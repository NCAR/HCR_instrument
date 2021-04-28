----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 04/10/2017
-- Design Name: px_10ge_udp_rx
-- Module Name: px_10ge_udp_rx
-- Project Name: px_10ge_udp_rx
-- Target Devices: Virtex 7
-- Tool Versions: Vivado 2016.4
-- Description: Recieves Packets from Xilinx Eth Core
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.00 - Release
-- Revision 0.01 - Removed xilinx core controls from this pentek core
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
library xpm;
use xpm.vcomponents.all;

entity px_10ge_udp_rx is
  port (
    axis_aclk       : in std_logic;  --connect to rxrecclk_out from PCS/PMA IP Core
    axis_aresetn    : in std_logic;  --connect to resetdone_out from PCS/PMA IP Core
    xilinx_core_rdy : in std_logic;

    s_axis_rx_tvalid : in std_logic;
    s_axis_rx_tdata  : in std_logic_vector(63 downto 0);
    s_axis_rx_tkeep  : in std_logic_vector(7 downto 0);
    s_axis_rx_tlast  : in std_logic;
    s_axis_rx_tuser  : in std_logic;

    s_axi_csr_aclk    : in  std_logic;
    s_axi_csr_aresetn : in  std_logic;
    s_axi_csr_awaddr  : in  std_logic_vector(6 downto 0);
    s_axi_csr_awprot  : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid : in  std_logic;
    s_axi_csr_awready : out std_logic;
    s_axi_csr_wdata   : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb   : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid  : in  std_logic;
    s_axi_csr_wready  : out std_logic;
    s_axi_csr_bresp   : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid  : out std_logic;
    s_axi_csr_bready  : in  std_logic;
    s_axi_csr_araddr  : in  std_logic_vector(6 downto 0);
    s_axi_csr_arprot  : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid : in  std_logic;
    s_axi_csr_arready : out std_logic;
    s_axi_csr_rdata   : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp   : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid  : out std_logic;
    s_axi_csr_rready  : in  std_logic;
    irq               : out std_logic;

    m_axis_eth_tvalid : out std_logic;
    m_axis_eth_tready : in  std_logic;
    m_axis_eth_tdata  : out std_logic_vector(63 downto 0);
    m_axis_eth_tkeep  : out std_logic_vector(7 downto 0);
    m_axis_eth_tlast  : out std_logic;
    m_axis_eth_tuser  : out std_logic_vector(0 downto 0)
    );
end px_10ge_udp_rx;


