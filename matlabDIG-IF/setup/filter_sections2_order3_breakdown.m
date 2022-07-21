%% 2 section order 3 filter breakdown
function filter_coeffs = filter_sections2_order3_breakdown(filter)
filter_coeffs = [
    filter.ScaleValues(1); %1  s(1)
    filter.sosMatrix(1,5); %2  a(2)(1)
    filter.sosMatrix(1,6); %3  a(3)(1)
    filter.sosMatrix(1,2); %4  b(2)(1)
    filter.sosMatrix(1,3); %5  b(3)(1)
    filter.ScaleValues(2); %6  s(2)
    filter.sosMatrix(2,5); %7  a(2)(2)
    filter.sosMatrix(2,6); %8  a(3)(2)
    filter.sosMatrix(2,2); %9  b(2)(2)
    filter.sosMatrix(2,3); %10 b(3)(2)  
];