function [U] = l1tv_admm(Af, Bf, Adf, Bdf, C, lambda, n_iters)
% Use ADMM(Alternating Direction Methods of Multiplier) to denoise
% an image with pulse noise.
% 
% min_{U} norm(Af(U), 1) + norm(Bf(U), 1) + lambda*norm(U-C, 1)
% 
% equivalent to
%
% min_{X, Y, Z} norm(Y, 1) + norm(Z, 1) + lambda*norm(X, 1), s.t. A(C+X)=Y, B(C+X)=Z
%
% Arguments
% ---------
% Af, Bf     : function objects that perform x and y axis circulant transformation
% Adf, Bdf   : the corresponding gradient of function Af and Bf
% C          : the corrupted image
% lambda     : denote the relative importance of re-constructing loss and smoothness
%              loss
% n_iters    : number of iterations
%
% Returns
% -------
% U    : denoised image

beta = 100;
X = zeros(size(C)); Y = zeros(size(C)); Z = zeros(size(C));
% Larangage multipliers
pi = zeros(size(C)); eta = zeros(size(C));

for k = 1:n_iters
	% X = argmin 0.5*beta*norm(Af(C+X)-Y+pi/beta, 'fro') + norm(X, 1)
	% Use chain rule to calculate the gradient with respective to X
	% 1. denote A = Af(X+C), dA = beta*(Af(X+C)-Y+pi/beta);
	% 2. dX = Adf(dA);
	dX = Adf(beta*(Af(X+C)-Y+pi/beta)) + Bdf(beta*(Bf(X+C)-Z+eta/beta));
	L = beta*4 + beta*4;  % But why choose L like this?
	X = thresholding_l1(X-dX/L, lambda/L);

	% Y = argmin 0.5*beta*norm(Y-(Af(X+C)+pi/beta), 'fro') + norm(Y, 1);
	Y = thresholding_l1(Af(C+X)+pi/beta, 1/beta);

	% Z = argmin 0.5*beta*norm(Z-(Bf(X+C)+eta/beta), 'fro') + norm(Z, 1);
	Z = thresholding_l1(Bf(C+X)+eta/beta, 1/beta);

	% Update Lagrange multipliers
	dpi = Af(C+X) - Y;
	pi = pi + beta*dpi;
	deta = Bf(C+X) - Z;
	eta = eta + beta*deta;
end

U = C + X;
end
