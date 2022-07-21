%%
load('setup/example_input.mat',  'stop_time', 'input_bus', 'expected_output');
load('constants.mat'); %, 'bank_bitwidth', 'req_mem_size', 'dl_filter_attribs', 'ul_filter_attribs', 'combiner_attribs', 'splitter_attribs')


out = sim('coeff_bank_integration_test');

output_table = table(out.req_out.valid.data, out.req_out.id.data, out.req_out.SEND.data, out.req_out.filter_address.data, out.req_out.dist_address.data, ...
    'VariableNames', {'valid', 'id', 'SEND', 'filter_address', 'dist_address'});


errors = [
    ~isequal(expected_output.req(expected_output.req.valid,:), output_table(output_table.valid,:))  
    any(expected_output.errors.id_not_found ~= reshape(out.errors.id_not_found.id.data(out.errors.id_not_found.valid.data), 1, []))
];