data {
  int<lower=1> m; //число уравнений 2
  int<lower=1> k; //число регрессоров в одном уравнении 4
  int<lower=1> n; //число наблюдений 1000
  matrix[n, k] x;
  matrix[n, k] X;
  vector[m] y[n];
}
parameters {
  vector[k] beta;
  vector[k] Beta;
  real<lower=2> sigma1;
  real<lower=2> sigma2;
  real<lower=-1, upper=1> p;
}
transformed parameters {
  vector[m] mu[n];
  cov_matrix[m] Sigma;
  Sigma[1][1] = sigma2;
  Sigma[2][2] = sigma1;
  Sigma[1][2] = square(sigma1) * square(sigma2) * p;
  Sigma[2][1] = square(sigma1) * square(sigma2) * p;
  for (s in 1:n) {
    mu[s][1] = x[s]*beta;
    mu[s][2] = X[s]*Beta;
  }
}
model {
  beta ~ normal(1, 100);
  Beta ~ normal(1, 100);
  sigma1 ~ normal(0, 1);
  sigma2 ~ normal(0, 1);
  p ~ normal(0, 1);
  y ~ multi_normal(mu, Sigma);
}