% 10. Write a function function [B] = normalize_rows(A) which uses a
% single command (one line and no loops) to make the sum in each row
% of the matrix 1. You may need to use repmat, depending on your
% Matlab version. Note that the sum of the entries in each row should
% be 1, in the matrix output by your function.

function [B] = normalize_rows(A)

    B = A./sum(A,2);