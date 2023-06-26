img = im2double(imread('delicate_arch.jpg'));
imshow(img);
gray_img = rgb2gray(img);
imshow(gray_img);
% gaussian filtering so as to smooth the image beforehand
filtering_level = 4;
img_blur_filtered = imgaussfilt(gray_img, filtering_level);
imshow(img_blur_filtered);
% morphological operation application: apply dilation to make the edges thicker
line_thickness = 2.5;
structuring_element = strel('line', line_thickness, line_thickness);
separated_edges = imdilate(edge(img_blur_filtered, 'Canny') ,structuring_element); % apply structuring element to image. prewitt, log and sobel do not work in this scenario.
imshow(separated_edges);
colored_img = repmat(gray_img, [1, 1, 3]); % convert to gray.
colored_img(separated_edges) = 0; % color the lines we extracted beore with black color
transformed_img = rgb2ycbcr(img); % convert
% transformed_img = rgb2ycbcr(colored_img);
img_styl = ycbcr2rgb(cat(3,  colored_img(:,:,1), transformed_img(:,:,2), transformed_img(:,:,3))); % concatenate images (1 for each color channel) to create new image 
% and convert back to RBG 
imshow(img_styl);
imwrite(img_styl, "image-stylization.jpg");
