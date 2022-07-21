%% Constants
clear;
sample_frequency = 983.04e6; % 983.04MS/s
symbol_size = 4400; %samples in a symbol
frame_size = 10*8*14; %symbols in a frame
downsample = 2;
% frame time = symbol_size*frame_size/(sample_frequency/downsample) = 10ms

id_bitwidth = 16;
fn_bitwidth = 16;
ts_bitwidth = 32;
ls_bitwidth = 32;

antenna_num = 8;
stream_num = 4;
sample_bitwidth = 4;
transmit_bitwidth = 4;

req_mem_size = 64; % cant be change without redesign

%% Bank attributes
%shared
bank_bitwidth = 8;
coeff_ram_bitwidth = 64;

dl_filter_attribs = struct(...
    'name', 'dl_filter', ...
    'coeff_num', 10,... % The currently applied dl filter design has 10 coefficients. 
    'complex', false,...
    'coeff_bitwidth', 8);
dl_filter_attribs.data_rows = ceil(dl_filter_attribs.coeff_num*dl_filter_attribs.coeff_bitwidth*(1+dl_filter_attribs.complex)/coeff_ram_bitwidth);

ul_filter_attribs = struct(...
    'name', 'ul_filter', ...
    'coeff_num', 10,... % The currently applied ul filter design has 10 coefficients. 
    'complex', false,...
    'coeff_bitwidth', 8);
ul_filter_attribs.data_rows = ceil(ul_filter_attribs.coeff_num*ul_filter_attribs.coeff_bitwidth*(1+ul_filter_attribs.complex)/coeff_ram_bitwidth);

combiner_attribs = struct(...
    'name', 'combiner', ...
    'coeff_num', antenna_num*stream_num,...
    'complex', true,...
    'coeff_bitwidth', 8);
combiner_attribs.data_rows = ceil(combiner_attribs.coeff_num*combiner_attribs.coeff_bitwidth*(1+combiner_attribs.complex)/coeff_ram_bitwidth);

splitter_attribs = struct(...
    'name', 'splitter', ...
    'coeff_num', antenna_num,... 
    'complex', true,...
    'coeff_bitwidth', 8);
splitter_attribs.data_rows = ceil(splitter_attribs.coeff_num*splitter_attribs.coeff_bitwidth*(1+splitter_attribs.complex)/coeff_ram_bitwidth);

%%
save('setup/constants.mat')