----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 07/18/2017 
-- Design Name: testbench
-- Module Name: px_vita49_pkt_tb - Behavioral
-- Project Name: px_vita49_pkt
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

entity px_vita49_pkt_tb is
end px_vita49_pkt_tb;

architecture Behavioral of px_vita49_pkt_tb is

  signal axis_aclk         : std_logic                      := '0';
  signal axis_aresetn      : std_logic                      := '0';
  signal s_axis_tvalid     : std_logic                      := '0';
  signal s_axis_tready     : std_logic                      := '0';
  signal s_axis_tdata      : std_logic_vector(31 downto 0)  := (others => '0');
  signal s_axis_tkeep      : std_logic_vector(1 downto 0)   := (others => '0');
  signal s_axis_tlast      : std_logic                      := '0';
  signal s_axis_tuser      : std_logic_vector(79 downto 0)  := x"A5A5A5A5A5A5A5A5A5A5";
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
  signal m_axis_tkeep      : std_logic_vector(15 downto 0)  := (others => '0');
  signal m_axis_tlast      : std_logic                      := '0';
  signal m_axis_tuser      : std_logic_vector(79 downto 0)  := (others => '0');
  signal count             : integer range 0 to 255         := 0;
  signal setup_complete    : std_logic                      := '0';
  signal data_words        : integer range 0 to 8192        := 1024;
  signal loops             : integer range 0 to 255         := 0;
  signal end_test          : std_logic := '0';
begin

  axis_aclk      <= not axis_aclk      after 2 ns;
  s_axi_csr_aclk <= not s_axi_csr_aclk after 3 ns;


  setup_and_test : process
  begin
    axis_aresetn      <= '1' after 300 ns;
    s_axi_csr_aresetn <= '1' after 300 ns;

    --Write CSR Regs
    wait until rising_edge(s_axi_csr_aresetn);
    --Mac dest 47 downto 16
    px_axi_lite_writer(std_logic_vector(to_unsigned(0*4, 7)), x"00000003", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    px_axi_lite_writer(std_logic_vector(to_unsigned(1*4, 7)), x"1C50" & std_logic_vector(to_unsigned(data_words, 16)), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    px_axi_lite_writer(std_logic_vector(to_unsigned(2*4, 7)), x"77777777", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    px_axi_lite_writer(std_logic_vector(to_unsigned(3*4, 7)), x"CAB2CAFE", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    --Read CSR Regs, fail if they are not correct 
    px_axi_lite_reader(std_logic_vector(to_unsigned(0*4, 7)), x"00000003", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
    --Enable Interupts 
    --px_axi_lite_writer(std_logic_vector(to_unsigned(10*4, 7)), x"FFFFFFFF", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    setup_complete <= '1';

    --Test IRQ
--    wait for 20 us;  --Change this for more or less Data Generated
--    tx_axis_aresetn <= '0';
--    wait for 100 ns;
--    tx_axis_aresetn <= '1';
--    wait until rising_edge(irq);
--    assert false report "Simulation Sucessfully Completed" severity failure;

  end process setup_and_test;

gen_data : process(axis_aclk)
  begin
  if rising_edge(axis_aclk) and setup_complete = '1' then
      if s_axis_tvalid = '1' then
          s_axis_tvalid <= '0';

      elsif count = 0 then
        count         <= count + 1;
        s_axis_tvalid <= '1';
        s_axis_tdata  <= s_axis_tdata + x"00000001";
        s_axis_tkeep  <= "11";
        s_axis_tlast  <= '0';
       elsif count = data_words-1 and s_axis_tready = '1' then --added this to test t_last functionality
          count         <= count + 1;
          s_axis_tvalid <= '1';
          s_axis_tdata  <= s_axis_tdata + x"00000001";
          s_axis_tkeep  <= "11";
          s_axis_tlast  <= '1';
      elsif count < data_words and s_axis_tready = '1' then
        count         <= count + 1;
        s_axis_tvalid <= '1';
        s_axis_tdata  <= s_axis_tdata + x"00000001";
        s_axis_tkeep  <= "11";
        s_axis_tlast  <= '0';
      elsif count >= data_words and s_axis_tready = '1' then
        count         <= 1;
        s_axis_tvalid <= '1';
        s_axis_tdata  <= s_axis_tdata + x"00000001";
        s_axis_tkeep  <= "11";
        s_axis_tlast  <= '0';
        loops         <= loops + 1;
--          s_axis_tvalid <= '0';
--          s_axis_tdata  <= (others => '0');
--          s_axis_tkeep  <= "11";
--          s_axis_tlast  <= '0';
--          end_test <= '1';
      end if;
      if loops > 2 and loops < 4 then
        m_axis_tready <= not m_axis_tready;
      else
        m_axis_tready <= '1';
      end if;
    end if;
  end process gen_data;


  uut : entity work.px_vita49_pkt
    port map(
      axis_aclk         => axis_aclk,
      axis_aresetn      => axis_aresetn,
      s_axis_tvalid     => s_axis_tvalid,
      s_axis_tready     => s_axis_tready,
      s_axis_tdata      => s_axis_tdata,
      s_axis_tkeep      => s_axis_tkeep,
      s_axis_tlast      => s_axis_tlast,
      s_axis_tuser      => s_axis_tuser,
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
      m_axis_tlast      => m_axis_tlast,
      m_axis_tuser      => m_axis_tuser
      );

end Behavioral;
