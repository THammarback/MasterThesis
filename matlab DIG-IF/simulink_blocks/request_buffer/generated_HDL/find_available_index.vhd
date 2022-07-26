-- -------------------------------------------------------------
-- 
-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\request_buffer\hdlsrc\request_buffer_test\find_available_index.vhd
-- Created: 2022-05-13 16:42:37
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: find_available_index
-- Source Path: request_buffer_test/request_buffer/request_orderer/occupy_ctrl/find_available_index
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY find_available_index IS
  PORT( in_rsvd                           :   IN    std_logic_vector(0 TO 63);  -- boolean [64]
        address                           :   OUT   std_logic_vector(5 DOWNTO 0);  -- ufix6
        found_any                         :   OUT   std_logic
        );
END find_available_index;


ARCHITECTURE rtl OF find_available_index IS

  -- Signals
  SIGNAL in_32                            : std_logic;
  SIGNAL in_33                            : std_logic;
  SIGNAL in_34                            : std_logic;
  SIGNAL in_35                            : std_logic;
  SIGNAL in_36                            : std_logic;
  SIGNAL in_37                            : std_logic;
  SIGNAL in_38                            : std_logic;
  SIGNAL in_39                            : std_logic;
  SIGNAL in_40                            : std_logic;
  SIGNAL in_41                            : std_logic;
  SIGNAL in_42                            : std_logic;
  SIGNAL in_43                            : std_logic;
  SIGNAL in_44                            : std_logic;
  SIGNAL in_45                            : std_logic;
  SIGNAL in_46                            : std_logic;
  SIGNAL in_47                            : std_logic;
  SIGNAL in_48                            : std_logic;
  SIGNAL in_49                            : std_logic;
  SIGNAL in_50                            : std_logic;
  SIGNAL in_51                            : std_logic;
  SIGNAL in_52                            : std_logic;
  SIGNAL in_53                            : std_logic;
  SIGNAL in_54                            : std_logic;
  SIGNAL in_55                            : std_logic;
  SIGNAL in_56                            : std_logic;
  SIGNAL in_57                            : std_logic;
  SIGNAL in_58                            : std_logic;
  SIGNAL in_59                            : std_logic;
  SIGNAL in_60                            : std_logic;
  SIGNAL in_61                            : std_logic;
  SIGNAL in_62                            : std_logic;
  SIGNAL in_63                            : std_logic;
  SIGNAL NAND_out1                        : std_logic;
  SIGNAL Selector_out1                    : std_logic_vector(0 TO 31);  -- boolean [32]
  SIGNAL Selector1_out1                   : std_logic_vector(0 TO 31);  -- boolean [32]
  SIGNAL Switch_out1                      : std_logic_vector(0 TO 31);  -- boolean [32]
  SIGNAL Switch_out1_16                   : std_logic;
  SIGNAL Switch_out1_17                   : std_logic;
  SIGNAL Switch_out1_18                   : std_logic;
  SIGNAL Switch_out1_19                   : std_logic;
  SIGNAL Switch_out1_20                   : std_logic;
  SIGNAL Switch_out1_21                   : std_logic;
  SIGNAL Switch_out1_22                   : std_logic;
  SIGNAL Switch_out1_23                   : std_logic;
  SIGNAL Switch_out1_24                   : std_logic;
  SIGNAL Switch_out1_25                   : std_logic;
  SIGNAL Switch_out1_26                   : std_logic;
  SIGNAL Switch_out1_27                   : std_logic;
  SIGNAL Switch_out1_28                   : std_logic;
  SIGNAL Switch_out1_29                   : std_logic;
  SIGNAL Switch_out1_30                   : std_logic;
  SIGNAL Switch_out1_31                   : std_logic;
  SIGNAL NAND1_out1                       : std_logic;
  SIGNAL Selector2_out1                   : std_logic_vector(0 TO 15);  -- boolean [16]
  SIGNAL Selector3_out1                   : std_logic_vector(0 TO 15);  -- boolean [16]
  SIGNAL Switch1_out1                     : std_logic_vector(0 TO 15);  -- boolean [16]
  SIGNAL Switch1_out1_8                   : std_logic;
  SIGNAL Switch1_out1_9                   : std_logic;
  SIGNAL Switch1_out1_10                  : std_logic;
  SIGNAL Switch1_out1_11                  : std_logic;
  SIGNAL Switch1_out1_12                  : std_logic;
  SIGNAL Switch1_out1_13                  : std_logic;
  SIGNAL Switch1_out1_14                  : std_logic;
  SIGNAL Switch1_out1_15                  : std_logic;
  SIGNAL NAND2_out1                       : std_logic;
  SIGNAL Selector4_out1                   : std_logic_vector(0 TO 7);  -- boolean [8]
  SIGNAL Selector5_out1                   : std_logic_vector(0 TO 7);  -- boolean [8]
  SIGNAL Switch2_out1                     : std_logic_vector(0 TO 7);  -- boolean [8]
  SIGNAL Switch2_out1_4                   : std_logic;
  SIGNAL Switch2_out1_5                   : std_logic;
  SIGNAL Switch2_out1_6                   : std_logic;
  SIGNAL Switch2_out1_7                   : std_logic;
  SIGNAL NAND3_out1                       : std_logic;
  SIGNAL Selector6_out1                   : std_logic_vector(0 TO 3);  -- boolean [4]
  SIGNAL Selector7_out1                   : std_logic_vector(0 TO 3);  -- boolean [4]
  SIGNAL Switch3_out1                     : std_logic_vector(0 TO 3);  -- boolean [4]
  SIGNAL Switch3_out1_2                   : std_logic;
  SIGNAL Switch3_out1_3                   : std_logic;
  SIGNAL NAND4_out1                       : std_logic;
  SIGNAL Selector8_out1                   : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Selector9_out1                   : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Switch4_out1                     : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Switch4_out1_1                   : std_logic;
  SIGNAL NOT_out1                         : std_logic;
  SIGNAL bools                            : std_logic_vector(0 TO 5);  -- boolean [6]
  SIGNAL fixed                            : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch4_out1_0                   : std_logic;
  SIGNAL NAND5_out1                       : std_logic;

