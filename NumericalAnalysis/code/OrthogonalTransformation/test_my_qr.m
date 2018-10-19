n = 10;
din = 10;
for i =1:n
	x = randn(100, din);
	x = x'*x;
	[qrm, d] = my_qr(x);
	[qm, rm] = split_into_qr(qrm, d);
	err = abs(qm*rm - x);
	err = max(err(:));
	assert(err < 1e-8, '<<ERROR>>');
	fprintf('Case %d passed\n', i)
end

fprintf('===========================\n');
fprintf('=       All Passed        =\n');
fprintf('===========================\n');
