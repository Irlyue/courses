function [t] = armijoRule(x, dfx, dx, f, alpha, beta)
% Use Armijo-Rule to search step size in arbitary direction.
% 
% Arguments
% ---------
% x    : point to search
% dfx  : gradient at point x
% dx   : search direction
% f    : function object to calculate f(x)
% alpha: initial step size, default to 0.25
% beta : decay factor, default to 0.5
% 
%
% Returns
% -------
% t: step size

if nargin == 4
	alpha = 0.25;
	beta = 0.5;
end

fx = f(x);
ddx = dfx' * dx;
t = 1.0;
for k = 1:20
	xn = x + t*dx;
	fxn = f(xn);
	if fxn - fx <= alpha * t * ddx
		break;
	end
	t = t*beta;
end
