--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
--Date        : Fri Jun  1 09:09:53 2018
--Host        : DESKTOP-AI6ONV9 running 64-bit major release  (build 9200)
--Command     : generate_target data_width_converter.bd
--Design      : data_width_converter
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity data_width_converter is
  port (
    M_AXIS_0_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXIS_0_tready : in STD_LOGIC;
    M_AXIS_0_tvalid : out STD_LOGIC;
    S_AXIS_0_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    S_AXIS_0_tready : out STD_LOGIC;
    S_AXIS_0_tvalid : in STD_LOGIC;
    m_axis_aclk_0 : in STD_LOGIC;
    m_axis_aresetn_0 : in STD_LOGIC;
    s_axis_aclk_0 : in STD_LOGIC;
    s_axis_aresetn_0 : in STD_LOGIC
  );

  end data_width_converter;

architecture STRUCTURE of data_width_converter is

  component axis_clock_converter_0 is
  port (
    s_axis_aresetn : in STD_LOGIC;
    m_axis_aresetn : in STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_aclk : in STD_LOGIC;
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  end component axis_clock_converter_0;
  
  component axis_dwidth_converter_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 )
  );
  end component axis_dwidth_converter_0;
  
  
  signal S_AXIS_0_1_TDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal S_AXIS_0_1_TREADY : STD_LOGIC;
  signal S_AXIS_0_1_TVALID : STD_LOGIC;
  signal axis_clock_converter_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal axis_clock_converter_0_M_AXIS_TREADY : STD_LOGIC;
  signal axis_clock_converter_0_M_AXIS_TVALID : STD_LOGIC;
  signal axis_dwidth_converter_0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal axis_dwidth_converter_0_M_AXIS_TREADY : STD_LOGIC;
  signal axis_dwidth_converter_0_M_AXIS_TVALID : STD_LOGIC;
  signal m_axis_aclk_0_1 : STD_LOGIC;
  signal m_axis_aresetn_0_1 : STD_LOGIC;
  signal s_axis_aclk_0_1 : STD_LOGIC;
  signal s_axis_aresetn_0_1 : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of M_AXIS_0_tready : signal is "xilinx.com:interface:axis:1.0 M_AXIS_0 TREADY";
  attribute X_INTERFACE_INFO of M_AXIS_0_tvalid : signal is "xilinx.com:interface:axis:1.0 M_AXIS_0 TVALID";
  attribute X_INTERFACE_INFO of S_AXIS_0_tready : signal is "xilinx.com:interface:axis:1.0 S_AXIS_0 TREADY";
  attribute X_INTERFACE_INFO of S_AXIS_0_tvalid : signal is "xilinx.com:interface:axis:1.0 S_AXIS_0 TVALID";
  attribute X_INTERFACE_INFO of m_axis_aclk_0 : signal is "xilinx.com:signal:clock:1.0 CLK.M_AXIS_ACLK_0 CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of m_axis_aclk_0 : signal is "XIL_INTERFACENAME CLK.M_AXIS_ACLK_0, ASSOCIATED_BUSIF M_AXIS_0, ASSOCIATED_RESET m_axis_aresetn_0, CLK_DOMAIN data_width_converter_m_axis_aclk_0, FREQ_HZ 100000000, PHASE 0.000";
  attribute X_INTERFACE_INFO of m_axis_aresetn_0 : signal is "xilinx.com:signal:reset:1.0 RST.M_AXIS_ARESETN_0 RST";
  attribute X_INTERFACE_PARAMETER of m_axis_aresetn_0 : signal is "XIL_INTERFACENAME RST.M_AXIS_ARESETN_0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of s_axis_aclk_0 : signal is "xilinx.com:signal:clock:1.0 CLK.S_AXIS_ACLK_0 CLK";
  attribute X_INTERFACE_PARAMETER of s_axis_aclk_0 : signal is "XIL_INTERFACENAME CLK.S_AXIS_ACLK_0, ASSOCIATED_BUSIF S_AXIS_0, ASSOCIATED_RESET s_axis_aresetn_0, CLK_DOMAIN data_width_converter_s_axis_aclk_0, FREQ_HZ 100000000, PHASE 0.000";
  attribute X_INTERFACE_INFO of s_axis_aresetn_0 : signal is "xilinx.com:signal:reset:1.0 RST.S_AXIS_ARESETN_0 RST";
  attribute X_INTERFACE_PARAMETER of s_axis_aresetn_0 : signal is "XIL_INTERFACENAME RST.S_AXIS_ARESETN_0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of M_AXIS_0_tdata : signal is "xilinx.com:interface:axis:1.0 M_AXIS_0 TDATA";
  attribute X_INTERFACE_PARAMETER of M_AXIS_0_tdata : signal is "XIL_INTERFACENAME M_AXIS_0, CLK_DOMAIN data_width_converter_m_axis_aclk_0, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of S_AXIS_0_tdata : signal is "xilinx.com:interface:axis:1.0 S_AXIS_0 TDATA";
  attribute X_INTERFACE_PARAMETER of S_AXIS_0_tdata : signal is "XIL_INTERFACENAME S_AXIS_0, CLK_DOMAIN data_width_converter_s_axis_aclk_0, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 16, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";

  
  begin
  
  M_AXIS_0_tdata(63 downto 0) <= axis_dwidth_converter_0_M_AXIS_TDATA(63 downto 0);
  M_AXIS_0_tvalid <= axis_dwidth_converter_0_M_AXIS_TVALID;
  S_AXIS_0_1_TDATA(127 downto 0) <= S_AXIS_0_tdata(127 downto 0);
  S_AXIS_0_1_TVALID <= S_AXIS_0_tvalid;
  S_AXIS_0_tready <= S_AXIS_0_1_TREADY;
  axis_dwidth_converter_0_M_AXIS_TREADY <= M_AXIS_0_tready;
  m_axis_aclk_0_1 <= m_axis_aclk_0;
  m_axis_aresetn_0_1 <= m_axis_aresetn_0;
  s_axis_aclk_0_1 <= s_axis_aclk_0;
  s_axis_aresetn_0_1 <= s_axis_aresetn_0;
  
