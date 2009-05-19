-----------------------------------------------------------------
-- ******* VHDL for A/D Data Path in Pentek Model 7142 ******* --
-- *********************** Signal FPGA *********************** --
-----------------------------------------------------------------
-- Title        : ADC Data Path
-- Project      : Model 7142 Signal FPGA
-----------------------------------------------------------------
-- Filename     : ADCDATA.VHD
-- Author       : AB - Adapted from module of same name in
--                  Model 7140 User FPGA
-- Created      : 08/09/05
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
--      03/12/06 : To support simulators other than XST and
--                  ModelSim, removed logical negations from PORT
--                  MAPs for Instances FIFO_ADCA and FIFO_ADCB,
--                  by creating and substituting negated signals
--                  fena and fenb.
--      04/27/06 : For compatibility with ModelSim compiler,
--                 added "else" unchanged clauses to assignment
--                 statements for sm_gatea_ntemp and
--                 sm_gateb_ntemp.
--      05/10/06 : Updated for new USER_BLOCK, w/ Clock input &
--                  Fifo Enable I/O.
--      08/31/06: Re-released with minor changes in comments
--                  for Model 7142 GateFlow kit (4953-142)
--      02/09/07: Reformatted all Port Maps such that ports are
--                  listed in same order as component declara-
--                  tions.
--      02/12/07: In DMA Request generation processes, evaluate
--                  the almost empty condition, to de-assert the
--                  request, BEFORE evaluating the almost full
--                  condition, to assert the request.
--      03/14/07 Used latest FIFO_GENERATOR IP (Ver 3.2) to
--                  create new FIFOs - fifo_d2k_w32_r64 replaces
--                  FIFO1K32TO64.
--      03/15/07: Port kit to VLX100 FPGA - removed references
--                  to VSX55 and Option 055 above.
--      10/19/07 - Add "Signal FPGA" to Project Name field in
--                  header (line 6).  Remove same from Title
--                  field (line 5).
-----------------------------------------------------------------

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;

LIBRARY UNISIM;
USE     UNISIM.vcomponents.all;

ENTITY ADC_DATA_PATH_USER is
PORT (
	 START_CLK				: in  std_logic;
    ADC_CLK             : in  std_logic;
    BYTESWAP            : in  std_logic;
    LCL_CLK             : in  std_logic;
    RD_EN_A             : in  std_logic;
    RD_EN_B             : in  std_logic;
    RST_A               : in  std_logic;
    RST_B               : in  std_logic;
    SM_GATEA_N          : in  std_logic;
    SM_GATEB_N          : in  std_logic;

    AD                  : in  std_logic_vector (15 downto 0);
    BD                  : in  std_logic_vector (15 downto 0);
    DAT_MODEA           : in  std_logic_vector (2 downto 0);
    DAT_MODEB           : in  std_logic_vector (2 downto 0);
    DECDIV_A            : in  std_logic_vector (15 downto 0);
    DECDIV_B            : in  std_logic_vector (15 downto 0);
    PROG_EMPTY_THRESH_A : in  std_logic_vector (9 downto 0);
    PROG_EMPTY_THRESH_B : in  std_logic_vector (9 downto 0);
    PROG_FULL_THRESH_A  : in  std_logic_vector (10 downto 0);
    PROG_FULL_THRESH_B  : in  std_logic_vector (10 downto 0);

    ADCA_PACKED_DATA    : out std_logic_vector (31 downto 0);
    ADCB_PACKED_DATA    : out std_logic_vector (31 downto 0);
    DOUTA               : out std_logic_vector (63 downto 0);
    DOUTB               : out std_logic_vector (63 downto 0);

    EF_A                : out std_logic;
    EF_B                : out std_logic;
    FAE_A               : out std_logic;
    FAE_B               : out std_logic;
    FAF_A               : out std_logic;
    FAF_B               : out std_logic;
    FF_A                : out std_logic;
    FF_B                : out std_logic;
    REQA                : out std_logic;
    REQB                : out std_logic;
    WR_EN_A             : out std_logic;
    WR_EN_B             : out std_logic;

-- For DDC USER BLOCK	 
	 CLK						: in std_logic;
	 CLK_12					: in std_logic;
	 G_ADDR					: in std_logic_vector(3 downto 0);
	 G_DATA					: in std_logic_vector(17 downto 0);
	 G_SEL					: in std_logic_vector(1 downto 0);
	 G_WR						: in std_logic;
	 K_ADDR					: in std_logic_vector(3 downto 0);
	 K_DATA					: in std_logic_vector(17 downto 0);
	 K_SEL					: in std_logic_vector(2 downto 0);
	 K_WR						: in std_logic;
	 STOP						: in std_logic;
	 G_READCOEF				: out std_logic_vector(17 downto 0);
	 K_READCOEF				: out std_logic_vector(17 downto 0);
	 RX_GATE					: in std_logic
    );

