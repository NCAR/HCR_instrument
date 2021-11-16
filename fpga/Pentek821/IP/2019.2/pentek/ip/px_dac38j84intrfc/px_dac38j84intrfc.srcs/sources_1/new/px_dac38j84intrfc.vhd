----------------------------------------------------------------------------------
-- Company:  Pentek Inc
-- Engineer: 
-- 	
-- Create Date: 06/20/2018 
-- IP Core Name: PX_dac38j84_INTRFC
-- File Name: px_dac38j84intrfc.vhd 
-- Target Devices: Kintex UltraScale  
-- Tool Versions: 2018.1
-- Description: This is the top level module for the PX_dac38j84_INTRFC IP Core. 
-- This interfaces to a Texas Intrument dac38j84, dual analog to digtial converter
-- chip. It receives dac data via a AXI-Stream slave bus from Pentek backend
-- acquisition core and packs the DAC data into the appropriate order, output
-- via a AXI-Stream master bus to a Xilinx JESD interface for transfter to
-- the external dac38j84 device.
-- This IP Core supports 4-lane JESD operation in both the 442 an 421 modes.
-- 
-- This core also generates control signals and monitors status for the DACs.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.0 - 6/20/2018 - Module Created
-- Additional Comments:
-- 
-- (Additional Info)
-- Example: Requires an externally instantiated JESD Interface to transmit data to 
-- dac38j84 digital to analog chip
--

-------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Memory Map
-- 0x00 - Control 1
-- 0x04 - Interrupt Enables
-- 0x08 - Interrupt Status
-- 0x0C - Interrupt Flags

-- Control 1
-- Bit [0]     - DAC Reset
-- Bit [1]     - DAC Sleep Mode
-- Bit [2]     - DAC TX Enable

-- Interrupts
-- Bit [0]     - DAC0 Alarm

----------------------------------------------------------------------------------

----------------------------------------------------------------------------------

-- (Technical Support for Pentek's GateFlow FPGA Design Kits)  
-- Technical support for Pentek's GateFlow FPGA Design Kits is available via e-mail 
-- (fpgasupport@pentek.com) or by phone (201-818-5900 ext. 238, 9 AM to 5 PM US 
-- Eastern time.) Names or initials contained within the source code are part of 
-- our revision control regime.  Please do not try to use these references to 
-- pursue technical support                              

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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_dac38j84intrfc is
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
    
   irq                      : out std_logic; -- interrupt
   ----------------------------------------------------------------------------
   -- Control Outputs
   ----------------------------------------------------------------------------
   dac_txena               : out std_logic;
   dac_sleep               : out std_logic;
   dac_resetb              : out std_logic;
   ----------------------------------------------------------------------------
   -- Status Inputs
   ----------------------------------------------------------------------------
   dac_alarm               : in  std_logic;
   ----------------------------------------------------------------------------
   -- Input Data Clock
   ----------------------------------------------------------------------------
   s_axis_dac_sample_clk    : in  std_logic;
   ----------------------------------------------------------------------------
   -- Input Data Busses
   ----------------------------------------------------------------------------
   s_axis_ch0_tx_tdata      : in std_logic_vector(63 downto 0);
   s_axis_ch0_tx_tvalid     : in std_logic;
   s_axis_ch1_tx_tdata      : in std_logic_vector(63 downto 0); 
   s_axis_ch1_tx_tvalid     : in std_logic;

   ----------------------------------------------------------------------------
   -- Output Data Busses
   ----------------------------------------------------------------------------
   m_axis_dac_tx_tdata    : out std_logic_vector(127 downto 0); 
   m_axis_dac_tx_tvalid   : out std_logic;
   m_axis_dac_tx_tready   : in  std_logic
);
end px_dac38j84intrfc;

architecture Behavioral of px_dac38j84intrfc is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- Generic AXI-Lite Control/Status Register Set
-- Control/Status Registers
component px_dac38j84intrfc_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(6 downto 0); -- only [5:0] used
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
   s_axi_csr_araddr         : in  std_logic_vector(6 downto 0);  -- only [5:0] used
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
    
   irq                      : out std_logic; -- interrupt
   ----------------------------------------------------------------------------
   -- Control Outputs
   ----------------------------------------------------------------------------
   dac_txena                : out std_logic;
   dac_sleep                : out std_logic;
   dac_resetb               : out std_logic;
   ----------------------------------------------------------------------------
   -- Status Inputs
   ----------------------------------------------------------------------------
   dac_alarm                : in  std_logic
);
end component;

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axis_dac_sample_clk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_dac_sample_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_dac_sample_clk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ch0_tx:s_axis_ch1_tx:m_axis_dac_tx";

