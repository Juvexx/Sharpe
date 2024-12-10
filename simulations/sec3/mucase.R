

library(Rcpp)
library(RcppEigen)
library(microbenchmark)

Sys.setenv("PKG_CPPFLAGS" = "-march=native")

# Use Rcpp attributes -----------------------------------------------------

sourceCpp(file = "MatrixMult.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixSolver.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixInv.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixEigenVa.cpp", verbose = TRUE, rebuild = TRUE)


set.seed(1997)
selectsigma=2
# selectmu=1  #Sigmabase or else
# y=1.5



q=0.2


mulist=(1:30)/5
vecrepeat1=rep(1,30)


# y=0.5
# n=1500

for (selectmu in 1:2){
for (y in c(0.5,1.5)){
for (n in c(500,1000,1500,2000)){
p=n*y
half_p=p/2
one<-rep(1,p)
if(y==0.5){
case='c<1'
mu0=read.table(paste('asset/c<1/mubasen',as.character(n), '.txt',sep=''), header = FALSE,  sep = '',  stringsAsFactors = FALSE)[,1]
True_sigma=as.matrix(read.table(paste('asset/c<1/sigmabasen',n,'.txt',sep=''), header = TRUE,  sep = '',  stringsAsFactors = FALSE))



xi=read.csv(paste('asset/xismall',as.character(n), '.csv',sep=''))[,2]
}
else{
case='c>1'
mu0=read.table(paste('asset/c>1/mubasen',as.character(n), '.txt',sep=''), header = FALSE,  sep = '',  stringsAsFactors = FALSE)[,1]
True_sigma=as.matrix(read.table(paste('asset/c>1/sigmabasen',n,'.txt',sep=''), header = TRUE,  sep = '',  stringsAsFactors = FALSE))


xi=read.csv(paste('asset/xibig',as.character(n),'.csv',sep=''))[,2]}

if (selectsigma==1){
    True_sigma=True_sigma
    sigmaname='Sigmabase'
}
else {
    True_sigma=True_sigma+xi%*%t(xi)
    sigmaname='Sigmaelse'
}

if (selectmu==1){
    cat(length(mu0))
    cat(length(one))
    mu=mu0+2*one+sqrt(p)*c(1,rep(0,p-1))
    muname='mu3'
}
else {
    cat(length(mu0))
    cat(length(one))
    mu=mu0+2*one+xi
    muname='mu4'
}



Store=eigen(as.matrix(True_sigma))
True_Sigma_half<-MatrixMultC(Store$vectors ,MatrixMultC(diag(sqrt(Store$values)),t(Store$vectors )))
Inverse_true<-MatrixMultC(Store$vectors ,MatrixMultC(diag(1/(Store$values)),t(Store$vectors )))




# Q0=diag(c(rep(3,half_p),rep(1,p-half_p)))
# Q0_inverse_half=diag(c(rep(1/sqrt(3),half_p),rep(1,p-half_p)))
# Q0_inverse=diag(c(rep(1/(3),half_p),rep(1,p-half_p)))
# Qhalf_hSigma_Qhalf=MatrixMultC(MatrixMultC(Q0_inverse_half,Estimate_sigma),Q0_inverse_half) 

# if(y<1){
# store=eigen(Qhalf_hSigma_Qhalf)
# eigenmatrixP=store$vectors
# eigenvalueLambda=store$values
# }
# else {
#   W <- MatrixMultC(X, Q0_inverse_half)  # W should be 400 x 10000
# # Step 2: Perform SVD on W
#   svd_result <- svd(W/sqrt(n),nv=p)

# # Extract U, D, and V
#   U <- svd_result$u      
#   D <- svd_result$d      
#   eigenmatrixP<- svd_result$v      
#   # Step 3: Construct the eigenvalue vector (10000 total)
#   eigenvalueLambda <- c(D^2, rep(0, p - n))  # Length 10000, zeros for missing eigenvalues
# }


for (repeat0 in 1:2){
cat(repeat0)
Z=rnorm(n*p)
Z=matrix(Z,nrow=n)
X=Z%*%True_Sigma_half

Q=q*diag(c(rep(3,half_p),rep(1,p-half_p)))

Estimate_sigma<-MatrixMultC(t(X),X)/n
filename=paste(muname,'/',case,'/','n=',n,sigmaname,'repeat',repeat0,'.csv',sep='')

MResolvent=MatrixInv(Estimate_sigma+Q)
adjustfactor=abs(1-y*mean(diag(MatrixMultC(Estimate_sigma,MResolvent))))^2

Rvec1=MResolvent%*%one
Rvecmu=MResolvent%*%mu




A=sum(Rvec1*mu)
B=sum(Rvecmu*mu)
C=sum(Rvec1*one)
D=B*C-A^2

vec_g=D^{-1}*(B*Rvec1-A*Rvecmu)
vec_h=D^{-1}*(C*Rvecmu-A*Rvec1)


sigma_0=(vecrepeat1%*%t(vec_g)+mulist%*%t(vec_h))%*%MatrixMultC(True_sigma,t((vecrepeat1%*%t(vec_g)+mulist%*%t(vec_h))))

hatsigma_0=(vecrepeat1%*%t(vec_g)+mulist%*%t(vec_h))%*%MatrixMultC(Estimate_sigma,t((vecrepeat1%*%t(vec_g)+mulist%*%t(vec_h))))/adjustfactor


data=data.frame(mulist,diag(sigma_0),diag(hatsigma_0))
write.csv(data,file=filename)


}

}}
}



