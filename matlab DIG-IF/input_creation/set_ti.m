function out = set_ti(data)
    load('constants.mat', 'ts_bitwidth')
    if islogical(data) && ~data
        out = struct('type', 'set_ti', 'valid', false, 'ti', fi(0, false, ts_bitwidth, 0));
    else
        out = struct('type', 'set_ti', 'valid', true, 'ti', fi(data, false, ts_bitwidth, 0));
    end
end
