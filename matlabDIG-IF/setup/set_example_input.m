load('example_mult.mat','example_dl_filter_banks','example_ul_filter_banks','example_combiner_banks','example_splitter_banks')
load('constants.mat', 'antenna_num', 'sample_bitwidth', 'transmit_bitwidth', 'dl_filter_attribs' ,'ul_filter_attribs', 'combiner_attribs', 'splitter_attribs')

req_num = 10;
send_num = 10;
req_index = 1:req_num;
send_index = req_num+1:req_num+send_num;

dl_filter_addresses = (1:numel(example_dl_filter_banks))';
ul_filter_addresses = (1:numel(example_ul_filter_banks))';
combiner_addresses = (1:numel(example_combiner_banks))';
splitter_addresses = (1:numel(example_splitter_banks))';

req_dl_filter_addresses = (mod(0:req_num-1, size(dl_filter_addresses, 1))+1)';
req_ul_filter_addresses = (mod(0:send_num-1, size(ul_filter_addresses, 1))+1)';
req_combiner_addresses = (mod(0:req_num-1, size(combiner_addresses, 1))+1)';
req_splitter_addresses = (mod(0:send_num-1, size(splitter_addresses, 1))+1)';

min_req_ls = 5;
max_req_ls = 20;
min_req_gap = 0;
max_req_gap = 10;

new_ti = randi(20)+30;
req_ids = req_index;
send_ids = send_index;

cancel_ids_not_findable = randsample(setdiff(1:(req_num+send_num+5), [req_ids, send_ids]),5);
cancel_ids = [randsample(req_ids, 1), randsample(send_ids, 1), cancel_ids_not_findable];

input_set_coeffs = [
    cell2mat(arrayfun( ...                                              %dl_filter
        @(address, data) set_coeff(dl_filter_attribs, address, data), ...
        dl_filter_addresses, ...
        example_dl_filter_banks, 'UniformOutput', false)').';

    cell2mat(arrayfun( ...                                              %ul_filter
        @(address, data) set_coeff(ul_filter_attribs, address, data), ...
        ul_filter_addresses, ...
        example_ul_filter_banks, 'UniformOutput', false)').';

    cell2mat(arrayfun( ...                                              %combiner
        @(address, data) set_coeff(combiner_attribs, address, data), ...
        combiner_addresses, ...
        example_combiner_banks, 'UniformOutput', false)').';

    cell2mat(arrayfun( ...                                              %splitter
        @(address, data) set_coeff(splitter_attribs, address, data), ...
        splitter_addresses, ...
        example_splitter_banks, 'UniformOutput', false)').';   
];

ls = min_req_ls+randi(max_req_ls-min_req_ls, req_num+send_num, 1);
gaps = min_req_gap+randi(max_req_gap-min_req_gap, req_num+send_num, 1);

latency = 4; % current design time from request on its input pins to it can be read

[ts, ss] = gen_req_timing(ls, gaps, numel(input_set_coeffs)+latency);

stop_time = max(ss);

%input_set_ti = set_ti(new_ti);

input_reqs = [
    arrayfun(@req, ...                  %req
        req_ids', ...                   %id
        ones(req_num, 1)*2, ...         %fn
        req_dl_filter_addresses, ...    %dl filter address
        req_combiner_addresses, ...     %combiner address
        ts(req_index), ...
        ls(req_index));

    arrayfun(@req_send, ...          %req_send
        send_ids', ...               %id
        ones(send_num, 1)*2, ...     %fn
        req_ul_filter_addresses, ... %ul filter address
        req_splitter_addresses, ...  %splitter address
        ts(send_index), ...
        ls(send_index));
];



input_cancel_id = arrayfun(@req_cancel, cancel_ids);
input_transmit_data = transmit_data(randi(2^transmit_bitwidth, stop_time, 1)-1+1i*randi(2^transmit_bitwidth, stop_time, 1)-1i);
antenna_input_data = fi(randi(2^sample_bitwidth, stop_time, antenna_num)-1+1i*randi(2^sample_bitwidth, stop_time, antenna_num)-1i, false, sample_bitwidth, 0);
input_bus = make_input(input_set_coeffs, input_reqs, input_cancel_id);

%% expected_output
cancel_ids_not_found = arrayfun(@(cancel_id) any([req_ids, send_ids] == cancel_id), cancel_ids);

expected_valid = assign_booleans(arrayfun(@(id) all(id~=cancel_ids(cancel_ids_not_found)), [req_ids, send_ids]), ts, ss);
expected_id = assign_numbers([req_ids, send_ids].*arrayfun(@(id) all(id~=cancel_ids(cancel_ids_not_found)), [req_ids, send_ids]), ts, ss);
expected_SEND = assign_booleans([false(1, req_num), true(1, send_num)], ts, ss);
expected_filter_address = assign_numbers([req_dl_filter_addresses, req_ul_filter_addresses], ts, ss);
expected_dist_address = assign_numbers([req_combiner_addresses, req_splitter_addresses], ts, ss);

expected_output = struct(...
    'req', table(expected_valid.', expected_id.', expected_SEND.', expected_filter_address.', expected_dist_address.', 'VariableNames',...
        {'valid', 'id', 'SEND', 'filter_address', 'dist_address'}),...
    'errors', struct('id_not_found', cancel_ids_not_findable));

save('setup/example_input.mat', 'stop_time', 'input_bus', 'antenna_input_data', 'input_transmit_data', 'expected_output');
