load('constants.mat', 'type_bitwidth', 'error_bitwidth');

types = {
% Origin BB
  % Requests
    'NOTHING', 0;
    'REQ', 1;
    'REQ_UC', 2;
    'REQ_UT', 3;
    'REQ_SEND', 4;
  % Transmit
    'TRANSMIT', 5;
    
  % Other
    'SET_TI', 6;
    'SET_DL_FILTER', 7;
    'SET_UL_FILTER', 8;
    'SET_COMBINER', 9;
    'SET_SPLITTER', 10;
    'CANCEL_REQ', 11;
% Origin DIG-IF
  % Responses
    'RES', 12;
    'RES_UC', 13;
    'RES_UT', 14;
    'FETCH', 15;
        
    'ACK_REQ', 16;
    'ACK_UC_REQ', 17;
    'ACK_UT_REQ', 18;
    'ACK_SEND', 19;
    'FAIL', 20;
    'ACK_TRANSMIT', 21;

  % Other
    'ACK_CANCEL_REQ', 22;
    'ACK_TI', 23;
    'ACK_DL_FILTER', 24;
    'ACK_UL_FILTER', 25
    'ACK_COMBINER', 26;
    'ACK_SPLITTER', 27;
}';
types(2:2:end) = num2cell(fi(cell2mat(types(2:2:end)),0,type_bitwidth,0));
types = struct(types{:});

errors = {
    'NO_ERROR', 0;
    'OVERLAP', 1;
    'TIMING_OUT_OF_BOUND', 2;
    'TRANSMIT_WAIT_TIMEOUT', 3;
    'ID_NOT_FOUND', 4; 
}';
errors(2:2:end) = num2cell(fi(cell2mat(errors(2:2:end)),0,error_bitwidth,0));
errors = struct(errors{:});

save('setup/types.mat', 'types', 'errors');