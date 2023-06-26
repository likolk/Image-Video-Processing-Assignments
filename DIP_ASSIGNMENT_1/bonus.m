% contrast enhancement.
img = imread('vrady.jpg');
enhanced_img = imadjust(img, [0.35 0.85], []);
figure
imshow(enhanced_img);
title("Adjusted image");
imwrite(enhanced_img, "contrast-ehnanced-bonus.png");

% rotate
img = imread('vrady.jpg');
% 180 degree rotation
rotated_image = imrotate(img, 180);
figure;
imshow(rotated_image);
title('Rotated Image');
imwrite(rotated_image, "rotated-image.png")




img = imread('vrady.jpg');
img_hsv = rgb2hsv(img);

% hue
img_hue = img_hsv;
img_hue(:,:,1) = mod(img_hue(:,:,1) + 0.5, 1); 

% saturation
img_sat = img_hsv;
img_sat(:,:,2) = img_hsv(:,:,2) * 5.5;

% value
img_val = img_hsv;
img_val(:,:,3) = img_hsv(:,:,3) * 2.8;

% combine all 3 changes onto 1 image with help of cat function, showing
% hue, saturation and value respectively.
final_img= cat(2, hsv2rgb(img_hue), hsv2rgb(img_sat), hsv2rgb(img_val));
imwrite(final_img, "hue-sat-val-final-image.png");
imshow(final_img);
title("Hue-Sat-Val Image");




% they might not be the same exact taken photo but i think you get the idea.
% averaging pixel values.
img1 = imread('vrady.jpg');
img2 = imread('vrady2.jpg');
img_average = (img1 + img2) / 2;
imshow(img_average);
title("Average Pixel values");
imwrite(img_average, "average.png");


% gaussian blur
img = imread('vrady.jpg');
blurred_img = imgaussfilt(img, 10);
% figure;
% imshow(img);
figure;
imshow(blurred_img);
title('Blurred Image');
imwrite(blurred_img, "blurred-image.png");


% edge detection
img = imread('vrady.jpg');
% figure;
% imshow(img);
img = rgb2gray(img);
edges_img = edge(img, 'canny', 0.15);
figure;
imshow(edges_img);
title('Edges Image');
imwrite(edges_img, "edges-image.png");

% sharpening
img = imread('vrady.jpg');
sharpened_img = imsharpen(img, 'Amount', 2, 'Radius', 2);
% sharpened_img = imsharpen(img);
% figure;
% imshow(img);
figure;
imshow(sharpened_img);
title('Sharpened Image');
imwrite(sharpened_img, "sharpened-image.png");



% thresholding
img = imread('vrady.jpg');
figure;
imshow(img);
img = rgb2gray(img);
thresholded_img = imbinarize(img, 'adaptive', 'Sensitivity', 1);
figure;
imshow(thresholded_img);
title('Thresholded Image');
imwrite(thresholded_img, "thresholded-image.png");

% gaussian blur, as discussed in non-linear filtering lecture
img = imread('vrady.jpg');
blurred_img = imgaussfilt(img, 10);
% figure;
% title('Original Image');
% imshow(img);
figure;
imshow(blurred_img);
title('Blurred Image');
imwrite(blurred_img, "blurred-image.png");

% inpainting
img = imread('vrady.jpg');
% figure;
% imshow(img);
img = rgb2gray(img);
mask = zeros(size(img));
mask(300:500, 300:500, :) = 0.5;
inpainting_img = regionfill(img, mask);
figure;
title('Inpainting Image');
imshow(inpainting_img);
imwrite(inpainting_img, "inpainting-image.png");




% bilateral filtering 
img = imread('vrady.jpg');
img2 = rgb2hsv(img);
filtered_img = imbilatfilt(img2);
% figure;
% imshow(img);
figure;
imshow(filtered_img);
title('Filtered Image');
imwrite(filtered_img, "filtered-image.png");
