load('constants.mat', 'antenna_num', 'stream_num', 'sample_bitwidth');
load('example_mult.mat', 'example_splitter_banks');

samples = 100;
stop_time = samples;

example_coeff_banks = arrayfun(@(index) reshape([real(example_splitter_banks{index});imag(example_splitter_banks{index})], size(real(example_splitter_banks{index}),1), []), 1:size(example_splitter_banks,1), 'UniformOutput', false).';


coeff_switches_at = sort(randi(samples-1, size(example_coeff_banks,1)-1, 1));
example_coeffs = cell2mat(assign_numbers(cellfun(@(cell) reshape(cell, [], numel(example_coeff_banks{1})), example_coeff_banks, 'UniformOutput', false).', [1; coeff_switches_at+1], [coeff_switches_at; samples])).';
example_complex_coeff = example_coeffs(:, 1:2:end)+1i*example_coeffs(:, 2:2:end);


example_input_stream = randi(100, samples, 1)+1i*randi(100, samples, 1);

out = sim('splitter_test').stream;


correct_ul_stream = cell2mat(arrayfun(@(i) example_complex_coeff(i,:)*example_input_stream(i), (1:samples)', 'UniformOutput',false));

errors = [
    any(correct_ul_stream.' ~= out.').';
];
