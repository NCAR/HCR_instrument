----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 4/14/2017
-- Design Name: testbench
-- Module Name: px_10ge_udp_rx_tb
-- Project Name: px_10ge_udp_rx
-- Target Devices: Virtex 7
-- Tool Versions: Vivado 2016.4
-- Description: Testbench
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 

-- (Memory Map)
-- 0x00 - Control Bits
-- 0x04 - Source Mac 47 downto 16
-- 0x08 - Source Mac 15 downto 0
-- 0x0C - Source IP Address
-- 0x10 - Source Port
-- 0x14 - Fifo Count
-- 0x18 - rx Statistics 
-- 0x1C - IRQ Enable
-- 0x20 - IRQ Status
-- 0x00 - IRW Flags

-- Interrupts
-- Bit 0 : RX_block_unlock
-- Bit 1 : FIFO Empty
-- Bit 2 : FIFO Full


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

entity px_10ge_udp_rx_tb is
end px_10ge_udp_rx_tb;

architecture Behavioral of px_10ge_udp_rx_tb is
--signals 


--simulation signals (Change for different simulation results)
  constant input_data_pack_size : integer   := 64;  --datasize*8(bits)/64(bits per count)
  signal packet_sm_enable       : std_logic := '1';
  signal packet_max_size        : std_logic := '0';  --0=1k 1=8k
  signal custom_pkt_size        : std_logic := '1';

--simulation signals (dont change)
  signal count          : integer   := 0;
  signal reset_control  : std_logic := '1';
  signal fifo_flush     : std_logic := '1';
  signal setup_complete : std_logic := '0';

--pentek tx signals 
  signal axis_aclk         : std_logic                     := '0';  --connect to coreclk_out from PCS/PMA IP Core
  signal axis_aresetn      : std_logic                     := '0';  --connect to resetdone_out from PCS/PMA IP Core
  signal xilinx_core_rdy   : std_logic                     := '0';
  signal s_axis_eth_tvalid : std_logic                     := '0';
  signal s_axis_eth_tready : std_logic                     := '0';
  signal s_axis_eth_tdata  : std_logic_vector(63 downto 0) := (others => '0');
  signal s_axis_eth_tkeep  : std_logic_vector(7 downto 0)  := (others => '0');
  signal s_axis_eth_tlast  : std_logic                     := '0';
  signal s_axi_csr_aclk    : std_logic                     := '0';
  signal s_axi_csr_aresetn : std_logic                     := '0';
  signal s_axi_csr_awaddr  : std_logic_vector(6 downto 0)  := (others => '0');
  signal s_axi_csr_awprot  : std_logic_vector(2 downto 0)  := (others => '0');
  signal s_axi_csr_awvalid : std_logic                     := '0';
  signal s_axi_csr_awready : std_logic                     := '0';
  signal s_axi_csr_wdata   : std_logic_vector(31 downto 0) := (others => '0');
  signal s_axi_csr_wstrb   : std_logic_vector(3 downto 0)  := (others => '0');
  signal s_axi_csr_wvalid  : std_logic                     := '0';
  signal s_axi_csr_wready  : std_logic                     := '0';
  signal s_axi_csr_bresp   : std_logic_vector(1 downto 0)  := (others => '0');
  signal s_axi_csr_bvalid  : std_logic                     := '0';
  signal s_axi_csr_bready  : std_logic                     := '0';
  signal s_axi_csr_araddr  : std_logic_vector(6 downto 0)  := (others => '0');
  signal s_axi_csr_arprot  : std_logic_vector(2 downto 0)  := (others => '0');
  signal s_axi_csr_arvalid : std_logic                     := '0';
  signal s_axi_csr_arready : std_logic                     := '0';
  signal s_axi_csr_rdata   : std_logic_vector(31 downto 0) := (others => '0');
  signal s_axi_csr_rresp   : std_logic_vector(1 downto 0)  := (others => '0');
  signal s_axi_csr_rvalid  : std_logic                     := '0';
  signal s_axi_csr_rready  : std_logic                     := '0';
  signal irq               : std_logic                     := '0';
  signal m_axis_tx_tvalid  : std_logic                     := '0';
  signal m_axis_tx_tready  : std_logic                     := '0';
  signal m_axis_tx_tdata   : std_logic_vector(63 downto 0) := (others => '0');
  signal m_axis_tx_tkeep   : std_logic_vector(7 downto 0)  := (others => '0');
  signal m_axis_tx_tlast   : std_logic                     := '0';
  signal m_axis_tx_tuser   : std_logic_vector(0 downto 0)  := (others => '0');

