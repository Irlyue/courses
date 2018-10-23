clear;
x = zeros(2, 1);
[x, his] = newton_method(x, @func_l08, 20);


% Use CVX package
xt = zeros(2, 1);
A = [[1, 3]; [1, -3];, [-1, 0]];
cvx_begin
variable xt(2);
minimize(sum(exp(A*xt)));
cvx_end

disp(['xt  = [', sprintf('%8.4f ', xt), ']', '(CVX)']);
disp(['x   = [', sprintf('%8.4f ', x), ']', '(mine)']);
