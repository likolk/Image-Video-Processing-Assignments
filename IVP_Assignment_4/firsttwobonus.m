img = imread('queen.jpg');
cielab_img = rgb2lab(img);
labImage2D = reshape(cielab_img, [], 3);
k = 7; 
[idx, ~] = kmeans(labImage2D, k);
cl_col = zeros(k, 3);
for i = 1:k
    clusterColors = labImage2D(idx == i, :);
    cl_col(i, :) = mean(clusterColors);
end
cl_col_rgb = lab2rgb(cl_col);
% 1xnumber of clusters array
colorFilters = cell(1, k);
for i = 1:k
    colorFilter = zeros(size(img));
    colorFilter(repmat(idx == i, [1 1 3])) = img(repmat(idx == i, [1 1 3]));
    colorFilters{i} = colorFilter;
end

gamma = 2.2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START WHITE BALANCE CODE RETRIEVED FROM ASSIGNMENT 1
img = imread('cod4.jpg');
figure;
imshow(img);
imwrite(img, "Original_white_balance.jpg");
title("Original-white-balance.jpg");
% apply gamma correction, but first normalize.
linear_image = double(img)/255;
gamma = 2.2;
linear_image = linear_image .^ gamma;
% pixel correction: Select a pixel that should be gray -> use ginput(1) to
% get a cursor that will allow us to pick a pixel from the image. if we
% dont pass as param 1, then we are not able choose any pixel.
gray_pixel = ginput(1);
% round down or up to the nearest integer. float and ceil do not work properly in this scenario as another pixel is very probable to be chosen than the one we want to.
gray_pixel = round(gray_pixel);
% Calciulate per-channel gain: get the gains for each color channel
% calculate the average value of the color channels of the chosen pixel
gray_value = mean(linear_image(gray_pixel(2), gray_pixel(1), :));
% linear_image is a 3D matrix containing the R G B values, gray_pixel
% containing the coords x, y of our pixel choice, in this case at coords x
% = 2, y = 1
% linear_image(gray_pixel(2), gray_pixel(1), :) selects the three color channels at the specified pixel location.
% interpolate the color of the neighbors of the chosen pixel.
neighboring_pixels = linear_image(gray_pixel(2)-1:gray_pixel(2)+1, gray_pixel(1)-1:gray_pixel(1)+1, :);
% Calculate avg of neighboring pixels.
channel_means = mean(mean(neighboring_pixels, 1), 2);
channel_means = channel_means(:)'; % transpose their average.
% compute gain for each channel by applying a division on all elements of the gray value by the chanel means
gains = gray_value ./ channel_means;
% convert to column vector
gains = reshape(gains, [1, 1, 3]);
% apply color correction gain to each color channel
balanced_image = zeros(size(linear_image)); % create a 3d matrix of 0s. this shall be filled.
% for each of the color channels RBG
for c = 1:3
%      multiply the values of the linear image channel with the respective  gains vector value, and assign to the respective channel of balanced_image
    balanced_image(:, :, c) = linear_image(:, :, c) * gains(c);
end
% apply inverse gamma correction, show final image, properly pixel corrected.
balanced_image = balanced_image .^ (1/2.2);
figure;
imshow(balanced_image);
imwrite(balanced_image, "Pixel-corrected-image.jpg");
title('Pixel-based correction');
% gray-world assumption.
% calculate average value of the color channels of the chosen pixel
gray_value = mean(linear_image(gray_pixel(2), gray_pixel(1), :));

% % calculate neighboring pixels color
neighboring_pixels = linear_image(gray_pixel(2) -1 : gray_pixel(2) + 1 , gray_pixel(1)-1 : gray_pixel(1) + 1, :);

% Calculate avg
channel_means = mean(mean(neighboring_pixels, 1), 2);
channel_means = channel_means(:)';

% compute gain for each channel by applying a division on all elements of the gray value by the chanel means
gains = gray_value ./ channel_means;

% transform to column vector
gains = reshape(gains, [1, 1, 3]);

% Apply color correction gain to each color channel
balanced_image = zeros(size(linear_image)); % create a 3d matrix of 0s. this shall be filled.
% For each of the color channels RBG
for c = 1:3
    % multiply the values of the linear image channel with the respective gains vector value
    balanced_image(:, :, c) = linear_image(:, :, c) * gains(c);
end

% Apply inverse gamma correction, show final image, properly pixel corrected.
balanced_image = balanced_image .^ (1/gamma);
figure;
imshow(balanced_image);
imwrite(balanced_image, "Gray-world-corrected-image.jpg");
title('Gray-World Correction');

% END WHITE BALANCE CODE RETRIEVED FROM ASSIGNMENT 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Adjust contrast and brightness
contrast = 50; 
brightness = 10;
balanced_image = imadjust(balanced_image, [0.0, 1.0], [brightness/100, (contrast+brightness)/100]);
balanced_image(balanced_image < 0) = 0;
balanced_image(balanced_image > 1) = 1;
figure;
% top row
subplot(2, k, 1:k);
imshow(reshape(cl_col_rgb, [1, k, 3]));
title('Representative Colors');

% bottom row
subplot(2, k, k+1:2*k);
imshow(uint8(colorFilters{1}));
title('Color Filter 1');

for i = 1:k
    subplot(2, k, k+i);
    imshow(uint8(colorFilters{i}));
    title(['Color Filter ' num2str(i)]);
end

subplot(2, k, k+1:2*k);
imshow(balanced_image);
title('Modified Image');

saveas(gcf, 'modified_image.png');
