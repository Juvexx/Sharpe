// [[Rcpp::depends(RcppEigen)]]
#include <RcppEigen.h>
#include <Eigen/Eigenvalues>

using Rcpp::NumericMatrix;
using Eigen::Map;
using Eigen::MatrixXd;

// [[Rcpp::export]]
NumericMatrix MatrixEigenVaC(NumericMatrix Ar) {
  int m = Ar.nrow();
  int n = Ar.ncol();
  
  MatrixXd A = MatrixXd::Map(Ar.begin(), m, n);
  
  Eigen::EigenSolver<MatrixXd> es(A);
  MatrixXd D = es.pseudoEigenvalueMatrix();
  MatrixXd V = es.pseudoEigenvectors();
  MatrixXd C(D.rows()+V.rows(), D.cols());
  
  // C << D, V; 
  
  return Rcpp::wrap(V);
}

