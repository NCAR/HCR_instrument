-----------------------------------------------------------------
-- ** VHDL for Parallel Data Interface in Pentek Model 7142 ** --
-- *********************** Signal FPGA *********************** --
-----------------------------------------------------------------
-- Title        : A/D & D/A Parallel Data Interface
-- Project      : Model 7142 Signal FPGA
-----------------------------------------------------------------
-- Filename     : D_INTRFC.VHD
-- Author       : AB - Adapted from module of same name in
--                  Model 7140 User FPGA
-- Created      : 03/15/07
-- Last Modified: 02/09/07
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

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

ENTITY D_INTRFC is
PORT (
    CLK     : in  std_logic;

    AD_IN   : in  std_logic_vector (15 downto 0);
    BD_IN   : in  std_logic_vector (15 downto 0);

    AD_OUT  : out std_logic_vector (15 downto 0);
    BD_OUT  : out std_logic_vector (15 downto 0)
    );
END D_INTRFC;

-----------------------------------------------------------------

ARCHITECTURE BEHAVIOR of D_INTRFC is

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    -------------------------------------------------------------
    -- ***** Register the Input Data  for the ADC or DAC ***** --
    -------------------------------------------------------------

    PROCESS (CLK)
    BEGIN
        if (rising_edge (CLK)) then
            AD_OUT  <= AD_IN;
            BD_OUT  <= BD_IN;
        end if;
    END PROCESS;

END BEHAVIOR;