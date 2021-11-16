----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 01/04/2017
-- Design Name: px_10ge_udp_tx
-- Module Name: px_10ge_udp_tx
-- Project Name: px_10ge_udp_tx
-- Target Devices: Virtex 7
-- Tool Versions: Vivado 2017.1
-- Description: Creates Packets for Xilinx Eth Core
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.10 - New Version with tkeep generic, data swap removed, Removed xilinx core controlls, resets fixed
-- Additional Comments:
-- Revision 1.10 - Added generics to allow MAC, IP and UDP to be pre-assigned.
-- Added an additional CSR register for MAC Src
-- 

-- (Memory Map)
-- 0x00 - Mac Destination Addr 47 downto 16
-- 0x04 - Mac Destination Addr 15 downto 0
-- 0x08 - IP Source Addr
-- 0x0C - IP Destination Addr
-- 0x10 - UDP Source Addr
-- 0x14 - UDP Destination Addr
-- 0x18 - Control Register
-- 0x1C - ETH Status Regs
-- 0x20 - Intake FIFO Regs
-- 0x24 - Packet FIFO Regs
-- 0x28 - Interrupt Enables
-- 0x2C - Interrupt Status
-- 0x30 - Interrupt Flags

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

entity px_10ge_udp_tx is
  generic (
    has_tkeep : boolean := true;         -- 16 or 24
    
    mac_source_init      : std_logic_vector(47 downto 0) := (others => '0');
    mac_dest_init        : std_logic_vector(47 downto 0) := (others => '0');
    ip_source_init       : std_logic_vector(31 downto 0) := (others => '0');
    ip_dest_init         : std_logic_vector(31 downto 0) := (others => '0');
    udp_port_source_init : std_logic_vector(15 downto 0) := (others => '0');
    udp_port_dest_init   : std_logic_vector(15 downto 0) := (others => '0')
        
    
    );

  port (
    axis_aclk       : in std_logic;  --connect to coreclk_out from PCS/PMA IP Core
    axis_aresetn    : in std_logic;  --connect to resetdone_out from PCS/PMA IP Core
    xilinx_core_rdy : in std_logic;

    s_axis_eth_tvalid : in  std_logic;
    s_axis_eth_tready : out std_logic;
    s_axis_eth_tdata  : in  std_logic_vector(63 downto 0);
    s_axis_eth_tkeep  : in  std_logic_vector(7 downto 0);
    s_axis_eth_tlast  : in  std_logic;

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

    m_axis_tx_tvalid : out std_logic;
    m_axis_tx_tready : in  std_logic;
    m_axis_tx_tdata  : out std_logic_vector(63 downto 0);
    m_axis_tx_tkeep  : out std_logic_vector(7 downto 0);
    m_axis_tx_tlast  : out std_logic;
    m_axis_tx_tuser  : out std_logic_vector(0 downto 0)
    );
end px_10ge_udp_tx;


