%% receive_blocker
load('constants.mat', 'antenna_num', 'sample_bitwidth')
stop_time = 8;

inputs = randi(2^sample_bitwidth, stop_time, antenna_num)-1+1i*randi(2^sample_bitwidth, stop_time, antenna_num)-1i;

valid_input = logical(randi(2, 1, stop_time)-1)';
example_input = fi(inputs, false, sample_bitwidth, 0);

%open('receive_blocker_test')
out = sim('receive_blocker_test.slx').data_out;
errors = any((out ~= fi(valid_input.*inputs, false, sample_bitwidth, 0))');