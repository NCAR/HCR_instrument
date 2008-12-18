-----------------------------------------------------------------
-- * VHDL for Control Registers  Module in Pentek Model 7142 * --
-- *********** Signal FPGA, in Xilinx Virtex4 FPGA *********** --
-----------------------------------------------------------------
-- Title        : Signal FPGA, Control Registers
-- Project      : Model 7142
-----------------------------------------------------------------
-- Filename     : CNTRL_REG.VHD
-- Author       : AB - Adapted from module of same name in
--                  Model 7140 User FPGA
-- Created      : 01/21/06
-- Last Modified: 11/12/07
-- Modified by  : Marc A. Lee, formatted for GateFlow
--                  (Model 4953-142, Options 055, 110)
--                  Pentek, Inc.
--                  One Park Way,
--                  Upper Saddle River, NJ 07458
--                  (201) 818-5900
--                  www.pentek.com
-----------------------------------------------------------------
--  Change log  :
--      10/07/05: Preliminary formatting for GateFlow (4953-140)
--      10/22/05: 7140 Rev. D update:  Add inputs
--                  MEM[0:1]_TRIG_REG_[H:L](15:0);  Add signals
--                  fifo_flags(10:0) of type REG16;
--                  Add Registers at addresses 41 - 51 and
--                  291 - 294
--      01/12/06: Changed contents of FPGA Revision Registers
--                  for Rev A 7140 GateFlow kit release.
--      03/13/06: Changed contents of FPGA Revision Registers
--                  for Rev B 7140 GateFlow kit release.
--      04/27/06: For compatibility with ModelSim Compiler,
--                  content of revision registers (7, 8 & 9)
--                  are now expressed in binary.
--      05/19/06: Corrected register # from 65 to 143 for DAC
--                  Write Enable Register in the Reset portion
--                  of the PROCESS.  In GENERATE process
--                  GEN_INTS, changed LOOP counter variable from
--                  "0 to 14" to"0 to 15", and removed 2nd LOOP.
--      08/31/06: Re-released with minor changes in comments
--                  for Model 7142 GateFlow kit (4953-142)
--      02/09/07: Added change log & comment regarding adaptation
--                  from 7140 code.
--      02/13/07: Corrected reg addresses for int_vctr1(9,3:0).
--      03/15/07: Port kit to VLX100 FPGA - change references
--                  to VSX55 and Option 055 above.
--      03/21/07: Commented out unused SIGNALS dac_sden_n_out,
--                  dac_sdio_en, dac_sdio_out, dac_sdo_in and
--                  addr_region(1:0), unused input port
--                  DCM_CLK_LOSS, and unused output port
--                  FIFOS_RDY.  In Readout process for index =
--                  44 (ADC D FIFO Status - line 844), change
--                  FIFO_ADCB_TRIG_STAT to FIFO_ADCD_TRIG_STAT
--                  (typo correction).
--      03/29/07: Update contents of FPGA Revision Registers for
--                  Rev. A 7142 GateFlow release. 
--      11/12/07: Update contents of FPGA Revision Registers for
--                  Rev. B 7142 GateFlow release.  Do not clear
--                  reg(143)(12) in write PROCESS at line 634.
--                  Add "Signal FPGA" to Project Name field in
--                  header (line 6).  Remove same from Title
--                  field (line 5).  Update note that explains
--                  how to convert addrx to a PCI address.
-----------------------------------------------------------------

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

