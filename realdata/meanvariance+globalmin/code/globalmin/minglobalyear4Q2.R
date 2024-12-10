source("readdata.R")

library(MASS)


year=2012
month=1
day=1




#This is the starting time

train_month=12

test_month=1


qlist=(1:30)/10
#This is the training sample size, and rolling window





One=rep(1,365)%*%t(rep(1,365))
startdate=ymd(year*10000+month*100+day)




q_id_month=NULL

q_diag_month=NULL


Rolling_time=NULL
Rolling_time_month=NULL


trainsetpre=readdata(SP500,startyear=2005,startmonth=1,endyear=2010,endmonth=12)
Xpre=data.matrix(trainsetpre[,3:367])*100
Factor_datapre=readdata(FF3,startyear=2005,startmonth=1,endyear=2010,endmonth=12)
Xpre=Xpre-Factor_datapre[,5]%*%t(rep(1,365))
r_barpre=apply(Xpre,2,mean)
npre=nrow(Xpre)
Qdiag=(t(Xpre-rep(1,npre)%*%t(r_barpre))%*%(Xpre-rep(1,npre)%*%t(r_barpre))/npre)
for (i in 0:125){
  
  cat('\n ')
  cat(i)
  startdate=ymd(year*10000+month*100+day)+months(i)
  enddate=startdate+months(train_month)-months(1)
  startdatemu=enddate-months(train_month)
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
  trainset=readdata(SP500,startyear=startyear_train,startmonth=startmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  testset=readdata(SP500,startyear=startyear_test,startmonth=startmonth_test,endyear=endyear_test,endmonth=endmonth_test)
  Factor_data=readdata(FF3,startyear=startyear_train,startmonth=startmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  Factor_data_test=readdata(FF3,startyear=startyear_test,startmonth=startmonth_test,endyear=endyear_test,endmonth=endmonth_test)
  id1=readdata(Adjusted_vol,startyear=endyear_train,startmonth=endmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  id1=id1[,-1]*1.0
  Q1=sqrt(diag(apply(id1,2,mean)/1e8))
  Factor_data_mu=readdata(FF3,startyear=startyear_trainmu,startmonth=startmonth_trainmu,endyear=endyear_train,endmonth=endmonth_train)
  trainset_mu=readdata(SP500,startyear=startyear_trainmu,startmonth=startmonth_trainmu,endyear=endyear_train,endmonth=endmonth_train)
  Rolling_time=c(Rolling_time,testset[,1])
  if(nrow(Factor_data)!=nrow(trainset)){break}
  
  FF=data.matrix(Factor_data[2:4])
  # FF_mu=data.matrix(Factor_data_mu[2:4])
  X=data.matrix(trainset[,3:367])*100
  # X_mu=data.matrix(trainset_mu[,3:367])*100
  X_test=data.matrix(testset[,3:367])*100
  
  X_center=X-Factor_data[,5]%*%t(rep(1,365))


  
  mu=rep(1,365)/sqrt(365)
  n=nrow(X)
  p=365
  c=p/n
  
  r_bar=apply(X_center,2,mean)
  hSigma=t(X_center-rep(1,n)%*%t(r_bar))%*%(X_center-rep(1,n)%*%t(r_bar))/n
  # hSigma=t(X_center-rep(1,n)%*%t(mu))%*%(X_center-rep(1,n)%*%t(mu))/n
  # hSigma=t(X)%*%(X)/n
  Eigen=eigen(hSigma)
  Lambda_s=Eigen$values
  OrthP=Eigen$vectors
  listEstSR=NULL
  for (j in 1:30){
    Resolvent_M=OrthP%*%diag(1/(Lambda_s+qlist[j]))%*%t(OrthP)

    w=Resolvent_M%*%mu
    
    w=w/sum(w)
    listEstSR=c(listEstSR, abs(1-c/p*sum(diag(hSigma%*%Resolvent_M)))*t(w)%*%mu/sqrt(t(w)%*%hSigma%*%w))
    # t(w)%*%mu/sqrt(t(w)%*%hSigma%*%w)
    if (j==1){Result=X_test%*%w-Factor_data_test[,5]}
    else {
       Result=cbind(Result,X_test%*%w-Factor_data_test[,5])
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

  if(sum(w)<0){cat('Error')}
  w_bench=w_bench/sum(w_bench)
  Result_bench=X_test%*%w_bench-Factor_data_test[,5]


  


########diag
  Est_SR1<-function(q){
    Resolvent_Mdiag=solve(hSigma+q*(Q1))
    wdiag=Resolvent_Mdiag%*%mu
    
    wdiag=wdiag/sum(wdiag)
    abs(1-c/p*sum(diag(hSigma%*%Resolvent_Mdiag)))*t(wdiag)%*%mu/sqrt(t(wdiag)%*%hSigma%*%wdiag)
    # t(w)%*%mu/sqrt(t(w)%*%hSigma%*%w)
  }
  
  qdiag=optimize(Est_SR1,interval = c(0,100),maximum = TRUE)$maximum
  q_diag_month=c(q_diag_month,qdiag)
  

  Resolvent_Mdiag=solve(hSigma+qdiag*(Q1))
  wdiag=Resolvent_Mdiag%*%mu
  
  if(sum(wdiag)<0){cat('Error')}
  wdiag=wdiag/sum(wdiag)
  Resultdiag=X_test%*%wdiag-Factor_data_test[,5]


  Resultall=cbind(Resultoptim,Result_bench,Resultdiag,Result)
  if (i==0){
    Result_day=Resultall
  }
  else {
     Result_day=rbind(Result_day,Resultall)
  }
}


Result_day=cbind(Rolling_time,Result_day)
colnames(Result_day)=c('Rolling_time','Optimal','standard','diag',(1:30)/10)
Result_day[,9][1:3]
Result_day[,1][1:3]
q_diag_month
q_id_month

write.table(Result_day,'globalmin/resultsyear4/resultday1.txt',row.names = FALSE)
write.table(cbind(Rolling_time_month,q_id_month),'globalmin/resultsyear4/q_id_month1.txt',row.names = FALSE)
write.table(cbind(Rolling_time_month,q_diag_month),'globalmin/resultsyear4/q_diag_month1.txt',row.names = FALSE)


global<-read.table('globalmin/resultsyear4/resultday1.txt',head=TRUE)

listsd=NULL
for (i in 0:7){
  year=2013+i

  X=readdata(global,startyear=year,startmonth=1,endyear=year+2,endmonth=12)
  sd1=c(year*100+1,apply(X[,-1],2,sd))


  X=readdata(global,startyear=year,startmonth=7,endyear=year+3,endmonth=6)
  sd2=c(year*100+7,apply(X[,-1],2,sd))

listsd=rbind(listsd,sd1)
listsd=rbind(listsd,sd2)
}




rownames(listsd)=NULL
write.csv(listsd,'globalmin/resultsyear4/listsdQ2.csv')