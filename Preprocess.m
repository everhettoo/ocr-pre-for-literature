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

        function g = binarize_otsu(obj, f, display_figure)
            % A high sensitivity value leads to thresholding more pixels as 
            % foreground, at the risk of including some background pixels.
            [count, x ] = imhist(f,16);
            T = otsuthresh(count);
            g = imbinarize(f, T); 

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

        function s = gamma_correction(obj, f, gamma, display_figure)
            s = imadjust(f,[],[],gamma);

            % Display result.
            trace_result(obj, f, s, "gamma", display_figure);          
        end

        function s = remove_noise(obj, f, display_figure)
            s = medfilt2(f, [3,3], 'symmetric');

            % Display result.
            trace_result(obj, f, s, "smooth", display_figure);          
        end

        function s = remove_noise5(obj, f, size, display_figure)
            s = medfilt2(f, [3,3], 'symmetric');

            % Display result.
            trace_result(obj, f, s, "smooth", display_figure);          
        end

        function s = remove_noise2(obj, f, display_figure)            
            % Asymmetric filter (weigted in the middle).
            % filter = [1 4 1
            %           4 7 4
            %           1 4 1];

             filter = [1 2 4 2 1
                       2 3 8 3 2
                       4 8 10 8 4
                       2 3 8 3 2
                       1 2 4 2 1];

            % Constant
            c = 15;

            filter = filter / c;

            % By default it is correlation filter.
            s = imfilter(f, filter);

            % Display result.
            trace_result(obj, f, s, "smooth", display_figure);          
        end

        function s = remove_noise3(obj, f, display_figure)            
            % Asymmetric filter (weigted in the middle).
            % filter = [1 4 1
            %           4 7 4
            %           1 4 1];

            %  filter = [1 2 4 2 1
            %            2 3 6 3 2
            %            4 6 8 6 4
            %            2 3 6 3 2
            %            1 2 4 2 1];
            % 
            % s = ordfilt2(f,5,filter);

            s = wiener2(f,[5 5]);

            % Display result.
            trace_result(obj, f, s, "smooth", display_figure);          
        end

        function s = sharpening(obj, f, display_figure)
            % without img substraction (simplified laplacian).
            lap = [0 -1 0
                   -1 5 -1
                   0 -1 0];
            
            % Create laplacian filtered image then minus original with laplacian.
            s = conv2(f,lap,'same');

            % Display result.
            trace_result(obj, f, s, "sharp", display_figure);          
        end

        % Placeholder - Smoothing filters

        function s = remove_adaptive_noise(obj, f, filter_size, display_figure)            
            s = wiener2(f,filter_size);

            % Display result.
            trace_result(obj, f, s, "adaptive", display_figure);          
        end

        function s = remove_median_noise(obj, f, filter_size, display_figure)
            s = medfilt2(f, filter_size, 'symmetric');

            % Display result.
            trace_result(obj, f, s, "median", display_figure);          
        end


        function s = dilate(obj, f, shape, r, display_figure)
            se = strel(shape, r);
            s = imdilate(f, se);

            % Display result.
            trace_result(obj, f, s, "dilate", display_figure);   
        end

        function s = erode(obj, f, shape, r, display_figure)
            se = strel(shape, r);
            s = imerode(f, se);

            % Display result.
            trace_result(obj, f, s, "erode", display_figure);   
        end

        function s = open(obj, f, shape, r, display_figure)
            se = strel(shape, r);
            s = imopen(f, se);

            % Display result.
            trace_result(obj, f, s, "open", display_figure);   
        end

        function s = close(obj, f, shape, r, display_figure)
            se = strel(shape, r);
            s = imclose(f, se);

            % Display result.
            trace_result(obj, f, s, "close", display_figure);   
        end

    end
end