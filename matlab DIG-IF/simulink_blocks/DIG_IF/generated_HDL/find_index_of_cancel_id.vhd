-- -------------------------------------------------------------
-- 

-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\find_index_of_cancel_id.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: find_index_of_cancel_id

-- Source Path: DIG_IF_test/DIG_IF/request_buffer/request_orderer/id_ctrl/find_id_index/find index of cancel id
-- Hierarchy Level: 5
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY find_index_of_cancel_id IS
  GENERIC( iter                           : integer := 0
           );
  PORT( id                                :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        ids                               :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        indexes                           :   OUT   std_logic_vector(5 DOWNTO 0);  -- ufix6
        any                               :   OUT   std_logic
        );
END find_index_of_cancel_id;


ARCHITECTURE rtl OF find_index_of_cancel_id IS

  -- Signals
  SIGNAL ids_unsigned                     : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL id_unsigned                      : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Equal_relop1                     : std_logic;
  SIGNAL Constant1_out1                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch_out1                      : unsigned(5 DOWNTO 0);  -- ufix6

BEGIN
  ids_unsigned <= unsigned(ids);

  id_unsigned <= unsigned(id);

  
  Equal_relop1 <= '1' WHEN ids_unsigned = id_unsigned ELSE
      '0';

  Constant1_out1 <= to_unsigned(iter, 6);

  
  Switch_out1 <= to_unsigned(16#00#, 6) WHEN Equal_relop1 = '0' ELSE
      Constant1_out1;

  indexes <= std_logic_vector(Switch_out1);

  any <= Equal_relop1;

END rtl;

