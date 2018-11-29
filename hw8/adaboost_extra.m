% Brian Knotten
% CS1675
% Homework 8

% X_train = NxD matrix of training samples, N = num training samples, D = num
%  feature dimension
% y_train = Nx1 vector of ground-truth labels for the training set
% iters = scalar defining the num of iterations of AdaBoost to run (denoted M in
%  Bishop
% X_test = MxD matrix of test samples, M = num test samples
% y_pred_final = Mx1 vector containing the final labels on the test set using
%  all iters classifiers

function [y_pred_final] = adaboost_extra(X_train, y_train, X_test, iters)
  
  % Get necessary dimensions
  trainSize = size(X_train);
  testSize = size(X_test);
  N = trainSize(1);
  D = trainSize(2);
  M = testSize(1);

  % Initialize weights, alpha vector, and X_test prediction matrix
  weights = zeros(N, 1) + 1/N; 
  alpha = zeros(iters, 1);
  testPred = zeros(M, iters);
  for it = 1:iters
    % Determine best decision stump and retrieve its predictions and training
    % accuracies
    [correct_train, y_pred] = decision_stump_set(X_train, y_train, weights, X_test);
    testPred(:, it) = y_pred;
    % Switch the accuracies for the indicator function and calculate epsilon
    % and alpha
    incorrect_train = abs(correct_train - 1);
    epsilon = sum(weights .* incorrect_train)/sum(weights);
    alpha(it) = log((1-epsilon)/epsilon);
    % If alpha is less than 0, discard the current iteration
    if alpha(it) < 0
      testPred(:, it) = y_pred;
    end
    
    % Update the weights and normalize
    weights = weights .* exp(alpha(it) .* incorrect_train);
    weights = weights / sum(weights);
  end
  
% Make final predictions
  prod = alpha' .* testPred;
  y_pred_final = sign(sum(prod, 2));
  y_pred_final(~y_pred_final) = 1;
  





