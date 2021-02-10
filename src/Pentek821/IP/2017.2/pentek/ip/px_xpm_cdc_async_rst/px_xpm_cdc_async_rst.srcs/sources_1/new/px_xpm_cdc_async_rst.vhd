----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/21/2016 03:02:09 PM
-- Design Name: 
-- Module Name: px_xpm_async_rst - Behavioral
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
-- 
----------------------------------------------------------------------------------
-- XPM_CDC instantiation template for Asynchronous Reset Synchronizer
-- Refer to the targeted device family architecture libraries guide for XPM_CDC documentation
-- =======================================================================================================================
--
-- Generic usage table, organized as follows:
-- +---------------------------------------------------------------------------------------------------------------------+
-- | Generic name         | Data type          | Restrictions, if applicable                                             |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Description                                                                                                         |
-- +---------------------------------------------------------------------------------------------------------------------+
-- +---------------------------------------------------------------------------------------------------------------------+
-- | DEST_SYNC_FF         | Integer            | Valid range : 2 - 10. Default value = 4.                                |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Number of register stages used to synchronize signal in the destination clock domain.                               |
-- | This parameter also determines the minimum width of the asserted reset signal.                                      |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | RST_ACTIVE_HIGH      | Integer            | Must be 0 or 1. Default value = 0.                                      |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Defines the polarity of the asynchronous reset signal.                                                              |
-- | 0: Active low asynchronous reset signal                                                                             |
-- | 1: Active high asynchronous reset signal                                                                            |
-- +---------------------------------------------------------------------------------------------------------------------+
--
-- Port usage table, organized as follows:
-- +---------------------------------------------------------------------------------------------------------------------+
-- | Port name      | Direction | Size, in bits                         | Domain   | Sense       | Handling if unused    |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Description                                                                                                         |
-- +---------------------------------------------------------------------------------------------------------------------+
-- +---------------------------------------------------------------------------------------------------------------------+
-- | src_arst       | Input     | 1                                     |           |             | Required             |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Source asynchronous reset signal.                                                                                   |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | dest_clk       | Input     | 1                                     |           | Rising-edge | Required             |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Destination clock.                                                                                                  |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | dest_arst      | Output    | 1                                     | dest_clk* |             | Required             |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | src_arst asynchronous reset signal synchronized to destination clock domain.  This output is registered.            |
-- | * Signal asserts asynchronously but deasserts synchronously to dest_clk.  Width of the reset signal is at least     |
-- |  (DEST_SYNC_FF*dest_clk) period.                                                                                    |
-- +---------------------------------------------------------------------------------------------------------------------+

--   xpm_cdc_async_rst  : In order to incorporate this function into the design, the following instance declaration
--         VHDL         : needs to be placed in the architecture body of the design code.  The default values for the
--       instance       : generics may be changed to meet design requirements.  The instance name (xpm_cdc_async_rst_inst)
--      declaration     : and/or the port declarations after the "=>" declaration may be changed to properly reference
--         code         : and connect this function to the design.  All inputs and outputs must be connected.

--         Library      :
--       declaration    : In addition to adding the instance declaration, a use statement for the XPM.vcomponents
--           for        : library needs to be added before the entity declaration.  This library contains the
--         Xilinx       : component declarations for all Xilinx XPMs.
--          XPMs        :


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_xpm_cdc_async_rst is
generic (
-- Common module parameters
     DEST_SYNC_FF    : integer := 4; -- integer; range: 2-10
     RST_ACTIVE_HIGH : integer := 0  -- integer; 0=active low reset, 1=active high reset
);
port ( 
    dest_clk  : in STD_LOGIC;
    src_arst  : in STD_LOGIC;
    dest_arst : out STD_LOGIC
);
end px_xpm_cdc_async_rst;

architecture Behavioral of px_xpm_cdc_async_rst is

begin

rst_inst: xpm_cdc_async_rst
generic map (

  -- Common module parameters
   DEST_SYNC_FF    => 4, -- integer; range: 2-10
   RST_ACTIVE_HIGH => 0  -- integer; 0=active low reset, 1=active high reset
)
port map (

   src_arst  => src_arst,
   dest_clk  => dest_clk,
   dest_arst => dest_arst
);

end Behavioral;
