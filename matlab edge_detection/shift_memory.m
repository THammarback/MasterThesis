function y = shift_memory(x, height, width)
    
    persistent memory;
    if isempty(memory)
        memory = zeros(height, width);
    end

    y = memory(end, end);
    memory = [
        x, memory(1, 1:end-1);
        memory(1:end-1,end), memory(2:end,1:end-1);
    ];

    
end

