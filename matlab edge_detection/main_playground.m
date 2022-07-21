%% filter
filter = [
    1 1 0;
    1 0 -1;
    0 -1 -1;
]';
%filter = fspecial('gaussian', 9, 3);
[filter_height, filter_width] = size(filter);

%% use image
img = double(rgb2gray(imread('image.jpg')));
[rows, columns] = size(img);

%% Run mathworks filter2
fil_image = filter2(filter, img); 
%% Run matlab model
padded_image = [zeros(1, (filter_height-1)*columns+filter_width-1), reshape(img.', 1, [])]; %padd image with "outside" pixels

matlab_edge_detected = gol_mat_main(padded_image, filter, columns)';

mat_image = reshape([ ...
    matlab_edge_detected(columns*floor(filter_height/2)+floor(filter_width/2)+1:end), ... %remove padding
    zeros(1, columns*floor(filter_height/2)+floor(filter_width/2)) ... %add equal amount of zeros to the bottom (should send more input to receive entire image)
], columns, [])';

%% run streamed matlab
%clear gol_mat_stream;
%stream_matlab_result = arrayfun(@(x) gol_mat_stream(x, columns, filter), reshape(img.', 1, []))';
%stream_matlab_result = sim('gol_mat_simulink_tb.slx').edge_detected(1:end-1);

%mat_stream_img = reshape([ ...
%    stream_matlab_result(columns*floor(filter_height/2)+floor(filter_width/2)+1:end); ... %remove first columns*filter_height/2 + filter_width/2 elements
%    zeros(columns*floor(filter_height/2)+floor(filter_width/2), 1) ... %add equal amount of zeros to the bottom (should send more input to receive entire image)
%], columns, [])';

%% Run simulink model
input_img = img; % [img; zeros([2, size(img,2)])]; % add black to bottom of image to run the entire image 
%simulink_edge_detected = sim('gol_sim_top.slx').edge_detected(:);
simulink_edge_detected = sim('fix_sim_test.slx').edge_detected;
sim_image = reshape([ ...
    simulink_edge_detected(columns*floor(filter_height/2)+floor(filter_width/2)+1:end-1); ... %remove first columns*filter_height/2 + filter_width/2 elements
    zeros(columns*floor(filter_height/2)+floor(filter_width/2), 1) ... %add equal amount of zeros to the bottom (should send more input to receive entire image)
], columns, [])';

sim_image = fi(sim_image, false, 8, 0);

%% Draw image
subplot(2,2,1),imshow(uint8(img)); %original
title("Original")
subplot(2,2,2),imshow(uint8(fil_image)); %Mathworks filtered
title("Mathworks filter2")
subplot(2,2,3),imshow(uint8(sim_image)); %simulink filtered
title("Simulink implementation")
subplot(2,2,4),imshow(uint8(mat_image)); %custom matlab filtered
title("Custom Matlab implementation")

%% difference
mathworks_simulink = fil_image-sim_image;
mathworks_matlab = fil_image-mat_image;
matlab_simulink = sim_image-mat_image;

fprintf("Mathworks - Simulink max error: %f\n",max(max(mathworks_simulink(1:end-floor(filter_height/2),1:end-floor(filter_width/2)))));
fprintf("Mathworks - Matlab max error:   %f\n",max(max(mathworks_matlab(1:end-floor(filter_height/2),1:end-floor(filter_width/2)))));
fprintf("Matlab    - Simulink max error: %f\n",max(max(matlab_simulink)));

% plot difference
ph=uint8(zeros(rows, columns)); %0 placeholders
R=uint8(mathworks_simulink);
G=uint8(mathworks_matlab);
B=uint8(matlab_simulink);

figure
subplot(2,2,1),imshow(cat(3,R,G,B));
title("Black = The same")
subplot(2,2,2),imshow(cat(3, R, ph, ph));
title("Filter2 - simulink")
subplot(2,2,3),imshow(cat(3, ph, G, ph));
title("Filter2 - matlab")
subplot(2,2,4),imshow(cat(3, ph, ph, B));
title("matlab - simulink")