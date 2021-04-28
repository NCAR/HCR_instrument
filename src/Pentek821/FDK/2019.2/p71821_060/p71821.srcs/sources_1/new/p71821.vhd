----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 02/25/2015 11:34:34 AM
-- Design Name: 
-- Module Name: p71821 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.00 - First Release
-- Revision 2.00 - Upgrade to Vivado 2019.1
-- Revision 3 - 8/20/20 Fixed ADC Ch.0 short packet issue, upgraded to Vivado 2019.2
--
--
-- Additional Comments:
-- 
-- At this time Vivado does not carry up from lower levels in hierarchy the
-- DIFF_TERM_ADV setting on differential inputs.  Therefore they must be set
-- correctly in the top level XDC.

----------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity p71821 is
generic (
   rev      : integer                        := 3;  -- Revision 0 to 255
   rev_date : std_logic_vector( 23 downto 0 ):= x"082020"; -- Revision Date MM/DD/YY 5/29/15 = x"052915" 
   fpga_size: std_logic_vector(11 downto 0)  := x"060" -- FPGA Size  - x"025", x"035", x"040", x"060" , x"085", x"095", x"115"
);
port (
   ----------------------------------------------------------------------------
   -- Front Panel SYNC BUS Signals
   ----------------------------------------------------------------------------
   -- LVDS Sync Bus Signals
   GATEA_IN_P        : in   std_logic;
   GATEA_IN_N        : in   std_logic;
   SYNCA_PPS_IN_P    : in   std_logic;
   SYNCA_PPS_IN_N    : in   std_logic;
   GATEB_IN_P        : in   std_logic;
   GATEB_IN_N        : in   std_logic;
   SYNCB_PPS_IN_P    : in   std_logic;
   SYNCB_PPS_IN_N    : in   std_logic;
   GATEA_OUT_P       : out  std_logic;
   GATEA_OUT_N       : out  std_logic;
   SYNCA_PPS_OUT_P   : out  std_logic;
   SYNCA_PPS_OUT_N   : out  std_logic;
   GATEB_OUT_P       : out  std_logic;
   GATEB_OUT_N       : out  std_logic;
   SYNCB_PPS_OUT_P   : out  std_logic;
   SYNCB_PPS_OUT_N   : out  std_logic;
   -- LVTTL Sync Bus Signals
   GATE_TRIG_TTL_IN  : in   std_logic;
   SSMC_GATE_TTL_IN  : in   std_logic;
   SYNC_PPS_TTL_IN   : in   std_logic;
   -- Clock and Front Panel SYNC Bus Control Signals
   SBUS_A_MASTER_N   : out  std_logic;
   SBUS_B_MASTER_N   : out  std_logic;
   CLK_MASTER_N      : out  std_logic;
   VCXO_EN           : out  std_logic;
   VCXO_SEL_N        : out  std_logic;
   CLK_MUX_SEL       : out  std_logic_vector(1 downto 0);
   ----------------------------------------------------------------------------
   ----------------------------------------------------------------------------
   -- Front Panel I/O Board
   ----------------------------------------------------------------------------
   ----------------------------------------------------------------------------
   -- ADS5485 ADC Channel 0
   ----------------------------------------------------------------------------
   -- Data from ADS5485 Channel 0
   ADC0_D0_1_N      : in std_logic;
   ADC0_D0_1_P      : in std_logic;
   ADC0_D2_3_N      : in std_logic;
   ADC0_D2_3_P      : in std_logic;
   ADC0_D4_5_N      : in std_logic;
   ADC0_D4_5_P      : in std_logic;
   ADC0_D6_7_N      : in std_logic;
   ADC0_D6_7_P      : in std_logic;
   ADC0_D8_9_N      : in std_logic;
   ADC0_D8_9_P      : in std_logic;
   ADC0_D10_11_N    : in std_logic;
   ADC0_D10_11_P    : in std_logic;
   ADC0_D12_13_N    : in std_logic;
   ADC0_D12_13_P    : in std_logic;
   ADC0_D14_15_N    : in std_logic;
   ADC0_D14_15_P    : in std_logic;
   -- Control Signals
   ADC_DITHER       : out std_logic; --Dither Enable (Controls all ADCs)
   ADC0_PDWNF       : out std_logic;
   ADC0_OVLD_LED_N  : out std_logic;
   ----------------------------------------------------------------------------
   -- ADS5485 ADC Channel 1
   ----------------------------------------------------------------------------
   -- Data from ADS5485 Channel 1
   ADC1_D0_1_N      : in std_logic;
   ADC1_D0_1_P      : in std_logic;
   ADC1_D2_3_N      : in std_logic;
   ADC1_D2_3_P      : in std_logic;
   ADC1_D4_5_N      : in std_logic;
   ADC1_D4_5_P      : in std_logic;
   ADC1_D6_7_N      : in std_logic;
   ADC1_D6_7_P      : in std_logic;
   ADC1_D8_9_N      : in std_logic;
   ADC1_D8_9_P      : in std_logic;
   ADC1_D10_11_N    : in std_logic;
   ADC1_D10_11_P    : in std_logic;
   ADC1_D12_13_N    : in std_logic;
   ADC1_D12_13_P    : in std_logic;
   ADC1_D14_15_N    : in std_logic;
   ADC1_D14_15_P    : in std_logic;
   -- Control Signals
   ADC1_PDWNF       : out std_logic;
   ADC1_OVLD_LED_N  : out std_logic;
   ----------------------------------------------------------------------------
   -- ADS5485 ADC Channel 2
   ----------------------------------------------------------------------------
   -- Data from ADS5485 Channel 2
   ADC2_D0_1_N      : in std_logic;
   ADC2_D0_1_P      : in std_logic;
   ADC2_D2_3_N      : in std_logic;
   ADC2_D2_3_P      : in std_logic;
   ADC2_D4_5_N      : in std_logic;
   ADC2_D4_5_P      : in std_logic;
   ADC2_D6_7_N      : in std_logic;
   ADC2_D6_7_P      : in std_logic;
   ADC2_D8_9_N      : in std_logic;
   ADC2_D8_9_P      : in std_logic;
   ADC2_D10_11_N    : in std_logic;
   ADC2_D10_11_P    : in std_logic;
   ADC2_D12_13_N    : in std_logic;
   ADC2_D12_13_P    : in std_logic;
   ADC2_D14_15_N    : in std_logic;
   ADC2_D14_15_P    : in std_logic;
   -- Control Signals
   ADC2_PDWNF       : out std_logic;
   ADC2_OVLD_LED_N  : out std_logic;
   ----------------------------------------------------------------------------
   -- DAC5688 Dual DAC
   ----------------------------------------------------------------------------
   -- Data to the DAC5688
   DAC_DA           : out std_logic_vector(15 downto 0); -- DAC Data A
   DAC_DB           : out std_logic_vector(15 downto 0); -- DAC Data B
   -- DAC SPI Control Bus
   DAC_SCLK         : out std_logic; -- SPI Bus Clock to the DAC
   DAC_SDI          : out std_logic; -- SPI Bus Data to the DAC
   DAC_SDO          : in  std_logic; -- SPI Bus Data from the DAC
   DAC_SDENB        : out std_logic; -- SPI Bus Data to the DAC
   -- DAC Control/Status Signals
   DAC_LOCK         : in  std_logic; -- PLL Lock Status from the DAC
   DAC_TX_EN        : out std_logic; -- transmit enable
   DAC_SYNC         : out std_logic; -- DAC Sync
   DAC_RESET_N      : out std_logic; -- Reset to the DAC
   DAC_ERR_LED_N    : out std_logic; -- DAC Under Run Error LED
   --------------------------------------------------------------------------
   -- Clocks from Front Panel I/O Board
   --------------------------------------------------------------------------
   --ADC0_CLKO_P       : in std_logic; -- ADC_CLKO + from ADC0
   --ADC0_CLKO_N       : in std_logic; -- ADC_CLKO -
   --ADC1_CLKO_P       : in std_logic; -- ADC_CLKO + from ADC1
   --ADC1_CLKO_N       : in std_logic; -- ADC_CLKO -
   --ADC2_CLKO_P       : in std_logic; -- ADC_CLKO + from ADC2
   --ADC2_CLKO_N       : in std_logic; -- ADC_CLKO -
   DAC_CLKO_P        : in std_logic; -- DAC_CLKO + from DAC
   DAC_CLKO_N        : in std_logic; -- DAC_CLKO -  
   ------------------------------------------------------------------------------
   -- Front Panel I/O Type (for 7176x this equals "0110")
   ------------------------------------------------------------------------------
   FPIO_TYPE         : in  std_logic_vector(3 downto 0);
   ----------------------------------------------------------------------------
   -- Front Panel LEDs
   ----------------------------------------------------------------------------
   CLK_DET_LED_N     : out std_logic; -- Clock Detect LED
   PPS_DET_LED_N     : out std_logic; -- PPS signal LED 
   MASTER_LED_N      : out std_logic; -- Sync Bus Master LED
   USER_LED_N        : out std_logic; -- Spare User defined LED
   ----------------------------------------------------------------------------
   -- Global Clock ins from CDC
   ----------------------------------------------------------------------------
   CLKA_GLBL_P       : in   std_logic; 
   CLKA_GLBL_N       : in   std_logic;
   --CLKB_GLBL_P       : in   std_logic;
   --CLKB_GLBL_N       : in   std_logic;

   -- REFERNCE Clock
   REF_CLK_P         : in  std_logic; -- 200MHz IDELAY Control Reference Clock
   REF_CLK_N         : in  std_logic;

   ----------------------------------------------------------------------------
   -- P15 and P16 PCIe Interface and Aux. Gigabit Interfaces
   ----------------------------------------------------------------------------
   -- PCie Ref Clock 225 Frequency = 250 MHz from P15 (freq. translated) or 
   -- 250 MHz from on-board oscillator.
   PCIE_MGTREFCLK_P  : in  std_logic;  -- Main REF Clock for Primary XMC P15
   PCIE_MGTREFCLK_N  : in  std_logic;  -- Main REF Clock for Primary XMC P15
   -- P15 PCIe Interface
   PERST0_N          : in  std_logic;  -- PCIe Reset in
   PERST1_N          : in  std_logic;  -- PCIe Reset in   
   PER0P0            : in  std_logic;  -- Lane 0 Rx
   PER0N0            : in  std_logic;  -- Lane 0 Rx
   PER0P1            : in  std_logic;  -- Lane 1 Rx
   PER0N1            : in  std_logic;  -- Lane 1 Rx
   PER0P2            : in  std_logic;  -- Lane 2 Rx
   PER0N2            : in  std_logic;  -- Lane 2 Rx
   PER0P3            : in  std_logic;  -- Lane 3 Rx
   PER0N3            : in  std_logic;  -- Lane 3 Rx
   PER0P4            : in  std_logic;  -- Lane 4 Rx
   PER0N4            : in  std_logic;  -- Lane 4 Rx
   PER0P5            : in  std_logic;  -- Lane 5 Rx
   PER0N5            : in  std_logic;  -- Lane 5 Rx
   PER0P6            : in  std_logic;  -- Lane 6 Rx
   PER0N6            : in  std_logic;  -- Lane 6 Rx
   PER0P7            : in  std_logic;  -- Lane 7 Rx
   PER0N7            : in  std_logic;  -- Lane 7 Rx
   PET0P0            : out std_logic;  -- Lane 0 Tx
   PET0N0            : out std_logic;  -- Lane 0 Tx
   PET0P1            : out std_logic;  -- Lane 1 Tx
   PET0N1            : out std_logic;  -- Lane 1 Tx
   PET0P2            : out std_logic;  -- Lane 2 Tx
   PET0N2            : out std_logic;  -- Lane 2 Tx
   PET0P3            : out std_logic;  -- Lane 3 Tx
   PET0N3            : out std_logic;  -- Lane 3 Tx
   PET0P4            : out std_logic;  -- Lane 4 Tx
   PET0N4            : out std_logic;  -- Lane 4 Tx
   PET0P5            : out std_logic;  -- Lane 5 Tx
   PET0N5            : out std_logic;  -- Lane 5 Tx
   PET0P6            : out std_logic;  -- Lane 6 Tx
   PET0N6            : out std_logic;  -- Lane 6 Tx
   PET0P7            : out std_logic;  -- Lane 7 Tx
   PET0N7            : out std_logic;  -- Lane 7 Tx
   -- PCIe Status LEDs
   KU_LINKUP_N       : out std_logic;  -- PCIe Link Up Status LED
   KU_LANES_N0       : out std_logic;  -- # Linked Lanes Indicator LED0
   KU_LANES_N1       : out std_logic;  -- # Linked Lanes Indicator LED1
   P16_LINKUP_N      : out std_logic;  -- P16 Link Up Status LED
   -- Secondary P16 Giga Bit Interface
--   MGTREFCLK0P_126   : in  std_logic;  -- REF Clock for Secondary XMC P16
--   MGTREFCLK0N_126   : in  std_logic;  -- REF Clock for Secondary XMC P16
--   S2RD_P0           : in  std_logic;  -- Lane 0 Rx
--   S2RD_N0           : in  std_logic;  -- Lane 0 Rx
--   S2RD_P1           : in  std_logic;  -- Lane 1 Rx
--   S2RD_N1           : in  std_logic;  -- Lane 1 Rx
--   S2RD_P2           : in  std_logic;  -- Lane 2 Rx
--   S2RD_N2           : in  std_logic;  -- Lane 2 Rx
--   S2RD_P3           : in  std_logic;  -- Lane 3 Rx
--   S2RD_N3           : in  std_logic;  -- Lane 3 Rx
--   S2TD_P0           : out std_logic;  -- Lane 0 Tx
--   S2TD_N0           : out std_logic;  -- Lane 0 Tx
--   S2TD_P1           : out std_logic;  -- Lane 1 Tx
--   S2TD_N1           : out std_logic;  -- Lane 1 Tx
--   S2TD_P2           : out std_logic;  -- Lane 2 Tx
--   S2TD_N2           : out std_logic;  -- Lane 2 Tx
--   S2TD_P3           : out std_logic;  -- Lane 3 Tx
--   S2TD_N3           : out std_logic;  -- Lane 3 Tx
--   S3RD_P0           : in  std_logic;  -- Lane 0 Rx
--   S3RD_N0           : in  std_logic;  -- Lane 0 Rx
--   S3RD_P1           : in  std_logic;  -- Lane 1 Rx
--   S3RD_N1           : in  std_logic;  -- Lane 1 Rx
--   S3RD_P2           : in  std_logic;  -- Lane 2 Rx
--   S3RD_N2           : in  std_logic;  -- Lane 2 Rx
--   S3RD_P3           : in  std_logic;  -- Lane 3 Rx
--   S3RD_N3           : in  std_logic;  -- Lane 3 Rx
--   S3TD_P0           : out std_logic;  -- Lane 0 Tx
--   S3TD_N0           : out std_logic;  -- Lane 0 Tx
--   S3TD_P1           : out std_logic;  -- Lane 1 Tx
--   S3TD_N1           : out std_logic;  -- Lane 1 Tx
--   S3TD_P2           : out std_logic;  -- Lane 2 Tx
--   S3TD_N2           : out std_logic;  -- Lane 2 Tx
--   S3TD_P3           : out std_logic;  -- Lane 3 Tx
--   S3TD_N3           : out std_logic;  -- Lane 3 Tx
   ----------------------------------------------------------------------------
   -- P14 CONNECTOR
   ----------------------------------------------------------------------------
   -- LVDS I/O
   -- IN and OUT Directions are not fixed. Any P14 signal can be IN, OUT or
   -- Bi-directional.
   --******************************************************************
   --Uncomment these signals if your design will use the P14 interface 
   --******************************************************************
   P14GPIO_P            : inout std_logic_vector(23 downto 0);
   P14GPIO_N            : inout std_logic_vector(23 downto 0);
   ---------------------------------------------------------------------------
   -- DDR4
   ---------------------------------------------------------------------------
   C0_SYS_CLK_P      : in  std_logic;                  
   C0_SYS_CLK_N      : in  std_logic;                  
   C0_DDR4_ADR       : out std_logic_vector(16 downto 0);
   C0_DDR4_BA        : out std_logic_vector(1 downto 0);
   C0_DDR4_CKE       : out std_logic_vector(0 downto 0);
   C0_DDR4_CS_N      : out std_logic_vector(0 downto 0);
   C0_DDR4_DM_DBI_N  : inout std_logic_vector(9 downto 0);
   C0_DDR4_DQ        : inout std_logic_vector(79 downto 0);
   C0_DDR4_DQS_C     : inout std_logic_vector(9 downto 0);
   C0_DDR4_DQS_T     : inout std_logic_vector(9 downto 0);
   C0_DDR4_ODT       : out std_logic_vector(0 downto 0);
   C0_DDR4_BG        : out std_logic_vector(0 downto 0);
   C0_DDR4_RESET_N   : out std_logic;                 
   C0_DDR4_ACT_N     : out std_logic;                 
   C0_DDR4_CK_C      : out std_logic_vector(0 downto 0);
   C0_DDR4_CK_T      : out std_logic_vector(0 downto 0);
   ----------------------------------------------------------------------------
   -- CDC Control and Status
   ----------------------------------------------------------------------------
   CDC_STAT_VCXO     : in  std_logic;
   CDC_STAT_REF      : in  std_logic;
   CDC_STAT_LOCK     : in  std_logic;
   CDC_RST_OUT_N     : out std_logic;
   CDC_DAT           : out std_logic;
   CDC_CLK           : out std_logic;
   CDC_LE            : out std_logic;
   CDC_PD_N          : out std_logic; 
   
   CDC_SYNC_RST_IN_P : in  std_logic;
   CDC_SYNC_RST_IN_N : in  std_logic;
   CDC_SYNC_RST_OUT  : out std_logic; 
   ----------------------------------------------------------------------------
   -- Temperature Monitoring 
   ----------------------------------------------------------------------------
   SYS_MON_LED_N     : out std_logic;
   TEMP_IRQ_N        : in  std_logic;
   ----------------------------------------------------------------------------
   -- I2C Bus
   ----------------------------------------------------------------------------
   I2C_PORT0_SDA     : inout std_logic;
   I2C_PORT0_SCL     : inout std_logic;
   ----------------------------------------------------------------------------
   -- XMC SM Bus
   ----------------------------------------------------------------------------
   I2C_PORT1_MGA     : in    std_logic_vector(2 downto 0);
   I2C_PORT1_SDA     : inout std_logic;
   I2C_PORT1_SCL     : inout std_logic;
   ----------------------------------------------------------------------------
   -- Configuration FLASH
   ----------------------------------------------------------------------------
   CONFIG_A          : out std_logic_vector(25 downto 0);
   CONFIG_DQ         : inout std_logic_vector(15 downto 4); -- [3:0] are on dedicated pins
   ADV_N             : out std_logic;
   -- FCS_N is on a dedicated pin
   FWE_N             : out std_logic;
   FOE_N             : out std_logic;
   ----------------------------------------------------------------------------
   -- System Monitor in Voltages
   ----------------------------------------------------------------------------
   VAUX0_V_N         : in  std_logic;    
   VAUX0_V_P         : in  std_logic;    
   VAUX10_V_N        : in  std_logic;    
   VAUX10_V_P        : in  std_logic;    
   VAUX11_V_N        : in  std_logic;    
   VAUX11_V_P        : in  std_logic;    
   VAUX12_V_N        : in  std_logic;    
   VAUX12_V_P        : in  std_logic;    
   VAUX1_V_N         : in  std_logic;    
   VAUX1_V_P         : in  std_logic;    
   VAUX2_V_N         : in  std_logic;    
   VAUX2_V_P         : in  std_logic;    
   VAUX3_V_N         : in  std_logic;    
   VAUX3_V_P         : in  std_logic;    
   VAUX4_V_N         : in  std_logic;    
   VAUX4_V_P         : in  std_logic;    
   VAUX8_V_N         : in  std_logic;    
   VAUX8_V_P         : in  std_logic;    
   VAUX9_V_N         : in  std_logic;    
   VAUX9_V_P         : in  std_logic;    
   VP_VN_V_N         : in  std_logic;    
   VP_VN_V_P         : in  std_logic    
   
   --FPGA_GP_CLK       : in std_logic;
   
--   PLL_INTR_N        : in std_logic;
--   PLL_LOL_N         : in std_logic     
        
   );