ENTITY CNTRLREG is
PORT (
    IIC_DAT             :inout std_logic;

    CLK                 : in  std_logic;
    CLKA_LOSS           : in  std_logic;
    CLKB_LOSS           : in  std_logic;
    DAC_PLLLOCK         : in  std_logic;
    DAC_SCLK            : in  std_logic;
    DAC_SDO             : in  std_logic;
--  DCM_CLK_LOSS        : in  std_logic;
    DCM_DAC_LOCKED      : in  std_logic;
    DCM_PLL_LOCKED      : in  std_logic;

    FIFO_ADCA_AE        : in  std_logic;
    FIFO_ADCA_AF        : in  std_logic;
    FIFO_ADCA_E         : in  std_logic;
    FIFO_ADCA_EN        : in  std_logic;
    FIFO_ADCA_F         : in  std_logic;
    FIFO_ADCA_TRIG_STAT : in  std_logic;

    FIFO_ADCB_AE        : in  std_logic;
    FIFO_ADCB_AF        : in  std_logic;
    FIFO_ADCB_E         : in  std_logic;
    FIFO_ADCB_EN        : in  std_logic;
    FIFO_ADCB_F         : in  std_logic;
    FIFO_ADCB_TRIG_STAT : in  std_logic;

    FIFO_ADCC_AE        : in  std_logic;
    FIFO_ADCC_AF        : in  std_logic;
    FIFO_ADCC_E         : in  std_logic;
    FIFO_ADCC_EN        : in  std_logic;
    FIFO_ADCC_F         : in  std_logic;
    FIFO_ADCC_TRIG_STAT : in  std_logic;

    FIFO_ADCD_AE        : in  std_logic;
    FIFO_ADCD_AF        : in  std_logic;
    FIFO_ADCD_E         : in  std_logic;
    FIFO_ADCD_EN        : in  std_logic;
    FIFO_ADCD_F         : in  std_logic;
    FIFO_ADCD_TRIG_STAT : in  std_logic;

    FIFO_DACA_AE        : in  std_logic;
    FIFO_DACA_AF        : in  std_logic;
    FIFO_DACA_E         : in  std_logic;
    FIFO_DACA_EN        : in  std_logic;
    FIFO_DACA_F         : in  std_logic;
    FIFO_DACA_TRIG_STAT : in  std_logic;

    FIFO_MEMR_AE        : in  std_logic;
    FIFO_MEMR_AF        : in  std_logic;
    FIFO_MEMR_E         : in  std_logic;
    FIFO_MEMR_EN        : in  std_logic;
    FIFO_MEMR_F         : in  std_logic;

    FIFO_MEMW_AE        : in  std_logic;
    FIFO_MEMW_AF        : in  std_logic;
    FIFO_MEMW_E         : in  std_logic;
    FIFO_MEMW_EN        : in  std_logic;
    FIFO_MEMW_F         : in  std_logic;

    FIFO_TEST_AE        : in  std_logic;
    FIFO_TEST_AF        : in  std_logic;
    FIFO_TEST_E         : in  std_logic;
    FIFO_TEST_F         : in  std_logic;

    GATEA_N             : in  std_logic;
    GATEB_N             : in  std_logic;
    OVLD1_INT           : in  std_logic;
    OVLD2_INT           : in  std_logic;
    OVLD3_INT           : in  std_logic;
    OVLD4_INT           : in  std_logic;
    REG_SEL             : in  std_logic;
    RST                 : in  std_logic;
    SYNCA_N             : in  std_logic;
    SYNCB_N             : in  std_logic;
    TEMP_INT            : in  std_logic;
    WEPLS               : in  std_logic;

    ADDR                : in  std_logic_vector (8 downto 0);
    DAT_IN              : in  std_logic_vector (15 downto 0);
    IO_DATA_IN          : in  std_logic_vector (15 downto 0);

    FIFO_ADCA_PRE_COUNT_H
                        : in  std_logic_vector (15 downto 0);
    FIFO_ADCA_PRE_COUNT_L
                        : in  std_logic_vector (15 downto 0);
    FIFO_ADCB_PRE_COUNT_H
                        : in  std_logic_vector (15 downto 0);
    FIFO_ADCB_PRE_COUNT_L
                        : in  std_logic_vector (15 downto 0);
    FIFO_ADCC_PRE_COUNT_H
                        : in  std_logic_vector (15 downto 0);
    FIFO_ADCC_PRE_COUNT_L
                        : in  std_logic_vector (15 downto 0);
    FIFO_ADCD_PRE_COUNT_H
                        : in  std_logic_vector (15 downto 0);
    FIFO_ADCD_PRE_COUNT_L
                        : in  std_logic_vector (15 downto 0);

    MEM0_END_REG_H      : in  std_logic_vector (15 downto 0);
    MEM0_END_REG_L      : in  std_logic_vector (15 downto 0);
    MEM0_TRIG_REG_H     : in  std_logic_vector (15 downto 0);
    MEM0_TRIG_REG_L     : in  std_logic_vector (15 downto 0);
    MEM1_END_REG_H      : in  std_logic_vector (15 downto 0);
    MEM1_END_REG_L      : in  std_logic_vector (15 downto 0);
    MEM1_TRIG_REG_H     : in  std_logic_vector (15 downto 0);
    MEM1_TRIG_REG_L     : in  std_logic_vector (15 downto 0);
    MEM2_END_REG_H      : in  std_logic_vector (15 downto 0);
    MEM2_END_REG_L      : in  std_logic_vector (15 downto 0);

    DAT_OUT             : out std_logic_vector (15 downto 0);
    EXTD_ADDR           : out std_logic_vector (15 downto 0);

    FIFO_ADCA_COUNT_AE  : out std_logic_vector (15 downto 0);
    FIFO_ADCA_COUNT_AF  : out std_logic_vector (15 downto 0);
    FIFO_ADCA_DECDIV    : out std_logic_vector (15 downto 0);
    FIFO_ADCA_PACKMODE  : out std_logic_vector (2 downto 0);
    FIFO_ADCA_POST_LENGTH_H
                        : out std_logic_vector (15 downto 0);
    FIFO_ADCA_POST_LENGTH_L
                        : out std_logic_vector (15 downto 0);
    FIFO_ADCA_TRIGLEN_H : out std_logic_vector (15 downto 0);
    FIFO_ADCA_TRIGLEN_L : out std_logic_vector (15 downto 0);

    FIFO_ADCB_COUNT_AE  : out std_logic_vector (15 downto 0);
    FIFO_ADCB_COUNT_AF  : out std_logic_vector (15 downto 0);
    FIFO_ADCB_DECDIV    : out std_logic_vector (15 downto 0);
    FIFO_ADCB_PACKMODE  : out std_logic_vector (2 downto 0);
    FIFO_ADCB_POST_LENGTH_H
                        : out std_logic_vector (15 downto 0);
    FIFO_ADCB_POST_LENGTH_L
                        : out std_logic_vector (15 downto 0);
    FIFO_ADCB_TRIGLEN_H : out std_logic_vector (15 downto 0);
    FIFO_ADCB_TRIGLEN_L : out std_logic_vector (15 downto 0);

    FIFO_ADCC_COUNT_AE  : out std_logic_vector (15 downto 0);
    FIFO_ADCC_COUNT_AF  : out std_logic_vector (15 downto 0);
    FIFO_ADCC_DECDIV    : out std_logic_vector (15 downto 0);
    FIFO_ADCC_PACKMODE  : out std_logic_vector (2 downto 0);
    FIFO_ADCC_POST_LENGTH_H
                        : out std_logic_vector (15 downto 0);
    FIFO_ADCC_POST_LENGTH_L
                        : out std_logic_vector (15 downto 0);
    FIFO_ADCC_TRIGLEN_H : out std_logic_vector (15 downto 0);
    FIFO_ADCC_TRIGLEN_L : out std_logic_vector (15 downto 0);

    FIFO_ADCD_COUNT_AE  : out std_logic_vector (15 downto 0);
    FIFO_ADCD_COUNT_AF  : out std_logic_vector (15 downto 0);
    FIFO_ADCD_DECDIV    : out std_logic_vector (15 downto 0);
    FIFO_ADCD_PACKMODE  : out std_logic_vector (2 downto 0);
    FIFO_ADCD_POST_LENGTH_H
                        : out std_logic_vector (15 downto 0);
    FIFO_ADCD_POST_LENGTH_L
                        : out std_logic_vector (15 downto 0);
    FIFO_ADCD_TRIGLEN_H : out std_logic_vector (15 downto 0);
    FIFO_ADCD_TRIGLEN_L : out std_logic_vector (15 downto 0);

    FIFO_DACA_COUNT_AE  : out std_logic_vector (15 downto 0);
    FIFO_DACA_COUNT_AF  : out std_logic_vector (15 downto 0);
    FIFO_DACA_PACKMODE  : out std_logic_vector (2 downto 0);
    FIFO_DACA_POST_LENGTH_H
                        : out std_logic_vector (15 downto 0);
    FIFO_DACA_POST_LENGTH_L
                        : out std_logic_vector (15 downto 0);
    FIFO_DACA_TRIGLEN_H : out std_logic_vector (15 downto 0);
    FIFO_DACA_TRIGLEN_L : out std_logic_vector (15 downto 0);

    FIFO_MEMR_COUNT_AE  : out std_logic_vector (15 downto 0);
    FIFO_MEMR_COUNT_AF  : out std_logic_vector (15 downto 0);
    FIFO_MEMW_COUNT_AE  : out std_logic_vector (15 downto 0);
    FIFO_MEMW_COUNT_AF  : out std_logic_vector (15 downto 0);
    FIFO_TEST_COUNT_AE  : out std_logic_vector (15 downto 0);
    FIFO_TEST_COUNT_AF  : out std_logic_vector (15 downto 0);

    INT                 : out std_logic_vector (3 downto 0);
    IO_DATA_OUT         : out std_logic_vector (15 downto 0);
    MEM_CTRL_REG        : out std_logic_vector (15 downto 0);

    MEM0_DEPTH_REG_H    : out std_logic_vector (15 downto 0);
    MEM0_DEPTH_REG_L    : out std_logic_vector (15 downto 0);
    MEM1_DEPTH_REG_H    : out std_logic_vector (15 downto 0);
    MEM1_DEPTH_REG_L    : out std_logic_vector (15 downto 0);
    MEM2_DEPTH_REG_H    : out std_logic_vector (15 downto 0);
    MEM2_DEPTH_REG_L    : out std_logic_vector (15 downto 0);

    MEM0_START_REG_H    : out std_logic_vector (15 downto 0);
    MEM0_START_REG_L    : out std_logic_vector (15 downto 0);
    MEM1_START_REG_H    : out std_logic_vector (15 downto 0);
    MEM1_START_REG_L    : out std_logic_vector (15 downto 0);
    MEM2_START_REG_H    : out std_logic_vector (15 downto 0);
    MEM2_START_REG_L    : out std_logic_vector (15 downto 0);

    ADC_CLK_SEL         : out std_logic;
    BUS_MASTER_A        : out std_logic;
    BUS_TERM_A          : out std_logic;
    BUS_MASTER_B        : out std_logic;
    BUS_TERM_B          : out std_logic;
    BYTESWAP            : out std_logic;
    CLK_SRC_A           : out std_logic;
    CLK_SRC_B           : out std_logic;

    DAC_CLK_SEL         : out std_logic;
    DAC_QFLAG           : out std_logic;
    DAC_RESET_N         : out std_logic;
    DAC_SDEN_N          : out std_logic;
    DAC_SDIO            : out std_logic;
    DAC_SYNC_MASK       : out std_logic;
    DACMODE             : out std_logic;

    DCM_CLK_SEL         : out std_logic;
    DCM_RST             : out std_logic;
    EXT_CLK_A           : out std_logic;
    EXT_CLK_B           : out std_logic;
    EXT_GATE_A          : out std_logic;
    EXT_GATE_B          : out std_logic;
    EXT_SYNC_A          : out std_logic;
    EXT_SYNC_B          : out std_logic;

    FIFO_ADCA_ARM       : out std_logic;
    FIFO_ADCA_CLEAR     : out std_logic;
    FIFO_ADCA_GATE_DISBL: out std_logic;
    FIFO_ADCA_GATE_ENABLE
                        : out std_logic;
    FIFO_ADCA_GATE_SELB : out std_logic;
    FIFO_ADCA_HOLD      : out std_logic;
    FIFO_ADCA_PRETRIG   : out std_logic;
    FIFO_ADCA_RST       : out std_logic;
    FIFO_ADCA_TRIG      : out std_logic;

    FIFO_ADCB_ARM       : out std_logic;
    FIFO_ADCB_CLEAR     : out std_logic;
    FIFO_ADCB_GATE_DISBL: out std_logic;
    FIFO_ADCB_GATE_ENABLE
                        : out std_logic;
    FIFO_ADCB_GATE_SELB : out std_logic;
    FIFO_ADCB_HOLD      : out std_logic;
    FIFO_ADCB_PRETRIG   : out std_logic;
    FIFO_ADCB_RST       : out std_logic;
    FIFO_ADCB_TRIG      : out std_logic;

    FIFO_ADCC_ARM       : out std_logic;
    FIFO_ADCC_CLEAR     : out std_logic;
    FIFO_ADCC_GATE_DISBL: out std_logic;
    FIFO_ADCC_GATE_ENABLE
                        : out std_logic;
    FIFO_ADCC_GATE_SELB : out std_logic;
    FIFO_ADCC_HOLD      : out std_logic;
    FIFO_ADCC_PRETRIG   : out std_logic;
    FIFO_ADCC_RST       : out std_logic;
    FIFO_ADCC_TRIG      : out std_logic;

    FIFO_ADCD_ARM       : out std_logic;
    FIFO_ADCD_CLEAR     : out std_logic;
    FIFO_ADCD_GATE_DISBL: out std_logic;
    FIFO_ADCD_GATE_ENABLE
                        : out std_logic;
    FIFO_ADCD_GATE_SELB : out std_logic;
    FIFO_ADCD_HOLD      : out std_logic;
    FIFO_ADCD_PRETRIG   : out std_logic;
    FIFO_ADCD_RST       : out std_logic;
    FIFO_ADCD_TRIG      : out std_logic;

    FIFO_DACA_CLEAR     : out std_logic;
    FIFO_DACA_GATE_DISBL: out std_logic;
    FIFO_DACA_GATE_ENABLE
                        : out std_logic;
    FIFO_DACA_GATE_SELB : out std_logic;
    FIFO_DACA_HOLD      : out std_logic;
    FIFO_DACA_RST       : out std_logic;
    FIFO_DACA_TRIG      : out std_logic;

    FIFO_MEMR_RST       : out std_logic;
    FIFO_MEMW_RST       : out std_logic;
    FIFO_TEST_RST       : out std_logic;
--  FIFOS_RDY           : out std_logic;

    GATE_POL_A          : out std_logic;
    GATE_POL_B          : out std_logic;
    GATE_SRC_A          : out std_logic;
    GATE_SRC_B          : out std_logic;
    GATEGO_A            : out std_logic;
    GATEGO_B            : out std_logic;

    IIC_CLK             : out std_logic;
    OSC_DISBL_A         : out std_logic;
    OSC_DISBL_B         : out std_logic;
    PLLVDD              : out std_logic;

    SYNC_POL_A          : out std_logic;
    SYNC_POL_B          : out std_logic;
    SYNC_SRC_A          : out std_logic;
    SYNC_SRC_B          : out std_logic;
    SYNCGO_A            : out std_logic;
    SYNCGO_B            : out std_logic;

    TEST_MODE           : out std_logic;

--  USER Required Ports for Digital Down Converter (DDC)

	 K_ADDR			      : out std_logic_vector (15 downto 0);
	 K_DATA			      : out std_logic_vector (17 downto 0);
	 K_WR				      : out std_logic;
	 G_ADDR			      : out std_logic_vector (15 downto 0);
	 G_DATA			      : out std_logic_vector (17 downto 0);
	 G_WR				      : out std_logic;
	 K_READCOEF				: in std_logic_vector (17 downto 0);
	 G_READCOEF				: in std_logic_vector (17 downto 0)

    );
