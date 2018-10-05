% Brian Knotten
% CS 1675
% Homework 4

% Using the Pima Indians Diabetes dataset, test KNN implementation with different
% values of K.

% Download the data file, split the data into 10 ~equally-size "folds".
% For simplicity, use folds of size 76 and drop the remaining 8 instances
% (768/10 = 76 remainder 8)

data = dlmread('pima.data', ',');
dataSize = size(diabetesData);

%Define labels and data sans label
labels = data(1:end-8, end);
data = data(1:end-8, 1:end-1);

%Divide data and labels into folds: 
foldLabels = reshape(labels, [76, 10]) %ith column corresponds to ith fold
fold1 = data(1:76, :);
fold2 = data(77:152, :);
fold3 = data(153:228, :);
fold4 = data(229:304, :);
fold5 = data(305:380, :);
fold6 = data(381:456, :);
fold7 = data(457:532, :);
fold8 = data(533:608, :);
fold9 = data(609:684, :);
fold10 = data(689:760, :);

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

for f = 1:10
  

## %Standardize
## stdFolds = folds;
## for f = 1:10
##   foldMean = mean(stdFolds(:, :, f));
##   foldStd = std(stdFolds(:, :, f));
##   stdFolds(:, :, f) = (stdFolds(:, :, f) - foldMean)./foldStd;
## end


