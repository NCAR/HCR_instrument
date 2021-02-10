----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2016 02:47:09 PM
-- Design Name: 
-- Module Name: px_axil_timeout_rst - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Creates a reset when activity times out on the AXI-Lite bus
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axil_timeout_rst is
generic (
   addr_bits     : integer := 12;
   timeout_count :integer := 2147483647
);
port ( 
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
   axi_aclk             : in  std_logic;
   s_axi_aresetn        : in  std_logic;
   s_axi_awaddr         : in  std_logic_vector(addr_bits-1 downto 0);
   s_axi_awprot         : in  std_logic_vector(2 downto 0);
   s_axi_awvalid        : in  std_logic;
   s_axi_awready        : out std_logic;
   s_axi_wdata          : in  std_logic_vector(31 downto 0);
   s_axi_wstrb          : in  std_logic_vector(3 downto 0);
   s_axi_wvalid         : in  std_logic;
   s_axi_wready         : out std_logic;
   s_axi_bresp          : out std_logic_vector(1 downto 0);
   s_axi_bvalid         : out std_logic;
   s_axi_bready         : in  std_logic;
   s_axi_araddr         : in  std_logic_vector(addr_bits-1 downto 0);
   s_axi_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_arvalid        : in  std_logic;
   s_axi_arready        : out std_logic;
   s_axi_rdata          : out std_logic_vector(31 downto 0);
   s_axi_rresp          : out std_logic_vector(1 downto 0);
   s_axi_rvalid         : out std_logic;
   s_axi_rready         : in  std_logic;

   m_axi_aresetn        : out std_logic;
   m_axi_awaddr         : out std_logic_vector(addr_bits-1 downto 0);
   m_axi_awprot         : out std_logic_vector(2 downto 0);
   m_axi_awvalid        : out std_logic;
   m_axi_awready        : in  std_logic;
   m_axi_wdata          : out std_logic_vector(31 downto 0);
   m_axi_wstrb          : out std_logic_vector(3 downto 0);
   m_axi_wvalid         : out std_logic;
   m_axi_wready         : in  std_logic;
   m_axi_bresp          : in  std_logic_vector(1 downto 0);
   m_axi_bvalid         : in  std_logic;
   m_axi_bready         : out std_logic;
   m_axi_araddr         : out std_logic_vector(addr_bits-1 downto 0);
   m_axi_arprot         : out std_logic_vector(2 downto 0);
   m_axi_arvalid        : out std_logic;
   m_axi_arready        : in  std_logic;
   m_axi_rdata          : in  std_logic_vector(31 downto 0);
   m_axi_rresp          : in  std_logic_vector(1 downto 0);
   m_axi_rvalid         : in  std_logic;
   m_axi_rready         : out std_logic

);
end px_axil_timeout_rst;

architecture Behavioral of px_axil_timeout_rst is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

COMPONENT px_axil_timeout_rst_rs
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
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
-- Signals
--------------------------------------------------------------------------------

signal awaddr : std_logic_vector(31 downto 0);                   
signal awprot : std_logic_vector(2 downto 0);                    
signal awvalid : std_logic;                                      
signal awready : std_logic;                                     
signal wdata : std_logic_vector(31 downto 0);                    
signal wstrb : std_logic_vector(3 downto 0);                     
signal wvalid : std_logic;                                       
signal wready : std_logic;                                      
signal bresp : std_logic_vector(1 downto 0);                    
signal bvalid : std_logic;                                      
signal bready : std_logic;                                       
signal araddr : std_logic_vector(31 downto 0);                   
signal arprot : std_logic_vector(2 downto 0);                    
signal arvalid : std_logic;                                      
signal arready : std_logic;                                     
signal rdata : std_logic_vector(31 downto 0);                   
signal rresp : std_logic_vector(1 downto 0);                    
signal rvalid : std_logic;                                      
signal rready : std_logic;                                       
signal t1_s_axi_aresetn: std_logic;
signal cnt_en: std_logic := '0';
signal cnt_en_w: std_logic := '0';
signal cnt_en_r: std_logic := '0';
signal to_cntr: std_logic_vector(31 downto 0) := x"00000000"; 
signal rst: std_logic := '0';
signal s_axi_awaddr_x : std_logic_vector(31 downto 0):= x"00000000";
signal s_axi_araddr_x : std_logic_vector(31 downto 0):= x"00000000";
signal m_axi_awaddr_x : std_logic_vector(31 downto 0):= x"00000000";
signal m_axi_araddr_x : std_logic_vector(31 downto 0):= x"00000000";
signal re_awvalid: std_logic := '0';
signal re_arvalid: std_logic := '0';
signal t1_awvalid: std_logic := '0';
signal t1_arvalid: std_logic := '0';
signal t1_rst: std_logic := '0';
signal fe_rst: std_logic := '0';
--------------------------------------------------------------------------------

begin

cnt_en     <= cnt_en_w or cnt_en_r;
re_awvalid <= (awvalid or wvalid) and not t1_awvalid;
re_arvalid <= arvalid and not t1_arvalid;

