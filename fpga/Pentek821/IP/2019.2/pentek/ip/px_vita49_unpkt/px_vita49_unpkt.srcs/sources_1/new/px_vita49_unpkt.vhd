----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 8/18/2017
-- Design Name: px_vita49_unpkt
-- Module Name: px_vita49_unpkt
-- Project Name: px_vita49_unpkt
-- Target Devices: Kintex Ultrascale
-- Tool Versions: Vivado 2017.2
-- Description: Packages Vita49 Header with Data
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 

-- (Memory Map)
-- 0x00 - Control Registers
-- 0x04 - Packet Size Control Reg
-- 0x08 - State Machine Status Regs
-- 0x0C - Header FIFO Status
-- 0x10 - Payload FIFO Status
-- 0x14 - Interrupt Enables
-- 0x18 - Interrupt Status
-- 0x1C - Interrupt Flags

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


entity px_vita49_unpkt is
  port (
    axis_aclk     : in  std_logic;
    axis_aresetn  : in  std_logic;
    s_axis_tvalid : in  std_logic;
    s_axis_tready : out std_logic;
    s_axis_tdata  : in  std_logic_vector(255 downto 0);
    s_axis_tkeep  : in  std_logic_vector(31 downto 0);
    s_axis_tlast  : in  std_logic;

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

    m_axis_tvalid : out std_logic;
    m_axis_tready : in  std_logic;
    m_axis_tdata  : out std_logic_vector(255 downto 0);
    m_axis_tkeep  : out std_logic_vector(31 downto 0);
    m_axis_tlast  : out std_logic
    );
end px_vita49_unpkt;

architecture Behavioral of px_vita49_unpkt is

  component px_vita49_unpkt_xpm_cdc_async_rst
    port (
      dest_clk  : in  std_logic;
      src_arst  : in  std_logic;
      dest_arst : out std_logic
      );
  end component;
  component px_vita49_unpkt_px_axil_csr_wrapper is
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
      ctl0_out          : out std_logic_vector(31 downto 0);
      intrpt_src_in     : in  std_logic_vector(0 downto 0);
      irq               : out std_logic
      );
  end component;

  signal resetn                  : std_logic                      := '0';
  signal user_resetn             : std_logic                      := '0';
  signal aclken                  : std_logic                      := '0';
  signal tlast_enable            : std_logic                      := '0';
  signal irq_local               : std_logic                      := '0';
  signal reg0_init_val           : std_logic_vector(31 downto 0)  := (others => '0');
  signal ctl0_out                : std_logic_vector(31 downto 0)  := (others => '0');
  signal intrpt_src_in           : std_logic_vector(0 downto 0)   := (others => '0');
  signal shifter                 : std_logic_vector(2 downto 0)   := (others => '0');
  signal packet_count_error      : std_logic                      := '0';
  signal packet_size             : std_logic_vector(15 downto 0)  := (others => '0');
  signal stream_id_en            : std_logic                      := '0';
  signal class_id_en             : std_logic                      := '0';
  signal integer_timestamp_en    : std_logic                      := '0';
  signal fractional_timestamp_en : std_logic                      := '0';
  signal trailer_en              : std_logic                      := '0';
  signal axis_analyzed_tvalid    : std_logic                      := '0';
  signal axis_analyzed_tready    : std_logic                      := '0';
  signal axis_analyzed_tdata     : std_logic_vector(255 downto 0) := (others => '0');
  signal axis_analyzed_tkeep     : std_logic_vector(31 downto 0)  := (others => '0');
  signal axis_analyzed_tlast     : std_logic                      := '0';
  signal parser_error            : std_logic                      := '0';
  signal contains_header         : std_logic                      := '0';
  signal contains_trailer        : std_logic                      := '0';
  signal axis_parsed_tvalid      : std_logic;
  signal axis_parsed_tready      : std_logic;
  signal axis_parsed_tdata       : std_logic_vector(255 downto 0);
  signal axis_parsed_tkeep       : std_logic_vector(31 downto 0);
  signal axis_parsed_tlast       : std_logic;
  signal keep_label              : std_logic_vector(7 downto 0);
  signal m_axis_tdata_swap       : std_logic_vector(255 downto 0);
  signal m_axis_tkeep_swap       : std_logic_vector(31 downto 0);
  signal data1                   : std_logic_vector(31 downto 0);
  signal data2                   : std_logic_vector(31 downto 0);
  signal data3                   : std_logic_vector(31 downto 0);
  signal data4                   : std_logic_vector(31 downto 0);
  signal data5                   : std_logic_vector(31 downto 0);
  signal data6                   : std_logic_vector(31 downto 0);
  signal data7                   : std_logic_vector(31 downto 0);
  signal data8                   : std_logic_vector(31 downto 0);
  signal keep1                   : std_logic_vector(3 downto 0);
  signal keep2                   : std_logic_vector(3 downto 0);
  signal keep3                   : std_logic_vector(3 downto 0);
  signal keep4                   : std_logic_vector(3 downto 0);
  signal keep5                   : std_logic_vector(3 downto 0);
  signal keep6                   : std_logic_vector(3 downto 0);
  signal keep7                   : std_logic_vector(3 downto 0);
  signal keep8                   : std_logic_vector(3 downto 0);


  attribute X_INTERFACE_INFO                        : string;
  attribute X_INTERFACE_INFO of irq_local           : signal is "xilinx.com:signal:interrupt:1.0 irq_local INTR";
  attribute X_INTERFACE_PARAMETER                   : string;
  attribute X_INTERFACE_PARAMETER of irq_local      : signal is "SENSITIVITY EDGE_RISING";
  attribute X_INTERFACE_INFO of s_axi_csr_aclk      : signal is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
  attribute X_INTERFACE_PARAMETER of s_axi_csr_aclk : signal is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";
  attribute X_INTERFACE_INFO of axis_aclk           : signal is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
  attribute X_INTERFACE_PARAMETER of axis_aclk      : signal is "ASSOCIATED_BUSIF s_axis:m_axis, ASSOCIATED_RESET axis_aresetn";

