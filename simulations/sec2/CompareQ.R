####This is the simulation code for Appendix A.1, the comparison of Qb
#### The results will be stored into the Q folder

library(Rcpp)
library(RcppEigen)
library(microbenchmark)



Sys.setenv("PKG_CPPFLAGS" = "-march=native")

# Use Rcpp attributes -----------------------------------------------------

sourceCpp(file = "MatrixMult.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixSolver.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixInv.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixEigenVa.cpp", verbose = TRUE, rebuild = TRUE)

n=1500
set.seed(1997)


for (y in c(0.5,1.5)){
p=n*y
half_p=p/2

if(y==0.5){
case='c<1'
listlambda=c(0.01,0.05,0.1,(1:30)/5)
mu=read.table('asset/c<1/mubasen1500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE)[,1]
True_sigma=read.table('asset/c<1/sigmabasen1500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE)
Store=eigen(as.matrix(True_sigma))
True_sigma<-Store$vectors %*%diag(Store$values)%*%t(Store$vectors )
True_Sigma_half<-Store$vectors %*%diag(sqrt(Store$values))%*%t(Store$vectors )
Inverse_true<-Store$vectors %*%diag(1/(Store$values))%*%t(Store$vectors )}
else{
case='c>1'
listlambda=c(0.01,0.2,0.4,(1:30)/1.5)
mu=read.table('asset/c>1/mubasen1500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE)[,1]
True_sigma=read.table('asset/c>1/sigmabasen1500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE)
Store=eigen(as.matrix(True_sigma))
True_sigma<-Store$vectors %*%diag(Store$values)%*%t(Store$vectors )
True_Sigma_half<-Store$vectors %*%diag(sqrt(Store$values))%*%t(Store$vectors )
Inverse_true<-Store$vectors %*%diag(1/(Store$values))%*%t(Store$vectors )}
QQ1=diag(c(rep(3,half_p),rep(1,p-half_p)))
QQ2=diag(diag(True_sigma)-2)
lambda_s=0.1
SRmax=sqrt(t(mu)%*%Inverse_true%*%mu)
for (i in 1:2){
if (i==1){
  choice='Q1'
  Q0else=0.1*QQ1 #fixed value added to \hSigma
  Q0=QQ2  #(\hSigma+Q0else+lbd*Q0)
}
else{
  choice='Q2'
  Q0else=0.5*diag(p)#fixed value added to \hSigma
  Q0=QQ1 #(\hSigma+Q0else+lbd*Q0)
}

Q0_inverse_half=diag((diag(Q0))^{-0.5})
Q0_inverse=diag((diag(Q0))^{-1})


for (repeat0 in 1:1000){
SRknown=NULL
SRunknown=NULL
SRmaxlist=NULL
Z=rnorm(n*p)
Z=matrix(Z,nrow=n)

X=MatrixMultC(Z,True_Sigma_half)

Estimate_sigma<<-MatrixMultC(t(X),X)/n
filename=paste('Q/',case,'/',choice,'repeat',repeat0,'.csv',sep='')


Qhalf_hSigma_Qhalf=MatrixMultC(MatrixMultC(Q0_inverse_half,Estimate_sigma+Q0else),Q0_inverse_half) #Q^(-0.5)%*%hatSigma%*%Q^(-0.5)

store=eigen(Qhalf_hSigma_Qhalf)
eigenmatrixP=store$vectors
eigenvalueLambda=store$values


PQ0=MatrixMultC(t(eigenmatrixP),Q0_inverse_half) # t(P)%*%Q^(-0.5)
PQhalfmu=MatrixMultC(PQ0,matrix(mu,ncol=1))
PQhalfmu=PQhalfmu[,1]
matrixadj=MatrixMultC(MatrixMultC(t(eigenmatrixP),diag(diag(Q0else)/diag(Q0))),(eigenmatrixP))  #


for (lambda in listlambda){
  cat('repeat=',repeat0,'lambda=',lambda,'\n')
  

  corevec=(eigenvalueLambda+lambda)^(-1)



  # adjustfactor=abs(1-y*mean(diag(Estimate_sigma%*%MResolvent)))
  adjustfactor=abs(1-y*(1-lambda*mean(corevec)-mean(diag(MatrixMultC(matrixadj,diag(corevec))))))

  # MRe_mu=MResolvent%*%(mu)
  MRe_mu= t(PQ0)%*%((corevec)*PQhalfmu)
  
  SRknown=c(SRknown,sum(MRe_mu*mu)/sqrt(t(MRe_mu)%*%True_sigma%*%MRe_mu))
  
  SRunknown=c(SRunknown,adjustfactor*sum(MRe_mu*mu)/sqrt(t(MRe_mu)%*%Estimate_sigma%*%MRe_mu))
  SRmaxlist=c(SRmaxlist,SRmax)

}
data=data.frame(listlambda,SRknown,SRunknown,SRmaxlist)
write.csv(data,file=filename)
}}

}




