----------------------------------------------------------------------------------
-- Company: Pentek
-- Engineer: 
-- 
-- Create Date: 01/01/2017 04:21:50 PM
-- Design Name: 
-- Module Name: px_xpm_cdc_single_array - Behavioral
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
-- XPM_CDC instantiation template for Bus Synchronizer with Full Handshake
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
-- | DEST_EXT_HSK         | Integer            | Must be 0 or 1. Default value = 1.                                      |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | 0: An internal handshake will be implemented in the macro to acknowledge receipt of data on the destination clock   |
-- |    domain.                                                                                                          |
-- |    When using this option, the valid dest_out output must be consumed immediately to avoid any data loss.           |
-- | 1: External handshake logic must be implemented by the user to knowledge receipt of data on the destination clock   |
-- |    domain.                                                                                                          |
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
-- | SRC_SYNC_FF          | Integer            | Valid range: 2 - 10. Default value = 4.                                 |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Number of register stages used to synchronize signal in the source clock domain.                                    |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | WIDTH                | Integer            | Valid range: 1 - 1024.  Default value = 1.                              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Width of bus that will be synchronized to destination clock domain.                                                 |
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
-- | src_in         | Input     | WIDTH                                 | src_clk  |             | Required              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Input bus that will be synchronized to the destination clock domain.                                                |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | src_send       | Input     | 1                                     | src_clk  | Active-high | Required              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Assertion of this signal allows the src_in bus to be synchronized to the destination clock domain.                  |
-- | This signal should only be asserted when src_rcv is deasserted, indicating that the previous data transfer          |
-- | is complete.                                                                                                        |
-- | This signal should only be deasserted once src_rcv is asserted, acknowledging that the src_in has been received by  |
-- | the destination logic.                                                                                              |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | src_rcv        | Output    | 1                                     | src_clk  | Active-high | Required              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Acknowledgement from destination logic that src_in has been received.  This signal will be deasserted once          |
-- | destination handshake has fully completed, thus completing a full data transfer.  This output is registered.        |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | dest_clk       | Input     | 1                                     |          | Rising-edge |  Required             |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Destination clock.                                                                                                  |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | dest_out       | Output    | WIDTH                                 | dest_clk |             | Required              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Input bus (src_in) synchronized to destination clock domain.  This output is registered.                            |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | dest_req       | Output    | 1                                     | dest_clk | Active-high | Required              |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Assertion of this signal indicates that new dest_out data has been received and is ready to be used or captured     |
-- | by the destination logic.                                                                                           |
-- | When DEST_EXT_HSK = 1, this signal will deassert once the source handshake acknowledges that the destination clock  |
-- | domain has received the transferred data.                                                                           |
-- | When DEST_EXT_HSK = 0, this signal asserts for one clock period when dest_out bus is valid.                         |
-- | This output is registered.                                                                                          |
-- +---------------------------------------------------------------------------------------------------------------------+
-- | dest_ack       | Input     | 1                                     | dest_clk | Active-high | Tie to 1'b0           |
-- |---------------------------------------------------------------------------------------------------------------------|
-- | Destination logic acknowledgement if DEST_EXT_HSK = 1.  Unused when DEST_EXT_HSK = 0.                               |
-- | Asserting this signal indicates that data on dest_out has been captured by the destination logic.                   |
-- | This signal should be deasserted once dest_req is deasserted, completing the handshake on the destination clock     |
-- | domain and indicating that the destination logic is ready for a new data transfer.                                  |
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

entity px_xpm_cdc_bus_sync is
generic (
   DEST_SYNC_FF   : integer := 3; -- integer; range: 2-10
   SRC_SYNC_FF    : integer := 3; -- integer; range: 2-10
   SIM_ASSERT_CHK : boolean := false; -- integer; false=disable simulation messages, true=enable simulation messages
   WIDTH          : integer := 8 -- number of bits in the array
);
port (
   src_clk  : in  std_logic;
   src_in   : in  std_logic_vector(WIDTH-1 downto 0);
   dest_clk : in  std_logic;
   dest_out : out std_logic_vector(WIDTH-1 downto 0)
 );
end px_xpm_cdc_bus_sync;

architecture Behavioral of px_xpm_cdc_bus_sync is

   function px_boolean_to_int(l: boolean) return integer is
   begin
       if l then
          return(1);
       else
          return(0);
       end if;
   end function px_boolean_to_int;

constant SIM_ASSERT_CHK_I: integer := px_boolean_to_int(SIM_ASSERT_CHK);   

signal src_send: std_logic := '0';
signal src_rcv : std_logic := '0';
signal dest_req: std_logic := '0';

begin

xpm_cdc_handshake_inst:  xpm_cdc_handshake
  generic map (

    -- Common module generics
    DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
    DEST_SYNC_FF   => DEST_SYNC_FF, -- integer; range: 2-10
    SIM_ASSERT_CHK => SIM_ASSERT_CHK_I, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_SYNC_FF    => SRC_SYNC_FF, -- integer; range: 2-10
    WIDTH          => WIDTH  -- integer; range: 1-1024
  )
  port map (

    src_clk  => src_clk,
    src_in   => src_in,
    src_send => src_send,
    src_rcv  => src_rcv,
    dest_clk => dest_clk,
    dest_req => dest_req,
    dest_ack => dest_req, -- optional; required when DEST_EXT_HSK = 1
    dest_out => dest_out
 );
 
 process(src_clk)
 begin
    if rising_edge(src_clk) then
      if (src_rcv = '1') then
        src_send <= '0';
      elsif (src_rcv = '0') and (src_send = '0') then
        src_send <= '1';
      end if;  
    end if;
 end process;   

end Behavioral;
