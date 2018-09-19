% Brian Knotten
% CS 1675
% Homework 3

% X_train = NxD feature matrix with N samples(in training set) & D feature dimensions
% y_train = Nx1 vector w/labels for the training set. The i-th sample in the y_train
% should correspond to the i-th row in X_train.
% w = Dx1 vector of weights (one per feature dimension).

[w] = lr_solve_closed(X_train, y_train)

% Compute the closed-form least-squares solution to linear regression
% using the MOore-Penrose inverse, as derived in class.
% Use pinv and one line of code