end p71821;

--------------------------------------------------------------------------------

architecture Behavioral of p71821 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Front End Interfaces
-- Block Design
component dataio_intrfc_wrapper
  port (
    adc0_d0_1_n : in STD_LOGIC;
    adc0_d0_1_p : in STD_LOGIC;
    adc0_d10_11_n : in STD_LOGIC;
    adc0_d10_11_p : in STD_LOGIC;
    adc0_d12_13_n : in STD_LOGIC;
    adc0_d12_13_p : in STD_LOGIC;
    adc0_d14_15_n : in STD_LOGIC;
    adc0_d14_15_p : in STD_LOGIC;
    adc0_d2_3_n : in STD_LOGIC;
    adc0_d2_3_p : in STD_LOGIC;
    adc0_d4_5_n : in STD_LOGIC;
    adc0_d4_5_p : in STD_LOGIC;
    adc0_d6_7_n : in STD_LOGIC;
    adc0_d6_7_p : in STD_LOGIC;
    adc0_d8_9_n : in STD_LOGIC;
    adc0_d8_9_p : in STD_LOGIC;
    adc0_fifo_full_stat : in STD_LOGIC;
    adc0_ovld_led_n : out STD_LOGIC;
    adc0_pdwnf : out STD_LOGIC;
    adc1_d0_1_n : in STD_LOGIC;
    adc1_d0_1_p : in STD_LOGIC;
    adc1_d10_11_n : in STD_LOGIC;
    adc1_d10_11_p : in STD_LOGIC;
    adc1_d12_13_n : in STD_LOGIC;
    adc1_d12_13_p : in STD_LOGIC;
    adc1_d14_15_n : in STD_LOGIC;
    adc1_d14_15_p : in STD_LOGIC;
    adc1_d2_3_n : in STD_LOGIC;
    adc1_d2_3_p : in STD_LOGIC;
    adc1_d4_5_n : in STD_LOGIC;
    adc1_d4_5_p : in STD_LOGIC;
    adc1_d6_7_n : in STD_LOGIC;
    adc1_d6_7_p : in STD_LOGIC;
    adc1_d8_9_n : in STD_LOGIC;
    adc1_d8_9_p : in STD_LOGIC;
    adc1_fifo_full_stat : in STD_LOGIC;
    adc1_ovld_led_n : out STD_LOGIC;
    adc1_pdwnf : out STD_LOGIC;
    adc2_d0_1_n : in STD_LOGIC;
    adc2_d0_1_p : in STD_LOGIC;
    adc2_d10_11_n : in STD_LOGIC;
    adc2_d10_11_p : in STD_LOGIC;
    adc2_d12_13_n : in STD_LOGIC;
    adc2_d12_13_p : in STD_LOGIC;
    adc2_d14_15_n : in STD_LOGIC;
    adc2_d14_15_p : in STD_LOGIC;
    adc2_d2_3_n : in STD_LOGIC;
    adc2_d2_3_p : in STD_LOGIC;
    adc2_d4_5_n : in STD_LOGIC;
    adc2_d4_5_p : in STD_LOGIC;
    adc2_d6_7_n : in STD_LOGIC;
    adc2_d6_7_p : in STD_LOGIC;
    adc2_d8_9_n : in STD_LOGIC;
    adc2_d8_9_p : in STD_LOGIC;
    adc2_fifo_full_stat : in STD_LOGIC;
    adc2_ovld_led_n : out STD_LOGIC;
    adc2_pdwnf : out STD_LOGIC;
    adc_dither : out STD_LOGIC;
    cdc_cntl_cdc_clk : out STD_LOGIC;
    cdc_cntl_cdc_dat : out STD_LOGIC;
    cdc_cntl_cdc_le : out STD_LOGIC;
    cdc_cntl_cdc_rst_n : out STD_LOGIC;
    cdc_cntl_cdc_stat_lock : in STD_LOGIC;
    cdc_cntl_cdc_stat_ref : in STD_LOGIC;
    cdc_cntl_cdc_stat_vcxo : in STD_LOGIC;
    cdc_sync_rst_in_n : in STD_LOGIC;
    cdc_sync_rst_in_p : in STD_LOGIC;
    cdc_sync_rst_out : out STD_LOGIC;
    clk_det_led_n : out STD_LOGIC;
    clk_mux_sel : out STD_LOGIC_VECTOR ( 1 downto 0 );
    clka_glbl_clk_n : in STD_LOGIC;
    clka_glbl_clk_p : in STD_LOGIC;
    clka_master_n : out STD_LOGIC;
    clkb_glbl_clk_n : in STD_LOGIC;
    clkb_glbl_clk_p : in STD_LOGIC;
    clkb_master_n : out STD_LOGIC;
    dac_da : out STD_LOGIC_VECTOR ( 15 downto 0 );
    dac_db : out STD_LOGIC_VECTOR ( 15 downto 0 );
    dac_lock : in STD_LOGIC;
    dac_realtime_lost_stat : in STD_LOGIC;
    dac_realtimelost_led_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    dac_reset_n : out STD_LOGIC;
    dac_sclk : out STD_LOGIC;
    dac_sdenb : out STD_LOGIC;
    dac_sdi : out STD_LOGIC;
    dac_sdo : in STD_LOGIC;
    dac_sync : out STD_LOGIC;
    dac_tx_en : out STD_LOGIC;
    dataio_irq : out STD_LOGIC_VECTOR ( 0 to 0 );
    gate_trig_ttl_in : in STD_LOGIC;
    gatea_in_n : in STD_LOGIC;
    gatea_in_p : in STD_LOGIC;
    gatea_out_n : out STD_LOGIC;
    gateb_out_n : out STD_LOGIC;
    gatea_out_p : out STD_LOGIC;
    gateb_out_p : out STD_LOGIC;
    gateb_in_n : in STD_LOGIC;
    gateb_in_p : in STD_LOGIC;
    m_axis_adc_ch0_pdti_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_adc_ch0_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_adc_ch0_pdti_tvalid : out STD_LOGIC;
    m_axis_adc_ch1_pdti_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_adc_ch1_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_adc_ch1_pdti_tvalid : out STD_LOGIC;
    m_axis_adc_ch2_pdti_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_adc_ch2_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_adc_ch2_pdti_tvalid : out STD_LOGIC;
    m_axis_adc_pdti_aclk : out STD_LOGIC;
    m_axis_adc_pdti_aresetn : out STD_LOGIC;
    m_axis_dac_pctl_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_dac_pctl_tvalid : out STD_LOGIC;
    master_led_n : out STD_LOGIC;
    pps_det_led_n : out STD_LOGIC;
    refclk : in STD_LOGIC;
    s_axi_csr_aclk : in STD_LOGIC;
    s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    s_axi_csr_aresetn : in STD_LOGIC;
    s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_arready : out STD_LOGIC;
    s_axi_csr_arvalid : in STD_LOGIC;
    s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_awready : out STD_LOGIC;
    s_axi_csr_awvalid : in STD_LOGIC;
    s_axi_csr_bready : in STD_LOGIC;
    s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_bvalid : out STD_LOGIC;
    s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_rready : in STD_LOGIC;
    s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_rvalid : out STD_LOGIC;
    s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_wready : out STD_LOGIC;
    s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_csr_wvalid : in STD_LOGIC;
    s_axis_dac_pdti_aclk : out STD_LOGIC;
    s_axis_dac_pdti_aresetn : out STD_LOGIC;
    s_axis_dac_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_dac_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_dac_pdti_tvalid : in STD_LOGIC;
    sbusa_master_n : out STD_LOGIC;
    sbusb_master_n : out STD_LOGIC;
    sync_pps_ttl_in : in STD_LOGIC;
    synca_pps_in_n : in STD_LOGIC;
    synca_pps_in_p : in STD_LOGIC;
    synca_pps_out_n : out STD_LOGIC;
    syncb_pps_out_n : out STD_LOGIC;
    synca_pps_out_p : out STD_LOGIC;
    syncb_pps_out_p : out STD_LOGIC;
    syncb_pps_in_n : in STD_LOGIC;
    syncb_pps_in_p : in STD_LOGIC;
    timestamp_irq : out STD_LOGIC;
    vcxo_en : out STD_LOGIC;
    vcxo_sel_n : out STD_LOGIC
  );
end component dataio_intrfc_wrapper;

-- User Application Space #1 (Pre-DSP Block)
-- Block Design
component  user_block1_wrapper
 port (
   controller_PPS : out STD_LOGIC;
   filter_select_ch0 : in STD_LOGIC_VECTOR ( 1 downto 0 );
   filter_select_ch1 : in STD_LOGIC_VECTOR ( 1 downto 0 );
   filter_select_ch2 : in STD_LOGIC_VECTOR ( 1 downto 0 );
   mt_pulse : in STD_LOGIC_VECTOR ( 7 downto 0 );
   m_axis_adc_ch0_pdti_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
   m_axis_adc_ch0_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
   m_axis_adc_ch0_pdti_tvalid : out STD_LOGIC;
   m_axis_adc_ch1_pdti_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
   m_axis_adc_ch1_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
   m_axis_adc_ch1_pdti_tvalid : out STD_LOGIC;
   m_axis_adc_ch2_pdti_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
   m_axis_adc_ch2_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
   m_axis_adc_ch2_pdti_tvalid : out STD_LOGIC;
   m_axis_dac_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
   m_axis_dac_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
   m_axis_dac_pdti_tvalid : out STD_LOGIC;
   s_axi_csr_aclk : in STD_LOGIC;
   s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
   s_axi_csr_aresetn : in STD_LOGIC;
   s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
   s_axi_csr_arready : out STD_LOGIC;
   s_axi_csr_arvalid : in STD_LOGIC;
   s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
   s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
   s_axi_csr_awready : out STD_LOGIC;
   s_axi_csr_awvalid : in STD_LOGIC;
   s_axi_csr_bready : in STD_LOGIC;
   s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
   s_axi_csr_bvalid : out STD_LOGIC;
   s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
   s_axi_csr_rready : in STD_LOGIC;
   s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
   s_axi_csr_rvalid : out STD_LOGIC;
   s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
   s_axi_csr_wready : out STD_LOGIC;
   s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
   s_axi_csr_wvalid : in STD_LOGIC;
   s_axis_adc_ch0_pdti_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
   s_axis_adc_ch0_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
   s_axis_adc_ch0_pdti_tvalid : in STD_LOGIC;
   s_axis_adc_ch1_pdti_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
   s_axis_adc_ch1_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
   s_axis_adc_ch1_pdti_tvalid : in STD_LOGIC;
   s_axis_adc_ch2_pdti_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
   s_axis_adc_ch2_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
   s_axis_adc_ch2_pdti_tvalid : in STD_LOGIC;
   s_axis_adc_pdti_aclk : in STD_LOGIC;
   s_axis_dac_pdti_aclk : in STD_LOGIC;
   s_axis_dac_pdti_aresetn : in STD_LOGIC;
   s_axis_dac_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
   s_axis_dac_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
   s_axis_dac_pdti_tvalid : in STD_LOGIC;
   s_axis_adc_pdti_aresetn : in STD_LOGIC;
   user1_irq : out STD_LOGIC_VECTOR ( 1 downto 0 )
 );
end component user_block1_wrapper;

-- User Application Space #2 (Post-DSP Block)
-- Block Design
component user_block2_wrapper
  port (
  filter_select_ch0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
  filter_select_ch1 : out STD_LOGIC_VECTOR ( 1 downto 0 );
  filter_select_ch2 : out STD_LOGIC_VECTOR ( 1 downto 0 );
  control_flags : out STD_LOGIC_VECTOR ( 31 downto 0 );
  mt_pulse : out STD_LOGIC_VECTOR ( 7 downto 0 );
  controller_PPS : in STD_LOGIC;
  status_flags : in STD_LOGIC_VECTOR ( 15 downto 0 );
  ROT_A   : in std_logic;
  ROT_B   : in std_logic;
  TILT_A  : in std_logic;
  TILT_B  : in std_logic;
  AZ_MOSI : in std_logic;
  AZ_SCK  : in std_logic;
  AZ_SSEL : in std_logic;
  EL_MOSI : in std_logic;
  EL_SCK  : in std_logic;
  m_axis_adc_ch0_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axis_adc_ch0_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
  m_axis_adc_ch0_pdti_tvalid : out STD_LOGIC;
  m_axis_adc_ch1_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axis_adc_ch1_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
  m_axis_adc_ch1_pdti_tvalid : out STD_LOGIC;
  m_axis_adc_ch2_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axis_adc_ch2_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
  m_axis_adc_ch2_pdti_tvalid : out STD_LOGIC;
  m_axis_dac_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axis_dac_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
  m_axis_dac_pdti_tvalid : out STD_LOGIC;
  s_axi_csr_aclk : in STD_LOGIC;
  s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
  s_axi_csr_aresetn : in STD_LOGIC;
  s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
  s_axi_csr_arready : out STD_LOGIC;
  s_axi_csr_arvalid : in STD_LOGIC;
  s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
  s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
  s_axi_csr_awready : out STD_LOGIC;
  s_axi_csr_awvalid : in STD_LOGIC;
  s_axi_csr_bready : in STD_LOGIC;
  s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
  s_axi_csr_bvalid : out STD_LOGIC;
  s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axi_csr_rready : in STD_LOGIC;
  s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
  s_axi_csr_rvalid : out STD_LOGIC;
  s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axi_csr_wready : out STD_LOGIC;
  s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
  s_axi_csr_wvalid : in STD_LOGIC;
  s_axis_adc_ch0_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axis_adc_ch0_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_adc_ch0_pdti_tvalid : in STD_LOGIC;
  s_axis_adc_ch1_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axis_adc_ch1_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_adc_ch1_pdti_tvalid : in STD_LOGIC;
  s_axis_adc_ch2_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axis_adc_ch2_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_adc_ch2_pdti_tvalid : in STD_LOGIC;
  s_axis_adc_pdti_aclk : in STD_LOGIC;
  s_axis_adc_pdti_aresetn : in STD_LOGIC;
  s_axis_dac_pdti_aclk : in STD_LOGIC;
  s_axis_dac_pdti_aresetn : in STD_LOGIC;
  s_axis_dac_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axis_dac_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_dac_pdti_tvalid : in STD_LOGIC;
  user2_irq : out STD_LOGIC_VECTOR ( 1 downto 0 )
);
end component user_block2_wrapper;

-- Digital Signal Processing Block
component dsp1_wrapper
  port (
  dsp_irq : out STD_LOGIC_VECTOR ( 7 downto 0 );
  m_axis_adc_ch0_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axis_adc_ch0_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
  m_axis_adc_ch0_pdti_tvalid : out STD_LOGIC;
  m_axis_adc_ch1_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axis_adc_ch1_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
  m_axis_adc_ch1_pdti_tvalid : out STD_LOGIC;
  m_axis_adc_ch2_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axis_adc_ch2_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
  m_axis_adc_ch2_pdti_tvalid : out STD_LOGIC;
  m_axis_dac_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axis_dac_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
  m_axis_dac_pdti_tvalid : out STD_LOGIC;
  s_axi_csr_aclk : in STD_LOGIC;
  s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
  s_axi_csr_aresetn : in STD_LOGIC;
  s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
  s_axi_csr_arready : out STD_LOGIC;
  s_axi_csr_arvalid : in STD_LOGIC;
  s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
  s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
  s_axi_csr_awready : out STD_LOGIC;
  s_axi_csr_awvalid : in STD_LOGIC;
  s_axi_csr_bready : in STD_LOGIC;
  s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
  s_axi_csr_bvalid : out STD_LOGIC;
  s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axi_csr_rready : in STD_LOGIC;
  s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
  s_axi_csr_rvalid : out STD_LOGIC;
  s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axi_csr_wready : out STD_LOGIC;
  s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
  s_axi_csr_wvalid : in STD_LOGIC;
  s_axis_adc_ch0_pdti_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
  s_axis_adc_ch0_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_adc_ch0_pdti_tvalid : in STD_LOGIC;
  s_axis_adc_ch1_pdti_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
  s_axis_adc_ch1_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_adc_ch1_pdti_tvalid : in STD_LOGIC;
  s_axis_adc_ch2_pdti_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
  s_axis_adc_ch2_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_adc_ch2_pdti_tvalid : in STD_LOGIC;
  s_axis_adc_pdti_aclk : in STD_LOGIC;
  s_axis_adc_pdti_aresetn : in STD_LOGIC;
  s_axis_dac_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axis_dac_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_dac_pdti_tvalid : in STD_LOGIC;
  s_axis_dac_pdti_aclk : in STD_LOGIC;
  s_axis_dac_pdti_aresetn : in STD_LOGIC
);
end component dsp1_wrapper;

