-----------------------------------------------------------------
-- **** FIFO Gate Generation Module for Pentek Model 7142 **** --
-- *********************** Signal FPGA *********************** --
-----------------------------------------------------------------
-- Title        : FIFO Enable Generator
-- Project      : Model 7142 Signal FPGA
-----------------------------------------------------------------
-- Filename     : FIFO_EN_GEN.VHD
-- Author       : AB - Adapted from module of same name in
--                  Model 7140 User FPGA
-- Created      : 07/26/05
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
--      10/22/05: Rev. D update:  Add output TRIG_REACHED;  Add
--                  signal trig_stat_out;
--      11/28/05: Rev. E update:  removed unused SIGNALs
--                  start_delay_d, poststart_delay_d and
--                  posttrig_tc_d.
--      08/31/06: Re-released with minor changes in comments
--                  for Model 7142 GateFlow kit (4953-142)
--      02/09/07: Deleted unused SIGNALs (formerly commented
--                  out).  Added change log & comment regarding
--                  adaptation from 7140 code.
--      03/15/07: Port kit to VLX100 FPGA - removed references
--                  to VSX55 and Option 055 above.
--      10/19/07 - Add "Signal FPGA" to Project Name field in
--                  header (line 6).
-----------------------------------------------------------------

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

ENTITY FIFO_EN_GEN is
PORT (
    ARM             : in  std_logic;
    CLK             : in  std_logic;
    GATE_DISBL      : in  std_logic;
    GATE_ENABLE     : in  std_logic;
    GATE_SELB       : in  std_logic;
    GATE_TRIG_SEL   : in  std_logic;
    GATEA_IN_N      : in  std_logic;
    GATEB_IN_N      : in  std_logic;
    HOLD_MODE       : in  std_logic;
    PRETRIG         : in  std_logic;
    RST             : in  std_logic;
    TRIG_CLEAR      : in  std_logic;

    POST_LENGTH_H   : in  std_logic_vector (15 downto 0);
    POST_LENGTH_L   : in  std_logic_vector (15 downto 0);
    TRIG_LENGTH_H   : in  std_logic_vector (15 downto 0);
    TRIG_LENGTH_L   : in  std_logic_vector (15 downto 0);

    PRE_COUNT_H     : out std_logic_vector (15 downto 0);
    PRE_COUNT_L     : out std_logic_vector (15 downto 0);

    FIFO_EN         : out std_logic;
    TRIG_REACHED    : out std_logic;
    TRIG_STAT       : out std_logic
    );
END FIFO_EN_GEN;

-----------------------------------------------------------------

ARCHITECTURE BEHAVIOR of FIFO_EN_GEN is

-----------------------------------------------------------------
-- ******************* Signal Declarations ******************* --
-----------------------------------------------------------------

SIGNAL arm_d                : std_logic;
SIGNAL arm_d2               : std_logic;
SIGNAL cntr_ce              : std_logic;
SIGNAL gate_n               : std_logic;
SIGNAL gate_n_d             : std_logic;
SIGNAL mode_mux             : std_logic;
SIGNAL postcntr_ce          : std_logic;
SIGNAL postcntr_ce_d        : std_logic;
SIGNAL poststart_delay      : std_logic;
SIGNAL start_delay          : std_logic;
SIGNAL trig_clear_d         : std_logic;
SIGNAL trig_stat_out        : std_logic;
SIGNAL trig_tc_d            : std_logic;

