% Brian Knotten
% CS 1675
% Homework 7

% X = NxD feature matrix where N is the number of samples and D is the number of feature dimensions
% W1 = MxD weight matrix between the first and second layer of the network, where M is the number of hidden neurons
% W2 = 1xM weight matrix between the second and third layer of the network, where there is a single neuron at the output layer
% y_pred = Nx1 vector containing the outputs at the last layer for all N samples
% Z = NxM matrix containing the activations for all M hidden neurons of all N samples

function [y_pred, Z] = forward(X, W1, W2)

  % Get necessary dimensions
  XSize = size(X);
  W1Size = size(W1);
  N = XSize(1);
  D = XSize(2);
  M = W1Size(1);
  
  % Create the matrix to store the activation of each sample 
  Z = zeros(N, M);
  y_pred = zeros(N, 1);
  
  % Calculate the activations of the hidden layer
  for i = 1:N % For each sample
    for j = 1:M % For each neuron
      % The activation is a linear combination (dot product) of that sample's
      % feature dimensions and that neuron's dimension's weights passed into
      % the activation function (tanh)
      Z(i, j) = tanh(dot(X(i, :), W1(j, :)));
    end
  end

  % Calculate the activation of the output layer
  for n = 1:N % For each sample
  % The outputs are the dot product of the hidden layer's output unit
  % activations and the weights between the hidden and output layers
    y_pred(n) = dot(Z(n, :), W2); 
  end
