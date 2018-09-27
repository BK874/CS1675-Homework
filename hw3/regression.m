% Brian Knotten
% CS 1675
% Homework 3

% Using the Wine Quality dataset (red wine only), find the quality score
% of some wine based on its attributes.

% Download the winequality-red.csv file, load it using dlmread and divide
% the data into a training and test set using approximately 50% for training.
% Standardize the data, by computing the mean and standard deviation for each
% feature dimension using the train set only, then subtracting the mean and dividing by stdev
% from each feature and each sample. Append a 1 for each feature vector, which
% will correspond to the bias that our model learns.

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

%Add bias
bStdTrainSet = [ones(size(stdTrainSet, 1), 1) stdTrainSet];
bStdTestSet = [ones(size(stdTestSet, 1), 1) stdTestSet];

% Find the direct closed-form solution and evaluate the accuracy on the test set,
% by computing the L2 distance between the predicted vector y_pred and the
% ground-truth vector y_test. Print the L2 error in your script, with an
% appropriate description for what is being printed; use fprintf. Include it in
% your report.
w = lr_solve_closed(bStdTrainSet, trainLabels);
y_pred = lr_predict(bStdTestSet, w);
L2 = norm(y_pred-testLabels);
fprintf('L2 error of closed form solution: %f\n', L2);
% Now compute and evaluate the gradient descent solution. Use 50 iterations,
% and experiment with the following values for the learning rate: 10.^(-6:-1).
% Evaluate the L2 distance between predicted and ground-truth test labels as above.
% Print the errors for each learning rate and include them in your report.


for ex = -6:-1
  w = lr_solve_gd(bStdTrainSet, trainLabels, 50, 10.^(ex));
  gradSol = lr_predict(bStdTestSet, w);

  L2_Grad = norm(gradSol - testLabels);
  fprintf('L2 error using gradient descent with learning rate of 10.^(%d): %f\n', ex, L2_Grad)
end




