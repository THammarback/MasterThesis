-- -------------------------------------------------------------
-- 
-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\to_complex\hdlsrc\to_complex_test\combine_to_complex.vhd
-- Created: 2022-05-12 14:31:03
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: combine_to_complex
-- Source Path: to_complex_test/to_complex/combine_to_complex
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.to_complex_pkg.ALL;

ENTITY combine_to_complex IS
  PORT( In1                               :   IN    vector_of_std_logic_vector8(0 TO 1);  -- uint8 [2]
        Out1_re                           :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        Out1_im                           :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
        );
END combine_to_complex;


ARCHITECTURE rtl OF combine_to_complex IS

BEGIN
  Out1_re <= In1(0);

  Out1_im <= In1(1);

END rtl;

