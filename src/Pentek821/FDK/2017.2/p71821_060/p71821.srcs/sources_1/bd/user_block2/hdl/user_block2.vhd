--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
--Date        : Tue Apr 27 22:15:17 2021
--Host        : wind running 64-bit unknown
--Command     : generate_target user_block2.bd
--Design      : user_block2
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity controller_imp_F1VSVM is
  port (
    adc_aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    coef_ch0_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_ch0_tready : in STD_LOGIC;
    coef_ch0_tvalid : out STD_LOGIC;
    coef_ch1_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_ch1_tready : in STD_LOGIC;
    coef_ch1_tvalid : out STD_LOGIC;
    coef_ch2_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_ch2_tready : in STD_LOGIC;
    coef_ch2_tvalid : out STD_LOGIC;
    control_flags : out STD_LOGIC_VECTOR ( 31 downto 0 );
    controller_PPS : in STD_LOGIC;
    filter_select_ch0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    filter_select_ch1 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    filter_select_ch2 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    mt_pulse : out STD_LOGIC_VECTOR ( 7 downto 0 );
    pulse_metadata_ch0_tdata : out STD_LOGIC_VECTOR ( 823 downto 0 );
    pulse_metadata_ch0_tready : in STD_LOGIC;
    pulse_metadata_ch0_tvalid : out STD_LOGIC;
    pulse_metadata_ch1_tdata : out STD_LOGIC_VECTOR ( 823 downto 0 );
    pulse_metadata_ch1_tready : in STD_LOGIC;
    pulse_metadata_ch1_tvalid : out STD_LOGIC;
    pulse_metadata_ch2_tdata : out STD_LOGIC_VECTOR ( 823 downto 0 );
    pulse_metadata_ch2_tready : in STD_LOGIC;
    pulse_metadata_ch2_tvalid : out STD_LOGIC;
    s_axi_cfg_bus_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_cfg_bus_arready : out STD_LOGIC;
    s_axi_cfg_bus_arvalid : in STD_LOGIC;
    s_axi_cfg_bus_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_cfg_bus_awready : out STD_LOGIC;
    s_axi_cfg_bus_awvalid : in STD_LOGIC;
    s_axi_cfg_bus_bready : in STD_LOGIC;
    s_axi_cfg_bus_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_cfg_bus_bvalid : out STD_LOGIC;
    s_axi_cfg_bus_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_cfg_bus_rready : in STD_LOGIC;
    s_axi_cfg_bus_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_cfg_bus_rvalid : out STD_LOGIC;
    s_axi_cfg_bus_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_cfg_bus_wready : out STD_LOGIC;
    s_axi_cfg_bus_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_cfg_bus_wvalid : in STD_LOGIC
  );
end controller_imp_F1VSVM;

architecture STRUCTURE of controller_imp_F1VSVM is
  component user_block2_axis_subset_converter_0_2 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 )
  );
  end component user_block2_axis_subset_converter_0_2;
  component user_block2_validate_kludge_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 )
  );
  end component user_block2_validate_kludge_0_0;
  component user_block2_validate_kludge_1_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 23 downto 0 )
  );
  end component user_block2_validate_kludge_1_0;
  component user_block2_hcr_controller_0_0 is
  port (
    pps_ce0 : out STD_LOGIC;
    pps_we0 : out STD_LOGIC;
    mt_pulse_V_ap_vld : out STD_LOGIC;
    control_flags_V_ap_vld : out STD_LOGIC;
    filter_select_ch0_V_ap_vld : out STD_LOGIC;
    filter_select_ch1_V_ap_vld : out STD_LOGIC;
    filter_select_ch2_V_ap_vld : out STD_LOGIC;
    s_axi_cfg_bus_AWADDR : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_cfg_bus_AWVALID : in STD_LOGIC;
    s_axi_cfg_bus_AWREADY : out STD_LOGIC;
    s_axi_cfg_bus_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_cfg_bus_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_cfg_bus_WVALID : in STD_LOGIC;
    s_axi_cfg_bus_WREADY : out STD_LOGIC;
    s_axi_cfg_bus_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_cfg_bus_BVALID : out STD_LOGIC;
    s_axi_cfg_bus_BREADY : in STD_LOGIC;
    s_axi_cfg_bus_ARADDR : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_cfg_bus_ARVALID : in STD_LOGIC;
    s_axi_cfg_bus_ARREADY : out STD_LOGIC;
    s_axi_cfg_bus_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_cfg_bus_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_cfg_bus_RVALID : out STD_LOGIC;
    s_axi_cfg_bus_RREADY : in STD_LOGIC;
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    interrupt : out STD_LOGIC;
    coef_ch0_V_V_TVALID : out STD_LOGIC;
    coef_ch0_V_V_TREADY : in STD_LOGIC;
    coef_ch0_V_V_TDATA : out STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_ch1_V_V_TVALID : out STD_LOGIC;
    coef_ch1_V_V_TREADY : in STD_LOGIC;
    coef_ch1_V_V_TDATA : out STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_ch2_V_V_TVALID : out STD_LOGIC;
    coef_ch2_V_V_TREADY : in STD_LOGIC;
    coef_ch2_V_V_TDATA : out STD_LOGIC_VECTOR ( 23 downto 0 );
    mt_pulse_V : out STD_LOGIC_VECTOR ( 7 downto 0 );
    control_flags_V : out STD_LOGIC_VECTOR ( 31 downto 0 );
    filter_select_ch0_V : out STD_LOGIC_VECTOR ( 1 downto 0 );
    filter_select_ch1_V : out STD_LOGIC_VECTOR ( 1 downto 0 );
    filter_select_ch2_V : out STD_LOGIC_VECTOR ( 1 downto 0 );
    pulse_metadata_ch0_V_TVALID : out STD_LOGIC;
    pulse_metadata_ch0_V_TREADY : in STD_LOGIC;
    pulse_metadata_ch0_V_TDATA : out STD_LOGIC_VECTOR ( 823 downto 0 );
    pulse_metadata_ch1_V_TVALID : out STD_LOGIC;
    pulse_metadata_ch1_V_TREADY : in STD_LOGIC;
    pulse_metadata_ch1_V_TDATA : out STD_LOGIC_VECTOR ( 823 downto 0 );
    pulse_metadata_ch2_V_TVALID : out STD_LOGIC;
    pulse_metadata_ch2_V_TREADY : in STD_LOGIC;
    pulse_metadata_ch2_V_TDATA : out STD_LOGIC_VECTOR ( 823 downto 0 );
    pps_address0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    pps_d0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    pps_q0 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component user_block2_hcr_controller_0_0;
  component user_block2_enable_mux_0_2 is
  port (
    EN : in STD_LOGIC;
    I : in STD_LOGIC_VECTOR ( 7 downto 0 );
    O : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component user_block2_enable_mux_0_2;
  component user_block2_enable_mux_0_3 is
  port (
    EN : in STD_LOGIC;
    I : in STD_LOGIC_VECTOR ( 31 downto 0 );
    O : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component user_block2_enable_mux_0_3;
  signal Conn1_ARADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal Conn1_ARREADY : STD_LOGIC;
  signal Conn1_ARVALID : STD_LOGIC;
  signal Conn1_AWADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal Conn1_AWREADY : STD_LOGIC;
  signal Conn1_AWVALID : STD_LOGIC;
  signal Conn1_BREADY : STD_LOGIC;
  signal Conn1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn1_BVALID : STD_LOGIC;
  signal Conn1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_RREADY : STD_LOGIC;
  signal Conn1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal Conn1_RVALID : STD_LOGIC;
  signal Conn1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_WREADY : STD_LOGIC;
  signal Conn1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn1_WVALID : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal axis_subset_converter_0_M_AXIS_TREADY : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS_TVALID : STD_LOGIC;
  signal enable_mux_0_O : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal enable_mux_1_O : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal hcr_controller_0_coef_ch0_V_V_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal hcr_controller_0_coef_ch0_V_V_TREADY : STD_LOGIC;
  signal hcr_controller_0_coef_ch0_V_V_TVALID : STD_LOGIC;
  signal hcr_controller_0_coef_ch1_V_V_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal hcr_controller_0_coef_ch1_V_V_TREADY : STD_LOGIC;
  signal hcr_controller_0_coef_ch1_V_V_TVALID : STD_LOGIC;
  signal hcr_controller_0_coef_ch2_V_V_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal hcr_controller_0_coef_ch2_V_V_TREADY : STD_LOGIC;
  signal hcr_controller_0_coef_ch2_V_V_TVALID : STD_LOGIC;
  signal hcr_controller_0_control_flags_V : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal hcr_controller_0_control_flags_V_ap_vld : STD_LOGIC;
  signal hcr_controller_0_filter_select_ch0_V : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal hcr_controller_0_filter_select_ch1_V : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal hcr_controller_0_filter_select_ch2_V : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal hcr_controller_0_mt_pulse_V : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal hcr_controller_0_mt_pulse_V_ap_vld : STD_LOGIC;
  signal hcr_controller_0_pulse_metadata_ch0_V_TDATA : STD_LOGIC_VECTOR ( 823 downto 0 );
  signal hcr_controller_0_pulse_metadata_ch0_V_TREADY : STD_LOGIC;
  signal hcr_controller_0_pulse_metadata_ch0_V_TVALID : STD_LOGIC;
  signal hcr_controller_0_pulse_metadata_ch2_V_TDATA : STD_LOGIC_VECTOR ( 823 downto 0 );
  signal hcr_controller_0_pulse_metadata_ch2_V_TREADY : STD_LOGIC;
  signal hcr_controller_0_pulse_metadata_ch2_V_TVALID : STD_LOGIC;
  signal pulse_metadata_1_TDATA : STD_LOGIC_VECTOR ( 823 downto 0 );
  signal pulse_metadata_1_TREADY : STD_LOGIC;
  signal pulse_metadata_1_TVALID : STD_LOGIC;
  signal reset_reg_aresetn : STD_LOGIC;
  signal s_axis_adc_pdti_aclk_1 : STD_LOGIC;
  signal sync_pulse_1 : STD_LOGIC;
  signal validate_kludge_1_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal validate_kludge_1_M_AXIS_TREADY : STD_LOGIC;
  signal validate_kludge_1_M_AXIS_TVALID : STD_LOGIC;
  signal validate_kludge_2_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal validate_kludge_2_M_AXIS_TREADY : STD_LOGIC;
  signal validate_kludge_2_M_AXIS_TVALID : STD_LOGIC;
  signal NLW_hcr_controller_0_filter_select_ch0_V_ap_vld_UNCONNECTED : STD_LOGIC;
  signal NLW_hcr_controller_0_filter_select_ch1_V_ap_vld_UNCONNECTED : STD_LOGIC;
  signal NLW_hcr_controller_0_filter_select_ch2_V_ap_vld_UNCONNECTED : STD_LOGIC;
  signal NLW_hcr_controller_0_interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_hcr_controller_0_pps_ce0_UNCONNECTED : STD_LOGIC;
  signal NLW_hcr_controller_0_pps_we0_UNCONNECTED : STD_LOGIC;
  signal NLW_hcr_controller_0_pps_address0_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_hcr_controller_0_pps_d0_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  Conn1_ARADDR(12 downto 0) <= s_axi_cfg_bus_araddr(12 downto 0);
  Conn1_ARVALID <= s_axi_cfg_bus_arvalid;
  Conn1_AWADDR(12 downto 0) <= s_axi_cfg_bus_awaddr(12 downto 0);
  Conn1_AWVALID <= s_axi_cfg_bus_awvalid;
  Conn1_BREADY <= s_axi_cfg_bus_bready;
  Conn1_RREADY <= s_axi_cfg_bus_rready;
  Conn1_WDATA(31 downto 0) <= s_axi_cfg_bus_wdata(31 downto 0);
  Conn1_WSTRB(3 downto 0) <= s_axi_cfg_bus_wstrb(3 downto 0);
  Conn1_WVALID <= s_axi_cfg_bus_wvalid;
  axis_subset_converter_0_M_AXIS_TREADY <= coef_ch0_tready;
  coef_ch0_tdata(23 downto 0) <= axis_subset_converter_0_M_AXIS_TDATA(23 downto 0);
  coef_ch0_tvalid <= axis_subset_converter_0_M_AXIS_TVALID;
  coef_ch1_tdata(23 downto 0) <= validate_kludge_1_M_AXIS_TDATA(23 downto 0);
  coef_ch1_tvalid <= validate_kludge_1_M_AXIS_TVALID;
  coef_ch2_tdata(23 downto 0) <= validate_kludge_2_M_AXIS_TDATA(23 downto 0);
  coef_ch2_tvalid <= validate_kludge_2_M_AXIS_TVALID;
  control_flags(31 downto 0) <= enable_mux_1_O(31 downto 0);
  filter_select_ch0(1 downto 0) <= hcr_controller_0_filter_select_ch0_V(1 downto 0);
  filter_select_ch1(1 downto 0) <= hcr_controller_0_filter_select_ch1_V(1 downto 0);
  filter_select_ch2(1 downto 0) <= hcr_controller_0_filter_select_ch2_V(1 downto 0);
  hcr_controller_0_pulse_metadata_ch0_V_TREADY <= pulse_metadata_ch0_tready;
  hcr_controller_0_pulse_metadata_ch2_V_TREADY <= pulse_metadata_ch2_tready;
  mt_pulse(7 downto 0) <= enable_mux_0_O(7 downto 0);
  pulse_metadata_1_TREADY <= pulse_metadata_ch1_tready;
  pulse_metadata_ch0_tdata(823 downto 0) <= hcr_controller_0_pulse_metadata_ch0_V_TDATA(823 downto 0);
  pulse_metadata_ch0_tvalid <= hcr_controller_0_pulse_metadata_ch0_V_TVALID;
  pulse_metadata_ch1_tdata(823 downto 0) <= pulse_metadata_1_TDATA(823 downto 0);
  pulse_metadata_ch1_tvalid <= pulse_metadata_1_TVALID;
  pulse_metadata_ch2_tdata(823 downto 0) <= hcr_controller_0_pulse_metadata_ch2_V_TDATA(823 downto 0);
  pulse_metadata_ch2_tvalid <= hcr_controller_0_pulse_metadata_ch2_V_TVALID;
  reset_reg_aresetn <= aresetn;
  s_axi_cfg_bus_arready <= Conn1_ARREADY;
  s_axi_cfg_bus_awready <= Conn1_AWREADY;
  s_axi_cfg_bus_bresp(1 downto 0) <= Conn1_BRESP(1 downto 0);
  s_axi_cfg_bus_bvalid <= Conn1_BVALID;
  s_axi_cfg_bus_rdata(31 downto 0) <= Conn1_RDATA(31 downto 0);
  s_axi_cfg_bus_rresp(1 downto 0) <= Conn1_RRESP(1 downto 0);
  s_axi_cfg_bus_rvalid <= Conn1_RVALID;
  s_axi_cfg_bus_wready <= Conn1_WREADY;
  s_axis_adc_pdti_aclk_1 <= adc_aclk;
  sync_pulse_1 <= controller_PPS;
  validate_kludge_1_M_AXIS_TREADY <= coef_ch1_tready;
  validate_kludge_2_M_AXIS_TREADY <= coef_ch2_tready;
enable_mux_0: component user_block2_enable_mux_0_2
     port map (
      EN => hcr_controller_0_mt_pulse_V_ap_vld,
      I(7 downto 0) => hcr_controller_0_mt_pulse_V(7 downto 0),
      O(7 downto 0) => enable_mux_0_O(7 downto 0)
    );
enable_mux_1: component user_block2_enable_mux_0_3
     port map (
      EN => hcr_controller_0_control_flags_V_ap_vld,
      I(31 downto 0) => hcr_controller_0_control_flags_V(31 downto 0),
      O(31 downto 0) => enable_mux_1_O(31 downto 0)
    );
hcr_controller_0: component user_block2_hcr_controller_0_0
     port map (
      ap_clk => s_axis_adc_pdti_aclk_1,
      ap_rst_n => reset_reg_aresetn,
      coef_ch0_V_V_TDATA(23 downto 0) => hcr_controller_0_coef_ch0_V_V_TDATA(23 downto 0),
      coef_ch0_V_V_TREADY => hcr_controller_0_coef_ch0_V_V_TREADY,
      coef_ch0_V_V_TVALID => hcr_controller_0_coef_ch0_V_V_TVALID,
      coef_ch1_V_V_TDATA(23 downto 0) => hcr_controller_0_coef_ch1_V_V_TDATA(23 downto 0),
      coef_ch1_V_V_TREADY => hcr_controller_0_coef_ch1_V_V_TREADY,
      coef_ch1_V_V_TVALID => hcr_controller_0_coef_ch1_V_V_TVALID,
      coef_ch2_V_V_TDATA(23 downto 0) => hcr_controller_0_coef_ch2_V_V_TDATA(23 downto 0),
      coef_ch2_V_V_TREADY => hcr_controller_0_coef_ch2_V_V_TREADY,
      coef_ch2_V_V_TVALID => hcr_controller_0_coef_ch2_V_V_TVALID,
      control_flags_V(31 downto 0) => hcr_controller_0_control_flags_V(31 downto 0),
      control_flags_V_ap_vld => hcr_controller_0_control_flags_V_ap_vld,
      filter_select_ch0_V(1 downto 0) => hcr_controller_0_filter_select_ch0_V(1 downto 0),
      filter_select_ch0_V_ap_vld => NLW_hcr_controller_0_filter_select_ch0_V_ap_vld_UNCONNECTED,
      filter_select_ch1_V(1 downto 0) => hcr_controller_0_filter_select_ch1_V(1 downto 0),
      filter_select_ch1_V_ap_vld => NLW_hcr_controller_0_filter_select_ch1_V_ap_vld_UNCONNECTED,
      filter_select_ch2_V(1 downto 0) => hcr_controller_0_filter_select_ch2_V(1 downto 0),
      filter_select_ch2_V_ap_vld => NLW_hcr_controller_0_filter_select_ch2_V_ap_vld_UNCONNECTED,
      interrupt => NLW_hcr_controller_0_interrupt_UNCONNECTED,
      mt_pulse_V(7 downto 0) => hcr_controller_0_mt_pulse_V(7 downto 0),
      mt_pulse_V_ap_vld => hcr_controller_0_mt_pulse_V_ap_vld,
      pps_address0(0) => NLW_hcr_controller_0_pps_address0_UNCONNECTED(0),
      pps_ce0 => NLW_hcr_controller_0_pps_ce0_UNCONNECTED,
      pps_d0(0) => NLW_hcr_controller_0_pps_d0_UNCONNECTED(0),
      pps_q0(0) => sync_pulse_1,
      pps_we0 => NLW_hcr_controller_0_pps_we0_UNCONNECTED,
      pulse_metadata_ch0_V_TDATA(823 downto 0) => hcr_controller_0_pulse_metadata_ch0_V_TDATA(823 downto 0),
      pulse_metadata_ch0_V_TREADY => hcr_controller_0_pulse_metadata_ch0_V_TREADY,
      pulse_metadata_ch0_V_TVALID => hcr_controller_0_pulse_metadata_ch0_V_TVALID,
      pulse_metadata_ch1_V_TDATA(823 downto 0) => pulse_metadata_1_TDATA(823 downto 0),
      pulse_metadata_ch1_V_TREADY => pulse_metadata_1_TREADY,
      pulse_metadata_ch1_V_TVALID => pulse_metadata_1_TVALID,
      pulse_metadata_ch2_V_TDATA(823 downto 0) => hcr_controller_0_pulse_metadata_ch2_V_TDATA(823 downto 0),
      pulse_metadata_ch2_V_TREADY => hcr_controller_0_pulse_metadata_ch2_V_TREADY,
      pulse_metadata_ch2_V_TVALID => hcr_controller_0_pulse_metadata_ch2_V_TVALID,
      s_axi_cfg_bus_ARADDR(12 downto 0) => Conn1_ARADDR(12 downto 0),
      s_axi_cfg_bus_ARREADY => Conn1_ARREADY,
      s_axi_cfg_bus_ARVALID => Conn1_ARVALID,
      s_axi_cfg_bus_AWADDR(12 downto 0) => Conn1_AWADDR(12 downto 0),
      s_axi_cfg_bus_AWREADY => Conn1_AWREADY,
      s_axi_cfg_bus_AWVALID => Conn1_AWVALID,
      s_axi_cfg_bus_BREADY => Conn1_BREADY,
      s_axi_cfg_bus_BRESP(1 downto 0) => Conn1_BRESP(1 downto 0),
      s_axi_cfg_bus_BVALID => Conn1_BVALID,
      s_axi_cfg_bus_RDATA(31 downto 0) => Conn1_RDATA(31 downto 0),
      s_axi_cfg_bus_RREADY => Conn1_RREADY,
      s_axi_cfg_bus_RRESP(1 downto 0) => Conn1_RRESP(1 downto 0),
      s_axi_cfg_bus_RVALID => Conn1_RVALID,
      s_axi_cfg_bus_WDATA(31 downto 0) => Conn1_WDATA(31 downto 0),
      s_axi_cfg_bus_WREADY => Conn1_WREADY,
      s_axi_cfg_bus_WSTRB(3 downto 0) => Conn1_WSTRB(3 downto 0),
      s_axi_cfg_bus_WVALID => Conn1_WVALID
    );
validate_kludge_0: component user_block2_axis_subset_converter_0_2
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => reset_reg_aresetn,
      m_axis_tdata(23 downto 0) => axis_subset_converter_0_M_AXIS_TDATA(23 downto 0),
      m_axis_tready => axis_subset_converter_0_M_AXIS_TREADY,
      m_axis_tvalid => axis_subset_converter_0_M_AXIS_TVALID,
      s_axis_tdata(23 downto 0) => hcr_controller_0_coef_ch0_V_V_TDATA(23 downto 0),
      s_axis_tready => hcr_controller_0_coef_ch0_V_V_TREADY,
      s_axis_tvalid => hcr_controller_0_coef_ch0_V_V_TVALID
    );
validate_kludge_1: component user_block2_validate_kludge_0_0
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => reset_reg_aresetn,
      m_axis_tdata(23 downto 0) => validate_kludge_1_M_AXIS_TDATA(23 downto 0),
      m_axis_tready => validate_kludge_1_M_AXIS_TREADY,
      m_axis_tvalid => validate_kludge_1_M_AXIS_TVALID,
      s_axis_tdata(23 downto 0) => hcr_controller_0_coef_ch1_V_V_TDATA(23 downto 0),
      s_axis_tready => hcr_controller_0_coef_ch1_V_V_TREADY,
      s_axis_tvalid => hcr_controller_0_coef_ch1_V_V_TVALID
    );
validate_kludge_2: component user_block2_validate_kludge_1_0
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => reset_reg_aresetn,
      m_axis_tdata(23 downto 0) => validate_kludge_2_M_AXIS_TDATA(23 downto 0),
      m_axis_tready => validate_kludge_2_M_AXIS_TREADY,
      m_axis_tvalid => validate_kludge_2_M_AXIS_TVALID,
      s_axis_tdata(23 downto 0) => hcr_controller_0_coef_ch2_V_V_TDATA(23 downto 0),
      s_axis_tready => hcr_controller_0_coef_ch2_V_V_TREADY,
      s_axis_tvalid => hcr_controller_0_coef_ch2_V_V_TVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fir_imp_1O78BGT is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    coef_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_tready : out STD_LOGIC;
    coef_tvalid : in STD_LOGIC;
    i_data_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    i_data_tready : out STD_LOGIC;
    i_data_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    i_data_tvalid : in STD_LOGIC;
    o_data_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    o_data_tready : in STD_LOGIC;
    o_data_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    o_data_tvalid : out STD_LOGIC
  );
end fir_imp_1O78BGT;

