----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 6/27/2017
-- Design Name: px_vita49_pkt
-- Module Name: px_vita49_pkt
-- Project Name: px_vita49_pkt
-- Target Devices: Kintex Ultrascale
-- Tool Versions: Vivado 2017.2
-- Description: Packages Vita49 Header with Data
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.01 - Fixed major bug involving handling of valid and ready signals
-- Revision 2.0  - Modified to support data input widths of 4, 8, 16 and 32 Bytes.
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


entity px_vita49_pkt is
generic (
    -- Valid Settings
    -- 4,8,16,32
    Input_Bytes    : integer := 4
);
  port (
    axis_aclk     : in  std_logic;
    axis_aresetn  : in  std_logic;
    s_axis_tvalid : in  std_logic;
    s_axis_tready : out std_logic;
    s_axis_tdata  : in  std_logic_vector(Input_Bytes*8 - 1 downto 0);
    s_axis_tkeep  : in  std_logic_vector(Input_Bytes/2 - 1 downto 0);
    s_axis_tlast  : in  std_logic;
    s_axis_tuser  : in  std_logic_vector(79 downto 0);

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
    m_axis_tkeep  : out std_logic_vector(15 downto 0);
    m_axis_tlast  : out std_logic;
    m_axis_tuser  : out std_logic_vector(79 downto 0)
    );
end px_vita49_pkt;

