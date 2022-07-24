-- -------------------------------------------------------------
-- 
-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\filters.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: filters
-- Source Path: DIG_IF_test/DIG_IF/dl_filter/filters
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DIG_IF_pac.ALL;

ENTITY filters IS
  PORT( clk                               :   IN    std_logic;
        stream_in_re                      :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        stream_in_im                      :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        coeffs                            :   IN    vector_of_std_logic_vector8(0 TO 9);  -- uint8 [10]
        stream_out_re                     :   OUT   std_logic_vector(19 DOWNTO 0);  -- ufix20
        stream_out_im                     :   OUT   std_logic_vector(19 DOWNTO 0)  -- ufix20
        );
END filters;


ARCHITECTURE rtl OF filters IS

  -- Component Declarations
  COMPONENT filter
    PORT( clk                             :   IN    std_logic;
          stream_in_re                    :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
          stream_in_im                    :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
          s_1                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          a_2_1                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          a_3_1                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          b_2_1                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          b_3_1                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          s_2                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          a_2_2                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          a_3_2                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          b_2_2                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          b_3_2                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          stream_out_re                   :   OUT   std_logic_vector(19 DOWNTO 0);  -- ufix20
          stream_out_im                   :   OUT   std_logic_vector(19 DOWNTO 0)  -- ufix20
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : filter
    USE ENTITY work.filter(rtl);

  -- Signals
  SIGNAL filter_out1_re                   : std_logic_vector(19 DOWNTO 0);  -- ufix20
  SIGNAL filter_out1_im                   : std_logic_vector(19 DOWNTO 0);  -- ufix20

BEGIN
  Ufilter_1 : filter
    PORT MAP( clk => clk,
              stream_in_re => stream_in_re,  -- ufix4
              stream_in_im => stream_in_im,  -- ufix4
              s_1 => coeffs(0),  -- uint8
              a_2_1 => coeffs(1),  -- uint8
              a_3_1 => coeffs(2),  -- uint8
              b_2_1 => coeffs(3),  -- uint8
              b_3_1 => coeffs(4),  -- uint8
              s_2 => coeffs(5),  -- uint8
              a_2_2 => coeffs(6),  -- uint8
              a_3_2 => coeffs(7),  -- uint8
              b_2_2 => coeffs(8),  -- uint8
              b_3_2 => coeffs(9),  -- uint8
              stream_out_re => filter_out1_re,  -- ufix20
              stream_out_im => filter_out1_im  -- ufix20
              );

  stream_out_re <= filter_out1_re;

  stream_out_im <= filter_out1_im;

END rtl;
