clear;
dims = [5, 10, 20, 50, 100, 1000];
for k = 1:length(dims)
	A = randn(dims(k));
	Htrue = hess(A);
	Hmine = hessenberg(A);
	err = relative_error(abs(Htrue), abs(Hmine));
	assert(err < 1e-10, '<<ERROR>>');
	fprintf('Case %d with %d by %d matrix passed\n', k, dims(k), dims(k));
end

fprintf('===========================\n');
fprintf('=       All Passed        =\n');
fprintf('===========================\n');
