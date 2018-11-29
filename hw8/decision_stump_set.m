% Brian Knotten
% CS1675
% Homework 8

% X_train = NxD matrix of training samples, N = num training samples, D = num
%  feature dimension
% y_train = Nx1 vector of ground-truth labels for the training set
% w_train = Nx1 vector containing the weights of the N training samples
% X_test = MxD matrix of test samples, M = num test samples
% correct_train = Nx1 binary vector containing 1 for training samples that are
%  correctly classified by the best decision stump, and 0 for incorrectly
%  classified training samples
% y_pred = Mx1 vector containing the label predictions on the test set

% Implement a set of decision stumps in a function





function [correct_train, y_pred] = decision_stump_set(X_train, y_train, w_train, X_test)
% Get necessary dimensions
  trainSize = size(X_train);
  testSize = size(X_test);
  N = trainSize(1);
  D = trainSize(2);
  M = testSize(1);
  
  % Create a Dx10 matrix to store the thresholds of each of the 10 classifiers
  % for each dimension
  thresholds = zeros(D, 10);

  % Each decision stump will operate on a single feature dimension and use a
  % threshold over that feature dimension to make positive/negative predictions.
  % It should iterate over all feature dimensions and consider 10 ~equally
  % spaced thresholds for each feature
  
  for i = 1:D
    % Get the min and max of each dimension
    dimMax = max(X_train(:, i));
    dimMin = min(X_train(:, i));
    % Calculate the threshold step sizes
    threshStep = (dimMax-dimMin)/11;
    % Fill the threshold maxtrix
    for j = 1:10
      thresholds(i, j) = threshStep * j;
    end
  end

  % Create a Dx10x2 matrix to store the weighted accuracies of each classifier
  % The first layer of the third dimension is the accuracy when a feature value
  % >= the threshold is classified as +1, and the second layer is when the same
  % feature value is classified as -1
  wAccur = zeros(D, 10, 2);

  % If the feature value for the dimension is over/under a threshold, it is 
  % classified as positive; otherwise it is classified as negative
  
  % For each classifier (10 for each dimension)
  for i = 1:D
    for j = 1:10
      % For each sample
      for n = 1:N
	% If the feature value is above the threshold, then the classifier labels
	% the sample as 1
	if X_train(n, i) >= thresholds(i, j)
	  tempLabel = 1;
	else % It is labelled as -1
	  tempLabel = -1;
	end
	% If the label is correct, then the classifiers weight is incremented
	if tempLabel == y_train(n) 
	  wAccur(i, j, 1) = wAccur(i, j, 1) + w_train(n);
	end
      end
    end
  end
  % The weighted accuracy of the inverse (-1 if above the threshold, 1 if below)
  % is just 1 - the accuracy of 1 if above, -1 if below.
  wAccur(:, :, 2) = 1 - wAccur(:, :, 1);

  % Determine the location of the best (highest weighted accuracy
  % classifier out of all Dx10x2 by taking the max of the weighted accuracy
  % matrix
  [maxVal, index] = max(wAccur(:));
  [row, column, layer] = ind2sub(size(wAccur), index);

  % Create the column vectors to store the predicted labels and accuracy labels
  % of the best classifier 
  y_pred = zeros(M, 1);
  correct_train = zeros(N, 1);
  
  % Variable to determine what the labels above/below the threshold should be
  invert = 1;
  if layer == 2
    invert = -1;
  end

  % For each test sample, use the best classifier to predict the proper label 
  for m = 1:M
    if X_test(m, row) >= thresholds(row, column)
      y_pred(m) = 1 * invert;
    else
      y_pred(m) = -1 * invert;
    end
  end
  
  % For each training sample, use the best classifier to predict the proper label
  % and check the correctness
  for n = 1:N
    if X_train(n, row) >= thresholds(row, column)
      tempTrainLabel = 1 * invert;
      correct_train(n) = tempTrainLabel == y_train(n);
    else
      tempTrainLabel = -1 * invert;
      correct_train(n) = tempTrainLabel == y_train(n);
    end
  end
