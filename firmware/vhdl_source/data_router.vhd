-----------------------------------------------------------------
-- ****** VHDL for D/A Data Router in Pentek Model 7142 ****** --
-- *********************** Signal FPGA *********************** --
-----------------------------------------------------------------
-- Title        : DAC Data Router
-- Project      : Model  Signal FPGA
-----------------------------------------------------------------
-- Filename     : DATA_ROUTER.VHD
-- Author       : AB - Adapted from module of same name in
--                  Model 7140 User FPGA
-- Created      : 02/01/06
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
--      08/31/06: Changes for 7142 (one DAC) - Remove SM_GATEB_N
--                  and FIFO_DAT_B in, FEN_B out and related
--                  logic.  Changes to mux for BD output.   
--      02/09/07: Added change log & comment regarding adaptation
--                  from 7140 code.
--      03/15/07: Port kit to VLX100 FPGA - removed references
--                  to VSX55 and Option 055 above.
--      03/21/07: Commented out unused signal ad_buff(15:0).
--      10/19/07 - Add "Signal FPGA" to Project Name field in
--                  header (line 6).  Remove same from Title
--                  field (line 5).
-----------------------------------------------------------------
-- ****** This module multiplexes the  FIFO data stream ****** --
-- ************ into two DAC O/P channels, A & B. ************ --
-----------------------------------------------------------------

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

ENTITY DATA_ROUTER is
PORT (
    CLK         : in  std_logic;
    RST         : in  std_logic;
    SM_GATEA_N  : in  std_logic;

    DAT_MODE    : in  std_logic_vector (2 downto 0);
    FIFO_DAT_A  : in  std_logic_vector (31 downto 0);

    AD          : out std_logic_vector (15 downto 0);
    BD          : out std_logic_vector (15 downto 0);

    FEN_A_N     : out std_logic
    );
END DATA_ROUTER;

-----------------------------------------------------------------

ARCHITECTURE BEHAVIOR of DATA_ROUTER is

-----------------------------------------------------------------
-- ******************* Signal Declarations ******************* --
-----------------------------------------------------------------

SIGNAL fen_a        : std_logic;
SIGNAL gate_a       : std_logic;

-- SIGNAL ad_buff   : std_logic_vector (15 downto 0);
SIGNAL fifo_data_a  : std_logic_vector (31 downto 0);

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    FEN_A_N <= NOT fen_a;

    gate_a  <= NOT SM_GATEA_N;
    
    fifo_data_a <= FIFO_DAT_A when (DAT_MODE(2) = '0')
                    else (FIFO_DAT_A(15 downto 0) &
                                    FIFO_DAT_A(31 downto 16));

    -------------------------------------------------------------
    -- ****************** Data  Multiplexer ****************** --
    -------------------------------------------------------------

    PROCESS (CLK, RST)
    BEGIN
        if (RST = '1') then
            fen_a       <= '0';
        elsif (rising_edge (CLK)) then
            if (DAT_MODE(0) = '0') then
                -- Non-Packed Mode
                fen_a   <= gate_a;
                AD      <= fifo_data_a(15 downto 0);
                BD      <= fifo_data_a(31 downto 16);
            else
                -- Packed Mode
                fen_a   <= NOT fen_a AND gate_a;
                if (DAT_MODE(1) = '0') then
                    BD(7 downto 0)  <= (others => '0');
                    if (fen_a = '0') then
                        AD          <= fifo_data_a(15 downto 0);
                        BD(15 downto 8)
                                    <= fifo_data_a(7 downto 0);
                    else
                        AD          <= fifo_data_a(31 downto 16);
                        BD(15 downto 8)
                                    <= fifo_data_a(23 downto 16);
                    end if;
                else
                    if (fen_a = '0') then
                        AD  <= fifo_data_a(15 downto 0);
                        BD  <= fifo_data_a(15 downto 0);
                    else
                        AD  <= fifo_data_a(31 downto 16);
                        BD  <= fifo_data_a(31 downto 16);
                    end if;
                end if;
            end if;
        end if;
    END PROCESS;

END BEHAVIOR;