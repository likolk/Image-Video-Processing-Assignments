sigma = 1;
kernel_size = 10;
x = - floor(kernel_size / 2):floor(kernel_size / 2);
% gaussian filter
gaussian_filter = exp(-x .^ 2 / (2 * sigma^2)) / (sqrt(2 * pi) * sigma);
% compute the Fourier transform of the Gaussian filter, and shift the  spectrum so that the 
% zero frequency is at the center of the spectrum using the fftshift function.
H = fftshift(fft(gaussian_filter)); 
% Fourier transform of the approximated filter with a smaller kernel size 
% by appending  zeros to the end of the Gaussian filter h,
% and then applying the fft and fftshift functions as above.
G = fftshift(fft([gaussian_filter zeros(1, kernel_size)])); 
freq = linspace(-10, 10,length(H));
figure;
plot(freq, abs(H));
title('Fourier Transform of Gaussian Filter');
freq = linspace(-10, 10, length(G));
figure;
plot(freq, abs(G));
title('Fourier Transform of Approximated Filter with Smaller Kernel Size');
saveas(gcf, 'gaussian-vs-windowed.png');