--eth core
  signal refclk_p             : std_logic                     := '0';
  signal refclk_n             : std_logic                     := '0';
  signal tx_axis_aresetn      : std_logic                     := '0';
  signal rx_axis_aresetn      : std_logic                     := '0';
  signal reset                : std_logic                     := '1';
  signal txp                  : std_logic                     := '0';
  signal txn                  : std_logic                     := '0';
  signal rxp                  : std_logic                     := '0';
  signal rxn                  : std_logic                     := '0';
  signal sim_speedup_control  : std_logic                     := '0';
  signal rxrecclk_out         : std_logic                     := '0';
  signal pcspma_status        : std_logic_vector(7 downto 0)  := (others => '0');
--pentek rx signals 
  signal m_axis_rx_tvalid     : std_logic                     := '0';
  signal m_axis_rx_tdata      : std_logic_vector(63 downto 0) := (others => '0');
  signal m_axis_rx_tkeep      : std_logic_vector(7 downto 0)  := (others => '0');
  signal m_axis_rx_tlast      : std_logic                     := '0';
  signal m_axis_rx_tuser      : std_logic                     := '0';
  signal s_axi_csr_rx_aclk    : std_logic                     := '0';
  signal s_axi_csr_rx_aresetn : std_logic                     := '0';
  signal s_axi_csr_rx_awaddr  : std_logic_vector(6 downto 0)  := (others => '0');
  signal s_axi_csr_rx_awprot  : std_logic_vector(2 downto 0)  := (others => '0');
  signal s_axi_csr_rx_awvalid : std_logic                     := '0';
  signal s_axi_csr_rx_awready : std_logic                     := '0';
  signal s_axi_csr_rx_wdata   : std_logic_vector(31 downto 0) := (others => '0');
  signal s_axi_csr_rx_wstrb   : std_logic_vector(3 downto 0)  := (others => '0');
  signal s_axi_csr_rx_wvalid  : std_logic                     := '0';
  signal s_axi_csr_rx_wready  : std_logic                     := '0';
  signal s_axi_csr_rx_bresp   : std_logic_vector(1 downto 0)  := (others => '0');
  signal s_axi_csr_rx_bvalid  : std_logic                     := '0';
  signal s_axi_csr_rx_bready  : std_logic                     := '0';
  signal s_axi_csr_rx_araddr  : std_logic_vector(6 downto 0)  := (others => '0');
  signal s_axi_csr_rx_arprot  : std_logic_vector(2 downto 0)  := (others => '0');
  signal s_axi_csr_rx_arvalid : std_logic                     := '0';
  signal s_axi_csr_rx_arready : std_logic                     := '0';
  signal s_axi_csr_rx_rdata   : std_logic_vector(31 downto 0) := (others => '0');
  signal s_axi_csr_rx_rresp   : std_logic_vector(1 downto 0)  := (others => '0');
  signal s_axi_csr_rx_rvalid  : std_logic                     := '0';
  signal s_axi_csr_rx_rready  : std_logic                     := '0';
  signal irq_rx               : std_logic                     := '0';
  signal m_axis_eth_tvalid    : std_logic                     := '0';
  signal m_axis_eth_tready    : std_logic                     := '0';
  signal m_axis_eth_tdata     : std_logic_vector(63 downto 0) := (others => '0');
  signal m_axis_eth_tkeep     : std_logic_vector(7 downto 0)  := (others => '0');
  signal m_axis_eth_tlast     : std_logic                     := '0';
  signal m_axis_eth_tuser     : std_logic_vector(0 downto 0)  := (others => '0');

begin

