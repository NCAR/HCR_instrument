-----------------------------------------------------------------
-- *** Sync & Gate Generation Module for Pentek Model 7142 *** --
-- *********************** Signal FPGA *********************** --
-----------------------------------------------------------------
-- Title        : Sync/Gate Generator
-- Project      : Model 7142 Signal FPGA
-----------------------------------------------------------------
-- Filename     : SYNCGATE.VHD
-- Author       : AB - Adapted from module of same name in
--                  Model 7140 User FPGA
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
--      08/31/06: Re-released with minor changes in comments
--                  for Model 7142 GateFlow kit (4953-142)
--      02/09/07: Added change log & comment regarding adaptation
--                  from 7140 code.
--      03/15/07: Port kit to VLX100 FPGA - removed references
--                  to VSX55 and Option 055 above.
--      10/19/07 - Add "Signal FPGA" to Project Name field in
--                  header (line 6).
-----------------------------------------------------------------
-- ENTITY I/O SIGNAL DEFINITIONS
--------------------------------
--
-- * Sync/Gate Signals * --
---------------------------
--
-- LVDS_SYNCGATE_IN_N   : LVDS Sync/Gate signal in from LVDS bus
--
-- LVDS_SYNCGATE_OUT_N  : Master Sync/Gate signal out to LVDS Bus
--
-- TTL_SYNCGATE         : TTL-Level Sync/Gate signal in from
--                                                      LVDS Bus
--
-- SYNCGATEGO           : Register generated Sync or Gate
--
-- SYNCGATEGO_RS        : SYNCGATEGO, sync'd to sample clock
--
-- * Control Signals * --
-------------------------
--
-- CLK                  : Sample Clock
--
-- EXT_SYNCGATE_EN      : 0 = Use Register-generated Sync/Gate
--                                                      signal
--                        1 = Use External Sync/Gate input
--
-- SYNCGATE_POL         : 0 = Sync/Gate input is Active Low
--                        1 = Sync/Gate input is Active High
--
-- SYNCGATE_SRC         : 0 = Use Sync/Gate signal selected by
--                                              EXT_SYNCGATE_EN
--                      : 1 = Use Sync/Gate signal from LVDS Bus
--
-- RST                  : Reset input, active high
-----------------------------------------------------------------

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

ENTITY SYNCGATE_GEN is
PORT (
    CLK                 : in  std_logic;
    EXT_SYNCGATE_EN     : in  std_logic;
    LVDS_SYNCGATE_IN_N  : in  std_logic;
    RST                 : in  std_logic;
    SYNCGATE_POL        : in  std_logic;
    SYNCGATE_SRC        : in  std_logic;
    SYNCGATEGO          : in  std_logic;
    TTL_SYNCGATE        : in  std_logic;

    LVDS_SYNCGATE_OUT_N : out std_logic;
    SYNCGATE_N_OUT      : out std_logic;
    SYNCGATEGO_RS       : out std_logic
    );
END SYNCGATE_GEN;

-----------------------------------------------------------------

ARCHITECTURE BEHAVIOR of SYNCGATE_GEN is

-----------------------------------------------------------------
-- ******************* Signal Declarations ******************* --
-----------------------------------------------------------------

SIGNAL ext_syncgate         : std_logic;
SIGNAL pol_syncgate         : std_logic;
SIGNAL mux_syncgate_n       : std_logic;
SIGNAL lvds_syncgate_n_rs   : std_logic;
SIGNAL sel_syncgate_n       : std_logic;
SIGNAL syncgate_pol_q       : std_logic;
SIGNAL syncgate_src_q       : std_logic;
SIGNAL syncgatego_n         : std_logic;

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    -------------------------------------------------------------
    -- ***************** Sync/Gate Circuitry ***************** --
    -------------------------------------------------------------
    -- ** Internally, Sync and Gate signals are active low. ** --
    -- *** SYNCGATE_POL converts the TTL_SYNCGATE input to *** --
    -- *** reflect this.  Register-generated Sync and Gate *** --
    -- ********** signals are likewise  active low. ********** --
    -------------------------------------------------------------

    -- Synchronize input signals to sample clock
    PROCESS(CLK)
    BEGIN
        if (rising_edge (CLK)) then
            ext_syncgate        <= TTL_SYNCGATE;
            SYNCGATEGO_RS       <= SYNCGATEGO;
            syncgatego_n        <= SYNCGATEGO;
            syncgate_pol_q      <= SYNCGATE_POL;
            syncgate_src_q      <= SYNCGATE_SRC;
            lvds_syncgate_n_rs  <= LVDS_SYNCGATE_IN_N;
        end if;
    END PROCESS;

    -- Definine Polarity of External Sync/Gate
    pol_syncgate    <= ext_syncgate XOR syncgate_pol_q;

    -- Internal or External TTL Selection Multiplexer
    PROCESS (EXT_SYNCGATE_EN, syncgatego_n, pol_syncgate)
    BEGIN
        case EXT_SYNCGATE_EN is
        when '0'    =>
            mux_syncgate_n  <= syncgatego_n;
        when '1'    =>
            mux_syncgate_n  <= pol_syncgate;
        when others =>
            mux_syncgate_n  <= syncgatego_n;
        end case;
    END PROCESS;

    -- Internal or External LVDS Selection Multiplexer
    PROCESS (syncgate_src_q, mux_syncgate_n, lvds_syncgate_n_rs)
    BEGIN
        case syncgate_src_q is
        when '0'    =>
            sel_syncgate_n  <= mux_syncgate_n;
        when '1'    =>
            sel_syncgate_n  <= lvds_syncgate_n_rs;
        when others =>
            sel_syncgate_n  <= mux_syncgate_n;
        end case;
    END PROCESS;

    -- Resynchronize output signals
    PROCESS (CLK, RST)
    BEGIN
        if (RST = '1') then
            SYNCGATE_N_OUT      <= '1';
            LVDS_SYNCGATE_OUT_N <= '1';
        elsif (rising_edge (CLK)) then
            SYNCGATE_N_OUT      <= sel_syncgate_n;
            LVDS_SYNCGATE_OUT_N <= mux_syncgate_n;
        end if;
    END PROCESS;

END BEHAVIOR;