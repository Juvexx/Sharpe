source('generate.R')
library(Rcpp)
library(RcppEigen)
library(microbenchmark)

# Sys.setenv("PKG_CPPFLAGS" = "-march=native")
#try this if Rcpp do not work


sourceCpp(file = "MatrixMult.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixSolver.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixInv.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixEigenVa.cpp", verbose = TRUE, rebuild = TRUE)



source('mucase.R')

source('readasymp.R')

##use python plot the figures

