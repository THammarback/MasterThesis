function out = make_input(varargin)
    index = sum(cellfun(@numel, varargin));
    for i = numel(varargin):-1:1
        for j = numel(varargin{i}):-1:1
            out(index) = struct('type', 'make', ...
                'set_coeff', set_coeff(false), ...
                'req_base', req_base(false), ...
                'req_cancel', req_cancel(false), ...
                'set_ti', set_ti(false));
            switch varargin{i}(j).type 
                case 'make'
                    out(index) = varargin{i}(j);
                case 'empty'
                otherwise
                    out(index).(varargin{i}(j).type) = varargin{i}(j);                   
            end
            index = index-1; % iterate backwards to preallocate
        end
    end
end

