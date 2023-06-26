original_img = imread('ferrari.JPG');
figure
imshow(original_img);
% linearization
linear_img = double(original_img)/255;
figure
imshow(linear_img);

gamma = 2.2;
gamma_correction = linear_img .^(1/gamma);

% brightness increase
bright_enhanced = linear_img * 2.5;
figure
imshow(bright_enhanced);

% contrast enhancement 
a = 90;
b = 0.5;
% contrast = constant * (exp(alpha * img) - beta)
contrast_enhanced = 2 * exp(a*(linear_img - b));
figure
imshow(contrast_enhanced);


