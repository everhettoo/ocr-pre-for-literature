% Read histogram of prestine image and tampered.

pristine = imread('data/n01-pristine.jpg');
tampered = imread('data/n01-tampered.jpg');

% Convert to gray-scale.
pristine_gray = rgb2gray(pristine);
tampered_gray = rgb2gray(tampered);

figure;
subplot(1,2,1), imhist(pristine_gray); title('Pristine');
subplot(1,2,2), imhist(tampered_gray); title('Tampered');


