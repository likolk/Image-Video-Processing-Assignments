img = ones(1024, 1024, 3);
width = 450;
height = 400;
centerX = size(img, 2) / 2;
centerY = size(img, 1) / 2;
left = round(centerX - width / 2);
right = round(centerX + width / 2);
top = round(centerY - height / 2);
bottom = round(centerY + height / 2);
img(top:bottom, left:right, :) = 0;
sigmas = 1:10;
% execution times
time_spatial = zeros(size(sigmas));
time_temporal = zeros(size(sigmas));
kSize = 2*round(3*sigma)+1;
for i = 1:length(sigmas)
    sigma = sigmas(i);
    tic;
    img_spatial = imgaussfilt(img, sigma);
    time_spatial(i) = toc;
    tic;
    h = fspecial('gaussian', kSize, sigma);
    img_temporal = imfilter(img, h, 'replicate');
    time_temporal(i) = toc;
end
figure;
plot(sigmas, time_spatial, sigmas, time_temporal);
xlabel('sigmas');
ylabel('Time');
legend('Spatial domain', 'Temporal domain');
saveas(gcf, 'spatial-vs-temporal.png');
