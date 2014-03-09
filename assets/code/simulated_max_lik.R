data<-read.table("http://cameron.econ.ucdavis.edu/mmabook/mma12p2mslmsm.asc")
u<-data[,1]
e<-data[,2]
y<-data[,3]
numobs<-length(u)
simreps<-10000

#write the likelihood using sapply
denssim<-function(theta){
loglik<-mean(sapply(y,function(y) log(mean((1/sqrt(2*pi))*exp(-(y-theta+log(-log(runif(simreps))))^2/2)))))
return(-loglik)
}

#run the optimization process
system.time(res<-optim(0.1,denssim,method="BFGS",control=list(maxit=simreps)))

#generate new data with another parameter value
y2<-2.5 + u + e
denssim2<-function(theta){
  loglik<-mean(sapply(y2,function(y2) log(mean((1/sqrt(2*pi))*exp(-(y2-theta+log(-log(runif(simreps))))^2/2)))))
  return(-loglik)
}

#run the optimization process with this new data
system.time(res2<-optim(0.1,denssim2,method="BFGS",control=list(maxit=simreps)))


