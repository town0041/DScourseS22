library(nloptr)
library(modelsummary)

#Problem 4
#From here I just follow the problem's isntructions to set the following values.
set.seed(100)
N <- 100000
K <- 10
sigma <- 0.5
X <- matrix(rnorm(N*K,mean = 0,sd=sigma),N,K)
X[,1]<-1
eps <- rnorm(N,mean=0,sd=sigma)
beta <- matrix(c(1.5,-1,-0.25,0.75,3.5,-2,0.5,1,1.25,2),K,1)
Y <- X%*%beta + eps


#Problem 5
beta_OLS <- solve(t(X)%*%X)%*%(t(X)%*%Y)
beta_OLS

#Problem 6

objfunct <- function(beta_h,y,x){return (sum(y-x%*%beta_h)^2)}

gradient <- function(beta_g,y,x) {
  return ( as.vector(-2*t(x)%*%(y-X%*%beta_g)) )
}

beta0 <- matrix(rnorm(K,mean = 0,sd=sigma),K,1)

gradientDesc <- function(y, x, beta_i,object,grad,learn_rate, tol,  max_iter) {
  
  n=dim(y)[1]
  m <- beta_i
  c <- matrix(rnorm(n,mean = 0,sd=sigma),n,1)
  
  yhat <- x%*%m+c
  MSE <- object(m,y,x)
  
  converged = F
  iterations = 0
  while(converged == F) {
    ## Implement the gradient descent algorithm
    m_new <- m - learn_rate * grad(m,y,x)
    m <- m_new
    c <- y-X%*%m
    yhat <- X%*%m+c
    MSE_new <- object(m,y,x)
    if(MSE - MSE_new <= tol) {
      converged = T
      
      return(m)
    }
    iterations = iterations + 1
    if(iterations > max_iter) { 
      converged = T
      return(m)
    }
  }
}


# We now must run the function we've formed.

beta_grad=gradientDesc(Y, X, beta0,objfunct,gradient,0.0000003, 0.0000000001, 1000)

#Problem 7

options <- list("algorithm"="NLOPT_LD_LBFGS","xtol_rel"=1.0e-6,"maxeval"=1e3)
beta_BFGS <- nloptr( x0=beta0,eval_f=objfunct,eval_grad_f=gradient,opts=options,y=Y,x=X)
beta_BFGS$solution

options <- list("algorithm"="NLOPT_LN_NELDERMEAD","xtol_rel"=1.0e-8)
beta_NM <- nloptr( x0=beta0,eval_f=objfunct,opts=options,y=Y,x=X)

beta_NM$solution

#It seems that my answers do vary a little bit...

#Problem 8

gradient_2 <- function (theta ,y,x) {
  grad <- as.vector( rep (0, length (theta )))
  beta <- theta [1:( length ( theta) -1)]
  sig <- theta [ length (theta )]
  grad [1:( length ( theta) -1)] <- -t(X)%*%(Y - X%*%beta )/(sig ^2)
  grad[ length (theta )] <- dim (X)[1] /sig - crossprod (Y-X%*%beta )/(sig^3)
  return ( grad )
}
objfunct_2 <- function(beta_h,y,x) {
  return (sum((y-x%*%beta_h[1:( length ( beta_h) -1)])^2))
}
#theta0 <- runif(dim(X)[2]+1)
theta0 <- append(as.vector(summary(lm(Y~X-1))$coefficients[,1]),runif(1))
options <- list("algorithm"="NLOPT_LD_LBFGS","xtol_rel"=1.0e-6,"maxeval"=1e3)
beta_2 <- nloptr( x0=theta0,eval_f=objfunct_2,eval_grad_f=gradient_2,opts=options,y=Y,x=X)

round(beta_2$solution,3)

#Problem 9
estimate <-lm(Y ~ X -1)
modelsummary(estimate, output = 'latex')






