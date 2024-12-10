----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2015 12:16:18 PM
-- Design Name: 
-- Module Name: px_pcie3_cfg_ctl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Ties off the Configuration Control Interface of the Xilinx Gen3 PCIe Core
-- to appropriate values.
-- 
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

entity px_pcie3_cfg_ctl is
generic(
   pci_ep_dsn     : std_logic_vector(63 downto 0) := x"0000000000000000";
   subsys_vend_id : std_logic_vector(15 downto 0) := x"0000"  
);
port (
   user_clk                       : in  std_logic;
   usr_link_up                    : in  std_logic;
   
   cc_shutdown_ok                 : in  std_logic; -- CC completions are not pending
   rq_shutdown_ok                 : in  std_logic; -- DMA Requests are not pending
   shutdown_rqst                  : out std_logic;
   
   cfg_config_space_enable        : out std_logic;
   cfg_ds_bus_number              : out std_logic_vector(7 downto 0);
   cfg_ds_device_number           : out std_logic_vector(4 downto 0);
   cfg_ds_function_number         : out std_logic_vector(2 downto 0);
   cfg_ds_port_number             : out std_logic_vector(7 downto 0); 
   cfg_dsn                        : out std_logic_vector(63 downto 0); 
   cfg_err_cor_in                 : out std_logic;
   cfg_err_uncor_in               : out std_logic;
   cfg_flr_done                   : out std_logic_vector(3 downto 0); 
   cfg_hot_reset_in               : out std_logic;
   cfg_link_training_enable       : out std_logic;
   cfg_per_function_number        : out std_logic_vector(3 downto 0);
   cfg_per_function_output_request: out std_logic;
   cfg_power_state_change_ack     : out std_logic;
   cfg_power_state_change_interrupt: in  std_logic;
   cfg_req_pm_transition_l23_ready: out std_logic;
   cfg_subsys_vend_id             : out std_logic_vector(15 downto 0);
   cfg_vf_flr_done                : out std_logic_vector(7 downto 0)
);
end px_pcie3_cfg_ctl;

architecture Behavioral of px_pcie3_cfg_ctl is

begin

shutdown_rqst  <= cfg_power_state_change_interrupt;

-- Tie Off to appropriate values
cfg_config_space_enable             <= '1';
cfg_ds_bus_number                   <= x"00";
cfg_ds_device_number                <= "00000";
cfg_ds_function_number              <= "000";
cfg_ds_port_number                  <= x"00";
cfg_dsn                             <= pci_ep_dsn;  -- Assign the input DSN
cfg_err_cor_in                      <= '0';                  -- Never report Correctable Error
cfg_err_uncor_in                    <= '0';                  -- Never report UnCorrectable Error
cfg_flr_done                        <= "0000";               -- FIXME : how to drive this?
cfg_hot_reset_in                    <= '0';
cfg_link_training_enable            <= '1';                  -- Always enable LTSSM to bring up the Link
cfg_per_function_number             <= "0000";               -- Zero out function num for status req
cfg_per_function_output_request     <= '0';                  -- Do not request configuration status update
cfg_req_pm_transition_l23_ready     <= '0';
cfg_subsys_vend_id                  <= subsys_vend_id;
cfg_vf_flr_done                     <= "00000000";                  -- FIXME : how to drive this?

-- Handle Power State Change Interrupt
process(user_clk)
begin
   if rising_edge(user_clk) then
      if (usr_link_up = '0' ) then
        cfg_power_state_change_ack  <= '0';
      elsif ((cfg_power_state_change_interrupt= '1') and (cc_shutdown_ok ='1') and (rq_shutdown_ok = '1')) then
        cfg_power_state_change_ack  <= '1';
      else
        cfg_power_state_change_ack  <= '0';
      end if;
   end if;
end process;

end Behavioral;