architecture STRUCTURE of fir_imp_1O78BGT is
  component user_block2_axis_subset_converter_0_5 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 47 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  end component user_block2_axis_subset_converter_0_5;
  component user_block2_axis_subset_converter_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component user_block2_axis_subset_converter_0_0;
  component user_block2_axis_subset_converter_1_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  end component user_block2_axis_subset_converter_1_0;
  component user_block2_fir_compiler_0_0 is
  port (
    aresetn : in STD_LOGIC;
    aclk : in STD_LOGIC;
    s_axis_data_tvalid : in STD_LOGIC;
    s_axis_data_tready : out STD_LOGIC;
    s_axis_data_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_data_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_config_tvalid : in STD_LOGIC;
    s_axis_config_tready : out STD_LOGIC;
    s_axis_config_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_reload_tvalid : in STD_LOGIC;
    s_axis_reload_tready : out STD_LOGIC;
    s_axis_reload_tlast : in STD_LOGIC;
    s_axis_reload_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_data_tvalid : out STD_LOGIC;
    m_axis_data_tready : in STD_LOGIC;
    m_axis_data_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_data_tdata : out STD_LOGIC_VECTOR ( 47 downto 0 );
    event_s_reload_tlast_missing : out STD_LOGIC;
    event_s_reload_tlast_unexpected : out STD_LOGIC
  );
  end component user_block2_fir_compiler_0_0;
  component user_block2_axis_broadcaster_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 )
  );
  end component user_block2_axis_broadcaster_0_0;
  signal axis_broadcaster_0_M00_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_broadcaster_0_M00_AXIS_TREADY : STD_LOGIC;
  signal axis_broadcaster_0_M00_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_broadcaster_0_M00_AXIS_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axis_broadcaster_0_M01_AXIS_TDATA : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal axis_broadcaster_0_M01_AXIS_TREADY : STD_LOGIC;
  signal axis_broadcaster_0_M01_AXIS_TUSER : STD_LOGIC_VECTOR ( 255 downto 128 );
  signal axis_broadcaster_0_M01_AXIS_TVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axis_data_fifo_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute DEBUG : string;
  attribute DEBUG of axis_data_fifo_0_M_AXIS_TDATA : signal is "true";
  attribute MARK_DEBUG : boolean;
  attribute MARK_DEBUG of axis_data_fifo_0_M_AXIS_TDATA : signal is std.standard.true;
  signal axis_data_fifo_0_M_AXIS_TREADY : STD_LOGIC;
  attribute DEBUG of axis_data_fifo_0_M_AXIS_TREADY : signal is "true";
  attribute MARK_DEBUG of axis_data_fifo_0_M_AXIS_TREADY : signal is std.standard.true;
  signal axis_data_fifo_0_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  attribute DEBUG of axis_data_fifo_0_M_AXIS_TUSER : signal is "true";
  attribute MARK_DEBUG of axis_data_fifo_0_M_AXIS_TUSER : signal is std.standard.true;
  signal axis_data_fifo_0_M_AXIS_TVALID : STD_LOGIC;
  attribute DEBUG of axis_data_fifo_0_M_AXIS_TVALID : signal is "true";
  attribute MARK_DEBUG of axis_data_fifo_0_M_AXIS_TVALID : signal is std.standard.true;
  signal axis_subset_converter_0_M_AXIS2_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute DEBUG of axis_subset_converter_0_M_AXIS2_TDATA : signal is "true";
  attribute MARK_DEBUG of axis_subset_converter_0_M_AXIS2_TDATA : signal is std.standard.true;
  signal axis_subset_converter_0_M_AXIS2_TREADY : STD_LOGIC;
  attribute DEBUG of axis_subset_converter_0_M_AXIS2_TREADY : signal is "true";
  attribute MARK_DEBUG of axis_subset_converter_0_M_AXIS2_TREADY : signal is std.standard.true;
  signal axis_subset_converter_0_M_AXIS2_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  attribute DEBUG of axis_subset_converter_0_M_AXIS2_TUSER : signal is "true";
  attribute MARK_DEBUG of axis_subset_converter_0_M_AXIS2_TUSER : signal is std.standard.true;
  signal axis_subset_converter_0_M_AXIS2_TVALID : STD_LOGIC;
  attribute DEBUG of axis_subset_converter_0_M_AXIS2_TVALID : signal is "true";
  attribute MARK_DEBUG of axis_subset_converter_0_M_AXIS2_TVALID : signal is std.standard.true;
  signal axis_subset_converter_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axis_subset_converter_0_M_AXIS_TREADY : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS_TVALID : STD_LOGIC;
  signal axis_subset_converter_1_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_subset_converter_1_M_AXIS_TREADY : STD_LOGIC;
  signal axis_subset_converter_1_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_subset_converter_1_M_AXIS_TVALID : STD_LOGIC;
  signal coef_1_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal coef_1_TREADY : STD_LOGIC;
  signal coef_1_TVALID : STD_LOGIC;
  signal pulse_fir_0_M_AXIS_DATA_TDATA : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal pulse_fir_0_M_AXIS_DATA_TREADY : STD_LOGIC;
  signal pulse_fir_0_M_AXIS_DATA_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal pulse_fir_0_M_AXIS_DATA_TVALID : STD_LOGIC;
  signal s_axis_adc_pdti_aclk_1 : STD_LOGIC;
  signal s_axis_adc_pdti_aresetn_1 : STD_LOGIC;
  signal NLW_pulse_fir_event_s_reload_tlast_missing_UNCONNECTED : STD_LOGIC;
  signal NLW_pulse_fir_event_s_reload_tlast_unexpected_UNCONNECTED : STD_LOGIC;
begin
  axis_data_fifo_0_M_AXIS_TDATA(31 downto 0) <= i_data_tdata(31 downto 0);
  axis_data_fifo_0_M_AXIS_TUSER(127 downto 0) <= i_data_tuser(127 downto 0);
  axis_data_fifo_0_M_AXIS_TVALID <= i_data_tvalid;
  axis_subset_converter_0_M_AXIS2_TREADY <= o_data_tready;
  coef_1_TDATA(23 downto 0) <= coef_tdata(23 downto 0);
  coef_1_TVALID <= coef_tvalid;
  coef_tready <= coef_1_TREADY;
  i_data_tready <= axis_data_fifo_0_M_AXIS_TREADY;
  o_data_tdata(31 downto 0) <= axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0);
  o_data_tuser(127 downto 0) <= axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0);
  o_data_tvalid <= axis_subset_converter_0_M_AXIS2_TVALID;
  s_axis_adc_pdti_aclk_1 <= aclk;
  s_axis_adc_pdti_aresetn_1 <= aresetn;
bcast: component user_block2_axis_broadcaster_0_0
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(63 downto 32) => axis_broadcaster_0_M01_AXIS_TDATA(63 downto 32),
      m_axis_tdata(31 downto 0) => axis_broadcaster_0_M00_AXIS_TDATA(31 downto 0),
      m_axis_tready(1) => axis_broadcaster_0_M01_AXIS_TREADY,
      m_axis_tready(0) => axis_broadcaster_0_M00_AXIS_TREADY,
      m_axis_tuser(255 downto 128) => axis_broadcaster_0_M01_AXIS_TUSER(255 downto 128),
      m_axis_tuser(127 downto 0) => axis_broadcaster_0_M00_AXIS_TUSER(127 downto 0),
      m_axis_tvalid(1) => axis_broadcaster_0_M01_AXIS_TVALID(1),
      m_axis_tvalid(0) => axis_broadcaster_0_M00_AXIS_TVALID(0),
      s_axis_tdata(31 downto 0) => axis_data_fifo_0_M_AXIS_TDATA(31 downto 0),
      s_axis_tready => axis_data_fifo_0_M_AXIS_TREADY,
      s_axis_tuser(127 downto 0) => axis_data_fifo_0_M_AXIS_TUSER(127 downto 0),
      s_axis_tvalid => axis_data_fifo_0_M_AXIS_TVALID
    );
map_data: component user_block2_axis_subset_converter_1_0
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(31 downto 0) => axis_subset_converter_1_M_AXIS_TDATA(31 downto 0),
      m_axis_tready => axis_subset_converter_1_M_AXIS_TREADY,
      m_axis_tuser(127 downto 0) => axis_subset_converter_1_M_AXIS_TUSER(127 downto 0),
      m_axis_tvalid => axis_subset_converter_1_M_AXIS_TVALID,
      s_axis_tdata(31 downto 0) => axis_broadcaster_0_M00_AXIS_TDATA(31 downto 0),
      s_axis_tready => axis_broadcaster_0_M00_AXIS_TREADY,
      s_axis_tuser(127 downto 0) => axis_broadcaster_0_M00_AXIS_TUSER(127 downto 0),
      s_axis_tvalid => axis_broadcaster_0_M00_AXIS_TVALID(0)
    );
map_fsel: component user_block2_axis_subset_converter_0_0
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(7 downto 0) => axis_subset_converter_0_M_AXIS_TDATA(7 downto 0),
      m_axis_tready => axis_subset_converter_0_M_AXIS_TREADY,
      m_axis_tvalid => axis_subset_converter_0_M_AXIS_TVALID,
      s_axis_tdata(31 downto 0) => axis_broadcaster_0_M01_AXIS_TDATA(63 downto 32),
      s_axis_tready => axis_broadcaster_0_M01_AXIS_TREADY,
      s_axis_tuser(127 downto 0) => axis_broadcaster_0_M01_AXIS_TUSER(255 downto 128),
      s_axis_tvalid => axis_broadcaster_0_M01_AXIS_TVALID(1)
    );
pulse_fir: component user_block2_fir_compiler_0_0
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      event_s_reload_tlast_missing => NLW_pulse_fir_event_s_reload_tlast_missing_UNCONNECTED,
      event_s_reload_tlast_unexpected => NLW_pulse_fir_event_s_reload_tlast_unexpected_UNCONNECTED,
      m_axis_data_tdata(47 downto 0) => pulse_fir_0_M_AXIS_DATA_TDATA(47 downto 0),
      m_axis_data_tready => pulse_fir_0_M_AXIS_DATA_TREADY,
      m_axis_data_tuser(127 downto 0) => pulse_fir_0_M_AXIS_DATA_TUSER(127 downto 0),
      m_axis_data_tvalid => pulse_fir_0_M_AXIS_DATA_TVALID,
      s_axis_config_tdata(7 downto 0) => axis_subset_converter_0_M_AXIS_TDATA(7 downto 0),
      s_axis_config_tready => axis_subset_converter_0_M_AXIS_TREADY,
      s_axis_config_tvalid => axis_subset_converter_0_M_AXIS_TVALID,
      s_axis_data_tdata(31 downto 0) => axis_subset_converter_1_M_AXIS_TDATA(31 downto 0),
      s_axis_data_tready => axis_subset_converter_1_M_AXIS_TREADY,
      s_axis_data_tuser(127 downto 0) => axis_subset_converter_1_M_AXIS_TUSER(127 downto 0),
      s_axis_data_tvalid => axis_subset_converter_1_M_AXIS_TVALID,
      s_axis_reload_tdata(23 downto 0) => coef_1_TDATA(23 downto 0),
      s_axis_reload_tlast => '0',
      s_axis_reload_tready => coef_1_TREADY,
      s_axis_reload_tvalid => coef_1_TVALID
    );
trim_data: component user_block2_axis_subset_converter_0_5
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(31 downto 0) => axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0),
      m_axis_tready => axis_subset_converter_0_M_AXIS2_TREADY,
      m_axis_tuser(127 downto 0) => axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0),
      m_axis_tvalid => axis_subset_converter_0_M_AXIS2_TVALID,
      s_axis_tdata(47 downto 0) => pulse_fir_0_M_AXIS_DATA_TDATA(47 downto 0),
      s_axis_tready => pulse_fir_0_M_AXIS_DATA_TREADY,
      s_axis_tuser(127 downto 0) => pulse_fir_0_M_AXIS_DATA_TUSER(127 downto 0),
      s_axis_tvalid => pulse_fir_0_M_AXIS_DATA_TVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fir_imp_QGCWA6 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    coef_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_tready : out STD_LOGIC;
    coef_tvalid : in STD_LOGIC;
    i_data_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    i_data_tready : out STD_LOGIC;
    i_data_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    i_data_tvalid : in STD_LOGIC;
    o_data_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    o_data_tready : in STD_LOGIC;
    o_data_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    o_data_tvalid : out STD_LOGIC
  );
end fir_imp_QGCWA6;

architecture STRUCTURE of fir_imp_QGCWA6 is
  component user_block2_map_cfg_0_1 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component user_block2_map_cfg_0_1;
  component user_block2_axis_subset_converter_0_7 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 47 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  end component user_block2_axis_subset_converter_0_7;
  component user_block2_map_data_0_1 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  end component user_block2_map_data_0_1;
  component user_block2_pulse_fir_0_1 is
  port (
    aresetn : in STD_LOGIC;
    aclk : in STD_LOGIC;
    s_axis_data_tvalid : in STD_LOGIC;
    s_axis_data_tready : out STD_LOGIC;
    s_axis_data_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_data_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_config_tvalid : in STD_LOGIC;
    s_axis_config_tready : out STD_LOGIC;
    s_axis_config_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_reload_tvalid : in STD_LOGIC;
    s_axis_reload_tready : out STD_LOGIC;
    s_axis_reload_tlast : in STD_LOGIC;
    s_axis_reload_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_data_tvalid : out STD_LOGIC;
    m_axis_data_tready : in STD_LOGIC;
    m_axis_data_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_data_tdata : out STD_LOGIC_VECTOR ( 47 downto 0 );
    event_s_reload_tlast_missing : out STD_LOGIC;
    event_s_reload_tlast_unexpected : out STD_LOGIC
  );
  end component user_block2_pulse_fir_0_1;
  component user_block2_bcast_0_1 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 )
  );
  end component user_block2_bcast_0_1;
  signal axis_broadcaster_0_M00_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_broadcaster_0_M00_AXIS_TREADY : STD_LOGIC;
  signal axis_broadcaster_0_M00_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_broadcaster_0_M00_AXIS_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axis_broadcaster_0_M01_AXIS_TDATA : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal axis_broadcaster_0_M01_AXIS_TREADY : STD_LOGIC;
  signal axis_broadcaster_0_M01_AXIS_TUSER : STD_LOGIC_VECTOR ( 255 downto 128 );
  signal axis_broadcaster_0_M01_AXIS_TVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axis_data_fifo_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_data_fifo_0_M_AXIS_TREADY : STD_LOGIC;
  signal axis_data_fifo_0_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_data_fifo_0_M_AXIS_TVALID : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS2_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_subset_converter_0_M_AXIS2_TREADY : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS2_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_subset_converter_0_M_AXIS2_TVALID : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axis_subset_converter_0_M_AXIS_TREADY : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS_TVALID : STD_LOGIC;
  signal axis_subset_converter_1_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_subset_converter_1_M_AXIS_TREADY : STD_LOGIC;
  signal axis_subset_converter_1_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_subset_converter_1_M_AXIS_TVALID : STD_LOGIC;
  signal coef_1_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal coef_1_TREADY : STD_LOGIC;
  signal coef_1_TVALID : STD_LOGIC;
  signal pulse_fir_0_M_AXIS_DATA_TDATA : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal pulse_fir_0_M_AXIS_DATA_TREADY : STD_LOGIC;
  signal pulse_fir_0_M_AXIS_DATA_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal pulse_fir_0_M_AXIS_DATA_TVALID : STD_LOGIC;
  signal s_axis_adc_pdti_aclk_1 : STD_LOGIC;
  signal s_axis_adc_pdti_aresetn_1 : STD_LOGIC;
  signal NLW_pulse_fir_event_s_reload_tlast_missing_UNCONNECTED : STD_LOGIC;
  signal NLW_pulse_fir_event_s_reload_tlast_unexpected_UNCONNECTED : STD_LOGIC;
begin
  axis_data_fifo_0_M_AXIS_TDATA(31 downto 0) <= i_data_tdata(31 downto 0);
  axis_data_fifo_0_M_AXIS_TUSER(127 downto 0) <= i_data_tuser(127 downto 0);
  axis_data_fifo_0_M_AXIS_TVALID <= i_data_tvalid;
  axis_subset_converter_0_M_AXIS2_TREADY <= o_data_tready;
  coef_1_TDATA(23 downto 0) <= coef_tdata(23 downto 0);
  coef_1_TVALID <= coef_tvalid;
  coef_tready <= coef_1_TREADY;
  i_data_tready <= axis_data_fifo_0_M_AXIS_TREADY;
  o_data_tdata(31 downto 0) <= axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0);
  o_data_tuser(127 downto 0) <= axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0);
  o_data_tvalid <= axis_subset_converter_0_M_AXIS2_TVALID;
  s_axis_adc_pdti_aclk_1 <= aclk;
  s_axis_adc_pdti_aresetn_1 <= aresetn;
bcast: component user_block2_bcast_0_1
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(63 downto 32) => axis_broadcaster_0_M01_AXIS_TDATA(63 downto 32),
      m_axis_tdata(31 downto 0) => axis_broadcaster_0_M00_AXIS_TDATA(31 downto 0),
      m_axis_tready(1) => axis_broadcaster_0_M01_AXIS_TREADY,
      m_axis_tready(0) => axis_broadcaster_0_M00_AXIS_TREADY,
      m_axis_tuser(255 downto 128) => axis_broadcaster_0_M01_AXIS_TUSER(255 downto 128),
      m_axis_tuser(127 downto 0) => axis_broadcaster_0_M00_AXIS_TUSER(127 downto 0),
      m_axis_tvalid(1) => axis_broadcaster_0_M01_AXIS_TVALID(1),
      m_axis_tvalid(0) => axis_broadcaster_0_M00_AXIS_TVALID(0),
      s_axis_tdata(31 downto 0) => axis_data_fifo_0_M_AXIS_TDATA(31 downto 0),
      s_axis_tready => axis_data_fifo_0_M_AXIS_TREADY,
      s_axis_tuser(127 downto 0) => axis_data_fifo_0_M_AXIS_TUSER(127 downto 0),
      s_axis_tvalid => axis_data_fifo_0_M_AXIS_TVALID
    );
map_data: component user_block2_map_data_0_1
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(31 downto 0) => axis_subset_converter_1_M_AXIS_TDATA(31 downto 0),
      m_axis_tready => axis_subset_converter_1_M_AXIS_TREADY,
      m_axis_tuser(127 downto 0) => axis_subset_converter_1_M_AXIS_TUSER(127 downto 0),
      m_axis_tvalid => axis_subset_converter_1_M_AXIS_TVALID,
      s_axis_tdata(31 downto 0) => axis_broadcaster_0_M00_AXIS_TDATA(31 downto 0),
      s_axis_tready => axis_broadcaster_0_M00_AXIS_TREADY,
      s_axis_tuser(127 downto 0) => axis_broadcaster_0_M00_AXIS_TUSER(127 downto 0),
      s_axis_tvalid => axis_broadcaster_0_M00_AXIS_TVALID(0)
    );
map_fsel: component user_block2_map_cfg_0_1
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(7 downto 0) => axis_subset_converter_0_M_AXIS_TDATA(7 downto 0),
      m_axis_tready => axis_subset_converter_0_M_AXIS_TREADY,
      m_axis_tvalid => axis_subset_converter_0_M_AXIS_TVALID,
      s_axis_tdata(31 downto 0) => axis_broadcaster_0_M01_AXIS_TDATA(63 downto 32),
      s_axis_tready => axis_broadcaster_0_M01_AXIS_TREADY,
      s_axis_tuser(127 downto 0) => axis_broadcaster_0_M01_AXIS_TUSER(255 downto 128),
      s_axis_tvalid => axis_broadcaster_0_M01_AXIS_TVALID(1)
    );
pulse_fir: component user_block2_pulse_fir_0_1
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      event_s_reload_tlast_missing => NLW_pulse_fir_event_s_reload_tlast_missing_UNCONNECTED,
      event_s_reload_tlast_unexpected => NLW_pulse_fir_event_s_reload_tlast_unexpected_UNCONNECTED,
      m_axis_data_tdata(47 downto 0) => pulse_fir_0_M_AXIS_DATA_TDATA(47 downto 0),
      m_axis_data_tready => pulse_fir_0_M_AXIS_DATA_TREADY,
      m_axis_data_tuser(127 downto 0) => pulse_fir_0_M_AXIS_DATA_TUSER(127 downto 0),
      m_axis_data_tvalid => pulse_fir_0_M_AXIS_DATA_TVALID,
      s_axis_config_tdata(7 downto 0) => axis_subset_converter_0_M_AXIS_TDATA(7 downto 0),
      s_axis_config_tready => axis_subset_converter_0_M_AXIS_TREADY,
      s_axis_config_tvalid => axis_subset_converter_0_M_AXIS_TVALID,
      s_axis_data_tdata(31 downto 0) => axis_subset_converter_1_M_AXIS_TDATA(31 downto 0),
      s_axis_data_tready => axis_subset_converter_1_M_AXIS_TREADY,
      s_axis_data_tuser(127 downto 0) => axis_subset_converter_1_M_AXIS_TUSER(127 downto 0),
      s_axis_data_tvalid => axis_subset_converter_1_M_AXIS_TVALID,
      s_axis_reload_tdata(23 downto 0) => coef_1_TDATA(23 downto 0),
      s_axis_reload_tlast => '0',
      s_axis_reload_tready => coef_1_TREADY,
      s_axis_reload_tvalid => coef_1_TVALID
    );
trim_data: component user_block2_axis_subset_converter_0_7
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(31 downto 0) => axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0),
      m_axis_tready => axis_subset_converter_0_M_AXIS2_TREADY,
      m_axis_tuser(127 downto 0) => axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0),
      m_axis_tvalid => axis_subset_converter_0_M_AXIS2_TVALID,
      s_axis_tdata(47 downto 0) => pulse_fir_0_M_AXIS_DATA_TDATA(47 downto 0),
      s_axis_tready => pulse_fir_0_M_AXIS_DATA_TREADY,
      s_axis_tuser(127 downto 0) => pulse_fir_0_M_AXIS_DATA_TUSER(127 downto 0),
      s_axis_tvalid => pulse_fir_0_M_AXIS_DATA_TVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fir_imp_WWVVRW is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    coef_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_tready : out STD_LOGIC;
    coef_tvalid : in STD_LOGIC;
    i_data_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    i_data_tready : out STD_LOGIC;
    i_data_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    i_data_tvalid : in STD_LOGIC;
    o_data_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    o_data_tready : in STD_LOGIC;
    o_data_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    o_data_tvalid : out STD_LOGIC
  );
end fir_imp_WWVVRW;

architecture STRUCTURE of fir_imp_WWVVRW is
  component user_block2_map_cfg_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component user_block2_map_cfg_0_0;
  component user_block2_map_data_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  end component user_block2_map_data_0_0;
  component user_block2_pulse_fir_0_0 is
  port (
    aresetn : in STD_LOGIC;
    aclk : in STD_LOGIC;
    s_axis_data_tvalid : in STD_LOGIC;
    s_axis_data_tready : out STD_LOGIC;
    s_axis_data_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_data_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_config_tvalid : in STD_LOGIC;
    s_axis_config_tready : out STD_LOGIC;
    s_axis_config_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_reload_tvalid : in STD_LOGIC;
    s_axis_reload_tready : out STD_LOGIC;
    s_axis_reload_tlast : in STD_LOGIC;
    s_axis_reload_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    m_axis_data_tvalid : out STD_LOGIC;
    m_axis_data_tready : in STD_LOGIC;
    m_axis_data_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_data_tdata : out STD_LOGIC_VECTOR ( 47 downto 0 );
    event_s_reload_tlast_missing : out STD_LOGIC;
    event_s_reload_tlast_unexpected : out STD_LOGIC
  );
  end component user_block2_pulse_fir_0_0;
  component user_block2_bcast_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 )
  );
  end component user_block2_bcast_0_0;
  component user_block2_axis_subset_converter_0_6 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 47 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  end component user_block2_axis_subset_converter_0_6;
  signal axis_broadcaster_0_M00_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_broadcaster_0_M00_AXIS_TREADY : STD_LOGIC;
  signal axis_broadcaster_0_M00_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_broadcaster_0_M00_AXIS_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axis_broadcaster_0_M01_AXIS_TDATA : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal axis_broadcaster_0_M01_AXIS_TREADY : STD_LOGIC;
  signal axis_broadcaster_0_M01_AXIS_TUSER : STD_LOGIC_VECTOR ( 255 downto 128 );
  signal axis_broadcaster_0_M01_AXIS_TVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axis_data_fifo_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_data_fifo_0_M_AXIS_TREADY : STD_LOGIC;
  signal axis_data_fifo_0_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_data_fifo_0_M_AXIS_TVALID : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS2_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_subset_converter_0_M_AXIS2_TREADY : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS2_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_subset_converter_0_M_AXIS2_TVALID : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axis_subset_converter_0_M_AXIS_TREADY : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS_TVALID : STD_LOGIC;
  signal axis_subset_converter_1_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_subset_converter_1_M_AXIS_TREADY : STD_LOGIC;
  signal axis_subset_converter_1_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_subset_converter_1_M_AXIS_TVALID : STD_LOGIC;
  signal coef_1_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal coef_1_TREADY : STD_LOGIC;
  signal coef_1_TVALID : STD_LOGIC;
  signal pulse_fir_0_M_AXIS_DATA_TDATA : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal pulse_fir_0_M_AXIS_DATA_TREADY : STD_LOGIC;
  signal pulse_fir_0_M_AXIS_DATA_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal pulse_fir_0_M_AXIS_DATA_TVALID : STD_LOGIC;
  signal s_axis_adc_pdti_aclk_1 : STD_LOGIC;
  signal s_axis_adc_pdti_aresetn_1 : STD_LOGIC;
  signal NLW_pulse_fir_event_s_reload_tlast_missing_UNCONNECTED : STD_LOGIC;
  signal NLW_pulse_fir_event_s_reload_tlast_unexpected_UNCONNECTED : STD_LOGIC;
