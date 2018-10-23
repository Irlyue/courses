function [x, his, t_his] = gradientDescentWithArmijo(x0, f, df, n_steps)
% Use Armijo-Rule to inference step size at different iterations.
%
% Arguments
% ---------
% x0      : initial point
% f       : function object to compute f(x)
% df      : gradient function to compute df(x)
% n_steps : number of iterations
%
% Return
% ------
% x     : result
% his   : history of f(x) at different iterations
% t_his : history of step size at different iterations

if nargin == 3
	n_steps = 50;
end

x = x0;
his = zeros(n_steps, 1);
t_his = zeros(n_steps, 1);
for k = 1:n_steps
	dx = df(x);
	% if gradient reaches around zero, done
	if dx'*dx < 1e-8
		his = his(1:k-1);
		t_his = t_his(1:k-1);
		break
	end
	t = armijoRule(x, dx, -dx, f);
	x = x - t * dx;
	his(k) = f(x);
	t_his(k) = t;
end
