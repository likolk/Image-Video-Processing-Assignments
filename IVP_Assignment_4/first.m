img = imread('queen.jpg');
linear_img = im2double(img);
% Invert sRGB transform
linear_img(linear_img <= 0.04045) = linear_img(linear_img <= 0.04045) / 12.92;
linear_img(linear_img > 0.04045) = ((linear_img(linear_img > 0.04045) + 0.055) / 1.055) .^ 2.4;
% linear RGB to HSL
hsl_img = rgb2hsl(linear_img);
reshaped_img = reshape(hsl_img, [], 3);
k = 7;
[cluster_indices, ~] = kmeans(reshaped_img, k);
% Calculate representative colors for each cluster
cluster_color = zeros(k, 3);
for i = 1:k
    k_colors = reshaped_img(cluster_indices == i, :);
    cluster_color(i, :) = mean(k_colors);
end
% Create individual color filters
color_filters = cell(1, k);
for i = 1:k
    colorFilter = zeros(size(img));
    colorFilter(repmat(cluster_indices == i, [1 1 3])) = img(repmat(cluster_indices == i, [1 1 3]));
    color_filters{i} = colorFilter;
end

figure;
% top row - colors
subplot(2, k, 1:k);
imshow(reshape(rgb2hsl(cluster_color), [1, k, 3]));
title('Representative Colors (HSL)');
% bottom row - images
for i = 1:k
    subplot(2, k, k+i);
    imshow(color_filters{i});
    title(['Color Filter ' num2str(i)]);
end

saveas(gcf, 'queen_linear_rgb_color_palette.png');







% similar procedure for SRGB color palette
img = imread('queen.jpg');
linear_img = im2double(img);
linear_img(linear_img <= 0.04045) = linear_img(linear_img <= 0.04045) / 12.92;
linear_img(linear_img > 0.04045) = ((linear_img(linear_img > 0.04045) + 0.055) / 1.055) .^ 2.4;
reshaped_img = reshape(linear_img, [], 3);
k = 7;
[cluster_indices, ~] = kmeans(reshaped_img, k);
cluster_color = zeros(k, 3);
for i = 1:k
    k_colors = reshaped_img(cluster_indices == i, :);
    cluster_color(i, :) = mean(k_colors);
end
color_filters = cell(1, k);
for i = 1:k
    colorFilter = zeros(size(img));
    colorFilter(repmat(cluster_indices == i, [1 1 3])) = img(repmat(cluster_indices == i, [1 1 3]));
    color_filters{i} = colorFilter;
end
figure;
subplot(2, k, 1:k);
imshow(reshape(rgb2hsl(cluster_color), [1, k, 3]));
title('Representative Colors (HSL)');
axis off;
for i = 1:k
    subplot(2, k, k+i);
    imshow(color_filters{i});
    title(['Color Filter ' num2str(i)]);
    axis off;
end
saveas(gcf, 'queen_srgb_color_palette.png');



% I took this piece of code from MATLAB's official site.
function hsl=rgb2hsl(rgb_in)
    % (C) Vladimir Bychkovsky, June 2008
    % written using: 
    % - an implementation by Suresh E Joel, April 26,2003
    % - Wikipedia: http://en.wikipedia.org/wiki/HSL_and_HSV
    rgb=reshape(rgb_in, [], 3);
    mx=max(rgb,[],2);%max of the 3 colors
    mn=min(rgb,[],2);%min of the 3 colors
    L=(mx+mn)/2;%luminance is half of max value + min value
    S=zeros(size(L));
    % this set of matrix operations can probably be done as an addition...
    zeroidx= (mx==mn);
    S(zeroidx)=0;
    lowlidx=L <= 0.5;
    calc=(mx-mn)./(mx+mn);
    idx=lowlidx & (~ zeroidx);
    S(idx)=calc(idx);
    hilidx=L > 0.5;
    calc=(mx-mn)./(2-(mx+mn));
    idx=hilidx & (~ zeroidx);
    S(idx)=calc(idx);
    hsv=rgb2hsv(rgb);
    H=hsv(:,1);
    hsl=[H, S, L];
    hsl=round(hsl.*100000)./100000; 
    hsl=reshape(hsl, size(rgb_in));
end
