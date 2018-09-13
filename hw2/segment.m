% Brian Knotten
% CS 1675
% Homework 2

% Read in images and convert them to double:
imPanda = imread('panda.jpg');
imPitt = imread('pittsburgh.png');
imBird = imread('cardinal.jpg');

imPandaD = im2double(imPanda);
imPittD = im2double(imPitt);
imBirdD = im2double(imBird);

% Downsample images
imPandaD = imresize(imPandaD, [100 100]);
imPittD = imresize(imPittD, [100 100]);
imBirdD = imresize(imBirdD, [100 100]);

% Convert 3D matrix to 2D matrix
H = 100;
W = 100;
imPandaD = reshape(imPandaD, H*W, 3);
imPittD = reshape(imPittD, H*W, 3);
imBirdD = reshape(imBirdD, H*W, 3);

% Use restarts.m to perform clustering over the images
[pandaIds, pandaMeans, pandaSsd] = restarts(imPandaD, 5, 10, 5);
[pittIds, pittMeans, pittSsd] = restarts(imPittD, 5, 10, 5);
[birdIds, birdMeans, birdSsd] = restarts(imBirdD, 5, 10, 5);

% Recolor the pixels of each image according to cluster memberships i.e. replace
% each pixel with the average R, G, B values of the cluster to which the pixel
% belongs. 