END CNTRLREG;

-----------------------------------------------------------------

ARCHITECTURE RTL of CNTRLREG is

-----------------------------------------------------------------
-- ********************* Type Definition ********************* --
-----------------------------------------------------------------

TYPE reg16 is ARRAY (natural range <>) of
                                std_logic_vector (15 downto 0);

-----------------------------------------------------------------
-- ******************* Signal Declarations ******************* --
-----------------------------------------------------------------

SIGNAL fifo_flags       : REG16 (10 downto 0);
SIGNAL reg              : REG16 (511 downto 0);
SIGNAL addrx            : integer   range 0 to 511;
SIGNAL i                : integer   range 0 to 16;

-- SIGNAL dac_sden_n_out: std_logic;
-- SIGNAL dac_sdio_en   : std_logic;
-- SIGNAL dac_sdio_out  : std_logic;
-- SIGNAL dac_sdo_in    : std_logic;
SIGNAL shift_en         : std_logic;
SIGNAL sreg_wepls       : std_logic;
SIGNAL sreg_wepls_q1    : std_logic;
SIGNAL sreg_write       : std_logic;

-- SIGNAL addr_region   : std_logic_vector (1 downto 0);
SIGNAL int_vctr0        : std_logic_vector (15 downto 0);
SIGNAL int_vctr1        : std_logic_vector (15 downto 0);

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    -------------------------------------------------------------
    -- ******************* Type Conversion ****************** --
    -------------------------------------------------------------

    addrx   <= conv_integer (ADDR);

    -- Note that the ADDR input of the Control Register module
    -- receives bits (11:3) of the PCI address bus, an that D15
    -- of the PCI address bus enables access to the FPGA's
    -- Control Registers.  Thus, the PCI address of any given
    -- Control Register can be determined by converting the
    -- decimal addrx to binary, shifting the result 3 bits to the
    -- left (i. e., multiplying by 8), and adding 32768 (0x8000).

    -------------------------------------------------------------
    -- ************* Writes to Control Registers ************* --
    -------------------------------------------------------------

    -- Global Registers (Regs. 0 to 8)

    GEN_GLBL_REGS : for X in 0 to 8 GENERATE
        PROCESS (RST, CLK)
        BEGIN
            -- Reset
            if (RST = '1') then
                reg(X)  <= (others => '0');
            -- Write
            elsif (rising_edge (CLK)) then
                if ((WEPLS = '1') AND (REG_SEL = '1')) then
                    if addrx = X then
                        reg(X)  <= DAT_IN;
                    end if;
                end if;
            end if;
        END PROCESS;
    END GENERATE GEN_GLBL_REGS;

    -- Sync and Gate Registers (Regs 16 to 23)

    GEN_GATE_REGS : for X in 16 to 23 GENERATE
        PROCESS(RST, CLK)
        BEGIN
            -- Reset
            if (RST = '1') then
                if ((X = 17) OR (X = 18) OR (X = 20) OR
                                                (X = 21)) then
                    reg(X)(0)           <= '1';
                    reg(X)(15 downto 1) <= (others => '0');
                else
                    reg(X)              <= (others => '0');
                end if;
            -- Write
            elsif (rising_edge (CLK)) then
                if ((WEPLS = '1') AND (REG_SEL = '1')) then
                    if (addrx = X) then
                        reg(X)  <= DAT_IN;
                    end if;
                end if;
            end if;
        END PROCESS;
    END GENERATE GEN_GATE_REGS;

    -- Interrupt Registers (Regs. 32 - 40)

    PROCESS (RST, CLK)
    BEGIN
        -- Reset
        if (RST = '1') then
            reg(32) <= (others => '0');
        -- Write
        elsif (rising_edge (CLK)) then
            if ((WEPLS = '1') AND (REG_SEL = '1')) then
                if addrx = 32 then
                    reg(32) <= DAT_IN;
                end if;
            end if;
        end if;
    END PROCESS;

    -- Flag Register - cleared by writes!

    GEN_FLAG_REG0 : for X in 0 to 6 GENERATE
        PROCESS (CLK, int_vctr0)
        BEGIN
            if (int_vctr0(X) = '1') then
                reg(33)(X)  <= '1';
            elsif (rising_edge (CLK)) then
                if ((WEPLS = '1') AND (REG_SEL = '1')) then
                    if addrx = 33 then
                        if DAT_IN(X) = '1' then
                            reg(33)(X) <= '0';
                        end if;
                    end if;
                end if;
            end if;
        END PROCESS;
    END GENERATE GEN_FLAG_REG0;

    GEN_INTRPT_REGS : for X in 34 to 38 GENERATE
        PROCESS (RST, CLK)
        BEGIN
            -- Reset
            if (RST = '1') then
                reg(X)  <= (others => '0');
            -- Write
            elsif (rising_edge (CLK)) then
                if ((WEPLS = '1') AND (REG_SEL = '1')) then
                    if (addrx = X) then
                        reg(X)  <= DAT_IN;
                    end if;
                end if;
            end if;
        END PROCESS;
    END GENERATE GEN_INTRPT_REGS;

    -- Flag Register - cleared by writes!

    GEN_FLAG_REG1 : for X in 0 to 15 GENERATE
        PROCESS (CLK, int_vctr1)
        BEGIN
            if (int_vctr1(X) = '1') then
                reg(39)(X)  <= '1';
            elsif (rising_edge (CLK)) then
                if ((WEPLS = '1') AND (REG_SEL = '1')) then
                    if (addrx = 39) then
                        if DAT_IN(X) = '1' then
                            reg(39)(X)  <= '0';
                        end if;
                    end if;
                end if;
            end if;
        END PROCESS;
    END GENERATE GEN_FLAG_REG1;

    PROCESS (RST, CLK)
    BEGIN
        -- Reset
        if (RST = '1') then
            reg(40) <= (others => '0');
        -- Write
        elsif (rising_edge (CLK)) then
            if ((WEPLS = '1') AND (REG_SEL = '1')) then
                if (addrx = 40) then
                    reg(40) <= DAT_IN;
                end if;
            end if;
        end if;
    END PROCESS;

    -- FIFO Flag Regs (41 to 51) - cleared by writes!
    GENY_FIFO_FLAGS_REG: for Y in 0 to 10 GENERATE
        GENX_FIFO_FLAGS_REG: for X in 8 to 11 GENERATE
            PROCESS (CLK, RST, fifo_flags)
            BEGIN
                -- Reset
                if (RST = '1') then
                    reg(41+Y)(X)    <= '0';
                elsif (fifo_flags(Y)(X) = '1') then
                    reg(41+Y)(X)    <= '1';
                -- Write
                elsif (rising_edge (CLK)) then
                    if ((WEPLS = '1') AND (REG_SEL = '1')) then
                        if addrx = (41 + Y) then
                            if DAT_IN(X) = '1' then
                                reg(41+Y)(X)    <= '0';
                            end if;
                        end if;
                    end if;
                end if;
            END PROCESS;
        END GENERATE GENX_FIFO_FLAGS_REG;
    END GENERATE GENY_FIFO_FLAGS_REG;

    -- DAC Registers (Regs 128 - 137)

    GEN_DAC_REGS : for X in 128 to 137 GENERATE
        PROCESS (RST, CLK)
        BEGIN
            -- Reset
            if (RST = '1') then
                reg(X)  <= (others => '0');
            -- Write
            elsif (rising_edge (CLK)) then
                if ((WEPLS = '1') AND (REG_SEL = '1')) then
                    if (addrx = X) then
                        reg(X)  <= DAT_IN;
                    end if;
                end if;
            end if;
        END PROCESS;
    END GENERATE GEN_DAC_REGS;

    -- DAC Write Shift Register (Reg. 142) - kicks off shift

    PROCESS (RST, DAC_SCLK)
    BEGIN
        if (RST = '1') then
            DAC_SDEN_N  <= '1';
            i           <= 15;
            shift_en    <= '0';
        elsif (falling_edge (DAC_SCLK)) then
            DAC_SDEN_N  <= '1';
            DAC_SDIO    <= 'Z';
            i           <= 16;
            shift_en    <= shift_en OR sreg_write;
            if (shift_en = '1') then
                i           <= i - 1;
                DAC_SDEN_N  <= '0';
                reg(142)(i) <= DAC_SDO;
                if ((i < 9) AND (reg(143)(15) = '1')) then
                    DAC_SDIO    <= 'Z';
                else
                    DAC_SDIO    <= reg(143)(i - 1);
                end if;
                if (i = 0) then
                    DAC_SDEN_N  <= '1';
                    i           <= 0;
                    shift_en    <= '0';
                end if;
            end if;
        end if;
    END PROCESS;

    -- DAC Write Enable Register (Reg. 143)

    PROCESS (RST, CLK)
    BEGIN
        -- Reset
        if (RST = '1') then
            sreg_wepls      <= '0';
            sreg_wepls_q1   <= '0';
            sreg_write      <= '0';
            reg(143)         <= (others => '0');
         -- Write
         elsif (rising_edge (CLK)) then
            sreg_wepls      <= '0';
            sreg_wepls_q1   <= sreg_wepls;
            sreg_write      <= (sreg_write AND (NOT shift_en)) OR
                                    ((NOT sreg_wepls) AND
                                                sreg_wepls_q1);
            if ((WEPLS = '1') AND (REG_SEL = '1')) then
                if (addrx = 143) then
                    sreg_wepls  <='1';
                    reg(143)    <= DAT_IN;
                    reg(143)(13)<='0';
                    reg(143)(14)<='0';
                end if;
            end if;
        end if;
    END PROCESS;

    --  Memory Capture Registers (Regs. 256 to 268)

    GEN_MEMC_REGS : for X in 256 to 268 GENERATE
        PROCESS (RST, CLK)
        BEGIN
            -- Reset
            if (RST = '1') then
                reg(X)  <= (others =>'0');
            -- Write
            elsif (rising_edge (CLK)) then
                if ((WEPLS = '1') AND (REG_SEL = '1')) then
                    if (addrx = X) then
                        reg(X)  <= DAT_IN;
                    end if;
                end if;
            end if;
        END PROCESS;
    END GENERATE GEN_MEMC_REGS;

    --  Memory Trigger Registers (Regs. 288 to 295)

    GEN_MEMT_REGS : for X in 288 to 295 GENERATE
        PROCESS (RST, CLK)
        BEGIN
            -- Reset
            if (RST = '1') then
                reg(X)  <= (others =>'0');
            -- Write
            elsif (rising_edge (CLK)) then
                if ((WEPLS = '1') AND (REG_SEL = '1')) then
                    if (addrx = X) then
                        reg(X)  <= DAT_IN;
                    end if;
                end if;
            end if;
        END PROCESS;
    END GENERATE GEN_MEMT_REGS;

    -- ADC Registers (Regs. 384 to 438)

    GEN_ADC_REGS : for X in 384 to 438 GENERATE
        PROCESS (RST, CLK)
        BEGIN
            -- Reset
            if (RST = '1') then
                reg(X)  <= (others => '0');
            -- Write
            elsif (rising_edge (CLK)) then
                if ((WEPLS = '1') AND (REG_SEL = '1')) then
                    if (addrx = X) then
                        reg(X)  <= DAT_IN;
                    end if;
                end if;
            end if;
        END PROCESS;
    END GENERATE GEN_ADC_REGS;
	 
	   -- User Registers (Regs. 464 to 478)
		-- 464: Multitimer Address Register
		-- 465: Multitimer Data Register
		-- 466: Multitimer Write Register
		-- 467: Kaiser Coefficient Address Register
		-- 468: Kaiser Coefficient Data Register (LSW)
		-- 469: Kaiser Coefficient Data Register (MSW)
		--	470: Kaiser Coefficient Write
		-- 471: Kaiser Coefficient Read Register (LSW)
		-- 472: Kaiser Coefficient Read Register (MSW)
		-- 473: Gaussian Coefficient Address Register
		-- 474: Gaussian Coefficient Data Register (LSW)
		-- 475: Gaussian Coefficient Data Register (MSW)
		--	476: Gaussian Coefficient Write
		-- 477: Gaussian Coefficient Read Register (LSW)
		-- 478: Gaussian Coefficient Read Register (MSW)