END ADC_DATA_PATH_USER;

-----------------------------------------------------------------

ARCHITECTURE STRUCTURE of ADC_DATA_PATH_USER is

-----------------------------------------------------------------
-- ***************** Component  Declarations ***************** --
-----------------------------------------------------------------

-- Input Data Register
COMPONENT D_INTRFC
PORT (
    Clk         : in  std_logic;

    Ad_In       : in  std_logic_vector (15 downto 0);
    Bd_In       : in  std_logic_vector (15 downto 0);

    Ad_Out      : out std_logic_vector (15 downto 0);
    Bd_Out      : out std_logic_vector (15 downto 0)
    );
END COMPONENT;

COMPONENT ADC_DATA_ROUTER
PORT (
    Clk         : in  std_logic;
    Rst         : in  std_logic;
    Sm_Gate_n   : in  std_logic;

    Dat_Mode    : in  std_logic_vector (2 downto 0);
    Data        : in  std_logic_vector (15 downto 0);
    DecDiv      : in  std_logic_vector (15 downto 0);

    Fifo_Dat    : out std_logic_vector (31 downto 0);

    Fen_n       : out std_logic
    );
END COMPONENT;

COMPONENT fifo_d2k_w32_r64
PORT (
    Rd_Clk              : in  std_logic;
    Rd_En               : in  std_logic;
    Rst                 : in  std_logic;
    Wr_Clk              : in  std_logic;
    Wr_En               : in  std_logic;

    Din                 : in  std_logic_vector (31 downto 0);
    Prog_Empty_Thresh   : in  std_logic_vector (9 downto 0);
    Prog_Full_Thresh    : in  std_logic_vector (10 downto 0);

    Dout                : out std_logic_vector (63 downto 0);

    Almost_Empty        : out std_logic;
    Almost_Full         : out std_logic;
    Empty               : out std_logic;
    Full                : out std_logic;
    Prog_Empty          : out std_logic;
    Prog_Full           : out std_logic
    );
END COMPONENT;

COMPONENT DDC_USER_BLOCK
PORT (
    Clk             : in  std_logic;
    Fen_In          : in  std_logic;

    Fifo_Dat_In     : in  std_logic_vector (31 downto 0);

    Fifo_Dat_Out    : out std_logic_vector (31 downto 0);

    Fen_Out         : out std_logic;

	 Clk_12			  : in std_logic;

	 G_addr			  : in std_logic_vector(3 downto 0);

	 G_data    		  : in std_logic_vector(17 downto 0);

	 G_sel			  : in std_logic_vector(1 downto 0);

	 G_wr				  : in std_logic;

	 K_addr   		  : in std_logic_vector(3 downto 0);

	 K_data			  : in std_logic_vector(17 downto 0);

	 K_sel			  : in std_logic_vector(2 downto 0);

	 K_wr				  : in std_logic;

	 Stop				  : in std_logic;

	 G_readcoef		  : out std_logic_vector(17 downto 0);

	 K_readcoef		  : out std_logic_vector(17 downto 0);
	 
	 Rx_gate			  : in std_logic
	
    );
END COMPONENT;

