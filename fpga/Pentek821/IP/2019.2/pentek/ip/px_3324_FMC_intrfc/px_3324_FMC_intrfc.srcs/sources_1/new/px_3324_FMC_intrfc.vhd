-------------------------------------------------------------------------------
-- ************************************************************************* --
-- ****    FMC Control Interfaces for the Model 33240 in Kintex-Ultra   **** --
-- ************************************************************************* --
-------------------------------------------------------------------------------
--  Copyright (c) 2018 Pentek, Inc.  All rights reserved.
-------------------------------------------------------------------------------
-- Title        : 3324x FPGA, SPI & TWSI Interfaces and LMK Control
-- Project      : Model 3324x
-------------------------------------------------------------------------------
---------  Technical Support for Pentek's GateFlow FPGA Design Kits   ---------
-------------------------------------------------------------------------------
--        Technical support for Pentek's GateFlow FPGA Design Kits is        --
--   available via e-mail (fpgasupport@pentek.com) or by phone (201-818-5900 --
--            ext. 238, 9 AM to 5 PM US Eastern time.) Names or              --
--  initials contained within the source code are part of our revision       --
--   control regime.  Please do not try to use these references to pursue    --
--                            technical support                              --
-------------------------------------------------------------------------------
-- Filename     : px_3324_FMC_intrfc_top.vhd
-- Created      : 06/22/2018
--                Pentek, Inc.
--                One Park Way
--                Upper Saddle River, NJ  07458
--                (201) 818-5900
--                www.pentek.com
-------------------------------------------------------------------------------
-- ******************************* Change Log ****************************** --
-- $History: px_3324_FMC_intrfc_top.vhd $
--
-- 06/22/2018: Created
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: 
-- SPI and TWSI interfaces and LMK Control for the components on the 3324x FMC,
-- targeting the Kintex-Ultra FPGA.
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--
-- Memory Map
-- 0x00 - SPI Interface Control
--           Bit 0 - SPI Reset
--           Bit 1 - SPI Read
--           Bit 2 - SPI Write
--           Bits 5:3 - Device Select: 100 = LMK, 011 = DAC1, 010 = DAC0, 001 = ADC1, 000 = ADC0
--           Bit 6 - Mode: 0 = 4-Wire, 1 = 3-Wire
--           Bit 7 - Data Length: 0 = 8-Bit, 1 = 16-bit
--           Bits 23:8 - SPI Address
--           Bits 31:24 - RESERVED
--
-- 0x04 - SPI Interface Write Data
--           Bits 15:0 - SPI Write Data
--           Bits 31:16 - RESERVED
--
-- 0x08 - SPI Interface Start
--           Bit 0 - Start SPI Transaction
--           Bits 31:1 - RESERVED
--
-- 0x0C - TWSI Interface Control
--           Bits 3:0 - Number of Data Bytes - 1
--           Bit 4 - TWSI Port Enable
--           Bit 5 - TWSI Port Data Direction: 0 = WRITE, 1 = READ
--           Bit 6, 7 - RESERVED
--           Bits 14:8 - TWSI Address
--           Bits 31:15 -  RESERVED
--
-- 0x10 - TWSI Interface Write Data
--           Bits 7:0 - TWSI Write Data
--           Bits 31:8 - RESERVED
--
-- 0x14 - TWSI Interface Start
--           Bit 0 - Start TWSI Transaction
--           Bits 31:1 - RESERVED
--
-- 0x18 - LMK Control
--           Bit 0 - LMK CLKIN_SEL0
--           Bit 1 - LMK CLKIN_SEL1
--           Bits 3:2 - RESERVED
--           Bit 4 - LMK Reset (active HIGH)
--           Bit 5 - LMK Reference Slect: 0 = EXTERNAL, 1 = INTERNAL
--           Bit 6 - PLL1 Reference Enable <NOT USED on 33240 FMC>
--           Bit 7 - PLL2 Reference Enable
--           Bit 8 - GATE_B_SEL
--           Bit 9 - SYSREF_SYNC
--           Bits 31:10 - RESERVED
--
-- 0x1C - SPI Interface Status
--           Bit 0 - SPI Write Ready
--           Bits 31:1 - RESERVED
--
-- 0x20 - SPI Interface Read Data
--           Bits 15:0 - SPI Read Data
--           Bits 31:16 - RESERVED
--
-- 0x24 - TWSI Interface Status
--           Bit 0 - TWSI Interface BUSY
--           Bit 1 - TWSI Write FIFO Empty
--           Bit 2 - TWSI Write FIFO Full
--           Bits 4:3 - RESERVED
--           Bit 5 - TWSI Read FIFO Empty
--           Bit 6 - TWSI Read FIFO Full
--           Bit 7 - RESERVED
--           Bits 12:8 - Read FIFO Count
--           Bits 31:13 - RESERVED
--
-- 0x28 - TWSI Interface Read Data
--           Bits 7:0 - TWSI Read Data
--           Bits 31:8 - RESERVED
--
-- 0x2C - LMK Status
--           Bit 0 - LMK STATUS_LD1
--           Bit 1 - LMK STATIS_LD2
--           Bits 31:2 - RESERVED
--
-- 0x30 - Reserved
--
--
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--
-- (c) Copyright 2018 Pentek, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Pentek, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Pentek, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND PENTEK HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Pentek shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Pentek had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Pentek products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Pentek products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-------------------------------------------------------------------------------
-- Main Entity
-------------------------------------------------------------------------------

