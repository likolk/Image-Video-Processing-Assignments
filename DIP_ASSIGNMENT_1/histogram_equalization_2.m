% local histogram equalization
img = imread('ferrari.JPG');
% Convert the image to HSV
hsv_img = rgb2hsv(img);
% Extract the value channel
value_channel = hsv_img(:,:,3);
window_sizes = [64, 128, 256, 512];
% Iterate over the window sizes and apply local histogram equalization
for i = 1:length(window_sizes)
    window_size = window_sizes(i);
    locally_equalized_image = adapthisteq(value_channel, 'NumTiles', [window_size window_size]);

    % Replace the original value channel with the equalized one
    hsv_img(:,:,3) = locally_equalized_image;

    % Convert the image back to RGB
    equalized_image = hsv2rgb(hsv_img);

    % Save the equalized image as a PNG file
    filename = sprintf('ferrari_%d.png', window_size);
    imwrite(equalized_image, filename);

    figure;
    imshow(equalized_image);
    figure;
    imhist(equalized_image);
end

imhist(img);
imhist(equalized_image);