architecture behavioral of px_10ge_udp_tx is

  component px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port (
      src_clk  : in  std_logic;
      src_in   : in  std_logic_vector(31 downto 0);
      dest_clk : in  std_logic;
      dest_out : out std_logic_vector(31 downto 0)
      );
  end component;
  component px_10ge_udp_tx_px_xpm_cdc_bus_sync_intr
    port (
      src_clk  : in  std_logic;
      src_in   : in  std_logic_vector(3 downto 0);
      dest_clk : in  std_logic;
      dest_out : out std_logic_vector(3 downto 0)
      );
  end component;
  component px_10ge_udp_tx_px_axil_csr
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
      reg1_init_val     : in  std_logic_vector(31 downto 0);
      reg2_init_val     : in  std_logic_vector(31 downto 0);
      reg3_init_val     : in  std_logic_vector(31 downto 0);
      reg4_init_val     : in  std_logic_vector(31 downto 0);
      reg5_init_val     : in  std_logic_vector(31 downto 0);
      reg6_init_val     : in  std_logic_vector(31 downto 0);
      reg7_init_val     : in  std_logic_vector(31 downto 0);
      ctl0_out          : out std_logic_vector(31 downto 0);
      ctl1_out          : out std_logic_vector(31 downto 0);
      ctl2_out          : out std_logic_vector(31 downto 0);
      ctl3_out          : out std_logic_vector(31 downto 0);
      ctl4_out          : out std_logic_vector(31 downto 0);
      ctl5_out          : out std_logic_vector(31 downto 0);
      ctl6_out          : out std_logic_vector(31 downto 0);
      ctl7_out          : out std_logic_vector(31 downto 0);
      stat0_in          : in  std_logic_vector(31 downto 0);
      stat1_in          : in  std_logic_vector(31 downto 0);
      stat2_in          : in  std_logic_vector(31 downto 0);
      intrpt_src_in     : in  std_logic_vector(4 downto 0);
      irq               : out std_logic
      );
  end component;

  signal clk                           : std_logic := '0';
  signal rstn                          : std_logic := '0';
  signal usr_rstn                      : std_logic := '0';
  signal fifo_rstn                     : std_logic := '0';
  signal sm_enable                     : std_logic := '0';
  signal packet_max_size               : std_logic_vector(15 downto 0);
  signal custom_size_enable            : std_logic;
  signal mac_header                    : std_logic_vector(111 downto 0);
  signal ip_header                     : std_logic_vector(159 downto 0);
  signal udp_header                    : std_logic_vector(63 downto 0);
  signal s_axis_eth_tlast_fix          : std_logic;
  signal count_rd                      : std_logic;
  signal count                         : std_logic_vector(15 downto 0);
  signal intake_axis_data_count        : std_logic_vector(14 downto 0);
  signal outgoing_axis_data_count      : std_logic_vector(14 downto 0);
  signal xilinx_core_rdy_prev          : std_logic;
  signal intake_axis_data_fifo_full    : std_logic;
  signal intake_axis_data_fifo_empty   : std_logic;
  signal outgoing_axis_data_fifo_full  : std_logic;
  signal outgoing_axis_data_fifo_empty : std_logic;
  signal s_axis_eth_tready_local       : std_logic;
  signal s_axis_eth_tkeep_local        : std_logic_vector(7 downto 0);
  signal src_rst                       : std_logic;
  signal dest_rst                      : std_logic;
  signal counter_error                 : std_logic;
  signal sm_error                      : std_logic_vector(0 downto 0);

  signal mac_src_address : std_logic_vector(47 downto 0);
  signal mac_dst_address : std_logic_vector(47 downto 0);
  signal ip_src_address  : std_logic_vector(31 downto 0);
  signal ip_dst_address  : std_logic_vector(31 downto 0);
  signal udp_src_port    : std_logic_vector(15 downto 0);
  signal udp_dst_port    : std_logic_vector(15 downto 0);
  
  signal s_axi_csr_aresetn_l : std_logic;
  signal reg0_init_val       : std_logic_vector(31 downto 0) := mac_source_init(47 downto 16);
  signal reg1_init_val       : std_logic_vector(31 downto 0) := X"0000" & mac_source_init(15 downto 0);
  signal reg2_init_val       : std_logic_vector(31 downto 0) := mac_dest_init(47 downto 16);
  signal reg3_init_val       : std_logic_vector(31 downto 0) := X"0000" & mac_dest_init(15 downto 0);
  signal reg4_init_val       : std_logic_vector(31 downto 0) := ip_source_init;
  signal reg5_init_val       : std_logic_vector(31 downto 0) := ip_dest_init;
  signal reg6_init_val       : std_logic_vector(31 downto 0) := udp_port_dest_init & udp_port_source_init;
  signal reg7_init_val       : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl0_out            : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl1_out            : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl2_out            : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl3_out            : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl4_out            : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl5_out            : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl6_out            : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl7_out            : std_logic_vector(31 downto 0) := (others => '0');
  signal stat0_in            : std_logic_vector(31 downto 0) := (others => '0');
  signal stat1_in            : std_logic_vector(31 downto 0) := (others => '0');
  signal stat2_in            : std_logic_vector(31 downto 0) := (others => '0');
  signal intrpt_src_in       : std_logic_vector(4 downto 0);
  signal ctl0_out_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl1_out_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl2_out_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl3_out_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl4_out_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl5_out_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl6_out_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl7_out_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal stat0_in_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal stat1_in_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal stat2_in_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal intrpt_src_in_s     : std_logic_vector(4 downto 0);
  signal irq_local           : std_logic;

  attribute X_INTERFACE_INFO                        : string;
  attribute X_INTERFACE_INFO of irq_local           : signal is "xilinx.com:signal:interrupt:1.0 irq_local INTR";
  attribute X_INTERFACE_PARAMETER                   : string;
  attribute X_INTERFACE_PARAMETER of irq_local      : signal is "SENSITIVITY EDGE_RISING";
  attribute X_INTERFACE_PARAMETER of axis_aclk      : signal is "ASSOCIATED_BUSIF s_axis_eth:m_axis_tx, ASSOCIATED_RESET axis_aresetn";
  attribute X_INTERFACE_PARAMETER of s_axi_csr_aclk : signal is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

