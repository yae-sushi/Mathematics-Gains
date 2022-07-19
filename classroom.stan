data {

  int<lower=0> N_students;
  int<lower=0> N_classes;
  int<lower=0> N_schools;

  int<lower=1> classid[N_students];   // j[i]
  int<lower=1> school[N_classes];     // k[j]

  real mathgain[N_students];
  
}

parameters {

  real gamma0;

  real<lower=0> sigma;

  real<lower=0> tau1;

  real<lower=0> tau2;

  real eta[N_classes];

  real zeta[N_schools];

}

transformed parameters  {

  // I hope this is right...
  real mu[N_students];
  real a[N_classes];
  real b[N_schools];
  
  for (k in 1:N_schools){
    b[k] <- gamma0 + zeta[k];
  }
  
  for (j in 1:N_classes){
    a[j] <- b[school[j]] + eta[j];
  }
  
  for (i in 1:N_students){
    mu[i] <- a[classid[i]];
  }

}

model {
  // What am I doing I really hope this is correct
  
  // Level 1
  for (i in 1:N_students){
    mathgain[i] ~ normal(mu[i], sigma);
  }
  
  // Level 2
  for (j in 1:N_classes){
    eta[j] ~ normal(0, tau1);
  }
  // Level 3
  for (k in 1:N_schools){
    zeta[k] ~ normal(0, tau2);
  }

  // Prior distributions
  sigma ~ exponential(1);
  tau1 ~ uniform(0,50);
  tau2 ~ uniform(0,50);
}
