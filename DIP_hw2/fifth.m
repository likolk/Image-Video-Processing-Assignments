img = im2double(imread("graz.png"));
figure;
imshow(img);
title("Original image");
imwrite(img, "originalgraz.jpg");
sigma_x = 10;
sigma_y = 10;
degrees = 45;

result_kernel = anisotropic_gauss(degrees, sigma_x, sigma_y);
final_img = conv2(img, result_kernel, "full");
figure;
imshow(final_img);
imwrite(final_img, "anisotropic-gaussian-kernel.jpg");

function result = anisotropic_gauss(theta, sigma_x, sigma_y)
kernel_size = 5;  % 2D 5x5
mid_pixel = (kernel_size/2) + 1;
% mid_pixel = 0;
result = zeros(kernel_size);
for i=1:kernel_size
    for j=1:kernel_size
        % rotation to coords by 45
        x_theta = (i -mid_pixel) *cos(theta) - (j -mid_pixel) *sin(theta);
        y_theta = (i -mid_pixel) *sin(theta) + (j -mid_pixel) *cos(theta);

        %   kernel value computation
        result(i,j) = exp(-(x_theta^2/(2*sigma_x^2) + (y_theta^2/(2*sigma_y^2))));
    end
end
% normalize
result = result ./ sum(result(:));
end
