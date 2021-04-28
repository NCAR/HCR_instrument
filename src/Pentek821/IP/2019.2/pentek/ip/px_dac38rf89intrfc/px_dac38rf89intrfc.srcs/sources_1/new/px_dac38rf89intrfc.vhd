----------------------------------------------------------------------------------
-- Company:  Pentek Inc
-- Engineer: G.L.
-- 	
-- Create Date: 06/06/2017 
-- IP Core Name: PX_DAC38RF89_INTRFC
-- File Name: px_dac38rf89intrfc.vhd 
-- Target Devices: Kintex UltraScale  
-- Tool Versions: 2017.1
-- Description: This is the top level module for the PX_DAC38RF89_INTRFC IP Core. 
-- This interfaces to the Texas Intrument DAC38RF89 analog to digtial converter 
-- chip. It receives dac data via a AXI-Stream slave bus from Pentek backend
-- acquisition cores, packs the DAC data into the appropriate order, output
-- via a AXI-Stream master bus to a Xilinx JESD interface for transfter to
-- the external DAC38RF89 device.
-- This IP Core supports 8-lane JESD operation in the following
-- L-M-F-S-Hd modes (See dac38rf89 datasheet for L-M-F-S-Hd modes details)
-- 82121 - Single Channel 16-bit I/Q 
-- 84111 - Two Channel 16-bit I/Q
-- 81180 - Single Channel 8-Bit real
-- 82380 - Single Channel 12-bit I/Q
-- 
-- A software register set allows for additional control of the DAC38RF89 device. 
-- (See datasheet for dac38rf89 register set)
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.0 - 6/6/2017 - Module Created
-- Additional Comments:
-- 

-- (Memory Map)
-- 0x00 - DAC Control Register      R/W
-- 0x04 - DAC SPI Control Register  R/W
-- 0x08 - DAC Status Register       RO
-- 0x0C - DAC SPI Status Register   R/W
-- 0x10 - Interrupt Enables         R/W
-- 0x14 - Interrupt Status          RO
-- 0x18 - Interrupt Flags           R/Clr

-- (Additional Info)
-- Example: Requires an externally instantiated JESD Interface to transmit data to 
-- DAC38RF89 digital to analog chip

----------------------------------------------------------------------------------

-- (Technical Support for Pentek's GateFlow FPGA Design Kits)  
-- Technical support for Pentek's GateFlow FPGA Design Kits is available via e-mail 
-- (fpgasupport@pentek.com) or by phone (201-818-5900 ext. 238, 9 AM to 5 PM US 
-- Eastern time.) Names or initials contained within the source code are part of 
-- our revision control regime.  Please do not try to use these references to 
-- pursue technical support                              

-- (c) Copyright 2017 Pentek, Inc. All rights reserved.
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_dac38rf89intrfc is
Port 
(
    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI4-LITE)
    ----------------------------------------------------------------------------
    -- associated with s_axi_csr_aclk
    s_axi_csr_aclk           : in  std_logic;
    s_axi_csr_aresetn        : in  std_logic;
    s_axi_csr_awaddr         : in  std_logic_vector(11 downto 0);
    s_axi_csr_awprot         : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid        : in  std_logic;
    s_axi_csr_awready        : out std_logic;
    s_axi_csr_wdata          : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb          : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid         : in  std_logic;
    s_axi_csr_wready         : out std_logic;
    s_axi_csr_bresp          : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid         : out std_logic;
    s_axi_csr_bready         : in  std_logic;
    s_axi_csr_araddr         : in  std_logic_vector(11 downto 0);
    s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid        : in  std_logic;
    s_axi_csr_arready        : out std_logic;
    s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid         : out std_logic;
    s_axi_csr_rready         : in  std_logic;
    
    -- Pentek DAC Data
    dac_sample_clk          : in  std_logic;
    s_axis_pdti_a_tdata     : in  std_logic_vector(255 downto 0);
    s_axis_pdti_a_tuser     : in  std_logic_vector(127 downto 0);
    s_axis_pdti_a_tvalid    : in  std_logic;
    
    s_axis_pdti_b_tdata     : in  std_logic_vector(255 downto 0);
    s_axis_pdti_b_tuser     : in  std_logic_vector(127 downto 0);
    s_axis_pdti_b_tvalid    : in  std_logic;
    
    tx_core_clk             : in  std_logic;
    tx_start_of_frame       : in  std_logic_vector(3 downto 0);
    m_axis_jesd_tx_tdata    : out std_logic_vector(255 downto 0);
    m_axis_jesd_tx_tready   : in  std_logic;
    m_axis_jesd_tx_tvalid   : out std_logic;

    ----------------------------------------------------------------------------
    -- DAC38RF89 Control Signals
    ----------------------------------------------------------------------------
    --Serial Interface 
    dac_sout                 : in  std_logic;
    dac_sdi                  : inout std_logic;
    dac_scs_n                : out std_logic;
    dac_sclk                 : out std_logic;
    
    --Dac control registers  
    dac_reset_n              : out std_logic;
    dac_txena                : out std_logic;  
    dac_sleep                : out std_logic;
    
    dac_alarm                : in std_logic;
    
    irq                      : out std_logic

);
end px_dac38rf89intrfc;

