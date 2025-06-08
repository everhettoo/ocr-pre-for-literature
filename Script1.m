% This script does not peform morphological operation
% Sample run with parameters for gamma is 0.75.

function exit = Script1(path, gamma)
    % Clear screen and close previous executions.
    clc;
    close all;

    fprintf('[Info] Path: %s\n', path);

    if exist(path, 'file')
        file_part = strsplit(path,'.');

        % Initialize preprocessing class with filename (without ext) to 
        % write output with process name surfix for each stage.
        p = Preprocess(string(file_part(1)));

        I = imread(path);
        gray = rgb2gray(I);

        % Contrast adjustment.
        g = p.gamma_correction(gray, str2double(gamma), true);
        
        % Binarization.
        g = p.binarize_otsu(g, true);

        % Smoothing.
        g = p.remove_noise(g, true);

        % Sharpening. 
        g = p.sharpening(g, true);

        % Return 0 for successful execution.
        exit = 0;
    else
        % Returns error for failed execution.
        fprintf('Warning: file [%s] does not exist!\n', path);
        exit = 1;
    end
end
