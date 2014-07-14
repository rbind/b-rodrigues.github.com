#Gmm estimation of a Probit Model

require("gmm")

data<-read.table("/home/cbrunos/Copy/Documents/Work/github_page/b-rodrigues.github.com/assets/files/benefits.R",header=T)

attach(data)

#Logit estimaion with glm()
native<- glm(y ~ age + age2 + dkids + dykids + head + male + married + rr + rr2, family=binomial(link="logit"), na.action=na.pass)

summary(native)


#Estimation via gmm()
dat <- data.matrix(cbind(y,1,age,age2,dkids,dykids,head,male,married,rr,rr2))

logistic<-function(theta,data){
  return(1/(1+exp(-data%*%theta)))
}


moments<-function(theta,data){
 y <- as.numeric(data[,1])
 x <- data.matrix(data[,2:11])
 m<- x*as.vector((y-logistic(theta,x)))
 return(cbind(m))
} 

init<-(lm(y ~ age + age2 + dkids + dykids + head + male + married + rr + rr2))$coefficients

my_gmm <- gmm(moments,x=dat,t0=init,type="iterative",crit=1e-25,method="Nelder-Mead", wmatrix="optimal",control=list(reltol=1e-25,maxit=20000))
 
summary(my_gmm)