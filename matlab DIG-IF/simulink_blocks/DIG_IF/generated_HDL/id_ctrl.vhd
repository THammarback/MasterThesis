-- -------------------------------------------------------------
-- 
-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\id_ctrl.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: id_ctrl
-- Source Path: DIG_IF_test/DIG_IF/request_buffer/request_orderer/id_ctrl
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DIG_IF_pac.ALL;

ENTITY id_ctrl IS
  PORT( clk                               :   IN    std_logic;
        cancel_valid                      :   IN    std_logic;
        cancel_id                         :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        write_id_bus_id                   :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        write_id_bus_available_valid      :   IN    std_logic;
        write_id_bus_available_address    :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
        read_id_address                   :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
        id_out                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        cancel_out_id                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        cancel_out_valid                  :   OUT   std_logic;
        cancel_out_id_found               :   OUT   std_logic;
        cancel_out_address                :   OUT   std_logic_vector(5 DOWNTO 0)  -- ufix6
        );
END id_ctrl;


ARCHITECTURE rtl OF id_ctrl IS

  -- Component Declarations
  COMPONENT find_id_index
    PORT( ids                             :   IN    vector_of_std_logic_vector16(0 TO 63);  -- uint16 [64]
          id                              :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          valid                           :   IN    std_logic;
          id_found                        :   OUT   std_logic;
          address                         :   OUT   std_logic_vector(5 DOWNTO 0)  -- ufix6
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : find_id_index
    USE ENTITY work.find_id_index(rtl);

  -- Signals
  SIGNAL valid                            : std_logic;
  SIGNAL id                               : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL address                          : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL address_1                        : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL id_1                             : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL id_2                             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL valid_1                          : std_logic;
  SIGNAL Delay_out1 : vector_of_unsigned16(0 TO 63) := (OTHERS => to_unsigned(16#0000#, 16)); -- uint16 [64]
  SIGNAL Assignment2_out1                 : vector_of_unsigned16(0 TO 63);  -- uint16 [64]
  SIGNAL address_2                        : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL address_unsigned                 : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL address_3                        : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Assignment3_out1                 : vector_of_unsigned16(0 TO 63);  -- uint16 [64]
  SIGNAL id_found                         : std_logic;
  SIGNAL Bit_Concat_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Multiport_Switch_out1            : vector_of_unsigned16(0 TO 63);  -- uint16 [64]
  SIGNAL Delay_out1_1                     : vector_of_std_logic_vector16(0 TO 63);  -- ufix16 [64]
  SIGNAL read_id_address_unsigned         : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL address_4                        : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL id_3                             : unsigned(15 DOWNTO 0);  -- uint16

BEGIN
  Ufind_id_index_1 : find_id_index
    PORT MAP( ids => Delay_out1_1,  -- uint16 [64]
              id => id_2,  -- uint16
              valid => valid_1,
              id_found => id_found,
              address => address_2  -- ufix6
              );

  valid <= write_id_bus_available_valid;

  id <= unsigned(write_id_bus_id);

  address <= unsigned(write_id_bus_available_address);

  address_1 <= resize(address, 8);

  id_1 <= unsigned(cancel_id);

  id_2 <= std_logic_vector(id_1);

  valid_1 <= cancel_valid;

  
  Assignment2_out1(0) <= id WHEN address_1 = to_unsigned(16#00#, 8) ELSE
      Delay_out1(0);
  
  Assignment2_out1(1) <= id WHEN address_1 = to_unsigned(16#01#, 8) ELSE
      Delay_out1(1);
  
  Assignment2_out1(2) <= id WHEN address_1 = to_unsigned(16#02#, 8) ELSE
      Delay_out1(2);
  
  Assignment2_out1(3) <= id WHEN address_1 = to_unsigned(16#03#, 8) ELSE
      Delay_out1(3);
  
  Assignment2_out1(4) <= id WHEN address_1 = to_unsigned(16#04#, 8) ELSE
      Delay_out1(4);
  
  Assignment2_out1(5) <= id WHEN address_1 = to_unsigned(16#05#, 8) ELSE
      Delay_out1(5);
  
  Assignment2_out1(6) <= id WHEN address_1 = to_unsigned(16#06#, 8) ELSE
      Delay_out1(6);
  
  Assignment2_out1(7) <= id WHEN address_1 = to_unsigned(16#07#, 8) ELSE
      Delay_out1(7);
  
  Assignment2_out1(8) <= id WHEN address_1 = to_unsigned(16#08#, 8) ELSE
      Delay_out1(8);
  
  Assignment2_out1(9) <= id WHEN address_1 = to_unsigned(16#09#, 8) ELSE
      Delay_out1(9);
  
  Assignment2_out1(10) <= id WHEN address_1 = to_unsigned(16#0A#, 8) ELSE
      Delay_out1(10);
  
  Assignment2_out1(11) <= id WHEN address_1 = to_unsigned(16#0B#, 8) ELSE
      Delay_out1(11);
  
  Assignment2_out1(12) <= id WHEN address_1 = to_unsigned(16#0C#, 8) ELSE
      Delay_out1(12);
  
  Assignment2_out1(13) <= id WHEN address_1 = to_unsigned(16#0D#, 8) ELSE
      Delay_out1(13);
  
  Assignment2_out1(14) <= id WHEN address_1 = to_unsigned(16#0E#, 8) ELSE
      Delay_out1(14);
  
  Assignment2_out1(15) <= id WHEN address_1 = to_unsigned(16#0F#, 8) ELSE
      Delay_out1(15);
  
  Assignment2_out1(16) <= id WHEN address_1 = to_unsigned(16#10#, 8) ELSE
      Delay_out1(16);
  
  Assignment2_out1(17) <= id WHEN address_1 = to_unsigned(16#11#, 8) ELSE
      Delay_out1(17);
  
  Assignment2_out1(18) <= id WHEN address_1 = to_unsigned(16#12#, 8) ELSE
      Delay_out1(18);
  
  Assignment2_out1(19) <= id WHEN address_1 = to_unsigned(16#13#, 8) ELSE
      Delay_out1(19);
  
  Assignment2_out1(20) <= id WHEN address_1 = to_unsigned(16#14#, 8) ELSE
      Delay_out1(20);
  
  Assignment2_out1(21) <= id WHEN address_1 = to_unsigned(16#15#, 8) ELSE
      Delay_out1(21);
  
  Assignment2_out1(22) <= id WHEN address_1 = to_unsigned(16#16#, 8) ELSE
      Delay_out1(22);
  
  Assignment2_out1(23) <= id WHEN address_1 = to_unsigned(16#17#, 8) ELSE
      Delay_out1(23);
  
  Assignment2_out1(24) <= id WHEN address_1 = to_unsigned(16#18#, 8) ELSE
      Delay_out1(24);
  
  Assignment2_out1(25) <= id WHEN address_1 = to_unsigned(16#19#, 8) ELSE
      Delay_out1(25);
  
  Assignment2_out1(26) <= id WHEN address_1 = to_unsigned(16#1A#, 8) ELSE
      Delay_out1(26);
  
  Assignment2_out1(27) <= id WHEN address_1 = to_unsigned(16#1B#, 8) ELSE
      Delay_out1(27);
  
  Assignment2_out1(28) <= id WHEN address_1 = to_unsigned(16#1C#, 8) ELSE
      Delay_out1(28);
  
  Assignment2_out1(29) <= id WHEN address_1 = to_unsigned(16#1D#, 8) ELSE
      Delay_out1(29);
  
  Assignment2_out1(30) <= id WHEN address_1 = to_unsigned(16#1E#, 8) ELSE
      Delay_out1(30);
  
  Assignment2_out1(31) <= id WHEN address_1 = to_unsigned(16#1F#, 8) ELSE
      Delay_out1(31);
  
  Assignment2_out1(32) <= id WHEN address_1 = to_unsigned(16#20#, 8) ELSE
      Delay_out1(32);
  
  Assignment2_out1(33) <= id WHEN address_1 = to_unsigned(16#21#, 8) ELSE
      Delay_out1(33);
  
  Assignment2_out1(34) <= id WHEN address_1 = to_unsigned(16#22#, 8) ELSE
      Delay_out1(34);
  
  Assignment2_out1(35) <= id WHEN address_1 = to_unsigned(16#23#, 8) ELSE
      Delay_out1(35);
  
  Assignment2_out1(36) <= id WHEN address_1 = to_unsigned(16#24#, 8) ELSE
      Delay_out1(36);
  
  Assignment2_out1(37) <= id WHEN address_1 = to_unsigned(16#25#, 8) ELSE
      Delay_out1(37);
  
  Assignment2_out1(38) <= id WHEN address_1 = to_unsigned(16#26#, 8) ELSE
      Delay_out1(38);
  
  Assignment2_out1(39) <= id WHEN address_1 = to_unsigned(16#27#, 8) ELSE
      Delay_out1(39);
  
  Assignment2_out1(40) <= id WHEN address_1 = to_unsigned(16#28#, 8) ELSE
      Delay_out1(40);
  
  Assignment2_out1(41) <= id WHEN address_1 = to_unsigned(16#29#, 8) ELSE
      Delay_out1(41);
  
  Assignment2_out1(42) <= id WHEN address_1 = to_unsigned(16#2A#, 8) ELSE
      Delay_out1(42);
  
  Assignment2_out1(43) <= id WHEN address_1 = to_unsigned(16#2B#, 8) ELSE
      Delay_out1(43);
  
  Assignment2_out1(44) <= id WHEN address_1 = to_unsigned(16#2C#, 8) ELSE
      Delay_out1(44);
  
  Assignment2_out1(45) <= id WHEN address_1 = to_unsigned(16#2D#, 8) ELSE
      Delay_out1(45);
  
  Assignment2_out1(46) <= id WHEN address_1 = to_unsigned(16#2E#, 8) ELSE
      Delay_out1(46);
  
  Assignment2_out1(47) <= id WHEN address_1 = to_unsigned(16#2F#, 8) ELSE
      Delay_out1(47);
  
  Assignment2_out1(48) <= id WHEN address_1 = to_unsigned(16#30#, 8) ELSE
      Delay_out1(48);
  
  Assignment2_out1(49) <= id WHEN address_1 = to_unsigned(16#31#, 8) ELSE
      Delay_out1(49);
  
  Assignment2_out1(50) <= id WHEN address_1 = to_unsigned(16#32#, 8) ELSE
      Delay_out1(50);
  
  Assignment2_out1(51) <= id WHEN address_1 = to_unsigned(16#33#, 8) ELSE
      Delay_out1(51);
  
  Assignment2_out1(52) <= id WHEN address_1 = to_unsigned(16#34#, 8) ELSE
      Delay_out1(52);
  
  Assignment2_out1(53) <= id WHEN address_1 = to_unsigned(16#35#, 8) ELSE
      Delay_out1(53);
  
  Assignment2_out1(54) <= id WHEN address_1 = to_unsigned(16#36#, 8) ELSE
      Delay_out1(54);
  
  Assignment2_out1(55) <= id WHEN address_1 = to_unsigned(16#37#, 8) ELSE
      Delay_out1(55);
  
  Assignment2_out1(56) <= id WHEN address_1 = to_unsigned(16#38#, 8) ELSE
      Delay_out1(56);
  
  Assignment2_out1(57) <= id WHEN address_1 = to_unsigned(16#39#, 8) ELSE
      Delay_out1(57);
  
  Assignment2_out1(58) <= id WHEN address_1 = to_unsigned(16#3A#, 8) ELSE
      Delay_out1(58);
  
  Assignment2_out1(59) <= id WHEN address_1 = to_unsigned(16#3B#, 8) ELSE
      Delay_out1(59);
  
  Assignment2_out1(60) <= id WHEN address_1 = to_unsigned(16#3C#, 8) ELSE
      Delay_out1(60);
  
  Assignment2_out1(61) <= id WHEN address_1 = to_unsigned(16#3D#, 8) ELSE
      Delay_out1(61);
  
  Assignment2_out1(62) <= id WHEN address_1 = to_unsigned(16#3E#, 8) ELSE
      Delay_out1(62);
  
  Assignment2_out1(63) <= id WHEN address_1 = to_unsigned(16#3F#, 8) ELSE
      Delay_out1(63);

  address_unsigned <= unsigned(address_2);

  address_3 <= resize(address_unsigned, 8);

  
  Assignment3_out1(0) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#00#, 8) ELSE
      Delay_out1(0);
  
  Assignment3_out1(1) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#01#, 8) ELSE
      Delay_out1(1);
  
  Assignment3_out1(2) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#02#, 8) ELSE
      Delay_out1(2);
  
  Assignment3_out1(3) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#03#, 8) ELSE
      Delay_out1(3);
  
  Assignment3_out1(4) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#04#, 8) ELSE
      Delay_out1(4);
  
  Assignment3_out1(5) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#05#, 8) ELSE
      Delay_out1(5);
  
  Assignment3_out1(6) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#06#, 8) ELSE
      Delay_out1(6);
  
  Assignment3_out1(7) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#07#, 8) ELSE
      Delay_out1(7);
  
  Assignment3_out1(8) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#08#, 8) ELSE
      Delay_out1(8);
  
  Assignment3_out1(9) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#09#, 8) ELSE
      Delay_out1(9);
  
  Assignment3_out1(10) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#0A#, 8) ELSE
      Delay_out1(10);
  
  Assignment3_out1(11) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#0B#, 8) ELSE
      Delay_out1(11);
  
  Assignment3_out1(12) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#0C#, 8) ELSE
      Delay_out1(12);
  
  Assignment3_out1(13) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#0D#, 8) ELSE
      Delay_out1(13);
  
  Assignment3_out1(14) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#0E#, 8) ELSE
      Delay_out1(14);
  
  Assignment3_out1(15) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#0F#, 8) ELSE
      Delay_out1(15);
  
  Assignment3_out1(16) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#10#, 8) ELSE
      Delay_out1(16);
  
  Assignment3_out1(17) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#11#, 8) ELSE
      Delay_out1(17);
  
  Assignment3_out1(18) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#12#, 8) ELSE
      Delay_out1(18);
  
  Assignment3_out1(19) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#13#, 8) ELSE
      Delay_out1(19);
  
  Assignment3_out1(20) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#14#, 8) ELSE
      Delay_out1(20);
  
  Assignment3_out1(21) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#15#, 8) ELSE
      Delay_out1(21);
  
  Assignment3_out1(22) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#16#, 8) ELSE
      Delay_out1(22);
  
  Assignment3_out1(23) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#17#, 8) ELSE
      Delay_out1(23);
  
  Assignment3_out1(24) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#18#, 8) ELSE
      Delay_out1(24);
  
  Assignment3_out1(25) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#19#, 8) ELSE
      Delay_out1(25);
  
  Assignment3_out1(26) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#1A#, 8) ELSE
      Delay_out1(26);
  
  Assignment3_out1(27) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#1B#, 8) ELSE
      Delay_out1(27);
  
  Assignment3_out1(28) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#1C#, 8) ELSE
      Delay_out1(28);
  
  Assignment3_out1(29) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#1D#, 8) ELSE
      Delay_out1(29);
  
  Assignment3_out1(30) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#1E#, 8) ELSE
      Delay_out1(30);
  
  Assignment3_out1(31) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#1F#, 8) ELSE
      Delay_out1(31);
  
  Assignment3_out1(32) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#20#, 8) ELSE
      Delay_out1(32);
  
  Assignment3_out1(33) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#21#, 8) ELSE
      Delay_out1(33);
  
  Assignment3_out1(34) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#22#, 8) ELSE
      Delay_out1(34);
  
  Assignment3_out1(35) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#23#, 8) ELSE
      Delay_out1(35);
  
  Assignment3_out1(36) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#24#, 8) ELSE
      Delay_out1(36);
  
  Assignment3_out1(37) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#25#, 8) ELSE
      Delay_out1(37);
  
  Assignment3_out1(38) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#26#, 8) ELSE
      Delay_out1(38);
  
  Assignment3_out1(39) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#27#, 8) ELSE
      Delay_out1(39);
  
  Assignment3_out1(40) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#28#, 8) ELSE
      Delay_out1(40);
  
  Assignment3_out1(41) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#29#, 8) ELSE
      Delay_out1(41);
  
  Assignment3_out1(42) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#2A#, 8) ELSE
      Delay_out1(42);
  
  Assignment3_out1(43) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#2B#, 8) ELSE
      Delay_out1(43);
  
  Assignment3_out1(44) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#2C#, 8) ELSE
      Delay_out1(44);
  
  Assignment3_out1(45) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#2D#, 8) ELSE
      Delay_out1(45);
  
  Assignment3_out1(46) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#2E#, 8) ELSE
      Delay_out1(46);
  
  Assignment3_out1(47) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#2F#, 8) ELSE
      Delay_out1(47);
  
  Assignment3_out1(48) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#30#, 8) ELSE
      Delay_out1(48);
  
  Assignment3_out1(49) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#31#, 8) ELSE
      Delay_out1(49);
  
  Assignment3_out1(50) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#32#, 8) ELSE
      Delay_out1(50);
  
  Assignment3_out1(51) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#33#, 8) ELSE
      Delay_out1(51);
  
  Assignment3_out1(52) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#34#, 8) ELSE
      Delay_out1(52);
  
  Assignment3_out1(53) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#35#, 8) ELSE
      Delay_out1(53);
  
  Assignment3_out1(54) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#36#, 8) ELSE
      Delay_out1(54);
  
  Assignment3_out1(55) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#37#, 8) ELSE
      Delay_out1(55);
  
  Assignment3_out1(56) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#38#, 8) ELSE
      Delay_out1(56);
  
  Assignment3_out1(57) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#39#, 8) ELSE
      Delay_out1(57);
  
  Assignment3_out1(58) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#3A#, 8) ELSE
      Delay_out1(58);
  
  Assignment3_out1(59) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#3B#, 8) ELSE
      Delay_out1(59);
  
  Assignment3_out1(60) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#3C#, 8) ELSE
      Delay_out1(60);
  
  Assignment3_out1(61) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#3D#, 8) ELSE
      Delay_out1(61);
  
  Assignment3_out1(62) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#3E#, 8) ELSE
      Delay_out1(62);
  
  Assignment3_out1(63) <= to_unsigned(16#0000#, 16) WHEN address_3 = to_unsigned(16#3F#, 8) ELSE
      Delay_out1(63);

  Bit_Concat_out1 <= unsigned'(valid & id_found);

  Multiport_Switch_output : PROCESS (Assignment2_out1, Assignment3_out1, Bit_Concat_out1, Delay_out1)
  BEGIN
    IF Bit_Concat_out1 = to_unsigned(16#0#, 2) THEN 
      Multiport_Switch_out1 <= Delay_out1;
    ELSIF Bit_Concat_out1 = to_unsigned(16#1#, 2) THEN 
      Multiport_Switch_out1 <= Assignment3_out1;
    ELSE 
      Multiport_Switch_out1 <= Assignment2_out1;
    END IF;
  END PROCESS Multiport_Switch_output;


  Delay_rsvd_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      Delay_out1 <= Multiport_Switch_out1;
    END IF;
  END PROCESS Delay_rsvd_process;


  outputgen: FOR kk IN 0 TO 63 GENERATE
    Delay_out1_1(kk) <= std_logic_vector(Delay_out1(kk));
  END GENERATE;

  read_id_address_unsigned <= unsigned(read_id_address);

  address_4 <= resize(read_id_address_unsigned, 8);

  
  id_3 <= Multiport_Switch_out1(0) WHEN address_4 = to_unsigned(16#00#, 8) ELSE
      Multiport_Switch_out1(1) WHEN address_4 = to_unsigned(16#01#, 8) ELSE
      Multiport_Switch_out1(2) WHEN address_4 = to_unsigned(16#02#, 8) ELSE
      Multiport_Switch_out1(3) WHEN address_4 = to_unsigned(16#03#, 8) ELSE
      Multiport_Switch_out1(4) WHEN address_4 = to_unsigned(16#04#, 8) ELSE
      Multiport_Switch_out1(5) WHEN address_4 = to_unsigned(16#05#, 8) ELSE
      Multiport_Switch_out1(6) WHEN address_4 = to_unsigned(16#06#, 8) ELSE
      Multiport_Switch_out1(7) WHEN address_4 = to_unsigned(16#07#, 8) ELSE
      Multiport_Switch_out1(8) WHEN address_4 = to_unsigned(16#08#, 8) ELSE
      Multiport_Switch_out1(9) WHEN address_4 = to_unsigned(16#09#, 8) ELSE
      Multiport_Switch_out1(10) WHEN address_4 = to_unsigned(16#0A#, 8) ELSE
      Multiport_Switch_out1(11) WHEN address_4 = to_unsigned(16#0B#, 8) ELSE
      Multiport_Switch_out1(12) WHEN address_4 = to_unsigned(16#0C#, 8) ELSE
      Multiport_Switch_out1(13) WHEN address_4 = to_unsigned(16#0D#, 8) ELSE
      Multiport_Switch_out1(14) WHEN address_4 = to_unsigned(16#0E#, 8) ELSE
      Multiport_Switch_out1(15) WHEN address_4 = to_unsigned(16#0F#, 8) ELSE
      Multiport_Switch_out1(16) WHEN address_4 = to_unsigned(16#10#, 8) ELSE
      Multiport_Switch_out1(17) WHEN address_4 = to_unsigned(16#11#, 8) ELSE
      Multiport_Switch_out1(18) WHEN address_4 = to_unsigned(16#12#, 8) ELSE
      Multiport_Switch_out1(19) WHEN address_4 = to_unsigned(16#13#, 8) ELSE
      Multiport_Switch_out1(20) WHEN address_4 = to_unsigned(16#14#, 8) ELSE
      Multiport_Switch_out1(21) WHEN address_4 = to_unsigned(16#15#, 8) ELSE
      Multiport_Switch_out1(22) WHEN address_4 = to_unsigned(16#16#, 8) ELSE
      Multiport_Switch_out1(23) WHEN address_4 = to_unsigned(16#17#, 8) ELSE
      Multiport_Switch_out1(24) WHEN address_4 = to_unsigned(16#18#, 8) ELSE
      Multiport_Switch_out1(25) WHEN address_4 = to_unsigned(16#19#, 8) ELSE
      Multiport_Switch_out1(26) WHEN address_4 = to_unsigned(16#1A#, 8) ELSE
      Multiport_Switch_out1(27) WHEN address_4 = to_unsigned(16#1B#, 8) ELSE
      Multiport_Switch_out1(28) WHEN address_4 = to_unsigned(16#1C#, 8) ELSE
      Multiport_Switch_out1(29) WHEN address_4 = to_unsigned(16#1D#, 8) ELSE
      Multiport_Switch_out1(30) WHEN address_4 = to_unsigned(16#1E#, 8) ELSE
      Multiport_Switch_out1(31) WHEN address_4 = to_unsigned(16#1F#, 8) ELSE
      Multiport_Switch_out1(32) WHEN address_4 = to_unsigned(16#20#, 8) ELSE
      Multiport_Switch_out1(33) WHEN address_4 = to_unsigned(16#21#, 8) ELSE
      Multiport_Switch_out1(34) WHEN address_4 = to_unsigned(16#22#, 8) ELSE
      Multiport_Switch_out1(35) WHEN address_4 = to_unsigned(16#23#, 8) ELSE
      Multiport_Switch_out1(36) WHEN address_4 = to_unsigned(16#24#, 8) ELSE
      Multiport_Switch_out1(37) WHEN address_4 = to_unsigned(16#25#, 8) ELSE
      Multiport_Switch_out1(38) WHEN address_4 = to_unsigned(16#26#, 8) ELSE
      Multiport_Switch_out1(39) WHEN address_4 = to_unsigned(16#27#, 8) ELSE
      Multiport_Switch_out1(40) WHEN address_4 = to_unsigned(16#28#, 8) ELSE
      Multiport_Switch_out1(41) WHEN address_4 = to_unsigned(16#29#, 8) ELSE
      Multiport_Switch_out1(42) WHEN address_4 = to_unsigned(16#2A#, 8) ELSE
      Multiport_Switch_out1(43) WHEN address_4 = to_unsigned(16#2B#, 8) ELSE
      Multiport_Switch_out1(44) WHEN address_4 = to_unsigned(16#2C#, 8) ELSE
      Multiport_Switch_out1(45) WHEN address_4 = to_unsigned(16#2D#, 8) ELSE
      Multiport_Switch_out1(46) WHEN address_4 = to_unsigned(16#2E#, 8) ELSE
      Multiport_Switch_out1(47) WHEN address_4 = to_unsigned(16#2F#, 8) ELSE
      Multiport_Switch_out1(48) WHEN address_4 = to_unsigned(16#30#, 8) ELSE
      Multiport_Switch_out1(49) WHEN address_4 = to_unsigned(16#31#, 8) ELSE
      Multiport_Switch_out1(50) WHEN address_4 = to_unsigned(16#32#, 8) ELSE
      Multiport_Switch_out1(51) WHEN address_4 = to_unsigned(16#33#, 8) ELSE
      Multiport_Switch_out1(52) WHEN address_4 = to_unsigned(16#34#, 8) ELSE
      Multiport_Switch_out1(53) WHEN address_4 = to_unsigned(16#35#, 8) ELSE
      Multiport_Switch_out1(54) WHEN address_4 = to_unsigned(16#36#, 8) ELSE
      Multiport_Switch_out1(55) WHEN address_4 = to_unsigned(16#37#, 8) ELSE
      Multiport_Switch_out1(56) WHEN address_4 = to_unsigned(16#38#, 8) ELSE
      Multiport_Switch_out1(57) WHEN address_4 = to_unsigned(16#39#, 8) ELSE
      Multiport_Switch_out1(58) WHEN address_4 = to_unsigned(16#3A#, 8) ELSE
      Multiport_Switch_out1(59) WHEN address_4 = to_unsigned(16#3B#, 8) ELSE
      Multiport_Switch_out1(60) WHEN address_4 = to_unsigned(16#3C#, 8) ELSE
      Multiport_Switch_out1(61) WHEN address_4 = to_unsigned(16#3D#, 8) ELSE
      Multiport_Switch_out1(62) WHEN address_4 = to_unsigned(16#3E#, 8) ELSE
      Multiport_Switch_out1(63);

  id_out <= std_logic_vector(id_3);

  cancel_out_id <= cancel_id;

  cancel_out_valid <= cancel_valid;

  cancel_out_id_found <= id_found;

  cancel_out_address <= address_2;

END rtl;

