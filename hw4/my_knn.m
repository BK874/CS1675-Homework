% Brian Knotten
% CS 1675
% Homework 4

% X_train = NxD feature maxtrix where N is the number of training instances and D is the feature dimension
% y_train = Nx1 label vector for the training instances
% X_test = MxD feature matrix where M is the number of test instances
% K = scalar
% y_test = Mx1 predicted label vector for the test instances

function [y_test] = my_knn.m(X_train, y_train, X_test, K)

% For each test instance, compute its distance to all training instances,
% pick the closest K training instances, pick the most common among their labels,
% and return it as the label for that test instance. Use pdist2

%Calculate distances:

%  dists = pdist(X_train, X_test,'euclidean'Smallest', K);
  dists = pdist2(X_train, X_test); %returns NxM matrix where dists[i,j] = distance from the jth test instance to the ith training instance
  
%Find the closest K instances and store them in a MxK matrix; nearest[i,j] = the distance to ith test instance's jth closest training instance
  testSize = size(X_test);
  nearest = zeros(testSize(1), K);
  for col = 1:testSize(1)
    nearest(col, :) = mink(dists(:, col), K);
  end

%Retreive the labels for each of the K instances
  
  nearestLabels = zeros(testSize(1), K);
  for i = 1:testSize(1)
    for j = 1:K
      myMax = max(nearest(i, j));
      loc = find(dists(:, i) == myMax);
      nearestLabels(i, j) = y_train(loc(1));
    end
  end

%Determine the test labels by taking the mode of each row of nearest labels
  y_test = zeros(testSize(1), 1);
  for r = 1:testSize(1)
    y_test(r) = mode(nearestLabels(r, :));
  end
  
		       
