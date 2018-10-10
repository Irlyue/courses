function [t] = armijoRule(x, dx, f)
% Use Armijo-Rule to search step size in negative gradient direction
% 
% Arguments
% ---------
% x    : point to search
% dx   : gradient at point x
% f    : function object to calculate f(x)
%
% Returns
% -------
% t: step size

alpha = 0.25;
beta = 0.5;
fx = f(x);
ddx = x'*dx;
t = alpha;
for k = 1:20
	xn = x - t*dx;
	fxn = f(xn);
	if fxn - fx <= alpha * t * ddx
		break;
	end
	t = t*beta;
end
