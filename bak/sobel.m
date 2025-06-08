% Unsharp & high-boost
clear all;
clc;
close all;

function g = func(I, kernel)
    g = imfilter(I, kernel);
end

% Mean/Average filtr.
f1 = [-1 -2 -1
       0 0 0
       1 2 1];

f2 = [-1 0 1
      -2 0 2
      -1 0 1];


% img = imread('bacteria_original.tif');
% img = imread(fullfile("../ipcv-images","cameraman.tif"));
img = imread(fullfile("../ipcv-images","barcode1.png"));

edges1 = uint8(func(double(img), f1));
edges2 = uint8(func(double(img), f2));

% Gives edges
result = uint8(edges1 + edges2);

figure;
subplot(1,3,1), imshow(edges1);title('original')
subplot(1,3,2), imshow(edges2);title('edges')
subplot(1,3,3), imshow(result);title('highboost')
