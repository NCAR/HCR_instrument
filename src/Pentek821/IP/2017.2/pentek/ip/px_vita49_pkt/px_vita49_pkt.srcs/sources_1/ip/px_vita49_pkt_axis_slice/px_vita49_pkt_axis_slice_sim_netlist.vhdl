-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2.1 (win64) Build 1957588 Wed Aug  9 16:32:24 MDT 2017
-- Date        : Thu Oct 26 16:19:10 2017
-- Host        : Mike-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/pentek/ip/2017.2/wip/px_vita49_pkt/px_vita49_pkt.srcs/sources_1/ip/px_vita49_pkt_axis_slice/px_vita49_pkt_axis_slice_sim_netlist.vhdl
-- Design      : px_vita49_pkt_axis_slice
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku035-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axisc_register_slice is
  port (
    Q : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tuser : out STD_LOGIC_VECTOR ( 79 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 116 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axisc_register_slice : entity is "axis_register_slice_v1_1_13_axisc_register_slice";
end px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axisc_register_slice;

architecture STRUCTURE of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axisc_register_slice is
  signal \^q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \gen_AB_reg_slice.payload_a[116]_i_1_n_0\ : STD_LOGIC;
  signal \gen_AB_reg_slice.sel_rd_i_1_n_0\ : STD_LOGIC;
  signal \gen_AB_reg_slice.sel_wr_i_1_n_0\ : STD_LOGIC;
  signal \gen_AB_reg_slice.state[1]_i_1_n_0\ : STD_LOGIC;
  signal payload_a : STD_LOGIC_VECTOR ( 116 downto 0 );
  signal payload_b : STD_LOGIC_VECTOR ( 116 downto 0 );
  signal payload_b_0 : STD_LOGIC;
  signal sel : STD_LOGIC;
  signal sel_wr : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_AB_reg_slice.state[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \gen_AB_reg_slice.state[1]_i_2\ : label is "soft_lutpair0";
  attribute FSM_ENCODING : string;
  attribute FSM_ENCODING of \gen_AB_reg_slice.state_reg[0]\ : label is "none";
  attribute FSM_ENCODING of \gen_AB_reg_slice.state_reg[1]\ : label is "none";
  attribute SOFT_HLUTNM of \m_axis_tdata[0]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \m_axis_tdata[10]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_axis_tdata[11]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_axis_tdata[12]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \m_axis_tdata[13]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \m_axis_tdata[14]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \m_axis_tdata[15]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \m_axis_tdata[16]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \m_axis_tdata[17]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \m_axis_tdata[18]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \m_axis_tdata[19]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \m_axis_tdata[1]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \m_axis_tdata[20]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \m_axis_tdata[21]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \m_axis_tdata[22]_INST_0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \m_axis_tdata[23]_INST_0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \m_axis_tdata[24]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \m_axis_tdata[25]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \m_axis_tdata[26]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \m_axis_tdata[27]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \m_axis_tdata[28]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \m_axis_tdata[29]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \m_axis_tdata[2]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \m_axis_tdata[30]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \m_axis_tdata[31]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \m_axis_tdata[3]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \m_axis_tdata[4]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \m_axis_tdata[5]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \m_axis_tdata[6]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \m_axis_tdata[7]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \m_axis_tdata[8]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \m_axis_tdata[9]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \m_axis_tkeep[0]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \m_axis_tkeep[1]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \m_axis_tkeep[2]_INST_0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \m_axis_tkeep[3]_INST_0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of m_axis_tlast_INST_0 : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \m_axis_tuser[0]_INST_0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \m_axis_tuser[10]_INST_0\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \m_axis_tuser[11]_INST_0\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \m_axis_tuser[12]_INST_0\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \m_axis_tuser[13]_INST_0\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \m_axis_tuser[14]_INST_0\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \m_axis_tuser[15]_INST_0\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \m_axis_tuser[16]_INST_0\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \m_axis_tuser[17]_INST_0\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \m_axis_tuser[18]_INST_0\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \m_axis_tuser[19]_INST_0\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \m_axis_tuser[1]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \m_axis_tuser[20]_INST_0\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \m_axis_tuser[21]_INST_0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \m_axis_tuser[22]_INST_0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \m_axis_tuser[23]_INST_0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \m_axis_tuser[24]_INST_0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \m_axis_tuser[25]_INST_0\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \m_axis_tuser[26]_INST_0\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \m_axis_tuser[27]_INST_0\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \m_axis_tuser[28]_INST_0\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \m_axis_tuser[29]_INST_0\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \m_axis_tuser[2]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \m_axis_tuser[30]_INST_0\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \m_axis_tuser[31]_INST_0\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \m_axis_tuser[32]_INST_0\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \m_axis_tuser[33]_INST_0\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \m_axis_tuser[34]_INST_0\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \m_axis_tuser[35]_INST_0\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \m_axis_tuser[36]_INST_0\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \m_axis_tuser[37]_INST_0\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \m_axis_tuser[38]_INST_0\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \m_axis_tuser[39]_INST_0\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \m_axis_tuser[3]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \m_axis_tuser[40]_INST_0\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \m_axis_tuser[41]_INST_0\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \m_axis_tuser[42]_INST_0\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \m_axis_tuser[43]_INST_0\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \m_axis_tuser[44]_INST_0\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \m_axis_tuser[45]_INST_0\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \m_axis_tuser[46]_INST_0\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \m_axis_tuser[47]_INST_0\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \m_axis_tuser[48]_INST_0\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \m_axis_tuser[49]_INST_0\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \m_axis_tuser[4]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \m_axis_tuser[50]_INST_0\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \m_axis_tuser[51]_INST_0\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \m_axis_tuser[52]_INST_0\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \m_axis_tuser[53]_INST_0\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \m_axis_tuser[54]_INST_0\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \m_axis_tuser[55]_INST_0\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \m_axis_tuser[56]_INST_0\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \m_axis_tuser[57]_INST_0\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \m_axis_tuser[58]_INST_0\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \m_axis_tuser[59]_INST_0\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \m_axis_tuser[5]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \m_axis_tuser[60]_INST_0\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \m_axis_tuser[61]_INST_0\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \m_axis_tuser[62]_INST_0\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \m_axis_tuser[63]_INST_0\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \m_axis_tuser[64]_INST_0\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \m_axis_tuser[65]_INST_0\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \m_axis_tuser[66]_INST_0\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \m_axis_tuser[67]_INST_0\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \m_axis_tuser[68]_INST_0\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \m_axis_tuser[69]_INST_0\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \m_axis_tuser[6]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \m_axis_tuser[70]_INST_0\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \m_axis_tuser[71]_INST_0\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \m_axis_tuser[72]_INST_0\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \m_axis_tuser[73]_INST_0\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \m_axis_tuser[74]_INST_0\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \m_axis_tuser[75]_INST_0\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \m_axis_tuser[76]_INST_0\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \m_axis_tuser[77]_INST_0\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \m_axis_tuser[78]_INST_0\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \m_axis_tuser[7]_INST_0\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \m_axis_tuser[8]_INST_0\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \m_axis_tuser[9]_INST_0\ : label is "soft_lutpair24";
begin
  Q(1 downto 0) <= \^q\(1 downto 0);
\gen_AB_reg_slice.payload_a[116]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00B0"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => aclken,
      I3 => sel_wr,
      O => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\
    );
\gen_AB_reg_slice.payload_a_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(0),
      Q => payload_a(0),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[100]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(100),
      Q => payload_a(100),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[101]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(101),
      Q => payload_a(101),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[102]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(102),
      Q => payload_a(102),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[103]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(103),
      Q => payload_a(103),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[104]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(104),
      Q => payload_a(104),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[105]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(105),
      Q => payload_a(105),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[106]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(106),
      Q => payload_a(106),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[107]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(107),
      Q => payload_a(107),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[108]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(108),
      Q => payload_a(108),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[109]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(109),
      Q => payload_a(109),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(10),
      Q => payload_a(10),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[110]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(110),
      Q => payload_a(110),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[111]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(111),
      Q => payload_a(111),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[112]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(112),
      Q => payload_a(112),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[113]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(113),
      Q => payload_a(113),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[114]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(114),
      Q => payload_a(114),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[115]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(115),
      Q => payload_a(115),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[116]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(116),
      Q => payload_a(116),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(11),
      Q => payload_a(11),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(12),
      Q => payload_a(12),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(13),
      Q => payload_a(13),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(14),
      Q => payload_a(14),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(15),
      Q => payload_a(15),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(16),
      Q => payload_a(16),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(17),
      Q => payload_a(17),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(18),
      Q => payload_a(18),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(19),
      Q => payload_a(19),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(1),
      Q => payload_a(1),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(20),
      Q => payload_a(20),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(21),
      Q => payload_a(21),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(22),
      Q => payload_a(22),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(23),
      Q => payload_a(23),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(24),
      Q => payload_a(24),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(25),
      Q => payload_a(25),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(26),
      Q => payload_a(26),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(27),
      Q => payload_a(27),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(28),
      Q => payload_a(28),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(29),
      Q => payload_a(29),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(2),
      Q => payload_a(2),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(30),
      Q => payload_a(30),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(31),
      Q => payload_a(31),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(32),
      Q => payload_a(32),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(33),
      Q => payload_a(33),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(34),
      Q => payload_a(34),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(35),
      Q => payload_a(35),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(36),
      Q => payload_a(36),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(37),
      Q => payload_a(37),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(38),
      Q => payload_a(38),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(39),
      Q => payload_a(39),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(3),
      Q => payload_a(3),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(40),
      Q => payload_a(40),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(41),
      Q => payload_a(41),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(42),
      Q => payload_a(42),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(43),
      Q => payload_a(43),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(44),
      Q => payload_a(44),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(45),
      Q => payload_a(45),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(46),
      Q => payload_a(46),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(47),
      Q => payload_a(47),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(48),
      Q => payload_a(48),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(49),
      Q => payload_a(49),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(4),
      Q => payload_a(4),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(50),
      Q => payload_a(50),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(51),
      Q => payload_a(51),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(52),
      Q => payload_a(52),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(53),
      Q => payload_a(53),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(54),
      Q => payload_a(54),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(55),
      Q => payload_a(55),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(56),
      Q => payload_a(56),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(57),
      Q => payload_a(57),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(58),
      Q => payload_a(58),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(59),
      Q => payload_a(59),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(5),
      Q => payload_a(5),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(60),
      Q => payload_a(60),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(61),
      Q => payload_a(61),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(62),
      Q => payload_a(62),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(63),
      Q => payload_a(63),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(64),
      Q => payload_a(64),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(65),
      Q => payload_a(65),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(66),
      Q => payload_a(66),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(67),
      Q => payload_a(67),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(68),
      Q => payload_a(68),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(69),
      Q => payload_a(69),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(6),
      Q => payload_a(6),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(70),
      Q => payload_a(70),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(71),
      Q => payload_a(71),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(72),
      Q => payload_a(72),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[73]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(73),
      Q => payload_a(73),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[74]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(74),
      Q => payload_a(74),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[75]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(75),
      Q => payload_a(75),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[76]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(76),
      Q => payload_a(76),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[77]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(77),
      Q => payload_a(77),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[78]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(78),
      Q => payload_a(78),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[79]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(79),
      Q => payload_a(79),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(7),
      Q => payload_a(7),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[80]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(80),
      Q => payload_a(80),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[81]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(81),
      Q => payload_a(81),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[82]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(82),
      Q => payload_a(82),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[83]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(83),
      Q => payload_a(83),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[84]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(84),
      Q => payload_a(84),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[85]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(85),
      Q => payload_a(85),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[86]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(86),
      Q => payload_a(86),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[87]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(87),
      Q => payload_a(87),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[88]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(88),
      Q => payload_a(88),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[89]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(89),
      Q => payload_a(89),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(8),
      Q => payload_a(8),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[90]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(90),
      Q => payload_a(90),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[91]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(91),
      Q => payload_a(91),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[92]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(92),
      Q => payload_a(92),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[93]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(93),
      Q => payload_a(93),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[94]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(94),
      Q => payload_a(94),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[95]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(95),
      Q => payload_a(95),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[96]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(96),
      Q => payload_a(96),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[97]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(97),
      Q => payload_a(97),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[98]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(98),
      Q => payload_a(98),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[99]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(99),
      Q => payload_a(99),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_AB_reg_slice.payload_a[116]_i_1_n_0\,
      D => D(9),
      Q => payload_a(9),
      R => '0'
    );
\gen_AB_reg_slice.payload_b[116]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B000"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => aclken,
      I3 => sel_wr,
      O => payload_b_0
    );
