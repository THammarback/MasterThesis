function out = transmit_data(data)
    load('constants.mat', 'transmit_bitwidth');
    out = fi(data, false, transmit_bitwidth, 0);
end

