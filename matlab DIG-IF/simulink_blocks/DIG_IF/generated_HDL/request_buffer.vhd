-- -------------------------------------------------------------
-- 

-- File Name: E:\Downloads\2021b-10mayFINAL\2021b-10mayFINAL\srcFiles\DIG_IF\hdlsrc\DIG_IF_test\request_buffer.vhd
-- Created: 2022-05-10 17:23:04
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: request_buffer
-- Source Path: DIG_IF_test/DIG_IF/request_buffer
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY request_buffer IS
  PORT( clk                               :   IN    std_logic;
        ti                                :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        req_in_valid                      :   IN    std_logic;
        req_in_fn                         :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        req_in_id                         :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        req_in_filter_address             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        req_in_dist_address               :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        req_in_ts                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        req_in_ls                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        req_in_UC                         :   IN    std_logic;
        req_in_UT                         :   IN    std_logic;
        req_in_SEND                       :   IN    std_logic;
        req_cancel_valid                  :   IN    std_logic;
        req_cancel_id                     :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        busy                              :   IN    std_logic;
        req_out_req_UC                    :   OUT   std_logic;
        req_out_req_SEND                  :   OUT   std_logic;
        req_out_req_fn                    :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        req_out_req_filter_address        :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        req_out_req_dist_address          :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        req_out_req_ss                    :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        req_out_id                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        req_out_valid                     :   OUT   std_logic;
        errors_id_not_found_valid         :   OUT   std_logic;
        errors_id_not_found_id            :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        errors_mem_full                   :   OUT   std_logic;
        errors_overlap                    :   OUT   std_logic
        );
END request_buffer;