COMPONENT USER_BLOCK
PORT (
    Clk             : in  std_logic;
    Fen_In          : in  std_logic;

    Fifo_Dat_In     : in  std_logic_vector (31 downto 0);

    Fifo_Dat_Out    : out std_logic_vector (31 downto 0);

    Fen_Out         : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------
-- ******************* Signal Declarations ******************* --
-----------------------------------------------------------------

SIGNAL ae_a             : std_logic;
SIGNAL ae_b             : std_logic;
SIGNAL af_a             : std_logic;
SIGNAL af_b             : std_logic;
SIGNAL faeq1_a          : std_logic;
SIGNAL faeq1_b          : std_logic;
SIGNAL faeq2_a          : std_logic;
SIGNAL faeq2_b          : std_logic;
SIGNAL fafq1_a          : std_logic;
SIGNAL fafq1_b          : std_logic;
SIGNAL fafq2_a          : std_logic;
SIGNAL fafq2_b          : std_logic;
SIGNAL fena             : std_logic;
SIGNAL fena_n           : std_logic;
SIGNAL fena_ub          : std_logic;
SIGNAL fenb             : std_logic;
SIGNAL fenb_n           : std_logic;
SIGNAL fenb_ub          : std_logic;
SIGNAL sm_gatea_ntemp   : std_logic;
SIGNAL sm_gateb_ntemp   : std_logic;

SIGNAL ad_q             : std_logic_vector (15 downto 0);
SIGNAL bd_q             : std_logic_vector (15 downto 0);
SIGNAL douta_fifo       : std_logic_vector (63 downto 0);
SIGNAL doutb_fifo       : std_logic_vector (63 downto 0);
SIGNAL fifo_dat_a       : std_logic_vector (31 downto 0);
SIGNAL fifo_dat_b       : std_logic_vector (31 downto 0);
SIGNAL fifo_dat_ua      : std_logic_vector (31 downto 0);
SIGNAL fifo_dat_ub      : std_logic_vector (31 downto 0);

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    -------------------------------------------------------------
    -- ************* Input Assignment Statements ************* --
    -------------------------------------------------------------

    sm_gatea_ntemp  <= SM_GATEA_N
                        when (rising_edge(START_CLK))
                        else sm_gatea_ntemp;
    sm_gateb_ntemp  <= SM_GATEB_N
                    when (rising_edge(ADC_CLK))
                        else sm_gateb_ntemp;

     -------------------------------------------------------------
    -- ********** Input Data Register Instantiation ********** --
    -------------------------------------------------------------

    D_INTRFC2 : D_INTRFC
    PORT MAP(
        Clk         => ADC_CLK,

        Ad_In       => AD,
        Bd_In       => BD,

        Ad_Out      => ad_q,
        Bd_Out      => bd_q
        );

    -------------------------------------------------------------
    -- ************** Instantiate  Data Routers ************** --
    -------------------------------------------------------------

    -- ADC Channel A
    DAT_RTRA : ADC_DATA_ROUTER
    PORT MAP(
        Clk         => ADC_CLK,
        Rst         => RST_A,
        Sm_Gate_n   => sm_gatea_ntemp,

        Dat_Mode    => DAT_MODEA,
        Data        => ad_q,
        DecDiv      => DECDIV_A,

        Fifo_Dat    => fifo_dat_a,

        Fen_n       => fena_n
        );

    -- ADC Channel B
    DAT_RTRB : ADC_DATA_ROUTER
    PORT MAP(
        Clk         => ADC_CLK,
        Rst         => RST_B,
        Sm_Gate_n   => sm_gateb_ntemp,

        Dat_Mode    => DAT_MODEB,
        Data        => bd_q,
        DecDiv      => DECDIV_B,

        Fifo_Dat    => fifo_dat_b,

        Fen_n       => fenb_n
        );

    fena            <= NOT fena_n;
    fenb            <= NOT fenb_n;

    -------------------------------------------------------------
    -- *************** Instantiate User Blocks *************** --
    -------------------------------------------------------------

    -- ADC Channel A
    USER_BLOCKA : DDC_USER_BLOCK
    PORT MAP(
        Clk             => ADC_CLK,
        Fen_In          => fena,
    
        Fifo_Dat_In     => fifo_dat_a,
    
        Fifo_Dat_Out    => fifo_dat_ua,
    
        Fen_Out         => fena_ub,
		  
		  Clk_12			   => CLK_12,
		  
		  G_addr			   => G_ADDR,
		  
		  G_data    		=> G_DATA,
		  
		  G_sel			   => G_SEL,
		  
		  G_wr				=> G_WR,
	 
	     K_addr   		   => K_ADDR,
	 
		  K_data			   => K_DATA,
	 
		  K_sel			   => K_SEL,
	 
		  K_wr				=> K_WR,
	 
		  Stop				=> STOP,
	 
		  G_readcoef		=> G_READCOEF,  
	 
		  K_readcoef		=> K_READCOEF,
			
		  Rx_gate			=> RX_GATE
		  
    );


    -- ADC Channel B
    USER_BLOCKB : USER_BLOCK
    PORT MAP(
        Clk             => ADC_CLK,
        Fen_In          => fenb,
    
        Fifo_Dat_In     => fifo_dat_b,
    
        Fifo_Dat_Out    => fifo_dat_ub,
    
        Fen_Out         => fenb_ub
    );

    -------------------------------------------------------------
    -- ****************** Instantiate FIFOs ****************** --
    -------------------------------------------------------------

    -- ADC Channel A
    FIFO_ADCA: fifo_d2k_w32_r64
    PORT MAP(
        Rd_Clk              => LCL_CLK,
        Rd_En               => RD_EN_A,
        Rst                 => RST_A,
        Wr_Clk              => ADC_CLK,
        Wr_En               => fena_ub,

        Din                 => fifo_dat_ua,
        Prog_Empty_Thresh   => PROG_EMPTY_THRESH_A,
        Prog_Full_Thresh    => PROG_FULL_THRESH_A,

        Dout                => douta_fifo,

        Almost_Empty        => OPEN,
        Almost_Full         => OPEN,
        Empty               => EF_A,
        Full                => FF_A,
        Prog_Empty          => ae_a,
        Prog_Full           => af_a
        );

    -- ADC Channel B
    FIFO_ADCB: fifo_d2k_w32_r64
    PORT MAP(
        Rd_Clk              => LCL_CLK,
        Rd_En               => RD_EN_B,
        Rst                 => RST_B,
        Wr_Clk              => ADC_CLK,
        Wr_En               => fenb_ub,

        Din                 => fifo_dat_ub,
        Prog_Empty_Thresh   => PROG_EMPTY_THRESH_B,
        Prog_Full_Thresh    => PROG_FULL_THRESH_B,

        Dout                => doutb_fifo,

        Almost_Empty        => OPEN,
        Almost_Full         => OPEN,
        Empty               => EF_B,
        Full                => FF_B,
        Prog_Empty          => ae_b,
        Prog_Full           => af_b
        );

    -------------------------------------------------------------
    -- **************** Generate DMA Requests **************** --
    -------------------------------------------------------------

    PROCESS (ae_a, af_a, LCL_CLK, RST_A)
    BEGIN
        if (RST_A = '1') then
            REQA  <= '0';
        elsif (rising_edge(LCL_CLK)) then
            faeq1_a <= ae_a;
            faeq2_a <= faeq1_a;
            fafq1_a <= af_a;
            fafq2_a <= fafq1_a;
            if ((faeq1_a = '1') AND (faeq2_a = '1')) then
                REQA    <= '0';
            elsif ((fafq1_a = '1') AND (fafq2_a = '1')) then
                REQA    <= '1';
           end if;
        end if;
    END PROCESS;

    PROCESS (ae_b, af_b, LCL_CLK, RST_B)
    BEGIN
        if (RST_B = '1') then
            REQB  <= '0';
        elsif (rising_edge(LCL_CLK)) then
            faeq1_b <= ae_b;
            faeq2_b <= faeq1_b;
            fafq1_b <= af_b;
            fafq2_b <= fafq1_b;
            if ((faeq1_b = '1') AND (faeq2_b = '1')) then
                REQB    <= '0';
            elsif ((fafq1_b = '1') AND (fafq2_b = '1')) then
                REQB    <= '1';
           end if;
        end if;
    END PROCESS;

    -------------------------------------------------------------
    -- ************ Output  Assignment Statements ************ --
    -------------------------------------------------------------

    ADCA_PACKED_DATA    <= fifo_dat_ua;
    ADCB_PACKED_DATA    <= fifo_dat_ub;

    DOUTA   <= (douta_fifo(31 downto 0) &
                douta_fifo(63 downto 32)) when (BYTESWAP = '0')
                else (douta_fifo(7 downto 0) &
                        douta_fifo(15 downto 8) &
                            douta_fifo(23 downto 16) &
                            douta_fifo(31 downto 24) &
                                douta_fifo(39 downto 32) &
                                douta_fifo(47 downto 40) &
                                    douta_fifo(55 downto 48) &
                                    douta_fifo(63 downto 56));

    DOUTB   <= (doutb_fifo(31 downto 0) &
                doutb_fifo(63 downto 32)) when (BYTESWAP = '0')
                else (doutb_fifo(7 downto 0) &
                        doutb_fifo(15 downto 8) &
                            doutb_fifo(23 downto 16) &
                            doutb_fifo(31 downto 24) &
                                doutb_fifo(39 downto 32) &
                                doutb_fifo(47 downto 40) &
                                    doutb_fifo(55 downto 48) &
                                    doutb_fifo(63 downto 56));

    FAE_A   <= ae_a;
    FAE_B   <= ae_b;

    FAF_A   <= af_a;
    FAF_B   <= af_b;

    WR_EN_A <= fena_ub;
    WR_EN_B <= fenb_ub;

END STRUCTURE;