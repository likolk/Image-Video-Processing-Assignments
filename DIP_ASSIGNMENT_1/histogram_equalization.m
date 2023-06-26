% global histogram equalization
img = imread('ferrari.JPG');
hsv_img = rgb2hsv(img);
% Apply histogram equalization to the value channel
hsv_img(:,:,3) = histeq(hsv_img(:,:,3)); % apply hiistogram equalization on the image color channel converted in hsv
%  i.e. increase image contrast by redestributing the pixels along the whole channel.
contrasted_img = hsv2rgb(hsv_img);
figure;
imshow(img);
title('Original Ferrari');
figure;
imshow(contrasted_img);
imwrite(contrasted_img, "global-histogram-equalization-result.png");
title('Enhanced Ferrari');
imhist(img);
imhist(contrasted_img);