component data_acq_wrapper
  port (
  adc0_fifo_full_stat : out STD_LOGIC;
  adc1_fifo_full_stat : out STD_LOGIC;
  adc2_fifo_full_stat : out STD_LOGIC;
  ddr4_ui_clk : in STD_LOGIC;
  m_axis_dac_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axis_dac_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
  m_axis_dac_pdti_tvalid : out STD_LOGIC;
  m_axis_ddr_rqst_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
  m_axis_ddr_rqst_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
  m_axis_ddr_rqst_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axis_ddr_rqst_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axis_ddr_rqst_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
  m_axis_ddr_rqst_tvalid : out STD_LOGIC;
  m_axis_pcie_rq_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
  m_axis_pcie_rq_tkeep : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axis_pcie_rq_tlast : out STD_LOGIC;
  m_axis_pcie_rq_tready : in STD_LOGIC;
  m_axis_pcie_rq_tuser : out STD_LOGIC_VECTOR ( 59 downto 0 );
  m_axis_pcie_rq_tvalid : out STD_LOGIC;
  pcie_dma_irq : out STD_LOGIC_VECTOR ( 15 downto 0 );
  pdti2ppkt_irq : out STD_LOGIC_VECTOR ( 0 to 0 );
  realtime_lost_stat : out STD_LOGIC;
  rq_shutdown_ok : out STD_LOGIC;
  s_axi_csr_aclk : in STD_LOGIC;
  s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
  s_axi_csr_aresetn : in STD_LOGIC;
  s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
  s_axi_csr_arready : out STD_LOGIC;
  s_axi_csr_arvalid : in STD_LOGIC;
  s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
  s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
  s_axi_csr_awready : out STD_LOGIC;
  s_axi_csr_awvalid : in STD_LOGIC;
  s_axi_csr_bready : in STD_LOGIC;
  s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
  s_axi_csr_bvalid : out STD_LOGIC;
  s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axi_csr_rready : in STD_LOGIC;
  s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
  s_axi_csr_rvalid : out STD_LOGIC;
  s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axi_csr_wready : out STD_LOGIC;
  s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
  s_axi_csr_wvalid : in STD_LOGIC;
  s_axis_adc_ch0_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axis_adc_ch0_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_adc_ch0_pdti_tvalid : in STD_LOGIC;
  s_axis_adc_ch1_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axis_adc_ch1_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_adc_ch1_pdti_tvalid : in STD_LOGIC;
  s_axis_adc_ch2_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axis_adc_ch2_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_adc_ch2_pdti_tvalid : in STD_LOGIC;
  s_axis_adc_pdti_aclk : in STD_LOGIC;
  s_axis_adc_pdti_aresetn : in STD_LOGIC;
  s_axis_dac_pctl_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
  s_axis_dac_pctl_tvalid : in STD_LOGIC;
  s_axis_dac_pdti_aclk : in STD_LOGIC;
  s_axis_dac_pdti_aresetn : in STD_LOGIC;
  s_axis_wave_ddr_rsp_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
  s_axis_wave_ddr_rsp_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
  s_axis_wave_ddr_rsp_tlast : in STD_LOGIC;
  s_axis_wave_ddr_rsp_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
  s_axis_wave_ddr_rsp_tvalid : in STD_LOGIC;
  s_axis_dma_pcie_cntl_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
  s_axis_dma_pcie_cntl_tvalid : in STD_LOGIC;
  s_axis_pcie_rc_tdata : in STD_LOGIC_VECTOR ( 255 downto 0 );
  s_axis_pcie_rc_tkeep : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axis_pcie_rc_tlast : in STD_LOGIC;
  s_axis_pcie_rc_tready : out STD_LOGIC;
  s_axis_pcie_rc_tuser : in STD_LOGIC_VECTOR ( 74 downto 0 );
  s_axis_pcie_rc_tvalid : in STD_LOGIC;
  shutdown_rqst : in STD_LOGIC
);
end component data_acq_wrapper;

component pcie_intrfc_wrapper
  port (
  Vaux0_v_n : in STD_LOGIC;
  Vaux0_v_p : in STD_LOGIC;
  Vaux10_v_n : in STD_LOGIC;
  Vaux10_v_p : in STD_LOGIC;
  Vaux11_v_n : in STD_LOGIC;
  Vaux11_v_p : in STD_LOGIC;
  Vaux12_v_n : in STD_LOGIC;
  Vaux12_v_p : in STD_LOGIC;
  Vaux1_v_n : in STD_LOGIC;
  Vaux1_v_p : in STD_LOGIC;
  Vaux2_v_n : in STD_LOGIC;
  Vaux2_v_p : in STD_LOGIC;
  Vaux3_v_n : in STD_LOGIC;
  Vaux3_v_p : in STD_LOGIC;
  Vaux4_v_n : in STD_LOGIC;
  Vaux4_v_p : in STD_LOGIC;
  Vaux8_v_n : in STD_LOGIC;
  Vaux8_v_p : in STD_LOGIC;
  Vaux9_v_n : in STD_LOGIC;
  Vaux9_v_p : in STD_LOGIC;
  Vp_Vn_v_n : in STD_LOGIC;
  Vp_Vn_v_p : in STD_LOGIC;
  dataio_irq : in STD_LOGIC_VECTOR ( 0 to 0 );
  dataiopkt_irq : in STD_LOGIC_VECTOR ( 0 to 0 );
  dma_irq : in STD_LOGIC_VECTOR ( 15 downto 0 );
  dsp_irq : in STD_LOGIC_VECTOR ( 7 downto 0 );
  flash_a : out STD_LOGIC_VECTOR ( 25 downto 0 );
  flash_adv_b : out STD_LOGIC;
  flash_d_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
  flash_d_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
  flash_d_t : out STD_LOGIC_VECTOR ( 15 downto 0 );
  flash_fcs_b : out STD_LOGIC;
  flash_foe_b : out STD_LOGIC;
  flash_fwe_b : out STD_LOGIC;
  fpga_size : in STD_LOGIC_VECTOR ( 11 downto 0 );
  fpio_type : in STD_LOGIC_VECTOR ( 3 downto 0 );
  iic_port0_scl_io : inout STD_LOGIC;
  iic_port0_sda_io : inout STD_LOGIC;
  iic_port1_scl_io : inout STD_LOGIC;
  iic_port1_sda_io : inout STD_LOGIC;
  m_axi_acq_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_acq_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_acq_csr_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_acq_csr_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_acq_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_acq_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_acq_csr_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_acq_csr_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_acq_csr_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_acq_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_acq_csr_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_acq_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_acq_csr_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_acq_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_acq_csr_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_acq_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_acq_csr_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_acq_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
  m_axi_acq_csr_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_csr_aclk : out STD_LOGIC;
  m_axi_csr_aresetn : out STD_LOGIC;
  m_axi_dataio_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_dataio_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_dataio_csr_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dataio_csr_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dataio_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_dataio_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_dataio_csr_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dataio_csr_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dataio_csr_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dataio_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_dataio_csr_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dataio_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_dataio_csr_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dataio_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_dataio_csr_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dataio_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_dataio_csr_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dataio_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
  m_axi_dataio_csr_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_ddr4_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_ddr4_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_ddr4_csr_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_ddr4_csr_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_ddr4_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_ddr4_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_ddr4_csr_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_ddr4_csr_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_ddr4_csr_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_ddr4_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_ddr4_csr_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_ddr4_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_ddr4_csr_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_ddr4_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_ddr4_csr_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_ddr4_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_ddr4_csr_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_ddr4_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
  m_axi_ddr4_csr_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dsp_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_dsp_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_dsp_csr_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dsp_csr_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dsp_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_dsp_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_dsp_csr_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dsp_csr_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dsp_csr_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dsp_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_dsp_csr_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dsp_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_dsp_csr_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dsp_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_dsp_csr_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dsp_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_dsp_csr_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_dsp_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
  m_axi_dsp_csr_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user1_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_user1_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_user1_csr_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user1_csr_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user1_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_user1_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_user1_csr_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user1_csr_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user1_csr_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user1_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_user1_csr_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user1_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_user1_csr_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user1_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_user1_csr_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user1_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_user1_csr_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user1_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
  m_axi_user1_csr_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user2_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_user2_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_user2_csr_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user2_csr_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user2_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
  m_axi_user2_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
  m_axi_user2_csr_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user2_csr_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user2_csr_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user2_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_user2_csr_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user2_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_user2_csr_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user2_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
  m_axi_user2_csr_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user2_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axi_user2_csr_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
  m_axi_user2_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
  m_axi_user2_csr_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
  m_axis_ddr_rqst_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
  m_axis_ddr_rqst_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
  m_axis_ddr_rqst_tlast : out STD_LOGIC;
  m_axis_ddr_rqst_tready : in STD_LOGIC;
  m_axis_ddr_rqst_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
  m_axis_ddr_rqst_tvalid : out STD_LOGIC;
  m_axis_dma_pcie_cntl_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
  m_axis_dma_pcie_cntl_tvalid : out STD_LOGIC;
  m_axis_pcie_rc_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
  m_axis_pcie_rc_tkeep : out STD_LOGIC_VECTOR ( 31 downto 0 );
  m_axis_pcie_rc_tlast : out STD_LOGIC;
  m_axis_pcie_rc_tready : in STD_LOGIC;
  m_axis_pcie_rc_tuser : out STD_LOGIC_VECTOR ( 74 downto 0 );
  m_axis_pcie_rc_tvalid : out STD_LOGIC;
  mga : in STD_LOGIC_VECTOR ( 2 downto 0 );
  pcie_lane_led0_n : out STD_LOGIC;
  pcie_lane_led1_n : out STD_LOGIC;
  pcie_link_up : out STD_LOGIC;
  pcie_link_up_led_n : out STD_LOGIC;
  pcie_mgt_rxn : in STD_LOGIC_VECTOR ( 7 downto 0 );
  pcie_mgt_rxp : in STD_LOGIC_VECTOR ( 7 downto 0 );
  pcie_mgt_txn : out STD_LOGIC_VECTOR ( 7 downto 0 );
  pcie_mgt_txp : out STD_LOGIC_VECTOR ( 7 downto 0 );
  pcie_perstn_in : in STD_LOGIC;
  rev : in STD_LOGIC_VECTOR ( 7 downto 0 );
  rev_date : in STD_LOGIC_VECTOR ( 23 downto 0 );
  rq_shutdown_ok : in STD_LOGIC;
  s_axis_ddr_rsp_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
  s_axis_ddr_rsp_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
  s_axis_ddr_rsp_tlast : in STD_LOGIC;
  s_axis_ddr_rsp_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
  s_axis_ddr_rsp_tvalid : in STD_LOGIC;
  s_axis_pcie_rq_tdata : in STD_LOGIC_VECTOR ( 255 downto 0 );
  s_axis_pcie_rq_tkeep : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axis_pcie_rq_tlast : in STD_LOGIC;
  s_axis_pcie_rq_tready : out STD_LOGIC;
  s_axis_pcie_rq_tuser : in STD_LOGIC_VECTOR ( 59 downto 0 );
  s_axis_pcie_rq_tvalid : in STD_LOGIC;
  shutdown_rqst : out STD_LOGIC;
  startup_eos_in : in STD_LOGIC;
  sys_clk : in STD_LOGIC;
  sys_clk_gt : in STD_LOGIC;
  sys_mon_alarm : out STD_LOGIC;
  sys_mon_led_n : out STD_LOGIC;
  temp_irq_n : in STD_LOGIC;
  time_irq : in STD_LOGIC;
  user1_irq : in STD_LOGIC_VECTOR ( 1 downto 0 );
  user2_irq : in STD_LOGIC_VECTOR ( 1 downto 0 );
  user_led_n : out STD_LOGIC
);
end component pcie_intrfc_wrapper;

component ddr4_intrfc_wrapper
  port (
  ddr4_sys_rst : out STD_LOGIC;
  ddr4_ui_app_addr : out STD_LOGIC_VECTOR ( 28 downto 0 );
  ddr4_ui_app_cmd : out STD_LOGIC_VECTOR ( 2 downto 0 );
  ddr4_ui_app_en : out STD_LOGIC;
  ddr4_ui_app_hi_pri : out STD_LOGIC;
  ddr4_ui_app_rd_data : in STD_LOGIC_VECTOR ( 639 downto 0 );
  ddr4_ui_app_rd_data_end : in STD_LOGIC;
  ddr4_ui_app_rd_data_valid : in STD_LOGIC;
  ddr4_ui_app_rdy : in STD_LOGIC;
  ddr4_ui_app_wdf_data : out STD_LOGIC_VECTOR ( 639 downto 0 );
  ddr4_ui_app_wdf_end : out STD_LOGIC;
  ddr4_ui_app_wdf_mask : out STD_LOGIC_VECTOR ( 79 downto 0 );
  ddr4_ui_app_wdf_rdy : in STD_LOGIC;
  ddr4_ui_app_wdf_wren : out STD_LOGIC;
  ddr4_ui_clk : in STD_LOGIC;
  init_calib_complete : in STD_LOGIC;
  m_axis_dac_ddr_rsp_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
  m_axis_dac_ddr_rsp_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
  m_axis_dac_ddr_rsp_tlast : out STD_LOGIC;
  m_axis_dac_ddr_rsp_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
  m_axis_dac_ddr_rsp_tvalid : out STD_LOGIC;
  m_axis_pcie_ddr_rsp_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
  m_axis_pcie_ddr_rsp_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
  m_axis_pcie_ddr_rsp_tlast : out STD_LOGIC;
  m_axis_pcie_ddr_rsp_tready : in STD_LOGIC;
  m_axis_pcie_ddr_rsp_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
  m_axis_pcie_ddr_rsp_tvalid : out STD_LOGIC;
  s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
  s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
  s_axi_csr_arready : out STD_LOGIC;
  s_axi_csr_arvalid : in STD_LOGIC;
  s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
  s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
  s_axi_csr_awready : out STD_LOGIC;
  s_axi_csr_awvalid : in STD_LOGIC;
  s_axi_csr_bready : in STD_LOGIC;
  s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
  s_axi_csr_bvalid : out STD_LOGIC;
  s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axi_csr_rready : in STD_LOGIC;
  s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
  s_axi_csr_rvalid : out STD_LOGIC;
  s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axi_csr_wready : out STD_LOGIC;
  s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
  s_axi_csr_wvalid : in STD_LOGIC;
  s_axi_csr_aclk : in STD_LOGIC;
  s_axi_csr_aresetn : in STD_LOGIC;
  s_axis_aresetn : in STD_LOGIC;
  s_axis_dac_ddr_rqst_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
  s_axis_dac_ddr_rqst_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
  s_axis_dac_ddr_rqst_tlast : in STD_LOGIC;
  s_axis_dac_ddr_rqst_tready : out STD_LOGIC;
  s_axis_dac_ddr_rqst_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
  s_axis_dac_ddr_rqst_tvalid : in STD_LOGIC;
  s_axis_pcie_ddr_rqst_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
  s_axis_pcie_ddr_rqst_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
  s_axis_pcie_ddr_rqst_tlast : in STD_LOGIC;
  s_axis_pcie_ddr_rqst_tready : out STD_LOGIC;
  s_axis_pcie_ddr_rqst_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
  s_axis_pcie_ddr_rqst_tvalid : in STD_LOGIC
);
end component ddr4_intrfc_wrapper;

-- DDR4 RAM Controller for 80-bit DDR4  
component ddr4_80_ctlr
  port (
    c0_init_calib_complete : OUT STD_LOGIC;
    c0_sys_clk_p : IN STD_LOGIC;
    c0_sys_clk_n : IN STD_LOGIC;
    c0_ddr4_adr : OUT STD_LOGIC_VECTOR(16 DOWNTO 0);
    c0_ddr4_ba : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    c0_ddr4_cke : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    c0_ddr4_cs_n : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    c0_ddr4_dm_dbi_n : INOUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    c0_ddr4_dq : INOUT STD_LOGIC_VECTOR(79 DOWNTO 0);
    c0_ddr4_dqs_c : INOUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    c0_ddr4_dqs_t : INOUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    c0_ddr4_odt : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    c0_ddr4_bg : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    c0_ddr4_reset_n : OUT STD_LOGIC;
    c0_ddr4_act_n : OUT STD_LOGIC;
    c0_ddr4_ck_c : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    c0_ddr4_ck_t : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    c0_ddr4_ui_clk : OUT STD_LOGIC;
    c0_ddr4_ui_clk_sync_rst : OUT STD_LOGIC;
    c0_ddr4_app_en : IN STD_LOGIC;
    c0_ddr4_app_hi_pri : IN STD_LOGIC;
    c0_ddr4_app_wdf_end : IN STD_LOGIC;
    c0_ddr4_app_wdf_wren : IN STD_LOGIC;
    c0_ddr4_app_rd_data_end : OUT STD_LOGIC;
    c0_ddr4_app_rd_data_valid : OUT STD_LOGIC;
    c0_ddr4_app_rdy : OUT STD_LOGIC;
    c0_ddr4_app_wdf_rdy : OUT STD_LOGIC;
    c0_ddr4_app_addr : IN STD_LOGIC_VECTOR(28 DOWNTO 0);
    c0_ddr4_app_cmd : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    c0_ddr4_app_wdf_data : IN STD_LOGIC_VECTOR(639 DOWNTO 0);
    c0_ddr4_app_wdf_mask : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
    c0_ddr4_app_rd_data : OUT STD_LOGIC_VECTOR(639 DOWNTO 0);
    sys_rst : IN STD_LOGIC
  );
end component;

component p14_gpio is
port (
    ADC_CLK         : in  STD_LOGIC;
    P14GPIO_P       : inout STD_LOGIC_VECTOR( 23 downto 0 );
    P14GPIO_N       : inout STD_LOGIC_VECTOR( 23 downto 0 );
    CONTROL_FLAGS   : in  STD_LOGIC_VECTOR ( 31 downto 0 );
    MT_PULSE        : in  STD_LOGIC_VECTOR ( 7 downto 0 );
    PPS             : out STD_LOGIC;
    STATUS_FLAGS    : out STD_LOGIC_VECTOR ( 15 downto 0 );
    ROT_A           : out STD_LOGIC;
    ROT_B           : out STD_LOGIC;
    TILT_A          : out STD_LOGIC;
    TILT_B          : out STD_LOGIC;
    AZ_MOSI         : out STD_LOGIC;
    AZ_SCK          : out STD_LOGIC;
    AZ_SSEL         : out STD_LOGIC;
    EL_MOSI         : out STD_LOGIC;
    EL_SCK          : out STD_LOGIC   
);
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal dataio_irq                                   : std_logic_vector(0 downto 0);                                     
signal timestamp_irq                                : std_logic;      
signal user1_irq                                    : std_logic_vector(1 downto 0);   
signal user2_irq                                    : std_logic_vector(1 downto 0);
signal dsp_irq                                      : std_logic_vector(7 downto 0);
signal pcie_dma_irq                                 : std_logic_vector(15 downto 0);
signal pdti2ppkt_irq                                : std_logic_vector(0 downto 0);   
                                               
