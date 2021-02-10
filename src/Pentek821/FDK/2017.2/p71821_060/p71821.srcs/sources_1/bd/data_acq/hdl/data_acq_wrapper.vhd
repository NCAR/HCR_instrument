--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
--Date        : Fri Jan 22 18:25:59 2021
--Host        : apararchiver running 64-bit CentOS Linux release 8.0.1905 (Core)
--Command     : generate_target data_acq_wrapper.bd
--Design      : data_acq_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity data_acq_wrapper is
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
    m_axis_ddr_rqst_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
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
    s_axis_dma_pcie_cntl_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_dma_pcie_cntl_tready : out STD_LOGIC;
    s_axis_dma_pcie_cntl_tvalid : in STD_LOGIC;
    s_axis_pcie_rc_tdata : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_pcie_rc_tkeep : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_pcie_rc_tlast : in STD_LOGIC;
    s_axis_pcie_rc_tready : out STD_LOGIC;
    s_axis_pcie_rc_tuser : in STD_LOGIC_VECTOR ( 74 downto 0 );
    s_axis_pcie_rc_tvalid : in STD_LOGIC;
    s_axis_wave_ddr_rsp_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_wave_ddr_rsp_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_wave_ddr_rsp_tlast : in STD_LOGIC;
    s_axis_wave_ddr_rsp_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_wave_ddr_rsp_tvalid : in STD_LOGIC;
    shutdown_rqst : in STD_LOGIC
  );
end data_acq_wrapper;

architecture STRUCTURE of data_acq_wrapper is
  component data_acq is
  port (
    s_axis_dac_pctl_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_dac_pctl_tvalid : in STD_LOGIC;
    s_axis_dma_pcie_cntl_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_dma_pcie_cntl_tready : out STD_LOGIC;
    s_axis_dma_pcie_cntl_tvalid : in STD_LOGIC;
    m_axis_pcie_rq_tvalid : out STD_LOGIC;
    m_axis_pcie_rq_tready : in STD_LOGIC;
    m_axis_pcie_rq_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_pcie_rq_tkeep : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_pcie_rq_tlast : out STD_LOGIC;
    m_axis_pcie_rq_tuser : out STD_LOGIC_VECTOR ( 59 downto 0 );
    s_axis_pcie_rc_tdata : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_pcie_rc_tkeep : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_pcie_rc_tlast : in STD_LOGIC;
    s_axis_pcie_rc_tready : out STD_LOGIC;
    s_axis_pcie_rc_tuser : in STD_LOGIC_VECTOR ( 74 downto 0 );
    s_axis_pcie_rc_tvalid : in STD_LOGIC;
    m_axis_ddr_rqst_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_ddr_rqst_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_ddr_rqst_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_ddr_rqst_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_ddr_rqst_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_ddr_rqst_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_wave_ddr_rsp_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_wave_ddr_rsp_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_wave_ddr_rsp_tlast : in STD_LOGIC;
    s_axis_wave_ddr_rsp_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_wave_ddr_rsp_tvalid : in STD_LOGIC;
    m_axis_dac_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_dac_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_dac_pdti_tvalid : out STD_LOGIC;
    s_axi_csr_aclk : in STD_LOGIC;
    s_axi_csr_aresetn : in STD_LOGIC;
    s_axis_adc_pdti_aclk : in STD_LOGIC;
    s_axis_adc_pdti_aresetn : in STD_LOGIC;
    shutdown_rqst : in STD_LOGIC;
    rq_shutdown_ok : out STD_LOGIC;
    pcie_dma_irq : out STD_LOGIC_VECTOR ( 15 downto 0 );
    adc0_fifo_full_stat : out STD_LOGIC;
    pdti2ppkt_irq : out STD_LOGIC_VECTOR ( 0 to 0 );
    realtime_lost_stat : out STD_LOGIC;
    s_axis_dac_pdti_aclk : in STD_LOGIC;
    s_axis_dac_pdti_aresetn : in STD_LOGIC;
    adc1_fifo_full_stat : out STD_LOGIC;
    adc2_fifo_full_stat : out STD_LOGIC;
    ddr4_ui_clk : in STD_LOGIC;
    s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
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
    s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 25 downto 0 );
    s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_arvalid : in STD_LOGIC;
    s_axi_csr_arready : out STD_LOGIC;
    s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_rvalid : out STD_LOGIC;
    s_axi_csr_rready : in STD_LOGIC;
    s_axis_adc_ch2_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_adc_ch2_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_adc_ch2_pdti_tvalid : in STD_LOGIC;
    s_axis_adc_ch1_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_adc_ch1_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_adc_ch1_pdti_tvalid : in STD_LOGIC;
    s_axis_adc_ch0_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_adc_ch0_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_adc_ch0_pdti_tvalid : in STD_LOGIC
  );
  end component data_acq;
