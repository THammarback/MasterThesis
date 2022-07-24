-- -------------------------------------------------------------
-- 
-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\filter_block\hdlsrc\filter_block_test\filter.vhd
-- Created: 2022-05-12 15:03:01
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: filter
-- Source Path: filter_block_test/Subsystem Reference/filters/filter
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Subsystem_Reference_pkg.ALL;

ENTITY filter IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        stream_in                         :   IN    vector_of_std_logic_vector4(0 TO 7);  -- sfix4_E2 [8]
        s_1                               :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        a_2_1                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        a_3_1                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        b_2_1                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        b_3_1                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        s_2                               :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        a_2_2                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        a_3_2                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        b_2_2                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        b_3_2                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        stream_out                        :   OUT   vector_of_std_logic_vector32(0 TO 7)  -- sfix32_E2 [8]
        );
END filter;


ARCHITECTURE rtl OF filter IS

  -- Signals
  SIGNAL s_1_unsigned                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL stream_in_signed                 : vector_of_signed4(0 TO 7);  -- sfix4_E2 [8]
  SIGNAL ss_1_cast                        : vector_of_signed9(0 TO 7);  -- sfix9 [8]
  SIGNAL ss_1_mul_temp                    : vector_of_signed13(0 TO 7);  -- sfix13_E2 [8]
  SIGNAL ss_1_cast_1                      : vector_of_signed12(0 TO 7);  -- sfix12_E2 [8]
  SIGNAL ss_1_out1                        : vector_of_signed16(0 TO 7);  -- sfix16_E2 [8]
  SIGNAL a_2_1_unsigned                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL a_3_1_unsigned                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Delay11_out1                     : vector_of_signed16(0 TO 7);  -- sfix16_E2 [8]
  SIGNAL Delay21_out1                     : vector_of_signed16(0 TO 7);  -- sfix16_E2 [8]
  SIGNAL aa_3_1_cast                      : vector_of_signed9(0 TO 7);  -- sfix9 [8]
  SIGNAL aa_3_1_mul_temp                  : vector_of_signed25(0 TO 7);  -- sfix25_E2 [8]
  SIGNAL aa_3_1_cast_1                    : vector_of_signed24(0 TO 7);  -- sfix24_E2 [8]
  SIGNAL aa_3_1_out1                      : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumA31_out1                      : vector_of_signed16(0 TO 7);  -- sfix16_E2 [8]
  SIGNAL aa_2_1_cast                      : vector_of_signed9(0 TO 7);  -- sfix9 [8]
  SIGNAL aa_2_1_mul_temp                  : vector_of_signed25(0 TO 7);  -- sfix25_E2 [8]
  SIGNAL aa_2_1_cast_1                    : vector_of_signed24(0 TO 7);  -- sfix24_E2 [8]
  SIGNAL aa_2_1_out1                      : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumA21_sub_cast                  : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumA21_sub_cast_1                : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumA21_sub_cast_2                : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumA21_sub_temp                  : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumA21_cast                      : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumA21_out1                      : vector_of_signed16(0 TO 7);  -- sfix16_E2 [8]
  SIGNAL SumA31_sub_cast                  : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumA31_sub_cast_1                : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumA31_sub_cast_2                : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumA31_sub_temp                  : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumA31_cast                      : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL b_2_1_unsigned                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL bb_2_1_cast                      : vector_of_signed9(0 TO 7);  -- sfix9 [8]
  SIGNAL bb_2_1_mul_temp                  : vector_of_signed25(0 TO 7);  -- sfix25_E2 [8]
  SIGNAL bb_2_1_cast_1                    : vector_of_signed24(0 TO 7);  -- sfix24_E2 [8]
  SIGNAL bb_2_1_out1                      : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumB21_add_cast                  : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumB21_add_cast_1                : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB21_add_cast_2                : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB21_add_temp                  : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB21_cast                      : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumB21_out1                      : vector_of_signed16(0 TO 7);  -- sfix16_E2 [8]
  SIGNAL b_3_1_unsigned                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL s_2_unsigned                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL bb_3_1_cast                      : vector_of_signed9(0 TO 7);  -- sfix9 [8]
  SIGNAL bb_3_1_mul_temp                  : vector_of_signed25(0 TO 7);  -- sfix25_E2 [8]
  SIGNAL bb_3_1_cast_1                    : vector_of_signed24(0 TO 7);  -- sfix24_E2 [8]
  SIGNAL bb_3_1_out1                      : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumB31_add_cast                  : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumB31_add_cast_1                : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB31_add_cast_2                : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB31_add_temp                  : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB31_cast                      : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumB31_out1                      : vector_of_signed16(0 TO 7);  -- sfix16_E2 [8]
  SIGNAL ss_2_cast                        : vector_of_signed9(0 TO 7);  -- sfix9 [8]
  SIGNAL ss_2_mul_temp                    : vector_of_signed25(0 TO 7);  -- sfix25_E2 [8]
  SIGNAL ss_2_cast_1                      : vector_of_signed24(0 TO 7);  -- sfix24_E2 [8]
  SIGNAL ss_2_out1                        : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL a_2_2_unsigned                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL a_3_2_unsigned                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Delay1_out1                      : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL Delay2_out1                      : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL aa_3_2_cast                      : vector_of_signed9(0 TO 7);  -- sfix9 [8]
  SIGNAL aa_3_2_mul_temp                  : vector_of_signed41(0 TO 7);  -- sfix41_E2 [8]
  SIGNAL aa_3_2_out1                      : vector_of_signed40(0 TO 7);  -- sfix40_E2 [8]
  SIGNAL SumA2_out1                       : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL aa_2_2_cast                      : vector_of_signed9(0 TO 7);  -- sfix9 [8]
  SIGNAL aa_2_2_mul_temp                  : vector_of_signed41(0 TO 7);  -- sfix41_E2 [8]
  SIGNAL aa_2_2_out1                      : vector_of_signed40(0 TO 7);  -- sfix40_E2 [8]
  SIGNAL SumA1_sub_cast                   : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumA1_sub_cast_1                 : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumA1_sub_cast_2                 : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumA1_sub_temp                   : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumA1_out1                       : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumA2_sub_cast                   : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumA2_sub_cast_1                 : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumA2_sub_cast_2                 : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumA2_sub_temp                   : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL b_3_2_unsigned                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL bb_2_2_cast                      : vector_of_signed9(0 TO 7);  -- sfix9 [8]
  SIGNAL bb_2_2_mul_temp                  : vector_of_signed41(0 TO 7);  -- sfix41_E2 [8]
  SIGNAL bb_2_2_out1                      : vector_of_signed40(0 TO 7);  -- sfix40_E2 [8]
  SIGNAL SumB1_add_cast                   : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB1_add_cast_1                 : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumB1_add_cast_2                 : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB1_add_temp                   : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB1_out1                       : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL b_2_2_unsigned                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL bb_3_2_cast                      : vector_of_signed9(0 TO 7);  -- sfix9 [8]
  SIGNAL bb_3_2_mul_temp                  : vector_of_signed41(0 TO 7);  -- sfix41_E2 [8]
  SIGNAL bb_3_2_out1                      : vector_of_signed40(0 TO 7);  -- sfix40_E2 [8]
  SIGNAL SumB2_add_cast                   : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB2_add_cast_1                 : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]
  SIGNAL SumB2_add_cast_2                 : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB2_add_temp                   : vector_of_signed33(0 TO 7);  -- sfix33_E2 [8]
  SIGNAL SumB2_out1                       : vector_of_signed32(0 TO 7);  -- sfix32_E2 [8]

