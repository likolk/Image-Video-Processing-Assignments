img = ones(1024, 1024, 3);
width = 450;
height = 450;
centerX = size(img, 2) / 2;
centerY = size(img, 1) / 2;
left = round(centerX - width / 2);
right = round(centerX + width / 2);
top = round(centerY - height / 2);
bottom = round(centerY + height / 2);
img(top:bottom, left:right, :) = 0;
figure;
% img = im2gray(img);
imshow(img);
imwrite(img, "original-img.png");
title("Original Image")

% Define the standard deviation of the Gaussian filter in the spatial domain
sigma_spatial = 100;
% Define the size of the filter
filter_size = [1024, 1024];
% Compute the standard deviation of the Gaussian filter in the frequency domain
sigma_freq = 1 / (2 * sigma_spatial * pi);
% Perform spatial domain Gaussian filtering using imgaussfilt
img_spatial_filtered = imgaussfilt(img, sigma_spatial);
figure;
imshow(img_spatial_filtered);
imwrite(img_spatial_filtered, "spatial_filtered_image.png");
title(sprintf('Spatially Filtered Image with σ_s = %0.2f', sigma_spatial));


% frequency domain Gaussian filtering using point-wise multiplication

tmp_img = img;

figure;



for k = 1:3
    tmp_img(:, : , k) = applygaussianfilter(tmp_img(:,:,k), sigma_spatial, top, bottom, left, right);
end


imshow(img_spatial_filtered)
imwrite(img_spatial_filtered, "frequency_domain_gaussian_filtered_image.png");
% figure;
% imshow(tmp_img);
% title(sprintf("test "));

function c = applygaussianfilter(channel, sigma_spatial, top, bottom, left, right)

gaussian_filter = exp(-((channel(top:bottom, left:right) .^2 ) / ( 2 * sigma_spatial * sigma_spatial))) ;
size(gaussian_filter)
%     gaussian_filter = gaussian_filter / sum(gaussian_filter);
%     gaussian_filter = reshape(gaussian_filter, [ ]);
new_filter = ones(size(channel));
new_filter(top:bottom, left:right) = gaussian_filter;
%     gaussian_filter = padarray(gaussian_filter, [287 287], 1);

size(gaussian_filter)
c = channel .* new_filter;
end


