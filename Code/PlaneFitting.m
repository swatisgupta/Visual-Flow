function [P] = PlaneFitting(N_e)

A = cell2mat(N_e);
A = [A, ones(size(A, 1), 1)];
[~, ~, V] = svd(A);
P = V(:, end);

% B = A'*A;
% [V, D] = eig(B);
% P = V(:, 1);




end