entity px_3324_FMC_intrfc_top is
port (
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   --------------------------------------------------------------------------------
   s_axi_csr_aclk          : in  std_logic;                         
   s_axi_csr_araddr        : in  std_logic_vector ( 6 downto 0 );
   s_axi_csr_aresetn       : in  std_logic;
   s_axi_csr_arprot        : in  std_logic_vector ( 2 downto 0 );
   s_axi_csr_arready       : out std_logic;
   s_axi_csr_arvalid       : in  std_logic;
   s_axi_csr_awaddr        : in  std_logic_vector ( 6 downto 0 );
   s_axi_csr_awprot        : in  std_logic_vector ( 2 downto 0 );
   s_axi_csr_awready       : out std_logic;
   s_axi_csr_awvalid       : in  std_logic;
   s_axi_csr_bready        : in  std_logic;
   s_axi_csr_bresp         : out std_logic_vector ( 1 downto 0 );
   s_axi_csr_bvalid        : out std_logic;
   s_axi_csr_rdata         : out std_logic_vector ( 31 downto 0 );
   s_axi_csr_rready        : in  std_logic;
   s_axi_csr_rresp         : out std_logic_vector ( 1 downto 0 );
   s_axi_csr_rvalid        : out std_logic;
   s_axi_csr_wdata         : in  std_logic_vector ( 31 downto 0 );
   s_axi_csr_wready        : out std_logic;
   s_axi_csr_wstrb         : in  std_logic_vector ( 3 downto 0 );
   s_axi_csr_wvalid        : in  std_logic;
 
   --------------------------------------------------------------------------------
   -- System Level Clock and Reset  
   --------------------------------------------------------------------------------
   PCIE_CLK                : in  std_logic;
   LRST_N                  : in  std_logic;

   ----------------------------------------------------------------------------
   -- TWSI Serial Bus
   ----------------------------------------------------------------------------
   TWSI_SDA                : inout std_logic;
   TWSI_SCL                : inout std_logic;
   
   TRNS_DONE_INT           : out std_logic;  -- Transfer Done Interrupt
   NO_ACK_INT              : out std_logic;  -- No Acknowledge Interrupt

   
   -----------------------------------------------------------------------------
   -- SPI  Serial Bus
   -----------------------------------------------------------------------------
   SDIO                    : inout std_logic;
   SDENB                   : out std_logic_vector(4 downto 0);
   SCLK                    : out std_logic;
   SDO                     : in  std_logic_vector(4 downto 0);
   
   ----------------------------------------------------------------------------
   -- LMK04828B Control and Status
   ----------------------------------------------------------------------------
   INT_REF_SEL             : out std_logic;
   JESD_RESET_GPO          : out std_logic;
   PLL1_CLKIN_SEL0         : out std_logic;
   PLL1_CLKIN_SEL1         : out std_logic;
   PLL1_REF_ENAB           : out std_logic;
   PLL2_REF_ENAB           : out std_logic;
   GATE_B_SEL              : out std_logic;
   SYSREF_SYNC             : out std_logic;
   STATUS_LD1              : in std_logic;
   STATUS_LD2              : in std_logic
 );
