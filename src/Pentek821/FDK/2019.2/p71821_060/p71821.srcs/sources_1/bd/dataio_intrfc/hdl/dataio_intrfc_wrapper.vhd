--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
--Date        : Wed Apr 28 20:06:36 2021
--Host        : wind running 64-bit unknown
--Command     : generate_target dataio_intrfc_wrapper.bd
--Design      : dataio_intrfc_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dataio_intrfc_wrapper is
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
    dac_sync_from_adc : in STD_LOGIC;
    dac_tx_en : out STD_LOGIC;
    dataio_irq : out STD_LOGIC_VECTOR ( 0 to 0 );
    gate_trig_ttl_in : in STD_LOGIC;
    gatea_in_n : in STD_LOGIC;
    gatea_in_p : in STD_LOGIC;
    gatea_out_n : out STD_LOGIC;
    gatea_out_p : out STD_LOGIC;
    gateb_in_n : in STD_LOGIC;
    gateb_in_p : in STD_LOGIC;
    gateb_out_n : out STD_LOGIC;
    gateb_out_p : out STD_LOGIC;
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
    m_axis_dac_pctl_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
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
    synca_pps_out_p : out STD_LOGIC;
    syncb_pps_in_n : in STD_LOGIC;
    syncb_pps_in_p : in STD_LOGIC;
    syncb_pps_out_n : out STD_LOGIC;
    syncb_pps_out_p : out STD_LOGIC;
    timestamp_irq : out STD_LOGIC;
    vcxo_en : out STD_LOGIC;
    vcxo_sel_n : out STD_LOGIC
  );
end dataio_intrfc_wrapper;

