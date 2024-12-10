// [[Rcpp::depends(RcppEigen)]]
#include <RcppEigen.h>

using Rcpp::NumericMatrix;
using Eigen::Map;
using Eigen::MatrixXd;

// [[Rcpp::export]]
NumericMatrix MatrixMultC(NumericMatrix Ar, NumericMatrix Br) {
  int m = Ar.nrow();
  int n = Ar.ncol();
  int k = Br.ncol();
  
  MatrixXd C;
  MatrixXd A = MatrixXd::Map(Ar.begin(), m, n);
  MatrixXd B = MatrixXd::Map(Br.begin(), n, k);
  
  C = A * B;
  return Rcpp::wrap(C);
}

