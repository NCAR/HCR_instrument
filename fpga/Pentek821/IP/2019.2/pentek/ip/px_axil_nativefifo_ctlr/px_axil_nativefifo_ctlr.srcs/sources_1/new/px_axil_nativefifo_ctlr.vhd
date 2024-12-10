----------------------------------------------------------------------------------
-- Pentek AXI-Lite Native FIFO Controller
----------------------------------------------------------------------------------
-- px_axil_nativefifo_ctlr.vhd
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
-- Does not pay attention to FIFO Flags. It is your responsibility to only
-- read or write when the FIFO is ready.

-- Access Address 0x00 - FIFO read or Write
-- Access Address 0x04 - FIFO Flag Status Read
   -- Bit 0 = Read FIFO Empty
   -- Bit 1 = Wrote FIFO Full  
   
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


entity px_axil_nativefifo_ctlr is
generic (
   number_fifo_data_bits : integer := 32; -- (1 to 32)
   has_fifo_read_intrfc  : boolean := true;  -- Used only by ip packager
   has_fifo_write_intrfc : boolean := true;  -- Used only by ip packager
   read_latency          : integer := 0    -- Latency of Read in FIFO( 0 or 1) 
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_aclk          : in  std_logic;
   s_axi_aresetn       : in  std_logic;
   s_axi_awaddr        : in  std_logic_vector(2 downto 0);
   s_axi_awprot        : in  std_logic_vector(2 downto 0); -- not used
   s_axi_awvalid       : in  std_logic;
   s_axi_awready       : out std_logic;
   s_axi_wdata         : in  std_logic_vector(31 downto 0);
   s_axi_wstrb         : in  std_logic_vector(3 downto 0); 
   s_axi_wvalid        : in  std_logic;
   s_axi_wready        : out std_logic;
   s_axi_bresp         : out std_logic_vector(1 downto 0);
   s_axi_bvalid        : out std_logic;
   s_axi_bready        : in  std_logic;
   s_axi_araddr        : in  std_logic_vector(2 downto 0);
   s_axi_arprot        : in  std_logic_vector(2 downto 0); -- not used
   s_axi_arvalid       : in  std_logic;
   s_axi_arready       : out std_logic;
   s_axi_rdata         : out std_logic_vector(31 downto 0);
   s_axi_rresp         : out std_logic_vector(1 downto 0);
   s_axi_rvalid        : out std_logic;
   s_axi_rready        : in  std_logic;
--------------------------------------------------------------------------------
-- FIFO Interface
-------------------------------------------------------------------------------- 
   fifo_rst            : out std_logic;
   fifo_clk            : out std_logic;
   -- FIFO Write Port
   fifo_wr_en          : out std_logic;
   fifo_din            : out std_logic_vector(number_fifo_data_bits-1 downto 0);
   fifo_full           : in  std_logic; -- not used at this time
   -- FIFO Read Port
   fifo_rd_en          : out std_logic;
   fifo_dout           : in  std_logic_vector(number_fifo_data_bits-1 downto 0);
   fifo_empty          : in  std_logic -- not used at this time

);
end px_axil_nativefifo_ctlr;


architecture Behavioral of px_axil_nativefifo_ctlr is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_aresetn";

ATTRIBUTE X_INTERFACE_INFO of fifo_clk: SIGNAL is "xilinx.com:signal:clock:1.0 fifo_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of fifo_clk: SIGNAL is "ASSOCIATED_BUSIF fifo_read:fifo_write, ASSOCIATED_RESET fifo_rst";

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
    WR_B_RSP_STATE,
    RD_ADDR_STATE,
    WAIT_RD_STAT_STATE,
    WAIT_RD_BS_STATE,
    WAIT2_RD_BS_STATE,
    WAIT_RDDATA_RDY_STATE
);

type reg_array is array (0 to 7) of std_logic_vector(31 downto 0);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal state            : state_type;
signal w_data           : std_logic_vector(number_fifo_data_bits-1 downto 0) := (others => '0');
signal wr_addr          : std_logic;
signal t1_s_axi_aresetn : std_logic;
--------------------------------------------------------------------------------


begin

fifo_rst <= not t1_s_axi_aresetn;
fifo_clk <= s_axi_aclk;

