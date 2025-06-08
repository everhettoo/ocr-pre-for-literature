% Remove salt-n-pepper noise using median filter.

clear;
clc;
close all;


g = smooth_gray(filter)

% name = 'data/n01-pristine';
name = 'data/n01-tampered';

path = append(name,'','.jpg');
I = imread(path);
gray = rgb2gray(I);

[m,n] = size(gray);
fprintf('Info: M=%d, N=%d.',m,n);

smoothed = medfilt2(gray,[3,3],'symmetric');

figure;
subplot(1,2,1), imshow(gray); title('original');
subplot(1,2,2), imshow(smoothed); title('removed-salt-n-pepper');


path = append(name,'','-01.jpg');
imwrite(smoothed, path,'quality',100)