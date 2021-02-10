-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2.1 (win64) Build 1957588 Wed Aug  9 16:32:24 MDT 2017
-- Date        : Thu Oct 26 16:19:12 2017
-- Host        : Mike-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/pentek/ip/2017.2/wip/px_vita49_pkt/px_vita49_pkt.srcs/sources_1/ip/px_vita49_pkt_ppkt_upsizer/px_vita49_pkt_ppkt_upsizer_sim_netlist.vhdl
-- Design      : px_vita49_pkt_ppkt_upsizer
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku035-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_register_slice is
  port (
    Q : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \r0_data_reg[31]\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    \r0_keep_reg[2]\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXIS_TLAST : out STD_LOGIC;
    \r0_user_reg[79]\ : out STD_LOGIC_VECTOR ( 79 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    s_axis_ppkt_tvalid : in STD_LOGIC;
    \state_reg[0]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    D : in STD_LOGIC_VECTOR ( 114 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_register_slice : entity is "px_axis_dwidth_conv_axisc_register_slice";
end px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_register_slice;

architecture STRUCTURE of px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_register_slice is
  signal \^q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \gen_AB_reg_slice.sel_rd_i_1_n_0\ : STD_LOGIC;
  signal \gen_AB_reg_slice.sel_wr_i_1_n_0\ : STD_LOGIC;
  signal \gen_AB_reg_slice.state[1]_i_1_n_0\ : STD_LOGIC;
  signal payload_a : STD_LOGIC_VECTOR ( 116 downto 0 );
  signal payload_a_1 : STD_LOGIC;
  signal payload_b : STD_LOGIC_VECTOR ( 116 downto 0 );
  signal payload_b_0 : STD_LOGIC;
  signal sel : STD_LOGIC;
  signal sel_wr : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \acc_data[224]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \acc_data[225]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \acc_data[226]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \acc_data[227]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \acc_data[228]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \acc_data[229]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \acc_data[230]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \acc_data[231]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \acc_data[232]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \acc_data[233]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \acc_data[234]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \acc_data[235]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \acc_data[236]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \acc_data[237]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \acc_data[238]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \acc_data[239]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \acc_data[240]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \acc_data[241]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \acc_data[242]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \acc_data[243]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \acc_data[244]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \acc_data[245]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \acc_data[246]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \acc_data[247]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \acc_data[248]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \acc_data[249]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \acc_data[250]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \acc_data[251]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \acc_data[252]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \acc_data[253]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \acc_data[254]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \acc_data[255]_i_2\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \acc_keep[28]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \acc_keep[30]_i_2\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \gen_AB_reg_slice.sel_rd_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gen_AB_reg_slice.state[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \gen_AB_reg_slice.state[1]_i_2\ : label is "soft_lutpair0";
  attribute FSM_ENCODING : string;
  attribute FSM_ENCODING of \gen_AB_reg_slice.state_reg[0]\ : label is "none";
  attribute FSM_ENCODING of \gen_AB_reg_slice.state_reg[1]\ : label is "none";
  attribute SOFT_HLUTNM of r0_last_i_1 : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \r0_user[0]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \r0_user[10]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \r0_user[11]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \r0_user[12]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \r0_user[13]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \r0_user[14]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \r0_user[15]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \r0_user[16]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \r0_user[17]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \r0_user[18]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \r0_user[19]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \r0_user[1]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \r0_user[20]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \r0_user[21]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \r0_user[22]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \r0_user[23]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \r0_user[24]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \r0_user[25]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \r0_user[26]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \r0_user[27]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \r0_user[28]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \r0_user[29]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \r0_user[2]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \r0_user[30]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \r0_user[31]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \r0_user[32]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \r0_user[33]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \r0_user[34]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \r0_user[35]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \r0_user[36]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \r0_user[37]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \r0_user[38]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \r0_user[39]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \r0_user[3]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \r0_user[40]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \r0_user[41]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \r0_user[42]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \r0_user[43]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \r0_user[44]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \r0_user[45]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \r0_user[46]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \r0_user[47]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \r0_user[48]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \r0_user[49]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \r0_user[4]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \r0_user[50]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \r0_user[51]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \r0_user[52]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \r0_user[53]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \r0_user[54]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \r0_user[55]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \r0_user[56]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \r0_user[57]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \r0_user[58]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \r0_user[59]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \r0_user[5]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \r0_user[60]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \r0_user[61]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \r0_user[62]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \r0_user[63]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \r0_user[64]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \r0_user[65]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \r0_user[66]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \r0_user[67]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \r0_user[68]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \r0_user[69]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \r0_user[6]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \r0_user[70]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \r0_user[71]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \r0_user[72]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \r0_user[73]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \r0_user[74]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \r0_user[75]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \r0_user[76]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \r0_user[77]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \r0_user[78]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \r0_user[79]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \r0_user[7]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \r0_user[8]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \r0_user[9]_i_1\ : label is "soft_lutpair23";
begin
  Q(1 downto 0) <= \^q\(1 downto 0);
\acc_data[224]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(0),
      I1 => payload_a(0),
      I2 => sel,
      O => \r0_data_reg[31]\(0)
    );
\acc_data[225]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(1),
      I1 => payload_a(1),
      I2 => sel,
      O => \r0_data_reg[31]\(1)
    );
\acc_data[226]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(2),
      I1 => payload_a(2),
      I2 => sel,
      O => \r0_data_reg[31]\(2)
    );
\acc_data[227]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(3),
      I1 => payload_a(3),
      I2 => sel,
      O => \r0_data_reg[31]\(3)
    );
\acc_data[228]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(4),
      I1 => payload_a(4),
      I2 => sel,
      O => \r0_data_reg[31]\(4)
    );
\acc_data[229]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(5),
      I1 => payload_a(5),
      I2 => sel,
      O => \r0_data_reg[31]\(5)
    );
\acc_data[230]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(6),
      I1 => payload_a(6),
      I2 => sel,
      O => \r0_data_reg[31]\(6)
    );
\acc_data[231]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(7),
      I1 => payload_a(7),
      I2 => sel,
      O => \r0_data_reg[31]\(7)
    );
\acc_data[232]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(8),
      I1 => payload_a(8),
      I2 => sel,
      O => \r0_data_reg[31]\(8)
    );
\acc_data[233]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(9),
      I1 => payload_a(9),
      I2 => sel,
      O => \r0_data_reg[31]\(9)
    );
\acc_data[234]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(10),
      I1 => payload_a(10),
      I2 => sel,
      O => \r0_data_reg[31]\(10)
    );
\acc_data[235]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(11),
      I1 => payload_a(11),
      I2 => sel,
      O => \r0_data_reg[31]\(11)
    );
\acc_data[236]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(12),
      I1 => payload_a(12),
      I2 => sel,
      O => \r0_data_reg[31]\(12)
    );
\acc_data[237]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(13),
      I1 => payload_a(13),
      I2 => sel,
      O => \r0_data_reg[31]\(13)
    );
\acc_data[238]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(14),
      I1 => payload_a(14),
      I2 => sel,
      O => \r0_data_reg[31]\(14)
    );
\acc_data[239]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(15),
      I1 => payload_a(15),
      I2 => sel,
      O => \r0_data_reg[31]\(15)
    );
\acc_data[240]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(16),
      I1 => payload_a(16),
      I2 => sel,
      O => \r0_data_reg[31]\(16)
    );
\acc_data[241]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(17),
      I1 => payload_a(17),
      I2 => sel,
      O => \r0_data_reg[31]\(17)
    );
\acc_data[242]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(18),
      I1 => payload_a(18),
      I2 => sel,
      O => \r0_data_reg[31]\(18)
    );
\acc_data[243]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(19),
      I1 => payload_a(19),
      I2 => sel,
      O => \r0_data_reg[31]\(19)
    );
\acc_data[244]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(20),
      I1 => payload_a(20),
      I2 => sel,
      O => \r0_data_reg[31]\(20)
    );
\acc_data[245]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(21),
      I1 => payload_a(21),
      I2 => sel,
      O => \r0_data_reg[31]\(21)
    );
\acc_data[246]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(22),
      I1 => payload_a(22),
      I2 => sel,
      O => \r0_data_reg[31]\(22)
    );
\acc_data[247]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(23),
      I1 => payload_a(23),
      I2 => sel,
      O => \r0_data_reg[31]\(23)
    );
\acc_data[248]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(24),
      I1 => payload_a(24),
      I2 => sel,
      O => \r0_data_reg[31]\(24)
    );
\acc_data[249]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(25),
      I1 => payload_a(25),
      I2 => sel,
      O => \r0_data_reg[31]\(25)
    );
\acc_data[250]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(26),
      I1 => payload_a(26),
      I2 => sel,
      O => \r0_data_reg[31]\(26)
    );
\acc_data[251]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(27),
      I1 => payload_a(27),
      I2 => sel,
      O => \r0_data_reg[31]\(27)
    );
\acc_data[252]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(28),
      I1 => payload_a(28),
      I2 => sel,
      O => \r0_data_reg[31]\(28)
    );
\acc_data[253]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(29),
      I1 => payload_a(29),
      I2 => sel,
      O => \r0_data_reg[31]\(29)
    );
\acc_data[254]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(30),
      I1 => payload_a(30),
      I2 => sel,
      O => \r0_data_reg[31]\(30)
    );
\acc_data[255]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(31),
      I1 => payload_a(31),
      I2 => sel,
      O => \r0_data_reg[31]\(31)
    );
\acc_keep[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(32),
      I1 => payload_a(32),
      I2 => sel,
      O => \r0_keep_reg[2]\(0)
    );
\acc_keep[30]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(34),
      I1 => payload_a(34),
      I2 => sel,
      O => \r0_keep_reg[2]\(1)
    );
\gen_AB_reg_slice.payload_a[116]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0D"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => sel_wr,
      O => payload_a_1
    );
\gen_AB_reg_slice.payload_a_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(0),
      Q => payload_a(0),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[100]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(98),
      Q => payload_a(100),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[101]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(99),
      Q => payload_a(101),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[102]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(100),
      Q => payload_a(102),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[103]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(101),
      Q => payload_a(103),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[104]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(102),
      Q => payload_a(104),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[105]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(103),
      Q => payload_a(105),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[106]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(104),
      Q => payload_a(106),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[107]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(105),
      Q => payload_a(107),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[108]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(106),
      Q => payload_a(108),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[109]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(107),
      Q => payload_a(109),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(10),
      Q => payload_a(10),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[110]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(108),
      Q => payload_a(110),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[111]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(109),
      Q => payload_a(111),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[112]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(110),
      Q => payload_a(112),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[113]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(111),
      Q => payload_a(113),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[114]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(112),
      Q => payload_a(114),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[115]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(113),
      Q => payload_a(115),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[116]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(114),
      Q => payload_a(116),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(11),
      Q => payload_a(11),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(12),
      Q => payload_a(12),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(13),
      Q => payload_a(13),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(14),
      Q => payload_a(14),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(15),
      Q => payload_a(15),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(16),
      Q => payload_a(16),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(17),
      Q => payload_a(17),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(18),
      Q => payload_a(18),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(19),
      Q => payload_a(19),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(1),
      Q => payload_a(1),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(20),
      Q => payload_a(20),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(21),
      Q => payload_a(21),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(22),
      Q => payload_a(22),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(23),
      Q => payload_a(23),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(24),
      Q => payload_a(24),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(25),
      Q => payload_a(25),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(26),
      Q => payload_a(26),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(27),
      Q => payload_a(27),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(28),
      Q => payload_a(28),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(29),
      Q => payload_a(29),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(2),
      Q => payload_a(2),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(30),
      Q => payload_a(30),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(31),
      Q => payload_a(31),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(32),
      Q => payload_a(32),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(33),
      Q => payload_a(34),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(34),
      Q => payload_a(36),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(35),
      Q => payload_a(37),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(36),
      Q => payload_a(38),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(37),
      Q => payload_a(39),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(3),
      Q => payload_a(3),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(38),
      Q => payload_a(40),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(39),
      Q => payload_a(41),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(40),
      Q => payload_a(42),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(41),
      Q => payload_a(43),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(42),
      Q => payload_a(44),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(43),
      Q => payload_a(45),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(44),
      Q => payload_a(46),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(45),
      Q => payload_a(47),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(46),
      Q => payload_a(48),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(47),
      Q => payload_a(49),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(4),
      Q => payload_a(4),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(48),
      Q => payload_a(50),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(49),
      Q => payload_a(51),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(50),
      Q => payload_a(52),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(51),
      Q => payload_a(53),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(52),
      Q => payload_a(54),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(53),
      Q => payload_a(55),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(54),
      Q => payload_a(56),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(55),
      Q => payload_a(57),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(56),
      Q => payload_a(58),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(57),
      Q => payload_a(59),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(5),
      Q => payload_a(5),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(58),
      Q => payload_a(60),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(59),
      Q => payload_a(61),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(60),
      Q => payload_a(62),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(61),
      Q => payload_a(63),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(62),
      Q => payload_a(64),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(63),
      Q => payload_a(65),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(64),
      Q => payload_a(66),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(65),
      Q => payload_a(67),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(66),
      Q => payload_a(68),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(67),
      Q => payload_a(69),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(6),
      Q => payload_a(6),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(68),
      Q => payload_a(70),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(69),
      Q => payload_a(71),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(70),
      Q => payload_a(72),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[73]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(71),
      Q => payload_a(73),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[74]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(72),
      Q => payload_a(74),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[75]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(73),
      Q => payload_a(75),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[76]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(74),
      Q => payload_a(76),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[77]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(75),
      Q => payload_a(77),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[78]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(76),
      Q => payload_a(78),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[79]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(77),
      Q => payload_a(79),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(7),
      Q => payload_a(7),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[80]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(78),
      Q => payload_a(80),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[81]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(79),
      Q => payload_a(81),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[82]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(80),
      Q => payload_a(82),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[83]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(81),
      Q => payload_a(83),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[84]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(82),
      Q => payload_a(84),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[85]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(83),
      Q => payload_a(85),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[86]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(84),
      Q => payload_a(86),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[87]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(85),
      Q => payload_a(87),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[88]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(86),
      Q => payload_a(88),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[89]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(87),
      Q => payload_a(89),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(8),
      Q => payload_a(8),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[90]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(88),
      Q => payload_a(90),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[91]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(89),
      Q => payload_a(91),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[92]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(90),
      Q => payload_a(92),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[93]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(91),
      Q => payload_a(93),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[94]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(92),
      Q => payload_a(94),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[95]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(93),
      Q => payload_a(95),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[96]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(94),
      Q => payload_a(96),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[97]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(95),
      Q => payload_a(97),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[98]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(96),
      Q => payload_a(98),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[99]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(97),
      Q => payload_a(99),
      R => '0'
    );
