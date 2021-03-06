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

X = [-1 -4; -3 -1; -3 -2; -2 1; -1 -1; 4 5; 1 3; 4 0; 3 2; 5 3];
Y = [1 1 1 1 1 -1 -1 -1 -1 -1];
eta = 0.1;
w = randn(1, 2);

% Compute the predicted label vector Y_pred by multiplying the weights and features
% and checking the result. Use the Matlab function sign. If the predicted label is
% 0, set it 1

Y_pred = zeros(1, 10);
for i = 1:10
  curr = sign(X(i, :) * w');
  if curr == 0
    curr = 1;
  end
  Y_pred(i) = curr;
end

% Compute the accuracy of the current prediction for each training sample.
% While the accuracy for some sample is not 1, loop as follows:

differ = (Y == Y_pred);
differInd = find(differ == 0);
ct = 1;
while ~isempty(differInd)

% Find a sample whose label is predicted innacurately. If multiple, choose randomly
% Copmute the weight update for the misclassified sample and predict all labels
% again using the new weights and check accuracy

  sel = randsample(differInd, 1);
  w = w - eta * X(sel, :) * Y_pred(sel);
  for i = 1:10
    curr = sign(X(i, :) * w');
    if curr == 0
      curr = 1;
    end
    Y_pred(i) = curr;
  end
  differ = (Y == Y_pred)
  differInd = find(differ == 0)
  Y_pred


% Use the provided plot_points_w.m function to plot the data points and the
% direction of the weight vector. Positive samples are open circles, negative
% are filled circles. Correctly classified samples are green, incorrectly
% classified samples are red. Requires you to keep an iteration counter ct and
% an index for the selected misclassified point in an iteration as sel. Name
% weights vector w, data matrix X (samples as rows), true labels vector Y,
% predicted labels Y_pred.

  plot_points_w;
  ct = ct+1;
end