architecture STRUCTURE of dataio_intrfc_wrapper is
  component dataio_intrfc is
  port (
    adc0_d0_1_p : in STD_LOGIC;
    adc0_d0_1_n : in STD_LOGIC;
    adc0_d2_3_p : in STD_LOGIC;
    adc0_d2_3_n : in STD_LOGIC;
    adc0_d4_5_p : in STD_LOGIC;
    adc0_d4_5_n : in STD_LOGIC;
    adc0_d6_7_p : in STD_LOGIC;
    adc0_d6_7_n : in STD_LOGIC;
    adc0_d8_9_p : in STD_LOGIC;
    adc0_d8_9_n : in STD_LOGIC;
    adc0_d10_11_p : in STD_LOGIC;
    adc0_d10_11_n : in STD_LOGIC;
    adc0_d12_13_p : in STD_LOGIC;
    adc0_d12_13_n : in STD_LOGIC;
    adc0_d14_15_n : in STD_LOGIC;
    adc0_d14_15_p : in STD_LOGIC;
    adc1_d8_9_n : in STD_LOGIC;
    adc2_d0_1_n : in STD_LOGIC;
    adc1_d6_7_p : in STD_LOGIC;
    adc1_d6_7_n : in STD_LOGIC;
    adc1_d8_9_p : in STD_LOGIC;
    adc1_d4_5_p : in STD_LOGIC;
    adc1_d4_5_n : in STD_LOGIC;
    adc1_d14_15_n : in STD_LOGIC;
    adc1_d2_3_p : in STD_LOGIC;
    adc1_d2_3_n : in STD_LOGIC;
    adc1_d12_13_p : in STD_LOGIC;
    adc1_d12_13_n : in STD_LOGIC;
    adc1_d14_15_p : in STD_LOGIC;
    adc1_d10_11_p : in STD_LOGIC;
    adc1_d10_11_n : in STD_LOGIC;
    adc1_d0_1_p : in STD_LOGIC;
    adc1_d0_1_n : in STD_LOGIC;
    adc2_d0_1_p : in STD_LOGIC;
    adc2_d10_11_n : in STD_LOGIC;
    adc2_d8_9_n : in STD_LOGIC;
    adc2_d6_7_p : in STD_LOGIC;
    adc2_d6_7_n : in STD_LOGIC;
    adc2_d4_5_p : in STD_LOGIC;
    adc2_d8_9_p : in STD_LOGIC;
    adc2_d4_5_n : in STD_LOGIC;
    adc2_d14_15_n : in STD_LOGIC;
    adc2_d2_3_p : in STD_LOGIC;
    adc2_d2_3_n : in STD_LOGIC;
    adc2_d12_13_p : in STD_LOGIC;
    adc2_d12_13_n : in STD_LOGIC;
    adc2_d14_15_p : in STD_LOGIC;
    adc2_d10_11_p : in STD_LOGIC;
    m_axis_adc_pdti_aresetn : out STD_LOGIC;
    gatea_in_p : in STD_LOGIC;
    gatea_in_n : in STD_LOGIC;
    synca_pps_in_p : in STD_LOGIC;
    synca_pps_in_n : in STD_LOGIC;
    gate_trig_ttl_in : in STD_LOGIC;
    sync_pps_ttl_in : in STD_LOGIC;
    gatea_out_p : out STD_LOGIC;
    gatea_out_n : out STD_LOGIC;
    synca_pps_out_p : out STD_LOGIC;
    synca_pps_out_n : out STD_LOGIC;
    sbusa_master_n : out STD_LOGIC;
    clka_master_n : out STD_LOGIC;
    pps_det_led_n : out STD_LOGIC;
    vcxo_en : out STD_LOGIC;
    vcxo_sel_n : out STD_LOGIC;
    clk_mux_sel : out STD_LOGIC_VECTOR ( 1 downto 0 );
    cdc_sync_rst_out : out STD_LOGIC;
    clk_det_led_n : out STD_LOGIC;
    cdc_sync_rst_in_n : in STD_LOGIC;
    cdc_sync_rst_in_p : in STD_LOGIC;
    m_axis_adc_pdti_aclk : out STD_LOGIC;
    adc0_fifo_full_stat : in STD_LOGIC;
    adc1_fifo_full_stat : in STD_LOGIC;
    adc2_fifo_full_stat : in STD_LOGIC;
    dac_realtime_lost_stat : in STD_LOGIC;
    adc_dither : out STD_LOGIC;
    adc0_ovld_led_n : out STD_LOGIC;
    adc1_ovld_led_n : out STD_LOGIC;
    adc2_ovld_led_n : out STD_LOGIC;
    adc0_pdwnf : out STD_LOGIC;
    adc1_pdwnf : out STD_LOGIC;
    adc2_pdwnf : out STD_LOGIC;
    s_axi_csr_aresetn : in STD_LOGIC;
    s_axi_csr_aclk : in STD_LOGIC;
    master_led_n : out STD_LOGIC;
    timestamp_irq : out STD_LOGIC;
    refclk : in STD_LOGIC;
    dataio_irq : out STD_LOGIC_VECTOR ( 0 to 0 );
    dac_da : out STD_LOGIC_VECTOR ( 15 downto 0 );
    dac_db : out STD_LOGIC_VECTOR ( 15 downto 0 );
    dac_sclk : out STD_LOGIC;
    dac_sdi : out STD_LOGIC;
    dac_sdenb : out STD_LOGIC;
    dac_tx_en : out STD_LOGIC;
    dac_sync : out STD_LOGIC;
    dac_reset_n : out STD_LOGIC;
    dac_sdo : in STD_LOGIC;
    dac_lock : in STD_LOGIC;
    dac_realtimelost_led_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_dac_pdti_aclk : out STD_LOGIC;
    syncb_pps_in_n : in STD_LOGIC;
    syncb_pps_in_p : in STD_LOGIC;
    gateb_in_n : in STD_LOGIC;
    gateb_in_p : in STD_LOGIC;
    gateb_out_p : out STD_LOGIC;
    gateb_out_n : out STD_LOGIC;
    syncb_pps_out_p : out STD_LOGIC;
    syncb_pps_out_n : out STD_LOGIC;
    sbusb_master_n : out STD_LOGIC;
    clkb_master_n : out STD_LOGIC;
    s_axis_dac_pdti_aresetn : out STD_LOGIC;
    cdc_cntl_cdc_stat_vcxo : in STD_LOGIC;
    cdc_cntl_cdc_stat_lock : in STD_LOGIC;
    cdc_cntl_cdc_stat_ref : in STD_LOGIC;
    cdc_cntl_cdc_dat : out STD_LOGIC;
    cdc_cntl_cdc_clk : out STD_LOGIC;
    cdc_cntl_cdc_le : out STD_LOGIC;
    cdc_cntl_cdc_rst_n : out STD_LOGIC;
    m_axis_adc_ch0_pdti_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_adc_ch0_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_adc_ch0_pdti_tvalid : out STD_LOGIC;
    m_axis_adc_ch1_pdti_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_adc_ch1_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_adc_ch1_pdti_tvalid : out STD_LOGIC;
    m_axis_adc_ch2_pdti_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_adc_ch2_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_adc_ch2_pdti_tvalid : out STD_LOGIC;
    s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
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
    clkb_glbl_clk_p : in STD_LOGIC;
    clkb_glbl_clk_n : in STD_LOGIC;
    s_axis_dac_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_dac_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_dac_pdti_tvalid : in STD_LOGIC;
    clka_glbl_clk_p : in STD_LOGIC;
    clka_glbl_clk_n : in STD_LOGIC;
    m_axis_dac_pctl_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_dac_pctl_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    dac_sync_from_adc : in STD_LOGIC
  );
  end component dataio_intrfc;
