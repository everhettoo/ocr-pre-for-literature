% Script work well with pristine.
% path = 'data/Pristine-01.jpg';
path = 'data/dataset03/03/tampered-o.jpg';

sensitivity = 0.2;
gamma = 0.9;


% Clear screen and close previous executions.
clc;
close all;

fprintf('[Info] Path: %s\n', path);
fprintf('[Info] Sensitivity: %f\n', sensitivity);

if exist(path, 'file')
    file_part = strsplit(path,'.');

    % Initialize preprocessing class with filename (without ext) to 
    % write output with process name surfix for each stage.
    p = Preprocess(string(file_part(1)));

    I = imread(path);
    gray = rgb2gray(I);

    % Contrast adjustment.
    % g = p.log_transformation(gray, sensitivity, true);
    g = p.gamma_correction(gray, gamma, true);

    % Binarization.
    g = p.binarize_otsu(g, true);

    % Smoothing.
    g = p.remove_noise(g, true);
    % 
    % % dilate. 
    % g = p.dilate(g, 'cube', 2, true);
    % 
    % g = p.open(g, 'cube',6, true);

    % Sharpening. 
    g = p.sharpening(g, true);

    g = p.remove_median_noise(g,[3 3],true);

    % Return 0 for successful execution.
    exit = 0;
else
    % Returns error for failed execution.
    fprintf('Warning: file [%s] does not exist!\n', path);
    exit = 1
end