end px_3324_FMC_intrfc_top;

architecture Behavioral of px_3324_FMC_intrfc_top is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------
COMPONENT px_3324_FMC_intrfc_csr
  PORT (
    s_axi_csr_aclk         : IN  std_logic;                                           
    s_axi_csr_aresetn      : IN  std_logic;
    s_axi_csr_awaddr       : IN  std_logic_vector(6 DOWNTO 0);
    s_axi_csr_awprot       : IN  std_logic_vector(2 DOWNTO 0);
    s_axi_csr_awvalid      : IN  std_logic;
    s_axi_csr_awready      : OUT std_logic;
    s_axi_csr_wdata        : IN  std_logic_vector(31 DOWNTO 0);
    s_axi_csr_wstrb        : IN  std_logic_vector(3 DOWNTO 0);
    s_axi_csr_wvalid       : IN  std_logic;
    s_axi_csr_wready       : OUT std_logic;
    s_axi_csr_bresp        : OUT std_logic_vector(1 DOWNTO 0);
    s_axi_csr_bvalid       : OUT std_logic;
    s_axi_csr_bready       : IN  std_logic;
    s_axi_csr_araddr       : IN  std_logic_vector(6 DOWNTO 0);
    s_axi_csr_arprot       : IN  std_logic_vector(2 DOWNTO 0);
    s_axi_csr_arvalid      : IN  std_logic;
    s_axi_csr_arready      : OUT std_logic;
    s_axi_csr_rdata        : OUT std_logic_vector(31 DOWNTO 0);
    s_axi_csr_rresp        : OUT std_logic_vector(1 DOWNTO 0);
    s_axi_csr_rvalid       : OUT std_logic;
    s_axi_csr_rready       : IN  std_logic;
    reg0_init_val          : IN  std_logic_vector(31 DOWNTO 0);
    reg1_init_val          : IN  std_logic_vector(31 DOWNTO 0);
    reg2_init_val          : IN  std_logic_vector(31 DOWNTO 0);
    reg3_init_val          : IN  std_logic_vector(31 DOWNTO 0);
    reg4_init_val          : IN  std_logic_vector(31 DOWNTO 0);
    reg5_init_val          : IN  std_logic_vector(31 DOWNTO 0);
    reg6_init_val          : IN  std_logic_vector(31 DOWNTO 0);
    ctl0_out               : OUT std_logic_vector(31 DOWNTO 0);     -- Addr: 00
    ctl1_out               : OUT std_logic_vector(31 DOWNTO 0);     -- Addr: 04
    ctl2_out               : OUT std_logic_vector(31 DOWNTO 0);     -- Addr: 08
    ctl3_out               : OUT std_logic_vector(31 DOWNTO 0);     -- Addr: 0C
    ctl4_out               : OUT std_logic_vector(31 DOWNTO 0);     -- Addr: 10
    ctl5_out               : OUT std_logic_vector(31 DOWNTO 0);     -- Addr: 14
    ctl6_out               : OUT std_logic_vector(31 DOWNTO 0);     -- Addr: 18
    stat0_in               : IN  std_logic_vector(31 DOWNTO 0);     -- Addr: 1C
    stat1_in               : IN  std_logic_vector(31 DOWNTO 0);     -- Addr: 20
    stat2_in               : IN  std_logic_vector(31 DOWNTO 0);     -- Addr: 24
    stat3_in               : IN  std_logic_vector(31 DOWNTO 0);     -- Addr: 28
    stat4_in               : IN  std_logic_vector(31 DOWNTO 0);     -- Addr: 2C
    stat5_in               : IN  std_logic_vector(31 DOWNTO 0)      -- Addr: 30
  );
END COMPONENT;

