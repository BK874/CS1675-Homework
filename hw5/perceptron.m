% Brian Knotten
% CS 1675
% Homework 5

% Trace through a run of the perceptron algorithm given two-dimensional data:
% {(-1,-4), (-3,-1), (-3,-2), (-2,1), (-1,-1), (4,5), (1,3), (4,0), (3,2), (5,3)}
% The first fiv data points are the positive class, the second 5 are the negative
% Create figures similar to Figure 4.7 in Bishop
% No basis function: use φ(x) = x

% First, represent the data and labels with samples as the rows and features
% (coordinates) as the columns. All data will be used for training (we aren't
% testing) - will visualize whath te method is learning. Learning rate η=0.1.
% Initialize the weight vector to a vector of random numbers.



% Compute the predicted label vector Y_pred by multiplying the weights and features
% and checking the result. Use the Matlab function sign. If the predicted label is
% 0, set it 1



% Compute the accuracy of the current prediction for each training sample.
% While the accuracy for some sample is not 1, loop as follows:



% Find a sample whose label is predicted innacurately. If multiple, choose randomly
% Copmute the weight update for the misclassified sample and predict all labels
% again using the new weights and check accuracy



% Use the provided plot_points_w.m function to plot the data points and the
% direction of the weight vector. Positive samples are open circles, negative
% are filled circles. Correctly classified samples are green, incorrectly
% classified samples are red. Requires you to keep an iteration counter ct and
% an index for the selected misclassified point in an iteration as sel. Name
% weights vector w, data matrix X (samples as rows), true labels vector Y,
% predicted labels Y_pred.