process(s_axi_aclk)
begin
    if rising_edge(s_axi_aclk) then
        t1_s_axi_aresetn <= s_axi_aresetn;
        if t1_s_axi_aresetn = '0' then
           state <= RESET_STATE;
           s_axi_awready <= '0'; 
           s_axi_wready  <= '0';  
           s_axi_arready <= '0'; 
           s_axi_rvalid  <= '0';  
           s_axi_bvalid  <= '0';
           fifo_rd_en    <= '0'; 
           fifo_wr_en    <= '0'; 
        else 
           case state is 
            when RESET_STATE =>
                if (t1_s_axi_aresetn = '0') then
                    state <= RESET_STATE;
                    s_axi_awready <= '0';
                    s_axi_wready  <= '0';
                    s_axi_arready <= '0'; 
                    s_axi_rvalid  <= '0';  
                    s_axi_bvalid  <= '0';   
                    fifo_rd_en    <= '0';
                    fifo_wr_en    <= '0'; 
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
                s_axi_wready <= '1';
                s_axi_awready <= '1';  
                w_data <= s_axi_wdata(number_fifo_data_bits-1 downto 0);
                wr_addr <= s_axi_awaddr(2);
                state  <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_wready <= '1';
                w_data <= s_axi_wdata(number_fifo_data_bits-1 downto 0);
                state  <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_wready <= '0';
                if (s_axi_awvalid = '1') then      
                   state  <= WR_ADDR_DEC_STATE;
                   s_axi_awready <= '1';
                   wr_addr <= s_axi_awaddr(2);
                else
                   state  <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   s_axi_awready <= '1';
                   wr_addr <= s_axi_awaddr(2);
                   state  <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                s_axi_awready <= '0';
                if (s_axi_wvalid = '1') then      
                   state  <= WR_ADDR_DEC_STATE;
                   w_data <= s_axi_wdata(number_fifo_data_bits-1 downto 0);
                   s_axi_wready <= '1';
                else
                   state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                if wr_addr = '0' then
                  fifo_wr_en    <= '1';
                  fifo_din      <= w_data;
                end if;     
                s_axi_wready  <= '0';
                s_axi_awready <= '0';   
                state         <= WR_B_RSP_STATE;
                s_axi_bresp   <= "00";
                s_axi_bvalid  <= '1';     
            when  WR_B_RSP_STATE =>
                fifo_wr_en    <= '0'; 
                if s_axi_bready = '1' then
                    s_axi_bvalid <= '0';
                    state <= RESET_STATE;
                else
                    state <= WR_B_RSP_STATE;
                end if;    
            when  RD_ADDR_STATE =>
               s_axi_arready <= '1';
               s_axi_rdata   <= x"00000000"; 
               if s_axi_araddr(2) = '0' then
                  fifo_rd_en    <= '1';
                  state         <= WAIT_RD_BS_STATE;
               else
                  state         <= WAIT_RD_STAT_STATE;    
               end if;  
            when WAIT_RD_STAT_STATE =>
               s_axi_arready <= '0';
               state        <=  WAIT_RDDATA_RDY_STATE;
               s_axi_rdata(1 downto 0)  <= fifo_full & fifo_empty;
               s_axi_rvalid <= '1'; 
               s_axi_rresp  <= "00";
            when WAIT_RD_BS_STATE =>
                s_axi_arready <= '0';
                fifo_rd_en    <= '0';  
                if (read_latency = 0) then   
                  state        <=  WAIT_RDDATA_RDY_STATE;
                  s_axi_rdata(number_fifo_data_bits-1 downto 0)  <= fifo_dout(number_fifo_data_bits-1 downto 0);
                  s_axi_rvalid <= '1'; 
                  s_axi_rresp  <= "00";
                else
                  state   <=  WAIT2_RD_BS_STATE;
                end if;  
            when WAIT2_RD_BS_STATE =>
                state     <=  WAIT_RDDATA_RDY_STATE;   
                s_axi_rdata(number_fifo_data_bits-1 downto 0)  <= fifo_dout(number_fifo_data_bits-1 downto 0);
                s_axi_rvalid <= '1'; 
                s_axi_rresp  <= "00"; 
                  
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_rready = '1' then
                    s_axi_rvalid <= '0';
                    state <= RESET_STATE;
                else
                   state <= WAIT_RDDATA_RDY_STATE;     
                end if;  
            when others =>
               state <= RESET_STATE;
          end case;
       end if;
   end if;  
end process;


end Behavioral;
