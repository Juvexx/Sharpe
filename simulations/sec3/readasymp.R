
MSE<-function(x){
    (sum(x^2)/length(x))
}


data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu3/c<1/n=500Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


smallabsmse500=apply(result,1,MSE)

write.table(smallabsmse500,'asymp/mu3smallabsmse500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}

smallabsmseratio500=apply(result,1,MSE)

write.table(smallabsmseratio500,'asymp/mu3smallabsmseratio500.txt',row.names = FALSE)

################

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu3/c<1/n=1000Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}

smallabsmse1000=apply(result,1,MSE)


write.table(smallabsmse1000,'asymp/mu3smallabsmse1000.txt',row.names = FALSE)

result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}

smallabsmseratio1000=apply(result,1,MSE)
write.table(smallabsmseratio1000,'asymp/mu3smallabsmseratio1000.txt',row.names = FALSE)
####

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu3/c<1/n=1500Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


smallabsmse1500=apply(result,1,MSE)


write.table(smallabsmse1500,'asymp/mu3smallabsmse1500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}

smallabsmseratio1500=apply(result,1,MSE)
write.table(smallabsmseratio1500,'asymp/mu3smallabsmseratio1500.txt',row.names = FALSE)

#####

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu3/c<1/n=2000Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


smallabsmse2000=apply(result,1,MSE)


write.table(smallabsmse2000,'asymp/mu3smallabsmse2000.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
smallabsmseratio2000=apply(result,1,MSE)
write.table(smallabsmseratio2000,'asymp/mu3smallabsmseratio2000.txt',row.names = FALSE)


MSE<-function(x){
    (sum(x^2)/length(x))
}
data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu3/c>1/n=500Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


bigabsmse500=apply(result,1,MSE)


write.table(bigabsmse500,'asymp/mu3bigabsmse500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio500=apply(result,1,MSE)
write.table(bigabsmseratio500,'asymp/mu3bigabsmseratio500.txt',row.names = FALSE)


################

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu3/c>1/n=1000Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


bigabsmse1000=apply(result,1,MSE)


write.table(bigabsmse1000,'asymp/mu3bigabsmse1000.txt',row.names = FALSE)

result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio1000=apply(result,1,MSE)
write.table(bigabsmseratio1000,'asymp/mu3bigabsmseratio1000.txt',row.names = FALSE)


####

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu3/c>1/n=1500Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}

bigabsmean1500=apply(result,1,mean)
bigabssd1500=apply(result,1,sd)
bigabsmse1500=apply(result,1,MSE)

write.table(bigabsmse1500,'asymp/mu3bigabsmse1500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio1500=apply(result,1,MSE)
write.table(bigabsmseratio1500,'asymp/mu3bigabsmseratio1500.txt',row.names = FALSE)


#####

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu3/c>1/n=2000Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


bigabsmse2000=apply(result,1,MSE)


write.table(bigabsmse2000,'asymp/mu3bigabsmse2000.txt',row.names = FALSE)

result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio2000=apply(result,1,MSE)
write.table(bigabsmseratio2000,'asymp/mu3bigabsmseratio2000.txt',row.names = FALSE)



############################################################


data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu4/c<1/n=500Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


smallabsmse500=apply(result,1,MSE)

write.table(smallabsmse500,'asymp/mu4smallabsmse500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}

smallabsmseratio500=apply(result,1,MSE)

write.table(smallabsmseratio500,'asymp/mu4smallabsmseratio500.txt',row.names = FALSE)

################

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu4/c<1/n=1000Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}

smallabsmse1000=apply(result,1,MSE)


write.table(smallabsmse1000,'asymp/mu4smallabsmse1000.txt',row.names = FALSE)

result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}

smallabsmseratio1000=apply(result,1,MSE)
write.table(smallabsmseratio1000,'asymp/mu4smallabsmseratio1000.txt',row.names = FALSE)
####

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu4/c<1/n=1500Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


smallabsmse1500=apply(result,1,MSE)


write.table(smallabsmse1500,'asymp/mu4smallabsmse1500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}

smallabsmseratio1500=apply(result,1,MSE)
write.table(smallabsmseratio1500,'asymp/mu4smallabsmseratio1500.txt',row.names = FALSE)

#####

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu4/c<1/n=2000Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


smallabsmse2000=apply(result,1,MSE)


write.table(smallabsmse2000,'asymp/mu4smallabsmse2000.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
smallabsmseratio2000=apply(result,1,MSE)
write.table(smallabsmseratio2000,'asymp/mu4smallabsmseratio2000.txt',row.names = FALSE)


MSE<-function(x){
    (sum(x^2)/length(x))
}
data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu4/c>1/n=500Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


bigabsmse500=apply(result,1,MSE)


write.table(bigabsmse500,'asymp/mu4bigabsmse500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio500=apply(result,1,MSE)
write.table(bigabsmseratio500,'asymp/mu4bigabsmseratio500.txt',row.names = FALSE)


################

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu4/c>1/n=1000Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


bigabsmse1000=apply(result,1,MSE)


write.table(bigabsmse1000,'asymp/mu4bigabsmse1000.txt',row.names = FALSE)

result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio1000=apply(result,1,MSE)
write.table(bigabsmseratio1000,'asymp/mu4bigabsmseratio1000.txt',row.names = FALSE)


####

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu4/c>1/n=1500Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}

bigabsmean1500=apply(result,1,mean)
bigabssd1500=apply(result,1,sd)
bigabsmse1500=apply(result,1,MSE)

write.table(bigabsmse1500,'asymp/mu4bigabsmse1500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio1500=apply(result,1,MSE)
write.table(bigabsmseratio1500,'asymp/mu4bigabsmseratio1500.txt',row.names = FALSE)


#####

data=array(1,dim=c(1000,30,3))
for (repeat0 in 1:1000){
    filename=paste('mu4/c>1/n=2000Sigmaelse','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


bigabsmse2000=apply(result,1,MSE)


write.table(bigabsmse2000,'asymp/mu4bigabsmse2000.txt',row.names = FALSE)

result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio2000=apply(result,1,MSE)
write.table(bigabsmseratio2000,'asymp/mu4bigabsmseratio2000.txt',row.names = FALSE)
