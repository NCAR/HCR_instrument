--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
--Date        : Fri Mar 19 18:48:58 2021
--Host        : apararchiver running 64-bit CentOS Linux release 8.0.1905 (Core)
--Command     : generate_target user_block2_wrapper.bd
--Design      : user_block2_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_wrapper is
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
end user_block2_wrapper;

architecture STRUCTURE of user_block2_wrapper is
  component user_block2 is
  port (
    m_axis_dac_pdti_tvalid : out STD_LOGIC;
    m_axis_dac_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_dac_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_dac_pdti_tvalid : in STD_LOGIC;
    s_axis_dac_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_dac_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    user2_irq : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_dac_pdti_aclk : in STD_LOGIC;
    s_axis_dac_pdti_aresetn : in STD_LOGIC;
    s_axis_adc_pdti_aclk : in STD_LOGIC;
    filter_select_ch0 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    filter_select_ch1 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    filter_select_ch2 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    control_flags : out STD_LOGIC_VECTOR ( 31 downto 0 );
    mt_pulse : out STD_LOGIC_VECTOR ( 7 downto 0 );
    status_flags : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_adc_pdti_aresetn : in STD_LOGIC;
    s_axi_csr_aresetn : in STD_LOGIC;
    s_axi_csr_aclk : in STD_LOGIC;
    controller_PPS : in STD_LOGIC;
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
    m_axis_adc_ch2_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_adc_ch2_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_adc_ch2_pdti_tvalid : out STD_LOGIC;
    s_axis_adc_ch2_pdti_tvalid : in STD_LOGIC;
    s_axis_adc_ch2_pdti_tready : out STD_LOGIC;
    s_axis_adc_ch2_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_adc_ch2_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_adc_ch1_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_adc_ch1_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_adc_ch1_pdti_tvalid : out STD_LOGIC;
    s_axis_adc_ch1_pdti_tvalid : in STD_LOGIC;
    s_axis_adc_ch1_pdti_tready : out STD_LOGIC;
    s_axis_adc_ch1_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_adc_ch1_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_adc_ch0_pdti_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_adc_ch0_pdti_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_adc_ch0_pdti_tvalid : out STD_LOGIC;
    s_axis_adc_ch0_pdti_tvalid : in STD_LOGIC;
    s_axis_adc_ch0_pdti_tready : out STD_LOGIC;
    s_axis_adc_ch0_pdti_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_adc_ch0_pdti_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  end component user_block2;
begin
user_block2_i: component user_block2
     port map (
      AZ_MOSI => AZ_MOSI,
      AZ_SCK => AZ_SCK,
      AZ_SSEL => AZ_SSEL,
      EL_MOSI => EL_MOSI,
      EL_SCK => EL_SCK,
      EL_SSEL => EL_SSEL,
      ROT_A => ROT_A,
      ROT_B => ROT_B,
      TILT_A => TILT_A,
      TILT_B => TILT_B,
      control_flags(31 downto 0) => control_flags(31 downto 0),
      controller_PPS => controller_PPS,
      filter_select_ch0(1 downto 0) => filter_select_ch0(1 downto 0),
      filter_select_ch1(1 downto 0) => filter_select_ch1(1 downto 0),
      filter_select_ch2(1 downto 0) => filter_select_ch2(1 downto 0),
      m_axis_adc_ch0_pdti_tdata(31 downto 0) => m_axis_adc_ch0_pdti_tdata(31 downto 0),
      m_axis_adc_ch0_pdti_tuser(127 downto 0) => m_axis_adc_ch0_pdti_tuser(127 downto 0),
      m_axis_adc_ch0_pdti_tvalid => m_axis_adc_ch0_pdti_tvalid,
      m_axis_adc_ch1_pdti_tdata(31 downto 0) => m_axis_adc_ch1_pdti_tdata(31 downto 0),
      m_axis_adc_ch1_pdti_tuser(127 downto 0) => m_axis_adc_ch1_pdti_tuser(127 downto 0),
      m_axis_adc_ch1_pdti_tvalid => m_axis_adc_ch1_pdti_tvalid,
      m_axis_adc_ch2_pdti_tdata(31 downto 0) => m_axis_adc_ch2_pdti_tdata(31 downto 0),
      m_axis_adc_ch2_pdti_tuser(127 downto 0) => m_axis_adc_ch2_pdti_tuser(127 downto 0),
      m_axis_adc_ch2_pdti_tvalid => m_axis_adc_ch2_pdti_tvalid,
      m_axis_dac_pdti_tdata(31 downto 0) => m_axis_dac_pdti_tdata(31 downto 0),
      m_axis_dac_pdti_tuser(127 downto 0) => m_axis_dac_pdti_tuser(127 downto 0),
      m_axis_dac_pdti_tvalid => m_axis_dac_pdti_tvalid,
      mt_pulse(7 downto 0) => mt_pulse(7 downto 0),
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
      s_axis_adc_ch0_pdti_tready => s_axis_adc_ch0_pdti_tready,
      s_axis_adc_ch0_pdti_tuser(127 downto 0) => s_axis_adc_ch0_pdti_tuser(127 downto 0),
      s_axis_adc_ch0_pdti_tvalid => s_axis_adc_ch0_pdti_tvalid,
      s_axis_adc_ch1_pdti_tdata(31 downto 0) => s_axis_adc_ch1_pdti_tdata(31 downto 0),
      s_axis_adc_ch1_pdti_tready => s_axis_adc_ch1_pdti_tready,
      s_axis_adc_ch1_pdti_tuser(127 downto 0) => s_axis_adc_ch1_pdti_tuser(127 downto 0),
      s_axis_adc_ch1_pdti_tvalid => s_axis_adc_ch1_pdti_tvalid,
      s_axis_adc_ch2_pdti_tdata(31 downto 0) => s_axis_adc_ch2_pdti_tdata(31 downto 0),
      s_axis_adc_ch2_pdti_tready => s_axis_adc_ch2_pdti_tready,
      s_axis_adc_ch2_pdti_tuser(127 downto 0) => s_axis_adc_ch2_pdti_tuser(127 downto 0),
      s_axis_adc_ch2_pdti_tvalid => s_axis_adc_ch2_pdti_tvalid,
      s_axis_adc_pdti_aclk => s_axis_adc_pdti_aclk,
      s_axis_adc_pdti_aresetn => s_axis_adc_pdti_aresetn,
      s_axis_dac_pdti_aclk => s_axis_dac_pdti_aclk,
      s_axis_dac_pdti_aresetn => s_axis_dac_pdti_aresetn,
      s_axis_dac_pdti_tdata(31 downto 0) => s_axis_dac_pdti_tdata(31 downto 0),
      s_axis_dac_pdti_tuser(127 downto 0) => s_axis_dac_pdti_tuser(127 downto 0),
      s_axis_dac_pdti_tvalid => s_axis_dac_pdti_tvalid,
      status_flags(15 downto 0) => status_flags(15 downto 0),
      user2_irq(1 downto 0) => user2_irq(1 downto 0)
    );
end STRUCTURE;
