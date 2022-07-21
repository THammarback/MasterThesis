load('setup/constants.mat', 'ul_filter_attribs', 'bank_bitwidth', 'coeff_ram_bitwidth');

coeff_num = ul_filter_attribs.coeff_num;
coeff_bitwidth = ul_filter_attribs.coeff_bitwidth;
coeff_complex = ul_filter_attribs.complex;
data_rows = ul_filter_attribs.data_rows;
address_bitwidth = bank_bitwidth;
row_bitwidth = coeff_ram_bitwidth;

inputs = 4;
stop_time = inputs+inputs * coeff_bitwidth*coeff_num*(1+coeff_complex)/row_bitwidth;
addresses_in = 0:inputs-1;% randperm(inputs)-1;

%input_coeffs = randi(2^coeff_bitwidth, inputs, coeff_num)-1+1i*coeff_complex*randi(2^coeff_bitwidth, inputs, coeff_num)-1i*coeff_complex;
input_coeffs = reshape(0:(coeff_num*inputs)-1, coeff_num, [])'+1i*coeff_complex*reshape(1:2:(2*coeff_num*inputs)-1, coeff_num, [])';
if coeff_complex
    input_coeffs_together = zeros(inputs, 2*coeff_num);
    input_coeffs_together(:,1:2:end) = real(input_coeffs);
    input_coeffs_together(:,2:2:end) = imag(input_coeffs);
else
    input_coeffs_together = input_coeffs;
end
coeff_bit_line = reshape(padarray(input_coeffs_together, [0, row_bitwidth/coeff_bitwidth-mod(size(input_coeffs_together, 2), row_bitwidth/coeff_bitwidth)], 'post')', row_bitwidth/coeff_bitwidth, [])';

data_row_input = arrayfun(@(rowIndex) bitconcat(fi(coeff_bit_line(rowIndex,:), false, coeff_bitwidth, 0)), 1:size(coeff_bit_line, 1)).';
                            
valid_input = fi(repmat((1:data_rows).', inputs, 1), false, ceil(log2(data_rows))+1, 0);
address_input = fi(reshape((addresses_in' * ones(1, ceil(coeff_bitwidth*coeff_num*(1+coeff_complex)/row_bitwidth))).', [], 1), false, address_bitwidth, 0);
read_addresses = fi(zeros(inputs*coeff_bitwidth*coeff_num*(1+coeff_complex)/row_bitwidth, 1), false, address_bitwidth, 0);

read_addresses = [read_addresses; addresses_in'];
%open('coeff_bank_simple_test');
out = sim('coeff_bank_simple_test');

errors = any(any(out.coeffs(end-inputs+1:end,:) ~= input_coeffs_together));