\gen_AB_reg_slice.payload_b_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(0),
      Q => payload_b(0),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[100]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(100),
      Q => payload_b(100),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[101]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(101),
      Q => payload_b(101),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[102]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(102),
      Q => payload_b(102),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[103]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(103),
      Q => payload_b(103),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[104]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(104),
      Q => payload_b(104),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[105]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(105),
      Q => payload_b(105),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[106]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(106),
      Q => payload_b(106),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[107]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(107),
      Q => payload_b(107),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[108]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(108),
      Q => payload_b(108),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[109]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(109),
      Q => payload_b(109),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(10),
      Q => payload_b(10),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[110]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(110),
      Q => payload_b(110),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[111]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(111),
      Q => payload_b(111),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[112]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(112),
      Q => payload_b(112),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[113]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(113),
      Q => payload_b(113),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[114]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(114),
      Q => payload_b(114),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[115]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(115),
      Q => payload_b(115),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[116]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(116),
      Q => payload_b(116),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(11),
      Q => payload_b(11),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(12),
      Q => payload_b(12),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(13),
      Q => payload_b(13),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(14),
      Q => payload_b(14),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(15),
      Q => payload_b(15),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(16),
      Q => payload_b(16),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(17),
      Q => payload_b(17),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(18),
      Q => payload_b(18),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(19),
      Q => payload_b(19),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(1),
      Q => payload_b(1),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(20),
      Q => payload_b(20),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(21),
      Q => payload_b(21),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(22),
      Q => payload_b(22),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(23),
      Q => payload_b(23),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(24),
      Q => payload_b(24),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(25),
      Q => payload_b(25),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(26),
      Q => payload_b(26),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(27),
      Q => payload_b(27),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(28),
      Q => payload_b(28),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(29),
      Q => payload_b(29),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(2),
      Q => payload_b(2),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(30),
      Q => payload_b(30),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(31),
      Q => payload_b(31),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(32),
      Q => payload_b(32),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(33),
      Q => payload_b(33),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(34),
      Q => payload_b(34),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(35),
      Q => payload_b(35),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(36),
      Q => payload_b(36),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(37),
      Q => payload_b(37),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(38),
      Q => payload_b(38),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(39),
      Q => payload_b(39),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(3),
      Q => payload_b(3),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(40),
      Q => payload_b(40),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(41),
      Q => payload_b(41),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(42),
      Q => payload_b(42),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(43),
      Q => payload_b(43),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(44),
      Q => payload_b(44),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(45),
      Q => payload_b(45),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(46),
      Q => payload_b(46),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(47),
      Q => payload_b(47),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(48),
      Q => payload_b(48),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(49),
      Q => payload_b(49),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(4),
      Q => payload_b(4),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(50),
      Q => payload_b(50),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(51),
      Q => payload_b(51),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(52),
      Q => payload_b(52),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(53),
      Q => payload_b(53),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(54),
      Q => payload_b(54),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(55),
      Q => payload_b(55),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(56),
      Q => payload_b(56),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(57),
      Q => payload_b(57),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(58),
      Q => payload_b(58),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(59),
      Q => payload_b(59),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(5),
      Q => payload_b(5),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(60),
      Q => payload_b(60),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(61),
      Q => payload_b(61),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(62),
      Q => payload_b(62),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(63),
      Q => payload_b(63),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(64),
      Q => payload_b(64),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(65),
      Q => payload_b(65),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(66),
      Q => payload_b(66),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(67),
      Q => payload_b(67),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(68),
      Q => payload_b(68),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(69),
      Q => payload_b(69),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(6),
      Q => payload_b(6),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(70),
      Q => payload_b(70),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(71),
      Q => payload_b(71),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(72),
      Q => payload_b(72),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[73]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(73),
      Q => payload_b(73),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[74]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(74),
      Q => payload_b(74),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[75]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(75),
      Q => payload_b(75),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[76]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(76),
      Q => payload_b(76),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[77]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(77),
      Q => payload_b(77),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[78]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(78),
      Q => payload_b(78),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[79]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(79),
      Q => payload_b(79),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(7),
      Q => payload_b(7),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[80]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(80),
      Q => payload_b(80),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[81]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(81),
      Q => payload_b(81),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[82]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(82),
      Q => payload_b(82),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[83]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(83),
      Q => payload_b(83),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[84]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(84),
      Q => payload_b(84),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[85]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(85),
      Q => payload_b(85),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[86]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(86),
      Q => payload_b(86),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[87]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(87),
      Q => payload_b(87),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[88]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(88),
      Q => payload_b(88),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[89]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(89),
      Q => payload_b(89),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(8),
      Q => payload_b(8),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[90]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(90),
      Q => payload_b(90),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[91]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(91),
      Q => payload_b(91),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[92]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(92),
      Q => payload_b(92),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[93]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(93),
      Q => payload_b(93),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[94]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(94),
      Q => payload_b(94),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[95]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(95),
      Q => payload_b(95),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[96]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(96),
      Q => payload_b(96),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[97]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(97),
      Q => payload_b(97),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[98]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(98),
      Q => payload_b(98),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[99]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(99),
      Q => payload_b(99),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(9),
      Q => payload_b(9),
      R => '0'
    );