-- Uncomment when instantiate timers		
 --   GEN_TIMER_REGS : for X in 464 to 466 GENERATE
 --       PROCESS (RST, CLK)
 --       BEGIN
            -- Reset
--            if (RST = '1') then
--                reg(X)  <= (others => '0');
            -- Write
--            elsif (rising_edge (CLK)) then
--                if ((WEPLS = '1') AND (REG_SEL = '1')) then
--                    if (addrx = X) then
--                        reg(X)  <= DAT_IN;
--                    end if;
--               end if;
--          end if;
--      END PROCESS;
--  END GENERATE GEN_TIMER_REGS;
	 
	 GEN_KAISER_REGS : for X in 467 to 470 GENERATE
        PROCESS (RST, CLK)
        BEGIN
            -- Reset
            if (RST = '1') then
                reg(X)  <= (others => '0');
            -- Write
            elsif (rising_edge (CLK)) then
                if ((WEPLS = '1') AND (REG_SEL = '1')) then
                    if (addrx = X) then
                        reg(X)  <= DAT_IN;
                    end if;
                end if;
            end if;
        END PROCESS;
    END GENERATE GEN_KAISER_REGS;

 GEN_GAUSSIAN_REGS : for X in 473 to 476 GENERATE
        PROCESS (RST, CLK)
        BEGIN
            -- Reset
            if (RST = '1') then
                reg(X)  <= (others => '0');
            -- Write
            elsif (rising_edge (CLK)) then
                if ((WEPLS = '1') AND (REG_SEL = '1')) then
                    if (addrx = X) then
                        reg(X)  <= DAT_IN;
                    end if;
                end if;
            end if;
        END PROCESS;
    END GENERATE GEN_GAUSSIAN_REGS;	 
	 

    -------------------------------------------------------------
    -- ************ Reads from  Control Registers ************ --
    -------------------------------------------------------------

    -- Multiplex addressed register onto output bus
    PROCESS (addrx, CLK, DAC_PLLLOCK, DCM_DAC_LOCKED,
                DCM_PLL_LOCKED, FIFO_ADCA_AE, FIFO_ADCA_AF,
                FIFO_ADCA_E, FIFO_ADCA_EN, FIFO_ADCA_F,
                FIFO_ADCA_TRIG_STAT, FIFO_ADCB_AE, FIFO_ADCB_AF,
                FIFO_ADCB_E, FIFO_ADCB_EN, FIFO_ADCB_F,
                FIFO_ADCB_TRIG_STAT, FIFO_ADCC_AE, FIFO_ADCC_AF,
                FIFO_ADCC_E, FIFO_ADCC_EN, FIFO_ADCC_F,
                FIFO_ADCC_TRIG_STAT, FIFO_ADCD_AE, FIFO_ADCD_AF,
                FIFO_ADCD_E, FIFO_ADCD_EN, FIFO_ADCD_F,
                FIFO_ADCD_TRIG_STAT, FIFO_DACA_AE, FIFO_DACA_AF,
                FIFO_DACA_E, FIFO_DACA_EN, FIFO_DACA_F,
                FIFO_DACA_TRIG_STAT, fifo_flags, FIFO_MEMR_AE,
                FIFO_MEMR_AF, FIFO_MEMR_E, FIFO_MEMR_EN,
                FIFO_MEMR_F, FIFO_MEMW_AE, FIFO_MEMW_AF,
                FIFO_MEMW_E, FIFO_MEMW_EN, FIFO_MEMW_F,
                FIFO_TEST_AE, FIFO_TEST_AF, FIFO_TEST_E,
                FIFO_TEST_F, GATEA_N, GATEB_N, IIC_DAT,
                int_vctr0, int_vctr1, IO_DATA_IN, reg, shift_en,
                sreg_wepls, sreg_wepls_q1, sreg_write, SYNCA_N,
                SYNCB_N)                --  DCM_CLK_LOSS removed
    BEGIN
        if (rising_edge (CLK)) then
            DAT_OUT     <= (others => '0');

            case addrx is

            -- ID Readout Register
            when 0          =>
                -- 7142, in BCD
                DAT_OUT <= "0111000101000010";

            -- FPGA I/O Data Input Register
            when 1          =>
                DAT_OUT <= IO_DATA_IN;

            -- FPGA I/O Data Output Register
            when 2          =>
                DAT_OUT <= reg(addrx);

            -- TWSI Port Register
            when 3          =>
                DAT_OUT(0)          <= IIC_DAT;
                DAT_OUT(15 downto 1)<= reg(addrx)(15 downto 1);

            -- DCM Control Register
            when 4          =>
                DAT_OUT(0)          <= reg(addrx)(0);
                DAT_OUT(1)          <= reg(addrx)(1);
                DAT_OUT(2)          <= '0';
                DAT_OUT(3)          <= reg(addrx)(3);
                DAT_OUT(4)          <= reg(addrx)(4);
                DAT_OUT(5)          <= DCM_DAC_LOCKED;
                DAT_OUT(6)          <= DCM_PLL_LOCKED;
                DAT_OUT(15 downto 7)<= reg(addrx)(15 downto 7);

            -- Misc. Control Register
            when 5          =>
                DAT_OUT <= reg(addrx);

            -- FLASH Memory Page Register
            when 6          =>
                DAT_OUT <= reg(addrx);

            -- FPGA Revision Register # 1
            --when 7          =>            -- 0x0711
            --    DAT_OUT <= "0000011100010001";
				when 7          =>            -- 0xAABB
                DAT_OUT <= "1010101010111011";

            -- FPGA Revision Register # 2
            --when 8          =>            -- 0x3002
            --    DAT_OUT <= "0011000000000010";
				when 8          =>            -- 0x5533
                DAT_OUT <= "0101010100110011";

            -- Reserved for Revision levels of cores that
            -- may be instantiated
            when 9          =>            -- 0x0000
                DAT_OUT <= "0000000000000000";

            -- Addresses 10 - 15 are Unused

            -- Clock/Sync/Gate Registers
            when 16 to 22   =>
                DAT_OUT <= reg(addrx);

            -- Addresses 23 - 31 are Unused
            -- System Interrupt Enable & Flag Registers
            when 32 to 33   =>
                DAT_OUT <= reg(addrx);

            -- System Interrupt Status Register
            when 34         =>
                DAT_OUT <= int_vctr0;

            -- Application Interrupt Enable & Flag Registers
            when 35 to 39   =>
                DAT_OUT <= reg(addrx);

            -- Application Interrupt Status Register
            when 40         =>
                DAT_OUT <= int_vctr1;

            -- ADC A FIFO Status Register
            when 41         =>
                DAT_OUT(11 downto 0)<= (reg(41)(11 downto 8) &
                                    "00" & FIFO_ADCA_TRIG_STAT &
                                    FIFO_ADCA_EN & FIFO_ADCA_F &
                                    FIFO_ADCA_AF & FIFO_ADCA_AE &
                                                    FIFO_ADCA_E);

            -- ADC B FIFO Status Register
            when 42         =>
                DAT_OUT(11 downto 0)<= (reg(42)(11 downto 8) &
                                    "00" & FIFO_ADCB_TRIG_STAT &
                                    FIFO_ADCB_EN & FIFO_ADCB_F &
                                    FIFO_ADCB_AF & FIFO_ADCB_AE &
                                                    FIFO_ADCB_E);

            -- ADC C FIFO Status Register
            when 43         =>
                DAT_OUT(11 downto 0)<= (reg(43)(11 downto 8) &
                                    "00" & FIFO_ADCC_TRIG_STAT &
                                    FIFO_ADCC_EN & FIFO_ADCC_F &
                                    FIFO_ADCC_AF & FIFO_ADCC_AE &
                                                    FIFO_ADCC_E);

            -- ADC D FIFO Status Register
            when 44         =>
                DAT_OUT(11 downto 0)<= (reg(44)(11 downto 8) &
                                    "00" & FIFO_ADCD_TRIG_STAT &
                                    FIFO_ADCD_EN & FIFO_ADCD_F &
                                    FIFO_ADCD_AF & FIFO_ADCD_AE &
                                                    FIFO_ADCD_E);

            -- Addresses 45 - 46 are Unused

            -- DAC A FIFO Status Register
            when 47         =>
                DAT_OUT(11 downto 0)<= (reg(47)(11 downto 8) &
                                    "00" & FIFO_DACA_TRIG_STAT &
                                    FIFO_DACA_EN & FIFO_DACA_F &
                                    FIFO_DACA_AF & FIFO_DACA_AE &
                                                    FIFO_DACA_E);

            -- Addresses 48 is Unused

            -- Delay Memory Read FIFO Status Register
            when 49         =>
                DAT_OUT(11 downto 0)<= (reg(49)(11 downto 8) &
                                    "000" & FIFO_MEMR_EN &
                                    FIFO_MEMR_F & FIFO_MEMR_AF &
                                    FIFO_MEMR_AE & FIFO_MEMR_E);

            -- Delay Memory Write FIFO Status Register
            when 50         =>
                DAT_OUT(11 downto 0)<= (reg(50)(11 downto 8) &
                                    "000" & FIFO_MEMW_EN &
                                    FIFO_MEMW_F & FIFO_MEMW_AF &
                                    FIFO_MEMW_AE & FIFO_MEMW_E);

            -- Test FIFO Status Register
            when 51         =>
                DAT_OUT(11 downto 0)<= (reg(51)(11 downto 8) &
                                    "0000" & FIFO_TEST_F &
                                    FIFO_TEST_AF & FIFO_TEST_AE &
                                                    FIFO_TEST_E);

            -- Addresses 52 - 127 are Unused

            -- DAC Sync Bus Select Register
            when 128        =>
                DAT_OUT <= reg(addrx);

            -- DAC Control/Status Register
            when 129        =>
                DAT_OUT(0)          <= DAC_PLLLOCK;
                DAT_OUT(15 downto 1)
                                    <= reg(addrx)(15 downto 1);

            -- Misc. DAC Registers
            when 130 to 137 =>
                DAT_OUT <= reg(addrx);

            -- Addresses 138 - 141 are Unused

            -- DAC Read Register
            when 142        =>
                DAT_OUT(14 downto 0)
                                    <= reg(addrx)(14 downto 0);
                DAT_OUT(15) <= shift_en OR sreg_write OR
                                    sreg_wepls OR sreg_wepls_q1;

            -- DAC Write Register
            when 143        =>
                DAT_OUT <= reg(addrx);

            -- Delay Memory Depth & Address Registers
            when 256 to 268 =>
                DAT_OUT <= reg(addrx);

            -- Delay Memory 0 End Address Register Low
            when 269        =>
                DAT_OUT <= MEM0_END_REG_L;

            -- Delay Memory 0 End Address Register High
            when 270        =>
                DAT_OUT <= MEM0_END_REG_H;

            -- Delay Memory 1 End Address Register Low
            when 271        =>
                DAT_OUT <= MEM1_END_REG_L;

            -- Delay Memory 1 End Address Register High
            when 272        =>
                DAT_OUT <= MEM1_END_REG_H;

            -- Delay Memory End Address Register Low
            when 273        =>
                DAT_OUT <= MEM2_END_REG_L;

            -- Delay Memory End Address Register High
            when 274        =>
                DAT_OUT <= MEM2_END_REG_H;

            -- Delay Memory Trigger Registers
            when 275        =>
                DAT_OUT <= MEM0_TRIG_REG_L;
            when 276        =>
                DAT_OUT <= MEM0_TRIG_REG_H;
            when 277        =>
                DAT_OUT <= MEM1_TRIG_REG_L;
            when 278        =>
                DAT_OUT <= MEM1_TRIG_REG_H;

            -- Addresses 279 - 287 are Unused

            -- Post-Trigger Count Registers
            when 288 to 295 =>
                DAT_OUT <= reg(addrx);

            -- ADC A Pre-Trigger Count Register Low
            when 296        =>
                DAT_OUT <= FIFO_ADCA_PRE_COUNT_L;

            -- ADC A Pre-Trigger Count Register High
            when 297        =>
                DAT_OUT <= FIFO_ADCA_PRE_COUNT_H;

            -- ADC B Pre-Trigger Count Register Low
            when 298        =>
                DAT_OUT <= FIFO_ADCB_PRE_COUNT_L;

            -- ADC B Pre-Trigger Count Register High
            when 299        =>
                DAT_OUT <= FIFO_ADCB_PRE_COUNT_H;

            -- ADC A Pre-Trigger Count Register Low
            when 300        =>
                DAT_OUT <= FIFO_ADCC_PRE_COUNT_L;

            -- ADC A Pre-Trigger Count Register High
            when 301        =>
                DAT_OUT <= FIFO_ADCC_PRE_COUNT_H;

            -- ADC B Pre-Trigger Count Register Low
            when 302        =>
                DAT_OUT <= FIFO_ADCD_PRE_COUNT_L;

            -- ADC B Pre-Trigger Count Register High
            when 303        =>
                DAT_OUT <= FIFO_ADCD_PRE_COUNT_H;

            -- Addresses 304 - 383 are Unused

            -- ADC Registers
            when 384 to 438 =>
                DAT_OUT <= reg(addrx);

				--	Mutitimer Registers
				when 464 to 466 =>
					 DAT_OUT <= reg(addrx);

				-- Kaiser Filter Registers
				when 467 to 470 =>
					 DAT_OUT <= reg(addrx);	

				-- Kaiser Coefficient Read Registers
				when 471			 =>
					if (reg(470)(0) = '0') then
						DAT_OUT <= K_READCOEF(15 downto 0);						 
					end if;
				when 472			 =>
					if (reg(470)(0) = '0') then
						DAT_OUT(1 downto 0) <= K_READCOEF(17 downto 16);						 
						DAT_OUT(15 downto 2) <= (others => '0'); 
					 end if; 
				-- Gaussian Filter Registers
				when 473 to 476 =>
					 DAT_OUT <= reg(addrx);				

				-- Gaussian Coefficient Read Registers
				when 477					=>
					if (reg(476)(0) = '0') then
						DAT_OUT <= G_READCOEF(15 downto 0);
					end if;
				when 478			 =>
					if (reg(476)(0) = '0') then
						DAT_OUT(1 downto 0) <= G_READCOEF(17 downto 16);						 
						DAT_OUT(15 downto 2) <= (others => '0');
					end if;	

            -- Addresses 439 - 511 are Unused
            when others     =>
                DAT_OUT <= (others => '0');

            end case;

        end if;
    END PROCESS;

    -------------------------------------------------------------
    -- ********************** Interrupts ********************* --
    -------------------------------------------------------------

    int_vctr0(0)    <= OVLD1_INT;
    int_vctr0(1)    <= OVLD2_INT;
    int_vctr0(2)    <= NOT CLKA_LOSS;
    int_vctr0(3)    <= NOT CLKB_LOSS;
    int_vctr0(4)    <= TEMP_INT;
    int_vctr0(5)    <= OVLD3_INT;
    int_vctr0(6)    <= OVLD4_INT;

    fifo_flags(0)(11 downto 8)  <= (FIFO_ADCA_F & FIFO_ADCA_AF &
                                    FIFO_ADCA_AE & FIFO_ADCA_E);
    fifo_flags(1)(11 downto 8)  <= (FIFO_ADCB_F & FIFO_ADCB_AF &
                                    FIFO_ADCB_AE & FIFO_ADCB_E);
    fifo_flags(2)(11 downto 8)  <= (FIFO_ADCC_F & FIFO_ADCC_AF &
                                    FIFO_ADCC_AE & FIFO_ADCC_E);
    fifo_flags(3)(11 downto 8)  <= (FIFO_ADCD_F & FIFO_ADCD_AF &
                                    FIFO_ADCD_AE & FIFO_ADCD_E);
    fifo_flags(4)(11 downto 8)  <= "0000";
    fifo_flags(5)(11 downto 8)  <= "0000";
    fifo_flags(6)(11 downto 8)  <= (FIFO_DACA_F & FIFO_DACA_AF &
                                    FIFO_DACA_AE & FIFO_DACA_E);
    fifo_flags(7)(11 downto 8)  <= "0000";
    fifo_flags(8)(11 downto 8)  <= (FIFO_MEMR_F & FIFO_MEMR_AF &
                                    FIFO_MEMR_AE & FIFO_MEMR_E);
    fifo_flags(9)(11 downto 8)  <= (FIFO_MEMW_F & FIFO_MEMW_AF &
                                    FIFO_MEMW_AE & FIFO_MEMW_E);
    fifo_flags(10)(11 downto 8) <= (FIFO_TEST_F & FIFO_TEST_AF &
                                    FIFO_TEST_AE & FIFO_TEST_E);

    int_vctr1(0)    <= (FIFO_ADCA_E AND reg(388)(0)) OR
                        (FIFO_ADCA_AE AND reg(388)(1)) OR
                            (FIFO_ADCA_AF AND reg(388)(2)) OR
                                (FIFO_ADCA_F AND reg(388)(3));
    int_vctr1(1)    <= (FIFO_ADCB_E AND reg(395)(0)) OR
                        (FIFO_ADCB_AE AND reg(395)(1)) OR
                            (FIFO_ADCB_AF AND reg(395)(2)) OR
                                (FIFO_ADCB_F AND reg(395)(3));
    int_vctr1(2)   <= (FIFO_ADCC_E AND reg(402)(0)) OR
                        (FIFO_ADCC_AE AND reg(402)(1)) OR
                            (FIFO_ADCC_AF AND reg(402)(2)) OR
                                (FIFO_ADCC_F AND reg(402)(3));
    int_vctr1(3)    <= (FIFO_ADCD_E AND reg(409)(0)) OR
                        (FIFO_ADCD_AE AND reg(409)(1)) OR
                            (FIFO_ADCD_AF AND reg(409)(2)) OR
                                (FIFO_ADCD_F AND reg(409)(3));
    int_vctr1(4)    <= '0'; --RESERVED 
    int_vctr1(5)    <= '0'; --RESERVED 
    int_vctr1(6)    <= (FIFO_DACA_E AND reg(133)(0)) OR
                        (FIFO_DACA_AE AND reg(133)(1)) OR
                            (FIFO_DACA_AF AND reg(133)(2)) OR
                                (FIFO_DACA_F AND reg(133)(3));
    int_vctr1(7)    <= '0'; --RESERVED 
    int_vctr1(8)    <= (FIFO_MEMR_E AND reg(430)(0)) OR
                        (FIFO_MEMR_AE AND reg(430)(1)) OR
                            (FIFO_MEMR_AF AND reg(430)(2)) OR
                                (FIFO_MEMR_F AND reg(430)(3));
    int_vctr1(9)    <= (FIFO_MEMW_E AND reg(436)(0)) OR
                        (FIFO_MEMW_AE AND reg(436)(1)) OR
                            (FIFO_MEMW_AF AND reg(436)(2)) OR
                                (FIFO_MEMW_F AND reg(436)(3));
    int_vctr1(10)   <=  (FIFO_ADCA_TRIG_STAT AND reg(388)(5)) OR
                        (FIFO_ADCB_TRIG_STAT AND reg(395)(5)) OR
                        (FIFO_ADCC_TRIG_STAT AND reg(402)(5)) OR
                        (FIFO_ADCD_TRIG_STAT AND reg(409)(5)) OR
                        (FIFO_DACA_TRIG_STAT AND reg(133)(5));
    int_vctr1(11)   <= NOT SYNCA_N;
    int_vctr1(12)   <= NOT SYNCB_N;
    int_vctr1(13)   <= NOT GATEA_N;
    int_vctr1(14)   <= NOT GATEB_N;
    int_vctr1(15)   <= (int_vctr0(0) AND reg(32)(0)) OR
                        (int_vctr0(1) AND reg(32)(1)) OR
                            (int_vctr0(2) AND reg(32)(2)) OR
                            (int_vctr0(3) AND reg(32)(3)) OR
                                (int_vctr0(4) AND reg(32)(4));


 GEN_INTS : for X in 0 to 3 GENERATE
        MAKE_INTS : PROCESS(reg(35), reg(36), reg(37), reg(38),
                                                        reg(39))
        VARIABLE Y : integer;
        BEGIN
            int(X) <= '0';
            for Y in 0 to 15 LOOP
                if ((reg(39)(Y) = '1') AND
                                    (reg(X + 35)(Y) = '1')) then
                    int(X) <= '1';
                end if;
            END LOOP;
        END PROCESS;
    END GENERATE GEN_INTS;
    
    -------------------------------------------------------------
    -- *************** Control Signal  Outputs *************** --
    -------------------------------------------------------------

    -- FPGA General Purpose I/O output data
    IO_DATA_OUT     <= reg(2);

    -- Two-Wire Serial Interface (TWSI or I2C) bus
    IIC_CLK         <= reg(3)(1);
    IIC_DAT         <= reg(3)(0) when (reg(3)(2) = '0') else 'Z';

    -- Clock Control
    ADC_CLK_SEL     <= reg(384)(0);
    CLK_SRC_A       <= NOT reg(16)(4);
    CLK_SRC_B       <= NOT reg(19)(4);
    DAC_CLK_SEL     <= reg(128)(0);
    DCM_CLK_SEL     <= reg(4)(3);
    DCM_RST         <= reg(4)(4);
    EXT_CLK_A       <= reg(16)(2);
    EXT_CLK_B       <= reg(19)(2);
    OSC_DISBL_A     <= NOT reg(16)(3);
    OSC_DISBL_B     <= NOT reg(19)(3);

    -- Bus Control Signals
    BUS_MASTER_A    <= reg(16)(0);
    BUS_MASTER_B    <= reg(19)(0);
    BUS_TERM_A      <= NOT reg(16)(1);
    BUS_TERM_B      <= NOT reg(19)(1);
    BYTESWAP        <= reg(5)(2);
    EXTD_ADDR       <= reg(6);

    -- SYNC/GATE signals
    EXT_GATE_A      <= reg(16)(8);
    EXT_GATE_B      <= reg(19)(8);
    EXT_SYNC_A      <= reg(16)(5);
    EXT_SYNC_B      <= reg(19)(5);
    GATE_POL_A      <= reg(16)(10);
    GATE_POL_B      <= reg(19)(10);
    GATE_SRC_A      <= reg(16)(9);
    GATE_SRC_B      <= reg(19)(9);
    GATEGO_A        <= reg(18)(0);
    GATEGO_B        <= reg(21)(0);
    SYNC_POL_A      <= reg(16)(7);
    SYNC_POL_B      <= reg(19)(7);
    SYNC_SRC_A      <= reg(16)(6);
    SYNC_SRC_B      <= reg(19)(6);
    SYNCGO_A        <= reg(17)(0);
    SYNCGO_B        <= reg(20)(0);

    -- Sync Masks
    DAC_SYNC_MASK   <= reg(22)(1);

    -- DAC Control Signals
    DAC_QFLAG       <= '0';
    DAC_RESET_N     <= NOT reg(129)(1);
    DACMODE         <= reg(129)(3);
    PLLVDD          <= reg(129)(2);

    -- FIFO Control Signals
    FIFO_ADCA_ARM           <= reg(385)(13);
    FIFO_ADCA_CLEAR         <= reg(385)(4);
    FIFO_ADCA_COUNT_AE      <= reg(389);
    FIFO_ADCA_COUNT_AF      <= (reg(390)(14 downto 0) & '0');
    FIFO_ADCA_DECDIV        <= reg(391);
    FIFO_ADCA_GATE_DISBL    <= reg(385)(5);
    FIFO_ADCA_GATE_ENABLE   <= reg(385)(0);
    FIFO_ADCA_GATE_SELB     <= reg(385)(7);
    FIFO_ADCA_HOLD          <= reg(385)(3);
    FIFO_ADCA_PACKMODE      <= reg(385)(10 downto 8);
    FIFO_ADCA_PRETRIG       <= reg(385)(12);
    FIFO_ADCA_RST           <= reg(385)(1) OR RST;
    FIFO_ADCA_TRIG          <= reg(385)(2);
    FIFO_ADCA_TRIGLEN_H     <= reg(387);
    FIFO_ADCA_TRIGLEN_L     <= reg(386);
    FIFO_ADCB_ARM           <= reg(392)(13);
    FIFO_ADCB_CLEAR         <= reg(392)(4);
    FIFO_ADCB_COUNT_AE      <= reg(396);
    FIFO_ADCB_COUNT_AF      <= (reg(397)(14 downto 0) & '0');
    FIFO_ADCB_DECDIV        <= reg(398);
    FIFO_ADCB_GATE_DISBL    <= reg(392)(5);
    FIFO_ADCB_GATE_ENABLE   <= reg(392)(0);
    FIFO_ADCB_GATE_SELB     <= reg(392)(7);
    FIFO_ADCB_HOLD          <= reg(392)(3);
    FIFO_ADCB_PACKMODE      <= reg(392)(10 downto 8);
    FIFO_ADCB_PRETRIG       <= reg(392)(12);
    FIFO_ADCB_RST           <= reg(392)(1) OR RST;
    FIFO_ADCB_TRIG          <= reg(392)(2);
    FIFO_ADCB_TRIGLEN_H     <= reg(394);
    FIFO_ADCB_TRIGLEN_L     <= reg(393);
    FIFO_ADCC_ARM           <= reg(399)(13);
    FIFO_ADCC_CLEAR         <= reg(399)(4);
    FIFO_ADCC_COUNT_AE      <= reg(403);
    FIFO_ADCC_COUNT_AF      <= (reg(404)(14 downto 0) & '0');
    FIFO_ADCC_DECDIV        <= reg(405);
    FIFO_ADCC_GATE_DISBL    <= reg(399)(5);
    FIFO_ADCC_GATE_ENABLE   <= reg(399)(0);
    FIFO_ADCC_GATE_SELB     <= reg(399)(7);
    FIFO_ADCC_HOLD          <= reg(399)(3);
    FIFO_ADCC_PACKMODE      <= reg(399)(10 downto 8);
    FIFO_ADCC_PRETRIG       <= reg(399)(12);
    FIFO_ADCC_RST           <= reg(399)(1) OR RST;
    FIFO_ADCC_TRIG          <= reg(399)(2);
    FIFO_ADCC_TRIGLEN_H     <= reg(401);
    FIFO_ADCC_TRIGLEN_L     <= reg(400);
    FIFO_ADCD_ARM           <= reg(406)(13);
    FIFO_ADCD_CLEAR         <= reg(406)(4);
    FIFO_ADCD_COUNT_AE      <= reg(410);
    FIFO_ADCD_COUNT_AF      <= (reg(411)(14 downto 0) & '0');
    FIFO_ADCD_DECDIV        <= reg(412);
    FIFO_ADCD_GATE_DISBL    <= reg(406)(5);
    FIFO_ADCD_GATE_ENABLE   <= reg(406)(0);
    FIFO_ADCD_GATE_SELB     <= reg(406)(7);
    FIFO_ADCD_HOLD          <= reg(406)(3);
    FIFO_ADCD_PACKMODE      <= reg(406)(10 downto 8);
    FIFO_ADCD_PRETRIG       <= reg(406)(12);
    FIFO_ADCD_RST           <= reg(406)(1) OR RST;
    FIFO_ADCD_TRIG          <= reg(406)(2);
    FIFO_ADCD_TRIGLEN_H     <= reg(408);
    FIFO_ADCD_TRIGLEN_L     <= reg(407);
    FIFO_DACA_CLEAR         <= reg(130)(4);
    FIFO_DACA_COUNT_AE      <= (reg(134)(14 downto 0) & '0');
    FIFO_DACA_COUNT_AF      <= reg(135);
    FIFO_DACA_GATE_DISBL    <= reg(130)(5);
    FIFO_DACA_GATE_ENABLE   <= reg(130)(0);
    FIFO_DACA_GATE_SELB     <= reg(130)(7);
    FIFO_DACA_HOLD          <= reg(130)(3);
    FIFO_DACA_PACKMODE      <= reg(130)(10 downto 8);
    FIFO_DACA_POST_LENGTH_H <= reg(137);
    FIFO_DACA_POST_LENGTH_L <= reg(136);
    FIFO_DACA_RST           <= reg(130)(1) OR RST;
    FIFO_DACA_TRIG          <= reg(130)(2);
    FIFO_DACA_TRIGLEN_H     <= reg(132);
    FIFO_DACA_TRIGLEN_L     <= reg(131);
    FIFO_MEMR_COUNT_AE      <= reg(431);
    FIFO_MEMR_COUNT_AF      <= reg(432);
    FIFO_MEMR_RST           <= reg(427)(1) OR RST;
    FIFO_MEMW_COUNT_AE      <= reg(437);
    FIFO_MEMW_COUNT_AF      <= reg(438);
    FIFO_MEMW_RST           <= reg(433)(1) OR RST;
    FIFO_TEST_COUNT_AE      <= reg(425);
    FIFO_TEST_COUNT_AF      <= reg(426);
    FIFO_TEST_RST           <= reg(423)(1) OR RST;
