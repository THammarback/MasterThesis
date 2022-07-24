-- -------------------------------------------------------------
-- 

-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\coeff_bank\hdlsrc\coeff_bank_integration_test\fi_splitter_block1.vhd
-- Created: 2022-05-13 10:10:53
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fi_splitter_block1
-- Source Path: coeff_bank_integration_test/coeff_bank/combiner_bank/multiple_rams/rams/fi_splitter
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.coeff_bank_pac.ALL;

ENTITY fi_splitter_block1 IS
  PORT( in_word                           :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        out_arr                           :   OUT   vector_of_std_logic_vector8(0 TO 7)  -- uint8 [8]
        );
END fi_splitter_block1;


ARCHITECTURE rtl OF fi_splitter_block1 IS

  -- Component Declarations
  COMPONENT fi_splitter
    PORT( in_data                         :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          out_rsvd                        :   OUT   vector_of_std_logic_vector8(0 TO 7)  -- uint8 [8]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : fi_splitter
    USE ENTITY work.fi_splitter(rtl);

  -- Signals
  SIGNAL fi_splitter_out1                 : vector_of_std_logic_vector8(0 TO 7);  -- ufix8 [8]

BEGIN
  Ufi_splitter_1_1 : fi_splitter
    PORT MAP( in_data => in_word,  -- ufix64
              out_rsvd => fi_splitter_out1  -- uint8 [8]
              );

  out_arr <= fi_splitter_out1;

END rtl;
