%% find_id_index
bitwidth = 16;
max_id = 2^bitwidth-1;
req_mem_size = 64;
id_num = 10;
stop_time = id_num-1;
id = randi(max_id, id_num, 1)-1;
id_address = randi(req_mem_size, id_num, 1);

needle_id = fi(id,0,bitwidth,0);

valid_id = true(id_num, 1);
valid_id(2) = false;
valid_id(6) = false;

haystack_ids = randi(max_id, id_num, req_mem_size);
for i=1:id_num
    haystack_ids(i,id_address(i)) = id(i);
end
haystack_ids(2, id_address(2)) = (id(2)==1)+1;
out = sim('find_id_index_test.slx');

%validate
errors = ~out.address == id_address-1 & ~out.error_id_not_found;
errors(2) = out.error_id_not_found(2);
if any(errors)
   disp("ERROR: see errors variable");
end
