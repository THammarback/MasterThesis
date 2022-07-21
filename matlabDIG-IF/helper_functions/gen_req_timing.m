function [ts, ss] = gen_req_timing(ls, gap, ts0)
    ts = zeros(size(ls));
    ss = zeros(size(ls));
    ts(1) = ts0;
    ss(1) = ts(1)+ls(1);
    if numel(ls)==numel(gap)
        for i=2:numel(ls)
            ts(i) = ss(i-1)+gap(i);
            ss(i) = ts(i)+ls(i);
        end
    else
        for i=2:numel(ls)
            ts(i) = ss(i-1)+gap;
            ss(i) = ts(i)+ls(i);
        end
    end
end