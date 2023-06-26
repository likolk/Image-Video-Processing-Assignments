image = imread('queen.jpg');
filteredImage = kelvins_insta_filter(image);
saveas(gcf, "insta_filter.jpg");

function filteredImage = kelvins_insta_filter(img)
    img = im2double(img);
    
    figure;
    subplot(3, 3, 1);
    imshow(img);
    title('1: Original Image');
    imwrite(img, "original_img.jpg");
    
    edges = edge(rgb2gray(img), 'sobel');
    subplot(3, 3, 2);
    imshow(edges);
    title('2: Edge Detection');
    imwrite(edges, "edge_detection.jpg");
    
    se = strel('disk', 2);
    dilatedEdges = imdilate(edges, se);
    subplot(3, 3, 3);
    imshow(dilatedEdges);
    title('3: Binary Dilation of Edges');
    imwrite(dilatedEdges, "binary_dilation.jpg");

  
    labImage = rgb2lab(img);
    [rows, cols, ~] = size(labImage);
    reshapedImage = reshape(labImage, rows * cols, 3);
    [~, colors] = kmeans(reshapedImage, 32, 'Replicates', 5);
    [~, indices] = pdist2(colors, reshapedImage, 'euclidean', 'Largest', 1);
    quantizedLabImage = reshape(colors(indices, :), rows, cols, 3);
    quantizedImage = lab2rgb(quantizedLabImage);
    subplot(3, 3, 4);
    imshow(quantizedImage);
    title('4: Color Quantization');
    imwrite(quantizedImage, "color_quantization.jpg");

    hsvImage = rgb2hsv(quantizedImage);
    hsvImage(:, :, 2) = hsvImage(:, :, 2) * 1.5;
    saturatedImage = hsv2rgb(hsvImage);
    subplot(3, 3, 5);
    imshow(saturatedImage);
    title('5: Increased Color Saturation');
    imwrite(saturatedImage, "increased_saturation.jpg");

 
    edgesRGB = cat(3, dilatedEdges, dilatedEdges, dilatedEdges);
    filteredImage = img .* (1 - edgesRGB) + edgesRGB;
    subplot(3, 3, 6);
    imshow(filteredImage);
    title('6: Thick Black Edges');
    imwrite(filteredImage, "thick_black_edges.jpg");
    

    filteredImage = filteredImage .* (1 - dilatedEdges) + saturatedImage .* dilatedEdges;
    subplot(3, 3, 7);
    imshow(filteredImage);
    title('7: Merging Saturation and Edges');
    imwrite(filteredImage, "merging_saturation_edges.jpg");


    filteredImage = imadjust(filteredImage, [0.2 0.8], [], 1.2);
    filteredImage = imsharpen(filteredImage, 'Radius', 2, 'Amount', 1.5);
    filteredImage = imgaussfilt(filteredImage, 1);
    subplot(3, 3, 8);
    imshow(filteredImage);
    title('8: Additional Operations');
    imwrite(filteredImage, "additional_operations.jpg");
    
    subplot(3, 3, 9);
    imshow(filteredImage);
    title('9: Final Filtered Image');
    imwrite(filteredImage, "final_filtered_image.jpg");
end
