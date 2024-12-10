--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
--Date        : Wed Mar 22 14:28:19 2017
--Host        : Mike-PC running 64-bit major release  (build 9200)
--Command     : generate_target bd_b160.bd
--Design      : bd_b160
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_b160 is
  port (
    areset_datapathclk_out : out STD_LOGIC;
    coreclk_out : out STD_LOGIC;
    dclk : in STD_LOGIC;
    gtrxreset_out : out STD_LOGIC;
    gttxreset_out : out STD_LOGIC;
    m_axis_rx_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_rx_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_rx_tlast : out STD_LOGIC;
    m_axis_rx_tuser : out STD_LOGIC;
    m_axis_rx_tvalid : out STD_LOGIC;
    mac_rx_configuration_vector : in STD_LOGIC_VECTOR ( 79 downto 0 );
    mac_status_vector : out STD_LOGIC_VECTOR ( 2 downto 0 );
    mac_tx_configuration_vector : in STD_LOGIC_VECTOR ( 79 downto 0 );
    pcs_pma_configuration_vector : in STD_LOGIC_VECTOR ( 535 downto 0 );
    pcs_pma_status_vector : out STD_LOGIC_VECTOR ( 447 downto 0 );
    pcspma_status : out STD_LOGIC_VECTOR ( 7 downto 0 );
    qplllock_out : out STD_LOGIC;
    qplloutclk_out : out STD_LOGIC;
    qplloutrefclk_out : out STD_LOGIC;
    refclk_n : in STD_LOGIC;
    refclk_p : in STD_LOGIC;
    reset : in STD_LOGIC;
    reset_counter_done_out : out STD_LOGIC;
    resetdone_out : out STD_LOGIC;
    rx_axis_aresetn : in STD_LOGIC;
    rx_statistics_valid : out STD_LOGIC;
    rx_statistics_vector : out STD_LOGIC_VECTOR ( 29 downto 0 );
    rxn : in STD_LOGIC;
    rxp : in STD_LOGIC;
    rxrecclk_out : out STD_LOGIC;
    s_axis_pause_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_pause_tvalid : in STD_LOGIC;
    s_axis_tx_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_tx_tkeep : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tx_tlast : in STD_LOGIC;
    s_axis_tx_tready : out STD_LOGIC;
    s_axis_tx_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tx_tvalid : in STD_LOGIC;
    signal_detect : in STD_LOGIC;
    sim_speedup_control : in STD_LOGIC;
    tx_axis_aresetn : in STD_LOGIC;
    tx_disable : out STD_LOGIC;
    tx_fault : in STD_LOGIC;
    tx_ifg_delay : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_statistics_valid : out STD_LOGIC;
    tx_statistics_vector : out STD_LOGIC_VECTOR ( 25 downto 0 );
    txn : out STD_LOGIC;
    txp : out STD_LOGIC;
    txuserrdy_out : out STD_LOGIC;
    txusrclk2_out : out STD_LOGIC;
    txusrclk_out : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of bd_b160 : entity is "bd_b160,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_b160,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=4,numReposBlks=4,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SBD,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of bd_b160 : entity is "ethernet_core.hwdef";
end bd_b160;

architecture STRUCTURE of bd_b160 is
  component bd_b160_xmac_0 is
  port (
    tx_clk0 : in STD_LOGIC;
    reset : in STD_LOGIC;
    tx_axis_aresetn : in STD_LOGIC;
    tx_axis_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    tx_axis_tvalid : in STD_LOGIC;
    tx_axis_tlast : in STD_LOGIC;
    tx_axis_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    tx_ifg_delay : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_axis_tkeep : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_axis_tready : out STD_LOGIC;
    tx_statistics_vector : out STD_LOGIC_VECTOR ( 25 downto 0 );
    tx_statistics_valid : out STD_LOGIC;
    rx_axis_aresetn : in STD_LOGIC;
    rx_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    rx_axis_tvalid : out STD_LOGIC;
    rx_axis_tuser : out STD_LOGIC;
    rx_axis_tlast : out STD_LOGIC;
    rx_axis_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_statistics_vector : out STD_LOGIC_VECTOR ( 29 downto 0 );
    rx_statistics_valid : out STD_LOGIC;
    pause_val : in STD_LOGIC_VECTOR ( 15 downto 0 );
    pause_req : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 79 downto 0 );
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 79 downto 0 );
    status_vector : out STD_LOGIC_VECTOR ( 2 downto 0 );
    tx_dcm_locked : in STD_LOGIC;
    xgmii_txd : out STD_LOGIC_VECTOR ( 63 downto 0 );
    xgmii_txc : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_clk0 : in STD_LOGIC;
    rx_dcm_locked : in STD_LOGIC;
    xgmii_rxd : in STD_LOGIC_VECTOR ( 63 downto 0 );
    xgmii_rxc : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component bd_b160_xmac_0;
  component bd_b160_xpcs_0 is
  port (
    refclk_p : in STD_LOGIC;
    refclk_n : in STD_LOGIC;
    reset : in STD_LOGIC;
    resetdone_out : out STD_LOGIC;
    coreclk_out : out STD_LOGIC;
    rxrecclk_out : out STD_LOGIC;
    dclk : in STD_LOGIC;
    txp : out STD_LOGIC;
    txn : out STD_LOGIC;
    rxp : in STD_LOGIC;
    rxn : in STD_LOGIC;
    sim_speedup_control : in STD_LOGIC;
    txusrclk_out : out STD_LOGIC;
    txusrclk2_out : out STD_LOGIC;
    areset_datapathclk_out : out STD_LOGIC;
    gttxreset_out : out STD_LOGIC;
    gtrxreset_out : out STD_LOGIC;
    txuserrdy_out : out STD_LOGIC;
    reset_counter_done_out : out STD_LOGIC;
    qplllock_out : out STD_LOGIC;
    qplloutclk_out : out STD_LOGIC;
    qplloutrefclk_out : out STD_LOGIC;
    xgmii_txd : in STD_LOGIC_VECTOR ( 63 downto 0 );
    xgmii_txc : in STD_LOGIC_VECTOR ( 7 downto 0 );
    xgmii_rxd : out STD_LOGIC_VECTOR ( 63 downto 0 );
    xgmii_rxc : out STD_LOGIC_VECTOR ( 7 downto 0 );
    configuration_vector : in STD_LOGIC_VECTOR ( 535 downto 0 );
    status_vector : out STD_LOGIC_VECTOR ( 447 downto 0 );
    core_status : out STD_LOGIC_VECTOR ( 7 downto 0 );
    signal_detect : in STD_LOGIC;
    tx_fault : in STD_LOGIC;
    drp_req : out STD_LOGIC;
    drp_gnt : in STD_LOGIC;
    drp_den_o : out STD_LOGIC;
    drp_dwe_o : out STD_LOGIC;
    drp_daddr_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drp_di_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drp_drdy_o : out STD_LOGIC;
    drp_drpdo_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drp_den_i : in STD_LOGIC;
    drp_dwe_i : in STD_LOGIC;
    drp_daddr_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    drp_di_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    drp_drdy_i : in STD_LOGIC;
    drp_drpdo_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    tx_disable : out STD_LOGIC;
    pma_pmd_type : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  end component bd_b160_xpcs_0;
  component bd_b160_dcm_locked_driver_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component bd_b160_dcm_locked_driver_0;
  component bd_b160_pma_pmd_type_driver_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  end component bd_b160_pma_pmd_type_driver_0;
  signal dclk_1 : STD_LOGIC;
  signal dcm_locked_driver_dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal mac_rx_configuration_vector_1 : STD_LOGIC_VECTOR ( 79 downto 0 );
  signal mac_tx_configuration_vector_1 : STD_LOGIC_VECTOR ( 79 downto 0 );
  signal pcs_pma_configuration_vector_1 : STD_LOGIC_VECTOR ( 535 downto 0 );
  signal pma_pmd_type_driver_dout : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal refclk_n_1 : STD_LOGIC;
  signal refclk_p_1 : STD_LOGIC;
  signal reset_1 : STD_LOGIC;
  signal rx_axis_aresetn_1 : STD_LOGIC;
  signal rxn_1 : STD_LOGIC;
  signal rxp_1 : STD_LOGIC;
  signal s_axis_pause_1_TDATA : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal s_axis_pause_1_TVALID : STD_LOGIC;
  signal s_axis_tx_1_TDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal s_axis_tx_1_TKEEP : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s_axis_tx_1_TLAST : STD_LOGIC;
  signal s_axis_tx_1_TREADY : STD_LOGIC;
  signal s_axis_tx_1_TUSER : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s_axis_tx_1_TVALID : STD_LOGIC;
  signal signal_detect_1 : STD_LOGIC;
  signal sim_speedup_control_1 : STD_LOGIC;
  signal tx_axis_aresetn_1 : STD_LOGIC;
  signal tx_fault_1 : STD_LOGIC;
  signal tx_ifg_delay_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal xmac_m_axis_rx_TDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal xmac_m_axis_rx_TKEEP : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal xmac_m_axis_rx_TLAST : STD_LOGIC;
  signal xmac_m_axis_rx_TUSER : STD_LOGIC;
  signal xmac_m_axis_rx_TVALID : STD_LOGIC;
  signal xmac_rx_statistics_valid : STD_LOGIC;
  signal xmac_rx_statistics_vector : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal xmac_status_vector : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal xmac_tx_statistics_valid : STD_LOGIC;
  signal xmac_tx_statistics_vector : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal xmac_xgmii_xgmac_RXC : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal xmac_xgmii_xgmac_RXD : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal xmac_xgmii_xgmac_TXC : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal xmac_xgmii_xgmac_TXD : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal xpcs_areset_datapathclk_out : STD_LOGIC;
  signal xpcs_core_gt_drp_interface_DADDR : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal xpcs_core_gt_drp_interface_DEN : STD_LOGIC;
  signal xpcs_core_gt_drp_interface_DI : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal xpcs_core_gt_drp_interface_DO : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal xpcs_core_gt_drp_interface_DRDY : STD_LOGIC;
  signal xpcs_core_gt_drp_interface_DWE : STD_LOGIC;
  signal xpcs_core_status : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal xpcs_coreclk_out : STD_LOGIC;
  signal xpcs_drp_req : STD_LOGIC;
  signal xpcs_gtrxreset_out : STD_LOGIC;
  signal xpcs_gttxreset_out : STD_LOGIC;
  signal xpcs_qplllock_out : STD_LOGIC;
  signal xpcs_qplloutclk_out : STD_LOGIC;
  signal xpcs_qplloutrefclk_out : STD_LOGIC;
  signal xpcs_reset_counter_done_out : STD_LOGIC;
  signal xpcs_resetdone_out : STD_LOGIC;
  signal xpcs_rxrecclk_out : STD_LOGIC;
  signal xpcs_status_vector : STD_LOGIC_VECTOR ( 447 downto 0 );
  signal xpcs_tx_disable : STD_LOGIC;
  signal xpcs_txn : STD_LOGIC;
  signal xpcs_txp : STD_LOGIC;
  signal xpcs_txuserrdy_out : STD_LOGIC;
  signal xpcs_txusrclk2_out : STD_LOGIC;
  signal xpcs_txusrclk_out : STD_LOGIC;
begin
  areset_datapathclk_out <= xpcs_areset_datapathclk_out;
  coreclk_out <= xpcs_coreclk_out;
  dclk_1 <= dclk;
  gtrxreset_out <= xpcs_gtrxreset_out;
  gttxreset_out <= xpcs_gttxreset_out;
  m_axis_rx_tdata(63 downto 0) <= xmac_m_axis_rx_TDATA(63 downto 0);
  m_axis_rx_tkeep(7 downto 0) <= xmac_m_axis_rx_TKEEP(7 downto 0);
  m_axis_rx_tlast <= xmac_m_axis_rx_TLAST;
  m_axis_rx_tuser <= xmac_m_axis_rx_TUSER;
  m_axis_rx_tvalid <= xmac_m_axis_rx_TVALID;
  mac_rx_configuration_vector_1(79 downto 0) <= mac_rx_configuration_vector(79 downto 0);
  mac_status_vector(2 downto 0) <= xmac_status_vector(2 downto 0);
  mac_tx_configuration_vector_1(79 downto 0) <= mac_tx_configuration_vector(79 downto 0);
  pcs_pma_configuration_vector_1(535 downto 0) <= pcs_pma_configuration_vector(535 downto 0);
  pcs_pma_status_vector(447 downto 0) <= xpcs_status_vector(447 downto 0);
  pcspma_status(7 downto 0) <= xpcs_core_status(7 downto 0);
  qplllock_out <= xpcs_qplllock_out;
  qplloutclk_out <= xpcs_qplloutclk_out;
  qplloutrefclk_out <= xpcs_qplloutrefclk_out;
  refclk_n_1 <= refclk_n;
  refclk_p_1 <= refclk_p;
  reset_1 <= reset;
  reset_counter_done_out <= xpcs_reset_counter_done_out;
  resetdone_out <= xpcs_resetdone_out;
  rx_axis_aresetn_1 <= rx_axis_aresetn;
  rx_statistics_valid <= xmac_rx_statistics_valid;
  rx_statistics_vector(29 downto 0) <= xmac_rx_statistics_vector(29 downto 0);
  rxn_1 <= rxn;
  rxp_1 <= rxp;
  rxrecclk_out <= xpcs_rxrecclk_out;
  s_axis_pause_1_TDATA(15 downto 0) <= s_axis_pause_tdata(15 downto 0);
  s_axis_pause_1_TVALID <= s_axis_pause_tvalid;
  s_axis_tx_1_TDATA(63 downto 0) <= s_axis_tx_tdata(63 downto 0);
  s_axis_tx_1_TKEEP(7 downto 0) <= s_axis_tx_tkeep(7 downto 0);
  s_axis_tx_1_TLAST <= s_axis_tx_tlast;
  s_axis_tx_1_TUSER(0) <= s_axis_tx_tuser(0);
  s_axis_tx_1_TVALID <= s_axis_tx_tvalid;
  s_axis_tx_tready <= s_axis_tx_1_TREADY;
  signal_detect_1 <= signal_detect;
  sim_speedup_control_1 <= sim_speedup_control;
  tx_axis_aresetn_1 <= tx_axis_aresetn;
  tx_disable <= xpcs_tx_disable;
  tx_fault_1 <= tx_fault;
  tx_ifg_delay_1(7 downto 0) <= tx_ifg_delay(7 downto 0);
  tx_statistics_valid <= xmac_tx_statistics_valid;
  tx_statistics_vector(25 downto 0) <= xmac_tx_statistics_vector(25 downto 0);
  txn <= xpcs_txn;
  txp <= xpcs_txp;
  txuserrdy_out <= xpcs_txuserrdy_out;
  txusrclk2_out <= xpcs_txusrclk2_out;
  txusrclk_out <= xpcs_txusrclk_out;
dcm_locked_driver: component bd_b160_dcm_locked_driver_0
     port map (
      dout(0) => dcm_locked_driver_dout(0)
    );
pma_pmd_type_driver: component bd_b160_pma_pmd_type_driver_0
     port map (
      dout(2 downto 0) => pma_pmd_type_driver_dout(2 downto 0)
    );
xmac: component bd_b160_xmac_0
     port map (
      pause_req => s_axis_pause_1_TVALID,
      pause_val(15 downto 0) => s_axis_pause_1_TDATA(15 downto 0),
      reset => reset_1,
      rx_axis_aresetn => rx_axis_aresetn_1,
      rx_axis_tdata(63 downto 0) => xmac_m_axis_rx_TDATA(63 downto 0),
      rx_axis_tkeep(7 downto 0) => xmac_m_axis_rx_TKEEP(7 downto 0),
      rx_axis_tlast => xmac_m_axis_rx_TLAST,
      rx_axis_tuser => xmac_m_axis_rx_TUSER,
      rx_axis_tvalid => xmac_m_axis_rx_TVALID,
      rx_clk0 => xpcs_coreclk_out,
      rx_configuration_vector(79 downto 0) => mac_rx_configuration_vector_1(79 downto 0),
      rx_dcm_locked => dcm_locked_driver_dout(0),
      rx_statistics_valid => xmac_rx_statistics_valid,
      rx_statistics_vector(29 downto 0) => xmac_rx_statistics_vector(29 downto 0),
      status_vector(2 downto 0) => xmac_status_vector(2 downto 0),
      tx_axis_aresetn => tx_axis_aresetn_1,
      tx_axis_tdata(63 downto 0) => s_axis_tx_1_TDATA(63 downto 0),
      tx_axis_tkeep(7 downto 0) => s_axis_tx_1_TKEEP(7 downto 0),
      tx_axis_tlast => s_axis_tx_1_TLAST,
      tx_axis_tready => s_axis_tx_1_TREADY,
      tx_axis_tuser(0) => s_axis_tx_1_TUSER(0),
      tx_axis_tvalid => s_axis_tx_1_TVALID,
      tx_clk0 => xpcs_coreclk_out,
      tx_configuration_vector(79 downto 0) => mac_tx_configuration_vector_1(79 downto 0),
      tx_dcm_locked => dcm_locked_driver_dout(0),
      tx_ifg_delay(7 downto 0) => tx_ifg_delay_1(7 downto 0),
      tx_statistics_valid => xmac_tx_statistics_valid,
      tx_statistics_vector(25 downto 0) => xmac_tx_statistics_vector(25 downto 0),
      xgmii_rxc(7 downto 0) => xmac_xgmii_xgmac_RXC(7 downto 0),
      xgmii_rxd(63 downto 0) => xmac_xgmii_xgmac_RXD(63 downto 0),
      xgmii_txc(7 downto 0) => xmac_xgmii_xgmac_TXC(7 downto 0),
      xgmii_txd(63 downto 0) => xmac_xgmii_xgmac_TXD(63 downto 0)
    );
xpcs: component bd_b160_xpcs_0
     port map (
      areset_datapathclk_out => xpcs_areset_datapathclk_out,
      configuration_vector(535 downto 0) => pcs_pma_configuration_vector_1(535 downto 0),
      core_status(7 downto 0) => xpcs_core_status(7 downto 0),
      coreclk_out => xpcs_coreclk_out,
      dclk => dclk_1,
      drp_daddr_i(15 downto 0) => xpcs_core_gt_drp_interface_DADDR(15 downto 0),
      drp_daddr_o(15 downto 0) => xpcs_core_gt_drp_interface_DADDR(15 downto 0),
      drp_den_i => xpcs_core_gt_drp_interface_DEN,
      drp_den_o => xpcs_core_gt_drp_interface_DEN,
      drp_di_i(15 downto 0) => xpcs_core_gt_drp_interface_DI(15 downto 0),
      drp_di_o(15 downto 0) => xpcs_core_gt_drp_interface_DI(15 downto 0),
      drp_drdy_i => xpcs_core_gt_drp_interface_DRDY,
      drp_drdy_o => xpcs_core_gt_drp_interface_DRDY,
      drp_drpdo_i(15 downto 0) => xpcs_core_gt_drp_interface_DO(15 downto 0),
      drp_drpdo_o(15 downto 0) => xpcs_core_gt_drp_interface_DO(15 downto 0),
      drp_dwe_i => xpcs_core_gt_drp_interface_DWE,
      drp_dwe_o => xpcs_core_gt_drp_interface_DWE,
      drp_gnt => xpcs_drp_req,
      drp_req => xpcs_drp_req,
      gtrxreset_out => xpcs_gtrxreset_out,
      gttxreset_out => xpcs_gttxreset_out,
      pma_pmd_type(2 downto 0) => pma_pmd_type_driver_dout(2 downto 0),
      qplllock_out => xpcs_qplllock_out,
      qplloutclk_out => xpcs_qplloutclk_out,
      qplloutrefclk_out => xpcs_qplloutrefclk_out,
      refclk_n => refclk_n_1,
      refclk_p => refclk_p_1,
      reset => reset_1,
      reset_counter_done_out => xpcs_reset_counter_done_out,
      resetdone_out => xpcs_resetdone_out,
      rxn => rxn_1,
      rxp => rxp_1,
      rxrecclk_out => xpcs_rxrecclk_out,
      signal_detect => signal_detect_1,
      sim_speedup_control => sim_speedup_control_1,
      status_vector(447 downto 0) => xpcs_status_vector(447 downto 0),
      tx_disable => xpcs_tx_disable,
      tx_fault => tx_fault_1,
      txn => xpcs_txn,
      txp => xpcs_txp,
      txuserrdy_out => xpcs_txuserrdy_out,
      txusrclk2_out => xpcs_txusrclk2_out,
      txusrclk_out => xpcs_txusrclk_out,
      xgmii_rxc(7 downto 0) => xmac_xgmii_xgmac_RXC(7 downto 0),
      xgmii_rxd(63 downto 0) => xmac_xgmii_xgmac_RXD(63 downto 0),
      xgmii_txc(7 downto 0) => xmac_xgmii_xgmac_TXC(7 downto 0),
      xgmii_txd(63 downto 0) => xmac_xgmii_xgmac_TXD(63 downto 0)
    );
end STRUCTURE;
