
%% image
img = double(rgb2gray(imread('image.jpg')));
[rows, columns] = size(img);

%% filter
filter = [
    1 1 0 0 0 1;
    1 0 0 0 0 -1;
    -1 0 0 0 -1 -1;
];
%filter = fspecial('gaussian', 9, 3);
[filter_height, filter_width] = size(filter);

%% run matlab
clear gol_mat_stream;
result = arrayfun(@(x) gol_mat_stream(x), reshape(img.', 1, []))';

mat_stream_img = reshape([ ...
    result(columns*floor(filter_height/2)+floor(filter_width/2)+1:end); ... %remove first columns*filter_height/2 + filter_width/2 elements
    zeros(columns*floor(filter_height/2)+floor(filter_width/2), 1) ... %add equal amount of zeros to the bottom (should send more input to receive entire image)
], columns, [])';

figure;

imshow(uint8(mat_stream_img));