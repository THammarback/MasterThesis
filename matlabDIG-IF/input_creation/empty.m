function out = empty(n)
    if exist('n', 'var')
        out = repmat(struct('type', 'empty'), n, 1);
    else
        out = struct('type', 'empty');
    end
end