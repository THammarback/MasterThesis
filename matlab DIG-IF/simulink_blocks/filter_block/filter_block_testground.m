load('example_mult.mat', 'example_dl_filter_banks', 'example_ul_filter_banks');
load('constants.mat', 'antenna_num', 'sample_bitwidth')

samples = 1000;
stop_time = samples;

coeff_switches_at = sort(randi(samples, size(example_dl_filter_banks,1)-1, 1));

freqs = 2*pi*(1:antenna_num)/samples;

example_stream_input = 2^sample_bitwidth*sin((1:samples)'.*freqs); %randi(2^sample_bitwidth, samples, antenna_num)-1;
example_filter_coeffs = cell2mat(assign_numbers(cellfun(@transpose,example_dl_filter_banks,'UniformOutput',false)', [1; coeff_switches_at+1], [coeff_switches_at; samples]))';