begin

  clk                    <= axis_aclk;
  irq                    <= irq_local;
  s_axis_eth_tkeep_local <= s_axis_eth_tkeep when has_tkeep = true else x"ff";
-----------------------------------------------------------------------------------------------------------------
--Connections for CSR Block
-----------------------------------------------------------------------------------------------------------------
  latch_csr : process(s_axi_csr_aclk)  --latch eth bus to compensate for counter lag. 
  begin
    if rising_edge(s_axi_csr_aclk) then
      s_axi_csr_aresetn_l <= s_axi_csr_aresetn;
    end if;
  end process latch_csr;

  latch : process(s_axi_csr_aclk)  --latch eth bus to compensate for counter lag. 
  begin
    if rising_edge(s_axi_csr_aclk) then
      xilinx_core_rdy_prev <= xilinx_core_rdy;
    end if;
  end process latch;

  intake_axis_data_fifo_empty   <= '1' when intake_axis_data_count = "000000000000000"   else '0';
  intake_axis_data_fifo_full    <= '1' when intake_axis_data_count = "111111111111111" else '0';
  outgoing_axis_data_fifo_empty <= '1' when outgoing_axis_data_count = "000000000000000" else '0';
  outgoing_axis_data_fifo_full  <= '1' when outgoing_axis_data_count = "111111111111111" else '0';

  --Control Reg Connections

  reg0_init_val      <= mac_source_init(47 downto 16);
  reg1_init_val      <= X"0000" & mac_source_init(15 downto 0);
  reg2_init_val      <= mac_dest_init(47 downto 16);
  reg3_init_val      <= X"0000" & mac_dest_init(15 downto 0);
  reg4_init_val      <= ip_source_init;
  reg5_init_val      <= ip_dest_init;
  reg6_init_val      <= udp_port_dest_init & udp_port_source_init;
  reg7_init_val      <= x"00000007"; --Start with User resetn fifo_rstn and sm enable set to 1.
  
  mac_src_address    <= ctl0_out_s & ctl1_out_s(15 downto 0);
  mac_dst_address    <= ctl2_out_s & ctl3_out_s(15 downto 0);
  ip_src_address     <= ctl4_out_s;
  ip_dst_address     <= ctl5_out_s;
  udp_src_port       <= ctl6_out_s(15 downto 0);
  udp_dst_port       <= ctl6_out_s(31 downto 16);
  usr_rstn           <= rstn and ctl7_out_s(0);  
  fifo_rstn          <= rstn and ctl7_out_s(1);
  sm_enable          <= ctl7_out_s(2);  --not ctl7_out_s(2);
  packet_max_size    <= x"0400" when ctl7_out_s(3) = '0' else x"2000";  --1024 or 8192
  custom_size_enable <= ctl7_out_s(4);

  --Setup Reg Connections
  stat0_in(0)           <= xilinx_core_rdy;
  stat0_in(1)           <= counter_error;
  stat0_in(2)           <= sm_error(0);
  stat1_in(0)           <= intake_axis_data_fifo_empty;
  stat1_in(1)           <= intake_axis_data_fifo_full;
  stat1_in(16 downto 2) <= intake_axis_data_count;
  stat2_in(0)           <= outgoing_axis_data_fifo_empty;
  stat2_in(1)           <= outgoing_axis_data_fifo_full;
  stat2_in(16 downto 2) <= outgoing_axis_data_count;

  --Interupts
  intrpt_src_in(0) <= (not xilinx_core_rdy) and xilinx_core_rdy_prev;
  intrpt_src_in(1) <= intake_axis_data_fifo_empty;
  intrpt_src_in(2) <= intake_axis_data_fifo_full;
  intrpt_src_in(3) <= outgoing_axis_data_fifo_empty;
  intrpt_src_in(4) <= outgoing_axis_data_fifo_full;

