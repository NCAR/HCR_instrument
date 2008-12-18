-----------------------------------------------------------------
-- *********** Controller for Local Bus DDR2 SDRAM *********** --
-- ************ in Pentek Model  7142 Signal FPGA ************ --
-----------------------------------------------------------------
-- Title        : Local Bus DDR2 SDRAM Controller
-- Project      : Model 7142 Signal FPGA
-----------------------------------------------------------------
-- Filename     : DRAM_DTL.VHD
-- Author       : AB
-- Created      : 02/27/06 (Adapted from module of same name in
--                  Model 7140 User FPGA)
-- Last Modified: 03/15/07
-- Modified by  : Marc A. Lee, formatted for GateFlow 
--                  (Model 4953-142)
--                  Pentek, Inc.
--                  One Park Way,
--                  Upper Saddle River, NJ 07458
--                  (201) 818-5900
--                  www.pentek.com
--  Change log  :
--      10/07/05: Preliminary formatting for GateFlow (4953-140)
--      10/17/05: Added cross-references to GateFlow Block
--                  Diagrams.  Rearranged logic terms in Memory
--                  Address Counters (MEM0_ADDR, MEM1_ADDR) for
--                  clarity (function is not changed).
--      10/22/05: Rev. D update:  Add input FIFO_ADCB_WREN;
--                  Add Outputs MEM[0:1]_TRIG_REG_[H:L](15:0);
--                  Add signals trig_adc[a:b]_addr(30:0),
--                  trig_adc[a:b]_reached;  in Memory Address
--                  Counters (MEM0_ADDR, MEM1_ADDR), change
--                  comparison from "if (addr = DEPTH) then" to
--                  "if ((addr + 8) = DEPTH) then".
--      10/30/05: Updated Block Diagram for Rev. D code release,
--                  cross references to the diagram updated.
--      11/28/05: Rev. E update:  Input FIFO_ADCB_WREN (added
--                  10/22/05) changed to FIFO_ADCBM_WREN, (which
--                  it should have been in the first place).
--                  Added SIGNAL "rst" to sensitivity list for
--                  PROCESS SYNCER.  Added Inputs
--                  "FIFO_ADC(A:B)M_RST" to sensitivity lists
--                  for PROCESSes "DDC(C:D)_UNPACKER".  Removed
--                  unused SIGNALs "fifo_mem(r:w)data) and
--                  mem_rw.
--      02/27/06: Changes for Model 7142 User FPGA - change
--                  SDRAM controllers to DDR2 (sdram_ddr2_lb).
--      05/02/06: For Compatibility with ModelSim simulator,
--                  constants cannot be used in Port Maps.
--                  Several signals created with names of the
--                  form "value_#bit(s)" to substitute for the
--                  pre-existing constants in Port Maps for FIFOs
--                  and DRAM Controllers.  Also corrected "File-
--                  name", above (line 9).
--      10/22/06: In MEM2_ADDR process, changed innermost "if"
--                  clause from "if mem_dac_addr = ..." to
--                  "if (mem_dac_addr + 8) = ...".
--      03/14/07: Used latest FIFO_GENERATOR IP (Ver 3.2) to
--                  create new FIFOs - fifo_d2k_w32_r64 replaces
--                  FIFO1K32TO64;  fifo_d1k_w64_r32 replaces
--                  FIFO1K64TO32;  fifo_d1k_w64_r64 replaces
--                  FIFO1K64TO64.  Added a switch for the value
--                  of the Delay port on the SDRAM controllers
--                  to shorten Simulation time.
--      03/15/07: Port kit to VLX100 FPGA - removed references
--                  to VSX55 and Option 055 above.
--      03/22/07: Rename all instances of the Northwest Logic
--                  DDR2 SDRAM Controller Cores SDRAM_DDR2_LB_x,
--                  instead of SDRAM_DDR1_LB_x.
--      10/19/07 - Add "Signal FPGA" to Project Name field in
--                  header (line 6).
-----------------------------------------------------------------

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

LIBRARY UNISIM;
USE     UNISIM.vcomponents.all;

ENTITY MEMORY_APP is
PORT (
    ADC_CLK             : in  std_logic;
    BYTESWAP            : in  std_logic;
    CAL_CLK             : in  std_logic;
    DAC_CLK             : in  std_logic;

    DDR0_FB0IN          : in  std_logic;
    DDR0_FB1IN          : in  std_logic;
    DDR1_FB0IN          : in  std_logic;
    DDR1_FB1IN          : in  std_logic;
    DDR2_FB0IN          : in  std_logic;
    DDR2_FB1IN          : in  std_logic;

    FIFO_ADCAM_RST      : in  std_logic;
    FIFO_ADCAM_WREN     : in  std_logic;
    FIFO_ADCBM_RST      : in  std_logic;
    FIFO_ADCBM_WREN     : in  std_logic;
    FIFO_DACM_RDEN      : in  std_logic;
    FIFO_DACM_RST       : in  std_logic;
    FIFO_MEMR_RST       : in  std_logic;
    FIFO_MEMR_SEL       : in  std_logic;
    FIFO_MEMW_RST       : in  std_logic;
    FIFO_MEMW_SEL       : in  std_logic;

    IDELAYCTRL_RDY      : in  std_logic;
    INT_RESET_N         : in  std_logic;
    LCLK                : in  std_logic;
    SCLK                : in  std_logic;
    WCLK                : in  std_logic;

    ADCA_DATA           : in  std_logic_vector (31 downto 0);
    ADCB_DATA           : in  std_logic_vector (31 downto 0);

    DDR0_DQ_IN          : in  std_logic_vector (31 downto 0);
    DDR0_DQS_IN         : in  std_logic_vector (3 downto 0);
    DDR1_DQ_IN          : in  std_logic_vector (31 downto 0);
    DDR1_DQS_IN         : in  std_logic_vector (3 downto 0);
    DDR2_DQ_IN          : in  std_logic_vector (31 downto 0);
    DDR2_DQS_IN         : in  std_logic_vector (3 downto 0);

    FIFO_MEMR_COUNT_AE  : in  std_logic_vector (9 downto 0);
    FIFO_MEMR_COUNT_AF  : in  std_logic_vector (9 downto 0);
    FIFO_MEMW_COUNT_AE  : in  std_logic_vector (9 downto 0);
    FIFO_MEMW_COUNT_AF  : in  std_logic_vector (9 downto 0);

    FIFO_MEMW_DIN       : in  std_logic_vector (63 downto 0);
    MEM_CTRL_REG        : in  std_logic_vector (15 downto 0);

    MEM0_DEPTH_REG_H    : in  std_logic_vector (15 downto 0);
    MEM0_DEPTH_REG_L    : in  std_logic_vector (15 downto 0);
    MEM0_START_REG_H    : in  std_logic_vector (15 downto 0);
    MEM0_START_REG_L    : in  std_logic_vector (15 downto 0);
    MEM1_DEPTH_REG_H    : in  std_logic_vector (15 downto 0);
    MEM1_DEPTH_REG_L    : in  std_logic_vector (15 downto 0);
    MEM1_START_REG_H    : in  std_logic_vector (15 downto 0);
    MEM1_START_REG_L    : in  std_logic_vector (15 downto 0);
    MEM2_DEPTH_REG_H    : in  std_logic_vector (15 downto 0);
    MEM2_DEPTH_REG_L    : in  std_logic_vector (15 downto 0);
    MEM2_START_REG_H    : in  std_logic_vector (15 downto 0);
    MEM2_START_REG_L    : in  std_logic_vector (15 downto 0);

    DDR0_ADDRESS        : out std_logic_vector (15 downto 0);
    DDR0_BA             : out std_logic_vector (2 downto 0);
    DDR0_CKE            : out std_logic_vector (7 downto 0);
    DDR0_CS_N           : out std_logic_vector (7 downto 0);
    DDR0_DM             : out std_logic_vector (3 downto 0);
    DDR0_DQ_OE_N        : out std_logic_vector (31 downto 0);
    DDR0_DQ_OUT         : out std_logic_vector (31 downto 0);
    DDR0_DQS_OE_N       : out std_logic_vector (3 downto 0);
    DDR0_DQS_OUT        : out std_logic_vector (3 downto 0);

    DDR1_ADDRESS        : out std_logic_vector (15 downto 0);
    DDR1_BA             : out std_logic_vector (2 downto 0);
    DDR1_CKE            : out std_logic_vector (7 downto 0);
    DDR1_CS_N           : out std_logic_vector (7 downto 0);
    DDR1_DM             : out std_logic_vector (3 downto 0);
    DDR1_DQ_OE_N        : out std_logic_vector (31 downto 0);
    DDR1_DQ_OUT         : out std_logic_vector (31 downto 0);
    DDR1_DQS_OE_N       : out std_logic_vector (3 downto 0);
    DDR1_DQS_OUT        : out std_logic_vector (3 downto 0);

    DDR2_ADDRESS        : out std_logic_vector (15 downto 0);
    DDR2_BA             : out std_logic_vector (2 downto 0);
    DDR2_CKE            : out std_logic_vector (7 downto 0);
    DDR2_CS_N           : out std_logic_vector (7 downto 0);
    DDR2_DM             : out std_logic_vector (3 downto 0);
    DDR2_DQ_OE_N        : out std_logic_vector (31 downto 0);
    DDR2_DQ_OUT         : out std_logic_vector (31 downto 0);
    DDR2_DQS_OE_N       : out std_logic_vector (3 downto 0);
    DDR2_DQS_OUT        : out std_logic_vector (3 downto 0);

    FIFO_DACM_DOUT      : out std_logic_vector (31 downto 0);
    FIFO_MEMR_DOUT      : out std_logic_vector (63 downto 0);

    MEM0_END_REG_H      : out std_logic_vector (15 downto 0);
    MEM0_END_REG_L      : out std_logic_vector (15 downto 0);
    MEM0_TRIG_REG_H     : out std_logic_vector (15 downto 0);
    MEM0_TRIG_REG_L     : out std_logic_vector (15 downto 0);
    MEM1_END_REG_H      : out std_logic_vector (15 downto 0);
    MEM1_END_REG_L      : out std_logic_vector (15 downto 0);
    MEM1_TRIG_REG_H     : out std_logic_vector (15 downto 0);
    MEM1_TRIG_REG_L     : out std_logic_vector (15 downto 0);
    MEM2_END_REG_H      : out std_logic_vector (15 downto 0);
    MEM2_END_REG_L      : out std_logic_vector (15 downto 0);

    DDR0_CASB           : out std_logic;
    DDR0_FB0OUT         : out std_logic;
    DDR0_FB1OUT         : out std_logic;
    DDR0_ODT            : out std_logic;
    DDR0_RASB           : out std_logic;
    DDR0_WEB            : out std_logic;

    DDR1_CASB           : out std_logic;
    DDR1_FB0OUT         : out std_logic;
    DDR1_FB1OUT         : out std_logic;
    DDR1_ODT            : out std_logic;
    DDR1_RASB           : out std_logic;
    DDR1_WEB            : out std_logic;

    DDR2_CASB           : out std_logic;
    DDR2_FB0OUT         : out std_logic;
    DDR2_FB1OUT         : out std_logic;
    DDR2_ODT            : out std_logic;
    DDR2_RASB           : out std_logic;
    DDR2_WEB            : out std_logic;

    FIFO_MEMR_AE        : out std_logic;
    FIFO_MEMR_AF        : out std_logic;
    FIFO_MEMR_E         : out std_logic;
    FIFO_MEMR_F         : out std_logic;
    FIFO_MEMR_REQ       : out std_logic;

    FIFO_MEMW_AE        : out std_logic;
    FIFO_MEMW_AF        : out std_logic;
    FIFO_MEMW_E         : out std_logic;
    FIFO_MEMW_F         : out std_logic;
    FIFO_MEMW_REQ       : out std_logic
    );
