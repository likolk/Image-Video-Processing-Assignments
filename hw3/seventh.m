img = imread('san_domenico.png');
img = im2double(img);
figure
imshow(img);
title('Original Image');


Fshift = fftshift(fft2(img)); % 2D FFT and shifting the low frequency components (i.e. zero  frequency component) to the center, making it easier to apply frequency-based operations.
magnitude_spectrum = 20*log10(abs(Fshift));
figure;
imshow(magnitude_spectrum, []);
imwrite(magnitude_spectrum, "Magnitude_Spectrum_of_FFT.png");
title('Magnitude Spectrum of FFT');


[M, N] = size(img);
% filter shape, notch width, frequency of notches.
H1 = notch_reject_filter([M, N], 18, 50, 30);
H2 = notch_reject_filter([M, N], 18, -40, 37);
H3 = notch_reject_filter([M, N], 18, 40, 30);
H4 = notch_reject_filter([M, N], 18, -40, 28);
NotchFilter = H1 .* H2 .* H3 .* H4;
notchRejectFilter = magnitude_spectrum .* NotchFilter;
figure;
imshow(notchRejectFilter, []);
imwrite(notchRejectFilter, "notch_reject_filter.png")
title('Notch Reject Filter');


final_img = abs(ifft2(ifftshift(Fshift .* NotchFilter))); 
figure;
imshow(final_img, []);
imwrite(final_img, "Restored_Image.png")
title('Final Image');

% function takes a shape, that is  the shape of the filter and is expected to be a 2-element 
% vector containing the number of rows and columns, a notch width, and
% frequency of notches
function F = notch_reject_filter(shape, notch_width, i_frequency, j_frequency)
    % extract dimensions of the filter shape
    M= shape(1);
    N= shape(2);
    % initialize filter matrix MxNwith zeros.
    F = zeros(M, N);
    % iterate over the filter 
    for i=1:M
        for j=1:N
            % euclidean distances
            % from point (u, v) to center of the filter
            % calculate distance to the center with positive frequency coordinates
            distances_uv_center_with_positive_freq_coordinates = sqrt((i - M/2 + i_frequency)^2 + (j - N/2 + j_frequency)^2); 
            % with negative
            distances_uv_center_with_negative_freq_coordinates = sqrt((i - M/2 - i_frequency)^2 + (j - N/2 - j_frequency)^2);
            
            if distances_uv_center_with_positive_freq_coordinates <= notch_width || distances_uv_center_with_negative_freq_coordinates <= notch_width
                F(i, j) = 0.0;
            else
                F(i, j) = 1.0;
            end
        end
    end
end