-----------------------------------------------------------------
-- ****** VHDL for A/D Data Router in Pentek Model 7142 ****** --
-- *********************** Signal FPGA *********************** --
-----------------------------------------------------------------
-- Title        : ADC Data Router
-- Project      : Model 7142 Signal FPGA
-----------------------------------------------------------------
-- Filename     : ADC_DATA_ROUTER.VHD
-- Author       : AB - Adapted from module of same name in
--                  Model 7140 User FPGA
-- Created      : 06/01/05
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
--      11/28/05: Rev. E update:  Delete SIGNAL load_lsw.  In 
--                  the PROCESS for Packed_mode, assignment of
--                  fifo_data(15:0) is dependent upon
--                  (toggler = 0), rather than (load_lsw = 1).
--      08/31/06: Re-released with minor changes in comments
--                  for Model 7142 GateFlow kit (4953-142)
--      02/09/07: Formatting correction - changed case of boolean
--                  operators in statements at lines 108 & 109
--                  from lower to ALL CAPS.
--      03/15/07: Port kit to VLX100 FPGA - removed references
--                  to VSX55 and Option 055 above.
--      10/19/07 - Add "Signal FPGA" to Project Name field in
--                  header (line 6).  Remove same from Title
--                  field (line 5).
-----------------------------------------------------------------
-- ******** This module multiplexes  the data streams ******** --
-- ********* from the A/D converters  into the FIFOs ********* --
-----------------------------------------------------------------

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

ENTITY ADC_DATA_ROUTER is
PORT (
    CLK         : in  std_logic;
    RST         : in  std_logic;
    SM_GATE_N   : in  std_logic;

    DAT_MODE    : in  std_logic_vector (2 downto 0);
    DATA        : in  std_logic_vector (15 downto 0);
    DECDIV      : in  std_logic_vector (15 downto 0);

    FIFO_DAT    : out std_logic_vector (31 downto 0);

    FEN_N       : out std_logic
    );
END ADC_DATA_ROUTER;

-----------------------------------------------------------------

ARCHITECTURE BEHAVIOR of ADC_DATA_ROUTER is

-----------------------------------------------------------------
-- ******************* Signal Declarations ******************* --
-----------------------------------------------------------------

SIGNAL fen          : std_logic;
SIGNAL gate         : std_logic;
SIGNAL toggler      : std_logic;

SIGNAL dec_counter  : std_logic_vector (11 downto 0);
SIGNAL fifo_data    : std_logic_vector (31 downto 0);

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    gate        <= NOT SM_GATE_N;

    PROCESS (RST, CLK, DATA, gate)
    BEGIN
        if (RST = '1') then
            fen         <= '0';
            dec_counter <= "000000000000";
        elsif (rising_edge (CLK)) then
            if (DAT_MODE(0) = '0') then
                -- Non-Packed mode
                if (DECDIV(11 downto 0) = "000000000000") then
                    fen <= gate;
                else
                    fen         <= '0';
                    dec_counter <= "000000000000";
                    if (gate = '1') then
                        dec_counter  <= dec_counter + 1;
                        if (dec_counter = DECDIV(11 downto 0))
                                                            then
                            fen         <= gate;
                            dec_counter <= "000000000000";
                        end if;
                    end if;
                end if;
                fifo_data(15 downto 0)  <= DATA;
                fifo_data(31 downto 16) <= DATA;
            else
                -- Packed mode
                if (DECDIV(11 downto 0) = "000000000000") then
                    fen <= (NOT fen) AND gate;
                    if ((fen = '1') OR (gate = '0')) then
                        fifo_data(15 downto 0)  <= DATA;
                    else
                        fifo_data(31 downto 16) <= DATA;
                    end if;
                else
                    fen         <= '0';
                    toggler     <= '0';
                    dec_counter <= "000000000000";
                    if (gate = '1') then
                        toggler     <= toggler;
                        dec_counter <= dec_counter + 1;
                        if (dec_counter = DECDIV(11 downto 0))
                                                            then
                            fen         <= toggler AND gate;
                            dec_counter <= "000000000000";
                            toggler     <= NOT toggler;
                        end if;
                    end if;
                    fifo_data(31 downto 16) <= DATA;
                    if (toggler = '0') then
                        fifo_data(15 downto 0)   <= DATA;
                    end if;
                end if;
            end if;
        end if;
    END PROCESS;

    FIFO_DAT    <= fifo_data when (DAT_MODE(2) = '0') else
                            (fifo_data(15 downto 0) &
                                        fifo_data(31 downto 16));

    FEN_N    <= NOT fen;

END BEHAVIOR;