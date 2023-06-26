% Given filter
H = [-1 -2 0; -2 0 3; 0 3 1];
[I,J,K] = svd(H);
% 𝐺=A*B*C'
H1 = I(:,1:rank(H)).*J(1:r,1:rank(H)).*K(:,1:rank(H))';
disp(H1);
% our goal is to find the minimum difference error ratio between the
% frobenius norm of the original filter H and the frobenius norm of the
% approximated filter H1.
optimal_frob_norm = norm(H-H1, 'fro');
disp(optimal_frob_norm);





