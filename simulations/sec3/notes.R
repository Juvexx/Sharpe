library(Rcpp)
library(RcppEigen)
library(microbenchmark)

Sys.setenv("PKG_CPPFLAGS" = "-march=native")

# Use Rcpp attributes -----------------------------------------------------

sourceCpp(file = "MatrixMult.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixSolver.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixInv.cpp", verbose = TRUE, rebuild = TRUE)
sourceCpp(file = "MatrixEigenVa.cpp", verbose = TRUE, rebuild = TRUE)

####################################################
