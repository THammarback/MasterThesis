function out = assign_booleans(booleans, ts, ss)
    indice_list = arrayfun(@(ts, ss) ts:ss, ts, ss, 'uni', false)';
    length = max(ss);
    out = false(1, length);
    out(cell2mat(indice_list)) = cell2mat(arrayfun(@(bool, indices) bool & true(size(indices{:})), booleans, indice_list, 'uni', false));
end