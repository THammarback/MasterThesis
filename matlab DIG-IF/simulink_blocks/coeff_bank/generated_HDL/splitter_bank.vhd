-- -------------------------------------------------------------
-- 

-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\coeff_bank\hdlsrc\coeff_bank_integration_test\splitter_bank.vhd
-- Created: 2022-05-13 10:10:53
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: splitter_bank
-- Source Path: coeff_bank_integration_test/coeff_bank/splitter_bank
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.coeff_bank_pac.ALL;

ENTITY splitter_bank IS
  PORT( clk                               :   IN    std_logic;
        enb                               :   IN    std_logic;
        wr_data                           :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        wr_addr                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        wr_en                             :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
        rd_addr                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        coeff_out                         :   OUT   vector_of_std_logic_vector8(0 TO 15)  -- uint8 [16]
        );
END splitter_bank;


ARCHITECTURE rtl OF splitter_bank IS

  -- Component Declarations
  COMPONENT multiple_rams_block1
    PORT( clk                             :   IN    std_logic;
          enb                             :   IN    std_logic;
          wr_data                         :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          wr_addr                         :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          wr_en                           :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          rd_addr                         :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          coeff_out                       :   OUT   vector_of_std_logic_vector8(0 TO 15)  -- uint8 [16]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : multiple_rams_block1
    USE ENTITY work.multiple_rams_block1(rtl);

  -- Signals
  SIGNAL multiple_rams_out1               : vector_of_std_logic_vector8(0 TO 15);  -- ufix8 [16]

BEGIN
  -- 1) Add Subsystem or Model blocks as valid variant choices.
  -- 2) You cannot connect blocks at this level. At simulation, connectivity is automatically 
  -- determined, based on the active variant and port name matching.

  Umultiple_rams_2 : multiple_rams_block1
    PORT MAP( clk => clk,
              enb => enb,
              wr_data => wr_data,  -- ufix64
              wr_addr => wr_addr,  -- uint8
              wr_en => wr_en,  -- ufix3
              rd_addr => rd_addr,  -- uint8
              coeff_out => multiple_rams_out1  -- uint8 [16]
              );

  coeff_out <= multiple_rams_out1;

END rtl;
