-----------------------------------------------------------------
-- ****** VHDL for Clock Generator in Pentek Model 7142 ****** --
-- *********************** Signal  FPGA ********************** --
-----------------------------------------------------------------
-- Title        : Clock Generator
-- Project      : Model 7142, Signal FPGA
-----------------------------------------------------------------
-- Filename     : CLK_GEN.VHD
-- Author       : AB - Adapted from module of same name in
--                  Model 7140 User FPGA
-- Created      : 07/29/05
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

ENTITY CLK_GEN is
PORT (
    LCLK        : in  std_logic;
    RST         : in  std_logic;

    DAC_SCLK    : out std_logic
    );
END CLK_GEN;

-----------------------------------------------------------------

ARCHITECTURE BEHAVIOR of CLK_GEN is

SIGNAL sclk     : std_logic;

SIGNAL scount   : std_logic_vector (7 downto 0);

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    PROCESS (LCLK, RST)
    BEGIN
        if (RST = '1') then
            scount  <= "00000000";
        elsif (rising_edge (LCLK)) then
            scount  <= scount + 1;
            if scount = "11111111" then
                sclk    <= not sclk;
            end if;
        end if;
    END PROCESS;

    -- DAC_SCLK = LCLK/256
    DAC_SCLK    <= sclk;

END BEHAVIOR;