begin
data_acq_i: component data_acq
     port map (
      adc0_fifo_full_stat => adc0_fifo_full_stat,
      adc1_fifo_full_stat => adc1_fifo_full_stat,
      adc2_fifo_full_stat => adc2_fifo_full_stat,
      ddr4_ui_clk => ddr4_ui_clk,
      m_axis_dac_pdti_tdata(31 downto 0) => m_axis_dac_pdti_tdata(31 downto 0),
      m_axis_dac_pdti_tuser(127 downto 0) => m_axis_dac_pdti_tuser(127 downto 0),
      m_axis_dac_pdti_tvalid => m_axis_dac_pdti_tvalid,
      m_axis_ddr_rqst_tdata(511 downto 0) => m_axis_ddr_rqst_tdata(511 downto 0),
      m_axis_ddr_rqst_tid(7 downto 0) => m_axis_ddr_rqst_tid(7 downto 0),
      m_axis_ddr_rqst_tlast(0) => m_axis_ddr_rqst_tlast(0),
      m_axis_ddr_rqst_tready(0) => m_axis_ddr_rqst_tready(0),
      m_axis_ddr_rqst_tuser(255 downto 0) => m_axis_ddr_rqst_tuser(255 downto 0),
      m_axis_ddr_rqst_tvalid(0) => m_axis_ddr_rqst_tvalid(0),
      m_axis_pcie_rq_tdata(255 downto 0) => m_axis_pcie_rq_tdata(255 downto 0),
      m_axis_pcie_rq_tkeep(31 downto 0) => m_axis_pcie_rq_tkeep(31 downto 0),
      m_axis_pcie_rq_tlast => m_axis_pcie_rq_tlast,
      m_axis_pcie_rq_tready => m_axis_pcie_rq_tready,
      m_axis_pcie_rq_tuser(59 downto 0) => m_axis_pcie_rq_tuser(59 downto 0),
      m_axis_pcie_rq_tvalid => m_axis_pcie_rq_tvalid,
      pcie_dma_irq(15 downto 0) => pcie_dma_irq(15 downto 0),
      pdti2ppkt_irq(0) => pdti2ppkt_irq(0),
      realtime_lost_stat => realtime_lost_stat,
      rq_shutdown_ok => rq_shutdown_ok,
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
      s_axis_adc_ch0_pdti_tdata(31 downto 0) => s_axis_adc_ch0_pdti_tdata(31 downto 0),
      s_axis_adc_ch0_pdti_tuser(127 downto 0) => s_axis_adc_ch0_pdti_tuser(127 downto 0),
      s_axis_adc_ch0_pdti_tvalid => s_axis_adc_ch0_pdti_tvalid,
      s_axis_adc_ch1_pdti_tdata(31 downto 0) => s_axis_adc_ch1_pdti_tdata(31 downto 0),
      s_axis_adc_ch1_pdti_tuser(127 downto 0) => s_axis_adc_ch1_pdti_tuser(127 downto 0),
      s_axis_adc_ch1_pdti_tvalid => s_axis_adc_ch1_pdti_tvalid,
      s_axis_adc_ch2_pdti_tdata(31 downto 0) => s_axis_adc_ch2_pdti_tdata(31 downto 0),
      s_axis_adc_ch2_pdti_tuser(127 downto 0) => s_axis_adc_ch2_pdti_tuser(127 downto 0),
      s_axis_adc_ch2_pdti_tvalid => s_axis_adc_ch2_pdti_tvalid,
      s_axis_adc_pdti_aclk => s_axis_adc_pdti_aclk,
      s_axis_adc_pdti_aresetn => s_axis_adc_pdti_aresetn,
      s_axis_dac_pctl_tdata(7 downto 0) => s_axis_dac_pctl_tdata(7 downto 0),
      s_axis_dac_pctl_tvalid => s_axis_dac_pctl_tvalid,
      s_axis_dac_pdti_aclk => s_axis_dac_pdti_aclk,
      s_axis_dac_pdti_aresetn => s_axis_dac_pdti_aresetn,
      s_axis_dma_pcie_cntl_tdata(7 downto 0) => s_axis_dma_pcie_cntl_tdata(7 downto 0),
      s_axis_dma_pcie_cntl_tready => s_axis_dma_pcie_cntl_tready,
      s_axis_dma_pcie_cntl_tvalid => s_axis_dma_pcie_cntl_tvalid,
      s_axis_pcie_rc_tdata(255 downto 0) => s_axis_pcie_rc_tdata(255 downto 0),
      s_axis_pcie_rc_tkeep(31 downto 0) => s_axis_pcie_rc_tkeep(31 downto 0),
      s_axis_pcie_rc_tlast => s_axis_pcie_rc_tlast,
      s_axis_pcie_rc_tready => s_axis_pcie_rc_tready,
      s_axis_pcie_rc_tuser(74 downto 0) => s_axis_pcie_rc_tuser(74 downto 0),
      s_axis_pcie_rc_tvalid => s_axis_pcie_rc_tvalid,
      s_axis_wave_ddr_rsp_tdata(511 downto 0) => s_axis_wave_ddr_rsp_tdata(511 downto 0),
      s_axis_wave_ddr_rsp_tid(7 downto 0) => s_axis_wave_ddr_rsp_tid(7 downto 0),
      s_axis_wave_ddr_rsp_tlast => s_axis_wave_ddr_rsp_tlast,
      s_axis_wave_ddr_rsp_tuser(255 downto 0) => s_axis_wave_ddr_rsp_tuser(255 downto 0),
      s_axis_wave_ddr_rsp_tvalid => s_axis_wave_ddr_rsp_tvalid,
      shutdown_rqst => shutdown_rqst
    );
end STRUCTURE;
