function [px] = thresholding_l1(a, t)
% U(x) = t*norm(x, 1) + 0.5 * norm(x - a, 2)
%
% Arguments
% ---------
% a, t: specified by the equation above
%
% Returns
% -------
% px: point that minimize the function U(x)

px = sign(a).*max(0, abs(a) - t);

end