\gen_AB_reg_slice.sel_rd_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(0),
      I1 => m_axis_tready,
      I2 => aclken,
      I3 => sel,
      O => \gen_AB_reg_slice.sel_rd_i_1_n_0\
    );
\gen_AB_reg_slice.sel_rd_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \gen_AB_reg_slice.sel_rd_i_1_n_0\,
      Q => sel,
      R => SR(0)
    );
\gen_AB_reg_slice.sel_wr_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => aclken,
      I1 => \^q\(1),
      I2 => s_axis_tvalid,
      I3 => sel_wr,
      O => \gen_AB_reg_slice.sel_wr_i_1_n_0\
    );
\gen_AB_reg_slice.sel_wr_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \gen_AB_reg_slice.sel_wr_i_1_n_0\,
      Q => sel_wr,
      R => SR(0)
    );
\gen_AB_reg_slice.state[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7808"
    )
        port map (
      I0 => m_axis_tready,
      I1 => \^q\(0),
      I2 => \^q\(1),
      I3 => s_axis_tvalid,
      O => state(0)
    );
\gen_AB_reg_slice.state[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2A808A8A"
    )
        port map (
      I0 => aclken,
      I1 => m_axis_tready,
      I2 => \^q\(0),
      I3 => s_axis_tvalid,
      I4 => \^q\(1),
      O => \gen_AB_reg_slice.state[1]_i_1_n_0\
    );
