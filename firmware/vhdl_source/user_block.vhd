-----------------------------------------------------------------
-- ***** VHDL for User Block Module in Pentek Model 7142 ***** --
-- *********************** Signal FPGA *********************** --
-----------------------------------------------------------------
-- Title        : User Block
-- Project      : Model 7142 Signal FPGA
-----------------------------------------------------------------
-- Filename     : USER_BLOCK.VHD
-- Author       : AB
-- Created      : 04/25/05
-- Last Modified: 03/15/07
-- Modified by  : Marc A. Lee, formatted for GateFlow
--                  (Model 4953-142)
--                  Pentek, Inc.
--                  One Park Way,
--                  Upper Saddle River, NJ 07458
--                  (201) 818-5900
--                  www.pentek.com
-----------------------------------------------------------------
--  Change log  :
--      10/07/05: Preliminary formatting for GateFlow (4953-140)
--      05/10/06 : Added inputs CLK and FEN_IN, added output
--                  FEN_OUT.
--      08/31/06: Re-released with minor changes in comments
--                  for Model 7142 GateFlow kit (4953-142)
--      02/09/07: Added change log & comment regarding adaptation
--                  from 7140 code.
--      03/15/07: Port kit to VLX100 FPGA - removed references
--                  to VSX55 and Option 055 above.
--      10/19/07 - Add "Signal FPGA" to Project Name field in
--                  header (line 6).  Remove same from Title
--                  field (line 5).
-----------------------------------------------------------------
-- * This Module is intended to be replaced by user-specific * --
-- **** code.  As a place holder for user code,  the data **** --
-- *** and FIFO Enable are simply  passed through from the *** --
-- *** inputs to the outputs.  This module is used in both *** --
-- *************** the ADC and DAC Data Paths. *************** --
-----------------------------------------------------------------

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

ENTITY USER_BLOCK is
PORT (
    CLK             : in  std_logic;
    FEN_IN          : in  std_logic;

    FIFO_DAT_IN     : in  std_logic_vector (31 downto 0);

    FIFO_DAT_OUT    : out std_logic_vector (31 downto 0);

    FEN_OUT         : out std_logic
    );
END USER_BLOCK;

-----------------------------------------------------------------

ARCHITECTURE BEHAVIOR of USER_BLOCK is

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    FEN_OUT         <= FEN_IN;

    FIFO_DAT_OUT    <= FIFO_DAT_IN;

END BEHAVIOR;