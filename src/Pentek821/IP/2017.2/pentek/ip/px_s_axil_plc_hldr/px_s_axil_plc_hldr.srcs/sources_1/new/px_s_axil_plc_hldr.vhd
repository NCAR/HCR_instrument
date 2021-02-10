----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 02/25/2015 10:15:55 AM
-- Design Name: 
-- Module Name: px_s_axil_plc_hldr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Placeholder AXI-LITE Responder. This can be used to as a placeholder in
-- a design to reserve an address range for later connection to a real responder.
-- Reads return 0x00000000 from any address and optionally an error response can be   
-- returned.

-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--  
----------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_s_axil_plc_hldr is
generic(
    address_width : integer := 32; -- AXI4-Lite Address Width
    respond_with_error : boolean := false -- Respond with an error condition when true
);
port (
    --------------------------------------------------------------------------------
    -- AXI LITE Slave Interface  
    -- DWORD Addressing
    --------------------------------------------------------------------------------
    s_axi_csr_aclk            : in  std_logic;
    s_axi_csr_aresetn         : in  std_logic;
    s_axi_csr_awaddr          : in  std_logic_vector(address_width -1 downto 0);
    s_axi_csr_awprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_awvalid         : in  std_logic;
    s_axi_csr_awready         : out std_logic;
    s_axi_csr_wdata           : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb           : in  std_logic_vector(3 downto 0); -- not used
    s_axi_csr_wvalid          : in  std_logic;
    s_axi_csr_wready          : out std_logic;
    s_axi_csr_bresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid          : out std_logic;
    s_axi_csr_bready          : in  std_logic;
    s_axi_csr_araddr          : in  std_logic_vector(address_width -1 downto 0);
    s_axi_csr_arprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_arvalid         : in  std_logic;
    s_axi_csr_arready         : out std_logic;
    s_axi_csr_rdata           : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid          : out std_logic;
    s_axi_csr_rready          : in  std_logic
);
end px_s_axil_plc_hldr;

architecture Behavioral of px_s_axil_plc_hldr is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

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
signal error_resp       : std_logic_vector(1 downto 0) := "00"; 
signal t1_s_axi_csr_aresetn: std_logic := '0';
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
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
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
                else
                   axi_state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';                    
                axi_state         <= WR_B_RSP_STATE;
                s_axi_csr_bresp   <= error_resp;
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
               axi_state   <= WAIT_RD_BS_STATE;
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rvalid  <= '1'; 
                s_axi_csr_rresp   <= error_resp;
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

error_resp <= "00" when (respond_with_error = false) else "01";
s_axi_csr_rdata <= x"00000000";

end Behavioral;
