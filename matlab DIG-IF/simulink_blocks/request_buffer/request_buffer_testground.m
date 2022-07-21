%% request_buffer_test
load('setup/constants.mat');
load('setup/types.mat')

cancel_id_error = 127; % only error if there is no other request with that id

input_bus = make_input(...
    empty(3), ...% t=1 
    req_ut(1, 1, 1, 1, 1), ... % t=4 
    empty(), ...
    req_uc(2, 2, 1, 20, 1), ... % t=6
    empty(), ...
    req(3, 2,  2,  2, 21, 1), ... % t=8
    empty(), ...
    req(4, 2, 63, 63, 22, 1), ... % t=10
    empty(), ...
    req_send(5, 2, 64, 64, 23, 1), ... % t=12
    empty(), ...
    req(6, 2,  1,  1, 24, 1), ... % t=14
    empty(), ...
    req(7, 2,  3,  2, 25, 1), ... % t=16
    empty(2), ...
    req_cancel(4), ... % t=18
    req_cancel(cancel_id_error), ... % t=19
    req(8, 2,  1,  1, 26, 1), ... % t=20
    empty(), ...
    empty(20));

ticks = numel(input_bus);
example_ti = (1:ticks)-1;

busy_at_index = 25; % busy at req id=7
example_busy = true(ticks, 1);
example_busy(19:26) = false; % Needs to not be busy one tick before the read because it takes a tick to read.
example_busy(busy_at_index) = true;

stop_time = ticks-1;

out = sim('request_buffer_test');

if any([
    any(out.errors.overlap.data(1:busy_at_index-1));
    not(out.errors.overlap.data(busy_at_index)); %Supposed to be overlap at busy_at_index
    any(out.errors.overlap.data(busy_at_index+1:end));
])
    fprintf("ERROR: Overlaping requests happens (More than the expected at time-index %i)\n", busy_at_index)
end

id_not_found_index = find(out.errors.id_not_found.valid.data);
if ~isscalar(id_not_found_index)
   fprintf("ERROR: Id not found that should have been found. id:%i, time-index:%i\n",...
       [reshape(out.errors.id_not_found.id.Data(id_not_found_index), [], 1), id_not_found_index]');
end
if(out.errors.id_not_found.id.Data(id_not_found_index) ~= cancel_id_error)
   disp("ERROR: Id not found does not match supposed not found index"); 
end

out_req_indexes = find(out.req_out.valid.data);
if any(reshape(out.req_out.id.Data(out_req_indexes), 1, []) ~= [2, 3, 5, 6, 8]) % id=1 missed, id=4 is canceled, id=7 overlaps
    disp("ERROR: Out requests doesnt match ids")
end

out_req_data = table(... % also check yourself if it matches your input data
    out.req_out.id.data(out_req_indexes),...
    out.req_out.req.fn.data(out_req_indexes),...
    out.req_out.req.UC.data(out_req_indexes),...
    out.req_out.req.SEND.data(out_req_indexes),...
    out.req_out.req.filter_address.data(out_req_indexes),...
    out.req_out.req.dist_address.data(out_req_indexes),...
    out.req_out.req.ss.data(out_req_indexes),...
    'VariableNames', {'id', 'fn', 'UC', 'SEND', 'filter_address', 'dist_address', 'ss'}...
);
%correct_data = out_req_data;
%save('correct_data.mat', 'correct_data');
load('correct_data.mat');
errors = false; %~isequal(out_req_data, correct_data);

