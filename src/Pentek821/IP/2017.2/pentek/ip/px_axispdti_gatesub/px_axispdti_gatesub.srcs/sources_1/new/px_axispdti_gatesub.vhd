----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 03/04/2016 10:16:11 AM
-- Design Name: 
-- Module Name: px_axispdti_gatesub - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Substitute a different gate signal into a axis_pdti stream
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- (c) Copyright 2016 Pentek, Inc. All rights reserved.
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

--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axispdti_gatesub is
generic ( 
   num_bytes : integer := 2;
   num_gate_bits : integer := 1
   );
port (
----------------------------------------------------------------------------
-- AXI4-Lite Control/Status Interface
----------------------------------------------------------------------------
s_axi_csr_aclk      : in  std_logic;
s_axi_csr_aresetn   : in  std_logic;
s_axi_csr_awaddr    : in  std_logic_vector(6 downto 0);
s_axi_csr_awprot    : in  std_logic_vector(2 downto 0);
s_axi_csr_awvalid   : in  std_logic;
s_axi_csr_awready   : out std_logic;
s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0);
s_axi_csr_wvalid    : in  std_logic;
s_axi_csr_wready    : out std_logic;
s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
s_axi_csr_bvalid    : out std_logic;
s_axi_csr_bready    : in  std_logic;
s_axi_csr_araddr    : in  std_logic_vector(6 downto 0);
s_axi_csr_arprot    : in  std_logic_vector(2 downto 0);
s_axi_csr_arvalid   : in  std_logic;
s_axi_csr_arready   : out std_logic;
s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
s_axi_csr_rvalid    : out std_logic;
s_axi_csr_rready    : in  std_logic;
----------------------------------------------------------------------------
-- Gate Input 
----------------------------------------------------------------------------
-- Gate input for substitution 
-- For single sample data   - 1 bit
-- For single 2 sample data - 2 bits
-- For single 4 sample data - 4 bits
-- For single 8 sample data - 8 bits
gate_in             : in std_logic_vector(num_gate_bits-1 downto 0);
----------------------------------------------------------------------------
-- AXI-S Slave Input (Pentek PDTI Type) I and Q Single 16-bit sample format 
----------------------------------------------------------------------------

axis_aclk          : in  std_logic;
axis_aresetn       : in  std_logic;

-- Only compatible with PDTI format
-- tuser[71:64]    = Gate  
s_axis_pdti_tdata  : in  std_logic_vector((num_bytes*8)-1 downto 0);
s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
s_axis_pdti_tvalid : in  std_logic;
----------------------------------------------------------------------------
-- AXI-S Master Output (Pentek PDTI Type) I and Q Single 16-bit sample format 
----------------------------------------------------------------------------
-- Only compatible with PDTI format when data
-- tuser[71:64]    = Gate  
m_axis_pdti_tdata  : out  std_logic_vector((num_bytes*8)-1 downto 0);
m_axis_pdti_tuser  : out  std_logic_vector(127 downto 0);
m_axis_pdti_tvalid : out  std_logic
-------------------------------------
);
end px_axispdti_gatesub;

architecture Behavioral of px_axispdti_gatesub is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti:m_axis_pdti, ASSOCIATED_RESET axis_aresetn";

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

type axi_state_type is
(
    RESET_STATE,
    WR_ADDR_DATA_STATE,
    WR_DATA_STATE,
    WR_ADDR2_STATE,
    WR_ADDR_STATE,
    WR_DATA2_STATE,
    WR_ADDR_DEC_STATE,
    WR_B_RSP_STATE,
    RD_ADDR_STATE,
    WAIT_RD_BS_STATE,
    WAIT_RDDATA_RDY_STATE
);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal axi_state        : axi_state_type := RESET_STATE;
signal sel_reg          : std_logic_vector(1 downto 0)  := (others => '0');
signal t1_sel_reg       : std_logic_vector(1 downto 0)  := (others => '0');
signal t2_sel_reg       : std_logic_vector(1 downto 0)  := (others => '0');
signal rd_data          : std_logic_vector(1 downto 0)  := (others => '0');
signal w_data           : std_logic_vector(1 downto 0)  := (others => '0');
signal w_strb           : std_logic := '0';
signal sel_regx         : std_logic_vector(1 downto 0)  := (others => '0');
signal src_senda        : std_logic:= '0';
signal src_rcva         : std_logic:= '0';
signal dest_reqa        : std_logic:= '0';
signal t1_s_axi_csr_aresetn: std_logic:= '0';
-------------------------------------------------------------------------------

begin

