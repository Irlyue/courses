function [fw, dw, hw] = func_l09(X, y, w)
% Function object that calculate the value, gradient and Hessian matrix
% of the following function:
%       f(w) = sum(log(1 + exp(-yXw)))
% which is actually the loss function for logistic regression.
%
% See lecture ppt L9 for details.
%
% Arguments
% ---------
% X      : m by n matrix, every row in X is a data point
% y      : m by 1 vector, either 0 or 1, the label for each data point
% w      : n by 1 vector, weight
%
% Returns
% -------
% fx, dx, hx : function value, gradient, Hessian matrix

Xw = X*w;
yXw = y.*Xw;

fw = sum(log(1 + exp(-yXw)));

sig = 1.0 ./ (1.0 + exp(-yXw));
dw = X' * (-y.*(1 - sig));

weight = sig.*(1 - sig);
%hw = X.'*diag(sparse(sig.*(1 - sig)))*X;
hw = X'*bsxfun(@(x, y)x.*y, weight, X);

end
