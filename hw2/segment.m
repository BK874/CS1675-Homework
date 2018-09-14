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
imPandaR = reshape(imPandaD, H*W, 3);
imPittR = reshape(imPittD, H*W, 3);
imBirdR = reshape(imBirdD, H*W, 3);

% Use restarts.m to perform clustering over the images
[pandaIds, pandaMeans, pandaSsd] = restarts(imPandaR, 5, 5, 3);
[pittIds, pittMeans, pittSsd] = restarts(imPittR, 5, 5, 3);
[birdIds, birdMeans, birdSsd] = restarts(imBirdR, 10, 5, 3);

% Recolor the pixels of each image according to cluster memberships i.e. replace
% each pixel with the average R, G, B values of the cluster to which the pixel
% belongs.

count = 1;
for h = 1:100
    for w = 1:100
        imPandaD(w, h, :) = pandaMeans(pandaIds(count), :);
        count = count + 1;
    end
end

count = 1;
for h = 1:100
    for w = 1:100
        imPittD(w, h, :) = pittMeans(pittIds(count), :);
        count = count + 1;
    end
end

count = 1;
for h = 1:100
    for w = 1:100
        imBirdD(w, h, :) = birdMeans(birdIds(count), :);
        count = count + 1;
    end
end

imPandaU = im2uint8(imPandaD);
imPittU = im2uint8(imPittD);
imBirdU = im2uint8(imBirdD);
figure;
imshow(imPandaU);
figure;
imshow(imPittU);
figure;
imshow(imBirdU);