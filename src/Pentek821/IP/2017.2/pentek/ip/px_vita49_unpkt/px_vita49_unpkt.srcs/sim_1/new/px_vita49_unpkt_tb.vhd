----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 09/01/2017 
-- Design Name: testbench
-- Module Name: px_vita49_unpkt_tb - Behavioral
-- Project Name: px_vita49_unpkt
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 

-- (Memory Map)
-- 0x00 - 


-- (Additional Info)

----------------------------------------------------------------------------------

-- (Technical Support for Pentek's GateFlow FPGA Design Kits)  
-- Technical support for Pentek's GateFlow FPGA Design Kits is available via e-mail 
-- (fpgasupport@pentek.com) or by phone (201-818-5900 ext. 238, 9 AM to 5 PM US 
-- Eastern time.) Names or initials contained within the source code are part of 
-- our revision control regime.  Please do not try to use these references to 
-- pursue technical support                              

-- (c) Copyright 2017 Pentek, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Pentek, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Pentek, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND PENTEK HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Pentek shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Pentek had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Pentek products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Pentek products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;
use work.px_utility_pkg.all;


entity px_vita49_unpkt_tb is
end px_vita49_unpkt_tb;

architecture Behavioral of px_vita49_unpkt_tb is

  signal data_words   : std_logic_vector(15 downto 0) := x"0010";
  signal stream_id_en : std_logic                     := '1';
  signal class_id_en  : std_logic                     := '1';
  signal integ_sec_en : std_logic                     := '1';
  signal frat_sec_en  : std_logic                     := '1';
  signal trailer_en   : std_logic                     := '1';
  signal word         : std_logic_vector(31 downto 0) := (others => '0');

  signal header         : std_logic_vector(31 downto 0) := (others => '0');
  signal packet_size    : std_logic_vector(15 downto 0) := (others => '0');
  signal packet_count   : std_logic_vector(3 downto 0)  := x"1";
  signal setup_complete : std_logic                     := '0';
  signal count          : std_logic_vector(15 downto 0) := x"0000";
  signal loops          : integer range 0 to 255        := 0;
  signal error_in_sm_tb : std_logic                     := '0';
  type vita49_sim_states is (header_state,  --0
                             data_state,    --1
                             delay,
                             trailer_state,
                             data_complete
                             );
  signal state : vita49_sim_states;

  signal axis_aclk         : std_logic                      := '0';
  signal axis_aresetn      : std_logic                      := '0';
  signal s_axis_tvalid     : std_logic                      := '0';
  signal s_axis_tready     : std_logic                      := '0';
  signal s_axis_tdata      : std_logic_vector(255 downto 0) := (others => '0');
  signal s_axis_tkeep      : std_logic_vector(31 downto 0)  := (others => '0');
  signal s_axis_tlast      : std_logic                      := '0';
  signal s_axi_csr_aclk    : std_logic                      := '0';
  signal s_axi_csr_aresetn : std_logic                      := '0';
  signal s_axi_csr_awaddr  : std_logic_vector(6 downto 0)   := (others => '0');
  signal s_axi_csr_awprot  : std_logic_vector(2 downto 0)   := (others => '0');
  signal s_axi_csr_awvalid : std_logic                      := '0';
  signal s_axi_csr_awready : std_logic                      := '0';
  signal s_axi_csr_wdata   : std_logic_vector(31 downto 0)  := (others => '0');
  signal s_axi_csr_wstrb   : std_logic_vector(3 downto 0)   := (others => '0');
  signal s_axi_csr_wvalid  : std_logic                      := '0';
  signal s_axi_csr_wready  : std_logic                      := '0';
  signal s_axi_csr_bresp   : std_logic_vector(1 downto 0)   := (others => '0');
  signal s_axi_csr_bvalid  : std_logic                      := '0';
  signal s_axi_csr_bready  : std_logic                      := '0';
  signal s_axi_csr_araddr  : std_logic_vector(6 downto 0)   := (others => '0');
  signal s_axi_csr_arprot  : std_logic_vector(2 downto 0)   := (others => '0');
  signal s_axi_csr_arvalid : std_logic                      := '0';
  signal s_axi_csr_arready : std_logic                      := '0';
  signal s_axi_csr_rdata   : std_logic_vector(31 downto 0)  := (others => '0');
  signal s_axi_csr_rresp   : std_logic_vector(1 downto 0)   := (others => '0');
  signal s_axi_csr_rvalid  : std_logic                      := '0';
  signal s_axi_csr_rready  : std_logic                      := '0';
  signal irq               : std_logic                      := '0';
  signal m_axis_tvalid     : std_logic                      := '0';
  signal m_axis_tready     : std_logic                      := '0';
  signal m_axis_tdata      : std_logic_vector(255 downto 0) := (others => '0');
  signal m_axis_tkeep      : std_logic_vector(31 downto 0)  := (others => '0');
  signal m_axis_tlast      : std_logic                      := '0';

  signal state_count : integer range 0 to 255 := 0;

---------------------------------------------\
--vita49 stuff
---------------------------------------------

signal vita49_s_axis_tvalid     : std_logic                      := '0';
signal vita49_s_axis_tready     : std_logic                      := '0';
signal vita49_s_axis_tdata      : std_logic_vector(31 downto 0)  := (others => '0');
signal vita49_s_axis_tkeep      : std_logic_vector(1 downto 0)   := (others => '0');
signal vita49_s_axis_tlast      : std_logic                      := '0';
signal vita49_s_axis_tuser      : std_logic_vector(79 downto 0)  := x"A5A5A5A5A5A5A5A5A5A5";
signal vita49_s_axi_csr_aclk    : std_logic                      := '0';
signal vita49_s_axi_csr_aresetn : std_logic                      := '0';
signal vita49_s_axi_csr_awaddr  : std_logic_vector(6 downto 0)   := (others => '0');
signal vita49_s_axi_csr_awprot  : std_logic_vector(2 downto 0)   := (others => '0');
signal vita49_s_axi_csr_awvalid : std_logic                      := '0';
signal vita49_s_axi_csr_awready : std_logic                      := '0';
signal vita49_s_axi_csr_wdata   : std_logic_vector(31 downto 0)  := (others => '0');
signal vita49_s_axi_csr_wstrb   : std_logic_vector(3 downto 0)   := (others => '0');
signal vita49_s_axi_csr_wvalid  : std_logic                      := '0';
signal vita49_s_axi_csr_wready  : std_logic                      := '0';
signal vita49_s_axi_csr_bresp   : std_logic_vector(1 downto 0)   := (others => '0');
signal vita49_s_axi_csr_bvalid  : std_logic                      := '0';
signal vita49_s_axi_csr_bready  : std_logic                      := '0';
signal vita49_s_axi_csr_araddr  : std_logic_vector(6 downto 0)   := (others => '0');
signal vita49_s_axi_csr_arprot  : std_logic_vector(2 downto 0)   := (others => '0');
signal vita49_s_axi_csr_arvalid : std_logic                      := '0';
signal vita49_s_axi_csr_arready : std_logic                      := '0';
signal vita49_s_axi_csr_rdata   : std_logic_vector(31 downto 0)  := (others => '0');
signal vita49_s_axi_csr_rresp   : std_logic_vector(1 downto 0)   := (others => '0');
signal vita49_s_axi_csr_rvalid  : std_logic                      := '0';
signal vita49_s_axi_csr_rready  : std_logic                      := '0';
signal vita49_irq               : std_logic                      := '0';
signal vita49_m_axis_tvalid     : std_logic                      := '0';
signal vita49_m_axis_tready     : std_logic                      := '0';
signal vita49_m_axis_tdata      : std_logic_vector(255 downto 0) := (others => '0');
signal vita49_m_axis_tkeep      : std_logic_vector(15 downto 0)  := (others => '0');
signal vita49_m_axis_tlast      : std_logic                      := '0';
signal vita49_m_axis_tuser      : std_logic_vector(79 downto 0)  := (others => '0');
signal vita49_count             : integer range 0 to 255         := 0;
signal vita49_setup_complete    : std_logic                      := '0';
signal vita49_data_words        : integer range 0 to 8192        := 4096;
signal vita49_loops             : integer range 0 to 255         := 0;


begin

  axis_aclk      <= not axis_aclk      after 2 ns;
  s_axi_csr_aclk <= not s_axi_csr_aclk after 3 ns;
  vita49_s_axi_csr_aclk <= not vita49_s_axi_csr_aclk after 3 ns;
 --  m_axis_tready <= not m_axis_tready after 12 ns;


tready_switch : process(axis_aclk)
begin
if rising_edge(axis_aclk) then
   m_axis_tready <= not m_axis_tready;
end if;
end process;

  setup_and_test : process
  begin
    axis_aresetn      <= '1' after 300 ns;
    s_axi_csr_aresetn <= '1' after 300 ns;
    vita49_s_axi_csr_aresetn <= '1' after 300 ns;

    --Write CSR Regs
    wait until rising_edge(s_axi_csr_aresetn);
    --Take core out of reset and enable
    px_axi_lite_writer(std_logic_vector(to_unsigned(0*4, 7)), x"00000003", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    --Read CSR Regs, fail if they are not correct 
    px_axi_lite_reader(std_logic_vector(to_unsigned(0*4, 7)), x"00000003", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
    --Enable Interupts 
    px_axi_lite_writer(std_logic_vector(to_unsigned(10*4, 7)), x"FFFFFFFF", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    setup_complete <= '1';

  --Test IRQ
  --wait until rising_edge(irq);
  --assert false report "Simulation Sucessfully Completed" severity failure;
  end process setup_and_test;



--test1
--  gen_data : process
--  begin
--    wait until (setup_complete = '1');
--    m_axis_tready <= '1';
--    while true loop

--      wait until rising_edge(axis_aclk);
--      case state is
--        when header_state =>
--          if s_axis_tready = '1' then
--            s_axis_tvalid <= '1';
--            s_axis_tdata  <= word & x"FFFFFFFF" & x"FFFFFFFF" & x"11111111" & x"CCCCCCCC" & x"CCCCCCCC" & x"55555555" & header;
--            s_axis_tkeep  <= x"FFFFFFFF";
--            word          <= word + 1;
--            count         <= count + 9;
--            state         <= delay;
--           -- state         <= data_state;
--          end if;
--        when delay      => 
--         s_axis_tvalid <= '0';
--         state         <= data_state;

--        when data_state =>
--          if s_axis_tready = '1' then
--            s_axis_tvalid <= '1';
--            s_axis_tdata  <= (word + 7) & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep  <= x"FFFFFFFF";
--            word          <= word + 8;
--            count         <= count + 8;
--            if count >= data_words - 7 then
--              state <= trailer_state;
--            end if;
--          end if;

--        when trailer_state =>
--          if s_axis_tready = '1' then
--            s_axis_tvalid <= '1';
--            s_axis_tdata  <= x"77777777" & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep  <= x"FFFFFFFF";
--            word          <= word + 7;
--            count         <= (others => '0');           
--            packet_count <= packet_count + 1;
--            state         <= header_state;
--            loops         <= loops +1;
--            if loops = 3 then 
--              state <= data_complete;
--            end if;

--          end if;

--        when data_complete =>
--         s_axis_tvalid <= '0';
--         s_axis_tdata  <= (others => '0');
--         s_axis_tkeep  <= (others => '0');

--        when others =>
--          error_in_sm_tb <= '1';
--      end case;

--    end loop;

--  end process gen_data;

  -- data_words  <= x"0016;

--test2
--  packet_size <= data_words + 1 + (x"000" & "000" & stream_id_en) + (x"000" & "000" & class_id_en) + (x"000" & "000" & class_id_en) + (x"000" & "000" & integ_sec_en) + (x"000" & "000" & frat_sec_en) + (x"000" & "000" & frat_sec_en) + (x"000" & "000" & trailer_en);
--  header      <= "000" & stream_id_en & class_id_en & trailer_en & "00" & "0" & integ_sec_en & "0" & frat_sec_en & packet_count & packet_size;

--  gen_data2 : process(axis_aclk)
--  begin
--   -- wait until (setup_complete = '1');
--   -- m_axis_tready <= '1';

--   -- wait until s_axis_tready = '1';  --header 1
-- if rising_edge(axis_aclk) then
--      --wait until rising_edge(axis_aclk);  --header 1
--      if s_axis_tready = '1' then
--      state_count <= state_count + 1;

--      case state_count is
--        when 1 =>
--            s_axis_tvalid <= '1';
--            s_axis_tdata  <= word & x"FFFFFFFF" & x"FFFFFFFF" & x"11111111" & x"CCCCCCCC" & x"CCCCCCCC" & x"55555555" & header;
--            s_axis_tkeep  <= x"FFFFFFFF";
--            word          <= word + 1;
--        when 2 =>
--            s_axis_tdata <= (word + 7) & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 8;

--        when 3 =>
--            s_axis_tdata <= x"77777777" & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 7;
--            packet_count <= packet_count + 1;

--        when 4 =>
--            s_axis_tvalid <= '0';
--            s_axis_tdata  <= (others => '0');
--            s_axis_tkeep  <= (others => '0');
--            data_words    <= x"0020";

--        when 5 =>
--            s_axis_tvalid <= '1';
--            s_axis_tdata  <= word & x"FFFFFFFF" & x"FFFFFFFF" & x"11111111" & x"CCCCCCCC" & x"CCCCCCCC" & x"55555555" & header;
--            s_axis_tkeep  <= x"FFFFFFFF";
--            word          <= word + 1;

--        when 6 =>
--            s_axis_tdata <= (word + 7) & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 8;
--        when 7 =>
--            s_axis_tdata <= (word + 7) & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 8;
--        when 8 =>
--            s_axis_tdata <= (word + 7) & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 8;
--        when 9 =>
--            s_axis_tdata <= x"77777777" & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 7;
--            packet_count <= packet_count + 1;

--        when 10 =>
--            data_words    <= x"0011";
--            s_axis_tvalid <= '0';
--            s_axis_tdata  <= (others => '0');
--            s_axis_tkeep  <= (others => '0');

--        when 11 =>
--            s_axis_tvalid <= '1';
--            s_axis_tdata  <= word & x"FFFFFFFF" & x"FFFFFFFF" & x"11111111" & x"CCCCCCCC" & x"CCCCCCCC" & x"55555555" & header;
--            s_axis_tkeep  <= x"FFFFFFFF";
--            word          <= word + 1;

--        when 12 =>
--            s_axis_tdata <= (word + 7) & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 8;

--        when 13 =>
--            s_axis_tdata <= (word + 7) & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 8;
--            data_words   <= x"0017";
--            packet_count <= packet_count + 1;

--        when 14 =>
--            s_axis_tvalid <= '1';
--            s_axis_tdata  <= x"FFFFFFFF" & x"FFFFFFFF" & x"11111111" & x"CCCCCCCC" & x"CCCCCCCC" & x"55555555" & header & x"77777777";
--            s_axis_tkeep  <= x"FFFFFFFF";
--            word          <= word + 0;
--        when 15 =>
--            s_axis_tdata <= (word + 7) & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 8;

--        when 16 =>
--            s_axis_tdata <= (word + 7) & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 8;
--        when 17 =>
--            s_axis_tdata <= x"77777777" & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 7;
--            packet_count <= packet_count + 1;
--            data_words   <= x"000D";
--        when 18 =>
--            s_axis_tvalid <= '1';
--            s_axis_tdata  <= word & x"FFFFFFFF" & x"FFFFFFFF" & x"11111111" & x"CCCCCCCC" & x"CCCCCCCC" & x"55555555" & header;
--            s_axis_tkeep  <= x"FFFFFFFF";
--            word          <= word + 1;
--        when 19 =>
--            s_axis_tdata <= (word + 7) & (word + 6) & (word + 5) & (word + 4) & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep <= x"FFFFFFFF";
--            word         <= word + 8;
--            packet_count <= packet_count + 1;
--            data_words   <= x"0006";
--        when 20 =>
--            s_axis_tvalid <= '1';
--            s_axis_tdata  <= x"CCCCCCCC" & x"55555555" & header & x"77777777" & (word + 3) & (word + 2) & (word + 1) & word;
--            s_axis_tkeep  <= x"FFFFFFFF";
--            word          <= word + 4;
--        when 21 =>
--                s_axis_tvalid <= '0';
--                s_axis_tdata  <= (others => '0');
--                s_axis_tkeep  <= (others => '0');
--        when 22 =>
--            s_axis_tvalid <= '1';
--            s_axis_tdata  <= (word + 3) & (word + 2) & (word + 1) & word & x"FFFFFFFF" & x"FFFFFFFF" & x"11111111" & x"CCCCCCCC";
--            s_axis_tkeep  <= x"FFFFFFFF";
--            word          <= word + 4;
--        when 23 =>
--            s_axis_tvalid <= '1';
--            s_axis_tdata  <= x"00000000" & x"00000000" & x"00000000" & x"00000000" & x"00000000" & x"77777777" & (word + 1) & word;
--            s_axis_tkeep  <= x"00000FFF";
--            word          <= word + 2;
--        when others =>
--          s_axis_tvalid <= '0';
--          s_axis_tdata  <= (others => '0');
--          s_axis_tkeep  <= (others => '0');
--      end case;
--            end if;
--     end if; 
--  end process gen_data2;

--test3
  setup_and_test_vita49 : process
  begin
    --Write CSR Regs
    wait until rising_edge(vita49_s_axi_csr_aresetn);
    --Mac dest 47 downto 16
    px_axi_lite_writer(std_logic_vector(to_unsigned(0*4, 7)), x"00000003", vita49_s_axi_csr_aclk, vita49_s_axi_csr_awaddr, vita49_s_axi_csr_awprot, vita49_s_axi_csr_awvalid, vita49_s_axi_csr_awready, vita49_s_axi_csr_wdata, vita49_s_axi_csr_wstrb, vita49_s_axi_csr_wvalid, vita49_s_axi_csr_wready, vita49_s_axi_csr_bresp, vita49_s_axi_csr_bvalid, vita49_s_axi_csr_bready);
    px_axi_lite_writer(std_logic_vector(to_unsigned(1*4, 7)), x"1C501000", vita49_s_axi_csr_aclk, vita49_s_axi_csr_awaddr, vita49_s_axi_csr_awprot, vita49_s_axi_csr_awvalid, vita49_s_axi_csr_awready, vita49_s_axi_csr_wdata, vita49_s_axi_csr_wstrb, vita49_s_axi_csr_wvalid, vita49_s_axi_csr_wready, vita49_s_axi_csr_bresp, vita49_s_axi_csr_bvalid, vita49_s_axi_csr_bready);
    px_axi_lite_writer(std_logic_vector(to_unsigned(2*4, 7)), x"77777777", vita49_s_axi_csr_aclk, vita49_s_axi_csr_awaddr, vita49_s_axi_csr_awprot, vita49_s_axi_csr_awvalid, vita49_s_axi_csr_awready, vita49_s_axi_csr_wdata, vita49_s_axi_csr_wstrb, vita49_s_axi_csr_wvalid, vita49_s_axi_csr_wready, vita49_s_axi_csr_bresp, vita49_s_axi_csr_bvalid, vita49_s_axi_csr_bready);
    px_axi_lite_writer(std_logic_vector(to_unsigned(3*4, 7)), x"CAB2CAFE", vita49_s_axi_csr_aclk, vita49_s_axi_csr_awaddr, vita49_s_axi_csr_awprot, vita49_s_axi_csr_awvalid, vita49_s_axi_csr_awready, vita49_s_axi_csr_wdata, vita49_s_axi_csr_wstrb, vita49_s_axi_csr_wvalid, vita49_s_axi_csr_wready, vita49_s_axi_csr_bresp, vita49_s_axi_csr_bvalid, vita49_s_axi_csr_bready);
    --Read CSR Regs, fail if they are not correct 
    px_axi_lite_reader(std_logic_vector(to_unsigned(0*4, 7)), x"00000003", '1', '1', vita49_s_axi_csr_aclk, vita49_s_axi_csr_araddr, vita49_s_axi_csr_arprot, vita49_s_axi_csr_arvalid, vita49_s_axi_csr_arready, vita49_s_axi_csr_rdata, vita49_s_axi_csr_rresp, vita49_s_axi_csr_rvalid, vita49_s_axi_csr_rready);
    --Enable Interupts 
    --px_axi_lite_writer(std_logic_vector(to_unsigned(10*4, 7)), x"FFFFFFFF", vita49_s_axi_csr_aclk, vita49_s_axi_csr_awaddr, vita49_s_axi_csr_awprot, vita49_s_axi_csr_awvalid, vita49_s_axi_csr_awready, vita49_s_axi_csr_wdata, vita49_s_axi_csr_wstrb, vita49_s_axi_csr_wvalid, vita49_s_axi_csr_wready, vita49_s_axi_csr_bresp, vita49_s_axi_csr_bvalid, vita49_s_axi_csr_bready);
    vita49_setup_complete <= '1';


  end process setup_and_test_vita49;

  gen_data : process
  begin
    wait until (vita49_setup_complete = '1');
  --  m_axis_tready <= '1';
    while vita49_loops < 5 loop
  --  while true loop
      wait until rising_edge(axis_aclk);
      if vita49_count = 0 then
        vita49_count         <= vita49_count + 1;
        vita49_s_axis_tvalid <= '1';
        vita49_s_axis_tdata  <= vita49_s_axis_tdata + x"00000001";
         vita49_s_axis_tkeep  <= "11";       
        vita49_s_axis_tlast  <= '0';
      elsif vita49_count < vita49_data_words and vita49_s_axis_tready = '1' then
        vita49_count         <= vita49_count + 1;
        vita49_s_axis_tvalid <= '1';
        vita49_s_axis_tdata  <= vita49_s_axis_tdata + x"00000001";
        vita49_s_axis_tkeep  <= "11";
        vita49_s_axis_tlast  <= '0';
      elsif vita49_count >= vita49_data_words and vita49_s_axis_tready = '1' then
        vita49_count         <= 0;
        vita49_s_axis_tvalid <= '1';
        vita49_s_axis_tdata  <= vita49_s_axis_tdata + x"00000001";
        vita49_s_axis_tkeep  <= "11";
        vita49_s_axis_tlast  <= '0';
        vita49_loops         <= vita49_loops + 1;
      end if;
    end loop;
  end process gen_data;


  vita49 : entity work.px_vita49_pkt_0
    port map(
      axis_aclk         => axis_aclk,
      axis_aresetn      => axis_aresetn,
      s_axis_tvalid     => vita49_s_axis_tvalid,
      s_axis_tready     => vita49_s_axis_tready,
      s_axis_tdata      => vita49_s_axis_tdata,
      s_axis_tkeep      => vita49_s_axis_tkeep,
      s_axis_tlast      => vita49_s_axis_tlast,
      s_axis_tuser      => vita49_s_axis_tuser,
      s_axi_csr_aclk    => vita49_s_axi_csr_aclk,
      s_axi_csr_aresetn => vita49_s_axi_csr_aresetn,
      s_axi_csr_awaddr  => vita49_s_axi_csr_awaddr,
      s_axi_csr_awprot  => vita49_s_axi_csr_awprot,
      s_axi_csr_awvalid => vita49_s_axi_csr_awvalid,
      s_axi_csr_awready => vita49_s_axi_csr_awready,
      s_axi_csr_wdata   => vita49_s_axi_csr_wdata,
      s_axi_csr_wstrb   => vita49_s_axi_csr_wstrb,
      s_axi_csr_wvalid  => vita49_s_axi_csr_wvalid,
      s_axi_csr_wready  => vita49_s_axi_csr_wready,
      s_axi_csr_bresp   => vita49_s_axi_csr_bresp,
      s_axi_csr_bvalid  => vita49_s_axi_csr_bvalid,
      s_axi_csr_bready  => vita49_s_axi_csr_bready,
      s_axi_csr_araddr  => vita49_s_axi_csr_araddr,
      s_axi_csr_arprot  => vita49_s_axi_csr_arprot,
      s_axi_csr_arvalid => vita49_s_axi_csr_arvalid,
      s_axi_csr_arready => vita49_s_axi_csr_arready,
      s_axi_csr_rdata   => vita49_s_axi_csr_rdata,
      s_axi_csr_rresp   => vita49_s_axi_csr_rresp,
      s_axi_csr_rvalid  => vita49_s_axi_csr_rvalid,
      s_axi_csr_rready  => vita49_s_axi_csr_rready,
      irq               => vita49_irq,
      m_axis_tvalid     => vita49_m_axis_tvalid,
      m_axis_tready     => vita49_m_axis_tready,
      m_axis_tdata      => vita49_m_axis_tdata,
      m_axis_tkeep      => vita49_m_axis_tkeep,
      m_axis_tlast      => vita49_m_axis_tlast,
      m_axis_tuser      => vita49_m_axis_tuser
      );

    uut_vita49 : entity work.px_vita49_unpkt
    port map(
      axis_aclk         => axis_aclk,
      axis_aresetn      => axis_aresetn,
      s_axis_tvalid     => vita49_m_axis_tvalid,
      s_axis_tready     => vita49_m_axis_tready,
      s_axis_tdata      => vita49_m_axis_tdata,
 --     s_axis_tkeep      => vita49_m_axis_tkeep,
      s_axis_tkeep      => x"FFFFFFFF",
      s_axis_tlast      => vita49_m_axis_tlast,
      s_axi_csr_aclk    => s_axi_csr_aclk,
      s_axi_csr_aresetn => s_axi_csr_aresetn,
      s_axi_csr_awaddr  => s_axi_csr_awaddr,
      s_axi_csr_awprot  => s_axi_csr_awprot,
      s_axi_csr_awvalid => s_axi_csr_awvalid,
      s_axi_csr_awready => s_axi_csr_awready,
      s_axi_csr_wdata   => s_axi_csr_wdata,
      s_axi_csr_wstrb   => s_axi_csr_wstrb,
      s_axi_csr_wvalid  => s_axi_csr_wvalid,
      s_axi_csr_wready  => s_axi_csr_wready,
      s_axi_csr_bresp   => s_axi_csr_bresp,
      s_axi_csr_bvalid  => s_axi_csr_bvalid,
      s_axi_csr_bready  => s_axi_csr_bready,
      s_axi_csr_araddr  => s_axi_csr_araddr,
      s_axi_csr_arprot  => s_axi_csr_arprot,
      s_axi_csr_arvalid => s_axi_csr_arvalid,
      s_axi_csr_arready => s_axi_csr_arready,
      s_axi_csr_rdata   => s_axi_csr_rdata,
      s_axi_csr_rresp   => s_axi_csr_rresp,
      s_axi_csr_rvalid  => s_axi_csr_rvalid,
      s_axi_csr_rready  => s_axi_csr_rready,
      irq               => irq,
      m_axis_tvalid     => m_axis_tvalid,
      m_axis_tready     => m_axis_tready,
      m_axis_tdata      => m_axis_tdata,
      m_axis_tkeep      => m_axis_tkeep,
      m_axis_tlast      => m_axis_tlast
      );


--    uut : entity work.px_vita49_unpkt
--    port map(
--      axis_aclk         => axis_aclk,
--      axis_aresetn      => axis_aresetn,
--      s_axis_tvalid     => s_axis_tvalid,
--      s_axis_tready     => s_axis_tready,
--      s_axis_tdata      => s_axis_tdata,
--      s_axis_tkeep      => s_axis_tkeep,
--      s_axis_tlast      => s_axis_tlast,
--      s_axi_csr_aclk    => s_axi_csr_aclk,
--      s_axi_csr_aresetn => s_axi_csr_aresetn,
--      s_axi_csr_awaddr  => s_axi_csr_awaddr,
--      s_axi_csr_awprot  => s_axi_csr_awprot,
--      s_axi_csr_awvalid => s_axi_csr_awvalid,
--      s_axi_csr_awready => s_axi_csr_awready,
--      s_axi_csr_wdata   => s_axi_csr_wdata,
--      s_axi_csr_wstrb   => s_axi_csr_wstrb,
--      s_axi_csr_wvalid  => s_axi_csr_wvalid,
--      s_axi_csr_wready  => s_axi_csr_wready,
--      s_axi_csr_bresp   => s_axi_csr_bresp,
--      s_axi_csr_bvalid  => s_axi_csr_bvalid,
--      s_axi_csr_bready  => s_axi_csr_bready,
--      s_axi_csr_araddr  => s_axi_csr_araddr,
--      s_axi_csr_arprot  => s_axi_csr_arprot,
--      s_axi_csr_arvalid => s_axi_csr_arvalid,
--      s_axi_csr_arready => s_axi_csr_arready,
--      s_axi_csr_rdata   => s_axi_csr_rdata,
--      s_axi_csr_rresp   => s_axi_csr_rresp,
--      s_axi_csr_rvalid  => s_axi_csr_rvalid,
--      s_axi_csr_rready  => s_axi_csr_rready,
--      irq               => irq,
--      m_axis_tvalid     => m_axis_tvalid,
--      m_axis_tready     => m_axis_tready,
--      m_axis_tdata      => m_axis_tdata,
--      m_axis_tkeep      => m_axis_tkeep,
--      m_axis_tlast      => m_axis_tlast
--      );

end Behavioral;