\gen_AB_reg_slice.state[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FD2D"
    )
        port map (
      I0 => \^q\(1),
      I1 => s_axis_tvalid,
      I2 => \^q\(0),
      I3 => m_axis_tready,
      O => state(1)
    );
\gen_AB_reg_slice.state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => \gen_AB_reg_slice.state[1]_i_1_n_0\,
      D => state(0),
      Q => \^q\(0),
      R => SR(0)
    );
\gen_AB_reg_slice.state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => \gen_AB_reg_slice.state[1]_i_1_n_0\,
      D => state(1),
      Q => \^q\(1),
      R => SR(0)
    );
\m_axis_tdata[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(0),
      I1 => payload_a(0),
      I2 => sel,
      O => m_axis_tdata(0)
    );
\m_axis_tdata[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(10),
      I1 => payload_a(10),
      I2 => sel,
      O => m_axis_tdata(10)
    );
\m_axis_tdata[11]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(11),
      I1 => payload_a(11),
      I2 => sel,
      O => m_axis_tdata(11)
    );
\m_axis_tdata[12]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(12),
      I1 => payload_a(12),
      I2 => sel,
      O => m_axis_tdata(12)
    );
\m_axis_tdata[13]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(13),
      I1 => payload_a(13),
      I2 => sel,
      O => m_axis_tdata(13)
    );
