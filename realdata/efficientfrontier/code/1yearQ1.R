

f<-function(x){
 sd(x)
}


mu0list=(1:15)/2.5
trainsetpre=readdata(SP500,startyear=2004,startmonth=1,endyear=2008,endmonth=12)
Xpre=data.matrix(trainsetpre[,3:367])*100
Factor_datapre=readdata(FF3,startyear=2004,startmonth=1,endyear=2008,endmonth=12)
Xpre=Xpre-Factor_datapre[,5]%*%t(rep(1,365))
r_barpre=apply(Xpre,2,mean)
npre=nrow(Xpre)
Q0=(t(Xpre-rep(1,npre)%*%t(r_barpre))%*%(Xpre-rep(1,npre)%*%t(r_barpre))/npre)
store=eigen(Q0)
store$values[store$values>9]=9
Q0=store$vectors%*%diag(store$values)%*%t(store$vectors)
Q0_inverse_half=store$vectors%*%diag(1/sqrt(store$values))%*%t(store$vectors)
Q0_inverse=store$vectors%*%diag(1/(store$values))%*%t(store$vectors)


for (mu0 in mu0list){
year=2012
month=1
day=1
train_month=12

test_month=1




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
  cat('\n mu0=')
  cat(mu0)
  cat(',\t i=')
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

  id1=readdata(Adjusted_vol,startyear=endyear_train,startmonth=endmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  id1=id1[,-1]*1.0
  Q1=sqrt(diag(apply(id1,2,mean)/1e8))

  Rolling_time=c(Rolling_time,testset[,1])
  

  X=data.matrix(trainset[,3:367])*100
  X_test0=data.matrix(testset[,3:367])*100

  # datamufactor=read.csv('data/mufactor1.csv')
  # mufactor=as.numeric(datamufactor[,-1][which(datamufactor[,1]== startyear_test*100+startmonth_test),])

  datamutrue=read.csv('data/mutrue.csv')
  mutrue=as.numeric(datamutrue[,-1][which(datamutrue[,1]== startyear_test*100+startmonth_test),])

  X_test=t(t(X_test0))#+mufactor-mutrue)

  mu=mutrue
  n=nrow(X)
  p=365
  c=p/n
  one=rep(1,p)
  
  r_bar=apply(X,2,mean)
  hSigma=t(X-rep(1,n)%*%t(r_bar))%*%(X-rep(1,n)%*%t(r_bar))/n


  Qhalf_hSigma_Qhalf=Q0_inverse_half%*%hSigma%*%Q0_inverse_half


  store0=eigen(Qhalf_hSigma_Qhalf)
  eigenmatrixP=store0$vectors
  eigenvalueLambda=store0$values


  PQ0=t(eigenmatrixP)%*%Q0_inverse_half # t(P)%*%Q^(-0.5)
  PQhalfmu=PQ0%*%matrix(mu,ncol=1)
  PQhalfmu=PQhalfmu[,1]


  PQhalf1=PQ0%*%matrix(one,ncol=1)
  PQhalf1=PQhalf1[,1]
  # hSigma=t(X)%*%(X)/n
  # Eigen=eigen(hSigma)
  # Lambda_s=Eigen$values
  # OrthP=Eigen$vectors
  listEstSR=NULL
  for (j in 1:30){
    corevec=(eigenvalueLambda+qlist[j])^(-1)
    adjustfactor=abs(1-c*(1-qlist[j]*mean(corevec)))


    Rvecmu=t(PQ0)%*%((corevec)*PQhalfmu)
    Rvec1=t(PQ0)%*%((corevec)*PQhalf1)
    A=(t(mu)%*%Rvec1)[1]
    B=(t(mu)%*%Rvecmu)[1]
    C=(t(one)%*%Rvec1)[1]
    D=B*C-A^2

    Rvecg=D^{-1}*(B*Rvec1-A*Rvecmu)
    Rvech=D^{-1}*(C*Rvecmu-A*Rvec1)

    w=Rvecg+mu0*Rvech
    listEstSR=c(listEstSR, adjustfactor/sqrt(t(w)%*%hSigma%*%w))
    
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
  Rvecmu_bench=Resolvent_M_bench%*%mu
  Rvec1_bench=Resolvent_M_bench%*%one
  A_bench=(t(mu)%*%Rvec1_bench)[1]
  B_bench=(t(mu)%*%Rvecmu_bench)[1]
  C_bench=(t(one)%*%Rvec1_bench)[1]
  D_bench=B_bench*C_bench-A_bench^2
  
  Rvecg_bench=D_bench^{-1}*(B_bench*Rvec1_bench-A_bench*Rvecmu_bench)
  Rvech_bench=D_bench^{-1}*(C_bench*Rvecmu_bench-A_bench*Rvec1_bench)
  # if(sum(w)<0){cat('Error')}
  w_bench=Rvecg_bench+mu0*Rvech_bench
  Result_bench=X_test%*%w_bench 

  


  Resultall=cbind(Resultoptim,Result_bench,Result)
  if (i==0){
    Result_day=Resultall
  }
  else {
     Result_day=rbind(Result_day,Resultall)
  }
}
cat('\n')
cat(length(Rolling_time))
cat(nrow(Result_day))
Result_day=cbind(Rolling_time,Result_day)
colnames(Result_day)=c('Rolling_time','Optimal','standard',qlist)
Result_day[,9][1:3]
Result_day[,1][1:3]
q_diag_month
q_id_month
q1_id_month



write.table(Result_day,paste('meanvariance/1yearQ1/resultdaymu0=',as.character(mu0),'.txt',sep=''),row.names = FALSE)
write.table(cbind(Rolling_time_month,q_id_month),paste('meanvariance/1yearQ1/q_id_monthmu0=',as.character(mu0),'.txt',sep=''),row.names = FALSE)
write.table(cbind(Rolling_time_month,q_diag_month),paste('meanvariance/1yearQ1/q_diag_monthmu0=',as.character(mu0),'.txt',sep=''),row.names = FALSE)

}



listsd=NULL
for (mu0 in mu0list){
global<-read.table(paste('meanvariance/1yearQ1/resultdaymu0=',as.character(mu0),'.txt',sep=''),head=TRUE)


X=readdata(global,startyear=2013,startmonth=1,endyear=2023,endmonth=06)
sd1=c(mu0,apply(X[,-1],2,sd))
listsd=rbind(listsd,sd1)
}


rownames(listsd)=NULL
write.csv(listsd,'meanvariance/1yearQ1/listsd.csv')

