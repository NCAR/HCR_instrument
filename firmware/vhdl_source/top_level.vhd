-----------------------------------------------------------------
-- **** Top Level VHDL for Pentek Model 7142 Signal FPGA, **** --
-- ********************** in a  Virtex4 ********************** --
-----------------------------------------------------------------
-- Title        : Top Level
-- Project      : Model 7142, Signal FPGA
-----------------------------------------------------------------
-- Filename     : TOP_LEVEL.VHD
-- Author       : AB - Adapted from module TOP_VP50.VHD in the
--                  Model 7140 User FPGA
-- Created      : 01/12/06
-- Last Modified: 03/22/07
-- Modified by  : Marc A. Lee, formatted for GateFlow
--                  (Model 4953-142, Option 055)
--                  Pentek, Inc.
--                  One Park Way,
--                  Upper Saddle River, NJ 07458
--                  (201) 818-5900
--                  www.pentek.com
-----------------------------------------------------------------
--  Change log  :
--      10/07/05:  Preliminary formatting for GateFlow (4953-140)
--      10/22/05:  Rev. D update:  Add output Trig_Reached to
--                  component FIFO_EN_GEN;  Add outputs
--                  Mem[1:0]_Trig_Reg_[H:L](15:0) to component
--                  MEMORY_APP;  Add inputs Mem[1:0]_Trig_Reg_
--                  [H:L](15:0) to component CNTRL_REG;  Add
--                  signals mem[1:0]_trig_reg[h:l](15:0) and
--                  fifo_adc[a:b]_trig_reached;  Use true states
--                  of (dac/ddc)_sync_masks to create outputs
--                  DAC_PHSTR and GC_SYNCA_N;  Append signals
--                  fifo_adc[a:b]_trig_reached to signal vectors
--                  data[0:1](15:0).
--      11/07/05:  Files renamed top_vp50.vhd (previous name was
--                  top3000.vhd).  Entity name has also been
--                  changed, from TOP to TOP_VP50.
--      03/09/06:  Added OPEN output ports ALMOST_EMPTY and
--                  ALMOST_FULL to component FIFO1K64TO64 and
--                  its PORT MAP.
--      03/12/06:  To support simulators other than XST and
--                  ModelSim, removed logical negations from PORT
--                  MAPs for Instances CONTROL, DDC_OUT_DAT,
--                  ADCDAT and DACDAT, by creating and
--                  substituting negated signals fifo_adca_en_n,
--                  fifo_adcb_en_n, fifo_daca_en_n,
--                  fifo_dacb_en_n, fifo_ddca_en_n,
--                  fifo_ddcb_en_n, fifo_ddcc_en_n,
--                  fifo_ddcd_en_n and tmp_vlt_int.
--      05/02/06:  For Compatibility with ModelSim simulator,
--                  constants cannot be used in Port Maps.
--                  In port map for RESET_DELAY_SR, substitute
--                  "vcc" for '1'.  In port map for CONTROL,
--                  substitute "vcc" for '1' and "gnd" for '0'.
--                  In port maps for GATE_DACA, GATE_DACB,
--                  GATE_DDCA, GATE_DDCB GATE_DDCC and GATE_DDCD
--                  substitute "gnd" for '0'.
--      05/22/06:  Changes to sub-modules only - Made DAC FIFO
--                  8k deep.  Added Clock input & FIFO_Enable
--                  inputs & outputs to USER_BLOCKs.
--      08/25/06:  Added COMPONENT definition for FDDRRSRE.
--                  Six instances of this component are
--                  instantiated.
--      08/31/06: Re-released with minor changes in comments
--                  for Model 7142 GateFlow kit (4953-142)
--      02/09/07: Reformatted all Port Maps such that ports are
--                  listed in same order as component declara-
--                  tions.
--      02/12/07: Commented out the "range 0 to 15" in the
--                  declaratioins of integer signals addrq,
--                  addrx and count.  Created std_logic signal
--                  tmp_vlt_int1 to use in Control Register
--                  Port Map, in place of (NOT TMP_VLT_INT1_N),
--                  because ModelSim won't allow logical
--                  expressions in Port Maps.
--      03/14/07: Rev. A GateFlow update - update Coregen FIFOs
--                  to latest IP (fifo_generator_v3_2).
--                  Component FIFO1K64TO64 becomes
--                  fifo_d1k_w64_r64.
--      03/15/07: Port kit to VLX100 FPGA - removed references
--                  to VSX55 and Option 055 above.
--      03/22/07: Commented out unused input port Dcm_Clk_loss
--                  and unused output port Fifos_Rdy of CTRLREG,
--                  in declaration and Port Map.  Commented out
--                  many unused SIGNALs (leftovers from 7140).
--                  Connected SIGNALs lvds(2:1)_rc_out to O/P
--                  buffers for LVDS(2:1)_RC_OUT(P:N), in place
--                  of deleted SIGNALs lvds(2:1)_rc_out_buf,
--                  which had no driver.  Updated cross-referen-
--                  ces to Block Diagram.
--      03/28/07: Removed leftover comment from 7140 code stating
--                  that FLASH_RP_N is not connected - in 7142,
--                  it is.
--      10/19/07 - Add "Signal FPGA" to Project Name field in
--                  header (line 6).  Remove same from Title
--                  field (line 5).
-- *********************************************************** --

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

LIBRARY UNISIM;
USE     UNISIM.vcomponents.all;

ENTITY TOP_LEVEL is
PORT (
    -- ADC clock, control, data & overrange bits
    ADC_CLKI        : in  std_logic;
    ADC_OVRA        : in  std_logic;
    ADC_OVRB        : in  std_logic;
    ADC_OVRC        : in  std_logic;
    ADC_OVRD        : in  std_logic;

    ADC_DA          : in  std_logic_vector (13 downto 0);
    ADC_DB          : in  std_logic_vector (13 downto 0);
    ADC_DC          : in  std_logic_vector (13 downto 0);
    ADC_DD          : in  std_logic_vector (13 downto 0);

    CLKSEL_ADC      : out std_logic_vector (1 downto 0);

    CLKEN_ADC       : out std_logic;

    -- Clock Adjust
    ADJ_CLK         : out std_logic;

    -- Sync Bus Controls
    BUSA_MASTER     : out std_logic;
    BUSA_TERM       : out std_logic;
    BUSB_MASTER     : out std_logic;
    BUSB_TERM       : out std_logic;

    -- Valid Clock detect signals
    CLK_DETA        : in  std_logic;
    CLK_DETB        : in  std_logic;

    -- DAC clock, controls & data
    DAC_CLKI        : in  std_logic;
    DAC_SDO         : in  std_logic;
    DAC_PLLLOCK     : in  std_logic;

    CLKSEL_DAC      : out std_logic_vector (1 downto 0);
    DAC_DA          : out std_logic_vector (15 downto 0);
    DAC_DB          : out std_logic_vector (15 downto 0);

    CLKEN_DAC       : out std_logic;
    DAC_PHSTR       : out std_logic;
    DAC_QFLAG       : out std_logic;
    DAC_RESET_N     : out std_logic;
    DAC_SCLK        : out std_logic;
    DAC_SDEN_N      : out std_logic;
    DAC_SDIO        : out std_logic;
    DAC_TXEN        : out std_logic;
    PLLVDD          : out std_logic;

    -- Delay Memory 0 signals
    DDR0_FB0IN      : in  std_logic;
    DDR0_FB1IN      : in  std_logic;

    DDR0_DQ         :inout std_logic_vector(31 downto 0)
                                            := (OTHERS => 'Z');
    DDR0_DQS        :inout std_logic_vector(3 downto 0)
                                            := (OTHERS => 'Z');
    DDR0_DQSB       :inout std_logic_vector(3 downto 0)
                                            := (OTHERS => 'Z');

    DDR0_ADDRESS    : out std_logic_vector (14 downto 0);
    DDR0_BA         : out std_logic_vector (2 downto 0);
    DDR0_DM         : out std_logic_vector (3 downto 0);

    DDR0_CASB       : out std_logic;
    DDR0_CKE        : out std_logic;
    DDR0_CLK        : out std_logic;
    DDR0_CLKB       : out std_logic;
    DDR0_CSB        : out std_logic;
    DDR0_FB0OUT     : out std_logic;
    DDR0_FB1OUT     : out std_logic;
    DDR0_ODT        : out std_logic;
    DDR0_RASB       : out std_logic;
    DDR0_WEB        : out std_logic;

    -- Delay Memory 1 signals
    DDR1_FB0IN      : in  std_logic;
    DDR1_FB1IN      : in  std_logic;

    DDR1_DQ         :inout std_logic_vector(31 downto 0)
                                            := (OTHERS => 'Z');
    DDR1_DQS        :inout std_logic_vector(3 downto 0)
                                            := (OTHERS => 'Z');
    DDR1_DQSB       :inout std_logic_vector(3 downto 0)
                                            := (OTHERS => 'Z');

    DDR1_ADDRESS    : out std_logic_vector (14 downto 0);
    DDR1_BA         : out std_logic_vector (2 downto 0);
    DDR1_DM         : out std_logic_vector (3 downto 0);

    DDR1_CASB       : out std_logic;
    DDR1_CKE        : out std_logic;
    DDR1_CLK        : out std_logic;
    DDR1_CLKB       : out std_logic;
    DDR1_CSB        : out std_logic;
    DDR1_FB0OUT     : out std_logic;
    DDR1_FB1OUT     : out std_logic;
    DDR1_ODT        : out std_logic;
    DDR1_RASB       : out std_logic;
    DDR1_WEB        : out std_logic;

    -- Delay Memory 2 signals
    DDR2_FB0IN      : in  std_logic;
    DDR2_FB1IN      : in  std_logic;

    DDR2_DQ         :inout std_logic_vector(31 downto 0)
                                            := (OTHERS => 'Z');
    DDR2_DQS        :inout std_logic_vector(3 downto 0)
                                            := (OTHERS => 'Z');
    DDR2_DQSB       :inout std_logic_vector(3 downto 0)
                                            := (OTHERS => 'Z');

    DDR2_ADDRESS    : out std_logic_vector (14 downto 0);
    DDR2_BA         : out std_logic_vector (2 downto 0);
    DDR2_DM         : out std_logic_vector (3 downto 0);
 
    DDR2_CASB       : out std_logic;
    DDR2_CKE        : out std_logic;
    DDR2_CLK        : out std_logic;
    DDR2_CLKB       : out std_logic;
    DDR2_CSB        : out std_logic;
    DDR2_FB0OUT     : out std_logic;
    DDR2_FB1OUT     : out std_logic;
    DDR2_ODT        : out std_logic;
    DDR2_RASB       : out std_logic;
    DDR2_WEB        : out std_logic;

    -- External Clock Enables
    EXTCLKA_EN      : out std_logic;
    EXTCLKB_EN      : out std_logic;

    -- The pin below is unconnected
    FLASH_RP_N      : out std_logic;

    -- Gate Signals
    GATEA_IN_N      : in  std_logic;
    GATEA_INT       : in  std_logic;
    GATEA_TTL       : in  std_logic;
    GATEB_IN_N      : in  std_logic;
    GATEB_INT       : in  std_logic;
    GATEB_TTL       : in  std_logic;

    GATEA_DISBL     : out std_logic;
    GATEA_OUT_N     : out std_logic;
    GATEA_SRC       : out std_logic;
    GATEB_DISBL     : out std_logic;
    GATEB_OUT_N     : out std_logic;
    GATEB_SRC       : out std_logic;

    -- I2C signals
    IIC_DAT         :inout std_logic;

    IIC_CLK         : out std_logic;

    -- PCI Local Bus signals
    LADS_N          : in  std_logic;
    LBE0_N          : in  std_logic;
    LBE4_N          : in  std_logic;
    LBLAST_N        : in  std_logic;
    LCLKI           : in  std_logic;
    LHOLD           : in  std_logic;
    LRST_N          : in  std_logic;
    LRW             : in  std_logic;
    LWAIT_N         : in  std_logic;

    LREADY_N        :inout std_logic;

    LAD             :inout std_logic_vector(63 downto 0);
    LSPARE          :inout std_logic_vector(4 downto 0);

    LDREQ_N         : out std_logic_vector (11 downto 0);
    LIRQ_N          : out std_logic_vector (3 downto 0);

    LHOLDA          : out std_logic;

    -- LVDS signals
    LVDS1_GCFB_N    : in  std_logic;
    LVDS1_GCFB_P    : in  std_logic;
    LVDS2_GCFB_N    : in  std_logic;
    LVDS2_GCFB_P    : in  std_logic;
    LVDS3_RC_IN_N   : in  std_logic;
    LVDS3_RC_IN_P   : in  std_logic;
    LVDS4_CTL_N     : in  std_logic;
    LVDS4_CTL_P     : in  std_logic;
    LVDS4_RC_IN_N   : in  std_logic;
    LVDS4_RC_IN_P   : in  std_logic;

    LVDS4_DAT_N     : in  std_logic_vector (3 downto 0);
    LVDS4_DAT_P     : in  std_logic_vector (3 downto 0);

    LVDS1_DAT_N     : out std_logic_vector (15 downto 0);
    LVDS1_DAT_P     : out std_logic_vector (15 downto 0);
    LVDS2_DAT_N     : out std_logic_vector (15 downto 0);
    LVDS2_DAT_P     : out std_logic_vector (15 downto 0);
    LVDS3_DAT_N     : out std_logic_vector (15 downto 0);
    LVDS3_DAT_P     : out std_logic_vector (15 downto 0);
   
    LVDS1_CTL_N     : out std_logic;
    LVDS1_CTL_P     : out std_logic;
    LVDS1_GCLK_N    : out std_logic;
    LVDS1_GCLK_P    : out std_logic;
    LVDS1_RC_OUT_N  : out std_logic;
    LVDS1_RC_OUT_P  : out std_logic;
    LVDS2_CTL_N     : out std_logic;
    LVDS2_CTL_P     : out std_logic;
    LVDS2_GCLK_N    : out std_logic;
    LVDS2_GCLK_P    : out std_logic;
    LVDS2_RC_OUT_N  : out std_logic;
    LVDS2_RC_OUT_P  : out std_logic;
    LVDS3_CTL_N     : out std_logic;
    LVDS3_CTL_P     : out std_logic;

    -- Memory and Reference Clocks
    MEM_CLK_N       : in  std_logic;
    MEM_CLK_P       : in  std_logic;
    REF_CLK_N       : in  std_logic;
    REF_CLK_P       : in  std_logic;

    -- Sync Signals
    SYNCA_IN_N      : in  std_logic;
    SYNCA_TTL       : in  std_logic;
    SYNCB_IN_N      : in  std_logic;
    SYNCB_TTL       : in  std_logic;

    SYNCA_OUT_N     : out std_logic;
    SYNCB_OUT_N     : out std_logic;

    -- Temperature/Voltage Interrupt
    TMP_VLT_INT1_N  : in  std_logic
    );
END TOP_LEVEL;

-----------------------------------------------------------------

ARCHITECTURE STRUCTURE of TOP_LEVEL is

-----------------------------------------------------------------
-- ***************** Component  Declarations ***************** --
-----------------------------------------------------------------
COMPONENT ADC_DATA_PATH
PORT (
    Adc_Clk             : in  std_logic;
    ByteSwap            : in  std_logic;
    Lcl_Clk             : in  std_logic;
    Rd_En_A             : in  std_logic;
    Rd_En_B             : in  std_logic;
    Rst_A               : in  std_logic;
    Rst_B               : in  std_logic;
    Sm_GateA_n          : in  std_logic;
    Sm_GateB_n          : in  std_logic;

    Ad                  : in  std_logic_vector (15 downto 0);
    Bd                  : in  std_logic_vector (15 downto 0);
    Dat_ModeA           : in  std_logic_vector (2 downto 0);
    Dat_ModeB           : in  std_logic_vector (2 downto 0);
    Decdiv_A            : in  std_logic_vector (15 downto 0);
    Decdiv_B            : in  std_logic_vector (15 downto 0);
    Prog_Empty_Thresh_A : in  std_logic_vector (9 downto 0);
    Prog_Empty_Thresh_B : in  std_logic_vector (9 downto 0);
    Prog_Full_Thresh_A  : in  std_logic_vector (10 downto 0);
    Prog_Full_Thresh_B  : in  std_logic_vector (10 downto 0);

    AdcA_Packed_Data    : out std_logic_vector (31 downto 0);
    AdcB_Packed_Data    : out std_logic_vector (31 downto 0);
    DoutA               : out std_logic_vector (63 downto 0);
    DoutB               : out std_logic_vector (63 downto 0);

    Ef_A                : out std_logic;
    Ef_B                : out std_logic;
    Fae_A               : out std_logic;
    Fae_B               : out std_logic;
    Faf_A               : out std_logic;
    Faf_B               : out std_logic;
    Ff_A                : out std_logic;
    Ff_B                : out std_logic;
    ReqA                : out std_logic;
    ReqB                : out std_logic;
    Wr_En_A             : out std_logic;
    Wr_En_B             : out std_logic
	 
    );

END COMPONENT;	 

COMPONENT ADC_DATA_PATH_USER
PORT (
	 Start_Clk				: in  std_logic;
    Adc_Clk             : in  std_logic;
    ByteSwap            : in  std_logic;
    Lcl_Clk             : in  std_logic;
    Rd_En_A             : in  std_logic;
    Rd_En_B             : in  std_logic;
    Rst_A               : in  std_logic;
    Rst_B               : in  std_logic;
    Sm_GateA_n          : in  std_logic;
    Sm_GateB_n          : in  std_logic;

    Ad                  : in  std_logic_vector (15 downto 0);
    Bd                  : in  std_logic_vector (15 downto 0);
    Dat_ModeA           : in  std_logic_vector (2 downto 0);
    Dat_ModeB           : in  std_logic_vector (2 downto 0);
    Decdiv_A            : in  std_logic_vector (15 downto 0);
    Decdiv_B            : in  std_logic_vector (15 downto 0);
    Prog_Empty_Thresh_A : in  std_logic_vector (9 downto 0);
    Prog_Empty_Thresh_B : in  std_logic_vector (9 downto 0);
    Prog_Full_Thresh_A  : in  std_logic_vector (10 downto 0);
    Prog_Full_Thresh_B  : in  std_logic_vector (10 downto 0);

    AdcA_Packed_Data    : out std_logic_vector (31 downto 0);
    AdcB_Packed_Data    : out std_logic_vector (31 downto 0);
    DoutA               : out std_logic_vector (63 downto 0);
    DoutB               : out std_logic_vector (63 downto 0);

    Ef_A                : out std_logic;
    Ef_B                : out std_logic;
    Fae_A               : out std_logic;
    Fae_B               : out std_logic;
    Faf_A               : out std_logic;
    Faf_B               : out std_logic;
    Ff_A                : out std_logic;
    Ff_B                : out std_logic;
    ReqA                : out std_logic;
    ReqB                : out std_logic;
    Wr_En_A             : out std_logic;
    Wr_En_B             : out std_logic;
	 
	 -- For DDC USER BLOCK	 

	 Clk 						: in std_logic;
	 Clk_12					: in std_logic;
	 G_addr					: in std_logic_vector(3 downto 0);
	 G_data					: in std_logic_vector(17 downto 0);
	 G_sel					: in std_logic_vector(1 downto 0);
	 G_wr 					: in std_logic;
	 K_addr					: in std_logic_vector(3 downto 0);
	 K_data					: in std_logic_vector(17 downto 0);
	 K_sel					: in std_logic_vector(2 downto 0);
	 K_wr						: in std_logic;
	 Stop						: in std_logic;
	 G_readcoef				: out std_logic_vector(17 downto 0);
	 K_readcoef				: out std_logic_vector(17 downto 0);
	 Rx_gate					: in std_logic            
	 
    );

END COMPONENT;	 
-----------------------------------------------------------------
-- Multiple Timers to produce the gating signals for DDC.
	COMPONENT MULTITIMER 
   Generic (NTIMERS : integer := 8);
   PORT ( 
			Busclk       : in  std_logic;
         Rst          : in  std_logic;
         Addrwr       : in  std_logic;
         Addrin       : in  std_logic_vector(15 downto 0);
         Datawr       : in  std_logic;
			Timerclk     : in  std_logic;
         Onepps       : in  std_logic;         -- not needed for now??
         Datain       : in  std_logic_vector(15 downto 0);
         Dataout      : inout std_logic_vector(15 downto 0);
         Pulseout     : out std_logic_vector(NTIMERS-1 downto 0);
         Addrout      : out std_logic_vector(15 downto 0));
	END COMPONENT;
-----------------------------------------------------------------
	 -- Filter Start/Stop Latch (User added)	
COMPONENT FILTER_LATCH
PORT (
	 Clk      				: in  std_logic;
	 Stop_in  				: in  std_logic;
	 Stop_out 				: out std_logic);
END COMPONENT;


-----------------------------------------------------------------
	-- DDC DCM; Generates necessary clocks for DDC
COMPONENT DDC_ADV_DCM 
	PORT (
			Rst		  	: in std_logic;
			Adc_clk		: in std_logic;
			Timer_clk	: out std_logic;
--			Filter_clk	: out std_logic;
			Start_clk   : out std_logic;
			Locked		: out std_logic);
	END COMPONENT;	

-----------------------------------------------------------------