\m_axis_tdata[14]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(14),
      I1 => payload_a(14),
      I2 => sel,
      O => m_axis_tdata(14)
    );
\m_axis_tdata[15]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(15),
      I1 => payload_a(15),
      I2 => sel,
      O => m_axis_tdata(15)
    );
\m_axis_tdata[16]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(16),
      I1 => payload_a(16),
      I2 => sel,
      O => m_axis_tdata(16)
    );
\m_axis_tdata[17]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(17),
      I1 => payload_a(17),
      I2 => sel,
      O => m_axis_tdata(17)
    );
\m_axis_tdata[18]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(18),
      I1 => payload_a(18),
      I2 => sel,
      O => m_axis_tdata(18)
    );
\m_axis_tdata[19]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(19),
      I1 => payload_a(19),
      I2 => sel,
      O => m_axis_tdata(19)
    );
\m_axis_tdata[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(1),
      I1 => payload_a(1),
      I2 => sel,
      O => m_axis_tdata(1)
    );
\m_axis_tdata[20]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(20),
      I1 => payload_a(20),
      I2 => sel,
      O => m_axis_tdata(20)
    );
\m_axis_tdata[21]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(21),
      I1 => payload_a(21),
      I2 => sel,
      O => m_axis_tdata(21)
    );
\m_axis_tdata[22]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(22),
      I1 => payload_a(22),
      I2 => sel,
      O => m_axis_tdata(22)
    );
\m_axis_tdata[23]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(23),
      I1 => payload_a(23),
      I2 => sel,
      O => m_axis_tdata(23)
    );
\m_axis_tdata[24]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(24),
      I1 => payload_a(24),
      I2 => sel,
      O => m_axis_tdata(24)
    );
\m_axis_tdata[25]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(25),
      I1 => payload_a(25),
      I2 => sel,
      O => m_axis_tdata(25)
    );
\m_axis_tdata[26]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(26),
      I1 => payload_a(26),
      I2 => sel,
      O => m_axis_tdata(26)
    );
\m_axis_tdata[27]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(27),
      I1 => payload_a(27),
      I2 => sel,
      O => m_axis_tdata(27)
    );
\m_axis_tdata[28]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(28),
      I1 => payload_a(28),
      I2 => sel,
      O => m_axis_tdata(28)
    );
\m_axis_tdata[29]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(29),
      I1 => payload_a(29),
      I2 => sel,
      O => m_axis_tdata(29)
    );
\m_axis_tdata[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(2),
      I1 => payload_a(2),
      I2 => sel,
      O => m_axis_tdata(2)
    );
\m_axis_tdata[30]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(30),
      I1 => payload_a(30),
      I2 => sel,
      O => m_axis_tdata(30)
    );
\m_axis_tdata[31]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(31),
      I1 => payload_a(31),
      I2 => sel,
      O => m_axis_tdata(31)
    );
\m_axis_tdata[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(3),
      I1 => payload_a(3),
      I2 => sel,
      O => m_axis_tdata(3)
    );
\m_axis_tdata[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(4),
      I1 => payload_a(4),
      I2 => sel,
      O => m_axis_tdata(4)
    );
\m_axis_tdata[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(5),
      I1 => payload_a(5),
      I2 => sel,
      O => m_axis_tdata(5)
    );
\m_axis_tdata[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(6),
      I1 => payload_a(6),
      I2 => sel,
      O => m_axis_tdata(6)
    );
\m_axis_tdata[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(7),
      I1 => payload_a(7),
      I2 => sel,
      O => m_axis_tdata(7)
    );
\m_axis_tdata[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(8),
      I1 => payload_a(8),
      I2 => sel,
      O => m_axis_tdata(8)
    );
\m_axis_tdata[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(9),
      I1 => payload_a(9),
      I2 => sel,
      O => m_axis_tdata(9)
    );
\m_axis_tkeep[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(32),
      I1 => payload_a(32),
      I2 => sel,
      O => m_axis_tkeep(0)
    );
\m_axis_tkeep[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(33),
      I1 => payload_a(33),
      I2 => sel,
      O => m_axis_tkeep(1)
    );
\m_axis_tkeep[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(34),
      I1 => payload_a(34),
      I2 => sel,
      O => m_axis_tkeep(2)
    );
\m_axis_tkeep[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(35),
      I1 => payload_a(35),
      I2 => sel,
      O => m_axis_tkeep(3)
    );
m_axis_tlast_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(36),
      I1 => payload_a(36),
      I2 => sel,
      O => m_axis_tlast
    );
\m_axis_tuser[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(37),
      I1 => payload_a(37),
      I2 => sel,
      O => m_axis_tuser(0)
    );
\m_axis_tuser[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(47),
      I1 => payload_a(47),
      I2 => sel,
      O => m_axis_tuser(10)
    );
\m_axis_tuser[11]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(48),
      I1 => payload_a(48),
      I2 => sel,
      O => m_axis_tuser(11)
    );
\m_axis_tuser[12]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(49),
      I1 => payload_a(49),
      I2 => sel,
      O => m_axis_tuser(12)
    );
\m_axis_tuser[13]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(50),
      I1 => payload_a(50),
      I2 => sel,
      O => m_axis_tuser(13)
    );