begin
  axis_data_fifo_0_M_AXIS_TDATA(31 downto 0) <= i_data_tdata(31 downto 0);
  axis_data_fifo_0_M_AXIS_TUSER(127 downto 0) <= i_data_tuser(127 downto 0);
  axis_data_fifo_0_M_AXIS_TVALID <= i_data_tvalid;
  axis_subset_converter_0_M_AXIS2_TREADY <= o_data_tready;
  coef_1_TDATA(23 downto 0) <= coef_tdata(23 downto 0);
  coef_1_TVALID <= coef_tvalid;
  coef_tready <= coef_1_TREADY;
  i_data_tready <= axis_data_fifo_0_M_AXIS_TREADY;
  o_data_tdata(31 downto 0) <= axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0);
  o_data_tuser(127 downto 0) <= axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0);
  o_data_tvalid <= axis_subset_converter_0_M_AXIS2_TVALID;
  s_axis_adc_pdti_aclk_1 <= aclk;
  s_axis_adc_pdti_aresetn_1 <= aresetn;
bcast: component user_block2_bcast_0_0
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(63 downto 32) => axis_broadcaster_0_M01_AXIS_TDATA(63 downto 32),
      m_axis_tdata(31 downto 0) => axis_broadcaster_0_M00_AXIS_TDATA(31 downto 0),
      m_axis_tready(1) => axis_broadcaster_0_M01_AXIS_TREADY,
      m_axis_tready(0) => axis_broadcaster_0_M00_AXIS_TREADY,
      m_axis_tuser(255 downto 128) => axis_broadcaster_0_M01_AXIS_TUSER(255 downto 128),
      m_axis_tuser(127 downto 0) => axis_broadcaster_0_M00_AXIS_TUSER(127 downto 0),
      m_axis_tvalid(1) => axis_broadcaster_0_M01_AXIS_TVALID(1),
      m_axis_tvalid(0) => axis_broadcaster_0_M00_AXIS_TVALID(0),
      s_axis_tdata(31 downto 0) => axis_data_fifo_0_M_AXIS_TDATA(31 downto 0),
      s_axis_tready => axis_data_fifo_0_M_AXIS_TREADY,
      s_axis_tuser(127 downto 0) => axis_data_fifo_0_M_AXIS_TUSER(127 downto 0),
      s_axis_tvalid => axis_data_fifo_0_M_AXIS_TVALID
    );
map_data: component user_block2_map_data_0_0
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(31 downto 0) => axis_subset_converter_1_M_AXIS_TDATA(31 downto 0),
      m_axis_tready => axis_subset_converter_1_M_AXIS_TREADY,
      m_axis_tuser(127 downto 0) => axis_subset_converter_1_M_AXIS_TUSER(127 downto 0),
      m_axis_tvalid => axis_subset_converter_1_M_AXIS_TVALID,
      s_axis_tdata(31 downto 0) => axis_broadcaster_0_M00_AXIS_TDATA(31 downto 0),
      s_axis_tready => axis_broadcaster_0_M00_AXIS_TREADY,
      s_axis_tuser(127 downto 0) => axis_broadcaster_0_M00_AXIS_TUSER(127 downto 0),
      s_axis_tvalid => axis_broadcaster_0_M00_AXIS_TVALID(0)
    );
map_fsel: component user_block2_map_cfg_0_0
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(7 downto 0) => axis_subset_converter_0_M_AXIS_TDATA(7 downto 0),
      m_axis_tready => axis_subset_converter_0_M_AXIS_TREADY,
      m_axis_tvalid => axis_subset_converter_0_M_AXIS_TVALID,
      s_axis_tdata(31 downto 0) => axis_broadcaster_0_M01_AXIS_TDATA(63 downto 32),
      s_axis_tready => axis_broadcaster_0_M01_AXIS_TREADY,
      s_axis_tuser(127 downto 0) => axis_broadcaster_0_M01_AXIS_TUSER(255 downto 128),
      s_axis_tvalid => axis_broadcaster_0_M01_AXIS_TVALID(1)
    );
pulse_fir: component user_block2_pulse_fir_0_0
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      event_s_reload_tlast_missing => NLW_pulse_fir_event_s_reload_tlast_missing_UNCONNECTED,
      event_s_reload_tlast_unexpected => NLW_pulse_fir_event_s_reload_tlast_unexpected_UNCONNECTED,
      m_axis_data_tdata(47 downto 0) => pulse_fir_0_M_AXIS_DATA_TDATA(47 downto 0),
      m_axis_data_tready => pulse_fir_0_M_AXIS_DATA_TREADY,
      m_axis_data_tuser(127 downto 0) => pulse_fir_0_M_AXIS_DATA_TUSER(127 downto 0),
      m_axis_data_tvalid => pulse_fir_0_M_AXIS_DATA_TVALID,
      s_axis_config_tdata(7 downto 0) => axis_subset_converter_0_M_AXIS_TDATA(7 downto 0),
      s_axis_config_tready => axis_subset_converter_0_M_AXIS_TREADY,
      s_axis_config_tvalid => axis_subset_converter_0_M_AXIS_TVALID,
      s_axis_data_tdata(31 downto 0) => axis_subset_converter_1_M_AXIS_TDATA(31 downto 0),
      s_axis_data_tready => axis_subset_converter_1_M_AXIS_TREADY,
      s_axis_data_tuser(127 downto 0) => axis_subset_converter_1_M_AXIS_TUSER(127 downto 0),
      s_axis_data_tvalid => axis_subset_converter_1_M_AXIS_TVALID,
      s_axis_reload_tdata(23 downto 0) => coef_1_TDATA(23 downto 0),
      s_axis_reload_tlast => '0',
      s_axis_reload_tready => coef_1_TREADY,
      s_axis_reload_tvalid => coef_1_TVALID
    );
trim_data: component user_block2_axis_subset_converter_0_6
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(31 downto 0) => axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0),
      m_axis_tready => axis_subset_converter_0_M_AXIS2_TREADY,
      m_axis_tuser(127 downto 0) => axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0),
      m_axis_tvalid => axis_subset_converter_0_M_AXIS2_TVALID,
      s_axis_tdata(47 downto 0) => pulse_fir_0_M_AXIS_DATA_TDATA(47 downto 0),
      s_axis_tready => pulse_fir_0_M_AXIS_DATA_TREADY,
      s_axis_tuser(127 downto 0) => pulse_fir_0_M_AXIS_DATA_TUSER(127 downto 0),
      s_axis_tvalid => pulse_fir_0_M_AXIS_DATA_TVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m00_couplers_imp_19I9FMC is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 6 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 6 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m00_couplers_imp_19I9FMC;

architecture STRUCTURE of m00_couplers_imp_19I9FMC is
  component user_block2_auto_cc_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_aclk : in STD_LOGIC;
    m_axi_aresetn : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 6 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 6 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component user_block2_auto_cc_0;
  signal M_ACLK_1 : STD_LOGIC;
  signal M_ARESETN_1 : STD_LOGIC;
  signal S_ACLK_1 : STD_LOGIC;
  signal S_ARESETN_1 : STD_LOGIC;
  signal auto_cc_to_m00_couplers_ARADDR : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal auto_cc_to_m00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_cc_to_m00_couplers_ARREADY : STD_LOGIC;
  signal auto_cc_to_m00_couplers_ARVALID : STD_LOGIC;
  signal auto_cc_to_m00_couplers_AWADDR : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal auto_cc_to_m00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_cc_to_m00_couplers_AWREADY : STD_LOGIC;
  signal auto_cc_to_m00_couplers_AWVALID : STD_LOGIC;
  signal auto_cc_to_m00_couplers_BREADY : STD_LOGIC;
  signal auto_cc_to_m00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_cc_to_m00_couplers_BVALID : STD_LOGIC;
  signal auto_cc_to_m00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_cc_to_m00_couplers_RREADY : STD_LOGIC;
  signal auto_cc_to_m00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_cc_to_m00_couplers_RVALID : STD_LOGIC;
  signal auto_cc_to_m00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_cc_to_m00_couplers_WREADY : STD_LOGIC;
  signal auto_cc_to_m00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_cc_to_m00_couplers_WVALID : STD_LOGIC;
  signal m00_couplers_to_auto_cc_ARADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal m00_couplers_to_auto_cc_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_auto_cc_ARREADY : STD_LOGIC;
  signal m00_couplers_to_auto_cc_ARVALID : STD_LOGIC;
  signal m00_couplers_to_auto_cc_AWADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal m00_couplers_to_auto_cc_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_auto_cc_AWREADY : STD_LOGIC;
  signal m00_couplers_to_auto_cc_AWVALID : STD_LOGIC;
  signal m00_couplers_to_auto_cc_BREADY : STD_LOGIC;
  signal m00_couplers_to_auto_cc_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_auto_cc_BVALID : STD_LOGIC;
  signal m00_couplers_to_auto_cc_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_auto_cc_RREADY : STD_LOGIC;
  signal m00_couplers_to_auto_cc_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_auto_cc_RVALID : STD_LOGIC;
  signal m00_couplers_to_auto_cc_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_auto_cc_WREADY : STD_LOGIC;
  signal m00_couplers_to_auto_cc_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_auto_cc_WVALID : STD_LOGIC;
begin
  M_ACLK_1 <= M_ACLK;
  M_ARESETN_1 <= M_ARESETN;
  M_AXI_araddr(6 downto 0) <= auto_cc_to_m00_couplers_ARADDR(6 downto 0);
  M_AXI_arprot(2 downto 0) <= auto_cc_to_m00_couplers_ARPROT(2 downto 0);
  M_AXI_arvalid <= auto_cc_to_m00_couplers_ARVALID;
  M_AXI_awaddr(6 downto 0) <= auto_cc_to_m00_couplers_AWADDR(6 downto 0);
  M_AXI_awprot(2 downto 0) <= auto_cc_to_m00_couplers_AWPROT(2 downto 0);
  M_AXI_awvalid <= auto_cc_to_m00_couplers_AWVALID;
  M_AXI_bready <= auto_cc_to_m00_couplers_BREADY;
  M_AXI_rready <= auto_cc_to_m00_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= auto_cc_to_m00_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= auto_cc_to_m00_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= auto_cc_to_m00_couplers_WVALID;
  S_ACLK_1 <= S_ACLK;
  S_ARESETN_1 <= S_ARESETN;
  S_AXI_arready <= m00_couplers_to_auto_cc_ARREADY;
  S_AXI_awready <= m00_couplers_to_auto_cc_AWREADY;
  S_AXI_bresp(1 downto 0) <= m00_couplers_to_auto_cc_BRESP(1 downto 0);
  S_AXI_bvalid <= m00_couplers_to_auto_cc_BVALID;
  S_AXI_rdata(31 downto 0) <= m00_couplers_to_auto_cc_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m00_couplers_to_auto_cc_RRESP(1 downto 0);
  S_AXI_rvalid <= m00_couplers_to_auto_cc_RVALID;
  S_AXI_wready <= m00_couplers_to_auto_cc_WREADY;
  auto_cc_to_m00_couplers_ARREADY <= M_AXI_arready;
  auto_cc_to_m00_couplers_AWREADY <= M_AXI_awready;
  auto_cc_to_m00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  auto_cc_to_m00_couplers_BVALID <= M_AXI_bvalid;
  auto_cc_to_m00_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  auto_cc_to_m00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  auto_cc_to_m00_couplers_RVALID <= M_AXI_rvalid;
  auto_cc_to_m00_couplers_WREADY <= M_AXI_wready;
  m00_couplers_to_auto_cc_ARADDR(25 downto 0) <= S_AXI_araddr(25 downto 0);
  m00_couplers_to_auto_cc_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  m00_couplers_to_auto_cc_ARVALID <= S_AXI_arvalid;
  m00_couplers_to_auto_cc_AWADDR(25 downto 0) <= S_AXI_awaddr(25 downto 0);
  m00_couplers_to_auto_cc_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  m00_couplers_to_auto_cc_AWVALID <= S_AXI_awvalid;
  m00_couplers_to_auto_cc_BREADY <= S_AXI_bready;
  m00_couplers_to_auto_cc_RREADY <= S_AXI_rready;
  m00_couplers_to_auto_cc_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m00_couplers_to_auto_cc_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m00_couplers_to_auto_cc_WVALID <= S_AXI_wvalid;
