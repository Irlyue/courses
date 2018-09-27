x = [1, 2, 3]';
[beta, v] = calc_householder_matrix(x);

y = householder_transform(x, beta, v);

y_true = [sqrt(x'*x), 0.0, 0.0]';

fprintf('%6s %2s\n', 'y_true', 'y');
fprintf('%.5f %.5f\n', [y_true'; y']);