\m_axis_tuser[14]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(51),
      I1 => payload_a(51),
      I2 => sel,
      O => m_axis_tuser(14)
    );
\m_axis_tuser[15]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(52),
      I1 => payload_a(52),
      I2 => sel,
      O => m_axis_tuser(15)
    );
\m_axis_tuser[16]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(53),
      I1 => payload_a(53),
      I2 => sel,
      O => m_axis_tuser(16)
    );
\m_axis_tuser[17]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(54),
      I1 => payload_a(54),
      I2 => sel,
      O => m_axis_tuser(17)
    );
\m_axis_tuser[18]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(55),
      I1 => payload_a(55),
      I2 => sel,
      O => m_axis_tuser(18)
    );
\m_axis_tuser[19]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(56),
      I1 => payload_a(56),
      I2 => sel,
      O => m_axis_tuser(19)
    );
\m_axis_tuser[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(38),
      I1 => payload_a(38),
      I2 => sel,
      O => m_axis_tuser(1)
    );
\m_axis_tuser[20]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(57),
      I1 => payload_a(57),
      I2 => sel,
      O => m_axis_tuser(20)
    );
\m_axis_tuser[21]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(58),
      I1 => payload_a(58),
      I2 => sel,
      O => m_axis_tuser(21)
    );
\m_axis_tuser[22]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(59),
      I1 => payload_a(59),
      I2 => sel,
      O => m_axis_tuser(22)
    );
\m_axis_tuser[23]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(60),
      I1 => payload_a(60),
      I2 => sel,
      O => m_axis_tuser(23)
    );
\m_axis_tuser[24]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(61),
      I1 => payload_a(61),
      I2 => sel,
      O => m_axis_tuser(24)
    );
\m_axis_tuser[25]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(62),
      I1 => payload_a(62),
      I2 => sel,
      O => m_axis_tuser(25)
    );
\m_axis_tuser[26]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(63),
      I1 => payload_a(63),
      I2 => sel,
      O => m_axis_tuser(26)
    );
\m_axis_tuser[27]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(64),
      I1 => payload_a(64),
      I2 => sel,
      O => m_axis_tuser(27)
    );
\m_axis_tuser[28]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(65),
      I1 => payload_a(65),
      I2 => sel,
      O => m_axis_tuser(28)
    );
\m_axis_tuser[29]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(66),
      I1 => payload_a(66),
      I2 => sel,
      O => m_axis_tuser(29)
    );
\m_axis_tuser[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(39),
      I1 => payload_a(39),
      I2 => sel,
      O => m_axis_tuser(2)
    );
\m_axis_tuser[30]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(67),
      I1 => payload_a(67),
      I2 => sel,
      O => m_axis_tuser(30)
    );
\m_axis_tuser[31]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(68),
      I1 => payload_a(68),
      I2 => sel,
      O => m_axis_tuser(31)
    );
\m_axis_tuser[32]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(69),
      I1 => payload_a(69),
      I2 => sel,
      O => m_axis_tuser(32)
    );
\m_axis_tuser[33]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(70),
      I1 => payload_a(70),
      I2 => sel,
      O => m_axis_tuser(33)
    );
\m_axis_tuser[34]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(71),
      I1 => payload_a(71),
      I2 => sel,
      O => m_axis_tuser(34)
    );
\m_axis_tuser[35]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(72),
      I1 => payload_a(72),
      I2 => sel,
      O => m_axis_tuser(35)
    );
\m_axis_tuser[36]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(73),
      I1 => payload_a(73),
      I2 => sel,
      O => m_axis_tuser(36)
    );
\m_axis_tuser[37]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(74),
      I1 => payload_a(74),
      I2 => sel,
      O => m_axis_tuser(37)
    );
\m_axis_tuser[38]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(75),
      I1 => payload_a(75),
      I2 => sel,
      O => m_axis_tuser(38)
    );
\m_axis_tuser[39]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(76),
      I1 => payload_a(76),
      I2 => sel,
      O => m_axis_tuser(39)
    );
\m_axis_tuser[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(40),
      I1 => payload_a(40),
      I2 => sel,
      O => m_axis_tuser(3)
    );
\m_axis_tuser[40]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(77),
      I1 => payload_a(77),
      I2 => sel,
      O => m_axis_tuser(40)
    );
\m_axis_tuser[41]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(78),
      I1 => payload_a(78),
      I2 => sel,
      O => m_axis_tuser(41)
    );
\m_axis_tuser[42]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(79),
      I1 => payload_a(79),
      I2 => sel,
      O => m_axis_tuser(42)
    );
\m_axis_tuser[43]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(80),
      I1 => payload_a(80),
      I2 => sel,
      O => m_axis_tuser(43)
    );
\m_axis_tuser[44]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(81),
      I1 => payload_a(81),
      I2 => sel,
      O => m_axis_tuser(44)
    );
\m_axis_tuser[45]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(82),
      I1 => payload_a(82),
      I2 => sel,
      O => m_axis_tuser(45)
    );
\m_axis_tuser[46]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(83),
      I1 => payload_a(83),
      I2 => sel,
      O => m_axis_tuser(46)
    );
\m_axis_tuser[47]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(84),
      I1 => payload_a(84),
      I2 => sel,
      O => m_axis_tuser(47)
    );
