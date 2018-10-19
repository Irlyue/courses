m = 10000;
n = 100;
B = rand(m, n);
A = B'*B;
b = rand(n, 1);

[x, steps] = conjugate_gradient(zeros(n, 1), A, b, 1e-8);

x_true = A \ b;


fprintf('steps = %d\n', steps);

fprintf('%-7s %-7s %-7s\n', 'x',  'x_true', 'error');
fprintf('%+.4f %+.4f %.4f\n', [x, x_true, abs(x - x_true)]');