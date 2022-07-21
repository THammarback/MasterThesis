function out = req_cancel(id)
    load('constants.mat', 'id_bitwidth')
    if(islogical(id) && ~id)
        out = struct('type', 'req_cancel', 'valid', false, 'id', fi(0, false, id_bitwidth, 0));
    else
        out = struct('type', 'req_cancel', 'valid', true, 'id', fi(id, false, id_bitwidth, 0));
    end
end

