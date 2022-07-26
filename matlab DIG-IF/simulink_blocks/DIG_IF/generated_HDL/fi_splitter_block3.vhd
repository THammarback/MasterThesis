-- -------------------------------------------------------------
-- 

-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\fi_splitter_block3.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fi_splitter_block3
-- Source Path: DIG_IF_test/DIG_IF/dl_filter_bank/multiple_rams/fi_splitter
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DIG_IF_pac.ALL;

ENTITY fi_splitter_block3 IS
  PORT( in_word                           :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        out_arr                           :   OUT   vector_of_std_logic_vector8(0 TO 1)  -- uint8 [2]
        );
END fi_splitter_block3;


ARCHITECTURE rtl OF fi_splitter_block3 IS

  -- Component Declarations
  COMPONENT fi_splitter_block2
    PORT( in_data                         :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          out_rsvd                        :   OUT   vector_of_std_logic_vector8(0 TO 1)  -- uint8 [2]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : fi_splitter_block2
    USE ENTITY work.fi_splitter_block2(rtl);

  -- Signals
  SIGNAL out_rsvd                         : vector_of_std_logic_vector8(0 TO 1);  -- ufix8 [2]

BEGIN
  Ufi_splitter_3 : fi_splitter_block2
    PORT MAP( in_data => in_word,  -- uint16
              out_rsvd => out_rsvd  -- uint8 [2]
              );

  out_arr <= out_rsvd;

END rtl;