--Simulation only
---------------------------------------------------------------
  refclk_p          <= not refclk_p       after 2 ns;
  refclk_n          <= not refclk_p;
  s_axi_csr_aclk    <= not s_axi_csr_aclk after 3 ns;
  s_axi_csr_rx_aclk <= s_axi_csr_aclk;

  rxp             <= txp;
  rxn             <= txn;
  rx_axis_aresetn <= tx_axis_aresetn;
  reset           <= not tx_axis_aresetn;

  setup_and_test : process
  begin
    sim_speedup_control <= '1' after 200 ns;
    tx_axis_aresetn     <= '1' after 300 ns;
    s_axi_csr_aresetn   <= '1' after 300 ns;

    --Write CSR Regs
    wait until rising_edge(s_axi_csr_aresetn);
    --Mac dest 47 downto 16
    px_axi_lite_writer(std_logic_vector(to_unsigned(0*4, 7)), x"da010203", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    --Mac dest 15 downto 0
    px_axi_lite_writer(std_logic_vector(to_unsigned(1*4, 7)), x"00000405", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    --IP source
    px_axi_lite_writer(std_logic_vector(to_unsigned(2*4, 7)), x"19216811", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    --IP destination
    px_axi_lite_writer(std_logic_vector(to_unsigned(3*4, 7)), x"26731966", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    --UDP source
    px_axi_lite_writer(std_logic_vector(to_unsigned(4*4, 7)), x"0000aaaa", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    --UDP destination 
    px_axi_lite_writer(std_logic_vector(to_unsigned(5*4, 7)), x"0000dddd", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    --setup regs
    px_axi_lite_writer(std_logic_vector(to_unsigned(6*4, 7)), x"000000" & "000" & custom_pkt_size & packet_max_size & packet_sm_enable & fifo_flush & reset_control, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);

    --read regs
--    px_axi_lite_reader(std_logic_vector(to_unsigned(0*4, 7)), x"da010203", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
--    px_axi_lite_reader(std_logic_vector(to_unsigned(1*4, 7)), x"00000405", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
--    px_axi_lite_reader(std_logic_vector(to_unsigned(2*4, 7)), x"19216811", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
--    px_axi_lite_reader(std_logic_vector(to_unsigned(3*4, 7)), x"26731966", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
--    px_axi_lite_reader(std_logic_vector(to_unsigned(4*4, 7)), x"00005555", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
--    px_axi_lite_reader(std_logic_vector(to_unsigned(5*4, 7)), x"0000dddd", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
--    px_axi_lite_reader(std_logic_vector(to_unsigned(6*4, 7)), x"000000" & "000" & custom_pkt_size & packet_max_size & packet_sm_enable & fifo_flush & reset_control, '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
--    px_axi_lite_reader(std_logic_vector(to_unsigned(7*4, 7)), x"00000000", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
--    px_axi_lite_reader(std_logic_vector(to_unsigned(8*4, 7)), x"00000001", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
--    px_axi_lite_reader(std_logic_vector(to_unsigned(9*4, 7)), x"00000001", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);

    --Write CSR RX Regs
    s_axi_csr_rx_aresetn <= '1' after 300 ns;
    px_axi_lite_writer(std_logic_vector(to_unsigned(0*4, 7)), x"00000001", s_axi_csr_rx_aclk, s_axi_csr_rx_awaddr, s_axi_csr_rx_awprot, s_axi_csr_rx_awvalid, s_axi_csr_rx_awready, s_axi_csr_rx_wdata, s_axi_csr_rx_wstrb, s_axi_csr_rx_wvalid, s_axi_csr_rx_wready, s_axi_csr_rx_bresp, s_axi_csr_rx_bvalid, s_axi_csr_rx_bready);

    setup_complete <= '1';
  end process setup_and_test;


  gen_data : process
  begin
    wait until (setup_complete = '1' and axis_aresetn = '1');
    while true loop
      wait until rising_edge(axis_aclk);
      if count = 0 then
        count             <= count + 1;
        s_axis_eth_tvalid <= '0';
        s_axis_eth_tlast  <= '0';
      elsif count < input_data_pack_size/8 and s_axis_eth_tready = '1' then
        count             <= count + 1;
        s_axis_eth_tvalid <= '1';
        s_axis_eth_tdata  <= x"123456789abcdef8";  --s_axis_eth_tdata + x"0000000000000001";
        s_axis_eth_tkeep  <= x"FF";
        s_axis_eth_tlast  <= '0';
      elsif count >= input_data_pack_size/8 and s_axis_eth_tready = '1' then
        count             <= 0;
        s_axis_eth_tvalid <= '1';
        s_axis_eth_tdata  <= x"DEADBEEFAAAABBBB";
        s_axis_eth_tkeep  <= x"ff";
        s_axis_eth_tlast  <= '1';
      end if;
    end loop;
  end process gen_data;
  ---------------------------------------------------------------


  tx : entity work.px_10ge_udp_tx_0
    port map (
      axis_aclk         => axis_aclk,
      axis_aresetn      => axis_aresetn,
      xilinx_core_rdy   => xilinx_core_rdy,
      s_axis_eth_tvalid => s_axis_eth_tvalid,
      s_axis_eth_tready => s_axis_eth_tready,
      s_axis_eth_tdata  => s_axis_eth_tdata,
      s_axis_eth_tkeep  => s_axis_eth_tkeep,
      s_axis_eth_tlast  => s_axis_eth_tlast,
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
      m_axis_tx_tvalid  => m_axis_tx_tvalid,
      m_axis_tx_tready  => m_axis_tx_tready,
      m_axis_tx_tdata   => m_axis_tx_tdata,
      m_axis_tx_tkeep   => m_axis_tx_tkeep,
      m_axis_tx_tlast   => m_axis_tx_tlast,
      m_axis_tx_tuser   => m_axis_tx_tuser
      );

  ethernet_core_inst : entity work.ethernet_core
    port map (
      tx_axis_aresetn              => tx_axis_aresetn,
      rx_axis_aresetn              => rx_axis_aresetn,
      tx_ifg_delay                 => (others => '0'),
      dclk                         => s_axi_csr_aclk,
      txp                          => txp,
      txn                          => txn,
      rxp                          => rxp,
      rxn                          => rxn,
      signal_detect                => '1',
      tx_fault                     => '0',
      tx_disable                   => open,
      pcspma_status                => pcspma_status,
      sim_speedup_control          => sim_speedup_control,
      rxrecclk_out                 => rxrecclk_out,
      mac_tx_configuration_vector  => x"00000000000000000002",
      mac_rx_configuration_vector  => x"00000000000000000002",
      mac_status_vector            => open,
      pcs_pma_configuration_vector => (others => '0'),
      areset_datapathclk_out       => open,
      txusrclk_out                 => open,
      txusrclk2_out                => open,
      gttxreset_out                => open,
      gtrxreset_out                => open,
      txuserrdy_out                => xilinx_core_rdy,
      coreclk_out                  => axis_aclk,
      resetdone_out                => axis_aresetn,
      reset_counter_done_out       => open,
      qpll0lock_out                => open,
      qpll0outclk_out              => open,
      qpll0outrefclk_out           => open,
      refclk_p                     => refclk_p,
      refclk_n                     => refclk_n,
      reset                        => reset,
      s_axis_tx_tdata              => m_axis_tx_tdata,
      s_axis_tx_tkeep              => m_axis_tx_tkeep,
      s_axis_tx_tlast              => m_axis_tx_tlast,
      s_axis_tx_tready             => m_axis_tx_tready,
      s_axis_tx_tuser              => m_axis_tx_tuser,
      s_axis_tx_tvalid             => m_axis_tx_tvalid,
      s_axis_pause_tdata           => (others => '0'),
      s_axis_pause_tvalid          => '0',
      m_axis_rx_tdata              => m_axis_rx_tdata,
      m_axis_rx_tkeep              => m_axis_rx_tkeep,
      m_axis_rx_tlast              => m_axis_rx_tlast,
      m_axis_rx_tuser              => m_axis_rx_tuser,
      m_axis_rx_tvalid             => m_axis_rx_tvalid,
      tx_statistics_valid          => open,
      tx_statistics_vector         => open,
      rx_statistics_valid          => open,
      rx_statistics_vector         => open
      );

----unit under test
  uut : entity work.px_10ge_udp_rx
    port map(
      axis_aclk         => axis_aclk,
      axis_aresetn      => axis_aresetn,
      xilinx_core_rdy   => pcspma_status(0),
      s_axis_rx_tvalid  => m_axis_rx_tvalid,
      s_axis_rx_tdata   => m_axis_rx_tdata,
      s_axis_rx_tkeep   => m_axis_rx_tkeep,
      s_axis_rx_tlast   => m_axis_rx_tlast,
      s_axis_rx_tuser   => m_axis_rx_tuser,
      s_axi_csr_aclk    => s_axi_csr_rx_aclk,
      s_axi_csr_aresetn => s_axi_csr_rx_aresetn,
      s_axi_csr_awaddr  => s_axi_csr_rx_awaddr,
      s_axi_csr_awprot  => s_axi_csr_rx_awprot,
      s_axi_csr_awvalid => s_axi_csr_rx_awvalid,
      s_axi_csr_awready => s_axi_csr_rx_awready,
      s_axi_csr_wdata   => s_axi_csr_rx_wdata,
      s_axi_csr_wstrb   => s_axi_csr_rx_wstrb,
      s_axi_csr_wvalid  => s_axi_csr_rx_wvalid,
      s_axi_csr_wready  => s_axi_csr_rx_wready,
      s_axi_csr_bresp   => s_axi_csr_rx_bresp,
      s_axi_csr_bvalid  => s_axi_csr_rx_bvalid,
      s_axi_csr_bready  => s_axi_csr_rx_bready,
      s_axi_csr_araddr  => s_axi_csr_rx_araddr,
      s_axi_csr_arprot  => s_axi_csr_rx_arprot,
      s_axi_csr_arvalid => s_axi_csr_rx_arvalid,
      s_axi_csr_arready => s_axi_csr_rx_arready,
      s_axi_csr_rdata   => s_axi_csr_rx_rdata,
      s_axi_csr_rresp   => s_axi_csr_rx_rresp,
      s_axi_csr_rvalid  => s_axi_csr_rx_rvalid,
      s_axi_csr_rready  => s_axi_csr_rx_rready,
      irq               => irq_rx,
      m_axis_eth_tvalid => m_axis_eth_tvalid,
      m_axis_eth_tready => m_axis_eth_tready,
      m_axis_eth_tdata  => m_axis_eth_tdata,
      m_axis_eth_tkeep  => m_axis_eth_tkeep,
      m_axis_eth_tlast  => m_axis_eth_tlast,
      m_axis_eth_tuser  => m_axis_eth_tuser
      );

end Behavioral;
