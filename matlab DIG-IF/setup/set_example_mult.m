load('constants.mat', 'combiner_attribs', 'splitter_attribs', 'antenna_num', 'stream_num');

%% Filters
sos_filters = load('sos_filters.mat');
%filterDesigner
example_dl_filter_banks = {
    filter_sections2_order3_breakdown(sos_filters.DL_filter1);
    filter_sections2_order3_breakdown(sos_filters.DL_filter2);
    filter_sections2_order3_breakdown(sos_filters.DL_filter3);
    filter_sections2_order3_breakdown(sos_filters.DL_filter4);
    filter_sections2_order3_breakdown(sos_filters.DL_filter5);
    filter_sections2_order3_breakdown(sos_filters.DL_filter6);
    filter_sections2_order3_breakdown(sos_filters.DL_filter7);
    filter_sections2_order3_breakdown(sos_filters.DL_filter8);
};
example_ul_filter_banks = {
    filter_sections2_order3_breakdown(sos_filters.UL_filter1);
    filter_sections2_order3_breakdown(sos_filters.UL_filter2);
};

%% Combiners
example_combiner_banks = {
    eye(stream_num, antenna_num)+2i*eye(stream_num, antenna_num);
    randi(combiner_attribs.complex*2^combiner_attribs.coeff_bitwidth, stream_num, antenna_num)+1i*randi(combiner_attribs.complex*2^combiner_attribs.coeff_bitwidth, stream_num, antenna_num)-1-1i*combiner_attribs.complex
};

%% Spliters
example_splitter_banks = {
    [1 zeros(1, antenna_num-1)]+1i*[1 zeros(1, antenna_num-1)];
    randi(splitter_attribs.complex*2^splitter_attribs.coeff_bitwidth, 1, splitter_attribs.coeff_num)+1i*randi(splitter_attribs.complex*2^splitter_attribs.coeff_bitwidth, 1, splitter_attribs.coeff_num)-1-1i*splitter_attribs.complex
};

%% Save
save('setup/example_mult.mat', 'example_dl_filter_banks', 'example_ul_filter_banks', 'example_combiner_banks', 'example_splitter_banks');

