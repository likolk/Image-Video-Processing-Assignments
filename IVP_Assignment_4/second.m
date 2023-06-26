img = im2double(imread('queen.jpg'));
colors = 32;
pixels = reshape(img, [], 3);
[~, centroids] = kmeans(pixels, colors);
[~, labels] = pdist2(centroids, pixels, 'euclidean', 'Smallest', 1);
quantized_img = reshape(centroids(labels, :), size(img));
look_up_table = mean(centroids, 2);
% quantized to grayscale using lut
grayscale_img = reshape(look_up_table(labels), size(img, 1), size(img, 2));
figure;
subplot(1, 3, 1);
imshow(img);
title('Original Image');
subplot(1, 3, 2);
imshow(quantized_img);
title('Quantized Color Image');
subplot(1, 3, 3);
imshow(grayscale_img);
title('Grayscale Image');
saveas(gcf, "color_quantization_and_lut.jpg");

