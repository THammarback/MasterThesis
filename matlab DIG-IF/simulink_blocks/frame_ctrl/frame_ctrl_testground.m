load('setup/types.mat')
load('constants.mat')

request_num = 10;
min_req_ls = 5;
max_req_ls = 20;
min_req_dist = 0;
max_req_dist = 10;
UC_chance = 0.2;
SEND_chance = 0.2;

latency = 4;

ls = min_req_ls+randi(max_req_ls-min_req_ls, request_num, 1);
ts = zeros(request_num, 1);
ss = zeros(request_num, 1);
ts(1) = latency;% + randi(max_req_dist-latency);
ss(1) = ts(1)+ls(1);
for i=2:(size(ls,1))
    ts(i) = ss(i-1)+randi(max_req_dist-min_req_dist)+min_req_dist;
    ss(i) = ts(i)+ls(i);
end

stop_time = max(ss);
id = 1:request_num;
skip_cancel_index = sum(ts<=request_num*2+2); %not enough time to process cancel before early req give response
canceled_index = randi(size(id,2)-skip_cancel_index)+skip_cancel_index;
canceled_id = id(canceled_index);
UC = logical(randi(2, size(ts))-1 > UC_chance)';
SEND = logical(randi(2, size(ts))-1 > SEND_chance)';
SEND = SEND & ~UC; % Can't be sending and uncombining at the same time
filter_bank = 1:request_num;
dist_bank = 1:request_num;
dist_bank = dist_bank.*~UC; %dist_bank is 0 when uncombining
fn = 2;

example_input = fi(zeros(request_num*2+2, 1), false, protocol_bitwidth, 0);
for i = 1:request_num
    index = [i*2-1 i*2];
    if SEND(i)
        example_input(index) = REQ_SEND(id(i), fn, filter_bank(i), dist_bank(i), ts(i), ls(i));
    elseif UC(i)
        example_input(index) = REQ_UC(id(i), fn, filter_bank(i), ts(i), ls(i));
    else
        example_input(index) = REQ(id(i), fn, filter_bank(i), dist_bank(i), ts(i), ls(i));
    end
end

example_input(end-1) = CANCEL_REQ(canceled_id);
example_input(end) = CANCEL_REQ(0); % There should not be any request (in this example) with id 0 => id_not_found_error
%%
out = sim('frame_ctrl_test');
output_table = table(out.req.valid.data, out.req.id.data, out.req.SEND.data, out.req.UC.data, out.req.filter_address.data, out.req.dist_address.data, ...
    'VariableNames', {'valid', 'id', 'SEND', 'UC', 'filter_bank', 'dist_bank'});

output_table.valid(1) = 0; %Start up bug

correct_valid = assign_booleans(true(1, request_num) & id~=canceled_id, ts, ss)';
correct_id = assign_numbers(id.*(id~=canceled_id), ts, ss)';
correct_SEND = assign_booleans(SEND & (id~=canceled_id), ts, ss)';
correct_UC = assign_booleans(UC & (id~=canceled_id), ts, ss)';
correct_filter_bank = assign_numbers(filter_bank.*(id~=canceled_id), ts, ss)';
correct_dist_bank = assign_numbers(dist_bank.*(id~=canceled_id), ts, ss)';

correct_table = table(correct_valid, correct_id, correct_SEND, correct_UC, correct_filter_bank, correct_dist_bank,...
    'VariableNames', {'valid', 'id', 'SEND', 'UC', 'filter_bank', 'dist_bank'});

errors = [
    any(out.errors.mem_full.Data);
    any(out.errors.overlap.Data);
    out.errors.id_not_found.data.Data(find(out.errors.id_not_found.valid.Data)) ~= 0; % supposed to be error.id_not_found with id 0
    any(output_table.valid ~= correct_table.valid);
    ~isequal(correct_table(correct_table.valid,:), output_table(output_table.valid,:));
];