auto_cc: component user_block2_auto_cc_0
     port map (
      m_axi_aclk => M_ACLK_1,
      m_axi_araddr(6 downto 0) => auto_cc_to_m00_couplers_ARADDR(6 downto 0),
      m_axi_aresetn => M_ARESETN_1,
      m_axi_arprot(2 downto 0) => auto_cc_to_m00_couplers_ARPROT(2 downto 0),
      m_axi_arready => auto_cc_to_m00_couplers_ARREADY,
      m_axi_arvalid => auto_cc_to_m00_couplers_ARVALID,
      m_axi_awaddr(6 downto 0) => auto_cc_to_m00_couplers_AWADDR(6 downto 0),
      m_axi_awprot(2 downto 0) => auto_cc_to_m00_couplers_AWPROT(2 downto 0),
      m_axi_awready => auto_cc_to_m00_couplers_AWREADY,
      m_axi_awvalid => auto_cc_to_m00_couplers_AWVALID,
      m_axi_bready => auto_cc_to_m00_couplers_BREADY,
      m_axi_bresp(1 downto 0) => auto_cc_to_m00_couplers_BRESP(1 downto 0),
      m_axi_bvalid => auto_cc_to_m00_couplers_BVALID,
      m_axi_rdata(31 downto 0) => auto_cc_to_m00_couplers_RDATA(31 downto 0),
      m_axi_rready => auto_cc_to_m00_couplers_RREADY,
      m_axi_rresp(1 downto 0) => auto_cc_to_m00_couplers_RRESP(1 downto 0),
      m_axi_rvalid => auto_cc_to_m00_couplers_RVALID,
      m_axi_wdata(31 downto 0) => auto_cc_to_m00_couplers_WDATA(31 downto 0),
      m_axi_wready => auto_cc_to_m00_couplers_WREADY,
      m_axi_wstrb(3 downto 0) => auto_cc_to_m00_couplers_WSTRB(3 downto 0),
      m_axi_wvalid => auto_cc_to_m00_couplers_WVALID,
      s_axi_aclk => S_ACLK_1,
      s_axi_araddr(6 downto 0) => m00_couplers_to_auto_cc_ARADDR(6 downto 0),
      s_axi_aresetn => S_ARESETN_1,
      s_axi_arprot(2 downto 0) => m00_couplers_to_auto_cc_ARPROT(2 downto 0),
      s_axi_arready => m00_couplers_to_auto_cc_ARREADY,
      s_axi_arvalid => m00_couplers_to_auto_cc_ARVALID,
      s_axi_awaddr(6 downto 0) => m00_couplers_to_auto_cc_AWADDR(6 downto 0),
      s_axi_awprot(2 downto 0) => m00_couplers_to_auto_cc_AWPROT(2 downto 0),
      s_axi_awready => m00_couplers_to_auto_cc_AWREADY,
      s_axi_awvalid => m00_couplers_to_auto_cc_AWVALID,
      s_axi_bready => m00_couplers_to_auto_cc_BREADY,
      s_axi_bresp(1 downto 0) => m00_couplers_to_auto_cc_BRESP(1 downto 0),
      s_axi_bvalid => m00_couplers_to_auto_cc_BVALID,
      s_axi_rdata(31 downto 0) => m00_couplers_to_auto_cc_RDATA(31 downto 0),
      s_axi_rready => m00_couplers_to_auto_cc_RREADY,
      s_axi_rresp(1 downto 0) => m00_couplers_to_auto_cc_RRESP(1 downto 0),
      s_axi_rvalid => m00_couplers_to_auto_cc_RVALID,
      s_axi_wdata(31 downto 0) => m00_couplers_to_auto_cc_WDATA(31 downto 0),
      s_axi_wready => m00_couplers_to_auto_cc_WREADY,
      s_axi_wstrb(3 downto 0) => m00_couplers_to_auto_cc_WSTRB(3 downto 0),
      s_axi_wvalid => m00_couplers_to_auto_cc_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m01_couplers_imp_GLRYYY is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m01_couplers_imp_GLRYYY;

architecture STRUCTURE of m01_couplers_imp_GLRYYY is
  component user_block2_auto_cc_1 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_aclk : in STD_LOGIC;
    m_axi_aresetn : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component user_block2_auto_cc_1;
  signal M_ACLK_1 : STD_LOGIC;
  signal M_ARESETN_1 : STD_LOGIC;
  signal S_ACLK_1 : STD_LOGIC;
  signal S_ARESETN_1 : STD_LOGIC;
  signal auto_cc_to_m01_couplers_ARADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal auto_cc_to_m01_couplers_ARREADY : STD_LOGIC;
  signal auto_cc_to_m01_couplers_ARVALID : STD_LOGIC;
  signal auto_cc_to_m01_couplers_AWADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal auto_cc_to_m01_couplers_AWREADY : STD_LOGIC;
  signal auto_cc_to_m01_couplers_AWVALID : STD_LOGIC;
  signal auto_cc_to_m01_couplers_BREADY : STD_LOGIC;
  signal auto_cc_to_m01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_cc_to_m01_couplers_BVALID : STD_LOGIC;
  signal auto_cc_to_m01_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_cc_to_m01_couplers_RREADY : STD_LOGIC;
  signal auto_cc_to_m01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_cc_to_m01_couplers_RVALID : STD_LOGIC;
  signal auto_cc_to_m01_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_cc_to_m01_couplers_WREADY : STD_LOGIC;
  signal auto_cc_to_m01_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_cc_to_m01_couplers_WVALID : STD_LOGIC;
  signal m01_couplers_to_auto_cc_ARADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal m01_couplers_to_auto_cc_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m01_couplers_to_auto_cc_ARREADY : STD_LOGIC;
  signal m01_couplers_to_auto_cc_ARVALID : STD_LOGIC;
  signal m01_couplers_to_auto_cc_AWADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal m01_couplers_to_auto_cc_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m01_couplers_to_auto_cc_AWREADY : STD_LOGIC;
  signal m01_couplers_to_auto_cc_AWVALID : STD_LOGIC;
  signal m01_couplers_to_auto_cc_BREADY : STD_LOGIC;
  signal m01_couplers_to_auto_cc_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_auto_cc_BVALID : STD_LOGIC;
  signal m01_couplers_to_auto_cc_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_auto_cc_RREADY : STD_LOGIC;
  signal m01_couplers_to_auto_cc_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_auto_cc_RVALID : STD_LOGIC;
  signal m01_couplers_to_auto_cc_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_auto_cc_WREADY : STD_LOGIC;
  signal m01_couplers_to_auto_cc_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m01_couplers_to_auto_cc_WVALID : STD_LOGIC;
  signal NLW_auto_cc_m_axi_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_auto_cc_m_axi_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
begin
  M_ACLK_1 <= M_ACLK;
  M_ARESETN_1 <= M_ARESETN;
  M_AXI_araddr(12 downto 0) <= auto_cc_to_m01_couplers_ARADDR(12 downto 0);
  M_AXI_arvalid <= auto_cc_to_m01_couplers_ARVALID;
  M_AXI_awaddr(12 downto 0) <= auto_cc_to_m01_couplers_AWADDR(12 downto 0);
  M_AXI_awvalid <= auto_cc_to_m01_couplers_AWVALID;
  M_AXI_bready <= auto_cc_to_m01_couplers_BREADY;
  M_AXI_rready <= auto_cc_to_m01_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= auto_cc_to_m01_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= auto_cc_to_m01_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= auto_cc_to_m01_couplers_WVALID;
  S_ACLK_1 <= S_ACLK;
  S_ARESETN_1 <= S_ARESETN;
  S_AXI_arready <= m01_couplers_to_auto_cc_ARREADY;
  S_AXI_awready <= m01_couplers_to_auto_cc_AWREADY;
  S_AXI_bresp(1 downto 0) <= m01_couplers_to_auto_cc_BRESP(1 downto 0);
  S_AXI_bvalid <= m01_couplers_to_auto_cc_BVALID;
  S_AXI_rdata(31 downto 0) <= m01_couplers_to_auto_cc_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m01_couplers_to_auto_cc_RRESP(1 downto 0);
  S_AXI_rvalid <= m01_couplers_to_auto_cc_RVALID;
  S_AXI_wready <= m01_couplers_to_auto_cc_WREADY;
  auto_cc_to_m01_couplers_ARREADY <= M_AXI_arready;
  auto_cc_to_m01_couplers_AWREADY <= M_AXI_awready;
  auto_cc_to_m01_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  auto_cc_to_m01_couplers_BVALID <= M_AXI_bvalid;
  auto_cc_to_m01_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  auto_cc_to_m01_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  auto_cc_to_m01_couplers_RVALID <= M_AXI_rvalid;
  auto_cc_to_m01_couplers_WREADY <= M_AXI_wready;
  m01_couplers_to_auto_cc_ARADDR(25 downto 0) <= S_AXI_araddr(25 downto 0);
  m01_couplers_to_auto_cc_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  m01_couplers_to_auto_cc_ARVALID <= S_AXI_arvalid;
  m01_couplers_to_auto_cc_AWADDR(25 downto 0) <= S_AXI_awaddr(25 downto 0);
  m01_couplers_to_auto_cc_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  m01_couplers_to_auto_cc_AWVALID <= S_AXI_awvalid;
  m01_couplers_to_auto_cc_BREADY <= S_AXI_bready;
  m01_couplers_to_auto_cc_RREADY <= S_AXI_rready;
  m01_couplers_to_auto_cc_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m01_couplers_to_auto_cc_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m01_couplers_to_auto_cc_WVALID <= S_AXI_wvalid;
auto_cc: component user_block2_auto_cc_1
     port map (
      m_axi_aclk => M_ACLK_1,
      m_axi_araddr(12 downto 0) => auto_cc_to_m01_couplers_ARADDR(12 downto 0),
      m_axi_aresetn => M_ARESETN_1,
      m_axi_arprot(2 downto 0) => NLW_auto_cc_m_axi_arprot_UNCONNECTED(2 downto 0),
      m_axi_arready => auto_cc_to_m01_couplers_ARREADY,
      m_axi_arvalid => auto_cc_to_m01_couplers_ARVALID,
      m_axi_awaddr(12 downto 0) => auto_cc_to_m01_couplers_AWADDR(12 downto 0),
      m_axi_awprot(2 downto 0) => NLW_auto_cc_m_axi_awprot_UNCONNECTED(2 downto 0),
      m_axi_awready => auto_cc_to_m01_couplers_AWREADY,
      m_axi_awvalid => auto_cc_to_m01_couplers_AWVALID,
      m_axi_bready => auto_cc_to_m01_couplers_BREADY,
      m_axi_bresp(1 downto 0) => auto_cc_to_m01_couplers_BRESP(1 downto 0),
      m_axi_bvalid => auto_cc_to_m01_couplers_BVALID,
      m_axi_rdata(31 downto 0) => auto_cc_to_m01_couplers_RDATA(31 downto 0),
      m_axi_rready => auto_cc_to_m01_couplers_RREADY,
      m_axi_rresp(1 downto 0) => auto_cc_to_m01_couplers_RRESP(1 downto 0),
      m_axi_rvalid => auto_cc_to_m01_couplers_RVALID,
      m_axi_wdata(31 downto 0) => auto_cc_to_m01_couplers_WDATA(31 downto 0),
      m_axi_wready => auto_cc_to_m01_couplers_WREADY,
      m_axi_wstrb(3 downto 0) => auto_cc_to_m01_couplers_WSTRB(3 downto 0),
      m_axi_wvalid => auto_cc_to_m01_couplers_WVALID,
      s_axi_aclk => S_ACLK_1,
      s_axi_araddr(12 downto 0) => m01_couplers_to_auto_cc_ARADDR(12 downto 0),
      s_axi_aresetn => S_ARESETN_1,
      s_axi_arprot(2 downto 0) => m01_couplers_to_auto_cc_ARPROT(2 downto 0),
      s_axi_arready => m01_couplers_to_auto_cc_ARREADY,
      s_axi_arvalid => m01_couplers_to_auto_cc_ARVALID,
      s_axi_awaddr(12 downto 0) => m01_couplers_to_auto_cc_AWADDR(12 downto 0),
      s_axi_awprot(2 downto 0) => m01_couplers_to_auto_cc_AWPROT(2 downto 0),
      s_axi_awready => m01_couplers_to_auto_cc_AWREADY,
      s_axi_awvalid => m01_couplers_to_auto_cc_AWVALID,
      s_axi_bready => m01_couplers_to_auto_cc_BREADY,
      s_axi_bresp(1 downto 0) => m01_couplers_to_auto_cc_BRESP(1 downto 0),
      s_axi_bvalid => m01_couplers_to_auto_cc_BVALID,
      s_axi_rdata(31 downto 0) => m01_couplers_to_auto_cc_RDATA(31 downto 0),
      s_axi_rready => m01_couplers_to_auto_cc_RREADY,
      s_axi_rresp(1 downto 0) => m01_couplers_to_auto_cc_RRESP(1 downto 0),
      s_axi_rvalid => m01_couplers_to_auto_cc_RVALID,
      s_axi_wdata(31 downto 0) => m01_couplers_to_auto_cc_WDATA(31 downto 0),
      s_axi_wready => m01_couplers_to_auto_cc_WREADY,
      s_axi_wstrb(3 downto 0) => m01_couplers_to_auto_cc_WSTRB(3 downto 0),
      s_axi_wvalid => m01_couplers_to_auto_cc_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity s00_couplers_imp_JZBK90 is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end s00_couplers_imp_JZBK90;

architecture STRUCTURE of s00_couplers_imp_JZBK90 is
  component user_block2_s00_regslice_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component user_block2_s00_regslice_0;
  signal S_ACLK_1 : STD_LOGIC;
  signal S_ARESETN_1 : STD_LOGIC;
  signal s00_couplers_to_s00_regslice_ARADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal s00_couplers_to_s00_regslice_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_regslice_ARREADY : STD_LOGIC;
  signal s00_couplers_to_s00_regslice_ARVALID : STD_LOGIC;
  signal s00_couplers_to_s00_regslice_AWADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal s00_couplers_to_s00_regslice_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_regslice_AWREADY : STD_LOGIC;
  signal s00_couplers_to_s00_regslice_AWVALID : STD_LOGIC;
  signal s00_couplers_to_s00_regslice_BREADY : STD_LOGIC;
  signal s00_couplers_to_s00_regslice_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_regslice_BVALID : STD_LOGIC;
  signal s00_couplers_to_s00_regslice_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_regslice_RREADY : STD_LOGIC;
  signal s00_couplers_to_s00_regslice_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_regslice_RVALID : STD_LOGIC;
  signal s00_couplers_to_s00_regslice_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_regslice_WREADY : STD_LOGIC;
  signal s00_couplers_to_s00_regslice_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_regslice_WVALID : STD_LOGIC;
  signal s00_regslice_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal s00_regslice_to_s00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_regslice_to_s00_couplers_ARREADY : STD_LOGIC;
  signal s00_regslice_to_s00_couplers_ARVALID : STD_LOGIC;
  signal s00_regslice_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal s00_regslice_to_s00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_regslice_to_s00_couplers_AWREADY : STD_LOGIC;
  signal s00_regslice_to_s00_couplers_AWVALID : STD_LOGIC;
  signal s00_regslice_to_s00_couplers_BREADY : STD_LOGIC;
  signal s00_regslice_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_regslice_to_s00_couplers_BVALID : STD_LOGIC;
  signal s00_regslice_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_regslice_to_s00_couplers_RREADY : STD_LOGIC;
  signal s00_regslice_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_regslice_to_s00_couplers_RVALID : STD_LOGIC;
  signal s00_regslice_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_regslice_to_s00_couplers_WREADY : STD_LOGIC;
  signal s00_regslice_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_regslice_to_s00_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(25 downto 0) <= s00_regslice_to_s00_couplers_ARADDR(25 downto 0);
  M_AXI_arprot(2 downto 0) <= s00_regslice_to_s00_couplers_ARPROT(2 downto 0);
  M_AXI_arvalid <= s00_regslice_to_s00_couplers_ARVALID;
  M_AXI_awaddr(25 downto 0) <= s00_regslice_to_s00_couplers_AWADDR(25 downto 0);
  M_AXI_awprot(2 downto 0) <= s00_regslice_to_s00_couplers_AWPROT(2 downto 0);
  M_AXI_awvalid <= s00_regslice_to_s00_couplers_AWVALID;
  M_AXI_bready <= s00_regslice_to_s00_couplers_BREADY;
  M_AXI_rready <= s00_regslice_to_s00_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= s00_regslice_to_s00_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= s00_regslice_to_s00_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= s00_regslice_to_s00_couplers_WVALID;
  S_ACLK_1 <= S_ACLK;
  S_ARESETN_1 <= S_ARESETN;
  S_AXI_arready <= s00_couplers_to_s00_regslice_ARREADY;
  S_AXI_awready <= s00_couplers_to_s00_regslice_AWREADY;
  S_AXI_bresp(1 downto 0) <= s00_couplers_to_s00_regslice_BRESP(1 downto 0);
  S_AXI_bvalid <= s00_couplers_to_s00_regslice_BVALID;
  S_AXI_rdata(31 downto 0) <= s00_couplers_to_s00_regslice_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= s00_couplers_to_s00_regslice_RRESP(1 downto 0);
  S_AXI_rvalid <= s00_couplers_to_s00_regslice_RVALID;
  S_AXI_wready <= s00_couplers_to_s00_regslice_WREADY;
  s00_couplers_to_s00_regslice_ARADDR(25 downto 0) <= S_AXI_araddr(25 downto 0);
  s00_couplers_to_s00_regslice_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  s00_couplers_to_s00_regslice_ARVALID <= S_AXI_arvalid;
  s00_couplers_to_s00_regslice_AWADDR(25 downto 0) <= S_AXI_awaddr(25 downto 0);
  s00_couplers_to_s00_regslice_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  s00_couplers_to_s00_regslice_AWVALID <= S_AXI_awvalid;
  s00_couplers_to_s00_regslice_BREADY <= S_AXI_bready;
  s00_couplers_to_s00_regslice_RREADY <= S_AXI_rready;
  s00_couplers_to_s00_regslice_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  s00_couplers_to_s00_regslice_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  s00_couplers_to_s00_regslice_WVALID <= S_AXI_wvalid;
  s00_regslice_to_s00_couplers_ARREADY <= M_AXI_arready;
  s00_regslice_to_s00_couplers_AWREADY <= M_AXI_awready;
  s00_regslice_to_s00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  s00_regslice_to_s00_couplers_BVALID <= M_AXI_bvalid;
  s00_regslice_to_s00_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  s00_regslice_to_s00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  s00_regslice_to_s00_couplers_RVALID <= M_AXI_rvalid;
  s00_regslice_to_s00_couplers_WREADY <= M_AXI_wready;
s00_regslice: component user_block2_s00_regslice_0
     port map (
      aclk => S_ACLK_1,
      aresetn => S_ARESETN_1,
      m_axi_araddr(25 downto 0) => s00_regslice_to_s00_couplers_ARADDR(25 downto 0),
      m_axi_arprot(2 downto 0) => s00_regslice_to_s00_couplers_ARPROT(2 downto 0),
      m_axi_arready => s00_regslice_to_s00_couplers_ARREADY,
      m_axi_arvalid => s00_regslice_to_s00_couplers_ARVALID,
      m_axi_awaddr(25 downto 0) => s00_regslice_to_s00_couplers_AWADDR(25 downto 0),
      m_axi_awprot(2 downto 0) => s00_regslice_to_s00_couplers_AWPROT(2 downto 0),
      m_axi_awready => s00_regslice_to_s00_couplers_AWREADY,
      m_axi_awvalid => s00_regslice_to_s00_couplers_AWVALID,
      m_axi_bready => s00_regslice_to_s00_couplers_BREADY,
      m_axi_bresp(1 downto 0) => s00_regslice_to_s00_couplers_BRESP(1 downto 0),
      m_axi_bvalid => s00_regslice_to_s00_couplers_BVALID,
      m_axi_rdata(31 downto 0) => s00_regslice_to_s00_couplers_RDATA(31 downto 0),
      m_axi_rready => s00_regslice_to_s00_couplers_RREADY,
      m_axi_rresp(1 downto 0) => s00_regslice_to_s00_couplers_RRESP(1 downto 0),
      m_axi_rvalid => s00_regslice_to_s00_couplers_RVALID,
      m_axi_wdata(31 downto 0) => s00_regslice_to_s00_couplers_WDATA(31 downto 0),
      m_axi_wready => s00_regslice_to_s00_couplers_WREADY,
      m_axi_wstrb(3 downto 0) => s00_regslice_to_s00_couplers_WSTRB(3 downto 0),
      m_axi_wvalid => s00_regslice_to_s00_couplers_WVALID,
      s_axi_araddr(25 downto 0) => s00_couplers_to_s00_regslice_ARADDR(25 downto 0),
      s_axi_arprot(2 downto 0) => s00_couplers_to_s00_regslice_ARPROT(2 downto 0),
      s_axi_arready => s00_couplers_to_s00_regslice_ARREADY,
      s_axi_arvalid => s00_couplers_to_s00_regslice_ARVALID,
      s_axi_awaddr(25 downto 0) => s00_couplers_to_s00_regslice_AWADDR(25 downto 0),
      s_axi_awprot(2 downto 0) => s00_couplers_to_s00_regslice_AWPROT(2 downto 0),
      s_axi_awready => s00_couplers_to_s00_regslice_AWREADY,
      s_axi_awvalid => s00_couplers_to_s00_regslice_AWVALID,
      s_axi_bready => s00_couplers_to_s00_regslice_BREADY,
      s_axi_bresp(1 downto 0) => s00_couplers_to_s00_regslice_BRESP(1 downto 0),
      s_axi_bvalid => s00_couplers_to_s00_regslice_BVALID,
      s_axi_rdata(31 downto 0) => s00_couplers_to_s00_regslice_RDATA(31 downto 0),
      s_axi_rready => s00_couplers_to_s00_regslice_RREADY,
      s_axi_rresp(1 downto 0) => s00_couplers_to_s00_regslice_RRESP(1 downto 0),
      s_axi_rvalid => s00_couplers_to_s00_regslice_RVALID,
      s_axi_wdata(31 downto 0) => s00_couplers_to_s00_regslice_WDATA(31 downto 0),
      s_axi_wready => s00_couplers_to_s00_regslice_WREADY,
      s_axi_wstrb(3 downto 0) => s00_couplers_to_s00_regslice_WSTRB(3 downto 0),
      s_axi_wvalid => s00_couplers_to_s00_regslice_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dsp_ch0_imp_4MOMA0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    coef_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_tready : out STD_LOGIC;
    coef_tvalid : in STD_LOGIC;
    flags : in STD_LOGIC_VECTOR ( 15 downto 0 );
    in_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    in_pdti_tready : out STD_LOGIC;
    in_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    in_pdti_tvalid : in STD_LOGIC;
    out_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    out_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    out_pdti_tvalid : out STD_LOGIC;
    pos_enc_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pos_enc_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pulse_metadata_tdata : in STD_LOGIC_VECTOR ( 823 downto 0 );
    pulse_metadata_tready : out STD_LOGIC;
    pulse_metadata_tvalid : in STD_LOGIC
  );
end dsp_ch0_imp_4MOMA0;

architecture STRUCTURE of dsp_ch0_imp_4MOMA0 is
  component user_block2_axis_data_fifo_0_0 is
  port (
    s_axis_aresetn : in STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    axis_data_count : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axis_wr_data_count : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axis_rd_data_count : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component user_block2_axis_data_fifo_0_0;
  component user_block2_xlconstant_0_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component user_block2_xlconstant_0_0;
  component user_block2_axis_subset_converter_0_1 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    sparse_tkeep_removed : out STD_LOGIC
  );
  end component user_block2_axis_subset_converter_0_1;
  component user_block2_hcr_metadata_injector_0_0 is
  port (
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_idle : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    i_data_TVALID : in STD_LOGIC;
    i_data_TREADY : out STD_LOGIC;
    i_data_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    i_data_TDEST : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_data_TKEEP : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_data_TSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_data_TUSER : in STD_LOGIC_VECTOR ( 127 downto 0 );
    i_data_TLAST : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_data_TID : in STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TVALID : out STD_LOGIC;
    o_data_TREADY : in STD_LOGIC;
    o_data_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    o_data_TDEST : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TKEEP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    o_data_TSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    o_data_TUSER : out STD_LOGIC_VECTOR ( 127 downto 0 );
    o_data_TLAST : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TID : out STD_LOGIC_VECTOR ( 0 to 0 );
    pulse_metadata_V_TVALID : in STD_LOGIC;
    pulse_metadata_V_TREADY : out STD_LOGIC;
    pulse_metadata_V_TDATA : in STD_LOGIC_VECTOR ( 823 downto 0 );
    pos_enc_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pos_enc_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    flags : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  end component user_block2_hcr_metadata_injector_0_0;
  signal Conn1_TDATA : STD_LOGIC_VECTOR ( 823 downto 0 );
  signal Conn1_TREADY : STD_LOGIC;
  signal Conn1_TVALID : STD_LOGIC;
  signal axis_data_fifo_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute DEBUG : string;
  attribute DEBUG of axis_data_fifo_0_M_AXIS_TDATA : signal is "true";
  signal axis_data_fifo_0_M_AXIS_TREADY : STD_LOGIC;
  attribute DEBUG of axis_data_fifo_0_M_AXIS_TREADY : signal is "true";
  signal axis_data_fifo_0_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  attribute DEBUG of axis_data_fifo_0_M_AXIS_TUSER : signal is "true";
  signal axis_data_fifo_0_M_AXIS_TVALID : STD_LOGIC;
  attribute DEBUG of axis_data_fifo_0_M_AXIS_TVALID : signal is "true";
  signal axis_subset_converter_0_M_AXIS1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_subset_converter_0_M_AXIS1_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_subset_converter_0_M_AXIS1_TVALID : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS2_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute DEBUG of axis_subset_converter_0_M_AXIS2_TDATA : signal is "true";
  signal axis_subset_converter_0_M_AXIS2_TREADY : STD_LOGIC;
  attribute DEBUG of axis_subset_converter_0_M_AXIS2_TREADY : signal is "true";
  signal axis_subset_converter_0_M_AXIS2_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  attribute DEBUG of axis_subset_converter_0_M_AXIS2_TUSER : signal is "true";
  signal axis_subset_converter_0_M_AXIS2_TVALID : STD_LOGIC;
  attribute DEBUG of axis_subset_converter_0_M_AXIS2_TVALID : signal is "true";
  signal coef_1_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal coef_1_TREADY : STD_LOGIC;
  signal coef_1_TVALID : STD_LOGIC;
  signal flags_1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal metadata_injector_o_data_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal metadata_injector_o_data_TDEST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal metadata_injector_o_data_TID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal metadata_injector_o_data_TKEEP : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal metadata_injector_o_data_TLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal metadata_injector_o_data_TREADY : STD_LOGIC;
  signal metadata_injector_o_data_TSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal metadata_injector_o_data_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal metadata_injector_o_data_TVALID : STD_LOGIC;
  signal one_dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal pos_enc_0_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal pos_enc_1_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_adc_ch0_pdti_1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_adc_ch0_pdti_1_TREADY : STD_LOGIC;
  signal s_axis_adc_ch0_pdti_1_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal s_axis_adc_ch0_pdti_1_TVALID : STD_LOGIC;
  signal s_axis_adc_pdti_aclk_1 : STD_LOGIC;
  signal s_axis_adc_pdti_aresetn_1 : STD_LOGIC;
  signal NLW_fifo_axis_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_fifo_axis_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_fifo_axis_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_metadata_injector_ap_done_UNCONNECTED : STD_LOGIC;
  signal NLW_metadata_injector_ap_idle_UNCONNECTED : STD_LOGIC;
  signal NLW_metadata_injector_ap_ready_UNCONNECTED : STD_LOGIC;
  signal NLW_remove_unused_sigs_sparse_tkeep_removed_UNCONNECTED : STD_LOGIC;
begin
  Conn1_TDATA(823 downto 0) <= pulse_metadata_tdata(823 downto 0);
  Conn1_TVALID <= pulse_metadata_tvalid;
  coef_1_TDATA(23 downto 0) <= coef_tdata(23 downto 0);
  coef_1_TVALID <= coef_tvalid;
  coef_tready <= coef_1_TREADY;
  flags_1(15 downto 0) <= flags(15 downto 0);
  in_pdti_tready <= s_axis_adc_ch0_pdti_1_TREADY;
  out_pdti_tdata(31 downto 0) <= axis_subset_converter_0_M_AXIS1_TDATA(31 downto 0);
  out_pdti_tuser(127 downto 0) <= axis_subset_converter_0_M_AXIS1_TUSER(127 downto 0);
  out_pdti_tvalid <= axis_subset_converter_0_M_AXIS1_TVALID;
  pos_enc_0_1(31 downto 0) <= pos_enc_0(31 downto 0);
  pos_enc_1_1(31 downto 0) <= pos_enc_1(31 downto 0);
  pulse_metadata_tready <= Conn1_TREADY;
  s_axis_adc_ch0_pdti_1_TDATA(31 downto 0) <= in_pdti_tdata(31 downto 0);
  s_axis_adc_ch0_pdti_1_TUSER(127 downto 0) <= in_pdti_tuser(127 downto 0);
  s_axis_adc_ch0_pdti_1_TVALID <= in_pdti_tvalid;
  s_axis_adc_pdti_aclk_1 <= aclk;
  s_axis_adc_pdti_aresetn_1 <= aresetn;
fifo: component user_block2_axis_data_fifo_0_0
     port map (
      axis_data_count(31 downto 0) => NLW_fifo_axis_data_count_UNCONNECTED(31 downto 0),
      axis_rd_data_count(31 downto 0) => NLW_fifo_axis_rd_data_count_UNCONNECTED(31 downto 0),
      axis_wr_data_count(31 downto 0) => NLW_fifo_axis_wr_data_count_UNCONNECTED(31 downto 0),
      m_axis_tdata(31 downto 0) => axis_data_fifo_0_M_AXIS_TDATA(31 downto 0),
      m_axis_tready => axis_data_fifo_0_M_AXIS_TREADY,
      m_axis_tuser(127 downto 0) => axis_data_fifo_0_M_AXIS_TUSER(127 downto 0),
      m_axis_tvalid => axis_data_fifo_0_M_AXIS_TVALID,
      s_axis_aclk => s_axis_adc_pdti_aclk_1,
      s_axis_aresetn => s_axis_adc_pdti_aresetn_1,
      s_axis_tdata(31 downto 0) => s_axis_adc_ch0_pdti_1_TDATA(31 downto 0),
      s_axis_tready => s_axis_adc_ch0_pdti_1_TREADY,
      s_axis_tuser(127 downto 0) => s_axis_adc_ch0_pdti_1_TUSER(127 downto 0),
      s_axis_tvalid => s_axis_adc_ch0_pdti_1_TVALID
    );
fir: entity work.fir_imp_1O78BGT
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      coef_tdata(23 downto 0) => coef_1_TDATA(23 downto 0),
      coef_tready => coef_1_TREADY,
      coef_tvalid => coef_1_TVALID,
      i_data_tdata(31 downto 0) => axis_data_fifo_0_M_AXIS_TDATA(31 downto 0),
      i_data_tready => axis_data_fifo_0_M_AXIS_TREADY,
      i_data_tuser(127 downto 0) => axis_data_fifo_0_M_AXIS_TUSER(127 downto 0),
      i_data_tvalid => axis_data_fifo_0_M_AXIS_TVALID,
      o_data_tdata(31 downto 0) => axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0),
      o_data_tready => axis_subset_converter_0_M_AXIS2_TREADY,
      o_data_tuser(127 downto 0) => axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0),
      o_data_tvalid => axis_subset_converter_0_M_AXIS2_TVALID
    );
metadata_injector: component user_block2_hcr_metadata_injector_0_0
     port map (
      ap_clk => s_axis_adc_pdti_aclk_1,
      ap_done => NLW_metadata_injector_ap_done_UNCONNECTED,
      ap_idle => NLW_metadata_injector_ap_idle_UNCONNECTED,
      ap_ready => NLW_metadata_injector_ap_ready_UNCONNECTED,
      ap_rst_n => s_axis_adc_pdti_aresetn_1,
      ap_start => one_dout(0),
      flags(15 downto 0) => flags_1(15 downto 0),
      i_data_TDATA(31 downto 0) => axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0),
      i_data_TDEST(0) => '0',
      i_data_TID(0) => '0',
      i_data_TKEEP(3 downto 0) => B"1111",
      i_data_TLAST(0) => '0',
      i_data_TREADY => axis_subset_converter_0_M_AXIS2_TREADY,
      i_data_TSTRB(3 downto 0) => B"1111",
      i_data_TUSER(127 downto 0) => axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0),
      i_data_TVALID => axis_subset_converter_0_M_AXIS2_TVALID,
      o_data_TDATA(31 downto 0) => metadata_injector_o_data_TDATA(31 downto 0),
      o_data_TDEST(0) => metadata_injector_o_data_TDEST(0),
      o_data_TID(0) => metadata_injector_o_data_TID(0),
      o_data_TKEEP(3 downto 0) => metadata_injector_o_data_TKEEP(3 downto 0),
      o_data_TLAST(0) => metadata_injector_o_data_TLAST(0),
      o_data_TREADY => metadata_injector_o_data_TREADY,
      o_data_TSTRB(3 downto 0) => metadata_injector_o_data_TSTRB(3 downto 0),
      o_data_TUSER(127 downto 0) => metadata_injector_o_data_TUSER(127 downto 0),
      o_data_TVALID => metadata_injector_o_data_TVALID,
      pos_enc_0(31 downto 0) => pos_enc_0_1(31 downto 0),
      pos_enc_1(31 downto 0) => pos_enc_1_1(31 downto 0),
      pulse_metadata_V_TDATA(823 downto 0) => Conn1_TDATA(823 downto 0),
      pulse_metadata_V_TREADY => Conn1_TREADY,
      pulse_metadata_V_TVALID => Conn1_TVALID
    );
one: component user_block2_xlconstant_0_0
     port map (
      dout(0) => one_dout(0)
    );
remove_unused_sigs: component user_block2_axis_subset_converter_0_1
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(31 downto 0) => axis_subset_converter_0_M_AXIS1_TDATA(31 downto 0),
      m_axis_tuser(127 downto 0) => axis_subset_converter_0_M_AXIS1_TUSER(127 downto 0),
      m_axis_tvalid => axis_subset_converter_0_M_AXIS1_TVALID,
      s_axis_tdata(31 downto 0) => metadata_injector_o_data_TDATA(31 downto 0),
      s_axis_tdest(0) => metadata_injector_o_data_TDEST(0),
      s_axis_tid(0) => metadata_injector_o_data_TID(0),
      s_axis_tkeep(3 downto 0) => metadata_injector_o_data_TKEEP(3 downto 0),
      s_axis_tlast => metadata_injector_o_data_TLAST(0),
      s_axis_tready => metadata_injector_o_data_TREADY,
      s_axis_tstrb(3 downto 0) => metadata_injector_o_data_TSTRB(3 downto 0),
      s_axis_tuser(127 downto 0) => metadata_injector_o_data_TUSER(127 downto 0),
      s_axis_tvalid => metadata_injector_o_data_TVALID,
      sparse_tkeep_removed => NLW_remove_unused_sigs_sparse_tkeep_removed_UNCONNECTED
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dsp_ch1_imp_12KUHLZ is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    coef_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_tready : out STD_LOGIC;
    coef_tvalid : in STD_LOGIC;
    flags : in STD_LOGIC_VECTOR ( 15 downto 0 );
    in_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    in_pdti_tready : out STD_LOGIC;
    in_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    in_pdti_tvalid : in STD_LOGIC;
    out_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    out_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    out_pdti_tvalid : out STD_LOGIC;
    pos_enc_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pos_enc_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pulse_metadata_tdata : in STD_LOGIC_VECTOR ( 823 downto 0 );
    pulse_metadata_tready : out STD_LOGIC;
    pulse_metadata_tvalid : in STD_LOGIC
  );
end dsp_ch1_imp_12KUHLZ;