SIGNAL len_cntr             : std_logic_vector (29 downto 0);
SIGNAL post_length          : std_logic_vector (29 downto 0);
SIGNAL postlen_cntr         : std_logic_vector (29 downto 0);
SIGNAL trig_length          : std_logic_vector (29 downto 0);

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    -------------------------------------------------------------
    -- **************** Assignment Statements **************** --
    -------------------------------------------------------------

    post_length(15 downto 0)    <= POST_LENGTH_L(15 downto 0);
    post_length(29 downto 16)   <= POST_LENGTH_H(13 downto 0);
    PRE_COUNT_L                 <= postlen_cntr(15 downto 0);
    PRE_COUNT_H                 <= ("00" & postlen_cntr
                                                (29 downto 16));
    trig_length(15 downto 0)    <=  TRIG_LENGTH_L(15 downto 0);
    trig_length(29 downto 16)   <=  TRIG_LENGTH_H(13 downto 0);

    -------------------------------------------------------------
    -- ******************* Gate  Circuitry ******************* --
    -- ***************** Gate is  active low ***************** --
    -------------------------------------------------------------

    PROCESS (CLK)
    BEGIN
        if (rising_edge (CLK)) then
            gate_n  <= ((GATEA_IN_N OR GATE_SELB) AND
                            (GATEB_IN_N OR (NOT GATE_SELB)));
            gate_n_d    <= gate_n;
            arm_d       <= ARM;
            arm_d2      <= arm_d;
        end if;
    END PROCESS;

    poststart_delay <= (gate_n_d AND (NOT gate_n) AND
                        (NOT PRETRIG)) OR (arm_d AND (NOT arm_d2)
                                                    AND PRETRIG);
    start_delay     <= (postcntr_ce_d AND (NOT postcntr_ce) AND
                        (NOT PRETRIG)) OR (gate_n_d AND
                                    (NOT gate_n) AND PRETRIG);

    PROCESS (CLK, RST)
    BEGIN
        if (RST = '1') then
            postcntr_ce_d       <= '0';
        elsif (rising_edge (CLK)) then
            postcntr_ce_d       <= postcntr_ce;
        end if;
    END PROCESS;

    PROCESS (CLK)
    BEGIN
        if (rising_edge (CLK)) then
            trig_clear_d        <= TRIG_CLEAR;
        end if;
    END PROCESS;

    -------------------------------------------------------------

    PROCESS (CLK, RST)
    BEGIN
        if (RST = '1') then
            postlen_cntr    <= (others => '0');
            postcntr_ce     <= '0';
        elsif (rising_edge (CLK)) then
            if (trig_clear_d = '1') then
                postlen_cntr<= post_length;
                postcntr_ce <= '0';
            elsif (poststart_delay = '1') then
                postlen_cntr<= (others => '0');
                postcntr_ce <= '1';
            elsif ((PRETRIG = '0') AND (postcntr_ce = '1') AND
                            (postlen_cntr = post_length)) then
                postcntr_ce <= '0';
            elsif ((PRETRIG = '1') AND (postcntr_ce = '1') AND
            (postlen_cntr = "111111111111111111111111111111"))
                                                            then
                postlen_cntr<= "100000000000000000000000000000";
            elsif ((PRETRIG = '1') AND (postcntr_ce = '1') AND
                                    (trig_stat_out = '1')) then
                postcntr_ce <= '0';
            elsif (postcntr_ce = '1') then
                postlen_cntr<= postlen_cntr + 1;
            end if;
        end if;
    END PROCESS;

    TRIG_STAT       <= trig_stat_out;
    TRIG_REACHED    <= cntr_ce;

    PROCESS (CLK, RST)
    BEGIN
        if (RST = '1') then
            len_cntr        <= (others => '0');
            cntr_ce         <= '0';
            trig_tc_d       <= '1';
            trig_stat_out   <= '0';
        elsif (rising_edge (CLK)) then
            if (trig_clear_d = '1') then
                len_cntr        <= (others => '0');
                cntr_ce         <= '0';
                trig_tc_d       <= '1';
                trig_stat_out   <= '0';
            elsif (poststart_delay = '1' AND PRETRIG = '1') then
                len_cntr        <= trig_length;
                cntr_ce         <= '0';
                trig_tc_d       <= '0';
                trig_stat_out   <= '0';
            elsif (start_delay = '1') then
                len_cntr        <= trig_length;
                cntr_ce         <= NOT HOLD_MODE;
                trig_tc_d       <= '0';
                trig_stat_out   <= '0';
            elsif ((cntr_ce = '1') AND
                (len_cntr /= "000000000000000000000000000000"))
                                                            then
                len_cntr        <= len_cntr - 1;
                cntr_ce         <= NOT HOLD_MODE;
                trig_tc_d       <= '0';
                trig_stat_out   <= '0';
            elsif ((cntr_ce = '1') AND
                (len_cntr = "000000000000000000000000000000"))
                                                            then
                cntr_ce         <= '0';
                trig_tc_d       <= '1';
                trig_stat_out   <= '1';
            end if;
        end if;
    END PROCESS;

    -------------------------------------------------------------
    -- ******* Select External or Internal Gate source ******* --
    -------------------------------------------------------------

    PROCESS (GATE_TRIG_SEL, gate_n, trig_tc_d, gate_n_d)
    BEGIN
        case GATE_TRIG_SEL is
            when '0'    =>
                mode_mux    <= gate_n_d;
            when '1'    =>
                mode_mux    <= trig_tc_d;
            when others =>
                mode_mux    <= gate_n_d;
        end case;
    END PROCESS;

    -------------------------------------------------------------
    -- ******************* Output Register ******************* --
    -------------------------------------------------------------

    PROCESS (CLK)
    BEGIN
        if (rising_edge (CLK)) then
            FIFO_EN <= ((NOT mode_mux) OR (GATE_DISBL)) AND
                                                    GATE_ENABLE;
        end if;
    END PROCESS;

END BEHAVIOR;