function g = gol_mat_stream(x)
    width = 640;
    w = [
        1 1 0 0 0 1;
        1 0 0 0 0 -1;
        -1 0 0 0 -1 -1;
    ];
    
    [w_height, w_width] = size(w);
    persistent memory;
    persistent extraMemory;
    if isempty(memory) || isempty(extraMemory)
        memory = zeros(w_height-1, width);
        extraMemory = zeros(1, w_width-1);
    end
    
    w_flipped = flip(flip(w,2));
    g = sum([x, extraMemory].*w_flipped(1,:));

    for i=1:w_height-1
        g = g + sum(memory(i, width-w_width+1:width).*w_flipped(i+1,:));
    end
    
    memory = [
        extraMemory(end), memory(1, 1:end-1);
        memory(1:end-1,end), memory(2:end,1:end-1);
    ];

    extraMemory = [x, extraMemory(1:end-1)];
end