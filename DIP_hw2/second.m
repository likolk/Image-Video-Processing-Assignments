sigma = 1; %standard deviation
kernel_size = 4 * sigma;
gamma = 0.29;
img = im2double(imread('graz.png'));
figure
imshow(img);
title('Original Image');
imwrite(img, "originalgraz.jpg");
gaussian_kernel = fspecial("gaussian", [kernel_size, kernel_size], sigma);
I = fspecial('gaussian', [kernel_size, kernel_size]);
unsharp_mask_kernel =  I - gamma * gaussian_kernel + I;
% unsharp masking procedure
% J = imfilter(im2double(img), unsharp_mask_kernel);
J = imfilter(img, unsharp_mask_kernel);
figure
imshow(J);
title('Unsharp Mask Filtered Image');
J_filtered = im2uint8(J);
imwrite(J_filtered, "unsharped-mask-graz.jpg");
