// [[Rcpp::depends(RcppEigen)]]
#include <RcppEigen.h>

using Rcpp::NumericMatrix;
using Eigen::Map;
using Eigen::MatrixXd;

// [[Rcpp::export]]
NumericMatrix MatrixInv(NumericMatrix Ar) {
  int m = Ar.nrow();
  int n = Ar.ncol();
  
  MatrixXd C ;
  MatrixXd A = MatrixXd::Map(Ar.begin(), m, n);
  
  C = A.inverse();
  return Rcpp::wrap(C);
}