--  FIFOS_RDY               <= reg(5)(1);
    TEST_MODE               <= reg(5)(0);

    FIFO_ADCA_POST_LENGTH_L <= reg(288);
    FIFO_ADCA_POST_LENGTH_H <= reg(289);
    FIFO_ADCB_POST_LENGTH_L <= reg(290);
    FIFO_ADCB_POST_LENGTH_H <= reg(291);
    FIFO_ADCC_POST_LENGTH_L <= reg(292);
    FIFO_ADCC_POST_LENGTH_H <= reg(293);
    FIFO_ADCD_POST_LENGTH_L <= reg(294);
    FIFO_ADCD_POST_LENGTH_H <= reg(295);


    -- Delay Memory Signals
    MEM_CTRL_REG            <= reg(256);
    MEM0_DEPTH_REG_H        <= reg(258);
    MEM0_DEPTH_REG_L        <= reg(257);
    MEM0_START_REG_H        <= reg(264);
    MEM0_START_REG_L        <= reg(263);
    MEM1_DEPTH_REG_H        <= reg(260);
    MEM1_DEPTH_REG_L        <= reg(259);
    MEM1_START_REG_H        <= reg(266);
    MEM1_START_REG_L        <= reg(265);
    MEM2_DEPTH_REG_H        <= reg(262);
    MEM2_DEPTH_REG_L        <= reg(261);
    MEM2_START_REG_H        <= reg(268);
    MEM2_START_REG_L        <= reg(267);
	 
	 -- User DDC Signals
		-- 464: Multitimer Address Register
		-- 465: Multitimer Data Register
		-- 466: Multitimer Write Register
	
	 K_ADDR			      	 <= reg(467);
	 K_DATA(17 downto 16)    <= reg(469)(1 downto 0)when (reg(470)(0) = '1');
	 K_DATA(15 downto 0)     <= reg(468) when (reg(470)(0) = '1');
	 K_WR				      	 <= reg(470)(0);
	 G_ADDR			      	 <= reg(473);
	 G_DATA(17 downto 16)  	 <= reg(475)(1 downto 0)when (reg(476)(0) = '1');
	 G_DATA(15 downto 0)  	 <= reg(474)when (reg(476)(0) = '1');
	 G_WR				      	 <= reg(476)(0);

END RTL;