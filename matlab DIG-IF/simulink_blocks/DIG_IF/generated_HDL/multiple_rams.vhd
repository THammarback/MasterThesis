-- -------------------------------------------------------------
-- 

-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\multiple_rams.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: multiple_rams
-- Source Path: DIG_IF_test/DIG_IF/combiner_bank/multiple_rams
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DIG_IF_pac.ALL;

ENTITY multiple_rams IS
  PORT( clk                               :   IN    std_logic;
        wr_data                           :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        wr_addr                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        wr_en                             :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
        rd_addr                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        coeff_out                         :   OUT   vector_of_std_logic_vector8(0 TO 63)  -- uint8 [64]
        );
END multiple_rams;


ARCHITECTURE rtl OF multiple_rams IS

  -- Component Declarations
  COMPONENT rams
    PORT( clk                             :   IN    std_logic;
          wr_data                         :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          wr_addr                         :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          Out1                            :   OUT   vector_of_std_logic_vector8(0 TO 7)  -- uint8 [8]
          );
  END COMPONENT;

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

  COMPONENT fi_splitter_block
    PORT( in_word                         :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          out_arr                         :   OUT   vector_of_std_logic_vector8(0 TO 7)  -- uint8 [8]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : rams
    USE ENTITY work.rams(rtl);

  FOR ALL : SimpleDualPortRAM_generic
    USE ENTITY work.SimpleDualPortRAM_generic(rtl);

  FOR ALL : fi_splitter_block
    USE ENTITY work.fi_splitter_block(rtl);

  -- Constants
  CONSTANT b0                             : vector_of_unsigned9(0 TO 6) := 
    (to_unsigned(16#001#, 9), to_unsigned(16#002#, 9), to_unsigned(16#003#, 9), to_unsigned(16#004#, 9), 
      to_unsigned(16#005#, 9), to_unsigned(16#006#, 9), to_unsigned(16#007#, 9)); -- ufix9 [7]

  -- Signals
  SIGNAL wr_en_unsigned                   : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL first_rams_cmps_out1             : std_logic_vector(0 TO 6);  -- boolean [7]
  SIGNAL rams_out1                        : vector_of_std_logic_vector8(0 TO 55);  -- ufix8 [56]
  SIGNAL wr_data_unsigned                 : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL Extract_Bits2_out1               : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL last_ram_cmp_out1                : std_logic;
  SIGNAL Simple_Dual_Port_RAM_System_out1 : std_logic_vector(63 DOWNTO 0);  -- ufix64
  SIGNAL out_rsvd                         : vector_of_std_logic_vector8(0 TO 7);  -- ufix8 [8]
  SIGNAL Mux_out1                         : vector_of_std_logic_vector8(0 TO 63);  -- ufix8 [64]

BEGIN
  USimple_Dual_Port_RAM_System_1 : SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => 8,
                 DataWidth => 64
                 )
    PORT MAP( clk => clk,
              wr_din => std_logic_vector(Extract_Bits2_out1),
              wr_addr => wr_addr,
              wr_en => last_ram_cmp_out1,
              rd_addr => rd_addr,
              rd_dout => Simple_Dual_Port_RAM_System_out1
              );

  Ufi_splitter_2 : fi_splitter_block
    PORT MAP( in_word => Simple_Dual_Port_RAM_System_out1,  -- ufix64
              out_arr => out_rsvd  -- uint8 [8]
              );

  wr_en_unsigned <= unsigned(wr_en);


  first_rams_cmps_out1_gen: FOR t_0 IN 0 TO 6 GENERATE
    
    first_rams_cmps_out1(t_0) <= '1' WHEN wr_en_unsigned = b0(t_0) ELSE
        '0';
  END GENERATE first_rams_cmps_out1_gen;


  GEN_LABEL: FOR kk IN 0 TO 6 GENERATE
    Urams_1 : rams
      PORT MAP( clk => clk,
                wr_data => wr_data,  -- ufix64
                wr_addr => wr_addr,  -- uint8
                wr_en => first_rams_cmps_out1(kk),
                rd_addr => rd_addr,  -- uint8
                Out1 => rams_out1(8*kk TO 8*(kk+1) - 1)  -- uint8 [8]
                );
  END GENERATE;

  wr_data_unsigned <= unsigned(wr_data);

  Extract_Bits2_out1 <= wr_data_unsigned;

  
  last_ram_cmp_out1 <= '1' WHEN wr_en_unsigned = to_unsigned(16#008#, 9) ELSE
      '0';

  Mux_out1(0) <= rams_out1(0);
  Mux_out1(1) <= rams_out1(1);
  Mux_out1(2) <= rams_out1(2);
  Mux_out1(3) <= rams_out1(3);
  Mux_out1(4) <= rams_out1(4);
  Mux_out1(5) <= rams_out1(5);
  Mux_out1(6) <= rams_out1(6);
  Mux_out1(7) <= rams_out1(7);
  Mux_out1(8) <= rams_out1(8);
  Mux_out1(9) <= rams_out1(9);
  Mux_out1(10) <= rams_out1(10);
  Mux_out1(11) <= rams_out1(11);
  Mux_out1(12) <= rams_out1(12);
  Mux_out1(13) <= rams_out1(13);
  Mux_out1(14) <= rams_out1(14);
  Mux_out1(15) <= rams_out1(15);
  Mux_out1(16) <= rams_out1(16);
  Mux_out1(17) <= rams_out1(17);
  Mux_out1(18) <= rams_out1(18);
  Mux_out1(19) <= rams_out1(19);
  Mux_out1(20) <= rams_out1(20);
  Mux_out1(21) <= rams_out1(21);
  Mux_out1(22) <= rams_out1(22);
  Mux_out1(23) <= rams_out1(23);
  Mux_out1(24) <= rams_out1(24);
  Mux_out1(25) <= rams_out1(25);
  Mux_out1(26) <= rams_out1(26);
  Mux_out1(27) <= rams_out1(27);
  Mux_out1(28) <= rams_out1(28);
  Mux_out1(29) <= rams_out1(29);
  Mux_out1(30) <= rams_out1(30);
  Mux_out1(31) <= rams_out1(31);
  Mux_out1(32) <= rams_out1(32);
  Mux_out1(33) <= rams_out1(33);
  Mux_out1(34) <= rams_out1(34);
  Mux_out1(35) <= rams_out1(35);
  Mux_out1(36) <= rams_out1(36);
  Mux_out1(37) <= rams_out1(37);
  Mux_out1(38) <= rams_out1(38);
  Mux_out1(39) <= rams_out1(39);
  Mux_out1(40) <= rams_out1(40);
  Mux_out1(41) <= rams_out1(41);
  Mux_out1(42) <= rams_out1(42);
  Mux_out1(43) <= rams_out1(43);
  Mux_out1(44) <= rams_out1(44);
  Mux_out1(45) <= rams_out1(45);
  Mux_out1(46) <= rams_out1(46);
  Mux_out1(47) <= rams_out1(47);
  Mux_out1(48) <= rams_out1(48);
  Mux_out1(49) <= rams_out1(49);
  Mux_out1(50) <= rams_out1(50);
  Mux_out1(51) <= rams_out1(51);
  Mux_out1(52) <= rams_out1(52);
  Mux_out1(53) <= rams_out1(53);
  Mux_out1(54) <= rams_out1(54);
  Mux_out1(55) <= rams_out1(55);
  Mux_out1(56) <= out_rsvd(0);
  Mux_out1(57) <= out_rsvd(1);
  Mux_out1(58) <= out_rsvd(2);
  Mux_out1(59) <= out_rsvd(3);
  Mux_out1(60) <= out_rsvd(4);
  Mux_out1(61) <= out_rsvd(5);
  Mux_out1(62) <= out_rsvd(6);
  Mux_out1(63) <= out_rsvd(7);

  coeff_out <= Mux_out1;

END rtl;

