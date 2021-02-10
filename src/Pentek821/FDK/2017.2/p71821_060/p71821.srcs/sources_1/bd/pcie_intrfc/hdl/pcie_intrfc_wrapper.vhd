--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
--Date        : Fri Jan 22 18:25:39 2021
--Host        : apararchiver running 64-bit CentOS Linux release 8.0.1905 (Core)
--Command     : generate_target pcie_intrfc_wrapper.bd
--Design      : pcie_intrfc_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pcie_intrfc_wrapper is
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
    m_axi_acq_csr_arready : in STD_LOGIC;
    m_axi_acq_csr_arvalid : out STD_LOGIC;
    m_axi_acq_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_acq_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_acq_csr_awready : in STD_LOGIC;
    m_axi_acq_csr_awvalid : out STD_LOGIC;
    m_axi_acq_csr_bready : out STD_LOGIC;
    m_axi_acq_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_acq_csr_bvalid : in STD_LOGIC;
    m_axi_acq_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_acq_csr_rready : out STD_LOGIC;
    m_axi_acq_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_acq_csr_rvalid : in STD_LOGIC;
    m_axi_acq_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_acq_csr_wready : in STD_LOGIC;
    m_axi_acq_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_acq_csr_wvalid : out STD_LOGIC;
    m_axi_csr_aclk : out STD_LOGIC;
    m_axi_csr_aresetn : out STD_LOGIC;
    m_axi_dataio_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_dataio_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dataio_csr_arready : in STD_LOGIC;
    m_axi_dataio_csr_arvalid : out STD_LOGIC;
    m_axi_dataio_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_dataio_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dataio_csr_awready : in STD_LOGIC;
    m_axi_dataio_csr_awvalid : out STD_LOGIC;
    m_axi_dataio_csr_bready : out STD_LOGIC;
    m_axi_dataio_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dataio_csr_bvalid : in STD_LOGIC;
    m_axi_dataio_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dataio_csr_rready : out STD_LOGIC;
    m_axi_dataio_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dataio_csr_rvalid : in STD_LOGIC;
    m_axi_dataio_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dataio_csr_wready : in STD_LOGIC;
    m_axi_dataio_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dataio_csr_wvalid : out STD_LOGIC;
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
    m_axi_dsp_csr_arready : in STD_LOGIC;
    m_axi_dsp_csr_arvalid : out STD_LOGIC;
    m_axi_dsp_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_dsp_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dsp_csr_awready : in STD_LOGIC;
    m_axi_dsp_csr_awvalid : out STD_LOGIC;
    m_axi_dsp_csr_bready : out STD_LOGIC;
    m_axi_dsp_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dsp_csr_bvalid : in STD_LOGIC;
    m_axi_dsp_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dsp_csr_rready : out STD_LOGIC;
    m_axi_dsp_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dsp_csr_rvalid : in STD_LOGIC;
    m_axi_dsp_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dsp_csr_wready : in STD_LOGIC;
    m_axi_dsp_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dsp_csr_wvalid : out STD_LOGIC;
    m_axi_user1_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_user1_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_user1_csr_arready : in STD_LOGIC;
    m_axi_user1_csr_arvalid : out STD_LOGIC;
    m_axi_user1_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_user1_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_user1_csr_awready : in STD_LOGIC;
    m_axi_user1_csr_awvalid : out STD_LOGIC;
    m_axi_user1_csr_bready : out STD_LOGIC;
    m_axi_user1_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_user1_csr_bvalid : in STD_LOGIC;
    m_axi_user1_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_user1_csr_rready : out STD_LOGIC;
    m_axi_user1_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_user1_csr_rvalid : in STD_LOGIC;
    m_axi_user1_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_user1_csr_wready : in STD_LOGIC;
    m_axi_user1_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_user1_csr_wvalid : out STD_LOGIC;
    m_axi_user2_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_user2_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_user2_csr_arready : in STD_LOGIC;
    m_axi_user2_csr_arvalid : out STD_LOGIC;
    m_axi_user2_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_user2_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_user2_csr_awready : in STD_LOGIC;
    m_axi_user2_csr_awvalid : out STD_LOGIC;
    m_axi_user2_csr_bready : out STD_LOGIC;
    m_axi_user2_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_user2_csr_bvalid : in STD_LOGIC;
    m_axi_user2_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_user2_csr_rready : out STD_LOGIC;
    m_axi_user2_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_user2_csr_rvalid : in STD_LOGIC;
    m_axi_user2_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_user2_csr_wready : in STD_LOGIC;
    m_axi_user2_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_user2_csr_wvalid : out STD_LOGIC;
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
end pcie_intrfc_wrapper;

