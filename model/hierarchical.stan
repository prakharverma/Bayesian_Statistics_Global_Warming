data {
  int N;
  vector[N] y;
  vector[N] x;
  int k;
  int i[N];
}

parameters {
  vector[k] beta;
  vector[k] alpha;
  real <lower=0> sigma;
  real <lower=0> sigma0;
  real beta0;
}

model {
  beta0 ~ normal(0,10);
  sigma0 ~ normal(0, 10);
  beta ~ normal(beta0, sigma0);
  y ~ normal(alpha[i] + beta[i] .* (x-1970), sigma);
}

generated quantities{
  vector[N] log_lik;
  vector[N] y_rep;
 
 for (j in 1:N) {
   log_lik[j] = normal_lpdf(y[j] | alpha[i[j]] + beta[i[j]] .* (x[j]-1970), sigma);
   y_rep[j] = normal_rng(alpha[i[j]] + beta[i[j]] .* (x[j]-1970), sigma);
 }
}
