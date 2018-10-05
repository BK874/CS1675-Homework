% Brian Knotten
% CS 1675
% Homework 4

% X_train = NxD feature maxtrix where N is the number of training instances and D is the feature dimension
% y_train = Nx1 label vector for the training instances
% X_test = MxD feature matrix where M is the number of test instances
% sigma = bandwidth of the Gaussian
% y_test = Mx1 predicted label vector for the test instances

function [y_test] = weighted_knn(X_train, y_train, X_test, sigma)

% Use all neighbors to make a prediction on the test set, but weigh them according
% to their distance to the test sample

%Label of each test instance = max(sum(w_i * y_i)) where y_i is in the currently considered class (label)
%Weight of the ith sample = exp(-dist(x-x_i)^2/sigma^2)

%Calculate distances:
  dists = pdist2(X_train, X_test); %returns NxM matrix where dists[i,j] = distance from the jth test instance to the ith training instance

%Create matrix of weights using the distance matrix; NxM matrix where weight[i,j] =
%weight from the jth test instance to the ith training instance
  weights = exp((-(dists).^2)/sigma^2);

%Create matrix of weighted distances; NxM matrix where wDists[i,j] =
%weighted distance from the jth test instance to the ith training instance
  wDists = dists .* weights;

%Determine the label for each test instance by finding the max of the sums of each
%label's weighted distances
  testSize = size(X_test);
  trainSize = size(X_train);
  y_test = zeros(testSize(1),1);
  %For each test instance, for each training instance, if that sample's label is x, then add that instance's weighted distance to the xSum 
  uni = unique(y_train);
  numUni = size(uni);
  for r = 1:testSize(1)
    labelSums = zeros(numUni(1), 1);
    for inst = 1:trainSize(1)
      for lab = 1:numUni(1)
	if y_train(inst) == uni(lab)
	  labelSums(lab) = labelSums(lab) + wDists(inst, r);
	end
      end
    end
    [maxVal, maxInd] = max(labelSums);
    y_test(r) = uni(maxInd);
  end
  
  