-------------------------------------------------------------------------------
-- AXI4-Lite Interface State Machine
-------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        if t1_s_axi_csr_aresetn = '0' then
           axi_state           <= RESET_STATE;
           s_axi_csr_awready   <= '0'; 
           s_axi_csr_wready    <= '0';  
           s_axi_csr_arready   <= '0'; 
           s_axi_csr_rvalid    <= '0';  
           s_axi_csr_bvalid    <= '0';
           sel_reg             <= (others => '0');
        else 
           case axi_state is 
            when RESET_STATE =>
                if (t1_s_axi_csr_aresetn = '0') then
                    axi_state           <= RESET_STATE;
                    s_axi_csr_awready   <= '0';
                    s_axi_csr_wready    <= '0';
                    s_axi_csr_arready   <= '0'; 
                    s_axi_csr_rvalid    <= '0';  
                    s_axi_csr_bvalid    <= '0';
                    sel_reg             <= (others => '0');
                elsif (s_axi_csr_awvalid = '1') then  
                    if (s_axi_csr_wvalid = '1') then
                        axi_state <=  WR_ADDR_DATA_STATE;
                    else
                        axi_state <=  WR_ADDR_STATE;
                    end if; 
                elsif (s_axi_csr_wvalid = '1') then
                    axi_state <=  WR_DATA_STATE;
                elsif (s_axi_csr_arvalid = '1') then
                    axi_state <=  RD_ADDR_STATE;
                else
                    axi_state <= RESET_STATE;
                end if;    
             when WR_ADDR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                s_axi_csr_awready <= '1';       
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata(1 downto 0);
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata(1 downto 0);
                axi_state         <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_csr_wready     <= '0';
                if (s_axi_csr_awvalid = '1') then      
                   axi_state  <= WR_ADDR_DEC_STATE;
                   s_axi_csr_awready <= '1';
                else
                   axi_state         <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   s_axi_csr_awready <= '1';
                   axi_state     <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                s_axi_csr_awready <= '0';
                if (s_axi_csr_wvalid = '1') then      
                   axi_state        <= WR_ADDR_DEC_STATE;
                   s_axi_csr_wready <= '1';
                   w_strb            <= s_axi_csr_wstrb(0);
                   w_data           <= s_axi_csr_wdata(1 downto 0);
                else
                   axi_state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';   
                if w_strb = '1' then   
                  sel_reg           <= w_data;
                end if;                     
                axi_state         <= WR_B_RSP_STATE;
                s_axi_csr_bresp   <= "00";
                s_axi_csr_bvalid  <= '1';     
            when  WR_B_RSP_STATE =>
                if s_axi_csr_bready = '1' then
                    s_axi_csr_bvalid <= '0';
                    axi_state <= RESET_STATE;
                else
                    axi_state <= WR_B_RSP_STATE;
                end if;    
            when  RD_ADDR_STATE =>
               s_axi_csr_arready <= '1';
               rd_data     <= sel_reg; 
               axi_state   <= WAIT_RD_BS_STATE;
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rdata(1 downto 0) <= rd_data;
                s_axi_csr_rvalid  <= '1'; 
                s_axi_csr_rresp   <= "00";
                axi_state         <= WAIT_RDDATA_RDY_STATE;              
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_csr_rready = '1' then
                   s_axi_csr_rvalid <= '0';
                   axi_state        <= RESET_STATE;
                else
                   axi_state        <= WAIT_RDDATA_RDY_STATE;     
                end if;  
            when others =>
               axi_state <= RESET_STATE;
          end case;
       end if;
   end if;  
end process;

s_axi_csr_rdata(31 downto 2) <= x"0000000" & "00";

--------------------------------------------------------------------------------
-- Clock Boundary Crossing
--------------------------------------------------------------------------------

ctl_xclk:  xpm_cdc_handshake
generic map (
  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 2 -- integer; range: 1-1024
)
port map (
  src_clk    => s_axi_csr_aclk,
  src_in     => sel_reg,
  src_send   => src_senda,
  src_rcv    => src_rcva,
  dest_clk   => axis_aclk,
  dest_req   => dest_reqa,
  dest_ack   => dest_reqa, 
  dest_out   => sel_regx
);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcva = '1') then
       src_senda <= '0';
     elsif (src_rcva = '0') and (src_senda = '0') then
       src_senda <= '1';
     end if;  
   end if;
end process;

--------------------------------------------------------------------------------
-- Output Gate Substitution Multiplexer
--------------------------------------------------------------------------------

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        t1_sel_reg <= sel_regx;
        t2_sel_reg <= t1_sel_reg;
        case t2_sel_reg is
            when "00" => -- Normal Gate Signal Passed Through
                m_axis_pdti_tuser(num_gate_bits+63 downto 64)  <= s_axis_pdti_tuser(num_gate_bits+63 downto 64);
            when "01" => -- Threshold Detect Gate Only
                m_axis_pdti_tuser(num_gate_bits+63 downto 64)  <= gate_in;
            when "10" => -- Threshold Detect Gate anded with Normal Gate
                m_axis_pdti_tuser(num_gate_bits+63 downto 64)  <= gate_in and s_axis_pdti_tuser(num_gate_bits+63 downto 64);  
            when "11" => -- Threshold Detect Gate anded with Normal Gate
                m_axis_pdti_tuser(num_gate_bits+63 downto 64)  <= gate_in and s_axis_pdti_tuser(num_gate_bits+63 downto 64);  
            when others =>
                m_axis_pdti_tuser(num_gate_bits+63 downto 64)  <= s_axis_pdti_tuser(num_gate_bits+63 downto 64);      
        end case;  
        m_axis_pdti_tuser(127 downto 72) <= s_axis_pdti_tuser(127 downto 72);
        if (num_gate_bits = 1) then
           m_axis_pdti_tuser(71 downto 65) <= s_axis_pdti_tuser(71 downto 65); 
        elsif (num_gate_bits = 2) then
           m_axis_pdti_tuser(71 downto 66) <= s_axis_pdti_tuser(71 downto 66);
        elsif (num_gate_bits = 4) then
           m_axis_pdti_tuser(71 downto 68) <= s_axis_pdti_tuser(71 downto 68);
        end if;    
        m_axis_pdti_tuser(63 downto 0)   <= s_axis_pdti_tuser(63 downto 0); 
        m_axis_pdti_tdata                <= s_axis_pdti_tdata;
        m_axis_pdti_tvalid               <= s_axis_pdti_tvalid; 
    end if;
end process;


end Behavioral;
