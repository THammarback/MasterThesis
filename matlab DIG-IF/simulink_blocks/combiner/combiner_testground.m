load('constants.mat', 'antenna_num', 'stream_num');
load('example_mult.mat', 'example_combiner_banks');

samples = 100;
stop_time = samples;

coeff_switches_at = sort(randi(samples-1, size(example_combiner_banks,1)-1, 1));
example_coeffs = cell2mat(assign_numbers(cellfun(@(cell) reshape(cell, [], antenna_num*stream_num), example_combiner_banks, 'UniformOutput', false).', [1; coeff_switches_at+1], [coeff_switches_at; samples])).';


example_input_stream = randi(100, samples, antenna_num);

out = sim('combiner_test').stream;

correct_out = zeros(samples, stream_num);
for i = 1:samples
    correct_out(i,:) = (reshape(example_coeffs(i,:), stream_num, antenna_num)*(example_input_stream(i,:).')).';
end

errors = [
    any(correct_out.' ~= out.').';
];