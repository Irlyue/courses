clear;
x = zeros(2, 1);
[x, his] = newton_method(x, @func_l08, 20);

x = zeros(2, 1);
A = [[1, 3]; [1, -3];, [-1, 0]];

cvx_begin
variable x(2);
minimize(sum(exp(A*x)));
cvx_end