END MEMORY_APP;

-----------------------------------------------------------------

ARCHITECTURE STRUCTURE of MEMORY_APP is

-----------------------------------------------------------------
-- ***************** Component  Declarations ***************** --
-----------------------------------------------------------------

-- Local Bus Double Data Rate II (DDR2) SDRAM Interface
COMPONENT SDRAM_DDR2_LB
GENERIC (    
    -- Local side Data width (this is 2x the number of dq bits)
    Dsize           : in  integer := 64;
    -- Set for nibble DQS implementations,
    -- where there is one DQS per 4 DQ bits
    Nibble_Devices  : in  integer :=  0;
    -- Number of differential clock output pairs generated
    Num_Clk_Outs    : in  integer :=  2;
    -- Number of read_validation loops implemented
    Num_Rd_Vld      : in  integer :=  2
    );
PORT (
    -- Clocks and Reset
    Cal_Clk             : in  std_logic;
    Clk                 : in  std_logic;
    Reset_n             : in  std_logic;
    Wr_D_Clk            : in  std_logic;

    -- Configuration Inputs
    Cfg_Auto_Ref_en     : in  std_logic;
    Cfg_BankBits        : in  std_logic;
    Cfg_Bt              : in  std_logic;
    Cfg_Diff_Dqs        : in  std_logic;
    Cfg_Dll_Disable     : in  std_logic;
    Cfg_Ds              : in  std_logic;
    Cfg_Lookahead_Act   : in  std_logic;
    Cfg_Lookahead_Pch   : in  std_logic;
    Cfg_Pch_Power_Down  : in  std_logic;
    Cfg_Qoff            : in  std_logic;
    Cfg_Rdqs            : in  std_logic;
    Cfg_RegDimm         : in  std_logic;
    Cfg_Two_T           : in  std_logic;
    Cfg_Two_T_Sel_Cycle : in  std_logic;
    Ctrlr_Init          : in  std_logic;
    IDelayCtrl_Rdy      : in  std_logic;

    Cfg_Al              : in  std_logic_vector (2 downto 0);
    Cfg_Bl              : in  std_logic_vector (1 downto 0);
    Cfg_Cl              : in  std_logic_vector (2 downto 0);
    Cfg_ColBits         : in  std_logic_vector (2 downto 0);
    Cfg_Emr2            : in  std_logic_vector (15 downto 0);
    Cfg_Emr3            : in  std_logic_vector (15 downto 0);
    Cfg_Faw             : in  std_logic_vector (4 downto 0);
    Cfg_Map_Rd_Vld0     : in  std_logic_vector (17 downto 0);
    Cfg_Map_Rd_Vld1     : in  std_logic_vector (17 downto 0);
    Cfg_Map_Rd_Vld2     : in  std_logic_vector (17 downto 0);
    Cfg_Map_Rd_Vld3     : in  std_logic_vector (17 downto 0);
    Cfg_Mrd             : in  std_logic_vector (2 downto 0);
    Cfg_Odt_Rd_Map_Cs0  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Rd_Map_Cs1  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Rd_Map_Cs2  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Rd_Map_Cs3  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Rd_Map_Cs4  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Rd_Map_Cs5  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Rd_Map_Cs6  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Rd_Map_Cs7  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Wr_Map_Cs0  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Wr_Map_Cs1  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Wr_Map_Cs2  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Wr_Map_Cs3  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Wr_Map_Cs4  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Wr_Map_Cs5  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Wr_Map_Cs6  : in  std_logic_vector (7 downto 0);
    Cfg_Odt_Wr_Map_Cs7  : in  std_logic_vector (7 downto 0);
    Cfg_Ras             : in  std_logic_vector (4 downto 0);
    Cfg_Rc              : in  std_logic_vector (4 downto 0);
    Cfg_Rcd             : in  std_logic_vector (2 downto 0);
    Cfg_Read_to_Read    : in  std_logic_vector (2 downto 0);
    Cfg_Read_to_Write   : in  std_logic_vector (1 downto 0);
    Cfg_Ref_Per         : in  std_logic_vector (15 downto 0);
    Cfg_Rfc             : in  std_logic_vector (7 downto 0);
    Cfg_Rowbits         : in  std_logic_vector (2 downto 0);
    Cfg_Rp              : in  std_logic_vector (2 downto 0);
    Cfg_Rrd             : in  std_logic_vector (2 downto 0);
    Cfg_Rtp             : in  std_logic_vector (1 downto 0);
    Cfg_Rtt             : in  std_logic_vector (1 downto 0);
    Cfg_Startup_Delay   : in  std_logic_vector (16 downto 0);
    Cfg_Wr              : in  std_logic_vector (2 downto 0);
    Cfg_Write_to_Write  : in  std_logic_vector (2 downto 0);
    Cfg_Wtr             : in  std_logic_vector (1 downto 0);
    Cfg_Xsnr            : in  std_logic_vector (7 downto 0);

    -- Local Bus (PCI) Interface
    L_Auto_Pch          : in  std_logic;
    L_R_Req             : in  std_logic;
    L_Ref_Req           : in  std_logic;
    L_W_Req             : in  std_logic;

    L_Addr              : in  std_logic_vector (32 downto 0);
    L_B_Size            : in  std_logic_vector (3 downto 0);
    L_Datain            : in  std_logic_vector
                                        ((Dsize - 1) downto 0);
    L_Dm_in             : in  std_logic_vector
                                        ((Dsize/8 - 1) downto 0);
    L_Power_Down        : in  std_logic_vector (7 downto 0);
    L_Self_Refresh      : in  std_logic_vector (7 downto 0);

    L_Dataout           : out std_logic_vector
                                        ((Dsize - 1) downto 0);

    L_Busy              : out std_logic;
    L_D_Req             : out std_logic;
    L_R_Valid           : out std_logic;
    L_Ref_Ack           : out std_logic;
    L_W_Valid           : out std_logic;

    -- External Connections to SDRAM

    Sd_Dq_in            : in  std_logic_vector
                                        ((Dsize/2 - 1) downto 0);
    Sd_Dqs_in           : in  std_logic_vector (((Dsize/16) *
                            (Nibble_Devices + 1) - 1) downto 0);

    -- Round-Trip Delay Calibration Loop -
    -- Loop created on circuit board to match round-trip delay
    -- of clock/DQS to SDRAM devices.  Used to time which
    -- clock cycle read data is available on.

    Sd_Rd_Vld_in        : in  std_logic_vector
                                    ((Num_Rd_Vld - 1) downto 0);
    Sd_Rd_Vld_out       : out std_logic_vector
                                    ((Num_Rd_Vld - 1) downto 0);

    Sd_A                : out std_logic_vector (15 downto 0);
    Sd_Ba               : out std_logic_vector (2 downto 0);
    Sd_Cke              : out std_logic_vector (7 downto 0);
    Sd_Cs_n             : out std_logic_vector (7 downto 0);
    Sd_Dm               : out std_logic_vector
                                    ((Dsize/16 - 1) downto 0);
    Sd_Dq_Oe_n          : out std_logic_vector
                                        ((Dsize/2 - 1) downto 0);
    Sd_Dq_out           : out std_logic_vector
                                        ((Dsize/2 - 1) downto 0);
    Sd_Dqs_Oe_n         : out std_logic_vector (((Dsize/16) *
                            (Nibble_Devices + 1) - 1) downto 0);
    Sd_Dqs_out          : out std_logic_vector (((Dsize/16) *
                            (Nibble_Devices + 1) - 1) downto 0);
    Sd_Odt              : out std_logic_vector (7 downto 0);

    Sd_Cas_n            : out std_logic;
    Sd_Ras_n            : out std_logic;
    Sd_We_n             : out std_logic
    );
