happy = im2double(rgb2gray(imread('happy.jpg')));
sad = im2double(rgb2gray(imread('sad.jpg')));
spatial = fspecial('gaussian', 5, 5);
levels = 4;
happy_lapl = laplacianPyramid(happy, spatial, levels);
sad_lapl = laplacianPyramid(sad, spatial, levels);
figure;

for i = 1:levels
    subplot(2, levels, i);
    imshow(happy_lapl{i}, []);
    title(['Happy Level ', num2str(i)]);
end

for i = 1:levels
    subplot(2, levels, levels+i);
    imshow(sad_lapl{i}, []);
    title(['Sad Level ', num2str(i)]);
end
% save individually
for i = 1:levels
    imwrite(happy_lapl{i}, ['happy_laplacian_pyramid', num2str(i), '.jpg']);
    imwrite(sad_lapl{i}, ['sad_laplacian_pyramid', num2str(i), '.jpg']);
end

sum_happy_images = happy_lapl{4};
for i = 3:-1:1
    sum_happy_images = imresize(sum_happy_images, size(happy_lapl{i})) + happy_lapl{i};
end
figure
imshow(sum_happy_images);
title('Sum of all the levels');

sum_sad_images = sad_lapl{4};
for i = 3:-1:1
   sum_sad_images = imresize(sum_sad_images, size(sad_lapl{i})) + sad_lapl{i};
end
figure
imshow(sum_sad_images);
title('Sum of all the levels');

function L = laplacianPyramid(img, spatial, levels)
L = cell(1, levels);
G = gaussianPyramid(img, spatial, levels);
% top level of gaussian pyramid == top level of laplacian pyramid
L{levels} = G{levels};
for i = levels-1:-1:1
    % backwards loop so we upsample next level
    G_up = imresize(G{i+1}, size(G{i}), 'nearest');
    % and subtract
    L{i} = G{i} - G_up;
end
end

function G = gaussianPyramid(img, spatial, levels)
G = cell(1, levels);
G{1} = img;
for i = 2:levels
    G{i} = imfilter(G{i-1}, spatial, 'replicate', 'same');
    % downsampling
    G{i} = G{i}(1:2:end, 1:2:end);
end
end