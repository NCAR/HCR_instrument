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
-- XPM_CDC instantiation template for Single-bit Synchronizer
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
-- | DEST_SYNC_FF         | Integer            | Valid range: 2 - 10. Default value = 4.                                 |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Number of register stages used to synchronize signal in the destination clock domain.                               |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | SIM_ASSERT_CHK       | Integer            | Must be 0 or 1.  Default value = 0.                                     |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | 0: Disable simulation message reporting, messages related to potential misuse will not be reported.                 |
-- | 1: Enable simulation message reporting, messages related to potential misuse will be reported.                      |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | SRC_INPUT_REG        | Integer            | Must be 0 or 1.  Default value = 1.                                     |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | 0: Do not register input (src_in)                                                                                   |
-- | 1: Register input (src_in) once using src_clk                                                                       |
-- +---------------------------------------------------------------------------------------------------------------------+
--
-- Port usage table, organized as follows:
-- +---------------------------------------------------------------------------------------------------------------------+
-- | Port name      | Direction | Size, in bits                         | Domain   | Sense       | Handling if unused    |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Description                                                                                                         |
-- +---------------------------------------------------------------------------------------------------------------------+
-- +---------------------------------------------------------------------------------------------------------------------+
-- | src_clk        | Input     | 1                                     |          | Rising-edge |  Tie to 1'b0          |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Input clock signal for src_in if SRC_INPUT_REG = 1.  Unused when SRC_INPUT_REG = 0.                                 |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | src_in         | Input     | 1                                     | src_clk  |             | Required              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Input signal to be synchronized to dest_clk domain.                                                                 |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | dest_clk       | Input     | 1                                     |          | Rising-edge | Required              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Clock signal for the destination clock domain.                                                                      |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | dest_out       | Output    | 1                                     | dest_clk |             | Required              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | src_in synchronized to the destination clock domain.  This output is registered.                                    |
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

entity px_xpm_cdc_single is
generic (
   DEST_SYNC_FF   : integer := 3; -- integer; range: 2-10
   SIM_ASSERT_CHK : boolean := false; -- integer; false=disable simulation messages, true=enable simulation messages
   SRC_INPUT_REG  : boolean := true  -- integer; false=do not register input, true=register input
);
port (
   src_clk  : in  std_logic;
   src_in   : in  std_logic;
   dest_clk : in  std_logic;
   dest_out : out std_logic
 );
end px_xpm_cdc_single;

architecture Behavioral of px_xpm_cdc_single is

   function px_boolean_to_int(l: boolean) return integer is
   begin
       if l then
          return(1);
       else
          return(0);
       end if;
   end function px_boolean_to_int;

constant SIM_ASSERT_CHK_I: integer := px_boolean_to_int(SIM_ASSERT_CHK);   
constant SRC_INPUT_REG_I: integer := px_boolean_to_int(SRC_INPUT_REG);

begin

cdc_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => DEST_SYNC_FF, -- integer; range: 2-10
     SIM_ASSERT_CHK => SIM_ASSERT_CHK_I, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => SRC_INPUT_REG_I  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => src_clk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => src_in,
     dest_clk => dest_clk,
     dest_out => dest_out
  );

end Behavioral;
