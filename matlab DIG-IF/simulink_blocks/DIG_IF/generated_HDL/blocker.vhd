-- -------------------------------------------------------------
-- 
-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\blocker.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: blocker
-- Source Path: DIG_IF_test/DIG_IF/blocker
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DIG_IF_pac.ALL;

ENTITY blocker IS
  PORT( receive_ctrl_bus_valid            :   IN    std_logic;
        data_in_re                        :   IN    vector_of_std_logic_vector4(0 TO 7);  -- ufix4 [8]
        data_in_im                        :   IN    vector_of_std_logic_vector4(0 TO 7);  -- ufix4 [8]
        data_out_re                       :   OUT   vector_of_std_logic_vector4(0 TO 7);  -- ufix4 [8]
        data_out_im                       :   OUT   vector_of_std_logic_vector4(0 TO 7)  -- ufix4 [8]
        );
END blocker;


ARCHITECTURE rtl OF blocker IS

  -- Signals
  SIGNAL valid                            : std_logic;
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL zero_out1_re                     : vector_of_unsigned4(0 TO 7);  -- ufix4 [8]
  SIGNAL zero_out1_im                     : vector_of_unsigned4(0 TO 7);  -- ufix4 [8]
  SIGNAL data_in_re_unsigned              : vector_of_unsigned4(0 TO 7);  -- ufix4 [8]
  SIGNAL data_in_im_unsigned              : vector_of_unsigned4(0 TO 7);  -- ufix4 [8]
  SIGNAL Switch_out1_re                   : vector_of_unsigned4(0 TO 7);  -- ufix4 [8]
  SIGNAL Switch_out1_im                   : vector_of_unsigned4(0 TO 7);  -- ufix4 [8]

BEGIN
  valid <= receive_ctrl_bus_valid;

  
  switch_compare_1 <= '1' WHEN valid > '0' ELSE
      '0';

  zero_out1_re(0) <= to_unsigned(16#0#, 4);
  zero_out1_im(0) <= to_unsigned(16#0#, 4);
  zero_out1_re(1) <= to_unsigned(16#0#, 4);
  zero_out1_im(1) <= to_unsigned(16#0#, 4);
  zero_out1_re(2) <= to_unsigned(16#0#, 4);
  zero_out1_im(2) <= to_unsigned(16#0#, 4);
  zero_out1_re(3) <= to_unsigned(16#0#, 4);
  zero_out1_im(3) <= to_unsigned(16#0#, 4);
  zero_out1_re(4) <= to_unsigned(16#0#, 4);
  zero_out1_im(4) <= to_unsigned(16#0#, 4);
  zero_out1_re(5) <= to_unsigned(16#0#, 4);
  zero_out1_im(5) <= to_unsigned(16#0#, 4);
  zero_out1_re(6) <= to_unsigned(16#0#, 4);
  zero_out1_im(6) <= to_unsigned(16#0#, 4);
  zero_out1_re(7) <= to_unsigned(16#0#, 4);
  zero_out1_im(7) <= to_unsigned(16#0#, 4);

  outputgen3: FOR kk IN 0 TO 7 GENERATE
    data_in_re_unsigned(kk) <= unsigned(data_in_re(kk));
  END GENERATE;

  outputgen2: FOR kk IN 0 TO 7 GENERATE
    data_in_im_unsigned(kk) <= unsigned(data_in_im(kk));
  END GENERATE;

  
  Switch_out1_re <= zero_out1_re WHEN switch_compare_1 = '0' ELSE
      data_in_re_unsigned;
  
  Switch_out1_im <= zero_out1_im WHEN switch_compare_1 = '0' ELSE
      data_in_im_unsigned;

  outputgen1: FOR kk IN 0 TO 7 GENERATE
    data_out_re(kk) <= std_logic_vector(Switch_out1_re(kk));
  END GENERATE;

  outputgen: FOR kk IN 0 TO 7 GENERATE
    data_out_im(kk) <= std_logic_vector(Switch_out1_im(kk));
  END GENERATE;

END rtl;
