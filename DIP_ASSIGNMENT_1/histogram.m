% 1.3 - Histograms
img = imread('ferrari.JPG');
% store the 3 RBG channels into an array
RBG = {'RED', 'GREEN', 'BLUE'};
% Calculate the histogram for each color channel and plot it
figure;
for color = 1:3
    channel = RBG{color}; % assign current color channel to variable channel
    channel_values = img(:,:,color);  % get rows, columns of the ith color channel from the ferrari image and assign them to variable channel_Values
    [histogram_freq, histogram_edges] = histcounts(channel_values(:), 256); % use function histcounts to generate the histogram for the current color channel, taking into account the channel values and the number of bins, 256 in this case.
    subplot(3,1,color); % default matlab function creating the 3 plots (the 3 from the loop, not from this line), with passed params: 3 rows, 1 column, and i the current color channel
    bar(histogram_edges(1:end-1), histogram_freq) % bar charts
    title(channel + " Channel Histogram"); 
end

saveas(gcf, 'all_hist.png'); % save the histograms to a file