\m_axis_tuser[48]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(85),
      I1 => payload_a(85),
      I2 => sel,
      O => m_axis_tuser(48)
    );
\m_axis_tuser[49]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(86),
      I1 => payload_a(86),
      I2 => sel,
      O => m_axis_tuser(49)
    );
\m_axis_tuser[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(41),
      I1 => payload_a(41),
      I2 => sel,
      O => m_axis_tuser(4)
    );
\m_axis_tuser[50]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(87),
      I1 => payload_a(87),
      I2 => sel,
      O => m_axis_tuser(50)
    );
\m_axis_tuser[51]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(88),
      I1 => payload_a(88),
      I2 => sel,
      O => m_axis_tuser(51)
    );
\m_axis_tuser[52]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(89),
      I1 => payload_a(89),
      I2 => sel,
      O => m_axis_tuser(52)
    );
\m_axis_tuser[53]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(90),
      I1 => payload_a(90),
      I2 => sel,
      O => m_axis_tuser(53)
    );
\m_axis_tuser[54]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(91),
      I1 => payload_a(91),
      I2 => sel,
      O => m_axis_tuser(54)
    );
\m_axis_tuser[55]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(92),
      I1 => payload_a(92),
      I2 => sel,
      O => m_axis_tuser(55)
    );
\m_axis_tuser[56]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(93),
      I1 => payload_a(93),
      I2 => sel,
      O => m_axis_tuser(56)
    );
\m_axis_tuser[57]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(94),
      I1 => payload_a(94),
      I2 => sel,
      O => m_axis_tuser(57)
    );
\m_axis_tuser[58]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(95),
      I1 => payload_a(95),
      I2 => sel,
      O => m_axis_tuser(58)
    );
\m_axis_tuser[59]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(96),
      I1 => payload_a(96),
      I2 => sel,
      O => m_axis_tuser(59)
    );
\m_axis_tuser[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(42),
      I1 => payload_a(42),
      I2 => sel,
      O => m_axis_tuser(5)
    );
\m_axis_tuser[60]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(97),
      I1 => payload_a(97),
      I2 => sel,
      O => m_axis_tuser(60)
    );
\m_axis_tuser[61]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(98),
      I1 => payload_a(98),
      I2 => sel,
      O => m_axis_tuser(61)
    );
\m_axis_tuser[62]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(99),
      I1 => payload_a(99),
      I2 => sel,
      O => m_axis_tuser(62)
    );
\m_axis_tuser[63]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(100),
      I1 => payload_a(100),
      I2 => sel,
      O => m_axis_tuser(63)
    );
\m_axis_tuser[64]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(101),
      I1 => payload_a(101),
      I2 => sel,
      O => m_axis_tuser(64)
    );
\m_axis_tuser[65]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(102),
      I1 => payload_a(102),
      I2 => sel,
      O => m_axis_tuser(65)
    );
\m_axis_tuser[66]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(103),
      I1 => payload_a(103),
      I2 => sel,
      O => m_axis_tuser(66)
    );
\m_axis_tuser[67]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(104),
      I1 => payload_a(104),
      I2 => sel,
      O => m_axis_tuser(67)
    );
\m_axis_tuser[68]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(105),
      I1 => payload_a(105),
      I2 => sel,
      O => m_axis_tuser(68)
    );
\m_axis_tuser[69]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(106),
      I1 => payload_a(106),
      I2 => sel,
      O => m_axis_tuser(69)
    );
\m_axis_tuser[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(43),
      I1 => payload_a(43),
      I2 => sel,
      O => m_axis_tuser(6)
    );
\m_axis_tuser[70]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(107),
      I1 => payload_a(107),
      I2 => sel,
      O => m_axis_tuser(70)
    );
\m_axis_tuser[71]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(108),
      I1 => payload_a(108),
      I2 => sel,
      O => m_axis_tuser(71)
    );
\m_axis_tuser[72]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(109),
      I1 => payload_a(109),
      I2 => sel,
      O => m_axis_tuser(72)
    );
\m_axis_tuser[73]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(110),
      I1 => payload_a(110),
      I2 => sel,
      O => m_axis_tuser(73)
    );
\m_axis_tuser[74]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(111),
      I1 => payload_a(111),
      I2 => sel,
      O => m_axis_tuser(74)
    );
\m_axis_tuser[75]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(112),
      I1 => payload_a(112),
      I2 => sel,
      O => m_axis_tuser(75)
    );
\m_axis_tuser[76]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(113),
      I1 => payload_a(113),
      I2 => sel,
      O => m_axis_tuser(76)
    );
\m_axis_tuser[77]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(114),
      I1 => payload_a(114),
      I2 => sel,
      O => m_axis_tuser(77)
    );
\m_axis_tuser[78]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(115),
      I1 => payload_a(115),
      I2 => sel,
      O => m_axis_tuser(78)
    );
\m_axis_tuser[79]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(116),
      I1 => payload_a(116),
      I2 => sel,
      O => m_axis_tuser(79)
    );
\m_axis_tuser[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(44),
      I1 => payload_a(44),
      I2 => sel,
      O => m_axis_tuser(7)
    );