architecture behavioral of px_10ge_udp_rx is

  component px_10ge_udp_rx_csr
    port (
      s_axi_csr_aclk    : in  std_logic;
      s_axi_csr_aresetn : in  std_logic;
      s_axi_csr_awaddr  : in  std_logic_vector(6 downto 0);
      s_axi_csr_awprot  : in  std_logic_vector(2 downto 0);
      s_axi_csr_awvalid : in  std_logic;
      s_axi_csr_awready : out std_logic;
      s_axi_csr_wdata   : in  std_logic_vector(31 downto 0);
      s_axi_csr_wstrb   : in  std_logic_vector(3 downto 0);
      s_axi_csr_wvalid  : in  std_logic;
      s_axi_csr_wready  : out std_logic;
      s_axi_csr_bresp   : out std_logic_vector(1 downto 0);
      s_axi_csr_bvalid  : out std_logic;
      s_axi_csr_bready  : in  std_logic;
      s_axi_csr_araddr  : in  std_logic_vector(6 downto 0);
      s_axi_csr_arprot  : in  std_logic_vector(2 downto 0);
      s_axi_csr_arvalid : in  std_logic;
      s_axi_csr_arready : out std_logic;
      s_axi_csr_rdata   : out std_logic_vector(31 downto 0);
      s_axi_csr_rresp   : out std_logic_vector(1 downto 0);
      s_axi_csr_rvalid  : out std_logic;
      s_axi_csr_rready  : in  std_logic;
      reg0_init_val     : in  std_logic_vector(31 downto 0);
      ctl0_out          : out std_logic_vector(31 downto 0);
      stat0_in          : in  std_logic_vector(31 downto 0);
      stat1_in          : in  std_logic_vector(31 downto 0);
      stat2_in          : in  std_logic_vector(31 downto 0);
      stat3_in          : in  std_logic_vector(31 downto 0);
      stat4_in          : in  std_logic_vector(31 downto 0);
      stat5_in          : in  std_logic_vector(31 downto 0);
      intrpt_src_in     : in  std_logic_vector(3 downto 0);
      irq               : out std_logic
      );
  end component;
  component px_10ge_udp_rx_datafifo
    port (
      s_aclk          : in  std_logic;
      s_aresetn       : in  std_logic;
      s_axis_tvalid   : in  std_logic;
      s_axis_tready   : out std_logic;
      s_axis_tdata    : in  std_logic_vector(63 downto 0);
      s_axis_tkeep    : in  std_logic_vector(7 downto 0);
      s_axis_tlast    : in  std_logic;
      s_axis_tuser    : in  std_logic_vector(0 downto 0);
      m_axis_tvalid   : out std_logic;
      m_axis_tready   : in  std_logic;
      m_axis_tdata    : out std_logic_vector(63 downto 0);
      m_axis_tkeep    : out std_logic_vector(7 downto 0);
      m_axis_tlast    : out std_logic;
      m_axis_tuser    : out std_logic_vector(0 downto 0);
      axis_data_count : out std_logic_vector(14 downto 0)
      );
  end component;
  component px_10ge_udp_rx_px_bus_sync
    port (
      src_clk  : in  std_logic;
      src_in   : in  std_logic_vector(31 downto 0);
      dest_clk : in  std_logic;
      dest_out : out std_logic_vector(31 downto 0)
      );
  end component;
  component px_10ge_udp_rx_px_bus_sync_intr
    port (
      src_clk  : in  std_logic;
      src_in   : in  std_logic_vector(3 downto 0);
      dest_clk : in  std_logic;
      dest_out : out std_logic_vector(3 downto 0)
      );
  end component;


  signal reg0_init_val        : std_logic_vector(31 downto 0);
  signal ctl0_out             : std_logic_vector(31 downto 0);
  signal stat0_in             : std_logic_vector(31 downto 0);
  signal stat1_in             : std_logic_vector(31 downto 0);
  signal stat2_in             : std_logic_vector(31 downto 0);
  signal stat3_in             : std_logic_vector(31 downto 0);
  signal stat4_in             : std_logic_vector(31 downto 0);
  signal stat5_in             : std_logic_vector(31 downto 0);
  signal intrpt_src_in        : std_logic_vector(3 downto 0);
  signal ctl0_out_s           : std_logic_vector(31 downto 0);
  signal stat0_in_s           : std_logic_vector(31 downto 0);
  signal stat1_in_s           : std_logic_vector(31 downto 0);
  signal stat2_in_s           : std_logic_vector(31 downto 0);
  signal stat3_in_s           : std_logic_vector(31 downto 0);
  signal stat4_in_s           : std_logic_vector(31 downto 0);
  signal stat5_in_s           : std_logic_vector(31 downto 0);
  signal intrpt_src_in_s      : std_logic_vector(3 downto 0);
  signal s_axis_tvalid        : std_logic;
  signal s_axis_tready        : std_logic;
  signal s_axis_tdata         : std_logic_vector(63 downto 0);
  signal s_axis_tkeep         : std_logic_vector(7 downto 0);
  signal s_axis_tlast         : std_logic;
  signal s_axis_tuser         : std_logic_vector(0 downto 0);
  signal mac_source           : std_logic_vector(47 downto 0);
  signal ip_source            : std_logic_vector(31 downto 0);
  signal port_source          : std_logic_vector(15 downto 0);
  signal parse_error          : std_logic;
  signal axis_data_count      : std_logic_vector(14 downto 0);
  signal irq_local            : std_logic;
  signal usr_rstn             : std_logic;
  signal xilinx_core_rdy_prev : std_logic;
  signal rstn                 : std_logic;
  attribute X_INTERFACE_INFO                        : string;
  attribute X_INTERFACE_INFO of irq_local           : signal is "xilinx.com:signal:interrupt:1.0 irq_local INTR";
  attribute X_INTERFACE_PARAMETER                   : string;
  attribute X_INTERFACE_PARAMETER of irq_local      : signal is "SENSITIVITY EDGE_RISING";
  attribute X_INTERFACE_PARAMETER of axis_aclk      : signal is "ASSOCIATED_BUSIF s_axis_rx:m_axis_eth, ASSOCIATED_RESET axis_aresetn";
  attribute X_INTERFACE_PARAMETER of s_axi_csr_aclk : signal is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

begin


-----------------------------------------------------------------------------------------------------------------
--Connections for CSR Regs
-----------------------------------------------------------------------------------------------------------------
  usr_rstn <= rstn and ctl0_out_s(0);

  reg0_init_val          <= x"00000000";
  stat0_in               <= mac_source(47 downto 16);
  stat1_in(15 downto 0)  <= mac_source(15 downto 0);
  stat1_in(31 downto 16) <= (others => '0');
  stat2_in               <= ip_source;
  stat3_in(15 downto 0)  <= port_source;
  stat3_in(31 downto 16) <= (others => '0');
  stat4_in(14 downto 0)  <= axis_data_count;
  stat4_in(31 downto 15) <= (others => '0');
  stat5_in               <= (others => '0');

  intrpt_src_in(0) <= (not xilinx_core_rdy) and xilinx_core_rdy_prev;
  intrpt_src_in(1) <= '1' when axis_data_count = "000000000000000" else '0';
  intrpt_src_in(2) <= '1' when axis_data_count = "111111111111111" else '0';
  intrpt_src_in(3) <= parse_error;
  irq              <= irq_local;



  latch : process(s_axi_csr_aclk)  --latch eth bus to compensate for counter lag. 
  begin
    if rising_edge(s_axi_csr_aclk) then
      xilinx_core_rdy_prev <= xilinx_core_rdy;
    end if;
  end process latch;

