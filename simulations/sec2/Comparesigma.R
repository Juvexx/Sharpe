####This is the simulation code for Appendix A.1, the comparison of bSigma
#### The results will be stored into the Sigma folder

library(Rcpp)
library(RcppEigen)
library(microbenchmark)



# Use Rcpp attributes -----------------------------------------------------

sourceCpp(file = "MatrixMult.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixSolver.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixInv.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixEigenVa.cpp", verbose = TRUE, rebuild = TRUE)


n=1500
set.seed(1997)



for (i in 2:3){
  if(i==1){choice='sigmabasen1500'}
  else if (i==2) {
     choice='sigma11500'
  }
  else{choice='sigma21500'}
for (y in c(0.5,1.5)){
p=n*y
half_p=p/2


if(y==0.5){
case='c<1'
listlambda=c(0.01,0.05,0.1,(1:30)/5)
mu=read.table('asset/c<1/mubasen1500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE)[,1]
True_sigma0=read.table(paste('asset/c<1/',choice,'.txt',sep=''), header = TRUE,  sep = '',  stringsAsFactors = FALSE)
Store=eigen(as.matrix(True_sigma0))
True_sigma<-Store$vectors %*%diag(Store$values)%*%t(Store$vectors )
True_Sigma_half<-Store$vectors %*%diag(sqrt(Store$values))%*%t(Store$vectors )
Inverse_true<-Store$vectors %*%diag(1/(Store$values))%*%t(Store$vectors )}
else{
case='c>1'
listlambda=c(0.01,0.2,0.4,(1:30)/1.5)
mu=read.table('asset/c>1/mubasen1500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE)[,1]
True_sigma0=read.table(paste('asset/c>1/',choice,'.txt',sep=''), header = TRUE,  sep = '',  stringsAsFactors = FALSE)
Store=eigen(as.matrix(True_sigma0))
True_sigma<-Store$vectors %*%diag(Store$values)%*%t(Store$vectors )
True_Sigma_half<-Store$vectors %*%diag(sqrt(Store$values))%*%t(Store$vectors )
Inverse_true<-Store$vectors %*%diag(1/(Store$values))%*%t(Store$vectors )}




for (repeat0 in 1:1000){
SRknown=NULL
SRunknown=NULL
Z=rnorm(n*p)
Z=matrix(Z,nrow=n)

X=Z%*%True_Sigma_half

Estimate_sigma<<-t(X)%*%X/n
filename=paste('Sigma/',case,'/',choice,'repeat',repeat0,'.csv',sep='')


Q0=diag(c(rep(3,half_p),rep(1,p-half_p)))
Q0_inverse_half=diag(c(rep(1/sqrt(3),half_p),rep(1,p-half_p)))
Q0_inverse=diag(c(rep(1/(3),half_p),rep(1,p-half_p)))
Qhalf_hSigma_Qhalf=MatrixMultC(MatrixMultC(Q0_inverse_half,Estimate_sigma),Q0_inverse_half) #Q^(-0.5)%*%hatSigma%*%Q^(-0.5)
if(y<1){
store=eigen(Qhalf_hSigma_Qhalf)
eigenmatrixP=store$vectors
eigenvalueLambda=store$values
}
else {
  W <- MatrixMultC(X, Q0_inverse_half)  # W should be 400 x 10000
# Step 2: Perform SVD on W
  svd_result <- svd(W/sqrt(n),nv=p)

# Extract U, D, and V
  U <- svd_result$u      
  D <- svd_result$d      
  eigenmatrixP<- svd_result$v      
  # Step 3: Construct the eigenvalue vector (10000 total)
  eigenvalueLambda <- c(D^2, rep(0, p - n))  # Length 10000, zeros for missing eigenvalues



}
PQ0=MatrixMultC(t(eigenmatrixP),Q0_inverse_half) # t(P)%*%Q^(-0.5)
PQhalfmu=MatrixMultC(PQ0,matrix(mu,ncol=1))
PQhalfmu=PQhalfmu[,1]

for (lambda in listlambda){
  cat('repeat=',repeat0,'lambda=',lambda,'\n')
#   Q1=lambda*diag(rep(1,p))
  
  corevec=(eigenvalueLambda+lambda)^(-1)

  # adjustfactor=abs(1-y*mean(diag(Estimate_sigma%*%MResolvent)))
  adjustfactor=abs(1-y*(1-lambda*mean(corevec)))

  # MRe_mu=MResolvent%*%(mu)
  MRe_mu= t(PQ0)%*%((corevec)*PQhalfmu)
  
  SRknown=c(SRknown,sum(MRe_mu*mu)/sqrt(t(MRe_mu)%*%True_sigma%*%MRe_mu))
  
  SRunknown=c(SRunknown,adjustfactor*sum(MRe_mu*mu)/sqrt(t(MRe_mu)%*%Estimate_sigma%*%MRe_mu))
  
}
data=data.frame(listlambda,SRknown,SRunknown)
write.csv(data,file=filename)

}

}}