\m_axis_tuser[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(45),
      I1 => payload_a(45),
      I2 => sel,
      O => m_axis_tuser(8)
    );
\m_axis_tuser[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(46),
      I1 => payload_a(46),
      I2 => sel,
      O => m_axis_tuser(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 79 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 79 downto 0 )
  );
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is "32'b00000000000000000000000010011011";
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 32;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 80;
  attribute C_FAMILY : string;
  attribute C_FAMILY of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is "kintexu";
  attribute C_REG_CONFIG : integer;
  attribute C_REG_CONFIG of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is "yes";
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is "axis_register_slice_v1_1_13_axis_register_slice";
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice : entity is 117;
end px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice;

architecture STRUCTURE of px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice is
  signal \<const0>\ : STD_LOGIC;
  signal areset_r : STD_LOGIC;
  signal areset_r_i_1_n_0 : STD_LOGIC;
begin
  m_axis_tdest(0) <= \<const0>\;
  m_axis_tid(0) <= \<const0>\;
  m_axis_tstrb(3) <= \<const0>\;
  m_axis_tstrb(2) <= \<const0>\;
  m_axis_tstrb(1) <= \<const0>\;
  m_axis_tstrb(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
areset_r_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => aresetn,
      O => areset_r_i_1_n_0
    );
areset_r_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => areset_r_i_1_n_0,
      Q => areset_r,
      R => '0'
    );
axisc_register_slice_0: entity work.px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axisc_register_slice
     port map (
      D(116 downto 37) => s_axis_tuser(79 downto 0),
      D(36) => s_axis_tlast,
      D(35 downto 32) => s_axis_tkeep(3 downto 0),
      D(31 downto 0) => s_axis_tdata(31 downto 0),
      Q(1) => s_axis_tready,
      Q(0) => m_axis_tvalid,
      SR(0) => areset_r,
      aclk => aclk,
      aclken => aclken,
      m_axis_tdata(31 downto 0) => m_axis_tdata(31 downto 0),
      m_axis_tkeep(3 downto 0) => m_axis_tkeep(3 downto 0),
      m_axis_tlast => m_axis_tlast,
      m_axis_tready => m_axis_tready,
      m_axis_tuser(79 downto 0) => m_axis_tuser(79 downto 0),
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_pkt_axis_slice is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tuser : in STD_LOGIC_VECTOR ( 79 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tuser : out STD_LOGIC_VECTOR ( 79 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of px_vita49_pkt_axis_slice : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of px_vita49_pkt_axis_slice : entity is "px_vita49_pkt_axis_slice,axis_register_slice_v1_1_13_axis_register_slice,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of px_vita49_pkt_axis_slice : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of px_vita49_pkt_axis_slice : entity is "axis_register_slice_v1_1_13_axis_register_slice,Vivado 2017.2.1";
end px_vita49_pkt_axis_slice;

architecture STRUCTURE of px_vita49_pkt_axis_slice is
  signal NLW_inst_m_axis_tdest_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axis_tid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axis_tstrb_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of inst : label is "32'b00000000000000000000000010011011";
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of inst : label is 32;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of inst : label is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of inst : label is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of inst : label is 80;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "kintexu";
  attribute C_REG_CONFIG : integer;
  attribute C_REG_CONFIG of inst : label is 1;
  attribute DowngradeIPIdentifiedWarnings of inst : label is "yes";
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of inst : label is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of inst : label is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of inst : label is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of inst : label is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of inst : label is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of inst : label is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of inst : label is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of inst : label is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of inst : label is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of inst : label is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of inst : label is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of inst : label is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of inst : label is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of inst : label is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of inst : label is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of inst : label is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of inst : label is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of inst : label is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of inst : label is 1;
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of inst : label is 117;
begin
inst: entity work.px_vita49_pkt_axis_slice_axis_register_slice_v1_1_13_axis_register_slice
     port map (
      aclk => aclk,
      aclken => aclken,
      aresetn => aresetn,
      m_axis_tdata(31 downto 0) => m_axis_tdata(31 downto 0),
      m_axis_tdest(0) => NLW_inst_m_axis_tdest_UNCONNECTED(0),
      m_axis_tid(0) => NLW_inst_m_axis_tid_UNCONNECTED(0),
      m_axis_tkeep(3 downto 0) => m_axis_tkeep(3 downto 0),
      m_axis_tlast => m_axis_tlast,
      m_axis_tready => m_axis_tready,
      m_axis_tstrb(3 downto 0) => NLW_inst_m_axis_tstrb_UNCONNECTED(3 downto 0),
      m_axis_tuser(79 downto 0) => m_axis_tuser(79 downto 0),
      m_axis_tvalid => m_axis_tvalid,
      s_axis_tdata(31 downto 0) => s_axis_tdata(31 downto 0),
      s_axis_tdest(0) => '0',
      s_axis_tid(0) => '0',
      s_axis_tkeep(3 downto 0) => s_axis_tkeep(3 downto 0),
      s_axis_tlast => s_axis_tlast,
      s_axis_tready => s_axis_tready,
      s_axis_tstrb(3 downto 0) => B"1111",
      s_axis_tuser(79 downto 0) => s_axis_tuser(79 downto 0),
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
