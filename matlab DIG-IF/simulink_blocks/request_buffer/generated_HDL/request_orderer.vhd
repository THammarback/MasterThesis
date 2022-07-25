-- -------------------------------------------------------------
-- 
-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\request_buffer\hdlsrc\request_buffer_test\request_orderer.vhd
-- Created: 2022-05-13 16:42:37
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: request_orderer
-- Source Path: request_buffer_test/request_buffer/request_orderer
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY request_orderer IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        req_in_id                         :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        req_in_valid                      :   IN    std_logic;
        req_in_ts                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        req_cancel_valid                  :   IN    std_logic;
        req_cancel_id                     :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        ti                                :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        write_bus_valid                   :   OUT   std_logic;
        write_bus_address                 :   OUT   std_logic_vector(5 DOWNTO 0);  -- ufix6
        read_bus_id                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        read_bus_valid                    :   OUT   std_logic;
        read_bus_address                  :   OUT   std_logic_vector(5 DOWNTO 0);  -- ufix6
        errors_signal2_mem_full           :   OUT   std_logic;
        errors_signal2_id_not_found_valid :   OUT   std_logic;
        errors_signal2_id_not_found_id    :   OUT   std_logic_vector(15 DOWNTO 0)  -- uint16
        );
END request_orderer;


ARCHITECTURE rtl OF request_orderer IS

  -- Component Declarations
  COMPONENT ts_ctrl
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          write_ts_bus_available_valid    :   IN    std_logic;
          write_ts_bus_available_address  :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
          write_ts_bus_ts                 :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          ti                              :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          read_bus_address                :   OUT   std_logic_vector(5 DOWNTO 0);  -- ufix6
          read_bus_valid                  :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT id_ctrl
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          cancel_valid                    :   IN    std_logic;
          cancel_id                       :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          write_id_bus_id                 :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          write_id_bus_available_valid    :   IN    std_logic;
          write_id_bus_available_address  :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
          read_id_address                 :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
          id_out                          :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
          cancel_out_id                   :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
          cancel_out_valid                :   OUT   std_logic;
          cancel_out_id_found             :   OUT   std_logic;
          cancel_out_address              :   OUT   std_logic_vector(5 DOWNTO 0)  -- ufix6
          );
  END COMPONENT;

  COMPONENT occupy_ctrl
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          cancel_in_id                    :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          cancel_in_valid                 :   IN    std_logic;
          cancel_in_id_found              :   IN    std_logic;
          cancel_in_address               :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
          valid_in                        :   IN    std_logic;
          read_occupy_bus                 :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
          errors_mem_full                 :   OUT   std_logic;
          errors_id_not_found_valid       :   OUT   std_logic;
          errors_id_not_found_id          :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
          occupied_out                    :   OUT   std_logic;
          write_bus_valid                 :   OUT   std_logic;
          write_bus_address               :   OUT   std_logic_vector(5 DOWNTO 0)  -- ufix6
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ts_ctrl
    USE ENTITY work.ts_ctrl(rtl);

  FOR ALL : id_ctrl
    USE ENTITY work.id_ctrl(rtl);

  FOR ALL : occupy_ctrl
    USE ENTITY work.occupy_ctrl(rtl);

  -- Signals
  SIGNAL id                               : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Bus_Creator1_out1_id             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ts                               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Bus_Creator_out1_ts              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL valid                            : std_logic;
  SIGNAL ts_ctrl_out1_address             : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL address                          : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL address_1                        : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL occupy_ctrl_out3_valid           : std_logic;
  SIGNAL occupy_ctrl_out3_address         : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL ts_ctrl_out1_valid               : std_logic;
  SIGNAL address_2                        : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL address_3                        : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL id_1                             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL id_ctrl_out3_id                  : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL id_ctrl_out3_valid               : std_logic;
  SIGNAL id_ctrl_out3_id_found            : std_logic;
  SIGNAL id_ctrl_out3_address             : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL occupy_ctrl_out1_mem_full        : std_logic;
  SIGNAL occupy_ctrl_out1_id_not_found_valid : std_logic;
  SIGNAL occupy_ctrl_out1_id_not_found_id : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL occupy_ctrl_out2                 : std_logic;
  SIGNAL valid_1                          : std_logic;
  SIGNAL valid_2                          : std_logic;
  SIGNAL address_4                        : unsigned(5 DOWNTO 0);  -- ufix6

BEGIN
  u_ts_ctrl : ts_ctrl
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              write_ts_bus_available_valid => occupy_ctrl_out3_valid,
              write_ts_bus_available_address => occupy_ctrl_out3_address,  -- ufix6
              write_ts_bus_ts => Bus_Creator_out1_ts,  -- uint32
              ti => ti,  -- uint16
              read_bus_address => ts_ctrl_out1_address,  -- ufix6
              read_bus_valid => ts_ctrl_out1_valid
              );

  u_id_ctrl : id_ctrl
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              cancel_valid => req_cancel_valid,
              cancel_id => req_cancel_id,  -- uint16
              write_id_bus_id => Bus_Creator1_out1_id,  -- uint16
              write_id_bus_available_valid => occupy_ctrl_out3_valid,
              write_id_bus_available_address => occupy_ctrl_out3_address,  -- ufix6
              read_id_address => address_3,  -- ufix6
              id_out => id_1,  -- uint16
              cancel_out_id => id_ctrl_out3_id,  -- uint16
              cancel_out_valid => id_ctrl_out3_valid,
              cancel_out_id_found => id_ctrl_out3_id_found,
              cancel_out_address => id_ctrl_out3_address  -- ufix6
              );

  u_occupy_ctrl : occupy_ctrl
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              cancel_in_id => id_ctrl_out3_id,  -- uint16
              cancel_in_valid => id_ctrl_out3_valid,
              cancel_in_id_found => id_ctrl_out3_id_found,
              cancel_in_address => id_ctrl_out3_address,  -- ufix6
              valid_in => valid,
              read_occupy_bus => address_1,  -- ufix6
              errors_mem_full => occupy_ctrl_out1_mem_full,
              errors_id_not_found_valid => occupy_ctrl_out1_id_not_found_valid,
              errors_id_not_found_id => occupy_ctrl_out1_id_not_found_id,  -- uint16
              occupied_out => occupy_ctrl_out2,
              write_bus_valid => occupy_ctrl_out3_valid,
              write_bus_address => occupy_ctrl_out3_address  -- ufix6
              );

  id <= unsigned(req_in_id);

  Bus_Creator1_out1_id <= std_logic_vector(id);

  ts <= unsigned(req_in_ts);

  Bus_Creator_out1_ts <= std_logic_vector(ts);

  valid <= req_in_valid;

  address <= unsigned(ts_ctrl_out1_address);

  address_1 <= std_logic_vector(address);

  address_2 <= unsigned(ts_ctrl_out1_address);

  address_3 <= std_logic_vector(address_2);

  valid_1 <= ts_ctrl_out1_valid;

  valid_2 <= occupy_ctrl_out2 AND valid_1;

  address_4 <= unsigned(ts_ctrl_out1_address);

  read_bus_address <= std_logic_vector(address_4);

  write_bus_valid <= occupy_ctrl_out3_valid;

  write_bus_address <= occupy_ctrl_out3_address;

  read_bus_id <= id_1;

  read_bus_valid <= valid_2;

  errors_signal2_mem_full <= occupy_ctrl_out1_mem_full;

  errors_signal2_id_not_found_valid <= occupy_ctrl_out1_id_not_found_valid;

  errors_signal2_id_not_found_id <= occupy_ctrl_out1_id_not_found_id;

END rtl;
