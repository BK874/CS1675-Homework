% Brian Knotten
% CS 1675
% Homework 3

% X_test = MxD feature matrix w/M samples and D feature dimensions.
%   M = number of samples in the test set
% w = Dx1 vector of weights
% y_pred = predicted Mx1 vector of labels for the test set.

function [y_pred] = lr_predict(X_test, w)

% Use the weights computed in lr_solve_closed to predict a label
% for a new test sample.

  y_pred = X_test * w;
