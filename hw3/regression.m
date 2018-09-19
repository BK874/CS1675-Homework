% Brian Knotten
% CS 1675
% Homework 3

% Using the Wine Quality dataset (red wine only), find the quality score
% of some wine based on its attributes.

% Download the winequality-red.csv file, load it using dlmread and divide
% the data into a training and test set using approximately 50% for training.
% Standardize the data, by computing the mean and standard deviation for each
% feature dimension using the train set only, then subtracting the mean and stdev
% from each feature and each sample. Append a 1 for each feature vector, which
% will correspond to the bias that our model learns.



% Find the direct closed-form solution and evaluate the accuracy on the test set,
% by computing the L2 distance between the predicted vector y_pred and the
% ground-truth vector y_test. Print the L2 error in your script, with an
% appropriate description for what is being printed; use fprintf. Include it in
% your report.



% [5 pts] Now compute and evaluate the gradient descent solution. Use 50 iterations,
% and experiment with the following values for the learning rate: 10.^(-6:-1).
% Evaluate the L2 distance between predicted and ground-truth test labels as above.
% Print the errors for each learning rate and include them in your report.



