----------------------------------------------------------------------------------
-- Company: Pent
-- Engineer: 
-- 
-- Create Date: 01/28/2017 10:45:34 AM
-- Design Name: 
-- Module Name: px_axil_2_drp - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Bridge from AXI-Lite to DRP port
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
-- Unused AXI input address bits not used by the DRP address output are ignored.

----------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------

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

entity px_axil_2_drp is
generic (
   axi_addr_bits : integer := 12; -- up to 32
   drp_bytes     : integer := 2; -- 2 or 4
   drp_addr_bits : integer := 10 -- up to 30
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
    s_axi_aclk      : in  std_logic;
    s_axi_aresetn   : in  std_logic;
    s_axi_awaddr    : in  std_logic_vector(axi_addr_bits-1 downto 0); -- byte address
    s_axi_awprot    : in  std_logic_vector(2 downto 0); -- not used
    s_axi_awvalid   : in  std_logic;
    s_axi_awready   : out std_logic;
    s_axi_wdata     : in  std_logic_vector(31 downto 0);
    s_axi_wstrb     : in  std_logic_vector(3 downto 0); -- not used
    s_axi_wvalid    : in  std_logic;
    s_axi_wready    : out std_logic;
    s_axi_bresp     : out std_logic_vector(1 downto 0);
    s_axi_bvalid    : out std_logic;
    s_axi_bready    : in  std_logic;
    s_axi_araddr    : in  std_logic_vector(axi_addr_bits-1 downto 0);
    s_axi_arprot    : in  std_logic_vector(2 downto 0); -- not used
    s_axi_arvalid   : in  std_logic;
    s_axi_arready   : out std_logic;
    s_axi_rdata     : out std_logic_vector(31 downto 0);
    s_axi_rresp     : out std_logic_vector(1 downto 0);
    s_axi_rvalid    : out std_logic;
    s_axi_rready    : in  std_logic;
--------------------------------------------------------------------------------
-- DRP Port 
--------------------------------------------------------------------------------   
    drpclk          : in  std_logic;
    drpaddr         : out std_logic_vector(drp_addr_bits-1 downto 0);
    drpdi           : out std_logic_vector((drp_bytes*8)-1 downto 0);
    drpen           : out std_logic;
    drpwe           : out std_logic;
    drpdo           : in  std_logic_vector((drp_bytes*8)-1 downto 0);
    drprdy          : in  std_logic 
);
end px_axil_2_drp;