architecture STRUCTURE of dsp_ch1_imp_12KUHLZ is
  component user_block2_fifo_0_0 is
  port (
    s_axis_aresetn : in STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    axis_data_count : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axis_wr_data_count : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axis_rd_data_count : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component user_block2_fifo_0_0;
  component user_block2_one_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component user_block2_one_0;
  component user_block2_axis_subset_converter_0_3 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    sparse_tkeep_removed : out STD_LOGIC
  );
  end component user_block2_axis_subset_converter_0_3;
  component user_block2_hcr_metadata_injector_0_1 is
  port (
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_idle : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    i_data_TVALID : in STD_LOGIC;
    i_data_TREADY : out STD_LOGIC;
    i_data_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    i_data_TDEST : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_data_TKEEP : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_data_TSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_data_TUSER : in STD_LOGIC_VECTOR ( 127 downto 0 );
    i_data_TLAST : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_data_TID : in STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TVALID : out STD_LOGIC;
    o_data_TREADY : in STD_LOGIC;
    o_data_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    o_data_TDEST : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TKEEP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    o_data_TSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    o_data_TUSER : out STD_LOGIC_VECTOR ( 127 downto 0 );
    o_data_TLAST : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TID : out STD_LOGIC_VECTOR ( 0 to 0 );
    pulse_metadata_V_TVALID : in STD_LOGIC;
    pulse_metadata_V_TREADY : out STD_LOGIC;
    pulse_metadata_V_TDATA : in STD_LOGIC_VECTOR ( 823 downto 0 );
    pos_enc_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pos_enc_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    flags : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  end component user_block2_hcr_metadata_injector_0_1;
  signal Conn1_TDATA : STD_LOGIC_VECTOR ( 823 downto 0 );
  signal Conn1_TREADY : STD_LOGIC;
  signal Conn1_TVALID : STD_LOGIC;
  signal axis_data_fifo_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_data_fifo_0_M_AXIS_TREADY : STD_LOGIC;
  signal axis_data_fifo_0_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_data_fifo_0_M_AXIS_TVALID : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_subset_converter_0_M_AXIS1_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_subset_converter_0_M_AXIS1_TVALID : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS2_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_subset_converter_0_M_AXIS2_TREADY : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS2_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_subset_converter_0_M_AXIS2_TVALID : STD_LOGIC;
  signal coef_1_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal coef_1_TREADY : STD_LOGIC;
  signal coef_1_TVALID : STD_LOGIC;
  signal flags_1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal metadata_injector_o_data_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal metadata_injector_o_data_TDEST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal metadata_injector_o_data_TID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal metadata_injector_o_data_TKEEP : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal metadata_injector_o_data_TLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal metadata_injector_o_data_TREADY : STD_LOGIC;
  signal metadata_injector_o_data_TSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal metadata_injector_o_data_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal metadata_injector_o_data_TVALID : STD_LOGIC;
  signal one_dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal pos_enc_0_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal pos_enc_1_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_adc_ch0_pdti_1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_adc_ch0_pdti_1_TREADY : STD_LOGIC;
  signal s_axis_adc_ch0_pdti_1_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal s_axis_adc_ch0_pdti_1_TVALID : STD_LOGIC;
  signal s_axis_adc_pdti_aclk_1 : STD_LOGIC;
  signal s_axis_adc_pdti_aresetn_1 : STD_LOGIC;
  signal NLW_fifo_axis_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_fifo_axis_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_fifo_axis_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_metadata_injector_ap_done_UNCONNECTED : STD_LOGIC;
  signal NLW_metadata_injector_ap_idle_UNCONNECTED : STD_LOGIC;
  signal NLW_metadata_injector_ap_ready_UNCONNECTED : STD_LOGIC;
  signal NLW_remove_unused_sigs_sparse_tkeep_removed_UNCONNECTED : STD_LOGIC;
begin
  Conn1_TDATA(823 downto 0) <= pulse_metadata_tdata(823 downto 0);
  Conn1_TVALID <= pulse_metadata_tvalid;
  coef_1_TDATA(23 downto 0) <= coef_tdata(23 downto 0);
  coef_1_TVALID <= coef_tvalid;
  coef_tready <= coef_1_TREADY;
  flags_1(15 downto 0) <= flags(15 downto 0);
  in_pdti_tready <= s_axis_adc_ch0_pdti_1_TREADY;
  out_pdti_tdata(31 downto 0) <= axis_subset_converter_0_M_AXIS1_TDATA(31 downto 0);
  out_pdti_tuser(127 downto 0) <= axis_subset_converter_0_M_AXIS1_TUSER(127 downto 0);
  out_pdti_tvalid <= axis_subset_converter_0_M_AXIS1_TVALID;
  pos_enc_0_1(31 downto 0) <= pos_enc_0(31 downto 0);
  pos_enc_1_1(31 downto 0) <= pos_enc_1(31 downto 0);
  pulse_metadata_tready <= Conn1_TREADY;
  s_axis_adc_ch0_pdti_1_TDATA(31 downto 0) <= in_pdti_tdata(31 downto 0);
  s_axis_adc_ch0_pdti_1_TUSER(127 downto 0) <= in_pdti_tuser(127 downto 0);
  s_axis_adc_ch0_pdti_1_TVALID <= in_pdti_tvalid;
  s_axis_adc_pdti_aclk_1 <= aclk;
  s_axis_adc_pdti_aresetn_1 <= aresetn;
fifo: component user_block2_fifo_0_0
     port map (
      axis_data_count(31 downto 0) => NLW_fifo_axis_data_count_UNCONNECTED(31 downto 0),
      axis_rd_data_count(31 downto 0) => NLW_fifo_axis_rd_data_count_UNCONNECTED(31 downto 0),
      axis_wr_data_count(31 downto 0) => NLW_fifo_axis_wr_data_count_UNCONNECTED(31 downto 0),
      m_axis_tdata(31 downto 0) => axis_data_fifo_0_M_AXIS_TDATA(31 downto 0),
      m_axis_tready => axis_data_fifo_0_M_AXIS_TREADY,
      m_axis_tuser(127 downto 0) => axis_data_fifo_0_M_AXIS_TUSER(127 downto 0),
      m_axis_tvalid => axis_data_fifo_0_M_AXIS_TVALID,
      s_axis_aclk => s_axis_adc_pdti_aclk_1,
      s_axis_aresetn => s_axis_adc_pdti_aresetn_1,
      s_axis_tdata(31 downto 0) => s_axis_adc_ch0_pdti_1_TDATA(31 downto 0),
      s_axis_tready => s_axis_adc_ch0_pdti_1_TREADY,
      s_axis_tuser(127 downto 0) => s_axis_adc_ch0_pdti_1_TUSER(127 downto 0),
      s_axis_tvalid => s_axis_adc_ch0_pdti_1_TVALID
    );
fir: entity work.fir_imp_WWVVRW
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      coef_tdata(23 downto 0) => coef_1_TDATA(23 downto 0),
      coef_tready => coef_1_TREADY,
      coef_tvalid => coef_1_TVALID,
      i_data_tdata(31 downto 0) => axis_data_fifo_0_M_AXIS_TDATA(31 downto 0),
      i_data_tready => axis_data_fifo_0_M_AXIS_TREADY,
      i_data_tuser(127 downto 0) => axis_data_fifo_0_M_AXIS_TUSER(127 downto 0),
      i_data_tvalid => axis_data_fifo_0_M_AXIS_TVALID,
      o_data_tdata(31 downto 0) => axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0),
      o_data_tready => axis_subset_converter_0_M_AXIS2_TREADY,
      o_data_tuser(127 downto 0) => axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0),
      o_data_tvalid => axis_subset_converter_0_M_AXIS2_TVALID
    );
metadata_injector: component user_block2_hcr_metadata_injector_0_1
     port map (
      ap_clk => s_axis_adc_pdti_aclk_1,
      ap_done => NLW_metadata_injector_ap_done_UNCONNECTED,
      ap_idle => NLW_metadata_injector_ap_idle_UNCONNECTED,
      ap_ready => NLW_metadata_injector_ap_ready_UNCONNECTED,
      ap_rst_n => s_axis_adc_pdti_aresetn_1,
      ap_start => one_dout(0),
      flags(15 downto 0) => flags_1(15 downto 0),
      i_data_TDATA(31 downto 0) => axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0),
      i_data_TDEST(0) => '0',
      i_data_TID(0) => '0',
      i_data_TKEEP(3 downto 0) => B"1111",
      i_data_TLAST(0) => '0',
      i_data_TREADY => axis_subset_converter_0_M_AXIS2_TREADY,
      i_data_TSTRB(3 downto 0) => B"1111",
      i_data_TUSER(127 downto 0) => axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0),
      i_data_TVALID => axis_subset_converter_0_M_AXIS2_TVALID,
      o_data_TDATA(31 downto 0) => metadata_injector_o_data_TDATA(31 downto 0),
      o_data_TDEST(0) => metadata_injector_o_data_TDEST(0),
      o_data_TID(0) => metadata_injector_o_data_TID(0),
      o_data_TKEEP(3 downto 0) => metadata_injector_o_data_TKEEP(3 downto 0),
      o_data_TLAST(0) => metadata_injector_o_data_TLAST(0),
      o_data_TREADY => metadata_injector_o_data_TREADY,
      o_data_TSTRB(3 downto 0) => metadata_injector_o_data_TSTRB(3 downto 0),
      o_data_TUSER(127 downto 0) => metadata_injector_o_data_TUSER(127 downto 0),
      o_data_TVALID => metadata_injector_o_data_TVALID,
      pos_enc_0(31 downto 0) => pos_enc_0_1(31 downto 0),
      pos_enc_1(31 downto 0) => pos_enc_1_1(31 downto 0),
      pulse_metadata_V_TDATA(823 downto 0) => Conn1_TDATA(823 downto 0),
      pulse_metadata_V_TREADY => Conn1_TREADY,
      pulse_metadata_V_TVALID => Conn1_TVALID
    );
one: component user_block2_one_0
     port map (
      dout(0) => one_dout(0)
    );
remove_unused_sigs: component user_block2_axis_subset_converter_0_3
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(31 downto 0) => axis_subset_converter_0_M_AXIS1_TDATA(31 downto 0),
      m_axis_tuser(127 downto 0) => axis_subset_converter_0_M_AXIS1_TUSER(127 downto 0),
      m_axis_tvalid => axis_subset_converter_0_M_AXIS1_TVALID,
      s_axis_tdata(31 downto 0) => metadata_injector_o_data_TDATA(31 downto 0),
      s_axis_tdest(0) => metadata_injector_o_data_TDEST(0),
      s_axis_tid(0) => metadata_injector_o_data_TID(0),
      s_axis_tkeep(3 downto 0) => metadata_injector_o_data_TKEEP(3 downto 0),
      s_axis_tlast => metadata_injector_o_data_TLAST(0),
      s_axis_tready => metadata_injector_o_data_TREADY,
      s_axis_tstrb(3 downto 0) => metadata_injector_o_data_TSTRB(3 downto 0),
      s_axis_tuser(127 downto 0) => metadata_injector_o_data_TUSER(127 downto 0),
      s_axis_tvalid => metadata_injector_o_data_TVALID,
      sparse_tkeep_removed => NLW_remove_unused_sigs_sparse_tkeep_removed_UNCONNECTED
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dsp_ch2_imp_1Y2Y72V is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    coef_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_tready : out STD_LOGIC;
    coef_tvalid : in STD_LOGIC;
    flags : in STD_LOGIC_VECTOR ( 15 downto 0 );
    in_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    in_pdti_tready : out STD_LOGIC;
    in_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    in_pdti_tvalid : in STD_LOGIC;
    out_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    out_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    out_pdti_tvalid : out STD_LOGIC;
    pos_enc_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pos_enc_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pulse_metadata_tdata : in STD_LOGIC_VECTOR ( 823 downto 0 );
    pulse_metadata_tready : out STD_LOGIC;
    pulse_metadata_tvalid : in STD_LOGIC
  );
end dsp_ch2_imp_1Y2Y72V;

architecture STRUCTURE of dsp_ch2_imp_1Y2Y72V is
  component user_block2_fifo_0_1 is
  port (
    s_axis_aresetn : in STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    axis_data_count : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axis_wr_data_count : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axis_rd_data_count : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component user_block2_fifo_0_1;
  component user_block2_one_1 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component user_block2_one_1;
  component user_block2_axis_subset_converter_0_4 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    sparse_tkeep_removed : out STD_LOGIC
  );
  end component user_block2_axis_subset_converter_0_4;
  component user_block2_hcr_metadata_injector_0_2 is
  port (
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_idle : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    i_data_TVALID : in STD_LOGIC;
    i_data_TREADY : out STD_LOGIC;
    i_data_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    i_data_TDEST : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_data_TKEEP : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_data_TSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_data_TUSER : in STD_LOGIC_VECTOR ( 127 downto 0 );
    i_data_TLAST : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_data_TID : in STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TVALID : out STD_LOGIC;
    o_data_TREADY : in STD_LOGIC;
    o_data_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    o_data_TDEST : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TKEEP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    o_data_TSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    o_data_TUSER : out STD_LOGIC_VECTOR ( 127 downto 0 );
    o_data_TLAST : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TID : out STD_LOGIC_VECTOR ( 0 to 0 );
    pulse_metadata_V_TVALID : in STD_LOGIC;
    pulse_metadata_V_TREADY : out STD_LOGIC;
    pulse_metadata_V_TDATA : in STD_LOGIC_VECTOR ( 823 downto 0 );
    pos_enc_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pos_enc_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    flags : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  end component user_block2_hcr_metadata_injector_0_2;
  signal Conn1_TDATA : STD_LOGIC_VECTOR ( 823 downto 0 );
  signal Conn1_TREADY : STD_LOGIC;
  signal Conn1_TVALID : STD_LOGIC;
  signal axis_data_fifo_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_data_fifo_0_M_AXIS_TREADY : STD_LOGIC;
  signal axis_data_fifo_0_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_data_fifo_0_M_AXIS_TVALID : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_subset_converter_0_M_AXIS1_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_subset_converter_0_M_AXIS1_TVALID : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS2_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_subset_converter_0_M_AXIS2_TREADY : STD_LOGIC;
  signal axis_subset_converter_0_M_AXIS2_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_subset_converter_0_M_AXIS2_TVALID : STD_LOGIC;
  signal coef_1_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal coef_1_TREADY : STD_LOGIC;
  signal coef_1_TVALID : STD_LOGIC;
  signal flags_1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal metadata_injector_o_data_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal metadata_injector_o_data_TDEST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal metadata_injector_o_data_TID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal metadata_injector_o_data_TKEEP : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal metadata_injector_o_data_TLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal metadata_injector_o_data_TREADY : STD_LOGIC;
  signal metadata_injector_o_data_TSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal metadata_injector_o_data_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal metadata_injector_o_data_TVALID : STD_LOGIC;
  signal one_dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal pos_enc_0_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal pos_enc_1_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_adc_ch0_pdti_1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_adc_ch0_pdti_1_TREADY : STD_LOGIC;
  signal s_axis_adc_ch0_pdti_1_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal s_axis_adc_ch0_pdti_1_TVALID : STD_LOGIC;
  signal s_axis_adc_pdti_aclk_1 : STD_LOGIC;
  signal s_axis_adc_pdti_aresetn_1 : STD_LOGIC;
  signal NLW_fifo_axis_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_fifo_axis_rd_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_fifo_axis_wr_data_count_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_metadata_injector_ap_done_UNCONNECTED : STD_LOGIC;
  signal NLW_metadata_injector_ap_idle_UNCONNECTED : STD_LOGIC;
  signal NLW_metadata_injector_ap_ready_UNCONNECTED : STD_LOGIC;
  signal NLW_remove_unused_sigs_sparse_tkeep_removed_UNCONNECTED : STD_LOGIC;
begin
  Conn1_TDATA(823 downto 0) <= pulse_metadata_tdata(823 downto 0);
  Conn1_TVALID <= pulse_metadata_tvalid;
  coef_1_TDATA(23 downto 0) <= coef_tdata(23 downto 0);
  coef_1_TVALID <= coef_tvalid;
  coef_tready <= coef_1_TREADY;
  flags_1(15 downto 0) <= flags(15 downto 0);
  in_pdti_tready <= s_axis_adc_ch0_pdti_1_TREADY;
  out_pdti_tdata(31 downto 0) <= axis_subset_converter_0_M_AXIS1_TDATA(31 downto 0);
  out_pdti_tuser(127 downto 0) <= axis_subset_converter_0_M_AXIS1_TUSER(127 downto 0);
  out_pdti_tvalid <= axis_subset_converter_0_M_AXIS1_TVALID;
  pos_enc_0_1(31 downto 0) <= pos_enc_0(31 downto 0);
  pos_enc_1_1(31 downto 0) <= pos_enc_1(31 downto 0);
  pulse_metadata_tready <= Conn1_TREADY;
  s_axis_adc_ch0_pdti_1_TDATA(31 downto 0) <= in_pdti_tdata(31 downto 0);
  s_axis_adc_ch0_pdti_1_TUSER(127 downto 0) <= in_pdti_tuser(127 downto 0);
  s_axis_adc_ch0_pdti_1_TVALID <= in_pdti_tvalid;
  s_axis_adc_pdti_aclk_1 <= aclk;
  s_axis_adc_pdti_aresetn_1 <= aresetn;
fifo: component user_block2_fifo_0_1
     port map (
      axis_data_count(31 downto 0) => NLW_fifo_axis_data_count_UNCONNECTED(31 downto 0),
      axis_rd_data_count(31 downto 0) => NLW_fifo_axis_rd_data_count_UNCONNECTED(31 downto 0),
      axis_wr_data_count(31 downto 0) => NLW_fifo_axis_wr_data_count_UNCONNECTED(31 downto 0),
      m_axis_tdata(31 downto 0) => axis_data_fifo_0_M_AXIS_TDATA(31 downto 0),
      m_axis_tready => axis_data_fifo_0_M_AXIS_TREADY,
      m_axis_tuser(127 downto 0) => axis_data_fifo_0_M_AXIS_TUSER(127 downto 0),
      m_axis_tvalid => axis_data_fifo_0_M_AXIS_TVALID,
      s_axis_aclk => s_axis_adc_pdti_aclk_1,
      s_axis_aresetn => s_axis_adc_pdti_aresetn_1,
      s_axis_tdata(31 downto 0) => s_axis_adc_ch0_pdti_1_TDATA(31 downto 0),
      s_axis_tready => s_axis_adc_ch0_pdti_1_TREADY,
      s_axis_tuser(127 downto 0) => s_axis_adc_ch0_pdti_1_TUSER(127 downto 0),
      s_axis_tvalid => s_axis_adc_ch0_pdti_1_TVALID
    );
fir: entity work.fir_imp_QGCWA6
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      coef_tdata(23 downto 0) => coef_1_TDATA(23 downto 0),
      coef_tready => coef_1_TREADY,
      coef_tvalid => coef_1_TVALID,
      i_data_tdata(31 downto 0) => axis_data_fifo_0_M_AXIS_TDATA(31 downto 0),
      i_data_tready => axis_data_fifo_0_M_AXIS_TREADY,
      i_data_tuser(127 downto 0) => axis_data_fifo_0_M_AXIS_TUSER(127 downto 0),
      i_data_tvalid => axis_data_fifo_0_M_AXIS_TVALID,
      o_data_tdata(31 downto 0) => axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0),
      o_data_tready => axis_subset_converter_0_M_AXIS2_TREADY,
      o_data_tuser(127 downto 0) => axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0),
      o_data_tvalid => axis_subset_converter_0_M_AXIS2_TVALID
    );
metadata_injector: component user_block2_hcr_metadata_injector_0_2
     port map (
      ap_clk => s_axis_adc_pdti_aclk_1,
      ap_done => NLW_metadata_injector_ap_done_UNCONNECTED,
      ap_idle => NLW_metadata_injector_ap_idle_UNCONNECTED,
      ap_ready => NLW_metadata_injector_ap_ready_UNCONNECTED,
      ap_rst_n => s_axis_adc_pdti_aresetn_1,
      ap_start => one_dout(0),
      flags(15 downto 0) => flags_1(15 downto 0),
      i_data_TDATA(31 downto 0) => axis_subset_converter_0_M_AXIS2_TDATA(31 downto 0),
      i_data_TDEST(0) => '0',
      i_data_TID(0) => '0',
      i_data_TKEEP(3 downto 0) => B"1111",
      i_data_TLAST(0) => '0',
      i_data_TREADY => axis_subset_converter_0_M_AXIS2_TREADY,
      i_data_TSTRB(3 downto 0) => B"1111",
      i_data_TUSER(127 downto 0) => axis_subset_converter_0_M_AXIS2_TUSER(127 downto 0),
      i_data_TVALID => axis_subset_converter_0_M_AXIS2_TVALID,
      o_data_TDATA(31 downto 0) => metadata_injector_o_data_TDATA(31 downto 0),
      o_data_TDEST(0) => metadata_injector_o_data_TDEST(0),
      o_data_TID(0) => metadata_injector_o_data_TID(0),
      o_data_TKEEP(3 downto 0) => metadata_injector_o_data_TKEEP(3 downto 0),
      o_data_TLAST(0) => metadata_injector_o_data_TLAST(0),
      o_data_TREADY => metadata_injector_o_data_TREADY,
      o_data_TSTRB(3 downto 0) => metadata_injector_o_data_TSTRB(3 downto 0),
      o_data_TUSER(127 downto 0) => metadata_injector_o_data_TUSER(127 downto 0),
      o_data_TVALID => metadata_injector_o_data_TVALID,
      pos_enc_0(31 downto 0) => pos_enc_0_1(31 downto 0),
      pos_enc_1(31 downto 0) => pos_enc_1_1(31 downto 0),
      pulse_metadata_V_TDATA(823 downto 0) => Conn1_TDATA(823 downto 0),
      pulse_metadata_V_TREADY => Conn1_TREADY,
      pulse_metadata_V_TVALID => Conn1_TVALID
    );
one: component user_block2_one_1
     port map (
      dout(0) => one_dout(0)
    );
remove_unused_sigs: component user_block2_axis_subset_converter_0_4
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => s_axis_adc_pdti_aresetn_1,
      m_axis_tdata(31 downto 0) => axis_subset_converter_0_M_AXIS1_TDATA(31 downto 0),
      m_axis_tuser(127 downto 0) => axis_subset_converter_0_M_AXIS1_TUSER(127 downto 0),
      m_axis_tvalid => axis_subset_converter_0_M_AXIS1_TVALID,
      s_axis_tdata(31 downto 0) => metadata_injector_o_data_TDATA(31 downto 0),
      s_axis_tdest(0) => metadata_injector_o_data_TDEST(0),
      s_axis_tid(0) => metadata_injector_o_data_TID(0),
      s_axis_tkeep(3 downto 0) => metadata_injector_o_data_TKEEP(3 downto 0),
      s_axis_tlast => metadata_injector_o_data_TLAST(0),
      s_axis_tready => metadata_injector_o_data_TREADY,
      s_axis_tstrb(3 downto 0) => metadata_injector_o_data_TSTRB(3 downto 0),
      s_axis_tuser(127 downto 0) => metadata_injector_o_data_TUSER(127 downto 0),
      s_axis_tvalid => metadata_injector_o_data_TVALID,
      sparse_tkeep_removed => NLW_remove_unused_sigs_sparse_tkeep_removed_UNCONNECTED
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_axi_interc_0 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    M00_ACLK : in STD_LOGIC;
    M00_ARESETN : in STD_LOGIC;
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 6 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 6 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_rready : out STD_LOGIC;
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_wvalid : out STD_LOGIC;
    M01_ACLK : in STD_LOGIC;
    M01_ARESETN : in STD_LOGIC;
    M01_AXI_araddr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    M01_AXI_arready : in STD_LOGIC;
    M01_AXI_arvalid : out STD_LOGIC;
    M01_AXI_awaddr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    M01_AXI_awready : in STD_LOGIC;
    M01_AXI_awvalid : out STD_LOGIC;
    M01_AXI_bready : out STD_LOGIC;
    M01_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_bvalid : in STD_LOGIC;
    M01_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_rready : out STD_LOGIC;
    M01_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_rvalid : in STD_LOGIC;
    M01_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_wready : in STD_LOGIC;
    M01_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M01_AXI_wvalid : out STD_LOGIC;
    S00_ACLK : in STD_LOGIC;
    S00_ARESETN : in STD_LOGIC;
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_rready : in STD_LOGIC;
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_wvalid : in STD_LOGIC
  );
end user_block2_axi_interc_0;

