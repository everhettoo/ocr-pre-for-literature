classdef Preprocess
    % A class that wraps underlying image processing techniques to 
    % facilitate the OCR preprocessing.
    properties
        % The source image filename (without ext) is stored for writing
        % output image for each process.
        filename
    end

    methods
        function obj = Preprocess(filename)
            obj.filename = filename;
        end
    end

    methods
        function trace_result(obj, a, b, fig_title, display_figure)  
            if display_figure
                figure('NumberTitle', 'off', 'Name', fig_title);
                subplot(1,2,1), imshow(a); title('source');
                subplot(1,2,2), imshow(b); title('modified');
            end

            % Formats path from base filename.
            path = string(compose('%s-%s.jpg', obj.filename, fig_title));
            imwrite(b, path,'quality',100)
        end

        function g = binarize(obj, f, sensitivity, display_figure)
            % A high sensitivity value leads to thresholding more pixels as 
            % foreground, at the risk of including some background pixels.
            g = imbinarize(f, 'adaptive','ForegroundPolarity','dark','Sensitivity',sensitivity); 

            % Display result.
            trace_result(obj, f, g, "binarize", display_figure);        
        end


        % C scaling factor for the output image.
        function s = log_transformation(obj, f, c, display_figure)
            % Convert for fraction processing.
            r = double(f);
            
            % Performing log transformation
            s = c * log10(1 + r);

            % Display result.
            trace_result(obj, f, s, "log", display_figure);  
        end

        function s = gamma_correction2(obj, f, gamma, display_figure)
            s = imadjust(f,[],[],gamma);

            % Display result.
            trace_result(obj, f, s, "gamma", display_figure);          
        end

        function s = remove_noise(obj, f, display_figure)
            s = medfilt2(f, [5,5], 'symmetric');

            % % Asymmetric filter (weigted in the middle).
            % % filter = [1 4 1
            % %           4 7 4
            % %           1 4 1];
            % 
            %  filter = [1 2 4 2 1
            %            2 3 6 3 2
            %            4 6 8 6 4
            %            2 3 6 3 2
            %            1 2 4 2 1];
            % 
            % % Constant
            % c = 15;
            % 
            % filter = filter / c;
            % 
            % % By default it is correlation filter.
            % s = imfilter(f, filter);

            % Display result.
            trace_result(obj, f, s, "smooth", display_figure);          
        end

    end
end