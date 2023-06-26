image = im2double(imread('queen.jpg'));
labImage = rgb2lab(image);
numColors = 32;
pixels = reshape(labImage, [], 3);
[~, centroids] = kmeans(pixels, numColors);
[~, labels] = pdist2(centroids, pixels, 'seuclidean', 'Smallest',1);
q_lab_img = reshape(centroids(labels, :), size(labImage));
quantized_img = lab2rgb(q_lab_img);
L = q_lab_img(:, :, 1); 
% normalize
L = (L - min(L(:))) / (max(L(:)) - min(L(:)));
% grayscale
grayscaleImage = repmat(L, [1, 1, 3]);

figure;
subplot(1, 3, 1);
imshow(image);
title('Original Image');
subplot(1, 3, 2);
imshow(quantized_img);
title('Quantized Color Image');
subplot(1, 3, 3);
imshow(grayscaleImage, []);
title('Grayscale Image (Perceptual LUT)');
saveas(gcf, 'improved_color_quantization.jpg')
