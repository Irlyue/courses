x1 = [1, 2, 3]';
x2 = randn(3, 5);
x3 = [2, 0, 0]';
x4 = [-2, 0, 0]';
x5 = [0, 2, 0]';
X = [x1, x2, x3, x4, x5];
[m, n] = size(X);

for i = 1:n
	x = X(:, i);
	[beta, v] = calc_householder_matrix(x);
	y = householder_transform(x, beta, v);
	yt = zeros(3, 1); yt(1) = norm(x, 2);
	err = max(abs(yt - y));
	assert(err < 1e-8, '<<ERROR>>');
	fprintf('Case %d passed\n', i)
end

fprintf('===========================\n');
fprintf('=       All Passed        =\n');
fprintf('===========================\n');
