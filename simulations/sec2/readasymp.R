
MSE<-function(x){
    (sum(x^2)/length(x))
}


data=array(1,dim=c(1000,33,3))
for (repeat0 in 1:1000){
    filename=paste('Basecase/c<1/n=500','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


smallabsmse500=apply(result,1,MSE)

write.table(smallabsmse500,'asymp/smallabsmse500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}

smallabsmseratio500=apply(result,1,MSE)

write.table(smallabsmseratio500,'asymp/smallabsmseratio500.txt',row.names = FALSE)

################

data=array(1,dim=c(1000,33,3))
for (repeat0 in 1:1000){
    filename=paste('Basecase/c<1/n=1000','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


smallabsmse1000=apply(result,1,MSE)


write.table(smallabsmse1000,'asymp/smallabsmse1000.txt',row.names = FALSE)

result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}

smallabsmseratio1000=apply(result,1,MSE)
write.table(smallabsmseratio1000,'asymp/smallabsmseratio1000.txt',row.names = FALSE)
####

data=array(1,dim=c(1000,33,3))
for (repeat0 in 1:1000){
    filename=paste('Basecase/c<1/n=1500','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


smallabsmse1500=apply(result,1,MSE)

write.table(smallabsmse1500,'asymp/smallabsmse1500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}

smallabsmseratio1500=apply(result,1,MSE)
write.table(smallabsmseratio1500,'asymp/smallabsmseratio1500.txt',row.names = FALSE)

#####

data=array(1,dim=c(1000,33,3))
for (repeat0 in 1:1000){
    filename=paste('Basecase/c<1/n=2000','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


smallabsmse2000=apply(result,1,MSE)


write.table(smallabsmse2000,'asymp/smallabsmse2000.txt',row.names = FALSE)




result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
smallabsmseratio2000=apply(result,1,MSE)
write.table(smallabsmseratio2000,'asymp/smallabsmseratio2000.txt',row.names = FALSE)






#############big
MSE<-function(x){
    (sum(x^2)/length(x))
}
data=array(1,dim=c(1000,33,3))
for (repeat0 in 1:1000){
    filename=paste('Basecase/c>1/n=500','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


bigabsmse500=apply(result,1,MSE)


write.table(bigabsmse500,'asymp/bigabsmse500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio500=apply(result,1,MSE)
write.table(bigabsmseratio500,'asymp/bigabsmseratio500.txt',row.names = FALSE)


################

data=array(1,dim=c(1000,33,3))
for (repeat0 in 1:1000){
    filename=paste('Basecase/c>1/n=1000','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}

bigabsmse1000=apply(result,1,MSE)


write.table(bigabsmse1000,'asymp/bigabsmse1000.txt',row.names = FALSE)

result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio1000=apply(result,1,MSE)
write.table(bigabsmseratio1000,'asymp/bigabsmseratio1000.txt',row.names = FALSE)


####

data=array(1,dim=c(1000,33,3))
for (repeat0 in 1:1000){
    filename=paste('Basecase/c>1/n=1500','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


bigabsmse1500=apply(result,1,MSE)


write.table(bigabsmse1500,'asymp/bigabsmse1500.txt',row.names = FALSE)


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio1500=apply(result,1,MSE)
write.table(bigabsmseratio1500,'asymp/bigabsmseratio1500.txt',row.names = FALSE)


#####

data=array(1,dim=c(1000,33,3))
for (repeat0 in 1:1000){
    filename=paste('Basecase/c>1/n=2000','repeat',repeat0,'.csv',sep='')
    data[repeat0,,]=as.matrix(read.csv(filename)[,-1])
}


result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]-X[,3])
   result=cbind(result,absdiff_r)
}


bigabsmse2000=apply(result,1,MSE)


write.table(bigabsmse2000,'asymp/bigabsmse2000.txt',row.names = FALSE)

result=NULL
for (i in 1:1000){
   X=data[i,,]
   absdiff_r=(X[,2]/X[,3]-1)
   result=cbind(result,absdiff_r)
}
bigabsmseratio2000=apply(result,1,MSE)
write.table(bigabsmseratio2000,'asymp/bigabsmseratio2000.txt',row.names = FALSE)
