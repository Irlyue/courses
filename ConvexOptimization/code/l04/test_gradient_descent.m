clear;

m = 100; n = 4;
A = randn(m, n);
A = A'*A;
b = randn(n, 1);

f = @(x)(0.5*x'*A*x - b'*x);
df = @(x)(A*x - b);

x0 = zeros(n, 1);
alpha = 1.0 / eigs(A, 1);
[x, his] = gradientDescent(x0, alpha, f, df);
plot(his);