architecture Behavioral of px_vita49_pkt is

  component px_vita49_xpm_cdc_async_rst
    port (
      dest_clk  : in  std_logic;
      src_arst  : in  std_logic;
      dest_arst : out std_logic
      );
  end component;
  component px_vita49_pkt_axis_slice
    port (
      aclk          : in  std_logic;
      aresetn       : in  std_logic;
      aclken        : in  std_logic;
      s_axis_tvalid : in  std_logic;
      s_axis_tready : out std_logic;
      s_axis_tdata  : in  std_logic_vector(31 downto 0);
      s_axis_tkeep  : in  std_logic_vector(3 downto 0);
      s_axis_tlast  : in  std_logic;
      s_axis_tuser  : in  std_logic_vector(79 downto 0);
      m_axis_tvalid : out std_logic;
      m_axis_tready : in  std_logic;
      m_axis_tdata  : out std_logic_vector(31 downto 0);
      m_axis_tkeep  : out std_logic_vector(3 downto 0);
      m_axis_tlast  : out std_logic;
      m_axis_tuser  : out std_logic_vector(79 downto 0)
      );
  end component;
  
  component px_vita49_pkt_axis_slice_64
    port (
      aclk          : in  std_logic;
      aresetn       : in  std_logic;
      aclken        : in  std_logic;
      s_axis_tvalid : in  std_logic;
      s_axis_tready : out std_logic;
      s_axis_tdata  : in  std_logic_vector(63 downto 0);
      s_axis_tkeep  : in  std_logic_vector(7 downto 0);
      s_axis_tlast  : in  std_logic;
      s_axis_tuser  : in  std_logic_vector(79 downto 0);
      m_axis_tvalid : out std_logic;
      m_axis_tready : in  std_logic;
      m_axis_tdata  : out std_logic_vector(63 downto 0);
      m_axis_tkeep  : out std_logic_vector(7 downto 0);
      m_axis_tlast  : out std_logic;
      m_axis_tuser  : out std_logic_vector(79 downto 0)
      );
  end component;
  
  component px_vita49_pkt_axis_slice_128
    port (
      aclk          : in  std_logic;
      aresetn       : in  std_logic;
      aclken        : in  std_logic;
      s_axis_tvalid : in  std_logic;
      s_axis_tready : out std_logic;
      s_axis_tdata  : in  std_logic_vector(127 downto 0);
      s_axis_tkeep  : in  std_logic_vector(15 downto 0);
      s_axis_tlast  : in  std_logic;
      s_axis_tuser  : in  std_logic_vector(79 downto 0);
      m_axis_tvalid : out std_logic;
      m_axis_tready : in  std_logic;
      m_axis_tdata  : out std_logic_vector(127 downto 0);
      m_axis_tkeep  : out std_logic_vector(15 downto 0);
      m_axis_tlast  : out std_logic;
      m_axis_tuser  : out std_logic_vector(79 downto 0)
      );
  end component;
  
  component px_vita49_pkt_axis_slice_256
    port (
      aclk          : in  std_logic;
      aresetn       : in  std_logic;
      aclken        : in  std_logic;
      s_axis_tvalid : in  std_logic;
      s_axis_tready : out std_logic;
      s_axis_tdata  : in  std_logic_vector(255 downto 0);
      s_axis_tkeep  : in  std_logic_vector(31 downto 0);
      s_axis_tlast  : in  std_logic;
      s_axis_tuser  : in  std_logic_vector(79 downto 0);
      m_axis_tvalid : out std_logic;
      m_axis_tready : in  std_logic;
      m_axis_tdata  : out std_logic_vector(255 downto 0);
      m_axis_tkeep  : out std_logic_vector(31 downto 0);
      m_axis_tlast  : out std_logic;
      m_axis_tuser  : out std_logic_vector(79 downto 0)
      );
  end component;
  
  component px_vita49_pkt_header_fifo
    port (
      s_aclk          : in  std_logic;
      s_aresetn       : in  std_logic;
      s_axis_tvalid   : in  std_logic;
      s_axis_tready   : out std_logic;
      s_axis_tdata    : in  std_logic_vector(255 downto 0);
      s_axis_tuser    : in  std_logic_vector(79 downto 0);
      m_axis_tvalid   : out std_logic;
      m_axis_tready   : in  std_logic;
      m_axis_tdata    : out std_logic_vector(255 downto 0);
      m_axis_tuser    : out std_logic_vector(79 downto 0);
      axis_data_count : out std_logic_vector(7 downto 0)
      );
  end component;
  component px_vita49_pkt_payload_fifo
    port (
      s_aclk          : in  std_logic;
      s_aresetn       : in  std_logic;
      s_axis_tvalid   : in  std_logic;
      s_axis_tready   : out std_logic;
      s_axis_tdata    : in  std_logic_vector(255 downto 0);
      s_axis_tkeep    : in  std_logic_vector(31 downto 0);
      s_axis_tlast    : in  std_logic;
      s_axis_tuser    : in  std_logic_vector(79 downto 0);
      m_axis_tvalid   : out std_logic;
      m_axis_tready   : in  std_logic;
      m_axis_tdata    : out std_logic_vector(255 downto 0);
      m_axis_tkeep    : out std_logic_vector(31 downto 0);
      m_axis_tlast    : out std_logic;
      m_axis_tuser    : out std_logic_vector(79 downto 0);
      axis_data_count : out std_logic_vector(12 downto 0)
      );
  end component;
  component px_vita49_pkt_ppkt_upsizer
    port (
      aclk               : in  std_logic;
      aresetn            : in  std_logic;
      s_axis_ppkt_tvalid : in  std_logic;
      s_axis_ppkt_tready : out std_logic;
      s_axis_ppkt_tdata  : in  std_logic_vector(31 downto 0);
      s_axis_ppkt_tuser  : in  std_logic_vector(79 downto 0);
      s_axis_ppkt_tkeep  : in  std_logic_vector(1 downto 0);
      s_axis_ppkt_tlast  : in  std_logic;
      m_axis_ppkt_tvalid : out std_logic;
      m_axis_ppkt_tready : in  std_logic;
      m_axis_ppkt_tdata  : out std_logic_vector(255 downto 0);
      m_axis_ppkt_tuser  : out std_logic_vector(79 downto 0);
      m_axis_ppkt_tkeep  : out std_logic_vector(15 downto 0);
      m_axis_ppkt_tlast  : out std_logic
      );
  end component;
  
  component px_vita49_pkt_ppkt_upsizer_64
    port (
      aclk               : in  std_logic;
      aresetn            : in  std_logic;
      s_axis_ppkt_tvalid : in  std_logic;
      s_axis_ppkt_tready : out std_logic;
      s_axis_ppkt_tdata  : in  std_logic_vector(63 downto 0);
      s_axis_ppkt_tuser  : in  std_logic_vector(79 downto 0);
      s_axis_ppkt_tkeep  : in  std_logic_vector(3 downto 0);
      s_axis_ppkt_tlast  : in  std_logic;
      m_axis_ppkt_tvalid : out std_logic;
      m_axis_ppkt_tready : in  std_logic;
      m_axis_ppkt_tdata  : out std_logic_vector(255 downto 0);
      m_axis_ppkt_tuser  : out std_logic_vector(79 downto 0);
      m_axis_ppkt_tkeep  : out std_logic_vector(15 downto 0);
      m_axis_ppkt_tlast  : out std_logic
      );
  end component;
  
  component px_vita49_pkt_ppkt_upsizer_128
    port (
      aclk               : in  std_logic;
      aresetn            : in  std_logic;
      s_axis_ppkt_tvalid : in  std_logic;
      s_axis_ppkt_tready : out std_logic;
      s_axis_ppkt_tdata  : in  std_logic_vector(127 downto 0);
      s_axis_ppkt_tuser  : in  std_logic_vector(79 downto 0);
      s_axis_ppkt_tkeep  : in  std_logic_vector(7 downto 0);
      s_axis_ppkt_tlast  : in  std_logic;
      m_axis_ppkt_tvalid : out std_logic;
      m_axis_ppkt_tready : in  std_logic;
      m_axis_ppkt_tdata  : out std_logic_vector(255 downto 0);
      m_axis_ppkt_tuser  : out std_logic_vector(79 downto 0);
      m_axis_ppkt_tkeep  : out std_logic_vector(15 downto 0);
      m_axis_ppkt_tlast  : out std_logic
      );
  end component;
  
  component px_vita49_pkt_ppkt_upsizer_256
    port (
      aclk               : in  std_logic;
      aresetn            : in  std_logic;
      s_axis_ppkt_tvalid : in  std_logic;
      s_axis_ppkt_tready : out std_logic;
      s_axis_ppkt_tdata  : in  std_logic_vector(255 downto 0);
      s_axis_ppkt_tuser  : in  std_logic_vector(79 downto 0);
      s_axis_ppkt_tkeep  : in  std_logic_vector(15 downto 0);
      s_axis_ppkt_tlast  : in  std_logic;
      m_axis_ppkt_tvalid : out std_logic;
      m_axis_ppkt_tready : in  std_logic;
      m_axis_ppkt_tdata  : out std_logic_vector(255 downto 0);
      m_axis_ppkt_tuser  : out std_logic_vector(79 downto 0);
      m_axis_ppkt_tkeep  : out std_logic_vector(15 downto 0);
      m_axis_ppkt_tlast  : out std_logic
      );
  end component;

  signal resetn               : std_logic                     := '0';
  signal sm_error             : std_logic                     := '0';
  signal head_error           : std_logic                     := '0';
  signal user_resetn          : std_logic                     := '0';
  signal enable               : std_logic                     := '0';
  signal time_mode            : std_logic                     := '0';
  signal data_len_max         : std_logic_vector(15 downto 0) := (others => '0');
  signal context_header_upper : std_logic_vector(11 downto 0) := (others => '0');
  signal stream_identifier    : std_logic_vector(31 downto 0) := (others => '0');
  signal class_identifier1    : std_logic_vector(31 downto 0) := (others => '0');
  signal class_identifier2    : std_logic_vector(31 downto 0) := (others => '0');
  signal trailer              : std_logic_vector(31 downto 0) := (others => '0');
  signal reg0_init_val        : std_logic_vector(31 downto 0) := (others => '0');
  signal reg1_init_val        : std_logic_vector(31 downto 0) := (others => '0');
  signal reg2_init_val        : std_logic_vector(31 downto 0) := (others => '0');
  signal reg3_init_val        : std_logic_vector(31 downto 0) := (others => '0');
  signal reg4_init_val        : std_logic_vector(31 downto 0) := (others => '0');
  signal reg5_init_val        : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl0_out             : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl1_out             : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl2_out             : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl3_out             : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl4_out             : std_logic_vector(31 downto 0) := (others => '0');
  signal ctl5_out             : std_logic_vector(31 downto 0) := (others => '0');
  signal stat0_in             : std_logic_vector(31 downto 0) := (others => '0');
  signal stat1_in             : std_logic_vector(31 downto 0) := (others => '0');
  signal stat2_in             : std_logic_vector(31 downto 0) := (others => '0');
  signal intrpt_src_in        : std_logic_vector(5 downto 0)  := (others => '0');
  signal irq_local            : std_logic                     := '0';

  signal s_axis_tkeep_fix        : std_logic_vector(Input_Bytes - 1 downto 0)   := (others => '0');
  signal axis_slice_tvalid       : std_logic                      := '0';
  signal axis_slice_tready       : std_logic                      := '0';
  signal axis_slice_tdata        : std_logic_vector(Input_Bytes*8 - 1 downto 0)  := (others => '0');
  signal axis_slice_tkeep        : std_logic_vector(Input_Bytes - 1 downto 0)   := (others => '0');
  signal axis_slice_tlast        : std_logic                      := '0';
  signal axis_slice_tuser        : std_logic_vector(79 downto 0)  := (others => '0');
  signal axis_data_tvalid        : std_logic                      := '0';
  signal axis_data_tready        : std_logic                      := '0';
  signal axis_data_tdata         : std_logic_vector(Input_Bytes*8 - 1 downto 0)  := (others => '0');
  signal axis_data_tdata_swap    : std_logic_vector(Input_Bytes*8 - 1 downto 0)  := (others => '0');
  signal axis_data_tkeep_swap    : std_logic_vector(Input_Bytes/2 -1 downto 0)   := (others => '0');
  signal axis_data_tkeep         : std_logic_vector(Input_Bytes - 1 downto 0)   := (others => '0');
  signal axis_data_tlast         : std_logic                      := '0';
  signal axis_data_tuser         : std_logic_vector(79 downto 0)  := (others => '0');
  signal axis_payload_tvalid     : std_logic                      := '0';
  signal axis_payload_tready     : std_logic                      := '0';
  signal axis_payload_tdata      : std_logic_vector(255 downto 0) := (others => '0');
  signal axis_payload_tkeep      : std_logic_vector(31 downto 0)  := (others => '0');
  signal axis_payload_tlast      : std_logic                      := '0';
  signal axis_payload_tuser      : std_logic_vector(79 downto 0)  := (others => '0');
  signal axis_payload_data_count : std_logic_vector(12 downto 0)  := (others => '0');
  signal axis_upsize_tvalid      : std_logic                      := '0';
  signal axis_upsize_tready      : std_logic                      := '0';
  signal axis_upsize_tdata       : std_logic_vector(255 downto 0) := (others => '0');
  signal axis_upsize_tuser       : std_logic_vector(79 downto 0)  := (others => '0');
  signal axis_upsize_tkeep       : std_logic_vector(15 downto 0)  := (others => '0');
  signal axis_upsize_tkeep_fix   : std_logic_vector(31 downto 0)  := (others => '0');
  signal axis_upsize_tlast       : std_logic                      := '0';
  signal axis_smheader_tvalid    : std_logic                      := '0';
  signal axis_smheader_tready    : std_logic                      := '0';
  signal axis_smheader_tdata     : std_logic_vector(255 downto 0) := (others => '0');
  signal axis_smheader_tuser     : std_logic_vector(79 downto 0)  := (others => '0');
  signal axis_header_tvalid      : std_logic                      := '0';
  signal axis_header_tready      : std_logic                      := '0';
  signal axis_header_tdata       : std_logic_vector(255 downto 0) := (others => '0');
  signal axis_header_tuser       : std_logic_vector(79 downto 0)  := (others => '0');
  signal axis_header_data_count  : std_logic_vector(7 downto 0)   := (others => '0');


  attribute X_INTERFACE_INFO                        : string;
  attribute X_INTERFACE_INFO of irq_local           : signal is "xilinx.com:signal:interrupt:1.0 irq_local INTR";
  attribute X_INTERFACE_PARAMETER                   : string;
  attribute X_INTERFACE_PARAMETER of irq_local      : signal is "SENSITIVITY EDGE_RISING";
  attribute X_INTERFACE_INFO of s_axi_csr_aclk      : signal is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
  attribute X_INTERFACE_PARAMETER of s_axi_csr_aclk : signal is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";
  attribute X_INTERFACE_INFO of axis_aclk           : signal is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
  attribute X_INTERFACE_PARAMETER of axis_aclk      : signal is "ASSOCIATED_BUSIF s_axis:m_axis, ASSOCIATED_RESET axis_aresetn";