-----------------------------------------------------------------------------------------------------------------
--Synchronization 
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
  px_10ge_udp_tx_px_xpm_cdc_bus_sync_ctl0_out : px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl0_out,
      dest_clk => axis_aclk,
      dest_out => ctl0_out_s
      );
  px_10ge_udp_tx_px_xpm_cdc_bus_sync_ctl1_out : px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl1_out,
      dest_clk => axis_aclk,
      dest_out => ctl1_out_s
      );
  px_10ge_udp_tx_px_xpm_cdc_bus_sync_ctl2_out : px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl2_out,
      dest_clk => axis_aclk,
      dest_out => ctl2_out_s
      );
  px_10ge_udp_tx_px_xpm_cdc_bus_sync_ctl3_out : px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl3_out,
      dest_clk => axis_aclk,
      dest_out => ctl3_out_s
      );
  px_10ge_udp_tx_px_xpm_cdc_bus_sync_ctl4_out : px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl4_out,
      dest_clk => axis_aclk,
      dest_out => ctl4_out_s
      );
  px_10ge_udp_tx_px_xpm_cdc_bus_sync_ctl5_out : px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl5_out,
      dest_clk => axis_aclk,
      dest_out => ctl5_out_s
      );
  px_10ge_udp_tx_px_xpm_cdc_bus_sync_ctl6_out : px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl6_out,
      dest_clk => axis_aclk,
      dest_out => ctl6_out_s
      );
  px_10ge_udp_tx_px_xpm_cdc_bus_sync_ctl7_out : px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl7_out,
      dest_clk => axis_aclk,
      dest_out => ctl7_out_s
      );
  px_10ge_udp_tx_px_xpm_cdc_bus_sync_stat0_out : px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat0_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat0_in_s
      );
  px_10ge_udp_tx_px_xpm_cdc_bus_sync_stat1_out : px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat1_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat1_in_s
      );
  px_10ge_udp_tx_px_xpm_cdc_bus_sync_stat2_out : px_10ge_udp_tx_px_xpm_cdc_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat2_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat2_in_s
      );

  px_10ge_udp_tx_px_xpm_cdc_bus_sync_intr_inst : px_10ge_udp_tx_px_xpm_cdc_bus_sync_intr
    port map (
      src_clk  => axis_aclk,
      src_in   => intrpt_src_in(4 downto 1),
      dest_clk => s_axi_csr_aclk,
      dest_out => intrpt_src_in_s(4 downto 1)
      );

  xpm_cdc_pulse_inst : xpm_cdc_pulse
    generic map (
      DEST_SYNC_FF   => 2,              -- integer; range: 2-10
      REG_OUTPUT     => 1,  -- integer; 0=disable registered output,   1=enable registered output
      RST_USED       => 1,  -- integer; 0=no reset, 1=implement reset
      SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
      )
    port map (
      src_clk    => axis_aclk,
      src_rst    => src_rst,            -- optional; required when RST_USED = 1
      src_pulse  => intrpt_src_in(0),
      dest_clk   => s_axi_csr_aclk,
      dest_rst   => dest_rst,           -- optional; required when RST_USED = 1
      dest_pulse => intrpt_src_in_s(0)
      );
  src_rst  <= not axis_aresetn;
  dest_rst <= not s_axi_csr_aresetn;
