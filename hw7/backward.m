% Brian Knotten
% CS1675
% Homework 7

% X = NxD feature matrix where N is the number of samples and D is the number of feature dimensions
% y = Nx1 vector containing the ground-truth labels for the N samples
% M = scalar indicating the number of hidden neurons to use
% iters = scalar indicating the number of iterations to run (one sample used in each)
% eta = scalar indicating the learning rate to use
% W1 = MxD weight matrix between the first and second layer of the network, where M is the number of hidden neurons
% W2 = 1xM weight matrix between the second and third layer of the network, where there is a single neuron at the output layer
% error_over_time = iters x 1 vector that contains the error on the sample used in each iteration

function [W1, W2, error_over_time] = backward(X, y, M, iters, eta)

  % Get necessary dimensions
  XSize = size(X);
  N = XSize(1);
  D = XSize(2);
  
  % Initialize weights
  W1 = rand(M, D)/10;
  W2 = rand(1, M)/10;

  % Initialize the error for each iteration
  error_over_time = zeros(iters);
  
  
  for iter = 1:iters
    % Pick a random sample
    sample = randi(N);

    % Perform forward propogation p
    [predOutput, Z] = forward(X, W1, W2);

    % Compute error at output
    outputErr = predOutput(sample) - y(sample);
    error_over_time(iter) = abs(outputErr);
    
    % Backpropogate to the hidden layer
    interW2 = zeros(1, M); % To store weights temporarily
    interW1 = zeros(M, D);

    % Multiply the activations for this sample for all neurons by the
    % error for this sample and the learning rate i.e. multiply the
    % learning rate by the derivative of the Error function
    lrDeriv = eta * outputErr * Z(sample, :);
    % Subtract this from the current weights to calculate the new weights
    interW2 = W2 - lrDeriv;

    % Compute the error at the hidden layer
    % Square the hidden layer's activations, subtract it from 1, and multiply
    % the result by the weights from the hidden layer to the output layer and
    % the output's error
    hiddenErr = (1 - (Z(sample, :).^2)) .* (W2 * outputErr);

    % Backpropogate to the input layer
    % Subtract the learning rate mulitiplied by the transpose of the 
    % hidden layer's error times the current sample
    interW1 = W1 - (eta * (hiddenErr' * X(sample, :)));

    % Update weights
    W1 = interW1;
    W2 = interW2;
  end
  