\gen_AB_reg_slice.payload_a_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_a_1,
      D => D(9),
      Q => payload_a(9),
      R => '0'
    );
\gen_AB_reg_slice.payload_b[116]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"D0"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => sel_wr,
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
      D => D(98),
      Q => payload_b(100),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[101]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(99),
      Q => payload_b(101),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[102]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(100),
      Q => payload_b(102),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[103]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(101),
      Q => payload_b(103),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[104]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(102),
      Q => payload_b(104),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[105]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(103),
      Q => payload_b(105),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[106]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(104),
      Q => payload_b(106),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[107]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(105),
      Q => payload_b(107),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[108]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(106),
      Q => payload_b(108),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[109]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(107),
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
      D => D(108),
      Q => payload_b(110),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[111]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(109),
      Q => payload_b(111),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[112]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(110),
      Q => payload_b(112),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[113]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(111),
      Q => payload_b(113),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[114]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(112),
      Q => payload_b(114),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[115]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(113),
      Q => payload_b(115),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[116]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(114),
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
\gen_AB_reg_slice.payload_b_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(33),
      Q => payload_b(34),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(34),
      Q => payload_b(36),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(35),
      Q => payload_b(37),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(36),
      Q => payload_b(38),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(37),
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
      D => D(38),
      Q => payload_b(40),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(39),
      Q => payload_b(41),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(40),
      Q => payload_b(42),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(41),
      Q => payload_b(43),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(42),
      Q => payload_b(44),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(43),
      Q => payload_b(45),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(44),
      Q => payload_b(46),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(45),
      Q => payload_b(47),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(46),
      Q => payload_b(48),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(47),
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
      D => D(48),
      Q => payload_b(50),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(49),
      Q => payload_b(51),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(50),
      Q => payload_b(52),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(51),
      Q => payload_b(53),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(52),
      Q => payload_b(54),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(53),
      Q => payload_b(55),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(54),
      Q => payload_b(56),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(55),
      Q => payload_b(57),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(56),
      Q => payload_b(58),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(57),
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
      D => D(58),
      Q => payload_b(60),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(59),
      Q => payload_b(61),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(60),
      Q => payload_b(62),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(61),
      Q => payload_b(63),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(62),
      Q => payload_b(64),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(63),
      Q => payload_b(65),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(64),
      Q => payload_b(66),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(65),
      Q => payload_b(67),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(66),
      Q => payload_b(68),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(67),
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
      D => D(68),
      Q => payload_b(70),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(69),
      Q => payload_b(71),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(70),
      Q => payload_b(72),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[73]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(71),
      Q => payload_b(73),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[74]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(72),
      Q => payload_b(74),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[75]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(73),
      Q => payload_b(75),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[76]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(74),
      Q => payload_b(76),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[77]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(75),
      Q => payload_b(77),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[78]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(76),
      Q => payload_b(78),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[79]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(77),
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
      D => D(78),
      Q => payload_b(80),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[81]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(79),
      Q => payload_b(81),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[82]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(80),
      Q => payload_b(82),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[83]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(81),
      Q => payload_b(83),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[84]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(82),
      Q => payload_b(84),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[85]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(83),
      Q => payload_b(85),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[86]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(84),
      Q => payload_b(86),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[87]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(85),
      Q => payload_b(87),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[88]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(86),
      Q => payload_b(88),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[89]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(87),
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
      D => D(88),
      Q => payload_b(90),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[91]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(89),
      Q => payload_b(91),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[92]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(90),
      Q => payload_b(92),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[93]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(91),
      Q => payload_b(93),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[94]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(92),
      Q => payload_b(94),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[95]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(93),
      Q => payload_b(95),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[96]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(94),
      Q => payload_b(96),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[97]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(95),
      Q => payload_b(97),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[98]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(96),
      Q => payload_b(98),
      R => '0'
    );
\gen_AB_reg_slice.payload_b_reg[99]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => payload_b_0,
      D => D(97),
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
\gen_AB_reg_slice.sel_rd_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \state_reg[0]\(0),
      I1 => \^q\(0),
      I2 => sel,
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
\gen_AB_reg_slice.sel_wr_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(1),
      I1 => s_axis_ppkt_tvalid,
      I2 => sel_wr,
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
      INIT => X"7088"
    )
        port map (
      I0 => \state_reg[0]\(0),
      I1 => \^q\(0),
      I2 => s_axis_ppkt_tvalid,
      I3 => \^q\(1),
      O => state(0)
    );
\gen_AB_reg_slice.state[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"78BB"
    )
        port map (
      I0 => \state_reg[0]\(0),
      I1 => \^q\(0),
      I2 => s_axis_ppkt_tvalid,
      I3 => \^q\(1),
      O => \gen_AB_reg_slice.state[1]_i_1_n_0\
    );
\gen_AB_reg_slice.state[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BCBB"
    )
        port map (
      I0 => \state_reg[0]\(0),
      I1 => \^q\(0),
      I2 => s_axis_ppkt_tvalid,
      I3 => \^q\(1),
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
r0_last_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(36),
      I1 => payload_a(36),
      I2 => sel,
      O => S_AXIS_TLAST
    );
\r0_user[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(37),
      I1 => payload_a(37),
      I2 => sel,
      O => \r0_user_reg[79]\(0)
    );
\r0_user[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(47),
      I1 => payload_a(47),
      I2 => sel,
      O => \r0_user_reg[79]\(10)
    );
\r0_user[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(48),
      I1 => payload_a(48),
      I2 => sel,
      O => \r0_user_reg[79]\(11)
    );
\r0_user[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(49),
      I1 => payload_a(49),
      I2 => sel,
      O => \r0_user_reg[79]\(12)
    );
\r0_user[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(50),
      I1 => payload_a(50),
      I2 => sel,
      O => \r0_user_reg[79]\(13)
    );
\r0_user[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(51),
      I1 => payload_a(51),
      I2 => sel,
      O => \r0_user_reg[79]\(14)
    );
\r0_user[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(52),
      I1 => payload_a(52),
      I2 => sel,
      O => \r0_user_reg[79]\(15)
    );
\r0_user[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(53),
      I1 => payload_a(53),
      I2 => sel,
      O => \r0_user_reg[79]\(16)
    );
\r0_user[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(54),
      I1 => payload_a(54),
      I2 => sel,
      O => \r0_user_reg[79]\(17)
    );
\r0_user[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(55),
      I1 => payload_a(55),
      I2 => sel,
      O => \r0_user_reg[79]\(18)
    );
\r0_user[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(56),
      I1 => payload_a(56),
      I2 => sel,
      O => \r0_user_reg[79]\(19)
    );
\r0_user[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(38),
      I1 => payload_a(38),
      I2 => sel,
      O => \r0_user_reg[79]\(1)
    );
\r0_user[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(57),
      I1 => payload_a(57),
      I2 => sel,
      O => \r0_user_reg[79]\(20)
    );
\r0_user[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(58),
      I1 => payload_a(58),
      I2 => sel,
      O => \r0_user_reg[79]\(21)
    );
\r0_user[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(59),
      I1 => payload_a(59),
      I2 => sel,
      O => \r0_user_reg[79]\(22)
    );
\r0_user[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(60),
      I1 => payload_a(60),
      I2 => sel,
      O => \r0_user_reg[79]\(23)
    );
\r0_user[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(61),
      I1 => payload_a(61),
      I2 => sel,
      O => \r0_user_reg[79]\(24)
    );
\r0_user[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(62),
      I1 => payload_a(62),
      I2 => sel,
      O => \r0_user_reg[79]\(25)
    );
\r0_user[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(63),
      I1 => payload_a(63),
      I2 => sel,
      O => \r0_user_reg[79]\(26)
    );
\r0_user[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(64),
      I1 => payload_a(64),
      I2 => sel,
      O => \r0_user_reg[79]\(27)
    );
\r0_user[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(65),
      I1 => payload_a(65),
      I2 => sel,
      O => \r0_user_reg[79]\(28)
    );
\r0_user[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(66),
      I1 => payload_a(66),
      I2 => sel,
      O => \r0_user_reg[79]\(29)
    );
\r0_user[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(39),
      I1 => payload_a(39),
      I2 => sel,
      O => \r0_user_reg[79]\(2)
    );
\r0_user[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(67),
      I1 => payload_a(67),
      I2 => sel,
      O => \r0_user_reg[79]\(30)
    );
\r0_user[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(68),
      I1 => payload_a(68),
      I2 => sel,
      O => \r0_user_reg[79]\(31)
    );
\r0_user[32]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(69),
      I1 => payload_a(69),
      I2 => sel,
      O => \r0_user_reg[79]\(32)
    );
\r0_user[33]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(70),
      I1 => payload_a(70),
      I2 => sel,
      O => \r0_user_reg[79]\(33)
    );
\r0_user[34]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(71),
      I1 => payload_a(71),
      I2 => sel,
      O => \r0_user_reg[79]\(34)
    );
\r0_user[35]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(72),
      I1 => payload_a(72),
      I2 => sel,
      O => \r0_user_reg[79]\(35)
    );
\r0_user[36]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(73),
      I1 => payload_a(73),
      I2 => sel,
      O => \r0_user_reg[79]\(36)
    );
\r0_user[37]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(74),
      I1 => payload_a(74),
      I2 => sel,
      O => \r0_user_reg[79]\(37)
    );
\r0_user[38]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(75),
      I1 => payload_a(75),
      I2 => sel,
      O => \r0_user_reg[79]\(38)
    );
\r0_user[39]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(76),
      I1 => payload_a(76),
      I2 => sel,
      O => \r0_user_reg[79]\(39)
    );
\r0_user[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(40),
      I1 => payload_a(40),
      I2 => sel,
      O => \r0_user_reg[79]\(3)
    );
\r0_user[40]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(77),
      I1 => payload_a(77),
      I2 => sel,
      O => \r0_user_reg[79]\(40)
    );
\r0_user[41]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(78),
      I1 => payload_a(78),
      I2 => sel,
      O => \r0_user_reg[79]\(41)
    );
\r0_user[42]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(79),
      I1 => payload_a(79),
      I2 => sel,
      O => \r0_user_reg[79]\(42)
    );
\r0_user[43]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(80),
      I1 => payload_a(80),
      I2 => sel,
      O => \r0_user_reg[79]\(43)
    );
\r0_user[44]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(81),
      I1 => payload_a(81),
      I2 => sel,
      O => \r0_user_reg[79]\(44)
    );
\r0_user[45]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(82),
      I1 => payload_a(82),
      I2 => sel,
      O => \r0_user_reg[79]\(45)
    );
\r0_user[46]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(83),
      I1 => payload_a(83),
      I2 => sel,
      O => \r0_user_reg[79]\(46)
    );
\r0_user[47]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(84),
      I1 => payload_a(84),
      I2 => sel,
      O => \r0_user_reg[79]\(47)
    );
\r0_user[48]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(85),
      I1 => payload_a(85),
      I2 => sel,
      O => \r0_user_reg[79]\(48)
    );
