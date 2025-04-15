source('generate.R')

library(Rcpp)
library(RcppEigen)
library(microbenchmark)



# Use Rcpp attributes -----------------------------------------------------

sourceCpp(file = "MatrixMult.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixSolver.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixInv.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixEigenVa.cpp", verbose = TRUE, rebuild = TRUE)






source('basic.R')

for (i in 2:4){
if (i==2) {
   source('Comparemu.R')
}
else if (i==3) {
source('Comparesigma.R')}
else{source('CompareQ.R')}
}









