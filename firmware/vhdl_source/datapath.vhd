-----------------------------------------------------------------
-- ******* VHDL for D/A Data Path in Pentek Model 7142 ******* --
-- *********************** Signal FPGA *********************** --
-----------------------------------------------------------------
-- Title        : DAC Data Path
-- Project      : Model 7142 Signal FPGA
-----------------------------------------------------------------
-- Filename     : DATAPATH.VHD
-- Author       : AB - Adapted from module of same name in
--                  Model 7140 User FPGA
-- Created      : 07/07/05
-- Last Modified: 03/15/07
-- Modified by  : Marc A. Lee, formatted for GateFlow
--                  (Model 4953-142, Option 055)
--                  Pentek, Inc.
--                  One Park Way,
--                  Upper Saddle River, NJ 07458
--                  (201) 818-5900
--                  www.pentek.com
-----------------------------------------------------------------
--  Change log  :
--      10/07/05: Preliminary formatting for GateFlow (4953-140)
--      05/10/06 : Updated for new USER_BLOCK, w/ Clock input &
--                  Fifo Enable I/O.
--      05/19/06 : Changed FIFO depth from 1k to 8k, for this
--                  component only.
--      08/31/06: Changes for 7142 (one DAC) - Remove RST_B,
--                  SM_GATEB_N, WR_EN_B, PROG_EMPTY_THRESH_B,
--                  PROG_FULL_THRESH_B & DIN_B in, EF_B, FAE_B,
--                  FAF_B, FF_B & REQB out, Components FIFO_B,
--                  and USER_BLOCKB, & related signals & logic.                  
--      02/09/07: Reformatted all Port Maps such that ports are
--                  listed in same order as component declara-
--                  tions.
--      03/14/07: Used latest FIFO_GENERATOR IP (Ver 3.2) to
--                  create new FIFOs - fifo_d8k_w64_r32 replaces
--                  FIFO8K64TO32.
--      03/15/07: Port kit to VLX100 FPGA - removed references
--                  to VSX55 and Option 055 above.
--      10/19/07: Add "Signal FPGA" to Project Name field in
--                  header (line 6).  Remove same from Title
--                  field (line 5).
-----------------------------------------------------------------

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;

LIBRARY UNISIM;
USE     UNISIM.vcomponents.all;

ENTITY DAC_DATA_PATH is
PORT (
    BYTESWAP            : in  std_logic;
    DAC_CLK             : in  std_logic;
    LCL_CLK             : in  std_logic;
    RST_A               : in  std_logic;
    SM_GATEA_N          : in  std_logic;
    WR_EN_A             : in  std_logic;

    DAT_MODE            : in  std_logic_vector (2 downto 0);
    DIN_A               : in  std_logic_vector (63 downto 0);
    FIFO_DACM_DOUT      : in  std_logic_vector (31 downto 0);
    MEM_CTRL_REG        : in  std_logic_vector (15 downto 0);
    PROG_EMPTY_THRESH_A : in  std_logic_vector (13 downto 0);
    PROG_FULL_THRESH_A  : in  std_logic_vector (12 downto 0);

    AD                  : out std_logic_vector (15 downto 0);
    BD                  : out std_logic_vector (15 downto 0);

    EF_A                : out std_logic;
    FAE_A               : out std_logic;
    FAF_A               : out std_logic;
    FF_A                : out std_logic;
    RD_EN_A             : out std_logic;
    REQA                : out std_logic
    );
END DAC_DATA_PATH;

-----------------------------------------------------------------

ARCHITECTURE STRUCTURE of DAC_DATA_PATH is

-----------------------------------------------------------------
-- ***************** Component  Declarations ***************** --
-----------------------------------------------------------------

-- Parallel Data Register
COMPONENT D_INTRFC
PORT (
    Clk         : in  std_logic;

    Ad_In       : in  std_logic_vector (15 downto 0);
    Bd_In       : in  std_logic_vector (15 downto 0);

    Ad_Out      : out std_logic_vector (15 downto 0);
    Bd_Out      : out std_logic_vector (15 downto 0)
    );
END COMPONENT;

-- Data Router
COMPONENT DATA_ROUTER
PORT (
    Clk         : in  std_logic;
    Rst         : in  std_logic;
    Sm_GateA_n  : in  std_logic;

    Dat_Mode    : in  std_logic_vector (2 downto 0);
    Fifo_Dat_A  : in  std_logic_vector (31 downto 0);

    Ad          : out std_logic_vector (15 downto 0);
    Bd          : out std_logic_vector (15 downto 0);

    Fen_A_n     : out std_logic
    );
END COMPONENT;

-- User Blocks
COMPONENT USER_BLOCK
PORT (
    Clk             : in  std_logic;
    Fen_In          : in  std_logic;

    Fifo_Dat_In     : in  std_logic_vector (31 downto 0);

    Fifo_Dat_Out    : out std_logic_vector (31 downto 0);

    Fen_Out         : out std_logic
    );
END COMPONENT;