architecture STRUCTURE of user_block2_axi_interc_0 is
  component user_block2_xbar_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 51 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 51 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component user_block2_xbar_0;
  signal M00_ACLK_1 : STD_LOGIC;
  signal M00_ARESETN_1 : STD_LOGIC;
  signal M01_ACLK_1 : STD_LOGIC;
  signal M01_ARESETN_1 : STD_LOGIC;
  signal S00_ACLK_1 : STD_LOGIC;
  signal S00_ARESETN_1 : STD_LOGIC;
  signal axi_interc_ACLK_net : STD_LOGIC;
  signal axi_interc_ARESETN_net : STD_LOGIC;
  signal axi_interc_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal axi_interc_to_s00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_interc_to_s00_couplers_ARREADY : STD_LOGIC;
  signal axi_interc_to_s00_couplers_ARVALID : STD_LOGIC;
  signal axi_interc_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal axi_interc_to_s00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_interc_to_s00_couplers_AWREADY : STD_LOGIC;
  signal axi_interc_to_s00_couplers_AWVALID : STD_LOGIC;
  signal axi_interc_to_s00_couplers_BREADY : STD_LOGIC;
  signal axi_interc_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_interc_to_s00_couplers_BVALID : STD_LOGIC;
  signal axi_interc_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_interc_to_s00_couplers_RREADY : STD_LOGIC;
  signal axi_interc_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_interc_to_s00_couplers_RVALID : STD_LOGIC;
  signal axi_interc_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_interc_to_s00_couplers_WREADY : STD_LOGIC;
  signal axi_interc_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_interc_to_s00_couplers_WVALID : STD_LOGIC;
  signal m00_couplers_to_axi_interc_ARADDR : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal m00_couplers_to_axi_interc_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_axi_interc_ARREADY : STD_LOGIC;
  signal m00_couplers_to_axi_interc_ARVALID : STD_LOGIC;
  signal m00_couplers_to_axi_interc_AWADDR : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal m00_couplers_to_axi_interc_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_axi_interc_AWREADY : STD_LOGIC;
  signal m00_couplers_to_axi_interc_AWVALID : STD_LOGIC;
  signal m00_couplers_to_axi_interc_BREADY : STD_LOGIC;
  signal m00_couplers_to_axi_interc_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_interc_BVALID : STD_LOGIC;
  signal m00_couplers_to_axi_interc_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_axi_interc_RREADY : STD_LOGIC;
  signal m00_couplers_to_axi_interc_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_interc_RVALID : STD_LOGIC;
  signal m00_couplers_to_axi_interc_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_axi_interc_WREADY : STD_LOGIC;
  signal m00_couplers_to_axi_interc_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_axi_interc_WVALID : STD_LOGIC;
  signal m01_couplers_to_axi_interc_ARADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal m01_couplers_to_axi_interc_ARREADY : STD_LOGIC;
  signal m01_couplers_to_axi_interc_ARVALID : STD_LOGIC;
  signal m01_couplers_to_axi_interc_AWADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal m01_couplers_to_axi_interc_AWREADY : STD_LOGIC;
  signal m01_couplers_to_axi_interc_AWVALID : STD_LOGIC;
  signal m01_couplers_to_axi_interc_BREADY : STD_LOGIC;
  signal m01_couplers_to_axi_interc_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_axi_interc_BVALID : STD_LOGIC;
  signal m01_couplers_to_axi_interc_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_axi_interc_RREADY : STD_LOGIC;
  signal m01_couplers_to_axi_interc_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_axi_interc_RVALID : STD_LOGIC;
  signal m01_couplers_to_axi_interc_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_axi_interc_WREADY : STD_LOGIC;
  signal m01_couplers_to_axi_interc_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m01_couplers_to_axi_interc_WVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_ARADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal s00_couplers_to_xbar_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_ARVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_AWADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal s00_couplers_to_xbar_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_AWVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_BREADY : STD_LOGIC;
  signal s00_couplers_to_xbar_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_RREADY : STD_LOGIC;
  signal s00_couplers_to_xbar_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_xbar_WVALID : STD_LOGIC;
  signal xbar_to_m00_couplers_ARADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal xbar_to_m00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal xbar_to_m00_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m00_couplers_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_AWADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal xbar_to_m00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal xbar_to_m00_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m00_couplers_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_to_m00_couplers_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m01_couplers_ARADDR : STD_LOGIC_VECTOR ( 51 downto 26 );
  signal xbar_to_m01_couplers_ARPROT : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal xbar_to_m01_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_ARVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_AWADDR : STD_LOGIC_VECTOR ( 51 downto 26 );
  signal xbar_to_m01_couplers_AWPROT : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal xbar_to_m01_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_AWVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_BREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m01_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m01_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m01_couplers_RREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m01_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m01_couplers_WDATA : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal xbar_to_m01_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_WSTRB : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal xbar_to_m01_couplers_WVALID : STD_LOGIC_VECTOR ( 1 to 1 );
begin
  M00_ACLK_1 <= M00_ACLK;
  M00_ARESETN_1 <= M00_ARESETN;
  M00_AXI_araddr(6 downto 0) <= m00_couplers_to_axi_interc_ARADDR(6 downto 0);
  M00_AXI_arprot(2 downto 0) <= m00_couplers_to_axi_interc_ARPROT(2 downto 0);
  M00_AXI_arvalid <= m00_couplers_to_axi_interc_ARVALID;
  M00_AXI_awaddr(6 downto 0) <= m00_couplers_to_axi_interc_AWADDR(6 downto 0);
  M00_AXI_awprot(2 downto 0) <= m00_couplers_to_axi_interc_AWPROT(2 downto 0);
  M00_AXI_awvalid <= m00_couplers_to_axi_interc_AWVALID;
  M00_AXI_bready <= m00_couplers_to_axi_interc_BREADY;
  M00_AXI_rready <= m00_couplers_to_axi_interc_RREADY;
  M00_AXI_wdata(31 downto 0) <= m00_couplers_to_axi_interc_WDATA(31 downto 0);
  M00_AXI_wstrb(3 downto 0) <= m00_couplers_to_axi_interc_WSTRB(3 downto 0);
  M00_AXI_wvalid <= m00_couplers_to_axi_interc_WVALID;
  M01_ACLK_1 <= M01_ACLK;
  M01_ARESETN_1 <= M01_ARESETN;
  M01_AXI_araddr(12 downto 0) <= m01_couplers_to_axi_interc_ARADDR(12 downto 0);
  M01_AXI_arvalid <= m01_couplers_to_axi_interc_ARVALID;
  M01_AXI_awaddr(12 downto 0) <= m01_couplers_to_axi_interc_AWADDR(12 downto 0);
  M01_AXI_awvalid <= m01_couplers_to_axi_interc_AWVALID;
  M01_AXI_bready <= m01_couplers_to_axi_interc_BREADY;
  M01_AXI_rready <= m01_couplers_to_axi_interc_RREADY;
  M01_AXI_wdata(31 downto 0) <= m01_couplers_to_axi_interc_WDATA(31 downto 0);
  M01_AXI_wstrb(3 downto 0) <= m01_couplers_to_axi_interc_WSTRB(3 downto 0);
  M01_AXI_wvalid <= m01_couplers_to_axi_interc_WVALID;
  S00_ACLK_1 <= S00_ACLK;
  S00_ARESETN_1 <= S00_ARESETN;
  S00_AXI_arready <= axi_interc_to_s00_couplers_ARREADY;
  S00_AXI_awready <= axi_interc_to_s00_couplers_AWREADY;
  S00_AXI_bresp(1 downto 0) <= axi_interc_to_s00_couplers_BRESP(1 downto 0);
  S00_AXI_bvalid <= axi_interc_to_s00_couplers_BVALID;
  S00_AXI_rdata(31 downto 0) <= axi_interc_to_s00_couplers_RDATA(31 downto 0);
  S00_AXI_rresp(1 downto 0) <= axi_interc_to_s00_couplers_RRESP(1 downto 0);
  S00_AXI_rvalid <= axi_interc_to_s00_couplers_RVALID;
  S00_AXI_wready <= axi_interc_to_s00_couplers_WREADY;
  axi_interc_ACLK_net <= ACLK;
  axi_interc_ARESETN_net <= ARESETN;
  axi_interc_to_s00_couplers_ARADDR(25 downto 0) <= S00_AXI_araddr(25 downto 0);
  axi_interc_to_s00_couplers_ARPROT(2 downto 0) <= S00_AXI_arprot(2 downto 0);
  axi_interc_to_s00_couplers_ARVALID <= S00_AXI_arvalid;
  axi_interc_to_s00_couplers_AWADDR(25 downto 0) <= S00_AXI_awaddr(25 downto 0);
  axi_interc_to_s00_couplers_AWPROT(2 downto 0) <= S00_AXI_awprot(2 downto 0);
  axi_interc_to_s00_couplers_AWVALID <= S00_AXI_awvalid;
  axi_interc_to_s00_couplers_BREADY <= S00_AXI_bready;
  axi_interc_to_s00_couplers_RREADY <= S00_AXI_rready;
  axi_interc_to_s00_couplers_WDATA(31 downto 0) <= S00_AXI_wdata(31 downto 0);
  axi_interc_to_s00_couplers_WSTRB(3 downto 0) <= S00_AXI_wstrb(3 downto 0);
  axi_interc_to_s00_couplers_WVALID <= S00_AXI_wvalid;
  m00_couplers_to_axi_interc_ARREADY <= M00_AXI_arready;
  m00_couplers_to_axi_interc_AWREADY <= M00_AXI_awready;
  m00_couplers_to_axi_interc_BRESP(1 downto 0) <= M00_AXI_bresp(1 downto 0);
  m00_couplers_to_axi_interc_BVALID <= M00_AXI_bvalid;
  m00_couplers_to_axi_interc_RDATA(31 downto 0) <= M00_AXI_rdata(31 downto 0);
  m00_couplers_to_axi_interc_RRESP(1 downto 0) <= M00_AXI_rresp(1 downto 0);
  m00_couplers_to_axi_interc_RVALID <= M00_AXI_rvalid;
  m00_couplers_to_axi_interc_WREADY <= M00_AXI_wready;
  m01_couplers_to_axi_interc_ARREADY <= M01_AXI_arready;
  m01_couplers_to_axi_interc_AWREADY <= M01_AXI_awready;
  m01_couplers_to_axi_interc_BRESP(1 downto 0) <= M01_AXI_bresp(1 downto 0);
  m01_couplers_to_axi_interc_BVALID <= M01_AXI_bvalid;
  m01_couplers_to_axi_interc_RDATA(31 downto 0) <= M01_AXI_rdata(31 downto 0);
  m01_couplers_to_axi_interc_RRESP(1 downto 0) <= M01_AXI_rresp(1 downto 0);
  m01_couplers_to_axi_interc_RVALID <= M01_AXI_rvalid;
  m01_couplers_to_axi_interc_WREADY <= M01_AXI_wready;
m00_couplers: entity work.m00_couplers_imp_19I9FMC
     port map (
      M_ACLK => M00_ACLK_1,
      M_ARESETN => M00_ARESETN_1,
      M_AXI_araddr(6 downto 0) => m00_couplers_to_axi_interc_ARADDR(6 downto 0),
      M_AXI_arprot(2 downto 0) => m00_couplers_to_axi_interc_ARPROT(2 downto 0),
      M_AXI_arready => m00_couplers_to_axi_interc_ARREADY,
      M_AXI_arvalid => m00_couplers_to_axi_interc_ARVALID,
      M_AXI_awaddr(6 downto 0) => m00_couplers_to_axi_interc_AWADDR(6 downto 0),
      M_AXI_awprot(2 downto 0) => m00_couplers_to_axi_interc_AWPROT(2 downto 0),
      M_AXI_awready => m00_couplers_to_axi_interc_AWREADY,
      M_AXI_awvalid => m00_couplers_to_axi_interc_AWVALID,
      M_AXI_bready => m00_couplers_to_axi_interc_BREADY,
      M_AXI_bresp(1 downto 0) => m00_couplers_to_axi_interc_BRESP(1 downto 0),
      M_AXI_bvalid => m00_couplers_to_axi_interc_BVALID,
      M_AXI_rdata(31 downto 0) => m00_couplers_to_axi_interc_RDATA(31 downto 0),
      M_AXI_rready => m00_couplers_to_axi_interc_RREADY,
      M_AXI_rresp(1 downto 0) => m00_couplers_to_axi_interc_RRESP(1 downto 0),
      M_AXI_rvalid => m00_couplers_to_axi_interc_RVALID,
      M_AXI_wdata(31 downto 0) => m00_couplers_to_axi_interc_WDATA(31 downto 0),
      M_AXI_wready => m00_couplers_to_axi_interc_WREADY,
      M_AXI_wstrb(3 downto 0) => m00_couplers_to_axi_interc_WSTRB(3 downto 0),
      M_AXI_wvalid => m00_couplers_to_axi_interc_WVALID,
      S_ACLK => axi_interc_ACLK_net,
      S_ARESETN => axi_interc_ARESETN_net,
      S_AXI_araddr(25 downto 0) => xbar_to_m00_couplers_ARADDR(25 downto 0),
      S_AXI_arprot(2 downto 0) => xbar_to_m00_couplers_ARPROT(2 downto 0),
      S_AXI_arready => xbar_to_m00_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m00_couplers_ARVALID(0),
      S_AXI_awaddr(25 downto 0) => xbar_to_m00_couplers_AWADDR(25 downto 0),
      S_AXI_awprot(2 downto 0) => xbar_to_m00_couplers_AWPROT(2 downto 0),
      S_AXI_awready => xbar_to_m00_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m00_couplers_AWVALID(0),
      S_AXI_bready => xbar_to_m00_couplers_BREADY(0),
      S_AXI_bresp(1 downto 0) => xbar_to_m00_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m00_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m00_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m00_couplers_RREADY(0),
      S_AXI_rresp(1 downto 0) => xbar_to_m00_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m00_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m00_couplers_WDATA(31 downto 0),
      S_AXI_wready => xbar_to_m00_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m00_couplers_WSTRB(3 downto 0),
      S_AXI_wvalid => xbar_to_m00_couplers_WVALID(0)
    );
m01_couplers: entity work.m01_couplers_imp_GLRYYY
     port map (
      M_ACLK => M01_ACLK_1,
      M_ARESETN => M01_ARESETN_1,
      M_AXI_araddr(12 downto 0) => m01_couplers_to_axi_interc_ARADDR(12 downto 0),
      M_AXI_arready => m01_couplers_to_axi_interc_ARREADY,
      M_AXI_arvalid => m01_couplers_to_axi_interc_ARVALID,
      M_AXI_awaddr(12 downto 0) => m01_couplers_to_axi_interc_AWADDR(12 downto 0),
      M_AXI_awready => m01_couplers_to_axi_interc_AWREADY,
      M_AXI_awvalid => m01_couplers_to_axi_interc_AWVALID,
      M_AXI_bready => m01_couplers_to_axi_interc_BREADY,
      M_AXI_bresp(1 downto 0) => m01_couplers_to_axi_interc_BRESP(1 downto 0),
      M_AXI_bvalid => m01_couplers_to_axi_interc_BVALID,
      M_AXI_rdata(31 downto 0) => m01_couplers_to_axi_interc_RDATA(31 downto 0),
      M_AXI_rready => m01_couplers_to_axi_interc_RREADY,
      M_AXI_rresp(1 downto 0) => m01_couplers_to_axi_interc_RRESP(1 downto 0),
      M_AXI_rvalid => m01_couplers_to_axi_interc_RVALID,
      M_AXI_wdata(31 downto 0) => m01_couplers_to_axi_interc_WDATA(31 downto 0),
      M_AXI_wready => m01_couplers_to_axi_interc_WREADY,
      M_AXI_wstrb(3 downto 0) => m01_couplers_to_axi_interc_WSTRB(3 downto 0),
      M_AXI_wvalid => m01_couplers_to_axi_interc_WVALID,
      S_ACLK => axi_interc_ACLK_net,
      S_ARESETN => axi_interc_ARESETN_net,
      S_AXI_araddr(25 downto 0) => xbar_to_m01_couplers_ARADDR(51 downto 26),
      S_AXI_arprot(2 downto 0) => xbar_to_m01_couplers_ARPROT(5 downto 3),
      S_AXI_arready => xbar_to_m01_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m01_couplers_ARVALID(1),
      S_AXI_awaddr(25 downto 0) => xbar_to_m01_couplers_AWADDR(51 downto 26),
      S_AXI_awprot(2 downto 0) => xbar_to_m01_couplers_AWPROT(5 downto 3),
      S_AXI_awready => xbar_to_m01_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m01_couplers_AWVALID(1),
      S_AXI_bready => xbar_to_m01_couplers_BREADY(1),
      S_AXI_bresp(1 downto 0) => xbar_to_m01_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m01_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m01_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m01_couplers_RREADY(1),
      S_AXI_rresp(1 downto 0) => xbar_to_m01_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m01_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m01_couplers_WDATA(63 downto 32),
      S_AXI_wready => xbar_to_m01_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m01_couplers_WSTRB(7 downto 4),
      S_AXI_wvalid => xbar_to_m01_couplers_WVALID(1)
    );
s00_couplers: entity work.s00_couplers_imp_JZBK90
     port map (
      M_ACLK => axi_interc_ACLK_net,
      M_ARESETN => axi_interc_ARESETN_net,
      M_AXI_araddr(25 downto 0) => s00_couplers_to_xbar_ARADDR(25 downto 0),
      M_AXI_arprot(2 downto 0) => s00_couplers_to_xbar_ARPROT(2 downto 0),
      M_AXI_arready => s00_couplers_to_xbar_ARREADY(0),
      M_AXI_arvalid => s00_couplers_to_xbar_ARVALID,
      M_AXI_awaddr(25 downto 0) => s00_couplers_to_xbar_AWADDR(25 downto 0),
      M_AXI_awprot(2 downto 0) => s00_couplers_to_xbar_AWPROT(2 downto 0),
      M_AXI_awready => s00_couplers_to_xbar_AWREADY(0),
      M_AXI_awvalid => s00_couplers_to_xbar_AWVALID,
      M_AXI_bready => s00_couplers_to_xbar_BREADY,
      M_AXI_bresp(1 downto 0) => s00_couplers_to_xbar_BRESP(1 downto 0),
      M_AXI_bvalid => s00_couplers_to_xbar_BVALID(0),
      M_AXI_rdata(31 downto 0) => s00_couplers_to_xbar_RDATA(31 downto 0),
      M_AXI_rready => s00_couplers_to_xbar_RREADY,
      M_AXI_rresp(1 downto 0) => s00_couplers_to_xbar_RRESP(1 downto 0),
      M_AXI_rvalid => s00_couplers_to_xbar_RVALID(0),
      M_AXI_wdata(31 downto 0) => s00_couplers_to_xbar_WDATA(31 downto 0),
      M_AXI_wready => s00_couplers_to_xbar_WREADY(0),
      M_AXI_wstrb(3 downto 0) => s00_couplers_to_xbar_WSTRB(3 downto 0),
      M_AXI_wvalid => s00_couplers_to_xbar_WVALID,
      S_ACLK => S00_ACLK_1,
      S_ARESETN => S00_ARESETN_1,
      S_AXI_araddr(25 downto 0) => axi_interc_to_s00_couplers_ARADDR(25 downto 0),
      S_AXI_arprot(2 downto 0) => axi_interc_to_s00_couplers_ARPROT(2 downto 0),
      S_AXI_arready => axi_interc_to_s00_couplers_ARREADY,
      S_AXI_arvalid => axi_interc_to_s00_couplers_ARVALID,
      S_AXI_awaddr(25 downto 0) => axi_interc_to_s00_couplers_AWADDR(25 downto 0),
      S_AXI_awprot(2 downto 0) => axi_interc_to_s00_couplers_AWPROT(2 downto 0),
      S_AXI_awready => axi_interc_to_s00_couplers_AWREADY,
      S_AXI_awvalid => axi_interc_to_s00_couplers_AWVALID,
      S_AXI_bready => axi_interc_to_s00_couplers_BREADY,
      S_AXI_bresp(1 downto 0) => axi_interc_to_s00_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => axi_interc_to_s00_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => axi_interc_to_s00_couplers_RDATA(31 downto 0),
      S_AXI_rready => axi_interc_to_s00_couplers_RREADY,
      S_AXI_rresp(1 downto 0) => axi_interc_to_s00_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => axi_interc_to_s00_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => axi_interc_to_s00_couplers_WDATA(31 downto 0),
      S_AXI_wready => axi_interc_to_s00_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => axi_interc_to_s00_couplers_WSTRB(3 downto 0),
      S_AXI_wvalid => axi_interc_to_s00_couplers_WVALID
    );
