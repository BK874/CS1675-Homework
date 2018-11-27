% Brian Knotten
% CS1675
% Homework 8

% X_train = NxD matri of training samples, N = num training samples, D = num
%  feature dimension
% y_train = Nx1 vector of ground-truth labels for the training set
% w_train = Nx1 vector containing the weights of the N training samples
% X_test = MxD matrix of test samples, M = num test samples
% correct_train = Nx1 binary vector containing 1 for training samples that are
%  correctly classified by the best decision stump, and 0 for incorrectly
%  classified training samples
% y_pred = Mx1 vector containing the label predictions on the test set

function [correct_train, y_pred] = decision_stump_set(X_train, y_train, w_train,
						       X_test)
  




