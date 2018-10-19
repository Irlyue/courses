function [err] = relative_error(x, y)
% Calculate the relative error 

err = abs(x - y) / max(abs(x) + abs(y), 1e-8);
err = max(err(:));

end