axis_clock_converter_inst: axis_clock_converter_0
     port map (
      m_axis_aclk => m_axis_aclk_0_1,
      m_axis_aresetn => m_axis_aresetn_0_1,
      m_axis_tdata(127 downto 0) => axis_clock_converter_0_M_AXIS_TDATA(127 downto 0),
      m_axis_tready => axis_clock_converter_0_M_AXIS_TREADY,
      m_axis_tvalid => axis_clock_converter_0_M_AXIS_TVALID,
      s_axis_aclk => s_axis_aclk_0_1,
      s_axis_aresetn => s_axis_aresetn_0_1,
      s_axis_tdata(127 downto 0) => S_AXIS_0_1_TDATA(127 downto 0),
      s_axis_tready => S_AXIS_0_1_TREADY,
      s_axis_tvalid => S_AXIS_0_1_TVALID
    );
axis_dwidth_converter_inst: axis_dwidth_converter_0
     port map (
      aclk => m_axis_aclk_0_1,
      aresetn => m_axis_aresetn_0_1,
      m_axis_tdata(63 downto 0) => axis_dwidth_converter_0_M_AXIS_TDATA(63 downto 0),
      m_axis_tready => axis_dwidth_converter_0_M_AXIS_TREADY,
      m_axis_tvalid => axis_dwidth_converter_0_M_AXIS_TVALID,
      s_axis_tdata(127 downto 0) => axis_clock_converter_0_M_AXIS_TDATA(127 downto 0),
      s_axis_tready => axis_clock_converter_0_M_AXIS_TREADY,
      s_axis_tvalid => axis_clock_converter_0_M_AXIS_TVALID
    );
	
end STRUCTURE;