\r0_user[49]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(86),
      I1 => payload_a(86),
      I2 => sel,
      O => \r0_user_reg[79]\(49)
    );
\r0_user[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(41),
      I1 => payload_a(41),
      I2 => sel,
      O => \r0_user_reg[79]\(4)
    );
\r0_user[50]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(87),
      I1 => payload_a(87),
      I2 => sel,
      O => \r0_user_reg[79]\(50)
    );
\r0_user[51]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(88),
      I1 => payload_a(88),
      I2 => sel,
      O => \r0_user_reg[79]\(51)
    );
\r0_user[52]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(89),
      I1 => payload_a(89),
      I2 => sel,
      O => \r0_user_reg[79]\(52)
    );
\r0_user[53]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(90),
      I1 => payload_a(90),
      I2 => sel,
      O => \r0_user_reg[79]\(53)
    );
\r0_user[54]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(91),
      I1 => payload_a(91),
      I2 => sel,
      O => \r0_user_reg[79]\(54)
    );
\r0_user[55]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(92),
      I1 => payload_a(92),
      I2 => sel,
      O => \r0_user_reg[79]\(55)
    );
\r0_user[56]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(93),
      I1 => payload_a(93),
      I2 => sel,
      O => \r0_user_reg[79]\(56)
    );
\r0_user[57]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(94),
      I1 => payload_a(94),
      I2 => sel,
      O => \r0_user_reg[79]\(57)
    );
\r0_user[58]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(95),
      I1 => payload_a(95),
      I2 => sel,
      O => \r0_user_reg[79]\(58)
    );
\r0_user[59]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(96),
      I1 => payload_a(96),
      I2 => sel,
      O => \r0_user_reg[79]\(59)
    );
\r0_user[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(42),
      I1 => payload_a(42),
      I2 => sel,
      O => \r0_user_reg[79]\(5)
    );
\r0_user[60]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(97),
      I1 => payload_a(97),
      I2 => sel,
      O => \r0_user_reg[79]\(60)
    );
\r0_user[61]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(98),
      I1 => payload_a(98),
      I2 => sel,
      O => \r0_user_reg[79]\(61)
    );
\r0_user[62]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(99),
      I1 => payload_a(99),
      I2 => sel,
      O => \r0_user_reg[79]\(62)
    );
\r0_user[63]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(100),
      I1 => payload_a(100),
      I2 => sel,
      O => \r0_user_reg[79]\(63)
    );
\r0_user[64]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(101),
      I1 => payload_a(101),
      I2 => sel,
      O => \r0_user_reg[79]\(64)
    );
\r0_user[65]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(102),
      I1 => payload_a(102),
      I2 => sel,
      O => \r0_user_reg[79]\(65)
    );
\r0_user[66]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(103),
      I1 => payload_a(103),
      I2 => sel,
      O => \r0_user_reg[79]\(66)
    );
\r0_user[67]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(104),
      I1 => payload_a(104),
      I2 => sel,
      O => \r0_user_reg[79]\(67)
    );
\r0_user[68]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(105),
      I1 => payload_a(105),
      I2 => sel,
      O => \r0_user_reg[79]\(68)
    );
\r0_user[69]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(106),
      I1 => payload_a(106),
      I2 => sel,
      O => \r0_user_reg[79]\(69)
    );
\r0_user[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(43),
      I1 => payload_a(43),
      I2 => sel,
      O => \r0_user_reg[79]\(6)
    );
\r0_user[70]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(107),
      I1 => payload_a(107),
      I2 => sel,
      O => \r0_user_reg[79]\(70)
    );
\r0_user[71]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(108),
      I1 => payload_a(108),
      I2 => sel,
      O => \r0_user_reg[79]\(71)
    );
\r0_user[72]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(109),
      I1 => payload_a(109),
      I2 => sel,
      O => \r0_user_reg[79]\(72)
    );
\r0_user[73]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(110),
      I1 => payload_a(110),
      I2 => sel,
      O => \r0_user_reg[79]\(73)
    );
\r0_user[74]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(111),
      I1 => payload_a(111),
      I2 => sel,
      O => \r0_user_reg[79]\(74)
    );
\r0_user[75]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(112),
      I1 => payload_a(112),
      I2 => sel,
      O => \r0_user_reg[79]\(75)
    );
\r0_user[76]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(113),
      I1 => payload_a(113),
      I2 => sel,
      O => \r0_user_reg[79]\(76)
    );
\r0_user[77]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(114),
      I1 => payload_a(114),
      I2 => sel,
      O => \r0_user_reg[79]\(77)
    );
\r0_user[78]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(115),
      I1 => payload_a(115),
      I2 => sel,
      O => \r0_user_reg[79]\(78)
    );
\r0_user[79]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(116),
      I1 => payload_a(116),
      I2 => sel,
      O => \r0_user_reg[79]\(79)
    );
\r0_user[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(44),
      I1 => payload_a(44),
      I2 => sel,
      O => \r0_user_reg[79]\(7)
    );
\r0_user[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(45),
      I1 => payload_a(45),
      I2 => sel,
      O => \r0_user_reg[79]\(8)
    );
\r0_user[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => payload_b(46),
      I1 => payload_a(46),
      I2 => sel,
      O => \r0_user_reg[79]\(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_upsizer is
  port (
    Q : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_ppkt_tlast : out STD_LOGIC;
    m_axis_ppkt_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_ppkt_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_ppkt_tuser : out STD_LOGIC_VECTOR ( 79 downto 0 );
    S_AXIS_TLAST : in STD_LOGIC;
    aclk : in STD_LOGIC;
    m_axis_ppkt_tready : in STD_LOGIC;
    \gen_AB_reg_slice.state_reg[0]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    areset_r : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \gen_AB_reg_slice.payload_b_reg[34]\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_AB_reg_slice.payload_b_reg[116]\ : in STD_LOGIC_VECTOR ( 79 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_upsizer : entity is "px_axis_dwidth_conv_axisc_upsizer";
end px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_upsizer;

architecture STRUCTURE of px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_upsizer is
  signal \FSM_onehot_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[0]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[0]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[2]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[0]\ : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of \FSM_onehot_state_reg_n_0_[0]\ : signal is "yes";
  signal \FSM_onehot_state_reg_n_0_[1]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_state_reg_n_0_[1]\ : signal is "yes";
  signal \FSM_onehot_state_reg_n_0_[2]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_state_reg_n_0_[2]\ : signal is "yes";
  signal \FSM_onehot_state_reg_n_0_[4]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_state_reg_n_0_[4]\ : signal is "yes";
  signal \^q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \acc_data[255]_i_1_n_0\ : STD_LOGIC;
  signal acc_last_i_1_n_0 : STD_LOGIC;
  signal acc_reg_en : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal acc_strb : STD_LOGIC;
  signal \gen_data_accumulator[6].acc_data[223]_i_1_n_0\ : STD_LOGIC;
  signal \^m_axis_ppkt_tlast\ : STD_LOGIC;
  signal p_0_in4_in : STD_LOGIC;
  attribute RTL_KEEP of p_0_in4_in : signal is "yes";
  signal p_1_in : STD_LOGIC_VECTOR ( 6 to 6 );
  signal p_1_in2_in : STD_LOGIC;
  signal r0_data : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal r0_keep : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal r0_last_reg_n_0 : STD_LOGIC;
  signal \r0_reg_sel_reg_n_0_[0]\ : STD_LOGIC;
  signal \r0_reg_sel_reg_n_0_[1]\ : STD_LOGIC;
  signal \r0_reg_sel_reg_n_0_[2]\ : STD_LOGIC;
  signal \r0_reg_sel_reg_n_0_[3]\ : STD_LOGIC;
  signal \r0_reg_sel_reg_n_0_[4]\ : STD_LOGIC;
  signal \r0_reg_sel_reg_n_0_[5]\ : STD_LOGIC;
  signal \r0_reg_sel_reg_n_0_[6]\ : STD_LOGIC;
  signal r0_user : STD_LOGIC_VECTOR ( 79 downto 0 );
  signal state : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal state1 : STD_LOGIC;
  signal \state[1]_i_2_n_0\ : STD_LOGIC;
  signal \state[2]_i_2_n_0\ : STD_LOGIC;
  signal \state[2]_i_3_n_0\ : STD_LOGIC;
  signal \state_reg_n_0_[2]\ : STD_LOGIC;
  attribute KEEP : string;
  attribute KEEP of \FSM_onehot_state_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_onehot_state_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_onehot_state_reg[2]\ : label is "yes";
  attribute KEEP of \FSM_onehot_state_reg[3]\ : label is "yes";
  attribute KEEP of \FSM_onehot_state_reg[4]\ : label is "yes";
begin
  Q(1 downto 0) <= \^q\(1 downto 0);
  m_axis_ppkt_tlast <= \^m_axis_ppkt_tlast\;
\FSM_onehot_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFF10"
    )
        port map (
      I0 => state1,
      I1 => \gen_AB_reg_slice.state_reg[0]\(0),
      I2 => \FSM_onehot_state_reg_n_0_[0]\,
      I3 => \FSM_onehot_state[0]_i_2_n_0\,
      I4 => \FSM_onehot_state[0]_i_3_n_0\,
      I5 => \FSM_onehot_state[0]_i_4_n_0\,
      O => \FSM_onehot_state[0]_i_1_n_0\
    );
\FSM_onehot_state[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0001"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[2]\,
      I1 => \FSM_onehot_state_reg_n_0_[4]\,
      I2 => p_0_in4_in,
      I3 => \FSM_onehot_state_reg_n_0_[0]\,
      I4 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \FSM_onehot_state[0]_i_2_n_0\
    );
\FSM_onehot_state[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00020000"
    )
        port map (
      I0 => m_axis_ppkt_tready,
      I1 => \gen_AB_reg_slice.state_reg[0]\(0),
      I2 => \FSM_onehot_state_reg_n_0_[0]\,
      I3 => p_0_in4_in,
      I4 => \FSM_onehot_state_reg_n_0_[2]\,
      O => \FSM_onehot_state[0]_i_3_n_0\
    );
\FSM_onehot_state[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => \gen_AB_reg_slice.state_reg[0]\(0),
      I2 => r0_last_reg_n_0,
      I3 => p_0_in4_in,
      O => \FSM_onehot_state[0]_i_4_n_0\
    );
\FSM_onehot_state[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FFF8"
    )
        port map (
      I0 => state1,
      I1 => \FSM_onehot_state_reg_n_0_[0]\,
      I2 => \FSM_onehot_state[2]_i_2_n_0\,
      I3 => \FSM_onehot_state[2]_i_3_n_0\,
      I4 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \FSM_onehot_state[2]_i_1_n_0\
    );
\FSM_onehot_state[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0055540000000000"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => p_1_in2_in,
      I2 => \r0_reg_sel_reg_n_0_[6]\,
      I3 => \gen_AB_reg_slice.state_reg[0]\(0),
      I4 => r0_last_reg_n_0,
      I5 => p_0_in4_in,
      O => \FSM_onehot_state[2]_i_2_n_0\
    );
\FSM_onehot_state[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => m_axis_ppkt_tready,
      I1 => \gen_AB_reg_slice.state_reg[0]\(0),
      I2 => \FSM_onehot_state_reg_n_0_[0]\,
      I3 => p_0_in4_in,
      I4 => \FSM_onehot_state_reg_n_0_[2]\,
      O => \FSM_onehot_state[2]_i_3_n_0\
    );
\FSM_onehot_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000002222FFF0"
    )
        port map (
      I0 => \gen_AB_reg_slice.state_reg[0]\(0),
      I1 => state1,
      I2 => \FSM_onehot_state[3]_i_3_n_0\,
      I3 => \FSM_onehot_state[3]_i_4_n_0\,
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \FSM_onehot_state[3]_i_1_n_0\
    );
\FSM_onehot_state[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EA00"
    )
        port map (
      I0 => p_1_in2_in,
      I1 => p_0_in4_in,
      I2 => \r0_reg_sel_reg_n_0_[6]\,
      I3 => \gen_AB_reg_slice.state_reg[0]\(0),
      O => state1
    );
\FSM_onehot_state[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AC00"
    )
        port map (
      I0 => \gen_AB_reg_slice.state_reg[0]\(0),
      I1 => \FSM_onehot_state_reg_n_0_[4]\,
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axis_ppkt_tready,
      I4 => p_0_in4_in,
      O => \FSM_onehot_state[3]_i_3_n_0\
    );
\FSM_onehot_state[3]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000200"
    )
        port map (
      I0 => \gen_AB_reg_slice.state_reg[0]\(0),
      I1 => r0_last_reg_n_0,
      I2 => p_1_in2_in,
      I3 => p_0_in4_in,
      I4 => \r0_reg_sel_reg_n_0_[6]\,
      O => \FSM_onehot_state[3]_i_4_n_0\
    );
\FSM_onehot_state[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[1]\,
      I1 => \FSM_onehot_state_reg_n_0_[0]\,
      I2 => \FSM_onehot_state[4]_i_2_n_0\,
      O => \FSM_onehot_state[4]_i_1_n_0\
    );
\FSM_onehot_state[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF54001000540010"
    )
        port map (
      I0 => m_axis_ppkt_tready,
      I1 => \FSM_onehot_state_reg_n_0_[2]\,
      I2 => \FSM_onehot_state_reg_n_0_[4]\,
      I3 => p_0_in4_in,
      I4 => \gen_AB_reg_slice.state_reg[0]\(0),
      I5 => r0_last_reg_n_0,
      O => \FSM_onehot_state[4]_i_2_n_0\
    );
\FSM_onehot_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \FSM_onehot_state[0]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[0]\,
      R => areset_r
    );
