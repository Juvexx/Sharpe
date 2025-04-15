### This is the manuscirpt for the simulation of the optimized diagonal Q in Appendix A.3


fun_grad_log_diag <- function(q, hatSigma, mu, c, p, debug = FALSE) {
  # Ensure q is a vector of length p.
  if(length(q) != p) stop("q must have length p")
  
  # Construct Q as a diagonal matrix; since q has dimension p, diag(q) creates a p x p matrix.
  Q <- diag(q)
  if(debug) {
    cat("Q (diagonal matrix):\n"); print(Q)
  }
  
  # Define A = hatSigma + Q.
  A <- hatSigma + Q
  if(debug) {
    cat("A = hatSigma + Q:\n"); print(A)
  }
  
  # Compute A^{-1} using your optimized routine.
  invA <- MatrixInv(A)
  if(any(is.na(invA))) {
    if(debug) cat("MatrixInv returned NA; returning penalty.\n")
    return(list(value = 1e10, gradient = rep(0, length(q))))
  }
  if(debug) {
    cat("invA:\n"); print(invA)
  }
  
  # Cache common products.
  commonTerm1 <- MatrixMultC(hatSigma, invA)  # hatSigma %*% invA
  commonTerm2 <- MatrixMultC(invA, commonTerm1) # invA %*% hatSigma %*% invA
  commenvec <- invA%*%mu          # invA %*% mu
  
  # Compute intermediate quantities.
  trace_term <- sum(diag(commonTerm1))
  T1 <- 1 - (c / p) * trace_term            # T1 = 1 - (c/p)*tr(hatSigma %*% invA)
  S  <- as.numeric(t(mu) %*% invA %*% mu)      # S = mu' invA mu
  S2 <- as.numeric(t(mu) %*% commonTerm2 %*% mu) # S2 = mu' invA hatSigma invA mu
  
  if(debug) {
    cat("trace_term:", trace_term, "\n")
    cat("T1:", T1, "\n")
    cat("S:", S, "\n")
    cat("S2:", S2, "\n")
  }
  
  # If any intermediate value is non-positive (T1, S, or S2), return a large penalty.
  if (T1 <= 0 || S <= 0 || S2 <= 0) {
    if(debug) cat("One of T1, S, or S2 is non-positive; returning penalty.\n")
    return(list(value = 1e10, gradient = rep(0, length(q))))
  }
  
  # Log objective: g_obj = log(T1) + log(S) - 0.5 * log(S2)
  g_obj <- log(T1) + log(S) - 0.5 * log(S2)
  obj <- -g_obj   # We minimize the negative log objective.
  if(debug) {
    cat("Log objective (g_obj):", g_obj, "\n")
    cat("Objective to minimize:", obj, "\n")
  }
  
  # Compute gradient contributions (with cached common terms):
  grad_logT1 <- (c / (p * T1)) * commonTerm2
  grad_logS  <- - (commenvec %*% t(commenvec)) / S
  grad_logS2 <- - (commonTerm2 %*% mu %*% t(commenvec) +
                    commenvec %*% t(mu) %*% commonTerm2) / S2
  grad_logS2 <- -0.5 * grad_logS2
  
  # Total gradient with respect to Q.
  grad_Q <- grad_logT1 + grad_logS + grad_logS2
  
  # For Q = diag(q), the gradient with respect to q is simply the diagonal elements of grad_Q.
  grad_q <- diag(grad_Q)
  
  # For minimization, we supply the negative gradient.
  grad_obj <- -grad_q
  if(debug) {
    cat("Gradient with respect to q:\n")
    print(grad_obj)
  }
  
  return(list(value = obj, gradient = grad_obj))
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

set.seed(1997)
hatSRhatQ=NULL
SRhatQ=NULL
for (repeat0 in 1:20){
cat(repeat0,'\n')
Z=rnorm(n*p)
Z=matrix(Z,nrow=n)

X=MatrixMultC(Z,True_Sigma_half)

hatSigma<-MatrixMultC(t(X),X)/n


q_init <- rep(1, p)

# Optimize using optim() with L-BFGS-B, restricting q >= 0.
res <- optim(
  par = q_init,
  fn = function(q) fun_grad_log_diag(q, hatSigma, mu, c, p, debug = FALSE)$value,
  gr = function(q) fun_grad_log_diag(q, hatSigma, mu, c, p, debug = FALSE)$gradient,
  method = "L-BFGS-B",
  lower = rep(0, p)   # Enforce q >= 0.
)

opt_Q <- diag(res$par)
bXi=MatrixInv(hatSigma+opt_Q)


hatSRhatQ=c(hatSRhatQ,(1-c/p*sum(diag(hatSigma%*%bXi)))/sqrt(t(mu)%*%bXi%*%hatSigma%*%bXi%*%mu)*(t(mu)%*%bXi%*%mu))  # Check the function and gradient

SRhatQ=c(SRhatQ,(t(mu)%*%bXi%*%mu)/sqrt(t(mu)%*%bXi%*%True_sigma%*%bXi%*%mu))  # Check the function and gradient
}

write.csv(hatSRhatQ, file = paste('optimizeQ/hatSRdiaghatQc<1',as.character(n),'.csv',sep=''), row.names = FALSE)
write.csv(SRhatQ, file = paste('optimizeQ/SRdiaghatQc<1',as.character(n),'.csv',sep=''), row.names = FALSE)



hatSRhatQ=read.csv(paste('optimizeQ/hatSRdiaghatQc<1',as.character(n),'.csv',sep=''), header = TRUE,  sep = '',  stringsAsFactors = FALSE)
SRhatQ=read.csv(paste('optimizeQ/SRdiaghatQc<1',as.character(n),'.csv',sep=''), header = TRUE,  sep = '',  stringsAsFactors = FALSE)

mean(SRhatQ[,1])
min(SRhatQ[,1])
max(SRhatQ[,1])

mean(hatSRhatQ[,1])
min(hatSRhatQ[,1])
max(hatSRhatQ[,1])