process(axi_aclk)
begin
   if rising_edge(axi_aclk) then
      t1_awvalid <= awvalid or wvalid;
      t1_arvalid <= arvalid;
      t1_rst <= rst;
      fe_rst <= t1_rst and not rst;
      if ((bready = '1') and (bvalid = '1')) or (t1_s_axi_aresetn = '0') or (fe_rst = '1') then
         cnt_en_w <= '0'; 
      elsif re_awvalid = '1' then
         cnt_en_w <= '1';
      end if;  
      if ((rvalid = '1') and (rready = '1')) or (t1_s_axi_aresetn = '0')  or (fe_rst = '1') then
         cnt_en_r <= '0'; 
      elsif re_arvalid = '1' then
         cnt_en_r <= '1';
      end if;    
      t1_s_axi_aresetn <= s_axi_aresetn;
      if (cnt_en = '0') or (t1_s_axi_aresetn = '0') then
         to_cntr <= conv_std_logic_vector(timeout_count, 32);
      else
         to_cntr <= to_cntr - 1;
      end if;   
      if (cnt_en = '0') or (t1_s_axi_aresetn = '0') then
         rst <= '0';
      elsif to_cntr < x"00000004" then
         rst <= '1';
      else
         rst <= '0';
      end if;
      --m_axi_aresetn <= not ((not t1_s_axi_aresetn) or rst);
      m_axi_aresetn <= not rst;
   end if;
end process;

s_axi_awaddr_x(addr_bits -1 downto 0) <= s_axi_awaddr;
s_axi_araddr_x(addr_bits -1 downto 0) <= s_axi_araddr;

-- Register Slices
in_rs : px_axil_timeout_rst_rs
  PORT MAP (
    aclk => axi_aclk,
    aresetn => t1_s_axi_aresetn,
    s_axi_awaddr => s_axi_awaddr_x,
    s_axi_awprot => s_axi_awprot,
    s_axi_awvalid => s_axi_awvalid,
    s_axi_awready => s_axi_awready,
    s_axi_wdata => s_axi_wdata,
    s_axi_wstrb => s_axi_wstrb,
    s_axi_wvalid => s_axi_wvalid,
    s_axi_wready => s_axi_wready,
    s_axi_bresp => s_axi_bresp,
    s_axi_bvalid => s_axi_bvalid,
    s_axi_bready => s_axi_bready,
    s_axi_araddr => s_axi_araddr_x,
    s_axi_arprot => s_axi_arprot,
    s_axi_arvalid => s_axi_arvalid,
    s_axi_arready => s_axi_arready,
    s_axi_rdata => s_axi_rdata,
    s_axi_rresp => s_axi_rresp,
    s_axi_rvalid => s_axi_rvalid,
    s_axi_rready => s_axi_rready,
    m_axi_awaddr => awaddr,
    m_axi_awprot => awprot,
    m_axi_awvalid => awvalid,
    m_axi_awready => awready,
    m_axi_wdata => wdata,
    m_axi_wstrb => wstrb,
    m_axi_wvalid => wvalid,
    m_axi_wready => wready,
    m_axi_bresp => bresp,
    m_axi_bvalid => bvalid,
    m_axi_bready => bready,
    m_axi_araddr => araddr,
    m_axi_arprot => arprot,
    m_axi_arvalid => arvalid,
    m_axi_arready => arready,
    m_axi_rdata => rdata,
    m_axi_rresp => rresp,
    m_axi_rvalid => rvalid,
    m_axi_rready => rready
  );
  
out_rs : px_axil_timeout_rst_rs
    PORT MAP (
      aclk => axi_aclk,
      aresetn => t1_s_axi_aresetn,
      s_axi_awaddr => awaddr,
      s_axi_awprot => awprot,
      s_axi_awvalid => awvalid,
      s_axi_awready => awready,
      s_axi_wdata => wdata,
      s_axi_wstrb => wstrb,
      s_axi_wvalid => wvalid,
      s_axi_wready => wready,
      s_axi_bresp => bresp,
      s_axi_bvalid => bvalid,
      s_axi_bready => bready,
      s_axi_araddr => araddr,
      s_axi_arprot => arprot,
      s_axi_arvalid => arvalid,
      s_axi_arready => arready,
      s_axi_rdata => rdata,
      s_axi_rresp => rresp,
      s_axi_rvalid => rvalid,
      s_axi_rready => rready,
      m_axi_awaddr => m_axi_awaddr_x,
      m_axi_awprot => m_axi_awprot,
      m_axi_awvalid => m_axi_awvalid,
      m_axi_awready => m_axi_awready,
      m_axi_wdata => m_axi_wdata,
      m_axi_wstrb => m_axi_wstrb,
      m_axi_wvalid => m_axi_wvalid,
      m_axi_wready => m_axi_wready,
      m_axi_bresp => m_axi_bresp,
      m_axi_bvalid => m_axi_bvalid,
      m_axi_bready => m_axi_bready,
      m_axi_araddr => m_axi_araddr_x,
      m_axi_arprot => m_axi_arprot,
      m_axi_arvalid => m_axi_arvalid,
      m_axi_arready => m_axi_arready,
      m_axi_rdata => m_axi_rdata,
      m_axi_rresp => m_axi_rresp,
      m_axi_rvalid => m_axi_rvalid,
      m_axi_rready => m_axi_rready
    );
    

    m_axi_awaddr <= m_axi_awaddr_x(addr_bits -1 downto 0);
    m_axi_araddr <= m_axi_araddr_x(addr_bits -1 downto 0);

end Behavioral;