\FSM_onehot_state_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => aclk,
      CE => '1',
      D => '0',
      Q => \FSM_onehot_state_reg_n_0_[1]\,
      S => areset_r
    );
\FSM_onehot_state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \FSM_onehot_state[2]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[2]\,
      R => areset_r
    );
\FSM_onehot_state_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \FSM_onehot_state[3]_i_1_n_0\,
      Q => p_0_in4_in,
      R => areset_r
    );
\FSM_onehot_state_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \FSM_onehot_state[4]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[4]\,
      R => areset_r
    );
\acc_data[255]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => p_0_in4_in,
      O => \acc_data[255]_i_1_n_0\
    );
\acc_data[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in4_in,
      I1 => \r0_reg_sel_reg_n_0_[0]\,
      O => acc_reg_en(0)
    );
\acc_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(0),
      Q => m_axis_ppkt_tdata(0),
      R => '0'
    );
\acc_data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(10),
      Q => m_axis_ppkt_tdata(10),
      R => '0'
    );
\acc_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(11),
      Q => m_axis_ppkt_tdata(11),
      R => '0'
    );
\acc_data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(12),
      Q => m_axis_ppkt_tdata(12),
      R => '0'
    );
\acc_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(13),
      Q => m_axis_ppkt_tdata(13),
      R => '0'
    );
\acc_data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(14),
      Q => m_axis_ppkt_tdata(14),
      R => '0'
    );
\acc_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(15),
      Q => m_axis_ppkt_tdata(15),
      R => '0'
    );
\acc_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(16),
      Q => m_axis_ppkt_tdata(16),
      R => '0'
    );
\acc_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(17),
      Q => m_axis_ppkt_tdata(17),
      R => '0'
    );
\acc_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(18),
      Q => m_axis_ppkt_tdata(18),
      R => '0'
    );
\acc_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(19),
      Q => m_axis_ppkt_tdata(19),
      R => '0'
    );
\acc_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(1),
      Q => m_axis_ppkt_tdata(1),
      R => '0'
    );
\acc_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(20),
      Q => m_axis_ppkt_tdata(20),
      R => '0'
    );
\acc_data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(21),
      Q => m_axis_ppkt_tdata(21),
      R => '0'
    );
\acc_data_reg[224]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(0),
      Q => m_axis_ppkt_tdata(224),
      R => '0'
    );
\acc_data_reg[225]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(1),
      Q => m_axis_ppkt_tdata(225),
      R => '0'
    );
\acc_data_reg[226]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(2),
      Q => m_axis_ppkt_tdata(226),
      R => '0'
    );
\acc_data_reg[227]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(3),
      Q => m_axis_ppkt_tdata(227),
      R => '0'
    );
\acc_data_reg[228]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(4),
      Q => m_axis_ppkt_tdata(228),
      R => '0'
    );
\acc_data_reg[229]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(5),
      Q => m_axis_ppkt_tdata(229),
      R => '0'
    );
\acc_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(22),
      Q => m_axis_ppkt_tdata(22),
      R => '0'
    );
\acc_data_reg[230]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(6),
      Q => m_axis_ppkt_tdata(230),
      R => '0'
    );
\acc_data_reg[231]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(7),
      Q => m_axis_ppkt_tdata(231),
      R => '0'
    );
\acc_data_reg[232]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(8),
      Q => m_axis_ppkt_tdata(232),
      R => '0'
    );
\acc_data_reg[233]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(9),
      Q => m_axis_ppkt_tdata(233),
      R => '0'
    );
\acc_data_reg[234]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(10),
      Q => m_axis_ppkt_tdata(234),
      R => '0'
    );
\acc_data_reg[235]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(11),
      Q => m_axis_ppkt_tdata(235),
      R => '0'
    );
\acc_data_reg[236]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(12),
      Q => m_axis_ppkt_tdata(236),
      R => '0'
    );
\acc_data_reg[237]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(13),
      Q => m_axis_ppkt_tdata(237),
      R => '0'
    );
\acc_data_reg[238]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(14),
      Q => m_axis_ppkt_tdata(238),
      R => '0'
    );
\acc_data_reg[239]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(15),
      Q => m_axis_ppkt_tdata(239),
      R => '0'
    );
\acc_data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(23),
      Q => m_axis_ppkt_tdata(23),
      R => '0'
    );
\acc_data_reg[240]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(16),
      Q => m_axis_ppkt_tdata(240),
      R => '0'
    );
\acc_data_reg[241]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(17),
      Q => m_axis_ppkt_tdata(241),
      R => '0'
    );
\acc_data_reg[242]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(18),
      Q => m_axis_ppkt_tdata(242),
      R => '0'
    );
\acc_data_reg[243]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(19),
      Q => m_axis_ppkt_tdata(243),
      R => '0'
    );
\acc_data_reg[244]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(20),
      Q => m_axis_ppkt_tdata(244),
      R => '0'
    );
\acc_data_reg[245]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(21),
      Q => m_axis_ppkt_tdata(245),
      R => '0'
    );
\acc_data_reg[246]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(22),
      Q => m_axis_ppkt_tdata(246),
      R => '0'
    );
\acc_data_reg[247]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(23),
      Q => m_axis_ppkt_tdata(247),
      R => '0'
    );
\acc_data_reg[248]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(24),
      Q => m_axis_ppkt_tdata(248),
      R => '0'
    );
\acc_data_reg[249]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(25),
      Q => m_axis_ppkt_tdata(249),
      R => '0'
    );
\acc_data_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(24),
      Q => m_axis_ppkt_tdata(24),
      R => '0'
    );
\acc_data_reg[250]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(26),
      Q => m_axis_ppkt_tdata(250),
      R => '0'
    );
\acc_data_reg[251]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(27),
      Q => m_axis_ppkt_tdata(251),
      R => '0'
    );
\acc_data_reg[252]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(28),
      Q => m_axis_ppkt_tdata(252),
      R => '0'
    );
\acc_data_reg[253]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(29),
      Q => m_axis_ppkt_tdata(253),
      R => '0'
    );
\acc_data_reg[254]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(30),
      Q => m_axis_ppkt_tdata(254),
      R => '0'
    );
\acc_data_reg[255]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => D(31),
      Q => m_axis_ppkt_tdata(255),
      R => '0'
    );
\acc_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(25),
      Q => m_axis_ppkt_tdata(25),
      R => '0'
    );
\acc_data_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(26),
      Q => m_axis_ppkt_tdata(26),
      R => '0'
    );
\acc_data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(27),
      Q => m_axis_ppkt_tdata(27),
      R => '0'
    );
\acc_data_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(28),
      Q => m_axis_ppkt_tdata(28),
      R => '0'
    );
\acc_data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(29),
      Q => m_axis_ppkt_tdata(29),
      R => '0'
    );
\acc_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(2),
      Q => m_axis_ppkt_tdata(2),
      R => '0'
    );
\acc_data_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(30),
      Q => m_axis_ppkt_tdata(30),
      R => '0'
    );
\acc_data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(31),
      Q => m_axis_ppkt_tdata(31),
      R => '0'
    );
\acc_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(3),
      Q => m_axis_ppkt_tdata(3),
      R => '0'
    );
\acc_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(4),
      Q => m_axis_ppkt_tdata(4),
      R => '0'
    );
\acc_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(5),
      Q => m_axis_ppkt_tdata(5),
      R => '0'
    );
\acc_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(6),
      Q => m_axis_ppkt_tdata(6),
      R => '0'
    );
\acc_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(7),
      Q => m_axis_ppkt_tdata(7),
      R => '0'
    );
\acc_data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(8),
      Q => m_axis_ppkt_tdata(8),
      R => '0'
    );
\acc_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_data(9),
      Q => m_axis_ppkt_tdata(9),
      R => '0'
    );
\acc_keep[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
        port map (
      I0 => r0_last_reg_n_0,
      I1 => \r0_reg_sel_reg_n_0_[0]\,
      I2 => p_0_in4_in,
      O => acc_strb
    );
\acc_keep_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_keep(0),
      Q => m_axis_ppkt_tkeep(0),
      R => '0'
    );
\acc_keep_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => \gen_AB_reg_slice.payload_b_reg[34]\(0),
      Q => m_axis_ppkt_tkeep(14),
      R => acc_strb
    );
\acc_keep_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_keep(2),
      Q => m_axis_ppkt_tkeep(1),
      R => '0'
    );
\acc_keep_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \acc_data[255]_i_1_n_0\,
      D => \gen_AB_reg_slice.payload_b_reg[34]\(1),
      Q => m_axis_ppkt_tkeep(15),
      R => acc_strb
    );
acc_last_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAFCAAAAAACC"
    )
        port map (
      I0 => \^m_axis_ppkt_tlast\,
      I1 => S_AXIS_TLAST,
      I2 => r0_last_reg_n_0,
      I3 => \FSM_onehot_state_reg_n_0_[4]\,
      I4 => \FSM_onehot_state_reg_n_0_[2]\,
      I5 => p_0_in4_in,
      O => acc_last_i_1_n_0
    );
acc_last_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => acc_last_i_1_n_0,
      Q => \^m_axis_ppkt_tlast\,
      R => '0'
    );
\acc_user_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(0),
      Q => m_axis_ppkt_tuser(0),
      R => '0'
    );
\acc_user_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(10),
      Q => m_axis_ppkt_tuser(10),
      R => '0'
    );
\acc_user_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(11),
      Q => m_axis_ppkt_tuser(11),
      R => '0'
    );
\acc_user_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(12),
      Q => m_axis_ppkt_tuser(12),
      R => '0'
    );
\acc_user_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(13),
      Q => m_axis_ppkt_tuser(13),
      R => '0'
    );
\acc_user_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(14),
      Q => m_axis_ppkt_tuser(14),
      R => '0'
    );
\acc_user_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(15),
      Q => m_axis_ppkt_tuser(15),
      R => '0'
    );
\acc_user_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(16),
      Q => m_axis_ppkt_tuser(16),
      R => '0'
    );
\acc_user_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(17),
      Q => m_axis_ppkt_tuser(17),
      R => '0'
    );
\acc_user_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(18),
      Q => m_axis_ppkt_tuser(18),
      R => '0'
    );
\acc_user_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(19),
      Q => m_axis_ppkt_tuser(19),
      R => '0'
    );
\acc_user_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(1),
      Q => m_axis_ppkt_tuser(1),
      R => '0'
    );
\acc_user_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(20),
      Q => m_axis_ppkt_tuser(20),
      R => '0'
    );
\acc_user_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(21),
      Q => m_axis_ppkt_tuser(21),
      R => '0'
    );
\acc_user_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(22),
      Q => m_axis_ppkt_tuser(22),
      R => '0'
    );
\acc_user_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(23),
      Q => m_axis_ppkt_tuser(23),
      R => '0'
    );
\acc_user_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(24),
      Q => m_axis_ppkt_tuser(24),
      R => '0'
    );
\acc_user_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(25),
      Q => m_axis_ppkt_tuser(25),
      R => '0'
    );
\acc_user_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(26),
      Q => m_axis_ppkt_tuser(26),
      R => '0'
    );
\acc_user_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(27),
      Q => m_axis_ppkt_tuser(27),
      R => '0'
    );
\acc_user_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(28),
      Q => m_axis_ppkt_tuser(28),
      R => '0'
    );
\acc_user_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(29),
      Q => m_axis_ppkt_tuser(29),
      R => '0'
    );
\acc_user_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(2),
      Q => m_axis_ppkt_tuser(2),
      R => '0'
    );
\acc_user_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(30),
      Q => m_axis_ppkt_tuser(30),
      R => '0'
    );
\acc_user_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(31),
      Q => m_axis_ppkt_tuser(31),
      R => '0'
    );
\acc_user_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(32),
      Q => m_axis_ppkt_tuser(32),
      R => '0'
    );
\acc_user_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(33),
      Q => m_axis_ppkt_tuser(33),
      R => '0'
    );
\acc_user_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(34),
      Q => m_axis_ppkt_tuser(34),
      R => '0'
    );
\acc_user_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(35),
      Q => m_axis_ppkt_tuser(35),
      R => '0'
    );
\acc_user_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(36),
      Q => m_axis_ppkt_tuser(36),
      R => '0'
    );
