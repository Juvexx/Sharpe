# This is the code for the simulation of the optimized full Q in Appendix A.3
vec_to_lower_triangular <- function(lvec, p) {
  L <- matrix(0, nrow = p, ncol = p)
  L[lower.tri(L, diag = TRUE)] <- lvec
  return(L)
}

# Convert a lower-triangular matrix L into a vector (its lower-triangular entries).
lower_triangular_to_vec <- function(L) {
  return(L[lower.tri(L, diag = TRUE)])
}




fun_grad_log_Q <- function(Q, hatSigma, mu, c, p) {
  # Compute A = hatSigma + Q
  A <- hatSigma + Q
  invA <- MatrixInv(A)  # B = A^{-1}
  
  # Cache common products.
  commonTerm1 <- MatrixMultC(hatSigma, invA)
  commonTerm2 <- MatrixMultC(invA, commonTerm1)  # invA %*% hatSigma %*% invA
  commenvec <- invA %*% mu
  
  # Intermediate quantities.
  trace_term <- sum(diag(commonTerm1))
  T1 <- 1 - (c / p) * trace_term       # T1 = 1 - (c/p)*tr(hatSigma %*% invA)
  S <- as.numeric(t(mu) %*% invA %*% mu)  # S = mu' invA mu
  S2 <- as.numeric(t(mu) %*% commonTerm2 %*% mu)  # S2 = mu' invA hatSigma invA mu
  
  # Log objective value.
  g_obj <- log(T1) + log(S) - 0.5 * log(S2)
  obj <- -g_obj  # we minimize -log f(Q)
  
  # Derivatives:
  grad_logT1 <- (c / (p * T1)) * commonTerm2
  grad_logS  <- - (commenvec %*% t(commenvec)) / S
  grad_logS2 <- - (commonTerm2 %*% mu %*% t(commenvec) +
                    commenvec %*% t(mu) %*% commonTerm2) / S2
  grad_logS2 <- -0.5 * grad_logS2
  
  grad_g <- grad_logT1 + grad_logS + grad_logS2
  grad_obj <- -grad_g  # gradient for minimization of -g(Q)
  
  return(list(value = obj, grad_Q = grad_obj))
}


fun_grad_log_chol <- function(lvec, hatSigma, mu, c, p, debug = FALSE) {
  # Convert lvec to lower-triangular matrix L.
  L <- vec_to_lower_triangular(lvec, p)
  if(debug) {
    cat("L:\n"); print(L)
  }
  
  # Compute Q = L L^T, which is positive semidefinite.
  Q <- L %*% t(L)
  if(debug) {
    cat("Q = L %*% t(L):\n"); print(Q)
  }
  
  # Evaluate the original objective and gradient at Q.
  resQ <- fun_grad_log_Q(Q, hatSigma, mu, c, p)
  obj <- resQ$value        # objective value: -g(Q)
  grad_Q <- resQ$grad_Q      # gradient with respect to Q (p x p matrix)
  
  # Chain rule: d f(LL^T) / dL = 2 * grad_Q * L.
  grad_L <- 2 * MatrixMultC(grad_Q, L)
  
  # Since our free parameters are the lower triangular part of L, we extract that vector.
  grad_vec <- lower_triangular_to_vec(grad_L)
  
  if(debug) {
    cat("Objective:", obj, "\n")
    cat("Gradient (vectorized):\n"); print(grad_vec)
  }
  
  return(list(value = obj, gradient = grad_vec))
}





# n=500
# p=250

n=1000
p=500
c=p/n
mu=read.table(paste('asset/c<1/mubasen',as.character(n), '.txt',sep=''), header = FALSE,  sep = '',  stringsAsFactors = FALSE)[,1]
True_sigma=read.table(paste('asset/c<1/sigmabasen',as.character(n), '.txt',sep=''), header = TRUE,  sep = '',  stringsAsFactors = FALSE)
Store=eigen(as.matrix(True_sigma))
True_sigma<-Store$vectors %*%diag(Store$values)%*%t(Store$vectors )
True_Sigma_half<-Store$vectors %*%diag(sqrt(Store$values))%*%t(Store$vectors )
Inverse_true<-Store$vectors %*%diag(1/(Store$values))%*%t(Store$vectors )


SRmax=sqrt(t(mu)%*%Inverse_true%*%mu)


######We need the matrix Q to be positive semidefinite, so we can use the Cholesky decomposition to ensure that Q is positive semidefinite.
# Q=L L^T, where L is a lower-triangular matrix. 
set.seed(1997)
hatSRhatQ=NULL
SRhatQ=NULL
for (repeat0 in 1:20){
cat(repeat0,'\n')
Z=rnorm(n*p)
Z=matrix(Z,nrow=n)

X=MatrixMultC(Z,True_Sigma_half)

hatSigma<-MatrixMultC(t(X),X)/n


# Initialize L as the identity matrix; then vectorize its lower-triangular part.
L_init <- diag(p)
init_lvec <- lower_triangular_to_vec(L_init)

# Now optimize using optim.
res <- optim(
  par = init_lvec,
  fn = function(lvec) fun_grad_log_chol(lvec, hatSigma, mu, c, p, debug = FALSE)$value,
  gr = function(lvec) fun_grad_log_chol(lvec, hatSigma, mu, c, p, debug = FALSE)$gradient,
  method = "L-BFGS-B"
)

# Retrieve the optimized L, then construct Q = L L^T.
opt_L <- vec_to_lower_triangular(res$par, p)
opt_Q <- opt_L %*% t(opt_L)

bXi=MatrixInv(hatSigma+opt_Q)



hatSRhatQ=c(hatSRhatQ,(1-c/p*sum(diag(hatSigma%*%bXi)))/sqrt(t(mu)%*%bXi%*%hatSigma%*%bXi%*%mu)*(t(mu)%*%bXi%*%mu))  # Check the function and gradient

SRhatQ=c(SRhatQ,(t(mu)%*%bXi%*%mu)/sqrt(t(mu)%*%bXi%*%True_sigma%*%bXi%*%mu))  # Check the function and gradient

}
# write.csv(hatSRhatQ, file = paste('optimizeQ/hatSRhatQc<1',as.character(n),'.csv',sep=''), row.names = FALSE)
# write.csv(SRhatQ, file = paste('optimizeQ/SRhatQc<1',as.character(n),'.csv',sep=''), row.names = FALSE)
n
hatSRhatQ=read.csv(paste('optimizeQ/hatSRhatQc<1',as.character(n),'.csv',sep=''), header = TRUE,  sep = '',  stringsAsFactors = FALSE)
SRhatQ=read.csv(paste('optimizeQ/SRhatQc<1',as.character(n),'.csv',sep=''), header = TRUE,  sep = '',  stringsAsFactors = FALSE)

mean(SRhatQ[,1])
min(SRhatQ[,1])
max(SRhatQ[,1])

mean(hatSRhatQ[,1])
min(hatSRhatQ[,1])
max(hatSRhatQ[,1])
# exp(-fun_grad_log_chol(res$par, hatSigma, mu, c, p)$value)