-- Master Mode TWSI Controller
component twsi_local_bus_intrfc
port (
   CLK                     : in  std_logic;                    -- PCIe Clock 250MHz
   RST_N                   : in  std_logic;                    -- Power on reset
   SDA                     : inout std_logic;
   SCL                     : inout std_logic;
   ----------------------------------------------------------------------------------------------------
   -- Controls
   ----------------------------------------------------------------------------------------------------
   ENABLE                  : in  std_logic;                    -- Port Enable
   ADDR                    : in  std_logic_vector(6 downto 0); -- TWSI t1_address
   STRT_PLS                : in  std_logic;                    -- Start Transfer pulse
   R_W_N                   : in  std_logic;                    -- Data direction (0 = write, 1 = read)
   -- (# of bytes-1) to transfer
   NUM_BYTES               : in  std_logic_vector(3 downto 0);
   ----------------------------------------------------------------------------------------------------
   -- Data Read/Write Bus
   ----------------------------------------------------------------------------------------------------
   FIFO_WR                 : in  std_logic;                    -- Write for data into the FIFO
   FIFO_RD                 : in  std_logic;                    -- Read for data out of FIFO
   WR_DATA                 : in  std_logic_vector(7 downto 0); -- Data to be transmitted
   RD_DATA                 : out std_logic_vector(7 downto 0); -- Data received
   ----------------------------------------------------------------------------------------------------
   -- Status
   ----------------------------------------------------------------------------------------------------
   -- Number of data bytes available to read in the FIFO
   RD_FIFO_CNT             : out std_logic_vector(4 downto 0);
   RD_FIFO_FULL            : out std_logic;                    -- RX Full
   RD_FIFO_EMPTY           : out std_logic;                    -- RX Empty
   -- Number of data bytes ready to be transmitted
   WR_FIFO_CNT             : out std_logic_vector(4 downto 0);
   WR_FIFO_FULL            : out std_logic;                    -- TX Full
   WR_FIFO_EMPTY           : out std_logic;                    -- TX Empty
   BUSY_OUT                : out std_logic;                    -- busy, transfer in process
   TRNS_DONE_INT           : out std_logic;                    -- Interrupt pulse when transfer is done
   NO_ACK_INT              : out std_logic                     -- No acknowledge interrupt
);
end component;

-- SPI Interface
component px_3324_spi_intrfc
port (
   -- internal interface signals
   clk_in                  : in  std_logic; 
   rst_n                   : in  std_logic;
   
   -- Device Select:
   --   000 = ADC0: 4-wire, 16-bit address, 8-bit data
   --   001 = ADC1: 4-wire, 16-bit address, 8-bit data
   --   010 = DAC0: 3/4-wire, 7-bit address, 16-bit data
   --   011 = DAC1: 3/4-wire, 7-bit address, 16-bit data
   --   100 = LMK: 3-wire, 16-bit address, 8-bit data
   dev_sel                 : in  std_logic_vector(2 downto 0);
   
   spi_mode                : in  std_logic;   -- '0' = 4 wire , '1' = 3 wire
   data_len                : in  std_logic;   -- '0' = 8-bit, '1' = 16-bit
   
   data_in                 : in  std_logic_vector(15 downto 0);
   addr                    : in  std_logic_vector(15 downto 0);
   wr                      : in  std_logic;
   rd                      : in  std_logic;
   data_out                : out std_logic_vector(15 downto 0);
   sm_rdy                  : out std_logic;
   -- serial interface signals
   sdi                     : inout std_logic;
   sdenb                   : out std_logic_vector(4 downto 0);
   sclk                    : out std_logic;
   sdo                     : in  std_logic_vector(4 downto 0)
);
end component;

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal spi_reset_n           : std_logic;
signal spi_data_in_r       : std_logic_vector(15 downto 0);
signal spi_data_out_r      : std_logic_vector(15 downto 0);
signal sm_rdy_r            : std_logic;
signal jesd_reset          : std_logic;

signal reg_init            : std_logic_vector(31 downto 0);

signal spi_ctrl            : std_logic_vector(31 downto 0);
signal twsi_ctrl           : std_logic_vector(31 downto 0);
signal lmk_ctrl            : std_logic_vector(31 downto 0);
signal spi_start           : std_logic_vector(31 downto 0);
signal spi_wr_data         : std_logic_vector(31 downto 0);
signal spi_rd_data         : std_logic_vector(31 downto 0);
signal twsi_wr_data        : std_logic_vector(31 downto 0);
signal twsi_rd_data        : std_logic_vector(31 downto 0);
signal twsi_start          : std_logic_vector(31 downto 0);

signal spi_status          : std_logic_vector(31 downto 0);
signal twsi_status         : std_logic_vector(31 downto 0);
signal lmk_status          : std_logic_vector(31 downto 0);
signal spi_wr              : std_logic;
signal spi_rd              : std_logic;

signal intrpt_src          : std_logic_vector(5 downto 0);

signal twsi_data_in_r      : std_logic_vector(7 downto 0);
signal twsi_data_out_r     : std_logic_vector(7 downto 0);

signal t1_twsi_wr          : std_logic;
signal t2_twsi_wr          : std_logic;
signal t3_twsi_wr          : std_logic;
signal twsi_wr             : std_logic;

signal t1_twsi_rd          : std_logic;
signal t2_twsi_rd          : std_logic;
signal t3_twsi_rd          : std_logic;
signal twsi_rd             : std_logic;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

begin

reg_init(31 downto 0) <= (others => '0');


px_3324_FMC_intrfc_csr_inst : px_3324_FMC_intrfc_csr
  PORT MAP (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => s_axi_csr_aresetn,
    s_axi_csr_awaddr    => s_axi_csr_awaddr,
    s_axi_csr_awprot    => s_axi_csr_awprot,
    s_axi_csr_awvalid   => s_axi_csr_awvalid,
    s_axi_csr_awready   => s_axi_csr_awready,
    s_axi_csr_wdata     => s_axi_csr_wdata,
    s_axi_csr_wstrb     => s_axi_csr_wstrb,
    s_axi_csr_wvalid    => s_axi_csr_wvalid,
    s_axi_csr_wready    => s_axi_csr_wready,
    s_axi_csr_bresp     => s_axi_csr_bresp,
    s_axi_csr_bvalid    => s_axi_csr_bvalid,
    s_axi_csr_bready    => s_axi_csr_bready,
    s_axi_csr_araddr    => s_axi_csr_araddr,
    s_axi_csr_arprot    => s_axi_csr_arprot,
    s_axi_csr_arvalid   => s_axi_csr_arvalid,
    s_axi_csr_arready   => s_axi_csr_arready,
    s_axi_csr_rdata     => s_axi_csr_rdata,
    s_axi_csr_rresp     => s_axi_csr_rresp,
    s_axi_csr_rvalid    => s_axi_csr_rvalid,
    s_axi_csr_rready    => s_axi_csr_rready,
    reg0_init_val       => reg_init,
    reg1_init_val       => reg_init,
    reg2_init_val       => reg_init,
    reg3_init_val       => reg_init,
    reg4_init_val       => reg_init,
    reg5_init_val       => reg_init,
    reg6_init_val       => reg_init,
    ctl0_out            => spi_ctrl,         -- Addr: 00
    ctl1_out            => spi_wr_data,      -- Addr: 04
    ctl2_out            => spi_start,        -- Addr: 08
    ctl3_out            => twsi_ctrl,        -- Addr: 0C
    ctl4_out            => twsi_wr_data,     -- Addr: 10
    ctl5_out            => twsi_start,       -- Addr: 14
    ctl6_out            => lmk_ctrl,         -- Addr: 18
    stat0_in            => spi_status,       -- Addr: 1c
    stat1_in            => spi_rd_data,      -- Addr: 20
    stat2_in            => twsi_status,      -- Addr: 24
    stat3_in            => twsi_rd_data,     -- Addr: 28
    stat4_in            => lmk_status,       -- Addr: 2C
    stat5_in            => reg_init          -- Addr: 30
  );
  
----------------------------------------------------------------------------
-- LMK04828B Control and Status
----------------------------------------------------------------------------

jesd_reset              <= (lmk_ctrl(4) or (not LRST_N));
 
INT_REF_SEL             <= lmk_ctrl(5);
JESD_RESET_GPO          <= jesd_reset;
PLL1_CLKIN_SEL0         <= lmk_ctrl(0);
PLL1_CLKIN_SEL1         <= lmk_ctrl(1);
PLL1_REF_ENAB           <= lmk_ctrl(6);
PLL2_REF_ENAB           <= lmk_ctrl(7);
GATE_B_SEL              <= lmk_ctrl(8);
SYSREF_SYNC             <= lmk_ctrl(9);
  
lmk_status(1)           <= STATUS_LD2;
lmk_status(0)           <= STATUS_LD1;
lmk_status(31 downto 2) <= (others => '0');
  
-------------------------------------------------------------------------------
-- TWSI Serial Port 
-------------------------------------------------------------------------------

-- Generate a Write signal for writing data to the TWSI port FIFO
process(PCIE_CLK)
begin
   if ((LRST_N = '0') or (s_axi_csr_aresetn = '0')) then
      t1_twsi_wr <= '0';
      t2_twsi_wr <= '0';
      t3_twsi_wr <= '0';
      twsi_wr    <= '0';
   elsif rising_edge(PCIE_CLK) then
      if ((twsi_ctrl(4) = '1') and (twsi_start(0) = '1') and (twsi_ctrl(5) = '0')) then
         t1_twsi_wr <= '1';
      else
         t1_twsi_wr <= '0';
      end if;
      t2_twsi_wr <= t1_twsi_wr;
      t3_twsi_wr <= t2_twsi_wr;
   twsi_wr    <= t2_twsi_wr and not t3_twsi_wr;
   end if;
end process;

-- Generate a Read signal for reading data from the TWSI port FIFO           
process(PCIE_CLK)
begin
   if ((LRST_N = '0') or (s_axi_csr_aresetn = '0')) then
      t1_twsi_rd <= '0';
      t2_twsi_rd <= '0';
      t3_twsi_rd <= '0';
      twsi_rd    <= '0';
   elsif rising_edge(PCIE_CLK) then
      if ((s_axi_csr_arvalid = '1') and (s_axi_csr_araddr = "0101000") and (twsi_status(5) = '0')) then
         t1_twsi_rd <= '1';
      else
         t1_twsi_rd <= '0';
      end if;
      t2_twsi_rd <= t1_twsi_rd;
      t3_twsi_rd <= t2_twsi_rd;
	  twsi_rd    <= t2_twsi_rd and not t3_twsi_rd;
   end if;
end process;

twsi_data_in_r    <=  twsi_wr_data(7 downto 0);

twsi_rd_data(7 downto 0)  <= twsi_data_out_r;
twsi_rd_data(31 downto 8) <= (others => '0');
   
twsi_status(3) <= '0';
twsi_status(4) <= '0';
twsi_status(7) <= '0';
twsi_status(31 downto 13)   <= (others => '0');

twsi_local_bus_intrfc_inst: twsi_local_bus_intrfc
port map (
   CLK            => PCIE_CLK,                  -- PCIe Clock 250MHz                     -- in  std_logic;                   
   RST_N          => LRST_N,                    -- Power on reset                        -- in  std_logic;                   
   ---------------------------------------------------------------------------- 
   -- TWSI Port                                                                 
   ---------------------------------------------------------------------------- 
   SDA            => TWSI_SDA,                  -- TWSI Data I/O                         -- inout std_logic;
   SCL            => TWSI_SCL,                  -- TWSI Clock Out                        -- inout std_logic;
   ---------------------------------------------------------------------------- ----------------------------------------------
   -- Controls                                                                  
   ---------------------------------------------------------------------------- ----------------------------------------------
   ENABLE         => twsi_ctrl(4),              -- Port Enable                           -- in  std_logic;                   
   ADDR           => twsi_ctrl(14 downto 8),    -- TWSI t1_address                       -- in  std_logic_vector(6 downto 0);
   STRT_PLS       => twsi_start(0),             -- Start Transfer pulse                  -- in  std_logic;                   
   R_W_N          => twsi_ctrl(5),              -- Data direction (0 = write, 1 = read)  -- in  std_logic;                   
   -- (# of bytes-1) to transfer                                                
   NUM_BYTES      => twsi_ctrl(3 downto 0),                                              -- in  std_logic_vector(3 downto 0);
   ---------------------------------------------------------------------------- -----------------------------------------------
   -- Data Read/Write Bus                                                       
   ---------------------------------------------------------------------------- -----------------------------------------------
   FIFO_WR        => twsi_wr,                   -- Write for data into the FIFO          -- in  std_logic;                   
   FIFO_RD        => twsi_rd,                   -- Read for data out of FIFO             -- in  std_logic;                   
   WR_DATA        => twsi_data_in_r,            -- Data to be transmitted                -- in  std_logic_vector(7 downto 0);
   RD_DATA        => twsi_data_out_r,           -- Data received                         -- out std_logic_vector(7 downto 0);
   ---------------------------------------------------------------------------- -----------------------------------------------
   -- Status                                                                    
   ---------------------------------------------------------------------------- -----------------------------------------------
   -- Number of data bytes available to read in the FIFO                        
   RD_FIFO_CNT    => twsi_status(12 downto 8),                                           -- out std_logic_vector(4 downto 0);
   RD_FIFO_FULL   => twsi_status(6),           -- RX Full                                -- out std_logic;                   
   RD_FIFO_EMPTY  => twsi_status(5),           -- RX Empty                               -- out std_logic;                   
   -- Number of data bytes ready to be transmitted                              
   WR_FIFO_CNT    => open,                                                               -- out std_logic_vector(4 downto 0);
   WR_FIFO_FULL   => twsi_status(2),           -- TX Full                                -- out std_logic;                   
   WR_FIFO_EMPTY  => twsi_status(1),           -- TX Empty                               -- out std_logic;                   
   BUSY_OUT       => twsi_status(0),           -- busy, transfer in process              -- out std_logic;                   
   TRNS_DONE_INT  => TRNS_DONE_INT,            -- transfer is done interrupt             -- out std_logic;                   
   NO_ACK_INT     => NO_ACK_INT                -- No acknowledge interrupt               -- out std_logic                    
);

-------------------------------------------------------------------------------
-- SPI Interface
-------------------------------------------------------------------------------

spi_reset_n       <=  not (spi_ctrl(0) or (not LRST_N));

spi_data_in_r     <= spi_wr_data(15 downto 0);

spi_status(0)             <= sm_rdy_r;
spi_status(31 downto 1)   <= (others => '0');

spi_rd_data(15 downto 0)  <= spi_data_out_r;
spi_rd_data(31 downto 16) <= (others => '0');

spi_wr <= (spi_ctrl(2) and spi_start(0));
spi_rd <= (spi_ctrl(1) and spi_start(0));

px_3324_spi_intrfc_inst: px_3324_spi_intrfc
port map (
   -- internal interface signals                                       
   clk_in     => PCIE_CLK,                 -- in  std_logic;  
   rst_n      => spi_reset_n,              -- in  std_logic;  

   -- Device Select: 
   --   000 = ADC0: 4-wire, 16-bit address, 8-bit data
   --   001 = ADC1: 4-wire, 16-bit address, 8-bit data
   --   010 = DAC0: 3/4-wire, 7-bit address, 16-bit data
   --   011 = DAC1: 3/4-wire, 7-bit address, 16-bit data
   --   100 = LMK: 3-wire, 16-bit address, 8-bit data
   dev_sel    => spi_ctrl(5 downto 3),     -- in  std_logic_vector(2 downto 0);
  
   spi_mode   =>  spi_ctrl(6),             -- in  std_logic;  '0' = 4 wire , '1' = 3 wire 
   data_len   =>  spi_ctrl(7),             -- in  std_logic;  '0' = 8-bit, '1' = 16-bit  
   data_in    =>  spi_data_in_r,           -- in  std_logic_vector(15 downto 0);
   addr       =>  spi_ctrl(23 downto 8),   -- in  std_logic_vector(15 downto 0);
   wr         =>  spi_wr,                  -- in  std_logic;
   rd         =>  spi_rd,                  -- in  std_logic; 
   data_out   =>  spi_data_out_r,          -- out std_logic_vector(15 downto 0);
   sm_rdy     =>  sm_rdy_r,                -- out std_logic; 
-- serial interface signals
   sdi        =>  SDIO,                    -- inout std_logic;
   sdenb      =>  SDENB,                   -- out std_logic_vector(4 downto 0);       
   sclk       =>  SCLK,                    -- out std_logic;                         
   sdo        =>  SDO                      -- in  std_logic_vector(4 downto 0)        
);                                                        

end Behavioral;

