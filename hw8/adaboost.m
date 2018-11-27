% Brian Knotten
% CS1675
% Homework 8

% X_train = NxD matri of training samples, N = num training samples, D = num
%  feature dimension
% y_train = Nx1 vector of ground-truth labels for the training set
% iters = scalar defining the num of iterations of AdaBoost to run (denoted M in
%  Bishop
% X_test = MxD matrix of test samples, M = num test samples
% y_pred_final = Mx1 vector containing the final labels on the test set using
%  all iters classifiers

function [y_pred_final] = adaboost(X_train, y_train, X_test, iters)










