m = 100000;
n = 10;

A = randn(m, n);
b = randn(m, 1);
rs1 = ls_by_qr(A, b, @qr_by_householder);
disp(['x = [', sprintf('%.3f ', rs1), ']']);
disp(['||Ax - b||_2 = ', sprintf('%.6f', norm(A*rs1 - b))]);

ATA = A'*A;
ATb = A'*b;
rs2 = ATA \ ATb;
disp(['x = [', sprintf('%.3f ', rs2), ']']);
disp(['||Ax - b||_2 = ', sprintf('%.6f', norm(A*rs2 - b))]);