\acc_user_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(37),
      Q => m_axis_ppkt_tuser(37),
      R => '0'
    );
\acc_user_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(38),
      Q => m_axis_ppkt_tuser(38),
      R => '0'
    );
\acc_user_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(39),
      Q => m_axis_ppkt_tuser(39),
      R => '0'
    );
\acc_user_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(3),
      Q => m_axis_ppkt_tuser(3),
      R => '0'
    );
\acc_user_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(40),
      Q => m_axis_ppkt_tuser(40),
      R => '0'
    );
\acc_user_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(41),
      Q => m_axis_ppkt_tuser(41),
      R => '0'
    );
\acc_user_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(42),
      Q => m_axis_ppkt_tuser(42),
      R => '0'
    );
\acc_user_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(43),
      Q => m_axis_ppkt_tuser(43),
      R => '0'
    );
\acc_user_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(44),
      Q => m_axis_ppkt_tuser(44),
      R => '0'
    );
\acc_user_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(45),
      Q => m_axis_ppkt_tuser(45),
      R => '0'
    );
\acc_user_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(46),
      Q => m_axis_ppkt_tuser(46),
      R => '0'
    );
\acc_user_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(47),
      Q => m_axis_ppkt_tuser(47),
      R => '0'
    );
\acc_user_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(48),
      Q => m_axis_ppkt_tuser(48),
      R => '0'
    );
\acc_user_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(49),
      Q => m_axis_ppkt_tuser(49),
      R => '0'
    );
\acc_user_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(4),
      Q => m_axis_ppkt_tuser(4),
      R => '0'
    );
\acc_user_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(50),
      Q => m_axis_ppkt_tuser(50),
      R => '0'
    );
\acc_user_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(51),
      Q => m_axis_ppkt_tuser(51),
      R => '0'
    );
\acc_user_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(52),
      Q => m_axis_ppkt_tuser(52),
      R => '0'
    );
\acc_user_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(53),
      Q => m_axis_ppkt_tuser(53),
      R => '0'
    );
\acc_user_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(54),
      Q => m_axis_ppkt_tuser(54),
      R => '0'
    );
\acc_user_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(55),
      Q => m_axis_ppkt_tuser(55),
      R => '0'
    );
\acc_user_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(56),
      Q => m_axis_ppkt_tuser(56),
      R => '0'
    );
\acc_user_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(57),
      Q => m_axis_ppkt_tuser(57),
      R => '0'
    );
\acc_user_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(58),
      Q => m_axis_ppkt_tuser(58),
      R => '0'
    );
\acc_user_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(59),
      Q => m_axis_ppkt_tuser(59),
      R => '0'
    );
\acc_user_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(5),
      Q => m_axis_ppkt_tuser(5),
      R => '0'
    );
\acc_user_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(60),
      Q => m_axis_ppkt_tuser(60),
      R => '0'
    );
\acc_user_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(61),
      Q => m_axis_ppkt_tuser(61),
      R => '0'
    );
\acc_user_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(62),
      Q => m_axis_ppkt_tuser(62),
      R => '0'
    );
\acc_user_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(63),
      Q => m_axis_ppkt_tuser(63),
      R => '0'
    );
\acc_user_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(64),
      Q => m_axis_ppkt_tuser(64),
      R => '0'
    );
\acc_user_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(65),
      Q => m_axis_ppkt_tuser(65),
      R => '0'
    );
\acc_user_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(66),
      Q => m_axis_ppkt_tuser(66),
      R => '0'
    );
\acc_user_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(67),
      Q => m_axis_ppkt_tuser(67),
      R => '0'
    );
\acc_user_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(68),
      Q => m_axis_ppkt_tuser(68),
      R => '0'
    );
\acc_user_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(69),
      Q => m_axis_ppkt_tuser(69),
      R => '0'
    );
\acc_user_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(6),
      Q => m_axis_ppkt_tuser(6),
      R => '0'
    );
\acc_user_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(70),
      Q => m_axis_ppkt_tuser(70),
      R => '0'
    );
\acc_user_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(71),
      Q => m_axis_ppkt_tuser(71),
      R => '0'
    );
\acc_user_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(72),
      Q => m_axis_ppkt_tuser(72),
      R => '0'
    );
\acc_user_reg[73]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(73),
      Q => m_axis_ppkt_tuser(73),
      R => '0'
    );
\acc_user_reg[74]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(74),
      Q => m_axis_ppkt_tuser(74),
      R => '0'
    );
\acc_user_reg[75]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(75),
      Q => m_axis_ppkt_tuser(75),
      R => '0'
    );
\acc_user_reg[76]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(76),
      Q => m_axis_ppkt_tuser(76),
      R => '0'
    );
\acc_user_reg[77]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(77),
      Q => m_axis_ppkt_tuser(77),
      R => '0'
    );
\acc_user_reg[78]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(78),
      Q => m_axis_ppkt_tuser(78),
      R => '0'
    );
\acc_user_reg[79]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(79),
      Q => m_axis_ppkt_tuser(79),
      R => '0'
    );
\acc_user_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(7),
      Q => m_axis_ppkt_tuser(7),
      R => '0'
    );
\acc_user_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(8),
      Q => m_axis_ppkt_tuser(8),
      R => '0'
    );
\acc_user_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(0),
      D => r0_user(9),
      Q => m_axis_ppkt_tuser(9),
      R => '0'
    );
\gen_data_accumulator[1].acc_data[63]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in4_in,
      I1 => \r0_reg_sel_reg_n_0_[1]\,
      O => acc_reg_en(1)
    );
\gen_data_accumulator[1].acc_data_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(0),
      Q => m_axis_ppkt_tdata(32),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(1),
      Q => m_axis_ppkt_tdata(33),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(2),
      Q => m_axis_ppkt_tdata(34),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(3),
      Q => m_axis_ppkt_tdata(35),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(4),
      Q => m_axis_ppkt_tdata(36),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(5),
      Q => m_axis_ppkt_tdata(37),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(6),
      Q => m_axis_ppkt_tdata(38),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(7),
      Q => m_axis_ppkt_tdata(39),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(8),
      Q => m_axis_ppkt_tdata(40),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(9),
      Q => m_axis_ppkt_tdata(41),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(10),
      Q => m_axis_ppkt_tdata(42),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(11),
      Q => m_axis_ppkt_tdata(43),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(12),
      Q => m_axis_ppkt_tdata(44),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(13),
      Q => m_axis_ppkt_tdata(45),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(14),
      Q => m_axis_ppkt_tdata(46),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(15),
      Q => m_axis_ppkt_tdata(47),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(16),
      Q => m_axis_ppkt_tdata(48),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(17),
      Q => m_axis_ppkt_tdata(49),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(18),
      Q => m_axis_ppkt_tdata(50),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(19),
      Q => m_axis_ppkt_tdata(51),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(20),
      Q => m_axis_ppkt_tdata(52),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(21),
      Q => m_axis_ppkt_tdata(53),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(22),
      Q => m_axis_ppkt_tdata(54),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(23),
      Q => m_axis_ppkt_tdata(55),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(24),
      Q => m_axis_ppkt_tdata(56),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(25),
      Q => m_axis_ppkt_tdata(57),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(26),
      Q => m_axis_ppkt_tdata(58),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(27),
      Q => m_axis_ppkt_tdata(59),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(28),
      Q => m_axis_ppkt_tdata(60),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(29),
      Q => m_axis_ppkt_tdata(61),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(30),
      Q => m_axis_ppkt_tdata(62),
      R => '0'
    );
\gen_data_accumulator[1].acc_data_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_data(31),
      Q => m_axis_ppkt_tdata(63),
      R => '0'
    );
\gen_data_accumulator[1].acc_keep_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_keep(0),
      Q => m_axis_ppkt_tkeep(2),
      R => acc_reg_en(0)
    );
\gen_data_accumulator[1].acc_keep_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(1),
      D => r0_keep(2),
      Q => m_axis_ppkt_tkeep(3),
      R => acc_reg_en(0)
    );
\gen_data_accumulator[2].acc_data[95]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in4_in,
      I1 => \r0_reg_sel_reg_n_0_[2]\,
      O => acc_reg_en(2)
    );
\gen_data_accumulator[2].acc_data_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(0),
      Q => m_axis_ppkt_tdata(64),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(1),
      Q => m_axis_ppkt_tdata(65),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(2),
      Q => m_axis_ppkt_tdata(66),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(3),
      Q => m_axis_ppkt_tdata(67),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(4),
      Q => m_axis_ppkt_tdata(68),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(5),
      Q => m_axis_ppkt_tdata(69),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(6),
      Q => m_axis_ppkt_tdata(70),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(7),
      Q => m_axis_ppkt_tdata(71),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(8),
      Q => m_axis_ppkt_tdata(72),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[73]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(9),
      Q => m_axis_ppkt_tdata(73),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[74]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(10),
      Q => m_axis_ppkt_tdata(74),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[75]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(11),
      Q => m_axis_ppkt_tdata(75),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[76]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(12),
      Q => m_axis_ppkt_tdata(76),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[77]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(13),
      Q => m_axis_ppkt_tdata(77),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[78]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(14),
      Q => m_axis_ppkt_tdata(78),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[79]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(15),
      Q => m_axis_ppkt_tdata(79),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[80]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(16),
      Q => m_axis_ppkt_tdata(80),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[81]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(17),
      Q => m_axis_ppkt_tdata(81),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[82]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(18),
      Q => m_axis_ppkt_tdata(82),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[83]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(19),
      Q => m_axis_ppkt_tdata(83),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[84]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(20),
      Q => m_axis_ppkt_tdata(84),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[85]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(21),
      Q => m_axis_ppkt_tdata(85),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[86]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(22),
      Q => m_axis_ppkt_tdata(86),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[87]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(23),
      Q => m_axis_ppkt_tdata(87),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[88]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(24),
      Q => m_axis_ppkt_tdata(88),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[89]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(25),
      Q => m_axis_ppkt_tdata(89),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[90]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(26),
      Q => m_axis_ppkt_tdata(90),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[91]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(27),
      Q => m_axis_ppkt_tdata(91),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[92]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(28),
      Q => m_axis_ppkt_tdata(92),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[93]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(29),
      Q => m_axis_ppkt_tdata(93),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[94]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(30),
      Q => m_axis_ppkt_tdata(94),
      R => '0'
    );
\gen_data_accumulator[2].acc_data_reg[95]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_data(31),
      Q => m_axis_ppkt_tdata(95),
      R => '0'
    );
\gen_data_accumulator[2].acc_keep_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_keep(2),
      Q => m_axis_ppkt_tkeep(5),
      R => acc_reg_en(0)
    );
\gen_data_accumulator[2].acc_keep_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(2),
      D => r0_keep(0),
      Q => m_axis_ppkt_tkeep(4),
      R => acc_reg_en(0)
    );
\gen_data_accumulator[3].acc_data[127]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in4_in,
      I1 => \r0_reg_sel_reg_n_0_[3]\,
      O => acc_reg_en(3)
    );
\gen_data_accumulator[3].acc_data_reg[100]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(4),
      Q => m_axis_ppkt_tdata(100),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[101]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(5),
      Q => m_axis_ppkt_tdata(101),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[102]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(6),
      Q => m_axis_ppkt_tdata(102),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[103]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(7),
      Q => m_axis_ppkt_tdata(103),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[104]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(8),
      Q => m_axis_ppkt_tdata(104),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[105]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(9),
      Q => m_axis_ppkt_tdata(105),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[106]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(10),
      Q => m_axis_ppkt_tdata(106),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[107]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(11),
      Q => m_axis_ppkt_tdata(107),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[108]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(12),
      Q => m_axis_ppkt_tdata(108),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[109]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(13),
      Q => m_axis_ppkt_tdata(109),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[110]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(14),
      Q => m_axis_ppkt_tdata(110),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[111]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(15),
      Q => m_axis_ppkt_tdata(111),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[112]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(16),
      Q => m_axis_ppkt_tdata(112),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[113]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(17),
      Q => m_axis_ppkt_tdata(113),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[114]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(18),
      Q => m_axis_ppkt_tdata(114),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[115]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(19),
      Q => m_axis_ppkt_tdata(115),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[116]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(20),
      Q => m_axis_ppkt_tdata(116),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[117]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(21),
      Q => m_axis_ppkt_tdata(117),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[118]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(22),
      Q => m_axis_ppkt_tdata(118),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[119]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(23),
      Q => m_axis_ppkt_tdata(119),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[120]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(24),
      Q => m_axis_ppkt_tdata(120),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[121]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(25),
      Q => m_axis_ppkt_tdata(121),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[122]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(26),
      Q => m_axis_ppkt_tdata(122),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[123]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(27),
      Q => m_axis_ppkt_tdata(123),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[124]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(28),
      Q => m_axis_ppkt_tdata(124),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[125]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(29),
      Q => m_axis_ppkt_tdata(125),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[126]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(30),
      Q => m_axis_ppkt_tdata(126),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[127]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(31),
      Q => m_axis_ppkt_tdata(127),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[96]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(0),
      Q => m_axis_ppkt_tdata(96),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[97]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(1),
      Q => m_axis_ppkt_tdata(97),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[98]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(2),
      Q => m_axis_ppkt_tdata(98),
      R => '0'
    );
