% Brian Knotten
% CS 1675
% Homework 2

% A = NxD matrix, N = # samples, D = dimensionality of feature representation
% k = # clusters to output
% iters = # iterations to run
% R = scalar denoting # random restarts
% ids = data membership ids of each sample
% means = mean/center for each cluster
% ssd = lowest final ssd error of the clustering (sum of squared distances between
% points and their assigned means summer over all clusters)

function [ids, means, ssd] = restarts(A, k, iters, R)
    ssd = realmax;
    for r = 1:R
        [ids2, means2, ssd2] = my_kmeans(A, k, iters);
        if ssd2<ssd
            ids = ids2;
            means = means2;
            ssd = ssd2;
        end
    end
