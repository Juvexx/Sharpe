source("readdata.R")
library(MASS)

returncalibrate<-read.csv('data/returncalibrate0.4.csv')

year=2009
month=1
day=1
train_month_Sigma=48
train_month_mu=48
test_month=1
q_previous=0
q1_previous=0

Result_day=NULL
One=rep(1,365)%*%t(rep(1,365))
startdate=ymd(year*10000+month*100+day)




q_id_month=NULL
q1_id_month=NULL
q_diag_month=NULL
Angle=NULL

Rolling_time=NULL
Rolling_time_month=NULL

qlist=(1:30)/10




for (i in 0:125){
  cat('\n ')
  cat(i)
  startdate=ymd(year*10000+month*100+day)+months(i)
  enddate=startdate+months(train_month_Sigma)-months(1)
  startdatemu=enddate-months(train_month_mu)
  testdate=enddate+months(test_month)
  
  ################Load data rolling 
  startyear_train=year(startdate)
  startmonth_train=month(startdate)

  startyear_trainmu=year(startdatemu)
  startmonth_trainmu=month(startdatemu)

  endyear_train=year(enddate)
  endmonth_train=month(enddate)
  
  startyear_test=endyear_test=year(testdate)
  startmonth_test=endmonth_test=month(testdate)
  Rolling_time_month=c(Rolling_time_month,startyear_test*100+startmonth_test)
  trainset=readdata(returncalibrate,startyear=startyear_train,startmonth=startmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  testset=readdata(returncalibrate,startyear=startyear_test,startmonth=startmonth_test,endyear=endyear_test,endmonth=endmonth_test)

  id1=readdata(Adjusted_vol,startyear=endyear_train,startmonth=endmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  id1=id1[,-1]*1.0
  Q1=sqrt(diag(apply(id1,2,mean)/1e8))

  Rolling_time=c(Rolling_time,testset[,1])
  

  X=data.matrix(trainset[,2:366])
  X_test0=data.matrix(testset[,2:366])

  # datamufactor=read.csv('data/mufactor1.csv')
  # mufactor=as.numeric(datamufactor[,-1][which(datamufactor[,1]== startyear_test*100+startmonth_test),])

  datamutrue=read.csv('data/mutrue.csv')
  mutrue=as.numeric(datamutrue[,-1][which(datamutrue[,1]== startyear_test*100+startmonth_test),])

  X_test=t(t(X_test0))#+mufactor-mutrue)

  mu=mutrue
  n=nrow(X)
  p=365
  c=p/n
  
  r_bar=apply(X,2,mean)
  hSigma=t(X-rep(1,n)%*%t(r_bar))%*%(X-rep(1,n)%*%t(r_bar))/n

  # hSigma=t(X)%*%(X)/n
  Eigen=eigen(hSigma)
  Lambda_s=Eigen$values
  OrthP=Eigen$vectors
  listEstSR=NULL
  for (j in 1:30){
    Resolvent_M=OrthP%*%diag(1/(Lambda_s+qlist[j]))%*%t(OrthP)

    w=Resolvent_M%*%mu
    
    w=w/sum(abs(w))
    listEstSR=c(listEstSR, abs(1-c/p*sum(diag(hSigma%*%Resolvent_M)))*t(w)%*%mu/sqrt(t(w)%*%hSigma%*%w))
    
    # t(w)%*%mu/sqrt(t(w)%*%hSigma%*%w)
    if (j==1){Result=X_test%*%w}
    else {
       Result=cbind(Result,X_test%*%w)
    }
  }
  qoptim=qlist[which.max(listEstSR)]
  Resultoptim=Result[,which.max(listEstSR)]
  #(OrthP)%*%diag(Lambda_s)%*%t(OrthP)-hSigma=0
  #######Our method fix q
  q_id_month=c(q_id_month,qoptim)




######bench
  Resolvent_M_bench=ginv(hSigma)
  w_bench=Resolvent_M_bench%*%mu

  # if(sum(w)<0){cat('Error')}
  w_bench=w_bench/sum(abs(w_bench))
  Result_bench=X_test%*%w_bench 


  


########diag
  Est_SR1<-function(q){
    Resolvent_Mdiag=solve(hSigma+q*(Q1))
    wdiag=Resolvent_Mdiag%*%mu
    wdiag=wdiag/sum(abs(wdiag))
    abs(1-c/p*sum(diag(hSigma%*%Resolvent_Mdiag)))*t(wdiag)%*%mu/sqrt(t(wdiag)%*%hSigma%*%wdiag)
    # t(w)%*%mu/sqrt(t(w)%*%hSigma%*%w)
  }
  
  qdiag=optimize(Est_SR1,interval = c(0,100),maximum = TRUE)$maximum
  q_diag_month=c(q_diag_month,qdiag)


  Resolvent_Mdiag=solve(hSigma+qdiag*(Q1))
  wdiag=Resolvent_Mdiag%*%mu
  
  # if(sum(wdiag)<0){cat('Error')}
  wdiag=wdiag/sum(abs(wdiag))
  Resultdiag=X_test%*%wdiag


  Resultall=cbind(Resultoptim,Result_bench,Resultdiag,Result)
  if (i==0){
    Result_day=Resultall
  }
  else {
     Result_day=rbind(Result_day,Resultall)
  }
}


Result_day=cbind(Rolling_time,Result_day)
colnames(Result_day)=c('Rolling_time','Optimal','standard','diag',qlist)
Result_day[,9][1:3]
Result_day[,1][1:3]
q_diag_month
q_id_month
q1_id_month



write.table(Result_day,'meanvariancemusd/Q2year4-0.4/resultday.txt',row.names = FALSE)
write.table(cbind(Rolling_time_month,q_id_month),'meanvariancemusd/Q2year4-0.4/q_id_month.txt',row.names = FALSE)
write.table(cbind(Rolling_time_month,q_diag_month),'meanvariancemusd/Q2year4-0.4/q_diag_month.txt',row.names = FALSE)



global<-read.table('meanvariancemusd/Q2year4-0.4/resultday.txt',head=TRUE)

f<-function(x){
 mean(x)/sd(x)
}

listsd=NULL
for (i in 0:7){
  year=2013+i

  X=readdata(global,startyear=year,startmonth=1,endyear=year+2,endmonth=12)
  sd1=c(year*100+1,apply(X[,-1],2,f))


  X=readdata(global,startyear=year,startmonth=7,endyear=year+3,endmonth=6)
  sd2=c(year*100+7,apply(X[,-1],2,f))

listsd=rbind(listsd,sd1)
listsd=rbind(listsd,sd2)
}




rownames(listsd)=NULL
write.csv(listsd,'meanvariancemusd/Q2year4-0.4/listsd.csv')



