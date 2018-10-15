% problems:
% f(x) = 0.5*x'*A*x + b'*x
% h(x) = t*norm(x, 1)
% g(x) =  f(x) + h(x)
% x = argmin g(x)

clear;
m = 100; n = 10;
A = randn(m, n);
A = A'*A;
b = randn(n, 1);
t = 1;

f = @(x)(0.5*x'*A*x + b'*x);
g = @(x)(f(x) + t*norm(x, 1));
df = @(x)(A*x + b);

n_steps = 20;
L = eigs(A, 1);
x = randn(n, 1);
his = zeros(n_steps, 1);
for i = 1:n_steps
	x = proxL1(x - df(x)./L, t / L);
	his(i) = g(x);
end

plot(his);

cvx_begin
    variable xt(n)
	minimize(0.5*xt'*A*xt + b'*xt + t*norm(xt, 1))
cvx_end

disp(['x_cvx = [', sprintf('%8.4f ', xt), ']']);
disp(['x     = [', sprintf('%8.4f ', x), ']']);
disp(['error = [', sprintf('%8.4f ', abs(xt - x)), ']']);
