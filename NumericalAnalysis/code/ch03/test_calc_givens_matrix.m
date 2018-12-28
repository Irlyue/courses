fprintf('Testing function calc_givens_matrix!\n');
A = [[2.0, 0.0]; [-2.0, 0.0]; [0.0, 3.0]; [1., 2.]; [0., 0.]];

n = length(A);
for i = 1:n
	G = calc_givens_matrix(A(i, 1), A(i, 2));
	y = G*A(i, :)';
	assert(abs(y(1)) == norm(A(i, :)) && y(2) == 0);
	fprintf('Test case passes![%d|%d]\n', i, n);
end
