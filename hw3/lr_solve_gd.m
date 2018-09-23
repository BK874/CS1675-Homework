% Brian Knotten
% CS 1675
% Homework 3

% X_train = NxD feature matrix with N samples(in training set) & D feature dimensions
% y_train = Nx1 vector w/labels for the training set. The i-th sample in the y_train
% should correspond to the i-th row in X_train.
% iters = number of iterations to run gradient descent for
% eta = learning rate to use in the weight update
% w = Dx1 vector of weights (one per feature dimension).

function [w] = lr_solve_gd(X_train, y_train, iters, eta)

% Implement the gradient descent solution:


% Initialize the weights using random values or all zeros

sizeX = size(X_train);
w = zeros(1, sizeX(2));

% Repeat the following iters times:
% In each iteration, compute the loss function gradient using all training data points
% You'll need to use lr_predict.m

diffY = 0;
				% For each iteration
diffY = y_train - sum(lr_predict(X_train, w));
w = w + y_train * X_train * eta;



% Adjust the weights in the opposite to the gradient