--  attribute mark_debug                  : string;
--  attribute keep                        : string;
--  attribute mark_debug of s_axis_tvalid : signal is "true";
--  attribute mark_debug of s_axis_tready : signal is "true";
--  attribute mark_debug of s_axis_tdata  : signal is "true";
--  attribute mark_debug of s_axis_tkeep  : signal is "true";
--  attribute mark_debug of s_axis_tlast  : signal is "true";
--  attribute mark_debug of m_axis_tvalid : signal is "true";
--  attribute mark_debug of m_axis_tready : signal is "true";
--  attribute mark_debug of m_axis_tdata  : signal is "true";
--  attribute mark_debug of m_axis_tkeep  : signal is "true";
--  attribute mark_debug of m_axis_tlast  : signal is "true";

begin

  px_vita49_unpkt_xpm_cdc_async_rst_inst : px_vita49_unpkt_xpm_cdc_async_rst
    port map (
      src_arst  => axis_aresetn,
      dest_clk  => axis_aclk,
      dest_arst => resetn
      );

  reg0_init_val    <= x"00000000";
  user_resetn      <= resetn and ctl0_out(0);
  aclken           <= ctl0_out(1);
  tlast_enable     <= ctl0_out(2);
  intrpt_src_in(0) <= parser_error;
  irq              <= irq_local;

  px_vita49_unpkt_px_axil_csr_wrapper_inst : entity work.px_vita49_unpkt_px_axil_csr_wrapper
    port map (
      axis_aclk         => axis_aclk,
      axis_aresetn      => user_resetn,
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
      intrpt_src_in     => intrpt_src_in,
      irq               => irq_local
      );

  px_vita49_unpkt_context_analyzer_inst : entity work.px_vita49_unpkt_context_analyzer
    port map (
      aclk                    => axis_aclk,
      aresetn                 => user_resetn,
      aclken                  => aclken,
      tlast_enable            => tlast_enable,
      s_axis_tvalid           => s_axis_tvalid,
      s_axis_tready           => s_axis_tready,
      s_axis_tdata            => s_axis_tdata,
      s_axis_tkeep            => s_axis_tkeep,
      s_axis_tlast            => s_axis_tlast,
      shifter                 => shifter,
      packet_count_error      => packet_count_error,
      packet_size             => packet_size,
      stream_id_en            => stream_id_en,
      class_id_en             => class_id_en,
      integer_timestamp_en    => integer_timestamp_en,
      fractional_timestamp_en => fractional_timestamp_en,
      trailer_en              => trailer_en,
      contains_header         => contains_header,
      contains_trailer        => contains_trailer,
      m_axis_tvalid           => axis_analyzed_tvalid,
      m_axis_tready           => axis_analyzed_tready,
      m_axis_tdata            => axis_analyzed_tdata,
      m_axis_tkeep            => axis_analyzed_tkeep,
      m_axis_tlast            => axis_analyzed_tlast
      );

  px_vita49_unpkt_parser_inst : entity work.px_vita49_unpkt_parser
    port map (
      aclk                    => axis_aclk,
      aresetn                 => user_resetn,
      aclken                  => aclken,
      shifter                 => shifter,
      packet_size             => packet_size,
      stream_id_en            => stream_id_en,
      class_id_en             => class_id_en,
      integer_timestamp_en    => integer_timestamp_en,
      fractional_timestamp_en => fractional_timestamp_en,
      trailer_en              => trailer_en,
      contains_header         => contains_header,
      contains_trailer        => contains_trailer,
      s_axis_tvalid           => axis_analyzed_tvalid,
      s_axis_tready           => axis_analyzed_tready,
      s_axis_tdata            => axis_analyzed_tdata,
      s_axis_tkeep            => axis_analyzed_tkeep,
      s_axis_tlast            => axis_analyzed_tlast,
      parser_error            => parser_error,
      m_axis_tvalid           => axis_parsed_tvalid,
      m_axis_tready           => axis_parsed_tready,
      m_axis_tdata            => axis_parsed_tdata,
      m_axis_tkeep            => axis_parsed_tkeep,
      m_axis_tlast            => axis_parsed_tlast,
      keep_label              => keep_label
      );

  px_vita49_unpkt_shifter_inst : entity work.px_vita49_unpkt_shifter
    port map (
      aclk          => axis_aclk,
      aresetn       => user_resetn,
      aclken        => aclken,
      keep_label    => keep_label,
      s_axis_tvalid => axis_parsed_tvalid,
      s_axis_tready => axis_parsed_tready,
      s_axis_tdata  => axis_parsed_tdata,
      s_axis_tkeep  => axis_parsed_tkeep,
      s_axis_tlast  => axis_parsed_tlast,
      m_axis_tvalid => m_axis_tvalid,
      m_axis_tready => m_axis_tready,
      m_axis_tdata  => m_axis_tdata_swap,
      m_axis_tkeep  => m_axis_tkeep_swap,
      m_axis_tlast  => m_axis_tlast
      );

