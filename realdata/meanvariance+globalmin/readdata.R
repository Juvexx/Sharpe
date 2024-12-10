library(lubridate)


showdate<-function(listdate,year=2000,month=01,fromstart=TRUE){
  year=round(year)
  month=round(month)
  yearmonth=ym(year*100+month)
  listdate=ymd(listdate)
  if (fromstart){
      index=match(TRUE,listdate>=yearmonth)
  }
  else{
    yearmonth=yearmonth+months(1)
    MMM=which((listdate<=yearmonth)==TRUE)
    index=MMM[length(MMM)]
    # index=match(TRUE,listdate>=yearmonth)-1
  }
  list(index,listdate[index])
}


readdata<-function(data,startyear=2000,startmonth=1,endyear=2003,endmonth=12){
  listdate=ymd(data[,1])
  index0=showdate(listdate,year=startyear,month=startmonth,fromstart = TRUE)[[1]]
  index1=showdate(listdate,year=endyear,month=endmonth,fromstart = FALSE)[[1]]
  data[index0:index1,]
}

truncate<-function(x,alpha=0.01){
  lowerbound=quantile(x,0.01)
  upperbound=quantile(x,0.99)
  x[x<lowerbound]=lowerbound
  x[x>upperbound]=upperbound
  x
}


FF3old=read.csv('data/FF3daily.csv')
FF3=na.omit(FF3old)

SP500_p=read.csv('data/SP500.csv')
SP500=na.omit(SP500_p)
SP500[,c(-1,-2)]=apply(SP500[,c(-1,-2)],2,truncate)
colnames(SP500)[7]='BRK-B'
colnames(SP500)[320]='BF-B'




Adjusted_vol=read.csv('data/Adjusted*vol.csv')
Adjusted_vol=Adjusted_vol[,-1]