signal axis_adc_pdti_aclk                           : std_logic;                     
signal axis_adc_pdti_aresetn                        : std_logic;                   
signal axis_dataio_adc_ch0_pdti_tdata               : std_logic_vector(15 downto 0); 
signal axis_dataio_adc_ch0_pdti_tuser               : std_logic_vector(127 downto 0);
signal axis_dataio_adc_ch0_pdti_tvalid              : std_logic;       
signal axis_dataio_adc_ch1_pdti_tdata               : std_logic_vector(15 downto 0); 
signal axis_dataio_adc_ch1_pdti_tuser               : std_logic_vector(127 downto 0);
signal axis_dataio_adc_ch1_pdti_tvalid              : std_logic;    
signal axis_dataio_adc_ch2_pdti_tdata               : std_logic_vector(15 downto 0); 
signal axis_dataio_adc_ch2_pdti_tuser               : std_logic_vector(127 downto 0);
signal axis_dataio_adc_ch2_pdti_tvalid              : std_logic;       
signal axis_dataio_dac_pctl_tdata                   : std_logic_vector(7 downto 0);
signal axis_dataio_dac_pctl_tvalid                  : std_logic;
signal axis_dac_pdti_aclk                           : std_logic;                     
signal axis_dac_pdti_aresetn                        : std_logic;    
                                       
signal axi_csr_aclk                                 : std_logic;    
signal axi_csr_aresetn                              : std_logic;    
signal axi_dataio_csr_araddr                        : std_logic_vector(25 downto 0);                  
signal axi_dataio_csr_arprot                        : std_logic_vector(2 downto 0);                   
signal axi_dataio_csr_arready                       : std_logic_vector(0 downto 0);                           
signal axi_dataio_csr_arvalid                       : std_logic_vector(0 downto 0);                           
signal axi_dataio_csr_awaddr                        : std_logic_vector(25 downto 0);                  
signal axi_dataio_csr_awprot                        : std_logic_vector(2 downto 0);                   
signal axi_dataio_csr_awready                       : std_logic_vector(0 downto 0);                           
signal axi_dataio_csr_awvalid                       : std_logic_vector(0 downto 0);                           
signal axi_dataio_csr_bready                        : std_logic_vector(0 downto 0);                            
signal axi_dataio_csr_bresp                         : std_logic_vector(1 downto 0);                    
signal axi_dataio_csr_bvalid                        : std_logic_vector(0 downto 0);                            
signal axi_dataio_csr_rdata                         : std_logic_vector(31 downto 0);                   
signal axi_dataio_csr_rready                        : std_logic_vector(0 downto 0);                            
signal axi_dataio_csr_rresp                         : std_logic_vector(1 downto 0);                    
signal axi_dataio_csr_rvalid                        : std_logic_vector(0 downto 0);                            
signal axi_dataio_csr_wdata                         : std_logic_vector(31 downto 0);                   
signal axi_dataio_csr_wready                        : std_logic_vector(0 downto 0);                            
signal axi_dataio_csr_wstrb                         : std_logic_vector(3 downto 0);                    
signal axi_dataio_csr_wvalid                        : std_logic_vector(0 downto 0);

signal axi_app1_csr_araddr                          : std_logic_vector(25 downto 0);                  
signal axi_app1_csr_arprot                          : std_logic_vector(2 downto 0);                   
signal axi_app1_csr_arready                         : std_logic_vector(0 downto 0);                           
signal axi_app1_csr_arvalid                         : std_logic_vector(0 downto 0);                           
signal axi_app1_csr_awaddr                          : std_logic_vector(25 downto 0);                  
signal axi_app1_csr_awprot                          : std_logic_vector(2 downto 0);                   
signal axi_app1_csr_awready                         : std_logic_vector(0 downto 0);                           
signal axi_app1_csr_awvalid                         : std_logic_vector(0 downto 0);                           
signal axi_app1_csr_bready                          : std_logic_vector(0 downto 0);                            
signal axi_app1_csr_bresp                           : std_logic_vector(1 downto 0);                    
signal axi_app1_csr_bvalid                          : std_logic_vector(0 downto 0);                            
signal axi_app1_csr_rdata                           : std_logic_vector(31 downto 0);                   
signal axi_app1_csr_rready                          : std_logic_vector(0 downto 0);                            
signal axi_app1_csr_rresp                           : std_logic_vector(1 downto 0);                    
signal axi_app1_csr_rvalid                          : std_logic_vector(0 downto 0);                            
signal axi_app1_csr_wdata                           : std_logic_vector(31 downto 0);                   
signal axi_app1_csr_wready                          : std_logic_vector(0 downto 0);                            
signal axi_app1_csr_wstrb                           : std_logic_vector(3 downto 0);                    
signal axi_app1_csr_wvalid                          : std_logic_vector(0 downto 0);
               
signal axis_app1_adc_ch0_pdti_tdata                 : std_logic_vector(15 downto 0); 
signal axis_app1_adc_ch0_pdti_tuser                 : std_logic_vector(127 downto 0);
signal axis_app1_adc_ch0_pdti_tvalid                : std_logic;       
signal axis_app1_adc_ch1_pdti_tdata                 : std_logic_vector(15 downto 0); 
signal axis_app1_adc_ch1_pdti_tuser                 : std_logic_vector(127 downto 0);
signal axis_app1_adc_ch1_pdti_tvalid                : std_logic;    
signal axis_app1_adc_ch2_pdti_tdata                 : std_logic_vector(15 downto 0); 
signal axis_app1_adc_ch2_pdti_tuser                 : std_logic_vector(127 downto 0);
signal axis_app1_adc_ch2_pdti_tvalid                : std_logic;    
signal axis_app1_dac_pdti_tdata                     : std_logic_vector(31 downto 0); 
signal axis_app1_dac_pdti_tuser                     : std_logic_vector(127 downto 0);
signal axis_app1_dac_pdti_tvalid                    : std_logic; 

signal axi_app2_csr_araddr                          : std_logic_vector(25 downto 0);                  
signal axi_app2_csr_arprot                          : std_logic_vector(2 downto 0);                   
signal axi_app2_csr_arready                         : std_logic_vector(0 downto 0);                           
signal axi_app2_csr_arvalid                         : std_logic_vector(0 downto 0);                           
signal axi_app2_csr_awaddr                          : std_logic_vector(25 downto 0);                  
signal axi_app2_csr_awprot                          : std_logic_vector(2 downto 0);                   
signal axi_app2_csr_awready                         : std_logic_vector(0 downto 0);                           
signal axi_app2_csr_awvalid                         : std_logic_vector(0 downto 0);                           
signal axi_app2_csr_bready                          : std_logic_vector(0 downto 0);                            
signal axi_app2_csr_bresp                           : std_logic_vector(1 downto 0);                    
signal axi_app2_csr_bvalid                          : std_logic_vector(0 downto 0);                            
signal axi_app2_csr_rdata                           : std_logic_vector(31 downto 0);                   
signal axi_app2_csr_rready                          : std_logic_vector(0 downto 0);                            
signal axi_app2_csr_rresp                           : std_logic_vector(1 downto 0);                    
signal axi_app2_csr_rvalid                          : std_logic_vector(0 downto 0);                            
signal axi_app2_csr_wdata                           : std_logic_vector(31 downto 0);                   
signal axi_app2_csr_wready                          : std_logic_vector(0 downto 0);                            
signal axi_app2_csr_wstrb                           : std_logic_vector(3 downto 0);                    
signal axi_app2_csr_wvalid                          : std_logic_vector(0 downto 0);
                  
signal axis_app2_adc_ch0_pdti_tdata                 : std_logic_vector(31 downto 0); 
signal axis_app2_adc_ch0_pdti_tuser                 : std_logic_vector(127 downto 0);
signal axis_app2_adc_ch0_pdti_tvalid                : std_logic;       
signal axis_app2_adc_ch1_pdti_tdata                 : std_logic_vector(31 downto 0); 
signal axis_app2_adc_ch1_pdti_tuser                 : std_logic_vector(127 downto 0);
signal axis_app2_adc_ch1_pdti_tvalid                : std_logic;    
signal axis_app2_adc_ch2_pdti_tdata                 : std_logic_vector(31 downto 0); 
signal axis_app2_adc_ch2_pdti_tuser                 : std_logic_vector(127 downto 0);
signal axis_app2_adc_ch2_pdti_tvalid                : std_logic;
signal axis_app2_dac_pdti_tdata                     : std_logic_vector(31 downto 0); 
signal axis_app2_dac_pdti_tuser                     : std_logic_vector(127 downto 0);
signal axis_app2_dac_pdti_tvalid                    : std_logic;   

signal axi_dsp_csr_araddr                           : std_logic_vector(25 downto 0);                  
signal axi_dsp_csr_arprot                           : std_logic_vector(2 downto 0);                   
signal axi_dsp_csr_arready                          : std_logic_vector(0 downto 0);                           
signal axi_dsp_csr_arvalid                          : std_logic_vector(0 downto 0);                           
signal axi_dsp_csr_awaddr                           : std_logic_vector(25 downto 0);                  
signal axi_dsp_csr_awprot                           : std_logic_vector(2 downto 0);                   
signal axi_dsp_csr_awready                          : std_logic_vector(0 downto 0);                           
signal axi_dsp_csr_awvalid                          : std_logic_vector(0 downto 0);                           
signal axi_dsp_csr_bready                           : std_logic_vector(0 downto 0);                            
signal axi_dsp_csr_bresp                            : std_logic_vector(1 downto 0);                    
signal axi_dsp_csr_bvalid                           : std_logic_vector(0 downto 0);                            
signal axi_dsp_csr_rdata                            : std_logic_vector(31 downto 0);                   
signal axi_dsp_csr_rready                           : std_logic_vector(0 downto 0);                            
signal axi_dsp_csr_rresp                            : std_logic_vector(1 downto 0);                    
signal axi_dsp_csr_rvalid                           : std_logic_vector(0 downto 0);                            
signal axi_dsp_csr_wdata                            : std_logic_vector(31 downto 0);                   
signal axi_dsp_csr_wready                           : std_logic_vector(0 downto 0);                            
signal axi_dsp_csr_wstrb                            : std_logic_vector(3 downto 0);                    
signal axi_dsp_csr_wvalid                           : std_logic_vector(0 downto 0);
                 
signal axis_dsp_adc_ch0_pdti_tdata                  : std_logic_vector(31 downto 0); 
signal axis_dsp_adc_ch0_pdti_tuser                  : std_logic_vector(127 downto 0);
signal axis_dsp_adc_ch0_pdti_tvalid                 : std_logic;       
signal axis_dsp_adc_ch1_pdti_tdata                  : std_logic_vector(31 downto 0); 
signal axis_dsp_adc_ch1_pdti_tuser                  : std_logic_vector(127 downto 0);
signal axis_dsp_adc_ch1_pdti_tvalid                 : std_logic;    
signal axis_dsp_adc_ch2_pdti_tdata                  : std_logic_vector(31 downto 0); 
signal axis_dsp_adc_ch2_pdti_tuser                  : std_logic_vector(127 downto 0);
signal axis_dsp_adc_ch2_pdti_tvalid                 : std_logic;
signal axis_dsp_dac_pdti_tdata                      : std_logic_vector(31 downto 0); 
signal axis_dsp_dac_pdti_tuser                      : std_logic_vector(127 downto 0);
signal axis_dsp_dac_pdti_tvalid                     : std_logic; 

signal axi_acq_csr_araddr                           : std_logic_vector(25 downto 0);                  
signal axi_acq_csr_arprot                           : std_logic_vector(2 downto 0);                   
signal axi_acq_csr_arready                          : std_logic_vector(0 downto 0);                           
signal axi_acq_csr_arvalid                          : std_logic_vector(0 downto 0);                           
signal axi_acq_csr_awaddr                           : std_logic_vector(25 downto 0);                  
signal axi_acq_csr_awprot                           : std_logic_vector(2 downto 0);                   
signal axi_acq_csr_awready                          : std_logic_vector(0 downto 0);                           
signal axi_acq_csr_awvalid                          : std_logic_vector(0 downto 0);                           
signal axi_acq_csr_bready                           : std_logic_vector(0 downto 0);                            
signal axi_acq_csr_bresp                            : std_logic_vector(1 downto 0);                    
signal axi_acq_csr_bvalid                           : std_logic_vector(0 downto 0);                            
signal axi_acq_csr_rdata                            : std_logic_vector(31 downto 0);                   
signal axi_acq_csr_rready                           : std_logic_vector(0 downto 0);                            
signal axi_acq_csr_rresp                            : std_logic_vector(1 downto 0);                    
signal axi_acq_csr_rvalid                           : std_logic_vector(0 downto 0);                            
signal axi_acq_csr_wdata                            : std_logic_vector(31 downto 0);                   
signal axi_acq_csr_wready                           : std_logic_vector(0 downto 0);                            
signal axi_acq_csr_wstrb                            : std_logic_vector(3 downto 0);                    
signal axi_acq_csr_wvalid                           : std_logic_vector(0 downto 0);   

signal axis_acq_dac_pdti_tdata                      : std_logic_vector(31 downto 0); 
signal axis_acq_dac_pdti_tuser                      : std_logic_vector(127 downto 0);
signal axis_acq_dac_pdti_tvalid                     : std_logic;                 

signal ref_clk_i                                    : std_logic; 
signal ref_clk                                      : std_logic; 
signal idelayctrl_rst                               : std_logic; 
signal idelayctrl_cntr                              : std_logic_vector(7 downto 0) := x"00";
signal sys_clk_gt                                   : std_logic; 
signal sys_clk                                      : std_logic; 

signal adc0_fifo_full_stat                          : std_logic; 
signal adc1_fifo_full_stat                          : std_logic;
signal adc2_fifo_full_stat                          : std_logic;
signal adc3_fifo_full_stat                          : std_logic;

signal axis_pcie_rq_tdata                           : std_logic_vector(255 downto 0); 
signal axis_pcie_rq_tkeep                           : std_logic_vector(31 downto 0); 
signal axis_pcie_rq_tlast                           : std_logic_vector(0 downto 0); 
signal axis_pcie_rq_tready                          : std_logic_vector(0 downto 0); 
signal axis_pcie_rq_tuser                           : std_logic_vector(59 downto 0); 
signal axis_pcie_rq_tvalid                          : std_logic_vector(0 downto 0); 

signal axis_pcie_rc_tdata                           : std_logic_vector ( 255 downto 0 );
signal axis_pcie_rc_tkeep                           : std_logic_vector ( 31 downto 0 );
signal axis_pcie_rc_tlast                           : std_logic;                       
signal axis_pcie_rc_tready                          : std_logic;                       
signal axis_pcie_rc_tuser                           : std_logic_vector ( 74 downto 0 );
signal axis_pcie_rc_tvalid                          : std_logic;                       

signal rq_shutdown_ok                               : std_logic; 
signal shutdown_rqst                                : std_logic; 
signal axis_dma_pcie_cntl_tdata                     : std_logic_vector(7 downto 0); 
signal axis_dma_pcie_cntl_tvalid                    : std_logic; 

signal dac_realtime_lost_stat                       : std_logic; 

signal flash_a                                      : std_logic_vector( 25 downto 0 );
signal flash_adv_b                                  : std_logic;                    
signal flash_d_o                                    : std_logic_vector( 15 downto 0 );
signal flash_d_t                                    : std_logic_vector( 15 downto 0 );
signal flash_fwe_b                                  : std_logic;                    
signal flash_fcs_b                                  : std_logic;      
signal flash_foe_b                                  : std_logic;      
signal flash_d_i                                    : std_logic_vector( 15 downto 0 );

signal axi_ddr4_csr_awaddr                          : std_logic_vector( 25 downto 0 );
signal axi_ddr4_csr_awprot                          : std_logic_vector( 2 downto 0 );
signal axi_ddr4_csr_awvalid                         : std_logic_vector( 0 to 0 );
signal axi_ddr4_csr_awready                         : std_logic_vector( 0 to 0 );
signal axi_ddr4_csr_wdata                           : std_logic_vector( 31 downto 0 );
signal axi_ddr4_csr_wstrb                           : std_logic_vector( 3 downto 0 );
signal axi_ddr4_csr_wvalid                          : std_logic_vector( 0 to 0 );
signal axi_ddr4_csr_wready                          : std_logic_vector( 0 to 0 );
signal axi_ddr4_csr_bresp                           : std_logic_vector( 1 downto 0 );
signal axi_ddr4_csr_bvalid                          : std_logic_vector( 0 to 0 );
signal axi_ddr4_csr_bready                          : std_logic_vector( 0 to 0 );
signal axi_ddr4_csr_araddr                          : std_logic_vector( 25 downto 0 );
signal axi_ddr4_csr_arprot                          : std_logic_vector( 2 downto 0 );
signal axi_ddr4_csr_arvalid                         : std_logic_vector( 0 to 0 );
signal axi_ddr4_csr_arready                         : std_logic_vector( 0 to 0 );
signal axi_ddr4_csr_rdata                           : std_logic_vector( 31 downto 0 );
signal axi_ddr4_csr_rresp                           : std_logic_vector( 1 downto 0 );
signal axi_ddr4_csr_rvalid                          : std_logic_vector( 0 to 0 );
signal axi_ddr4_csr_rready                          : std_logic_vector( 0 to 0 );