ARCHITECTURE rtl OF request_buffer IS

  -- Component Declarations
  COMPONENT untimed_ctrl
    PORT( clk                             :   IN    std_logic;
          valid                           :   IN    std_logic;
          ts                              :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          ls                              :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          UT                              :   IN    std_logic;
          ts_out                          :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
          ss                              :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
          );
  END COMPONENT;

  COMPONENT request_orderer
    PORT( clk                             :   IN    std_logic;
          req_in_id                       :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          req_in_valid                    :   IN    std_logic;
          req_in_ts                       :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          req_cancel_valid                :   IN    std_logic;
          req_cancel_id                   :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          ti                              :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          write_bus_valid                 :   OUT   std_logic;
          write_bus_address               :   OUT   std_logic_vector(5 DOWNTO 0);  -- ufix6
          read_bus_id                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
          read_bus_valid                  :   OUT   std_logic;
          read_bus_address                :   OUT   std_logic_vector(5 DOWNTO 0);  -- ufix6
          errors_signal2_mem_full         :   OUT   std_logic;
          errors_signal2_id_not_found_valid :   OUT   std_logic;
          errors_signal2_id_not_found_id  :   OUT   std_logic_vector(15 DOWNTO 0)  -- uint16
          );
  END COMPONENT;

  COMPONENT rams_block1
    PORT( clk                             :   IN    std_logic;
          wr_din_UC                       :   IN    std_logic;
          wr_din_SEND                     :   IN    std_logic;
          wr_din_fn                       :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          wr_din_filter_address           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          wr_din_dist_address             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          wr_din_ss                       :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          wr_addr                         :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
          rd_dout_UC                      :   OUT   std_logic;
          rd_dout_SEND                    :   OUT   std_logic;
          rd_dout_fn                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
          rd_dout_filter_address          :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          rd_dout_dist_address            :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          rd_dout_ss                      :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : untimed_ctrl
    USE ENTITY work.untimed_ctrl(rtl);

  FOR ALL : request_orderer
    USE ENTITY work.request_orderer(rtl);

  FOR ALL : rams_block1
    USE ENTITY work.rams_block1(rtl);

  -- Signals
  SIGNAL req_valid                        : std_logic;
  SIGNAL UC                               : std_logic;
  SIGNAL valid                            : std_logic;
  SIGNAL ts                               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL ts_1                             : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL ls                               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL ls_1                             : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL UT                               : std_logic;
  SIGNAL ts_2                             : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL ss                               : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL id                               : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL alpha_id                         : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL valid_1                          : std_logic;
  SIGNAL ts_3                             : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL alpha_ts                         : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL ti_unsigned                      : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL latency_fix_out1                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL request_orderer_out1_valid       : std_logic;
  SIGNAL request_orderer_out1_address     : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL request_orderer_out2_id          : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL request_orderer_out2_valid       : std_logic;
  SIGNAL request_orderer_out2_address     : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL request_orderer_out3_signal2_mem_ful : std_logic;
  SIGNAL request_orderer_out3_signal2_id_not : std_logic;
  SIGNAL request_orderer_out3_signal2_id_not_1 : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL SEND                             : std_logic;
  SIGNAL fn                               : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL alpha_fn                         : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL filter_address                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL alpha_filter_address             : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL dist_address                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL alpha_dist_address               : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL ss_1                             : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL alpha_ss                         : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL address                          : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL address_1                        : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL valid_2                          : std_logic;
  SIGNAL address_2                        : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL address_3                        : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL req_UC                           : std_logic;
  SIGNAL req_SEND                         : std_logic;
  SIGNAL req_fn                           : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL req_filter_address               : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL req_dist_address                 : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL req_ss                           : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL id_1                             : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL id_2                             : unsigned(15 DOWNTO 0) := to_unsigned(16#0000#, 16);  -- uint16
  SIGNAL valid_3                          : std_logic;
  SIGNAL NOT_out1                         : std_logic;
  SIGNAL valid_4                          : std_logic;
  SIGNAL valid_5                          : std_logic := '0';
  SIGNAL mem_full                         : std_logic;
  SIGNAL overlap                          : std_logic;

BEGIN
  Uuntimed_ctrl_1 : untimed_ctrl
    PORT MAP( clk => clk,
              valid => valid,
              ts => ts_1,  -- uint32
              ls => ls_1,  -- uint32
              UT => UT,
              ts_out => ts_2,  -- uint32
              ss => ss  -- uint32
              );

  Urequest_orderer_1 : request_orderer
    PORT MAP( clk => clk,
              req_in_id => alpha_id,  -- uint16
              req_in_valid => valid_1,
              req_in_ts => alpha_ts,  -- uint32
              req_cancel_valid => req_cancel_valid,
              req_cancel_id => req_cancel_id,  -- uint16
              ti => std_logic_vector(latency_fix_out1),  -- uint32
              write_bus_valid => request_orderer_out1_valid,
              write_bus_address => request_orderer_out1_address,  -- ufix6
              read_bus_id => request_orderer_out2_id,  -- uint16
              read_bus_valid => request_orderer_out2_valid,
              read_bus_address => request_orderer_out2_address,  -- ufix6
              errors_signal2_mem_full => request_orderer_out3_signal2_mem_ful,
              errors_signal2_id_not_found_valid => request_orderer_out3_signal2_id_not,
              errors_signal2_id_not_found_id => request_orderer_out3_signal2_id_not_1  -- uint16
              );

  Urams : rams_block1
    PORT MAP( clk => clk,
              wr_din_UC => UC,
              wr_din_SEND => SEND,
              wr_din_fn => alpha_fn,  -- uint16
              wr_din_filter_address => alpha_filter_address,  -- uint8
              wr_din_dist_address => alpha_dist_address,  -- uint8
              wr_din_ss => alpha_ss,  -- uint32
              wr_addr => address_1,  -- ufix6
              wr_en => valid_2,
              rd_addr => address_3,  -- ufix6
              rd_dout_UC => req_UC,
              rd_dout_SEND => req_SEND,
              rd_dout_fn => req_fn,  -- uint16
              rd_dout_filter_address => req_filter_address,  -- uint8
              rd_dout_dist_address => req_dist_address,  -- uint8
              rd_dout_ss => req_ss  -- uint32
              );

  req_valid <= req_in_valid;

  UC <= req_in_UC;

  valid <= req_valid;

  ts <= unsigned(req_in_ts);

  ts_1 <= std_logic_vector(ts);

  ls <= unsigned(req_in_ls);

  ls_1 <= std_logic_vector(ls);

  UT <= req_in_UT;

  id <= unsigned(req_in_id);

  alpha_id <= std_logic_vector(id);

  valid_1 <= req_valid;

  ts_3 <= unsigned(ts_2);

  alpha_ts <= std_logic_vector(ts_3);

  ti_unsigned <= unsigned(ti);

  latency_fix_out1 <= ti_unsigned + to_unsigned(1, 32);

  SEND <= req_in_SEND;

  fn <= unsigned(req_in_fn);

  alpha_fn <= std_logic_vector(fn);

  filter_address <= unsigned(req_in_filter_address);

  alpha_filter_address <= std_logic_vector(filter_address);

  dist_address <= unsigned(req_in_dist_address);

  alpha_dist_address <= std_logic_vector(dist_address);

  ss_1 <= unsigned(ss);

  alpha_ss <= std_logic_vector(ss_1);

  address <= unsigned(request_orderer_out1_address);

  address_1 <= std_logic_vector(address);

  valid_2 <= request_orderer_out1_valid;

  address_2 <= unsigned(request_orderer_out2_address);

  address_3 <= std_logic_vector(address_2);

  id_1 <= unsigned(request_orderer_out2_id);

  Delay_rsvd_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      id_2 <= id_1;
    END IF;
  END PROCESS Delay_rsvd_process;


  req_out_id <= std_logic_vector(id_2);

  valid_3 <= request_orderer_out2_valid;

  NOT_out1 <=  NOT busy;

  valid_4 <= valid_3 AND NOT_out1;

  Delay1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      valid_5 <= valid_4;
    END IF;
  END PROCESS Delay1_process;


  errors_id_not_found_valid <= request_orderer_out3_signal2_id_not;

  mem_full <= request_orderer_out3_signal2_mem_ful;

  errors_mem_full <= mem_full;

  overlap <= valid_3 AND busy;

  errors_overlap <= overlap;

  req_out_req_UC <= req_UC;

  req_out_req_SEND <= req_SEND;

  req_out_req_fn <= req_fn;

  req_out_req_filter_address <= req_filter_address;

  req_out_req_dist_address <= req_dist_address;

  req_out_req_ss <= req_ss;

  req_out_valid <= valid_5;

  errors_id_not_found_id <= request_orderer_out3_signal2_id_not_1;

END rtl;

