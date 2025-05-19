function exit = Script1(path, sensitivity)
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
        % % g = lib.log_transformation(gray, 0.16, true);
        g = p.gamma_correction2(gray, 0.8, true);


        % Binarization.
        g = p.binarize(g, sensitivity, true);


        % Smoothing.
        g = p.remove_noise(g, true);


        % Return 0 for successful execution.
        exit = 0;
    else
        % Returns error for failed execution.
        fprintf('Warning: file [%s] does not exist!\n', path);
        exit = 1
    end
end