\gen_data_accumulator[3].acc_data_reg[99]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_data(3),
      Q => m_axis_ppkt_tdata(99),
      R => '0'
    );
\gen_data_accumulator[3].acc_keep_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_keep(0),
      Q => m_axis_ppkt_tkeep(6),
      R => acc_reg_en(0)
    );
\gen_data_accumulator[3].acc_keep_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(3),
      D => r0_keep(2),
      Q => m_axis_ppkt_tkeep(7),
      R => acc_reg_en(0)
    );
\gen_data_accumulator[4].acc_data[159]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in4_in,
      I1 => \r0_reg_sel_reg_n_0_[4]\,
      O => acc_reg_en(4)
    );
\gen_data_accumulator[4].acc_data_reg[128]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(0),
      Q => m_axis_ppkt_tdata(128),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[129]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(1),
      Q => m_axis_ppkt_tdata(129),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[130]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(2),
      Q => m_axis_ppkt_tdata(130),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[131]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(3),
      Q => m_axis_ppkt_tdata(131),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[132]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(4),
      Q => m_axis_ppkt_tdata(132),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[133]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(5),
      Q => m_axis_ppkt_tdata(133),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[134]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(6),
      Q => m_axis_ppkt_tdata(134),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[135]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(7),
      Q => m_axis_ppkt_tdata(135),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[136]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(8),
      Q => m_axis_ppkt_tdata(136),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[137]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(9),
      Q => m_axis_ppkt_tdata(137),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[138]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(10),
      Q => m_axis_ppkt_tdata(138),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[139]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(11),
      Q => m_axis_ppkt_tdata(139),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[140]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(12),
      Q => m_axis_ppkt_tdata(140),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[141]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(13),
      Q => m_axis_ppkt_tdata(141),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[142]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(14),
      Q => m_axis_ppkt_tdata(142),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[143]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(15),
      Q => m_axis_ppkt_tdata(143),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[144]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(16),
      Q => m_axis_ppkt_tdata(144),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[145]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(17),
      Q => m_axis_ppkt_tdata(145),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[146]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(18),
      Q => m_axis_ppkt_tdata(146),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[147]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(19),
      Q => m_axis_ppkt_tdata(147),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[148]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(20),
      Q => m_axis_ppkt_tdata(148),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[149]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(21),
      Q => m_axis_ppkt_tdata(149),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[150]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(22),
      Q => m_axis_ppkt_tdata(150),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[151]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(23),
      Q => m_axis_ppkt_tdata(151),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[152]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(24),
      Q => m_axis_ppkt_tdata(152),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[153]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(25),
      Q => m_axis_ppkt_tdata(153),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[154]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(26),
      Q => m_axis_ppkt_tdata(154),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[155]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(27),
      Q => m_axis_ppkt_tdata(155),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[156]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(28),
      Q => m_axis_ppkt_tdata(156),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[157]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(29),
      Q => m_axis_ppkt_tdata(157),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[158]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(30),
      Q => m_axis_ppkt_tdata(158),
      R => '0'
    );
\gen_data_accumulator[4].acc_data_reg[159]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_data(31),
      Q => m_axis_ppkt_tdata(159),
      R => '0'
    );
\gen_data_accumulator[4].acc_keep_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_keep(0),
      Q => m_axis_ppkt_tkeep(8),
      R => acc_reg_en(0)
    );
\gen_data_accumulator[4].acc_keep_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(4),
      D => r0_keep(2),
      Q => m_axis_ppkt_tkeep(9),
      R => acc_reg_en(0)
    );
\gen_data_accumulator[5].acc_data[191]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in4_in,
      I1 => \r0_reg_sel_reg_n_0_[5]\,
      O => acc_reg_en(5)
    );
\gen_data_accumulator[5].acc_data_reg[160]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(0),
      Q => m_axis_ppkt_tdata(160),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[161]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(1),
      Q => m_axis_ppkt_tdata(161),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[162]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(2),
      Q => m_axis_ppkt_tdata(162),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[163]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(3),
      Q => m_axis_ppkt_tdata(163),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[164]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(4),
      Q => m_axis_ppkt_tdata(164),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[165]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(5),
      Q => m_axis_ppkt_tdata(165),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[166]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(6),
      Q => m_axis_ppkt_tdata(166),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[167]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(7),
      Q => m_axis_ppkt_tdata(167),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[168]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(8),
      Q => m_axis_ppkt_tdata(168),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[169]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(9),
      Q => m_axis_ppkt_tdata(169),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[170]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(10),
      Q => m_axis_ppkt_tdata(170),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[171]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(11),
      Q => m_axis_ppkt_tdata(171),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[172]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(12),
      Q => m_axis_ppkt_tdata(172),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[173]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(13),
      Q => m_axis_ppkt_tdata(173),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[174]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(14),
      Q => m_axis_ppkt_tdata(174),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[175]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(15),
      Q => m_axis_ppkt_tdata(175),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[176]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(16),
      Q => m_axis_ppkt_tdata(176),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[177]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(17),
      Q => m_axis_ppkt_tdata(177),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[178]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(18),
      Q => m_axis_ppkt_tdata(178),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[179]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(19),
      Q => m_axis_ppkt_tdata(179),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[180]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(20),
      Q => m_axis_ppkt_tdata(180),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[181]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(21),
      Q => m_axis_ppkt_tdata(181),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[182]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(22),
      Q => m_axis_ppkt_tdata(182),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[183]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(23),
      Q => m_axis_ppkt_tdata(183),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[184]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(24),
      Q => m_axis_ppkt_tdata(184),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[185]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(25),
      Q => m_axis_ppkt_tdata(185),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[186]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(26),
      Q => m_axis_ppkt_tdata(186),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[187]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(27),
      Q => m_axis_ppkt_tdata(187),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[188]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(28),
      Q => m_axis_ppkt_tdata(188),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[189]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(29),
      Q => m_axis_ppkt_tdata(189),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[190]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(30),
      Q => m_axis_ppkt_tdata(190),
      R => '0'
    );
\gen_data_accumulator[5].acc_data_reg[191]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_data(31),
      Q => m_axis_ppkt_tdata(191),
      R => '0'
    );
\gen_data_accumulator[5].acc_keep_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_keep(0),
      Q => m_axis_ppkt_tkeep(10),
      R => acc_reg_en(0)
    );
\gen_data_accumulator[5].acc_keep_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => acc_reg_en(5),
      D => r0_keep(2),
      Q => m_axis_ppkt_tkeep(11),
      R => acc_reg_en(0)
    );
\gen_data_accumulator[6].acc_data[223]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in4_in,
      I1 => \r0_reg_sel_reg_n_0_[6]\,
      O => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\
    );
\gen_data_accumulator[6].acc_data_reg[192]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(0),
      Q => m_axis_ppkt_tdata(192),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[193]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(1),
      Q => m_axis_ppkt_tdata(193),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[194]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(2),
      Q => m_axis_ppkt_tdata(194),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[195]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(3),
      Q => m_axis_ppkt_tdata(195),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[196]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(4),
      Q => m_axis_ppkt_tdata(196),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[197]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(5),
      Q => m_axis_ppkt_tdata(197),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[198]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(6),
      Q => m_axis_ppkt_tdata(198),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[199]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(7),
      Q => m_axis_ppkt_tdata(199),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[200]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(8),
      Q => m_axis_ppkt_tdata(200),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[201]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(9),
      Q => m_axis_ppkt_tdata(201),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[202]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(10),
      Q => m_axis_ppkt_tdata(202),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[203]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(11),
      Q => m_axis_ppkt_tdata(203),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[204]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(12),
      Q => m_axis_ppkt_tdata(204),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[205]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(13),
      Q => m_axis_ppkt_tdata(205),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[206]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(14),
      Q => m_axis_ppkt_tdata(206),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[207]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(15),
      Q => m_axis_ppkt_tdata(207),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[208]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(16),
      Q => m_axis_ppkt_tdata(208),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[209]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(17),
      Q => m_axis_ppkt_tdata(209),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[210]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(18),
      Q => m_axis_ppkt_tdata(210),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[211]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(19),
      Q => m_axis_ppkt_tdata(211),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[212]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(20),
      Q => m_axis_ppkt_tdata(212),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[213]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(21),
      Q => m_axis_ppkt_tdata(213),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[214]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(22),
      Q => m_axis_ppkt_tdata(214),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[215]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(23),
      Q => m_axis_ppkt_tdata(215),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[216]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(24),
      Q => m_axis_ppkt_tdata(216),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[217]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(25),
      Q => m_axis_ppkt_tdata(217),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[218]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(26),
      Q => m_axis_ppkt_tdata(218),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[219]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(27),
      Q => m_axis_ppkt_tdata(219),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[220]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(28),
      Q => m_axis_ppkt_tdata(220),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[221]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(29),
      Q => m_axis_ppkt_tdata(221),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[222]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(30),
      Q => m_axis_ppkt_tdata(222),
      R => '0'
    );
\gen_data_accumulator[6].acc_data_reg[223]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_data(31),
      Q => m_axis_ppkt_tdata(223),
      R => '0'
    );
\gen_data_accumulator[6].acc_keep_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_keep(0),
      Q => m_axis_ppkt_tkeep(12),
      R => acc_reg_en(0)
    );
\gen_data_accumulator[6].acc_keep_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \gen_data_accumulator[6].acc_data[223]_i_1_n_0\,
      D => r0_keep(2),
      Q => m_axis_ppkt_tkeep(13),
      R => acc_reg_en(0)
    );
\r0_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(0),
      Q => r0_data(0),
      R => '0'
    );
\r0_data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(10),
      Q => r0_data(10),
      R => '0'
    );
\r0_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(11),
      Q => r0_data(11),
      R => '0'
    );
\r0_data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(12),
      Q => r0_data(12),
      R => '0'
    );
\r0_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(13),
      Q => r0_data(13),
      R => '0'
    );
\r0_data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(14),
      Q => r0_data(14),
      R => '0'
    );
\r0_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(15),
      Q => r0_data(15),
      R => '0'
    );
\r0_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(16),
      Q => r0_data(16),
      R => '0'
    );
\r0_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(17),
      Q => r0_data(17),
      R => '0'
    );
\r0_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(18),
      Q => r0_data(18),
      R => '0'
    );
\r0_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(19),
      Q => r0_data(19),
      R => '0'
    );
\r0_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(1),
      Q => r0_data(1),
      R => '0'
    );
\r0_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(20),
      Q => r0_data(20),
      R => '0'
    );
\r0_data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(21),
      Q => r0_data(21),
      R => '0'
    );
\r0_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(22),
      Q => r0_data(22),
      R => '0'
    );
\r0_data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(23),
      Q => r0_data(23),
      R => '0'
    );
\r0_data_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(24),
      Q => r0_data(24),
      R => '0'
    );
\r0_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(25),
      Q => r0_data(25),
      R => '0'
    );
\r0_data_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(26),
      Q => r0_data(26),
      R => '0'
    );
\r0_data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(27),
      Q => r0_data(27),
      R => '0'
    );
\r0_data_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(28),
      Q => r0_data(28),
      R => '0'
    );
\r0_data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(29),
      Q => r0_data(29),
      R => '0'
    );
\r0_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(2),
      Q => r0_data(2),
      R => '0'
    );
\r0_data_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(30),
      Q => r0_data(30),
      R => '0'
    );
\r0_data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(31),
      Q => r0_data(31),
      R => '0'
    );
\r0_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(3),
      Q => r0_data(3),
      R => '0'
    );
\r0_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(4),
      Q => r0_data(4),
      R => '0'
    );
\r0_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(5),
      Q => r0_data(5),
      R => '0'
    );
\r0_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(6),
      Q => r0_data(6),
      R => '0'
    );
\r0_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(7),
      Q => r0_data(7),
      R => '0'
    );
\r0_data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(8),
      Q => r0_data(8),
      R => '0'
    );
\r0_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => D(9),
      Q => r0_data(9),
      R => '0'
    );
\r0_keep_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[34]\(0),
      Q => r0_keep(0),
      R => '0'
    );
\r0_keep_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[34]\(1),
      Q => r0_keep(2),
      R => '0'
    );
r0_last_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => S_AXIS_TLAST,
      Q => r0_last_reg_n_0,
      R => '0'
    );
\r0_reg_sel[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F8"
    )
        port map (
      I0 => \^q\(1),
      I1 => m_axis_ppkt_tready,
      I2 => areset_r,
      O => p_1_in(6)
    );