BEGIN
  s_1_unsigned <= unsigned(s_1);

  outputgen1: FOR k IN 0 TO 7 GENERATE
    stream_in_signed(k) <= signed(stream_in(k));
  END GENERATE;


  ss_1_out1_gen: FOR t_0 IN 0 TO 7 GENERATE
    ss_1_cast(t_0) <= signed(resize(s_1_unsigned, 9));
    ss_1_mul_temp(t_0) <= ss_1_cast(t_0) * stream_in_signed(t_0);
    ss_1_cast_1(t_0) <= ss_1_mul_temp(t_0)(11 DOWNTO 0);
    ss_1_out1(t_0) <= resize(ss_1_cast_1(t_0), 16);
  END GENERATE ss_1_out1_gen;


  a_2_1_unsigned <= unsigned(a_2_1);

  a_3_1_unsigned <= unsigned(a_3_1);

  Delay21_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay21_out1 <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay21_out1 <= Delay11_out1;
      END IF;
    END IF;
  END PROCESS Delay21_process;



  aa_3_1_out1_gen: FOR t_01 IN 0 TO 7 GENERATE
    aa_3_1_cast(t_01) <= signed(resize(a_3_1_unsigned, 9));
    aa_3_1_mul_temp(t_01) <= aa_3_1_cast(t_01) * Delay21_out1(t_01);
    aa_3_1_cast_1(t_01) <= aa_3_1_mul_temp(t_01)(23 DOWNTO 0);
    aa_3_1_out1(t_01) <= resize(aa_3_1_cast_1(t_01), 32);
  END GENERATE aa_3_1_out1_gen;


  Delay11_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay11_out1 <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay11_out1 <= SumA31_out1;
      END IF;
    END IF;
  END PROCESS Delay11_process;



  aa_2_1_out1_gen: FOR t_02 IN 0 TO 7 GENERATE
    aa_2_1_cast(t_02) <= signed(resize(a_2_1_unsigned, 9));
    aa_2_1_mul_temp(t_02) <= aa_2_1_cast(t_02) * Delay11_out1(t_02);
    aa_2_1_cast_1(t_02) <= aa_2_1_mul_temp(t_02)(23 DOWNTO 0);
    aa_2_1_out1(t_02) <= resize(aa_2_1_cast_1(t_02), 32);
  END GENERATE aa_2_1_out1_gen;



  SumA21_out1_gen: FOR t_03 IN 0 TO 7 GENERATE
    SumA21_sub_cast(t_03) <= resize(ss_1_out1(t_03), 32);
    SumA21_sub_cast_1(t_03) <= resize(SumA21_sub_cast(t_03), 33);
    SumA21_sub_cast_2(t_03) <= resize(aa_2_1_out1(t_03), 33);
    SumA21_sub_temp(t_03) <= SumA21_sub_cast_1(t_03) - SumA21_sub_cast_2(t_03);
    
    SumA21_cast(t_03) <= X"7FFFFFFF" WHEN (SumA21_sub_temp(t_03)(32) = '0') AND (SumA21_sub_temp(t_03)(31) /= '0') ELSE
        X"80000000" WHEN (SumA21_sub_temp(t_03)(32) = '1') AND (SumA21_sub_temp(t_03)(31) /= '1') ELSE
        SumA21_sub_temp(t_03)(31 DOWNTO 0);
    
    SumA21_out1(t_03) <= X"7FFF" WHEN (SumA21_cast(t_03)(31) = '0') AND (SumA21_cast(t_03)(30 DOWNTO 15) /= X"0000") ELSE
        X"8000" WHEN (SumA21_cast(t_03)(31) = '1') AND (SumA21_cast(t_03)(30 DOWNTO 15) /= X"FFFF") ELSE
        SumA21_cast(t_03)(15 DOWNTO 0);
  END GENERATE SumA21_out1_gen;



  SumA31_out1_gen: FOR t_04 IN 0 TO 7 GENERATE
    SumA31_sub_cast(t_04) <= resize(SumA21_out1(t_04), 32);
    SumA31_sub_cast_1(t_04) <= resize(SumA31_sub_cast(t_04), 33);
    SumA31_sub_cast_2(t_04) <= resize(aa_3_1_out1(t_04), 33);
    SumA31_sub_temp(t_04) <= SumA31_sub_cast_1(t_04) - SumA31_sub_cast_2(t_04);
    
    SumA31_cast(t_04) <= X"7FFFFFFF" WHEN (SumA31_sub_temp(t_04)(32) = '0') AND (SumA31_sub_temp(t_04)(31) /= '0') ELSE
        X"80000000" WHEN (SumA31_sub_temp(t_04)(32) = '1') AND (SumA31_sub_temp(t_04)(31) /= '1') ELSE
        SumA31_sub_temp(t_04)(31 DOWNTO 0);
    
    SumA31_out1(t_04) <= X"7FFF" WHEN (SumA31_cast(t_04)(31) = '0') AND (SumA31_cast(t_04)(30 DOWNTO 15) /= X"0000") ELSE
        X"8000" WHEN (SumA31_cast(t_04)(31) = '1') AND (SumA31_cast(t_04)(30 DOWNTO 15) /= X"FFFF") ELSE
        SumA31_cast(t_04)(15 DOWNTO 0);
  END GENERATE SumA31_out1_gen;


  b_2_1_unsigned <= unsigned(b_2_1);


  bb_2_1_out1_gen: FOR t_05 IN 0 TO 7 GENERATE
    bb_2_1_cast(t_05) <= signed(resize(b_2_1_unsigned, 9));
    bb_2_1_mul_temp(t_05) <= bb_2_1_cast(t_05) * Delay11_out1(t_05);
    bb_2_1_cast_1(t_05) <= bb_2_1_mul_temp(t_05)(23 DOWNTO 0);
    bb_2_1_out1(t_05) <= resize(bb_2_1_cast_1(t_05), 32);
  END GENERATE bb_2_1_out1_gen;



  SumB21_out1_gen: FOR t_06 IN 0 TO 7 GENERATE
    SumB21_add_cast(t_06) <= resize(SumA31_out1(t_06), 32);
    SumB21_add_cast_1(t_06) <= resize(SumB21_add_cast(t_06), 33);
    SumB21_add_cast_2(t_06) <= resize(bb_2_1_out1(t_06), 33);
    SumB21_add_temp(t_06) <= SumB21_add_cast_1(t_06) + SumB21_add_cast_2(t_06);
    
    SumB21_cast(t_06) <= X"7FFFFFFF" WHEN (SumB21_add_temp(t_06)(32) = '0') AND (SumB21_add_temp(t_06)(31) /= '0') ELSE
        X"80000000" WHEN (SumB21_add_temp(t_06)(32) = '1') AND (SumB21_add_temp(t_06)(31) /= '1') ELSE
        SumB21_add_temp(t_06)(31 DOWNTO 0);
    
    SumB21_out1(t_06) <= X"7FFF" WHEN (SumB21_cast(t_06)(31) = '0') AND (SumB21_cast(t_06)(30 DOWNTO 15) /= X"0000") ELSE
        X"8000" WHEN (SumB21_cast(t_06)(31) = '1') AND (SumB21_cast(t_06)(30 DOWNTO 15) /= X"FFFF") ELSE
        SumB21_cast(t_06)(15 DOWNTO 0);
  END GENERATE SumB21_out1_gen;


  b_3_1_unsigned <= unsigned(b_3_1);

  s_2_unsigned <= unsigned(s_2);


  bb_3_1_out1_gen: FOR t_07 IN 0 TO 7 GENERATE
    bb_3_1_cast(t_07) <= signed(resize(b_3_1_unsigned, 9));
    bb_3_1_mul_temp(t_07) <= bb_3_1_cast(t_07) * Delay21_out1(t_07);
    bb_3_1_cast_1(t_07) <= bb_3_1_mul_temp(t_07)(23 DOWNTO 0);
    bb_3_1_out1(t_07) <= resize(bb_3_1_cast_1(t_07), 32);
  END GENERATE bb_3_1_out1_gen;



  SumB31_out1_gen: FOR t_08 IN 0 TO 7 GENERATE
    SumB31_add_cast(t_08) <= resize(SumB21_out1(t_08), 32);
    SumB31_add_cast_1(t_08) <= resize(SumB31_add_cast(t_08), 33);
    SumB31_add_cast_2(t_08) <= resize(bb_3_1_out1(t_08), 33);
    SumB31_add_temp(t_08) <= SumB31_add_cast_1(t_08) + SumB31_add_cast_2(t_08);
    
    SumB31_cast(t_08) <= X"7FFFFFFF" WHEN (SumB31_add_temp(t_08)(32) = '0') AND (SumB31_add_temp(t_08)(31) /= '0') ELSE
        X"80000000" WHEN (SumB31_add_temp(t_08)(32) = '1') AND (SumB31_add_temp(t_08)(31) /= '1') ELSE
        SumB31_add_temp(t_08)(31 DOWNTO 0);
    
    SumB31_out1(t_08) <= X"7FFF" WHEN (SumB31_cast(t_08)(31) = '0') AND (SumB31_cast(t_08)(30 DOWNTO 15) /= X"0000") ELSE
        X"8000" WHEN (SumB31_cast(t_08)(31) = '1') AND (SumB31_cast(t_08)(30 DOWNTO 15) /= X"FFFF") ELSE
        SumB31_cast(t_08)(15 DOWNTO 0);
  END GENERATE SumB31_out1_gen;



  ss_2_out1_gen: FOR t_09 IN 0 TO 7 GENERATE
    ss_2_cast(t_09) <= signed(resize(s_2_unsigned, 9));
    ss_2_mul_temp(t_09) <= ss_2_cast(t_09) * SumB31_out1(t_09);
    ss_2_cast_1(t_09) <= ss_2_mul_temp(t_09)(23 DOWNTO 0);
    ss_2_out1(t_09) <= resize(ss_2_cast_1(t_09), 32);
  END GENERATE ss_2_out1_gen;


  a_2_2_unsigned <= unsigned(a_2_2);

  a_3_2_unsigned <= unsigned(a_3_2);

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= (OTHERS => to_signed(0, 32));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_out1 <= Delay1_out1;
      END IF;
    END IF;
  END PROCESS Delay2_process;



  aa_3_2_out1_gen: FOR t_010 IN 0 TO 7 GENERATE
    aa_3_2_cast(t_010) <= signed(resize(a_3_2_unsigned, 9));
    aa_3_2_mul_temp(t_010) <= aa_3_2_cast(t_010) * Delay2_out1(t_010);
    aa_3_2_out1(t_010) <= aa_3_2_mul_temp(t_010)(39 DOWNTO 0);
  END GENERATE aa_3_2_out1_gen;


  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= (OTHERS => to_signed(0, 32));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= SumA2_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;



  aa_2_2_out1_gen: FOR t_011 IN 0 TO 7 GENERATE
    aa_2_2_cast(t_011) <= signed(resize(a_2_2_unsigned, 9));
    aa_2_2_mul_temp(t_011) <= aa_2_2_cast(t_011) * Delay1_out1(t_011);
    aa_2_2_out1(t_011) <= aa_2_2_mul_temp(t_011)(39 DOWNTO 0);
  END GENERATE aa_2_2_out1_gen;



  SumA1_out1_gen: FOR t_012 IN 0 TO 7 GENERATE
    SumA1_sub_cast(t_012) <= resize(ss_2_out1(t_012), 33);
    
    SumA1_sub_cast_1(t_012) <= X"7FFFFFFF" WHEN (aa_2_2_out1(t_012)(39) = '0') AND (aa_2_2_out1(t_012)(38 DOWNTO 31) /= "00000000") ELSE
        X"80000000" WHEN (aa_2_2_out1(t_012)(39) = '1') AND (aa_2_2_out1(t_012)(38 DOWNTO 31) /= "11111111") ELSE
        aa_2_2_out1(t_012)(31 DOWNTO 0);
    SumA1_sub_cast_2(t_012) <= resize(SumA1_sub_cast_1(t_012), 33);
    SumA1_sub_temp(t_012) <= SumA1_sub_cast(t_012) - SumA1_sub_cast_2(t_012);
    
    SumA1_out1(t_012) <= X"7FFFFFFF" WHEN (SumA1_sub_temp(t_012)(32) = '0') AND (SumA1_sub_temp(t_012)(31) /= '0') ELSE
        X"80000000" WHEN (SumA1_sub_temp(t_012)(32) = '1') AND (SumA1_sub_temp(t_012)(31) /= '1') ELSE
        SumA1_sub_temp(t_012)(31 DOWNTO 0);
  END GENERATE SumA1_out1_gen;



  SumA2_out1_gen: FOR t_013 IN 0 TO 7 GENERATE
    SumA2_sub_cast(t_013) <= resize(SumA1_out1(t_013), 33);
    
    SumA2_sub_cast_1(t_013) <= X"7FFFFFFF" WHEN (aa_3_2_out1(t_013)(39) = '0') AND (aa_3_2_out1(t_013)(38 DOWNTO 31) /= "00000000") ELSE
        X"80000000" WHEN (aa_3_2_out1(t_013)(39) = '1') AND (aa_3_2_out1(t_013)(38 DOWNTO 31) /= "11111111") ELSE
        aa_3_2_out1(t_013)(31 DOWNTO 0);
    SumA2_sub_cast_2(t_013) <= resize(SumA2_sub_cast_1(t_013), 33);
    SumA2_sub_temp(t_013) <= SumA2_sub_cast(t_013) - SumA2_sub_cast_2(t_013);
    
    SumA2_out1(t_013) <= X"7FFFFFFF" WHEN (SumA2_sub_temp(t_013)(32) = '0') AND (SumA2_sub_temp(t_013)(31) /= '0') ELSE
        X"80000000" WHEN (SumA2_sub_temp(t_013)(32) = '1') AND (SumA2_sub_temp(t_013)(31) /= '1') ELSE
        SumA2_sub_temp(t_013)(31 DOWNTO 0);
  END GENERATE SumA2_out1_gen;


  b_3_2_unsigned <= unsigned(b_3_2);


  bb_2_2_out1_gen: FOR t_014 IN 0 TO 7 GENERATE
    bb_2_2_cast(t_014) <= signed(resize(b_3_2_unsigned, 9));
    bb_2_2_mul_temp(t_014) <= bb_2_2_cast(t_014) * Delay1_out1(t_014);
    bb_2_2_out1(t_014) <= bb_2_2_mul_temp(t_014)(39 DOWNTO 0);
  END GENERATE bb_2_2_out1_gen;



  SumB1_out1_gen: FOR t_015 IN 0 TO 7 GENERATE
    SumB1_add_cast(t_015) <= resize(SumA2_out1(t_015), 33);
    
    SumB1_add_cast_1(t_015) <= X"7FFFFFFF" WHEN (bb_2_2_out1(t_015)(39) = '0') AND (bb_2_2_out1(t_015)(38 DOWNTO 31) /= "00000000") ELSE
        X"80000000" WHEN (bb_2_2_out1(t_015)(39) = '1') AND (bb_2_2_out1(t_015)(38 DOWNTO 31) /= "11111111") ELSE
        bb_2_2_out1(t_015)(31 DOWNTO 0);
    SumB1_add_cast_2(t_015) <= resize(SumB1_add_cast_1(t_015), 33);
    SumB1_add_temp(t_015) <= SumB1_add_cast(t_015) + SumB1_add_cast_2(t_015);
    
    SumB1_out1(t_015) <= X"7FFFFFFF" WHEN (SumB1_add_temp(t_015)(32) = '0') AND (SumB1_add_temp(t_015)(31) /= '0') ELSE
        X"80000000" WHEN (SumB1_add_temp(t_015)(32) = '1') AND (SumB1_add_temp(t_015)(31) /= '1') ELSE
        SumB1_add_temp(t_015)(31 DOWNTO 0);
  END GENERATE SumB1_out1_gen;


  b_2_2_unsigned <= unsigned(b_2_2);


  bb_3_2_out1_gen: FOR t_016 IN 0 TO 7 GENERATE
    bb_3_2_cast(t_016) <= signed(resize(b_2_2_unsigned, 9));
    bb_3_2_mul_temp(t_016) <= bb_3_2_cast(t_016) * Delay2_out1(t_016);
    bb_3_2_out1(t_016) <= bb_3_2_mul_temp(t_016)(39 DOWNTO 0);
  END GENERATE bb_3_2_out1_gen;



  SumB2_out1_gen: FOR t_017 IN 0 TO 7 GENERATE
    SumB2_add_cast(t_017) <= resize(SumB1_out1(t_017), 33);
    
    SumB2_add_cast_1(t_017) <= X"7FFFFFFF" WHEN (bb_3_2_out1(t_017)(39) = '0') AND (bb_3_2_out1(t_017)(38 DOWNTO 31) /= "00000000") ELSE
        X"80000000" WHEN (bb_3_2_out1(t_017)(39) = '1') AND (bb_3_2_out1(t_017)(38 DOWNTO 31) /= "11111111") ELSE
        bb_3_2_out1(t_017)(31 DOWNTO 0);
    SumB2_add_cast_2(t_017) <= resize(SumB2_add_cast_1(t_017), 33);
    SumB2_add_temp(t_017) <= SumB2_add_cast(t_017) + SumB2_add_cast_2(t_017);
    
    SumB2_out1(t_017) <= X"7FFFFFFF" WHEN (SumB2_add_temp(t_017)(32) = '0') AND (SumB2_add_temp(t_017)(31) /= '0') ELSE
        X"80000000" WHEN (SumB2_add_temp(t_017)(32) = '1') AND (SumB2_add_temp(t_017)(31) /= '1') ELSE
        SumB2_add_temp(t_017)(31 DOWNTO 0);
  END GENERATE SumB2_out1_gen;


  outputgen: FOR k IN 0 TO 7 GENERATE
    stream_out(k) <= std_logic_vector(SumB2_out1(k));
  END GENERATE;

END rtl;