COMPONENT BUFG
PORT (
    I       : in  std_logic;

    O       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT BUFGCTRL
PORT (
    Ce0     : in  std_logic;
    Ce1     : in  std_logic;
    I0      : in  std_logic;
    I1      : in  std_logic;
    Ignore0 : in  std_logic;
    Ignore1 : in  std_logic;
    S0      : in  std_logic;
    S1      : in  std_logic;

    O       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT BUFIO
PORT (
    I       : in  std_logic;

    O       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT CLK_DCM
PORT (
    ClkIn_in    : in  std_logic;
    ClkFb_in    : in  std_logic;
    Rst_in      : in  std_logic;

    Clk0_out    : out std_logic;
    Locked_out  : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT CLK_GEN
PORT (
    Lclk    : in  std_logic;
    Rst     : in  std_logic;

    Dac_Sclk: out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT CNTRLREG
PORT (
    Iic_Dat             :inout std_logic;

    Clk                 : in  std_logic;
    ClkA_Loss           : in  std_logic;
    ClkB_Loss           : in  std_logic;
    Dac_Plllock         : in  std_logic;
    Dac_Sclk            : in  std_logic;
    Dac_Sdo             : in  std_logic;
--  Dcm_Clk_Loss        : in  std_logic;
    Dcm_Dac_Locked      : in  std_logic;
    Dcm_Pll_Locked      : in  std_logic;

    Fifo_AdcA_AE        : in  std_logic;
    Fifo_AdcA_AF        : in  std_logic;
    Fifo_AdcA_E         : in  std_logic;
    Fifo_AdcA_En        : in  std_logic;
    Fifo_AdcA_F         : in  std_logic;
    Fifo_AdcA_Trig_Stat : in  std_logic;

    Fifo_AdcB_AE        : in  std_logic;
    Fifo_AdcB_AF        : in  std_logic;
    Fifo_AdcB_E         : in  std_logic;
    Fifo_AdcB_En        : in  std_logic;
    Fifo_AdcB_F         : in  std_logic;
    Fifo_AdcB_Trig_Stat : in  std_logic;

    Fifo_AdcC_AE        : in  std_logic;
    Fifo_AdcC_AF        : in  std_logic;
    Fifo_AdcC_E         : in  std_logic;
    Fifo_AdcC_En        : in  std_logic;
    Fifo_AdcC_F         : in  std_logic;
    Fifo_AdcC_Trig_Stat : in  std_logic;

    Fifo_AdcD_AE        : in  std_logic;
    Fifo_AdcD_AF        : in  std_logic;
    Fifo_AdcD_E         : in  std_logic;
    Fifo_AdcD_En        : in  std_logic;
    Fifo_AdcD_F         : in  std_logic;
    Fifo_AdcD_Trig_Stat : in  std_logic;

    Fifo_DacA_AE        : in  std_logic;
    Fifo_DacA_AF        : in  std_logic;
    Fifo_DacA_E         : in  std_logic;
    Fifo_DacA_En        : in  std_logic;
    Fifo_DacA_F         : in  std_logic;
    Fifo_DacA_Trig_Stat : in  std_logic;

    Fifo_MemR_AE        : in  std_logic;
    Fifo_MemR_AF        : in  std_logic;
    Fifo_MemR_E         : in  std_logic;
    Fifo_MemR_En        : in  std_logic;
    Fifo_MemR_F         : in  std_logic;

    Fifo_MemW_AE        : in  std_logic;
    Fifo_MemW_AF        : in  std_logic;
    Fifo_MemW_E         : in  std_logic;
    Fifo_MemW_En        : in  std_logic;
    Fifo_MemW_F         : in  std_logic;

    Fifo_Test_AE        : in  std_logic;
    Fifo_Test_AF        : in  std_logic;
    Fifo_Test_E         : in  std_logic;
    Fifo_Test_F         : in  std_logic;

    GateA_n             : in  std_logic;
    GateB_n             : in  std_logic;

    Ovld1_Int           : in  std_logic;
    Ovld2_Int           : in  std_logic;
    Ovld3_Int           : in  std_logic;
    Ovld4_Int           : in  std_logic;

    Reg_Sel             : in  std_logic;
    Rst                 : in  std_logic;

    SyncA_N             : in  std_logic;
    SyncB_N             : in  std_logic;

    Temp_Int            : in  std_logic;
    Wepls               : in  std_logic;

    Addr                : in  std_logic_vector (8 downto 0);
    Dat_In              : in  std_logic_vector (15 downto 0);
    IO_Data_In          : in  std_logic_vector (15 downto 0);

    Fifo_AdcA_Pre_Count_H
                        : in  std_logic_vector (15 downto 0);
    Fifo_AdcA_Pre_Count_L
                        : in  std_logic_vector (15 downto 0);
    Fifo_AdcB_Pre_Count_H
                        : in  std_logic_vector (15 downto 0);
    Fifo_AdcB_Pre_Count_L
                        : in  std_logic_vector (15 downto 0);
    Fifo_AdcC_Pre_Count_H
                        : in  std_logic_vector (15 downto 0);
    Fifo_AdcC_Pre_Count_L
                        : in  std_logic_vector (15 downto 0);
    Fifo_AdcD_Pre_Count_H
                        : in  std_logic_vector (15 downto 0);
    Fifo_AdcD_Pre_Count_L
                        : in  std_logic_vector (15 downto 0);

    Mem0_End_Reg_H      : in  std_logic_vector (15 downto 0);
    Mem0_End_Reg_L      : in  std_logic_vector (15 downto 0);
    Mem0_Trig_Reg_H     : in  std_logic_vector (15 downto 0);
    Mem0_Trig_Reg_L     : in  std_logic_vector (15 downto 0);

    Mem1_End_Reg_H      : in  std_logic_vector (15 downto 0);
    Mem1_End_Reg_L      : in  std_logic_vector (15 downto 0);
    Mem1_Trig_Reg_H     : in  std_logic_vector (15 downto 0);
    Mem1_Trig_Reg_L     : in  std_logic_vector (15 downto 0);

    Mem2_End_Reg_H      : in  std_logic_vector (15 downto 0);
    Mem2_End_Reg_L      : in  std_logic_vector (15 downto 0);

    Dat_Out             : out std_logic_vector (15 downto 0);
    Extd_Addr           : out std_logic_vector (15 downto 0);

    Fifo_AdcA_Count_AE  : out std_logic_vector (15 downto 0);
    Fifo_AdcA_Count_AF  : out std_logic_vector (15 downto 0);
    Fifo_AdcA_DecDiv    : out std_logic_vector (15 downto 0);
    Fifo_AdcA_PackMode  : out std_logic_vector (2 downto 0);
    Fifo_AdcA_Post_Length_H
                        : out std_logic_vector (15 downto 0);
    Fifo_AdcA_Post_Length_L
                        : out std_logic_vector (15 downto 0);
    Fifo_AdcA_TrigLen_H : out std_logic_vector (15 downto 0);
    Fifo_AdcA_TrigLen_L : out std_logic_vector (15 downto 0);

    Fifo_AdcB_Count_AE  : out std_logic_vector (15 downto 0);
    Fifo_AdcB_Count_AF  : out std_logic_vector (15 downto 0);
    Fifo_AdcB_DecDiv    : out std_logic_vector (15 downto 0);
    Fifo_AdcB_PackMode  : out std_logic_vector (2 downto 0);
    Fifo_AdcB_Post_Length_H
                        : out std_logic_vector (15 downto 0);
    Fifo_AdcB_Post_Length_L
                        : out std_logic_vector (15 downto 0);
    Fifo_AdcB_TrigLen_H : out std_logic_vector (15 downto 0);
    Fifo_AdcB_TrigLen_L : out std_logic_vector (15 downto 0);

    Fifo_AdcC_Count_AE  : out std_logic_vector (15 downto 0);
    Fifo_AdcC_Count_AF  : out std_logic_vector (15 downto 0);
    Fifo_AdcC_DecDiv    : out std_logic_vector (15 downto 0);
    Fifo_AdcC_PackMode  : out std_logic_vector (2 downto 0);
    Fifo_AdcC_Post_Length_H
                        : out std_logic_vector (15 downto 0);
    Fifo_AdcC_Post_Length_L
                        : out std_logic_vector (15 downto 0);
    Fifo_AdcC_TrigLen_H : out std_logic_vector (15 downto 0);
    Fifo_AdcC_TrigLen_L : out std_logic_vector (15 downto 0);

    Fifo_AdcD_Count_AE  : out std_logic_vector (15 downto 0);
    Fifo_AdcD_Count_AF  : out std_logic_vector (15 downto 0);
    Fifo_AdcD_DecDiv    : out std_logic_vector (15 downto 0);
    Fifo_AdcD_PackMode  : out std_logic_vector (2 downto 0);
    Fifo_AdcD_Post_Length_H
                        : out std_logic_vector (15 downto 0);
    Fifo_AdcD_Post_Length_L
                        : out std_logic_vector (15 downto 0);
    Fifo_AdcD_TrigLen_H : out std_logic_vector (15 downto 0);
    Fifo_AdcD_TrigLen_L : out std_logic_vector (15 downto 0);

    Fifo_DacA_Count_AE  : out std_logic_vector (15 downto 0);
    Fifo_DacA_Count_AF  : out std_logic_vector (15 downto 0);
    Fifo_DacA_PackMode  : out std_logic_vector (2 downto 0);
    Fifo_DacA_Post_Length_H
                        : out std_logic_vector (15 downto 0);
    Fifo_DacA_Post_Length_L
                        : out std_logic_vector (15 downto 0);
    Fifo_DacA_TrigLen_H : out std_logic_vector (15 downto 0);
    Fifo_DacA_TrigLen_L : out std_logic_vector (15 downto 0);

    Fifo_MemR_Count_AE  : out std_logic_vector (15 downto 0);
    Fifo_MemR_Count_AF  : out std_logic_vector (15 downto 0);

    Fifo_MemW_Count_AE  : out std_logic_vector (15 downto 0);
    Fifo_MemW_Count_AF  : out std_logic_vector (15 downto 0);

    Fifo_Test_Count_AE  : out std_logic_vector (15 downto 0);
    Fifo_Test_Count_AF  : out std_logic_vector (15 downto 0);

    Int                 : out std_logic_vector (3 downto 0);
    IO_Data_Out         : out std_logic_vector (15 downto 0);

    Mem_Ctrl_Reg        : out std_logic_vector (15 downto 0);

    Mem0_Depth_Reg_H    : out std_logic_vector (15 downto 0);
    Mem0_Depth_Reg_L    : out std_logic_vector (15 downto 0);
    Mem0_Start_Reg_H    : out std_logic_vector (15 downto 0);
    Mem0_Start_Reg_L    : out std_logic_vector (15 downto 0);

    Mem1_Depth_Reg_H    : out std_logic_vector (15 downto 0);
    Mem1_Depth_Reg_L    : out std_logic_vector (15 downto 0);
    Mem1_Start_Reg_H    : out std_logic_vector (15 downto 0);
    Mem1_Start_Reg_L    : out std_logic_vector (15 downto 0);

    Mem2_Depth_Reg_H    : out std_logic_vector (15 downto 0);
    Mem2_Depth_Reg_L    : out std_logic_vector (15 downto 0);
    Mem2_Start_Reg_H    : out std_logic_vector (15 downto 0);
    Mem2_Start_Reg_L    : out std_logic_vector (15 downto 0);

    Adc_Clk_Sel         : out std_logic;
    Bus_Master_A        : out std_logic;
    Bus_Master_B        : out std_logic;
    Bus_Term_A          : out std_logic;
    Bus_Term_B          : out std_logic;
    ByteSwap            : out std_logic;

    Clk_Src_A           : out std_logic;
    Clk_Src_B           : out std_logic;

    Dac_Clk_Sel         : out std_logic;
    Dac_QFlag           : out std_logic;
    Dac_Reset_n         : out std_logic;
    Dac_Sden_n          : out std_logic;
    Dac_Sdio            : out std_logic;
    Dac_Sync_Mask       : out std_logic;
    DacMode             : out std_logic;

    Dcm_Clk_Sel         : out std_logic;
    Dcm_Rst             : out std_logic;

    Ext_Clk_A           : out std_logic;
    Ext_Clk_B           : out std_logic;
    Ext_Gate_A          : out std_logic;
    Ext_Gate_B          : out std_logic;
    Ext_Sync_A          : out std_logic;
    Ext_Sync_B          : out std_logic;

    Fifo_AdcA_Arm       : out std_logic;
    Fifo_AdcA_Clear     : out std_logic;
    Fifo_AdcA_Gate_Disbl: out std_logic;
    Fifo_AdcA_Gate_Enable
                        : out std_logic;
    Fifo_AdcA_Gate_Selb : out std_logic;
    Fifo_AdcA_Hold      : out std_logic;
    Fifo_AdcA_Pretrig   : out std_logic;
    Fifo_AdcA_Rst       : out std_logic;
    Fifo_AdcA_Trig      : out std_logic;

    Fifo_AdcB_Arm       : out std_logic;
    Fifo_AdcB_Clear     : out std_logic;
    Fifo_AdcB_Gate_Disbl: out std_logic;
    Fifo_AdcB_Gate_Enable
                        : out std_logic;
    Fifo_AdcB_Gate_Selb : out std_logic;
    Fifo_AdcB_Hold      : out std_logic;
    Fifo_AdcB_Pretrig   : out std_logic;
    Fifo_AdcB_Rst       : out std_logic;
    Fifo_AdcB_Trig      : out std_logic;

    Fifo_AdcC_Arm       : out std_logic;
    Fifo_AdcC_Clear     : out std_logic;
    Fifo_AdcC_Gate_Disbl: out std_logic;
    Fifo_AdcC_Gate_Enable
                        : out std_logic;
    Fifo_AdcC_Gate_Selb : out std_logic;
    Fifo_AdcC_Hold      : out std_logic;
    Fifo_AdcC_Pretrig   : out std_logic;
    Fifo_AdcC_Rst       : out std_logic;
    Fifo_AdcC_Trig      : out std_logic;

    Fifo_AdcD_Arm       : out std_logic;
    Fifo_AdcD_Clear     : out std_logic;
    Fifo_AdcD_Gate_Disbl: out std_logic;
    Fifo_AdcD_Gate_Enable
                        : out std_logic;
    Fifo_AdcD_Gate_Selb : out std_logic;
    Fifo_AdcD_Hold      : out std_logic;
    Fifo_AdcD_Pretrig   : out std_logic;
    Fifo_AdcD_Rst       : out std_logic;
    Fifo_AdcD_Trig      : out std_logic;

    Fifo_DacA_Clear     : out std_logic;
    Fifo_DacA_Gate_Disbl: out std_logic;
    Fifo_DacA_Gate_Enable
                        : out std_logic;
    Fifo_DacA_Gate_Selb : out std_logic;
    Fifo_DacA_Hold      : out std_logic;
    Fifo_DacA_Rst       : out std_logic;
    Fifo_DacA_Trig      : out std_logic;

    Fifo_MemR_Rst       : out std_logic;
    Fifo_MemW_Rst       : out std_logic;

    Fifo_Test_Rst       : out std_logic;
--  Fifos_Rdy           : out std_logic;

    Gate_Pol_A          : out std_logic;
    Gate_Pol_B          : out std_logic;
    Gate_Src_A          : out std_logic;
    Gate_Src_B          : out std_logic;
    GateGo_A            : out std_logic;
    GateGo_B            : out std_logic;

    Iic_Clk             : out std_logic;
    Osc_Disbl_A         : out std_logic;
    Osc_Disbl_B         : out std_logic;
    PllVdd              : out std_logic;

    Sync_Pol_A          : out std_logic;
    Sync_Pol_B          : out std_logic;
    Sync_Src_A          : out std_logic;
    Sync_Src_B          : out std_logic;
    SyncGo_A            : out std_logic;
    SyncGo_B            : out std_logic;

    Test_Mode           : out std_logic;

	 --  USER Required Ports for Digital Down Converter (DDC)

	 K_addr			      : out std_logic_vector (15 downto 0);
	 K_data			      : out std_logic_vector (17 downto 0);
	 K_wr				      : out std_logic;
	 G_addr			      : out std_logic_vector (15 downto 0);
	 G_data			      : out std_logic_vector (17 downto 0);
	 G_wr 			      : out std_logic;
	 K_readcoef		      : in std_logic_vector (17 downto 0);
	 G_readcoef		      : in std_logic_vector (17 downto 0);
	 
	 --  USER Required Ports for Multi-Timers
	 
	 MT_addr_reg 			: out std_logic_vector(15 downto 0);	--MultiTimer Address Register
	 MT_data_reg 			: out std_logic_vector(15 downto 0);	--MultiTimer Data Register
	 MT_addr_wr  			: out std_logic;								--MultiTimer Address Write
	 MT_data_wr  			: out std_logic								--MultiTimer Data Write

    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT DAC_DATA_PATH
PORT (
    ByteSwap            : in  std_logic;
    Dac_Clk             : in  std_logic;
    Lcl_Clk             : in  std_logic;
    Rst_A               : in  std_logic;
    Sm_GateA_n          : in  std_logic;
    Wr_En_A             : in  std_logic;

    Dat_Mode            : in  std_logic_vector (2 downto 0);
    Din_A               : in  std_logic_vector (63 downto 0);
    Fifo_Dacm_Dout      : in  std_logic_vector (31 downto 0);
    Mem_Ctrl_Reg        : in  std_logic_vector (15 downto 0);
    Prog_Empty_Thresh_A : in  std_logic_vector (13 downto 0);
    Prog_Full_Thresh_A  : in  std_logic_vector (12 downto 0);

    Ad                  : out std_logic_vector (15 downto 0);
    Bd                  : out std_logic_vector (15 downto 0);

    Ef_A                : out std_logic;
    Fae_A               : out std_logic;
    Faf_A               : out std_logic;
    Ff_A                : out std_logic;
    Rd_En_A             : out std_logic;
    ReqA                : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT DCM
--  pragma translate_off
GENERIC (
    Clkdv_Divide            : real      := 16.0;
    Clkout_Phase_Shift      : string    := "FIXED";
    Dll_Frequency_Mode      : string    := "LOW";
    Duty_Cycle_Correction   : boolean   := TRUE;
    Phase_Shift             : integer
    );
--  pragma translate_on

PORT (
    Clkfb       : in  std_logic;
    Clkin       : in  std_logic;
    Dssen       : in  std_logic;
    Psclk       : in  std_logic;
    Psen        : in  std_logic;
    Psincdec    : in  std_logic;
    Rst         : in  std_logic;

    Status      : out std_logic_vector (7 downto 0);

    Clk0        : out std_logic;
    Clk180      : out std_logic;
    Clk270      : out std_logic;
    Clk2x       : out std_logic;
    Clk2x180    : out std_logic;
    Clk90       : out std_logic;
    Clkdv       : out std_logic;
    Clkfx       : out std_logic;
    Clkfx180    : out std_logic;
    Locked      : out std_logic;
    Psdone      : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT FDDRRSE
PORT (
    C0      : in  std_logic;
    C1      : in  std_logic;
    Ce      : in  std_logic;
    D0      : in  std_logic;
    D1      : in  std_logic;
    R       : in  std_logic;
    S       : in  std_logic;

    Q       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT FIFO_EN_GEN
PORT (
    Arm             : in  std_logic;
    Clk             : in  std_logic;
    Gate_Disbl      : in  std_logic;
    Gate_Enable     : in  std_logic;
    Gate_Selb       : in  std_logic;
    Gate_Trig_Sel   : in  std_logic;
    GateA_In_n      : in  std_logic;
    GateB_In_n      : in  std_logic;
    Hold_Mode       : in  std_logic;
    Pretrig         : in  std_logic;
    Rst             : in  std_logic;
    Trig_Clear      : in  std_logic;

    Post_Length_H   : in  std_logic_vector (15 downto 0);
    Post_Length_L   : in  std_logic_vector (15 downto 0);
    Trig_Length_H   : in  std_logic_vector (15 downto 0);
    Trig_Length_L   : in  std_logic_vector (15 downto 0);

    Pre_Count_H     : out std_logic_vector (15 downto 0);
    Pre_Count_L     : out std_logic_vector (15 downto 0);

    Fifo_En         : out std_logic;
    Trig_Reached    : out std_logic;
    Trig_Stat       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT fifo_d1k_w64_r64
PORT (
    Rd_Clk              : in  std_logic;
    Rd_En               : in  std_logic;
    Rst                 : in  std_logic;
    Wr_Clk              : in  std_logic;
    Wr_En               : in  std_logic;

    Din                 : in  std_logic_vector (63 downto 0);
    Prog_Empty_Thresh   : in  std_logic_vector (9 downto 0);
    Prog_Full_Thresh    : in  std_logic_vector (9 downto 0);

    Dout                : out std_logic_vector (63 downto 0);

    Almost_Empty        : out std_logic;
    Almost_Full         : out std_logic;
    Empty               : out std_logic;
    Full                : out std_logic;
    Prog_Empty          : out std_logic;
    Prog_Full           : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT IBUFDS_LVDS_25_DT
PORT (
    I       : in  std_logic;
    Ib      : in  std_logic;

    O       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT IBUFG
PORT (
    I       : in  std_logic;

    O       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT IBUFGDS_LVDS_25
PORT (
    I       : in  std_logic;
    Ib      : in  std_logic;

    O       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT IBUFGDS_LVPECL_25
PORT (
    I       : in  std_logic;
    Ib      : in  std_logic;

    O       : out std_logic
    );
END COMPONENT;

----------------------------------------------------------------

COMPONENT IDELAYCTRL
PORT (
    Refclk  : in  std_logic;
    Rst     : in  std_logic;

    Rdy     : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT IOBUF
PORT (
    I       : in  std_logic;
    T       : in  std_logic;

    Io      :inout std_logic;

    O       : out std_logic
    );
END COMPONENT;

----------------------------------------------------------------

COMPONENT MEMORY_APP
PORT (
    Adc_Clk             : in  std_logic;
    Byteswap            : in  std_logic;
    Cal_Clk             : in  std_logic;
    Dac_Clk             : in  std_logic;

    Ddr0_Fb0in          : in  std_logic;
    Ddr0_Fb1in          : in  std_logic;
    Ddr1_Fb0in          : in  std_logic;
    Ddr1_Fb1in          : in  std_logic;
    Ddr2_Fb0in          : in  std_logic;
    Ddr2_Fb1in          : in  std_logic;

    Fifo_AdcAm_Rst      : in  std_logic;
    Fifo_AdcAm_Wren     : in  std_logic;
    Fifo_AdcBm_Rst      : in  std_logic;
    Fifo_AdcBm_Wren     : in  std_logic;
    Fifo_Dacm_Rden      : in  std_logic;
    Fifo_Dacm_Rst       : in  std_logic;
    Fifo_Memr_Rst       : in  std_logic;
    Fifo_Memr_Sel       : in  std_logic;
    Fifo_Memw_Rst       : in  std_logic;
    Fifo_Memw_Sel       : in  std_logic;

    Idelayctrl_Rdy      : in  std_logic;
    Int_Reset_n         : in  std_logic;
    Lclk                : in  std_logic;
    Sclk                : in  std_logic;
    Wclk                : in  std_logic;

    AdcA_Data           : in  std_logic_vector (31 downto 0);
    AdcB_Data           : in  std_logic_vector (31 downto 0);

    Ddr0_Dq_In          : in  std_logic_vector (31 downto 0);
    Ddr0_Dqs_in         : in  std_logic_vector (3 downto 0);
    Ddr1_Dq_In          : in  std_logic_vector (31 downto 0);
    Ddr1_Dqs_in         : in  std_logic_vector (3 downto 0);
    Ddr2_Dq_In          : in  std_logic_vector (31 downto 0);
    Ddr2_Dqs_in         : in  std_logic_vector (3 downto 0);

    Fifo_Memr_Count_AE  : in  std_logic_vector (9 downto 0);
    Fifo_Memr_Count_AF  : in  std_logic_vector (9 downto 0);
    Fifo_Memw_Count_AE  : in  std_logic_vector (9 downto 0);
    Fifo_Memw_Count_AF  : in  std_logic_vector (9 downto 0);

    Fifo_Memw_Din       : in  std_logic_vector (63 downto 0);
    Mem_Ctrl_Reg        : in  std_logic_vector (15 downto 0);

    Mem0_Depth_Reg_H    : in  std_logic_vector (15 downto 0);
    Mem0_Depth_Reg_L    : in  std_logic_vector (15 downto 0);
    Mem0_Start_Reg_H    : in  std_logic_vector (15 downto 0);
    Mem0_Start_Reg_L    : in  std_logic_vector (15 downto 0);
    Mem1_Depth_Reg_H    : in  std_logic_vector (15 downto 0);
    Mem1_Depth_Reg_L    : in  std_logic_vector (15 downto 0);
    Mem1_Start_Reg_H    : in  std_logic_vector (15 downto 0);
    Mem1_Start_Reg_L    : in  std_logic_vector (15 downto 0);
    Mem2_Depth_Reg_H    : in  std_logic_vector (15 downto 0);
    Mem2_Depth_Reg_L    : in  std_logic_vector (15 downto 0);
    Mem2_Start_Reg_H    : in  std_logic_vector (15 downto 0);
    Mem2_Start_Reg_L    : in  std_logic_vector (15 downto 0);

    Ddr0_Address        : out std_logic_vector (15 downto 0);
    Ddr0_Ba             : out std_logic_vector (2 downto 0);
    Ddr0_Cke            : out std_logic_vector (7 downto 0);
    Ddr0_Cs_n           : out std_logic_vector (7 downto 0);
    Ddr0_Dm             : out std_logic_vector (3 downto 0);
    Ddr0_Dq_oe_n        : out std_logic_vector (31 downto 0);
    Ddr0_Dq_out         : out std_logic_vector (31 downto 0);
    Ddr0_Dqs_oe_n       : out std_logic_vector (3 downto 0);
    Ddr0_Dqs_out        : out std_logic_vector (3 downto 0);

    Ddr1_Address        : out std_logic_vector (15 downto 0);
    Ddr1_Ba             : out std_logic_vector (2 downto 0);
    Ddr1_Cke            : out std_logic_vector (7 downto 0);
    Ddr1_Cs_n           : out std_logic_vector (7 downto 0);
    Ddr1_Dm             : out std_logic_vector (3 downto 0);
    Ddr1_Dq_oe_n        : out std_logic_vector (31 downto 0);
    Ddr1_Dq_out         : out std_logic_vector (31 downto 0);
    Ddr1_Dqs_oe_n       : out std_logic_vector (3 downto 0);
    Ddr1_Dqs_out        : out std_logic_vector (3 downto 0);

    Ddr2_Address        : out std_logic_vector (15 downto 0);
    Ddr2_Ba             : out std_logic_vector (2 downto 0);
    Ddr2_Cke            : out std_logic_vector (7 downto 0);
    Ddr2_Cs_n           : out std_logic_vector (7 downto 0);
    Ddr2_Dm             : out std_logic_vector (3 downto 0);
    Ddr2_Dq_oe_n        : out std_logic_vector (31 downto 0);
    Ddr2_Dq_out         : out std_logic_vector (31 downto 0);
    Ddr2_Dqs_oe_n       : out std_logic_vector (3 downto 0);
    Ddr2_Dqs_out        : out std_logic_vector (3 downto 0);

    Fifo_Dacm_Dout      : out std_logic_vector (31 downto 0);
    Fifo_Memr_Dout      : out std_logic_vector (63 downto 0);

    Mem0_End_Reg_H      : out std_logic_vector (15 downto 0);
    Mem0_End_Reg_L      : out std_logic_vector (15 downto 0);
    Mem0_Trig_Reg_H     : out std_logic_vector (15 downto 0);
    Mem0_Trig_Reg_L     : out std_logic_vector (15 downto 0);
    Mem1_End_Reg_H      : out std_logic_vector (15 downto 0);
    Mem1_End_Reg_L      : out std_logic_vector (15 downto 0);
    Mem1_Trig_Reg_H     : out std_logic_vector (15 downto 0);
    Mem1_Trig_Reg_L     : out std_logic_vector (15 downto 0);
    Mem2_End_Reg_H      : out std_logic_vector (15 downto 0);
    Mem2_End_Reg_L      : out std_logic_vector (15 downto 0);

    Ddr0_Casb           : out std_logic;
    Ddr0_Fb0out         : out std_logic;
    Ddr0_Fb1out         : out std_logic;
    Ddr0_Odt            : out std_logic;
    Ddr0_Rasb           : out std_logic;
    Ddr0_Web            : out std_logic;

    Ddr1_Casb           : out std_logic;
    Ddr1_Fb0out         : out std_logic;
    Ddr1_Fb1out         : out std_logic;
    Ddr1_Odt            : out std_logic;
    Ddr1_Rasb           : out std_logic;
    Ddr1_Web            : out std_logic;

    Ddr2_Casb           : out std_logic;
    Ddr2_Fb0out         : out std_logic;
    Ddr2_Fb1out         : out std_logic;
    Ddr2_Odt            : out std_logic;
    Ddr2_Rasb           : out std_logic;
    Ddr2_Web            : out std_logic;

    Fifo_Memr_AE        : out std_logic;
    Fifo_Memr_AF        : out std_logic;
    Fifo_Memr_E         : out std_logic;
    Fifo_Memr_F         : out std_logic;
    Fifo_Memr_Req       : out std_logic;

    Fifo_Memw_AE        : out std_logic;
    Fifo_Memw_AF        : out std_logic;
    Fifo_Memw_E         : out std_logic;
    Fifo_Memw_F         : out std_logic;
    Fifo_Memw_Req       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT OBUFDS_LVDS_25
PORT (
    I       : in  std_logic;

    O       : out std_logic;
    Ob      : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT OBUFT
PORT (
    I       : in  std_logic;
    T       : in  std_logic;

    O       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT SDRAM_SYS_CLK_DCM
PORT (
    ClkIn_in    : in  std_logic; 
    Rst_in      : in  std_logic;
 
    Clk0_out    : out std_logic; 
    Clk180_out  : out std_logic; 
    Clk270_out  : out std_logic; 
    ClkDv_out   : out std_logic; 
    Locked_out  : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT SRL16
PORT (
    A0      : in  std_logic;
    A1      : in  std_logic;
    A2      : in  std_logic;
    A3      : in  std_logic;
    Clk     : in  std_logic;
    D       : in  std_logic;

    Q       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------

COMPONENT SYNCGATE_GEN
PORT (
    Clk                 : in  std_logic;
    Ext_SyncGate_En     : in  std_logic;
    Lvds_SyncGate_In_n  : in  std_logic;
    Rst                 : in  std_logic;
    SyncGate_Pol        : in  std_logic;
    SyncGate_Src        : in  std_logic;
    SyncGateGo          : in  std_logic;
    Ttl_SyncGate        : in  std_logic;

    Lvds_SyncGate_Out_n : out std_logic;
    SyncGate_n_Out      : out std_logic;
    SyncGateGo_Rs       : out std_logic
    );
END COMPONENT;

-----------------------------------------------------------------
-- *********************** Attributes ************************ --
-----------------------------------------------------------------

-- ATTRIBUTE Clkdv_Divide           : string;
-- ATTRIBUTE Clkout_Phase_Shift     : string;
-- ATTRIBUTE Dll_Frequency_Mode     : string;
-- ATTRIBUTE Duty_Cycle_Correction  : string;
-- ATTRIBUTE Phase_Shift            : integer;
-- ATTRIBUTE Startup_Wait           : string;

-- ATTRIBUTE Clkdv_Divide       of DCM_INST1: label is "16.0";
-- ATTRIBUTE Clkout_Phase_Shift of DCM_RCLK : label is "FIXED";
-- ATTRIBUTE Clkout_Phase_Shift of DCM_WCLK : label is "FIXED";
-- ATTRIBUTE Dll_Frequency_Mode of DCM_INST1: label is "LOW";
-- ATTRIBUTE Dll_Frequency_Mode of DCM_RCLK : label is "LOW";
-- ATTRIBUTE Dll_Frequency_Mode of U1_DCM   : label is "LOW";
-- ATTRIBUTE Duty_Cycle_Correction
--                              of DCM_INST1: label is "TRUE";
-- ATTRIBUTE Duty_Cycle_Correction
--                              of DCM_RCLK : label is "TRUE";
-- ATTRIBUTE Duty_Cycle_Correction
--                              of U1_DCM   : label is "TRUE";
-- ATTRIBUTE Phase_Shift        of DCM_RCLK : label is 0;
-- ATTRIBUTE Phase_Shift        of DCM_WCLK : label is 230;
-- ATTRIBUTE Startup_Wait       of U1_DCM   : label is "FALSE";

-----------------------------------------------------------------
-- ******************* Signal Declarations ******************* --
-----------------------------------------------------------------

SIGNAL addrq                : integer; --range 0 to 15;
-- SIGNAL addrx             : integer range 0 to 15;
SIGNAL count                : integer; --range 0 to 15;

SIGNAL adc_clk              : std_logic;
SIGNAL adc_clk_buf          : std_logic;
-- SIGNAL adc_clk_lock      : std_logic;
SIGNAL adca_sel             : std_logic;
SIGNAL adcb_sel             : std_logic;
SIGNAL adcc_sel             : std_logic;
SIGNAL adcd_sel             : std_logic;
-- SIGNAL all_dcms_locked   : std_logic;

-- SIGNAL busy              : std_logic;
SIGNAL byteswap             : std_logic;

SIGNAL cal_clk              : std_logic;
-- SIGNAL clk               : std_logic;
-- SIGNAL clk_b             : std_logic;
-- SIGNAL clk_dv16          : std_logic;
-- SIGNAL clk_dv16_o        : std_logic;
-- SIGNAL clk_fb            : std_logic;
-- SIGNAL clk0_buf          : std_logic;
-- SIGNAL clk1x_int_w       : std_logic;
-- SIGNAL clkfb_w           : std_logic;
SIGNAL clksel_adc_int       : std_logic;
SIGNAL clksel_dac_int       : std_logic;

SIGNAL dac_clk              : std_logic;
SIGNAL dac_clk_dcm          : std_logic;
SIGNAL dac_clk_nodcm        : std_logic;
SIGNAL dac_clk_buf          : std_logic;
SIGNAL dac_clk_buf2         : std_logic;
SIGNAL dac_plllock_buf      : std_logic;
SIGNAL dac_plllock_buf2     : std_logic;
SIGNAL dac_sclk_int         : std_logic;
SIGNAL dac_sync_mask        : std_logic;
-- SIGNAL daca_dq_sel       : std_logic;
SIGNAL daca_sel             : std_logic;
-- SIGNAL dacb_dq_sel       : std_logic;
-- SIGNAL dacb_sel          : std_logic;
SIGNAL dacmode              : std_logic;
SIGNAL dacmode_n            : std_logic;

SIGNAL dat_en               : std_logic;

-- SIGNAL dcm_clk_loss      : std_logic;
SIGNAL dcm_clk_sel          : std_logic;
SIGNAL dcm_clk_sel_n        : std_logic;
SIGNAL dcm_dac_locked       : std_logic;
SIGNAL dcm_pll_locked       : std_logic;
SIGNAL dcm_rst              : std_logic;
-- SIGNAL dcm_wclk_lock     : std_logic;
-- SIGNAL dcm1_lock         : std_logic;
-- SIGNAL dcm2_lock         : std_logic;
-- SIGNAL dcm3_lock         : std_logic;

-- SIGNAL dram_w_req        : std_logic;
-- SIGNAL dram_r_req        : std_logic;

SIGNAL ext_gate_a           : std_logic;
SIGNAL ext_gate_b           : std_logic;
SIGNAL ext_sync_a           : std_logic;
SIGNAL ext_sync_b           : std_logic;
-- SIGNAL ext_sync_en       : std_logic;

SIGNAL fifo_adca_ae         : std_logic;
SIGNAL fifo_adca_af         : std_logic;
SIGNAL fifo_adca_arm        : std_logic;
SIGNAL fifo_adca_clear      : std_logic;
SIGNAL fifo_adca_e          : std_logic;
SIGNAL fifo_adca_en         : std_logic;
SIGNAL fifo_adca_en_n       : std_logic;
SIGNAL fifo_adca_f          : std_logic;
SIGNAL fifo_adca_firstread  : std_logic;
SIGNAL fifo_adca_gate_enable: std_logic;
SIGNAL fifo_adca_gate_disbl : std_logic;
SIGNAL fifo_adca_gate_selb  : std_logic;
SIGNAL fifo_adca_hold       : std_logic;
SIGNAL fifo_adca_pretrig    : std_logic;
SIGNAL fifo_adca_req        : std_logic;
SIGNAL fifo_adca_rst        : std_logic;
SIGNAL fifo_adca_trig       : std_logic;
SIGNAL fifo_adca_trig_reached
                            : std_logic;
SIGNAL fifo_adca_trig_stat  : std_logic;
SIGNAL fifo_adca_wren       : std_logic;

SIGNAL fifo_adcb_ae         : std_logic;
SIGNAL fifo_adcb_af         : std_logic;
SIGNAL fifo_adcb_arm        : std_logic;
SIGNAL fifo_adcb_clear      : std_logic;
SIGNAL fifo_adcb_e          : std_logic;
SIGNAL fifo_adcb_en         : std_logic;
SIGNAL fifo_adcb_en_n       : std_logic;
SIGNAL fifo_adcb_f          : std_logic;
SIGNAL fifo_adcb_firstread  : std_logic;
SIGNAL fifo_adcb_gate_enable: std_logic;
SIGNAL fifo_adcb_gate_disbl : std_logic;
SIGNAL fifo_adcb_gate_selb  : std_logic;
SIGNAL fifo_adcb_hold       : std_logic;
SIGNAL fifo_adcb_pretrig    : std_logic;
SIGNAL fifo_adcb_req        : std_logic;
SIGNAL fifo_adcb_rst        : std_logic;
SIGNAL fifo_adcb_trig       : std_logic;
SIGNAL fifo_adcb_trig_reached
                            : std_logic;
SIGNAL fifo_adcb_trig_stat  : std_logic;
-- SIGNAL fifo_adcb_wren    : std_logic;

SIGNAL fifo_adcc_ae         : std_logic;
SIGNAL fifo_adcc_af         : std_logic;
SIGNAL fifo_adcc_arm        : std_logic;
SIGNAL fifo_adcc_clear      : std_logic;
SIGNAL fifo_adcc_e          : std_logic;
SIGNAL fifo_adcc_en         : std_logic;
SIGNAL fifo_adcc_en_n       : std_logic;
SIGNAL fifo_adcc_f          : std_logic;
SIGNAL fifo_adcc_firstread  : std_logic;
SIGNAL fifo_adcc_gate_enable: std_logic;
SIGNAL fifo_adcc_gate_disbl : std_logic;
SIGNAL fifo_adcc_gate_selb  : std_logic;
SIGNAL fifo_adcc_hold       : std_logic;
SIGNAL fifo_adcc_pretrig    : std_logic;
SIGNAL fifo_adcc_req        : std_logic;
SIGNAL fifo_adcc_rst        : std_logic;
SIGNAL fifo_adcc_trig       : std_logic;
SIGNAL fifo_adcc_trig_reached
                            : std_logic;
SIGNAL fifo_adcc_trig_stat  : std_logic;
SIGNAL fifo_adcc_wren       : std_logic;

SIGNAL fifo_adcd_ae         : std_logic;
SIGNAL fifo_adcd_af         : std_logic;
SIGNAL fifo_adcd_arm        : std_logic;
SIGNAL fifo_adcd_clear      : std_logic;
SIGNAL fifo_adcd_e          : std_logic;
SIGNAL fifo_adcd_en         : std_logic;
SIGNAL fifo_adcd_en_n       : std_logic;
SIGNAL fifo_adcd_f          : std_logic;
SIGNAL fifo_adcd_firstread  : std_logic;
SIGNAL fifo_adcd_gate_enable: std_logic;
SIGNAL fifo_adcd_gate_disbl : std_logic;
SIGNAL fifo_adcd_gate_selb  : std_logic;
SIGNAL fifo_adcd_hold       : std_logic;
SIGNAL fifo_adcd_pretrig    : std_logic;
SIGNAL fifo_adcd_req        : std_logic;
SIGNAL fifo_adcd_rst        : std_logic;
SIGNAL fifo_adcd_trig       : std_logic;
SIGNAL fifo_adcd_trig_reached
                            : std_logic;
SIGNAL fifo_adcd_trig_stat  : std_logic;
-- SIGNAL fifo_adcd_wren    : std_logic;

SIGNAL fifo_daca_ae         : std_logic;
SIGNAL fifo_daca_af         : std_logic;
SIGNAL fifo_daca_clear      : std_logic;
SIGNAL fifo_daca_e          : std_logic;
SIGNAL fifo_daca_en         : std_logic;
SIGNAL fifo_daca_en_n       : std_logic;
SIGNAL fifo_daca_f          : std_logic;
SIGNAL fifo_daca_gate_enable: std_logic;
SIGNAL fifo_daca_gate_disbl : std_logic;
SIGNAL fifo_daca_gate_selb  : std_logic;
SIGNAL fifo_daca_hold       : std_logic;
SIGNAL fifo_daca_req        : std_logic;
SIGNAL fifo_daca_rst        : std_logic;
SIGNAL fifo_daca_trig       : std_logic;
SIGNAL fifo_daca_trig_stat  : std_logic;

-- SIGNAL fifo_dacb_ae      : std_logic;
-- SIGNAL fifo_dacb_af      : std_logic;
-- SIGNAL fifo_dacb_clear   : std_logic;
-- SIGNAL fifo_dacb_e       : std_logic;
-- SIGNAL fifo_dacb_en      : std_logic;
-- SIGNAL fifo_dacb_en_n    : std_logic;
-- SIGNAL fifo_dacb_f       : std_logic;
-- SIGNAL fifo_dacb_gate_enable
--                          : std_logic;
-- SIGNAL fifo_dacb_gate_disbl
--                          : std_logic;
-- SIGNAL fifo_dacb_gate_selb
--                          : std_logic;
-- SIGNAL fifo_dacb_hold    : std_logic;
-- SIGNAL fifo_dacb_req     : std_logic;
-- SIGNAL fifo_dacb_rst     : std_logic;
-- SIGNAL fifo_dacb_trig    : std_logic;
-- SIGNAL fifo_dacb_trig_stat
--                          : std_logic;

SIGNAL fifo_dacm_rden       : std_logic;

SIGNAL fifo_memr_ae         : std_logic;
SIGNAL fifo_memr_af         : std_logic;
SIGNAL fifo_memr_e          : std_logic;
-- SIGNAL fifo_memr_en      : std_logic;
SIGNAL fifo_memr_f          : std_logic;
SIGNAL fifo_memr_firstread  : std_logic;
SIGNAL fifo_memr_req        : std_logic;
SIGNAL fifo_memr_rst        : std_logic;

SIGNAL fifo_memw_ae         : std_logic;
SIGNAL fifo_memw_af         : std_logic;
SIGNAL fifo_memw_e          : std_logic;
-- SIGNAL fifo_memw_en      : std_logic;
SIGNAL fifo_memw_f          : std_logic;
SIGNAL fifo_memw_req        : std_logic;
SIGNAL fifo_memw_rst        : std_logic;

SIGNAL fifo_test_ae         : std_logic;
SIGNAL fifo_test_af         : std_logic;
SIGNAL fifo_test_e          : std_logic;
SIGNAL fifo_test_f          : std_logic;
SIGNAL fifo_test_rst        : std_logic;

SIGNAL fifo_testr_firstread : std_logic;
SIGNAL fifo_testr_req       : std_logic;
SIGNAL fifo_testw_req       : std_logic;
-- SIGNAL fifos_rdy         : std_logic;
-- SIGNAL fifos_rdy_q       : std_logic;

-- SIGNAL flash_rdsel       : std_logic;
-- SIGNAL flash_wrsel       : std_logic;

-- SIGNAL gate_pol          : std_logic;
SIGNAL gate_pol_a           : std_logic;
SIGNAL gate_pol_b           : std_logic;
SIGNAL gate_src_a           : std_logic;
SIGNAL gate_src_b           : std_logic;

-- SIGNAL gatea_cntr_fen    : std_logic;
SIGNAL gatea_n              : std_logic;
-- SIGNAL gatea_trig_sel    : std_logic;
-- SIGNAL gateago           : std_logic;
-- SIGNAL gateago_rs        : std_logic;

-- SIGNAL gateb_cntr_fen    : std_logic;
-- SIGNAL gateb_in_b_q      : std_logic;
SIGNAL gateb_n              : std_logic;
-- SIGNAL gateb_trig_sel    : std_logic;
-- SIGNAL gateb_ttl_q       : std_logic;
-- SIGNAL gatebgo           : std_logic;
-- SIGNAL gatebgo_rs        : std_logic;

SIGNAL gatego_a             : std_logic;
SIGNAL gatego_b             : std_logic;
-- SIGNAL gatego_rs_a       : std_logic;
-- SIGNAL gatego_rs_b       : std_logic;

SIGNAL gnd                  : std_logic;

SIGNAL idelayctrl_rdy       : std_logic;
-- SIGNAL in_clk_ibufg      : std_logic;
-- SIGNAL input_clk_ibuf    : std_logic;
SIGNAL int_reset            : std_logic;
SIGNAL int_reset_n          : std_logic;

SIGNAL laddr_27             : std_logic;
SIGNAL lads_in_n            : std_logic;
SIGNAL lads_n_out           : std_logic;

SIGNAL lbe0_in_n            : std_logic;
SIGNAL lbe0_n_out           : std_logic;
SIGNAL lbe4_in_n            : std_logic;
SIGNAL lbe4_n_out           : std_logic;
SIGNAL lblast_in_n          : std_logic;
SIGNAL lblast_n_out         : std_logic;

SIGNAL lclk                 : std_logic;
SIGNAL lclk_buf             : std_logic;
SIGNAL lhold_in             : std_logic;
-- SIGNAL lhold_q           : std_logic;
SIGNAL lready_in_n          : std_logic;
SIGNAL lready_n_out         : std_logic;
SIGNAL lready_n_shadow      : std_logic;
SIGNAL lrst_in_n            : std_logic;
SIGNAL lrw_in               : std_logic;
SIGNAL lrw_out              : std_logic;

-- SIGNAL lvds_clk1         : std_logic;
-- SIGNAL lvds_clk1_buf     : std_logic;
-- SIGNAL lvds_clk2         : std_logic;
-- SIGNAL lvds_clk2_buf     : std_logic;

SIGNAL lvds1_ctl            : std_logic;
SIGNAL lvds1_gcfb           : std_logic;
SIGNAL lvds1_gcfb_buf       : std_logic;
SIGNAL lvds1_gclk           : std_logic;
SIGNAL lvds1_rc_out         : std_logic;

SIGNAL lvds2_ctl            : std_logic;
SIGNAL lvds2_gcfb           : std_logic;
SIGNAL lvds2_gcfb_buf       : std_logic;
SIGNAL lvds2_gclk           : std_logic;
SIGNAL lvds2_rc_out         : std_logic;

SIGNAL lvds3_ctl            : std_logic;
-- SIGNAL lvds3_gclk        : std_logic;
SIGNAL lvds3_rc_in          : std_logic;
SIGNAL lvds3_rc_in_buf      : std_logic;

SIGNAL lvds4_ctl            : std_logic;
-- SIGNAL lvds4_gclk        : std_logic;
SIGNAL lvds4_rc_in          : std_logic;
SIGNAL lvds4_rc_in_buf      : std_logic;

SIGNAL lwait_in_n           : std_logic;
SIGNAL lwait_n_out          : std_logic;

SIGNAL mem_clk_buf          : std_logic;
SIGNAL memr_sel             : std_logic;
-- SIGNAL memw_dq_sel       : std_logic;
SIGNAL memw_sel             : std_logic;

-- SIGNAL px_clk_valid      : std_logic;
-- SIGNAL px_fifo_rst_n     : std_logic;
-- SIGNAL px_proc_data_dir  : std_logic;
-- SIGNAL px_processor_id   : std_logic;
-- SIGNAL px_trig_clear     : std_logic;
-- SIGNAL px_sm_gate_n      : std_logic;
-- SIGNAL px1_clk_valid     : std_logic;
-- SIGNAL px1_proc_data_dir : std_logic;

SIGNAL rd_sel               : std_logic;

SIGNAL ref_clk              : std_logic;
-- SIGNAL ref_clk_buf       : std_logic;
SIGNAL ref_clk_ibuf         : std_logic;
-- SIGNAL ref_clk270        : std_logic;
-- SIGNAL ref_clk270_buf    : std_logic;
-- SIGNAL ref_temp1         : std_logic;
-- SIGNAL ref_temp2         : std_logic;

-- SIGNAL reg_dq_sel        : std_logic;
SIGNAL reg_sel              : std_logic;

SIGNAL rst                  : std_logic;
-- SIGNAL rst_q             : std_logic;
-- SIGNAL sdram_rd_clk_lock : std_logic;

-- SIGNAL sync_event        : std_logic;
-- SIGNAL sync_pol          : std_logic;
SIGNAL sync_pol_a           : std_logic;
SIGNAL sync_pol_b           : std_logic;
-- SIGNAL sync_src          : std_logic;
SIGNAL sync_src_a           : std_logic;
SIGNAL sync_src_b           : std_logic;
SIGNAL synca_n              : std_logic;
-- SIGNAL syncb_in_n_q      : std_logic;
SIGNAL syncb_n              : std_logic;
-- SIGNAL syncb_ttl_q       : std_logic;
SIGNAL syncgo_a             : std_logic;
SIGNAL syncgo_b             : std_logic;
-- SIGNAL syncgo_rs_a       : std_logic;
-- SIGNAL syncgo_rs_b       : std_logic;

SIGNAL sys_clk              : std_logic;
SIGNAL sys_clk_180          : std_logic;
SIGNAL sys_clk_lock         : std_logic;

-- SIGNAL test_mode         : std_logic;
SIGNAL testr_sel            : std_logic;
-- SIGNAL testw_dq_sel      : std_logic;
SIGNAL testw_sel            : std_logic;
SIGNAL tmp_vlt_int1         : std_logic;
SIGNAL toggle_mem           : std_logic;

-- SIGNAL user_data_valid   : std_logic;
-- SIGNAL user_input_clk    : std_logic;
-- SIGNAL user_rst          : std_logic;
SIGNAL vcc                  : std_logic;

SIGNAL wclk                 : std_logic;
-- SIGNAL wclk_buf          : std_logic;
SIGNAL wr_sel               : std_logic;
SIGNAL wr_sel_dlyd          : std_logic;

SIGNAL xfer                 : std_logic;

SIGNAL adc_ab_data          : std_logic_vector (31 downto 0);
SIGNAL adc_cd_data          : std_logic_vector (31 downto 0);
-- SIGNAL adc_data          : std_logic_vector (31 downto 0);
-- SIGNAL adc_data2         : std_logic_vector (31 downto 0);

SIGNAL adca_packed_data     : std_logic_vector (31 downto 0);
SIGNAL adcb_packed_data     : std_logic_vector (31 downto 0);
SIGNAL adcc_packed_data     : std_logic_vector (31 downto 0);
SIGNAL adcd_packed_data     : std_logic_vector (31 downto 0);

SIGNAL ctlreg_data          : std_logic_vector (15 downto 0);
SIGNAL ctlreg_dq            : std_logic_vector (15 downto 0);

SIGNAL data0                : std_logic_vector (15 downto 0);
SIGNAL data1                : std_logic_vector (15 downto 0);
SIGNAL data2                : std_logic_vector (15 downto 0);
SIGNAL data3                : std_logic_vector (15 downto 0);

SIGNAL ddr0_dq_in           : std_logic_vector (31 downto 0);
-- SIGNAL ddr0_dq_oe        : std_logic_vector (31 downto 0);
SIGNAL ddr0_dq_oe_n         : std_logic_vector (31 downto 0);
SIGNAL ddr0_dq_out          : std_logic_vector (31 downto 0);
SIGNAL ddr0_dqs_in          : std_logic_vector (3 downto 0);
-- SIGNAL ddr0_dqs_oe       : std_logic_vector (3 downto 0);
SIGNAL ddr0_dqs_oe_n        : std_logic_vector (3 downto 0);
SIGNAL ddr0_dqs_out         : std_logic_vector (3 downto 0);
SIGNAL ddr0_vaddress        : std_logic_vector (15 downto 0);
SIGNAL ddr0_vcke            : std_logic_vector (7 downto 0);
SIGNAL ddr0_vcs_n           : std_logic_vector (7 downto 0);

SIGNAL ddr1_dq_in           : std_logic_vector (31 downto 0);
-- SIGNAL ddr1_dq_oe        : std_logic_vector (31 downto 0);
SIGNAL ddr1_dq_oe_n         : std_logic_vector (31 downto 0);
SIGNAL ddr1_dq_out          : std_logic_vector (31 downto 0);
SIGNAL ddr1_dqs_in          : std_logic_vector (3 downto 0);
-- SIGNAL ddr1_dqs_oe       : std_logic_vector (3 downto 0);
SIGNAL ddr1_dqs_oe_n        : std_logic_vector (3 downto 0);
SIGNAL ddr1_dqs_out         : std_logic_vector (3 downto 0);
SIGNAL ddr1_vaddress        : std_logic_vector (15 downto 0);
SIGNAL ddr1_vcke            : std_logic_vector (7 downto 0);
SIGNAL ddr1_vcs_n           : std_logic_vector (7 downto 0);

SIGNAL ddr2_dq_in           : std_logic_vector (31 downto 0);
-- SIGNAL ddr2_dq_oe        : std_logic_vector (31 downto 0);
SIGNAL ddr2_dq_oe_n         : std_logic_vector (31 downto 0);
SIGNAL ddr2_dq_out          : std_logic_vector (31 downto 0);
SIGNAL ddr2_dqs_in          : std_logic_vector (3 downto 0);
-- SIGNAL ddr2_dqs_oe       : std_logic_vector (3 downto 0);
SIGNAL ddr2_dqs_oe_n        : std_logic_vector (3 downto 0);
SIGNAL ddr2_dqs_out         : std_logic_vector (3 downto 0);
SIGNAL ddr2_vaddress        : std_logic_vector (15 downto 0);
SIGNAL ddr2_vcke            : std_logic_vector (7 downto 0);
SIGNAL ddr2_vcs_n           : std_logic_vector (7 downto 0);

SIGNAL extd_addr            : std_logic_vector (15 downto 0);

SIGNAL fifo_adca_count_ae   : std_logic_vector (15 downto 0);
SIGNAL fifo_adca_count_af   : std_logic_vector (15 downto 0);
SIGNAL fifo_adca_data       : std_logic_vector (63 downto 0);
SIGNAL fifo_adca_decdiv     : std_logic_vector (15 downto 0);
SIGNAL fifo_adca_dq         : std_logic_vector (63 downto 0);
SIGNAL fifo_adca_packmode   : std_logic_vector (2 downto 0);
SIGNAL fifo_adca_post_length_h
                            : std_logic_vector (15 downto 0);
SIGNAL fifo_adca_post_length_l
                            : std_logic_vector (15 downto 0);
SIGNAL fifo_adca_pre_count_h: std_logic_vector (15 downto 0);
SIGNAL fifo_adca_pre_count_l: std_logic_vector (15 downto 0);
SIGNAL fifo_adca_triglen_h  : std_logic_vector (15 downto 0);
SIGNAL fifo_adca_triglen_l  : std_logic_vector (15 downto 0);

SIGNAL fifo_adcb_count_ae   : std_logic_vector (15 downto 0);
SIGNAL fifo_adcb_count_af   : std_logic_vector (15 downto 0);
SIGNAL fifo_adcb_data       : std_logic_vector (63 downto 0);
SIGNAL fifo_adcb_decdiv     : std_logic_vector (15 downto 0);
SIGNAL fifo_adcb_dq         : std_logic_vector (63 downto 0);
SIGNAL fifo_adcb_packmode   : std_logic_vector (2 downto 0);
SIGNAL fifo_adcb_post_length_h
                            : std_logic_vector (15 downto 0);
SIGNAL fifo_adcb_post_length_l
                            : std_logic_vector (15 downto 0);
SIGNAL fifo_adcb_pre_count_h: std_logic_vector (15 downto 0);
SIGNAL fifo_adcb_pre_count_l: std_logic_vector (15 downto 0);
SIGNAL fifo_adcb_triglen_h  : std_logic_vector (15 downto 0);
SIGNAL fifo_adcb_triglen_l  : std_logic_vector (15 downto 0);

SIGNAL fifo_adcc_count_ae   : std_logic_vector (15 downto 0);
SIGNAL fifo_adcc_count_af   : std_logic_vector (15 downto 0);
SIGNAL fifo_adcc_data       : std_logic_vector (63 downto 0);
SIGNAL fifo_adcc_decdiv     : std_logic_vector (15 downto 0);
SIGNAL fifo_adcc_dq         : std_logic_vector (63 downto 0);
SIGNAL fifo_adcc_packmode   : std_logic_vector (2 downto 0);
SIGNAL fifo_adcc_post_length_h
                            : std_logic_vector (15 downto 0);
SIGNAL fifo_adcc_post_length_l
                            : std_logic_vector (15 downto 0);
SIGNAL fifo_adcc_pre_count_h: std_logic_vector (15 downto 0);
SIGNAL fifo_adcc_pre_count_l: std_logic_vector (15 downto 0);
SIGNAL fifo_adcc_triglen_h  : std_logic_vector (15 downto 0);
SIGNAL fifo_adcc_triglen_l  : std_logic_vector (15 downto 0);

SIGNAL fifo_adcd_count_ae   : std_logic_vector (15 downto 0);
SIGNAL fifo_adcd_count_af   : std_logic_vector (15 downto 0);
SIGNAL fifo_adcd_data       : std_logic_vector (63 downto 0);
SIGNAL fifo_adcd_decdiv     : std_logic_vector (15 downto 0);
SIGNAL fifo_adcd_dq         : std_logic_vector (63 downto 0);
SIGNAL fifo_adcd_packmode   : std_logic_vector (2 downto 0);
SIGNAL fifo_adcd_post_length_h
                            : std_logic_vector (15 downto 0);
SIGNAL fifo_adcd_post_length_l
                            : std_logic_vector (15 downto 0);
SIGNAL fifo_adcd_pre_count_h: std_logic_vector (15 downto 0);
SIGNAL fifo_adcd_pre_count_l: std_logic_vector (15 downto 0);
SIGNAL fifo_adcd_triglen_h  : std_logic_vector (15 downto 0);
SIGNAL fifo_adcd_triglen_l  : std_logic_vector (15 downto 0);

SIGNAL fifo_daca_count_ae   : std_logic_vector (15 downto 0);
SIGNAL fifo_daca_count_af   : std_logic_vector (15 downto 0);
-- SIGNAL fifo_daca_data    : std_logic_vector (63 downto 0);
SIGNAL fifo_daca_dq         : std_logic_vector (63 downto 0);
SIGNAL fifo_daca_packmode   : std_logic_vector (2 downto 0);
SIGNAL fifo_daca_post_length_h
                            : std_logic_vector (15 downto 0);
SIGNAL fifo_daca_post_length_l
                            : std_logic_vector (15 downto 0);
SIGNAL fifo_daca_triglen_h  : std_logic_vector (15 downto 0);
SIGNAL fifo_daca_triglen_l  : std_logic_vector (15 downto 0);

-- SIGNAL fifo_dacb_count_ae: std_logic_vector (15 downto 0);
-- SIGNAL fifo_dacb_count_af: std_logic_vector (15 downto 0);
-- SIGNAL fifo_dacb_data    : std_logic_vector (63 downto 0);
-- SIGNAL fifo_dacb_dq      : std_logic_vector (63 downto 0);
-- SIGNAL fifo_dacb_packmode: std_logic_vector (2 downto 0);
-- SIGNAL fifo_dacb_post_length_h
--                          : std_logic_vector (15 downto 0);
-- SIGNAL fifo_dacb_post_length_l
--                          : std_logic_vector (15 downto 0);
-- SIGNAL fifo_dacb_triglen_h
--                          : std_logic_vector (15 downto 0);
-- SIGNAL fifo_dacb_triglen_l
--                          : std_logic_vector (15 downto 0);

SIGNAL fifo_dacm_dout       : std_logic_vector (31 downto 0);

SIGNAL fifo_memr_count_ae   : std_logic_vector (15 downto 0);
SIGNAL fifo_memr_count_af   : std_logic_vector (15 downto 0);
SIGNAL fifo_memr_data       : std_logic_vector (63 downto 0);
-- SIGNAL fifo_memr_din     : std_logic_vector (63 downto 0);
SIGNAL fifo_memr_dq         : std_logic_vector (63 downto 0);

SIGNAL fifo_memw_count_ae   : std_logic_vector (15 downto 0);
SIGNAL fifo_memw_count_af   : std_logic_vector (15 downto 0);
-- SIGNAL fifo_memw_dout    : std_logic_vector (63 downto 0);
SIGNAL fifo_memw_dq         : std_logic_vector (63 downto 0);

SIGNAL fifo_test_count_ae   : std_logic_vector (15 downto 0);
SIGNAL fifo_test_count_af   : std_logic_vector (15 downto 0);
-- SIGNAL fifo_test_dout    : std_logic_vector (63 downto 0);
SIGNAL fifo_testr_data      : std_logic_vector (63 downto 0);
SIGNAL fifo_testr_dq        : std_logic_vector (63 downto 0);
SIGNAL fifo_testw_dq        : std_logic_vector (63 downto 0);

-- SIGNAL flash_dat_out     : std_logic_vector (15 downto 0);

SIGNAL int                  : std_logic_vector (3 downto 0);

SIGNAL lad_in               : std_logic_vector (63 downto 0);
SIGNAL lad_out              : std_logic_vector (63 downto 0);
-- SIGNAL lad_out_q         : std_logic_vector (63 downto 0);
SIGNAL laddr                : std_logic_vector (63 downto 0);
SIGNAL laddr_held           : std_logic_vector (63 downto 0);
SIGNAL lspare_in            : std_logic_vector (4 downto 0);
SIGNAL lspare_out           : std_logic_vector (4 downto 0);

-- SIGNAL lvds_in           : std_logic_vector (15 downto 0);
-- SIGNAL lvds_inq          : std_logic_vector (15 downto 0);
-- SIGNAL lvds_out          : std_logic_vector (15 downto 0);
SIGNAL lvds_outq            : std_logic_vector (15 downto 0);
-- SIGNAL lvds1_dat         : std_logic_vector (15 downto 0);
SIGNAL lvds1_out            : std_logic_vector (15 downto 0);
-- SIGNAL lvds2_dat         : std_logic_vector (15 downto 0);
SIGNAL lvds2_out            : std_logic_vector (15 downto 0);
-- SIGNAL lvds3_dat         : std_logic_vector (15 downto 0);
SIGNAL lvds3_out            : std_logic_vector (15 downto 0);
SIGNAL lvds4_in             : std_logic_vector (3 downto 0);

SIGNAL mem_ctrl_reg         : std_logic_vector (15 downto 0);

SIGNAL mem0_depth_reg_h     : std_logic_vector (15 downto 0);
SIGNAL mem0_depth_reg_l     : std_logic_vector (15 downto 0);
SIGNAL mem0_end_reg_h       : std_logic_vector (15 downto 0);
SIGNAL mem0_end_reg_l       : std_logic_vector (15 downto 0);
SIGNAL mem0_start_reg_h     : std_logic_vector (15 downto 0);
SIGNAL mem0_start_reg_l     : std_logic_vector (15 downto 0);
SIGNAL mem0_trig_reg_h      : std_logic_vector (15 downto 0);
SIGNAL mem0_trig_reg_l      : std_logic_vector (15 downto 0);

SIGNAL mem1_depth_reg_h     : std_logic_vector (15 downto 0);
SIGNAL mem1_depth_reg_l     : std_logic_vector (15 downto 0);
SIGNAL mem1_end_reg_h       : std_logic_vector (15 downto 0);
SIGNAL mem1_end_reg_l       : std_logic_vector (15 downto 0);
SIGNAL mem1_start_reg_h     : std_logic_vector (15 downto 0);
SIGNAL mem1_start_reg_l     : std_logic_vector (15 downto 0);
SIGNAL mem1_trig_reg_h      : std_logic_vector (15 downto 0);
SIGNAL mem1_trig_reg_l      : std_logic_vector (15 downto 0);

SIGNAL mem2_depth_reg_h     : std_logic_vector (15 downto 0);
SIGNAL mem2_depth_reg_l     : std_logic_vector (15 downto 0);
SIGNAL mem2_end_reg_h       : std_logic_vector (15 downto 0);
SIGNAL mem2_end_reg_l       : std_logic_vector (15 downto 0);
SIGNAL mem2_start_reg_h     : std_logic_vector (15 downto 0);
SIGNAL mem2_start_reg_l     : std_logic_vector (15 downto 0);

-- SIGNAL px_dat_mode       : std_logic_vector (1 downto 0);
-- SIGNAL px_dat_out_adc    : std_logic_vector (31 downto 0);
-- SIGNAL px_dat_out_b      : std_logic_vector (31 downto 0);
-- SIGNAL px_dat_out_c      : std_logic_vector (31 downto 0);
-- SIGNAL px_dat_out_d      : std_logic_vector (31 downto 0);
-- SIGNAL px_int_vctr       : std_logic_vector (15 downto 0);
-- SIGNAL px_io_data_dir    : std_logic_vector (15 downto 0);
SIGNAL px_io_data_in        : std_logic_vector (15 downto 0);
SIGNAL px_io_data_out       : std_logic_vector (15 downto 0);
-- SIGNAL px_trig_length    : std_logic_vector (13 downto 0);

-- SIGNAL px1_dat_mode      : std_logic_vector (1 downto 0);
-- SIGNAL px1_io_data_dir   : std_logic_vector (15 downto 0);
-- SIGNAL px1_io_data_out   : std_logic_vector (15 downto 0);
-- SIGNAL px1_trig_length   : std_logic_vector (13 downto 0);

-- SIGNAL status            : std_logic_vector (7 downto 0);

-- SIGNAL user_bank_address : std_logic_vector (1 downto 0);
--SIGNAL user_command_register:std_logic_vector (2 downto 0);
--SIGNAL user_config_register:std_logic_vector (9 downto 0);
-- SIGNAL user_input_address: std_logic_vector (20 downto 0);
-- SIGNAL user_input_data   : std_logic_vector (63 downto 0);
-- SIGNAL user_output_data  : std_logic_vector (63 downto 0);
-- SIGNAL user_output_data1 : std_logic_vector (63 downto 0);
-- SIGNAL user_output_data2 : std_logic_vector (63 downto 0);
-- SIGNAL user_output_data3 : std_logic_vector (63 downto 0);
-- SIGNAL user_output_data4 : std_logic_vector (63 downto 0);

--  USER Required Signals for Digital Down Converter (DDC)

SIGNAL k_addr			   : std_logic_vector (15 downto 0);
SIGNAL k_data		      : std_logic_vector (17 downto 0);
SIGNAL k_wr			      : std_logic;
SIGNAL g_addr			   : std_logic_vector (15 downto 0);
SIGNAL g_data			   : std_logic_vector (17 downto 0);
SIGNAL g_wr 			   : std_logic;
SIGNAL k_readcoef		   : std_logic_vector (17 downto 0);
SIGNAL g_readcoef		   : std_logic_vector (17 downto 0);
SIGNAL stop					: std_logic;
SIGNAL start_clk			: std_logic; -- filter decimation clk (adc_clk/8)
SIGNAL timer_clk			: std_logic; -- multitimer clk (adc_clk/2)
-- SIGNAL filter_clk			: std_logic; -- filter clk (adc_clk x 2)

--  USER Required Signals for Multi-Timers

SIGNAL mt_addr_reg 		: std_logic_vector(15 downto 0);	--MultiTimer Address Register
SIGNAL mt_data_reg 		: std_logic_vector(15 downto 0);	--MultiTimer Data Register
SIGNAL mt_addr_wr  		: std_logic;							--MultiTimer Address Write
SIGNAL mt_data_wr  		: std_logic;							--MultiTimer Data Write
SIGNAL pulse_out   		: std_logic_vector(7 downto 0);	--MultiTimer Output Pulses
	

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    -------------------------------------------------------------
    -- **************** Assignment Statements **************** --
    -------------------------------------------------------------

    -- See Block Diagram, page 1
    ADJ_CLK     <='0';

    -- See Block Diagram, page 8
    CLKSEL_ADC(0)   <= clksel_adc_int;
    -- See Block Diagram, page 9
    CLKSEL_DAC(0)   <= clksel_dac_int;

    -- See Block Diagram, page 1
    DAC_SCLK    <= dac_sclk_int;
    -- See Block Diagram, page 9
    DAC_TXEN    <='1';

    -- See Block Diagram, page 11
    GATEA_DISBL <= '0';
    GATEA_SRC   <= '0';
    GATEB_DISBL <= '0';
    GATEB_SRC   <= '0';

    gnd         <='0';
    vcc         <='1';

    -- See Block Diagram, page 1
    toggle_mem  <= NOT toggle_mem
                    when (rising_edge (sys_clk))
                    else toggle_mem;

    LSPARE(3 downto 0)  <= (others =>'0');   
    LSPARE(4)           <= toggle_mem;

    -------------------------------------------------------------
    -- ********* Local, A/D & Memory Clock Receivers ********* --
    -------------------------------------------------------------

    --Local Clock

    LCLK_IBUF : IBUFG
    PORT MAP (
        I       => LCLKI,

        O       => lclk_buf
        );

    LCLK_BUFG : BUFG
    PORT MAP (
        I       => lclk_buf,

        O       => lclk
        );

    -- ADC Clock

   ADC_IBUFG : IBUFG
    PORT MAP (
        I       => ADC_CLKI,

        O       => adc_clk_buf
    );

    ADCCLK_BUFG : BUFG
    PORT MAP (
        I       => adc_clk_buf,

        O       => adc_clk
        );

    -------------------------------------------------------------
    -- **************** Memory Clocks  **************** --
    -------------------------------------------------------------

    -- Ref Clock Receiver
    -- See Block Diagram, page 15
    REF_IBUFG : IBUFGDS_LVPECL_25
    PORT MAP (
        I       => REF_CLK_P,
        Ib      => REF_CLK_N,

        O       => ref_clk_ibuf
        );

      REF_BUFG : BUFG
      PORT MAP (
          I     => ref_clk_ibuf,

          O     => ref_clk
          );

    -- Memory Clock Receiver
    -- See Block Diagram, page 1

    MEM_IBUFG : IBUFGDS_LVPECL_25
    PORT MAP (
        I       => MEM_CLK_P,
        Ib      => MEM_CLK_N,

        O       => mem_clk_buf
        );

    -------------------------------------------------------------
    -- ****************** SDRAM_SYS_CLK_DCM ****************** --
    -- ****** This DCM generates  the following clocks: ****** --
    -- *** 1) System clock (sys_clk)  for internal control *** --
    -- ************* and local  interface logic; ************* --
    -- *** 2) Inverted system clock (sys_clk_180) used for *** --
    -- ******** generating differential output clocks ******** --
    -- *** 3) Write Clock (wclk) for  data phase alignment *** --
    -- ******************** during writes ******************** --
    -------------------------------------------------------------

    SDRAM_SYS_CLK_DCM_INST : SDRAM_SYS_CLK_DCM
    PORT MAP (
        ClkIn_in    => mem_clk_buf,
        Rst_in      => rst,

        Clk0_out    => sys_clk,
        Clk180_out  => sys_clk_180,
        Clk270_out  => wclk,
        ClkDv_out   => cal_clk,
        Locked_out  => sys_clk_lock
        );

    -------------------------------------------------------------
    -- **************** Clock Outputs to DDRs **************** --
    -------------------------------------------------------------

    DDR0CLK_INST : FDDRRSE
    PORT MAP (
        C0  => sys_clk,
        C1  => sys_clk_180,
        Ce  => vcc,
        D0  => vcc,
        D1  => gnd,
        R   => gnd,
        S   => gnd,

        Q   => DDR0_CLK
        );

    DDR0CLKB_INST : FDDRRSE
    PORT MAP (
        C0  => sys_clk,
        C1  => sys_clk_180,
        Ce  => vcc,
        D0  => gnd,
        D1  => vcc,
        R   => gnd,
        S   => gnd,

        Q   => DDR0_CLKB
        );

    DDR1CLK_INST : FDDRRSE
    PORT MAP (
        C0  => sys_clk,
        C1  => sys_clk_180,
        Ce  => vcc,
        D0  => vcc,
        D1  => gnd,
        R   => gnd,
        S   => gnd,

        Q   => DDR1_CLK
        );

    DDR1CLKB_INST : FDDRRSE
    PORT MAP (
        C0  => sys_clk,
        C1  => sys_clk_180,
        Ce  => vcc,
        D0  => gnd,
        D1  => vcc,
        R   => gnd,
        S   => gnd,

        Q   => DDR1_CLKB
        );

    DDR2CLK_INST : FDDRRSE
    PORT MAP (
        C0  => sys_clk,
        C1  => sys_clk_180,
        Ce  => vcc,
        D0  => vcc,
        D1  => gnd,
        R   => gnd,
        S   => gnd,

        Q   => DDR2_CLK
        );

    DDR2CLKB_INST : FDDRRSE
    PORT MAP (
        C0  => sys_clk,
        C1  => sys_clk_180,
        Ce  => vcc,
        D0  => gnd,
        D1  => vcc,
        R   => gnd,
        S   => gnd,

        Q   => DDR2_CLKB
        );

    -------------------------------------------------------------
    -- ********************** Local Bus ********************** --
    -------------------------------------------------------------

    -- See Block Diagram, page 2
    rst         <= NOT LRST_N;

    -- See Block Diagram, page 2 & 3
    LREADY_N    <= lready_n_out
                    when (LHOLD = '1' AND rst = '0')
                    else 'Z';

    -- See Block Diagram, page 2
    LAD         <= lad_out
                    when (dat_en = '1' AND LHOLD = '1' AND
                                                    rst = '0')
                    else (others => 'Z');

    LCLBUS_IOB : PROCESS (lclk)
    BEGIN
        if (rising_edge (lclk)) then
            -- Local Interrupt Request Output Assignments
            LIRQ_N(0)   <= NOT int(0);
            LIRQ_N(1)   <= NOT int(1);
            LIRQ_N(2)   <= NOT int(2);
            LIRQ_N(3)   <= NOT int(3);
            -- Local DMA Request Output Assignments
            LDREQ_N(0)  <= NOT fifo_adca_req;
            LDREQ_N(1)  <= NOT fifo_adcb_req;
            LDREQ_N(2)  <= NOT fifo_adcc_req;
            LDREQ_N(3)  <= NOT fifo_adcd_req;
            LDREQ_N(4)  <= '1';
            LDREQ_N(5)  <= '1';
            LDREQ_N(6)  <= NOT fifo_daca_req;
            LDREQ_N(7)  <= '1';
            LDREQ_N(8)  <= NOT fifo_memr_req;
            LDREQ_N(9)  <= NOT fifo_memw_req;
            LDREQ_N(10) <= NOT fifo_testr_req;
            LDREQ_N(11) <= NOT fifo_testw_req;
            -- Local Bus Hold Output
            LHOLDA      <= lhold_in;
            -- Local Control Signals -> Outputs
            lads_n_out  <= '1';
            lbe0_n_out  <= '1';
            lbe4_n_out  <= '1';
            lblast_n_out<= '1';
            lrw_out     <= '1';
            lspare_out  <= "11111";
            lwait_n_out <= '1';
            -- Local Control Signals <- Inputs
            lad_in      <= LAD;
            lads_in_n   <= LADS_N;
            lbe0_in_n   <= LBE0_N;
            lbe4_in_n   <= LBE4_N;
            lblast_in_n <= LBLAST_N;
            lhold_in    <= LHOLD;
--          lready_in_n <= LREADY_N;
            lrst_in_n   <= LRST_N;
            lrw_in      <= LRW;
            lspare_in   <= LSPARE;
            lwait_in_n  <= LWAIT_N;
        end if;
    END PROCESS;

    -- See Block Diagram, page 3
    laddr       <= lad_in
                    when (lads_in_n = '0')
                    else laddr_held;
    addrq       <= conv_integer (laddr(31 downto 28));
    laddr_27    <= lad_in(27)
                    when (lads_in_n = '0')
                    else laddr_held(27);

    -- See Block Diagram, pages 2 - 7
    LCLBUS_MUXER : PROCESS (lclk, rst)
    BEGIN

        if (rst = '1') then
            -- Page 4
            adca_sel        <= '0';
            adcb_sel        <= '0';
            adcc_sel        <= '0';
            adcd_sel        <= '0';
            -- Page 6
            daca_sel        <= '0';
            -- Page 2
            dat_en          <= '0';
            -- Page 3
            laddr_held      <= (others => '0');
            lready_n_out    <= '1';
            lready_n_shadow <= '1';
            -- Page 5
            memr_sel        <= '0';
            -- Page 6
            memw_sel        <= '0';
            -- Page 2
            rd_sel          <= '0';
            reg_sel         <= '0';
            -- Page 5
            testr_sel       <= '0';
            -- Page 6
            testw_sel       <= '0';
            -- Page 2
            wr_sel          <= '0';
            wr_sel_dlyd     <= '0';
            xfer            <= '0';

        elsif (rising_edge (lclk)) then
            -- in the Block Diagrams, a signal named "lbl_sh"
            -- represents the conditional below
            if (LBLAST_N = '0' AND lready_n_shadow = '0') then
                -- Page 3
                count           <= 0;
                -- Page 2
                dat_en          <= '0';
                -- Page 3
                lready_n_out    <= '1';
                lready_n_shadow <= '1';
                -- Page 2
                wr_sel          <= '0';
                xfer            <= '0';
            elsif (lads_in_n = '0') then
                -- Page 3
                count           <= 0;
                -- Page 2
                dat_en          <= NOT lrw_in;
                -- Page 3
                laddr_held      <= lad_in;
                -- Page 2
                wr_sel          <= lrw_in;
                xfer            <= '1';

                -- Page 3
                case addrq is
                when 14 =>
                    -- Flash Memory Access
                    lready_n_out        <= '1';
                    lready_n_shadow     <= '1';
                when 15 =>
                    if (laddr_27 = '0') then
                        -- Control Register Access
                        lready_n_out    <= NOT lrw_in;
                        lready_n_shadow <= NOT lrw_in;
                    else
                        lready_n_out    <= '1';
                        lready_n_shadow <= '1';
                    end if;
                when others =>
                    lready_n_out        <= NOT lrw_in;
                    lready_n_shadow     <= NOT lrw_in;
                end case;

            elsif (xfer = '1') then
                count   <= count + 1;

                case addrq is
                when 14 =>
                    if (count >= 14) then
                        lready_n_out    <= '0';
                        lready_n_shadow <= '0';
                    else
                        lready_n_out    <= lready_n_shadow;
                    end if;
                when 15 =>
                    if (laddr_27 = '0') then
                        lready_n_out    <= '0';
                        lready_n_shadow <= '0';
                    elsif (count >= 8) then
                        lready_n_out    <= '0';
                        lready_n_shadow <= '0';
                    else
                        lready_n_out    <= lready_n_shadow;
                    end if;
                when others =>
                    lready_n_out        <= '0';
                    lready_n_shadow     <= '0';
                end case;
            else
                lready_n_out            <= lready_n_shadow;
            end if;

            -----------------------------------------------------
            -- ************ Write Access Controls ************ --
            -----------------------------------------------------

            -- Page 2
            wr_sel_dlyd <= wr_sel;

            -- Page 6
            if (wr_sel_dlyd = '1') then
                case addrq is
                when 6 =>
                    daca_sel    <= NOT lbe4_in_n;
                    if (lbe0_in_n ='0') then
                        fifo_daca_dq(31 downto 0)
                                <= lad_in(31 downto 0);
                    else
                        fifo_daca_dq(31 downto 0)
                                <= fifo_daca_dq(31 downto 0);
                    end if;
                    if (lbe4_in_n ='0') then
                        fifo_daca_dq(63 downto 32)
                                <= lad_in(63 downto 32);
                    else
                        fifo_daca_dq(63 downto 32)
                                <= fifo_daca_dq(63 downto 32);
                    end if;
                 when 9 =>
                    memw_sel    <= NOT lbe4_in_n;
                    if (lbe0_in_n ='0') then
                        fifo_memw_dq(31 downto 0)
                                <= lad_in(31 downto 0);
                    else
                        fifo_memw_dq(31 downto 0)
                                <= fifo_memw_dq(31 downto 0);
                    end if;
                    if (lbe4_in_n ='0') then
                        fifo_memw_dq(63 downto 32)
                                <= lad_in(63 downto 32);
                    else
                        fifo_memw_dq(63 downto 32)
                                <= fifo_memw_dq(63 downto 32);
                    end if;
                when 13 =>
                    testw_sel   <= NOT lbe4_in_n;
                    if (lbe0_in_n ='0') then
                        fifo_testw_dq(31 downto 0)
                                <= lad_in(31 downto 0);
                    else
                    fifo_testw_dq(31 downto 0)
                                <= fifo_testw_dq(31 downto 0);
                    end if;
                    if (lbe4_in_n ='0') then
                        fifo_testw_dq(63 downto 32)
                                <= lad_in(63 downto 32);
                    else
                        fifo_testw_dq(63 downto 32)
                                <= fifo_testw_dq(63 downto 32);
                    end if;
                -- page 3
                when 15 =>
                    if (laddr_27 = '0') then 
                        reg_sel     <= NOT lbe0_in_n;
                        ctlreg_dq   <= lad_in(15 downto 0);
                    end if;
                when others =>
                    ctlreg_dq       <= ctlreg_dq;
                    daca_sel        <= '0';
                    fifo_daca_dq    <= fifo_daca_dq;
                    fifo_memw_dq    <= fifo_memw_dq;
                    fifo_testw_dq   <= fifo_testw_dq;
                    memw_sel        <= '0';
                    reg_sel         <= '0';
                    testw_sel       <= '0';
                end case;

            else
                ctlreg_dq       <= ctlreg_dq;
                daca_sel        <= '0';
                fifo_daca_dq    <= fifo_daca_dq;
                fifo_memw_dq    <= fifo_memw_dq;
                fifo_testw_dq   <= fifo_testw_dq;
                memw_sel        <= '0';
                -- page 2
                reg_sel         <= '0';
                -- page 6
                testw_sel       <= '0';
            end if;

            -----------------------------------------------------
            -- ************ Read Access  Controls ************ --
            -----------------------------------------------------

            -- Backup Registers for FIFO reads

            -- Page 7
            if (adca_sel = '1') then
                fifo_adca_dq <= fifo_adca_data;
            else
                fifo_adca_dq <= fifo_adca_dq;
            end if;

            -- Page 4
            if (fifo_adca_rst = '1') then
                fifo_adca_firstread <='1';
            end if;

            -- Page 7
            if (adcb_sel = '1') then
                fifo_adcb_dq <= fifo_adcb_data;
            else
                fifo_adcb_dq <= fifo_adcb_dq;
            end if;

            -- Page 4
            if (fifo_adcb_rst = '1') then
                fifo_adcb_firstread <='1';
            end if;

            -- Page 7
            if (adcc_sel = '1') then
                fifo_adcc_dq <= fifo_adcc_data;
            else
                fifo_adcc_dq <= fifo_adcc_dq;
            end if;

            -- Page 5
            if (fifo_adcc_rst = '1') then
                fifo_adcc_firstread <='1';
            end if;

            -- Page 7
            if (adcd_sel = '1') then
                fifo_adcd_dq <= fifo_adcd_data;
            else
                fifo_adcd_dq <= fifo_adcd_dq;
            end if;

            -- Page 5
            if (fifo_adcd_rst = '1') then
                fifo_adcd_firstread <='1';
            end if;

            -- Page 7
            if (memr_sel = '1') then
                fifo_memr_dq <= fifo_memr_data;
            else
                fifo_memr_dq <= fifo_memr_dq;
            end if;

            -- Page 5
            if (fifo_memr_rst = '1') then
                fifo_memr_firstread <='1';
            end if;

            -- Page 7
            if (testr_sel = '1') then
                fifo_testr_dq<= fifo_testr_data;
            else
                fifo_testr_dq<= fifo_testr_dq;
            end if;

            -- Page 5
            if (fifo_test_rst = '1') then
                fifo_testr_firstread<='1';
            end if;

            -- Local Bus Read Control
            -- in the Block Diagrams, a signal named "lbl_sh"
            -- represents the conditional below
            if (LBLAST_N = '0' AND lready_n_shadow = '0') then
                -- Page 4
                adca_sel    <= '0';
                adcb_sel    <= '0';
                adcc_sel    <= '0';
                adcd_sel    <= '0';
                -- Page 7
                lad_out     <= (others => '0');
                -- Page 5
                memr_sel    <= '0';
                -- Page 2
                rd_sel      <= '0';
                -- Page 5
                testr_sel   <= '0';
            -- in the Block Diagrams, a signal named "dp_en"
            -- represents the conditional below
            elsif ((lrw_in = '0' AND lads_in_n = '0') OR
                                            rd_sel = '1') then
                -- Page 2
                rd_sel      <= '1';
                -- Page 7
                lad_out     <= (others => '0');

                -- In the Block diagrams, the combination
                -- ((NOT lbe0_in_n) AND (NOT lbe4_in_n)))
                -- is represented by a signal named "lbes_in",
                -- and the combination (LBE0_N AND (NOT LBE4_N)
                -- is represented by a signal named "lbe_04".
                -- Both combinations are used often in the
                -- case statements below.

                case addrq is
                when 0 =>
                    -- Page 4
                    adca_sel    <= ((fifo_adca_firstread OR
                                    rd_sel) AND ((NOT lbe0_in_n)
                                    AND (NOT lbe4_in_n))) OR
                                    (LBE0_N AND (NOT LBE4_N));
                    fifo_adca_firstread <= fifo_adca_firstread
                                                AND (NOT rd_sel);
                    -- Page 7
                    if (lready_n_shadow = '1' AND
                                fifo_adca_firstread = '0' AND
                                            lbe4_in_n = '0') then
                        lad_out <= fifo_adca_dq;
                    else
                        lad_out <= fifo_adca_data;
                    end if;
                when 1 =>
                    -- Page 4
                    adcb_sel    <= ((fifo_adcb_firstread OR
                                    rd_sel) AND ((NOT lbe0_in_n)
                                    AND (NOT lbe4_in_n))) OR
                                    (LBE0_N AND (NOT LBE4_N));
                    fifo_adcb_firstread <= fifo_adcb_firstread
                                                AND (NOT rd_sel);
                    -- Page 7
                    if (lready_n_shadow = '1' AND
                                fifo_adcb_firstread = '0' AND
                                            lbe4_in_n = '0') then
                        lad_out <= fifo_adcb_dq;
                    else
                        lad_out <= fifo_adcb_data;
                    end if;
                when 2 =>
                    -- Page 4
                    adcc_sel    <= ((fifo_adcc_firstread OR
                                    rd_sel) AND ((NOT lbe0_in_n)
                                    AND (NOT lbe4_in_n))) OR
                                    (LBE0_N AND (NOT LBE4_N));
                    fifo_adcc_firstread <= fifo_adcc_firstread
                                                AND (NOT rd_sel);
                    -- Page 7
                    if (lready_n_shadow = '1' AND
                                fifo_adcc_firstread = '0' AND
                                            lbe4_in_n = '0') then
                        lad_out <= fifo_adcc_dq;
                    else
                        lad_out <= fifo_adcc_data;
                    end if;
                when 3 =>
                    -- Page 4
                    adcd_sel    <= ((fifo_adcd_firstread OR
                                    rd_sel) AND ((NOT lbe0_in_n)
                                    AND (NOT lbe4_in_n))) OR
                                    (LBE0_N AND (NOT LBE4_N));
                    fifo_adcd_firstread <= fifo_adcd_firstread
                                                AND (NOT rd_sel);
                    -- Page 7
                    if (lready_n_shadow = '1' AND
                                fifo_adcd_firstread = '0' AND
                                            lbe4_in_n = '0') then
                        lad_out <= fifo_adcd_dq;
                    else
                        lad_out <= fifo_adcd_data;
                    end if;
                when 8 =>
                    -- Page 5
                    memr_sel    <= ((fifo_memr_firstread OR
                                    rd_sel) AND ((NOT lbe0_in_n)
                                    AND (NOT lbe4_in_n))) OR
                                    (LBE0_N AND (NOT LBE4_N));
                    fifo_memr_firstread <= fifo_memr_firstread
                                                AND (NOT rd_sel);
                    -- Page 7
                    if (lready_n_shadow = '1' AND
                                fifo_memr_firstread = '0' AND
                                            lbe4_in_n = '0') then
                        lad_out <= fifo_memr_dq;
                    else
                        lad_out <= fifo_memr_data;
                    end if;
                when 12 =>
                    -- Page 5
                    testr_sel   <= ((fifo_testr_firstread OR
                                    rd_sel) AND ((NOT lbe0_in_n)
                                    AND (NOT lbe4_in_n))) OR
                                    (LBE0_N AND (NOT LBE4_N));
                    fifo_testr_firstread<= fifo_testr_firstread
                                                AND (NOT rd_sel);
                    -- Page 7
                    if (lready_n_shadow = '1' AND
                                fifo_testr_firstread = '0' AND
                                            lbe4_in_n = '0') then
                        lad_out <= fifo_testr_dq;
                    else
                        lad_out <= fifo_testr_data;
                    end if;
                when 15 =>
                    if (laddr_27 = '0') then
                        lad_out(15 downto 0)<= ctlreg_data;
                    end if;
                when others =>
                    -- Page 4
                    adca_sel    <= '0';
                    adcb_sel    <= '0';
                    adcc_sel    <= '0';
                    adcd_sel    <= '0';
                    -- Page 7
                    lad_out     <= (others => '0');
                    -- Page 5
                    memr_sel    <= '0';
                    -- Page 2
                    rd_sel      <= '0';
                    -- Page 5
                    testr_sel   <= '0';
                end case;
            end if;
        end if;
    END PROCESS;

    -------------------------------------------------------------
    -- ********************** Test FIFO ********************** --
    -------------------------------------------------------------

    -- See Block Diagram, page 8
    FIFO_TEST : fifo_d1k_w64_r64
    PORT MAP (
        Rd_Clk              => lclk,
        Rd_En               => testr_sel,
        Rst                 => fifo_test_rst,
        Wr_Clk              => lclk,
        Wr_En               => testw_sel,

        Din                 => fifo_testw_dq,
        Prog_Empty_Thresh   => fifo_test_count_ae(9 downto 0),
        Prog_Full_Thresh    => fifo_test_count_af(9 downto 0),

        Dout                => fifo_testr_data,

        Almost_Empty        => OPEN,
        Almost_Full         => OPEN,
        Empty               => fifo_test_e,
        Full                => fifo_test_f,
        Prog_Empty          => fifo_test_ae,
        Prog_Full           => fifo_test_af
        );

    PROCESS (fifo_test_ae, fifo_test_af, lclk, rst)
    BEGIN
        if (rst = '1') then
            fifo_testr_req      <= '0';
            fifo_testw_req      <= '1';
        elsif (rising_edge (lclk)) then
            if (fifo_test_ae = '1') then
                fifo_testr_req  <= '0';
                fifo_testw_req  <= '1';
            elsif (fifo_test_af = '1') then
                fifo_testr_req  <= '1';
                fifo_testw_req  <= '0';
            end if;
        end if;
    END PROCESS;

    -------------------------------------------------------------
    -- ***************** Memory  Application ***************** --
    -------------------------------------------------------------

    -- See Block Diagram, page 14
    MEMAPP : MEMORY_APP
    PORT MAP (
        Adc_Clk             => adc_clk,
        Byteswap            => byteswap,
        Cal_Clk             => cal_clk,
        Dac_Clk             => dac_clk,

        Ddr0_Fb0in          => DDR0_FB0IN,
        Ddr0_Fb1in          => DDR0_FB1IN,
        Ddr1_Fb0in          => DDR1_FB0IN,
        Ddr1_Fb1in          => DDR1_FB1IN,
        Ddr2_Fb0in          => DDR2_FB0IN,
        Ddr2_Fb1in          => DDR2_FB1IN,

        Fifo_AdcAm_Rst      => fifo_adca_rst,
        Fifo_AdcAm_Wren     => fifo_adca_wren,
        Fifo_AdcBm_Rst      => fifo_adcb_rst,
        Fifo_AdcBm_Wren     => fifo_adcc_wren,
        Fifo_Dacm_Rden      => fifo_dacm_rden,
        Fifo_Dacm_Rst       => fifo_daca_rst,
        Fifo_Memr_Rst       => fifo_memr_rst,
        Fifo_Memr_Sel       => memr_sel,
        Fifo_Memw_Rst       => fifo_memw_rst,
        Fifo_Memw_Sel       => memw_sel,

        Idelayctrl_Rdy      => idelayctrl_rdy,
        Int_Reset_n         => int_reset_n,
        Lclk                => lclk,
        Sclk                => sys_clk,
        Wclk                => wclk,

        AdcA_Data           => adc_ab_data,
        AdcB_Data           => adc_cd_data,

        Ddr0_Dq_In          => ddr0_dq_in,
        Ddr0_Dqs_in         => ddr0_dqs_in,
        Ddr1_Dq_In          => ddr1_dq_in,
        Ddr1_Dqs_in         => ddr1_dqs_in,
        Ddr2_Dq_In          => ddr2_dq_in,
        Ddr2_Dqs_in         => ddr2_dqs_in,

        Fifo_Memr_Count_AE  => fifo_memr_count_ae(9 downto 0),
        Fifo_Memr_Count_AF  => fifo_memr_count_af(9 downto 0),
        Fifo_Memw_Count_AE  => fifo_memw_count_ae(9 downto 0),
        Fifo_Memw_Count_AF  => fifo_memw_count_af(9 downto 0),

        Fifo_Memw_Din       => fifo_memw_dq,
        Mem_Ctrl_Reg        => mem_ctrl_reg,

        Mem0_Depth_Reg_H    => mem0_depth_reg_h,
        Mem0_Depth_Reg_L    => mem0_depth_reg_l,
        Mem0_Start_Reg_H    => mem0_start_reg_h,
        Mem0_Start_Reg_L    => mem0_start_reg_l,
        Mem1_Depth_Reg_H    => mem1_depth_reg_h,
        Mem1_Depth_Reg_L    => mem1_depth_reg_l,
        Mem1_Start_Reg_H    => mem1_start_reg_h,
        Mem1_Start_Reg_L    => mem1_start_reg_l,
        Mem2_Depth_Reg_H    => mem2_depth_reg_h,
        Mem2_Depth_Reg_L    => mem2_depth_reg_l,
        Mem2_Start_Reg_H    => mem2_start_reg_h,
        Mem2_Start_Reg_L    => mem2_start_reg_l,

        Ddr0_Address        => ddr0_vaddress,
        Ddr0_Ba             => DDR0_BA,
        Ddr0_Cke            => ddr0_vcke,
        Ddr0_Cs_n           => ddr0_vcs_n,
        Ddr0_Dm             => OPEN,
        Ddr0_Dq_oe_n        => ddr0_dq_oe_n,
        Ddr0_Dq_out         => ddr0_dq_out,
        Ddr0_Dqs_oe_n       => ddr0_dqs_oe_n,
        Ddr0_Dqs_out        => ddr0_dqs_out,

        Ddr1_Address        => ddr1_vaddress,
        Ddr1_Ba             => DDR1_BA,
        Ddr1_Cke            => ddr1_vcke,
        Ddr1_Cs_n           => ddr1_vcs_n,
        Ddr1_Dm             => OPEN,
        Ddr1_Dq_oe_n        => ddr1_dq_oe_n,
        Ddr1_Dq_out         => ddr1_dq_out,
        Ddr1_Dqs_oe_n       => ddr1_dqs_oe_n,
        Ddr1_Dqs_out        => ddr1_dqs_out,

        Ddr2_Address        => ddr2_vaddress,
        Ddr2_Ba             => DDR2_BA,
        Ddr2_Cke            => ddr2_vcke,
        Ddr2_Cs_n           => ddr2_vcs_n,
        Ddr2_Dm             => OPEN,
        Ddr2_Dq_oe_n        => ddr2_dq_oe_n,
        Ddr2_Dq_out         => ddr2_dq_out,
        Ddr2_Dqs_oe_n       => ddr2_dqs_oe_n,
        Ddr2_Dqs_out        => ddr2_dqs_out,

        Fifo_Dacm_Dout      => fifo_dacm_dout,
        Fifo_Memr_Dout      => fifo_memr_data,

        Mem0_End_Reg_H      => mem0_end_reg_h,
        Mem0_End_Reg_L      => mem0_end_reg_l,
        Mem0_Trig_Reg_H     => mem0_trig_reg_h,
        Mem0_Trig_Reg_L     => mem0_trig_reg_l,
        Mem1_End_Reg_H      => mem1_end_reg_h,
        Mem1_End_Reg_L      => mem1_end_reg_l,
        Mem1_Trig_Reg_H     => mem1_trig_reg_h,
        Mem1_Trig_Reg_L     => mem1_trig_reg_l,
        Mem2_End_Reg_H      => mem2_end_reg_h,
        Mem2_End_Reg_L      => mem2_end_reg_l,

        Ddr0_Casb           => DDR0_CASB,
        Ddr0_Fb0out         => DDR0_FB0OUT,
        Ddr0_Fb1out         => DDR0_FB1OUT,
        Ddr0_Odt            => DDR0_ODT,
        Ddr0_Rasb           => DDR0_RASB,
        Ddr0_Web            => DDR0_WEB,

        Ddr1_Casb           => DDR1_CASB,
        Ddr1_Fb0out         => DDR1_FB0OUT,
        Ddr1_Fb1out         => DDR1_FB1OUT,
        Ddr1_Odt            => DDR1_ODT,
        Ddr1_Rasb           => DDR1_RASB,
        Ddr1_Web            => DDR1_WEB,

        Ddr2_Casb           => DDR2_CASB,
        Ddr2_Fb0out         => DDR2_FB0OUT,
        Ddr2_Fb1out         => DDR2_FB1OUT,
        Ddr2_Odt            => DDR2_ODT,
        Ddr2_Rasb           => DDR2_RASB,
        Ddr2_Web            => DDR2_WEB,

        Fifo_Memr_AE        => fifo_memr_ae,
        Fifo_Memr_AF        => fifo_memr_af,
        Fifo_Memr_E         => fifo_memr_e,
        Fifo_Memr_F         => fifo_memr_f,
        Fifo_Memr_Req       => fifo_memr_req,

        Fifo_Memw_AE        => fifo_memw_ae,
        Fifo_Memw_AF        => fifo_memw_af,
        Fifo_Memw_E         => fifo_memw_e,
        Fifo_Memw_F         => fifo_memw_f,
        Fifo_Memw_Req       => fifo_memw_req
        );

    -- See Block Diagram, page 1
    RESET_DELAY_SR : SRL16
    PORT MAP (
        A0      => vcc,
        A1      => vcc,
        A2      => vcc,
        A3      => vcc,
        Clk     => lclk,
        D       => sys_clk_lock,

        Q       => int_reset_n
        );

    int_reset       <= NOT int_reset_n;

    -- See Block Diagram, page 14
    DDR0_DM         <= "0000";
    DDR0_CSB        <= ddr0_vcs_n(0);
    DDR0_CKE        <= ddr0_vcke(0);
    DDR0_ADDRESS(14)<='0';
    DDR0_ADDRESS(13 downto 0)
                    <= ddr0_vaddress(13 downto 0);

    DDR1_DM         <= "0000";
    DDR1_CSB        <= ddr1_vcs_n(0);
    DDR1_CKE        <= ddr1_vcke(0);
    DDR1_ADDRESS(14)<='0';
    DDR1_ADDRESS(13 downto 0)
                    <= ddr1_vaddress(13 downto 0);

    DDR2_DM         <= "0000";
    DDR2_CSB        <= ddr2_vcs_n(0);
    DDR2_CKE        <= ddr2_vcke(0);
    DDR2_ADDRESS(14)<='0';
    DDR2_ADDRESS(13 downto 0)
                    <= ddr2_vaddress(13 downto 0);

    -- IDELAYCTRL instantiation - Need only one at the top level.
    DELAYCTRL0 : IDELAYCTRL
    PORT MAP (
        Refclk  => ref_clk,
        Rst     => int_reset,

        Rdy     => idelayctrl_rdy
        );

    -------------------------------------------------------------
    -- * Create tri-state IOBs  with output enable registers * --
    -- *** Output Enable Registers are implemented at this *** --
    -- **** level to assure proper IOB placement, and are **** --
    -- *** instantiated manually, to prevent inappropriate *** --
    -- * IOB sharing by synthesis tools during optimization. * --
    -------------------------------------------------------------

    -- See Block Diagram, page 14
    -- DDR0_DQ Tri-State Buffers

    DDR0_DQ_TS_FORMATION : for j in 0 to 31 GENERATE

        DDR0_DQ_IOBUF_INST : IOBUF
        PORT MAP (
            I   => ddr0_dq_out(j),
            T   => ddr0_dq_oe_n(j),

            Io  => DDR0_DQ(j),

            O   => ddr0_dq_in(j)
            );
 
    END GENERATE DDR0_DQ_TS_FORMATION;

    -- DDR0_DQS Buffers

    DDR0_DQS_TS_FORMATION : for j in 0 to 3 GENERATE

        -- DDR0_DQS Tri-State Buffer
        DDR0_DQS_OBUFT_INST : IOBUF
        PORT MAP (
            I   => ddr0_dqs_out(j),
            T   => ddr0_dqs_oe_n(j),

            Io  => DDR0_DQS(j),

            O   => DDR0_DQS_in(j)
            );

        -- DDR0_DQSB Buffer
        DDR0_DQSB_OBUFT_INST : OBUFT
        PORT MAP (
            I   => gnd,
            T   => ddr0_dqs_oe_n(j),

            O   => DDR0_DQSB(j)
            );

    END GENERATE DDR0_DQS_TS_FORMATION;

    -- DDR1_DQ Tri-State Buffers

    DDR1_DQ_TS_FORMATION : for j in 0 to 31 GENERATE

        DDR1_DQ_IOBUF_INST : IOBUF
        PORT MAP (
            I   => ddr1_dq_out(j),
            T   => ddr1_dq_oe_n(j),

            Io  => DDR1_DQ(j),

            O   => ddr1_dq_in(j)
            );
 
    END GENERATE DDR1_DQ_TS_FORMATION;

    -- DDR1_DQS Buffers
    DDR1_DQS_TS_FORMATION : for j in 0 to 3 GENERATE

        -- DDR1_DQS Tri-State Buffer
        DDR1_DQS_OBUFT_INST : IOBUF
        PORT MAP (
            I   => ddr1_dqs_out(j),
            T   => ddr1_dqs_oe_n(j),

            Io  => DDR1_DQS(j),

            O   => DDR1_DQS_in(j)
            );

        -- DDR1_DQSB Buffer
        DDR1_DQSB_OBUFT_INST : OBUFT
        PORT MAP (
            I   => gnd,
            T   => ddr1_dqs_oe_n(j),

            O   => DDR1_DQSB(j)
            );

    END GENERATE DDR1_DQS_TS_FORMATION;

    -- DDR2_DQ Tri-State Buffers

    DDR2_DQ_TS_FORMATION : for j in 0 to 31 GENERATE

        DDR2_DQ_IOBUF_INST : IOBUF
        PORT MAP (
            I   => ddr2_dq_out(j),
            T   => ddr2_dq_oe_n(j),

            Io  => DDR2_DQ(j),

            O   => ddr2_dq_in(j)
            );
 
    END GENERATE DDR2_DQ_TS_FORMATION;

    -- DDR2_DQS Buffers
    DDR2_DQS_TS_FORMATION : for j in 0 to 3 GENERATE

        -- DDR2_DQS Tri-State Buffer
        DDR2_DQS_OBUFT_INST : IOBUF
        PORT MAP (
            I   => ddr2_dqs_out(j),
            T   => ddr2_dqs_oe_n(j),

            Io  => DDR2_DQS(j),

            O   => ddr2_dqs_in(j)
            );

        -- DDR2_DQSB Buffer
        DDR2_DQSB_OBUFT_INST : OBUFT
        PORT MAP (
            I   => gnd,
            T   => ddr2_dqs_oe_n(j),

            O   => DDR2_DQSB(j)
            );

    END GENERATE DDR2_DQS_TS_FORMATION;

    -------------------------------------------------------------
    -- ********************** TEMP  I/O ********************** --
    -------------------------------------------------------------

    -- See Block Diagram, page 2
    TEMP_IOB : PROCESS (lclk, rst)
    BEGIN
        if rst = '1' then
            FLASH_RP_N   <= '1';
        elsif (rising_edge (lclk)) then
            FLASH_RP_N   <= lwait_in_n AND GATEA_INT AND
                                                    GATEB_INT;
        end if;
    END PROCESS;

    -------------------------------------------------------------
    -- ***************** LVDS I/O  Interface ***************** --
    -------------------------------------------------------------

    -- See Block Diagram page 15
    LVDS1_GCFB_IBUFG : IBUFGDS_LVDS_25
    PORT MAP (
        I   => LVDS1_GCFB_P,
        Ib  => LVDS1_GCFB_N,

        O   => lvds1_gcfb_buf
        );

    LVDS1_GCFB_BUFG : BUFG
    PORT MAP (
        I => lvds1_gcfb_buf,

        O => lvds1_gcfb
        );

    LVDS2_GCFB_IBUFG : IBUFGDS_LVDS_25
    PORT MAP (
        I   => LVDS2_GCFB_P,
        Ib  => LVDS2_GCFB_N,

        O   => lvds2_gcfb_buf
        );

    LVDS2_GCFB_BUFG : BUFG
    PORT MAP (
        I   => lvds2_gcfb_buf,

        O   => lvds2_gcfb
        );

    LVDS1_GCLK_OBUF : OBUFDS_LVDS_25
    PORT MAP (
        I   => lvds1_gclk,

        O   => LVDS1_GCLK_P,
        Ob  => LVDS1_GCLK_N
        );

    LVDS2_GCLK_OBUF : OBUFDS_LVDS_25
    PORT MAP (
        I   => lvds2_gclk,

        O   => LVDS2_GCLK_P,
        Ob  => LVDS2_GCLK_N
        );

    LVDS1_RC_OUT_OBUFDS : OBUFDS_LVDS_25
    PORT MAP (
        I   => lvds1_rc_out,

        O   => LVDS1_RC_OUT_P,
        Ob  => LVDS1_RC_OUT_N
        );

    LVDS2_RC_OUT_OBUFDS : OBUFDS_LVDS_25
    PORT MAP (
        I   => lvds2_rc_out,

        O   => LVDS2_RC_OUT_P,
        Ob  => LVDS2_RC_OUT_N
        );

    LVDS3_RC_IN_BUFDS : IBUFDS_LVDS_25
    PORT MAP (
        I   => LVDS3_RC_IN_P,
        Ib  => LVDS3_RC_IN_N,

        O   => lvds3_rc_in_buf
        );

    LVDS3_RC_IN_BUFIO : BUFIO
    PORT MAP (
        I   => lvds3_rc_in_buf,

        O   => lvds3_rc_in
        );

    LVDS4_RC_IN_BUFDS : IBUFDS_LVDS_25
    PORT MAP (
        I   => LVDS4_RC_IN_P,
        Ib  => LVDS4_RC_IN_N,

        O   => lvds4_rc_in_buf
        );

    LVDS4_RC_IN_BUFIO : BUFIO
    PORT MAP (
        I   => lvds4_rc_in_buf,

        O   => lvds4_rc_in
        );

    LVDS1_CTL_OBUF : OBUFDS_LVDS_25
    PORT MAP (
        I   => lvds1_ctl,

        O   => LVDS1_CTL_P,
        Ob  => LVDS1_CTL_N
        );

    LVDS2_CTL_OBUF : OBUFDS_LVDS_25
    PORT MAP (
        I   => lvds2_ctl,

        O   => LVDS2_CTL_P,
        Ob  => LVDS2_CTL_N
        );

    LVDS3_CTL_OBUF : OBUFDS_LVDS_25
    PORT MAP (
        I   => lvds3_ctl,

        O   => LVDS3_CTL_P,
        Ob  => LVDS3_CTL_N
        );

    LVDS4_CTL_IBUF : IBUFDS_LVDS_25
    PORT MAP (
        I   => LVDS4_CTL_P,
        Ib  => LVDS4_CTL_N,

        O   => lvds4_ctl
        );

    GEN_LVDS1_DAT : for X in 0 to 15 GENERATE
    LVDS1_DAT_OBUF : OBUFDS_LVDS_25
    PORT MAP (
        I   => lvds1_out(X),

        O   => LVDS1_DAT_P(X),
        Ob  => LVDS1_DAT_N(X)
        );
    END GENERATE GEN_LVDS1_DAT;

    GEN_LVDS2_DAT : for X in 0 to 15 GENERATE
    LVDS2_DAT_OBUF : OBUFDS_LVDS_25
    PORT MAP (
        I   => lvds2_out(X),

        O   => LVDS2_DAT_P(X),
        Ob  => LVDS2_DAT_N(X)
        );
    END GENERATE GEN_LVDS2_DAT;

    GEN_LVDS3_DAT : for X in 0 to 15 GENERATE
    LVDS3_DAT_OBUF : OBUFDS_LVDS_25
    PORT MAP (
        I   => lvds3_out(X),

        O   => LVDS3_DAT_P(X),
        Ob  => LVDS3_DAT_N(X)
        );
    END GENERATE GEN_LVDS3_DAT;

    GEN_LVDS4_DAT : for X in 0 to 3 GENERATE
    LVDS4_DAT_IBUF : IBUFDS_LVDS_25
    PORT MAP (
        I   => LVDS4_DAT_P(X),
        Ib  => LVDS4_DAT_N(X),

        O   => lvds4_in(X)
        );
    END GENERATE GEN_LVDS4_DAT;

    lvds_outq       <= px_io_data_out;

    lvds1_out       <= lvds_outq
                        when (rising_edge (lvds1_gcfb))
                        else lvds1_out;
    lvds1_ctl       <= byteswap
                        when (rising_edge (lvds1_gcfb))
                        else lvds1_ctl;
    lvds1_gclk      <= '1';
    lvds1_rc_out    <= byteswap
                        when (rising_edge (lvds1_gcfb))
                        else lvds1_rc_out;

    lvds2_out       <= lvds_outq
                        when (rising_edge (lvds2_gcfb))
                        else lvds2_out;
    lvds2_ctl       <= byteswap
                        when (rising_edge (lvds2_gcfb))
                        else lvds2_ctl;
    lvds2_gclk      <= '1';
    lvds2_rc_out    <= byteswap
                        when (rising_edge (lvds2_gcfb))
                        else lvds2_rc_out;

    lvds3_out       <= lvds_outq
                        when (rising_edge (lvds3_rc_in))
                        else lvds3_out;
    lvds3_ctl       <= byteswap
                        when (rising_edge (lvds3_rc_in))
                        else lvds3_ctl;
    
    px_io_data_in(14 downto 0)
                        <= (lvds4_in & "00000000000")
                            when (rising_edge (lvds4_rc_in))
                            else px_io_data_in(14 downto 0);
    px_io_data_in(15)   <= lvds4_ctl
                            when (rising_edge (lvds4_rc_in))
                            else px_io_data_in(15);

    -------------------------------------------------------------
    -- **************** Sub-Module  Port Maps **************** --
    -------------------------------------------------------------

    -- See Block Diagram, page 1
    CLKGEN : CLK_GEN
    PORT MAP (
        Lclk    => lclk,
        Rst     => rst,

        Dac_Sclk=> dac_sclk_int
        );

    -- See Block Diagram, page 3
    tmp_vlt_int1    <= NOT TMP_VLT_INT1_N;

    -- See Block Diagram, pages 2, 3 & 8 - 15
    CONTROL : CNTRLREG
    PORT MAP (
        Iic_Dat                 => IIC_DAT,

        Clk                     => lclk,
        ClkA_Loss               => CLK_DETA,
        ClkB_Loss               => CLK_DETB,
        Dac_Plllock             => dac_plllock_buf,
        Dac_Sclk                => dac_sclk_int,
        Dac_Sdo                 => DAC_SDO,
--      Dcm_Clk_loss            => '0',
        Dcm_Dac_Locked          => dcm_dac_locked,
        Dcm_Pll_Locked          => dcm_pll_locked,

        Fifo_AdcA_AE            => fifo_adca_ae,
        Fifo_AdcA_AF            => fifo_adca_af,
        Fifo_AdcA_E             => fifo_adca_e,
        Fifo_AdcA_En            => fifo_adca_en,
        Fifo_AdcA_F             => fifo_adca_f,
        Fifo_AdcA_Trig_Stat     => fifo_adca_trig_stat,

        Fifo_AdcB_AE            => fifo_adcb_ae,
        Fifo_AdcB_AF            => fifo_adcb_af,
        Fifo_AdcB_E             => fifo_adcb_e,
        Fifo_AdcB_En            => fifo_adcb_en,
        Fifo_AdcB_F             => fifo_adcb_f,
        Fifo_AdcB_Trig_Stat     => fifo_adcb_trig_stat,

        Fifo_AdcC_AE            => fifo_adcc_ae,
        Fifo_AdcC_AF            => fifo_adcc_af,
        Fifo_AdcC_E             => fifo_adcc_e,
        Fifo_AdcC_En            => fifo_adcc_en,
        Fifo_AdcC_F             => fifo_adcc_f,
        Fifo_AdcC_Trig_Stat     => fifo_adcc_trig_stat,

        Fifo_AdcD_AE            => fifo_adcd_ae,
        Fifo_AdcD_AF            => fifo_adcd_af,
        Fifo_AdcD_E             => fifo_adcd_e,
        Fifo_AdcD_En            => fifo_adcd_en,
        Fifo_AdcD_F             => fifo_adcd_f,
        Fifo_AdcD_Trig_Stat     => fifo_adcd_trig_stat,

        Fifo_DacA_AE            => fifo_daca_ae,
        Fifo_DacA_AF            => fifo_daca_af,
        Fifo_DacA_E             => fifo_daca_e,
        Fifo_DacA_En            => fifo_daca_en,
        Fifo_DacA_F             => fifo_daca_f,
        Fifo_DacA_Trig_Stat     => fifo_daca_trig_stat,

        Fifo_MemR_AE            => fifo_memr_ae,
        Fifo_MemR_AF            => fifo_memr_af,
        Fifo_MemR_E             => fifo_memr_e,
        Fifo_MemR_En            => gnd,
        Fifo_MemR_F             => fifo_memr_f,

        Fifo_MemW_AE            => fifo_memw_ae,
        Fifo_MemW_AF            => fifo_memw_af,
        Fifo_MemW_E             => fifo_memw_e,
        Fifo_MemW_En            => gnd,
        Fifo_MemW_F             => fifo_memw_f,

        Fifo_Test_AE            => fifo_test_ae,
        Fifo_Test_AF            => fifo_test_af,
        Fifo_Test_E             => fifo_test_e,
        Fifo_Test_F             => fifo_test_f,

        GateA_n                 => gatea_n,
        GateB_n                 => gateb_n,

        Ovld1_Int               => ADC_OVRA,
        Ovld2_Int               => ADC_OVRB,
        Ovld3_Int               => ADC_OVRC,
        Ovld4_Int               => ADC_OVRD,

        Reg_Sel                 => reg_sel,
        Rst                     => rst,

        SyncA_n                 => synca_n,
        SyncB_n                 => syncb_n,

        Temp_Int                => tmp_vlt_int1,
        Wepls                   => reg_sel,

        Addr                    => laddr(11 downto 3),
        Dat_In                  => ctlreg_dq,
        IO_Data_In              => px_io_data_in,

        Fifo_AdcA_Pre_Count_H   => fifo_adca_pre_count_h,
        Fifo_AdcA_Pre_Count_L   => fifo_adca_pre_count_l,
        Fifo_AdcB_Pre_Count_H   => fifo_adcb_pre_count_h,
        Fifo_AdcB_Pre_Count_L   => fifo_adcb_pre_count_l,
        Fifo_AdcC_Pre_Count_H   => fifo_adcc_pre_count_h,
        Fifo_AdcC_Pre_Count_L   => fifo_adcc_pre_count_l,
        Fifo_AdcD_Pre_Count_H   => fifo_adcd_pre_count_h,
        Fifo_AdcD_Pre_Count_L   => fifo_adcd_pre_count_l,

        Mem0_End_Reg_H          => mem0_end_reg_h,
        Mem0_End_Reg_L          => mem0_end_reg_l,
        Mem0_Trig_Reg_H         => mem0_trig_reg_h,
        Mem0_Trig_Reg_L         => mem0_trig_reg_l,

        Mem1_End_Reg_H          => mem1_end_reg_h,
        Mem1_End_Reg_L          => mem1_end_reg_l,
        Mem1_Trig_Reg_H         => mem1_trig_reg_h,
        Mem1_Trig_Reg_L         => mem1_trig_reg_l,

        Mem2_End_Reg_H          => mem2_end_reg_h,
        Mem2_End_Reg_L          => mem2_end_reg_l,

        Dat_Out                 => ctlreg_data,
        Extd_Addr               => extd_addr,

        Fifo_AdcA_Count_AE      => fifo_adca_count_ae,
        Fifo_AdcA_Count_AF      => fifo_adca_count_af,
        Fifo_AdcA_Decdiv        => fifo_adca_decdiv,
        Fifo_AdcA_Packmode      => fifo_adca_packmode,
        Fifo_AdcA_Post_Length_H => fifo_adca_post_length_h,
        Fifo_AdcA_Post_Length_L => fifo_adca_post_length_l,
        Fifo_AdcA_Triglen_H     => fifo_adca_triglen_h,
        Fifo_AdcA_Triglen_L     => fifo_adca_triglen_l,

        Fifo_AdcB_Count_AE      => fifo_adcb_count_ae,
        Fifo_AdcB_Count_AF      => fifo_adcb_count_af,
        Fifo_AdcB_Decdiv        => fifo_adcb_decdiv,
        Fifo_AdcB_Packmode      => fifo_adcb_packmode,
        Fifo_AdcB_Post_Length_H => fifo_adcb_post_length_h,
        Fifo_AdcB_Post_Length_L => fifo_adcb_post_length_l,
        Fifo_AdcB_Triglen_H     => fifo_adcb_triglen_h,
        Fifo_AdcB_Triglen_L     => fifo_adcb_triglen_l,

        Fifo_AdcC_Count_AE      => fifo_adcc_count_ae,
        Fifo_AdcC_Count_AF      => fifo_adcc_count_af,
        Fifo_AdcC_Decdiv        => fifo_adcc_decdiv,
        Fifo_AdcC_Packmode      => fifo_adcc_packmode,
        Fifo_AdcC_Post_Length_H => fifo_adcc_post_length_h,
        Fifo_AdcC_Post_Length_L => fifo_adcc_post_length_l,
        Fifo_AdcC_Triglen_H     => fifo_adcc_triglen_h,
        Fifo_AdcC_Triglen_L     => fifo_adcc_triglen_l,

        Fifo_AdcD_Count_AE      => fifo_adcd_count_ae,
        Fifo_AdcD_Count_AF      => fifo_adcd_count_af,
        Fifo_AdcD_Decdiv        => fifo_adcd_decdiv,
        Fifo_AdcD_Packmode      => fifo_adcd_packmode,
        Fifo_AdcD_Post_Length_H => fifo_adcd_post_length_h,
        Fifo_AdcD_Post_Length_L => fifo_adcd_post_length_l,
        Fifo_AdcD_Triglen_H     => fifo_adcd_triglen_h,
        Fifo_AdcD_Triglen_L     => fifo_adcd_triglen_l,

        Fifo_DacA_Count_AE      => fifo_daca_count_ae,
        Fifo_DacA_Count_AF      => fifo_daca_count_af,
        Fifo_DacA_Packmode      => fifo_daca_packmode,
        Fifo_DacA_Post_Length_H => fifo_daca_post_length_h,
        Fifo_DacA_Post_Length_L => fifo_daca_post_length_l,
        Fifo_DacA_Triglen_H     => fifo_daca_triglen_h,
        Fifo_DacA_Triglen_L     => fifo_daca_triglen_l,

        Fifo_MemR_Count_AE      => fifo_memr_count_ae,
        Fifo_MemR_Count_AF      => fifo_memr_count_af,

        Fifo_MemW_Count_AE      => fifo_memw_count_ae,
        Fifo_MemW_Count_AF      => fifo_memw_count_af,

        Fifo_Test_Count_AE      => fifo_test_count_ae,
        Fifo_Test_Count_AF      => fifo_test_count_af,

        Int                     => int,
        IO_Data_Out             => px_io_data_out,

        Mem_Ctrl_Reg            => mem_ctrl_reg,

        Mem0_Depth_Reg_H        => mem0_depth_reg_h,
        Mem0_Depth_Reg_L        => mem0_depth_reg_l,
        Mem0_Start_Reg_H        => mem0_start_reg_h,
        Mem0_Start_Reg_L        => mem0_start_reg_l,

        Mem1_Depth_Reg_H        => mem1_depth_reg_h,
        Mem1_Depth_Reg_L        => mem1_depth_reg_l,
        Mem1_Start_Reg_H        => mem1_start_reg_h,
        Mem1_Start_Reg_L        => mem1_start_reg_l,

        Mem2_Depth_Reg_H        => mem2_depth_reg_h,
        Mem2_Depth_Reg_L        => mem2_depth_reg_l,
        Mem2_Start_Reg_H        => mem2_start_reg_h,
        Mem2_Start_Reg_L        => mem2_start_reg_l,

        Adc_Clk_Sel             => clksel_adc_int,
        Bus_Master_A            => BUSA_MASTER,
        Bus_Master_B            => BUSB_MASTER,
        Bus_Term_A              => BUSA_TERM,
        Bus_Term_B              => BUSB_TERM,
        Byteswap                => byteswap,

        Clk_Src_A               => CLKSEL_ADC(1),
        Clk_Src_B               => CLKSEL_DAC(1),

        Dac_Clk_Sel             => clksel_dac_int,
        Dac_Qflag               => DAC_QFLAG,
        Dac_Reset_n             => DAC_RESET_N,
        Dac_Sden_n              => DAC_SDEN_N,
        Dac_Sdio                => DAC_SDIO,
        Dac_Sync_Mask           => dac_sync_mask,
        Dacmode                 => dacmode,

        Dcm_Clk_Sel             => dcm_clk_sel,
        Dcm_Rst                 => dcm_rst,

        Ext_Clk_A               => EXTCLKA_EN,
        Ext_Clk_B               => EXTCLKB_EN,
        Ext_Gate_A              => ext_gate_a,
        Ext_Gate_B              => ext_gate_b,
        Ext_Sync_A              => ext_sync_a,
        Ext_Sync_B              => ext_sync_b,

        Fifo_AdcA_Arm           => fifo_adca_arm,
        Fifo_AdcA_Clear         => fifo_adca_clear,
        Fifo_AdcA_Gate_Disbl    => fifo_adca_gate_disbl,
        Fifo_AdcA_Gate_Enable   => fifo_adca_gate_enable,
        Fifo_AdcA_Gate_Selb     => fifo_adca_gate_selb,
        Fifo_AdcA_Hold          => fifo_adca_hold,
        Fifo_AdcA_Pretrig       => fifo_adca_pretrig,
        Fifo_AdcA_Rst           => fifo_adca_rst,
        Fifo_AdcA_Trig          => fifo_adca_trig,

        Fifo_AdcB_Arm           => fifo_adcb_arm,
        Fifo_AdcB_Clear         => fifo_adcb_clear,
        Fifo_AdcB_Gate_Disbl    => fifo_adcb_gate_disbl,
        Fifo_AdcB_Gate_Enable   => fifo_adcb_gate_enable,
        Fifo_AdcB_Gate_Selb     => fifo_adcb_gate_selb,
        Fifo_AdcB_Hold          => fifo_adcb_hold,
        Fifo_AdcB_Pretrig       => fifo_adcb_pretrig,
        Fifo_AdcB_Rst           => fifo_adcb_rst,
        Fifo_AdcB_Trig          => fifo_adcb_trig,

        Fifo_AdcC_Arm           => fifo_adcc_arm,
        Fifo_AdcC_Clear         => fifo_adcc_clear,
        Fifo_AdcC_Gate_Disbl    => fifo_adcc_gate_disbl,
        Fifo_AdcC_Gate_Enable   => fifo_adcc_gate_enable,
        Fifo_AdcC_Gate_Selb     => fifo_adcc_gate_selb,
        Fifo_AdcC_Hold          => fifo_adcc_hold,
        Fifo_AdcC_Pretrig       => fifo_adcc_pretrig,
        Fifo_AdcC_Rst           => fifo_adcc_rst,
        Fifo_AdcC_Trig          => fifo_adcc_trig,

        Fifo_AdcD_Arm           => fifo_adcd_arm,
        Fifo_AdcD_Clear         => fifo_adcd_clear,
        Fifo_AdcD_Gate_Disbl    => fifo_adcd_gate_disbl,
        Fifo_AdcD_Gate_Enable   => fifo_adcd_gate_enable,
        Fifo_AdcD_Gate_Selb     => fifo_adcd_gate_selb,
        Fifo_AdcD_Hold          => fifo_adcd_hold,
        Fifo_AdcD_Pretrig       => fifo_adcd_pretrig,
        Fifo_AdcD_Rst           => fifo_adcd_rst,
        Fifo_AdcD_Trig          => fifo_adcd_trig,

        Fifo_DacA_Clear         => fifo_daca_clear,
        Fifo_DacA_Gate_Disbl    => fifo_daca_gate_disbl,
        Fifo_DacA_Gate_Enable   => fifo_daca_gate_enable,
        Fifo_DacA_Gate_Selb     => fifo_daca_gate_selb,
        Fifo_DacA_Hold          => fifo_daca_hold,
        Fifo_DacA_Rst           => fifo_daca_rst,
        Fifo_DacA_Trig          => fifo_daca_trig,

        Fifo_MemR_Rst           => fifo_memr_rst,
        Fifo_MemW_Rst           => fifo_memw_rst,

        Fifo_Test_Rst           => fifo_test_rst,
--      Fifos_Rdy               => fifos_rdy,

        Gate_Pol_A              => gate_pol_a,
        Gate_Pol_B              => gate_pol_b,
        Gate_Src_A              => gate_src_a,
        Gate_Src_B              => gate_src_b,
        GateGo_A                => gatego_a,
        GateGo_B                => gatego_b,

        Iic_Clk                 => IIC_CLK,

        Osc_Disbl_A             => CLKEN_ADC,
        Osc_Disbl_B             => CLKEN_DAC,
        PllVdd                  => PLLVDD,

        Sync_Pol_A              => sync_pol_a,
        Sync_Pol_B              => sync_pol_b,
        Sync_Src_A              => sync_src_a,
        Sync_Src_B              => sync_src_b,
        SyncGo_A                => syncgo_a,
        SyncGo_B                => syncgo_b,

        Test_Mode               => OPEN,
		  
--  USER Required Assignments for Digital Down Converter (DDC)

		  K_addr			           => k_addr,
		  K_data			      	  => k_data,
		  K_wr				        => k_wr,
		  G_addr			      	  => g_addr,
		  G_data			      	  => g_data,
		  G_wr 			      	  => g_wr,
		  K_readcoef				  => k_readcoef,
		  G_readcoef				  => g_readcoef,
		  
-- USER Required Assignments for Multi-Timers

		  MT_addr_reg 				  => mt_addr_reg,
		  MT_data_reg 				  => mt_data_reg,
		  MT_addr_wr  			     => mt_addr_wr,
		  MT_data_wr  				  => mt_data_wr
		  
        );

    -------------------------------------------------------------
    -- ********** Sync and Gate Generator Port Maps ********** --
    -------------------------------------------------------------

    -- See Block Diagram, page 11
    GATEA_GEN : SYNCGATE_GEN
    PORT MAP (
        Clk                 => adc_clk,
        Ext_SyncGate_En     => ext_gate_a,
        Lvds_SyncGate_In_n  => GATEA_IN_N,
        Rst                 => rst,
        SyncGate_Pol        => gate_pol_a,
        SyncGate_Src        => gate_src_a,
        SyncGateGo          => gatego_a,
        Ttl_SyncGate        => GATEA_TTL,

        Lvds_SyncGate_Out_n => GATEA_OUT_N,
        SyncGate_n_Out      => gatea_n,
        SyncGateGo_Rs       => OPEN	-- gatego_rs_a
        );

    GATEB_GEN : SYNCGATE_GEN
    PORT MAP (
        Clk                 => dac_clk,
        Ext_SyncGate_En     => ext_gate_b,
        Lvds_SyncGate_In_n  => GATEB_IN_N,
        Rst                 => rst,
        SyncGate_Pol        => gate_pol_b,
        SyncGate_Src        => gate_src_b,
        SyncGateGo          => gatego_b,
        Ttl_SyncGate        => GATEB_TTL,

        Lvds_SyncGate_Out_n => GATEB_OUT_N,
        SyncGate_n_Out      => gateb_n,
        SyncGateGo_Rs       => OPEN	-- gatego_rs_b
        );

    -- See Block Diagram, page 13
    SYNCA_GEN : SYNCGATE_GEN
    PORT MAP (
        Clk                 => adc_clk,
        Ext_SyncGate_En     => ext_sync_a,
        Lvds_SyncGate_In_n  => SYNCA_IN_N,
        Rst                 => rst,
        SyncGate_Pol        => sync_pol_a,
        SyncGate_Src        => sync_src_a,
        SyncGateGo          => syncgo_a,
        Ttl_SyncGate        => SYNCA_TTL,

        Lvds_SyncGate_Out_n => SYNCA_OUT_N,
        SyncGate_n_Out      => synca_n,
        SyncGateGo_Rs       => OPEN	-- syncgo_rs_a
      );

    SYNCB_GEN : SYNCGATE_GEN
    PORT MAP (
        Clk                 => dac_clk,
        Ext_SyncGate_En     => ext_sync_b,
        Lvds_SyncGate_In_n  => SYNCB_IN_N,
        Rst                 => rst,
        SyncGate_Pol        => sync_pol_b,
        SyncGate_Src        => sync_src_b,
        SyncGateGo          => syncgo_b,
        Ttl_SyncGate        => SYNCB_TTL,

        Lvds_SyncGate_Out_n => SYNCB_OUT_N,
        SyncGate_n_Out      => syncb_n,
        SyncGateGo_Rs       => OPEN	-- syncgo_rs_b
        );

    -------------------------------------------------------------
    -- ************* Direct Sync Signals  to DAC ************* --
    -------------------------------------------------------------

    -- See Block Diagram, page 15
    IOB_PHSTRB : PROCESS (dac_clk)
    BEGIN
        if (rising_edge (dac_clk)) then
            DAC_PHSTR   <= ((dac_sync_mask) AND (NOT synca_n)
                                    AND (NOT clksel_dac_int)) OR
                                    ((dac_sync_mask) AND
                                            (NOT syncb_n) AND
                                                clksel_dac_int);
        end if;
    END PROCESS;

    -------------------------------------------------------------
    -- *** Direct Gates to non-Local bus side FIFO Enables *** --
    -------------------------------------------------------------

    -- See Block Diagram, page 11
    GATE_ADCA : FIFO_EN_GEN
    PORT MAP (
        Arm             => fifo_adca_arm,
        Clk             => adc_clk,
        Gate_Disbl      => fifo_adca_gate_disbl,
        Gate_Enable     => fifo_adca_gate_enable,
        Gate_Selb       => fifo_adca_gate_selb,
        Gate_Trig_Sel   => fifo_adca_trig,
        GateA_In_n      => gatea_n,
        GateB_In_n      => gateb_n,
        Hold_Mode       => fifo_adca_hold,
        Pretrig         => fifo_adca_pretrig,
        Rst             => fifo_adca_rst,
        Trig_Clear      => fifo_adca_clear,

        Post_Length_H   => fifo_adca_post_length_h,
        Post_Length_L   => fifo_adca_post_length_l,
        Trig_Length_H   => fifo_adca_triglen_h,
        Trig_Length_L   => fifo_adca_triglen_l,

        Pre_Count_H     => fifo_adca_pre_count_h,
        Pre_Count_L     => fifo_adca_pre_count_l,

        Fifo_En         => fifo_adca_en,
        Trig_Reached    => fifo_adca_trig_reached,
        Trig_Stat       => fifo_adca_trig_stat
        );

    GATE_ADCB : FIFO_EN_GEN
    PORT MAP (
        Arm             => fifo_adcb_arm,
        Clk             => adc_clk,
        Gate_Disbl      => fifo_adcb_gate_disbl,
        Gate_Enable     => fifo_adcb_gate_enable,
        Gate_Selb       => fifo_adcb_gate_selb,
        Gate_Trig_Sel   => fifo_adcb_trig,
        GateA_In_n      => gatea_n,
        GateB_In_n      => gateb_n,
        Hold_Mode       => fifo_adcb_hold,
        Pretrig         => fifo_adcb_pretrig,
        Rst             => fifo_adcb_rst,
        Trig_Clear      => fifo_adcb_clear,

        Post_Length_H   => fifo_adcb_post_length_h,
        Post_Length_L   => fifo_adcb_post_length_l,
        Trig_Length_H   => fifo_adcb_triglen_h,
        Trig_Length_L   => fifo_adcb_triglen_l,

        Pre_Count_H     => fifo_adcb_pre_count_h,
        Pre_Count_L     => fifo_adcb_pre_count_l,

        Fifo_En         => fifo_adcb_en,
        Trig_Reached    => fifo_adcb_trig_reached,
        Trig_Stat       => fifo_adcb_trig_stat
        );

    -- See Block Diagram, page 12
    GATE_ADCC : FIFO_EN_GEN
    PORT MAP (
        Arm             => fifo_adcc_arm,
        Clk             => adc_clk,
        Gate_Disbl      => fifo_adcc_gate_disbl,
        Gate_Enable     => fifo_adcc_gate_enable,
        Gate_Selb       => fifo_adcc_gate_selb,
        Gate_Trig_Sel   => fifo_adcc_trig,
        GateA_In_n      => gatea_n,
        GateB_In_n      => gateb_n,
        Hold_Mode       => fifo_adcc_hold,
        Pretrig         => fifo_adcc_pretrig,
        Rst             => fifo_adcc_rst,
        Trig_Clear      => fifo_adcc_clear,

        Post_Length_H   => fifo_adcc_post_length_h,
        Post_Length_L   => fifo_adcc_post_length_l,
        Trig_Length_H   => fifo_adcc_triglen_h,
        Trig_Length_L   => fifo_adcc_triglen_l,

        Pre_Count_H     => fifo_adcc_pre_count_h,
        Pre_Count_L     => fifo_adcc_pre_count_l,

        Fifo_En         => fifo_adcc_en,
        Trig_Reached    => fifo_adcc_trig_reached,
        Trig_Stat       => fifo_adcc_trig_stat
        );

    GATE_ADCD : FIFO_EN_GEN
    PORT MAP (
        Arm             => fifo_adcd_arm,
        Clk             => adc_clk,
        Gate_Disbl      => fifo_adcd_gate_disbl,
        Gate_Enable     => fifo_adcd_gate_enable,
        Gate_Selb       => fifo_adcd_gate_selb,
        Gate_Trig_Sel   => fifo_adcd_trig,
        GateA_In_n      => gatea_n,
        GateB_In_n      => gateb_n,
        Hold_Mode       => fifo_adcd_hold,
        Pretrig         => fifo_adcd_pretrig,
        Rst             => fifo_adcd_rst,
        Trig_Clear      => fifo_adcd_clear,

        Post_Length_H   => fifo_adcd_post_length_h,
        Post_Length_L   => fifo_adcd_post_length_l,
        Trig_Length_H   => fifo_adcd_triglen_h,
        Trig_Length_L   => fifo_adcd_triglen_l,

        Pre_Count_H     => fifo_adcd_pre_count_h,
        Pre_Count_L     => fifo_adcd_pre_count_l,

        Fifo_En         => fifo_adcd_en,
        Trig_Reached    => fifo_adcd_trig_reached,
        Trig_Stat       => fifo_adcd_trig_stat
        );

    -- See Block Diagram, page 13
    GATE_DACA : FIFO_EN_GEN
    PORT MAP (
        Arm             => gnd,
        Clk             => dac_clk,
        Gate_Disbl      => fifo_daca_gate_disbl,
        Gate_Enable     => fifo_daca_gate_enable,
        Gate_Selb       => fifo_daca_gate_selb,
        Gate_Trig_Sel   => fifo_daca_trig,
        GateA_In_n      => gatea_n,
        GateB_In_n      => gateb_n,
        Hold_Mode       => fifo_daca_hold,
        Pretrig         => gnd,
        Rst             => fifo_daca_rst,
        Trig_Clear      => fifo_daca_clear,

        Post_Length_H   => fifo_daca_post_length_h,
        Post_Length_L   => fifo_daca_post_length_l,
        Trig_Length_H   => fifo_daca_triglen_h,
        Trig_Length_L   => fifo_daca_triglen_l,

        Pre_Count_H     => OPEN,
        Pre_Count_L     => OPEN,

        Fifo_En         => fifo_daca_en,
        Trig_Reached    => OPEN,
        Trig_Stat       => fifo_daca_trig_stat
        );

    -------------------------------------------------------------
    -- *************** A/D Converter Interface *************** --
    -------------------------------------------------------------

    -- See Block Diagram, page 8
    fifo_adca_en_n  <= NOT (fifo_adca_en);
    fifo_adcb_en_n  <= NOT (fifo_adcb_en);

    data0       <= (ADC_DA & "0" & fifo_adca_trig_reached);
    data1       <= (ADC_DB & "0" & fifo_adcb_trig_reached);

    adc_ab_data <= adca_packed_data
                    when (mem_ctrl_reg(12) = '0')
                    else (adcb_packed_data(15 downto 0) &
                                adca_packed_data(15 downto 0));

-- Filter Latch: necessary to stop/start DDC Filter processing

	 STOP_LATCH : FILTER_LATCH PORT MAP (
		  Clk 					 => start_clk,
		  Stop_in 				 => k_addr(12),
		  Stop_out 				 => stop
		  );

    ADCDAT : ADC_DATA_PATH_USER
    PORT MAP (
		  Start_Clk				 => start_clk,
        Adc_Clk             => adc_clk,
        ByteSwap            => byteswap,
        Lcl_Clk             => lclk,
        Rd_En_A             => adca_sel,
        Rd_En_B             => adcb_sel,
        Rst_A               => fifo_adca_rst,
        Rst_B               => fifo_adcb_rst,
        Sm_GateA_n          => fifo_adca_en_n,
        Sm_GateB_n          => fifo_adcb_en_n,

        Ad                  => data0,
        Bd                  => data1,
        Dat_ModeA           => fifo_adca_packmode,
        Dat_ModeB           => fifo_adcb_packmode,
        Decdiv_A            => fifo_adca_decdiv,
        Decdiv_B            => fifo_adcb_decdiv,
        Prog_Empty_Thresh_A => fifo_adca_count_ae(9 downto 0),
        Prog_Empty_Thresh_B => fifo_adcb_count_ae(9 downto 0),
        Prog_Full_Thresh_A  => fifo_adca_count_af(10 downto 0),
        Prog_Full_Thresh_B  => fifo_adcb_count_af(10 downto 0),

        AdcA_Packed_Data    => adca_packed_data,
        AdcB_Packed_Data    => adcb_packed_data,
        DoutA               => fifo_adca_data,
        DoutB               => fifo_adcb_data,

        Ef_A                => fifo_adca_e,
        Ef_B                => fifo_adcb_e,
        Fae_A               => fifo_adca_ae,
        Fae_B               => fifo_adcb_ae,
        Faf_A               => fifo_adca_af,
        Faf_B               => fifo_adcb_af,
        Ff_A                => fifo_adca_f,
        Ff_B                => fifo_adcb_f,
        ReqA                => fifo_adca_req,
        ReqB                => fifo_adcb_req,
        Wr_En_A             => fifo_adca_wren,
        Wr_En_B             => open,
		  
	 -- For DDC USER BLOCK	 

--		  Clk						 => filter_clk,
		  Clk						 => adc_clk,      -- modified filter to run at 125 MHz (adc_clk) 
		  Clk_12					 => start_clk,
		  G_addr					 => g_addr(3 downto 0),
		  G_data					 => g_data,
		  G_sel					 => g_addr(5 downto 4),
		  G_wr 					 => g_wr,
		  K_addr					 => k_addr(3 downto 0),
		  K_data					 => k_data,
		  K_sel					 => k_addr(6 downto 4),
		  K_wr					 => k_wr,
		  Stop					 => stop,
		  G_readcoef			 => g_readcoef,
		  K_readcoef			 => k_readcoef,
		  Rx_gate	    	    => pulse_out(0)

        );

    -- See Block Diagram, page 9
    fifo_adcc_en_n  <= NOT (fifo_adcc_en);
    fifo_adcd_en_n  <= NOT (fifo_adcd_en);

    data2       <= (ADC_DC & "0" & fifo_adcc_trig_reached);
    data3       <= (ADC_DD & "0" & fifo_adcd_trig_reached);

    adc_cd_data <= adcc_packed_data
                    when mem_ctrl_reg(14) = '0'
                        else (adcd_packed_data(15 downto 0) &
                                adcc_packed_data(15 downto 0));

    ADCDAT2 : ADC_DATA_PATH
    PORT MAP (
        Adc_Clk             => adc_clk,
        ByteSwap            => byteswap,
        Lcl_Clk             => lclk,
        Rd_En_A             => adcc_sel,
        Rd_En_B             => adcd_sel,
        Rst_A               => fifo_adcc_rst,
        Rst_B               => fifo_adcd_rst,
        Sm_GateA_n          => fifo_adcc_en_n,
        Sm_GateB_n          => fifo_adcd_en_n,

        Ad                  => data2,
        Bd                  => data3,
        Dat_ModeA           => fifo_adcc_packmode,
        Dat_ModeB           => fifo_adcd_packmode,
        Decdiv_A            => fifo_adcc_decdiv,
        Decdiv_B            => fifo_adcd_decdiv,
        Prog_Empty_Thresh_A => fifo_adcc_count_ae(9 downto 0),
        Prog_Empty_Thresh_B => fifo_adcd_count_ae(9 downto 0),
        Prog_Full_Thresh_A  => fifo_adcc_count_af(10 downto 0),
        Prog_Full_Thresh_B  => fifo_adcd_count_af(10 downto 0),

        AdcA_Packed_Data    => adcc_packed_data,
        AdcB_Packed_Data    => adcd_packed_data,
        DoutA               => fifo_adcc_data,
        DoutB               => fifo_adcd_data,

        Ef_A                => fifo_adcc_e,
        Ef_B                => fifo_adcd_e,
        Fae_A               => fifo_adcc_ae,
        Fae_B               => fifo_adcd_ae,
        Faf_A               => fifo_adcc_af,
        Faf_B               => fifo_adcd_af,
        Ff_A                => fifo_adcc_f,
        Ff_B                => fifo_adcd_f,
        ReqA                => fifo_adcc_req,
        ReqB                => fifo_adcd_req,
        Wr_En_A             => fifo_adcc_wren,
        Wr_En_B             => open

        );
------------------------------------------------------------------		  
--	************* Multiple Timers Instantiation **************** --
------------------------------------------------------------------

	GEN_TIMER : MULTITIMER 
	GENERIC MAP(NTIMERS => 8) PORT MAP (
		Busclk => lclk,
		Rst => rst,
		Addrwr => mt_addr_wr,
		Addrin => mt_addr_reg,
		Datawr => mt_data_wr,
		Timerclk => timer_clk,
		Onepps => '0',
		Datain => mt_data_reg,
		Dataout => open,       -- to read timer registers, this must be connected!
		Pulseout => pulse_out,
		Addrout => open);

    -------------------------------------------------------------
    -- *************** D/A Converter Interface *************** --
    -------------------------------------------------------------

    -- See Block Diagram, page 10
    dacmode_n       <= NOT (dacmode);
    dcm_clk_sel_n   <= NOT (dcm_clk_sel);
    fifo_daca_en_n  <= NOT (fifo_daca_en);

    DACDAT : DAC_DATA_PATH
    PORT MAP (
        ByteSwap            => byteswap,
        Dac_Clk             => dac_clk,
        Lcl_Clk             => lclk,
        Rst_A               => fifo_daca_rst,
        Sm_GateA_n          => fifo_daca_en_n,
        Wr_En_A             => daca_sel,

        Dat_Mode            => fifo_daca_packmode,
        Din_A               => fifo_daca_dq,
        Fifo_Dacm_Dout      => fifo_dacm_dout,
        Mem_Ctrl_Reg        => mem_ctrl_reg,
        Prog_Empty_Thresh_A => fifo_daca_count_ae(13 downto 0),
        Prog_Full_Thresh_A  => fifo_daca_count_af(12 downto 0),

        Ad                  => DAC_DA,
        Bd                  => DAC_DB,

        Ef_A                => fifo_daca_e,
        Fae_A               => fifo_daca_ae,
        Faf_A               => fifo_daca_af,
        Ff_A                => fifo_daca_f,
        Rd_En_A             => fifo_dacm_rden,
        ReqA                => fifo_daca_req
        );

    -- See Block Diagram, page 1
    -- DAC Clock Buffers & Selection
    IBUFG_DACCLK : IBUFG
    PORT MAP (
        I   => DAC_CLKI,

        O   => dac_clk_buf
        );

    IBUFG_PLLCLK : IBUFG
    PORT MAP (
        I   => DAC_PLLLOCK,

        O   => dac_plllock_buf
        );

    PLL_CLK_DCM_INST : CLK_DCM
    PORT MAP (
        ClkIn_in    => dac_plllock_buf,
        ClkFb_in    => dac_clk,
        Rst_in      => dcm_rst,

        Clk0_out    => dac_plllock_buf2,
        Locked_out  => dcm_pll_locked
        );

    DAC_CLK_DCM_INST : CLK_DCM
    PORT MAP (
        ClkIn_in    => dac_clk_buf,
        ClkFb_in    => dac_clk,
        Rst_in      => dcm_rst,

        Clk0_out    => dac_clk_buf2,
        Locked_out  => dcm_dac_locked
        );
-- User Added
	 DDC_DCM :		DDC_ADV_DCM 
	
	 PORT MAP (
			Rst		  => dcm_rst,
			Adc_clk	  => adc_clk,
-- 		Filter_clk => filter_clk,
			Timer_clk  => timer_clk, 
			Start_clk  => start_clk,
			Locked	  => open       -- for now locked signal is not monitored!
			);
			
    BUFGMUX_DCM : BUFGCTRL
    PORT MAP (
        Ce0     => vcc,
        Ce1     => vcc,
        I0      => dac_plllock_buf2,
        I1      => dac_clk_buf2,
        Ignore0 => vcc,
        Ignore1 => vcc,
        S0      => dacmode_n,
        S1      => dacmode,

        O       => dac_clk_dcm
        );

    BUFGMUX_NODCM : BUFGCTRL
    PORT MAP (
        Ce0     => vcc,
        Ce1     => vcc,
        I0      => dac_plllock_buf,
        I1      => dac_clk_buf,
        Ignore0 => vcc,
        Ignore1 => vcc,
        S0      => dacmode_n,
        S1      => dacmode,

        O       => dac_clk_nodcm
        );

    BUFGMUX_DAC : BUFGCTRL
    PORT MAP (
        Ce0     => vcc,
        Ce1     => vcc,
        I0      => dac_clk_nodcm,
        I1      => dac_clk_dcm,
        Ignore0 => vcc,
        Ignore1 => vcc,
        S0      => dcm_clk_sel_n,
        S1      => dcm_clk_sel,

        O       => dac_clk
        );

    -- The code below, included as a convenience for GateFlow
    -- users, can be used to instantiate a Digital Clock Manager
    -- for the Ref Clock, which is not included in
    -- the default design.  If your application requires this
    -- DCM, change the name of the output of the REF_IBUFG,
    -- above, from ref_clk to ref_clk_ibuf.  It is not shown
    -- in the block diagram.

    --  REF_DCM : DCM
    --  PORT MAP (
    --      Clkfb       => ref_clk,
    --      Clkin       => ref_clk_ibuf,
    --      Dssen       => gnd,
    --      Psclk       => gnd,
    --      Psen        => gnd,
    --      Psincdec    => gnd,
    --      Rst         => rst,

    --      Status      => OPEN,

    --      Clk0        => ref_clk_buf,
    --      Clk180      => OPEN,
    --      Clk270      => ref_clk270_buf,
    --      Clk2x       => OPEN,
    --      Clk2x180    => OPEN,
    --      Clk90       => OPEN,
    --      Clkdv       => OPEN,
    --      Clkfx       => OPEN,
    --      Clkfx180    => OPEN,
    --      Locked      => OPEN,
    --      Psdone      => OPEN
    --      );

    --  REF_BUFG_270 : BUFG
    --  PORT MAP (
    --      I           => ref_clk270_buf,

    --      O           => ref_clk270
    --      );

    -- Ref I/O Data
    -- ref_temp1        <= lad_in(3)
    --                      when (rising_edge (ref_clk));
    -- ref_temp2        <= lad_in(15
    --                      when (rising_edge (ref_clk));
	 
END STRUCTURE;