begin
dataio_intrfc_i: component dataio_intrfc
     port map (
      adc0_d0_1_n => adc0_d0_1_n,
      adc0_d0_1_p => adc0_d0_1_p,
      adc0_d10_11_n => adc0_d10_11_n,
      adc0_d10_11_p => adc0_d10_11_p,
      adc0_d12_13_n => adc0_d12_13_n,
      adc0_d12_13_p => adc0_d12_13_p,
      adc0_d14_15_n => adc0_d14_15_n,
      adc0_d14_15_p => adc0_d14_15_p,
      adc0_d2_3_n => adc0_d2_3_n,
      adc0_d2_3_p => adc0_d2_3_p,
      adc0_d4_5_n => adc0_d4_5_n,
      adc0_d4_5_p => adc0_d4_5_p,
      adc0_d6_7_n => adc0_d6_7_n,
      adc0_d6_7_p => adc0_d6_7_p,
      adc0_d8_9_n => adc0_d8_9_n,
      adc0_d8_9_p => adc0_d8_9_p,
      adc0_fifo_full_stat => adc0_fifo_full_stat,
      adc0_ovld_led_n => adc0_ovld_led_n,
      adc0_pdwnf => adc0_pdwnf,
      adc1_d0_1_n => adc1_d0_1_n,
      adc1_d0_1_p => adc1_d0_1_p,
      adc1_d10_11_n => adc1_d10_11_n,
      adc1_d10_11_p => adc1_d10_11_p,
      adc1_d12_13_n => adc1_d12_13_n,
      adc1_d12_13_p => adc1_d12_13_p,
      adc1_d14_15_n => adc1_d14_15_n,
      adc1_d14_15_p => adc1_d14_15_p,
      adc1_d2_3_n => adc1_d2_3_n,
      adc1_d2_3_p => adc1_d2_3_p,
      adc1_d4_5_n => adc1_d4_5_n,
      adc1_d4_5_p => adc1_d4_5_p,
      adc1_d6_7_n => adc1_d6_7_n,
      adc1_d6_7_p => adc1_d6_7_p,
      adc1_d8_9_n => adc1_d8_9_n,
      adc1_d8_9_p => adc1_d8_9_p,
      adc1_fifo_full_stat => adc1_fifo_full_stat,
      adc1_ovld_led_n => adc1_ovld_led_n,
      adc1_pdwnf => adc1_pdwnf,
      adc2_d0_1_n => adc2_d0_1_n,
      adc2_d0_1_p => adc2_d0_1_p,
      adc2_d10_11_n => adc2_d10_11_n,
      adc2_d10_11_p => adc2_d10_11_p,
      adc2_d12_13_n => adc2_d12_13_n,
      adc2_d12_13_p => adc2_d12_13_p,
      adc2_d14_15_n => adc2_d14_15_n,
      adc2_d14_15_p => adc2_d14_15_p,
      adc2_d2_3_n => adc2_d2_3_n,
      adc2_d2_3_p => adc2_d2_3_p,
      adc2_d4_5_n => adc2_d4_5_n,
      adc2_d4_5_p => adc2_d4_5_p,
      adc2_d6_7_n => adc2_d6_7_n,
      adc2_d6_7_p => adc2_d6_7_p,
      adc2_d8_9_n => adc2_d8_9_n,
      adc2_d8_9_p => adc2_d8_9_p,
      adc2_fifo_full_stat => adc2_fifo_full_stat,
      adc2_ovld_led_n => adc2_ovld_led_n,
      adc2_pdwnf => adc2_pdwnf,
      adc_dither => adc_dither,
      cdc_cntl_cdc_clk => cdc_cntl_cdc_clk,
      cdc_cntl_cdc_dat => cdc_cntl_cdc_dat,
      cdc_cntl_cdc_le => cdc_cntl_cdc_le,
      cdc_cntl_cdc_rst_n => cdc_cntl_cdc_rst_n,
      cdc_cntl_cdc_stat_lock => cdc_cntl_cdc_stat_lock,
      cdc_cntl_cdc_stat_ref => cdc_cntl_cdc_stat_ref,
      cdc_cntl_cdc_stat_vcxo => cdc_cntl_cdc_stat_vcxo,
      cdc_sync_rst_in_n => cdc_sync_rst_in_n,
      cdc_sync_rst_in_p => cdc_sync_rst_in_p,
      cdc_sync_rst_out => cdc_sync_rst_out,
      clk_det_led_n => clk_det_led_n,
      clk_mux_sel(1 downto 0) => clk_mux_sel(1 downto 0),
      clka_glbl_clk_n => clka_glbl_clk_n,
      clka_glbl_clk_p => clka_glbl_clk_p,
      clka_master_n => clka_master_n,
      clkb_glbl_clk_n => clkb_glbl_clk_n,
      clkb_glbl_clk_p => clkb_glbl_clk_p,
      clkb_master_n => clkb_master_n,
      dac_da(15 downto 0) => dac_da(15 downto 0),
      dac_db(15 downto 0) => dac_db(15 downto 0),
      dac_lock => dac_lock,
      dac_realtime_lost_stat => dac_realtime_lost_stat,
      dac_realtimelost_led_n(0) => dac_realtimelost_led_n(0),
      dac_reset_n => dac_reset_n,
      dac_sclk => dac_sclk,
      dac_sdenb => dac_sdenb,
      dac_sdi => dac_sdi,
      dac_sdo => dac_sdo,
      dac_sync => dac_sync,
      dac_sync_from_adc => dac_sync_from_adc,
      dac_tx_en => dac_tx_en,
      dataio_irq(0) => dataio_irq(0),
      gate_trig_ttl_in => gate_trig_ttl_in,
      gatea_in_n => gatea_in_n,
      gatea_in_p => gatea_in_p,
      gatea_out_n => gatea_out_n,
      gatea_out_p => gatea_out_p,
      gateb_in_n => gateb_in_n,
      gateb_in_p => gateb_in_p,
      gateb_out_n => gateb_out_n,
      gateb_out_p => gateb_out_p,
      m_axis_adc_ch0_pdti_tdata(15 downto 0) => m_axis_adc_ch0_pdti_tdata(15 downto 0),
      m_axis_adc_ch0_pdti_tuser(127 downto 0) => m_axis_adc_ch0_pdti_tuser(127 downto 0),
      m_axis_adc_ch0_pdti_tvalid => m_axis_adc_ch0_pdti_tvalid,
      m_axis_adc_ch1_pdti_tdata(15 downto 0) => m_axis_adc_ch1_pdti_tdata(15 downto 0),
      m_axis_adc_ch1_pdti_tuser(127 downto 0) => m_axis_adc_ch1_pdti_tuser(127 downto 0),
      m_axis_adc_ch1_pdti_tvalid => m_axis_adc_ch1_pdti_tvalid,
      m_axis_adc_ch2_pdti_tdata(15 downto 0) => m_axis_adc_ch2_pdti_tdata(15 downto 0),
      m_axis_adc_ch2_pdti_tuser(127 downto 0) => m_axis_adc_ch2_pdti_tuser(127 downto 0),
      m_axis_adc_ch2_pdti_tvalid => m_axis_adc_ch2_pdti_tvalid,
      m_axis_adc_pdti_aclk => m_axis_adc_pdti_aclk,
      m_axis_adc_pdti_aresetn => m_axis_adc_pdti_aresetn,
      m_axis_dac_pctl_tdata(7 downto 0) => m_axis_dac_pctl_tdata(7 downto 0),
      m_axis_dac_pctl_tvalid(0) => m_axis_dac_pctl_tvalid(0),
      master_led_n => master_led_n,
      pps_det_led_n => pps_det_led_n,
      refclk => refclk,
      s_axi_csr_aclk => s_axi_csr_aclk,
      s_axi_csr_araddr(25 downto 0) => s_axi_csr_araddr(25 downto 0),
      s_axi_csr_aresetn => s_axi_csr_aresetn,
      s_axi_csr_arprot(2 downto 0) => s_axi_csr_arprot(2 downto 0),
      s_axi_csr_arready => s_axi_csr_arready,
      s_axi_csr_arvalid => s_axi_csr_arvalid,
      s_axi_csr_awaddr(25 downto 0) => s_axi_csr_awaddr(25 downto 0),
      s_axi_csr_awprot(2 downto 0) => s_axi_csr_awprot(2 downto 0),
      s_axi_csr_awready => s_axi_csr_awready,
      s_axi_csr_awvalid => s_axi_csr_awvalid,
      s_axi_csr_bready => s_axi_csr_bready,
      s_axi_csr_bresp(1 downto 0) => s_axi_csr_bresp(1 downto 0),
      s_axi_csr_bvalid => s_axi_csr_bvalid,
      s_axi_csr_rdata(31 downto 0) => s_axi_csr_rdata(31 downto 0),
      s_axi_csr_rready => s_axi_csr_rready,
      s_axi_csr_rresp(1 downto 0) => s_axi_csr_rresp(1 downto 0),
      s_axi_csr_rvalid => s_axi_csr_rvalid,
      s_axi_csr_wdata(31 downto 0) => s_axi_csr_wdata(31 downto 0),
      s_axi_csr_wready => s_axi_csr_wready,
      s_axi_csr_wstrb(3 downto 0) => s_axi_csr_wstrb(3 downto 0),
      s_axi_csr_wvalid => s_axi_csr_wvalid,
      s_axis_dac_pdti_aclk => s_axis_dac_pdti_aclk,
      s_axis_dac_pdti_aresetn => s_axis_dac_pdti_aresetn,
      s_axis_dac_pdti_tdata(31 downto 0) => s_axis_dac_pdti_tdata(31 downto 0),
      s_axis_dac_pdti_tuser(127 downto 0) => s_axis_dac_pdti_tuser(127 downto 0),
      s_axis_dac_pdti_tvalid => s_axis_dac_pdti_tvalid,
      sbusa_master_n => sbusa_master_n,
      sbusb_master_n => sbusb_master_n,
      sync_pps_ttl_in => sync_pps_ttl_in,
      synca_pps_in_n => synca_pps_in_n,
      synca_pps_in_p => synca_pps_in_p,
      synca_pps_out_n => synca_pps_out_n,
      synca_pps_out_p => synca_pps_out_p,
      syncb_pps_in_n => syncb_pps_in_n,
      syncb_pps_in_p => syncb_pps_in_p,
      syncb_pps_out_n => syncb_pps_out_n,
      syncb_pps_out_p => syncb_pps_out_p,
      timestamp_irq => timestamp_irq,
      vcxo_en => vcxo_en,
      vcxo_sel_n => vcxo_sel_n
    );
end STRUCTURE;
