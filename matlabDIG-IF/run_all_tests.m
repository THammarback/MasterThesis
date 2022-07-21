clc
addpath(genpath('setup'));
addpath(genpath('helper_functions'));
addpath(genpath('input_creation'));
addpath(genpath('simulink_blocks'));

%% bit64_binary_index_search_test
% No dependencies
clear

%open('bit64_binary_index_search_test');
bit64_binary_index_search_testground;

if any(errors)
   fprintf(2, "ERROR - bit64_binary_index_search:\n");
   disp(errors');
else
    disp("Pass - bit64_binary_index_search");
end

%% find_id_index_test
% No dependencies
clear

%open('find_id_index_test');
find_id_index_testground;

if any(errors)
   disp("ERROR - find_id_index: see errors variable");
   disp(errors');
else
    disp("Pass - find_id_index");
end

%% untimed_ctrl_test
% No dependencies
clear

%open('untimed_ctrl_test');
untimed_ctrl_testground;

if UT_index ~= find(ts+ls ~= out.ss') % Note; because of random, this could happen even though there is no error
    fprintf(2,"ERROR - untimed_ctrl_test")
else
    disp("Pass - untimed_ctrl_test");
end

%% request_buffer_test
% Test depends on: untimed_ctrl
clear

%open('request_buffer_test');
%open('request_buffer_testground');
request_buffer_testground;

if any(any(errors))
   fprintf(2,"ERROR - request_buffer: see errors variable\n");
else
    disp("Pass - request_buffer");
end

%% coeff_bank_test
% Depends on: coeff_bank_multiple_rams, coeff_bank_single_ram
clear

%open('coeff_bank_simple_test');
%open('coeff_bank_simple_testground');
coeff_bank_simple_testground;
if errors
    fprintf(2,"ERROR - coeff_bank_test\n");
else
    disp("Pass - coeff_bank_test");
end

%% coeff_bank_integration_test
% Depends on: coeff_bank_multiple_rams, coeff_bank_single_ram
% Test depends on: frame_ctrl, request_buffer, time_ctrl, package_opener
clear

%open('coeff_bank_integration_test');
coeff_bank_integration_testground;
if errors
    fprintf(2,"ERROR - coeff_bank_integration_test");
else
    disp("Pass - coeff_bank_integration_test");
end

%% receive_blocker
% No dependencies
clear

%open('receive_blocker_test');
receive_blocker_testground;

if any(errors)
    fprintf(2, "ERROR - receive_blocker_test:\n")
    disp(errors)
else
    disp("Pass - receive_blocker_test");
end


%% filter_block
% Depends on current selected filter (sections2order3)
clear 

filter_block_testground;
sim('filter_block_test');
disp("No errors - filter_block_testground - validate the scopes");

%% combiner
% No dependencies
clear

%open('combiner_test');
combiner_testground;

if any(errors)
    fprintf(2, "ERROR - combiner_test:\n")
    disp(errors)
else
    disp("Pass - combiner_test");
end

%% Combining
% Depends on combiner
clear

%open('combining_test');
combining_testground;

if any(errors)
    fprintf(2, "ERROR - combining_test:\n")
    disp(errors)
else
    disp("Pass - combining_test");
end

%% splitter
% No dependencies
clear

%open('splitter_test');
splitter_testground;

if any(errors)
    fprintf(2, "ERROR - splitter_test:\n")
    disp(errors)
else
    disp("Pass - splitter_test");
end

%% to_complex
% No dependencies
clear

%open('to_complex_test');
to_complex_testground;

if any(errors)
    fprintf(2, "ERROR - to_complex_test:\n")
    disp(errors)
else
    disp("Pass - to_complex_test");
end


%% DIG_IF
% Depends on every block (not deprecated ones)
clear

%open('DIG_IF_test');
DIG_IF_testground;

disp("Skip - DIG_IF - Not yet implemented")
%%
disp(" ")
disp("All Done!")