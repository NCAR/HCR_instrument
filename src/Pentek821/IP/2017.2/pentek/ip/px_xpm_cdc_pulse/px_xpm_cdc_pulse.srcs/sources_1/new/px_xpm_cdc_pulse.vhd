----------------------------------------------------------------------------------
-- Company: Pentek
-- Engineer: 
-- 
-- Create Date: 01/01/2017 04:21:50 PM
-- Design Name: 
-- Module Name: px_xpm_cdc_single - Behavioral
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

-- XPM_CDC instantiation template for Pulse Transfer
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
-- +---------------------------------------------------------------------------------------------------------------------+
-- | REG_OUTPUT           | Integer            | Must be 0 or 1.  Default value = 0.                                     |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | 0: Disable registered output                                                                                        |
-- | 1: Enable registered output                                                                                         |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | RST_USED             | Integer            | Must be 0 or 1. Default value = 1.                                      |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | 0 : No resets implemented.                                                                                          |
-- | 1 : Resets implemented.                                                                                             |
-- | When RST_USED = 0, src_pulse input must always be defined during simulation since there is no reset logic to        |
-- | recover from an x-propagating through the macro.                                                                    |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | SIM_ASSERT_CHK       | Integer            | Must be 0 or 1.  Default value = 0.                                     |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | 0: Disable simulation message reporting, messages related to potential misuse will not be reported.                 |
-- | 1: Enable simulation message reporting, messages related to potential misuse will be reported.                      |
-- +---------------------------------------------------------------------------------------------------------------------+
--
-- Port usage table, organized as follows:
-- +---------------------------------------------------------------------------------------------------------------------+
-- | Port name      | Direction | Size, in bits                         | Domain   | Sense       | Handling if unused    |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Description                                                                                                         |
-- +---------------------------------------------------------------------------------------------------------------------+
-- +---------------------------------------------------------------------------------------------------------------------+
-- | src_clk        | Input     | 1                                     |          | Rising-edge | Required              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Source clock.                                                                                                       |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | src_rst        | Input     | 1                                     | src_clk  | Active-high |  Tie to 1'b0          |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Unused when RST_USED = 0. Source reset signal if RST_USED = 1. Resets all logic in source clock domain.             |
-- | To fully reset the macro, src_rst and dest_rst must be asserted simultaneously for at least                         |
-- | ((DEST_SYNC_FF+2)*dest_clk_period) + (2*src_clk_period).                                                            |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | src_pulse      | Input     | 1                                     | src_clk  | Rising-edge | Required              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Rising edge of this signal initiates a pulse transfer to the destination clock domain.                              |
-- | The minimum gap between each pulse transfer must be at the minimum 2*(larger(src_clk period, dest_clk period)).     |
-- | This is measured between the falling edge of a src_pulse to the rising edge of the next src_pulse.  This minimum    |
-- | gap will guarantee that each rising edge of src_pulse will generate a pulse the size of one dest_clk period in the  |
-- | destination clock domain.                                                                                           |
-- | When RST_USED = 1, pulse transfers will not be guaranteed while src_rst and/or dest_rst are asserted.               |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | dest_clk       | Input     | 1                                     |          | Rising-edge |  Required             |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Destination clock.                                                                                                  |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | dest_rst       | Input     | 1                                     | dest_clk | Active-high |  Tie to 1'b0          |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Unused when RST_USED = 0. Destination reset signal if RST_USED = 1. Resets all logic in destination clock domain.   |
-- | To fully reset the macro, src_rst and dest_rst must be asserted simultaneously for at least                         |
-- | ((DEST_SYNC_FF+2)*dest_clk_period) + (2*src_clk_period).                                                            |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | dest_pulse     | Output    | 1                                     | dest_clk | Active-high | Required              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Outputs a pulse the size of one dest_clk period when a pulse transfer is correctly initiated on src_pulse input.    |
-- | This output is combinatorial unless REG_OUTPUT is set to 1.                                                         |
-- +---------------------------------------------------------------------------------------------------------------------+


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

entity px_xpm_cdc_pulse is
generic (
   DEST_SYNC_FF   : integer := 3; -- integer; range: 2-10
   SIM_ASSERT_CHK : boolean := false; -- integer; false=disable simulation messages, true=enable simulation messages
   REG_OUTPUT     : boolean := true; -- integer; false=disable registered output,   true=enable registered output
   RST_USED       : boolean := false -- integer; false=no reset, true=implement reset
);
port (
   src_clk    : in  std_logic;
   src_rst    : in  std_logic;
   src_pulse  : in  std_logic;
   dest_clk   : in  std_logic;
   dest_rst   : in  std_logic;
   dest_pulse : out std_logic
 );
end px_xpm_cdc_pulse;

architecture Behavioral of px_xpm_cdc_pulse is

   function px_boolean_to_int(l: boolean) return integer is
   begin
       if l then
          return(1);
       else
          return(0);
       end if;
   end function px_boolean_to_int;

constant SIM_ASSERT_CHK_I: integer := px_boolean_to_int(SIM_ASSERT_CHK);   
constant REG_OUTPUT_I: integer := px_boolean_to_int(REG_OUTPUT);
constant RST_USED_I: integer := px_boolean_to_int(RST_USED);  

begin 

cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => DEST_SYNC_FF, -- integer; range: 2-10
    REG_OUTPUT     => REG_OUTPUT_I, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => RST_USED_I, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => SIM_ASSERT_CHK_I  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => src_clk,
    src_rst    => src_rst,   -- optional; required when RST_USED = 1
    src_pulse  => src_pulse,
    dest_clk   => dest_clk,
    dest_rst   => dest_rst,  -- optional; required when RST_USED = 1
    dest_pulse => dest_pulse
  );

end Behavioral;
