img = im2double(imread('delicate_arch.jpg'));
% Define standard deviations of two Gaussian filters
gamma = .5;
t = 5;
% apply first gaussian filter with standard deviation gamma
img_first_filter = imgaussfilt(img, gamma);
% second
img_second_filter = imgaussfilt(img_first_filter, t);
figure
imshow(img_second_filter);
title("2 gaussian filters image");
imwrite(img_second_filter, "two-gaussian-filters.jpg");
% One gaussian filter with bigger sigma parameter
figure
sigma = sqrt(gamma^2 + t^2);
img_bigger_sigma = imgaussfilt(img, sigma);
imshow(img_bigger_sigma);
title('Gaussian Filtered Image with bigger σ');
imwrite(img_bigger_sigma, "bigger-sigma.jpg");