architecture Behavioral of px_dac38rf89intrfc is

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of dac_sample_clk: SIGNAL is "xilinx.com:signal:clock:1.0 dac_sample_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of dac_sample_clk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti_a:s_axis_pdti_b";

ATTRIBUTE X_INTERFACE_INFO of tx_core_clk: SIGNAL is "xilinx.com:signal:clock:1.0 tx_core_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of tx_core_clk: SIGNAL is "ASSOCIATED_BUSIF m_axis_jesd_tx";


signal dac_jesd_format_mode     : std_logic_vector(2 downto 0);
signal wide_duc_mode            : std_logic; 
signal dac_pack_rst             : std_logic;
signal sync_latch_clr           : std_logic;
signal sync_latch_en            : std_logic;

component px_dac38rf89intrfc_csr 
Port 
(
    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI4-LITE)
    ----------------------------------------------------------------------------
    -- associated with s_axi_csr_aclk
    s_axi_csr_aclk           : in  std_logic;
    s_axi_csr_aresetn        : in  std_logic;
    s_axi_csr_awaddr         : in  std_logic_vector(6 downto 0);
    s_axi_csr_awprot         : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid        : in  std_logic;
    s_axi_csr_awready        : out std_logic;
    s_axi_csr_wdata          : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb          : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid         : in  std_logic;
    s_axi_csr_wready         : out std_logic;
    s_axi_csr_bresp          : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid         : out std_logic;
    s_axi_csr_bready         : in  std_logic;
    s_axi_csr_araddr         : in  std_logic_vector(6 downto 0);
    s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid        : in  std_logic;
    s_axi_csr_arready        : out std_logic;
    s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid         : out std_logic;
    s_axi_csr_rready         : in  std_logic;
    
    dac_sample_clk           : in  std_logic;

    dac_pack_rst             : out std_logic;
    sync_latch_clr           : out std_logic;
    sync_latch_en            : out std_logic;
    
    ----------------------------------------------------------------------------
    -- DAC38RF89 Control Signals
    ----------------------------------------------------------------------------
    --Serial Interface 
    dac_sout                 : in  std_logic;
    dac_sdi                  : inout std_logic;
    dac_scs_n                : out std_logic;
    dac_sclk                 : out std_logic;
    
    --Dac control registers  
    dac_reset_n              : out std_logic;
    dac_txena                : out std_logic;  
    dac_sleep                : out std_logic;
    
    dac_jesd_format_mode     : out std_logic_vector(2 downto 0);
    wide_duc_mode            : out std_logic;
        
    dac_alarm                : in std_logic;
    
    irq                      : out std_logic


);
end component;

component px_dac38rf89intrfc_pack 
Port
( 
   dac_jesd_format_mode    : in  std_logic_vector(2 downto 0);
   wide_duc_mode           : in  std_logic;

   dac_sample_clk          : in  std_logic; -- Sample Clock input
   tx_core_clk             : in  std_logic;
   
   dac_pack_rst            : in  std_logic;
   sync_latch_clr          : in  std_logic;
   sync_latch_en           : in  std_logic;
   
   s_axis_pdti_a_tdata     : in  std_logic_vector(255 downto 0);
   s_axis_pdti_a_tuser     : in  std_logic_vector(127 downto 0);
   s_axis_pdti_a_tvalid    : in  std_logic;
   
   s_axis_pdti_b_tdata     : in  std_logic_vector(255 downto 0);
   s_axis_pdti_b_tuser     : in  std_logic_vector(127 downto 0);
   s_axis_pdti_b_tvalid    : in  std_logic;
   
   tx_start_of_frame       : in  std_logic_vector(3 downto 0);
   m_axis_jesd_tx_tdata    : out std_logic_vector(255 downto 0);
   m_axis_jesd_tx_tready   : in  std_logic;
   m_axis_jesd_tx_tvalid   : out std_logic

);
end component;

