----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 6/27/2017
-- Design Name: px_vita49_pkt_px_axil_csr_wrapper
-- Module Name: px_vita49_pkt_px_axil_csr_wrapper
-- Project Name: px_vita49_pkt
-- Target Devices: Kintex Ultrascale
-- Tool Versions: Vivado 2017.2
-- Description: Wrapper for CSR
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
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

entity px_vita49_pkt_px_axil_csr_wrapper is
  port (
    axis_aclk         : in  std_logic;
    axis_aresetn      : in  std_logic;
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
    ctl0_out          : out std_logic_vector(31 downto 0);
    ctl1_out          : out std_logic_vector(31 downto 0);
    ctl2_out          : out std_logic_vector(31 downto 0);
    ctl3_out          : out std_logic_vector(31 downto 0);
    ctl4_out          : out std_logic_vector(31 downto 0);
    ctl5_out          : out std_logic_vector(31 downto 0);
    stat0_in          : in  std_logic_vector(31 downto 0);
    stat1_in          : in  std_logic_vector(31 downto 0);
    stat2_in          : in  std_logic_vector(31 downto 0);
    intrpt_src_in     : in  std_logic_vector(5 downto 0);
    irq               : out std_logic
    );
end px_vita49_pkt_px_axil_csr_wrapper;

architecture Behavioral of px_vita49_pkt_px_axil_csr_wrapper is
  component px_vita49_xpm_cdc_bus_sync
    port (
      src_clk  : in  std_logic;
      src_in   : in  std_logic_vector(31 downto 0);
      dest_clk : in  std_logic;
      dest_out : out std_logic_vector(31 downto 0)
      );
  end component;
  component px_vita49_xpm_cdc_bus_sync_intr
    port (
      src_clk  : in  std_logic;
      src_in   : in  std_logic_vector(5 downto 0);
      dest_clk : in  std_logic;
      dest_out : out std_logic_vector(5 downto 0)
      );
  end component;
  component px_vita49_pkt_px_axil_csr
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
      ctl0_out          : out std_logic_vector(31 downto 0);
      ctl1_out          : out std_logic_vector(31 downto 0);
      ctl2_out          : out std_logic_vector(31 downto 0);
      ctl3_out          : out std_logic_vector(31 downto 0);
      ctl4_out          : out std_logic_vector(31 downto 0);
      ctl5_out          : out std_logic_vector(31 downto 0);
      stat0_in          : in  std_logic_vector(31 downto 0);
      stat1_in          : in  std_logic_vector(31 downto 0);
      stat2_in          : in  std_logic_vector(31 downto 0);
      intrpt_src_in     : in  std_logic_vector(5 downto 0);
      irq               : out std_logic
      );
  end component;

  signal ctl0_out_local      : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl1_out_local      : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl2_out_local      : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl3_out_local      : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl4_out_local      : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl5_out_local      : std_logic_vector(31 downto 0) := (others => '0');
  signal stat0_in_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal stat1_in_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal stat2_in_s          : std_logic_vector(31 downto 0) := (others => '0');
  signal intrpt_src_in_s     : std_logic_vector(5 downto 0)  := (others => '0');
  signal s_axi_csr_aresetn_r : std_logic                     := '0';
begin

  reset_register : process(s_axi_csr_aclk)
  begin
    if rising_edge(s_axi_csr_aclk) then
      s_axi_csr_aresetn_r <= s_axi_csr_aresetn;
    end if;
  end process;

  px_vita49_xpm_cdc_bus_sync_stat0_out : px_vita49_xpm_cdc_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat0_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat0_in_s
      );
  px_vita49_xpm_cdc_bus_sync_stat1_out : px_vita49_xpm_cdc_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat1_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat1_in_s
      );
  px_vita49_xpm_cdc_bus_sync_stat2_out : px_vita49_xpm_cdc_bus_sync
    port map (
      src_clk  => axis_aclk,
      src_in   => stat2_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => stat2_in_s
      );

  px_vita49_xpm_cdc_bus_sync_intr_inst : px_vita49_xpm_cdc_bus_sync_intr
    port map (
      src_clk  => axis_aclk,
      src_in   => intrpt_src_in,
      dest_clk => s_axi_csr_aclk,
      dest_out => intrpt_src_in_s
      );

  px_vita49_pkt_px_axil_csr_inst : px_vita49_pkt_px_axil_csr
    port map (
      s_axi_csr_aclk    => s_axi_csr_aclk,
      s_axi_csr_aresetn => s_axi_csr_aresetn_r,
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
      ctl0_out          => ctl0_out_local,
      ctl1_out          => ctl1_out_local,
      ctl2_out          => ctl2_out_local,
      ctl3_out          => ctl3_out_local,
      ctl4_out          => ctl4_out_local,
      ctl5_out          => ctl5_out_local,
      stat0_in          => stat0_in_s,
      stat1_in          => stat1_in_s,
      stat2_in          => stat2_in_s,
      intrpt_src_in     => intrpt_src_in_s,
      irq               => irq
      );

  px_vita49_xpm_cdc_bus_sync_ctl0_out : px_vita49_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl0_out_local,
      dest_clk => axis_aclk,
      dest_out => ctl0_out
      );
  px_vita49_xpm_cdc_bus_sync_ctl1_out : px_vita49_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl1_out_local,
      dest_clk => axis_aclk,
      dest_out => ctl1_out
      );
  px_vita49_xpm_cdc_bus_sync_ctl2_out : px_vita49_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl2_out_local,
      dest_clk => axis_aclk,
      dest_out => ctl2_out
      );
  px_vita49_xpm_cdc_bus_sync_ctl3_out : px_vita49_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl3_out_local,
      dest_clk => axis_aclk,
      dest_out => ctl3_out
      );
  px_vita49_xpm_cdc_bus_sync_ctl4_out : px_vita49_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl4_out_local,
      dest_clk => axis_aclk,
      dest_out => ctl4_out
      );
  px_vita49_xpm_cdc_bus_sync_ctl5_out : px_vita49_xpm_cdc_bus_sync
    port map (
      src_clk  => s_axi_csr_aclk,
      src_in   => ctl5_out_local,
      dest_clk => axis_aclk,
      dest_out => ctl5_out
      );
end Behavioral;
