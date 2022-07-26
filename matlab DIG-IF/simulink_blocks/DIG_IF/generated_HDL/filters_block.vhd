-- -------------------------------------------------------------
-- 

-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\filters_block.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: filters_block
-- Source Path: DIG_IF_test/DIG_IF/ul_filter/filters
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DIG_IF_pac.ALL;

ENTITY filters_block IS
  PORT( clk                               :   IN    std_logic;
        stream_in_re                      :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        stream_in_im                      :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        coeffs                            :   IN    vector_of_std_logic_vector8(0 TO 9);  -- uint8 [10]
        stream_out_re                     :   OUT   std_logic_vector(23 DOWNTO 0);  -- ufix24
        stream_out_im                     :   OUT   std_logic_vector(23 DOWNTO 0)  -- ufix24
        );
END filters_block;


ARCHITECTURE rtl OF filters_block IS

  -- Component Declarations
  COMPONENT filter_block
    PORT( clk                             :   IN    std_logic;
          stream_in_re                    :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          stream_in_im                    :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
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
          stream_out_re                   :   OUT   std_logic_vector(23 DOWNTO 0);  -- ufix24
          stream_out_im                   :   OUT   std_logic_vector(23 DOWNTO 0)  -- ufix24
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : filter_block
    USE ENTITY work.filter_block(rtl);

  -- Signals
  SIGNAL filter_out1_re                   : std_logic_vector(23 DOWNTO 0);  -- ufix24
  SIGNAL filter_out1_im                   : std_logic_vector(23 DOWNTO 0);  -- ufix24

BEGIN
  Ufilter : filter_block
    PORT MAP( clk => clk,
              stream_in_re => stream_in_re,  -- uint8
              stream_in_im => stream_in_im,  -- uint8
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
              stream_out_re => filter_out1_re,  -- ufix24
              stream_out_im => filter_out1_im  -- ufix24
              );

  stream_out_re <= filter_out1_re;

  stream_out_im <= filter_out1_im;

END rtl;

