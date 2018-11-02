% Brian Knotten
% CS 1675
% Homework 4

% Using the Pima Indians Diabetes dataset, test KNN implementation with different
% values of K.

% Download the data file, split the data into 10 ~equally-size "folds".
% For simplicity, use folds of size 76 and drop the remaining 8 instances
% (768/10 = 76 remainder 8)

data = dlmread('pima.data', ',');
dataSize = size(data);

%Define labels and data sans label
labels = data(1:end-8, end);
data = data(1:end-8, 1:end-1);

%Divide data and labels into folds: 
foldLabels = reshape(labels, [76, 10]); %ith column corresponds to ith fold
fold1 = data(1:76, :);
fold2 = data(77:152, :);
fold3 = data(153:228, :);
fold4 = data(229:304, :);
fold5 = data(305:380, :);
fold6 = data(381:456, :);
fold7 = data(457:532, :);
fold8 = data(533:608, :);
fold9 = data(609:684, :);
fold10 = data(685:760, :);

%create multi-dim array for ease of access
folds = fold1;
folds = cat(3, folds, fold2);
folds = cat(3, folds, fold3);
folds = cat(3, folds, fold4);
folds = cat(3, folds, fold5);
folds = cat(3, folds, fold6);
folds = cat(3, folds, fold7);
folds = cat(3, folds, fold8);
folds = cat(3, folds, fold9);
folds = cat(3, folds, fold10);

%For the specified K values
knnResults = zeros(8, 1);
index = 1;
for K = 1:2:15
  ratios = zeros(10, 1);
  wRatios = zeros(10, 3);
  %For every split of the data, standardize and apply KNN
  for f = 1:10
    if f ~= 1
      trainData = folds(:, :, 1);
      trainLabels = foldLabels(:, 1);
      for g = setdiff(2:10, f)
	trainData = cat(1, trainData, folds(:, :, g));
	trainLabels = cat(1, trainLabels, foldLabels(:, g));
      end
    else %Edge Case split on 1 - - - - - - - - - - - - - - - - - - - - - -
      trainData = folds(:, :, 2);
      trainLabels = foldLabels(:, 2);
      for h = 3:10
	trainData = cat(1, trainData, folds(:, :, h));
	trainLabels = cat(1, trainLabels, folds(:, h));
      end
    end
    %Standardize
    trainDataMean = mean(trainData);
    trainDataStd = std(trainData);
    stdTrainData = (trainData - trainDataMean)./trainDataStd;
    testData = folds(:, :, f);
    stdTestData = (testData - trainDataMean)./trainDataStd;
    %Apply KNN
    splitLabels = my_knn(stdTrainData, trainLabels, stdTestData, K);
    numLabels = size(splitLabels);
    weightedLabels = zeros(numLabels(1), 3);
    weightedLabels(:, 1) = weighted_knn(stdTrainData, trainLabels, stdTestData, 0.5);
    weightedLabels(:, 2) = weighted_knn(stdTrainData, trainLabels, stdTestData, 0.9);
    weightedLabels(:, 3) = weighted_knn(stdTrainData, trainLabels, stdTestData, 1.3);
    %Compare the predicted labels and the ground truth labels
    count = 0;
    for m = 1:numLabels(1)
      if splitLabels(m) == foldLabels(m, f)
	count = count + 1;
      end
      for w = 1:3
	wCount = 0;
	if weightedLabels(m, w) == foldLabels(m, f)
	  wCount = wCount + 1;
	end
	wRatios(f, w) = wCount/numLabels(1);
      end
    end
    ratios(f) = count/numLabels(1);
  end
  avgPerform = mean(ratios);
  wAvgPerform1 = mean(wRatios(:, 1));
  wAvgPerform2 = mean(wRatios(:, 2));
  wAvgPerform3 = mean(wRatios(:, 3));
  knnResults(index) = avgPerform;
  index = index + 1;
end
wKnnResults =[wAvgPerform1, wAvgPerform2, wAvgPerform3]
knnResults

%Plot results
figure
plot(1:2:15, knnResults)
title('Plot of KNN Accuracy per K Value')
xlabel('K')
ylabel('Accuracy')

figure
plot([10, 5, 1], wKnnResults)
title('Plot of Weighted KNN Accuracy per Sigma Value')
xlabel('Sigma')
ylabel('Accuracy')

