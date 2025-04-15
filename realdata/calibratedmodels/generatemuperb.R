

year=2001
month=1
day=1
train_month_Sigma=12

test_month=1
Result_day=NULL
One=rep(1,365)%*%t(rep(1,365))
startdate=ymd(year*10000+month*100+day)
listmuperb=NULL
Rolling_time_day=NULL
Rolling_time_month=NULL

Rolling_time=NULL

set.seed(1997)
rho=0.05
for (i in 0:257){
  cat('\n ')
  cat(i)
  startdate=ymd(year*10000+month*100+day)+months(i)
  enddate=startdate+months(train_month_Sigma)-months(1)

  testdate=enddate+months(test_month)

  startyear_train=year(startdate)
  startmonth_train=month(startdate)


  endyear_train=year(enddate)
  endmonth_train=month(enddate)
  
  startyear_test=endyear_test=year(testdate)
  startmonth_test=endmonth_test=month(testdate)

  trainset=readdata(SP500,startyear=startyear_train,startmonth=startmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  testset=readdata(SP500,startyear=startyear_test,startmonth=startmonth_test,endyear=endyear_test,endmonth=endmonth_test)

  Rolling_time=c(Rolling_time,testset[,1])

  Rolling_time_month=c(Rolling_time_month,startyear_test*100+startmonth_test)

  X=data.matrix(trainset[,3:367])*100
  X_mu=data.matrix(testset[,3:367])*100
  X_test=data.matrix(testset[,3:367])*100
  
  


  mutrue=apply(X_mu,2,mean)

  sigmamu=sd(mutrue)

  muperb=rho*mutrue+sqrt(1-rho*rho)*rnorm(365,sd=sigmamu)

  listmuperb=rbind(listmuperb,muperb)

}



write.csv(cbind(Rolling_time_month,listmuperb),'data/mutrueperb0.05.csv',row.names=FALSE)



year=2001
month=1
day=1
train_month_Sigma=12

test_month=1
Result_day=NULL
One=rep(1,365)%*%t(rep(1,365))
startdate=ymd(year*10000+month*100+day)
listmuperb=NULL
Rolling_time_day=NULL
Rolling_time_month=NULL

Rolling_time=NULL

for (i in 0:257){
  cat('\n ')
  cat(i)
  startdate=ymd(year*10000+month*100+day)+months(i)
  enddate=startdate+months(train_month_Sigma)-months(1)

  testdate=enddate+months(test_month)

  startyear_train=year(startdate)
  startmonth_train=month(startdate)


  endyear_train=year(enddate)
  endmonth_train=month(enddate)
  
  startyear_test=endyear_test=year(testdate)
  startmonth_test=endmonth_test=month(testdate)

  trainset=readdata(SP500,startyear=startyear_train,startmonth=startmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  testset=readdata(SP500,startyear=startyear_test,startmonth=startmonth_test,endyear=endyear_test,endmonth=endmonth_test)

  Rolling_time=c(Rolling_time,testset[,1])

  Rolling_time_month=c(Rolling_time_month,startyear_test*100+startmonth_test)

  X=data.matrix(trainset[,3:367])*100
  X_mu=data.matrix(testset[,3:367])*100
  X_test=data.matrix(testset[,3:367])*100
  
  


  mutrue=apply(X_mu,2,mean)

  sigmamu=sd(mutrue)

  muperb=rho*mutrue+sqrt(1-rho*rho)*rnorm(365,sd=sigmamu)

  listmuperb=rbind(listmuperb,muperb)

}



write.csv(cbind(Rolling_time_month,listmuperb),'data/mutrueperb0.2.csv',row.names=FALSE)



year=2001
month=1
day=1
train_month_Sigma=12

test_month=1
Result_day=NULL
One=rep(1,365)%*%t(rep(1,365))
startdate=ymd(year*10000+month*100+day)
listmuperb=NULL
Rolling_time_day=NULL
Rolling_time_month=NULL

Rolling_time=NULL

rho=0.4
for (i in 0:257){
  cat('\n ')
  cat(i)
  startdate=ymd(year*10000+month*100+day)+months(i)
  enddate=startdate+months(train_month_Sigma)-months(1)

  testdate=enddate+months(test_month)

  startyear_train=year(startdate)
  startmonth_train=month(startdate)


  endyear_train=year(enddate)
  endmonth_train=month(enddate)
  
  startyear_test=endyear_test=year(testdate)
  startmonth_test=endmonth_test=month(testdate)

  trainset=readdata(SP500,startyear=startyear_train,startmonth=startmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  testset=readdata(SP500,startyear=startyear_test,startmonth=startmonth_test,endyear=endyear_test,endmonth=endmonth_test)

  Rolling_time=c(Rolling_time,testset[,1])

  Rolling_time_month=c(Rolling_time_month,startyear_test*100+startmonth_test)

  X=data.matrix(trainset[,3:367])*100
  X_mu=data.matrix(testset[,3:367])*100
  X_test=data.matrix(testset[,3:367])*100
  
  


  mutrue=apply(X_mu,2,mean)

  sigmamu=sd(mutrue)

  muperb=rho*mutrue+sqrt(1-rho*rho)*rnorm(365,sd=sigmamu)

  listmuperb=rbind(listmuperb,muperb)

}



write.csv(cbind(Rolling_time_month,listmuperb),'data/mutrueperb0.4.csv',row.names=FALSE)