END COMPONENT;

-- FIFO, 32-bit input, 64-bit output
COMPONENT fifo_d2k_w32_r64
PORT (
    Rd_Clk              : in  std_logic;
    Rd_En               : in  std_logic;
    Rst                 : in  std_logic;
    Wr_Clk              : in  std_logic;
    Wr_En               : in  std_logic;

    Din                 : in  std_logic_vector (31 downto 0);
    Prog_Empty_Thresh   : in  std_logic_vector ( 9 downto 0);
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

-- FIFO, 64-bit input, 32-bit output
COMPONENT fifo_d1k_w64_r32
PORT (
    Rd_Clk              : in  std_logic;
    Rd_En               : in  std_logic;
    Rst                 : in  std_logic;
    Wr_Clk              : in  std_logic;
    Wr_En               : in  std_logic;

    Din                 : in  std_logic_vector (63 downto 0);
    Prog_Empty_Thresh   : in  std_logic_vector (10 downto 0);
    Prog_Full_Thresh    : in  std_logic_vector ( 9 downto 0);

    Dout                : out std_logic_vector (31 downto 0);

    Almost_Empty        : out std_logic;
    Almost_Full         : out std_logic;
    Empty               : out std_logic;
    Full                : out std_logic;
    Prog_Empty          : out std_logic;
    Prog_Full           : out std_logic
    );
END COMPONENT;

 -- FIFO, 64-bit input, 64-bit output
COMPONENT fifo_d1k_w64_r64
PORT (     
    Rd_Clk              : in  std_logic;
    Rd_En               : in  std_logic;
    Rst                 : in  std_logic;
    Wr_Clk              : in  std_logic;
    Wr_En               : in  std_logic;

    Din                 : in  std_logic_vector (63 downto 0);
    Prog_Empty_Thresh   : in  std_logic_vector ( 9 downto 0);
    Prog_Full_Thresh    : in  std_logic_vector ( 9 downto 0);

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
-- ******************* Signal Declarations ******************* --
-----------------------------------------------------------------

SIGNAL fifo_adcam_aef   : std_logic;
SIGNAL fifo_adcbm_aef   : std_logic;
SIGNAL fifo_dacm_af     : std_logic;

SIGNAL fifo_memr_aef    : std_logic;
SIGNAL fifo_memr_aff    : std_logic;
SIGNAL fifo_memr_wren   : std_logic;
SIGNAL fifo_memw_aef    : std_logic;
SIGNAL fifo_memw_aff    : std_logic;
SIGNAL fifo_memw_rden   : std_logic;

SIGNAL mem_adca_busy    : std_logic;
SIGNAL mem_adca_rd      : std_logic;
SIGNAL mem_adca_rreq    : std_logic;
SIGNAL mem_adca_run     : std_logic;
SIGNAL mem_adca_rvalid  : std_logic;
SIGNAL mem_adca_wr      : std_logic;
SIGNAL mem_adca_wreq    : std_logic;
SIGNAL mem_adca_wvalid  : std_logic;

SIGNAL mem_adcb_busy    : std_logic;
SIGNAL mem_adcb_rd      : std_logic;
SIGNAL mem_adcb_rreq    : std_logic;
SIGNAL mem_adcb_run     : std_logic;
SIGNAL mem_adcb_rvalid  : std_logic;
SIGNAL mem_adcb_wr      : std_logic;
SIGNAL mem_adcb_wreq    : std_logic;
SIGNAL mem_adcb_wvalid  : std_logic;

SIGNAL mem_dac_busy     : std_logic;
SIGNAL mem_dac_rd       : std_logic;
SIGNAL mem_dac_rreq     : std_logic;
SIGNAL mem_dac_run      : std_logic;
SIGNAL mem_dac_rvalid   : std_logic;
SIGNAL mem_dac_wr       : std_logic;
SIGNAL mem_dac_wreq     : std_logic;
SIGNAL mem_dac_wvalid   : std_logic;

SIGNAL rst              : std_logic;
SIGNAL trig_adca_reached: std_logic;
SIGNAL trig_adcb_reached: std_logic;

SIGNAL ddr0_vodt        : std_logic_vector ( 7 downto  0);
SIGNAL ddr0_fbin_valid  : std_logic_vector ( 1 downto  0);
SIGNAL ddr0_fbout_valid : std_logic_vector ( 1 downto  0);

SIGNAL ddr1_vodt        : std_logic_vector ( 7 downto  0);
SIGNAL ddr1_fbin_valid  : std_logic_vector ( 1 downto  0);
SIGNAL ddr1_fbout_valid : std_logic_vector ( 1 downto  0);

SIGNAL ddr2_vodt        : std_logic_vector ( 7 downto  0);
SIGNAL ddr2_fbin_valid  : std_logic_vector ( 1 downto  0);
SIGNAL ddr2_fbout_valid : std_logic_vector ( 1 downto  0);

SIGNAL din_swapped      : std_logic_vector (63 downto  0);

SIGNAL fifo_adcam_dout  : std_logic_vector (63 downto  0);
SIGNAL fifo_adcbm_dout  : std_logic_vector (63 downto  0);

SIGNAL fifo_memr_dout_unswapped
                        : std_logic_vector (63 downto  0);
SIGNAL fifo_memw_dout   : std_logic_vector (63 downto  0);

SIGNAL mem_adca_addr    : std_logic_vector (32 downto  0);
SIGNAL mem_adca_din     : std_logic_vector (63 downto  0);
SIGNAL mem_adca_dout    : std_logic_vector (63 downto  0);

SIGNAL mem_adcb_addr    : std_logic_vector (32 downto  0);
SIGNAL mem_adcb_din     : std_logic_vector (63 downto  0);
SIGNAL mem_adcb_dout    : std_logic_vector (63 downto  0);

SIGNAL mem_ctrl_reg_q   : std_logic_vector (15 downto  0);
SIGNAL mem_dac_addr     : std_logic_vector (32 downto  0);
SIGNAL mem_dac_dout     : std_logic_vector (63 downto  0);
SIGNAL mem_dout         : std_logic_vector (63 downto  0);

SIGNAL trig_adca_addr   : std_logic_vector (32 downto  0);
SIGNAL trig_adcb_addr   : std_logic_vector (32 downto  0);

-----------------------------------------------------------------
-- ****************** Constant Declarations ****************** --
-----------------------------------------------------------------

-- These symbolic constants are used in Port Maps, where the
-- ModelSim Simulator prohibits the use of numeric constants.

SIGNAL hi                   : std_logic := '1';
SIGNAL lo                   : std_logic := '0';

SIGNAL one_in_2_bits        : std_logic_vector (1 downto 0)
                            := "01";
SIGNAL two_in_2_bits        : std_logic_vector (1 downto 0)
                            := "10";
SIGNAL two_in_3_bits        : std_logic_vector (2 downto 0)
                            := "010";
SIGNAL three_in_3_bits      : std_logic_vector (2 downto 0)
                            := "011";
SIGNAL four_in_3_bits       : std_logic_vector (2 downto 0)
                            := "100";
SIGNAL five_in_3_bits       : std_logic_vector (2 downto 0)
                            := "101";
SIGNAL four_in_4_bits       : std_logic_vector (3 downto 0)
                            := "0100";
SIGNAL nine_in_5_bits       : std_logic_vector (4 downto 0)
                            := "01001";
SIGNAL thirteen_in_5_bits   : std_logic_vector (4 downto 0)
                            := "01101";
SIGNAL eighteen_in_5_bits   : std_logic_vector (4 downto 0)
                            := "10010";
SIGNAL zero_in_8_bits       : std_logic_vector (7 downto 0)
                            := "00000000";
SIGNAL thirty_three_h_in_8_bits
                            : std_logic_vector (7 downto 0)
                            := "00110011";
SIGNAL thirty_seven_h_in_8_bits
                            : std_logic_vector (7 downto 0)
                            := "00110111";
SIGNAL two_fifty_five_in_8_bits
                            : std_logic_vector (7 downto 0)
                            := "11111111";
SIGNAL one_hundred_h_in_10_bits
                            : std_logic_vector (9 downto 0)
                            := "0100000000";
SIGNAL three_hundred_h_in_10_bits
                            : std_logic_vector (9 downto 0)
                            := "1100000000";
SIGNAL two_hundred_h_in_11_bits
                            : std_logic_vector (10 downto 0)
                            := "01000000000";
SIGNAL six_hundred_h_in_11_bits
                            : std_logic_vector (10 downto 0)
                            := "11000000000";
SIGNAL zero_in_16_bits      : std_logic_vector (15 downto 0)
                            := "0000000000000000";
SIGNAL four_hundred_h_in_16_bits
                            : std_logic_vector (15 downto 0)
                            := "0000010000000000";
SIGNAL c_thousand_h_in_17_bits
                            : std_logic_vector (16 downto 0)
                            := "01100000000000000";
SIGNAL zero_in_18_bits      : std_logic_vector (17 downto 0)
                            := "000000000000000000";
SIGNAL three_in_18_bits     : std_logic_vector (17 downto 0)
                            := "000000000000000011";
SIGNAL seven_in_18_bits     : std_logic_vector (17 downto 0)
                            := "000000000000000111";
SIGNAL eight_in_18_bits     : std_logic_vector (17 downto 0)
                            := "000000000000001000";
SIGNAL twelve_in_18_bits    : std_logic_vector (17 downto 0)
                            := "000000000000001100";

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

BEGIN

    -------------------------------------------------------------
    -- **************** Assignment Statements **************** --
    -------------------------------------------------------------

    -------------------------------------------------------------
    -- ************************ NOTE ************************* --
    -- ** The SDRAM controllers are not ready for use until ** --
    -- *** 400 us after reset is de-asserted.  We set this *** --
    -- *** period via the Delay port, driven by the SIGNAL *** --
    -- **** fivek_16bit. During simulation, however, that **** --
    -- ** delay is not necessary, and it causes one to wait ** --
    -- *** a V-E-R-Y long time for results.  The statement *** --
    -- *** between the "synopsys translate" switches below *** --
    -- ** assign a smaller value  to the Delay signal, that ** --
    -- **** is used only during simulation and is ignored **** --
    -- *** when ISE compiles the  hardware creation files. *** --
    -------------------------------------------------------------

    -- synopsys translate_off
    c_thousand_h_in_17_bits <= "00000000000001100";
    -- synopsys translate_on

    -- See Block Diagram, page 1
    rst             <= NOT INT_RESET_N;

    -- See Block Diagram, page 2
    MEM0_END_REG_L  <= mem_adca_addr(15 downto 0);
    MEM0_END_REG_H  <= ("0" & mem_adca_addr(30 downto 16));

    MEM0_TRIG_REG_L <= trig_adca_addr(15 downto 0);
    MEM0_TRIG_REG_H <= ("0" & trig_adca_addr(30 downto 16));

    -- See Block Diagram, page 3
    MEM1_END_REG_L  <= mem_adcb_addr(15 downto 0);
    MEM1_END_REG_H  <= ("0" & mem_adcb_addr(30 downto 16));

    MEM1_TRIG_REG_L <= trig_adcb_addr(15 downto 0);
    MEM1_TRIG_REG_H <= ("0" & trig_adcb_addr(30 downto 16));

    -- See Block Diagram, page 6
    MEM2_END_REG_L  <= mem_dac_addr(15 downto 0);
    MEM2_END_REG_H  <= ("0" & mem_dac_addr(30 downto 16));

    -- See Block Diagram, page 1
    SYNCER : PROCESS (SCLK, rst)
    BEGIN 
        if (rst = '1') then
            mem_dac_run     <= '0';
            mem_adca_run    <= '0';
            mem_adcb_run    <= '0';
        elsif (rising_edge (SCLK)) then
            mem_ctrl_reg_q  <= MEM_CTRL_REG(15 downto 0);
            mem_adca_run    <= MEM_CTRL_REG(4);
            mem_adcb_run    <= MEM_CTRL_REG(5);
            mem_dac_run     <= MEM_CTRL_REG(6);
        end if;
    END PROCESS;

    mem_adca_wr <= mem_ctrl_reg_q(0) AND (NOT mem_ctrl_reg_q(1))
                                        AND mem_ctrl_reg_q(2);
    mem_adcb_wr <= (NOT mem_ctrl_reg_q(0)) AND mem_ctrl_reg_q(1)
                                        AND mem_ctrl_reg_q(2);
    mem_dac_wr  <= mem_ctrl_reg_q(0) AND mem_ctrl_reg_q(1) AND
                                            mem_ctrl_reg_q(2);
    mem_adca_rd <= mem_ctrl_reg_q(0) AND (NOT mem_ctrl_reg_q(1))
                                    AND (NOT mem_ctrl_reg_q(2));
    mem_adcb_rd <= (NOT mem_ctrl_reg_q(0)) AND mem_ctrl_reg_q(1)
                                    AND (NOT mem_ctrl_reg_q(2));
    mem_dac_rd  <= mem_ctrl_reg_q(0) AND mem_ctrl_reg_q(1)
                                    AND (NOT mem_ctrl_reg_q(2));

    -- See Block Diagram, page 6
    PROCESS (LCLK, rst)
    BEGIN
        if (rst = '1') then
            FIFO_MEMR_REQ   <= '0';
        elsif (rising_edge (LCLK)) then
            if (fifo_memr_aef = '1') then
                FIFO_MEMR_REQ   <= '0';
            elsif (fifo_memr_aff = '1') then
                FIFO_MEMR_REQ   <= '1';
            end if;
            if (fifo_memw_aff = '1') then
                FIFO_MEMW_REQ   <= '0';
            elsif (fifo_memw_aef = '1') then
                FIFO_MEMW_REQ <= '1';
            end if;
        end if;
    END PROCESS;

    -------------------------------------------------------------
    -- **************** Data Out to Local Bus **************** --
    -------------------------------------------------------------

    -- See Block Diagram, page 5
     FIFO_MEMR_DOUT  <= (fifo_memr_dout_unswapped(31 downto 0) &
                        fifo_memr_dout_unswapped(63 downto 32))
                    when (BYTESWAP = '0')
                    else (fifo_memr_dout_unswapped(7 downto 0) &
                        fifo_memr_dout_unswapped(15 downto  8) &
                        fifo_memr_dout_unswapped(23 downto 16) &
                        fifo_memr_dout_unswapped(31 downto 24) &
                        fifo_memr_dout_unswapped(39 downto 32) &
                        fifo_memr_dout_unswapped(47 downto 40) &
                        fifo_memr_dout_unswapped(55 downto 48) &
                        fifo_memr_dout_unswapped(63 downto 56));

    -------------------------------------------------------------
    -- ******** Instantiate Delay  Memory Output FIFO ******** --
    -------------------------------------------------------------

    FIFO_MEMR : fifo_d1k_w64_r64
    PORT MAP (
        Rd_Clk              => LCLK,
        Rd_En               => FIFO_MEMR_SEL,
        Rst                 => FIFO_MEMR_RST,
        Wr_Clk              => SCLK,
        Wr_En               => fifo_memr_wren,

        Din                 => mem_dout,
        Prog_Empty_Thresh   => FIFO_MEMR_COUNT_AE,
        Prog_Full_Thresh    => FIFO_MEMR_COUNT_AF,

        Dout                => fifo_memr_dout_unswapped,

        Almost_Empty        => OPEN,
        Almost_Full         => OPEN,
        Empty               => FIFO_MEMR_E,
        Full                => FIFO_MEMR_F,
        Prog_Empty          => fifo_memr_aef,
        Prog_Full           => fifo_memr_aff
        );

    -- Flag Assignment
    FIFO_MEMR_AF    <= fifo_memr_aff;
    FIFO_MEMR_AE    <= fifo_memr_aef;

    -- Output FIFO Write Enable
    fifo_memr_wren  <= mem_adca_rvalid
                        when (mem_adca_rd = '1')
                        else mem_adcb_rvalid
                        when (mem_adcb_rd = '1')
                        else mem_dac_rvalid
                        when (mem_dac_rd  = '1')
                        else '0';

    -- Select source of Output Data
    mem_dout    <= mem_adca_dout
                    when (mem_adca_rd = '1')
                    else mem_adcb_dout
                    when (mem_adcb_rd = '1')
                    else mem_dac_dout;

    -------------------------------------------------------------
    -- *************** Data In  from Local Bus *************** --
    -------------------------------------------------------------

    -- See Block Diagram, page 4
    din_swapped <= (FIFO_MEMW_DIN(7 downto  0) &
                    FIFO_MEMW_DIN(15 downto 8) &
                        FIFO_MEMW_DIN(23 downto 16) &
                        FIFO_MEMW_DIN(31 downto 24) &
                            FIFO_MEMW_DIN(39 downto 32) &
                            FIFO_MEMW_DIN(47 downto 40) &
                                FIFO_MEMW_DIN(55 downto 48) &
                                FIFO_MEMW_DIN(63 downto 56))
                                            when (BYTESWAP = '1')
                    else (FIFO_MEMW_DIN(31 downto 0) &
                                    FIFO_MEMW_DIN(63 downto 32));

    -------------------------------------------------------------
    -- ********* Instantiate Delay Memory Input FIFO ********* --
    -------------------------------------------------------------

    FIFO_MEMW : fifo_d1k_w64_r64
    PORT MAP (
        Rd_Clk              => SCLK,
        Rd_En               => fifo_memw_rden,
        Rst                 => FIFO_MEMW_RST,
        Wr_Clk              => LCLK,
        Wr_En               => FIFO_MEMW_SEL,

        Din                 => din_swapped,
        Prog_Empty_Thresh   => FIFO_MEMW_COUNT_AE,
        Prog_Full_Thresh    => FIFO_MEMW_COUNT_AF,

        Dout                => fifo_memw_dout,

        Almost_Empty        => OPEN,
        Almost_Full         => OPEN,
        Empty               => FIFO_MEMW_E,
        Full                => FIFO_MEMW_F,
        Prog_Empty          => fifo_memw_aef,
        Prog_Full           => fifo_memw_aff
        );

    -- Flag Assignment
    FIFO_MEMW_AE <= fifo_memw_aef;
    FIFO_MEMW_AF <= fifo_memw_aff;

    -- Input FIFO Read Enable
    fifo_memw_rden  <= mem_adca_wvalid
                        when (mem_adca_wr = '1')
                        else mem_adcb_wvalid
                        when (mem_adcb_wr = '1')
                        else mem_dac_wvalid
                        when (mem_dac_wr  = '1')
                        else '0';

    -------------------------------------------------------------
    -- ********* Instantiate FIFO  for ADC Channel A ********* --
    -------------------------------------------------------------

    -- See Block Diagram, page 2
    FIFO_ADCAM : fifo_d2k_w32_r64
    PORT MAP (
        Rd_Clk              => SCLK,
        Rd_En               => mem_adca_wvalid,
        Rst                 => FIFO_ADCAM_RST,
        Wr_Clk              => ADC_CLK,
        Wr_En               => FIFO_ADCAM_WREN,

        Din                 => ADCA_DATA,
        Prog_Empty_Thresh   => one_hundred_h_in_10_bits,
        Prog_Full_Thresh    => six_hundred_h_in_11_bits,

        Dout                => fifo_adcam_dout,

        Almost_Empty        => OPEN,
        Almost_Full         => OPEN,
        Empty               => OPEN,
        Full                => OPEN,
        Prog_Empty          => fifo_adcam_aef,
        Prog_Full           => OPEN
        );

    -- See Block Diagram, page 4
    mem_adca_din    <= fifo_memw_dout
                        when (mem_adca_wr = '1')
                        else fifo_adcam_dout;

    -- See Block Diagram, page 2
    MEM0_ADDR : PROCESS (SCLK)
    BEGIN
        if (rising_edge (SCLK)) then
            if (mem_adca_run = '0') then
                mem_adca_addr   <= ("00" & MEM0_START_REG_H
                                                (14 downto 0) &
                                            MEM0_START_REG_L
                                                (15 downto 3) &
                                                        "000");
            elsif (mem_adca_busy = '0' AND (mem_adca_rreq = '1'
                                    OR mem_adca_wreq = '1')) then
                if (mem_adca_addr + 8) = ("00" & MEM0_DEPTH_REG_H
                                                (14 downto 0) &
                                                MEM0_DEPTH_REG_L
                                                (15 downto 3) &
                                                    "000") then
                    mem_adca_addr   <= ("00" & MEM0_START_REG_H
                                                (14 downto 0) &
                                                MEM0_START_REG_L
                                                (15 downto 3) &
                                                         "000");
                else
                    mem_adca_addr   <= mem_adca_addr + 8;
                end if;
            end if;

            if (mem_adca_run = '0') then
                trig_adca_reached   <= '0';
                trig_adca_addr      <= ("00" & MEM0_START_REG_H
                                                (14 downto 0) &
                                                MEM0_START_REG_L
                                                (15 downto 3) &
                                                        "000");
            elsif (mem_adca_rd = '0' AND mem_adca_wr = '0' AND
                        mem_adca_wvalid = '1' AND
                                    trig_adca_reached = '0') then
                if (fifo_adcam_dout(32) = '1' OR
                                fifo_adcam_dout(48) = '1') then
                    trig_adca_reached   <= '1';
                    trig_adca_addr      <= trig_adca_addr;
                elsif (fifo_adcam_dout(0) = '1' OR
                                fifo_adcam_dout(16) = '1') then
                    trig_adca_reached   <= '1';
                    trig_adca_addr      <= trig_adca_addr + 1;
                elsif (trig_adca_addr + 2) =
                        (MEM0_DEPTH_REG_H(14 downto 0) &
                                MEM0_DEPTH_REG_L(15 downto 3) &
                                                    "000") then
                    trig_adca_addr  <= ("00" & MEM0_START_REG_H
                                                (14 downto 0) &
                                                MEM0_START_REG_L
                                                (15 downto 3) &
                                                        "000");
                else
                    trig_adca_addr  <= trig_adca_addr + 2;
                end if;
            end if;
        end if;
    END PROCESS;

    -- See Block Diagram, page 1
    mem_adca_rreq   <= ((NOT fifo_memr_aff) AND mem_adca_rd)
                                                AND mem_adca_run;
    mem_adca_wreq   <= (((NOT fifo_memw_aef) AND mem_adca_wr) OR
                                ((NOT fifo_adcam_aef) AND
                                        (NOT (mem_adca_rd OR
                                            mem_adca_wr)))) AND
                                                    mem_adca_run;

    -------------------------------------------------------------
    -- ********* Instantiate SDRAM Bank 0 Controller ********* --
    -------------------------------------------------------------

    -- See Block Diagram, page 4
    SDRAM_DDR2_LB_0 : SDRAM_DDR2_LB
    PORT MAP (
        -- Clocks and Reset
        Cal_Clk             =>   CAL_CLK,
        Clk                 =>   SCLK,
        Reset_n             =>   INT_RESET_N,
        Wr_D_Clk            =>   WCLK,

       -- Configuration Inputs
        Cfg_Auto_Ref_en     => hi,
        Cfg_BankBits        => hi,
        Cfg_Bt              => lo,
        Cfg_Diff_Dqs        => lo,
        Cfg_Dll_Disable     => lo,
        Cfg_Ds              => lo,
        Cfg_Lookahead_Act   => lo,
        Cfg_Lookahead_Pch   => lo,
        Cfg_Pch_Power_Down  => lo,
        Cfg_Qoff            => lo,
        Cfg_Rdqs            => lo,
        Cfg_RegDimm         => lo,
        Cfg_Two_T           => lo,
        Cfg_Two_T_Sel_Cycle => lo,
        Ctrlr_Init          => lo,
        IDelayCtrl_Rdy      => IDELAYCTRL_RDY,

        Cfg_Al              => two_in_3_bits,
        Cfg_Bl              => two_in_2_bits,
        Cfg_Cl              => four_in_3_bits,
        Cfg_ColBits         => five_in_3_bits,
        Cfg_Emr2            => zero_in_16_bits,
        Cfg_Emr3            => zero_in_16_bits,
        Cfg_Faw             => eighteen_in_5_bits,
        Cfg_Map_Rd_Vld0     => seven_in_18_bits,
        Cfg_Map_Rd_Vld1     => eight_in_18_bits,
        Cfg_Map_Rd_Vld2     => zero_in_18_bits,
        Cfg_Map_Rd_Vld3     => zero_in_18_bits,
        Cfg_Mrd             => two_in_3_bits,
        Cfg_Odt_Rd_Map_Cs0  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs1  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs2  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs3  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs4  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs5  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs6  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs7  => zero_in_8_bits,
        Cfg_Odt_Wr_Map_Cs0  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs1  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs2  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs3  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs4  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs5  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs6  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs7  => two_fifty_five_in_8_bits,
        Cfg_Ras             => nine_in_5_bits,
        Cfg_Rc              => thirteen_in_5_bits,
        Cfg_Rcd             => four_in_3_bits,
        Cfg_Read_to_Read    => three_in_3_bits,
        Cfg_Read_to_Write   => one_in_2_bits,
        Cfg_Ref_Per         => four_hundred_h_in_16_bits,
        Cfg_Rfc             => thirty_three_h_in_8_bits,
        Cfg_Rowbits         => two_in_3_bits,
        Cfg_Rp              => four_in_3_bits,
        Cfg_Rrd             => two_in_3_bits,
        Cfg_Rtp             => two_in_2_bits,
        Cfg_Rtt             => one_in_2_bits,
        Cfg_Startup_Delay   => c_thousand_h_in_17_bits,
        Cfg_Wr              => three_in_3_bits,
        Cfg_Write_to_Write  => three_in_3_bits,
        Cfg_Wtr             => two_in_2_bits,
        Cfg_Xsnr            => thirty_seven_h_in_8_bits,

        -- Local Interface
        L_Auto_Pch          => lo,
        L_R_Req             => mem_adca_rreq,
        L_Ref_Req           => lo,
        L_W_Req             => mem_adca_wreq,

        L_Addr              => mem_adca_addr,
        L_B_Size            => four_in_4_bits,
        L_Datain            => mem_adca_din,
        L_Dm_in             => zero_in_8_bits,
        L_Power_Down        => zero_in_8_bits,
        L_Self_Refresh      => zero_in_8_bits,

        L_Dataout           => mem_adca_dout,

        L_Busy              => mem_adca_busy,
        L_D_Req             => OPEN,
        L_R_Valid           => mem_adca_rvalid,
        L_Ref_Ack           => OPEN,
        L_W_Valid           => mem_adca_wvalid,

       -- External Connections to SDRAM
        Sd_Dq_in            => DDR0_DQ_IN,
        Sd_Dqs_in           => DDR0_DQS_IN,

        -- Round-Trip Delay Calibration Loop
        Sd_Rd_Vld_in        => ddr0_fbin_valid,
        Sd_Rd_Vld_out       => ddr0_fbout_valid,

        Sd_A                => DDR0_ADDRESS,
        Sd_Ba               => DDR0_BA,
        Sd_Cke              => DDR0_CKE,
        Sd_Cs_n             => DDR0_CS_N,
        Sd_Dm               => DDR0_DM,
        Sd_Dq_Oe_n          => DDR0_DQ_OE_N,
        Sd_Dq_out           => DDR0_DQ_OUT,
        Sd_Dqs_Oe_n         => DDR0_DQS_OE_N,
        Sd_Dqs_out          => DDR0_DQS_OUT,
        Sd_Odt              => ddr0_vodt,

        Sd_Cas_n            => DDR0_CASB,
        Sd_Ras_n            => DDR0_RASB,
        Sd_We_n             => DDR0_WEB
        );

    DDR0_ODT            <= ddr0_vodt(0);

    DDR0_FB0OUT         <= ddr0_fbout_valid(0);
    DDR0_FB1OUT         <= ddr0_fbout_valid(1);
    ddr0_fbin_valid(0)  <= DDR0_FB0IN;
    ddr0_fbin_valid(1)  <= DDR0_FB1IN;

    -------------------------------------------------------------
    -- ********* Instantiate FIFO  for ADC Channel B ********* --
    -------------------------------------------------------------

    -- See Block Diagram, page 3
    FIFO_ADCBM : fifo_d2k_w32_r64
    PORT MAP (
        Rd_Clk              => SCLK,
        Rd_En               => mem_adcb_wvalid,
        Rst                 => FIFO_ADCBM_RST,
        Wr_Clk              => ADC_CLK,
        Wr_En               => FIFO_ADCBM_WREN,

        Din                 => ADCB_DATA,
        Prog_Empty_Thresh   => one_hundred_h_in_10_bits,
        Prog_Full_Thresh    => six_hundred_h_in_11_bits,

        Dout                => fifo_adcbm_dout,

        Almost_Empty        => OPEN,
        Almost_Full         => OPEN,
        Empty               => OPEN,
        Full                => OPEN,
        Prog_Empty          => fifo_adcbm_aef,
        Prog_Full           => OPEN
        );
 
    -- See Block Diagram, page 5
    mem_adcb_din    <= fifo_memw_dout
                        when (mem_adcb_wr = '1')
                        else fifo_adcbm_dout;

    -- See Block Diagram, page 3
    MEM1_ADDR : PROCESS (SCLK)
    BEGIN
        if (rising_edge (SCLK)) then
            if (mem_adcb_run = '0') then
                mem_adcb_addr   <= ("00" & MEM1_START_REG_H
                                                (14 downto 0) &
                                            MEM1_START_REG_L
                                                (15 downto 3) &
                                                        "000");
            elsif (mem_adcb_busy = '0' AND (mem_adcb_rreq = '1'
                                    OR mem_adcb_wreq = '1')) then
                if (mem_adcb_addr + 8) = ("00" & MEM1_DEPTH_REG_H
                                                (14 downto 0) &
                                                MEM1_DEPTH_REG_L
                                                (15 downto 3) &
                                                    "000") then
                    mem_adcb_addr   <= ("00" & MEM1_START_REG_H
                                                (14 downto 0) &
                                                MEM1_START_REG_L
                                                (15 downto 3) &
                                                        "000");
                else
                    mem_adcb_addr   <= mem_adcb_addr + 8;
                end if;
            end if;

            if (mem_adcb_run = '0') then
                trig_adcb_reached   <= '0';
                trig_adcb_addr      <= ("00" & MEM1_START_REG_H
                                                (14 downto 0) &
                                                MEM1_START_REG_L
                                                (15 downto 3) &
                                                        "000");
            elsif (mem_adcb_rd = '0' AND mem_adcb_wr = '0' AND
                        mem_adcb_wvalid = '1' AND
                                    trig_adcb_reached = '0') then
                if (fifo_adcbm_dout(32) = '1' OR
                                fifo_adcbm_dout(48) = '1') then
                    trig_adcb_reached   <= '1';
                    trig_adcb_addr      <= trig_adcb_addr;
                elsif (fifo_adcbm_dout(0) = '1' OR
                                fifo_adcbm_dout(16) = '1') then
                    trig_adcb_reached   <= '1';
                    trig_adcb_addr      <= trig_adcb_addr + 1;
                elsif (trig_adcb_addr + 2) = 
                            (MEM1_DEPTH_REG_H(14 downto 0) &
                                MEM1_DEPTH_REG_L(15 downto 3) &
                                                    "000") then
                    trig_adcb_addr  <= ("00" & MEM1_START_REG_H
                                                (14 downto 0) &
                                                MEM1_START_REG_L
                                                (15 downto 3) &
                                                        "000");
                else
                    trig_adcb_addr      <= trig_adcb_addr + 2;
                end if;
            end if;
        end if;
    END PROCESS;

    -- See Block Diagram, page 1
    mem_adcb_rreq   <= ((NOT fifo_memr_aff) AND mem_adcb_rd)
                                                AND mem_adcb_run;
    mem_adcb_wreq   <= (((NOT fifo_memw_aef) AND mem_adcb_wr) OR
                                ((NOT fifo_adcbm_aef) AND
                                        (NOT (mem_adcb_rd OR
                                            mem_adcb_wr)))) AND
                                                    mem_adcb_run;

    -------------------------------------------------------------
    -- ********* Instantiate SDRAM Bank 1 Controller ********* --
    -------------------------------------------------------------
    -- See Block Diagram, page 5
    SDRAM_DDR2_LB_1 : SDRAM_DDR2_LB
    PORT MAP (
        -- Clocks and Reset
        Cal_Clk             => CAL_CLK,
        Clk                 => SCLK,
        Reset_n             => INT_RESET_N,
        Wr_D_Clk            => WCLK,

        -- Configuration Inputs
        Cfg_Auto_Ref_en     => hi,
        Cfg_BankBits        => hi,
        Cfg_Bt              => lo,
        Cfg_Diff_Dqs        => lo,
        Cfg_Dll_Disable     => lo,
        Cfg_Ds              => lo,
        Cfg_Lookahead_Act   => lo,
        Cfg_Lookahead_Pch   => lo,
        Cfg_Pch_Power_Down  => lo,
        Cfg_Qoff            => lo,
        Cfg_Rdqs            => lo,
        Cfg_RegDimm         => lo,
        Cfg_Two_T           => lo,
        Cfg_Two_T_Sel_Cycle => lo,
        Ctrlr_Init          => lo,
        IDelayCtrl_Rdy      => IDELAYCTRL_RDY,

        Cfg_Al              => two_in_3_bits,
        Cfg_Bl              => two_in_2_bits,
        Cfg_Cl              => four_in_3_bits,
        Cfg_ColBits         => five_in_3_bits,
        Cfg_Emr2            => zero_in_16_bits,
        Cfg_Emr3            => zero_in_16_bits,
        Cfg_Faw             => eighteen_in_5_bits,
        Cfg_Map_Rd_Vld0     => three_in_18_bits,
        Cfg_Map_Rd_Vld1     => twelve_in_18_bits,
        Cfg_Map_Rd_Vld2     => zero_in_18_bits,
        Cfg_Map_Rd_Vld3     => zero_in_18_bits,
        Cfg_Mrd             => two_in_3_bits,
        Cfg_Odt_Rd_Map_Cs0  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs1  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs2  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs3  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs4  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs5  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs6  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs7  => zero_in_8_bits,
        Cfg_Odt_Wr_Map_Cs0  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs1  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs2  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs3  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs4  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs5  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs6  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs7  => two_fifty_five_in_8_bits,
        Cfg_Ras             => nine_in_5_bits,
        Cfg_Rc              => thirteen_in_5_bits,
        Cfg_Rcd             => four_in_3_bits,
        Cfg_Read_to_Read    => three_in_3_bits,
        Cfg_Read_to_Write   => one_in_2_bits,
        Cfg_Ref_Per         => four_hundred_h_in_16_bits,
        Cfg_Rfc             => thirty_three_h_in_8_bits,
        Cfg_Rowbits         => two_in_3_bits,
        Cfg_Rp              => four_in_3_bits,
        Cfg_Rrd             => two_in_3_bits,
        Cfg_Rtp             => two_in_2_bits,
        Cfg_Rtt             => one_in_2_bits,
        Cfg_Startup_Delay   => c_thousand_h_in_17_bits,
        Cfg_Wr              => three_in_3_bits,
        Cfg_Write_to_Write  => three_in_3_bits,
        Cfg_Wtr             => two_in_2_bits,
        Cfg_Xsnr            => thirty_seven_h_in_8_bits,

        -- Local Interface
        L_Auto_Pch          => lo,
        L_R_Req             => mem_adcb_rreq,
        L_Ref_Req           => lo,
        L_W_Req             => mem_adcb_wreq,

        L_Addr              => mem_adcb_addr,
        L_B_Size            => four_in_4_bits,
        L_Datain            => mem_adcb_din,
        L_Dm_in             => zero_in_8_bits,
        L_Power_Down        => zero_in_8_bits,
        L_Self_Refresh      => zero_in_8_bits,

        L_Dataout           => mem_adcb_dout,

        L_Busy              => mem_adcb_busy,
        L_D_Req             => OPEN,
        L_R_Valid           => mem_adcb_rvalid,
        L_Ref_Ack           => OPEN,
        L_W_Valid           => mem_adcb_wvalid,

        -- External Connections to SDRAM
        Sd_Dq_in            => DDR1_DQ_IN,
        Sd_Dqs_in           => DDR1_DQS_IN,

        -- Round-Trip Delay Calibration Loop
        Sd_Rd_Vld_in        => ddr1_fbin_valid,
        Sd_Rd_Vld_out       => ddr1_fbout_valid,

        Sd_A                => DDR1_ADDRESS,
        Sd_Ba               => DDR1_BA,
        Sd_Cke              => DDR1_CKE,
        Sd_Cs_n             => DDR1_CS_N,
        Sd_Dm               => DDR1_DM,
        Sd_Dq_Oe_n          => DDR1_DQ_OE_N,
        Sd_Dq_out           => DDR1_DQ_OUT,
        Sd_Dqs_Oe_n         => DDR1_DQS_OE_N,
        Sd_Dqs_out          => DDR1_DQS_OUT,
        Sd_Odt              => ddr1_vodt,

        Sd_Cas_n            => DDR1_CASB,
        Sd_Ras_n            => DDR1_RASB,
        Sd_We_n             => DDR1_WEB
        );

    DDR1_ODT            <= ddr1_vodt(0);

    DDR1_FB0OUT         <= ddr1_fbout_valid(0);
    DDR1_FB1OUT         <= ddr1_fbout_valid(1);
    ddr1_fbin_valid(0)  <= DDR1_FB0IN;
    ddr1_fbin_valid(1)  <= DDR1_FB1IN;

    -------------------------------------------------------------
    -- ************** Instantiate  FIFO for DAC ************** --
    -------------------------------------------------------------

    -- See Block Diagram, page 6
    DACM_FIFO : fifo_d1k_w64_r32
    PORT MAP (
        Rd_Clk              => DAC_CLK,
        Rd_En               => FIFO_DACM_RDEN,
        Rst                 => FIFO_DACM_RST,
        Wr_Clk              => SCLK,
        Wr_En               => mem_dac_rvalid,

        Din                 => mem_dac_dout,
        Prog_Empty_Thresh   => two_hundred_h_in_11_bits,
        Prog_Full_Thresh    => three_hundred_h_in_10_bits,

        Dout                => FIFO_DACM_DOUT,

        Almost_Empty        => OPEN,
        Almost_Full         => OPEN,
        Empty               => OPEN,
        Full                => OPEN,
        Prog_Empty          => OPEN,
        Prog_Full           => fifo_dacm_af
        );

    -------------------------------------------------------------
    -- ********* Instantiate SDRAM Bank 2 Controller ********* --
    -------------------------------------------------------------

    SDRAM_DDR2_LB_2 : SDRAM_DDR2_LB
    PORT MAP (
        -- Clocks and Reset
        Cal_Clk             => CAL_CLK,
        Clk                 => SCLK,
        Reset_n             => INT_RESET_N,
        Wr_D_Clk            => WCLK,

        -- Configuration Inputs
        Cfg_Auto_Ref_en     => hi,
        Cfg_BankBits        => hi,
        Cfg_Bt              => lo,
        Cfg_Diff_Dqs        => lo,
        Cfg_Dll_Disable     => lo,
        Cfg_Ds              => lo,
        Cfg_Lookahead_Act   => lo,
        Cfg_Lookahead_Pch   => lo,
        Cfg_Pch_Power_Down  => lo,
        Cfg_Qoff            => lo,
        Cfg_Rdqs            => lo,
        Cfg_RegDimm         => lo,
        Cfg_Two_T           => lo,
        Cfg_Two_T_Sel_Cycle => lo,
        Ctrlr_Init          => lo,
        IDelayCtrl_Rdy      => IDELAYCTRL_RDY,

        Cfg_Al              => two_in_3_bits,
        Cfg_Bl              => two_in_2_bits,
        Cfg_Cl              => four_in_3_bits,
        Cfg_ColBits         => five_in_3_bits,
        Cfg_Emr2            => zero_in_16_bits,
        Cfg_Emr3            => zero_in_16_bits,
        Cfg_Faw             => eighteen_in_5_bits,
        Cfg_Map_Rd_Vld0     => seven_in_18_bits,
        Cfg_Map_Rd_Vld1     => eight_in_18_bits,
        Cfg_Map_Rd_Vld2     => zero_in_18_bits,
        Cfg_Map_Rd_Vld3     => zero_in_18_bits,
        Cfg_Mrd             => two_in_3_bits,
        Cfg_Odt_Rd_Map_Cs0  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs1  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs2  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs3  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs4  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs5  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs6  => zero_in_8_bits,
        Cfg_Odt_Rd_Map_Cs7  => zero_in_8_bits,
        Cfg_Odt_Wr_Map_Cs0  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs1  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs2  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs3  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs4  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs5  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs6  => two_fifty_five_in_8_bits,
        Cfg_Odt_Wr_Map_Cs7  => two_fifty_five_in_8_bits,
        Cfg_Ras             => nine_in_5_bits,
        Cfg_Rc              => thirteen_in_5_bits,
        Cfg_Rcd             => four_in_3_bits,
        Cfg_Read_to_Read    => three_in_3_bits,
        Cfg_Read_to_Write   => one_in_2_bits,
        Cfg_Ref_Per         => four_hundred_h_in_16_bits,
        Cfg_Rfc             => thirty_three_h_in_8_bits,
        Cfg_Rowbits         => two_in_3_bits,
        Cfg_Rp              => four_in_3_bits,
        Cfg_Rrd             => two_in_3_bits,
        Cfg_Rtp             => two_in_2_bits,
        Cfg_Rtt             => one_in_2_bits,
        Cfg_Startup_Delay   => c_thousand_h_in_17_bits,
        Cfg_Wr              => three_in_3_bits,
        Cfg_Write_to_Write  => three_in_3_bits,
        Cfg_Wtr             => two_in_2_bits,
        Cfg_Xsnr            => thirty_seven_h_in_8_bits,

        -- Local Interface
        L_Auto_Pch          => lo,
        L_R_Req             => mem_dac_rreq,
        L_Ref_Req           => lo,
        L_W_Req             => mem_dac_wreq,

        L_Addr              => mem_dac_addr,
        L_B_Size            => four_in_4_bits,
        L_Datain            => fifo_memw_dout,
        L_Dm_in             => zero_in_8_bits,
        L_Power_Down        => zero_in_8_bits,
        L_Self_Refresh      => zero_in_8_bits,

        L_Dataout           => mem_dac_dout,

        L_Busy              => mem_dac_busy,
        L_D_Req             => OPEN,
        L_R_Valid           => mem_dac_rvalid,
        L_Ref_Ack           => OPEN,
        L_W_Valid           => mem_dac_wvalid,

        -- External connections to SDRAM
        Sd_Dq_in            => DDR2_DQ_IN,
        Sd_Dqs_in           => DDR2_DQS_IN,

        -- Round-Trip Delay Calibration Loop
        Sd_Rd_Vld_in        => ddr2_fbin_valid,
        Sd_Rd_Vld_out       => ddr2_fbout_valid,

        Sd_A                => DDR2_ADDRESS,
        Sd_Ba               => DDR2_BA,
        Sd_Cke              => DDR2_CKE,
        Sd_Cs_n             => DDR2_CS_N,
        Sd_Dm               => DDR2_DM,
        Sd_Dq_Oe_n          => DDR2_DQ_OE_N,
        Sd_Dq_out           => DDR2_DQ_OUT,
        Sd_Dqs_Oe_n         => DDR2_DQS_OE_N,
        Sd_Dqs_out          => DDR2_DQS_OUT,
        Sd_Odt              => ddr2_vodt,

        Sd_Cas_n            => DDR2_CASB,
        Sd_Ras_n            => DDR2_RASB,
        Sd_We_n             => DDR2_WEB
        );

    DDR2_ODT            <= ddr2_vodt(0);

    DDR2_FB0OUT         <= ddr2_fbout_valid(0);
    DDR2_FB1OUT         <= ddr2_fbout_valid(1);
    ddr2_fbin_valid(0)  <= DDR2_FB0IN;
    ddr2_fbin_valid(1)  <= DDR2_FB1IN;

    MEM2_ADDR : PROCESS (SCLK)
    BEGIN
        if (rising_edge (SCLK)) then
            if (mem_dac_run = '0') then
                mem_dac_addr    <= ("00" &  MEM2_START_REG_H
                                                (14 downto 0) &
                                            MEM2_START_REG_L
                                                (15 downto 3) &
                                                        "000");
            elsif ((mem_dac_rreq = '1' OR mem_dac_wreq = '1') AND
                                    (mem_dac_busy = '0')) then
                if (mem_dac_addr + 8) = ("00" & MEM2_DEPTH_REG_H
                                                (14 downto 0) &
                                                MEM2_DEPTH_REG_L
                                                (15 downto 3) &
                                                    "000") then
                     mem_dac_addr    <= ("00" & MEM2_START_REG_H
                                                (14 downto 0) &
                                                MEM2_START_REG_L
                                                (15 downto 3) &
                                                        "000");
                else
                    mem_dac_addr    <= mem_dac_addr + 8;
                end if;
            end if;
        end if;
    END PROCESS;

    mem_dac_rreq    <= (((NOT fifo_memr_aff) AND mem_dac_rd) OR
                            ((NOT fifo_dacm_af) AND
                                (NOT (mem_dac_rd OR
                                        mem_dac_wr)))) AND
                                                    mem_dac_run;

    mem_dac_wreq    <= (NOT fifo_memw_aef) AND mem_dac_wr AND
                                                     mem_dac_run;

END STRUCTURE;