data {
  int<lower=0> n; 
  vector[n] x_1;
  vector[n] x_2;         
  vector[n] y;
}

parameters {
  real beta_0;
  real beta_1;
  real beta_2;
}

model {
  beta_0 ~ uniform(-5, 5);
  beta_1 ~ uniform(-5, 5);
  beta_2 ~ uniform(-5, 5);
  y ~ logistic(beta_0 + beta_1 * x_1 + beta_2 * x_2, 1);
}                                      
