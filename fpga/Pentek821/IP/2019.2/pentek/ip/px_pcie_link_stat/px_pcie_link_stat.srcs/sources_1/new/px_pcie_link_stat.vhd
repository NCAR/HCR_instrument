----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2015 01:52:49 PM
-- Design Name: 
-- Module Name: px_pcie_link_stat - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- This module takes status info from the pcie cfg_status bus and creates an output
-- vector with the following information:

--pcie_link_status_info[3:0]  =  negotiated width
--pcie_link_status_info[6:4]  =  current link speed
--pcie_link_status_info[10:8] =  maximum payload size
--pcie_link_status_info[14:12]=  maximum read request
--pcie_link_status_info[19:16]=  msi enabled

-- It also output the maximum payload and request sizes in the format required by the Pentek PCIe DMAs.
-- LED drives for link indicators are also created.

-- PCIe Link LED Encoding : Solid = Gen 3, Blink 0.5 second = Gen 2, Blink 1 Second = Gen 1    
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_pcie_link_stat is
    Generic (
        ultrascale_plus : boolean := false
    );
    Port ( 
        cfg_phy_link_down         : in  std_logic;
        cfg_negotiated_width      : in  std_logic_vector(3 downto 0);
        cfg_current_speed         : in  std_logic_vector(2 downto 0);
        cfg_max_payload           : in  std_logic_vector(2 downto 0);
        cfg_max_read_req          : in  std_logic_vector(2 downto 0);
        pcie_cq_np_req            : out std_logic; 
        
        cfg4_phy_link_down        : in  std_logic;
        cfg4_negotiated_width     : in  std_logic_vector(2 downto 0);
        cfg4_current_speed        : in  std_logic_vector(1 downto 0);
        cfg4_max_payload          : in  std_logic_vector(1 downto 0);
        cfg4_max_read_req         : in  std_logic_vector(2 downto 0);
        pcie4_cq_np_req           : out std_logic_vector(1 downto 0); 
        
        msi_en                    : in  std_logic_vector(3 downto 0);
        pcie_link_status_info     : out std_logic_vector(31 downto 0);
        
        
        byte_swap                 : in  std_logic;
        aclk                      : in std_logic;
        aresetn                   : in std_logic;
        m_axis_dma_pcie_cntl_tdata  : out std_logic_vector(7 downto 0);-- DMAs use this information 
        m_axis_dma_pcie_cntl_tvalid : out std_logic;
        ---------------------
        --LED Drives
        pcie_link_up_led_n        : out std_logic;
        lane_led0_n               : out std_logic;
        lane_led1_n               : out std_logic
        );
end px_pcie_link_stat;

architecture Behavioral of px_pcie_link_stat is

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal enc_width: std_logic_vector(1 downto 0) := "00";
signal cntr: std_logic_vector(27 downto 0):= x"0000000";
signal cntr_tc: std_logic := '0';
signal blink_cntr: std_logic_vector(1 downto 0) := "00";
signal negotiated_width: std_logic_vector(3 downto 0) := x"0";
--------------------------------------------------------------------------------

begin

gen_not_u_p: if (ultrascale_plus = false) generate
pcie_link_status_info(3 downto 0)  <=  cfg_negotiated_width;
pcie_link_status_info(6 downto 4)  <=  cfg_current_speed;
pcie_link_status_info(7)           <=  '0';
pcie_link_status_info(10 downto 8) <=  cfg_max_payload;
pcie_link_status_info(11)          <=  '0';
pcie_link_status_info(14 downto 12)<=  cfg_max_read_req;
pcie_link_status_info(15)          <=  '0';
pcie_link_status_info(19 downto 16)<=  msi_en;
pcie_link_status_info(31 downto 20)<=  "000000000000";  

enc_width <= "00" when ( cfg_negotiated_width = x"1") else
             "01" when ( cfg_negotiated_width = x"2") else
             "10" when ( cfg_negotiated_width = x"4") else
             "11" when ( cfg_negotiated_width = x"8") else "00";
             
process(aclk)
begin
    if rising_edge(aclk) then
       m_axis_dma_pcie_cntl_tdata  <= byte_swap & cfg_max_read_req & '0' & cfg_max_payload; -- DMAs use this information 
    end if; 
end process;           

pcie_link_up_led_n <= '1' when (cfg_phy_link_down = '1') else
                      blink_cntr(0) when (cfg_current_speed = "010") else
                      blink_cntr(1) when (cfg_current_speed = "001") else '0'; 
                      
-- Count .5 seconds
process(aclk)
begin
    if rising_edge(aclk) then
      if cntr = (x"0000000") or (cfg_phy_link_down = '1') then 
         cntr    <=  x"3B9AC9F";
         cntr_tc <= '1';
      else    
         cntr <= cntr - 1;
         cntr_tc <= '0';
      end if;   
      if cntr_tc = '1' then
         blink_cntr <= blink_cntr + 1;
      end if;
    end if; 
end process;                         

end generate;

pcie_cq_np_req <= '1';

gen_u_p: if (ultrascale_plus = true) generate
pcie_link_status_info(3 downto 0)  <=  negotiated_width;
pcie_link_status_info(6 downto 4)  <=  '0' & cfg4_current_speed;
pcie_link_status_info(7)           <=  '0';
pcie_link_status_info(10 downto 8) <=  '0' & cfg4_max_payload;
pcie_link_status_info(11)          <=  '0';
pcie_link_status_info(14 downto 12)<=  cfg4_max_read_req;
pcie_link_status_info(15)          <=  '0';
pcie_link_status_info(19 downto 16)<=  msi_en;
pcie_link_status_info(31 downto 20)<=  "000000000000";  

enc_width <= cfg4_negotiated_width(1 downto 0);

negotiated_width <= x"1" when ( cfg4_negotiated_width = "000") else
             x"2" when ( cfg4_negotiated_width = "001") else
             x"4" when ( cfg4_negotiated_width = "010") else
             x"8" when ( cfg4_negotiated_width = "011") else x"F";
             
process(aclk)
begin
    if rising_edge(aclk) then
       m_axis_dma_pcie_cntl_tdata  <= byte_swap & cfg4_max_read_req & "00" & cfg4_max_payload; -- DMAs use this information 
    end if; 
end process;           

pcie_link_up_led_n <= '1' when (cfg4_phy_link_down = '1') else
                      blink_cntr(0) when (cfg4_current_speed = "10") else
                      blink_cntr(1) when (cfg4_current_speed = "01") else '0';
                      
 
 -- Count .5 seconds
 process(aclk)
 begin
     if rising_edge(aclk) then
       if cntr = (x"0000000") or (cfg4_phy_link_down = '1') then 
          cntr    <=  x"3B9AC9F";
          cntr_tc <= '1';
       else    
          cntr <= cntr - 1;
          cntr_tc <= '0';
       end if;   
       if cntr_tc = '1' then                     
          blink_cntr <= blink_cntr + 1;
       end if;
     end if; 
 end process;  
 
end generate;

pcie4_cq_np_req <= "11";


m_axis_dma_pcie_cntl_tvalid <= '1';



lane_led0_n        <= not enc_width(0);
lane_led1_n        <= not enc_width(1);

  




end Behavioral;
