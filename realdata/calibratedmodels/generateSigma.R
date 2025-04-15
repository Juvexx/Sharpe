# source("readdata.R")
# library(MASS)









generateSigma<-function(tau=0.95,year=2016,month=11){
  startdate=ymd(year*10000+month*100+1)-months(61)
  enddate=ymd(year*10000+month*100+1)-months(1)
  testdate=ymd(year*10000+month*100+1)


  startyear_train=year(startdate)
  startmonth_train=month(startdate)


  endyear_train=year(enddate)
  endmonth_train=month(enddate)
  
  startyear_test=endyear_test=year(testdate)
  startmonth_test=endmonth_test=month(testdate)

  trainset=readdata(SP500,startyear=startyear_train,startmonth=startmonth_train,endyear=endyear_train,endmonth=endmonth_train)
  testset=readdata(SP500,startyear=startyear_test,startmonth=startmonth_test,endyear=endyear_test,endmonth=endmonth_test)
  X=data.matrix(trainset[,3:367])*100

  X_test=data.matrix(testset[,3:367])*100

  Sigma=tau*cov(X)+sqrt(1-tau^2)*cov(X_test)
  Sigma
}




year=2005
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
listreturn=NULL
trainset=readdata(SP500,startyear=2004,startmonth=1,endyear=2004,endmonth=1)
stocksname=colnames(trainset )
set.seed(1997)

for (i in 0:221){
  cat('\n ')
  cat(i)
  startdate=ymd(year*10000+month*100+day)+months(i)
  startyear=year(startdate)
  startmonth=month(startdate)

  Rolling_time_day=c(Rolling_time_day,startyear*10000+startmonth*100+(1:21))

  
  datamutrueperb=read.csv('data/mutrueperb0.05.csv')
  mutrueperb=as.numeric(datamutrueperb[,-1][which(datamutrueperb[,1]== startyear*100+startmonth),])
  mutrueSigma=generateSigma(tau=0.95,year=startyear,month=startmonth)
  Decom=eigen(mutrueSigma)
  Lambdas=Decom$values
  U=Decom$vectors
  halfSigma<-U%*%diag(Lambdas^(0.5))%*%t(U)
  Z=matrix(rnorm(365*21),nrow=21)
  Gammajr<-rep(1,21)%*%t(mutrueperb)+Z%*%halfSigma
  colnames(Gammajr)=stocksname[3:367]
  M=cbind(startyear*10000+startmonth*100+(1:21),Gammajr)
  
  listreturn=rbind(listreturn,M)
}


write.csv(listreturn,'data/returncalibrate0.05.csv',row.names=FALSE)




year=2005
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
listreturn=NULL
trainset=readdata(SP500,startyear=2004,startmonth=1,endyear=2004,endmonth=1)
stocksname=colnames(trainset)
set.seed(1997)
i=1
for (i in 0:221){
  cat('\n ')
  cat(i)
  startdate=ymd(year*10000+month*100+day)+months(i)
  startyear=year(startdate)
  startmonth=month(startdate)

  Rolling_time_day=c(Rolling_time_day,startyear*10000+startmonth*100+(1:21))

  
  datamutrueperb=read.csv('data/mutrueperb0.2.csv')
  mutrueperb=as.numeric(datamutrueperb[,-1][which(datamutrueperb[,1]== startyear*100+startmonth),])
  mutrueSigma=generateSigma(tau=0.95,year=startyear,month=startmonth)
  Decom=eigen(mutrueSigma)
  Lambdas=Decom$values
  U=Decom$vectors
  halfSigma<-U%*%diag(Lambdas^(0.5))%*%t(U)
  Z=matrix(rnorm(365*21),nrow=21)
  Gammajr<-rep(1,21)%*%t(mutrueperb)+Z%*%halfSigma
  colnames(Gammajr)=stocksname[3:367]
  M=cbind(startyear*10000+startmonth*100+(1:21),Gammajr)
  
  listreturn=rbind(listreturn,M)
}


write.csv(listreturn,'data/returncalibrate0.2.csv',row.names=FALSE)






year=2005
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
listreturn=NULL
trainset=readdata(SP500,startyear=2004,startmonth=1,endyear=2004,endmonth=1)
stocksname=colnames(trainset )
set.seed(1997)

for (i in 0:221){
  cat('\n ')
  cat(i)
  startdate=ymd(year*10000+month*100+day)+months(i)
  startyear=year(startdate)
  startmonth=month(startdate)

  Rolling_time_day=c(Rolling_time_day,startyear*10000+startmonth*100+(1:21))

  
  datamutrueperb=read.csv('data/mutrueperb0.4.csv')
  mutrueperb=as.numeric(datamutrueperb[,-1][which(datamutrueperb[,1]== startyear*100+startmonth),])
  mutrueSigma=generateSigma(tau=0.95,year=startyear,month=startmonth)
  Decom=eigen(mutrueSigma)
  Lambdas=Decom$values
  U=Decom$vectors
  halfSigma<-U%*%diag(Lambdas^(0.5))%*%t(U)
  Z=matrix(rnorm(365*21),nrow=21)
  Gammajr<-rep(1,21)%*%t(mutrueperb)+Z%*%halfSigma
  colnames(Gammajr)=stocksname[3:367]
  M=cbind(startyear*10000+startmonth*100+(1:21),Gammajr)
  
  listreturn=rbind(listreturn,M)
}


write.csv(listreturn,'data/returncalibrate0.4.csv',row.names=FALSE)


