----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 6/29/2017
-- Design Name: px_vita49_pkt_header_creator
-- Module Name: px_vita49_pkt_header_creator
-- Project Name: px_vita49_pkt
-- Target Devices: Kintex Ultrascale
-- Tool Versions: Vivado 2017.2
-- Description: Creates header for Vit49 Packet
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 2.0  - Modified to support data input widths of 4, 8, 16 and 32 Bytes.
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

entity px_vita49_pkt_header_creator is
generic (
    Input_Bytes    : integer := 32
);
  port (
    aclk                   : in     std_logic;
    aresetn                : in     std_logic;
    aclken                 : in     std_logic;
    time_mode              : in     std_logic;
    data_len_max           : in     std_logic_vector(15 downto 0);
    context_header_upper   : in     std_logic_vector(11 downto 0);
    stream_identifier      : in     std_logic_vector(31 downto 0);
    class_identifier1      : in     std_logic_vector(31 downto 0);
    class_identifier2      : in     std_logic_vector(31 downto 0);
    head_error             : out    std_logic;
    s_axis_tvalid          : in     std_logic;
    s_axis_tready          : out    std_logic;
    s_axis_tdata           : in     std_logic_vector(Input_Bytes*8 - 1 downto 0);
    s_axis_tkeep           : in     std_logic_vector(Input_Bytes - 1 downto 0);
    s_axis_tlast           : in     std_logic;
    s_axis_tuser           : in     std_logic_vector(79 downto 0);
    m_axis_tvalid          : out    std_logic;
    m_axis_tready          : in     std_logic;
    m_axis_tdata           : out    std_logic_vector(Input_Bytes*8 - 1 downto 0);
    m_axis_tkeep           : out    std_logic_vector(Input_Bytes - 1 downto 0);
    m_axis_tlast           : out    std_logic;
    m_axis_tuser           : out    std_logic_vector(79 downto 0);
    m_axis_smheader_tvalid : buffer std_logic;
    m_axis_smheader_tready : in     std_logic;
    m_axis_smheader_tdata  : out    std_logic_vector(255 downto 0);
    m_axis_smheader_tuser  : out    std_logic_vector(79 downto 0)
    );
end px_vita49_pkt_header_creator;


architecture behavioral of px_vita49_pkt_header_creator is

  signal tuser_latched         : std_logic                     := '0';
  signal counter               : std_logic_vector(15 downto 0) := (others => '0');
  signal packet_count          : std_logic_vector(3 downto 0)  := (others => '0');
  signal packet_size           : std_logic_vector(15 downto 0) := (others => '0');
  signal s_axis_tuser_first    : std_logic_vector(79 downto 0) := (others => '0');
  signal context_header        : std_logic_vector(31 downto 0) := (others => '0');
  signal integer_timestamp     : std_logic_vector(31 downto 0) := (others => '0');
  signal fractional_timestamp1 : std_logic_vector(31 downto 0) := (others => '0');
  signal fractional_timestamp2 : std_logic_vector(31 downto 0) := (others => '0');
  
  signal data_len_incr_val     : integer := Input_Bytes/4;

begin

  s_axis_tready <= m_axis_tready;

  latch_tuser_first : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      s_axis_tuser_first <= (others => '0');
      tuser_latched      <= '0';
    elsif rising_edge(aclk) then
      if aclken = '1' and s_axis_tvalid = '1' and tuser_latched = '0' then  --added rising_edge(aclk)
        s_axis_tuser_first <= s_axis_tuser;
        tuser_latched      <= '1';
      elsif s_axis_tlast = '1' or m_axis_smheader_tvalid = '1' then
        tuser_latched <= '0';
      end if;
    end if;
  end process;


  count_data_length : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      counter                <= x"0000";
      m_axis_smheader_tvalid <= '0';
      packet_count           <= (others => '0');
    elsif rising_edge(aclk) and aclken = '1' then
      if s_axis_tvalid = '0' then
        m_axis_smheader_tvalid <= '0';
      elsif s_axis_tvalid = '1' and s_axis_tlast = '1' then
        packet_size            <= counter + data_len_incr_val;
        counter                <= (others => '0');
        m_axis_smheader_tvalid <= '1';
        packet_count           <= packet_count + 1;
      elsif s_axis_tvalid = '1' and (counter = data_len_max - data_len_incr_val) then
        packet_size            <= counter + data_len_incr_val;
        counter                <= (others => '0');
        m_axis_smheader_tvalid <= '1';
        packet_count           <= packet_count + 1;
      elsif s_axis_tvalid = '1' and m_axis_smheader_tready = '1' and (counter < data_len_max - data_len_incr_val) then
        -- Count by (Input_bytes/4) 
        counter                <= counter + data_len_incr_val;
        m_axis_smheader_tvalid <= '0';
      end if;
    end if;
  end process;

  check_for_error : process(aclk, aresetn, aclken)  --header fifo is full
  begin
    if aresetn = '0' then
      head_error <= '0';
    elsif rising_edge(aclk) and aclken = '1' then
      if m_axis_smheader_tvalid = '1' and m_axis_smheader_tready = '0' then
        head_error <= '1';
      end if;
    end if;
  end process;

--To Data FIFO
  m_axis_tvalid <= s_axis_tvalid;
  --m_axis_tready <= s_axis_tready_d;
  m_axis_tdata  <= s_axis_tdata;
  m_axis_tkeep  <= s_axis_tkeep;
  m_axis_tlast  <= s_axis_tlast;
  m_axis_tuser  <= s_axis_tuser;

--VITA 49 Header
  context_header        <= context_header_upper & packet_count & (packet_size + 8);
--stream_identifier     <= (others => '0');
--class_identifier1     <= (others => '0');
--class_identifier2     <= (others => '0');
  integer_timestamp     <= s_axis_tuser_first(31 downto 0)                                           when time_mode = '1' else (others => '0');
  fractional_timestamp1 <= s_axis_tuser_first(63 downto 32)                                          when time_mode = '1' else s_axis_tuser_first(31 downto 0);
  fractional_timestamp2 <= (others                                                                                                     => '0') when time_mode = '1' else s_axis_tuser_first(63 downto 32);

--To Header FIFO
  m_axis_smheader_tdata(255 downto 224) <= (others => '0');
  m_axis_smheader_tdata(223 downto 0)   <= fractional_timestamp2 & fractional_timestamp1 & integer_timestamp & class_identifier2 & class_identifier1 & stream_identifier & context_header;
  m_axis_smheader_tuser                 <= s_axis_tuser_first;

end Behavioral;