\r0_reg_sel_reg[0]\: unisim.vcomponents.FDSE
     port map (
      C => aclk,
      CE => p_0_in4_in,
      D => '0',
      Q => \r0_reg_sel_reg_n_0_[0]\,
      S => p_1_in(6)
    );
\r0_reg_sel_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in4_in,
      D => \r0_reg_sel_reg_n_0_[0]\,
      Q => \r0_reg_sel_reg_n_0_[1]\,
      R => p_1_in(6)
    );
\r0_reg_sel_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in4_in,
      D => \r0_reg_sel_reg_n_0_[1]\,
      Q => \r0_reg_sel_reg_n_0_[2]\,
      R => p_1_in(6)
    );
\r0_reg_sel_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in4_in,
      D => \r0_reg_sel_reg_n_0_[2]\,
      Q => \r0_reg_sel_reg_n_0_[3]\,
      R => p_1_in(6)
    );
\r0_reg_sel_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in4_in,
      D => \r0_reg_sel_reg_n_0_[3]\,
      Q => \r0_reg_sel_reg_n_0_[4]\,
      R => p_1_in(6)
    );
\r0_reg_sel_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in4_in,
      D => \r0_reg_sel_reg_n_0_[4]\,
      Q => \r0_reg_sel_reg_n_0_[5]\,
      R => p_1_in(6)
    );
\r0_reg_sel_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in4_in,
      D => \r0_reg_sel_reg_n_0_[5]\,
      Q => \r0_reg_sel_reg_n_0_[6]\,
      R => p_1_in(6)
    );
\r0_reg_sel_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in4_in,
      D => \r0_reg_sel_reg_n_0_[6]\,
      Q => p_1_in2_in,
      R => p_1_in(6)
    );
\r0_user_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(0),
      Q => r0_user(0),
      R => '0'
    );
\r0_user_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(10),
      Q => r0_user(10),
      R => '0'
    );
\r0_user_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(11),
      Q => r0_user(11),
      R => '0'
    );
\r0_user_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(12),
      Q => r0_user(12),
      R => '0'
    );
\r0_user_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(13),
      Q => r0_user(13),
      R => '0'
    );
\r0_user_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(14),
      Q => r0_user(14),
      R => '0'
    );
\r0_user_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(15),
      Q => r0_user(15),
      R => '0'
    );
\r0_user_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(16),
      Q => r0_user(16),
      R => '0'
    );
\r0_user_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(17),
      Q => r0_user(17),
      R => '0'
    );
\r0_user_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(18),
      Q => r0_user(18),
      R => '0'
    );
\r0_user_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(19),
      Q => r0_user(19),
      R => '0'
    );
\r0_user_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(1),
      Q => r0_user(1),
      R => '0'
    );
\r0_user_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(20),
      Q => r0_user(20),
      R => '0'
    );
\r0_user_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(21),
      Q => r0_user(21),
      R => '0'
    );
\r0_user_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(22),
      Q => r0_user(22),
      R => '0'
    );
\r0_user_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(23),
      Q => r0_user(23),
      R => '0'
    );
\r0_user_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(24),
      Q => r0_user(24),
      R => '0'
    );
\r0_user_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(25),
      Q => r0_user(25),
      R => '0'
    );
\r0_user_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(26),
      Q => r0_user(26),
      R => '0'
    );
\r0_user_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(27),
      Q => r0_user(27),
      R => '0'
    );
\r0_user_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(28),
      Q => r0_user(28),
      R => '0'
    );
\r0_user_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(29),
      Q => r0_user(29),
      R => '0'
    );
\r0_user_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(2),
      Q => r0_user(2),
      R => '0'
    );
\r0_user_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(30),
      Q => r0_user(30),
      R => '0'
    );
\r0_user_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(31),
      Q => r0_user(31),
      R => '0'
    );
\r0_user_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(32),
      Q => r0_user(32),
      R => '0'
    );
\r0_user_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(33),
      Q => r0_user(33),
      R => '0'
    );
\r0_user_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(34),
      Q => r0_user(34),
      R => '0'
    );
\r0_user_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(35),
      Q => r0_user(35),
      R => '0'
    );
\r0_user_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(36),
      Q => r0_user(36),
      R => '0'
    );
\r0_user_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(37),
      Q => r0_user(37),
      R => '0'
    );
\r0_user_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(38),
      Q => r0_user(38),
      R => '0'
    );
\r0_user_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(39),
      Q => r0_user(39),
      R => '0'
    );
\r0_user_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(3),
      Q => r0_user(3),
      R => '0'
    );
\r0_user_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(40),
      Q => r0_user(40),
      R => '0'
    );
\r0_user_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(41),
      Q => r0_user(41),
      R => '0'
    );
\r0_user_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(42),
      Q => r0_user(42),
      R => '0'
    );
\r0_user_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(43),
      Q => r0_user(43),
      R => '0'
    );
\r0_user_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(44),
      Q => r0_user(44),
      R => '0'
    );
\r0_user_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(45),
      Q => r0_user(45),
      R => '0'
    );
\r0_user_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(46),
      Q => r0_user(46),
      R => '0'
    );
\r0_user_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(47),
      Q => r0_user(47),
      R => '0'
    );
\r0_user_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(48),
      Q => r0_user(48),
      R => '0'
    );
\r0_user_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(49),
      Q => r0_user(49),
      R => '0'
    );
\r0_user_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(4),
      Q => r0_user(4),
      R => '0'
    );
\r0_user_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(50),
      Q => r0_user(50),
      R => '0'
    );
\r0_user_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(51),
      Q => r0_user(51),
      R => '0'
    );
\r0_user_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(52),
      Q => r0_user(52),
      R => '0'
    );
\r0_user_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(53),
      Q => r0_user(53),
      R => '0'
    );
\r0_user_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(54),
      Q => r0_user(54),
      R => '0'
    );
\r0_user_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(55),
      Q => r0_user(55),
      R => '0'
    );
\r0_user_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(56),
      Q => r0_user(56),
      R => '0'
    );
\r0_user_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(57),
      Q => r0_user(57),
      R => '0'
    );
\r0_user_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(58),
      Q => r0_user(58),
      R => '0'
    );
\r0_user_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(59),
      Q => r0_user(59),
      R => '0'
    );
\r0_user_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(5),
      Q => r0_user(5),
      R => '0'
    );
\r0_user_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(60),
      Q => r0_user(60),
      R => '0'
    );
\r0_user_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(61),
      Q => r0_user(61),
      R => '0'
    );
\r0_user_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(62),
      Q => r0_user(62),
      R => '0'
    );
\r0_user_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(63),
      Q => r0_user(63),
      R => '0'
    );
\r0_user_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(64),
      Q => r0_user(64),
      R => '0'
    );
\r0_user_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(65),
      Q => r0_user(65),
      R => '0'
    );
\r0_user_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(66),
      Q => r0_user(66),
      R => '0'
    );
\r0_user_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(67),
      Q => r0_user(67),
      R => '0'
    );
\r0_user_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(68),
      Q => r0_user(68),
      R => '0'
    );
\r0_user_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(69),
      Q => r0_user(69),
      R => '0'
    );
\r0_user_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(6),
      Q => r0_user(6),
      R => '0'
    );
\r0_user_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(70),
      Q => r0_user(70),
      R => '0'
    );
\r0_user_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(71),
      Q => r0_user(71),
      R => '0'
    );
\r0_user_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(72),
      Q => r0_user(72),
      R => '0'
    );
\r0_user_reg[73]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(73),
      Q => r0_user(73),
      R => '0'
    );
\r0_user_reg[74]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(74),
      Q => r0_user(74),
      R => '0'
    );
\r0_user_reg[75]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(75),
      Q => r0_user(75),
      R => '0'
    );
\r0_user_reg[76]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(76),
      Q => r0_user(76),
      R => '0'
    );
\r0_user_reg[77]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(77),
      Q => r0_user(77),
      R => '0'
    );
\r0_user_reg[78]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(78),
      Q => r0_user(78),
      R => '0'
    );
\r0_user_reg[79]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(79),
      Q => r0_user(79),
      R => '0'
    );
\r0_user_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(7),
      Q => r0_user(7),
      R => '0'
    );
\r0_user_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(8),
      Q => r0_user(8),
      R => '0'
    );
\r0_user_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^q\(0),
      D => \gen_AB_reg_slice.payload_b_reg[116]\(9),
      Q => r0_user(9),
      R => '0'
    );
\state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FCFCFFFC77FFFFFF"
    )
        port map (
      I0 => r0_last_reg_n_0,
      I1 => \state_reg_n_0_[2]\,
      I2 => m_axis_ppkt_tready,
      I3 => \^q\(0),
      I4 => \gen_AB_reg_slice.state_reg[0]\(0),
      I5 => \^q\(1),
      O => state(0)
    );
\state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000FBFBF000F8080"
    )
        port map (
      I0 => \^q\(0),
      I1 => r0_last_reg_n_0,
      I2 => \state_reg_n_0_[2]\,
      I3 => m_axis_ppkt_tready,
      I4 => \^q\(1),
      I5 => \state[1]_i_2_n_0\,
      O => state(1)
    );
\state[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AA800000"
    )
        port map (
      I0 => \^q\(0),
      I1 => \r0_reg_sel_reg_n_0_[6]\,
      I2 => p_0_in4_in,
      I3 => p_1_in2_in,
      I4 => \gen_AB_reg_slice.state_reg[0]\(0),
      O => \state[1]_i_2_n_0\
    );
\state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0300777703000000"
    )
        port map (
      I0 => r0_last_reg_n_0,
      I1 => \state_reg_n_0_[2]\,
      I2 => \state[2]_i_2_n_0\,
      I3 => m_axis_ppkt_tready,
      I4 => \^q\(1),
      I5 => \state[2]_i_3_n_0\,
      O => state(2)
    );
\state[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^q\(0),
      I1 => \gen_AB_reg_slice.state_reg[0]\(0),
      O => \state[2]_i_2_n_0\
    );
\state[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"002A0000"
    )
        port map (
      I0 => \^q\(0),
      I1 => p_0_in4_in,
      I2 => \r0_reg_sel_reg_n_0_[6]\,
      I3 => p_1_in2_in,
      I4 => \gen_AB_reg_slice.state_reg[0]\(0),
      O => \state[2]_i_3_n_0\
    );
\state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => state(0),
      Q => \^q\(0),
      R => areset_r
    );
\state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => state(1),
      Q => \^q\(1),
      R => areset_r
    );
\state_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => state(2),
      Q => \state_reg_n_0_[2]\,
      R => areset_r
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axis_register_slice is
  port (
    areset_r : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \r0_data_reg[31]\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    \r0_keep_reg[2]\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXIS_TLAST : out STD_LOGIC;
    \r0_user_reg[79]\ : out STD_LOGIC_VECTOR ( 79 downto 0 );
    aclk : in STD_LOGIC;
    t1_aresetn_reg : in STD_LOGIC;
    s_axis_ppkt_tvalid : in STD_LOGIC;
    \state_reg[0]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    D : in STD_LOGIC_VECTOR ( 114 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axis_register_slice : entity is "px_axis_dwidth_conv_axis_register_slice";
end px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axis_register_slice;

architecture STRUCTURE of px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axis_register_slice is
  signal \^areset_r\ : STD_LOGIC;
  signal areset_r_i_1_n_0 : STD_LOGIC;
begin
  areset_r <= \^areset_r\;
areset_r_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => t1_aresetn_reg,
      O => areset_r_i_1_n_0
    );
areset_r_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => areset_r_i_1_n_0,
      Q => \^areset_r\,
      R => '0'
    );
