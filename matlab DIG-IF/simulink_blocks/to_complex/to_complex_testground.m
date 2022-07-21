
samples = 100;
stop_time = samples;
example_complex_stream = ones(samples, 1)*(1:64);

out = sim('to_complex_test.slx').complex_stream;

correct_out = example_complex_stream(:, 1:2:end)+1i*example_complex_stream(:, 2:2:end);

errors = [
    any(out.' ~= correct_out.').'
];