architecture STRUCTURE of pcie_intrfc_wrapper is
  component pcie_intrfc is
  port (
    s_axis_pcie_rq_tdata : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_pcie_rq_tkeep : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_pcie_rq_tlast : in STD_LOGIC;
    s_axis_pcie_rq_tuser : in STD_LOGIC_VECTOR ( 59 downto 0 );
    s_axis_pcie_rq_tvalid : in STD_LOGIC;
    s_axis_pcie_rq_tready : out STD_LOGIC;
    pcie_mgt_rxn : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pcie_mgt_rxp : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pcie_mgt_txn : out STD_LOGIC_VECTOR ( 7 downto 0 );
    pcie_mgt_txp : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Vp_Vn_v_n : in STD_LOGIC;
    Vp_Vn_v_p : in STD_LOGIC;
    Vaux0_v_n : in STD_LOGIC;
    Vaux0_v_p : in STD_LOGIC;
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
    Vaux10_v_n : in STD_LOGIC;
    Vaux10_v_p : in STD_LOGIC;
    Vaux11_v_n : in STD_LOGIC;
    Vaux11_v_p : in STD_LOGIC;
    Vaux12_v_n : in STD_LOGIC;
    Vaux12_v_p : in STD_LOGIC;
    iic_port0_scl_i : in STD_LOGIC;
    iic_port0_scl_o : out STD_LOGIC;
    iic_port0_scl_t : out STD_LOGIC;
    iic_port0_sda_i : in STD_LOGIC;
    iic_port0_sda_o : out STD_LOGIC;
    iic_port0_sda_t : out STD_LOGIC;
    iic_port1_scl_i : in STD_LOGIC;
    iic_port1_scl_o : out STD_LOGIC;
    iic_port1_scl_t : out STD_LOGIC;
    iic_port1_sda_i : in STD_LOGIC;
    iic_port1_sda_o : out STD_LOGIC;
    iic_port1_sda_t : out STD_LOGIC;
    m_axis_dma_pcie_cntl_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_dma_pcie_cntl_tvalid : out STD_LOGIC;
    m_axis_ddr_rqst_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_ddr_rqst_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_ddr_rqst_tlast : out STD_LOGIC;
    m_axis_ddr_rqst_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_ddr_rqst_tvalid : out STD_LOGIC;
    m_axis_ddr_rqst_tready : in STD_LOGIC;
    s_axis_ddr_rsp_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_ddr_rsp_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_ddr_rsp_tlast : in STD_LOGIC;
    s_axis_ddr_rsp_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_ddr_rsp_tvalid : in STD_LOGIC;
    m_axis_pcie_rc_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_pcie_rc_tkeep : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_pcie_rc_tlast : out STD_LOGIC;
    m_axis_pcie_rc_tuser : out STD_LOGIC_VECTOR ( 74 downto 0 );
    m_axis_pcie_rc_tvalid : out STD_LOGIC;
    m_axis_pcie_rc_tready : in STD_LOGIC;
    pcie_link_up : out STD_LOGIC;
    m_axi_csr_aresetn : out STD_LOGIC;
    shutdown_rqst : out STD_LOGIC;
    rq_shutdown_ok : in STD_LOGIC;
    m_axi_csr_aclk : out STD_LOGIC;
    sys_clk : in STD_LOGIC;
    sys_clk_gt : in STD_LOGIC;
    pcie_perstn_in : in STD_LOGIC;
    sys_mon_alarm : out STD_LOGIC;
    mga : in STD_LOGIC_VECTOR ( 2 downto 0 );
    pcie_link_up_led_n : out STD_LOGIC;
    pcie_lane_led0_n : out STD_LOGIC;
    pcie_lane_led1_n : out STD_LOGIC;
    user_led_n : out STD_LOGIC;
    sys_mon_led_n : out STD_LOGIC;
    temp_irq_n : in STD_LOGIC;
    rev : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rev_date : in STD_LOGIC_VECTOR ( 23 downto 0 );
    fpio_type : in STD_LOGIC_VECTOR ( 3 downto 0 );
    time_irq : in STD_LOGIC;
    dataio_irq : in STD_LOGIC_VECTOR ( 0 to 0 );
    dataiopkt_irq : in STD_LOGIC_VECTOR ( 0 to 0 );
    dma_irq : in STD_LOGIC_VECTOR ( 15 downto 0 );
    dsp_irq : in STD_LOGIC_VECTOR ( 7 downto 0 );
    user1_irq : in STD_LOGIC_VECTOR ( 1 downto 0 );
    user2_irq : in STD_LOGIC_VECTOR ( 1 downto 0 );
    flash_a : out STD_LOGIC_VECTOR ( 25 downto 0 );
    flash_adv_b : out STD_LOGIC;
    flash_d_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    flash_d_t : out STD_LOGIC_VECTOR ( 15 downto 0 );
    flash_fwe_b : out STD_LOGIC;
    flash_fcs_b : out STD_LOGIC;
    flash_foe_b : out STD_LOGIC;
    flash_d_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    fpga_size : in STD_LOGIC_VECTOR ( 11 downto 0 );
    startup_eos_in : in STD_LOGIC;
    m_axi_acq_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_acq_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_acq_csr_awvalid : out STD_LOGIC;
    m_axi_acq_csr_awready : in STD_LOGIC;
    m_axi_acq_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_acq_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_acq_csr_wvalid : out STD_LOGIC;
    m_axi_acq_csr_wready : in STD_LOGIC;
    m_axi_acq_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_acq_csr_bvalid : in STD_LOGIC;
    m_axi_acq_csr_bready : out STD_LOGIC;
    m_axi_acq_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_acq_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_acq_csr_arvalid : out STD_LOGIC;
    m_axi_acq_csr_arready : in STD_LOGIC;
    m_axi_acq_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_acq_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_acq_csr_rvalid : in STD_LOGIC;
    m_axi_acq_csr_rready : out STD_LOGIC;
    m_axi_dsp_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_dsp_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dsp_csr_awvalid : out STD_LOGIC;
    m_axi_dsp_csr_awready : in STD_LOGIC;
    m_axi_dsp_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dsp_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dsp_csr_wvalid : out STD_LOGIC;
    m_axi_dsp_csr_wready : in STD_LOGIC;
    m_axi_dsp_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dsp_csr_bvalid : in STD_LOGIC;
    m_axi_dsp_csr_bready : out STD_LOGIC;
    m_axi_dsp_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_dsp_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dsp_csr_arvalid : out STD_LOGIC;
    m_axi_dsp_csr_arready : in STD_LOGIC;
    m_axi_dsp_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dsp_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dsp_csr_rvalid : in STD_LOGIC;
    m_axi_dsp_csr_rready : out STD_LOGIC;
    m_axi_user2_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_user2_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_user2_csr_awvalid : out STD_LOGIC;
    m_axi_user2_csr_awready : in STD_LOGIC;
    m_axi_user2_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_user2_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_user2_csr_wvalid : out STD_LOGIC;
    m_axi_user2_csr_wready : in STD_LOGIC;
    m_axi_user2_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_user2_csr_bvalid : in STD_LOGIC;
    m_axi_user2_csr_bready : out STD_LOGIC;
    m_axi_user2_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_user2_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_user2_csr_arvalid : out STD_LOGIC;
    m_axi_user2_csr_arready : in STD_LOGIC;
    m_axi_user2_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_user2_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_user2_csr_rvalid : in STD_LOGIC;
    m_axi_user2_csr_rready : out STD_LOGIC;
    m_axi_user1_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_user1_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_user1_csr_awvalid : out STD_LOGIC;
    m_axi_user1_csr_awready : in STD_LOGIC;
    m_axi_user1_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_user1_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_user1_csr_wvalid : out STD_LOGIC;
    m_axi_user1_csr_wready : in STD_LOGIC;
    m_axi_user1_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_user1_csr_bvalid : in STD_LOGIC;
    m_axi_user1_csr_bready : out STD_LOGIC;
    m_axi_user1_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_user1_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_user1_csr_arvalid : out STD_LOGIC;
    m_axi_user1_csr_arready : in STD_LOGIC;
    m_axi_user1_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_user1_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_user1_csr_rvalid : in STD_LOGIC;
    m_axi_user1_csr_rready : out STD_LOGIC;
    m_axi_dataio_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_dataio_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dataio_csr_awvalid : out STD_LOGIC;
    m_axi_dataio_csr_awready : in STD_LOGIC;
    m_axi_dataio_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dataio_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dataio_csr_wvalid : out STD_LOGIC;
    m_axi_dataio_csr_wready : in STD_LOGIC;
    m_axi_dataio_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dataio_csr_bvalid : in STD_LOGIC;
    m_axi_dataio_csr_bready : out STD_LOGIC;
    m_axi_dataio_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_dataio_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dataio_csr_arvalid : out STD_LOGIC;
    m_axi_dataio_csr_arready : in STD_LOGIC;
    m_axi_dataio_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dataio_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dataio_csr_rvalid : in STD_LOGIC;
    m_axi_dataio_csr_rready : out STD_LOGIC;
    m_axi_ddr4_csr_awaddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_ddr4_csr_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_ddr4_csr_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_ddr4_csr_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_ddr4_csr_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_ddr4_csr_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_ddr4_csr_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_ddr4_csr_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_ddr4_csr_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_ddr4_csr_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_ddr4_csr_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_ddr4_csr_araddr : out STD_LOGIC_VECTOR ( 25 downto 0 );
    m_axi_ddr4_csr_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_ddr4_csr_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_ddr4_csr_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_ddr4_csr_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_ddr4_csr_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_ddr4_csr_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_ddr4_csr_rready : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component pcie_intrfc;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal iic_port0_scl_i : STD_LOGIC;
  signal iic_port0_scl_o : STD_LOGIC;
  signal iic_port0_scl_t : STD_LOGIC;
  signal iic_port0_sda_i : STD_LOGIC;
  signal iic_port0_sda_o : STD_LOGIC;
  signal iic_port0_sda_t : STD_LOGIC;
  signal iic_port1_scl_i : STD_LOGIC;
  signal iic_port1_scl_o : STD_LOGIC;
  signal iic_port1_scl_t : STD_LOGIC;
  signal iic_port1_sda_i : STD_LOGIC;
  signal iic_port1_sda_o : STD_LOGIC;
  signal iic_port1_sda_t : STD_LOGIC;
begin
iic_port0_scl_iobuf: component IOBUF
     port map (
      I => iic_port0_scl_o,
      IO => iic_port0_scl_io,
      O => iic_port0_scl_i,
      T => iic_port0_scl_t
    );
iic_port0_sda_iobuf: component IOBUF
     port map (
      I => iic_port0_sda_o,
      IO => iic_port0_sda_io,
      O => iic_port0_sda_i,
      T => iic_port0_sda_t
    );
iic_port1_scl_iobuf: component IOBUF
     port map (
      I => iic_port1_scl_o,
      IO => iic_port1_scl_io,
      O => iic_port1_scl_i,
      T => iic_port1_scl_t
    );
iic_port1_sda_iobuf: component IOBUF
     port map (
      I => iic_port1_sda_o,
      IO => iic_port1_sda_io,
      O => iic_port1_sda_i,
      T => iic_port1_sda_t
    );
pcie_intrfc_i: component pcie_intrfc
     port map (
      Vaux0_v_n => Vaux0_v_n,
      Vaux0_v_p => Vaux0_v_p,
      Vaux10_v_n => Vaux10_v_n,
      Vaux10_v_p => Vaux10_v_p,
      Vaux11_v_n => Vaux11_v_n,
      Vaux11_v_p => Vaux11_v_p,
      Vaux12_v_n => Vaux12_v_n,
      Vaux12_v_p => Vaux12_v_p,
      Vaux1_v_n => Vaux1_v_n,
      Vaux1_v_p => Vaux1_v_p,
      Vaux2_v_n => Vaux2_v_n,
      Vaux2_v_p => Vaux2_v_p,
      Vaux3_v_n => Vaux3_v_n,
      Vaux3_v_p => Vaux3_v_p,
      Vaux4_v_n => Vaux4_v_n,
      Vaux4_v_p => Vaux4_v_p,
      Vaux8_v_n => Vaux8_v_n,
      Vaux8_v_p => Vaux8_v_p,
      Vaux9_v_n => Vaux9_v_n,
      Vaux9_v_p => Vaux9_v_p,
      Vp_Vn_v_n => Vp_Vn_v_n,
      Vp_Vn_v_p => Vp_Vn_v_p,
      dataio_irq(0) => dataio_irq(0),
      dataiopkt_irq(0) => dataiopkt_irq(0),
      dma_irq(15 downto 0) => dma_irq(15 downto 0),
      dsp_irq(7 downto 0) => dsp_irq(7 downto 0),
      flash_a(25 downto 0) => flash_a(25 downto 0),
      flash_adv_b => flash_adv_b,
      flash_d_i(15 downto 0) => flash_d_i(15 downto 0),
      flash_d_o(15 downto 0) => flash_d_o(15 downto 0),
      flash_d_t(15 downto 0) => flash_d_t(15 downto 0),
      flash_fcs_b => flash_fcs_b,
      flash_foe_b => flash_foe_b,
      flash_fwe_b => flash_fwe_b,
      fpga_size(11 downto 0) => fpga_size(11 downto 0),
      fpio_type(3 downto 0) => fpio_type(3 downto 0),
      iic_port0_scl_i => iic_port0_scl_i,
      iic_port0_scl_o => iic_port0_scl_o,
      iic_port0_scl_t => iic_port0_scl_t,
      iic_port0_sda_i => iic_port0_sda_i,
      iic_port0_sda_o => iic_port0_sda_o,
      iic_port0_sda_t => iic_port0_sda_t,
      iic_port1_scl_i => iic_port1_scl_i,
      iic_port1_scl_o => iic_port1_scl_o,
      iic_port1_scl_t => iic_port1_scl_t,
      iic_port1_sda_i => iic_port1_sda_i,
      iic_port1_sda_o => iic_port1_sda_o,
      iic_port1_sda_t => iic_port1_sda_t,
      m_axi_acq_csr_araddr(25 downto 0) => m_axi_acq_csr_araddr(25 downto 0),
      m_axi_acq_csr_arprot(2 downto 0) => m_axi_acq_csr_arprot(2 downto 0),
      m_axi_acq_csr_arready => m_axi_acq_csr_arready,
      m_axi_acq_csr_arvalid => m_axi_acq_csr_arvalid,
      m_axi_acq_csr_awaddr(25 downto 0) => m_axi_acq_csr_awaddr(25 downto 0),
      m_axi_acq_csr_awprot(2 downto 0) => m_axi_acq_csr_awprot(2 downto 0),
      m_axi_acq_csr_awready => m_axi_acq_csr_awready,
      m_axi_acq_csr_awvalid => m_axi_acq_csr_awvalid,
      m_axi_acq_csr_bready => m_axi_acq_csr_bready,
      m_axi_acq_csr_bresp(1 downto 0) => m_axi_acq_csr_bresp(1 downto 0),
      m_axi_acq_csr_bvalid => m_axi_acq_csr_bvalid,
      m_axi_acq_csr_rdata(31 downto 0) => m_axi_acq_csr_rdata(31 downto 0),
      m_axi_acq_csr_rready => m_axi_acq_csr_rready,
      m_axi_acq_csr_rresp(1 downto 0) => m_axi_acq_csr_rresp(1 downto 0),
      m_axi_acq_csr_rvalid => m_axi_acq_csr_rvalid,
      m_axi_acq_csr_wdata(31 downto 0) => m_axi_acq_csr_wdata(31 downto 0),
      m_axi_acq_csr_wready => m_axi_acq_csr_wready,
      m_axi_acq_csr_wstrb(3 downto 0) => m_axi_acq_csr_wstrb(3 downto 0),
      m_axi_acq_csr_wvalid => m_axi_acq_csr_wvalid,
      m_axi_csr_aclk => m_axi_csr_aclk,
      m_axi_csr_aresetn => m_axi_csr_aresetn,
      m_axi_dataio_csr_araddr(25 downto 0) => m_axi_dataio_csr_araddr(25 downto 0),
      m_axi_dataio_csr_arprot(2 downto 0) => m_axi_dataio_csr_arprot(2 downto 0),
      m_axi_dataio_csr_arready => m_axi_dataio_csr_arready,
      m_axi_dataio_csr_arvalid => m_axi_dataio_csr_arvalid,
      m_axi_dataio_csr_awaddr(25 downto 0) => m_axi_dataio_csr_awaddr(25 downto 0),
      m_axi_dataio_csr_awprot(2 downto 0) => m_axi_dataio_csr_awprot(2 downto 0),
      m_axi_dataio_csr_awready => m_axi_dataio_csr_awready,
      m_axi_dataio_csr_awvalid => m_axi_dataio_csr_awvalid,
      m_axi_dataio_csr_bready => m_axi_dataio_csr_bready,
      m_axi_dataio_csr_bresp(1 downto 0) => m_axi_dataio_csr_bresp(1 downto 0),
      m_axi_dataio_csr_bvalid => m_axi_dataio_csr_bvalid,
      m_axi_dataio_csr_rdata(31 downto 0) => m_axi_dataio_csr_rdata(31 downto 0),
      m_axi_dataio_csr_rready => m_axi_dataio_csr_rready,
      m_axi_dataio_csr_rresp(1 downto 0) => m_axi_dataio_csr_rresp(1 downto 0),
      m_axi_dataio_csr_rvalid => m_axi_dataio_csr_rvalid,
      m_axi_dataio_csr_wdata(31 downto 0) => m_axi_dataio_csr_wdata(31 downto 0),
      m_axi_dataio_csr_wready => m_axi_dataio_csr_wready,
      m_axi_dataio_csr_wstrb(3 downto 0) => m_axi_dataio_csr_wstrb(3 downto 0),
      m_axi_dataio_csr_wvalid => m_axi_dataio_csr_wvalid,
      m_axi_ddr4_csr_araddr(25 downto 0) => m_axi_ddr4_csr_araddr(25 downto 0),
      m_axi_ddr4_csr_arprot(2 downto 0) => m_axi_ddr4_csr_arprot(2 downto 0),
      m_axi_ddr4_csr_arready(0) => m_axi_ddr4_csr_arready(0),
      m_axi_ddr4_csr_arvalid(0) => m_axi_ddr4_csr_arvalid(0),
      m_axi_ddr4_csr_awaddr(25 downto 0) => m_axi_ddr4_csr_awaddr(25 downto 0),
      m_axi_ddr4_csr_awprot(2 downto 0) => m_axi_ddr4_csr_awprot(2 downto 0),
      m_axi_ddr4_csr_awready(0) => m_axi_ddr4_csr_awready(0),
      m_axi_ddr4_csr_awvalid(0) => m_axi_ddr4_csr_awvalid(0),
      m_axi_ddr4_csr_bready(0) => m_axi_ddr4_csr_bready(0),
      m_axi_ddr4_csr_bresp(1 downto 0) => m_axi_ddr4_csr_bresp(1 downto 0),
      m_axi_ddr4_csr_bvalid(0) => m_axi_ddr4_csr_bvalid(0),
      m_axi_ddr4_csr_rdata(31 downto 0) => m_axi_ddr4_csr_rdata(31 downto 0),
      m_axi_ddr4_csr_rready(0) => m_axi_ddr4_csr_rready(0),
      m_axi_ddr4_csr_rresp(1 downto 0) => m_axi_ddr4_csr_rresp(1 downto 0),
      m_axi_ddr4_csr_rvalid(0) => m_axi_ddr4_csr_rvalid(0),
      m_axi_ddr4_csr_wdata(31 downto 0) => m_axi_ddr4_csr_wdata(31 downto 0),
      m_axi_ddr4_csr_wready(0) => m_axi_ddr4_csr_wready(0),
      m_axi_ddr4_csr_wstrb(3 downto 0) => m_axi_ddr4_csr_wstrb(3 downto 0),
      m_axi_ddr4_csr_wvalid(0) => m_axi_ddr4_csr_wvalid(0),
      m_axi_dsp_csr_araddr(25 downto 0) => m_axi_dsp_csr_araddr(25 downto 0),
      m_axi_dsp_csr_arprot(2 downto 0) => m_axi_dsp_csr_arprot(2 downto 0),
      m_axi_dsp_csr_arready => m_axi_dsp_csr_arready,
      m_axi_dsp_csr_arvalid => m_axi_dsp_csr_arvalid,
      m_axi_dsp_csr_awaddr(25 downto 0) => m_axi_dsp_csr_awaddr(25 downto 0),
      m_axi_dsp_csr_awprot(2 downto 0) => m_axi_dsp_csr_awprot(2 downto 0),
      m_axi_dsp_csr_awready => m_axi_dsp_csr_awready,
      m_axi_dsp_csr_awvalid => m_axi_dsp_csr_awvalid,
      m_axi_dsp_csr_bready => m_axi_dsp_csr_bready,
      m_axi_dsp_csr_bresp(1 downto 0) => m_axi_dsp_csr_bresp(1 downto 0),
      m_axi_dsp_csr_bvalid => m_axi_dsp_csr_bvalid,
      m_axi_dsp_csr_rdata(31 downto 0) => m_axi_dsp_csr_rdata(31 downto 0),
      m_axi_dsp_csr_rready => m_axi_dsp_csr_rready,
      m_axi_dsp_csr_rresp(1 downto 0) => m_axi_dsp_csr_rresp(1 downto 0),
      m_axi_dsp_csr_rvalid => m_axi_dsp_csr_rvalid,
      m_axi_dsp_csr_wdata(31 downto 0) => m_axi_dsp_csr_wdata(31 downto 0),
      m_axi_dsp_csr_wready => m_axi_dsp_csr_wready,
      m_axi_dsp_csr_wstrb(3 downto 0) => m_axi_dsp_csr_wstrb(3 downto 0),
      m_axi_dsp_csr_wvalid => m_axi_dsp_csr_wvalid,
      m_axi_user1_csr_araddr(25 downto 0) => m_axi_user1_csr_araddr(25 downto 0),
      m_axi_user1_csr_arprot(2 downto 0) => m_axi_user1_csr_arprot(2 downto 0),
      m_axi_user1_csr_arready => m_axi_user1_csr_arready,
      m_axi_user1_csr_arvalid => m_axi_user1_csr_arvalid,
      m_axi_user1_csr_awaddr(25 downto 0) => m_axi_user1_csr_awaddr(25 downto 0),
      m_axi_user1_csr_awprot(2 downto 0) => m_axi_user1_csr_awprot(2 downto 0),
      m_axi_user1_csr_awready => m_axi_user1_csr_awready,
      m_axi_user1_csr_awvalid => m_axi_user1_csr_awvalid,
      m_axi_user1_csr_bready => m_axi_user1_csr_bready,
      m_axi_user1_csr_bresp(1 downto 0) => m_axi_user1_csr_bresp(1 downto 0),
      m_axi_user1_csr_bvalid => m_axi_user1_csr_bvalid,
      m_axi_user1_csr_rdata(31 downto 0) => m_axi_user1_csr_rdata(31 downto 0),
      m_axi_user1_csr_rready => m_axi_user1_csr_rready,
      m_axi_user1_csr_rresp(1 downto 0) => m_axi_user1_csr_rresp(1 downto 0),
      m_axi_user1_csr_rvalid => m_axi_user1_csr_rvalid,
      m_axi_user1_csr_wdata(31 downto 0) => m_axi_user1_csr_wdata(31 downto 0),
      m_axi_user1_csr_wready => m_axi_user1_csr_wready,
      m_axi_user1_csr_wstrb(3 downto 0) => m_axi_user1_csr_wstrb(3 downto 0),
      m_axi_user1_csr_wvalid => m_axi_user1_csr_wvalid,
      m_axi_user2_csr_araddr(25 downto 0) => m_axi_user2_csr_araddr(25 downto 0),
      m_axi_user2_csr_arprot(2 downto 0) => m_axi_user2_csr_arprot(2 downto 0),
      m_axi_user2_csr_arready => m_axi_user2_csr_arready,
      m_axi_user2_csr_arvalid => m_axi_user2_csr_arvalid,
      m_axi_user2_csr_awaddr(25 downto 0) => m_axi_user2_csr_awaddr(25 downto 0),
      m_axi_user2_csr_awprot(2 downto 0) => m_axi_user2_csr_awprot(2 downto 0),
      m_axi_user2_csr_awready => m_axi_user2_csr_awready,
      m_axi_user2_csr_awvalid => m_axi_user2_csr_awvalid,
      m_axi_user2_csr_bready => m_axi_user2_csr_bready,
      m_axi_user2_csr_bresp(1 downto 0) => m_axi_user2_csr_bresp(1 downto 0),
      m_axi_user2_csr_bvalid => m_axi_user2_csr_bvalid,
      m_axi_user2_csr_rdata(31 downto 0) => m_axi_user2_csr_rdata(31 downto 0),
      m_axi_user2_csr_rready => m_axi_user2_csr_rready,
      m_axi_user2_csr_rresp(1 downto 0) => m_axi_user2_csr_rresp(1 downto 0),
      m_axi_user2_csr_rvalid => m_axi_user2_csr_rvalid,
      m_axi_user2_csr_wdata(31 downto 0) => m_axi_user2_csr_wdata(31 downto 0),
      m_axi_user2_csr_wready => m_axi_user2_csr_wready,
      m_axi_user2_csr_wstrb(3 downto 0) => m_axi_user2_csr_wstrb(3 downto 0),
      m_axi_user2_csr_wvalid => m_axi_user2_csr_wvalid,
      m_axis_ddr_rqst_tdata(511 downto 0) => m_axis_ddr_rqst_tdata(511 downto 0),
      m_axis_ddr_rqst_tid(7 downto 0) => m_axis_ddr_rqst_tid(7 downto 0),
      m_axis_ddr_rqst_tlast => m_axis_ddr_rqst_tlast,
      m_axis_ddr_rqst_tready => m_axis_ddr_rqst_tready,
      m_axis_ddr_rqst_tuser(255 downto 0) => m_axis_ddr_rqst_tuser(255 downto 0),
      m_axis_ddr_rqst_tvalid => m_axis_ddr_rqst_tvalid,
      m_axis_dma_pcie_cntl_tdata(7 downto 0) => m_axis_dma_pcie_cntl_tdata(7 downto 0),
      m_axis_dma_pcie_cntl_tvalid => m_axis_dma_pcie_cntl_tvalid,
      m_axis_pcie_rc_tdata(255 downto 0) => m_axis_pcie_rc_tdata(255 downto 0),
      m_axis_pcie_rc_tkeep(31 downto 0) => m_axis_pcie_rc_tkeep(31 downto 0),
      m_axis_pcie_rc_tlast => m_axis_pcie_rc_tlast,
      m_axis_pcie_rc_tready => m_axis_pcie_rc_tready,
      m_axis_pcie_rc_tuser(74 downto 0) => m_axis_pcie_rc_tuser(74 downto 0),
      m_axis_pcie_rc_tvalid => m_axis_pcie_rc_tvalid,
      mga(2 downto 0) => mga(2 downto 0),
      pcie_lane_led0_n => pcie_lane_led0_n,
      pcie_lane_led1_n => pcie_lane_led1_n,
      pcie_link_up => pcie_link_up,
      pcie_link_up_led_n => pcie_link_up_led_n,
      pcie_mgt_rxn(7 downto 0) => pcie_mgt_rxn(7 downto 0),
      pcie_mgt_rxp(7 downto 0) => pcie_mgt_rxp(7 downto 0),
      pcie_mgt_txn(7 downto 0) => pcie_mgt_txn(7 downto 0),
      pcie_mgt_txp(7 downto 0) => pcie_mgt_txp(7 downto 0),
      pcie_perstn_in => pcie_perstn_in,
      rev(7 downto 0) => rev(7 downto 0),
      rev_date(23 downto 0) => rev_date(23 downto 0),
      rq_shutdown_ok => rq_shutdown_ok,
      s_axis_ddr_rsp_tdata(511 downto 0) => s_axis_ddr_rsp_tdata(511 downto 0),
      s_axis_ddr_rsp_tid(7 downto 0) => s_axis_ddr_rsp_tid(7 downto 0),
      s_axis_ddr_rsp_tlast => s_axis_ddr_rsp_tlast,
      s_axis_ddr_rsp_tuser(255 downto 0) => s_axis_ddr_rsp_tuser(255 downto 0),
      s_axis_ddr_rsp_tvalid => s_axis_ddr_rsp_tvalid,
      s_axis_pcie_rq_tdata(255 downto 0) => s_axis_pcie_rq_tdata(255 downto 0),
      s_axis_pcie_rq_tkeep(31 downto 0) => s_axis_pcie_rq_tkeep(31 downto 0),
      s_axis_pcie_rq_tlast => s_axis_pcie_rq_tlast,
      s_axis_pcie_rq_tready => s_axis_pcie_rq_tready,
      s_axis_pcie_rq_tuser(59 downto 0) => s_axis_pcie_rq_tuser(59 downto 0),
      s_axis_pcie_rq_tvalid => s_axis_pcie_rq_tvalid,
      shutdown_rqst => shutdown_rqst,
      startup_eos_in => startup_eos_in,
      sys_clk => sys_clk,
      sys_clk_gt => sys_clk_gt,
      sys_mon_alarm => sys_mon_alarm,
      sys_mon_led_n => sys_mon_led_n,
      temp_irq_n => temp_irq_n,
      time_irq => time_irq,
      user1_irq(1 downto 0) => user1_irq(1 downto 0),
      user2_irq(1 downto 0) => user2_irq(1 downto 0),
      user_led_n => user_led_n
    );
end STRUCTURE;