begin

----------------------------------------------------------------------------
-- Output Data Bus Data Mapping
----------------------------------------------------------------------------

process(s_axis_dac_sample_clk)
begin
    if rising_edge(s_axis_dac_sample_clk) then
		--
		-- Set the "tvalid" outputs to the or "or" of the input "tvalid" signals.
		--
		m_axis_dac_tx_tvalid <= s_axis_ch0_tx_tvalid or s_axis_ch1_tx_tvalid;
		--
        -- DAC Reformatting    
        -- DAC LMF = 442 (four lanes, 2xIQ) or LMF = 421 (four lanes, packed REAL)
        --                                     DA1[7:0]                            DA1[15:8]                           DA0[7:0]                            DA0[15:8]
        m_axis_dac_tx_tdata(31 downto 0)    <= s_axis_ch0_tx_tdata(39 downto 32) & s_axis_ch0_tx_tdata(47 downto 40) & s_axis_ch0_tx_tdata(7 downto 0)   & s_axis_ch0_tx_tdata(15 downto 8);
        --                                     DB1[7:0]                            DB1[15:8]                           DB0[7:0]                            DB0[15:8]
        m_axis_dac_tx_tdata(63 downto 32)   <= s_axis_ch0_tx_tdata(55 downto 48) & s_axis_ch0_tx_tdata(63 downto 56) & s_axis_ch0_tx_tdata(23 downto 16) & s_axis_ch0_tx_tdata(31 downto 24);
        --                                     DC1[7:0]                            DC1[15:8]                           DC0[7:0]                            DC0[15:8]
        m_axis_dac_tx_tdata(95 downto 64)   <= s_axis_ch1_tx_tdata(39 downto 32) & s_axis_ch1_tx_tdata(47 downto 40) & s_axis_ch1_tx_tdata(7 downto 0)   & s_axis_ch1_tx_tdata(15 downto 8);
        --                                     DD1[7:0]                            DD1[15:8]                           DD0[7:0]                            DD0[15:8]  
        m_axis_dac_tx_tdata(127 downto 96)  <= s_axis_ch1_tx_tdata(55 downto 48) & s_axis_ch1_tx_tdata(63 downto 56) & s_axis_ch1_tx_tdata(23 downto 16) & s_axis_ch1_tx_tdata(31 downto 24); 
        
    end if;
end process;

----------------------------------------------------------------------------
-- Control, Status and Interrupt Logic
----------------------------------------------------------------------------

controller_inst: px_dac38j84intrfc_csr
   port map (
     s_axi_csr_aclk        =>       s_axi_csr_aclk,    
     s_axi_csr_aresetn     =>       s_axi_csr_aresetn, 
     s_axi_csr_awaddr      =>       s_axi_csr_awaddr,  
     s_axi_csr_awprot      =>       s_axi_csr_awprot,  
     s_axi_csr_awvalid     =>       s_axi_csr_awvalid, 
     s_axi_csr_awready     =>       s_axi_csr_awready, 
     s_axi_csr_wdata       =>       s_axi_csr_wdata,   
     s_axi_csr_wstrb       =>       s_axi_csr_wstrb,   
     s_axi_csr_wvalid      =>       s_axi_csr_wvalid,  
     s_axi_csr_wready      =>       s_axi_csr_wready,  
     s_axi_csr_bresp       =>       s_axi_csr_bresp,   
     s_axi_csr_bvalid      =>       s_axi_csr_bvalid,  
     s_axi_csr_bready      =>       s_axi_csr_bready,  
     s_axi_csr_araddr      =>       s_axi_csr_araddr,  
     s_axi_csr_arprot      =>       s_axi_csr_arprot,  
     s_axi_csr_arvalid     =>       s_axi_csr_arvalid, 
     s_axi_csr_arready     =>       s_axi_csr_arready, 
     s_axi_csr_rdata       =>       s_axi_csr_rdata,   
     s_axi_csr_rresp       =>       s_axi_csr_rresp,   
     s_axi_csr_rvalid      =>       s_axi_csr_rvalid,  
     s_axi_csr_rready      =>       s_axi_csr_rready,  
     irq                   =>       irq,
     dac_txena             =>       dac_txena,  
     dac_sleep             =>       dac_sleep,  
     dac_resetb            =>       dac_resetb, 
     dac_alarm             =>       dac_alarm  
   ); 

   end Behavioral;