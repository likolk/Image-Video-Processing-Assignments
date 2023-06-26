img = im2double(imread('delicate_arch.jpg'));

Applying a Billateral filter to an image multiple times results in a similar result to applying one bigger Billateral filter

% Apply big bilateral filter with small degrees of smoothing and spatial sigma
big_dos = 6;
big_spatial_sigma = 6; 
img_big = imbilatfilt(img, big_dos, big_spatial_sigma);
figure;
imshow(img_big);
title('Big Filter');
imwrite(img_big, "big-filter.jpg");

% Apply small bilateral filter iteratively with large degree of smoothing and spatial sigma
small_dos = 2.0;
small_spatial_sigma = 2.0;
num_iters = 5;
for i = 1:num_iters
    img_small = imbilatfilt(img, small_dos, small_spatial_sigma);
    img = img_small;
end
figure
imshow(img_small);
title("Small Filter");
imwrite(img_small, "small-filter.jpg");
