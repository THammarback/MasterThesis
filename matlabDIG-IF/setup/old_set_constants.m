%% Constants
clear;
sample_frequency = 983.04e6; % 983.04MS/s
symbol_size = 4400; %samples in a symbol
frame_size = 10*8*14; %symbols in a frame
downsample = 2;
% frame time = symbol_size*frame_size/(sample_frequency/downsample) = 10ms

protocol_bitwidth = 64; % Can't be changed in this design
antenna_num = 8;
sample_bitwidth = 8;
stream_num = 4; % <= protocol_bitwidth / (sample_bitwidth*2)

req_mem_size = 64; % if set to other than 64 swap /request_buffer/alive_ctrl/bit64_binary_index_search to appropriate block
                   % also if set to larger than 256 some static (uint8) conversions needs to be changed.

bank_bitwidth = 8;
dl_filter_attribs = struct(...
    'coeff_num', 10,... % The currently applied dl filter design has 10 coefficients. 
    'complex', false,...
    'coeff_bitwidth', 8);

ul_filter_attribs = struct(...
    'coeff_num', 4,... % The currently applied ul filter design has 4 coefficients. 
    'complex', false,...
    'coeff_bitwidth', 8);

combiner_attribs = struct(...
    'coeff_num', antenna_num*stream_num,...
    'complex', true,...
    'coeff_bitwidth', 8);

splitter_attribs = struct(...
    'coeff_num', antenna_num,... 
    'complex', true,...
    'coeff_bitwidth', 8);

% dependent on package size
type_bitwidth = 16;
error_bitwidth = 16;
id_bitwidth = 16;
fn_bitwidth = 16;
ts_bitwidth = 32;
ls_bitwidth = 32;

coeff_ram_bitwidth = protocol_bitwidth; % Current version does not support other values

save('setup/constants.mat')