architecture Behavioral of px_axil_2_drp is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_aresetn";
ATTRIBUTE X_INTERFACE_INFO of drpclk: SIGNAL is "xilinx.com:signal:clock:1.0 drpclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of drpclk: SIGNAL is "ASSOCIATED_BUSIF drp";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- AXI-Lite Clock Converter
COMPONENT px_axil_2_drp_clkcnv
  PORT (
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC;
    s_axi_awready : OUT STD_LOGIC;
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC;
    s_axi_wready : OUT STD_LOGIC;
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC;
    s_axi_bready : IN STD_LOGIC;
    s_axi_araddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC;
    m_axi_aclk : IN STD_LOGIC;
    m_axi_aresetn : IN STD_LOGIC;
    m_axi_awaddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_awvalid : OUT STD_LOGIC;
    m_axi_awready : IN STD_LOGIC;
    m_axi_wdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_wstrb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_wvalid : OUT STD_LOGIC;
    m_axi_wready : IN STD_LOGIC;
    m_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_bvalid : IN STD_LOGIC;
    m_axi_bready : OUT STD_LOGIC;
    m_axi_araddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_arvalid : OUT STD_LOGIC;
    m_axi_arready : IN STD_LOGIC;
    m_axi_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_rvalid : IN STD_LOGIC;
    m_axi_rready : OUT STD_LOGIC
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type state_type is
(
    RESET_STATE,
    WR_ADDR_DATA_STATE,
    WR_DATA_STATE,
    WR_ADDR2_STATE,
    WR_ADDR_STATE,
    WR_DATA2_STATE,
    WR_ADDR_DEC_STATE,
    WR_STATE,
    WR_B_RSP_STATE,
    RD_ADDR_STATE,
    RD_STATE,
    WAIT_RDDATA_RDY_STATE
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal state  : state_type := RESET_STATE;
signal w_data : std_logic_vector((drp_bytes*8)-1 downto 0) := (others => '0');
signal w_addr : std_logic_vector(axi_addr_bits-3 downto 0) := (others => '0');

signal s_axi_cc_awaddr :  std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_cc_araddr :  std_logic_vector(31 downto 0) := (others => '0');
signal axi_cc_aresetn : std_logic := '0';
signal axi_cc_awaddr :  std_logic_vector(31 downto 0) := (others => '0');
signal axi_cc_awprot :  std_logic_vector(2 downto 0) := (others => '0');
signal axi_cc_awvalid :  std_logic := '0';
signal axi_cc_awready :  std_logic := '0';
signal axi_cc_wdata :  std_logic_vector(31 downto 0) := (others => '0');
signal axi_cc_wstrb :  std_logic_vector(3 downto 0) := (others => '0');
signal axi_cc_wvalid :  std_logic := '0';
signal axi_cc_wready : std_logic := '0';
signal axi_cc_bresp :  std_logic_vector(1 downto 0) := (others => '0');
signal axi_cc_bvalid :  std_logic := '0';
signal axi_cc_bready :  std_logic := '0';
signal axi_cc_araddr :  std_logic_vector(31 downto 0) := (others => '0');
signal axi_cc_arprot :  std_logic_vector(2 downto 0) := (others => '0');
signal axi_cc_arvalid :  std_logic := '0';
signal axi_cc_arready :  std_logic := '0';
signal axi_cc_rdata :  std_logic_vector(31 downto 0) := (others => '0');
signal axi_cc_rresp :  std_logic_vector(1 downto 0) := (others => '0');
signal axi_cc_rvalid :  std_logic := '0';
signal axi_cc_rready :  std_logic := '0';
signal t1_s_axi_aresetn :  std_logic := '0';

signal timeout_cntr: std_logic_vector(7 downto 0):= (others => '0');

--------------------------------------------------------------------------------
begin

process(s_axi_aclk) 
begin
   if rising_edge(s_axi_aclk) then
      t1_s_axi_aresetn <= s_axi_aresetn;
   end if;
end process;

rst_cdc_inst: xpm_cdc_sync_rst
generic map (

   -- Common module parameters
   DEST_SYNC_FF    => 3, -- integer; range: 2-10
   INIT            => 0, -- integer; 0=initialize synchronization registers to 0,
                         --          1=initialize synchronization registers to 1
   SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
   src_rst  => t1_s_axi_aresetn,
   dest_clk => drpclk,
   dest_rst => axi_cc_aresetn
);

gen_addru: if (axi_addr_bits < 32) generate

s_axi_cc_awaddr(31 downto axi_addr_bits) <= (others => '0'); 
s_axi_cc_araddr(31 downto axi_addr_bits) <= (others => '0'); 

end generate;

s_axi_cc_awaddr(axi_addr_bits-1 downto 0) <= s_axi_awaddr;
s_axi_cc_araddr(axi_addr_bits-1 downto 0) <= s_axi_araddr;

axi_cc_inst : px_axil_2_drp_clkcnv
port map (
    s_axi_aclk       => s_axi_aclk,
    s_axi_aresetn    => t1_s_axi_aresetn,
    s_axi_awaddr     => s_axi_cc_awaddr,
    s_axi_awprot     => s_axi_awprot,
    s_axi_awvalid    => s_axi_awvalid,
    s_axi_awready    => s_axi_awready,
    s_axi_wdata      => s_axi_wdata,
    s_axi_wstrb      => s_axi_wstrb,
    s_axi_wvalid     => s_axi_wvalid,
    s_axi_wready     => s_axi_wready,
    s_axi_bresp      => s_axi_bresp,
    s_axi_bvalid     => s_axi_bvalid,
    s_axi_bready     => s_axi_bready,
    s_axi_araddr     => s_axi_cc_araddr,
    s_axi_arprot     => s_axi_arprot,
    s_axi_arvalid    => s_axi_arvalid,
    s_axi_arready    => s_axi_arready,
    s_axi_rdata      => s_axi_rdata,
    s_axi_rresp      => s_axi_rresp,
    s_axi_rvalid     => s_axi_rvalid,
    s_axi_rready     => s_axi_rready,
    m_axi_aclk       => drpclk,
    m_axi_aresetn    => axi_cc_aresetn,
    m_axi_awaddr     => axi_cc_awaddr,
    m_axi_awprot     => axi_cc_awprot,
    m_axi_awvalid    => axi_cc_awvalid,
    m_axi_awready    => axi_cc_awready,
    m_axi_wdata      => axi_cc_wdata,
    m_axi_wstrb      => axi_cc_wstrb,
    m_axi_wvalid     => axi_cc_wvalid,
    m_axi_wready     => axi_cc_wready,
    m_axi_bresp      => axi_cc_bresp,
    m_axi_bvalid     => axi_cc_bvalid,
    m_axi_bready     => axi_cc_bready,
    m_axi_araddr     => axi_cc_araddr,
    m_axi_arprot     => axi_cc_arprot,
    m_axi_arvalid    => axi_cc_arvalid,
    m_axi_arready    => axi_cc_arready,
    m_axi_rdata      => axi_cc_rdata,
    m_axi_rresp      => axi_cc_rresp,
    m_axi_rvalid     => axi_cc_rvalid,
    m_axi_rready     => axi_cc_rready
  );

process(drpclk)
begin
    if rising_edge(drpclk) then
        if axi_cc_aresetn = '0' then
           state            <= RESET_STATE;
           axi_cc_awready   <= '0'; 
           axi_cc_wready    <= '0';  
           axi_cc_arready   <= '0'; 
           axi_cc_rvalid    <= '0';  
           axi_cc_bvalid    <= '0';
           axi_cc_rdata     <= (others => '0'); 
           drpen            <= '0';
           drpwe            <= '0';
           timeout_cntr     <= x"00";
           w_addr           <= (others => '0'); 
           drpaddr          <= (others => '0'); 
        else 
           case state is 
            when RESET_STATE =>
                timeout_cntr      <= x"00";
                w_addr            <= (others => '0');
                drpaddr           <= (others => '0');
                axi_cc_rdata      <= (others => '0');   
                if (axi_cc_aresetn = '0') then
                    state <= RESET_STATE;
                    axi_cc_awready  <= '0';
                    axi_cc_wready   <= '0';
                    axi_cc_arready  <= '0'; 
                    axi_cc_rvalid   <= '0';  
                    axi_cc_bvalid   <= '0';
                    drpen           <= '0';
                    drpwe           <= '0';     
                elsif (axi_cc_awvalid = '1') then  
                    if (axi_cc_wvalid = '1') then
                        state <=  WR_ADDR_DATA_STATE;
                    else
                        state <=  WR_ADDR_STATE;
                    end if; 
                elsif (axi_cc_wvalid = '1') then
                    state <=  WR_DATA_STATE;
                elsif (axi_cc_arvalid = '1') then
                    state <=  RD_ADDR_STATE;
                else
                    state <= RESET_STATE;
                end if;    
             when WR_ADDR_DATA_STATE =>
                axi_cc_wready   <= '1';
                axi_cc_awready  <= '1';       
                w_data          <= axi_cc_wdata((drp_bytes*8)-1 downto 0);
                w_addr(axi_addr_bits-3 downto 0)   <= axi_cc_awaddr(axi_addr_bits-1 downto 2);
                state           <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                axi_cc_wready   <= '1';
                w_data          <= axi_cc_wdata((drp_bytes*8)-1 downto 0);
                state           <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                axi_cc_wready   <= '0';
                if (axi_cc_awvalid = '1') then      
                   state          <= WR_ADDR_DEC_STATE;
                   axi_cc_awready <= '1';
                   w_addr(axi_addr_bits-3 downto 0) <= axi_cc_awaddr(axi_addr_bits-1 downto 2);
                else
                   state        <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   axi_cc_awready <= '1';
                   w_addr(axi_addr_bits-3 downto 0) <= axi_cc_awaddr(axi_addr_bits-1 downto 2);
                   state        <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                axi_cc_awready  <= '0';
                if (axi_cc_wvalid = '1') then      
                   state          <= WR_ADDR_DEC_STATE;
                   axi_cc_wready  <= '1';
                   w_data         <= axi_cc_wdata((drp_bytes*8)-1 downto 0);
                else
                   state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                axi_cc_wready     <= '0';
                axi_cc_awready    <= '0';   
                drpdi             <= w_data;
                drpaddr           <= w_addr(drp_addr_bits-1 downto 0);
                drpwe             <= '1';
                drpen             <= '1';
                state             <= WR_STATE;
             when WR_STATE =>
                if (timeout_cntr = x"FF") then
                   axi_cc_bresp   <= "10";
                   axi_cc_bvalid  <= '1';
                   state          <= WR_B_RSP_STATE;
                elsif (drprdy = '1') then -- Is Write Complete ?
                   drpwe          <= '0';
                   drpen          <= '0';
                   axi_cc_bresp   <= "00";
                   axi_cc_bvalid  <= '1';
                   state          <= WR_B_RSP_STATE;
                else
                   state          <= WR_STATE;
                   timeout_cntr   <= timeout_cntr+1;
                end if;
            when  WR_B_RSP_STATE =>
                if axi_cc_bready = '1' then
                    axi_cc_bvalid <= '0';
                    state         <= RESET_STATE;
                else
                    state         <= WR_B_RSP_STATE;
                end if;    
            when  RD_ADDR_STATE =>
               axi_cc_arready     <= '1';
               drpaddr            <= axi_cc_araddr(drp_addr_bits+1 downto 2);
               drpwe              <= '0';
               drpen              <= '1';
               state              <= RD_STATE;
            when RD_STATE =>
               axi_cc_arready <= '0';
               if (timeout_cntr = x"FF") then
                  axi_cc_rdata((drp_bytes*8)-1 downto 0)  <= drpdo;
                  axi_cc_rvalid   <= '1';
                  axi_cc_rresp    <= "10";
                  state           <= WAIT_RDDATA_RDY_STATE; 
               elsif (drprdy = '1') then
                  drpen           <= '0';
                  axi_cc_rdata((drp_bytes*8)-1 downto 0)  <= drpdo;
                  axi_cc_rvalid   <= '1';
                  axi_cc_rresp    <= "00"; 
                  state           <= WAIT_RDDATA_RDY_STATE;    
               else
                  state           <= RD_STATE;
                  timeout_cntr    <= timeout_cntr+1;
               end if;                  
            when WAIT_RDDATA_RDY_STATE =>   
                if axi_cc_rready = '1' then
                    axi_cc_rvalid <= '0';
                    state         <= RESET_STATE;
                else
                   state          <= WAIT_RDDATA_RDY_STATE;     
                end if;  
            when others =>
               state <= RESET_STATE;
          end case;
       end if;
   end if;  
end process;

end Behavioral;