-----------------------------------------------------------------------------------------------------------------
--Modules
-----------------------------------------------------------------------------------------------------------------

  px_10ge_udp_rx_csr_inst : px_10ge_udp_rx_csr
    port map (
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
      reg0_init_val     => reg0_init_val,
      ctl0_out          => ctl0_out,
      stat0_in          => stat0_in_s,
      stat1_in          => stat1_in_s,
      stat2_in          => stat2_in_s,
      stat3_in          => stat3_in_s,
      stat4_in          => stat4_in_s,
      stat5_in          => stat5_in_s,
      intrpt_src_in     => intrpt_src_in_s,
      irq               => irq_local
      );

  px_10ge_udp_rx_pkt_parse_inst : entity work.px_10ge_udp_rx_pkt_parse
    port map(
      axis_aclk          => axis_aclk,
      axis_aresetn       => usr_rstn,
      s_axis_rx_tvalid   => s_axis_rx_tvalid,
      s_axis_rx_tdata    => s_axis_rx_tdata,
      s_axis_rx_tkeep    => s_axis_rx_tkeep,
      s_axis_rx_tlast    => s_axis_rx_tlast,
      s_axis_rx_tuser(0) => s_axis_rx_tuser,
      m_axis_tvalid      => s_axis_tvalid,
      m_axis_tready      => s_axis_tready,
      m_axis_tdata       => s_axis_tdata,
      m_axis_tkeep       => s_axis_tkeep,
      m_axis_tlast       => s_axis_tlast,
      m_axis_tuser       => s_axis_tuser,
      mac_source         => mac_source,
      ip_source          => ip_source,
      port_source        => port_source,
      parse_error        => parse_error
      );

  px_10ge_udp_rx_datafifo_inst : px_10ge_udp_rx_datafifo
    port map (
      s_aclk          => axis_aclk,
      s_aresetn       => usr_rstn,
      s_axis_tvalid   => s_axis_tvalid,
      s_axis_tready   => s_axis_tready,
      s_axis_tdata    => s_axis_tdata,
      s_axis_tkeep    => s_axis_tkeep,
      s_axis_tlast    => s_axis_tlast,
      s_axis_tuser    => s_axis_tuser,
      m_axis_tvalid   => m_axis_eth_tvalid,
      m_axis_tready   => m_axis_eth_tready,
      m_axis_tdata    => m_axis_eth_tdata,
      m_axis_tkeep    => m_axis_eth_tkeep,
      m_axis_tlast    => m_axis_eth_tlast,
      m_axis_tuser    => m_axis_eth_tuser,
      axis_data_count => axis_data_count
      );

-----------------------------------------------------------------------------------------------------------------
--Synchronization for CSR Regs
-----------------------------------------------------------------------------------------------------------------
  xpm_cdc_async_rst_inst : xpm_cdc_async_rst
    generic map (
      DEST_SYNC_FF    => 2,             -- integer; range: 2-10
      RST_ACTIVE_HIGH => 0  -- integer; 0=active low reset, 1=active high reset
      )
    port map (
      src_arst  => axis_aresetn,
      dest_clk  => axis_aclk,
      dest_arst => rstn
      ); 
  px_10ge_udp_rx_px_bus_sync_ctl0_inst : px_10ge_udp_rx_px_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl0_out,
      dest_clk => axis_aclk,
      dest_out => ctl0_out_s
      );
  px_10ge_udp_rx_px_bus_sync_stat0 : px_10ge_udp_rx_px_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat0_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat0_in_s
      );
  px_10ge_udp_rx_px_bus_sync_stat1 : px_10ge_udp_rx_px_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat1_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat1_in_s
      );
  px_10ge_udp_rx_px_bus_sync_stat2 : px_10ge_udp_rx_px_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat2_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat2_in_s
      );
  px_10ge_udp_rx_px_bus_sync_stat3 : px_10ge_udp_rx_px_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat3_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat3_in_s
      );
  px_10ge_udp_rx_px_bus_sync_stat4 : px_10ge_udp_rx_px_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat4_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat4_in_s
      );
  px_10ge_udp_rx_px_bus_sync_stat5 : px_10ge_udp_rx_px_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat5_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat5_in_s
      );
  px_10ge_udp_rx_px_bus_sync_intr_inst : px_10ge_udp_rx_px_bus_sync_intr
    port map (
      src_clk  => axis_aclk,
      src_in   => intrpt_src_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => intrpt_src_in_s
      );

end Behavioral;