signal axis_dac_ddr_rqst_tid                        : std_logic_vector( 7 downto 0 );
signal axis_dac_ddr_rqst_tdata                      : std_logic_vector( 511 downto 0 );
signal axis_dac_ddr_rqst_tlast                      : std_logic;      
signal axis_dac_ddr_rqst_tuser                      : std_logic_vector( 255 downto 0 );
signal axis_dac_ddr_rqst_tvalid                     : std_logic;      
signal axis_dac_ddr_rqst_tready                     : std_logic;  
signal axis_pcie_ddr_rqst_tid                       : std_logic_vector( 7 downto 0 );
signal axis_pcie_ddr_rqst_tdata                     : std_logic_vector( 511 downto 0 );
signal axis_pcie_ddr_rqst_tlast                     : std_logic;      
signal axis_pcie_ddr_rqst_tuser                     : std_logic_vector( 255 downto 0 );
signal axis_pcie_ddr_rqst_tvalid                    : std_logic;      
signal axis_pcie_ddr_rqst_tready                    : std_logic;       
signal axis_dac_ddr_rsp_tid                         : std_logic_vector( 7 downto 0 );
signal axis_dac_ddr_rsp_tdata                       : std_logic_vector( 511 downto 0 );
signal axis_dac_ddr_rsp_tlast                       : std_logic;      
signal axis_dac_ddr_rsp_tuser                       : std_logic_vector( 255 downto 0 );
signal axis_dac_ddr_rsp_tvalid                      : std_logic; 
signal axis_pcie_ddr_rsp_tid                        : std_logic_vector( 7 downto 0 );
signal axis_pcie_ddr_rsp_tdata                      : std_logic_vector( 511 downto 0 );
signal axis_pcie_ddr_rsp_tlast                      : std_logic;      
signal axis_pcie_ddr_rsp_tuser                      : std_logic_vector( 255 downto 0 );
signal axis_pcie_ddr_rsp_tvalid                     : std_logic;     
            
signal ddr4_sys_rst                                 : std_logic;                      
signal ddr4_ui_app_addr                             : std_logic_vector ( 28 downto 0 );
signal ddr4_ui_app_cmd                              : std_logic_vector ( 2 downto 0 );
signal ddr4_ui_app_en                               : std_logic;                      
signal ddr4_ui_app_hi_pri                           : std_logic;                      
signal ddr4_ui_app_rd_data                          : std_logic_vector ( 639 downto 0 );
signal ddr4_ui_app_rd_data_end                      : std_logic;                      
signal ddr4_ui_app_rd_data_valid                    : std_logic;                      
signal ddr4_ui_app_rdy                              : std_logic;                      
signal ddr4_ui_app_wdf_data                         : std_logic_vector ( 639 downto 0 );
signal ddr4_ui_app_wdf_end                          : std_logic;                      
signal ddr4_ui_app_wdf_mask                         : std_logic_vector ( 79 downto 0 );
signal ddr4_ui_app_wdf_rdy                          : std_logic;                      
signal ddr4_ui_app_wdf_wren                         : std_logic;                      
signal ddr4_ui_clk                                  : std_logic;
signal init_calib_complete                           : std_logic;

signal pcie_perstn_in                               : std_logic;
signal startup_eos                                  : std_logic;
signal ddr4_ui_rstn                                 : std_logic;
signal ddr4_ui_clk_sync_rst                         : std_logic;

signal filter_select_ch0    : std_logic_vector ( 1 downto 0 ) := (others=>'0');
signal filter_select_ch1    : std_logic_vector ( 1 downto 0 ) := (others=>'0');
signal filter_select_ch2    : std_logic_vector ( 1 downto 0 ) := (others=>'0');
signal control_flags        : std_logic_vector ( 31 downto 0 ) := (others=>'0');
signal mt_pulse             : std_logic_vector ( 7 downto 0 ) := (others=>'0');
signal controller_pps       : std_logic := '0';
signal status_flags         : std_logic_vector ( 15 downto 0 ) := (others=>'0');
signal rot_a                : std_logic := '0';
signal rot_b                : std_logic := '0';
signal tilt_a               : std_logic := '0';
signal tilt_b               : std_logic := '0';
signal az_mosi              : std_logic := '0';
signal az_sck               : std_logic := '0';
signal az_ssel              : std_logic := '0';
signal el_mosi              : std_logic := '0';
signal el_sck               : std_logic := '0';
signal p14_gpio_pps         : std_logic := '0';

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant rev_vctr : std_logic_vector(7 downto 0) := conv_std_logic_vector(rev, 8);

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

attribute IODELAY_GROUP: string;
attribute IODELAY_GROUP of IDELAYCTRL_inst1: label is "IODELAY_GRP"; --"iodelay_grp1";

--------------------------------------------------------------------------------

begin

P16_LINKUP_N    <= '1';

--------------------------------------------------------------------------------
-- Front End Interfaces
-- Block Design
--------------------------------------------------------------------------------

dataio_intrfc_i: dataio_intrfc_wrapper
port map (
      -- External Interfaces
      
      -- ADC Interfaces
      adc0_d0_1_n                               => ADC0_D0_1_N,       
      adc0_d0_1_p                               => ADC0_D0_1_P,       
      adc0_d10_11_n                             => ADC0_D10_11_N,     
      adc0_d10_11_p                             => ADC0_D10_11_P,     
      adc0_d12_13_n                             => ADC0_D12_13_N,     
      adc0_d12_13_p                             => ADC0_D12_13_P,     
      adc0_d14_15_n                             => ADC0_D14_15_N,     
      adc0_d14_15_p                             => ADC0_D14_15_P,     
      adc0_d2_3_n                               => ADC0_D2_3_N,       
      adc0_d2_3_p                               => ADC0_D2_3_P,       
      adc0_d4_5_n                               => ADC0_D4_5_N,       
      adc0_d4_5_p                               => ADC0_D4_5_P,       
      adc0_d6_7_n                               => ADC0_D6_7_N,       
      adc0_d6_7_p                               => ADC0_D6_7_P,       
      adc0_d8_9_n                               => ADC0_D8_9_N,       
      adc0_d8_9_p                               => ADC0_D8_9_P,       
      adc0_ovld_led_n                           => ADC0_OVLD_LED_N, 
      adc0_fifo_full_stat                       => adc0_fifo_full_stat,  
      adc0_pdwnf                                => ADC0_PDWNF,        
      adc1_d0_1_n                               => ADC1_D0_1_N,       
      adc1_d0_1_p                               => ADC1_D0_1_P,       
      adc1_d10_11_n                             => ADC1_D10_11_N,     
      adc1_d10_11_p                             => ADC1_D10_11_P,     
      adc1_d12_13_n                             => ADC1_D12_13_N,     
      adc1_d12_13_p                             => ADC1_D12_13_P,     
      adc1_d14_15_n                             => ADC1_D14_15_N,     
      adc1_d14_15_p                             => ADC1_D14_15_P,     
      adc1_d2_3_n                               => ADC1_D2_3_N,       
      adc1_d2_3_p                               => ADC1_D2_3_P,       
      adc1_d4_5_n                               => ADC1_D4_5_N,       
      adc1_d4_5_p                               => ADC1_D4_5_P,       
      adc1_d6_7_n                               => ADC1_D6_7_N,       
      adc1_d6_7_p                               => ADC1_D6_7_P,       
      adc1_d8_9_n                               => ADC1_D8_9_N,       
      adc1_d8_9_p                               => ADC1_D8_9_P,       
      adc1_ovld_led_n                           => ADC1_OVLD_LED_N, 
      adc1_fifo_full_stat                       => adc1_fifo_full_stat,   
      adc1_pdwnf                                => ADC1_PDWNF,        
      adc2_d0_1_n                               => ADC2_D0_1_N,       
      adc2_d0_1_p                               => ADC2_D0_1_P,       
      adc2_d10_11_n                             => ADC2_D10_11_N,     
      adc2_d10_11_p                             => ADC2_D10_11_P,     
      adc2_d12_13_n                             => ADC2_D12_13_N,     
      adc2_d12_13_p                             => ADC2_D12_13_P,     
      adc2_d14_15_n                             => ADC2_D14_15_N,     
      adc2_d14_15_p                             => ADC2_D14_15_P,     
      adc2_d2_3_n                               => ADC2_D2_3_N,       
      adc2_d2_3_p                               => ADC2_D2_3_P,       
      adc2_d4_5_n                               => ADC2_D4_5_N,       
      adc2_d4_5_p                               => ADC2_D4_5_P,       
      adc2_d6_7_n                               => ADC2_D6_7_N,       
      adc2_d6_7_p                               => ADC2_D6_7_P,       
      adc2_d8_9_n                               => ADC2_D8_9_N,       
      adc2_d8_9_p                               => ADC2_D8_9_P,       
      adc2_ovld_led_n                           => ADC2_OVLD_LED_N,
      adc2_fifo_full_stat                       => adc2_fifo_full_stat,    
      adc2_pdwnf                                => ADC2_PDWNF,
      adc_dither                                => ADC_DITHER,
      -- DAC Interfaces  
      dac_da                                    => DAC_DA,                       
      dac_db                                    => DAC_DB,                       
      dac_lock                                  => DAC_LOCK,                     
      dac_realtime_lost_stat                    => dac_realtime_lost_stat,       
      dac_realtimelost_led_n(0)                 => DAC_ERR_LED_N,    
      dac_reset_n                               => DAC_RESET_N,                  
      dac_sclk                                  => DAC_SCLK,                     
      dac_sdenb                                 => DAC_SDENB,                    
      dac_sdi                                   => DAC_SDI,                      
      dac_sdo                                   => DAC_SDO,                      
      dac_sync                                  => DAC_SYNC,                     
      dac_tx_en                                 => DAC_TX_EN,                    
      -- Clock Control
      cdc_cntl_cdc_clk                          => CDC_CLK,
      cdc_cntl_cdc_dat                          => CDC_DAT,
      cdc_cntl_cdc_le                           => CDC_LE,
      cdc_cntl_cdc_rst_n                        => CDC_RST_OUT_N,
      cdc_cntl_cdc_stat_lock                    => CDC_STAT_LOCK,
      cdc_cntl_cdc_stat_ref                     => CDC_STAT_REF,
      cdc_cntl_cdc_stat_vcxo                    => CDC_STAT_VCXO,
      
      cdc_sync_rst_in_p                         => CDC_SYNC_RST_IN_P,
      cdc_sync_rst_in_n                         => CDC_SYNC_RST_IN_N,
      cdc_sync_rst_out                          => CDC_SYNC_RST_OUT, 
      
      clka_glbl_clk_n                           => CLKA_GLBL_N,
      clka_glbl_clk_p                           => CLKA_GLBL_P,
      clkb_glbl_clk_n                           => DAC_CLKO_N,
      clkb_glbl_clk_p                           => DAC_CLKO_P,
      clk_det_led_n                             => CLK_DET_LED_N,
      clka_master_n                             => CLK_MASTER_N,
      clkb_master_n                             => open, 
      master_led_n                              => MASTER_LED_N,
      clk_mux_sel(1 downto 0)                   => CLK_MUX_SEL(1 downto 0),
      
      refclk                                    => ref_clk, -- 200MHz fixed Reference Clock

      -- Sync Bus Interfaces
      gate_trig_ttl_in                          => GATE_TRIG_TTL_IN,
      gatea_in_n                                => GATEA_IN_N,
      gatea_in_p                                => GATEA_IN_P,
      gatea_out_n                               => GATEA_OUT_N,
      gatea_out_p                               => GATEA_OUT_P,
      gateb_in_n                                => GATEB_IN_N,
      gateb_in_p                                => GATEB_IN_P,
      gateb_out_n                               => GATEB_OUT_N,
      gateb_out_p                               => GATEB_OUT_P,
      sync_pps_ttl_in                           => p14_gpio_pps,--SYNC_PPS_TTL_IN,
      synca_pps_in_n                            => SYNCA_PPS_IN_N, 
      synca_pps_in_p                            => SYNCA_PPS_IN_P, 
      synca_pps_out_n                           => SYNCA_PPS_OUT_N,
      synca_pps_out_p                           => SYNCA_PPS_OUT_P,
      syncb_pps_in_n                            => SYNCB_PPS_IN_N, 
      syncb_pps_in_p                            => SYNCB_PPS_IN_P, 
      syncb_pps_out_n                           => SYNCB_PPS_OUT_N,
      syncb_pps_out_p                           => SYNCB_PPS_OUT_P,
      vcxo_en                                   => VCXO_EN,        
      vcxo_sel_n                                => VCXO_SEL_N, 
      pps_det_led_n                             => PPS_DET_LED_N,
      sbusa_master_n                            => SBUS_A_MASTER_N,  
      sbusb_master_n                            => SBUS_B_MASTER_N,  
      --------------------------------------------------------------------------
      -- Internal Interfaces
      --------------------------------------------------------------------------   
      -- Interrupt Outputs   
      dataio_irq                                => dataio_irq,
      timestamp_irq                             => timestamp_irq,
      -- AXI4-Stream ADC data Streams
      m_axis_adc_ch0_pdti_tdata                 => axis_dataio_adc_ch0_pdti_tdata(15 downto 0),    
      m_axis_adc_ch0_pdti_tuser                 => axis_dataio_adc_ch0_pdti_tuser(127 downto 0),   
      m_axis_adc_ch0_pdti_tvalid                => axis_dataio_adc_ch0_pdti_tvalid,                
      m_axis_adc_ch1_pdti_tdata                 => axis_dataio_adc_ch1_pdti_tdata(15 downto 0),    
      m_axis_adc_ch1_pdti_tuser                 => axis_dataio_adc_ch1_pdti_tuser(127 downto 0),   
      m_axis_adc_ch1_pdti_tvalid                => axis_dataio_adc_ch1_pdti_tvalid,                
      m_axis_adc_ch2_pdti_tdata                 => axis_dataio_adc_ch2_pdti_tdata(15 downto 0),    
      m_axis_adc_ch2_pdti_tuser                 => axis_dataio_adc_ch2_pdti_tuser(127 downto 0),   
      m_axis_adc_ch2_pdti_tvalid                => axis_dataio_adc_ch2_pdti_tvalid,
      m_axis_adc_pdti_aclk                      => axis_adc_pdti_aclk,     
      m_axis_adc_pdti_aresetn                   => axis_adc_pdti_aresetn,  
      -- AXI4-Stream DAC data Streams
      s_axis_dac_pdti_tdata                     => axis_app1_dac_pdti_tdata,    
      s_axis_dac_pdti_tuser                     => axis_app1_dac_pdti_tuser(127 downto 0),   
      s_axis_dac_pdti_tvalid                    => axis_app1_dac_pdti_tvalid, 
      m_axis_dac_pctl_tdata                     => axis_dataio_dac_pctl_tdata, -- Gate and Sync Stream
      m_axis_dac_pctl_tvalid                    => axis_dataio_dac_pctl_tvalid,
      s_axis_dac_pdti_aclk                      => axis_dac_pdti_aclk,     
      s_axis_dac_pdti_aresetn                   => axis_dac_pdti_aresetn,  
      -- AXI4-Lite Control Bus
      s_axi_csr_aclk                            => axi_csr_aclk,
      s_axi_csr_aresetn                         => axi_csr_aresetn,
      s_axi_csr_araddr(25 downto 0)             => axi_dataio_csr_araddr(25 downto 0),
      s_axi_csr_arprot(2 downto 0)              => axi_dataio_csr_arprot(2 downto 0),
      s_axi_csr_arready                         => axi_dataio_csr_arready(0),
      s_axi_csr_arvalid                         => axi_dataio_csr_arvalid(0),
      s_axi_csr_awaddr(25 downto 0)             => axi_dataio_csr_awaddr(25 downto 0),
      s_axi_csr_awprot(2 downto 0)              => axi_dataio_csr_awprot(2 downto 0),
      s_axi_csr_awready                         => axi_dataio_csr_awready(0),
      s_axi_csr_awvalid                         => axi_dataio_csr_awvalid(0),
      s_axi_csr_bready                          => axi_dataio_csr_bready(0),
      s_axi_csr_bresp(1 downto 0)               => axi_dataio_csr_bresp(1 downto 0),
      s_axi_csr_bvalid                          => axi_dataio_csr_bvalid(0),
      s_axi_csr_rdata(31 downto 0)              => axi_dataio_csr_rdata(31 downto 0),
      s_axi_csr_rready                          => axi_dataio_csr_rready(0),
      s_axi_csr_rresp(1 downto 0)               => axi_dataio_csr_rresp(1 downto 0),
      s_axi_csr_rvalid                          => axi_dataio_csr_rvalid(0),
      s_axi_csr_wdata(31 downto 0)              => axi_dataio_csr_wdata(31 downto 0),
      s_axi_csr_wready                          => axi_dataio_csr_wready(0),
      s_axi_csr_wstrb(3 downto 0)               => axi_dataio_csr_wstrb(3 downto 0),
      s_axi_csr_wvalid                          => axi_dataio_csr_wvalid(0)
);

