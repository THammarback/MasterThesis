load('constants.mat', 'antenna_num', 'stream_num', 'sample_bitwidth');
load('example_mult.mat', 'example_combiner_banks');

samples = 100;
stop_time = samples;

example_coeff_banks = arrayfun(@(index) reshape([real(example_combiner_banks{index});imag(example_combiner_banks{index})], size(real(example_combiner_banks{index}),1), []), 1:size(example_combiner_banks,1), 'UniformOutput', false).';


coeff_switches_at = sort(randi(samples-1, size(example_coeff_banks,1)-1, 1));
example_coeffs = cell2mat(assign_numbers(cellfun(@(cell) reshape(cell, [], numel(example_coeff_banks{1})), example_coeff_banks, 'UniformOutput', false).', [1; coeff_switches_at+1], [coeff_switches_at; samples])).';
example_complex_coeff = example_coeffs(:, 1:2:end)+1i*example_coeffs(:, 2:2:end);


example_input_stream = randi(100, samples, antenna_num)+1i*randi(100, samples, antenna_num);
UC_input = logical(randi(2, samples, 1)-1);

out = sim('combining_test');


correct_dl_stream = zeros(sum(~UC_input), stream_num);
out_index = 1;
for i = find(~UC_input).'
    correct_dl_stream(out_index,:) = (reshape(example_complex_coeff(i,:), stream_num, antenna_num)*(example_input_stream(i,:).')).';
    out_index = out_index+1;
end

errors = [
    any(out.UC_stream(UC_input,:).' ~= example_input_stream(UC_input,:).').';
    any(out.dl_stream(~UC_input,:).' ~= correct_dl_stream.').';
];