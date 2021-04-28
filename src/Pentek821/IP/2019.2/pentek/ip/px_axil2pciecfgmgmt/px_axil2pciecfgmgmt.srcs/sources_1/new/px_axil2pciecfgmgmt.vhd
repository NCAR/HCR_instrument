----------------------------------------------------------------------------------
-- Pentek AXI4-LITE to UltraScale PCIE Core CFG_MGMT bus
----------------------------------------------------------------------------------
-- px_axil2pciecfgmgmt.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2015
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 
--  

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2015 Pentek, Inc. All rights reserved.
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

entity px_axil2pciecfgmgmt is
generic (
   axi_addr_bits : integer := 12 -- If less than 21, the upper CFG_MGMT address bits will be set to zero
   -- and only the smaller address space will be accessible.
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
    ----------------------------------------------------------------------------
    -- configuration space interface
    ----------------------------------------------------------------------------
    -- uses s_axi_aclk
    cfg_mgmt_addr        : out std_logic_vector (18 downto 0); -- dword address
    cfg_mgmt_read_data   : in  std_logic_vector (31 downto 0);
    cfg_mgmt_write       : out std_logic;
    cfg_mgmt_read        : out std_logic;
    cfg_mgmt_read_write_done  : in  std_logic;
    cfg_mgmt_write_data  : out std_logic_vector (31 downto 0);
    cfg_mgmt_byte_enable : out std_logic_vector (3 downto 0);
    cfg_mgmt_type1_cfg_reg_access  : out std_logic
);
end px_axil2pciecfgmgmt;

architecture Behavioral of px_axil2pciecfgmgmt is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_aresetn";

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
signal w_data : std_logic_vector(31 downto 0) := (others => '0');
signal w_addr : std_logic_vector(18 downto 0) := (others => '0');

signal timeout_cntr: std_logic_vector(7 downto 0):= (others => '0');

--------------------------------------------------------------------------------

begin

cfg_mgmt_type1_cfg_reg_access <= '0';
cfg_mgmt_byte_enable    <= "1111";


process(s_axi_aclk)
begin
    if rising_edge(s_axi_aclk) then
        if s_axi_aresetn = '0' then
           state            <= RESET_STATE;
           s_axi_awready    <= '0'; 
           s_axi_wready     <= '0';  
           s_axi_arready    <= '0'; 
           s_axi_rvalid     <= '0';  
           s_axi_bvalid     <= '0';
           cfg_mgmt_write   <= '0';
           cfg_mgmt_read    <= '0';
           timeout_cntr     <= x"00";
           w_addr           <= (others => '0'); 
           cfg_mgmt_addr    <= (others => '0'); 
        else 
           case state is 
            when RESET_STATE =>
                timeout_cntr     <= x"00";
                w_addr           <= (others => '0');
                cfg_mgmt_addr    <= (others => '0');  
                if (s_axi_aresetn = '0') then
                    state <= RESET_STATE;
                    s_axi_awready  <= '0';
                    s_axi_wready   <= '0';
                    s_axi_arready  <= '0'; 
                    s_axi_rvalid   <= '0';  
                    s_axi_bvalid   <= '0';
                    cfg_mgmt_write <= '0';
                    cfg_mgmt_read  <= '0';     
                elsif (s_axi_awvalid = '1') then  
                    if (s_axi_wvalid = '1') then
                        state <=  WR_ADDR_DATA_STATE;
                    else
                        state <=  WR_ADDR_STATE;
                    end if; 
                elsif (s_axi_wvalid = '1') then
                    state <=  WR_DATA_STATE;
                elsif (s_axi_arvalid = '1') then
                    state <=  RD_ADDR_STATE;
                else
                    state <= RESET_STATE;
                end if;    
             when WR_ADDR_DATA_STATE =>
                s_axi_wready   <= '1';
                s_axi_awready  <= '1';       
                w_data         <= s_axi_wdata;
                w_addr(axi_addr_bits-3 downto 0)   <= s_axi_awaddr(axi_addr_bits-1 downto 2);
                state          <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_wready   <= '1';
                w_data         <= s_axi_wdata;
                state          <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_wready   <= '0';
                if (s_axi_awvalid = '1') then      
                   state         <= WR_ADDR_DEC_STATE;
                   s_axi_awready <= '1';
                   w_addr(axi_addr_bits-3 downto 0) <= s_axi_awaddr(axi_addr_bits-1 downto 2);
                else
                   state         <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   s_axi_awready <= '1';
                   w_addr(axi_addr_bits-3 downto 0) <= s_axi_awaddr(axi_addr_bits-1 downto 2);
                   state         <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                s_axi_awready    <= '0';
                if (s_axi_wvalid = '1') then      
                   state         <= WR_ADDR_DEC_STATE;
                   s_axi_wready  <= '1';
                   w_data        <= s_axi_wdata;
                else
                   state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_wready        <= '0';
                s_axi_awready       <= '0';   
                cfg_mgmt_write_data <= w_data;
                cfg_mgmt_addr       <= w_addr;
                cfg_mgmt_write      <= '1';
                cfg_mgmt_read       <= '0';
                state               <= WR_STATE;
             when WR_STATE =>
                if (timeout_cntr = x"FF") then
                   cfg_mgmt_write <= '0';
                   s_axi_bresp    <= "10";
                   s_axi_bvalid   <= '1';
                   state          <= WR_B_RSP_STATE;
                elsif (cfg_mgmt_read_write_done = '1') then -- Is Write Complete ?
                   cfg_mgmt_write <= '0';
                   s_axi_bresp    <= "00";
                   s_axi_bvalid   <= '1';
                   state          <= WR_B_RSP_STATE;
                else
                   state          <= WR_STATE;
                   timeout_cntr   <= timeout_cntr+1;
                end if;
            when  WR_B_RSP_STATE =>
                if s_axi_bready = '1' then
                    s_axi_bvalid  <= '0';
                    state         <= RESET_STATE;
                else
                    state         <= WR_B_RSP_STATE;
                end if;    
            when  RD_ADDR_STATE =>
               s_axi_arready      <= '1';
               cfg_mgmt_addr(axi_addr_bits-3 downto 0)  <= s_axi_araddr(axi_addr_bits-1 downto 2);
               cfg_mgmt_write     <= '0';
               cfg_mgmt_read      <= '1';
               state              <= RD_STATE;
            when RD_STATE =>
               s_axi_arready <= '0';
               if (timeout_cntr = x"FF") then
                  cfg_mgmt_read  <= '0';
                  s_axi_rdata    <= cfg_mgmt_read_data;
                  s_axi_rvalid   <= '1';
                  s_axi_rresp    <= "10";
                  state          <= WAIT_RDDATA_RDY_STATE; 
               elsif (cfg_mgmt_read_write_done = '1') then
                  cfg_mgmt_read  <= '0';
                  s_axi_rdata    <= cfg_mgmt_read_data;
                  s_axi_rvalid   <= '1';
                  s_axi_rresp    <= "00"; 
                  state          <= WAIT_RDDATA_RDY_STATE;    
               else
                  state          <= RD_STATE;
                  timeout_cntr   <= timeout_cntr+1;
               end if;                  
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_rready = '1' then
                    s_axi_rvalid <= '0';
                    state        <= RESET_STATE;
                else
                   state         <= WAIT_RDDATA_RDY_STATE;     
                end if;  
            when others =>
               state <= RESET_STATE;
          end case;
       end if;
   end if;  
end process;


end Behavioral;