xbar: component user_block2_xbar_0
     port map (
      aclk => axi_interc_ACLK_net,
      aresetn => axi_interc_ARESETN_net,
      m_axi_araddr(51 downto 26) => xbar_to_m01_couplers_ARADDR(51 downto 26),
      m_axi_araddr(25 downto 0) => xbar_to_m00_couplers_ARADDR(25 downto 0),
      m_axi_arprot(5 downto 3) => xbar_to_m01_couplers_ARPROT(5 downto 3),
      m_axi_arprot(2 downto 0) => xbar_to_m00_couplers_ARPROT(2 downto 0),
      m_axi_arready(1) => xbar_to_m01_couplers_ARREADY,
      m_axi_arready(0) => xbar_to_m00_couplers_ARREADY,
      m_axi_arvalid(1) => xbar_to_m01_couplers_ARVALID(1),
      m_axi_arvalid(0) => xbar_to_m00_couplers_ARVALID(0),
      m_axi_awaddr(51 downto 26) => xbar_to_m01_couplers_AWADDR(51 downto 26),
      m_axi_awaddr(25 downto 0) => xbar_to_m00_couplers_AWADDR(25 downto 0),
      m_axi_awprot(5 downto 3) => xbar_to_m01_couplers_AWPROT(5 downto 3),
      m_axi_awprot(2 downto 0) => xbar_to_m00_couplers_AWPROT(2 downto 0),
      m_axi_awready(1) => xbar_to_m01_couplers_AWREADY,
      m_axi_awready(0) => xbar_to_m00_couplers_AWREADY,
      m_axi_awvalid(1) => xbar_to_m01_couplers_AWVALID(1),
      m_axi_awvalid(0) => xbar_to_m00_couplers_AWVALID(0),
      m_axi_bready(1) => xbar_to_m01_couplers_BREADY(1),
      m_axi_bready(0) => xbar_to_m00_couplers_BREADY(0),
      m_axi_bresp(3 downto 2) => xbar_to_m01_couplers_BRESP(1 downto 0),
      m_axi_bresp(1 downto 0) => xbar_to_m00_couplers_BRESP(1 downto 0),
      m_axi_bvalid(1) => xbar_to_m01_couplers_BVALID,
      m_axi_bvalid(0) => xbar_to_m00_couplers_BVALID,
      m_axi_rdata(63 downto 32) => xbar_to_m01_couplers_RDATA(31 downto 0),
      m_axi_rdata(31 downto 0) => xbar_to_m00_couplers_RDATA(31 downto 0),
      m_axi_rready(1) => xbar_to_m01_couplers_RREADY(1),
      m_axi_rready(0) => xbar_to_m00_couplers_RREADY(0),
      m_axi_rresp(3 downto 2) => xbar_to_m01_couplers_RRESP(1 downto 0),
      m_axi_rresp(1 downto 0) => xbar_to_m00_couplers_RRESP(1 downto 0),
      m_axi_rvalid(1) => xbar_to_m01_couplers_RVALID,
      m_axi_rvalid(0) => xbar_to_m00_couplers_RVALID,
      m_axi_wdata(63 downto 32) => xbar_to_m01_couplers_WDATA(63 downto 32),
      m_axi_wdata(31 downto 0) => xbar_to_m00_couplers_WDATA(31 downto 0),
      m_axi_wready(1) => xbar_to_m01_couplers_WREADY,
      m_axi_wready(0) => xbar_to_m00_couplers_WREADY,
      m_axi_wstrb(7 downto 4) => xbar_to_m01_couplers_WSTRB(7 downto 4),
      m_axi_wstrb(3 downto 0) => xbar_to_m00_couplers_WSTRB(3 downto 0),
      m_axi_wvalid(1) => xbar_to_m01_couplers_WVALID(1),
      m_axi_wvalid(0) => xbar_to_m00_couplers_WVALID(0),
      s_axi_araddr(25 downto 0) => s00_couplers_to_xbar_ARADDR(25 downto 0),
      s_axi_arprot(2 downto 0) => s00_couplers_to_xbar_ARPROT(2 downto 0),
      s_axi_arready(0) => s00_couplers_to_xbar_ARREADY(0),
      s_axi_arvalid(0) => s00_couplers_to_xbar_ARVALID,
      s_axi_awaddr(25 downto 0) => s00_couplers_to_xbar_AWADDR(25 downto 0),
      s_axi_awprot(2 downto 0) => s00_couplers_to_xbar_AWPROT(2 downto 0),
      s_axi_awready(0) => s00_couplers_to_xbar_AWREADY(0),
      s_axi_awvalid(0) => s00_couplers_to_xbar_AWVALID,
      s_axi_bready(0) => s00_couplers_to_xbar_BREADY,
      s_axi_bresp(1 downto 0) => s00_couplers_to_xbar_BRESP(1 downto 0),
      s_axi_bvalid(0) => s00_couplers_to_xbar_BVALID(0),
      s_axi_rdata(31 downto 0) => s00_couplers_to_xbar_RDATA(31 downto 0),
      s_axi_rready(0) => s00_couplers_to_xbar_RREADY,
      s_axi_rresp(1 downto 0) => s00_couplers_to_xbar_RRESP(1 downto 0),
      s_axi_rvalid(0) => s00_couplers_to_xbar_RVALID(0),
      s_axi_wdata(31 downto 0) => s00_couplers_to_xbar_WDATA(31 downto 0),
      s_axi_wready(0) => s00_couplers_to_xbar_WREADY(0),
      s_axi_wstrb(3 downto 0) => s00_couplers_to_xbar_WSTRB(3 downto 0),
      s_axi_wvalid(0) => s00_couplers_to_xbar_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity csr_imp_1W4S3O8 is
  port (
    adc_aresetn : out STD_LOGIC;
    adc_csr_araddr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    adc_csr_arready : in STD_LOGIC;
    adc_csr_arvalid : out STD_LOGIC;
    adc_csr_awaddr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    adc_csr_awready : in STD_LOGIC;
    adc_csr_awvalid : out STD_LOGIC;
    adc_csr_bready : out STD_LOGIC;
    adc_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    adc_csr_bvalid : in STD_LOGIC;
    adc_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    adc_csr_rready : out STD_LOGIC;
    adc_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    adc_csr_rvalid : in STD_LOGIC;
    adc_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    adc_csr_wready : in STD_LOGIC;
    adc_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    adc_csr_wvalid : out STD_LOGIC;
    controller_PPS : out STD_LOGIC;
    ctl2_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    i_controller_PPS : in STD_LOGIC;
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
    s_axis_adc_pdti_aclk : in STD_LOGIC;
    s_axis_adc_pdti_aresetn : in STD_LOGIC
  );
end csr_imp_1W4S3O8;

architecture STRUCTURE of csr_imp_1W4S3O8 is
  component user_block2_px_axil_csr_0_0 is
  port (
    s_axi_csr_aclk : in STD_LOGIC;
    s_axi_csr_aresetn : in STD_LOGIC;
    s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_awvalid : in STD_LOGIC;
    s_axi_csr_awready : out STD_LOGIC;
    s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_csr_wvalid : in STD_LOGIC;
    s_axi_csr_wready : out STD_LOGIC;
    s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_bvalid : out STD_LOGIC;
    s_axi_csr_bready : in STD_LOGIC;
    s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_arvalid : in STD_LOGIC;
    s_axi_csr_arready : out STD_LOGIC;
    s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_rvalid : out STD_LOGIC;
    s_axi_csr_rready : in STD_LOGIC;
    reg0_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg1_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg2_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl0_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl1_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl2_out : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component user_block2_px_axil_csr_0_0;
  component user_block2_xlconstant_0_1 is
  port (
    dout : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component user_block2_xlconstant_0_1;
  component user_block2_px_vctr2scalar_0_0 is
  port (
    input_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    output_scalar : out STD_LOGIC
  );
  end component user_block2_px_vctr2scalar_0_0;
  component user_block2_xlslice_0_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component user_block2_xlslice_0_0;
  component user_block2_xlslice_0_1 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component user_block2_xlslice_0_1;
  component user_block2_px_vctr2scalar_0_1 is
  port (
    input_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    output_scalar : out STD_LOGIC
  );
  end component user_block2_px_vctr2scalar_0_1;
  component user_block2_util_vector_logic_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Op2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component user_block2_util_vector_logic_0_0;
  signal aresetn_1 : STD_LOGIC;
  signal axi_interc_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal axi_interc_M00_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_interc_M00_AXI_ARREADY : STD_LOGIC;
  signal axi_interc_M00_AXI_ARVALID : STD_LOGIC;
  signal axi_interc_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal axi_interc_M00_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_interc_M00_AXI_AWREADY : STD_LOGIC;
  signal axi_interc_M00_AXI_AWVALID : STD_LOGIC;
  signal axi_interc_M00_AXI_BREADY : STD_LOGIC;
  signal axi_interc_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_interc_M00_AXI_BVALID : STD_LOGIC;
  signal axi_interc_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_interc_M00_AXI_RREADY : STD_LOGIC;
  signal axi_interc_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_interc_M00_AXI_RVALID : STD_LOGIC;
  signal axi_interc_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_interc_M00_AXI_WREADY : STD_LOGIC;
  signal axi_interc_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_interc_M00_AXI_WVALID : STD_LOGIC;
  signal axi_interc_M01_AXI_ARADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal axi_interc_M01_AXI_ARREADY : STD_LOGIC;
  signal axi_interc_M01_AXI_ARVALID : STD_LOGIC;
  signal axi_interc_M01_AXI_AWADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal axi_interc_M01_AXI_AWREADY : STD_LOGIC;
  signal axi_interc_M01_AXI_AWVALID : STD_LOGIC;
  signal axi_interc_M01_AXI_BREADY : STD_LOGIC;
  signal axi_interc_M01_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_interc_M01_AXI_BVALID : STD_LOGIC;
  signal axi_interc_M01_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_interc_M01_AXI_RREADY : STD_LOGIC;
  signal axi_interc_M01_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_interc_M01_AXI_RVALID : STD_LOGIC;
  signal axi_interc_M01_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_interc_M01_AXI_WREADY : STD_LOGIC;
  signal axi_interc_M01_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_interc_M01_AXI_WVALID : STD_LOGIC;
  signal general_purpose_reg_0_ctl1_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal general_purpose_reg_0_ctl2_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal i_controller_PPS_1 : STD_LOGIC;
  signal px_vctr2scalar_1_output_scalar : STD_LOGIC;
  signal reset_reg_0_ctl0_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axi_csr_1_ARADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal s_axi_csr_1_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s_axi_csr_1_ARREADY : STD_LOGIC;
  signal s_axi_csr_1_ARVALID : STD_LOGIC;
  signal s_axi_csr_1_AWADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal s_axi_csr_1_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s_axi_csr_1_AWREADY : STD_LOGIC;
  signal s_axi_csr_1_AWVALID : STD_LOGIC;
  signal s_axi_csr_1_BREADY : STD_LOGIC;
  signal s_axi_csr_1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s_axi_csr_1_BVALID : STD_LOGIC;
  signal s_axi_csr_1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axi_csr_1_RREADY : STD_LOGIC;
  signal s_axi_csr_1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s_axi_csr_1_RVALID : STD_LOGIC;
  signal s_axi_csr_1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axi_csr_1_WREADY : STD_LOGIC;
  signal s_axi_csr_1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s_axi_csr_1_WVALID : STD_LOGIC;
  signal s_axi_csr_aclk_1 : STD_LOGIC;
  signal s_axi_csr_aresetn_1 : STD_LOGIC;
  signal s_axis_adc_pdti_aclk_1 : STD_LOGIC;
  signal s_axis_adc_pdti_aresetn_1 : STD_LOGIC;
  signal util_vector_logic_0_Res : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xlconstant_0_dout_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xlslice_0_Dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xlslice_1_Dout : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  adc_aresetn <= aresetn_1;
  adc_csr_araddr(12 downto 0) <= axi_interc_M01_AXI_ARADDR(12 downto 0);
  adc_csr_arvalid <= axi_interc_M01_AXI_ARVALID;
  adc_csr_awaddr(12 downto 0) <= axi_interc_M01_AXI_AWADDR(12 downto 0);
  adc_csr_awvalid <= axi_interc_M01_AXI_AWVALID;
  adc_csr_bready <= axi_interc_M01_AXI_BREADY;
  adc_csr_rready <= axi_interc_M01_AXI_RREADY;
  adc_csr_wdata(31 downto 0) <= axi_interc_M01_AXI_WDATA(31 downto 0);
  adc_csr_wstrb(3 downto 0) <= axi_interc_M01_AXI_WSTRB(3 downto 0);
  adc_csr_wvalid <= axi_interc_M01_AXI_WVALID;
  axi_interc_M01_AXI_ARREADY <= adc_csr_arready;
  axi_interc_M01_AXI_AWREADY <= adc_csr_awready;
  axi_interc_M01_AXI_BRESP(1 downto 0) <= adc_csr_bresp(1 downto 0);
  axi_interc_M01_AXI_BVALID <= adc_csr_bvalid;
  axi_interc_M01_AXI_RDATA(31 downto 0) <= adc_csr_rdata(31 downto 0);
  axi_interc_M01_AXI_RRESP(1 downto 0) <= adc_csr_rresp(1 downto 0);
  axi_interc_M01_AXI_RVALID <= adc_csr_rvalid;
  axi_interc_M01_AXI_WREADY <= adc_csr_wready;
  controller_PPS <= px_vctr2scalar_1_output_scalar;
  ctl2_out(31 downto 0) <= general_purpose_reg_0_ctl2_out(31 downto 0);
  i_controller_PPS_1 <= i_controller_PPS;
  s_axi_csr_1_ARADDR(25 downto 0) <= s_axi_csr_araddr(25 downto 0);
  s_axi_csr_1_ARPROT(2 downto 0) <= s_axi_csr_arprot(2 downto 0);
  s_axi_csr_1_ARVALID <= s_axi_csr_arvalid;
  s_axi_csr_1_AWADDR(25 downto 0) <= s_axi_csr_awaddr(25 downto 0);
  s_axi_csr_1_AWPROT(2 downto 0) <= s_axi_csr_awprot(2 downto 0);
  s_axi_csr_1_AWVALID <= s_axi_csr_awvalid;
  s_axi_csr_1_BREADY <= s_axi_csr_bready;
  s_axi_csr_1_RREADY <= s_axi_csr_rready;
  s_axi_csr_1_WDATA(31 downto 0) <= s_axi_csr_wdata(31 downto 0);
  s_axi_csr_1_WSTRB(3 downto 0) <= s_axi_csr_wstrb(3 downto 0);
  s_axi_csr_1_WVALID <= s_axi_csr_wvalid;
  s_axi_csr_aclk_1 <= s_axi_csr_aclk;
  s_axi_csr_aresetn_1 <= s_axi_csr_aresetn;
  s_axi_csr_arready <= s_axi_csr_1_ARREADY;
  s_axi_csr_awready <= s_axi_csr_1_AWREADY;
  s_axi_csr_bresp(1 downto 0) <= s_axi_csr_1_BRESP(1 downto 0);
  s_axi_csr_bvalid <= s_axi_csr_1_BVALID;
  s_axi_csr_rdata(31 downto 0) <= s_axi_csr_1_RDATA(31 downto 0);
  s_axi_csr_rresp(1 downto 0) <= s_axi_csr_1_RRESP(1 downto 0);
  s_axi_csr_rvalid <= s_axi_csr_1_RVALID;
  s_axi_csr_wready <= s_axi_csr_1_WREADY;
  s_axis_adc_pdti_aclk_1 <= s_axis_adc_pdti_aclk;
  s_axis_adc_pdti_aresetn_1 <= s_axis_adc_pdti_aresetn;
axi_interc: entity work.user_block2_axi_interc_0
     port map (
      ACLK => s_axi_csr_aclk_1,
      ARESETN => s_axi_csr_aresetn_1,
      M00_ACLK => s_axis_adc_pdti_aclk_1,
      M00_ARESETN => s_axis_adc_pdti_aresetn_1,
      M00_AXI_araddr(6 downto 0) => axi_interc_M00_AXI_ARADDR(6 downto 0),
      M00_AXI_arprot(2 downto 0) => axi_interc_M00_AXI_ARPROT(2 downto 0),
      M00_AXI_arready => axi_interc_M00_AXI_ARREADY,
      M00_AXI_arvalid => axi_interc_M00_AXI_ARVALID,
      M00_AXI_awaddr(6 downto 0) => axi_interc_M00_AXI_AWADDR(6 downto 0),
      M00_AXI_awprot(2 downto 0) => axi_interc_M00_AXI_AWPROT(2 downto 0),
      M00_AXI_awready => axi_interc_M00_AXI_AWREADY,
      M00_AXI_awvalid => axi_interc_M00_AXI_AWVALID,
      M00_AXI_bready => axi_interc_M00_AXI_BREADY,
      M00_AXI_bresp(1 downto 0) => axi_interc_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid => axi_interc_M00_AXI_BVALID,
      M00_AXI_rdata(31 downto 0) => axi_interc_M00_AXI_RDATA(31 downto 0),
      M00_AXI_rready => axi_interc_M00_AXI_RREADY,
      M00_AXI_rresp(1 downto 0) => axi_interc_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid => axi_interc_M00_AXI_RVALID,
      M00_AXI_wdata(31 downto 0) => axi_interc_M00_AXI_WDATA(31 downto 0),
      M00_AXI_wready => axi_interc_M00_AXI_WREADY,
      M00_AXI_wstrb(3 downto 0) => axi_interc_M00_AXI_WSTRB(3 downto 0),
      M00_AXI_wvalid => axi_interc_M00_AXI_WVALID,
      M01_ACLK => s_axis_adc_pdti_aclk_1,
      M01_ARESETN => s_axis_adc_pdti_aresetn_1,
      M01_AXI_araddr(12 downto 0) => axi_interc_M01_AXI_ARADDR(12 downto 0),
      M01_AXI_arready => axi_interc_M01_AXI_ARREADY,
      M01_AXI_arvalid => axi_interc_M01_AXI_ARVALID,
      M01_AXI_awaddr(12 downto 0) => axi_interc_M01_AXI_AWADDR(12 downto 0),
      M01_AXI_awready => axi_interc_M01_AXI_AWREADY,
      M01_AXI_awvalid => axi_interc_M01_AXI_AWVALID,
      M01_AXI_bready => axi_interc_M01_AXI_BREADY,
      M01_AXI_bresp(1 downto 0) => axi_interc_M01_AXI_BRESP(1 downto 0),
      M01_AXI_bvalid => axi_interc_M01_AXI_BVALID,
      M01_AXI_rdata(31 downto 0) => axi_interc_M01_AXI_RDATA(31 downto 0),
      M01_AXI_rready => axi_interc_M01_AXI_RREADY,
      M01_AXI_rresp(1 downto 0) => axi_interc_M01_AXI_RRESP(1 downto 0),
      M01_AXI_rvalid => axi_interc_M01_AXI_RVALID,
      M01_AXI_wdata(31 downto 0) => axi_interc_M01_AXI_WDATA(31 downto 0),
      M01_AXI_wready => axi_interc_M01_AXI_WREADY,
      M01_AXI_wstrb(3 downto 0) => axi_interc_M01_AXI_WSTRB(3 downto 0),
      M01_AXI_wvalid => axi_interc_M01_AXI_WVALID,
      S00_ACLK => s_axi_csr_aclk_1,
      S00_ARESETN => s_axi_csr_aresetn_1,
      S00_AXI_araddr(25 downto 0) => s_axi_csr_1_ARADDR(25 downto 0),
      S00_AXI_arprot(2 downto 0) => s_axi_csr_1_ARPROT(2 downto 0),
      S00_AXI_arready => s_axi_csr_1_ARREADY,
      S00_AXI_arvalid => s_axi_csr_1_ARVALID,
      S00_AXI_awaddr(25 downto 0) => s_axi_csr_1_AWADDR(25 downto 0),
      S00_AXI_awprot(2 downto 0) => s_axi_csr_1_AWPROT(2 downto 0),
      S00_AXI_awready => s_axi_csr_1_AWREADY,
      S00_AXI_awvalid => s_axi_csr_1_AWVALID,
      S00_AXI_bready => s_axi_csr_1_BREADY,
      S00_AXI_bresp(1 downto 0) => s_axi_csr_1_BRESP(1 downto 0),
      S00_AXI_bvalid => s_axi_csr_1_BVALID,
      S00_AXI_rdata(31 downto 0) => s_axi_csr_1_RDATA(31 downto 0),
      S00_AXI_rready => s_axi_csr_1_RREADY,
      S00_AXI_rresp(1 downto 0) => s_axi_csr_1_RRESP(1 downto 0),
      S00_AXI_rvalid => s_axi_csr_1_RVALID,
      S00_AXI_wdata(31 downto 0) => s_axi_csr_1_WDATA(31 downto 0),
      S00_AXI_wready => s_axi_csr_1_WREADY,
      S00_AXI_wstrb(3 downto 0) => s_axi_csr_1_WSTRB(3 downto 0),
      S00_AXI_wvalid => s_axi_csr_1_WVALID
    );
general_purpose_reg_0: component user_block2_px_axil_csr_0_0
     port map (
      ctl0_out(31 downto 0) => reset_reg_0_ctl0_out(31 downto 0),
      ctl1_out(31 downto 0) => general_purpose_reg_0_ctl1_out(31 downto 0),
      ctl2_out(31 downto 0) => general_purpose_reg_0_ctl2_out(31 downto 0),
      reg0_init_val(31 downto 0) => xlconstant_0_dout_1(31 downto 0),
      reg1_init_val(31 downto 0) => xlconstant_0_dout_1(31 downto 0),
      reg2_init_val(31 downto 0) => xlconstant_0_dout_1(31 downto 0),
      s_axi_csr_aclk => s_axis_adc_pdti_aclk_1,
      s_axi_csr_araddr(6 downto 0) => axi_interc_M00_AXI_ARADDR(6 downto 0),
      s_axi_csr_aresetn => s_axis_adc_pdti_aresetn_1,
      s_axi_csr_arprot(2 downto 0) => axi_interc_M00_AXI_ARPROT(2 downto 0),
      s_axi_csr_arready => axi_interc_M00_AXI_ARREADY,
      s_axi_csr_arvalid => axi_interc_M00_AXI_ARVALID,
      s_axi_csr_awaddr(6 downto 0) => axi_interc_M00_AXI_AWADDR(6 downto 0),
      s_axi_csr_awprot(2 downto 0) => axi_interc_M00_AXI_AWPROT(2 downto 0),
      s_axi_csr_awready => axi_interc_M00_AXI_AWREADY,
      s_axi_csr_awvalid => axi_interc_M00_AXI_AWVALID,
      s_axi_csr_bready => axi_interc_M00_AXI_BREADY,
      s_axi_csr_bresp(1 downto 0) => axi_interc_M00_AXI_BRESP(1 downto 0),
      s_axi_csr_bvalid => axi_interc_M00_AXI_BVALID,
      s_axi_csr_rdata(31 downto 0) => axi_interc_M00_AXI_RDATA(31 downto 0),
      s_axi_csr_rready => axi_interc_M00_AXI_RREADY,
      s_axi_csr_rresp(1 downto 0) => axi_interc_M00_AXI_RRESP(1 downto 0),
      s_axi_csr_rvalid => axi_interc_M00_AXI_RVALID,
      s_axi_csr_wdata(31 downto 0) => axi_interc_M00_AXI_WDATA(31 downto 0),
      s_axi_csr_wready => axi_interc_M00_AXI_WREADY,
      s_axi_csr_wstrb(3 downto 0) => axi_interc_M00_AXI_WSTRB(3 downto 0),
      s_axi_csr_wvalid => axi_interc_M00_AXI_WVALID
    );
px_vctr2scalar_0: component user_block2_px_vctr2scalar_0_0
     port map (
      input_vector(0) => xlslice_0_Dout(0),
      output_scalar => aresetn_1
    );
px_vctr2scalar_1: component user_block2_px_vctr2scalar_0_1
     port map (
      input_vector(0) => util_vector_logic_0_Res(0),
      output_scalar => px_vctr2scalar_1_output_scalar
    );
util_vector_logic_0: component user_block2_util_vector_logic_0_0
     port map (
      Op1(0) => xlslice_1_Dout(0),
      Op2(0) => i_controller_PPS_1,
      Res(0) => util_vector_logic_0_Res(0)
    );
xlconstant_0: component user_block2_xlconstant_0_1
     port map (
      dout(31 downto 0) => xlconstant_0_dout_1(31 downto 0)
    );
xlslice_0: component user_block2_xlslice_0_0
     port map (
      Din(31 downto 0) => reset_reg_0_ctl0_out(31 downto 0),
      Dout(0) => xlslice_0_Dout(0)
    );
xlslice_1: component user_block2_xlslice_0_1
     port map (
      Din(31 downto 0) => general_purpose_reg_0_ctl1_out(31 downto 0),
      Dout(0) => xlslice_1_Dout(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2 is
  port (
    AZ_MOSI : in STD_LOGIC;
    AZ_SCK : in STD_LOGIC;
    AZ_SSEL : in STD_LOGIC;
    EL_MOSI : in STD_LOGIC;
    EL_SCK : in STD_LOGIC;
    EL_SSEL : in STD_LOGIC;
    ROT_A : in STD_LOGIC;
    ROT_B : in STD_LOGIC;
    TILT_A : in STD_LOGIC;
    TILT_B : in STD_LOGIC;
    control_flags : out STD_LOGIC_VECTOR ( 31 downto 0 );
    controller_PPS : in STD_LOGIC;
    filter_select_ch0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    filter_select_ch1 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    filter_select_ch2 : out STD_LOGIC_VECTOR ( 1 downto 0 );
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
    mt_pulse : out STD_LOGIC_VECTOR ( 7 downto 0 );
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
    s_axis_adc_ch0_pdti_tready : out STD_LOGIC;
    s_axis_adc_ch0_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_adc_ch0_pdti_tvalid : in STD_LOGIC;
    s_axis_adc_ch1_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_adc_ch1_pdti_tready : out STD_LOGIC;
    s_axis_adc_ch1_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_adc_ch1_pdti_tvalid : in STD_LOGIC;
    s_axis_adc_ch2_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_adc_ch2_pdti_tready : out STD_LOGIC;
    s_axis_adc_ch2_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_adc_ch2_pdti_tvalid : in STD_LOGIC;
    s_axis_adc_pdti_aclk : in STD_LOGIC;
    s_axis_adc_pdti_aresetn : in STD_LOGIC;
    s_axis_dac_pdti_aclk : in STD_LOGIC;
    s_axis_dac_pdti_aresetn : in STD_LOGIC;
    s_axis_dac_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_dac_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_dac_pdti_tvalid : in STD_LOGIC;
    status_flags : in STD_LOGIC_VECTOR ( 15 downto 0 );
    user2_irq : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of user_block2 : entity is "user_block2,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=user_block2,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=59,numReposBlks=47,numNonXlnxBlks=10,numHierBlks=12,maxHierDepth=2,numSysgenBlks=0,numHlsBlks=4,numHdlrefBlks=3,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of user_block2 : entity is "user_block2.hwdef";
end user_block2;

architecture STRUCTURE of user_block2 is
  component user_block2_irq_placeholder_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component user_block2_irq_placeholder_0;
  component user_block2_position_encoder_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    ctl_reg : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ROT_A : in STD_LOGIC;
    ROT_B : in STD_LOGIC;
    TILT_A : in STD_LOGIC;
    TILT_B : in STD_LOGIC;
    AZ_MOSI : in STD_LOGIC;
    AZ_SCK : in STD_LOGIC;
    AZ_SSEL : in STD_LOGIC;
    EL_MOSI : in STD_LOGIC;
    EL_SCK : in STD_LOGIC;
    EL_SSEL : in STD_LOGIC;
    pos_enc_0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pos_enc_1 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component user_block2_position_encoder_0_0;
  component user_block2_axis_register_slice_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  end component user_block2_axis_register_slice_0_0;
  signal AZ_MOSI_1 : STD_LOGIC;
  signal AZ_SCK_1 : STD_LOGIC;
  signal AZ_SSEL_1 : STD_LOGIC;
  signal EL_MOSI_1 : STD_LOGIC;
  signal EL_SCK_1 : STD_LOGIC;
  signal EL_SSEL_1 : STD_LOGIC;
  signal ROT_A_1 : STD_LOGIC;
  signal ROT_B_1 : STD_LOGIC;
  signal TILT_A_1 : STD_LOGIC;
  signal TILT_B_1 : STD_LOGIC;
  signal adc_aresetn : STD_LOGIC;
  signal axi_interc_M01_AXI_ARADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal axi_interc_M01_AXI_ARREADY : STD_LOGIC;
  signal axi_interc_M01_AXI_ARVALID : STD_LOGIC;
  signal axi_interc_M01_AXI_AWADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal axi_interc_M01_AXI_AWREADY : STD_LOGIC;
  signal axi_interc_M01_AXI_AWVALID : STD_LOGIC;
  signal axi_interc_M01_AXI_BREADY : STD_LOGIC;
  signal axi_interc_M01_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_interc_M01_AXI_BVALID : STD_LOGIC;
  signal axi_interc_M01_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_interc_M01_AXI_RREADY : STD_LOGIC;
  signal axi_interc_M01_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_interc_M01_AXI_RVALID : STD_LOGIC;
  signal axi_interc_M01_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_interc_M01_AXI_WREADY : STD_LOGIC;
  signal axi_interc_M01_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_interc_M01_AXI_WVALID : STD_LOGIC;
  signal axis_register_slice_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axis_register_slice_0_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_register_slice_0_M_AXIS_TVALID : STD_LOGIC;
  signal coef_1_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal coef_1_TREADY : STD_LOGIC;
  signal coef_1_TVALID : STD_LOGIC;
  signal controller_PPS_1 : STD_LOGIC;
  signal controller_PPS_2 : STD_LOGIC;
  signal csr_ctl2_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal dsp_ch1_out_pdti_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal dsp_ch1_out_pdti_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal dsp_ch1_out_pdti_TVALID : STD_LOGIC;
  signal dsp_ch2_out_pdti_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal dsp_ch2_out_pdti_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal dsp_ch2_out_pdti_TVALID : STD_LOGIC;
  signal hcr_controller_0_coef_ch0_V_V_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal hcr_controller_0_coef_ch0_V_V_TREADY : STD_LOGIC;
  signal hcr_controller_0_coef_ch0_V_V_TVALID : STD_LOGIC;
  signal hcr_controller_0_coef_ch2_V_V_TDATA : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal hcr_controller_0_coef_ch2_V_V_TREADY : STD_LOGIC;
  signal hcr_controller_0_coef_ch2_V_V_TVALID : STD_LOGIC;
  signal hcr_controller_0_control_flags : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal hcr_controller_0_filter_select_ch0 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal hcr_controller_0_filter_select_ch1 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal hcr_controller_0_filter_select_ch2 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal hcr_controller_0_mt_pulse : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal hcr_controller_0_pulse_metadata_ch0_V_TDATA : STD_LOGIC_VECTOR ( 823 downto 0 );
  signal hcr_controller_0_pulse_metadata_ch0_V_TREADY : STD_LOGIC;
  signal hcr_controller_0_pulse_metadata_ch0_V_TVALID : STD_LOGIC;
  signal hcr_controller_0_pulse_metadata_ch2_V_TDATA : STD_LOGIC_VECTOR ( 823 downto 0 );
  signal hcr_controller_0_pulse_metadata_ch2_V_TREADY : STD_LOGIC;
  signal hcr_controller_0_pulse_metadata_ch2_V_TVALID : STD_LOGIC;
  signal hcr_metadata_injector_0_o_data_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal hcr_metadata_injector_0_o_data_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal hcr_metadata_injector_0_o_data_TVALID : STD_LOGIC;
  signal pos_enc_0_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal pos_enc_1_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal pulse_metadata_1_TDATA : STD_LOGIC_VECTOR ( 823 downto 0 );
  signal pulse_metadata_1_TREADY : STD_LOGIC;
  signal pulse_metadata_1_TVALID : STD_LOGIC;
  signal s_axi_csr_1_ARADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal s_axi_csr_1_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s_axi_csr_1_ARREADY : STD_LOGIC;
  signal s_axi_csr_1_ARVALID : STD_LOGIC;
  signal s_axi_csr_1_AWADDR : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal s_axi_csr_1_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s_axi_csr_1_AWREADY : STD_LOGIC;
  signal s_axi_csr_1_AWVALID : STD_LOGIC;
  signal s_axi_csr_1_BREADY : STD_LOGIC;
  signal s_axi_csr_1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s_axi_csr_1_BVALID : STD_LOGIC;
  signal s_axi_csr_1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axi_csr_1_RREADY : STD_LOGIC;
  signal s_axi_csr_1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s_axi_csr_1_RVALID : STD_LOGIC;
  signal s_axi_csr_1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axi_csr_1_WREADY : STD_LOGIC;
  signal s_axi_csr_1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s_axi_csr_1_WVALID : STD_LOGIC;
  signal s_axi_csr_aclk_1 : STD_LOGIC;
  signal s_axi_csr_aresetn_1 : STD_LOGIC;
  signal s_axis_adc_ch0_pdti_1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_adc_ch0_pdti_1_TREADY : STD_LOGIC;
  signal s_axis_adc_ch0_pdti_1_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal s_axis_adc_ch0_pdti_1_TVALID : STD_LOGIC;
  signal s_axis_adc_ch1_pdti_1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_adc_ch1_pdti_1_TREADY : STD_LOGIC;
  signal s_axis_adc_ch1_pdti_1_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal s_axis_adc_ch1_pdti_1_TVALID : STD_LOGIC;
  signal s_axis_adc_ch2_pdti_1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_adc_ch2_pdti_1_TREADY : STD_LOGIC;
  signal s_axis_adc_ch2_pdti_1_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal s_axis_adc_ch2_pdti_1_TVALID : STD_LOGIC;
  signal s_axis_adc_pdti_aclk_1 : STD_LOGIC;
  signal s_axis_adc_pdti_aresetn_1 : STD_LOGIC;
  signal s_axis_dac_pdti_1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_dac_pdti_1_TUSER : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal s_axis_dac_pdti_1_TVALID : STD_LOGIC;
  signal s_axis_dac_pdti_aclk_1 : STD_LOGIC;
  signal s_axis_dac_pdti_aresetn_1 : STD_LOGIC;
  signal xlconstant_0_dout : STD_LOGIC_VECTOR ( 1 downto 0 );
begin
  AZ_MOSI_1 <= AZ_MOSI;
  AZ_SCK_1 <= AZ_SCK;
  AZ_SSEL_1 <= AZ_SSEL;
  EL_MOSI_1 <= EL_MOSI;
  EL_SCK_1 <= EL_SCK;
  EL_SSEL_1 <= EL_SSEL;
  ROT_A_1 <= ROT_A;
  ROT_B_1 <= ROT_B;
  TILT_A_1 <= TILT_A;
  TILT_B_1 <= TILT_B;
  control_flags(31 downto 0) <= hcr_controller_0_control_flags(31 downto 0);
  controller_PPS_2 <= controller_PPS;
  filter_select_ch0(1 downto 0) <= hcr_controller_0_filter_select_ch0(1 downto 0);
  filter_select_ch1(1 downto 0) <= hcr_controller_0_filter_select_ch1(1 downto 0);
  filter_select_ch2(1 downto 0) <= hcr_controller_0_filter_select_ch2(1 downto 0);
  m_axis_adc_ch0_pdti_tdata(31 downto 0) <= hcr_metadata_injector_0_o_data_TDATA(31 downto 0);
  m_axis_adc_ch0_pdti_tuser(127 downto 0) <= hcr_metadata_injector_0_o_data_TUSER(127 downto 0);
  m_axis_adc_ch0_pdti_tvalid <= hcr_metadata_injector_0_o_data_TVALID;
  m_axis_adc_ch1_pdti_tdata(31 downto 0) <= dsp_ch1_out_pdti_TDATA(31 downto 0);
  m_axis_adc_ch1_pdti_tuser(127 downto 0) <= dsp_ch1_out_pdti_TUSER(127 downto 0);
  m_axis_adc_ch1_pdti_tvalid <= dsp_ch1_out_pdti_TVALID;
  m_axis_adc_ch2_pdti_tdata(31 downto 0) <= dsp_ch2_out_pdti_TDATA(31 downto 0);
  m_axis_adc_ch2_pdti_tuser(127 downto 0) <= dsp_ch2_out_pdti_TUSER(127 downto 0);
  m_axis_adc_ch2_pdti_tvalid <= dsp_ch2_out_pdti_TVALID;
  m_axis_dac_pdti_tdata(31 downto 0) <= axis_register_slice_0_M_AXIS_TDATA(31 downto 0);
  m_axis_dac_pdti_tuser(127 downto 0) <= axis_register_slice_0_M_AXIS_TUSER(127 downto 0);
  m_axis_dac_pdti_tvalid <= axis_register_slice_0_M_AXIS_TVALID;
  mt_pulse(7 downto 0) <= hcr_controller_0_mt_pulse(7 downto 0);
  s_axi_csr_1_ARADDR(25 downto 0) <= s_axi_csr_araddr(25 downto 0);
  s_axi_csr_1_ARPROT(2 downto 0) <= s_axi_csr_arprot(2 downto 0);
  s_axi_csr_1_ARVALID <= s_axi_csr_arvalid;
  s_axi_csr_1_AWADDR(25 downto 0) <= s_axi_csr_awaddr(25 downto 0);
  s_axi_csr_1_AWPROT(2 downto 0) <= s_axi_csr_awprot(2 downto 0);
  s_axi_csr_1_AWVALID <= s_axi_csr_awvalid;
  s_axi_csr_1_BREADY <= s_axi_csr_bready;
  s_axi_csr_1_RREADY <= s_axi_csr_rready;
  s_axi_csr_1_WDATA(31 downto 0) <= s_axi_csr_wdata(31 downto 0);
  s_axi_csr_1_WSTRB(3 downto 0) <= s_axi_csr_wstrb(3 downto 0);
  s_axi_csr_1_WVALID <= s_axi_csr_wvalid;
  s_axi_csr_aclk_1 <= s_axi_csr_aclk;
  s_axi_csr_aresetn_1 <= s_axi_csr_aresetn;
  s_axi_csr_arready <= s_axi_csr_1_ARREADY;
  s_axi_csr_awready <= s_axi_csr_1_AWREADY;
  s_axi_csr_bresp(1 downto 0) <= s_axi_csr_1_BRESP(1 downto 0);
  s_axi_csr_bvalid <= s_axi_csr_1_BVALID;
  s_axi_csr_rdata(31 downto 0) <= s_axi_csr_1_RDATA(31 downto 0);
  s_axi_csr_rresp(1 downto 0) <= s_axi_csr_1_RRESP(1 downto 0);
  s_axi_csr_rvalid <= s_axi_csr_1_RVALID;
  s_axi_csr_wready <= s_axi_csr_1_WREADY;
  s_axis_adc_ch0_pdti_1_TDATA(31 downto 0) <= s_axis_adc_ch0_pdti_tdata(31 downto 0);
  s_axis_adc_ch0_pdti_1_TUSER(127 downto 0) <= s_axis_adc_ch0_pdti_tuser(127 downto 0);
  s_axis_adc_ch0_pdti_1_TVALID <= s_axis_adc_ch0_pdti_tvalid;
  s_axis_adc_ch0_pdti_tready <= s_axis_adc_ch0_pdti_1_TREADY;
  s_axis_adc_ch1_pdti_1_TDATA(31 downto 0) <= s_axis_adc_ch1_pdti_tdata(31 downto 0);
  s_axis_adc_ch1_pdti_1_TUSER(127 downto 0) <= s_axis_adc_ch1_pdti_tuser(127 downto 0);
  s_axis_adc_ch1_pdti_1_TVALID <= s_axis_adc_ch1_pdti_tvalid;
  s_axis_adc_ch1_pdti_tready <= s_axis_adc_ch1_pdti_1_TREADY;
  s_axis_adc_ch2_pdti_1_TDATA(31 downto 0) <= s_axis_adc_ch2_pdti_tdata(31 downto 0);
  s_axis_adc_ch2_pdti_1_TUSER(127 downto 0) <= s_axis_adc_ch2_pdti_tuser(127 downto 0);
  s_axis_adc_ch2_pdti_1_TVALID <= s_axis_adc_ch2_pdti_tvalid;
  s_axis_adc_ch2_pdti_tready <= s_axis_adc_ch2_pdti_1_TREADY;
  s_axis_adc_pdti_aclk_1 <= s_axis_adc_pdti_aclk;
  s_axis_adc_pdti_aresetn_1 <= s_axis_adc_pdti_aresetn;
  s_axis_dac_pdti_1_TDATA(31 downto 0) <= s_axis_dac_pdti_tdata(31 downto 0);
  s_axis_dac_pdti_1_TUSER(127 downto 0) <= s_axis_dac_pdti_tuser(127 downto 0);
  s_axis_dac_pdti_1_TVALID <= s_axis_dac_pdti_tvalid;
  s_axis_dac_pdti_aclk_1 <= s_axis_dac_pdti_aclk;
  s_axis_dac_pdti_aresetn_1 <= s_axis_dac_pdti_aresetn;
  user2_irq(1 downto 0) <= xlconstant_0_dout(1 downto 0);
axis_register_slice_0: component user_block2_axis_register_slice_0_0
     port map (
      aclk => s_axis_dac_pdti_aclk_1,
      aresetn => s_axis_dac_pdti_aresetn_1,
      m_axis_tdata(31 downto 0) => axis_register_slice_0_M_AXIS_TDATA(31 downto 0),
      m_axis_tuser(127 downto 0) => axis_register_slice_0_M_AXIS_TUSER(127 downto 0),
      m_axis_tvalid => axis_register_slice_0_M_AXIS_TVALID,
      s_axis_tdata(31 downto 0) => s_axis_dac_pdti_1_TDATA(31 downto 0),
      s_axis_tuser(127 downto 0) => s_axis_dac_pdti_1_TUSER(127 downto 0),
      s_axis_tvalid => s_axis_dac_pdti_1_TVALID
    );
controller: entity work.controller_imp_F1VSVM
     port map (
      adc_aclk => s_axis_adc_pdti_aclk_1,
      aresetn => adc_aresetn,
      coef_ch0_tdata(23 downto 0) => hcr_controller_0_coef_ch0_V_V_TDATA(23 downto 0),
      coef_ch0_tready => hcr_controller_0_coef_ch0_V_V_TREADY,
      coef_ch0_tvalid => hcr_controller_0_coef_ch0_V_V_TVALID,
      coef_ch1_tdata(23 downto 0) => coef_1_TDATA(23 downto 0),
      coef_ch1_tready => coef_1_TREADY,
      coef_ch1_tvalid => coef_1_TVALID,
      coef_ch2_tdata(23 downto 0) => hcr_controller_0_coef_ch2_V_V_TDATA(23 downto 0),
      coef_ch2_tready => hcr_controller_0_coef_ch2_V_V_TREADY,
      coef_ch2_tvalid => hcr_controller_0_coef_ch2_V_V_TVALID,
      control_flags(31 downto 0) => hcr_controller_0_control_flags(31 downto 0),
      controller_PPS => controller_PPS_1,
      filter_select_ch0(1 downto 0) => hcr_controller_0_filter_select_ch0(1 downto 0),
      filter_select_ch1(1 downto 0) => hcr_controller_0_filter_select_ch1(1 downto 0),
      filter_select_ch2(1 downto 0) => hcr_controller_0_filter_select_ch2(1 downto 0),
      mt_pulse(7 downto 0) => hcr_controller_0_mt_pulse(7 downto 0),
      pulse_metadata_ch0_tdata(823 downto 0) => hcr_controller_0_pulse_metadata_ch0_V_TDATA(823 downto 0),
      pulse_metadata_ch0_tready => hcr_controller_0_pulse_metadata_ch0_V_TREADY,
      pulse_metadata_ch0_tvalid => hcr_controller_0_pulse_metadata_ch0_V_TVALID,
      pulse_metadata_ch1_tdata(823 downto 0) => pulse_metadata_1_TDATA(823 downto 0),
      pulse_metadata_ch1_tready => pulse_metadata_1_TREADY,
      pulse_metadata_ch1_tvalid => pulse_metadata_1_TVALID,
      pulse_metadata_ch2_tdata(823 downto 0) => hcr_controller_0_pulse_metadata_ch2_V_TDATA(823 downto 0),
      pulse_metadata_ch2_tready => hcr_controller_0_pulse_metadata_ch2_V_TREADY,
      pulse_metadata_ch2_tvalid => hcr_controller_0_pulse_metadata_ch2_V_TVALID,
      s_axi_cfg_bus_araddr(12 downto 0) => axi_interc_M01_AXI_ARADDR(12 downto 0),
      s_axi_cfg_bus_arready => axi_interc_M01_AXI_ARREADY,
      s_axi_cfg_bus_arvalid => axi_interc_M01_AXI_ARVALID,
      s_axi_cfg_bus_awaddr(12 downto 0) => axi_interc_M01_AXI_AWADDR(12 downto 0),
      s_axi_cfg_bus_awready => axi_interc_M01_AXI_AWREADY,
      s_axi_cfg_bus_awvalid => axi_interc_M01_AXI_AWVALID,
      s_axi_cfg_bus_bready => axi_interc_M01_AXI_BREADY,
      s_axi_cfg_bus_bresp(1 downto 0) => axi_interc_M01_AXI_BRESP(1 downto 0),
      s_axi_cfg_bus_bvalid => axi_interc_M01_AXI_BVALID,
      s_axi_cfg_bus_rdata(31 downto 0) => axi_interc_M01_AXI_RDATA(31 downto 0),
      s_axi_cfg_bus_rready => axi_interc_M01_AXI_RREADY,
      s_axi_cfg_bus_rresp(1 downto 0) => axi_interc_M01_AXI_RRESP(1 downto 0),
      s_axi_cfg_bus_rvalid => axi_interc_M01_AXI_RVALID,
      s_axi_cfg_bus_wdata(31 downto 0) => axi_interc_M01_AXI_WDATA(31 downto 0),
      s_axi_cfg_bus_wready => axi_interc_M01_AXI_WREADY,
      s_axi_cfg_bus_wstrb(3 downto 0) => axi_interc_M01_AXI_WSTRB(3 downto 0),
      s_axi_cfg_bus_wvalid => axi_interc_M01_AXI_WVALID
    );
csr: entity work.csr_imp_1W4S3O8
     port map (
      adc_aresetn => adc_aresetn,
      adc_csr_araddr(12 downto 0) => axi_interc_M01_AXI_ARADDR(12 downto 0),
      adc_csr_arready => axi_interc_M01_AXI_ARREADY,
      adc_csr_arvalid => axi_interc_M01_AXI_ARVALID,
      adc_csr_awaddr(12 downto 0) => axi_interc_M01_AXI_AWADDR(12 downto 0),
      adc_csr_awready => axi_interc_M01_AXI_AWREADY,
      adc_csr_awvalid => axi_interc_M01_AXI_AWVALID,
      adc_csr_bready => axi_interc_M01_AXI_BREADY,
      adc_csr_bresp(1 downto 0) => axi_interc_M01_AXI_BRESP(1 downto 0),
      adc_csr_bvalid => axi_interc_M01_AXI_BVALID,
      adc_csr_rdata(31 downto 0) => axi_interc_M01_AXI_RDATA(31 downto 0),
      adc_csr_rready => axi_interc_M01_AXI_RREADY,
      adc_csr_rresp(1 downto 0) => axi_interc_M01_AXI_RRESP(1 downto 0),
      adc_csr_rvalid => axi_interc_M01_AXI_RVALID,
      adc_csr_wdata(31 downto 0) => axi_interc_M01_AXI_WDATA(31 downto 0),
      adc_csr_wready => axi_interc_M01_AXI_WREADY,
      adc_csr_wstrb(3 downto 0) => axi_interc_M01_AXI_WSTRB(3 downto 0),
      adc_csr_wvalid => axi_interc_M01_AXI_WVALID,
      controller_PPS => controller_PPS_1,
      ctl2_out(31 downto 0) => csr_ctl2_out(31 downto 0),
      i_controller_PPS => controller_PPS_2,
      s_axi_csr_aclk => s_axi_csr_aclk_1,
      s_axi_csr_araddr(25 downto 0) => s_axi_csr_1_ARADDR(25 downto 0),
      s_axi_csr_aresetn => s_axi_csr_aresetn_1,
      s_axi_csr_arprot(2 downto 0) => s_axi_csr_1_ARPROT(2 downto 0),
      s_axi_csr_arready => s_axi_csr_1_ARREADY,
      s_axi_csr_arvalid => s_axi_csr_1_ARVALID,
      s_axi_csr_awaddr(25 downto 0) => s_axi_csr_1_AWADDR(25 downto 0),
      s_axi_csr_awprot(2 downto 0) => s_axi_csr_1_AWPROT(2 downto 0),
      s_axi_csr_awready => s_axi_csr_1_AWREADY,
      s_axi_csr_awvalid => s_axi_csr_1_AWVALID,
      s_axi_csr_bready => s_axi_csr_1_BREADY,
      s_axi_csr_bresp(1 downto 0) => s_axi_csr_1_BRESP(1 downto 0),
      s_axi_csr_bvalid => s_axi_csr_1_BVALID,
      s_axi_csr_rdata(31 downto 0) => s_axi_csr_1_RDATA(31 downto 0),
      s_axi_csr_rready => s_axi_csr_1_RREADY,
      s_axi_csr_rresp(1 downto 0) => s_axi_csr_1_RRESP(1 downto 0),
      s_axi_csr_rvalid => s_axi_csr_1_RVALID,
      s_axi_csr_wdata(31 downto 0) => s_axi_csr_1_WDATA(31 downto 0),
      s_axi_csr_wready => s_axi_csr_1_WREADY,
      s_axi_csr_wstrb(3 downto 0) => s_axi_csr_1_WSTRB(3 downto 0),
      s_axi_csr_wvalid => s_axi_csr_1_WVALID,
      s_axis_adc_pdti_aclk => s_axis_adc_pdti_aclk_1,
      s_axis_adc_pdti_aresetn => s_axis_adc_pdti_aresetn_1
    );
dsp_ch0: entity work.dsp_ch0_imp_4MOMA0
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => adc_aresetn,
      coef_tdata(23 downto 0) => hcr_controller_0_coef_ch0_V_V_TDATA(23 downto 0),
      coef_tready => hcr_controller_0_coef_ch0_V_V_TREADY,
      coef_tvalid => hcr_controller_0_coef_ch0_V_V_TVALID,
      flags(15 downto 0) => status_flags(15 downto 0),
      in_pdti_tdata(31 downto 0) => s_axis_adc_ch0_pdti_1_TDATA(31 downto 0),
      in_pdti_tready => s_axis_adc_ch0_pdti_1_TREADY,
      in_pdti_tuser(127 downto 0) => s_axis_adc_ch0_pdti_1_TUSER(127 downto 0),
      in_pdti_tvalid => s_axis_adc_ch0_pdti_1_TVALID,
      out_pdti_tdata(31 downto 0) => hcr_metadata_injector_0_o_data_TDATA(31 downto 0),
      out_pdti_tuser(127 downto 0) => hcr_metadata_injector_0_o_data_TUSER(127 downto 0),
      out_pdti_tvalid => hcr_metadata_injector_0_o_data_TVALID,
      pos_enc_0(31 downto 0) => pos_enc_0_1(31 downto 0),
      pos_enc_1(31 downto 0) => pos_enc_1_1(31 downto 0),
      pulse_metadata_tdata(823 downto 0) => hcr_controller_0_pulse_metadata_ch0_V_TDATA(823 downto 0),
      pulse_metadata_tready => hcr_controller_0_pulse_metadata_ch0_V_TREADY,
      pulse_metadata_tvalid => hcr_controller_0_pulse_metadata_ch0_V_TVALID
    );
dsp_ch1: entity work.dsp_ch1_imp_12KUHLZ
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => adc_aresetn,
      coef_tdata(23 downto 0) => coef_1_TDATA(23 downto 0),
      coef_tready => coef_1_TREADY,
      coef_tvalid => coef_1_TVALID,
      flags(15 downto 0) => status_flags(15 downto 0),
      in_pdti_tdata(31 downto 0) => s_axis_adc_ch1_pdti_1_TDATA(31 downto 0),
      in_pdti_tready => s_axis_adc_ch1_pdti_1_TREADY,
      in_pdti_tuser(127 downto 0) => s_axis_adc_ch1_pdti_1_TUSER(127 downto 0),
      in_pdti_tvalid => s_axis_adc_ch1_pdti_1_TVALID,
      out_pdti_tdata(31 downto 0) => dsp_ch1_out_pdti_TDATA(31 downto 0),
      out_pdti_tuser(127 downto 0) => dsp_ch1_out_pdti_TUSER(127 downto 0),
      out_pdti_tvalid => dsp_ch1_out_pdti_TVALID,
      pos_enc_0(31 downto 0) => pos_enc_0_1(31 downto 0),
      pos_enc_1(31 downto 0) => pos_enc_1_1(31 downto 0),
      pulse_metadata_tdata(823 downto 0) => pulse_metadata_1_TDATA(823 downto 0),
      pulse_metadata_tready => pulse_metadata_1_TREADY,
      pulse_metadata_tvalid => pulse_metadata_1_TVALID
    );
dsp_ch2: entity work.dsp_ch2_imp_1Y2Y72V
     port map (
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => adc_aresetn,
      coef_tdata(23 downto 0) => hcr_controller_0_coef_ch2_V_V_TDATA(23 downto 0),
      coef_tready => hcr_controller_0_coef_ch2_V_V_TREADY,
      coef_tvalid => hcr_controller_0_coef_ch2_V_V_TVALID,
      flags(15 downto 0) => status_flags(15 downto 0),
      in_pdti_tdata(31 downto 0) => s_axis_adc_ch2_pdti_1_TDATA(31 downto 0),
      in_pdti_tready => s_axis_adc_ch2_pdti_1_TREADY,
      in_pdti_tuser(127 downto 0) => s_axis_adc_ch2_pdti_1_TUSER(127 downto 0),
      in_pdti_tvalid => s_axis_adc_ch2_pdti_1_TVALID,
      out_pdti_tdata(31 downto 0) => dsp_ch2_out_pdti_TDATA(31 downto 0),
      out_pdti_tuser(127 downto 0) => dsp_ch2_out_pdti_TUSER(127 downto 0),
      out_pdti_tvalid => dsp_ch2_out_pdti_TVALID,
      pos_enc_0(31 downto 0) => pos_enc_0_1(31 downto 0),
      pos_enc_1(31 downto 0) => pos_enc_1_1(31 downto 0),
      pulse_metadata_tdata(823 downto 0) => hcr_controller_0_pulse_metadata_ch2_V_TDATA(823 downto 0),
      pulse_metadata_tready => hcr_controller_0_pulse_metadata_ch2_V_TREADY,
      pulse_metadata_tvalid => hcr_controller_0_pulse_metadata_ch2_V_TVALID
    );
irq_placeholder: component user_block2_irq_placeholder_0
     port map (
      dout(1 downto 0) => xlconstant_0_dout(1 downto 0)
    );
position_encoder_0: component user_block2_position_encoder_0_0
     port map (
      AZ_MOSI => AZ_MOSI_1,
      AZ_SCK => AZ_SCK_1,
      AZ_SSEL => AZ_SSEL_1,
      EL_MOSI => EL_MOSI_1,
      EL_SCK => EL_SCK_1,
      EL_SSEL => EL_SSEL_1,
      ROT_A => ROT_A_1,
      ROT_B => ROT_B_1,
      TILT_A => TILT_A_1,
      TILT_B => TILT_B_1,
      aclk => s_axis_adc_pdti_aclk_1,
      aresetn => adc_aresetn,
      ctl_reg(31 downto 0) => csr_ctl2_out(31 downto 0),
      pos_enc_0(31 downto 0) => pos_enc_0_1(31 downto 0),
      pos_enc_1(31 downto 0) => pos_enc_1_1(31 downto 0)
    );
end STRUCTURE;
