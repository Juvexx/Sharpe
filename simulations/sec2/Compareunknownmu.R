############part1
#########p=2000,n=3000,alpha0=beta0=1,sigma=sqrt(rgamma(2*p ,alpha0,beta0))
#########sigma=sigma[sigma>0.1][1:p], mu
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
y=0.5
for (y in c(0.5,1.5)){
p=n*y
half_p=p/2
one=rep(1,p)
if(y==0.5){
case='c<1'
listlambda=c(0.01,0.05,0.1,(1:30)/5)
mubase=read.table('asset/c<1/mubasen1500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE)[,1]
mu1=read.table('asset/c<1/mu11500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE)[,1]
# mu2=read.table('asset/c<1/mu2.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE)[,1]
True_sigma=as.matrix(read.table('asset/c<1/sigmabasen1500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE))
Store=eigen(as.matrix(True_sigma))
# True_sigma<-Store$vectors %*%diag(Store$values)%*%t(Store$vectors )
True_Sigma_half<-Store$vectors %*%MatrixMultC(diag(sqrt(Store$values)),t(Store$vectors ))
Inverse_true<-Store$vectors %*%MatrixMultC(diag(1/(Store$values)),t(Store$vectors ))
}
else{
case='c>1'
listlambda=c(0.01,0.2,0.4,(1:30)/1.5)
mubase=read.table('asset/c>1/mubasen1500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE)[,1]
mu1=read.table('asset/c>1/mu11500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE)[,1]
True_sigma=as.matrix(read.table('asset/c>1/sigmabasen1500.txt', header = TRUE,  sep = '',  stringsAsFactors = FALSE))
Store=eigen(as.matrix(True_sigma))
True_Sigma_half<-Store$vectors %*%MatrixMultC(diag(sqrt(Store$values)),t(Store$vectors ))
Inverse_true<-Store$vectors %*%MatrixMultC(diag(1/(Store$values)),t(Store$vectors ))
}

mu2=mu1+2*one
listmu=list(mubase,mu1,mu2)
listmuname=c('mubase','mu1','mu2')
for (j in 1:3){
  j=3
  mu=listmu[[j]]
  srmax=sqrt(t(mu)%*%Inverse_true%*%mu)
for (repeat0 in 1:1000){
SRknown=NULL
SRunknown=NULL
SRmax=NULL
Z=rnorm(n*p)
Z=matrix(Z,nrow=n)

X0=MatrixMultC(Z,True_Sigma_half)
X=rep(1,n)%*%t(mu)+X0
hatmu=apply(X,2,mean)

Estimate_sigma<-MatrixMultC(t(X-rep(1,n)%*%t(hatmu)),X-rep(1,n)%*%t(hatmu))/n
filename=paste('unknownmu/',case,'/',listmuname[j],'repeat',repeat0,'.csv',sep='')


Q0=True_sigma
store0=eigen(Q0)
Q0_inverse_half=store0$vectors%*%diag(1/sqrt(store0$values))%*%t(store0$vectors)
Q0_inverse=store0$vectors%*%diag(1/(store0$values))%*%t(store0$vectors)
Qhalf_hSigma_Qhalf=MatrixMultC(MatrixMultC(Q0_inverse_half,Estimate_sigma),Q0_inverse_half) #Q^(-0.5)%*%hatSigma%*%Q^(-0.5)
if(y<1){
store=eigen(Qhalf_hSigma_Qhalf)
eigenmatrixP=store$vectors 
eigenvalueLambda=store$values
}
else {
  W <- MatrixMultC(X-rep(1,n)%*%t(hatmu), Q0_inverse_half)  # W should be 400 x 10000
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
PQhalfmu=MatrixMultC(PQ0,matrix(hatmu,ncol=1))
PQhalfmu=PQhalfmu[,1]



for (lambda in listlambda){
  cat('repeat=',repeat0,'lambda=',lambda,'\n')
  # lambda=20
  # lambda=0.1
  corevec=(eigenvalueLambda+lambda)^(-1)
  # Q=lambda*Q0
  # MResolvent=solve(Estimate_sigma+lambda*Q0)
  #  t(c(1,rep(0,p-1)))%*%MResolvent%*%c(1,rep(0,p-1))
    
#   adjustfactor=abs(1-y*mean(diag(Estimate_sigma%*%MResolvent)))
  
  adjustfactor=abs(1-y*(1-lambda*mean(corevec)))
  # n-sum(diag(MResolvent%*%Estimate_sigma))


  # sum(diag(MResolvent%*%Estimate_sigma))/(n-sum(diag(MResolvent%*%Estimate_sigma)))
  # MRe_mu=MResolvent%*%(hatmu)
  MRe_mu= t(PQ0)%*%((corevec)*PQhalfmu)





  # sum(diag(MResolvent%*%True_sigma))/n
  # t(hatmu-mu)%*%MResolvent%*%(hatmu-mu)
  # sum(MRe_mu*hatmu) 
#  length(mu)
  SRknown=c(SRknown,sum(MRe_mu*mu)/sqrt(t(MRe_mu)%*%True_sigma%*%MRe_mu))
  
  SRunknown=c(SRunknown,adjustfactor*(sum(MRe_mu*hatmu)-(1-adjustfactor)/adjustfactor)/sqrt(t(MRe_mu)%*%Estimate_sigma%*%MRe_mu))
  SRmax=c(SRmax,srmax)
  
  # sum(hatmu^2)


}
data=data.frame(listlambda,SRknown,SRunknown,SRmax)
write.csv(data,file=filename)

}

}}

