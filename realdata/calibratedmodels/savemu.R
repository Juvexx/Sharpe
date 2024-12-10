source("readdata.R")
library(MASS)
Estimate_coef<-function(X,Y){
  # X=cbind(X,rep(1,nrow(X)))
  solve(t(X)%*%X,t(X)%*%Y)
}


predict<-function(X,alpha){
  # cbind(X,rep(1,nrow(X)))%*%alpha
  X%*%alpha[1:(nrow(alpha)),]
}



year=2001
month=1
day=1
train_month_Sigma=12
train_month_mu=12
test_month=1
q_previous=0
q1_previous=0
q_previousdiag=0
q_decay=1

Result_day=NULL
One=rep(1,365)%*%t(rep(1,365))
startdate=ymd(year*10000+month*100+day)




q_id_month=NULL
q1_id_month=NULL
q_diag_month=NULL
Angle=NULL

Rolling_time=NULL
Rolling_time_month=NULL

qlist=(1:30)/1.5
trainsetpre=readdata(SP500,startyear=2005,startmonth=1,endyear=2010,endmonth=12)
Xpre=data.matrix(trainsetpre[,3:367])*100
Factor_datapre=readdata(FF3,startyear=2005,startmonth=1,endyear=2010,endmonth=12)
Xpre=Xpre-Factor_datapre[,5]%*%t(rep(1,365))
r_barpre=apply(Xpre,2,mean)
npre=nrow(Xpre)
Qdiag=(t(Xpre-rep(1,npre)%*%t(r_barpre))%*%(Xpre-rep(1,npre)%*%t(r_barpre))/npre)

{

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

  trainset=readdata(SP500,startyear=startyear_train,startmonth=startmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  testset=readdata(SP500,startyear=startyear_test,startmonth=startmonth_test,endyear=endyear_test,endmonth=endmonth_test)
  Factor_data=readdata(FF3,startyear=startyear_train,startmonth=startmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  Factor_data_test=readdata(FF3,startyear=startyear_test,startmonth=startmonth_test,endyear=endyear_test,endmonth=endmonth_test)
#   id1=readdata(Adjusted_vol,startyear=endyear_train,startmonth=endmonth_train,endyear=endyear_train,endmonth=endmonth_train)
#   id1=id1[,-1]*1.0
#   Q1=sqrt(diag(apply(id1,2,mean)/1e8))
  # Factor_data_mu=readdata(FF3,startyear=startyear_trainmu,startmonth=startmonth_trainmu,endyear=endyear_train,endmonth=endmonth_train)
  
  Rolling_time=c(Rolling_time,testset[,1])
#   if(nrow(Factor_data)!=nrow(trainset)){break}
  Rolling_time_month=c(Rolling_time_month,startyear_test*100+startmonth_test)
  
  
  FF=data.matrix(Factor_data[2:4])
  FFtest=data.matrix(Factor_data_test[2:4])
  # FF_mu=data.matrix(Factor_data_mu[2:4])
  X=data.matrix(trainset[,3:367])*100
  X_mu=data.matrix(testset[,3:367])*100
  X_test=data.matrix(testset[,3:367])*100
  
  X_center=X-Factor_data[,5]%*%t(rep(1,365))
  X_center_mu=X_mu-Factor_data_test[,5]%*%t(rep(1,365))
  mutrue=apply(X_mu,2,mean)
  alpha=Estimate_coef(FF,X_center)


}

set.seed(1997)
listmutrue=NULL
listmufactor=NULL


listmu01=NULL
listmu05=NULL
listmu1=NULL
listmu15=NULL
listmu2=NULL
for (i in 0:257){
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

  trainset=readdata(SP500,startyear=startyear_train,startmonth=startmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  testset=readdata(SP500,startyear=startyear_test,startmonth=startmonth_test,endyear=endyear_test,endmonth=endmonth_test)
  Factor_data=readdata(FF3,startyear=startyear_train,startmonth=startmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  Factor_data_test=readdata(FF3,startyear=startyear_test,startmonth=startmonth_test,endyear=endyear_test,endmonth=endmonth_test)
#   id1=readdata(Adjusted_vol,startyear=endyear_train,startmonth=endmonth_train,endyear=endyear_train,endmonth=endmonth_train)
#   id1=id1[,-1]*1.0
#   Q1=sqrt(diag(apply(id1,2,mean)/1e8))
  # Factor_data_mu=readdata(FF3,startyear=startyear_trainmu,startmonth=startmonth_trainmu,endyear=endyear_train,endmonth=endmonth_train)
  
  Rolling_time=c(Rolling_time,testset[,1])
#   if(nrow(Factor_data)!=nrow(trainset)){break}
  Rolling_time_month=c(Rolling_time_month,startyear_test*100+startmonth_test)
  
  
  FF=data.matrix(Factor_data[2:4])
  FFtest=data.matrix(Factor_data_test[2:4])
  # FF_mu=data.matrix(Factor_data_mu[2:4])
  X=data.matrix(trainset[,3:367])*100
  X_mu=data.matrix(testset[,3:367])*100
  X_test=data.matrix(testset[,3:367])*100
  
  X_center=X-Factor_data[,5]%*%t(rep(1,365))
  X_center_mu=X_mu-Factor_data_test[,5]%*%t(rep(1,365))
  mutrue=apply(X_mu,2,mean)
  # alpha=Estimate_coef(FF,X_center)
  mu_predict_excess=predict(FFtest,alpha)
  
  nrow(mu_predict_excess)
  mufactor=apply(mu_predict_excess+Factor_data_test[,5]%*%t(rep(1,365)),2,mean)
  mu01=mutrue+rnorm(365,sd=0.1)
  mu05=mutrue+rnorm(365,sd=0.5)
  mu1=mutrue+rnorm(365,sd=1)
  mu15=mutrue+rnorm(365,sd=1.5)
  mu2=mutrue+rnorm(365,sd=2)

  listmutrue=rbind(listmutrue,mutrue)
  listmufactor=rbind(listmufactor,mufactor)
  listmu01=rbind(listmu01,mu01)
  listmu05=rbind(listmu05,mu05)
  listmu1=rbind(listmu1,mu1)
  listmu15=rbind(listmu15,mu15)
  listmu2=rbind(listmu2,mu2) 
}


write.csv(cbind(Rolling_time_month,listmutrue),'data/mutrue.csv',row.names=FALSE)

write.csv(cbind(Rolling_time_month,listmufactor),'data/mufactor1.csv',row.names=FALSE)

write.csv(cbind(Rolling_time_month,listmu01),'data/mu01.csv',row.names=FALSE)

write.csv(cbind(Rolling_time_month,listmu05),'data/mu05.csv',row.names=FALSE)

write.csv(cbind(Rolling_time_month,listmu1),'data/mu1.csv',row.names=FALSE)

write.csv(cbind(Rolling_time_month,listmu15),'data/mu15.csv',row.names=FALSE)

write.csv(cbind(Rolling_time_month,listmu2),'data/mu2.csv',row.names=FALSE)
