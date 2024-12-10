library(MASS)
Schmid<-function(alpha){
  n<-dim(alpha)[1]
  s<-dim(alpha)[2]
  beta1<-alpha[,1]
  result<-beta1
  if(s>1){
    for(i in 2:s){
      vec<-rep(0,n)
      for(j in 1:(i-1)){
        beta0<-get(paste0("beta",j))
        vec<-vec-(sum(alpha[,i]*beta0)/sum(beta0^2))*beta0
      }
      assign(paste0("beta",i),alpha[,i]+vec)
      result<-cbind(result,get(paste0("beta",i)))
    }
  }
  return(result)
}




preparefix<-function(n,p,choice=1,ifmu=TRUE){
p<-p
n<-n
half_p<<-round(p/2)
One<<-rep(1,p)
Vectors=Schmid(cbind(One,rnorm(p),rnorm(p)))
Xi2<<-Vectors[,2]
Xi3<<-Vectors[,3]

alpha0=beta0=1
sigma=1/sqrt(rgamma(2*p ,alpha0,beta0))
sigma=sigma[sigma<3&sigma>0.01][1:p]
sigma=sigma[order(sigma,decreasing = TRUE)]

if (ifmu==TRUE){
index0=sample(1:p,size=round(p/5),replace = FALSE)
mmu=rep(0,p)
mmu[index0[1:round(p/10)]]=1
mmu[index0[(round(p/10)+1):round(p/5)]]=-1
mu1<<-mmu/sqrt(p)*sqrt(5)

mu2<<-One/sqrt(p)

mu3<<-runif(p,-1,1)/sqrt(p/2)}

y<-p/n
if (y<1){situation='c<1/'
R.utils::mkdirs.default(paste('asset/',situation,sep=''))}
else{situation='c>1/'
R.utils::mkdirs.default(paste('asset/',situation,sep=''))}
  
True_sigma<<-diag(sigma^2)+2*One%*%t(One)



write.csv(True_sigma,paste('asset/',situation,'sigmabasen',as.character(n),'.csv',sep=''),row.names=FALSE,col.names=FALSE,sep=",")
write.csv(mu1,paste('asset/',situation,'mubasen',as.character(n),'.csv',sep=''),row.names=FALSE,col.names=FALSE,sep=",")
write.table(True_sigma,paste('asset/',situation,'sigmabasen',as.character(n),'.txt',sep=''))
write.table(mu1,paste('asset/',situation,'mubasen',as.character(n),'.txt',sep=''),row.names=FALSE,col.names=FALSE,sep=",")
}


set.seed(1997)
preparefix(500,250,ifmu=TRUE)
preparefix(1000,500,ifmu=TRUE)
preparefix(1500,750,ifmu=TRUE)
preparefix(2000,1000,ifmu=TRUE)


preparefix(500,750,ifmu=TRUE)
preparefix(1000,1500,ifmu=TRUE)
preparefix(1500,2250,ifmu=TRUE)
preparefix(2000,3000,ifmu=TRUE)




xi=rgamma(250,shape=1)
write.csv(xi,'asset/xismall500.csv')


xi=rgamma(500,shape=1)
write.csv(xi,'asset/xismall1000.csv')


xi=rgamma(750,shape=1)
write.csv(xi,'asset/xismall1500.csv')


xi=rgamma(1000,shape=1)
write.csv(xi,'asset/xismall2000.csv')


xi=rgamma(750,shape=1)
write.csv(xi,'asset/xibig500.csv')


xi=rgamma(1500,shape=1)
write.csv(xi,'asset/xismall1000.csv')


xi=rgamma(2250,shape=1)
write.csv(xi,'asset/xismall1500.csv')


xi=rgamma(3000,shape=1)
write.csv(xi,'asset/xismall2000.csv')