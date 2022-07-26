-- -------------------------------------------------------------
-- 

-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\ul_filter_bank.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ul_filter_bank
-- Source Path: DIG_IF_test/DIG_IF/ul_filter_bank
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DIG_IF_pac.ALL;

ENTITY ul_filter_bank IS
  PORT( clk                               :   IN    std_logic;
        wr_data                           :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        wr_addr                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        wr_en                             :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
        rd_addr                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        coeff_out                         :   OUT   vector_of_std_logic_vector8(0 TO 9)  -- uint8 [10]
        );
END ul_filter_bank;


ARCHITECTURE rtl OF ul_filter_bank IS

  -- Component Declarations
  COMPONENT multiple_rams_block2
    PORT( clk                             :   IN    std_logic;
          wr_data                         :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          wr_addr                         :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          wr_en                           :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          rd_addr                         :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          coeff_out                       :   OUT   vector_of_std_logic_vector8(0 TO 9)  -- uint8 [10]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : multiple_rams_block2
    USE ENTITY work.multiple_rams_block2(rtl);

  -- Signals
  SIGNAL multiple_rams_out1               : vector_of_std_logic_vector8(0 TO 9);  -- ufix8 [10]

BEGIN
  -- 1) Add Subsystem or Model blocks as valid variant choices.
  -- 2) You cannot connect blocks at this level. At simulation, connectivity is automatically 
  -- determined, based on the active variant and port name matching.

  Umultiple_rams_3 : multiple_rams_block2
    PORT MAP( clk => clk,
              wr_data => wr_data,  -- ufix64
              wr_addr => wr_addr,  -- uint8
              wr_en => wr_en,  -- ufix3
              rd_addr => rd_addr,  -- uint8
              coeff_out => multiple_rams_out1  -- uint8 [10]
              );

  coeff_out <= multiple_rams_out1;

END rtl;

