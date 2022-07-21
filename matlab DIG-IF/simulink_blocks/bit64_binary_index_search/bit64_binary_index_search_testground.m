%% bit64_binary_index_search_test
verbose = true;
bitwidth = log2(64);

bit64_binary_index_search_test_input = logical([
    % Note indexing starts at 1 and MSB on RHS compared
    % to simulink where MSB on LHS and index start at 0
  randi(2, 1, 64)-1; %Random
  zeros(1, 64); %Empty
  ones(1, 64); %Full
  ones(1, 64); %Full but one
  false, ones(1, 63);  %MSB available
  ones(1, 63), false;  %LSB available
]);

fourth_address = 17; %randi(64);
bit64_binary_index_search_test_input(4, fourth_address) = false;

% sim
stop_time = size(bit64_binary_index_search_test_input, 1)-1;
out = sim('bit64_binary_index_search_test.slx');

% validate
errors = ~[
    out.found_any(1);
    out.found_any(2) && out.address(2) == 63;
    ~out.found_any(3) && out.address(3) == 0;
    out.found_any(4) && all(dec2bin(digitrevorder(fourth_address-1,2),bitwidth) == dec2bin(out.address(4), bitwidth));
    out.found_any(5) && out.address(5) == 0;
    out.found_any(6) && out.address(6) == 63;    
];

if verbose && any(errors)
    disp("ERROR: See 'errors' variable");
    disp(errors');
end
