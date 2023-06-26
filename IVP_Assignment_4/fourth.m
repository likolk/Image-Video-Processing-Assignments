happy = imread('happy.jpg');
sad = imread('sad.jpg');
happy_img = im2double(rgb2gray(happy));
sad_img = im2double(rgb2gray(sad));
sigma = 4;
gauss_filt = 3 * sigma * 2 + 1;
happy_high_pass = highPassFilter(happy_img, gauss_filt);

sad_low_pass = lowPassFilter(sad_img, gauss_filt);
% make them have the same size
happy_high_pass = imresize(happy_high_pass, size(sad_low_pass));

final_image = sad_low_pass + happy_high_pass;

figure('Name', 'Filtered Images');
subplot(1, 3, 1);
imshow(happy_high_pass, []);
title('High-Pass Filtered Image');
subplot(1, 3, 2);
imshow(sad_low_pass, []);
title('Low-Pass Filtered Image');
subplot(1, 3, 3);
imshow(final_image, []);
title('Combined Image');

saveas(gcf, 'filtered_images_subplot.png');

% apply the high-pass filter to happy
function filtered_image = highPassFilter(image, filter_size)
    % FFT
    fft_img = fft2(image);
    shifted_fft = fftshift(fft_img);
    [rows, cols] = size(fft_img);
    % meshgrid for the frequency domain in the size of the image
    X = 0:cols-1;
    Y = 0:rows-1;
    [X, Y] = meshgrid(X, Y);
    x_mid = 0.5 * cols;
    y_mid = 0.5 * rows;
    gauss_filt_freq_domain = 1 - exp(-((X - x_mid).^2 + (Y - y_mid).^2) / (2 * filter_size).^2);
    % apply the filter to the frequency domain img
    filter_freq_domain_img = shifted_fft .* gauss_filt_freq_domain;
    % Shift the filtered image back to the original position in the frequency domain
    shifted_img = ifftshift(filter_freq_domain_img);
    filtered_image = ifft2(shifted_img);
end

% apply the low-pass filter to sad
function filtered_image = lowPassFilter(image, filter_size)
    fft_img = fft2(image);
    shifted_fft = fftshift(fft_img);
    [rows, cols] = size(fft_img);
    X = 0:cols-1;
    Y = 0:rows-1;
    [X, Y] = meshgrid(X, Y);
    % Calculate the center coordinates
    mid_x = 0.5 * cols;
    mid_y = 0.5 * rows;
    gauss_filt_freq_domain= exp(-((X - mid_x).^2 + (Y - mid_y).^2) / (2 * filter_size).^2);
    filter_freq_domain_img = shifted_fft .* gauss_filt_freq_domain;
    shifted_img = ifftshift(filter_freq_domain_img);
    filtered_image = ifft2(shifted_img);
end



