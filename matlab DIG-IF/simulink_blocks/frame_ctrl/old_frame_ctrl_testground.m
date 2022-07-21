load('constants.mat', 'ts_bitwidth', 'symbol_size', 'frame_size')

request_num = 10;
min_req_ls = 5;
max_req_ls = 20;
min_req_dist = 0;
max_req_dist = 10;
UC_chance = 0.2;
SEND_chance = 0.2;

ls = min_req_ls+randi(max_req_ls-min_req_ls, request_num, 1);
ts_ticks = zeros(request_num, 1);
ss_ticks = zeros(request_num, 1);
ts_ticks(1) = randi(max_req_dist-min_req_dist)+min_req_dist;
ss_ticks(1) = ts_ticks(1)+ls(1);
for i=2:(size(ls,1))
    ts_ticks(i) = ss_ticks(i-1)+randi(max_req_dist-min_req_dist)+min_req_dist;
    ss_ticks(i) = ts_ticks(i)+ls(i);
end

stop_time = max(ss_ticks);
ids = 1:request_num;
UC = logical(randi(2, size(ts_ticks))-1 < UC_chance);
SEND = logical(randi(2, size(ts_ticks))-1 < SEND_chance);
SEND = SEND & ~UC; % Can't be sending and uncombining at the same time
cb = 1:request_num;
kb = 1:request_num;

input_id = zeros(1, stop_time);
input_valid = false(1, stop_time);
input_ss = zeros(1, stop_time);
input_UC = false(1, stop_time);
input_SEND = false(1, stop_time);
input_cb = zeros(1, stop_time);
input_kb = zeros(1, stop_time);

input_id(ts_ticks) = ids;
input_valid(ts_ticks) = true;
input_ss(ts_ticks) = ss_ticks;
input_UC(ts_ticks) = UC;
input_SEND(ts_ticks) = SEND;
input_cb(ts_ticks) = cb;
input_kb(ts_ticks) = kb;


%open('frame_ctrl_test')
out = sim('frame_ctrl_test');

out_table = table(out.receive_UC, out.receive_cb, out.receive_kb, out.receive_valid, out.transmit_cb, out.transmit_kb, out.transmit_valid, ...
'VariableNames', {'input_ts', 'input_ss', 'receive_UC', 'receive_cb', 'receive_kb', 'receive_valid', 'transmit_cb', 'transmit_kb', 'transmit_valid'});

correct_table = table(assign_booleans(UC_chance, ts_ticks, ss_ticks))

%% Plots
out_id = assign_number(1:request_num, ts_ticks, ss_ticks);
out_ss = assign_number(ss_ticks', ts_ticks, ss_ticks);
out_UC = assign_booleans(UC_chance, ts_ticks, ss_ticks);
out_SEND = assign_booleans(SEND_chance, ts_ticks, ss_ticks);
out_cb = assign_number(1:request_num, ts_ticks, ss_ticks);
out_kb = assign_number(1:request_num, ts_ticks, ss_ticks);

subplot(5, 1, 1);
hold on
ylim([-0.1 1.1])
stairs((1:stop_time)-0.5, input_valid);
plot(ss_ticks, ones(size(ss_ticks)), '+');
plot(ts_ticks, ones(size(ts_ticks)), '+');
legend('valid', 'ss', 'ts')
title('Valid, start tick and stop tick');

subplot(5, 1, 2);
plot(1:stop_time, max(out_ss-(1:stop_time), 0));
title('time left');

subplot(5, 1, 3);
stairs((1:stop_time)-0.5, out_id)
title('id');

subplot(5, 1, 4);
stairs((1:stop_time)-0.5, out_UC);
ylim([-0.1 1.1])
title('UC');

subplot(5, 1, 5);
stairs((1:stop_time)-0.5, out_SEND);
ylim([-0.1 1.1])
title('SEND');

function out = assign_number(numbers, ts, ss)
    indice_list = arrayfun(@(ts, ss) ts:ss, ts, ss, 'uni', false)';
    length = max(ss);
    out = zeros(1, length);
    out(cell2mat(indice_list)) = cell2mat(arrayfun(@(n, indices) ones(size(indices{:})).*n, numbers, indice_list, 'uni', false));
end

function out = assign_booleans(booleans, ts, ss)
    indice_list = arrayfun(@(ts, ss) ts:ss, ts, ss, 'uni', false)';
    length = max(ss);
    out = zeros(1, length);
    out(cell2mat(indice_list)) = cell2mat(arrayfun(@(bool, indices) bool & true(size(indices{:})), booleans, indice_list, 'uni', false));
end
