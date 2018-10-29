clear;
m = 100; n = 200; d = 5;
w = zeros(n, 1);  % have to be initialized at zero.
v = randn(d, 1);
X = randn(m, n);
y = sign(randn(m, 1));

A = randn(d, n);
b = randn(d, 1);

%fx = func_l09(X, y, w);
[w, his] = is_newton_method_eq(w, v, A, b, @(w)func_l09(X, y, w), 100);
plot(his);
fprintf('Done in %d steps\n', length(his));
disp(['||Aw - b||_2 = ', sprintf('%f', norm(A*w - b))]);
