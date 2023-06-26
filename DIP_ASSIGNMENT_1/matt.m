img = imread('ferrari.JPG');
background_img = imread('cat.jpg');

% convert to grayscale so that using treshold we can create a mask.
grayscale_img = rgb2gray(img);

% Threshold the grayscale image to create a mask
mask = zeros(size(grayscale_img)); % initialize mask to all 0s
for i = 1:size(grayscale_img, 1)
    for j = 1:size(grayscale_img, 2)
        if grayscale_img(i,j) < 100 
            mask(i,j) = 1; % set mask to 1 for all pixels that have intensity < 170
        else
            mask(i, j) = 0; % else set to 0
        end
    end
end


% Apply the mask to the input image to extract the 2 images.
% values outside the mask are black.
outside_img = img; 
for i = 1:size(img, 1)
    for j = 1:size(img, 2)
        if mask(i,j) == 0 % if pixel outside mask
            outside_img(i,j,:) = [0 0 0]; % color it black.
        end
    end
end


% extract background by inverting pixel values. inverting background is
% useful as we can check the inverted pixels and then place the new image
% there.
invert_bg = zeros(size(mask)); % Initialize the inverted mask to all zeros
for i = 1:size(mask, 1)
    for j = 1:size(mask, 2)
        if mask(i,j) == 0 % Check if pixel is outside the mask
            invert_bg(i,j) = 1; % Set pixel to inside the mask
        end
    end
end

% resize bg image to match original image size. size(img, [1 2])
% specifices the size to which the bg image should be resized.
new_bg = imresize(background_img, size(img, [1, 2]));
% Apply the inverted mask to the background image to extract the background
% replicate the inverted mask, to create a 3d mask, so as to have equal
% number of color channels in masks such as color channels in the original
% image.
% use uint8 so that we have operations applied to same types of integers,
% in this case unsigned ints. not using uint8 gives compiler error as
% operations msut be applied on the same type of operands.
background_extracted = new_bg .* uint8(repmat(invert_bg, [1 1 3]));

% combine background ith originalimage
final_img = outside_img + background_extracted;
figure
imshow(img);
figure
imshow(final_img);
imwrite(final_img, "replaced-image-with-background.png");

imhist(final_img);




