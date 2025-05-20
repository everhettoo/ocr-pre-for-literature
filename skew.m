clc;
clear all;
close all;

k = imread('data/Pristine-00.jpg');
imshow(k);

sam = k;
m = imadjust(rgb2gray(k));
[r,c] = size(k);

BW = edge(m,'canny');

[H,T,R] = hough(BW);
imshow(H, [], 'XData', T, 'YData', R, 'InitialMagnification','fit');

xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

P = houghpeaks(H, 1, 'threshold', ceil(0.9*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));

plot(x, y, 's', 'color', 'white');

lines = houghlines(BW, T, R, P, 'FillGap', 0.8*c, 'MinLength',40);

figure, imshow(k), hold on
for k = 1: length(lines)
    xy = [lines(k).point1, lines(k).point2];
    plot(xy(:,1), xy(:, 2), 'LineWidth', 5, 'Color','green');
end

figure;
if(lines.theta<0)
    g = imrotate(m, (90-abs(lines.theta)));
else
    g =(imrotate(m, lines.theta - 90));
end

subplot(1,2,1);
imshow(sam);
subplot(1,2,2);imshow(g);
