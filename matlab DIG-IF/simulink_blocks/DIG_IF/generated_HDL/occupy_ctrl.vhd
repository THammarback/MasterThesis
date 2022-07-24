-- -------------------------------------------------------------
-- 

-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\occupy_ctrl.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: occupy_ctrl
-- Source Path: DIG_IF_test/DIG_IF/request_buffer/request_orderer/occupy_ctrl
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY occupy_ctrl IS
  PORT( clk                               :   IN    std_logic;
        cancel_in_id                      :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        cancel_in_valid                   :   IN    std_logic;
        cancel_in_id_found                :   IN    std_logic;
        cancel_in_address                 :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
        valid_in                          :   IN    std_logic;
        read_occupy_bus                   :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
        errors_mem_full                   :   OUT   std_logic;
        errors_id_not_found_valid         :   OUT   std_logic;
        errors_id_not_found_id            :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        occupied_out                      :   OUT   std_logic;
        write_bus_valid                   :   OUT   std_logic;
        write_bus_address                 :   OUT   std_logic_vector(5 DOWNTO 0)  -- ufix6
        );
END occupy_ctrl;


ARCHITECTURE rtl OF occupy_ctrl IS

  -- Component Declarations
  COMPONENT find_available_index
    PORT( in_rsvd                         :   IN    std_logic_vector(0 TO 63);  -- boolean [64]
          address                         :   OUT   std_logic_vector(5 DOWNTO 0);  -- ufix6
          found_any                       :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : find_available_index
    USE ENTITY work.find_available_index(rtl);

  -- Signals
  SIGNAL id_found                         : std_logic;
  SIGNAL Bit_Concat1_out1                 : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL NOT1_out1                        : std_logic;
  SIGNAL address                          : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL address_1                        : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Delay_out1                       : std_logic_vector(0 TO 63) := (OTHERS => '0');  -- boolean [64]
  SIGNAL Assignment3_out1                 : std_logic_vector(0 TO 63);  -- boolean [64]
  SIGNAL address_2                        : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL address_unsigned                 : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL address_3                        : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Assignment2_out1                 : std_logic_vector(0 TO 63);  -- boolean [64]
  SIGNAL Multiport_Switch1_out1           : std_logic_vector(0 TO 63);  -- boolean [64]
  SIGNAL find_available_index_out2        : std_logic;
  SIGNAL NOT_out1                         : std_logic;
  SIGNAL mem_full                         : std_logic;
  SIGNAL Selector_out1                    : std_logic;
  SIGNAL NAND_out1                        : std_logic;
  SIGNAL valid                            : std_logic;
  SIGNAL valid_1                          : std_logic;
  SIGNAL id                               : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL read_occupy_bus_unsigned         : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL address_4                        : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Selector2_out1                   : std_logic;
  SIGNAL valid_2                          : std_logic;

BEGIN
  Ufind_available_index_1 : find_available_index
    PORT MAP( in_rsvd => Delay_out1,  -- boolean [64]
              address => address_2,  -- ufix6
              found_any => find_available_index_out2
              );

  id_found <= cancel_in_id_found;

  Bit_Concat1_out1 <= unsigned'(id_found & valid_in);

  NOT1_out1 <=  NOT id_found;

  address <= unsigned(cancel_in_address);

  address_1 <= resize(address, 8);

  
  Assignment3_out1(0) <= NOT1_out1 WHEN address_1 = to_unsigned(16#00#, 8) ELSE
      Delay_out1(0);
  
  Assignment3_out1(1) <= NOT1_out1 WHEN address_1 = to_unsigned(16#01#, 8) ELSE
      Delay_out1(1);
  
  Assignment3_out1(2) <= NOT1_out1 WHEN address_1 = to_unsigned(16#02#, 8) ELSE
      Delay_out1(2);
  
  Assignment3_out1(3) <= NOT1_out1 WHEN address_1 = to_unsigned(16#03#, 8) ELSE
      Delay_out1(3);
  
  Assignment3_out1(4) <= NOT1_out1 WHEN address_1 = to_unsigned(16#04#, 8) ELSE
      Delay_out1(4);
  
  Assignment3_out1(5) <= NOT1_out1 WHEN address_1 = to_unsigned(16#05#, 8) ELSE
      Delay_out1(5);
  
  Assignment3_out1(6) <= NOT1_out1 WHEN address_1 = to_unsigned(16#06#, 8) ELSE
      Delay_out1(6);
  
  Assignment3_out1(7) <= NOT1_out1 WHEN address_1 = to_unsigned(16#07#, 8) ELSE
      Delay_out1(7);
  
  Assignment3_out1(8) <= NOT1_out1 WHEN address_1 = to_unsigned(16#08#, 8) ELSE
      Delay_out1(8);
  
  Assignment3_out1(9) <= NOT1_out1 WHEN address_1 = to_unsigned(16#09#, 8) ELSE
      Delay_out1(9);
  
  Assignment3_out1(10) <= NOT1_out1 WHEN address_1 = to_unsigned(16#0A#, 8) ELSE
      Delay_out1(10);
  
  Assignment3_out1(11) <= NOT1_out1 WHEN address_1 = to_unsigned(16#0B#, 8) ELSE
      Delay_out1(11);
  
  Assignment3_out1(12) <= NOT1_out1 WHEN address_1 = to_unsigned(16#0C#, 8) ELSE
      Delay_out1(12);
  
  Assignment3_out1(13) <= NOT1_out1 WHEN address_1 = to_unsigned(16#0D#, 8) ELSE
      Delay_out1(13);
  
  Assignment3_out1(14) <= NOT1_out1 WHEN address_1 = to_unsigned(16#0E#, 8) ELSE
      Delay_out1(14);
  
  Assignment3_out1(15) <= NOT1_out1 WHEN address_1 = to_unsigned(16#0F#, 8) ELSE
      Delay_out1(15);
  
  Assignment3_out1(16) <= NOT1_out1 WHEN address_1 = to_unsigned(16#10#, 8) ELSE
      Delay_out1(16);
  
  Assignment3_out1(17) <= NOT1_out1 WHEN address_1 = to_unsigned(16#11#, 8) ELSE
      Delay_out1(17);
  
  Assignment3_out1(18) <= NOT1_out1 WHEN address_1 = to_unsigned(16#12#, 8) ELSE
      Delay_out1(18);
  
  Assignment3_out1(19) <= NOT1_out1 WHEN address_1 = to_unsigned(16#13#, 8) ELSE
      Delay_out1(19);
  
  Assignment3_out1(20) <= NOT1_out1 WHEN address_1 = to_unsigned(16#14#, 8) ELSE
      Delay_out1(20);
  
  Assignment3_out1(21) <= NOT1_out1 WHEN address_1 = to_unsigned(16#15#, 8) ELSE
      Delay_out1(21);
  
  Assignment3_out1(22) <= NOT1_out1 WHEN address_1 = to_unsigned(16#16#, 8) ELSE
      Delay_out1(22);
  
  Assignment3_out1(23) <= NOT1_out1 WHEN address_1 = to_unsigned(16#17#, 8) ELSE
      Delay_out1(23);
  
  Assignment3_out1(24) <= NOT1_out1 WHEN address_1 = to_unsigned(16#18#, 8) ELSE
      Delay_out1(24);
  
  Assignment3_out1(25) <= NOT1_out1 WHEN address_1 = to_unsigned(16#19#, 8) ELSE
      Delay_out1(25);
  
  Assignment3_out1(26) <= NOT1_out1 WHEN address_1 = to_unsigned(16#1A#, 8) ELSE
      Delay_out1(26);
  
  Assignment3_out1(27) <= NOT1_out1 WHEN address_1 = to_unsigned(16#1B#, 8) ELSE
      Delay_out1(27);
  
  Assignment3_out1(28) <= NOT1_out1 WHEN address_1 = to_unsigned(16#1C#, 8) ELSE
      Delay_out1(28);
  
  Assignment3_out1(29) <= NOT1_out1 WHEN address_1 = to_unsigned(16#1D#, 8) ELSE
      Delay_out1(29);
  
  Assignment3_out1(30) <= NOT1_out1 WHEN address_1 = to_unsigned(16#1E#, 8) ELSE
      Delay_out1(30);
  
  Assignment3_out1(31) <= NOT1_out1 WHEN address_1 = to_unsigned(16#1F#, 8) ELSE
      Delay_out1(31);
  
  Assignment3_out1(32) <= NOT1_out1 WHEN address_1 = to_unsigned(16#20#, 8) ELSE
      Delay_out1(32);
  
  Assignment3_out1(33) <= NOT1_out1 WHEN address_1 = to_unsigned(16#21#, 8) ELSE
      Delay_out1(33);
  
  Assignment3_out1(34) <= NOT1_out1 WHEN address_1 = to_unsigned(16#22#, 8) ELSE
      Delay_out1(34);
  
  Assignment3_out1(35) <= NOT1_out1 WHEN address_1 = to_unsigned(16#23#, 8) ELSE
      Delay_out1(35);
  
  Assignment3_out1(36) <= NOT1_out1 WHEN address_1 = to_unsigned(16#24#, 8) ELSE
      Delay_out1(36);
  
  Assignment3_out1(37) <= NOT1_out1 WHEN address_1 = to_unsigned(16#25#, 8) ELSE
      Delay_out1(37);
  
  Assignment3_out1(38) <= NOT1_out1 WHEN address_1 = to_unsigned(16#26#, 8) ELSE
      Delay_out1(38);
  
  Assignment3_out1(39) <= NOT1_out1 WHEN address_1 = to_unsigned(16#27#, 8) ELSE
      Delay_out1(39);
  
  Assignment3_out1(40) <= NOT1_out1 WHEN address_1 = to_unsigned(16#28#, 8) ELSE
      Delay_out1(40);
  
  Assignment3_out1(41) <= NOT1_out1 WHEN address_1 = to_unsigned(16#29#, 8) ELSE
      Delay_out1(41);
  
  Assignment3_out1(42) <= NOT1_out1 WHEN address_1 = to_unsigned(16#2A#, 8) ELSE
      Delay_out1(42);
  
  Assignment3_out1(43) <= NOT1_out1 WHEN address_1 = to_unsigned(16#2B#, 8) ELSE
      Delay_out1(43);
  
  Assignment3_out1(44) <= NOT1_out1 WHEN address_1 = to_unsigned(16#2C#, 8) ELSE
      Delay_out1(44);
  
  Assignment3_out1(45) <= NOT1_out1 WHEN address_1 = to_unsigned(16#2D#, 8) ELSE
      Delay_out1(45);
  
  Assignment3_out1(46) <= NOT1_out1 WHEN address_1 = to_unsigned(16#2E#, 8) ELSE
      Delay_out1(46);
  
  Assignment3_out1(47) <= NOT1_out1 WHEN address_1 = to_unsigned(16#2F#, 8) ELSE
      Delay_out1(47);
  
  Assignment3_out1(48) <= NOT1_out1 WHEN address_1 = to_unsigned(16#30#, 8) ELSE
      Delay_out1(48);
  
  Assignment3_out1(49) <= NOT1_out1 WHEN address_1 = to_unsigned(16#31#, 8) ELSE
      Delay_out1(49);
  
  Assignment3_out1(50) <= NOT1_out1 WHEN address_1 = to_unsigned(16#32#, 8) ELSE
      Delay_out1(50);
  
  Assignment3_out1(51) <= NOT1_out1 WHEN address_1 = to_unsigned(16#33#, 8) ELSE
      Delay_out1(51);
  
  Assignment3_out1(52) <= NOT1_out1 WHEN address_1 = to_unsigned(16#34#, 8) ELSE
      Delay_out1(52);
  
  Assignment3_out1(53) <= NOT1_out1 WHEN address_1 = to_unsigned(16#35#, 8) ELSE
      Delay_out1(53);
  
  Assignment3_out1(54) <= NOT1_out1 WHEN address_1 = to_unsigned(16#36#, 8) ELSE
      Delay_out1(54);
  
  Assignment3_out1(55) <= NOT1_out1 WHEN address_1 = to_unsigned(16#37#, 8) ELSE
      Delay_out1(55);
  
  Assignment3_out1(56) <= NOT1_out1 WHEN address_1 = to_unsigned(16#38#, 8) ELSE
      Delay_out1(56);
  
  Assignment3_out1(57) <= NOT1_out1 WHEN address_1 = to_unsigned(16#39#, 8) ELSE
      Delay_out1(57);
  
  Assignment3_out1(58) <= NOT1_out1 WHEN address_1 = to_unsigned(16#3A#, 8) ELSE
      Delay_out1(58);
  
  Assignment3_out1(59) <= NOT1_out1 WHEN address_1 = to_unsigned(16#3B#, 8) ELSE
      Delay_out1(59);
  
  Assignment3_out1(60) <= NOT1_out1 WHEN address_1 = to_unsigned(16#3C#, 8) ELSE
      Delay_out1(60);
  
  Assignment3_out1(61) <= NOT1_out1 WHEN address_1 = to_unsigned(16#3D#, 8) ELSE
      Delay_out1(61);
  
  Assignment3_out1(62) <= NOT1_out1 WHEN address_1 = to_unsigned(16#3E#, 8) ELSE
      Delay_out1(62);
  
  Assignment3_out1(63) <= NOT1_out1 WHEN address_1 = to_unsigned(16#3F#, 8) ELSE
      Delay_out1(63);

  address_unsigned <= unsigned(address_2);

  address_3 <= resize(address_unsigned, 8);

  
  Assignment2_out1(0) <= valid_in WHEN address_3 = to_unsigned(16#00#, 8) ELSE
      Delay_out1(0);
  
  Assignment2_out1(1) <= valid_in WHEN address_3 = to_unsigned(16#01#, 8) ELSE
      Delay_out1(1);
  
  Assignment2_out1(2) <= valid_in WHEN address_3 = to_unsigned(16#02#, 8) ELSE
      Delay_out1(2);
  
  Assignment2_out1(3) <= valid_in WHEN address_3 = to_unsigned(16#03#, 8) ELSE
      Delay_out1(3);
  
  Assignment2_out1(4) <= valid_in WHEN address_3 = to_unsigned(16#04#, 8) ELSE
      Delay_out1(4);
  
  Assignment2_out1(5) <= valid_in WHEN address_3 = to_unsigned(16#05#, 8) ELSE
      Delay_out1(5);
  
  Assignment2_out1(6) <= valid_in WHEN address_3 = to_unsigned(16#06#, 8) ELSE
      Delay_out1(6);
  
  Assignment2_out1(7) <= valid_in WHEN address_3 = to_unsigned(16#07#, 8) ELSE
      Delay_out1(7);
  
  Assignment2_out1(8) <= valid_in WHEN address_3 = to_unsigned(16#08#, 8) ELSE
      Delay_out1(8);
  
  Assignment2_out1(9) <= valid_in WHEN address_3 = to_unsigned(16#09#, 8) ELSE
      Delay_out1(9);
  
  Assignment2_out1(10) <= valid_in WHEN address_3 = to_unsigned(16#0A#, 8) ELSE
      Delay_out1(10);
  
  Assignment2_out1(11) <= valid_in WHEN address_3 = to_unsigned(16#0B#, 8) ELSE
      Delay_out1(11);
  
  Assignment2_out1(12) <= valid_in WHEN address_3 = to_unsigned(16#0C#, 8) ELSE
      Delay_out1(12);
  
  Assignment2_out1(13) <= valid_in WHEN address_3 = to_unsigned(16#0D#, 8) ELSE
      Delay_out1(13);
  
  Assignment2_out1(14) <= valid_in WHEN address_3 = to_unsigned(16#0E#, 8) ELSE
      Delay_out1(14);
  
  Assignment2_out1(15) <= valid_in WHEN address_3 = to_unsigned(16#0F#, 8) ELSE
      Delay_out1(15);
  
  Assignment2_out1(16) <= valid_in WHEN address_3 = to_unsigned(16#10#, 8) ELSE
      Delay_out1(16);
  
  Assignment2_out1(17) <= valid_in WHEN address_3 = to_unsigned(16#11#, 8) ELSE
      Delay_out1(17);
  
  Assignment2_out1(18) <= valid_in WHEN address_3 = to_unsigned(16#12#, 8) ELSE
      Delay_out1(18);
  
  Assignment2_out1(19) <= valid_in WHEN address_3 = to_unsigned(16#13#, 8) ELSE
      Delay_out1(19);
  
  Assignment2_out1(20) <= valid_in WHEN address_3 = to_unsigned(16#14#, 8) ELSE
      Delay_out1(20);
  
  Assignment2_out1(21) <= valid_in WHEN address_3 = to_unsigned(16#15#, 8) ELSE
      Delay_out1(21);
  
  Assignment2_out1(22) <= valid_in WHEN address_3 = to_unsigned(16#16#, 8) ELSE
      Delay_out1(22);
  
  Assignment2_out1(23) <= valid_in WHEN address_3 = to_unsigned(16#17#, 8) ELSE
      Delay_out1(23);
  
  Assignment2_out1(24) <= valid_in WHEN address_3 = to_unsigned(16#18#, 8) ELSE
      Delay_out1(24);
  
  Assignment2_out1(25) <= valid_in WHEN address_3 = to_unsigned(16#19#, 8) ELSE
      Delay_out1(25);
  
  Assignment2_out1(26) <= valid_in WHEN address_3 = to_unsigned(16#1A#, 8) ELSE
      Delay_out1(26);
  
  Assignment2_out1(27) <= valid_in WHEN address_3 = to_unsigned(16#1B#, 8) ELSE
      Delay_out1(27);
  
  Assignment2_out1(28) <= valid_in WHEN address_3 = to_unsigned(16#1C#, 8) ELSE
      Delay_out1(28);
  
  Assignment2_out1(29) <= valid_in WHEN address_3 = to_unsigned(16#1D#, 8) ELSE
      Delay_out1(29);
  
  Assignment2_out1(30) <= valid_in WHEN address_3 = to_unsigned(16#1E#, 8) ELSE
      Delay_out1(30);
  
  Assignment2_out1(31) <= valid_in WHEN address_3 = to_unsigned(16#1F#, 8) ELSE
      Delay_out1(31);
  
  Assignment2_out1(32) <= valid_in WHEN address_3 = to_unsigned(16#20#, 8) ELSE
      Delay_out1(32);
  
  Assignment2_out1(33) <= valid_in WHEN address_3 = to_unsigned(16#21#, 8) ELSE
      Delay_out1(33);
  
  Assignment2_out1(34) <= valid_in WHEN address_3 = to_unsigned(16#22#, 8) ELSE
      Delay_out1(34);
  
  Assignment2_out1(35) <= valid_in WHEN address_3 = to_unsigned(16#23#, 8) ELSE
      Delay_out1(35);
  
  Assignment2_out1(36) <= valid_in WHEN address_3 = to_unsigned(16#24#, 8) ELSE
      Delay_out1(36);
  
  Assignment2_out1(37) <= valid_in WHEN address_3 = to_unsigned(16#25#, 8) ELSE
      Delay_out1(37);
  
  Assignment2_out1(38) <= valid_in WHEN address_3 = to_unsigned(16#26#, 8) ELSE
      Delay_out1(38);
  
  Assignment2_out1(39) <= valid_in WHEN address_3 = to_unsigned(16#27#, 8) ELSE
      Delay_out1(39);
  
  Assignment2_out1(40) <= valid_in WHEN address_3 = to_unsigned(16#28#, 8) ELSE
      Delay_out1(40);
  
  Assignment2_out1(41) <= valid_in WHEN address_3 = to_unsigned(16#29#, 8) ELSE
      Delay_out1(41);
  
  Assignment2_out1(42) <= valid_in WHEN address_3 = to_unsigned(16#2A#, 8) ELSE
      Delay_out1(42);
  
  Assignment2_out1(43) <= valid_in WHEN address_3 = to_unsigned(16#2B#, 8) ELSE
      Delay_out1(43);
  
  Assignment2_out1(44) <= valid_in WHEN address_3 = to_unsigned(16#2C#, 8) ELSE
      Delay_out1(44);
  
  Assignment2_out1(45) <= valid_in WHEN address_3 = to_unsigned(16#2D#, 8) ELSE
      Delay_out1(45);
  
  Assignment2_out1(46) <= valid_in WHEN address_3 = to_unsigned(16#2E#, 8) ELSE
      Delay_out1(46);
  
  Assignment2_out1(47) <= valid_in WHEN address_3 = to_unsigned(16#2F#, 8) ELSE
      Delay_out1(47);
  
  Assignment2_out1(48) <= valid_in WHEN address_3 = to_unsigned(16#30#, 8) ELSE
      Delay_out1(48);
  
  Assignment2_out1(49) <= valid_in WHEN address_3 = to_unsigned(16#31#, 8) ELSE
      Delay_out1(49);
  
  Assignment2_out1(50) <= valid_in WHEN address_3 = to_unsigned(16#32#, 8) ELSE
      Delay_out1(50);
  
  Assignment2_out1(51) <= valid_in WHEN address_3 = to_unsigned(16#33#, 8) ELSE
      Delay_out1(51);
  
  Assignment2_out1(52) <= valid_in WHEN address_3 = to_unsigned(16#34#, 8) ELSE
      Delay_out1(52);
  
  Assignment2_out1(53) <= valid_in WHEN address_3 = to_unsigned(16#35#, 8) ELSE
      Delay_out1(53);
  
  Assignment2_out1(54) <= valid_in WHEN address_3 = to_unsigned(16#36#, 8) ELSE
      Delay_out1(54);
  
  Assignment2_out1(55) <= valid_in WHEN address_3 = to_unsigned(16#37#, 8) ELSE
      Delay_out1(55);
  
  Assignment2_out1(56) <= valid_in WHEN address_3 = to_unsigned(16#38#, 8) ELSE
      Delay_out1(56);
  
  Assignment2_out1(57) <= valid_in WHEN address_3 = to_unsigned(16#39#, 8) ELSE
      Delay_out1(57);
  
  Assignment2_out1(58) <= valid_in WHEN address_3 = to_unsigned(16#3A#, 8) ELSE
      Delay_out1(58);
  
  Assignment2_out1(59) <= valid_in WHEN address_3 = to_unsigned(16#3B#, 8) ELSE
      Delay_out1(59);
  
  Assignment2_out1(60) <= valid_in WHEN address_3 = to_unsigned(16#3C#, 8) ELSE
      Delay_out1(60);
  
  Assignment2_out1(61) <= valid_in WHEN address_3 = to_unsigned(16#3D#, 8) ELSE
      Delay_out1(61);
  
  Assignment2_out1(62) <= valid_in WHEN address_3 = to_unsigned(16#3E#, 8) ELSE
      Delay_out1(62);
  
  Assignment2_out1(63) <= valid_in WHEN address_3 = to_unsigned(16#3F#, 8) ELSE
      Delay_out1(63);

  Multiport_Switch1_output : PROCESS (Assignment2_out1, Assignment3_out1, Bit_Concat1_out1, Delay_out1)
  BEGIN
    IF Bit_Concat1_out1 = to_unsigned(16#0#, 2) THEN 
      Multiport_Switch1_out1 <= Delay_out1;
    ELSIF Bit_Concat1_out1 = to_unsigned(16#1#, 2) THEN 
      Multiport_Switch1_out1 <= Assignment2_out1;
    ELSE 
      Multiport_Switch1_out1 <= Assignment3_out1;
    END IF;
  END PROCESS Multiport_Switch1_output;


  Delay_rsvd_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      Delay_out1 <= Multiport_Switch1_out1;
    END IF;
  END PROCESS Delay_rsvd_process;


  NOT_out1 <=  NOT find_available_index_out2;

  mem_full <= valid_in AND NOT_out1;

  
  Selector_out1 <= Delay_out1(0) WHEN address_1 = to_unsigned(16#00#, 8) ELSE
      Delay_out1(1) WHEN address_1 = to_unsigned(16#01#, 8) ELSE
      Delay_out1(2) WHEN address_1 = to_unsigned(16#02#, 8) ELSE
      Delay_out1(3) WHEN address_1 = to_unsigned(16#03#, 8) ELSE
      Delay_out1(4) WHEN address_1 = to_unsigned(16#04#, 8) ELSE
      Delay_out1(5) WHEN address_1 = to_unsigned(16#05#, 8) ELSE
      Delay_out1(6) WHEN address_1 = to_unsigned(16#06#, 8) ELSE
      Delay_out1(7) WHEN address_1 = to_unsigned(16#07#, 8) ELSE
      Delay_out1(8) WHEN address_1 = to_unsigned(16#08#, 8) ELSE
      Delay_out1(9) WHEN address_1 = to_unsigned(16#09#, 8) ELSE
      Delay_out1(10) WHEN address_1 = to_unsigned(16#0A#, 8) ELSE
      Delay_out1(11) WHEN address_1 = to_unsigned(16#0B#, 8) ELSE
      Delay_out1(12) WHEN address_1 = to_unsigned(16#0C#, 8) ELSE
      Delay_out1(13) WHEN address_1 = to_unsigned(16#0D#, 8) ELSE
      Delay_out1(14) WHEN address_1 = to_unsigned(16#0E#, 8) ELSE
      Delay_out1(15) WHEN address_1 = to_unsigned(16#0F#, 8) ELSE
      Delay_out1(16) WHEN address_1 = to_unsigned(16#10#, 8) ELSE
      Delay_out1(17) WHEN address_1 = to_unsigned(16#11#, 8) ELSE
      Delay_out1(18) WHEN address_1 = to_unsigned(16#12#, 8) ELSE
      Delay_out1(19) WHEN address_1 = to_unsigned(16#13#, 8) ELSE
      Delay_out1(20) WHEN address_1 = to_unsigned(16#14#, 8) ELSE
      Delay_out1(21) WHEN address_1 = to_unsigned(16#15#, 8) ELSE
      Delay_out1(22) WHEN address_1 = to_unsigned(16#16#, 8) ELSE
      Delay_out1(23) WHEN address_1 = to_unsigned(16#17#, 8) ELSE
      Delay_out1(24) WHEN address_1 = to_unsigned(16#18#, 8) ELSE
      Delay_out1(25) WHEN address_1 = to_unsigned(16#19#, 8) ELSE
      Delay_out1(26) WHEN address_1 = to_unsigned(16#1A#, 8) ELSE
      Delay_out1(27) WHEN address_1 = to_unsigned(16#1B#, 8) ELSE
      Delay_out1(28) WHEN address_1 = to_unsigned(16#1C#, 8) ELSE
      Delay_out1(29) WHEN address_1 = to_unsigned(16#1D#, 8) ELSE
      Delay_out1(30) WHEN address_1 = to_unsigned(16#1E#, 8) ELSE
      Delay_out1(31) WHEN address_1 = to_unsigned(16#1F#, 8) ELSE
      Delay_out1(32) WHEN address_1 = to_unsigned(16#20#, 8) ELSE
      Delay_out1(33) WHEN address_1 = to_unsigned(16#21#, 8) ELSE
      Delay_out1(34) WHEN address_1 = to_unsigned(16#22#, 8) ELSE
      Delay_out1(35) WHEN address_1 = to_unsigned(16#23#, 8) ELSE
      Delay_out1(36) WHEN address_1 = to_unsigned(16#24#, 8) ELSE
      Delay_out1(37) WHEN address_1 = to_unsigned(16#25#, 8) ELSE
      Delay_out1(38) WHEN address_1 = to_unsigned(16#26#, 8) ELSE
      Delay_out1(39) WHEN address_1 = to_unsigned(16#27#, 8) ELSE
      Delay_out1(40) WHEN address_1 = to_unsigned(16#28#, 8) ELSE
      Delay_out1(41) WHEN address_1 = to_unsigned(16#29#, 8) ELSE
      Delay_out1(42) WHEN address_1 = to_unsigned(16#2A#, 8) ELSE
      Delay_out1(43) WHEN address_1 = to_unsigned(16#2B#, 8) ELSE
      Delay_out1(44) WHEN address_1 = to_unsigned(16#2C#, 8) ELSE
      Delay_out1(45) WHEN address_1 = to_unsigned(16#2D#, 8) ELSE
      Delay_out1(46) WHEN address_1 = to_unsigned(16#2E#, 8) ELSE
      Delay_out1(47) WHEN address_1 = to_unsigned(16#2F#, 8) ELSE
      Delay_out1(48) WHEN address_1 = to_unsigned(16#30#, 8) ELSE
      Delay_out1(49) WHEN address_1 = to_unsigned(16#31#, 8) ELSE
      Delay_out1(50) WHEN address_1 = to_unsigned(16#32#, 8) ELSE
      Delay_out1(51) WHEN address_1 = to_unsigned(16#33#, 8) ELSE
      Delay_out1(52) WHEN address_1 = to_unsigned(16#34#, 8) ELSE
      Delay_out1(53) WHEN address_1 = to_unsigned(16#35#, 8) ELSE
      Delay_out1(54) WHEN address_1 = to_unsigned(16#36#, 8) ELSE
      Delay_out1(55) WHEN address_1 = to_unsigned(16#37#, 8) ELSE
      Delay_out1(56) WHEN address_1 = to_unsigned(16#38#, 8) ELSE
      Delay_out1(57) WHEN address_1 = to_unsigned(16#39#, 8) ELSE
      Delay_out1(58) WHEN address_1 = to_unsigned(16#3A#, 8) ELSE
      Delay_out1(59) WHEN address_1 = to_unsigned(16#3B#, 8) ELSE
      Delay_out1(60) WHEN address_1 = to_unsigned(16#3C#, 8) ELSE
      Delay_out1(61) WHEN address_1 = to_unsigned(16#3D#, 8) ELSE
      Delay_out1(62) WHEN address_1 = to_unsigned(16#3E#, 8) ELSE
      Delay_out1(63);

  NAND_out1 <=  NOT (Selector_out1 AND id_found);

  valid <= cancel_in_valid;

  valid_1 <= NAND_out1 AND valid;

  id <= unsigned(cancel_in_id);

  errors_id_not_found_id <= std_logic_vector(id);

  read_occupy_bus_unsigned <= unsigned(read_occupy_bus);

  address_4 <= resize(read_occupy_bus_unsigned, 8);

  
  Selector2_out1 <= Multiport_Switch1_out1(0) WHEN address_4 = to_unsigned(16#00#, 8) ELSE
      Multiport_Switch1_out1(1) WHEN address_4 = to_unsigned(16#01#, 8) ELSE
      Multiport_Switch1_out1(2) WHEN address_4 = to_unsigned(16#02#, 8) ELSE
      Multiport_Switch1_out1(3) WHEN address_4 = to_unsigned(16#03#, 8) ELSE
      Multiport_Switch1_out1(4) WHEN address_4 = to_unsigned(16#04#, 8) ELSE
      Multiport_Switch1_out1(5) WHEN address_4 = to_unsigned(16#05#, 8) ELSE
      Multiport_Switch1_out1(6) WHEN address_4 = to_unsigned(16#06#, 8) ELSE
      Multiport_Switch1_out1(7) WHEN address_4 = to_unsigned(16#07#, 8) ELSE
      Multiport_Switch1_out1(8) WHEN address_4 = to_unsigned(16#08#, 8) ELSE
      Multiport_Switch1_out1(9) WHEN address_4 = to_unsigned(16#09#, 8) ELSE
      Multiport_Switch1_out1(10) WHEN address_4 = to_unsigned(16#0A#, 8) ELSE
      Multiport_Switch1_out1(11) WHEN address_4 = to_unsigned(16#0B#, 8) ELSE
      Multiport_Switch1_out1(12) WHEN address_4 = to_unsigned(16#0C#, 8) ELSE
      Multiport_Switch1_out1(13) WHEN address_4 = to_unsigned(16#0D#, 8) ELSE
      Multiport_Switch1_out1(14) WHEN address_4 = to_unsigned(16#0E#, 8) ELSE
      Multiport_Switch1_out1(15) WHEN address_4 = to_unsigned(16#0F#, 8) ELSE
      Multiport_Switch1_out1(16) WHEN address_4 = to_unsigned(16#10#, 8) ELSE
      Multiport_Switch1_out1(17) WHEN address_4 = to_unsigned(16#11#, 8) ELSE
      Multiport_Switch1_out1(18) WHEN address_4 = to_unsigned(16#12#, 8) ELSE
      Multiport_Switch1_out1(19) WHEN address_4 = to_unsigned(16#13#, 8) ELSE
      Multiport_Switch1_out1(20) WHEN address_4 = to_unsigned(16#14#, 8) ELSE
      Multiport_Switch1_out1(21) WHEN address_4 = to_unsigned(16#15#, 8) ELSE
      Multiport_Switch1_out1(22) WHEN address_4 = to_unsigned(16#16#, 8) ELSE
      Multiport_Switch1_out1(23) WHEN address_4 = to_unsigned(16#17#, 8) ELSE
      Multiport_Switch1_out1(24) WHEN address_4 = to_unsigned(16#18#, 8) ELSE
      Multiport_Switch1_out1(25) WHEN address_4 = to_unsigned(16#19#, 8) ELSE
      Multiport_Switch1_out1(26) WHEN address_4 = to_unsigned(16#1A#, 8) ELSE
      Multiport_Switch1_out1(27) WHEN address_4 = to_unsigned(16#1B#, 8) ELSE
      Multiport_Switch1_out1(28) WHEN address_4 = to_unsigned(16#1C#, 8) ELSE
      Multiport_Switch1_out1(29) WHEN address_4 = to_unsigned(16#1D#, 8) ELSE
      Multiport_Switch1_out1(30) WHEN address_4 = to_unsigned(16#1E#, 8) ELSE
      Multiport_Switch1_out1(31) WHEN address_4 = to_unsigned(16#1F#, 8) ELSE
      Multiport_Switch1_out1(32) WHEN address_4 = to_unsigned(16#20#, 8) ELSE
      Multiport_Switch1_out1(33) WHEN address_4 = to_unsigned(16#21#, 8) ELSE
      Multiport_Switch1_out1(34) WHEN address_4 = to_unsigned(16#22#, 8) ELSE
      Multiport_Switch1_out1(35) WHEN address_4 = to_unsigned(16#23#, 8) ELSE
      Multiport_Switch1_out1(36) WHEN address_4 = to_unsigned(16#24#, 8) ELSE
      Multiport_Switch1_out1(37) WHEN address_4 = to_unsigned(16#25#, 8) ELSE
      Multiport_Switch1_out1(38) WHEN address_4 = to_unsigned(16#26#, 8) ELSE
      Multiport_Switch1_out1(39) WHEN address_4 = to_unsigned(16#27#, 8) ELSE
      Multiport_Switch1_out1(40) WHEN address_4 = to_unsigned(16#28#, 8) ELSE
      Multiport_Switch1_out1(41) WHEN address_4 = to_unsigned(16#29#, 8) ELSE
      Multiport_Switch1_out1(42) WHEN address_4 = to_unsigned(16#2A#, 8) ELSE
      Multiport_Switch1_out1(43) WHEN address_4 = to_unsigned(16#2B#, 8) ELSE
      Multiport_Switch1_out1(44) WHEN address_4 = to_unsigned(16#2C#, 8) ELSE
      Multiport_Switch1_out1(45) WHEN address_4 = to_unsigned(16#2D#, 8) ELSE
      Multiport_Switch1_out1(46) WHEN address_4 = to_unsigned(16#2E#, 8) ELSE
      Multiport_Switch1_out1(47) WHEN address_4 = to_unsigned(16#2F#, 8) ELSE
      Multiport_Switch1_out1(48) WHEN address_4 = to_unsigned(16#30#, 8) ELSE
      Multiport_Switch1_out1(49) WHEN address_4 = to_unsigned(16#31#, 8) ELSE
      Multiport_Switch1_out1(50) WHEN address_4 = to_unsigned(16#32#, 8) ELSE
      Multiport_Switch1_out1(51) WHEN address_4 = to_unsigned(16#33#, 8) ELSE
      Multiport_Switch1_out1(52) WHEN address_4 = to_unsigned(16#34#, 8) ELSE
      Multiport_Switch1_out1(53) WHEN address_4 = to_unsigned(16#35#, 8) ELSE
      Multiport_Switch1_out1(54) WHEN address_4 = to_unsigned(16#36#, 8) ELSE
      Multiport_Switch1_out1(55) WHEN address_4 = to_unsigned(16#37#, 8) ELSE
      Multiport_Switch1_out1(56) WHEN address_4 = to_unsigned(16#38#, 8) ELSE
      Multiport_Switch1_out1(57) WHEN address_4 = to_unsigned(16#39#, 8) ELSE
      Multiport_Switch1_out1(58) WHEN address_4 = to_unsigned(16#3A#, 8) ELSE
      Multiport_Switch1_out1(59) WHEN address_4 = to_unsigned(16#3B#, 8) ELSE
      Multiport_Switch1_out1(60) WHEN address_4 = to_unsigned(16#3C#, 8) ELSE
      Multiport_Switch1_out1(61) WHEN address_4 = to_unsigned(16#3D#, 8) ELSE
      Multiport_Switch1_out1(62) WHEN address_4 = to_unsigned(16#3E#, 8) ELSE
      Multiport_Switch1_out1(63);

  valid_2 <= valid_in AND find_available_index_out2;

  errors_mem_full <= mem_full;

  errors_id_not_found_valid <= valid_1;

  occupied_out <= Selector2_out1;

  write_bus_valid <= valid_2;

  write_bus_address <= address_2;

END rtl;
