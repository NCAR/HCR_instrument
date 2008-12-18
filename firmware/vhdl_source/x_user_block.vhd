-----------------------------------------------------------------
-- ***** VHDL for User Block Module in Pentek Model 7142 ***** --
-- *********************** Signal FPGA *********************** --
-----------------------------------------------------------------
-- Title        : Signal FPGA - User Block
-- Project      : Model 7142
-----------------------------------------------------------------
-- Filename     : USER_BLOCK_X.VHD
-- Author       : MAL
-- Created      : 02/09/07
-- Last Modified: 03/29/07
--                  Pentek, Inc.
--                  One Park Way,
--                  Upper Saddle River, NJ 07458
--                  (201) 818-5900
--                  www.pentek.com
-----------------------------------------------------------------
--  Change log  :
--      02/09/07: Adapted from standard 7142 USER_BLOCK.
--                  Add INV_CTRL input, signals fen_del_1,
--                  fifo_dat_reg, dat_prg_inv.  Latch input data,
--                  XOR with INV_CTRL bit, register output.
--                  Add pipeline delays between FEN_IN & FEN_OUT.
--      03/15/07: Port kit to VLX100 FPGA - removed references
--                  to VSX55 and Option 055 above.
--      03/29/07: Update comments for Rev. A GateFlow release.
-----------------------------------------------------------------
-- *** The User Block Module is intended to be replaced by *** --
-- ** user-specific code.  As a place holder for user code, ** --
-- *** the data and FIFO Enable are simply  passed through *** --
-- ** from the inputs to the outputs.   This module is used ** --
-- *********** in both the ADC and DAC Data Paths. *********** --
-----------------------------------------------------------------
-- ** This Module is intended as  an example of how one can ** --
-- *** customize the 7142 by adding  one's own code in the *** --
-- ******************* USER_BLOCK  module. ******************* --
-----------------------------------------------------------------

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

ENTITY USER_BLOCK is
PORT (
    CLK             : in  std_logic;
    FEN_IN          : in  std_logic;
    -- Added input port for data inversion control bit from
    -- Control Register module
    INV_CTRL        : in  std_logic;

    FIFO_DAT_IN     : in  std_logic_vector (31 downto 0);

    FIFO_DAT_OUT    : out std_logic_vector (31 downto 0);

    FEN_OUT         : out std_logic
    );
END USER_BLOCK;

-----------------------------------------------------------------

ARCHITECTURE BEHAVIOR of USER_BLOCK is

-----------------------------------------------------------------
-- ******************* Signal Declarations ******************* --
-----------------------------------------------------------------

-- Pipeline delay stage for FIFO Enable
SIGNAL fen_del_1    : std_logic;

-- Registered FIFO_DAT_IN
SIGNAL fifo_dat_reg : std_logic_vector (31 downto 0);
-- Programmable inversion of registered input data
SIGNAL dat_prg_inv  : std_logic_vector (31 downto 0);

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    -- Latch input data

    PROCESS (CLK)
    BEGIN
        if (rising_edge (CLK)) then
            fifo_dat_reg    <= FIFO_DAT_IN;
       end if;
    END PROCESS;

    -- Exclusive-OR latched data with data inversion control bit

    PROG_INV : for j in 0 to 31 GENERATE

        dat_prg_inv(j)  <= fifo_dat_reg(j) XOR INV_CTRL;

    END GENERATE PROG_INV;

    -- Output Register

    PROCESS (CLK)
    BEGIN
        if (rising_edge (CLK)) then
            FIFO_DAT_OUT    <= dat_prg_inv;
        end if;
    END PROCESS;

    -- The code above puts 2 clock cycles of delay between
    -- FIFO_DAT_IN and FIFO_DAT_OUT.  We must match that delay
    -- between FEN_IN and FEN_OUT.

    PROCESS (CLK)
    BEGIN
        if (rising_edge (CLK)) then
            fen_del_1   <= FEN_IN;
            FEN_OUT     <= fen_del_1;
        end if;
    END PROCESS;

END BEHAVIOR;