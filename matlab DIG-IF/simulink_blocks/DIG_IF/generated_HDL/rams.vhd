-- -------------------------------------------------------------
-- 
-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\rams.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: rams
-- Source Path: DIG_IF_test/DIG_IF/combiner_bank/multiple_rams/rams
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DIG_IF_pac.ALL;

ENTITY rams IS
  PORT( clk                               :   IN    std_logic;
        wr_data                           :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        wr_addr                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        wr_en                             :   IN    std_logic;
        rd_addr                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        Out1                              :   OUT   vector_of_std_logic_vector8(0 TO 7)  -- uint8 [8]
        );
END rams;


ARCHITECTURE rtl OF rams IS

  -- Component Declarations
  COMPONENT SimpleDualPortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          wr_din : IN std_logic_vector(DataWidth - 1 DOWNTO 0); -- generic width
          wr_addr : IN std_logic_vector(AddrWidth - 1 DOWNTO 0); -- generic width
          wr_en                           :   IN    std_logic;
          rd_addr : IN std_logic_vector(AddrWidth - 1 DOWNTO 0); -- generic width
          rd_dout                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
          );
  END COMPONENT;

  COMPONENT fi_splitter_block1
    PORT( in_word                         :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          out_arr                         :   OUT   vector_of_std_logic_vector8(0 TO 7)  -- uint8 [8]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : SimpleDualPortRAM_generic
    USE ENTITY work.SimpleDualPortRAM_generic(rtl);

  FOR ALL : fi_splitter_block1
    USE ENTITY work.fi_splitter_block1(rtl);

  -- Signals
  SIGNAL Simple_Dual_Port_RAM_System_out1 : std_logic_vector(63 DOWNTO 0);  -- ufix64
  SIGNAL out_rsvd                         : vector_of_std_logic_vector8(0 TO 7);  -- ufix8 [8]

BEGIN
  USimple_Dual_Port_RAM_System : SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => 8,
                 DataWidth => 64
                 )
    PORT MAP( clk => clk,
              wr_din => wr_data,
              wr_addr => wr_addr,
              wr_en => wr_en,
              rd_addr => rd_addr,
              rd_dout => Simple_Dual_Port_RAM_System_out1
              );

  Ufi_splitter : fi_splitter_block1
    PORT MAP( in_word => Simple_Dual_Port_RAM_System_out1,  -- ufix64
              out_arr => out_rsvd  -- uint8 [8]
              );

  Out1 <= out_rsvd;

END rtl;

