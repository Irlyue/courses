function G = clac_givens_matrix(a, b)
% This function calculate the Givens matrix 
%         G = [[c,  s]
%              [-s, c]]
% such that G[a]=[*].
%            [b] [0]
%
% Arguments
% ---------
% a, b   : float, both are scalars.
%
% Returns
% -------
% G   : the Givens matrix as described above.

if b == 0
	c = 1;
	s = 0;
else
	if abs(b) > abs(a)
		tou = a / b;
		s = 1./sqrt(1 + tou^2);
		c = s*tou;
	else
		tou = b / a;
		c = 1./sqrt(1 + tou^2);
		s = c*tou;
	end
end
G = [[c, s]; [-s, c]];
end
