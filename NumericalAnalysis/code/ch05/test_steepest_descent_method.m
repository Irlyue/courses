% A = [[6, 3]; [3, 2]];
% p = [0; -1];

A = [[4, 3, 0]; [3, 4, -1]; [0, -1, 4]];
p = [3; 5; -5];

[x, y] = steepest_descent_method(zeros(numel(p), 1), A, p, 100);
fprintf('%s\n', x);
fprintf('steps = %d\n', numel(y));
x_true = A \ p;
err = abs(x - x_true) / abs(x + x_true);
err = max(err(:));
fprintf('error = %f\n', err);
plot(y);