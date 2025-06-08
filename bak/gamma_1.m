path = 'data/Tampered-01.jpg';
sensitivity = 0.2;
% gamma = 0.9;

p = Preprocess(string(file_part(1)));
g = p.gamma_correction(gray, 1.4, true);