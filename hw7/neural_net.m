% Brian Knotten
% CS1675
% Homework 7

% Use the Wine Quality dataset from HW3 to test the neural implementation

% Load & split the wine dataset as in HW3:

wineData = dlmread('winequality-red.csv', ';', 1, 0);
wineSize = size(wineData);

%Randomly permute the data before dividing
randWine = wineData(randperm(wineSize(1)), :);

%Create training set and test set
trainSet = randWine(1:floor(end/2), 1:end-1);
testSet = randWine(floor(end/2)+1:end, 1:end-1);

%Define labels
trainLabels = randWine(1:floor(end/2), end);
testLabels = randWine(floor(end/2)+1:end, end);

%Compute mean and standard deviation of the training set's feature dimensions
trainMean = mean(trainSet);
trainStd = std(trainSet);

%Standardize data 
stdTrainSet = (trainSet - trainMean)./trainStd;
stdTestSet = (testSet - trainMean)./trainStd;

%Add bias at input
bStdTrainSet = [ones(size(stdTrainSet, 1), 1) stdTrainSet];
bStdTestSet = [ones(size(stdTestSet, 1), 1) stdTestSet];

% Set the hidden units, iterations, and learning rate.
M = 30;
iters = 1000;

for eta = 0.01:0.02:0.05


  % Construct and train the network.
  [W1, W2, error_over_time] = backward(bStdTrainSet, trainLabels, M, iters, eta);

  % Make predictions and compute root mean squared error between the predicted
  % and the ground-truth labels.
  [y_pred, Z] = forward(bStdTestSet, W1, W2);
  error = sqrt(mean((y_pred - testLabels).^2));

  fprintf('Root mean squared error with a learning rate of %.2f: %f\n', eta, error)

  % Plot
  figure
  plot(error_over_time)
  title(['Learning rate: ', num2str(eta)])
  xlabel('iteration')
  ylabel('MSE')

  % Save the figures
  filename = ['Error over time ' num2str(eta) '.jpg'];
  saveas(gcf, filename);
end