BEGIN
  in_32 <= in_rsvd(32);

  in_33 <= in_rsvd(33);

  in_34 <= in_rsvd(34);

  in_35 <= in_rsvd(35);

  in_36 <= in_rsvd(36);

  in_37 <= in_rsvd(37);

  in_38 <= in_rsvd(38);

  in_39 <= in_rsvd(39);

  in_40 <= in_rsvd(40);

  in_41 <= in_rsvd(41);

  in_42 <= in_rsvd(42);

  in_43 <= in_rsvd(43);

  in_44 <= in_rsvd(44);

  in_45 <= in_rsvd(45);

  in_46 <= in_rsvd(46);

  in_47 <= in_rsvd(47);

  in_48 <= in_rsvd(48);

  in_49 <= in_rsvd(49);

  in_50 <= in_rsvd(50);

  in_51 <= in_rsvd(51);

  in_52 <= in_rsvd(52);

  in_53 <= in_rsvd(53);

  in_54 <= in_rsvd(54);

  in_55 <= in_rsvd(55);

  in_56 <= in_rsvd(56);

  in_57 <= in_rsvd(57);

  in_58 <= in_rsvd(58);

  in_59 <= in_rsvd(59);

  in_60 <= in_rsvd(60);

  in_61 <= in_rsvd(61);

  in_62 <= in_rsvd(62);

  in_63 <= in_rsvd(63);

  NAND_rsvd_output : PROCESS (in_32, in_33, in_34, in_35, in_36, in_37, in_38, in_39, in_40, in_41, in_42,
       in_43, in_44, in_45, in_46, in_47, in_48, in_49, in_50, in_51, in_52,
       in_53, in_54, in_55, in_56, in_57, in_58, in_59, in_60, in_61, in_62,
       in_63)
    VARIABLE t : std_logic;
  BEGIN
    t := in_48 AND (in_47 AND (in_46 AND (in_45 AND (in_44 AND (in_43 AND (in_42 AND (in_41 AND (in_40 AND (in_39 AND (in_38 AND (in_37 AND (in_36 AND (in_35 AND (in_34 AND (in_32 AND in_33)))))))))))))));
    t := in_49 AND t;
    t := in_50 AND t;
    t := in_51 AND t;
    t := in_52 AND t;
    t := in_53 AND t;
    t := in_54 AND t;
    t := in_55 AND t;
    t := in_56 AND t;
    t := in_57 AND t;
    t := in_58 AND t;
    t := in_59 AND t;
    t := in_60 AND t;
    t := in_61 AND t;
    t := in_62 AND t;
    t := in_63 AND t;
    NAND_out1 <=  NOT t;
  END PROCESS NAND_rsvd_output;


  Selector_out1(0) <= in_rsvd(0);
  Selector_out1(1) <= in_rsvd(1);
  Selector_out1(2) <= in_rsvd(2);
  Selector_out1(3) <= in_rsvd(3);
  Selector_out1(4) <= in_rsvd(4);
  Selector_out1(5) <= in_rsvd(5);
  Selector_out1(6) <= in_rsvd(6);
  Selector_out1(7) <= in_rsvd(7);
  Selector_out1(8) <= in_rsvd(8);
  Selector_out1(9) <= in_rsvd(9);
  Selector_out1(10) <= in_rsvd(10);
  Selector_out1(11) <= in_rsvd(11);
  Selector_out1(12) <= in_rsvd(12);
  Selector_out1(13) <= in_rsvd(13);
  Selector_out1(14) <= in_rsvd(14);
  Selector_out1(15) <= in_rsvd(15);
  Selector_out1(16) <= in_rsvd(16);
  Selector_out1(17) <= in_rsvd(17);
  Selector_out1(18) <= in_rsvd(18);
  Selector_out1(19) <= in_rsvd(19);
  Selector_out1(20) <= in_rsvd(20);
  Selector_out1(21) <= in_rsvd(21);
  Selector_out1(22) <= in_rsvd(22);
  Selector_out1(23) <= in_rsvd(23);
  Selector_out1(24) <= in_rsvd(24);
  Selector_out1(25) <= in_rsvd(25);
  Selector_out1(26) <= in_rsvd(26);
  Selector_out1(27) <= in_rsvd(27);
  Selector_out1(28) <= in_rsvd(28);
  Selector_out1(29) <= in_rsvd(29);
  Selector_out1(30) <= in_rsvd(30);
  Selector_out1(31) <= in_rsvd(31);

  Selector1_out1(0) <= in_rsvd(32);
  Selector1_out1(1) <= in_rsvd(33);
  Selector1_out1(2) <= in_rsvd(34);
  Selector1_out1(3) <= in_rsvd(35);
  Selector1_out1(4) <= in_rsvd(36);
  Selector1_out1(5) <= in_rsvd(37);
  Selector1_out1(6) <= in_rsvd(38);
  Selector1_out1(7) <= in_rsvd(39);
  Selector1_out1(8) <= in_rsvd(40);
  Selector1_out1(9) <= in_rsvd(41);
  Selector1_out1(10) <= in_rsvd(42);
  Selector1_out1(11) <= in_rsvd(43);
  Selector1_out1(12) <= in_rsvd(44);
  Selector1_out1(13) <= in_rsvd(45);
  Selector1_out1(14) <= in_rsvd(46);
  Selector1_out1(15) <= in_rsvd(47);
  Selector1_out1(16) <= in_rsvd(48);
  Selector1_out1(17) <= in_rsvd(49);
  Selector1_out1(18) <= in_rsvd(50);
  Selector1_out1(19) <= in_rsvd(51);
  Selector1_out1(20) <= in_rsvd(52);
  Selector1_out1(21) <= in_rsvd(53);
  Selector1_out1(22) <= in_rsvd(54);
  Selector1_out1(23) <= in_rsvd(55);
  Selector1_out1(24) <= in_rsvd(56);
  Selector1_out1(25) <= in_rsvd(57);
  Selector1_out1(26) <= in_rsvd(58);
  Selector1_out1(27) <= in_rsvd(59);
  Selector1_out1(28) <= in_rsvd(60);
  Selector1_out1(29) <= in_rsvd(61);
  Selector1_out1(30) <= in_rsvd(62);
  Selector1_out1(31) <= in_rsvd(63);

  
  Switch_out1 <= Selector_out1 WHEN NAND_out1 = '0' ELSE
      Selector1_out1;

  Switch_out1_16 <= Switch_out1(16);

  Switch_out1_17 <= Switch_out1(17);

  Switch_out1_18 <= Switch_out1(18);

  Switch_out1_19 <= Switch_out1(19);

  Switch_out1_20 <= Switch_out1(20);

  Switch_out1_21 <= Switch_out1(21);

  Switch_out1_22 <= Switch_out1(22);

  Switch_out1_23 <= Switch_out1(23);

  Switch_out1_24 <= Switch_out1(24);

  Switch_out1_25 <= Switch_out1(25);

  Switch_out1_26 <= Switch_out1(26);

  Switch_out1_27 <= Switch_out1(27);

  Switch_out1_28 <= Switch_out1(28);

  Switch_out1_29 <= Switch_out1(29);

  Switch_out1_30 <= Switch_out1(30);

  Switch_out1_31 <= Switch_out1(31);

  NAND1_out1 <=  NOT (Switch_out1_31 AND (Switch_out1_30 AND (Switch_out1_29 AND (Switch_out1_28 AND (Switch_out1_27 AND (Switch_out1_26 AND (Switch_out1_25 AND (Switch_out1_24 AND (Switch_out1_23 AND (Switch_out1_22 AND (Switch_out1_21 AND (Switch_out1_20 AND (Switch_out1_19 AND (Switch_out1_18 AND (Switch_out1_16 AND Switch_out1_17)))))))))))))));

  Selector2_out1(0) <= Switch_out1(0);
  Selector2_out1(1) <= Switch_out1(1);
  Selector2_out1(2) <= Switch_out1(2);
  Selector2_out1(3) <= Switch_out1(3);
  Selector2_out1(4) <= Switch_out1(4);
  Selector2_out1(5) <= Switch_out1(5);
  Selector2_out1(6) <= Switch_out1(6);
  Selector2_out1(7) <= Switch_out1(7);
  Selector2_out1(8) <= Switch_out1(8);
  Selector2_out1(9) <= Switch_out1(9);
  Selector2_out1(10) <= Switch_out1(10);
  Selector2_out1(11) <= Switch_out1(11);
  Selector2_out1(12) <= Switch_out1(12);
  Selector2_out1(13) <= Switch_out1(13);
  Selector2_out1(14) <= Switch_out1(14);
  Selector2_out1(15) <= Switch_out1(15);

  Selector3_out1(0) <= Switch_out1(16);
  Selector3_out1(1) <= Switch_out1(17);
  Selector3_out1(2) <= Switch_out1(18);
  Selector3_out1(3) <= Switch_out1(19);
  Selector3_out1(4) <= Switch_out1(20);
  Selector3_out1(5) <= Switch_out1(21);
  Selector3_out1(6) <= Switch_out1(22);
  Selector3_out1(7) <= Switch_out1(23);
  Selector3_out1(8) <= Switch_out1(24);
  Selector3_out1(9) <= Switch_out1(25);
  Selector3_out1(10) <= Switch_out1(26);
  Selector3_out1(11) <= Switch_out1(27);
  Selector3_out1(12) <= Switch_out1(28);
  Selector3_out1(13) <= Switch_out1(29);
  Selector3_out1(14) <= Switch_out1(30);
  Selector3_out1(15) <= Switch_out1(31);

  
  Switch1_out1 <= Selector2_out1 WHEN NAND1_out1 = '0' ELSE
      Selector3_out1;

  Switch1_out1_8 <= Switch1_out1(8);

  Switch1_out1_9 <= Switch1_out1(9);

  Switch1_out1_10 <= Switch1_out1(10);

  Switch1_out1_11 <= Switch1_out1(11);

  Switch1_out1_12 <= Switch1_out1(12);

  Switch1_out1_13 <= Switch1_out1(13);

  Switch1_out1_14 <= Switch1_out1(14);

  Switch1_out1_15 <= Switch1_out1(15);

  NAND2_out1 <=  NOT (Switch1_out1_15 AND (Switch1_out1_14 AND (Switch1_out1_13 AND (Switch1_out1_12 AND (Switch1_out1_11 AND (Switch1_out1_10 AND (Switch1_out1_8 AND Switch1_out1_9)))))));

  Selector4_out1(0) <= Switch1_out1(0);
  Selector4_out1(1) <= Switch1_out1(1);
  Selector4_out1(2) <= Switch1_out1(2);
  Selector4_out1(3) <= Switch1_out1(3);
  Selector4_out1(4) <= Switch1_out1(4);
  Selector4_out1(5) <= Switch1_out1(5);
  Selector4_out1(6) <= Switch1_out1(6);
  Selector4_out1(7) <= Switch1_out1(7);

  Selector5_out1(0) <= Switch1_out1(8);
  Selector5_out1(1) <= Switch1_out1(9);
  Selector5_out1(2) <= Switch1_out1(10);
  Selector5_out1(3) <= Switch1_out1(11);
  Selector5_out1(4) <= Switch1_out1(12);
  Selector5_out1(5) <= Switch1_out1(13);
  Selector5_out1(6) <= Switch1_out1(14);
  Selector5_out1(7) <= Switch1_out1(15);

  
  Switch2_out1 <= Selector4_out1 WHEN NAND2_out1 = '0' ELSE
      Selector5_out1;

  Switch2_out1_4 <= Switch2_out1(4);

  Switch2_out1_5 <= Switch2_out1(5);

  Switch2_out1_6 <= Switch2_out1(6);

  Switch2_out1_7 <= Switch2_out1(7);

  NAND3_out1 <=  NOT (Switch2_out1_7 AND (Switch2_out1_6 AND (Switch2_out1_4 AND Switch2_out1_5)));

  Selector6_out1(0) <= Switch2_out1(0);
  Selector6_out1(1) <= Switch2_out1(1);
  Selector6_out1(2) <= Switch2_out1(2);
  Selector6_out1(3) <= Switch2_out1(3);

  Selector7_out1(0) <= Switch2_out1(4);
  Selector7_out1(1) <= Switch2_out1(5);
  Selector7_out1(2) <= Switch2_out1(6);
  Selector7_out1(3) <= Switch2_out1(7);

  
  Switch3_out1 <= Selector6_out1 WHEN NAND3_out1 = '0' ELSE
      Selector7_out1;

  Switch3_out1_2 <= Switch3_out1(2);

  Switch3_out1_3 <= Switch3_out1(3);

  NAND4_out1 <=  NOT (Switch3_out1_2 AND Switch3_out1_3);

  Selector8_out1(0) <= Switch3_out1(0);
  Selector8_out1(1) <= Switch3_out1(1);

  Selector9_out1(0) <= Switch3_out1(2);
  Selector9_out1(1) <= Switch3_out1(3);

  
  Switch4_out1 <= Selector8_out1 WHEN NAND4_out1 = '0' ELSE
      Selector9_out1;

  Switch4_out1_1 <= Switch4_out1(1);

  NOT_out1 <=  NOT Switch4_out1_1;

  bools(0) <= NAND_out1;
  bools(1) <= NAND1_out1;
  bools(2) <= NAND2_out1;
  bools(3) <= NAND3_out1;
  bools(4) <= NAND4_out1;
  bools(5) <= NOT_out1;

  fixed <= unsigned'(bools(0) & bools(1) & bools(2) & bools(3) & bools(4) & bools(5));

  address <= std_logic_vector(fixed);

  Switch4_out1_0 <= Switch4_out1(0);

  NAND5_out1 <=  NOT (Switch4_out1_1 AND Switch4_out1_0);

  found_any <= NAND5_out1;

END rtl;