-- FIFOs
COMPONENT fifo_d8k_w64_r32
PORT (
    Rd_Clk              : in  std_logic;
    Rd_En               : in  std_logic;
    Rst                 : in  std_logic;
    Wr_Clk              : in  std_logic;
    Wr_En               : in  std_logic;

    Din                 : in  std_logic_vector (63 downto 0);
    Prog_Empty_Thresh   : in  std_logic_vector (13 downto 0);
    Prog_Full_Thresh    : in  std_logic_vector (12 downto 0);

    Dout                : out std_logic_vector (31 downto 0);

    Almost_Empty        : out std_logic;
    Almost_Full         : out std_logic;
    Empty               : out std_logic;
    Full                : out std_logic;
    Prog_Empty          : out std_logic;
    Prog_Full           : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------
-- ******************* Signal Declarations ******************* --
-----------------------------------------------------------------

SIGNAL ae_a             : std_logic;
SIGNAL af_a             : std_logic;
SIGNAL faeq1_a          : std_logic;
SIGNAL faeq2_a          : std_logic;
SIGNAL fafq1_a          : std_logic;
SIGNAL fafq2_a          : std_logic;
SIGNAL fen_a            : std_logic;
SIGNAL fen_a_n          : std_logic;
SIGNAL ub_gatea_n       : std_logic;

SIGNAL ad_q             : std_logic_vector(15 downto 0);
SIGNAL bd_q             : std_logic_vector(15 downto 0);
SIGNAL din_a_swapped    : std_logic_vector(63 downto 0);
SIGNAL fifo_daca_dout   : std_logic_vector(31 downto 0);
SIGNAL fifo_dout_a      : std_logic_vector(31 downto 0);
SIGNAL fifo_dat_ua      : std_logic_vector(31 downto 0);

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    -------------------------------------------------------------
    -- **************** Assignment Statements **************** --
    -------------------------------------------------------------

    RD_EN_A         <= fen_a;

    fen_a           <= NOT fen_a_n;

    FAE_A           <= ae_a;

    FAF_A           <= af_a;

    din_a_swapped   <= (DIN_A(7 downto 0) & DIN_A(15 downto 8) &
                    DIN_A(23 downto 16) & DIN_A(31 downto 24) &
                    DIN_A(39 downto 32) & DIN_A(47 downto 40) &
                    DIN_A(55 downto 48) & DIN_A(63 downto 56))
                                            when (BYTESWAP = '1')
                    else
                    (DIN_A(31 downto 0) & DIN_A(63 downto 32));

    -------------------------------------------------------------
    -- ****************** Instantiate  FIFO ****************** --
    -------------------------------------------------------------

    -- DAC Channel A
    FIFO_A: fifo_d8k_w64_r32
    PORT MAP(
        Rd_Clk              => DAC_CLK,
        Rd_En               => fen_a,
        Rst                 => RST_A,
        Wr_Clk              => LCL_CLK,
        Wr_En               => WR_EN_A,

        Din                 => din_a_swapped,
        Prog_Empty_Thresh   => PROG_EMPTY_THRESH_A,
        Prog_Full_Thresh    => PROG_FULL_THRESH_A,

        Dout                => fifo_daca_dout,

        Almost_Empty        => OPEN,
        Almost_Full         => OPEN,
        Empty               => EF_A,
        Full                => FF_A,
        Prog_Empty          => ae_a,
        Prog_Full           => af_a
        );

    fifo_dout_a <= fifo_daca_dout
                    when (MEM_CTRL_REG(10) = '0')
                    else FIFO_DACM_DOUT;

    -------------------------------------------------------------
    -- *************** Instantiate  User Block *************** --
    -------------------------------------------------------------

    USER_BLOCKA : USER_BLOCK
    PORT MAP(
        Clk             => DAC_CLK,
        Fen_In          => SM_GATEA_N,

        Fifo_Dat_In     => fifo_dout_a,

        Fifo_Dat_Out    => fifo_dat_ua,

        Fen_Out         => ub_gatea_n
        );

    -------------------------------------------------------------
    -- *************** Instantiate Data Router *************** --
    -------------------------------------------------------------

    DAT_RTR : DATA_ROUTER
    PORT MAP(
        Clk         => DAC_CLK,
        Rst         => RST_A,
        Sm_GateA_n  => ub_gatea_n,

        Dat_Mode    => DAT_MODE,
        Fifo_Dat_A  => fifo_dat_ua,

        Ad          => ad_q,
        Bd          => bd_q,

        Fen_A_n     => fen_a_n
        );

    -------------------------------------------------------------
    -- ********* Output Data  Register Instantiation ********* --
    -------------------------------------------------------------

    D_INTRFACE : D_INTRFC
    PORT MAP(
        Clk         => DAC_CLK,

        Ad_In       => ad_q,
        Bd_In       => bd_q,

        Ad_Out      => AD,
        Bd_Out      => BD
        );

    -------------------------------------------------------------
    -- **************** Generate DMA  Request **************** --
    -------------------------------------------------------------

    PROCESS(RST_A, LCL_CLK)
    BEGIN
        if (RST_A = '1') then
            REQA    <= '1';
        elsif (rising_edge (LCL_CLK)) then
            faeq1_a  <= ae_a;
            faeq2_a  <= faeq1_a;
            fafq1_a  <= af_a;
            fafq2_a  <= fafq1_a;
            if (faeq1_a = '1' AND faeq2_a = '1') then
                REQA    <= '1';
            elsif (fafq1_a = '1' AND fafq2_a = '1') then
                REQA    <= '0';
            end if;
        end if;
    END PROCESS;

END STRUCTURE;