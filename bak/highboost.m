% Unsharp & high-boost
clear all;
clc;
close all;

function g = func(I, kernel)
    g = imfilter(I, kernel);
end

% Mean/Average filtr.
c = 9;
k_avg = ones(c,c);
k_avg = k_avg / (c*c);

display(k_avg);

% img = imread('bacteria_original.tif');
% img = imread(fullfile("../ipcv-images","cameraman.tif"));
img = imread(fullfile("../ipcv-images","barcode1.png"));

blur = func(img, k_avg);

% Gives edges
a = img - blur;

% Highboost
hb = img + a;


figure;
subplot(1,3,1), imshow(img);title('original')
subplot(1,3,2), imshow(a);title('edges')
subplot(1,3,3), imshow(hb);title('highboost')
