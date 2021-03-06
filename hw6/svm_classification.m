% Brian Knotten
% CS 1675
% Homework 6

% Using the Pima Indians Diabetes dataset, test SVM implementation with different
% values of C.

% Download the data file, split the data into 10 ~equally-size "folds".
% For simplicity, use folds of size 76 and drop the remaining 8 instances
% (768/10 = 76 remainder 8)

data = dlmread('pima.data', ',');
dataSize = size(data);

% Shuffle the data
data = data(randperm(dataSize(1)), :);

%Define labels and data sans label
labels = data(1:end-8, end);
data = data(1:end-8, 1:end-1);

%Divide data and labels into folds: 
foldLabels = reshape(labels, [76, 10]); %ith column corresponds to ith fold
foldLabels(foldLabels == 0) = -1; % Correct ground truth labels
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

%For the specified C values
svmResults = zeros(5, 1);
index = 1;
C = [0.0001, 0.001, 0.01, 0.1, 1];
for c = 1:length(C)
  ratios = zeros(10, 1);
  %For every split of the data, standardize and apply SVM
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
	trainLabels = cat(1, trainLabels, foldLabels(:, h));
      end
    end
    %Standardize
    trainDataMean = mean(trainData);
    trainDataStd = std(trainData);
    stdTrainData = (trainData - trainDataMean)./trainDataStd;
    testData = folds(:, :, f);
    stdTestData = (testData - trainDataMean)./trainDataStd;
    % Apply SVM
    splitLabels = svm_quadprog(stdTrainData, trainLabels, stdTestData, C(c));
    numLabels = size(splitLabels);
 %Compare the predicted labels and the ground truth labels
    count = 0;
    for m = 1:numLabels(1)
      if splitLabels(m) == foldLabels(m, f)
	count = count + 1;
      end
    end
    ratios(f) = count/numLabels(1);
  end
  % Calculate accuracy
  avgPerform = mean(ratios);
  svmResults(index) = avgPerform;
  index = index + 1;
end
% Print results
svmResults

%Plot results
figure
bar(svmResults)
title('Plot of SVM Accuracy per C Value')
xlabel('C')
ylabel('Accuracy')
text(1:5, svmResults, num2str(svmResults), 'HorizontalAlignment',...
     'center', 'VerticalAlignment', 'bottom')
set(gca, 'xtickLabel', [0.0001, 0.001, 0.01, 0.1, 1])
box off;
saveas(gcf, 'SVM_C_accuracy.jpg');
