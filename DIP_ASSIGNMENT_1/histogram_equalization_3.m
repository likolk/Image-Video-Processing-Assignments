% locally adaptive histogram equalization
img = imread('ferrari.JPG');
% convert to hsv
hsv_image = rgb2hsv(img);
color_channel = hsv_image(:,:,3);
% LOCALLY ADAPTIVE HISTOGRAM EQUALIZATION 
pxs = [8, 8]; % divide image into x pixels. 
contrast = 0.15; % how much to enhance each pixel. the greater the value, the more the contrast. 
local = adapthisteq(color_channel, 'NumTiles', pxs, 'ClipLimit', contrast);
% Replace the original value channel with the equalized one
hsv_image(:,:,3) = local;
% Convert the image back to RGB
ehnanced_img = hsv2rgb(hsv_image);
imwrite(ehnanced_img, "locally-adaptive-histogram-equalization-result.png");
figure;
imshow(img);
title('Original Ferrari');
figure;
imshow(ehnanced_img);
imwrite(ehnanced_img, "locally-adaptive-histogram-equalization-result.png");
title('Enhanced Ferrari');
figure;
imhist(local);
title('Locally Adaptive Equalized Histogram');
histfile = 'locally-adaptive-histogram-equalized-result.png';



saveas(gcf, histfile);