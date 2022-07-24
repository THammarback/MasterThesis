-- -------------------------------------------------------------
-- 

-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\fi_splitter_block2.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fi_splitter_block2
-- Source Path: DIG_IF_test/DIG_IF/dl_filter_bank/multiple_rams/fi_splitter/fi_splitter
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DIG_IF_pac.ALL;

ENTITY fi_splitter_block2 IS
  PORT( in_data                           :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        out_rsvd                          :   OUT   vector_of_std_logic_vector8(0 TO 1)  -- uint8 [2]
        );
END fi_splitter_block2;


ARCHITECTURE rtl OF fi_splitter_block2 IS

  -- Signals
  SIGNAL in_data_unsigned                 : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL out_tmp                          : vector_of_unsigned8(0 TO 1);  -- uint8 [2]

BEGIN
  in_data_unsigned <= unsigned(in_data);

  fi_splitter_output : PROCESS (in_data_unsigned)
    VARIABLE in_data1 : unsigned(15 DOWNTO 0);
  BEGIN
    --MATLAB Function 'DIG_IF/dl_filter_bank/multiple_rams/fi_splitter/fi_splitter'
    in_data1 := in_data_unsigned;
    out_tmp(1) <= in_data1(7 DOWNTO 0);
    out_tmp(0) <= in_data1(15 DOWNTO 8);
  END PROCESS fi_splitter_output;


  outputgen: FOR kk IN 0 TO 1 GENERATE
    out_rsvd(kk) <= std_logic_vector(out_tmp(kk));
  END GENERATE;

END rtl;