-- User Application Space #1 (Pre-DSP Block)
user_block1_i: user_block1_wrapper
port map (
      user1_irq                                 => user1_irq,
      filter_select_ch0 => filter_select_ch0,
      filter_select_ch1 => filter_select_ch1,
      filter_select_ch2 => filter_select_ch2,
      mt_pulse          => mt_pulse,
      controller_PPS    => controller_PPS,
      -- Input ADC AXI4-Stream Interfaces 
      s_axis_adc_pdti_aclk                      => axis_adc_pdti_aclk,
      s_axis_adc_pdti_aresetn                   => axis_adc_pdti_aresetn,
      s_axis_adc_ch0_pdti_tdata(15 downto 0)    => axis_dataio_adc_ch0_pdti_tdata(15 downto 0),
      s_axis_adc_ch0_pdti_tuser(127 downto 0)   => axis_dataio_adc_ch0_pdti_tuser(127 downto 0),
      s_axis_adc_ch0_pdti_tvalid                => axis_dataio_adc_ch0_pdti_tvalid,
      s_axis_adc_ch1_pdti_tdata(15 downto 0)    => axis_dataio_adc_ch1_pdti_tdata(15 downto 0),
      s_axis_adc_ch1_pdti_tuser(127 downto 0)   => axis_dataio_adc_ch1_pdti_tuser(127 downto 0),
      s_axis_adc_ch1_pdti_tvalid                => axis_dataio_adc_ch1_pdti_tvalid,
      s_axis_adc_ch2_pdti_tdata(15 downto 0)    => axis_dataio_adc_ch2_pdti_tdata(15 downto 0),
      s_axis_adc_ch2_pdti_tuser(127 downto 0)   => axis_dataio_adc_ch2_pdti_tuser(127 downto 0),
      s_axis_adc_ch2_pdti_tvalid                => axis_dataio_adc_ch2_pdti_tvalid,
      -- Input DAC AXI4-Stream Interface from DSP Block 
      s_axis_dac_pdti_aclk                      => axis_dac_pdti_aclk,
      s_axis_dac_pdti_aresetn                   => axis_dac_pdti_aresetn,
      s_axis_dac_pdti_tdata(31 downto 0)        => axis_dsp_dac_pdti_tdata(31 downto 0),
      s_axis_dac_pdti_tuser(127 downto 0)       => axis_dsp_dac_pdti_tuser(127 downto 0),
      s_axis_dac_pdti_tvalid                    => axis_dsp_dac_pdti_tvalid,
      -- Output ADC AXI4-Stream Interfaces 
      m_axis_adc_ch0_pdti_tdata(15 downto 0)    => axis_app1_adc_ch0_pdti_tdata(15 downto 0),
      m_axis_adc_ch0_pdti_tuser(127 downto 0)   => axis_app1_adc_ch0_pdti_tuser(127 downto 0),
      m_axis_adc_ch0_pdti_tvalid                => axis_app1_adc_ch0_pdti_tvalid,
      m_axis_adc_ch1_pdti_tdata(15 downto 0)    => axis_app1_adc_ch1_pdti_tdata(15 downto 0),
      m_axis_adc_ch1_pdti_tuser(127 downto 0)   => axis_app1_adc_ch1_pdti_tuser(127 downto 0),
      m_axis_adc_ch1_pdti_tvalid                => axis_app1_adc_ch1_pdti_tvalid,
      m_axis_adc_ch2_pdti_tdata(15 downto 0)    => axis_app1_adc_ch2_pdti_tdata(15 downto 0),
      m_axis_adc_ch2_pdti_tuser(127 downto 0)   => axis_app1_adc_ch2_pdti_tuser(127 downto 0),
      m_axis_adc_ch2_pdti_tvalid                => axis_app1_adc_ch2_pdti_tvalid,
      -- Output DAC AXI4-Stream Interface to DataIO Block 
      m_axis_dac_pdti_tdata(31 downto 0)        => axis_app1_dac_pdti_tdata(31 downto 0),
      m_axis_dac_pdti_tuser(127 downto 0)       => axis_app1_dac_pdti_tuser(127 downto 0),
      m_axis_dac_pdti_tvalid                    => axis_app1_dac_pdti_tvalid,
      -- AXI4-Lite Control Bus
      s_axi_csr_aclk                            => axi_csr_aclk,
      s_axi_csr_aresetn                         => axi_csr_aresetn,
      s_axi_csr_araddr(25 downto 0)             => axi_app1_csr_araddr(25 downto 0),
      s_axi_csr_arprot(2 downto 0)              => axi_app1_csr_arprot(2 downto 0),
      s_axi_csr_arready                         => axi_app1_csr_arready(0),
      s_axi_csr_arvalid                         => axi_app1_csr_arvalid(0),
      s_axi_csr_awaddr(25 downto 0)             => axi_app1_csr_awaddr(25 downto 0),
      s_axi_csr_awprot(2 downto 0)              => axi_app1_csr_awprot(2 downto 0),
      s_axi_csr_awready                         => axi_app1_csr_awready(0),
      s_axi_csr_awvalid                         => axi_app1_csr_awvalid(0),
      s_axi_csr_bready                          => axi_app1_csr_bready(0),
      s_axi_csr_bresp(1 downto 0)               => axi_app1_csr_bresp(1 downto 0),
      s_axi_csr_bvalid                          => axi_app1_csr_bvalid(0),
      s_axi_csr_rdata(31 downto 0)              => axi_app1_csr_rdata(31 downto 0),
      s_axi_csr_rready                          => axi_app1_csr_rready(0),
      s_axi_csr_rresp(1 downto 0)               => axi_app1_csr_rresp(1 downto 0),
      s_axi_csr_rvalid                          => axi_app1_csr_rvalid(0),
      s_axi_csr_wdata(31 downto 0)              => axi_app1_csr_wdata(31 downto 0),
      s_axi_csr_wready                          => axi_app1_csr_wready(0),
      s_axi_csr_wstrb(3 downto 0)               => axi_app1_csr_wstrb(3 downto 0),
      s_axi_csr_wvalid                          => axi_app1_csr_wvalid(0)
    );
    
-- Digital Signal Processing Block
dsp_i: dsp1_wrapper
port map(
   dsp_irq                                      => dsp_irq,
   m_axis_adc_ch0_pdti_tdata                    => axis_dsp_adc_ch0_pdti_tdata(31 downto 0), 
   m_axis_adc_ch0_pdti_tuser                    => axis_dsp_adc_ch0_pdti_tuser(127 downto 0),
   m_axis_adc_ch0_pdti_tvalid                   => axis_dsp_adc_ch0_pdti_tvalid,             
   m_axis_adc_ch1_pdti_tdata                    => axis_dsp_adc_ch1_pdti_tdata(31 downto 0), 
   m_axis_adc_ch1_pdti_tuser                    => axis_dsp_adc_ch1_pdti_tuser(127 downto 0),
   m_axis_adc_ch1_pdti_tvalid                   => axis_dsp_adc_ch1_pdti_tvalid,             
   m_axis_adc_ch2_pdti_tdata                    => axis_dsp_adc_ch2_pdti_tdata(31 downto 0), 
   m_axis_adc_ch2_pdti_tuser                    => axis_dsp_adc_ch2_pdti_tuser(127 downto 0),
   m_axis_adc_ch2_pdti_tvalid                   => axis_dsp_adc_ch2_pdti_tvalid,  
   m_axis_dac_pdti_tdata                        => axis_dsp_dac_pdti_tdata(31 downto 0), 
   m_axis_dac_pdti_tuser                        => axis_dsp_dac_pdti_tuser(127 downto 0),
   m_axis_dac_pdti_tvalid                       => axis_dsp_dac_pdti_tvalid,                      
   s_axi_csr_aclk                               => axi_csr_aclk,                     
   s_axi_csr_aresetn                            => axi_csr_aresetn, 
   s_axi_csr_araddr                             => axi_dsp_csr_araddr(25 downto 0), 
   s_axi_csr_arprot                             => axi_dsp_csr_arprot(2 downto 0),  
   s_axi_csr_arready                            => axi_dsp_csr_arready(0),          
   s_axi_csr_arvalid                            => axi_dsp_csr_arvalid(0),          
   s_axi_csr_awaddr                             => axi_dsp_csr_awaddr(25 downto 0), 
   s_axi_csr_awprot                             => axi_dsp_csr_awprot(2 downto 0),  
   s_axi_csr_awready                            => axi_dsp_csr_awready(0),          
   s_axi_csr_awvalid                            => axi_dsp_csr_awvalid(0),          
   s_axi_csr_bready                             => axi_dsp_csr_bready(0),           
   s_axi_csr_bresp                              => axi_dsp_csr_bresp(1 downto 0),   
   s_axi_csr_bvalid                             => axi_dsp_csr_bvalid(0),           
   s_axi_csr_rdata                              => axi_dsp_csr_rdata(31 downto 0),  
   s_axi_csr_rready                             => axi_dsp_csr_rready(0),           
   s_axi_csr_rresp                              => axi_dsp_csr_rresp(1 downto 0),   
   s_axi_csr_rvalid                             => axi_dsp_csr_rvalid(0),           
   s_axi_csr_wdata                              => axi_dsp_csr_wdata(31 downto 0),  
   s_axi_csr_wready                             => axi_dsp_csr_wready(0),           
   s_axi_csr_wstrb                              => axi_dsp_csr_wstrb(3 downto 0),   
   s_axi_csr_wvalid                             => axi_dsp_csr_wvalid(0),            
   s_axis_adc_ch0_pdti_tdata                    => axis_app1_adc_ch0_pdti_tdata(15 downto 0),                  
   s_axis_adc_ch0_pdti_tuser                    => axis_app1_adc_ch0_pdti_tuser(127 downto 0),                 
   s_axis_adc_ch0_pdti_tvalid                   => axis_app1_adc_ch0_pdti_tvalid,               
   s_axis_adc_ch1_pdti_tdata                    => axis_app1_adc_ch1_pdti_tdata(15 downto 0),   
   s_axis_adc_ch1_pdti_tuser                    => axis_app1_adc_ch1_pdti_tuser(127 downto 0),  
   s_axis_adc_ch1_pdti_tvalid                   => axis_app1_adc_ch1_pdti_tvalid,               
   s_axis_adc_ch2_pdti_tdata                    => axis_app1_adc_ch2_pdti_tdata(15 downto 0),   
   s_axis_adc_ch2_pdti_tuser                    => axis_app1_adc_ch2_pdti_tuser(127 downto 0),  
   s_axis_adc_ch2_pdti_tvalid                   => axis_app1_adc_ch2_pdti_tvalid, 
   s_axis_dac_pdti_tdata                        => axis_app2_dac_pdti_tdata(31 downto 0),   
   s_axis_dac_pdti_tuser                        => axis_app2_dac_pdti_tuser(127 downto 0),  
   s_axis_dac_pdti_tvalid                       => axis_app2_dac_pdti_tvalid,                            
   s_axis_adc_pdti_aclk                         => axis_adc_pdti_aclk,       
   s_axis_adc_pdti_aresetn                      => axis_adc_pdti_aresetn,
   s_axis_dac_pdti_aclk                         => axis_dac_pdti_aclk,       
   s_axis_dac_pdti_aresetn                      => axis_dac_pdti_aresetn    
);

-- User Application Space #2 (Post-DSP Block)    
user_block2_i: user_block2_wrapper
port map (
    -- radar customizations
    filter_select_ch0                         => filter_select_ch0,
    filter_select_ch1                         => filter_select_ch1,
    filter_select_ch2                         => filter_select_ch2,
    control_flags                             => control_flags,
    mt_pulse                                  => mt_pulse,
    controller_PPS                            => controller_PPS,
    status_flags                              => status_flags,
    ROT_A                                     => ROT_A,
    ROT_B                                     => ROT_B,
    TILT_A                                    => TILT_A,
    TILT_B                                    => TILT_B,
    AZ_MOSI                                   => AZ_MOSI,
    AZ_SCK                                    => AZ_SCK,
    AZ_SSEL                                   => AZ_SSEL,
    EL_MOSI                                   => EL_MOSI,
    EL_SCK                                    => EL_SCK,
    -- IRQ
    user2_irq                                 => user2_irq,
    -- Input ADC AXI4-Stream Interfaces 
    s_axis_adc_pdti_aclk                      => axis_adc_pdti_aclk,
    s_axis_adc_pdti_aresetn                   => axis_adc_pdti_aresetn,
    s_axis_dac_pdti_aclk                      => axis_dac_pdti_aclk,
    s_axis_dac_pdti_aresetn                   => axis_dac_pdti_aresetn,
    s_axis_adc_ch0_pdti_tdata(31 downto 0)    => axis_dsp_adc_ch0_pdti_tdata(31 downto 0),
    s_axis_adc_ch0_pdti_tuser(127 downto 0)   => axis_dsp_adc_ch0_pdti_tuser(127 downto 0),
    s_axis_adc_ch0_pdti_tvalid                => axis_dsp_adc_ch0_pdti_tvalid,
    s_axis_adc_ch1_pdti_tdata(31 downto 0)    => axis_dsp_adc_ch1_pdti_tdata(31 downto 0),
    s_axis_adc_ch1_pdti_tuser(127 downto 0)   => axis_dsp_adc_ch1_pdti_tuser(127 downto 0),
    s_axis_adc_ch1_pdti_tvalid                => axis_dsp_adc_ch1_pdti_tvalid,
    s_axis_adc_ch2_pdti_tdata(31 downto 0)    => axis_dsp_adc_ch2_pdti_tdata(31 downto 0),
    s_axis_adc_ch2_pdti_tuser(127 downto 0)   => axis_dsp_adc_ch2_pdti_tuser(127 downto 0),
    s_axis_adc_ch2_pdti_tvalid                => axis_dsp_adc_ch2_pdti_tvalid,
    s_axis_dac_pdti_tdata(31 downto 0)        => axis_acq_dac_pdti_tdata(31 downto 0),
    s_axis_dac_pdti_tuser(127 downto 0)       => axis_acq_dac_pdti_tuser(127 downto 0),
    s_axis_dac_pdti_tvalid                    => axis_acq_dac_pdti_tvalid,
    -- Output ADC AXI4-Stream Interfaces 
    m_axis_adc_ch0_pdti_tdata(31 downto 0)    => axis_app2_adc_ch0_pdti_tdata(31 downto 0),
    m_axis_adc_ch0_pdti_tuser(127 downto 0)   => axis_app2_adc_ch0_pdti_tuser(127 downto 0),
    m_axis_adc_ch0_pdti_tvalid                => axis_app2_adc_ch0_pdti_tvalid,
    m_axis_adc_ch1_pdti_tdata(31 downto 0)    => axis_app2_adc_ch1_pdti_tdata(31 downto 0),
    m_axis_adc_ch1_pdti_tuser(127 downto 0)   => axis_app2_adc_ch1_pdti_tuser(127 downto 0),
    m_axis_adc_ch1_pdti_tvalid                => axis_app2_adc_ch1_pdti_tvalid,
    m_axis_adc_ch2_pdti_tdata(31 downto 0)    => axis_app2_adc_ch2_pdti_tdata(31 downto 0),
    m_axis_adc_ch2_pdti_tuser(127 downto 0)   => axis_app2_adc_ch2_pdti_tuser(127 downto 0),
    m_axis_adc_ch2_pdti_tvalid                => axis_app2_adc_ch2_pdti_tvalid,
    m_axis_dac_pdti_tdata(31 downto 0)        => axis_app2_dac_pdti_tdata(31 downto 0),
    m_axis_dac_pdti_tuser(127 downto 0)       => axis_app2_dac_pdti_tuser(127 downto 0),
    m_axis_dac_pdti_tvalid                    => axis_app2_dac_pdti_tvalid,
    -- AXI4-Lite Control Bus
    s_axi_csr_aclk                            => axi_csr_aclk,
    s_axi_csr_aresetn                         => axi_csr_aresetn,
    s_axi_csr_araddr(25 downto 0)             => axi_app2_csr_araddr(25 downto 0),
    s_axi_csr_arprot(2 downto 0)              => axi_app2_csr_arprot(2 downto 0),
    s_axi_csr_arready                         => axi_app2_csr_arready(0),
    s_axi_csr_arvalid                         => axi_app2_csr_arvalid(0),
    s_axi_csr_awaddr(25 downto 0)             => axi_app2_csr_awaddr(25 downto 0),
    s_axi_csr_awprot(2 downto 0)              => axi_app2_csr_awprot(2 downto 0),
    s_axi_csr_awready                         => axi_app2_csr_awready(0),
    s_axi_csr_awvalid                         => axi_app2_csr_awvalid(0),
    s_axi_csr_bready                          => axi_app2_csr_bready(0),
    s_axi_csr_bresp(1 downto 0)               => axi_app2_csr_bresp(1 downto 0),
    s_axi_csr_bvalid                          => axi_app2_csr_bvalid(0),
    s_axi_csr_rdata(31 downto 0)              => axi_app2_csr_rdata(31 downto 0),
    s_axi_csr_rready                          => axi_app2_csr_rready(0),
    s_axi_csr_rresp(1 downto 0)               => axi_app2_csr_rresp(1 downto 0),
    s_axi_csr_rvalid                          => axi_app2_csr_rvalid(0),
    s_axi_csr_wdata(31 downto 0)              => axi_app2_csr_wdata(31 downto 0),
    s_axi_csr_wready                          => axi_app2_csr_wready(0),
    s_axi_csr_wstrb(3 downto 0)               => axi_app2_csr_wstrb(3 downto 0),
    s_axi_csr_wvalid                          => axi_app2_csr_wvalid(0)
  );   
        
data_acq_i: data_acq_wrapper
port map (
   adc0_fifo_full_stat                        => adc0_fifo_full_stat,
   adc1_fifo_full_stat                        => adc1_fifo_full_stat,
   adc2_fifo_full_stat                        => adc2_fifo_full_stat,
   ddr4_ui_clk                                => ddr4_ui_clk,       
   realtime_lost_stat                         => dac_realtime_lost_stat,
   m_axis_pcie_rq_tdata                       => axis_pcie_rq_tdata, 
   m_axis_pcie_rq_tkeep                       => axis_pcie_rq_tkeep, 
   m_axis_pcie_rq_tlast                       => axis_pcie_rq_tlast(0), 
   m_axis_pcie_rq_tready                      => axis_pcie_rq_tready(0),
   m_axis_pcie_rq_tuser                       => axis_pcie_rq_tuser, 
   m_axis_pcie_rq_tvalid                      => axis_pcie_rq_tvalid(0),
   s_axis_pcie_rc_tdata                       => axis_pcie_rc_tdata,  
   s_axis_pcie_rc_tkeep                       => axis_pcie_rc_tkeep,  
   s_axis_pcie_rc_tlast                       => axis_pcie_rc_tlast,  
   s_axis_pcie_rc_tready                      => axis_pcie_rc_tready, 
   s_axis_pcie_rc_tuser                       => axis_pcie_rc_tuser,  
   s_axis_pcie_rc_tvalid                      => axis_pcie_rc_tvalid, 
   pcie_dma_irq                               => pcie_dma_irq,
   pdti2ppkt_irq                              => pdti2ppkt_irq,
   rq_shutdown_ok                             => rq_shutdown_ok,
   s_axi_csr_aclk                             => axi_csr_aclk,                    
   s_axi_csr_aresetn                          => axi_csr_aresetn,                 
   s_axi_csr_araddr                           => axi_acq_csr_araddr(25 downto 0),
   s_axi_csr_arprot                           => axi_acq_csr_arprot(2 downto 0), 
   s_axi_csr_arready                          => axi_acq_csr_arready(0),         
   s_axi_csr_arvalid                          => axi_acq_csr_arvalid(0),         
   s_axi_csr_awaddr                           => axi_acq_csr_awaddr(25 downto 0),
   s_axi_csr_awprot                           => axi_acq_csr_awprot(2 downto 0), 
   s_axi_csr_awready                          => axi_acq_csr_awready(0),         
   s_axi_csr_awvalid                          => axi_acq_csr_awvalid(0),         
   s_axi_csr_bready                           => axi_acq_csr_bready(0),          
   s_axi_csr_bresp                            => axi_acq_csr_bresp(1 downto 0),  
   s_axi_csr_bvalid                           => axi_acq_csr_bvalid(0),          
   s_axi_csr_rdata                            => axi_acq_csr_rdata(31 downto 0), 
   s_axi_csr_rready                           => axi_acq_csr_rready(0),          
   s_axi_csr_rresp                            => axi_acq_csr_rresp(1 downto 0),  
   s_axi_csr_rvalid                           => axi_acq_csr_rvalid(0),          
   s_axi_csr_wdata                            => axi_acq_csr_wdata(31 downto 0), 
   s_axi_csr_wready                           => axi_acq_csr_wready(0),          
   s_axi_csr_wstrb                            => axi_acq_csr_wstrb(3 downto 0),  
   s_axi_csr_wvalid                           => axi_acq_csr_wvalid(0),     
   s_axis_adc_pdti_aclk                       => axis_adc_pdti_aclk,   
   s_axis_adc_pdti_aresetn                    => axis_adc_pdti_aresetn,
   s_axis_dac_pdti_aclk                       => axis_dac_pdti_aclk,   
   s_axis_dac_pdti_aresetn                    => axis_dac_pdti_aresetn,
   s_axis_adc_ch0_pdti_tdata                  => axis_app2_adc_ch0_pdti_tdata(31 downto 0), 
   s_axis_adc_ch0_pdti_tuser                  => axis_app2_adc_ch0_pdti_tuser(127 downto 0),
   s_axis_adc_ch0_pdti_tvalid                 => axis_app2_adc_ch0_pdti_tvalid,             
   s_axis_adc_ch1_pdti_tdata                  => axis_app2_adc_ch1_pdti_tdata(31 downto 0), 
   s_axis_adc_ch1_pdti_tuser                  => axis_app2_adc_ch1_pdti_tuser(127 downto 0),
   s_axis_adc_ch1_pdti_tvalid                 => axis_app2_adc_ch1_pdti_tvalid,             
   s_axis_adc_ch2_pdti_tdata                  => axis_app2_adc_ch2_pdti_tdata(31 downto 0), 
   s_axis_adc_ch2_pdti_tuser                  => axis_app2_adc_ch2_pdti_tuser(127 downto 0),
   s_axis_adc_ch2_pdti_tvalid                 => axis_app2_adc_ch2_pdti_tvalid,             
   m_axis_dac_pdti_tdata                      => axis_acq_dac_pdti_tdata(31 downto 0), 
   m_axis_dac_pdti_tuser                      => axis_acq_dac_pdti_tuser(127 downto 0),
   m_axis_dac_pdti_tvalid                     => axis_acq_dac_pdti_tvalid,  
   s_axis_dac_pctl_tdata                      => axis_dataio_dac_pctl_tdata(7 downto 0), 
   s_axis_dac_pctl_tvalid                     => axis_dataio_dac_pctl_tvalid,            
   s_axis_dma_pcie_cntl_tdata                 => axis_dma_pcie_cntl_tdata,  
   s_axis_dma_pcie_cntl_tvalid                => axis_dma_pcie_cntl_tvalid, 
   shutdown_rqst                              => shutdown_rqst, 
   m_axis_ddr_rqst_tdata                      => axis_dac_ddr_rqst_tdata,      
   m_axis_ddr_rqst_tid                        => axis_dac_ddr_rqst_tid,        
   m_axis_ddr_rqst_tlast(0)                   => axis_dac_ddr_rqst_tlast,      
   m_axis_ddr_rqst_tready(0)                  => axis_dac_ddr_rqst_tready,     
   m_axis_ddr_rqst_tuser                      => axis_dac_ddr_rqst_tuser,      
   m_axis_ddr_rqst_tvalid                     => axis_dac_ddr_rqst_tvalid,     
   s_axis_wave_ddr_rsp_tdata                  => axis_dac_ddr_rsp_tdata,  
   s_axis_wave_ddr_rsp_tid                    => axis_dac_ddr_rsp_tid,    
   s_axis_wave_ddr_rsp_tlast                  => axis_dac_ddr_rsp_tlast,  
   s_axis_wave_ddr_rsp_tuser                  => axis_dac_ddr_rsp_tuser,  
   s_axis_wave_ddr_rsp_tvalid                 => axis_dac_ddr_rsp_tvalid
   
); 
    

