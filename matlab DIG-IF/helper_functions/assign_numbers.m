function out = assign_numbers(numbers, ts, ss)
    numbers_was_num = false;
    if ~iscell(numbers)
        numbers_was_num = true;
        numbers = num2cell(numbers);
    end
    indice_list = arrayfun(@(ts, ss) ts:ss, ts, ss, 'uni', false)';
    length = max(ss);
    out = cell(1, length);
    out(:) = {0};
    for i=1:size(indice_list, 2)
       out(indice_list{i}) = mat2cell(numbers{i}.'.*ones(size(indice_list{i})), size(numbers{i}, 2), ones(1, size(indice_list{i}, 2)));
    end
    if numbers_was_num
        out = cell2mat(out);
    end
end

%       out(indice_list{i}) = mat2cell([numbers{i,:}]'.*ones(size(indice_list{i})), size([numbers{i,:}], 2), ones(1, size(indice_list{i}, 2)));
