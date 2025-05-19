% Remove median noise?

clear;
clc;
close all;

% name = 'data/n01-pristine';
name = 'data/n01-tampered';

path = append(name,'','-01.jpg');

gray = imread(path);

[m,n] = size(gray);
fprintf('Info: M=%d, N=%d.',m,n);

% Asymmetric filter (weigted in the middle).
filter = [1 2 1
          2 4 2
          1 2 1];

% Constant
c = 15;

filter = filter / c;

% By default it is correlation filter.
smoothed = imfilter(gray, filter);

figure;
subplot(1,2,1), imshow(gray); title('original');
subplot(1,2,2), imshow(smoothed); title('weighted-avg');

path = append(name,'','-02.jpg');
imwrite(smoothed, path,'quality',100)