attribute mark_debug : string;
attribute keep : string;
attribute mark_debug of s_axis_tvalid           : signal is "true"; 
attribute mark_debug of s_axis_tready           : signal is "true"; 
attribute mark_debug of s_axis_tdata            : signal is "true"; 
attribute mark_debug of s_axis_tkeep            : signal is "true"; 
attribute mark_debug of s_axis_tlast            : signal is "true"; 
attribute mark_debug of m_axis_tvalid           : signal is "true"; 
attribute mark_debug of m_axis_tready           : signal is "true"; 
attribute mark_debug of m_axis_tdata            : signal is "true"; 
attribute mark_debug of m_axis_tkeep            : signal is "true"; 
attribute mark_debug of m_axis_tlast            : signal is "true"; 

begin

  px_vita49_xpm_cdc_async_rst_inst : px_vita49_xpm_cdc_async_rst
    port map (
      src_arst  => axis_aresetn,
      dest_clk  => axis_aclk,
      dest_arst => resetn
      );

  reg0_init_val        <= x"00000000";
  reg1_init_val        <= x"1C501000";
  reg2_init_val        <= x"00000000";
  reg3_init_val        <= x"00000000";
  reg4_init_val        <= x"00000000";
  reg5_init_val        <= x"00000000";
  user_resetn          <= resetn and ctl0_out(0);
  enable               <= ctl0_out(1);
  time_mode            <= ctl0_out(2);
  data_len_max         <= ctl1_out(15 downto 0);
  context_header_upper <= ctl1_out(31 downto 20);
  stream_identifier    <= ctl2_out;
  trailer              <= ctl3_out;
  class_identifier1    <= ctl4_out;
  class_identifier2    <= ctl5_out;

  stat0_in         <= x"0000000" & "00" & sm_error & head_error;
  stat1_in         <= x"0000" & "000" & axis_payload_data_count;
  stat2_in         <= x"000000" & axis_header_data_count;
  intrpt_src_in(0) <= head_error;
  intrpt_src_in(1) <= sm_error;
  intrpt_src_in(2) <= '1' when axis_payload_data_count = "0000000000000" else '0';  --empty
  intrpt_src_in(3) <= '1' when axis_payload_data_count = "1000000000000" else '0';  --full
  intrpt_src_in(4) <= '1' when axis_header_data_count = "00000000"       else '0';  --empty
  intrpt_src_in(5) <= '1' when axis_header_data_count = "11111111"       else '0';  --full
  irq              <= irq_local;

  px_vita49_pkt_px_axil_csr_wrapper_inst : entity work.px_vita49_pkt_px_axil_csr_wrapper
    port map (
      axis_aclk         => axis_aclk,
      axis_aresetn      => axis_aresetn,
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
      reg1_init_val     => reg1_init_val,
      reg2_init_val     => reg2_init_val,
      reg3_init_val     => reg3_init_val,
      reg4_init_val     => reg4_init_val,
      reg5_init_val     => reg5_init_val,
      ctl0_out          => ctl0_out,
      ctl1_out          => ctl1_out,
      ctl2_out          => ctl2_out,
      ctl3_out          => ctl3_out,
      ctl4_out          => ctl4_out,
      ctl5_out          => ctl5_out,
      stat0_in          => stat0_in,
      stat1_in          => stat1_in,
      stat2_in          => stat2_in,
      intrpt_src_in     => intrpt_src_in,
      irq               => irq_local
      );

      
  bytes_4: if Input_Bytes = 4 generate    
      
      s_axis_tkeep_fix <= "00" & s_axis_tkeep(1 downto 0);
      
      px_vita49_pkt_axis_slice_inst : px_vita49_pkt_axis_slice
        port map (
          aclk          => axis_aclk,
          aresetn       => user_resetn,
          aclken        => enable,
          s_axis_tvalid => s_axis_tvalid,
          s_axis_tready => s_axis_tready,
          s_axis_tdata  => s_axis_tdata,
          s_axis_tkeep  => s_axis_tkeep_fix,
          s_axis_tlast  => s_axis_tlast,
          s_axis_tuser  => s_axis_tuser,
          m_axis_tvalid => axis_slice_tvalid,
          m_axis_tready => axis_slice_tready,
          m_axis_tdata  => axis_slice_tdata,
          m_axis_tkeep  => axis_slice_tkeep,
          m_axis_tlast  => axis_slice_tlast,
          m_axis_tuser  => axis_slice_tuser
          );
          
      
      axis_data_tdata_swap <= axis_data_tdata(15 downto 0) & axis_data_tdata(31 downto 16);
      axis_data_tkeep_swap <= axis_data_tkeep(0) & axis_data_tkeep(1);

      px_vita49_pkt_ppkt_upsizer_inst : px_vita49_pkt_ppkt_upsizer
        port map (
          aclk               => axis_aclk,
          aresetn            => user_resetn,
          s_axis_ppkt_tvalid => axis_data_tvalid,
          s_axis_ppkt_tready => axis_data_tready,
          s_axis_ppkt_tdata  => axis_data_tdata_swap,
          s_axis_ppkt_tuser  => axis_data_tuser,
          s_axis_ppkt_tkeep  => axis_data_tkeep_swap,
          s_axis_ppkt_tlast  => axis_data_tlast,
          m_axis_ppkt_tvalid => axis_upsize_tvalid,
          m_axis_ppkt_tready => axis_upsize_tready,
          m_axis_ppkt_tdata  => axis_upsize_tdata,
          m_axis_ppkt_tuser  => axis_upsize_tuser,
          m_axis_ppkt_tkeep  => axis_upsize_tkeep,
          m_axis_ppkt_tlast  => axis_upsize_tlast
          );
      
  end generate bytes_4;
    
  
  bytes_8: if Input_Bytes = 8 generate    
      
      s_axis_tkeep_fix <= "0000" & s_axis_tkeep(3 downto 0);
      
      px_vita49_pkt_axis_slice_inst : px_vita49_pkt_axis_slice_64
        port map (
          aclk          => axis_aclk,
          aresetn       => user_resetn,
          aclken        => enable,
          s_axis_tvalid => s_axis_tvalid,
          s_axis_tready => s_axis_tready,
          s_axis_tdata  => s_axis_tdata,
          s_axis_tkeep  => s_axis_tkeep_fix,
          s_axis_tlast  => s_axis_tlast,
          s_axis_tuser  => s_axis_tuser,
          m_axis_tvalid => axis_slice_tvalid,
          m_axis_tready => axis_slice_tready,
          m_axis_tdata  => axis_slice_tdata,
          m_axis_tkeep  => axis_slice_tkeep,
          m_axis_tlast  => axis_slice_tlast,
          m_axis_tuser  => axis_slice_tuser
          );
          
      
      axis_data_tdata_swap <= axis_data_tdata(47 downto 32) & axis_data_tdata(63 downto 48) & 
                              axis_data_tdata(15 downto 0) & axis_data_tdata(31 downto 16);
      
      
      axis_data_tkeep_swap <= axis_data_tkeep(0) & axis_data_tkeep(1) & axis_data_tkeep(2) & axis_data_tkeep(3);

      px_vita49_pkt_ppkt_upsizer_inst : px_vita49_pkt_ppkt_upsizer_64
        port map (
          aclk               => axis_aclk,
          aresetn            => user_resetn,
          s_axis_ppkt_tvalid => axis_data_tvalid,
          s_axis_ppkt_tready => axis_data_tready,
          s_axis_ppkt_tdata  => axis_data_tdata_swap,
          s_axis_ppkt_tuser  => axis_data_tuser,
          s_axis_ppkt_tkeep  => axis_data_tkeep_swap,
          s_axis_ppkt_tlast  => axis_data_tlast,
          m_axis_ppkt_tvalid => axis_upsize_tvalid,
          m_axis_ppkt_tready => axis_upsize_tready,
          m_axis_ppkt_tdata  => axis_upsize_tdata,
          m_axis_ppkt_tuser  => axis_upsize_tuser,
          m_axis_ppkt_tkeep  => axis_upsize_tkeep,
          m_axis_ppkt_tlast  => axis_upsize_tlast
          );
      
  end generate bytes_8;
  
  
  
  bytes_16: if Input_Bytes = 16 generate    
      
      s_axis_tkeep_fix <= "00000000" & s_axis_tkeep(7 downto 0);
      
      px_vita49_pkt_axis_slice_inst : px_vita49_pkt_axis_slice_128
        port map (
          aclk          => axis_aclk,
          aresetn       => user_resetn,
          aclken        => enable,
          s_axis_tvalid => s_axis_tvalid,
          s_axis_tready => s_axis_tready,
          s_axis_tdata  => s_axis_tdata,
          s_axis_tkeep  => s_axis_tkeep_fix,
          s_axis_tlast  => s_axis_tlast,
          s_axis_tuser  => s_axis_tuser,
          m_axis_tvalid => axis_slice_tvalid,
          m_axis_tready => axis_slice_tready,
          m_axis_tdata  => axis_slice_tdata,
          m_axis_tkeep  => axis_slice_tkeep,
          m_axis_tlast  => axis_slice_tlast,
          m_axis_tuser  => axis_slice_tuser
          );
          
      
      axis_data_tdata_swap <= axis_data_tdata(111 downto 96) & axis_data_tdata(127 downto 112) &
                              axis_data_tdata(79 downto 64)  & axis_data_tdata(95 downto 80)  &
                              axis_data_tdata(47 downto 32)  & axis_data_tdata(63 downto 48)  &
                              axis_data_tdata(15 downto 0)   & axis_data_tdata(31 downto 16);
      
      axis_data_tkeep_swap <= axis_data_tkeep(0) & axis_data_tkeep(1) & axis_data_tkeep(2) & axis_data_tkeep(3) &
                              axis_data_tkeep(4) & axis_data_tkeep(5) & axis_data_tkeep(6) & axis_data_tkeep(7);

      px_vita49_pkt_ppkt_upsizer_inst : px_vita49_pkt_ppkt_upsizer_128
        port map (
          aclk               => axis_aclk,
          aresetn            => user_resetn,
          s_axis_ppkt_tvalid => axis_data_tvalid,
          s_axis_ppkt_tready => axis_data_tready,
          s_axis_ppkt_tdata  => axis_data_tdata_swap,
          s_axis_ppkt_tuser  => axis_data_tuser,
          s_axis_ppkt_tkeep  => axis_data_tkeep_swap,
          s_axis_ppkt_tlast  => axis_data_tlast,
          m_axis_ppkt_tvalid => axis_upsize_tvalid,
          m_axis_ppkt_tready => axis_upsize_tready,
          m_axis_ppkt_tdata  => axis_upsize_tdata,
          m_axis_ppkt_tuser  => axis_upsize_tuser,
          m_axis_ppkt_tkeep  => axis_upsize_tkeep,
          m_axis_ppkt_tlast  => axis_upsize_tlast
          );
      
  end generate bytes_16;
  
  
  
  bytes_32: if Input_Bytes = 32 generate    
      
      s_axis_tkeep_fix <= X"0000" & s_axis_tkeep(15 downto 0);
      
      px_vita49_pkt_axis_slice_inst : px_vita49_pkt_axis_slice_256
        port map (
          aclk          => axis_aclk,
          aresetn       => user_resetn,
          aclken        => enable,
          s_axis_tvalid => s_axis_tvalid,
          s_axis_tready => s_axis_tready,
          s_axis_tdata  => s_axis_tdata,
          s_axis_tkeep  => s_axis_tkeep_fix,
          s_axis_tlast  => s_axis_tlast,
          s_axis_tuser  => s_axis_tuser,
          m_axis_tvalid => axis_slice_tvalid,
          m_axis_tready => axis_slice_tready,
          m_axis_tdata  => axis_slice_tdata,
          m_axis_tkeep  => axis_slice_tkeep,
          m_axis_tlast  => axis_slice_tlast,
          m_axis_tuser  => axis_slice_tuser
          );
          
      axis_data_tdata_swap <= axis_data_tdata(239 downto 224) & axis_data_tdata(255 downto 240) &
                              axis_data_tdata(207 downto 192) & axis_data_tdata(223 downto 208) &
                              axis_data_tdata(175 downto 160) & axis_data_tdata(191 downto 176) &
                              axis_data_tdata(143 downto 128) & axis_data_tdata(159 downto 144) &
                              axis_data_tdata(111 downto 96) & axis_data_tdata(127 downto 112)  &
                              axis_data_tdata(79 downto 64) & axis_data_tdata(95 downto 80)     &
                              axis_data_tdata(47 downto 32) & axis_data_tdata(63 downto 48)     &
                              axis_data_tdata(15 downto 0) & axis_data_tdata(31 downto 16);
                        
      axis_data_tkeep_swap <= axis_data_tkeep(0) & axis_data_tkeep(1) & axis_data_tkeep(2) & axis_data_tkeep(3) &
                              axis_data_tkeep(4) & axis_data_tkeep(5) & axis_data_tkeep(6) & axis_data_tkeep(7) &
                              axis_data_tkeep(8) & axis_data_tkeep(9) & axis_data_tkeep(10) & axis_data_tkeep(11) &
                              axis_data_tkeep(12) & axis_data_tkeep(13) & axis_data_tkeep(14) & axis_data_tkeep(15);
                              
       px_vita49_pkt_ppkt_upsizer_inst : px_vita49_pkt_ppkt_upsizer_256
           port map (
             aclk               => axis_aclk,
             aresetn            => user_resetn,
             s_axis_ppkt_tvalid => axis_data_tvalid,
             s_axis_ppkt_tready => axis_data_tready,
             s_axis_ppkt_tdata  => axis_data_tdata_swap,
             s_axis_ppkt_tuser  => axis_data_tuser,
             s_axis_ppkt_tkeep  => axis_data_tkeep_swap,
             s_axis_ppkt_tlast  => axis_data_tlast,
             m_axis_ppkt_tvalid => axis_upsize_tvalid,
             m_axis_ppkt_tready => axis_upsize_tready,
             m_axis_ppkt_tdata  => axis_upsize_tdata,
             m_axis_ppkt_tuser  => axis_upsize_tuser,
             m_axis_ppkt_tkeep  => axis_upsize_tkeep,
             m_axis_ppkt_tlast  => axis_upsize_tlast
             );
      
  end generate bytes_32;
  


  px_vita49_pkt_header_creator_inst : entity work.px_vita49_pkt_header_creator
   generic map (
    Input_Bytes  => Input_Bytes
   )
    port map (
      aclk                   => axis_aclk,
      aresetn                => user_resetn,
      aclken                 => enable,
      time_mode              => time_mode,
      data_len_max           => data_len_max,
      context_header_upper   => context_header_upper,
      stream_identifier      => stream_identifier,
      class_identifier1      => class_identifier1,
      class_identifier2      => class_identifier2,
      head_error             => head_error,
      s_axis_tvalid          => axis_slice_tvalid,
      s_axis_tready          => axis_slice_tready,
      s_axis_tdata           => axis_slice_tdata,
      s_axis_tkeep           => axis_slice_tkeep,
      s_axis_tlast           => axis_slice_tlast,
      s_axis_tuser           => axis_slice_tuser,
      m_axis_tvalid          => axis_data_tvalid,
      m_axis_tready          => axis_data_tready,
      m_axis_tdata           => axis_data_tdata,
      m_axis_tkeep           => axis_data_tkeep,
      m_axis_tlast           => axis_data_tlast,
      m_axis_tuser           => axis_data_tuser,
      m_axis_smheader_tvalid => axis_smheader_tvalid,
      m_axis_smheader_tready => axis_smheader_tready,
      m_axis_smheader_tdata  => axis_smheader_tdata,
      m_axis_smheader_tuser  => axis_smheader_tuser
      );


  px_vita49_pkt_header_fifo_inst : px_vita49_pkt_header_fifo
    port map (
      s_aclk          => axis_aclk,
      s_aresetn       => user_resetn,
      s_axis_tvalid   => axis_smheader_tvalid,
      s_axis_tready   => axis_smheader_tready,
      s_axis_tdata    => axis_smheader_tdata,
      s_axis_tuser    => axis_smheader_tuser,
      m_axis_tvalid   => axis_header_tvalid,
      m_axis_tready   => axis_header_tready,
      m_axis_tdata    => axis_header_tdata,
      m_axis_tuser    => axis_header_tuser,
      axis_data_count => axis_header_data_count
      );

  axis_upsize_tkeep_fix <= x"0000" & axis_upsize_tkeep;

  px_vita49_pkt_payload_fifo_inst : px_vita49_pkt_payload_fifo
    port map (
      s_aclk          => axis_aclk,
      s_aresetn       => user_resetn,
      s_axis_tvalid   => axis_upsize_tvalid,
      s_axis_tready   => axis_upsize_tready,
      s_axis_tdata    => axis_upsize_tdata,
      s_axis_tkeep    => axis_upsize_tkeep_fix,
      s_axis_tlast    => axis_upsize_tlast,
      s_axis_tuser    => axis_upsize_tuser,
      m_axis_tvalid   => axis_payload_tvalid,
      m_axis_tready   => axis_payload_tready,
      m_axis_tdata    => axis_payload_tdata,
      m_axis_tkeep    => axis_payload_tkeep,  --32 bits
      m_axis_tlast    => axis_payload_tlast,
      m_axis_tuser    => axis_payload_tuser,
      axis_data_count => axis_payload_data_count
      );



  packet_sm_inst : entity work.packet_sm
    generic map (
        Input_Bytes  => Input_Bytes
    )
    port map (
      aclk                  => axis_aclk,
      aresetn               => user_resetn,
      aclken                => enable,
      trailer               => trailer,
      sm_error              => sm_error,
      s_axis_payload_tvalid => axis_payload_tvalid,
      s_axis_payload_tready => axis_payload_tready,
      s_axis_payload_tdata  => axis_payload_tdata,
      s_axis_payload_tkeep  => axis_payload_tkeep(15 downto 0),
      s_axis_payload_tlast  => axis_payload_tlast,
      s_axis_payload_tuser  => axis_payload_tuser,
      s_axis_header_tvalid  => axis_header_tvalid,
      s_axis_header_tready  => axis_header_tready,
      s_axis_header_tdata   => axis_header_tdata,
      s_axis_header_tuser   => axis_header_tuser,
      m_axis_tvalid         => m_axis_tvalid,
      m_axis_tready         => m_axis_tready,
      m_axis_tdata          => m_axis_tdata,
      m_axis_tkeep          => m_axis_tkeep,
      m_axis_tlast          => m_axis_tlast,
      m_axis_tuser          => m_axis_tuser
      );


end Behavioral;