pcie_intrfc_wrapper_i: pcie_intrfc_wrapper
port map (

   -- PCI Express Interface
   sys_clk                                   => sys_clk,
   sys_clk_gt                                => sys_clk_gt,
   
   pcie_perstn_in                            => pcie_perstn_in, --PERST0_N,
   pcie_lane_led0_n                          => KU_LANES_N0,
   pcie_lane_led1_n                          => KU_LANES_N1,
   pcie_link_up                              => CDC_PD_N,
   pcie_link_up_led_n                        => KU_LINKUP_N,
   
   pcie_mgt_rxp(0)                           => PER0P0,
   pcie_mgt_rxp(1)                           => PER0P1,
   pcie_mgt_rxp(2)                           => PER0P2,
   pcie_mgt_rxp(3)                           => PER0P3,
   pcie_mgt_rxp(4)                           => PER0P4,
   pcie_mgt_rxp(5)                           => PER0P5,
   pcie_mgt_rxp(6)                           => PER0P6,
   pcie_mgt_rxp(7)                           => PER0P7,
      
   pcie_mgt_rxn(0)                           => PER0N0,
   pcie_mgt_rxn(1)                           => PER0N1,
   pcie_mgt_rxn(2)                           => PER0N2,
   pcie_mgt_rxn(3)                           => PER0N3,
   pcie_mgt_rxn(4)                           => PER0N4,
   pcie_mgt_rxn(5)                           => PER0N5,
   pcie_mgt_rxn(6)                           => PER0N6,
   pcie_mgt_rxn(7)                           => PER0N7,     
   
   pcie_mgt_txp(0)                           => PET0P0,
   pcie_mgt_txp(1)                           => PET0P1,
   pcie_mgt_txp(2)                           => PET0P2,
   pcie_mgt_txp(3)                           => PET0P3,
   pcie_mgt_txp(4)                           => PET0P4,
   pcie_mgt_txp(5)                           => PET0P5,
   pcie_mgt_txp(6)                           => PET0P6,
   pcie_mgt_txp(7)                           => PET0P7,
      
   pcie_mgt_txn(0)                           => PET0N0,
   pcie_mgt_txn(1)                           => PET0N1,
   pcie_mgt_txn(2)                           => PET0N2,
   pcie_mgt_txn(3)                           => PET0N3,
   pcie_mgt_txn(4)                           => PET0N4,
   pcie_mgt_txn(5)                           => PET0N5,
   pcie_mgt_txn(6)                           => PET0N6,
   pcie_mgt_txn(7)                           => PET0N7,    
   -- I2C Ports
   iic_port0_scl_io                          => I2C_PORT0_SCL,
   iic_port0_sda_io                          => I2C_PORT0_SDA,
   iic_port1_scl_io                          => I2C_PORT1_SCL,
   iic_port1_sda_io                          => I2C_PORT1_SDA,
   mga(2 downto 0)                           => I2C_PORT1_MGA(2 downto 0),
   -- External Temperature Interrupt In
   temp_irq_n                               => TEMP_IRQ_N, 
   -- Voltage Monitoring
   Vaux0_v_n                                 => VAUX0_V_N,
   Vaux0_v_p                                 => VAUX0_V_P,
   Vaux10_v_n                                => VAUX10_V_N,
   Vaux10_v_p                                => VAUX10_V_P,
   Vaux11_v_n                                => VAUX11_V_N,
   Vaux11_v_p                                => VAUX11_V_P,
   Vaux12_v_n                                => VAUX12_V_N,
   Vaux12_v_p                                => VAUX12_V_P,
   Vaux1_v_n                                 => VAUX1_V_N,
   Vaux1_v_p                                 => VAUX1_V_P,
   Vaux2_v_n                                 => VAUX2_V_N,
   Vaux2_v_p                                 => VAUX2_V_P,
   Vaux3_v_n                                 => VAUX3_V_N,
   Vaux3_v_p                                 => VAUX3_V_P,
   Vaux4_v_n                                 => VAUX4_V_N,
   Vaux4_v_p                                 => VAUX4_V_P,
   Vaux8_v_n                                 => VAUX8_V_N,
   Vaux8_v_p                                 => VAUX8_V_P,
   Vaux9_v_n                                 => VAUX9_V_N,
   Vaux9_v_p                                 => VAUX9_V_P,
   Vp_Vn_v_n                                 => VP_VN_V_N,
   Vp_Vn_v_p                                 => VP_VN_V_P,
   -- Front Panel I/O Type from Front Panel
   fpio_type(3 downto 0)                     => FPIO_TYPE(3 downto 0),
   -- System Monitor LED
   sys_mon_led_n                             => SYS_MON_LED_N,
   -- User LED       
   user_led_n                                => USER_LED_N,
   --------------------------------------------------------------------------
   -- Internal Interfaces
   --------------------------------------------------------------------------
   -- Interrupts
   dataio_irq                                => dataio_irq,
   time_irq                                  => timestamp_irq,
   user1_irq                                 => user1_irq,
   user2_irq                                 => user2_irq,
   dataiopkt_irq                             => pdti2ppkt_irq,
   dma_irq                                   => pcie_dma_irq,
   dsp_irq                                   => dsp_irq,
   -- AXI4-Lite Control Bus to User Application Space #1    
   m_axi_csr_aclk                            => axi_csr_aclk,
   m_axi_csr_aresetn                         => axi_csr_aresetn,
   m_axi_user1_csr_araddr                    => axi_app1_csr_araddr,
   m_axi_user1_csr_arprot(2 downto 0)        => axi_app1_csr_arprot(2 downto 0),
   m_axi_user1_csr_arready(0)                => axi_app1_csr_arready(0),
   m_axi_user1_csr_arvalid(0)                => axi_app1_csr_arvalid(0),
   m_axi_user1_csr_awaddr                    => axi_app1_csr_awaddr,
   m_axi_user1_csr_awprot(2 downto 0)        => axi_app1_csr_awprot(2 downto 0),
   m_axi_user1_csr_awready(0)                => axi_app1_csr_awready(0),
   m_axi_user1_csr_awvalid(0)                => axi_app1_csr_awvalid(0),
   m_axi_user1_csr_bready(0)                 => axi_app1_csr_bready(0),
   m_axi_user1_csr_bresp(1 downto 0)         => axi_app1_csr_bresp(1 downto 0),
   m_axi_user1_csr_bvalid(0)                 => axi_app1_csr_bvalid(0),
   m_axi_user1_csr_rdata(31 downto 0)        => axi_app1_csr_rdata(31 downto 0),
   m_axi_user1_csr_rready(0)                 => axi_app1_csr_rready(0),
   m_axi_user1_csr_rresp(1 downto 0)         => axi_app1_csr_rresp(1 downto 0),
   m_axi_user1_csr_rvalid(0)                 => axi_app1_csr_rvalid(0),
   m_axi_user1_csr_wdata(31 downto 0)        => axi_app1_csr_wdata(31 downto 0),
   m_axi_user1_csr_wready(0)                 => axi_app1_csr_wready(0),
   m_axi_user1_csr_wstrb(3 downto 0)         => axi_app1_csr_wstrb(3 downto 0),
   m_axi_user1_csr_wvalid(0)                 => axi_app1_csr_wvalid(0),
   -- AXI4-Lite Control Bus to User Application Space #2    
   m_axi_user2_csr_araddr                    => axi_app2_csr_araddr,
   m_axi_user2_csr_arprot(2 downto 0)        => axi_app2_csr_arprot(2 downto 0),
   m_axi_user2_csr_arready(0)                => axi_app2_csr_arready(0),
   m_axi_user2_csr_arvalid(0)                => axi_app2_csr_arvalid(0),
   m_axi_user2_csr_awaddr                    => axi_app2_csr_awaddr,
   m_axi_user2_csr_awprot(2 downto 0)        => axi_app2_csr_awprot(2 downto 0),
   m_axi_user2_csr_awready(0)                => axi_app2_csr_awready(0),
   m_axi_user2_csr_awvalid(0)                => axi_app2_csr_awvalid(0),
   m_axi_user2_csr_bready(0)                 => axi_app2_csr_bready(0),
   m_axi_user2_csr_bresp(1 downto 0)         => axi_app2_csr_bresp(1 downto 0),
   m_axi_user2_csr_bvalid(0)                 => axi_app2_csr_bvalid(0),
   m_axi_user2_csr_rdata(31 downto 0)        => axi_app2_csr_rdata(31 downto 0),
   m_axi_user2_csr_rready(0)                 => axi_app2_csr_rready(0),
   m_axi_user2_csr_rresp(1 downto 0)         => axi_app2_csr_rresp(1 downto 0),
   m_axi_user2_csr_rvalid(0)                 => axi_app2_csr_rvalid(0),
   m_axi_user2_csr_wdata(31 downto 0)        => axi_app2_csr_wdata(31 downto 0),
   m_axi_user2_csr_wready(0)                 => axi_app2_csr_wready(0),
   m_axi_user2_csr_wstrb(3 downto 0)         => axi_app2_csr_wstrb(3 downto 0),
   m_axi_user2_csr_wvalid(0)                 => axi_app2_csr_wvalid(0),     
   -- AXI4-Lite Control Bus to Dataio Front End Interfaces     
   m_axi_dataio_csr_araddr                   => axi_dataio_csr_araddr,
   m_axi_dataio_csr_arprot(2 downto 0)       => axi_dataio_csr_arprot(2 downto 0),
   m_axi_dataio_csr_arready(0)               => axi_dataio_csr_arready(0),
   m_axi_dataio_csr_arvalid(0)               => axi_dataio_csr_arvalid(0),
   m_axi_dataio_csr_awaddr                   => axi_dataio_csr_awaddr,
   m_axi_dataio_csr_awprot(2 downto 0)       => axi_dataio_csr_awprot(2 downto 0),
   m_axi_dataio_csr_awready(0)               => axi_dataio_csr_awready(0),
   m_axi_dataio_csr_awvalid(0)               => axi_dataio_csr_awvalid(0),
   m_axi_dataio_csr_bready(0)                => axi_dataio_csr_bready(0),
   m_axi_dataio_csr_bresp(1 downto 0)        => axi_dataio_csr_bresp(1 downto 0),
   m_axi_dataio_csr_bvalid(0)                => axi_dataio_csr_bvalid(0),
   m_axi_dataio_csr_rdata(31 downto 0)       => axi_dataio_csr_rdata(31 downto 0),
   m_axi_dataio_csr_rready(0)                => axi_dataio_csr_rready(0),
   m_axi_dataio_csr_rresp(1 downto 0)        => axi_dataio_csr_rresp(1 downto 0),
   m_axi_dataio_csr_rvalid(0)                => axi_dataio_csr_rvalid(0),
   m_axi_dataio_csr_wdata(31 downto 0)       => axi_dataio_csr_wdata(31 downto 0),
   m_axi_dataio_csr_wready(0)                => axi_dataio_csr_wready(0),
   m_axi_dataio_csr_wstrb(3 downto 0)        => axi_dataio_csr_wstrb(3 downto 0),
   m_axi_dataio_csr_wvalid(0)                => axi_dataio_csr_wvalid(0),
   -- AXI4-Lite Control Bus to DSP Block     
   m_axi_dsp_csr_araddr                      => axi_dsp_csr_araddr,
   m_axi_dsp_csr_arprot(2 downto 0)          => axi_dsp_csr_arprot(2 downto 0),
   m_axi_dsp_csr_arready(0)                  => axi_dsp_csr_arready(0),
   m_axi_dsp_csr_arvalid(0)                  => axi_dsp_csr_arvalid(0),
   m_axi_dsp_csr_awaddr                      => axi_dsp_csr_awaddr,
   m_axi_dsp_csr_awprot(2 downto 0)          => axi_dsp_csr_awprot(2 downto 0),
   m_axi_dsp_csr_awready(0)                  => axi_dsp_csr_awready(0),
   m_axi_dsp_csr_awvalid(0)                  => axi_dsp_csr_awvalid(0),
   m_axi_dsp_csr_bready(0)                   => axi_dsp_csr_bready(0),
   m_axi_dsp_csr_bresp(1 downto 0)           => axi_dsp_csr_bresp(1 downto 0),
   m_axi_dsp_csr_bvalid(0)                   => axi_dsp_csr_bvalid(0),
   m_axi_dsp_csr_rdata(31 downto 0)          => axi_dsp_csr_rdata(31 downto 0),
   m_axi_dsp_csr_rready(0)                   => axi_dsp_csr_rready(0),
   m_axi_dsp_csr_rresp(1 downto 0)           => axi_dsp_csr_rresp(1 downto 0),
   m_axi_dsp_csr_rvalid(0)                   => axi_dsp_csr_rvalid(0),
   m_axi_dsp_csr_wdata(31 downto 0)          => axi_dsp_csr_wdata(31 downto 0),
   m_axi_dsp_csr_wready(0)                   => axi_dsp_csr_wready(0),
   m_axi_dsp_csr_wstrb(3 downto 0)           => axi_dsp_csr_wstrb(3 downto 0),
   m_axi_dsp_csr_wvalid(0)                   => axi_dsp_csr_wvalid(0),
   -- AXI4-Lite Control Bus to Data Acquisition Block     
   m_axi_acq_csr_araddr                      => axi_acq_csr_araddr,
   m_axi_acq_csr_arprot(2 downto 0)          => axi_acq_csr_arprot(2 downto 0),
   m_axi_acq_csr_arready(0)                  => axi_acq_csr_arready(0),
   m_axi_acq_csr_arvalid(0)                  => axi_acq_csr_arvalid(0),
   m_axi_acq_csr_awaddr                      => axi_acq_csr_awaddr,
   m_axi_acq_csr_awprot(2 downto 0)          => axi_acq_csr_awprot(2 downto 0),
   m_axi_acq_csr_awready(0)                  => axi_acq_csr_awready(0),
   m_axi_acq_csr_awvalid(0)                  => axi_acq_csr_awvalid(0),
   m_axi_acq_csr_bready(0)                   => axi_acq_csr_bready(0),
   m_axi_acq_csr_bresp(1 downto 0)           => axi_acq_csr_bresp(1 downto 0),
   m_axi_acq_csr_bvalid(0)                   => axi_acq_csr_bvalid(0),
   m_axi_acq_csr_rdata(31 downto 0)          => axi_acq_csr_rdata(31 downto 0),
   m_axi_acq_csr_rready(0)                   => axi_acq_csr_rready(0),
   m_axi_acq_csr_rresp(1 downto 0)           => axi_acq_csr_rresp(1 downto 0),
   m_axi_acq_csr_rvalid(0)                   => axi_acq_csr_rvalid(0),
   m_axi_acq_csr_wdata(31 downto 0)          => axi_acq_csr_wdata(31 downto 0),
   m_axi_acq_csr_wready(0)                   => axi_acq_csr_wready(0),
   m_axi_acq_csr_wstrb(3 downto 0)           => axi_acq_csr_wstrb(3 downto 0),
   m_axi_acq_csr_wvalid(0)                   => axi_acq_csr_wvalid(0),
   -- AXI4-Lite Control Bus to DDR4 RAM Controller Block   
   m_axi_ddr4_csr_awaddr                     => axi_ddr4_csr_awaddr, 
   m_axi_ddr4_csr_awprot(2 downto 0)         => axi_ddr4_csr_awprot(2 downto 0), 
   m_axi_ddr4_csr_awvalid(0)                 => axi_ddr4_csr_awvalid(0),
   m_axi_ddr4_csr_awready(0)                 => axi_ddr4_csr_awready(0),
   m_axi_ddr4_csr_wdata                      => axi_ddr4_csr_wdata,  
   m_axi_ddr4_csr_wstrb(3 downto 0)          => axi_ddr4_csr_wstrb(3 downto 0), 
   m_axi_ddr4_csr_wvalid(0)                  => axi_ddr4_csr_wvalid(0), 
   m_axi_ddr4_csr_wready(0)                  => axi_ddr4_csr_wready(0), 
   m_axi_ddr4_csr_bresp(1 downto 0)          => axi_ddr4_csr_bresp(1 downto 0),  
   m_axi_ddr4_csr_bvalid(0)                  => axi_ddr4_csr_bvalid(0), 
   m_axi_ddr4_csr_bready(0)                  => axi_ddr4_csr_bready(0), 
   m_axi_ddr4_csr_araddr                     => axi_ddr4_csr_araddr, 
   m_axi_ddr4_csr_arprot(2 downto 0)         => axi_ddr4_csr_arprot(2 downto 0), 
   m_axi_ddr4_csr_arvalid(0)                 => axi_ddr4_csr_arvalid(0),
   m_axi_ddr4_csr_arready(0)                 => axi_ddr4_csr_arready(0),
   m_axi_ddr4_csr_rdata                      => axi_ddr4_csr_rdata,  
   m_axi_ddr4_csr_rresp(1 downto 0)          => axi_ddr4_csr_rresp(1 downto 0),  
   m_axi_ddr4_csr_rvalid(0)                  => axi_ddr4_csr_rvalid(0), 
   m_axi_ddr4_csr_rready(0)                  => axi_ddr4_csr_rready(0), 
   --------------------------------------------------------------------------
   -- DDR4 Memory Access AXI-S 
   --------------------------------------------------------------------------         
   s_axis_ddr_rsp_tdata                      => axis_pcie_ddr_rsp_tdata, 
   s_axis_ddr_rsp_tid                        => axis_pcie_ddr_rsp_tid,   
   s_axis_ddr_rsp_tlast                      => axis_pcie_ddr_rsp_tlast, 
   s_axis_ddr_rsp_tuser                      => axis_pcie_ddr_rsp_tuser, 
   s_axis_ddr_rsp_tvalid                     => axis_pcie_ddr_rsp_tvalid,
   m_axis_ddr_rqst_tid                       => axis_pcie_ddr_rqst_tid,   
   m_axis_ddr_rqst_tdata                     => axis_pcie_ddr_rqst_tdata, 
   m_axis_ddr_rqst_tlast                     => axis_pcie_ddr_rqst_tlast, 
   m_axis_ddr_rqst_tuser                     => axis_pcie_ddr_rqst_tuser, 
   m_axis_ddr_rqst_tvalid                    => axis_pcie_ddr_rqst_tvalid,
   m_axis_ddr_rqst_tready                    => axis_pcie_ddr_rqst_tready,
   -----------------------------------------------------------------------------
   -- FLASH Interface
   -----------------------------------------------------------------------------
   flash_d_i                                 => flash_d_i,  
   flash_d_o                                 => flash_d_o,  
   flash_d_t                                 => flash_d_t,  
   flash_a                                   => flash_a,    
   flash_adv_b                               => flash_adv_b,
   flash_fwe_b                               => flash_fwe_b,
   flash_fcs_b                               => flash_fcs_b,
   flash_foe_b                               => flash_foe_b,
   ---------------------------------------------------------------------------
   -- PCIe Misc. Control  interface
   m_axis_dma_pcie_cntl_tdata                => axis_dma_pcie_cntl_tdata, 
   m_axis_dma_pcie_cntl_tvalid               => axis_dma_pcie_cntl_tvalid,

   shutdown_rqst                             => shutdown_rqst,
   rq_shutdown_ok                            => rq_shutdown_ok, 
   s_axis_pcie_rq_tdata                      => axis_pcie_rq_tdata,   
   s_axis_pcie_rq_tkeep                      => axis_pcie_rq_tkeep,   
   s_axis_pcie_rq_tlast                      => axis_pcie_rq_tlast(0),   
   s_axis_pcie_rq_tready                     => axis_pcie_rq_tready(0),  
   s_axis_pcie_rq_tuser                      => axis_pcie_rq_tuser,   
   s_axis_pcie_rq_tvalid                     => axis_pcie_rq_tvalid(0),  
   
   m_axis_pcie_rc_tdata                      => axis_pcie_rc_tdata,  
   m_axis_pcie_rc_tkeep                      => axis_pcie_rc_tkeep,  
   m_axis_pcie_rc_tlast                      => axis_pcie_rc_tlast,  
   m_axis_pcie_rc_tready                     => axis_pcie_rc_tready, 
   m_axis_pcie_rc_tuser                      => axis_pcie_rc_tuser,  
   m_axis_pcie_rc_tvalid                     => axis_pcie_rc_tvalid, 

   startup_eos_in                            => startup_eos,
   sys_mon_alarm                             => open,
   rev                                       => rev_vctr,     
   rev_date                                  => rev_date,
   fpga_size                                 => fpga_size             
);