-- vita49 compliance swap
  data1 <= m_axis_tdata_swap(15 downto 0) & m_axis_tdata_swap(31 downto 16);
  data2 <= m_axis_tdata_swap(47 downto 32) & m_axis_tdata_swap(63 downto 48);
  data3 <= m_axis_tdata_swap(79 downto 64) & m_axis_tdata_swap(95 downto 80);
  data4 <= m_axis_tdata_swap(111 downto 96) & m_axis_tdata_swap(127 downto 112);
  data5 <= m_axis_tdata_swap(143 downto 128) & m_axis_tdata_swap(159 downto 144);
  data6 <= m_axis_tdata_swap(175 downto 160) & m_axis_tdata_swap(191 downto 176);
  data7 <= m_axis_tdata_swap(207 downto 192) & m_axis_tdata_swap(223 downto 208);
  data8 <= m_axis_tdata_swap(239 downto 224) & m_axis_tdata_swap(255 downto 240);

  keep1 <= m_axis_tkeep_swap(1 downto 0) & m_axis_tkeep_swap(3 downto 2);
  keep2 <= m_axis_tkeep_swap(5 downto 4) & m_axis_tkeep_swap(7 downto 6);
  keep3 <= m_axis_tkeep_swap(9 downto 8) & m_axis_tkeep_swap(11 downto 10);
  keep4 <= m_axis_tkeep_swap(13 downto 12) & m_axis_tkeep_swap(15 downto 14);
  keep5 <= m_axis_tkeep_swap(17 downto 16) & m_axis_tkeep_swap(19 downto 18);
  keep6 <= m_axis_tkeep_swap(21 downto 20) & m_axis_tkeep_swap(23 downto 22);
  keep7 <= m_axis_tkeep_swap(25 downto 24) & m_axis_tkeep_swap(27 downto 26);
  keep8 <= m_axis_tkeep_swap(29 downto 28) & m_axis_tkeep_swap(31 downto 30);

  m_axis_tdata <= data8 & data7 & data6 & data5 & data4 & data3 & data2 & data1;
  m_axis_tkeep <= keep8 & keep7 & keep6 & keep5 & keep4 & keep3 & keep2 & keep1;

end Behavioral;
