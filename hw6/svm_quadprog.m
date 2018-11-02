% Brian Knotten
% CS 1675
% Homework 6

% X_train = NxD feature matrix where N is the number of training instances and D is the feature dimension
% y_train = Nx1 label vector for the training instances
% X_test = MxD feature matrix where M is the number of test instances
% C = scalar denoting the misclassification cost in an SVM
% y_pred = Mx1 label vector for the test instances

% Implement an SVM using Matlab function quadprog. 
% This function will "train" an SVM i.e. obtains the solutions for the alpha
% weights using quadprog, then computes the weight vector w from these.
% Additionally, it should compute a prediction on the test set using the test
% features

function [y_pred] = svm_quadprog(X_train, Y_train, X_test, C)

  trainSize = size(X_train);
  testSize = size(X_test);

% H is a matrix containing the pairwise multiplication of the labels of every
% two samples and the sample with its pair's transpose
  H = zeros(trainSize(1), trainSize(1));
  for i = 1:trainSize(1)
    for j = 1:trainSize(1)
      H(i, j) = Y_train(i) * Y_train(j) * X_train(i, :) * X_train(j, :)';
    end
  end

  % A column vector of -1s, the linear objective term
  f = -ones(trainSize(1), 1);
  % A and b are empty vectors, because we have no corresponding 
  A = [];
  b = [];
  % Aeq and beq is a linear equality constraint where Aeq*x = beq
  Aeq = Y_train';
  beq = 0;
  % lb and ub are the upper and lower bounds for x=alpha
  lb = zeros(trainSize(1), 1);
  ub = C * ones(trainSize(1), 1);

  % Calculate alphas using the above variables
  alphas = quadprog(H, f, A, b, Aeq, beq, lb, ub);

  % Compute the weights using the alphas
  w = zeros(trainSize(2), 1);
  for i = 1:trainSize(1)
    w = w + (alphas(i) * Y_train(i) * X_train(i, :)');
  end

  % Predict X_test's labels & correct 0s to 1s
  result = sign(X_test * w);
  result(result == 0) = 1;
  y_pred = result;
