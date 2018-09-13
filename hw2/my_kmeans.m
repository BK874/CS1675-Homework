% Brian Knotten
% CS 1675
% Homework 2

% A = NxD matrix, N = # samples, D = dimensionality of feature representation
% k = # clusters to output
% iters = # iterations to run
% ids = data membership ids of each sample
% means = mean/center for each cluster
% ssd = final ssd error of the clustering (sum of squared distances between
% points and their assigned means summer over all clusters)

function [ids, means, ssd] = my_kmeans(A, k, iters)

% Create matrix to hold the ranges of each feature dimension:
% Row one of the matrix holds the min of each dimension (column)
% Row two holds the max of each dimension (column)
    featRange = [min(A); max(A)];
    
    % Create matrix to hold cluster means
    means = zeros(k, size(A, 2));

    % Randomly populate the cluster means using the feature dimension ranges
    for col = 1:size(means, 2)
        for i = 1:size(means, 1)
            means(i, col) = featRange(1, col) + (featRange(2, col) - featRange(1, col)) .* rand;
        end
    end

    % Compute membership for each data sample by comparing the distance between
    % each sample (row of A) and each cluster center (row of means) and assigning
    % each sample to the nearest center
    clustMem = zeros(1, k);
    for i = 1:size(A, 1)
        dist = zeros(1, k);
        for j = 1:k
            dist(j) = pdist2(A(i, :), means(j, :));
        end
        [m, I] = min(dist);
        clustMem(i) = I;
    end
    