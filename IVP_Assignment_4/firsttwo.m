
img = imread('queen.jpg');
% convert to cielab
labImage = rgb2lab(img);
labImage2D = reshape(labImage, [], 3);
% clustering 
k = 7; 
[idx, ~] = kmeans(labImage2D, k);
% colors for each cluster
cl_col = zeros(k, 3);
for i = 1:k
    clusterColors = labImage2D(idx == i, :);
    cl_col(i, :) = mean(clusterColors);
end
% convert back from cielab
cl_col_rbg = lab2rgb(cl_col);
color_filters = cell(1, k);
for i = 1:k
    colorFilter = zeros(size(img));
    colorFilter(repmat(idx == i, [1 1 3])) = img(repmat(idx == i, [1 1 3]));
    color_filters{i} = colorFilter;
end

figure;
% top row - colors
subplot(2, k, 1:k);
imshow(reshape(cl_col_rbg, [1, k, 3]));
title('Representative Colors');
axis off;

% bottom row - images
subplot(2, k, k+1:2*k);
imshow(uint8(color_filters{1}));
title('Color Filter 1');

for i = 1:k
    subplot(2, k, k+i);
    imshow(uint8(color_filters{i}));
    title(['Color Filter ' num2str(i)]);
end
saveas(gcf, 'ciel_queen_color_palette.png');


