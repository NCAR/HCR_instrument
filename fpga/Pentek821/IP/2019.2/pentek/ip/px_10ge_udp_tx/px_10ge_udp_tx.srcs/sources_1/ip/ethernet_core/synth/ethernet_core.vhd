-- (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:axi_10g_ethernet:3.1
-- IP Revision: 3

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ethernet_core IS
  PORT (
    tx_axis_aresetn : IN STD_LOGIC;
    rx_axis_aresetn : IN STD_LOGIC;
    tx_ifg_delay : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dclk : IN STD_LOGIC;
    txp : OUT STD_LOGIC;
    txn : OUT STD_LOGIC;
    rxp : IN STD_LOGIC;
    rxn : IN STD_LOGIC;
    signal_detect : IN STD_LOGIC;
    tx_fault : IN STD_LOGIC;
    tx_disable : OUT STD_LOGIC;
    pcspma_status : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    sim_speedup_control : IN STD_LOGIC;
    rxrecclk_out : OUT STD_LOGIC;
    mac_tx_configuration_vector : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
    mac_rx_configuration_vector : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
    mac_status_vector : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    pcs_pma_configuration_vector : IN STD_LOGIC_VECTOR(535 DOWNTO 0);
    pcs_pma_status_vector : OUT STD_LOGIC_VECTOR(447 DOWNTO 0);
    areset_datapathclk_out : OUT STD_LOGIC;
    txusrclk_out : OUT STD_LOGIC;
    txusrclk2_out : OUT STD_LOGIC;
    gttxreset_out : OUT STD_LOGIC;
    gtrxreset_out : OUT STD_LOGIC;
    txuserrdy_out : OUT STD_LOGIC;
    coreclk_out : OUT STD_LOGIC;
    resetdone_out : OUT STD_LOGIC;
    reset_counter_done_out : OUT STD_LOGIC;
    qplllock_out : OUT STD_LOGIC;
    qplloutclk_out : OUT STD_LOGIC;
    qplloutrefclk_out : OUT STD_LOGIC;
    refclk_p : IN STD_LOGIC;
    refclk_n : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    s_axis_tx_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_tx_tkeep : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_tx_tlast : IN STD_LOGIC;
    s_axis_tx_tready : OUT STD_LOGIC;
    s_axis_tx_tuser : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axis_tx_tvalid : IN STD_LOGIC;
    s_axis_pause_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_axis_pause_tvalid : IN STD_LOGIC;
    m_axis_rx_tdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axis_rx_tkeep : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_rx_tlast : OUT STD_LOGIC;
    m_axis_rx_tuser : OUT STD_LOGIC;
    m_axis_rx_tvalid : OUT STD_LOGIC;
    tx_statistics_valid : OUT STD_LOGIC;
    tx_statistics_vector : OUT STD_LOGIC_VECTOR(25 DOWNTO 0);
    rx_statistics_valid : OUT STD_LOGIC;
    rx_statistics_vector : OUT STD_LOGIC_VECTOR(29 DOWNTO 0)
  );
END ethernet_core;

ARCHITECTURE ethernet_core_arch OF ethernet_core IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF ethernet_core_arch: ARCHITECTURE IS "yes";
  COMPONENT bd_b160 IS
    PORT (
      tx_axis_aresetn : IN STD_LOGIC;
      rx_axis_aresetn : IN STD_LOGIC;
      tx_ifg_delay : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      dclk : IN STD_LOGIC;
      txp : OUT STD_LOGIC;
      txn : OUT STD_LOGIC;
      rxp : IN STD_LOGIC;
      rxn : IN STD_LOGIC;
      signal_detect : IN STD_LOGIC;
      tx_fault : IN STD_LOGIC;
      tx_disable : OUT STD_LOGIC;
      pcspma_status : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      sim_speedup_control : IN STD_LOGIC;
      rxrecclk_out : OUT STD_LOGIC;
      mac_tx_configuration_vector : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
      mac_rx_configuration_vector : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
      mac_status_vector : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      pcs_pma_configuration_vector : IN STD_LOGIC_VECTOR(535 DOWNTO 0);
      pcs_pma_status_vector : OUT STD_LOGIC_VECTOR(447 DOWNTO 0);
      areset_datapathclk_out : OUT STD_LOGIC;
      txusrclk_out : OUT STD_LOGIC;
      txusrclk2_out : OUT STD_LOGIC;
      gttxreset_out : OUT STD_LOGIC;
      gtrxreset_out : OUT STD_LOGIC;
      txuserrdy_out : OUT STD_LOGIC;
      coreclk_out : OUT STD_LOGIC;
      resetdone_out : OUT STD_LOGIC;
      reset_counter_done_out : OUT STD_LOGIC;
      qplllock_out : OUT STD_LOGIC;
      qplloutclk_out : OUT STD_LOGIC;
      qplloutrefclk_out : OUT STD_LOGIC;
      refclk_p : IN STD_LOGIC;
      refclk_n : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      s_axis_tx_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      s_axis_tx_tkeep : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      s_axis_tx_tlast : IN STD_LOGIC;
      s_axis_tx_tready : OUT STD_LOGIC;
      s_axis_tx_tuser : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      s_axis_tx_tvalid : IN STD_LOGIC;
      s_axis_pause_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      s_axis_pause_tvalid : IN STD_LOGIC;
      m_axis_rx_tdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      m_axis_rx_tkeep : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      m_axis_rx_tlast : OUT STD_LOGIC;
      m_axis_rx_tuser : OUT STD_LOGIC;
      m_axis_rx_tvalid : OUT STD_LOGIC;
      tx_statistics_valid : OUT STD_LOGIC;
      tx_statistics_vector : OUT STD_LOGIC_VECTOR(25 DOWNTO 0);
      rx_statistics_valid : OUT STD_LOGIC;
      rx_statistics_vector : OUT STD_LOGIC_VECTOR(29 DOWNTO 0)
    );
  END COMPONENT bd_b160;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF ethernet_core_arch: ARCHITECTURE IS "bd_b160,Vivado 2016.4";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF ethernet_core_arch : ARCHITECTURE IS "ethernet_core,bd_b160,{ten_gig_eth_mac=design_linking,ten_gig_eth_pcs_pma_basekr=design_linking}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF ethernet_core_arch: ARCHITECTURE IS "ethernet_core,bd_b160,{x_ipProduct=Vivado 2016.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=axi_10g_ethernet,x_ipVersion=3.1,x_ipCoreRevision=3,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,x_ipLicense=ten_gig_eth_mac@2016.04(design_linking),x_ipLicense=ten_gig_eth_pcs_pma_basekr@2015.04(design_linking),Component_Name=ethernet_core,Management_Interface=false,Management_Frequency=200.00,base_kr=BASE-R,MAC_and_BASER_32=64bit,speed10_25=10Gig,no_ebuff=false,vu_gt_type=GTH,autonegotiation=false,fec=fal" & 
"se,IEEE_1588=None,TIMER_CLK_PERIOD=5000,Timer_Format=Time_of_day,Statistics_Gathering=false,TransceiverControl=false,DRP=false,DClkRate=100.00,SupportLevel=1,Enable_Priority_Flow_Control=false,Locations=X0Y0,RefClkRate=156.25,RefClk=clk0}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF tx_axis_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 RST.tx_axis_aresetn RST";
  ATTRIBUTE X_INTERFACE_INFO OF rx_axis_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 RST.rx_axis_aresetn RST";
  ATTRIBUTE X_INTERFACE_INFO OF dclk: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.dclk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF rxrecclk_out: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.rxrecclk_out CLK";
  ATTRIBUTE X_INTERFACE_INFO OF areset_datapathclk_out: SIGNAL IS "xilinx.com:signal:reset:1.0 RST.areset_datapathclk_out RST";
  ATTRIBUTE X_INTERFACE_INFO OF txusrclk_out: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.txusrclk_out CLK";
  ATTRIBUTE X_INTERFACE_INFO OF txusrclk2_out: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.txusrclk2_out CLK";
  ATTRIBUTE X_INTERFACE_INFO OF gttxreset_out: SIGNAL IS "xilinx.com:signal:reset:1.0 RST.gttxreset_out RST";
  ATTRIBUTE X_INTERFACE_INFO OF gtrxreset_out: SIGNAL IS "xilinx.com:signal:reset:1.0 RST.gtrxreset_out RST";
  ATTRIBUTE X_INTERFACE_INFO OF coreclk_out: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.coreclk_out CLK";
  ATTRIBUTE X_INTERFACE_INFO OF qplloutclk_out: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.qplloutclk_out CLK";
  ATTRIBUTE X_INTERFACE_INFO OF qplloutrefclk_out: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.qplloutrefclk_out CLK";
  ATTRIBUTE X_INTERFACE_INFO OF reset: SIGNAL IS "xilinx.com:signal:reset:1.0 RST.reset RST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_tx_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_tx TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_tx_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_tx TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_tx_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_tx TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_tx_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_tx TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_tx_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_tx TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_tx_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_tx TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_pause_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_pause TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_pause_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_pause TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_rx_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_rx TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_rx_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_rx TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_rx_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_rx TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_rx_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_rx TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_rx_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_rx TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF tx_statistics_valid: SIGNAL IS "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 tx_statistics valid";
  ATTRIBUTE X_INTERFACE_INFO OF tx_statistics_vector: SIGNAL IS "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 tx_statistics vector";
  ATTRIBUTE X_INTERFACE_INFO OF rx_statistics_valid: SIGNAL IS "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 rx_statistics valid";
  ATTRIBUTE X_INTERFACE_INFO OF rx_statistics_vector: SIGNAL IS "xilinx.com:display_ten_gig_eth_mac:statistics:2.0 rx_statistics vector";
BEGIN
  U0 : bd_b160
    PORT MAP (
      tx_axis_aresetn => tx_axis_aresetn,
      rx_axis_aresetn => rx_axis_aresetn,
      tx_ifg_delay => tx_ifg_delay,
      dclk => dclk,
      txp => txp,
      txn => txn,
      rxp => rxp,
      rxn => rxn,
      signal_detect => signal_detect,
      tx_fault => tx_fault,
      tx_disable => tx_disable,
      pcspma_status => pcspma_status,
      sim_speedup_control => sim_speedup_control,
      rxrecclk_out => rxrecclk_out,
      mac_tx_configuration_vector => mac_tx_configuration_vector,
      mac_rx_configuration_vector => mac_rx_configuration_vector,
      mac_status_vector => mac_status_vector,
      pcs_pma_configuration_vector => pcs_pma_configuration_vector,
      pcs_pma_status_vector => pcs_pma_status_vector,
      areset_datapathclk_out => areset_datapathclk_out,
      txusrclk_out => txusrclk_out,
      txusrclk2_out => txusrclk2_out,
      gttxreset_out => gttxreset_out,
      gtrxreset_out => gtrxreset_out,
      txuserrdy_out => txuserrdy_out,
      coreclk_out => coreclk_out,
      resetdone_out => resetdone_out,
      reset_counter_done_out => reset_counter_done_out,
      qplllock_out => qplllock_out,
      qplloutclk_out => qplloutclk_out,
      qplloutrefclk_out => qplloutrefclk_out,
      refclk_p => refclk_p,
      refclk_n => refclk_n,
      reset => reset,
      s_axis_tx_tdata => s_axis_tx_tdata,
      s_axis_tx_tkeep => s_axis_tx_tkeep,
      s_axis_tx_tlast => s_axis_tx_tlast,
      s_axis_tx_tready => s_axis_tx_tready,
      s_axis_tx_tuser => s_axis_tx_tuser,
      s_axis_tx_tvalid => s_axis_tx_tvalid,
      s_axis_pause_tdata => s_axis_pause_tdata,
      s_axis_pause_tvalid => s_axis_pause_tvalid,
      m_axis_rx_tdata => m_axis_rx_tdata,
      m_axis_rx_tkeep => m_axis_rx_tkeep,
      m_axis_rx_tlast => m_axis_rx_tlast,
      m_axis_rx_tuser => m_axis_rx_tuser,
      m_axis_rx_tvalid => m_axis_rx_tvalid,
      tx_statistics_valid => tx_statistics_valid,
      tx_statistics_vector => tx_statistics_vector,
      rx_statistics_valid => rx_statistics_valid,
      rx_statistics_vector => rx_statistics_vector
    );
END ethernet_core_arch;