ddr4_intrfc_wrapper_i: ddr4_intrfc_wrapper
  port map (
    ddr4_sys_rst                 => ddr4_sys_rst,                     
    ddr4_ui_app_addr             => ddr4_ui_app_addr,                 
    ddr4_ui_app_cmd              => ddr4_ui_app_cmd,                  
    ddr4_ui_app_en               => ddr4_ui_app_en,                   
    ddr4_ui_app_hi_pri           => ddr4_ui_app_hi_pri,               
    ddr4_ui_app_rd_data          => ddr4_ui_app_rd_data,              
    ddr4_ui_app_rd_data_end      => ddr4_ui_app_rd_data_end,          
    ddr4_ui_app_rd_data_valid    => ddr4_ui_app_rd_data_valid,        
    ddr4_ui_app_rdy              => ddr4_ui_app_rdy,                  
    ddr4_ui_app_wdf_data         => ddr4_ui_app_wdf_data,             
    ddr4_ui_app_wdf_end          => ddr4_ui_app_wdf_end,              
    ddr4_ui_app_wdf_mask         => ddr4_ui_app_wdf_mask,             
    ddr4_ui_app_wdf_rdy          => ddr4_ui_app_wdf_rdy,              
    ddr4_ui_app_wdf_wren         => ddr4_ui_app_wdf_wren,             
    ddr4_ui_clk                  => ddr4_ui_clk,                      
    init_calib_complete          => init_calib_complete,  
    m_axis_dac_ddr_rsp_tdata     => axis_dac_ddr_rsp_tdata,        
    m_axis_dac_ddr_rsp_tid       => axis_dac_ddr_rsp_tid,          
    m_axis_dac_ddr_rsp_tlast     => axis_dac_ddr_rsp_tlast,       
    m_axis_dac_ddr_rsp_tuser     => axis_dac_ddr_rsp_tuser,        
    m_axis_dac_ddr_rsp_tvalid    => axis_dac_ddr_rsp_tvalid, 
    m_axis_pcie_ddr_rsp_tdata    => axis_pcie_ddr_rsp_tdata,        
    m_axis_pcie_ddr_rsp_tid      => axis_pcie_ddr_rsp_tid,          
    m_axis_pcie_ddr_rsp_tlast    => axis_pcie_ddr_rsp_tlast,       
    m_axis_pcie_ddr_rsp_tuser    => axis_pcie_ddr_rsp_tuser,        
    m_axis_pcie_ddr_rsp_tvalid   => axis_pcie_ddr_rsp_tvalid, 
    m_axis_pcie_ddr_rsp_tready   => '1',       
    s_axi_csr_araddr             => axi_ddr4_csr_araddr(6 downto 0),            
    s_axi_csr_arprot             => axi_ddr4_csr_arprot,            
    s_axi_csr_arready            => axi_ddr4_csr_arready(0),           
    s_axi_csr_arvalid            => axi_ddr4_csr_arvalid(0),           
    s_axi_csr_awaddr             => axi_ddr4_csr_awaddr(6 downto 0),            
    s_axi_csr_awprot             => axi_ddr4_csr_awprot,            
    s_axi_csr_awready            => axi_ddr4_csr_awready(0),           
    s_axi_csr_awvalid            => axi_ddr4_csr_awvalid(0),           
    s_axi_csr_bready             => axi_ddr4_csr_bready(0),            
    s_axi_csr_bresp              => axi_ddr4_csr_bresp,             
    s_axi_csr_bvalid             => axi_ddr4_csr_bvalid(0),            
    s_axi_csr_rdata              => axi_ddr4_csr_rdata,             
    s_axi_csr_rready             => axi_ddr4_csr_rready(0),            
    s_axi_csr_rresp              => axi_ddr4_csr_rresp,             
    s_axi_csr_rvalid             => axi_ddr4_csr_rvalid(0),            
    s_axi_csr_wdata              => axi_ddr4_csr_wdata,            
    s_axi_csr_wready             => axi_ddr4_csr_wready(0),            
    s_axi_csr_wstrb              => axi_ddr4_csr_wstrb,             
    s_axi_csr_wvalid             => axi_ddr4_csr_wvalid(0),            
    s_axi_csr_aclk               => axi_csr_aclk,                    
    s_axi_csr_aresetn            => axi_csr_aresetn, 
    s_axis_aresetn               => ddr4_ui_rstn,               
    s_axis_pcie_ddr_rqst_tdata   => axis_pcie_ddr_rqst_tdata,       
    s_axis_pcie_ddr_rqst_tid     => axis_pcie_ddr_rqst_tid,         
    s_axis_pcie_ddr_rqst_tlast   => axis_pcie_ddr_rqst_tlast,       
    s_axis_pcie_ddr_rqst_tready  => axis_pcie_ddr_rqst_tready,      
    s_axis_pcie_ddr_rqst_tuser   => axis_pcie_ddr_rqst_tuser,       
    s_axis_pcie_ddr_rqst_tvalid  => axis_pcie_ddr_rqst_tvalid,
    s_axis_dac_ddr_rqst_tdata    => axis_dac_ddr_rqst_tdata, 
    s_axis_dac_ddr_rqst_tid      => axis_dac_ddr_rqst_tid,   
    s_axis_dac_ddr_rqst_tlast    => axis_dac_ddr_rqst_tlast, 
    s_axis_dac_ddr_rqst_tready   => axis_dac_ddr_rqst_tready,
    s_axis_dac_ddr_rqst_tuser    => axis_dac_ddr_rqst_tuser, 
    s_axis_dac_ddr_rqst_tvalid   => axis_dac_ddr_rqst_tvalid
  );

ddr4_ctlr_inst: ddr4_80_ctlr
port map (
   c0_init_calib_complete   => init_calib_complete,
   c0_sys_clk_p             => C0_SYS_CLK_P,   
   c0_sys_clk_n             => C0_SYS_CLK_N,   
   c0_ddr4_adr              => C0_DDR4_ADR,    
   c0_ddr4_ba               => C0_DDR4_BA,     
   c0_ddr4_cke              => C0_DDR4_CKE,    
   c0_ddr4_cs_n             => C0_DDR4_CS_N,   
   c0_ddr4_dm_dbi_n         => C0_DDR4_DM_DBI_N,
   c0_ddr4_dq               => C0_DDR4_DQ,     
   c0_ddr4_dqs_c            => C0_DDR4_DQS_C,  
   c0_ddr4_dqs_t            => C0_DDR4_DQS_T,  
   c0_ddr4_odt              => C0_DDR4_ODT,    
   c0_ddr4_bg               => C0_DDR4_BG,     
   c0_ddr4_reset_n          => C0_DDR4_RESET_N,
   c0_ddr4_act_n            => C0_DDR4_ACT_N,  
   c0_ddr4_ck_c             => C0_DDR4_CK_C,   
   c0_ddr4_ck_t             => C0_DDR4_CK_T,   
   c0_ddr4_ui_clk           => ddr4_ui_clk,
   c0_ddr4_ui_clk_sync_rst  => ddr4_ui_clk_sync_rst,
   c0_ddr4_app_en           => ddr4_ui_app_en, 
   c0_ddr4_app_hi_pri       => ddr4_ui_app_hi_pri, 
   c0_ddr4_app_wdf_end      => ddr4_ui_app_wdf_end, 
   c0_ddr4_app_wdf_wren     => ddr4_ui_app_wdf_wren,
   c0_ddr4_app_rd_data_end  => ddr4_ui_app_rd_data_end,  
   c0_ddr4_app_rd_data_valid=> ddr4_ui_app_rd_data_valid,      
   c0_ddr4_app_rdy          => ddr4_ui_app_rdy,
   c0_ddr4_app_wdf_rdy      => ddr4_ui_app_wdf_rdy,
   c0_ddr4_app_addr         => ddr4_ui_app_addr(28 downto 0), 
   c0_ddr4_app_cmd          => ddr4_ui_app_cmd, 
   c0_ddr4_app_wdf_data     => ddr4_ui_app_wdf_data,
   c0_ddr4_app_wdf_mask     => ddr4_ui_app_wdf_mask,
   c0_ddr4_app_rd_data      => ddr4_ui_app_rd_data, 
   sys_rst                  => ddr4_sys_rst
); 

ddr4_ui_rstn <= not ddr4_ui_clk_sync_rst;

--------------------------------------------------------------------------------
-- PCIe System Clocks
--------------------------------------------------------------------------------

-- GTX Clock Buffer
PCIE_IBUFDS_GTE3_inst: IBUFDS_GTE3
port map (
   I     => PCIE_MGTREFCLK_P,
   IB    => PCIE_MGTREFCLK_N,
   O     => sys_clk_gt,
   ODIV2 => sys_clk,
   CEB   => '0'
);

PERST0_N_ibuf : IBUF
port map (
      O => pcie_perstn_in, -- 1-bit output: Buffer output
      I => PERST0_N   -- 1-bit input: Buffer input
   );
   
--------------------------------------------------------------------------------
-- IDELAY Controls
--------------------------------------------------------------------------------

-- 200MHz Reference Clock
IBUFGDS_refclk_inst : IBUFGDS
generic map (
   DIFF_TERM    => TRUE, 
   IBUF_LOW_PWR => TRUE,
   IOSTANDARD   => "LVDS"
)
port map (
   I  => REF_CLK_P, 
   IB => REF_CLK_N, 
   O  => ref_clk_i
);

BUFG_refclk_inst : BUFG
port map (
  O => ref_clk, -- 1-bit output: Clock output
  I => ref_clk_i  -- 1-bit input: Clock input
);

-- Generate idelaycntrl reset
process(ref_clk)
begin 
    if rising_edge(ref_clk) then
        if idelayctrl_cntr /= x"FF" then
           idelayctrl_cntr <= idelayctrl_cntr + 1;
        end if;   
        if idelayctrl_cntr(7) = '0' then  
            idelayctrl_rst <= '1';
        else
            idelayctrl_rst <= '0';
        end if;       
    end if;
end process;

IDELAYCTRL_inst1 : IDELAYCTRL
generic map (
      SIM_DEVICE => "ULTRASCALE"  -- Set the device version (7SERIES, ULTRASCALE)
   )
port map (
  RDY    => open,           -- 1-bit output: Ready output
  REFCLK => ref_clk,        -- 1-bit input: Reference clock input
  RST    => idelayctrl_rst  -- 1-bit input: Active high reset input
);


STARTUPE3_inst : component STARTUPE3
generic map (
  PROG_USR      => "FALSE", -- Activate program event security feature.
  SIM_CCLK_FREQ => 0.0      -- Set the Configuration Clock Frequency(ns) for simulation.
)
port map
(
  CFGCLK    => open,                 -- 1-bit output: Configuration main clock output
  CFGMCLK   => open,                 -- 1-bit output: Configuration internal oscillator clock output
  DI        => flash_d_i(3 downto 0),-- 4-bit output: Allow receiving on the D input pin
  EOS       => startup_eos,          -- 1-bit output: Active-High output signal indicating the End Of Startup
  PREQ      => open,                 -- 1-bit output: PROGRAM request to fabric output
  DO        => flash_d_o(3 downto 0),-- 4-bit input: Allows control of the D pin output
  DTS       => flash_d_t(3 downto 0),-- 4-bit input: Allows tristate of the D pin
  FCSBO     => flash_fcs_b,          -- 1-bit input: Contols the FCS_B pin for flash access
  FCSBTS    => '0',                  -- 1-bit input: Tristate the FCS_B pin
  GSR       => '0',                  -- 1-bit input: Global Set/Reset input (GSR cannot be used for the port)
  GTS       => '0',                  -- 1-bit input: Global 3-state input (GTS cannot be used for the port name)
  KEYCLEARB => '0',                  -- 1-bit input: Clear AES Decrypter Key input from Battery-Backed RAM (BBRAM)
  PACK      => '0',                  -- 1-bit input: PROGRAM acknowledge input
  USRCCLKO  => '0',                  -- 1-bit input: User CCLK input
  USRCCLKTS => '0',                  -- 1-bit input: User CCLK 3-state enable input
  USRDONEO  => '1',                  -- 1-bit input: User DONE pin output control
  USRDONETS => '1'                   -- 1-bit input: User DONE 3-state enable output
);

gen_flash_io: for i in 4 to 15 generate
flsh_iobuf : IOBUF
   port map
   (
     I  => flash_d_o(i),
     IO => CONFIG_DQ(i),
     O  => flash_d_i(i),
     T  => flash_d_t(i)
   );
end generate;

CONFIG_A <= flash_a;
ADV_N    <= flash_adv_b;
FWE_N    <= flash_fwe_b;
FOE_N    <= flash_foe_b;

gpio_regs : component p14_gpio
port map (
    ADC_CLK         => axis_adc_pdti_aclk,
    P14GPIO_P       => P14GPIO_P,
    P14GPIO_N       => P14GPIO_N,
    CONTROL_FLAGS   => CONTROL_FLAGS,
    MT_PULSE        => MT_PULSE,
    PPS             => p14_gpio_pps,
    STATUS_FLAGS    => STATUS_FLAGS,
    ROT_A           => ROT_A,
    ROT_B           => ROT_B,
    TILT_A          => TILT_A,
    TILT_B          => TILT_B,
    AZ_MOSI         => AZ_MOSI,
    AZ_SCK          => AZ_SCK,
    AZ_SSEL         => AZ_SSEL,
    EL_MOSI         => EL_MOSI,
    EL_SCK          => EL_SCK
);

end Behavioral;
