----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 01/04/2017
-- Design Name: packer 
-- Module Name: px_10ge_udp_tx_packer
-- Project Name: px_10ge_udp_tx
-- Target Devices: Virtex 7
-- Tool Versions: Vivado 2016.4
-- Description: Contains fifos, intake for incoming data, and outgoing for constructed packets
--              and sm which creates the packets
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 

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
use IEEE.STD_LOGIC_TEXTIO.all;

library UNISIM;
use UNISIM.VComponents.all;

entity px_10ge_udp_tx_packer is

  port (
    clk       : in std_logic;           --must come from ethernet core clk
    rstn      : in std_logic;
    fifo_rstn : in std_logic;



    sm_enable     : in  std_logic;
    xilinx_core_rdy : in  std_logic;
    mac_header    : in  std_logic_vector(111 downto 0);
    ip_header     : in  std_logic_vector(159 downto 0);
    udp_header    : in  std_logic_vector(63 downto 0);
    count_rd      : out std_logic;
    count         : in  std_logic_vector(15 downto 0);

    s_axis_eth_tvalid        : in  std_logic;
    s_axis_eth_tready        : out std_logic;
    s_axis_eth_tdata         : in  std_logic_vector(63 downto 0);
    s_axis_eth_tkeep         : in  std_logic_vector(7 downto 0);
    s_axis_eth_tlast         : in  std_logic;
    intake_axis_data_count   : out std_logic_vector(14 downto 0);
    outgoing_axis_data_count : out std_logic_vector(14 downto 0);

    m_axis_tx_tvalid : out std_logic;
    m_axis_tx_tready : in  std_logic;
    m_axis_tx_tdata  : out std_logic_vector(63 downto 0);
    m_axis_tx_tkeep  : out std_logic_vector(7 downto 0);
    m_axis_tx_tlast  : out std_logic;
    m_axis_tx_tuser  : out std_logic_vector(0 downto 0)
    );
end px_10ge_udp_tx_packer;


architecture behavioral of px_10ge_udp_tx_packer is

  component px_10ge_udp_tx_in_pkt_fifo
    port (
      s_aclk          : in  std_logic;
      s_aresetn       : in  std_logic;
      s_axis_tvalid   : in  std_logic;
      s_axis_tready   : out std_logic;
      s_axis_tdata    : in  std_logic_vector(63 downto 0);
      s_axis_tkeep    : in  std_logic_vector(7 downto 0);
      s_axis_tlast    : in  std_logic;
      m_axis_tvalid   : out std_logic;
      m_axis_tready   : in  std_logic;
      m_axis_tdata    : out std_logic_vector(63 downto 0);
      m_axis_tkeep    : out std_logic_vector(7 downto 0);
      m_axis_tlast    : out std_logic;
      axis_data_count : out std_logic_vector(14 downto 0)
      );
  end component;
  component px_10ge_udp_tx_out_pkt_fifo
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

--signals
  signal s_aresetn           : std_logic := '0';
  signal m_axis_tvalid       : std_logic;
  signal m_axis_tready       : std_logic;
  signal m_axis_tdata        : std_logic_vector(63 downto 0);
  signal m_axis_tkeep        : std_logic_vector(7 downto 0);
  signal m_axis_tlast        : std_logic;
  signal in_axis_data_count  : std_logic_vector(14 downto 0);
  signal s_axis_tvalid       : std_logic;
  signal s_axis_tready       : std_logic;
  signal s_axis_tdata        : std_logic_vector(63 downto 0);
  signal s_axis_tkeep        : std_logic_vector(7 downto 0);
  signal s_axis_tlast        : std_logic;
  signal s_axis_tuser        : std_logic_vector(0 downto 0);
  signal out_axis_data_count : std_logic_vector(14 downto 0);

begin

  s_aresetn                <= fifo_rstn;
  intake_axis_data_count   <= in_axis_data_count;
  outgoing_axis_data_count <= out_axis_data_count;

  px_10ge_udp_tx_in_pkt_fifo_inst : px_10ge_udp_tx_in_pkt_fifo
    port map (
      s_aclk          => clk,
      s_aresetn       => s_aresetn,
      s_axis_tvalid   => s_axis_eth_tvalid,
      s_axis_tready   => s_axis_eth_tready,
      s_axis_tdata    => s_axis_eth_tdata,
      s_axis_tkeep    => s_axis_eth_tkeep,
      s_axis_tlast    => s_axis_eth_tlast,
      m_axis_tvalid   => m_axis_tvalid,
      m_axis_tready   => m_axis_tready,
      m_axis_tdata    => m_axis_tdata,
      m_axis_tkeep    => m_axis_tkeep,
      m_axis_tlast    => m_axis_tlast,
      axis_data_count => in_axis_data_count
      );

  px_10ge_udp_tx_sm_inst : entity work.px_10ge_udp_tx_sm
    port map(
      clk                 => clk,
      rstn                => rstn,
      sm_enable           => sm_enable,
      xilinx_core_rdy       => xilinx_core_rdy,
      fifo_rstn           => fifo_rstn,
      mac_header          => mac_header,
      ip_header           => ip_header,
      udp_header          => udp_header,
      count_rd            => count_rd,
      count               => count,
      in_axis_data_count  => in_axis_data_count,
      out_axis_data_count => out_axis_data_count,
      s_axis_tvalid       => m_axis_tvalid,
      s_axis_tready       => m_axis_tready,
      s_axis_tdata        => m_axis_tdata,
      s_axis_tkeep        => m_axis_tkeep,
      s_axis_tlast        => m_axis_tlast,
      m_axis_tvalid       => s_axis_tvalid,
      m_axis_tready       => s_axis_tready,
      m_axis_tdata        => s_axis_tdata,
      m_axis_tkeep        => s_axis_tkeep,
      m_axis_tlast        => s_axis_tlast,
      m_axis_tuser        => s_axis_tuser
      );

  px_10ge_udp_tx_out_pkt_fifo_inst : px_10ge_udp_tx_out_pkt_fifo
    port map (
      s_aclk          => clk,
      s_aresetn       => rstn,
      s_axis_tvalid   => s_axis_tvalid,
      s_axis_tready   => s_axis_tready,
      s_axis_tdata    => s_axis_tdata,
      s_axis_tkeep    => s_axis_tkeep,
      s_axis_tlast    => s_axis_tlast,
      s_axis_tuser    => s_axis_tuser,
      m_axis_tvalid   => m_axis_tx_tvalid,
      m_axis_tready   => m_axis_tx_tready,
      m_axis_tdata    => m_axis_tx_tdata,
      m_axis_tkeep    => m_axis_tx_tkeep,
      m_axis_tlast    => m_axis_tx_tlast,
      m_axis_tuser    => m_axis_tx_tuser,
      axis_data_count => out_axis_data_count
      );


end Behavioral;