axisc_register_slice_0: entity work.px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_register_slice
     port map (
      D(114 downto 0) => D(114 downto 0),
      Q(1 downto 0) => Q(1 downto 0),
      SR(0) => \^areset_r\,
      S_AXIS_TLAST => S_AXIS_TLAST,
      aclk => aclk,
      \r0_data_reg[31]\(31 downto 0) => \r0_data_reg[31]\(31 downto 0),
      \r0_keep_reg[2]\(1 downto 0) => \r0_keep_reg[2]\(1 downto 0),
      \r0_user_reg[79]\(79 downto 0) => \r0_user_reg[79]\(79 downto 0),
      s_axis_ppkt_tvalid => s_axis_ppkt_tvalid,
      \state_reg[0]\(0) => \state_reg[0]\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_upconv is
  port (
    m_axis_ppkt_tlast : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_ppkt_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_ppkt_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_ppkt_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_ppkt_tuser : out STD_LOGIC_VECTOR ( 79 downto 0 );
    aclk : in STD_LOGIC;
    t1_aresetn_reg : in STD_LOGIC;
    s_axis_ppkt_tvalid : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 114 downto 0 );
    m_axis_ppkt_tready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_upconv : entity is "px_axis_dwidth_upconv";
end px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_upconv;

architecture STRUCTURE of px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_upconv is
  signal S_AXIS_TKEEP : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal S_AXIS_TLAST : STD_LOGIC;
  signal S_AXIS_TUSER : STD_LOGIC_VECTOR ( 79 downto 0 );
  signal areset_r : STD_LOGIC;
  signal axis_register_slice_0_n_10 : STD_LOGIC;
  signal axis_register_slice_0_n_11 : STD_LOGIC;
  signal axis_register_slice_0_n_12 : STD_LOGIC;
  signal axis_register_slice_0_n_13 : STD_LOGIC;
  signal axis_register_slice_0_n_14 : STD_LOGIC;
  signal axis_register_slice_0_n_15 : STD_LOGIC;
  signal axis_register_slice_0_n_16 : STD_LOGIC;
  signal axis_register_slice_0_n_17 : STD_LOGIC;
  signal axis_register_slice_0_n_18 : STD_LOGIC;
  signal axis_register_slice_0_n_19 : STD_LOGIC;
  signal axis_register_slice_0_n_20 : STD_LOGIC;
  signal axis_register_slice_0_n_21 : STD_LOGIC;
  signal axis_register_slice_0_n_22 : STD_LOGIC;
  signal axis_register_slice_0_n_23 : STD_LOGIC;
  signal axis_register_slice_0_n_24 : STD_LOGIC;
  signal axis_register_slice_0_n_25 : STD_LOGIC;
  signal axis_register_slice_0_n_26 : STD_LOGIC;
  signal axis_register_slice_0_n_27 : STD_LOGIC;
  signal axis_register_slice_0_n_28 : STD_LOGIC;
  signal axis_register_slice_0_n_29 : STD_LOGIC;
  signal axis_register_slice_0_n_3 : STD_LOGIC;
  signal axis_register_slice_0_n_30 : STD_LOGIC;
  signal axis_register_slice_0_n_31 : STD_LOGIC;
  signal axis_register_slice_0_n_32 : STD_LOGIC;
  signal axis_register_slice_0_n_33 : STD_LOGIC;
  signal axis_register_slice_0_n_34 : STD_LOGIC;
  signal axis_register_slice_0_n_4 : STD_LOGIC;
  signal axis_register_slice_0_n_5 : STD_LOGIC;
  signal axis_register_slice_0_n_6 : STD_LOGIC;
  signal axis_register_slice_0_n_7 : STD_LOGIC;
  signal axis_register_slice_0_n_8 : STD_LOGIC;
  signal axis_register_slice_0_n_9 : STD_LOGIC;
  signal d1_ready : STD_LOGIC;
  signal d1_valid : STD_LOGIC;
begin
axis_register_slice_0: entity work.px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axis_register_slice
     port map (
      D(114 downto 0) => D(114 downto 0),
      Q(1) => Q(0),
      Q(0) => d1_valid,
      S_AXIS_TLAST => S_AXIS_TLAST,
      aclk => aclk,
      areset_r => areset_r,
      \r0_data_reg[31]\(31) => axis_register_slice_0_n_3,
      \r0_data_reg[31]\(30) => axis_register_slice_0_n_4,
      \r0_data_reg[31]\(29) => axis_register_slice_0_n_5,
      \r0_data_reg[31]\(28) => axis_register_slice_0_n_6,
      \r0_data_reg[31]\(27) => axis_register_slice_0_n_7,
      \r0_data_reg[31]\(26) => axis_register_slice_0_n_8,
      \r0_data_reg[31]\(25) => axis_register_slice_0_n_9,
      \r0_data_reg[31]\(24) => axis_register_slice_0_n_10,
      \r0_data_reg[31]\(23) => axis_register_slice_0_n_11,
      \r0_data_reg[31]\(22) => axis_register_slice_0_n_12,
      \r0_data_reg[31]\(21) => axis_register_slice_0_n_13,
      \r0_data_reg[31]\(20) => axis_register_slice_0_n_14,
      \r0_data_reg[31]\(19) => axis_register_slice_0_n_15,
      \r0_data_reg[31]\(18) => axis_register_slice_0_n_16,
      \r0_data_reg[31]\(17) => axis_register_slice_0_n_17,
      \r0_data_reg[31]\(16) => axis_register_slice_0_n_18,
      \r0_data_reg[31]\(15) => axis_register_slice_0_n_19,
      \r0_data_reg[31]\(14) => axis_register_slice_0_n_20,
      \r0_data_reg[31]\(13) => axis_register_slice_0_n_21,
      \r0_data_reg[31]\(12) => axis_register_slice_0_n_22,
      \r0_data_reg[31]\(11) => axis_register_slice_0_n_23,
      \r0_data_reg[31]\(10) => axis_register_slice_0_n_24,
      \r0_data_reg[31]\(9) => axis_register_slice_0_n_25,
      \r0_data_reg[31]\(8) => axis_register_slice_0_n_26,
      \r0_data_reg[31]\(7) => axis_register_slice_0_n_27,
      \r0_data_reg[31]\(6) => axis_register_slice_0_n_28,
      \r0_data_reg[31]\(5) => axis_register_slice_0_n_29,
      \r0_data_reg[31]\(4) => axis_register_slice_0_n_30,
      \r0_data_reg[31]\(3) => axis_register_slice_0_n_31,
      \r0_data_reg[31]\(2) => axis_register_slice_0_n_32,
      \r0_data_reg[31]\(1) => axis_register_slice_0_n_33,
      \r0_data_reg[31]\(0) => axis_register_slice_0_n_34,
      \r0_keep_reg[2]\(1) => S_AXIS_TKEEP(2),
      \r0_keep_reg[2]\(0) => S_AXIS_TKEEP(0),
      \r0_user_reg[79]\(79 downto 0) => S_AXIS_TUSER(79 downto 0),
      s_axis_ppkt_tvalid => s_axis_ppkt_tvalid,
      \state_reg[0]\(0) => d1_ready,
      t1_aresetn_reg => t1_aresetn_reg
    );
\gen_upsizer_conversion.axisc_upsizer_0\: entity work.px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_upsizer
     port map (
      D(31) => axis_register_slice_0_n_3,
      D(30) => axis_register_slice_0_n_4,
      D(29) => axis_register_slice_0_n_5,
      D(28) => axis_register_slice_0_n_6,
      D(27) => axis_register_slice_0_n_7,
      D(26) => axis_register_slice_0_n_8,
      D(25) => axis_register_slice_0_n_9,
      D(24) => axis_register_slice_0_n_10,
      D(23) => axis_register_slice_0_n_11,
      D(22) => axis_register_slice_0_n_12,
      D(21) => axis_register_slice_0_n_13,
      D(20) => axis_register_slice_0_n_14,
      D(19) => axis_register_slice_0_n_15,
      D(18) => axis_register_slice_0_n_16,
      D(17) => axis_register_slice_0_n_17,
      D(16) => axis_register_slice_0_n_18,
      D(15) => axis_register_slice_0_n_19,
      D(14) => axis_register_slice_0_n_20,
      D(13) => axis_register_slice_0_n_21,
      D(12) => axis_register_slice_0_n_22,
      D(11) => axis_register_slice_0_n_23,
      D(10) => axis_register_slice_0_n_24,
      D(9) => axis_register_slice_0_n_25,
      D(8) => axis_register_slice_0_n_26,
      D(7) => axis_register_slice_0_n_27,
      D(6) => axis_register_slice_0_n_28,
      D(5) => axis_register_slice_0_n_29,
      D(4) => axis_register_slice_0_n_30,
      D(3) => axis_register_slice_0_n_31,
      D(2) => axis_register_slice_0_n_32,
      D(1) => axis_register_slice_0_n_33,
      D(0) => axis_register_slice_0_n_34,
      Q(1) => m_axis_ppkt_tvalid(0),
      Q(0) => d1_ready,
      S_AXIS_TLAST => S_AXIS_TLAST,
      aclk => aclk,
      areset_r => areset_r,
      \gen_AB_reg_slice.payload_b_reg[116]\(79 downto 0) => S_AXIS_TUSER(79 downto 0),
      \gen_AB_reg_slice.payload_b_reg[34]\(1) => S_AXIS_TKEEP(2),
      \gen_AB_reg_slice.payload_b_reg[34]\(0) => S_AXIS_TKEEP(0),
      \gen_AB_reg_slice.state_reg[0]\(0) => d1_valid,
      m_axis_ppkt_tdata(255 downto 0) => m_axis_ppkt_tdata(255 downto 0),
      m_axis_ppkt_tkeep(15 downto 0) => m_axis_ppkt_tkeep(15 downto 0),
      m_axis_ppkt_tlast => m_axis_ppkt_tlast,
      m_axis_ppkt_tready => m_axis_ppkt_tready,
      m_axis_ppkt_tuser(79 downto 0) => m_axis_ppkt_tuser(79 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_pkt_ppkt_upsizer_px_ppkt_width_upsizer is
  port (
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_ppkt_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_ppkt_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_ppkt_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_ppkt_tuser : out STD_LOGIC_VECTOR ( 79 downto 0 );
    m_axis_ppkt_tlast : out STD_LOGIC;
    aclk : in STD_LOGIC;
    m_axis_ppkt_tready : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 114 downto 0 );
    s_axis_ppkt_tvalid : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of px_vita49_pkt_ppkt_upsizer_px_ppkt_width_upsizer : entity is "px_ppkt_width_upsizer";
end px_vita49_pkt_ppkt_upsizer_px_ppkt_width_upsizer;

architecture STRUCTURE of px_vita49_pkt_ppkt_upsizer_px_ppkt_width_upsizer is
  signal t1_aresetn_reg_n_0 : STD_LOGIC;
begin
t1_aresetn_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => aresetn,
      Q => t1_aresetn_reg_n_0,
      R => '0'
    );
widthconv_inst: entity work.px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_upconv
     port map (
      D(114 downto 0) => D(114 downto 0),
      Q(0) => Q(0),
      aclk => aclk,
      m_axis_ppkt_tdata(255 downto 0) => m_axis_ppkt_tdata(255 downto 0),
      m_axis_ppkt_tkeep(15 downto 0) => m_axis_ppkt_tkeep(15 downto 0),
      m_axis_ppkt_tlast => m_axis_ppkt_tlast,
      m_axis_ppkt_tready => m_axis_ppkt_tready,
      m_axis_ppkt_tuser(79 downto 0) => m_axis_ppkt_tuser(79 downto 0),
      m_axis_ppkt_tvalid(0) => m_axis_ppkt_tvalid(0),
      s_axis_ppkt_tvalid => s_axis_ppkt_tvalid,
      t1_aresetn_reg => t1_aresetn_reg_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_pkt_ppkt_upsizer is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_ppkt_tvalid : in STD_LOGIC;
    s_axis_ppkt_tready : out STD_LOGIC;
    s_axis_ppkt_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_ppkt_tuser : in STD_LOGIC_VECTOR ( 79 downto 0 );
    s_axis_ppkt_tkeep : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_ppkt_tlast : in STD_LOGIC;
    m_axis_ppkt_tvalid : out STD_LOGIC;
    m_axis_ppkt_tready : in STD_LOGIC;
    m_axis_ppkt_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_ppkt_tuser : out STD_LOGIC_VECTOR ( 79 downto 0 );
    m_axis_ppkt_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_ppkt_tlast : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of px_vita49_pkt_ppkt_upsizer : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of px_vita49_pkt_ppkt_upsizer : entity is "px_vita49_pkt_ppkt_upsizer,px_ppkt_width_upsizer,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of px_vita49_pkt_ppkt_upsizer : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of px_vita49_pkt_ppkt_upsizer : entity is "px_ppkt_width_upsizer,Vivado 2017.2.1";
end px_vita49_pkt_ppkt_upsizer;

architecture STRUCTURE of px_vita49_pkt_ppkt_upsizer is
begin
U0: entity work.px_vita49_pkt_ppkt_upsizer_px_ppkt_width_upsizer
     port map (
      D(114 downto 35) => s_axis_ppkt_tuser(79 downto 0),
      D(34) => s_axis_ppkt_tlast,
      D(33 downto 32) => s_axis_ppkt_tkeep(1 downto 0),
      D(31 downto 0) => s_axis_ppkt_tdata(31 downto 0),
      Q(0) => s_axis_ppkt_tready,
      aclk => aclk,
      aresetn => aresetn,
      m_axis_ppkt_tdata(255 downto 0) => m_axis_ppkt_tdata(255 downto 0),
      m_axis_ppkt_tkeep(15 downto 0) => m_axis_ppkt_tkeep(15 downto 0),
      m_axis_ppkt_tlast => m_axis_ppkt_tlast,
      m_axis_ppkt_tready => m_axis_ppkt_tready,
      m_axis_ppkt_tuser(79 downto 0) => m_axis_ppkt_tuser(79 downto 0),
      m_axis_ppkt_tvalid(0) => m_axis_ppkt_tvalid,
      s_axis_ppkt_tvalid => s_axis_ppkt_tvalid
    );
end STRUCTURE;