begin


dac_csr_i: px_dac38rf89intrfc_csr 
Port map
(
    s_axi_csr_aclk           => s_axi_csr_aclk   , 
    s_axi_csr_aresetn        => s_axi_csr_aresetn, 
    s_axi_csr_awaddr         => s_axi_csr_awaddr(6 downto 0) , 
    s_axi_csr_awprot         => s_axi_csr_awprot , 
    s_axi_csr_awvalid        => s_axi_csr_awvalid, 
    s_axi_csr_awready        => s_axi_csr_awready, 
    s_axi_csr_wdata          => s_axi_csr_wdata  , 
    s_axi_csr_wstrb          => s_axi_csr_wstrb  , 
    s_axi_csr_wvalid         => s_axi_csr_wvalid , 
    s_axi_csr_wready         => s_axi_csr_wready , 
    s_axi_csr_bresp          => s_axi_csr_bresp  , 
    s_axi_csr_bvalid         => s_axi_csr_bvalid , 
    s_axi_csr_bready         => s_axi_csr_bready , 
    s_axi_csr_araddr         => s_axi_csr_araddr(6 downto 0) , 
    s_axi_csr_arprot         => s_axi_csr_arprot , 
    s_axi_csr_arvalid        => s_axi_csr_arvalid, 
    s_axi_csr_arready        => s_axi_csr_arready, 
    s_axi_csr_rdata          => s_axi_csr_rdata  , 
    s_axi_csr_rresp          => s_axi_csr_rresp  , 
    s_axi_csr_rvalid         => s_axi_csr_rvalid , 
    s_axi_csr_rready         => s_axi_csr_rready ,
    
    dac_sample_clk           => dac_sample_clk,
    
    dac_pack_rst             => dac_pack_rst,
    sync_latch_clr           => sync_latch_clr,                
    sync_latch_en            => sync_latch_en,                  

    ----------------------------------------------------------------------------
    -- DAC38RF89 Control Signals
    ----------------------------------------------------------------------------
    --Serial Interface 
    dac_sout                 => dac_sout,      
    dac_sdi                  => dac_sdi,       
    dac_scs_n                => dac_scs_n,     
    dac_sclk                 => dac_sclk,
    
    --Dac control registers  
    dac_reset_n              => dac_reset_n,
    dac_txena                => dac_txena,       
    dac_sleep                => dac_sleep,
    
    dac_jesd_format_mode     => dac_jesd_format_mode,
    wide_duc_mode            => wide_duc_mode,
                                     
    dac_alarm                => dac_alarm,

    irq                      => irq    

);

pack_inst: px_dac38rf89intrfc_pack 
Port map
(  
    
   dac_jesd_format_mode    => dac_jesd_format_mode,
   wide_duc_mode           => wide_duc_mode, 

   dac_sample_clk          => dac_sample_clk,
   tx_core_clk             => tx_core_clk,
   
   dac_pack_rst            => dac_pack_rst,
   sync_latch_clr          => sync_latch_clr,
   sync_latch_en           => sync_latch_en, 
   
   s_axis_pdti_a_tdata     => s_axis_pdti_a_tdata,  
   s_axis_pdti_a_tuser     => s_axis_pdti_a_tuser,  
   s_axis_pdti_a_tvalid    => s_axis_pdti_a_tvalid,
   
   s_axis_pdti_b_tdata     => s_axis_pdti_b_tdata,  
   s_axis_pdti_b_tuser     => s_axis_pdti_b_tuser,  
   s_axis_pdti_b_tvalid    => s_axis_pdti_b_tvalid,
      
   tx_start_of_frame       => tx_start_of_frame,
   m_axis_jesd_tx_tdata    => m_axis_jesd_tx_tdata,
   m_axis_jesd_tx_tready   => m_axis_jesd_tx_tready,
   m_axis_jesd_tx_tvalid   => m_axis_jesd_tx_tvalid 

);



end Behavioral;
