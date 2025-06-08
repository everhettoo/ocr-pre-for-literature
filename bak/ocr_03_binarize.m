% Binarize image

clear;
clc;
close all;

% name = 'data/n01-pristine';
name = 'data/n01-tampered';

path = append(name,'','-02.jpg');

gray = imread(path);

[m,n] = size(gray);

% A high sensitivity value leads to thresholding more pixels as 
% foreground, at the risk of including some background pixels.
binary = imbinarize(gray, 'adaptive','ForegroundPolarity','dark','Sensitivity',0.45);

% reduced_size = imcrop(binary,[5,5,m+10,n+10]);

figure;
subplot(1,2,1), imshow(gray); title('original');
subplot(1,2,2), imshow(binary); title('weighted-avg');

path = append(name,'','-03.jpg');
imwrite(binary, path,'quality',100)