% Gradient calculation.

Gx = [-1 0 1
      -2 0 2
      -1 0 1];

Gy = [-1 -2 -1
       0 0 0
      1 2 1];

path = 'data/Pristine-01.jpg';

I = imread(path);
I = im2gray(I);


% 'same' ensures image border is padded with eros (white). corr() also
% available.
gradX = conv2(I, Gx, 'same');
gradY = conv2(I, Gy, 'same');


figure('NumberTitle', 'off', 'Name', 'Gradient');
subplot(1,2,1), imshow(gradY); title('Grad-X');
subplot(1,2,2), imshow(gradY); title('Grad-Y');