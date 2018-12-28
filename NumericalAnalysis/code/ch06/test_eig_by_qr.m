clear;
%Case 1:
X = [[1 0 -1 0];
	 [0 1 -1 0];
	 [1 2 1 1];
	 [-1 0 0 1]];
vt = [3, 2, 1, -3]';
D = diag(vt);
A = X*D*inv(X);
%
% Case 2:
%rng(3);
%A = randn(6, 6);
%vt = eig(A);


% No Hessenberg(Really weid figure)
n = 150;
errs = zeros(n, 1);
for i = 1:n
	v = eig_by_qr(A, i);
	errs(i) = norm(sort(v) - sort(vt));
end
subplot(1, 2, 1);
plot(errs);
title('Without Hessenberg');
ylabel('$||v-vt||_2$', 'Interpreter', 'latex');

% With Hessenberg(Converges much quickly)
n = 150;
errs = zeros(n, 1);
H = hessenberg(A);
for i = 1:n
	v = eig_by_qr(H, i);
	errs(i) = norm(sort(v) - sort(vt));
end
subplot(1, 2, 2);
plot(errs);
title('With Hessenberg');
ylabel('$||v-vt||_2$', 'Interpreter', 'latex');