-----------------------------------------------------------------------------------------------------------------
--Modules
-----------------------------------------------------------------------------------------------------------------

  px_10ge_udp_tx_px_axil_csr_inst : px_10ge_udp_tx_px_axil_csr
    port map (
      s_axi_csr_aclk    => s_axi_csr_aclk,
      s_axi_csr_aresetn => s_axi_csr_aresetn_l,
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
      reg1_init_val     => reg1_init_val,
      reg2_init_val     => reg2_init_val,
      reg3_init_val     => reg3_init_val,
      reg4_init_val     => reg4_init_val,
      reg5_init_val     => reg5_init_val,
      reg6_init_val     => reg6_init_val,
      reg7_init_val     => reg7_init_val,
      ctl0_out          => ctl0_out,
      ctl1_out          => ctl1_out,
      ctl2_out          => ctl2_out,
      ctl3_out          => ctl3_out,
      ctl4_out          => ctl4_out,
      ctl5_out          => ctl5_out,
      ctl6_out          => ctl6_out,
      ctl7_out          => ctl7_out,
      stat0_in          => stat0_in_s,
      stat1_in          => stat1_in_s,
      stat2_in          => stat2_in_s,
      intrpt_src_in     => intrpt_src_in_s,
      irq               => irq_local
      );

  px_10ge_udp_tx_mac_inst : entity work.px_10ge_udp_tx_mac
    port map(
      clk                 => clk,
      source_address      => mac_src_address,
      destination_address => mac_dst_address,
      mac_header          => mac_header
      );

  px_10ge_udp_tx_ip_inst : entity work.px_10ge_udp_tx_ip
    port map(
      clk                 => clk,
      count               => count,
      source_address      => ip_src_address,
      destination_address => ip_dst_address,
      ip_header           => ip_header
      );

  px_10ge_udp_tx_udp_inst : entity work.px_10ge_udp_tx_udp
    port map(
      clk              => clk,
      count            => count,
      source_port      => udp_src_port,
      destination_port => udp_dst_port,
      udp_header       => udp_header
      );

  px_10ge_udp_tx_counter_inst : entity work.px_10ge_udp_tx_counter
    port map(
      clk                  => clk,
      rstn                 => usr_rstn,
      packet_max_size      => packet_max_size,
      custom_size_enable   => custom_size_enable,
      s_axis_eth_tvalid    => s_axis_eth_tvalid,
      s_axis_eth_tready    => s_axis_eth_tready_local,
      s_axis_eth_tkeep     => s_axis_eth_tkeep_local,
      s_axis_eth_tlast     => s_axis_eth_tlast,
      s_axis_eth_tlast_fix => s_axis_eth_tlast_fix,
      counter_error        => counter_error,
      count_rd             => count_rd,
      count                => count
      );

  px_10ge_udp_tx_packer_inst : entity work.px_10ge_udp_tx_packer
    port map(
      clk                      => clk,
      rstn                     => usr_rstn,
      fifo_rstn                => fifo_rstn,
      sm_enable                => sm_enable,
      xilinx_core_rdy          => xilinx_core_rdy,
      mac_header               => mac_header,
      ip_header                => ip_header,
      udp_header               => udp_header,
      count_rd                 => count_rd,
      count                    => count,
      s_axis_eth_tvalid        => s_axis_eth_tvalid,
      s_axis_eth_tready        => s_axis_eth_tready_local,
      s_axis_eth_tdata         => s_axis_eth_tdata,
      s_axis_eth_tkeep         => s_axis_eth_tkeep_local,
      s_axis_eth_tlast         => s_axis_eth_tlast_fix,
      intake_axis_data_count   => intake_axis_data_count,
      outgoing_axis_data_count => outgoing_axis_data_count,
      m_axis_tx_tvalid         => m_axis_tx_tvalid,
      m_axis_tx_tready         => m_axis_tx_tready,
      m_axis_tx_tdata          => m_axis_tx_tdata,
      m_axis_tx_tkeep          => m_axis_tx_tkeep,
      m_axis_tx_tlast          => m_axis_tx_tlast,
      m_axis_tx_tuser          => sm_error
      );
  m_axis_tx_tuser   <= sm_error;
  s_axis_eth_tready <= s_axis_eth_tready_local;

end Behavioral;
