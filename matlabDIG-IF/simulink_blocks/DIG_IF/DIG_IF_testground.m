load('setup/example_input.mat',  'stop_time', 'input_bus', 'antenna_input_data', 'input_transmit_data');
load('constants.mat')

sim('DIG_IF_test');