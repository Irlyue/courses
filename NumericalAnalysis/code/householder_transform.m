function [y] = householder_transform(x, beta, v)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if beta == 0
    y = x;
else
    c = beta .* (x' * v);
    y = x - c .* v;
end

end

