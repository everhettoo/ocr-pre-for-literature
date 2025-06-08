% Average filter
clear all;
clc;
close all;

function g = func(I, kernel)
    g = imfilter(I, kernel);
end

I = [20 30 200 230 70 80
     20 30 200 230 70 80
     20 30 200 230 70 80
     20 30 200 230 70 80
     20 30 200 230 70 80];

% Average
% k_avg = [1 1 1
%           1 1 1
%           1 1 1];
% k_avg = k_avg / 9;

c = 3;
k_avg = ones(c,c);
k_avg = k_avg / (c*c);




display(k_avg);

filtered1 = func(I,k_avg);

% 1/9 (z1+z2...+z9)
display(filtered1);

% img = imread('bacteria_original.tif');
img = imread(fullfile("../ipcv-images","cameraman.tif"));

filtered2 = func(img, k_avg);


figure;
subplot(1,2,1), imshow(img);title('original')
subplot(1,2,2), imshow(filtered2);title('filtered')
