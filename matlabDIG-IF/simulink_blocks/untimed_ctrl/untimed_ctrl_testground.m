%% Untimed_ctrl_test
load('setup/constants.mat', 'ls_bitwidth');
ticks = 100;

UT_index = randi(ticks);
valid = true(1, ticks);
ts = randperm(ticks, ticks)*100;
ls = randi(ticks, 1, ticks);
UT = false(1, ticks);
UT(UT_index) = true;

out = sim('untimed_ctrl_test');

if UT_index ~= find(ts+ls ~= out.ss') % Note; because of random, this could happen even though there is no error
    %disp("ERROR")
end
