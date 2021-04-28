-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Mon Apr 26 16:12:18 2021
-- Host        : wind running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_position_encoder_0_0/user_block2_position_encoder_0_0_sim_netlist.vhdl
-- Design      : user_block2_position_encoder_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0_quad2bin_jkff is
  port (
    rot_a_filt : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 18 downto 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    rot_a_d2 : in STD_LOGIC;
    rot_a_d4 : in STD_LOGIC;
    rot_a_d3 : in STD_LOGIC;
    \rot_encoder_cnt_reg[15]\ : in STD_LOGIC;
    \rot_encoder_cnt_reg[17]\ : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    rot_b_filt_d1 : in STD_LOGIC;
    O : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \rot_encoder_cnt_reg[0]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \rot_encoder_cnt_reg[0]_0\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \rot_encoder_cnt_reg[16]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \rot_encoder_cnt_reg[18]\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \rot_encoder_cnt_reg[17]_0\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rot_a_filt_d1 : in STD_LOGIC;
    rot_b_filt : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_position_encoder_0_0_quad2bin_jkff : entity is "quad2bin_jkff";
end user_block2_position_encoder_0_0_quad2bin_jkff;

architecture STRUCTURE of user_block2_position_encoder_0_0_quad2bin_jkff is
  signal Qi_i_1_n_0 : STD_LOGIC;
  signal \^rot_a_filt\ : STD_LOGIC;
begin
  rot_a_filt <= \^rot_a_filt\;
Qi_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE80"
    )
        port map (
      I0 => rot_a_d2,
      I1 => rot_a_d4,
      I2 => rot_a_d3,
      I3 => \^rot_a_filt\,
      O => Qi_i_1_n_0
    );
Qi_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => Qi_i_1_n_0,
      Q => \^rot_a_filt\
    );
\rot_encoder_cnt[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CF0A0ACF"
    )
        port map (
      I0 => \rot_encoder_cnt_reg[15]\,
      I1 => \rot_encoder_cnt_reg[17]\,
      I2 => Q(0),
      I3 => rot_b_filt_d1,
      I4 => \^rot_a_filt\,
      O => D(0)
    );
\rot_encoder_cnt[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F08888888800F0"
    )
        port map (
      I0 => \rot_encoder_cnt_reg[0]_0\(1),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[16]\(1),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(10)
    );
\rot_encoder_cnt[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF088888888FFF0"
    )
        port map (
      I0 => \rot_encoder_cnt_reg[0]_0\(2),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[16]\(2),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(11)
    );
\rot_encoder_cnt[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF088888888FFF0"
    )
        port map (
      I0 => \rot_encoder_cnt_reg[0]_0\(3),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[16]\(3),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(12)
    );
\rot_encoder_cnt[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F08888888800F0"
    )
        port map (
      I0 => \rot_encoder_cnt_reg[0]_0\(4),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[16]\(4),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(13)
    );
\rot_encoder_cnt[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F08888888800F0"
    )
        port map (
      I0 => \rot_encoder_cnt_reg[0]_0\(5),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[16]\(5),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(14)
    );
\rot_encoder_cnt[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F08888888800F0"
    )
        port map (
      I0 => \rot_encoder_cnt_reg[0]_0\(6),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[16]\(6),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(15)
    );
\rot_encoder_cnt[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F08888888800F0"
    )
        port map (
      I0 => \rot_encoder_cnt_reg[0]_0\(7),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[16]\(7),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(16)
    );
\rot_encoder_cnt[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF088888888FFF0"
    )
        port map (
      I0 => \rot_encoder_cnt_reg[18]\(0),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[17]_0\(0),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(17)
    );
\rot_encoder_cnt[18]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => \^rot_a_filt\,
      I1 => rot_b_filt_d1,
      I2 => rot_a_filt_d1,
      I3 => rot_b_filt,
      O => E(0)
    );
\rot_encoder_cnt[18]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF088888888FFF0"
    )
        port map (
      I0 => \rot_encoder_cnt_reg[18]\(1),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[17]_0\(1),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(18)
    );
\rot_encoder_cnt[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF088888888FFF0"
    )
        port map (
      I0 => O(0),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[0]\(0),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(1)
    );
\rot_encoder_cnt[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF088888888FFF0"
    )
        port map (
      I0 => O(1),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[0]\(1),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(2)
    );
\rot_encoder_cnt[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF088888888FFF0"
    )
        port map (
      I0 => O(2),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[0]\(2),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(3)
    );
\rot_encoder_cnt[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF088888888FFF0"
    )
        port map (
      I0 => O(3),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[0]\(3),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(4)
    );
\rot_encoder_cnt[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF088888888FFF0"
    )
        port map (
      I0 => O(4),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[0]\(4),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(5)
    );
\rot_encoder_cnt[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF088888888FFF0"
    )
        port map (
      I0 => O(5),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[0]\(5),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(6)
    );
\rot_encoder_cnt[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F08888888800F0"
    )
        port map (
      I0 => O(6),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[0]\(6),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(7)
    );
\rot_encoder_cnt[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F08888888800F0"
    )
        port map (
      I0 => O(7),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[0]\(7),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(8)
    );
\rot_encoder_cnt[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF088888888FFF0"
    )
        port map (
      I0 => \rot_encoder_cnt_reg[0]_0\(0),
      I1 => \rot_encoder_cnt_reg[15]\,
      I2 => \rot_encoder_cnt_reg[16]\(0),
      I3 => \rot_encoder_cnt_reg[17]\,
      I4 => rot_b_filt_d1,
      I5 => \^rot_a_filt\,
      O => D(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0_quad2bin_jkff_1 is
  port (
    rot_b_filt : out STD_LOGIC;
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    rot_b_d2 : in STD_LOGIC;
    rot_b_d4 : in STD_LOGIC;
    rot_b_d3 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_position_encoder_0_0_quad2bin_jkff_1 : entity is "quad2bin_jkff";
end user_block2_position_encoder_0_0_quad2bin_jkff_1;

architecture STRUCTURE of user_block2_position_encoder_0_0_quad2bin_jkff_1 is
  signal \Qi_i_1__0_n_0\ : STD_LOGIC;
  signal \^rot_b_filt\ : STD_LOGIC;
begin
  rot_b_filt <= \^rot_b_filt\;
\Qi_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE80"
    )
        port map (
      I0 => rot_b_d2,
      I1 => rot_b_d4,
      I2 => rot_b_d3,
      I3 => \^rot_b_filt\,
      O => \Qi_i_1__0_n_0\
    );
Qi_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => \Qi_i_1__0_n_0\,
      Q => \^rot_b_filt\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0_quad2bin_jkff_2 is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    tilt_z_d2 : in STD_LOGIC;
    tilt_z_d4 : in STD_LOGIC;
    tilt_z_d3 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_position_encoder_0_0_quad2bin_jkff_2 : entity is "quad2bin_jkff";
end user_block2_position_encoder_0_0_quad2bin_jkff_2;

architecture STRUCTURE of user_block2_position_encoder_0_0_quad2bin_jkff_2 is
  signal \Qi_i_1__1_n_0\ : STD_LOGIC;
  signal rot_z_filt : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \Qi_i_1__1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \rot_encoder_cnt[18]_i_1\ : label is "soft_lutpair0";
begin
\Qi_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE80"
    )
        port map (
      I0 => tilt_z_d2,
      I1 => tilt_z_d4,
      I2 => tilt_z_d3,
      I3 => rot_z_filt,
      O => \Qi_i_1__1_n_0\
    );
Qi_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => \Qi_i_1__1_n_0\,
      Q => rot_z_filt
    );
\rot_encoder_cnt[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => aresetn,
      I1 => rot_z_filt,
      O => SR(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0_quad2bin_jkff_3 is
  port (
    tilt_a_filt : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 17 downto 0 );
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    \tilt_encoder_cnt_reg[3]\ : in STD_LOGIC;
    \tilt_encoder_cnt_reg[7]\ : in STD_LOGIC;
    \tilt_encoder_cnt_reg[17]\ : in STD_LOGIC;
    \tilt_encoder_cnt_reg[8]\ : in STD_LOGIC;
    tilt_b_filt_d1 : in STD_LOGIC;
    tilt_a_d2 : in STD_LOGIC;
    tilt_a_d3 : in STD_LOGIC;
    tilt_a_d4 : in STD_LOGIC;
    O : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \tilt_encoder_cnt_reg[18]\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \tilt_encoder_cnt_reg[16]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \tilt_encoder_cnt_reg[0]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \tilt_encoder_cnt_reg[0]_0\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \tilt_encoder_cnt_reg[0]_1\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \tilt_encoder_cnt_reg[3]_0\ : in STD_LOGIC;
    \tilt_encoder_cnt_reg[7]_0\ : in STD_LOGIC;
    \tilt_encoder_cnt_reg[17]_0\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_position_encoder_0_0_quad2bin_jkff_3 : entity is "quad2bin_jkff";
end user_block2_position_encoder_0_0_quad2bin_jkff_3;

architecture STRUCTURE of user_block2_position_encoder_0_0_quad2bin_jkff_3 is
  signal \Qi_i_1__2_n_0\ : STD_LOGIC;
  signal \^tilt_a_filt\ : STD_LOGIC;
  signal \tilt_encoder_cnt[15]_i_2_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[18]_i_4_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[18]_i_6_n_0\ : STD_LOGIC;
begin
  tilt_a_filt <= \^tilt_a_filt\;
\Qi_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE80"
    )
        port map (
      I0 => tilt_a_d2,
      I1 => tilt_a_d3,
      I2 => tilt_a_d4,
      I3 => \^tilt_a_filt\,
      O => \Qi_i_1__2_n_0\
    );
Qi_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => \Qi_i_1__2_n_0\,
      Q => \^tilt_a_filt\
    );
\tilt_encoder_cnt[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \tilt_encoder_cnt_reg[0]\(1),
      I1 => \tilt_encoder_cnt[18]_i_6_n_0\,
      I2 => \tilt_encoder_cnt_reg[16]\(1),
      I3 => \tilt_encoder_cnt[15]_i_2_n_0\,
      O => D(9)
    );
\tilt_encoder_cnt[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \tilt_encoder_cnt_reg[0]\(2),
      I1 => \tilt_encoder_cnt[18]_i_6_n_0\,
      I2 => \tilt_encoder_cnt_reg[16]\(2),
      I3 => \tilt_encoder_cnt[15]_i_2_n_0\,
      O => D(10)
    );
\tilt_encoder_cnt[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => \tilt_encoder_cnt_reg[16]\(3),
      I4 => \tilt_encoder_cnt_reg[0]\(3),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(11)
    );
\tilt_encoder_cnt[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \tilt_encoder_cnt_reg[0]\(4),
      I1 => \tilt_encoder_cnt[18]_i_6_n_0\,
      I2 => \tilt_encoder_cnt_reg[16]\(4),
      I3 => \tilt_encoder_cnt[15]_i_2_n_0\,
      O => D(12)
    );
\tilt_encoder_cnt[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => \tilt_encoder_cnt_reg[16]\(5),
      I4 => \tilt_encoder_cnt_reg[0]\(5),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(13)
    );
\tilt_encoder_cnt[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \tilt_encoder_cnt_reg[0]\(6),
      I1 => \tilt_encoder_cnt[18]_i_6_n_0\,
      I2 => \tilt_encoder_cnt_reg[16]\(6),
      I3 => \tilt_encoder_cnt[15]_i_2_n_0\,
      O => D(14)
    );
\tilt_encoder_cnt[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFE00000000FFFE"
    )
        port map (
      I0 => \tilt_encoder_cnt_reg[3]_0\,
      I1 => \tilt_encoder_cnt_reg[7]_0\,
      I2 => \tilt_encoder_cnt_reg[17]_0\,
      I3 => \tilt_encoder_cnt_reg[8]\,
      I4 => \^tilt_a_filt\,
      I5 => tilt_b_filt_d1,
      O => \tilt_encoder_cnt[15]_i_2_n_0\
    );
\tilt_encoder_cnt[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => \tilt_encoder_cnt_reg[16]\(7),
      I4 => \tilt_encoder_cnt_reg[0]\(7),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(15)
    );
\tilt_encoder_cnt[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => O(0),
      I4 => \tilt_encoder_cnt_reg[18]\(0),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(16)
    );
\tilt_encoder_cnt[18]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => O(1),
      I4 => \tilt_encoder_cnt_reg[18]\(1),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(17)
    );
\tilt_encoder_cnt[18]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000009"
    )
        port map (
      I0 => \^tilt_a_filt\,
      I1 => tilt_b_filt_d1,
      I2 => \tilt_encoder_cnt_reg[3]_0\,
      I3 => \tilt_encoder_cnt_reg[7]_0\,
      I4 => \tilt_encoder_cnt_reg[17]_0\,
      I5 => \tilt_encoder_cnt_reg[8]\,
      O => \tilt_encoder_cnt[18]_i_4_n_0\
    );
\tilt_encoder_cnt[18]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFEFFFE0000"
    )
        port map (
      I0 => \tilt_encoder_cnt_reg[3]\,
      I1 => \tilt_encoder_cnt_reg[7]\,
      I2 => \tilt_encoder_cnt_reg[17]\,
      I3 => \tilt_encoder_cnt_reg[8]\,
      I4 => \^tilt_a_filt\,
      I5 => tilt_b_filt_d1,
      O => \tilt_encoder_cnt[18]_i_6_n_0\
    );
\tilt_encoder_cnt[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => \tilt_encoder_cnt_reg[0]_1\(0),
      I4 => \tilt_encoder_cnt_reg[0]_0\(0),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(0)
    );
\tilt_encoder_cnt[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => \tilt_encoder_cnt_reg[0]_1\(1),
      I4 => \tilt_encoder_cnt_reg[0]_0\(1),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(1)
    );
\tilt_encoder_cnt[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => \tilt_encoder_cnt_reg[0]_1\(2),
      I4 => \tilt_encoder_cnt_reg[0]_0\(2),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(2)
    );
\tilt_encoder_cnt[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => \tilt_encoder_cnt_reg[0]_1\(3),
      I4 => \tilt_encoder_cnt_reg[0]_0\(3),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(3)
    );
\tilt_encoder_cnt[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => \tilt_encoder_cnt_reg[0]_1\(4),
      I4 => \tilt_encoder_cnt_reg[0]_0\(4),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(4)
    );
\tilt_encoder_cnt[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => \tilt_encoder_cnt_reg[0]_1\(5),
      I4 => \tilt_encoder_cnt_reg[0]_0\(5),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(5)
    );
\tilt_encoder_cnt[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => \tilt_encoder_cnt_reg[0]_1\(6),
      I4 => \tilt_encoder_cnt_reg[0]_0\(6),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(6)
    );
\tilt_encoder_cnt[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \tilt_encoder_cnt_reg[0]_0\(7),
      I1 => \tilt_encoder_cnt[18]_i_6_n_0\,
      I2 => \tilt_encoder_cnt_reg[0]_1\(7),
      I3 => \tilt_encoder_cnt[15]_i_2_n_0\,
      O => D(7)
    );
\tilt_encoder_cnt[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEBAAEBAAEBAA"
    )
        port map (
      I0 => \tilt_encoder_cnt[18]_i_4_n_0\,
      I1 => \^tilt_a_filt\,
      I2 => tilt_b_filt_d1,
      I3 => \tilt_encoder_cnt_reg[16]\(0),
      I4 => \tilt_encoder_cnt_reg[0]\(0),
      I5 => \tilt_encoder_cnt[18]_i_6_n_0\,
      O => D(8)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0_quad2bin_jkff_4 is
  port (
    tilt_b_filt : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    tilt_b_d2 : in STD_LOGIC;
    tilt_b_d3 : in STD_LOGIC;
    tilt_b_d4 : in STD_LOGIC;
    tilt_a_filt_d1 : in STD_LOGIC;
    tilt_a_filt : in STD_LOGIC;
    tilt_b_filt_d1 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_position_encoder_0_0_quad2bin_jkff_4 : entity is "quad2bin_jkff";
end user_block2_position_encoder_0_0_quad2bin_jkff_4;

architecture STRUCTURE of user_block2_position_encoder_0_0_quad2bin_jkff_4 is
  signal \Qi_i_1__3_n_0\ : STD_LOGIC;
  signal \^tilt_b_filt\ : STD_LOGIC;
begin
  tilt_b_filt <= \^tilt_b_filt\;
\Qi_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE80"
    )
        port map (
      I0 => tilt_b_d2,
      I1 => tilt_b_d3,
      I2 => tilt_b_d4,
      I3 => \^tilt_b_filt\,
      O => \Qi_i_1__3_n_0\
    );
Qi_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => \Qi_i_1__3_n_0\,
      Q => \^tilt_b_filt\
    );
\tilt_encoder_cnt[18]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => \^tilt_b_filt\,
      I1 => tilt_a_filt_d1,
      I2 => tilt_a_filt,
      I3 => tilt_b_filt_d1,
      O => E(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0_quad2bin_jkff_5 is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    tilt_z_d2 : in STD_LOGIC;
    tilt_z_d4 : in STD_LOGIC;
    tilt_z_d3 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_position_encoder_0_0_quad2bin_jkff_5 : entity is "quad2bin_jkff";
end user_block2_position_encoder_0_0_quad2bin_jkff_5;

architecture STRUCTURE of user_block2_position_encoder_0_0_quad2bin_jkff_5 is
  signal \Qi_i_1__4_n_0\ : STD_LOGIC;
  signal tilt_z_filt : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \Qi_i_1__4\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \tilt_encoder_cnt[18]_i_1\ : label is "soft_lutpair1";
begin
\Qi_i_1__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE80"
    )
        port map (
      I0 => tilt_z_d2,
      I1 => tilt_z_d4,
      I2 => tilt_z_d3,
      I3 => tilt_z_filt,
      O => \Qi_i_1__4_n_0\
    );
Qi_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => \Qi_i_1__4_n_0\,
      Q => tilt_z_filt
    );
\tilt_encoder_cnt[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => aresetn,
      I1 => tilt_z_filt,
      O => SR(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0_ser2bin_spi is
  port (
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 );
    aclk : in STD_LOGIC;
    AZ_SCK : in STD_LOGIC;
    AZ_SSEL : in STD_LOGIC;
    AZ_MOSI : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_position_encoder_0_0_ser2bin_spi : entity is "ser2bin_spi";
end user_block2_position_encoder_0_0_ser2bin_spi;

architecture STRUCTURE of user_block2_position_encoder_0_0_ser2bin_spi is
  signal do_buffer_next : STD_LOGIC_VECTOR ( 15 downto 1 );
  signal \do_buffer_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal do_transfer_reg : STD_LOGIC;
  signal do_transfer_reg_i_1_n_0 : STD_LOGIC;
  signal do_valid_A : STD_LOGIC;
  signal do_valid_B : STD_LOGIC;
  signal do_valid_C : STD_LOGIC;
  signal do_valid_D : STD_LOGIC;
  signal do_valid_next : STD_LOGIC;
  signal sh_next : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \sh_reg[14]_i_2_n_0\ : STD_LOGIC;
  signal \sh_reg[14]_i_3_n_0\ : STD_LOGIC;
  signal state_next : STD_LOGIC_VECTOR ( 4 to 4 );
  signal state_reg : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \state_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \state_reg[1]_i_1_n_0\ : STD_LOGIC;
  signal \state_reg[2]_i_1_n_0\ : STD_LOGIC;
  signal \state_reg[3]_i_1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \sh_reg[14]_i_3\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \state_reg[0]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \state_reg[1]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \state_reg[2]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \state_reg[3]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \state_reg[4]_i_1\ : label is "soft_lutpair12";
begin
\do_buffer_reg[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => state_reg(1),
      I1 => state_reg(2),
      I2 => state_reg(0),
      I3 => state_reg(3),
      I4 => state_reg(4),
      O => \do_buffer_reg[15]_i_1_n_0\
    );
\do_buffer_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => AZ_MOSI,
      Q => Q(0),
      R => '0'
    );
\do_buffer_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(10),
      Q => Q(10),
      R => '0'
    );
\do_buffer_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(11),
      Q => Q(11),
      R => '0'
    );
\do_buffer_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(12),
      Q => Q(12),
      R => '0'
    );
\do_buffer_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(13),
      Q => Q(13),
      R => '0'
    );
\do_buffer_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(14),
      Q => Q(14),
      R => '0'
    );
\do_buffer_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(15),
      Q => Q(15),
      R => '0'
    );
\do_buffer_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(1),
      Q => Q(1),
      R => '0'
    );
\do_buffer_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(2),
      Q => Q(2),
      R => '0'
    );
\do_buffer_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(3),
      Q => Q(3),
      R => '0'
    );
\do_buffer_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(4),
      Q => Q(4),
      R => '0'
    );
\do_buffer_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(5),
      Q => Q(5),
      R => '0'
    );
\do_buffer_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(6),
      Q => Q(6),
      R => '0'
    );
\do_buffer_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(7),
      Q => Q(7),
      R => '0'
    );
\do_buffer_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(8),
      Q => Q(8),
      R => '0'
    );
\do_buffer_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => \do_buffer_reg[15]_i_1_n_0\,
      D => do_buffer_next(9),
      Q => Q(9),
      R => '0'
    );
do_transfer_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAABFBE00000004"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(1),
      I2 => state_reg(2),
      I3 => state_reg(0),
      I4 => state_reg(3),
      I5 => do_transfer_reg,
      O => do_transfer_reg_i_1_n_0
    );
do_transfer_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => AZ_SCK,
      CE => '1',
      D => do_transfer_reg_i_1_n_0,
      Q => do_transfer_reg,
      R => '0'
    );
do_valid_A_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => do_transfer_reg,
      Q => do_valid_A,
      R => '0'
    );
do_valid_B_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => do_valid_A,
      Q => do_valid_B,
      R => '0'
    );
do_valid_C_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => do_valid_B,
      Q => do_valid_C,
      R => '0'
    );
do_valid_D_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => do_valid_C,
      Q => do_valid_D,
      R => '0'
    );
do_valid_next0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => do_valid_D,
      I1 => do_valid_A,
      I2 => do_valid_B,
      O => do_valid_next
    );
do_valid_o_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => do_valid_next,
      Q => E(0),
      R => '0'
    );
\sh_reg[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0F1FFFFF0E00000"
    )
        port map (
      I0 => state_reg(3),
      I1 => \sh_reg[14]_i_3_n_0\,
      I2 => do_buffer_next(1),
      I3 => \sh_reg[14]_i_2_n_0\,
      I4 => state_reg(4),
      I5 => AZ_MOSI,
      O => sh_next(0)
    );
\sh_reg[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(11),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(10),
      O => sh_next(10)
    );
\sh_reg[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(12),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(11),
      O => sh_next(11)
    );
\sh_reg[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(13),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(12),
      O => sh_next(12)
    );
\sh_reg[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(14),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(13),
      O => sh_next(13)
    );
\sh_reg[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(15),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(14),
      O => sh_next(14)
    );
\sh_reg[14]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => state_reg(2),
      I1 => state_reg(1),
      I2 => state_reg(0),
      O => \sh_reg[14]_i_2_n_0\
    );
\sh_reg[14]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => state_reg(1),
      I1 => state_reg(2),
      O => \sh_reg[14]_i_3_n_0\
    );
\sh_reg[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(2),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(1),
      O => sh_next(1)
    );
\sh_reg[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(3),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(2),
      O => sh_next(2)
    );
\sh_reg[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(4),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(3),
      O => sh_next(3)
    );
\sh_reg[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(5),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(4),
      O => sh_next(4)
    );
\sh_reg[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(6),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(5),
      O => sh_next(5)
    );
\sh_reg[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(7),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(6),
      O => sh_next(6)
    );
\sh_reg[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(8),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(7),
      O => sh_next(7)
    );
\sh_reg[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(9),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(8),
      O => sh_next(8)
    );
\sh_reg[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => do_buffer_next(10),
      I1 => \sh_reg[14]_i_2_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3_n_0\,
      I5 => do_buffer_next(9),
      O => sh_next(9)
    );
\sh_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(0),
      Q => do_buffer_next(1),
      R => '0'
    );
\sh_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(10),
      Q => do_buffer_next(11),
      R => '0'
    );
\sh_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(11),
      Q => do_buffer_next(12),
      R => '0'
    );
\sh_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(12),
      Q => do_buffer_next(13),
      R => '0'
    );
\sh_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(13),
      Q => do_buffer_next(14),
      R => '0'
    );
\sh_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(14),
      Q => do_buffer_next(15),
      R => '0'
    );
\sh_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(1),
      Q => do_buffer_next(2),
      R => '0'
    );
\sh_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(2),
      Q => do_buffer_next(3),
      R => '0'
    );
\sh_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(3),
      Q => do_buffer_next(4),
      R => '0'
    );
\sh_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(4),
      Q => do_buffer_next(5),
      R => '0'
    );
\sh_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(5),
      Q => do_buffer_next(6),
      R => '0'
    );
\sh_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(6),
      Q => do_buffer_next(7),
      R => '0'
    );
\sh_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(7),
      Q => do_buffer_next(8),
      R => '0'
    );
\sh_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(8),
      Q => do_buffer_next(9),
      R => '0'
    );
\sh_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => AZ_SCK,
      CE => '1',
      D => sh_next(9),
      Q => do_buffer_next(10),
      R => '0'
    );
\state_reg[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00005556"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(3),
      I2 => state_reg(1),
      I3 => state_reg(2),
      I4 => state_reg(0),
      O => \state_reg[0]_i_1_n_0\
    );
\state_reg[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55000056"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(3),
      I2 => state_reg(2),
      I3 => state_reg(1),
      I4 => state_reg(0),
      O => \state_reg[1]_i_1_n_0\
    );
\state_reg[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"50505006"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(3),
      I2 => state_reg(2),
      I3 => state_reg(0),
      I4 => state_reg(1),
      O => \state_reg[2]_i_1_n_0\
    );
\state_reg[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"44444442"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(3),
      I2 => state_reg(1),
      I3 => state_reg(0),
      I4 => state_reg(2),
      O => \state_reg[3]_i_1_n_0\
    );
\state_reg[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(2),
      I2 => state_reg(1),
      I3 => state_reg(3),
      O => state_next(4)
    );
\state_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => AZ_SCK,
      CE => '1',
      CLR => AZ_SSEL,
      D => \state_reg[0]_i_1_n_0\,
      Q => state_reg(0)
    );
\state_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => AZ_SCK,
      CE => '1',
      CLR => AZ_SSEL,
      D => \state_reg[1]_i_1_n_0\,
      Q => state_reg(1)
    );
\state_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => AZ_SCK,
      CE => '1',
      CLR => AZ_SSEL,
      D => \state_reg[2]_i_1_n_0\,
      Q => state_reg(2)
    );
\state_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => AZ_SCK,
      CE => '1',
      CLR => AZ_SSEL,
      D => \state_reg[3]_i_1_n_0\,
      Q => state_reg(3)
    );
\state_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => AZ_SCK,
      CE => '1',
      CLR => AZ_SSEL,
      D => state_next(4),
      Q => state_reg(4)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0_ser2bin_spi_0 is
  port (
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 );
    aclk : in STD_LOGIC;
    EL_SCK : in STD_LOGIC;
    EL_SSEL : in STD_LOGIC;
    EL_MOSI : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_position_encoder_0_0_ser2bin_spi_0 : entity is "ser2bin_spi";
end user_block2_position_encoder_0_0_ser2bin_spi_0;

architecture STRUCTURE of user_block2_position_encoder_0_0_ser2bin_spi_0 is
  signal \do_buffer_next__0\ : STD_LOGIC_VECTOR ( 15 downto 1 );
  signal \do_buffer_reg[15]_i_1__0_n_0\ : STD_LOGIC;
  signal \do_transfer_reg_i_1__0_n_0\ : STD_LOGIC;
  signal do_transfer_reg_reg_n_0 : STD_LOGIC;
  signal do_valid_A : STD_LOGIC;
  signal do_valid_B : STD_LOGIC;
  signal do_valid_C_reg_n_0 : STD_LOGIC;
  signal do_valid_D : STD_LOGIC;
  signal do_valid_next : STD_LOGIC;
  signal sh_next : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \sh_reg[14]_i_2__0_n_0\ : STD_LOGIC;
  signal \sh_reg[14]_i_3__0_n_0\ : STD_LOGIC;
  signal state_next : STD_LOGIC_VECTOR ( 4 to 4 );
  signal state_reg : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \state_reg[0]_i_1__0_n_0\ : STD_LOGIC;
  signal \state_reg[1]_i_1__0_n_0\ : STD_LOGIC;
  signal \state_reg[2]_i_1__0_n_0\ : STD_LOGIC;
  signal \state_reg[3]_i_1__0_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \sh_reg[14]_i_3__0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \state_reg[0]_i_1__0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \state_reg[1]_i_1__0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \state_reg[2]_i_1__0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \state_reg[3]_i_1__0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \state_reg[4]_i_1__0\ : label is "soft_lutpair15";
begin
\do_buffer_reg[15]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => state_reg(1),
      I1 => state_reg(2),
      I2 => state_reg(0),
      I3 => state_reg(3),
      I4 => state_reg(4),
      O => \do_buffer_reg[15]_i_1__0_n_0\
    );
\do_buffer_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => EL_MOSI,
      Q => Q(0),
      R => '0'
    );
\do_buffer_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(10),
      Q => Q(10),
      R => '0'
    );
\do_buffer_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(11),
      Q => Q(11),
      R => '0'
    );
\do_buffer_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(12),
      Q => Q(12),
      R => '0'
    );
\do_buffer_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(13),
      Q => Q(13),
      R => '0'
    );
\do_buffer_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(14),
      Q => Q(14),
      R => '0'
    );
\do_buffer_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(15),
      Q => Q(15),
      R => '0'
    );
\do_buffer_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(1),
      Q => Q(1),
      R => '0'
    );
\do_buffer_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(2),
      Q => Q(2),
      R => '0'
    );
\do_buffer_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(3),
      Q => Q(3),
      R => '0'
    );
\do_buffer_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(4),
      Q => Q(4),
      R => '0'
    );
\do_buffer_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(5),
      Q => Q(5),
      R => '0'
    );
\do_buffer_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(6),
      Q => Q(6),
      R => '0'
    );
\do_buffer_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(7),
      Q => Q(7),
      R => '0'
    );
\do_buffer_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(8),
      Q => Q(8),
      R => '0'
    );
\do_buffer_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => \do_buffer_reg[15]_i_1__0_n_0\,
      D => \do_buffer_next__0\(9),
      Q => Q(9),
      R => '0'
    );
\do_transfer_reg_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAABFBE00000004"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(1),
      I2 => state_reg(2),
      I3 => state_reg(0),
      I4 => state_reg(3),
      I5 => do_transfer_reg_reg_n_0,
      O => \do_transfer_reg_i_1__0_n_0\
    );
do_transfer_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => EL_SCK,
      CE => '1',
      D => \do_transfer_reg_i_1__0_n_0\,
      Q => do_transfer_reg_reg_n_0,
      R => '0'
    );
do_valid_A_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => do_transfer_reg_reg_n_0,
      Q => do_valid_A,
      R => '0'
    );
do_valid_B_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => do_valid_A,
      Q => do_valid_B,
      R => '0'
    );
do_valid_C_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => do_valid_B,
      Q => do_valid_C_reg_n_0,
      R => '0'
    );
do_valid_D_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => do_valid_C_reg_n_0,
      Q => do_valid_D,
      R => '0'
    );
do_valid_next0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => do_valid_D,
      I1 => do_valid_A,
      I2 => do_valid_B,
      O => do_valid_next
    );
do_valid_o_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => do_valid_next,
      Q => E(0),
      R => '0'
    );
\sh_reg[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0F1FFFFF0E00000"
    )
        port map (
      I0 => state_reg(3),
      I1 => \sh_reg[14]_i_3__0_n_0\,
      I2 => \do_buffer_next__0\(1),
      I3 => \sh_reg[14]_i_2__0_n_0\,
      I4 => state_reg(4),
      I5 => EL_MOSI,
      O => sh_next(0)
    );
\sh_reg[10]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(11),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(10),
      O => sh_next(10)
    );
\sh_reg[11]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(12),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(11),
      O => sh_next(11)
    );
\sh_reg[12]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(13),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(12),
      O => sh_next(12)
    );
\sh_reg[13]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(14),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(13),
      O => sh_next(13)
    );
\sh_reg[14]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(15),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(14),
      O => sh_next(14)
    );
\sh_reg[14]_i_2__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => state_reg(2),
      I1 => state_reg(1),
      I2 => state_reg(0),
      O => \sh_reg[14]_i_2__0_n_0\
    );
\sh_reg[14]_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => state_reg(1),
      I1 => state_reg(2),
      O => \sh_reg[14]_i_3__0_n_0\
    );
\sh_reg[1]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(2),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(1),
      O => sh_next(1)
    );
\sh_reg[2]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(3),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(2),
      O => sh_next(2)
    );
\sh_reg[3]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(4),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(3),
      O => sh_next(3)
    );
\sh_reg[4]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(5),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(4),
      O => sh_next(4)
    );
\sh_reg[5]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(6),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(5),
      O => sh_next(5)
    );
\sh_reg[6]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(7),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(6),
      O => sh_next(6)
    );
\sh_reg[7]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(8),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(7),
      O => sh_next(7)
    );
\sh_reg[8]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(9),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(8),
      O => sh_next(8)
    );
\sh_reg[9]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAFAFB0A0A0A080"
    )
        port map (
      I0 => \do_buffer_next__0\(10),
      I1 => \sh_reg[14]_i_2__0_n_0\,
      I2 => state_reg(4),
      I3 => state_reg(3),
      I4 => \sh_reg[14]_i_3__0_n_0\,
      I5 => \do_buffer_next__0\(9),
      O => sh_next(9)
    );
\sh_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(0),
      Q => \do_buffer_next__0\(1),
      R => '0'
    );
\sh_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(10),
      Q => \do_buffer_next__0\(11),
      R => '0'
    );
\sh_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(11),
      Q => \do_buffer_next__0\(12),
      R => '0'
    );
\sh_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(12),
      Q => \do_buffer_next__0\(13),
      R => '0'
    );
\sh_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(13),
      Q => \do_buffer_next__0\(14),
      R => '0'
    );
\sh_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(14),
      Q => \do_buffer_next__0\(15),
      R => '0'
    );
\sh_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(1),
      Q => \do_buffer_next__0\(2),
      R => '0'
    );
\sh_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(2),
      Q => \do_buffer_next__0\(3),
      R => '0'
    );
\sh_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(3),
      Q => \do_buffer_next__0\(4),
      R => '0'
    );
\sh_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(4),
      Q => \do_buffer_next__0\(5),
      R => '0'
    );
\sh_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(5),
      Q => \do_buffer_next__0\(6),
      R => '0'
    );
\sh_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(6),
      Q => \do_buffer_next__0\(7),
      R => '0'
    );
\sh_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(7),
      Q => \do_buffer_next__0\(8),
      R => '0'
    );
\sh_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(8),
      Q => \do_buffer_next__0\(9),
      R => '0'
    );
\sh_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => EL_SCK,
      CE => '1',
      D => sh_next(9),
      Q => \do_buffer_next__0\(10),
      R => '0'
    );
\state_reg[0]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00005556"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(3),
      I2 => state_reg(1),
      I3 => state_reg(2),
      I4 => state_reg(0),
      O => \state_reg[0]_i_1__0_n_0\
    );
\state_reg[1]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55000056"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(3),
      I2 => state_reg(2),
      I3 => state_reg(1),
      I4 => state_reg(0),
      O => \state_reg[1]_i_1__0_n_0\
    );
\state_reg[2]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"50505006"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(3),
      I2 => state_reg(2),
      I3 => state_reg(0),
      I4 => state_reg(1),
      O => \state_reg[2]_i_1__0_n_0\
    );
\state_reg[3]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"44444442"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(3),
      I2 => state_reg(1),
      I3 => state_reg(0),
      I4 => state_reg(2),
      O => \state_reg[3]_i_1__0_n_0\
    );
\state_reg[4]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => state_reg(4),
      I1 => state_reg(2),
      I2 => state_reg(1),
      I3 => state_reg(3),
      O => state_next(4)
    );
\state_reg_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => EL_SCK,
      CE => '1',
      CLR => EL_SSEL,
      D => \state_reg[0]_i_1__0_n_0\,
      Q => state_reg(0)
    );
\state_reg_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => EL_SCK,
      CE => '1',
      CLR => EL_SSEL,
      D => \state_reg[1]_i_1__0_n_0\,
      Q => state_reg(1)
    );
\state_reg_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => EL_SCK,
      CE => '1',
      CLR => EL_SSEL,
      D => \state_reg[2]_i_1__0_n_0\,
      Q => state_reg(2)
    );
\state_reg_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => EL_SCK,
      CE => '1',
      CLR => EL_SSEL,
      D => \state_reg[3]_i_1__0_n_0\,
      Q => state_reg(3)
    );
\state_reg_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => EL_SCK,
      CE => '1',
      CLR => EL_SSEL,
      D => state_next(4),
      Q => state_reg(4)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0_QUAD2BIN is
  port (
    pos_enc_0 : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pos_enc_1 : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \pos_enc_0[15]\ : out STD_LOGIC;
    \pos_enc_0[14]\ : out STD_LOGIC;
    \pos_enc_0[13]\ : out STD_LOGIC;
    \pos_enc_0[12]\ : out STD_LOGIC;
    \pos_enc_0[11]\ : out STD_LOGIC;
    \pos_enc_0[10]\ : out STD_LOGIC;
    \pos_enc_0[9]\ : out STD_LOGIC;
    \pos_enc_0[8]\ : out STD_LOGIC;
    \pos_enc_0[7]\ : out STD_LOGIC;
    \pos_enc_0[6]\ : out STD_LOGIC;
    \pos_enc_0[5]\ : out STD_LOGIC;
    \pos_enc_0[4]\ : out STD_LOGIC;
    \pos_enc_0[3]\ : out STD_LOGIC;
    \pos_enc_0_2__s_port_\ : out STD_LOGIC;
    \pos_enc_0_1__s_port_\ : out STD_LOGIC;
    \pos_enc_0_0__s_port_\ : out STD_LOGIC;
    \pos_enc_1[15]\ : out STD_LOGIC;
    \pos_enc_1[14]\ : out STD_LOGIC;
    \pos_enc_1[13]\ : out STD_LOGIC;
    \pos_enc_1[12]\ : out STD_LOGIC;
    \pos_enc_1[11]\ : out STD_LOGIC;
    \pos_enc_1[10]\ : out STD_LOGIC;
    \pos_enc_1[9]\ : out STD_LOGIC;
    \pos_enc_1[8]\ : out STD_LOGIC;
    \pos_enc_1[7]\ : out STD_LOGIC;
    \pos_enc_1[6]\ : out STD_LOGIC;
    \pos_enc_1[5]\ : out STD_LOGIC;
    \pos_enc_1[4]\ : out STD_LOGIC;
    \pos_enc_1[3]\ : out STD_LOGIC;
    \pos_enc_1_2__s_port_\ : out STD_LOGIC;
    \pos_enc_1_1__s_port_\ : out STD_LOGIC;
    \pos_enc_1_0__s_port_\ : out STD_LOGIC;
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    ctl_reg : in STD_LOGIC_VECTOR ( 1 downto 0 );
    ROT_A : in STD_LOGIC;
    ROT_B : in STD_LOGIC;
    TILT_B : in STD_LOGIC;
    TILT_A : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_position_encoder_0_0_QUAD2BIN : entity is "QUAD2BIN";
end user_block2_position_encoder_0_0_QUAD2BIN;

architecture STRUCTURE of user_block2_position_encoder_0_0_QUAD2BIN is
  signal FF4_n_1 : STD_LOGIC;
  signal FF4_n_10 : STD_LOGIC;
  signal FF4_n_11 : STD_LOGIC;
  signal FF4_n_12 : STD_LOGIC;
  signal FF4_n_13 : STD_LOGIC;
  signal FF4_n_14 : STD_LOGIC;
  signal FF4_n_15 : STD_LOGIC;
  signal FF4_n_16 : STD_LOGIC;
  signal FF4_n_17 : STD_LOGIC;
  signal FF4_n_18 : STD_LOGIC;
  signal FF4_n_2 : STD_LOGIC;
  signal FF4_n_3 : STD_LOGIC;
  signal FF4_n_4 : STD_LOGIC;
  signal FF4_n_5 : STD_LOGIC;
  signal FF4_n_6 : STD_LOGIC;
  signal FF4_n_7 : STD_LOGIC;
  signal FF4_n_8 : STD_LOGIC;
  signal FF4_n_9 : STD_LOGIC;
  signal \ROT_POS_reg_n_0_[16]\ : STD_LOGIC;
  signal \ROT_POS_reg_n_0_[17]\ : STD_LOGIC;
  signal \ROT_POS_reg_n_0_[18]\ : STD_LOGIC;
  signal \TILT_POS_reg_n_0_[16]\ : STD_LOGIC;
  signal \TILT_POS_reg_n_0_[17]\ : STD_LOGIC;
  signal \TILT_POS_reg_n_0_[18]\ : STD_LOGIC;
  signal \i__carry__0_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_5_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_6_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_7_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_8_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_2_n_0\ : STD_LOGIC;
  signal \i__carry_i_1_n_0\ : STD_LOGIC;
  signal \i__carry_i_2_n_0\ : STD_LOGIC;
  signal \i__carry_i_3_n_0\ : STD_LOGIC;
  signal \i__carry_i_4_n_0\ : STD_LOGIC;
  signal \i__carry_i_5_n_0\ : STD_LOGIC;
  signal \i__carry_i_6_n_0\ : STD_LOGIC;
  signal \i__carry_i_7_n_0\ : STD_LOGIC;
  signal \i__carry_i_8_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_i_5_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_i_6_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_i_7_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_i_8_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_n_1\ : STD_LOGIC;
  signal \minusOp_carry__0_n_10\ : STD_LOGIC;
  signal \minusOp_carry__0_n_11\ : STD_LOGIC;
  signal \minusOp_carry__0_n_12\ : STD_LOGIC;
  signal \minusOp_carry__0_n_13\ : STD_LOGIC;
  signal \minusOp_carry__0_n_14\ : STD_LOGIC;
  signal \minusOp_carry__0_n_15\ : STD_LOGIC;
  signal \minusOp_carry__0_n_2\ : STD_LOGIC;
  signal \minusOp_carry__0_n_3\ : STD_LOGIC;
  signal \minusOp_carry__0_n_5\ : STD_LOGIC;
  signal \minusOp_carry__0_n_6\ : STD_LOGIC;
  signal \minusOp_carry__0_n_7\ : STD_LOGIC;
  signal \minusOp_carry__0_n_8\ : STD_LOGIC;
  signal \minusOp_carry__0_n_9\ : STD_LOGIC;
  signal \minusOp_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \minusOp_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \minusOp_carry__1_n_14\ : STD_LOGIC;
  signal \minusOp_carry__1_n_15\ : STD_LOGIC;
  signal \minusOp_carry__1_n_7\ : STD_LOGIC;
  signal minusOp_carry_i_1_n_0 : STD_LOGIC;
  signal minusOp_carry_i_2_n_0 : STD_LOGIC;
  signal minusOp_carry_i_3_n_0 : STD_LOGIC;
  signal minusOp_carry_i_4_n_0 : STD_LOGIC;
  signal minusOp_carry_i_5_n_0 : STD_LOGIC;
  signal minusOp_carry_i_6_n_0 : STD_LOGIC;
  signal minusOp_carry_i_7_n_0 : STD_LOGIC;
  signal minusOp_carry_i_8_n_0 : STD_LOGIC;
  signal minusOp_carry_n_0 : STD_LOGIC;
  signal minusOp_carry_n_1 : STD_LOGIC;
  signal minusOp_carry_n_10 : STD_LOGIC;
  signal minusOp_carry_n_11 : STD_LOGIC;
  signal minusOp_carry_n_12 : STD_LOGIC;
  signal minusOp_carry_n_13 : STD_LOGIC;
  signal minusOp_carry_n_14 : STD_LOGIC;
  signal minusOp_carry_n_15 : STD_LOGIC;
  signal minusOp_carry_n_2 : STD_LOGIC;
  signal minusOp_carry_n_3 : STD_LOGIC;
  signal minusOp_carry_n_5 : STD_LOGIC;
  signal minusOp_carry_n_6 : STD_LOGIC;
  signal minusOp_carry_n_7 : STD_LOGIC;
  signal minusOp_carry_n_8 : STD_LOGIC;
  signal minusOp_carry_n_9 : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_0\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_1\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_10\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_11\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_12\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_13\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_14\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_15\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_2\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_3\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_5\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_6\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_7\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_8\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__0_n_9\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__1_n_14\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__1_n_15\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry__1_n_7\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_0\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_1\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_10\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_11\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_12\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_13\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_14\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_15\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_2\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_3\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_5\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_6\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_7\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_8\ : STD_LOGIC;
  signal \minusOp_inferred__0/i__carry_n_9\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 18 downto 0 );
  signal \pos_enc_0_0__s_net_1\ : STD_LOGIC;
  signal \pos_enc_0_1__s_net_1\ : STD_LOGIC;
  signal \pos_enc_0_2__s_net_1\ : STD_LOGIC;
  signal \pos_enc_1_0__s_net_1\ : STD_LOGIC;
  signal \pos_enc_1_1__s_net_1\ : STD_LOGIC;
  signal \pos_enc_1_2__s_net_1\ : STD_LOGIC;
  signal rot_a_d1 : STD_LOGIC;
  signal rot_a_d2 : STD_LOGIC;
  signal rot_a_d3 : STD_LOGIC;
  signal rot_a_d4 : STD_LOGIC;
  signal rot_a_filt : STD_LOGIC;
  signal rot_a_filt_d1 : STD_LOGIC;
  signal rot_b_d1 : STD_LOGIC;
  signal rot_b_d2 : STD_LOGIC;
  signal rot_b_d3 : STD_LOGIC;
  signal rot_b_d4 : STD_LOGIC;
  signal rot_b_filt : STD_LOGIC;
  signal rot_b_filt_d1 : STD_LOGIC;
  signal rot_count_enable : STD_LOGIC;
  signal rot_encoder_cnt : STD_LOGIC_VECTOR ( 18 downto 0 );
  signal rot_encoder_cnt0 : STD_LOGIC;
  signal \rot_encoder_cnt[16]_i_10_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[16]_i_3_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[16]_i_4_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[16]_i_5_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[16]_i_6_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[16]_i_7_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[16]_i_8_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[16]_i_9_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_10_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_11_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_12_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_13_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_14_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_15_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_16_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_17_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_18_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_5_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_6_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_7_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_8_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[18]_i_9_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[8]_i_10_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[8]_i_3_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[8]_i_4_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[8]_i_5_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[8]_i_6_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[8]_i_7_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[8]_i_8_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt[8]_i_9_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_1\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_10\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_11\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_12\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_13\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_14\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_15\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_2\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_3\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_5\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_6\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_7\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_8\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[16]_i_2_n_9\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[18]_i_4_n_14\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[18]_i_4_n_15\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[18]_i_4_n_7\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_10\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_11\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_12\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_13\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_14\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_15\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_5\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_6\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_7\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_8\ : STD_LOGIC;
  signal \rot_encoder_cnt_reg[8]_i_2_n_9\ : STD_LOGIC;
  signal tilt_a_d1 : STD_LOGIC;
  signal tilt_a_d2 : STD_LOGIC;
  signal tilt_a_d3 : STD_LOGIC;
  signal tilt_a_d4 : STD_LOGIC;
  signal tilt_a_filt : STD_LOGIC;
  signal tilt_a_filt_d1 : STD_LOGIC;
  signal tilt_b_d1 : STD_LOGIC;
  signal tilt_b_d2 : STD_LOGIC;
  signal tilt_b_d3 : STD_LOGIC;
  signal tilt_b_d4 : STD_LOGIC;
  signal tilt_b_filt : STD_LOGIC;
  signal tilt_b_filt_d1 : STD_LOGIC;
  signal tilt_count_enable : STD_LOGIC;
  signal tilt_encoder_cnt : STD_LOGIC_VECTOR ( 18 downto 0 );
  signal tilt_encoder_cnt0 : STD_LOGIC;
  signal \tilt_encoder_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[16]_i_10_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[16]_i_3_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[16]_i_4_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[16]_i_5_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[16]_i_6_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[16]_i_7_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[16]_i_8_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[16]_i_9_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[18]_i_10_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[18]_i_11_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[18]_i_12_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[18]_i_13_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[18]_i_14_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[18]_i_15_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[18]_i_7_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[18]_i_8_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[18]_i_9_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[8]_i_10_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[8]_i_3_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[8]_i_4_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[8]_i_5_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[8]_i_6_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[8]_i_7_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[8]_i_8_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt[8]_i_9_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_1\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_10\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_11\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_12\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_13\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_14\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_15\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_2\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_3\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_5\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_6\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_7\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_8\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[16]_i_2_n_9\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[18]_i_5_n_14\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[18]_i_5_n_15\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[18]_i_5_n_7\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_10\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_11\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_12\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_13\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_14\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_15\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_5\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_6\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_7\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_8\ : STD_LOGIC;
  signal \tilt_encoder_cnt_reg[8]_i_2_n_9\ : STD_LOGIC;
  signal tilt_z_d1 : STD_LOGIC;
  signal tilt_z_d2 : STD_LOGIC;
  signal tilt_z_d3 : STD_LOGIC;
  signal tilt_z_d4 : STD_LOGIC;
  signal NLW_minusOp_carry_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_minusOp_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_minusOp_carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal \NLW_minusOp_carry__1_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_minusOp_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_minusOp_carry__1_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_minusOp_inferred__0/i__carry_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_minusOp_inferred__0/i__carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_minusOp_inferred__0/i__carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal \NLW_minusOp_inferred__0/i__carry__1_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_minusOp_inferred__0/i__carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_minusOp_inferred__0/i__carry__1_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_rot_encoder_cnt_reg[16]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_rot_encoder_cnt_reg[18]_i_4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal \NLW_rot_encoder_cnt_reg[18]_i_4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_rot_encoder_cnt_reg[18]_i_4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_rot_encoder_cnt_reg[18]_i_4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_rot_encoder_cnt_reg[8]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_tilt_encoder_cnt_reg[16]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_tilt_encoder_cnt_reg[18]_i_5_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal \NLW_tilt_encoder_cnt_reg[18]_i_5_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_tilt_encoder_cnt_reg[18]_i_5_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_tilt_encoder_cnt_reg[18]_i_5_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_tilt_encoder_cnt_reg[8]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \pos_enc_0[16]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \pos_enc_0[17]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \pos_enc_0[18]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \pos_enc_1[16]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \pos_enc_1[17]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \pos_enc_1[18]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \rot_encoder_cnt[18]_i_10\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \rot_encoder_cnt[18]_i_12\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \rot_encoder_cnt[18]_i_14\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \rot_encoder_cnt[18]_i_15\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \rot_encoder_cnt[18]_i_16\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \rot_encoder_cnt[18]_i_9\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \tilt_encoder_cnt[18]_i_13\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \tilt_encoder_cnt[18]_i_14\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \tilt_encoder_cnt[18]_i_7\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \tilt_encoder_cnt[18]_i_8\ : label is "soft_lutpair4";
begin
  \pos_enc_0_0__s_port_\ <= \pos_enc_0_0__s_net_1\;
  \pos_enc_0_1__s_port_\ <= \pos_enc_0_1__s_net_1\;
  \pos_enc_0_2__s_port_\ <= \pos_enc_0_2__s_net_1\;
  \pos_enc_1_0__s_port_\ <= \pos_enc_1_0__s_net_1\;
  \pos_enc_1_1__s_port_\ <= \pos_enc_1_1__s_net_1\;
  \pos_enc_1_2__s_port_\ <= \pos_enc_1_2__s_net_1\;
FF1: entity work.user_block2_position_encoder_0_0_quad2bin_jkff
     port map (
      D(18 downto 0) => p_0_in(18 downto 0),
      E(0) => rot_count_enable,
      O(7) => \rot_encoder_cnt_reg[8]_i_2_n_8\,
      O(6) => \rot_encoder_cnt_reg[8]_i_2_n_9\,
      O(5) => \rot_encoder_cnt_reg[8]_i_2_n_10\,
      O(4) => \rot_encoder_cnt_reg[8]_i_2_n_11\,
      O(3) => \rot_encoder_cnt_reg[8]_i_2_n_12\,
      O(2) => \rot_encoder_cnt_reg[8]_i_2_n_13\,
      O(1) => \rot_encoder_cnt_reg[8]_i_2_n_14\,
      O(0) => \rot_encoder_cnt_reg[8]_i_2_n_15\,
      Q(0) => rot_encoder_cnt(0),
      aclk => aclk,
      aresetn => aresetn,
      rot_a_d2 => rot_a_d2,
      rot_a_d3 => rot_a_d3,
      rot_a_d4 => rot_a_d4,
      rot_a_filt => rot_a_filt,
      rot_a_filt_d1 => rot_a_filt_d1,
      rot_b_filt => rot_b_filt,
      rot_b_filt_d1 => rot_b_filt_d1,
      \rot_encoder_cnt_reg[0]\(7) => minusOp_carry_n_8,
      \rot_encoder_cnt_reg[0]\(6) => minusOp_carry_n_9,
      \rot_encoder_cnt_reg[0]\(5) => minusOp_carry_n_10,
      \rot_encoder_cnt_reg[0]\(4) => minusOp_carry_n_11,
      \rot_encoder_cnt_reg[0]\(3) => minusOp_carry_n_12,
      \rot_encoder_cnt_reg[0]\(2) => minusOp_carry_n_13,
      \rot_encoder_cnt_reg[0]\(1) => minusOp_carry_n_14,
      \rot_encoder_cnt_reg[0]\(0) => minusOp_carry_n_15,
      \rot_encoder_cnt_reg[0]_0\(7) => \rot_encoder_cnt_reg[16]_i_2_n_8\,
      \rot_encoder_cnt_reg[0]_0\(6) => \rot_encoder_cnt_reg[16]_i_2_n_9\,
      \rot_encoder_cnt_reg[0]_0\(5) => \rot_encoder_cnt_reg[16]_i_2_n_10\,
      \rot_encoder_cnt_reg[0]_0\(4) => \rot_encoder_cnt_reg[16]_i_2_n_11\,
      \rot_encoder_cnt_reg[0]_0\(3) => \rot_encoder_cnt_reg[16]_i_2_n_12\,
      \rot_encoder_cnt_reg[0]_0\(2) => \rot_encoder_cnt_reg[16]_i_2_n_13\,
      \rot_encoder_cnt_reg[0]_0\(1) => \rot_encoder_cnt_reg[16]_i_2_n_14\,
      \rot_encoder_cnt_reg[0]_0\(0) => \rot_encoder_cnt_reg[16]_i_2_n_15\,
      \rot_encoder_cnt_reg[15]\ => \rot_encoder_cnt[18]_i_5_n_0\,
      \rot_encoder_cnt_reg[16]\(7) => \minusOp_carry__0_n_8\,
      \rot_encoder_cnt_reg[16]\(6) => \minusOp_carry__0_n_9\,
      \rot_encoder_cnt_reg[16]\(5) => \minusOp_carry__0_n_10\,
      \rot_encoder_cnt_reg[16]\(4) => \minusOp_carry__0_n_11\,
      \rot_encoder_cnt_reg[16]\(3) => \minusOp_carry__0_n_12\,
      \rot_encoder_cnt_reg[16]\(2) => \minusOp_carry__0_n_13\,
      \rot_encoder_cnt_reg[16]\(1) => \minusOp_carry__0_n_14\,
      \rot_encoder_cnt_reg[16]\(0) => \minusOp_carry__0_n_15\,
      \rot_encoder_cnt_reg[17]\ => \rot_encoder_cnt[18]_i_6_n_0\,
      \rot_encoder_cnt_reg[17]_0\(1) => \minusOp_carry__1_n_14\,
      \rot_encoder_cnt_reg[17]_0\(0) => \minusOp_carry__1_n_15\,
      \rot_encoder_cnt_reg[18]\(1) => \rot_encoder_cnt_reg[18]_i_4_n_14\,
      \rot_encoder_cnt_reg[18]\(0) => \rot_encoder_cnt_reg[18]_i_4_n_15\
    );
FF2: entity work.user_block2_position_encoder_0_0_quad2bin_jkff_1
     port map (
      aclk => aclk,
      aresetn => aresetn,
      rot_b_d2 => rot_b_d2,
      rot_b_d3 => rot_b_d3,
      rot_b_d4 => rot_b_d4,
      rot_b_filt => rot_b_filt
    );
FF3: entity work.user_block2_position_encoder_0_0_quad2bin_jkff_2
     port map (
      SR(0) => rot_encoder_cnt0,
      aclk => aclk,
      aresetn => aresetn,
      tilt_z_d2 => tilt_z_d2,
      tilt_z_d3 => tilt_z_d3,
      tilt_z_d4 => tilt_z_d4
    );
FF4: entity work.user_block2_position_encoder_0_0_quad2bin_jkff_3
     port map (
      D(17) => FF4_n_1,
      D(16) => FF4_n_2,
      D(15) => FF4_n_3,
      D(14) => FF4_n_4,
      D(13) => FF4_n_5,
      D(12) => FF4_n_6,
      D(11) => FF4_n_7,
      D(10) => FF4_n_8,
      D(9) => FF4_n_9,
      D(8) => FF4_n_10,
      D(7) => FF4_n_11,
      D(6) => FF4_n_12,
      D(5) => FF4_n_13,
      D(4) => FF4_n_14,
      D(3) => FF4_n_15,
      D(2) => FF4_n_16,
      D(1) => FF4_n_17,
      D(0) => FF4_n_18,
      O(1) => \minusOp_inferred__0/i__carry__1_n_14\,
      O(0) => \minusOp_inferred__0/i__carry__1_n_15\,
      aclk => aclk,
      aresetn => aresetn,
      tilt_a_d2 => tilt_a_d2,
      tilt_a_d3 => tilt_a_d3,
      tilt_a_d4 => tilt_a_d4,
      tilt_a_filt => tilt_a_filt,
      tilt_b_filt_d1 => tilt_b_filt_d1,
      \tilt_encoder_cnt_reg[0]\(7) => \tilt_encoder_cnt_reg[16]_i_2_n_8\,
      \tilt_encoder_cnt_reg[0]\(6) => \tilt_encoder_cnt_reg[16]_i_2_n_9\,
      \tilt_encoder_cnt_reg[0]\(5) => \tilt_encoder_cnt_reg[16]_i_2_n_10\,
      \tilt_encoder_cnt_reg[0]\(4) => \tilt_encoder_cnt_reg[16]_i_2_n_11\,
      \tilt_encoder_cnt_reg[0]\(3) => \tilt_encoder_cnt_reg[16]_i_2_n_12\,
      \tilt_encoder_cnt_reg[0]\(2) => \tilt_encoder_cnt_reg[16]_i_2_n_13\,
      \tilt_encoder_cnt_reg[0]\(1) => \tilt_encoder_cnt_reg[16]_i_2_n_14\,
      \tilt_encoder_cnt_reg[0]\(0) => \tilt_encoder_cnt_reg[16]_i_2_n_15\,
      \tilt_encoder_cnt_reg[0]_0\(7) => \tilt_encoder_cnt_reg[8]_i_2_n_8\,
      \tilt_encoder_cnt_reg[0]_0\(6) => \tilt_encoder_cnt_reg[8]_i_2_n_9\,
      \tilt_encoder_cnt_reg[0]_0\(5) => \tilt_encoder_cnt_reg[8]_i_2_n_10\,
      \tilt_encoder_cnt_reg[0]_0\(4) => \tilt_encoder_cnt_reg[8]_i_2_n_11\,
      \tilt_encoder_cnt_reg[0]_0\(3) => \tilt_encoder_cnt_reg[8]_i_2_n_12\,
      \tilt_encoder_cnt_reg[0]_0\(2) => \tilt_encoder_cnt_reg[8]_i_2_n_13\,
      \tilt_encoder_cnt_reg[0]_0\(1) => \tilt_encoder_cnt_reg[8]_i_2_n_14\,
      \tilt_encoder_cnt_reg[0]_0\(0) => \tilt_encoder_cnt_reg[8]_i_2_n_15\,
      \tilt_encoder_cnt_reg[0]_1\(7) => \minusOp_inferred__0/i__carry_n_8\,
      \tilt_encoder_cnt_reg[0]_1\(6) => \minusOp_inferred__0/i__carry_n_9\,
      \tilt_encoder_cnt_reg[0]_1\(5) => \minusOp_inferred__0/i__carry_n_10\,
      \tilt_encoder_cnt_reg[0]_1\(4) => \minusOp_inferred__0/i__carry_n_11\,
      \tilt_encoder_cnt_reg[0]_1\(3) => \minusOp_inferred__0/i__carry_n_12\,
      \tilt_encoder_cnt_reg[0]_1\(2) => \minusOp_inferred__0/i__carry_n_13\,
      \tilt_encoder_cnt_reg[0]_1\(1) => \minusOp_inferred__0/i__carry_n_14\,
      \tilt_encoder_cnt_reg[0]_1\(0) => \minusOp_inferred__0/i__carry_n_15\,
      \tilt_encoder_cnt_reg[16]\(7) => \minusOp_inferred__0/i__carry__0_n_8\,
      \tilt_encoder_cnt_reg[16]\(6) => \minusOp_inferred__0/i__carry__0_n_9\,
      \tilt_encoder_cnt_reg[16]\(5) => \minusOp_inferred__0/i__carry__0_n_10\,
      \tilt_encoder_cnt_reg[16]\(4) => \minusOp_inferred__0/i__carry__0_n_11\,
      \tilt_encoder_cnt_reg[16]\(3) => \minusOp_inferred__0/i__carry__0_n_12\,
      \tilt_encoder_cnt_reg[16]\(2) => \minusOp_inferred__0/i__carry__0_n_13\,
      \tilt_encoder_cnt_reg[16]\(1) => \minusOp_inferred__0/i__carry__0_n_14\,
      \tilt_encoder_cnt_reg[16]\(0) => \minusOp_inferred__0/i__carry__0_n_15\,
      \tilt_encoder_cnt_reg[17]\ => \tilt_encoder_cnt[18]_i_15_n_0\,
      \tilt_encoder_cnt_reg[17]_0\ => \tilt_encoder_cnt[18]_i_9_n_0\,
      \tilt_encoder_cnt_reg[18]\(1) => \tilt_encoder_cnt_reg[18]_i_5_n_14\,
      \tilt_encoder_cnt_reg[18]\(0) => \tilt_encoder_cnt_reg[18]_i_5_n_15\,
      \tilt_encoder_cnt_reg[3]\ => \tilt_encoder_cnt[18]_i_13_n_0\,
      \tilt_encoder_cnt_reg[3]_0\ => \tilt_encoder_cnt[18]_i_7_n_0\,
      \tilt_encoder_cnt_reg[7]\ => \tilt_encoder_cnt[18]_i_14_n_0\,
      \tilt_encoder_cnt_reg[7]_0\ => \tilt_encoder_cnt[18]_i_8_n_0\,
      \tilt_encoder_cnt_reg[8]\ => \tilt_encoder_cnt[18]_i_10_n_0\
    );
FF5: entity work.user_block2_position_encoder_0_0_quad2bin_jkff_4
     port map (
      E(0) => tilt_count_enable,
      aclk => aclk,
      aresetn => aresetn,
      tilt_a_filt => tilt_a_filt,
      tilt_a_filt_d1 => tilt_a_filt_d1,
      tilt_b_d2 => tilt_b_d2,
      tilt_b_d3 => tilt_b_d3,
      tilt_b_d4 => tilt_b_d4,
      tilt_b_filt => tilt_b_filt,
      tilt_b_filt_d1 => tilt_b_filt_d1
    );
FF6: entity work.user_block2_position_encoder_0_0_quad2bin_jkff_5
     port map (
      SR(0) => tilt_encoder_cnt0,
      aclk => aclk,
      aresetn => aresetn,
      tilt_z_d2 => tilt_z_d2,
      tilt_z_d3 => tilt_z_d3,
      tilt_z_d4 => tilt_z_d4
    );
\ROT_POS_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(0),
      Q => \pos_enc_0_0__s_net_1\
    );
\ROT_POS_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(10),
      Q => \pos_enc_0[10]\
    );
\ROT_POS_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(11),
      Q => \pos_enc_0[11]\
    );
\ROT_POS_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(12),
      Q => \pos_enc_0[12]\
    );
\ROT_POS_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(13),
      Q => \pos_enc_0[13]\
    );
\ROT_POS_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(14),
      Q => \pos_enc_0[14]\
    );
\ROT_POS_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(15),
      Q => \pos_enc_0[15]\
    );
\ROT_POS_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(16),
      Q => \ROT_POS_reg_n_0_[16]\
    );
\ROT_POS_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(17),
      Q => \ROT_POS_reg_n_0_[17]\
    );
\ROT_POS_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(18),
      Q => \ROT_POS_reg_n_0_[18]\
    );
\ROT_POS_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(1),
      Q => \pos_enc_0_1__s_net_1\
    );
\ROT_POS_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(2),
      Q => \pos_enc_0_2__s_net_1\
    );
\ROT_POS_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(3),
      Q => \pos_enc_0[3]\
    );
\ROT_POS_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(4),
      Q => \pos_enc_0[4]\
    );
\ROT_POS_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(5),
      Q => \pos_enc_0[5]\
    );
\ROT_POS_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(6),
      Q => \pos_enc_0[6]\
    );
\ROT_POS_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(7),
      Q => \pos_enc_0[7]\
    );
\ROT_POS_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(8),
      Q => \pos_enc_0[8]\
    );
\ROT_POS_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_encoder_cnt(9),
      Q => \pos_enc_0[9]\
    );
\TILT_POS_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(0),
      Q => \pos_enc_1_0__s_net_1\
    );
\TILT_POS_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(10),
      Q => \pos_enc_1[10]\
    );
\TILT_POS_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(11),
      Q => \pos_enc_1[11]\
    );
\TILT_POS_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(12),
      Q => \pos_enc_1[12]\
    );
\TILT_POS_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(13),
      Q => \pos_enc_1[13]\
    );
\TILT_POS_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(14),
      Q => \pos_enc_1[14]\
    );
\TILT_POS_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(15),
      Q => \pos_enc_1[15]\
    );
\TILT_POS_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(16),
      Q => \TILT_POS_reg_n_0_[16]\
    );
\TILT_POS_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(17),
      Q => \TILT_POS_reg_n_0_[17]\
    );
\TILT_POS_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(18),
      Q => \TILT_POS_reg_n_0_[18]\
    );
\TILT_POS_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(1),
      Q => \pos_enc_1_1__s_net_1\
    );
\TILT_POS_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(2),
      Q => \pos_enc_1_2__s_net_1\
    );
\TILT_POS_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(3),
      Q => \pos_enc_1[3]\
    );
\TILT_POS_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(4),
      Q => \pos_enc_1[4]\
    );
\TILT_POS_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(5),
      Q => \pos_enc_1[5]\
    );
\TILT_POS_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(6),
      Q => \pos_enc_1[6]\
    );
\TILT_POS_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(7),
      Q => \pos_enc_1[7]\
    );
\TILT_POS_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(8),
      Q => \pos_enc_1[8]\
    );
\TILT_POS_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_encoder_cnt(9),
      Q => \pos_enc_1[9]\
    );
\i__carry__0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(16),
      O => \i__carry__0_i_1_n_0\
    );
\i__carry__0_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(15),
      O => \i__carry__0_i_2_n_0\
    );
\i__carry__0_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(14),
      O => \i__carry__0_i_3_n_0\
    );
\i__carry__0_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(13),
      O => \i__carry__0_i_4_n_0\
    );
\i__carry__0_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(12),
      O => \i__carry__0_i_5_n_0\
    );
\i__carry__0_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(11),
      O => \i__carry__0_i_6_n_0\
    );
\i__carry__0_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(10),
      O => \i__carry__0_i_7_n_0\
    );
\i__carry__0_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(9),
      O => \i__carry__0_i_8_n_0\
    );
\i__carry__1_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(18),
      O => \i__carry__1_i_1_n_0\
    );
\i__carry__1_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(17),
      O => \i__carry__1_i_2_n_0\
    );
\i__carry_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(8),
      O => \i__carry_i_1_n_0\
    );
\i__carry_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(7),
      O => \i__carry_i_2_n_0\
    );
\i__carry_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(6),
      O => \i__carry_i_3_n_0\
    );
\i__carry_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(5),
      O => \i__carry_i_4_n_0\
    );
\i__carry_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(4),
      O => \i__carry_i_5_n_0\
    );
\i__carry_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(3),
      O => \i__carry_i_6_n_0\
    );
\i__carry_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(2),
      O => \i__carry_i_7_n_0\
    );
\i__carry_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(1),
      O => \i__carry_i_8_n_0\
    );
minusOp_carry: unisim.vcomponents.CARRY8
     port map (
      CI => rot_encoder_cnt(0),
      CI_TOP => '0',
      CO(7) => minusOp_carry_n_0,
      CO(6) => minusOp_carry_n_1,
      CO(5) => minusOp_carry_n_2,
      CO(4) => minusOp_carry_n_3,
      CO(3) => NLW_minusOp_carry_CO_UNCONNECTED(3),
      CO(2) => minusOp_carry_n_5,
      CO(1) => minusOp_carry_n_6,
      CO(0) => minusOp_carry_n_7,
      DI(7 downto 0) => rot_encoder_cnt(8 downto 1),
      O(7) => minusOp_carry_n_8,
      O(6) => minusOp_carry_n_9,
      O(5) => minusOp_carry_n_10,
      O(4) => minusOp_carry_n_11,
      O(3) => minusOp_carry_n_12,
      O(2) => minusOp_carry_n_13,
      O(1) => minusOp_carry_n_14,
      O(0) => minusOp_carry_n_15,
      S(7) => minusOp_carry_i_1_n_0,
      S(6) => minusOp_carry_i_2_n_0,
      S(5) => minusOp_carry_i_3_n_0,
      S(4) => minusOp_carry_i_4_n_0,
      S(3) => minusOp_carry_i_5_n_0,
      S(2) => minusOp_carry_i_6_n_0,
      S(1) => minusOp_carry_i_7_n_0,
      S(0) => minusOp_carry_i_8_n_0
    );
\minusOp_carry__0\: unisim.vcomponents.CARRY8
     port map (
      CI => minusOp_carry_n_0,
      CI_TOP => '0',
      CO(7) => \minusOp_carry__0_n_0\,
      CO(6) => \minusOp_carry__0_n_1\,
      CO(5) => \minusOp_carry__0_n_2\,
      CO(4) => \minusOp_carry__0_n_3\,
      CO(3) => \NLW_minusOp_carry__0_CO_UNCONNECTED\(3),
      CO(2) => \minusOp_carry__0_n_5\,
      CO(1) => \minusOp_carry__0_n_6\,
      CO(0) => \minusOp_carry__0_n_7\,
      DI(7 downto 0) => rot_encoder_cnt(16 downto 9),
      O(7) => \minusOp_carry__0_n_8\,
      O(6) => \minusOp_carry__0_n_9\,
      O(5) => \minusOp_carry__0_n_10\,
      O(4) => \minusOp_carry__0_n_11\,
      O(3) => \minusOp_carry__0_n_12\,
      O(2) => \minusOp_carry__0_n_13\,
      O(1) => \minusOp_carry__0_n_14\,
      O(0) => \minusOp_carry__0_n_15\,
      S(7) => \minusOp_carry__0_i_1_n_0\,
      S(6) => \minusOp_carry__0_i_2_n_0\,
      S(5) => \minusOp_carry__0_i_3_n_0\,
      S(4) => \minusOp_carry__0_i_4_n_0\,
      S(3) => \minusOp_carry__0_i_5_n_0\,
      S(2) => \minusOp_carry__0_i_6_n_0\,
      S(1) => \minusOp_carry__0_i_7_n_0\,
      S(0) => \minusOp_carry__0_i_8_n_0\
    );
\minusOp_carry__0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(16),
      O => \minusOp_carry__0_i_1_n_0\
    );
\minusOp_carry__0_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(15),
      O => \minusOp_carry__0_i_2_n_0\
    );
\minusOp_carry__0_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(14),
      O => \minusOp_carry__0_i_3_n_0\
    );
\minusOp_carry__0_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(13),
      O => \minusOp_carry__0_i_4_n_0\
    );
\minusOp_carry__0_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(12),
      O => \minusOp_carry__0_i_5_n_0\
    );
\minusOp_carry__0_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(11),
      O => \minusOp_carry__0_i_6_n_0\
    );
\minusOp_carry__0_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(10),
      O => \minusOp_carry__0_i_7_n_0\
    );
\minusOp_carry__0_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(9),
      O => \minusOp_carry__0_i_8_n_0\
    );
\minusOp_carry__1\: unisim.vcomponents.CARRY8
     port map (
      CI => \minusOp_carry__0_n_0\,
      CI_TOP => '0',
      CO(7 downto 1) => \NLW_minusOp_carry__1_CO_UNCONNECTED\(7 downto 1),
      CO(0) => \minusOp_carry__1_n_7\,
      DI(7 downto 2) => \NLW_minusOp_carry__1_DI_UNCONNECTED\(7 downto 2),
      DI(1) => '0',
      DI(0) => rot_encoder_cnt(17),
      O(7 downto 2) => \NLW_minusOp_carry__1_O_UNCONNECTED\(7 downto 2),
      O(1) => \minusOp_carry__1_n_14\,
      O(0) => \minusOp_carry__1_n_15\,
      S(7 downto 2) => \NLW_minusOp_carry__1_S_UNCONNECTED\(7 downto 2),
      S(1) => \minusOp_carry__1_i_1_n_0\,
      S(0) => \minusOp_carry__1_i_2_n_0\
    );
\minusOp_carry__1_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(18),
      O => \minusOp_carry__1_i_1_n_0\
    );
\minusOp_carry__1_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(17),
      O => \minusOp_carry__1_i_2_n_0\
    );
minusOp_carry_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(8),
      O => minusOp_carry_i_1_n_0
    );
minusOp_carry_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(7),
      O => minusOp_carry_i_2_n_0
    );
minusOp_carry_i_3: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(6),
      O => minusOp_carry_i_3_n_0
    );
minusOp_carry_i_4: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(5),
      O => minusOp_carry_i_4_n_0
    );
minusOp_carry_i_5: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(4),
      O => minusOp_carry_i_5_n_0
    );
minusOp_carry_i_6: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(3),
      O => minusOp_carry_i_6_n_0
    );
minusOp_carry_i_7: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(2),
      O => minusOp_carry_i_7_n_0
    );
minusOp_carry_i_8: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rot_encoder_cnt(1),
      O => minusOp_carry_i_8_n_0
    );
\minusOp_inferred__0/i__carry\: unisim.vcomponents.CARRY8
     port map (
      CI => tilt_encoder_cnt(0),
      CI_TOP => '0',
      CO(7) => \minusOp_inferred__0/i__carry_n_0\,
      CO(6) => \minusOp_inferred__0/i__carry_n_1\,
      CO(5) => \minusOp_inferred__0/i__carry_n_2\,
      CO(4) => \minusOp_inferred__0/i__carry_n_3\,
      CO(3) => \NLW_minusOp_inferred__0/i__carry_CO_UNCONNECTED\(3),
      CO(2) => \minusOp_inferred__0/i__carry_n_5\,
      CO(1) => \minusOp_inferred__0/i__carry_n_6\,
      CO(0) => \minusOp_inferred__0/i__carry_n_7\,
      DI(7 downto 0) => tilt_encoder_cnt(8 downto 1),
      O(7) => \minusOp_inferred__0/i__carry_n_8\,
      O(6) => \minusOp_inferred__0/i__carry_n_9\,
      O(5) => \minusOp_inferred__0/i__carry_n_10\,
      O(4) => \minusOp_inferred__0/i__carry_n_11\,
      O(3) => \minusOp_inferred__0/i__carry_n_12\,
      O(2) => \minusOp_inferred__0/i__carry_n_13\,
      O(1) => \minusOp_inferred__0/i__carry_n_14\,
      O(0) => \minusOp_inferred__0/i__carry_n_15\,
      S(7) => \i__carry_i_1_n_0\,
      S(6) => \i__carry_i_2_n_0\,
      S(5) => \i__carry_i_3_n_0\,
      S(4) => \i__carry_i_4_n_0\,
      S(3) => \i__carry_i_5_n_0\,
      S(2) => \i__carry_i_6_n_0\,
      S(1) => \i__carry_i_7_n_0\,
      S(0) => \i__carry_i_8_n_0\
    );
\minusOp_inferred__0/i__carry__0\: unisim.vcomponents.CARRY8
     port map (
      CI => \minusOp_inferred__0/i__carry_n_0\,
      CI_TOP => '0',
      CO(7) => \minusOp_inferred__0/i__carry__0_n_0\,
      CO(6) => \minusOp_inferred__0/i__carry__0_n_1\,
      CO(5) => \minusOp_inferred__0/i__carry__0_n_2\,
      CO(4) => \minusOp_inferred__0/i__carry__0_n_3\,
      CO(3) => \NLW_minusOp_inferred__0/i__carry__0_CO_UNCONNECTED\(3),
      CO(2) => \minusOp_inferred__0/i__carry__0_n_5\,
      CO(1) => \minusOp_inferred__0/i__carry__0_n_6\,
      CO(0) => \minusOp_inferred__0/i__carry__0_n_7\,
      DI(7 downto 0) => tilt_encoder_cnt(16 downto 9),
      O(7) => \minusOp_inferred__0/i__carry__0_n_8\,
      O(6) => \minusOp_inferred__0/i__carry__0_n_9\,
      O(5) => \minusOp_inferred__0/i__carry__0_n_10\,
      O(4) => \minusOp_inferred__0/i__carry__0_n_11\,
      O(3) => \minusOp_inferred__0/i__carry__0_n_12\,
      O(2) => \minusOp_inferred__0/i__carry__0_n_13\,
      O(1) => \minusOp_inferred__0/i__carry__0_n_14\,
      O(0) => \minusOp_inferred__0/i__carry__0_n_15\,
      S(7) => \i__carry__0_i_1_n_0\,
      S(6) => \i__carry__0_i_2_n_0\,
      S(5) => \i__carry__0_i_3_n_0\,
      S(4) => \i__carry__0_i_4_n_0\,
      S(3) => \i__carry__0_i_5_n_0\,
      S(2) => \i__carry__0_i_6_n_0\,
      S(1) => \i__carry__0_i_7_n_0\,
      S(0) => \i__carry__0_i_8_n_0\
    );
\minusOp_inferred__0/i__carry__1\: unisim.vcomponents.CARRY8
     port map (
      CI => \minusOp_inferred__0/i__carry__0_n_0\,
      CI_TOP => '0',
      CO(7 downto 1) => \NLW_minusOp_inferred__0/i__carry__1_CO_UNCONNECTED\(7 downto 1),
      CO(0) => \minusOp_inferred__0/i__carry__1_n_7\,
      DI(7 downto 2) => \NLW_minusOp_inferred__0/i__carry__1_DI_UNCONNECTED\(7 downto 2),
      DI(1) => '0',
      DI(0) => tilt_encoder_cnt(17),
      O(7 downto 2) => \NLW_minusOp_inferred__0/i__carry__1_O_UNCONNECTED\(7 downto 2),
      O(1) => \minusOp_inferred__0/i__carry__1_n_14\,
      O(0) => \minusOp_inferred__0/i__carry__1_n_15\,
      S(7 downto 2) => \NLW_minusOp_inferred__0/i__carry__1_S_UNCONNECTED\(7 downto 2),
      S(1) => \i__carry__1_i_1_n_0\,
      S(0) => \i__carry__1_i_2_n_0\
    );
\pos_enc_0[16]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \ROT_POS_reg_n_0_[16]\,
      I1 => ctl_reg(0),
      O => pos_enc_0(0)
    );
\pos_enc_0[17]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \ROT_POS_reg_n_0_[17]\,
      I1 => ctl_reg(0),
      O => pos_enc_0(1)
    );
\pos_enc_0[18]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \ROT_POS_reg_n_0_[18]\,
      I1 => ctl_reg(0),
      O => pos_enc_0(2)
    );
\pos_enc_1[16]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \TILT_POS_reg_n_0_[16]\,
      I1 => ctl_reg(0),
      O => pos_enc_1(0)
    );
\pos_enc_1[17]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \TILT_POS_reg_n_0_[17]\,
      I1 => ctl_reg(0),
      O => pos_enc_1(1)
    );
\pos_enc_1[18]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \TILT_POS_reg_n_0_[18]\,
      I1 => ctl_reg(0),
      O => pos_enc_1(2)
    );
rot_a_d1_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => ROT_A,
      Q => rot_a_d1
    );
rot_a_d2_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_a_d1,
      Q => rot_a_d2
    );
rot_a_d3_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_a_d2,
      Q => rot_a_d3
    );
rot_a_d4_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_a_d3,
      Q => rot_a_d4
    );
rot_a_filt_d1_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_a_filt,
      Q => rot_a_filt_d1
    );
rot_b_d1_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => ROT_B,
      Q => rot_b_d1
    );
rot_b_d2_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_b_d1,
      Q => rot_b_d2
    );
rot_b_d3_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_b_d2,
      Q => rot_b_d3
    );
rot_b_d4_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_b_d3,
      Q => rot_b_d4
    );
rot_b_filt_d1_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => rot_b_filt,
      Q => rot_b_filt_d1
    );
\rot_encoder_cnt[16]_i_10\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(9),
      O => \rot_encoder_cnt[16]_i_10_n_0\
    );
\rot_encoder_cnt[16]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(16),
      O => \rot_encoder_cnt[16]_i_3_n_0\
    );
\rot_encoder_cnt[16]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(15),
      O => \rot_encoder_cnt[16]_i_4_n_0\
    );
\rot_encoder_cnt[16]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(14),
      O => \rot_encoder_cnt[16]_i_5_n_0\
    );
\rot_encoder_cnt[16]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(13),
      O => \rot_encoder_cnt[16]_i_6_n_0\
    );
\rot_encoder_cnt[16]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(12),
      O => \rot_encoder_cnt[16]_i_7_n_0\
    );
\rot_encoder_cnt[16]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(11),
      O => \rot_encoder_cnt[16]_i_8_n_0\
    );
\rot_encoder_cnt[16]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(10),
      O => \rot_encoder_cnt[16]_i_9_n_0\
    );
\rot_encoder_cnt[18]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFF7"
    )
        port map (
      I0 => rot_encoder_cnt(5),
      I1 => rot_encoder_cnt(4),
      I2 => rot_encoder_cnt(7),
      I3 => rot_encoder_cnt(16),
      O => \rot_encoder_cnt[18]_i_10_n_0\
    );
\rot_encoder_cnt[18]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => rot_encoder_cnt(10),
      I1 => rot_encoder_cnt(8),
      I2 => rot_encoder_cnt(14),
      I3 => rot_encoder_cnt(13),
      O => \rot_encoder_cnt[18]_i_11_n_0\
    );
\rot_encoder_cnt[18]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => rot_encoder_cnt(0),
      I1 => rot_encoder_cnt(6),
      I2 => rot_encoder_cnt(2),
      I3 => rot_encoder_cnt(1),
      O => \rot_encoder_cnt[18]_i_12_n_0\
    );
\rot_encoder_cnt[18]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => rot_encoder_cnt(11),
      I1 => rot_encoder_cnt(12),
      I2 => rot_encoder_cnt(9),
      I3 => rot_encoder_cnt(3),
      O => \rot_encoder_cnt[18]_i_13_n_0\
    );
\rot_encoder_cnt[18]_i_14\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => rot_encoder_cnt(17),
      I1 => rot_encoder_cnt(16),
      I2 => rot_encoder_cnt(18),
      O => \rot_encoder_cnt[18]_i_14_n_0\
    );
\rot_encoder_cnt[18]_i_15\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => rot_encoder_cnt(6),
      I1 => rot_encoder_cnt(7),
      I2 => rot_encoder_cnt(4),
      I3 => rot_encoder_cnt(5),
      O => \rot_encoder_cnt[18]_i_15_n_0\
    );
\rot_encoder_cnt[18]_i_16\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => rot_encoder_cnt(2),
      I1 => rot_encoder_cnt(3),
      I2 => rot_encoder_cnt(0),
      I3 => rot_encoder_cnt(1),
      O => \rot_encoder_cnt[18]_i_16_n_0\
    );
\rot_encoder_cnt[18]_i_17\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => rot_encoder_cnt(14),
      I1 => rot_encoder_cnt(15),
      I2 => rot_encoder_cnt(12),
      I3 => rot_encoder_cnt(13),
      O => \rot_encoder_cnt[18]_i_17_n_0\
    );
\rot_encoder_cnt[18]_i_18\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => rot_encoder_cnt(10),
      I1 => rot_encoder_cnt(11),
      I2 => rot_encoder_cnt(8),
      I3 => rot_encoder_cnt(9),
      O => \rot_encoder_cnt[18]_i_18_n_0\
    );
\rot_encoder_cnt[18]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \rot_encoder_cnt[18]_i_9_n_0\,
      I1 => \rot_encoder_cnt[18]_i_10_n_0\,
      I2 => \rot_encoder_cnt[18]_i_11_n_0\,
      I3 => \rot_encoder_cnt[18]_i_12_n_0\,
      I4 => \rot_encoder_cnt[18]_i_13_n_0\,
      O => \rot_encoder_cnt[18]_i_5_n_0\
    );
\rot_encoder_cnt[18]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \rot_encoder_cnt[18]_i_14_n_0\,
      I1 => \rot_encoder_cnt[18]_i_15_n_0\,
      I2 => \rot_encoder_cnt[18]_i_16_n_0\,
      I3 => \rot_encoder_cnt[18]_i_17_n_0\,
      I4 => \rot_encoder_cnt[18]_i_18_n_0\,
      O => \rot_encoder_cnt[18]_i_6_n_0\
    );
\rot_encoder_cnt[18]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(18),
      O => \rot_encoder_cnt[18]_i_7_n_0\
    );
\rot_encoder_cnt[18]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(17),
      O => \rot_encoder_cnt[18]_i_8_n_0\
    );
\rot_encoder_cnt[18]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
        port map (
      I0 => rot_encoder_cnt(15),
      I1 => rot_encoder_cnt(18),
      I2 => rot_encoder_cnt(17),
      O => \rot_encoder_cnt[18]_i_9_n_0\
    );
\rot_encoder_cnt[8]_i_10\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(1),
      O => \rot_encoder_cnt[8]_i_10_n_0\
    );
\rot_encoder_cnt[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(8),
      O => \rot_encoder_cnt[8]_i_3_n_0\
    );
\rot_encoder_cnt[8]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(7),
      O => \rot_encoder_cnt[8]_i_4_n_0\
    );
\rot_encoder_cnt[8]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(6),
      O => \rot_encoder_cnt[8]_i_5_n_0\
    );
\rot_encoder_cnt[8]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(5),
      O => \rot_encoder_cnt[8]_i_6_n_0\
    );
\rot_encoder_cnt[8]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(4),
      O => \rot_encoder_cnt[8]_i_7_n_0\
    );
\rot_encoder_cnt[8]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(3),
      O => \rot_encoder_cnt[8]_i_8_n_0\
    );
\rot_encoder_cnt[8]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rot_encoder_cnt(2),
      O => \rot_encoder_cnt[8]_i_9_n_0\
    );
\rot_encoder_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(0),
      Q => rot_encoder_cnt(0),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(10),
      Q => rot_encoder_cnt(10),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(11),
      Q => rot_encoder_cnt(11),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(12),
      Q => rot_encoder_cnt(12),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(13),
      Q => rot_encoder_cnt(13),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(14),
      Q => rot_encoder_cnt(14),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(15),
      Q => rot_encoder_cnt(15),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(16),
      Q => rot_encoder_cnt(16),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[16]_i_2\: unisim.vcomponents.CARRY8
     port map (
      CI => \rot_encoder_cnt_reg[8]_i_2_n_0\,
      CI_TOP => '0',
      CO(7) => \rot_encoder_cnt_reg[16]_i_2_n_0\,
      CO(6) => \rot_encoder_cnt_reg[16]_i_2_n_1\,
      CO(5) => \rot_encoder_cnt_reg[16]_i_2_n_2\,
      CO(4) => \rot_encoder_cnt_reg[16]_i_2_n_3\,
      CO(3) => \NLW_rot_encoder_cnt_reg[16]_i_2_CO_UNCONNECTED\(3),
      CO(2) => \rot_encoder_cnt_reg[16]_i_2_n_5\,
      CO(1) => \rot_encoder_cnt_reg[16]_i_2_n_6\,
      CO(0) => \rot_encoder_cnt_reg[16]_i_2_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7) => \rot_encoder_cnt_reg[16]_i_2_n_8\,
      O(6) => \rot_encoder_cnt_reg[16]_i_2_n_9\,
      O(5) => \rot_encoder_cnt_reg[16]_i_2_n_10\,
      O(4) => \rot_encoder_cnt_reg[16]_i_2_n_11\,
      O(3) => \rot_encoder_cnt_reg[16]_i_2_n_12\,
      O(2) => \rot_encoder_cnt_reg[16]_i_2_n_13\,
      O(1) => \rot_encoder_cnt_reg[16]_i_2_n_14\,
      O(0) => \rot_encoder_cnt_reg[16]_i_2_n_15\,
      S(7) => \rot_encoder_cnt[16]_i_3_n_0\,
      S(6) => \rot_encoder_cnt[16]_i_4_n_0\,
      S(5) => \rot_encoder_cnt[16]_i_5_n_0\,
      S(4) => \rot_encoder_cnt[16]_i_6_n_0\,
      S(3) => \rot_encoder_cnt[16]_i_7_n_0\,
      S(2) => \rot_encoder_cnt[16]_i_8_n_0\,
      S(1) => \rot_encoder_cnt[16]_i_9_n_0\,
      S(0) => \rot_encoder_cnt[16]_i_10_n_0\
    );
\rot_encoder_cnt_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(17),
      Q => rot_encoder_cnt(17),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(18),
      Q => rot_encoder_cnt(18),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[18]_i_4\: unisim.vcomponents.CARRY8
     port map (
      CI => \rot_encoder_cnt_reg[16]_i_2_n_0\,
      CI_TOP => '0',
      CO(7 downto 1) => \NLW_rot_encoder_cnt_reg[18]_i_4_CO_UNCONNECTED\(7 downto 1),
      CO(0) => \rot_encoder_cnt_reg[18]_i_4_n_7\,
      DI(7 downto 2) => \NLW_rot_encoder_cnt_reg[18]_i_4_DI_UNCONNECTED\(7 downto 2),
      DI(1 downto 0) => B"00",
      O(7 downto 2) => \NLW_rot_encoder_cnt_reg[18]_i_4_O_UNCONNECTED\(7 downto 2),
      O(1) => \rot_encoder_cnt_reg[18]_i_4_n_14\,
      O(0) => \rot_encoder_cnt_reg[18]_i_4_n_15\,
      S(7 downto 2) => \NLW_rot_encoder_cnt_reg[18]_i_4_S_UNCONNECTED\(7 downto 2),
      S(1) => \rot_encoder_cnt[18]_i_7_n_0\,
      S(0) => \rot_encoder_cnt[18]_i_8_n_0\
    );
\rot_encoder_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(1),
      Q => rot_encoder_cnt(1),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(2),
      Q => rot_encoder_cnt(2),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(3),
      Q => rot_encoder_cnt(3),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(4),
      Q => rot_encoder_cnt(4),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(5),
      Q => rot_encoder_cnt(5),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(6),
      Q => rot_encoder_cnt(6),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(7),
      Q => rot_encoder_cnt(7),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(8),
      Q => rot_encoder_cnt(8),
      R => rot_encoder_cnt0
    );
\rot_encoder_cnt_reg[8]_i_2\: unisim.vcomponents.CARRY8
     port map (
      CI => rot_encoder_cnt(0),
      CI_TOP => '0',
      CO(7) => \rot_encoder_cnt_reg[8]_i_2_n_0\,
      CO(6) => \rot_encoder_cnt_reg[8]_i_2_n_1\,
      CO(5) => \rot_encoder_cnt_reg[8]_i_2_n_2\,
      CO(4) => \rot_encoder_cnt_reg[8]_i_2_n_3\,
      CO(3) => \NLW_rot_encoder_cnt_reg[8]_i_2_CO_UNCONNECTED\(3),
      CO(2) => \rot_encoder_cnt_reg[8]_i_2_n_5\,
      CO(1) => \rot_encoder_cnt_reg[8]_i_2_n_6\,
      CO(0) => \rot_encoder_cnt_reg[8]_i_2_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7) => \rot_encoder_cnt_reg[8]_i_2_n_8\,
      O(6) => \rot_encoder_cnt_reg[8]_i_2_n_9\,
      O(5) => \rot_encoder_cnt_reg[8]_i_2_n_10\,
      O(4) => \rot_encoder_cnt_reg[8]_i_2_n_11\,
      O(3) => \rot_encoder_cnt_reg[8]_i_2_n_12\,
      O(2) => \rot_encoder_cnt_reg[8]_i_2_n_13\,
      O(1) => \rot_encoder_cnt_reg[8]_i_2_n_14\,
      O(0) => \rot_encoder_cnt_reg[8]_i_2_n_15\,
      S(7) => \rot_encoder_cnt[8]_i_3_n_0\,
      S(6) => \rot_encoder_cnt[8]_i_4_n_0\,
      S(5) => \rot_encoder_cnt[8]_i_5_n_0\,
      S(4) => \rot_encoder_cnt[8]_i_6_n_0\,
      S(3) => \rot_encoder_cnt[8]_i_7_n_0\,
      S(2) => \rot_encoder_cnt[8]_i_8_n_0\,
      S(1) => \rot_encoder_cnt[8]_i_9_n_0\,
      S(0) => \rot_encoder_cnt[8]_i_10_n_0\
    );
\rot_encoder_cnt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => rot_count_enable,
      D => p_0_in(9),
      Q => rot_encoder_cnt(9),
      R => rot_encoder_cnt0
    );
rot_z_d1_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => ctl_reg(1),
      Q => tilt_z_d1
    );
rot_z_d2_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_z_d1,
      Q => tilt_z_d2
    );
rot_z_d3_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_z_d2,
      Q => tilt_z_d3
    );
rot_z_d4_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_z_d3,
      Q => tilt_z_d4
    );
tilt_a_d1_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => TILT_A,
      Q => tilt_a_d1
    );
tilt_a_d2_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_a_d1,
      Q => tilt_a_d2
    );
tilt_a_d3_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_a_d2,
      Q => tilt_a_d3
    );
tilt_a_d4_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_a_d3,
      Q => tilt_a_d4
    );
tilt_a_filt_d1_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_a_filt,
      Q => tilt_a_filt_d1
    );
tilt_b_d1_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => TILT_B,
      Q => tilt_b_d1
    );
tilt_b_d2_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_b_d1,
      Q => tilt_b_d2
    );
tilt_b_d3_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_b_d2,
      Q => tilt_b_d3
    );
tilt_b_d4_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_b_d3,
      Q => tilt_b_d4
    );
tilt_b_filt_d1_reg: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => tilt_b_filt,
      Q => tilt_b_filt_d1
    );
\tilt_encoder_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tilt_encoder_cnt(0),
      O => \tilt_encoder_cnt[0]_i_1_n_0\
    );
\tilt_encoder_cnt[16]_i_10\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(9),
      O => \tilt_encoder_cnt[16]_i_10_n_0\
    );
\tilt_encoder_cnt[16]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(16),
      O => \tilt_encoder_cnt[16]_i_3_n_0\
    );
\tilt_encoder_cnt[16]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(15),
      O => \tilt_encoder_cnt[16]_i_4_n_0\
    );
\tilt_encoder_cnt[16]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(14),
      O => \tilt_encoder_cnt[16]_i_5_n_0\
    );
\tilt_encoder_cnt[16]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(13),
      O => \tilt_encoder_cnt[16]_i_6_n_0\
    );
\tilt_encoder_cnt[16]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(12),
      O => \tilt_encoder_cnt[16]_i_7_n_0\
    );
\tilt_encoder_cnt[16]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(11),
      O => \tilt_encoder_cnt[16]_i_8_n_0\
    );
\tilt_encoder_cnt[16]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(10),
      O => \tilt_encoder_cnt[16]_i_9_n_0\
    );
\tilt_encoder_cnt[18]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => tilt_encoder_cnt(8),
      I1 => tilt_encoder_cnt(13),
      I2 => tilt_encoder_cnt(15),
      I3 => tilt_encoder_cnt(11),
      I4 => tilt_encoder_cnt(10),
      O => \tilt_encoder_cnt[18]_i_10_n_0\
    );
\tilt_encoder_cnt[18]_i_11\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(18),
      O => \tilt_encoder_cnt[18]_i_11_n_0\
    );
\tilt_encoder_cnt[18]_i_12\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(17),
      O => \tilt_encoder_cnt[18]_i_12_n_0\
    );
\tilt_encoder_cnt[18]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => tilt_encoder_cnt(3),
      I1 => tilt_encoder_cnt(2),
      I2 => tilt_encoder_cnt(5),
      I3 => tilt_encoder_cnt(4),
      O => \tilt_encoder_cnt[18]_i_13_n_0\
    );
\tilt_encoder_cnt[18]_i_14\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => tilt_encoder_cnt(7),
      I1 => tilt_encoder_cnt(6),
      I2 => tilt_encoder_cnt(12),
      I3 => tilt_encoder_cnt(9),
      O => \tilt_encoder_cnt[18]_i_14_n_0\
    );
\tilt_encoder_cnt[18]_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => tilt_encoder_cnt(17),
      I1 => tilt_encoder_cnt(18),
      I2 => tilt_encoder_cnt(14),
      I3 => tilt_encoder_cnt(16),
      I4 => tilt_encoder_cnt(1),
      I5 => tilt_encoder_cnt(0),
      O => \tilt_encoder_cnt[18]_i_15_n_0\
    );
\tilt_encoder_cnt[18]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => tilt_encoder_cnt(3),
      I1 => tilt_encoder_cnt(2),
      I2 => tilt_encoder_cnt(5),
      I3 => tilt_encoder_cnt(4),
      O => \tilt_encoder_cnt[18]_i_7_n_0\
    );
\tilt_encoder_cnt[18]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => tilt_encoder_cnt(7),
      I1 => tilt_encoder_cnt(6),
      I2 => tilt_encoder_cnt(12),
      I3 => tilt_encoder_cnt(9),
      O => \tilt_encoder_cnt[18]_i_8_n_0\
    );
\tilt_encoder_cnt[18]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => tilt_encoder_cnt(17),
      I1 => tilt_encoder_cnt(18),
      I2 => tilt_encoder_cnt(14),
      I3 => tilt_encoder_cnt(16),
      I4 => tilt_encoder_cnt(1),
      I5 => tilt_encoder_cnt(0),
      O => \tilt_encoder_cnt[18]_i_9_n_0\
    );
\tilt_encoder_cnt[8]_i_10\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(1),
      O => \tilt_encoder_cnt[8]_i_10_n_0\
    );
\tilt_encoder_cnt[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(8),
      O => \tilt_encoder_cnt[8]_i_3_n_0\
    );
\tilt_encoder_cnt[8]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(7),
      O => \tilt_encoder_cnt[8]_i_4_n_0\
    );
\tilt_encoder_cnt[8]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(6),
      O => \tilt_encoder_cnt[8]_i_5_n_0\
    );
\tilt_encoder_cnt[8]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(5),
      O => \tilt_encoder_cnt[8]_i_6_n_0\
    );
\tilt_encoder_cnt[8]_i_7\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(4),
      O => \tilt_encoder_cnt[8]_i_7_n_0\
    );
\tilt_encoder_cnt[8]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(3),
      O => \tilt_encoder_cnt[8]_i_8_n_0\
    );
\tilt_encoder_cnt[8]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tilt_encoder_cnt(2),
      O => \tilt_encoder_cnt[8]_i_9_n_0\
    );
\tilt_encoder_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => \tilt_encoder_cnt[0]_i_1_n_0\,
      Q => tilt_encoder_cnt(0),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_9,
      Q => tilt_encoder_cnt(10),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_8,
      Q => tilt_encoder_cnt(11),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_7,
      Q => tilt_encoder_cnt(12),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_6,
      Q => tilt_encoder_cnt(13),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_5,
      Q => tilt_encoder_cnt(14),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_4,
      Q => tilt_encoder_cnt(15),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_3,
      Q => tilt_encoder_cnt(16),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[16]_i_2\: unisim.vcomponents.CARRY8
     port map (
      CI => \tilt_encoder_cnt_reg[8]_i_2_n_0\,
      CI_TOP => '0',
      CO(7) => \tilt_encoder_cnt_reg[16]_i_2_n_0\,
      CO(6) => \tilt_encoder_cnt_reg[16]_i_2_n_1\,
      CO(5) => \tilt_encoder_cnt_reg[16]_i_2_n_2\,
      CO(4) => \tilt_encoder_cnt_reg[16]_i_2_n_3\,
      CO(3) => \NLW_tilt_encoder_cnt_reg[16]_i_2_CO_UNCONNECTED\(3),
      CO(2) => \tilt_encoder_cnt_reg[16]_i_2_n_5\,
      CO(1) => \tilt_encoder_cnt_reg[16]_i_2_n_6\,
      CO(0) => \tilt_encoder_cnt_reg[16]_i_2_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7) => \tilt_encoder_cnt_reg[16]_i_2_n_8\,
      O(6) => \tilt_encoder_cnt_reg[16]_i_2_n_9\,
      O(5) => \tilt_encoder_cnt_reg[16]_i_2_n_10\,
      O(4) => \tilt_encoder_cnt_reg[16]_i_2_n_11\,
      O(3) => \tilt_encoder_cnt_reg[16]_i_2_n_12\,
      O(2) => \tilt_encoder_cnt_reg[16]_i_2_n_13\,
      O(1) => \tilt_encoder_cnt_reg[16]_i_2_n_14\,
      O(0) => \tilt_encoder_cnt_reg[16]_i_2_n_15\,
      S(7) => \tilt_encoder_cnt[16]_i_3_n_0\,
      S(6) => \tilt_encoder_cnt[16]_i_4_n_0\,
      S(5) => \tilt_encoder_cnt[16]_i_5_n_0\,
      S(4) => \tilt_encoder_cnt[16]_i_6_n_0\,
      S(3) => \tilt_encoder_cnt[16]_i_7_n_0\,
      S(2) => \tilt_encoder_cnt[16]_i_8_n_0\,
      S(1) => \tilt_encoder_cnt[16]_i_9_n_0\,
      S(0) => \tilt_encoder_cnt[16]_i_10_n_0\
    );
\tilt_encoder_cnt_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_2,
      Q => tilt_encoder_cnt(17),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_1,
      Q => tilt_encoder_cnt(18),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[18]_i_5\: unisim.vcomponents.CARRY8
     port map (
      CI => \tilt_encoder_cnt_reg[16]_i_2_n_0\,
      CI_TOP => '0',
      CO(7 downto 1) => \NLW_tilt_encoder_cnt_reg[18]_i_5_CO_UNCONNECTED\(7 downto 1),
      CO(0) => \tilt_encoder_cnt_reg[18]_i_5_n_7\,
      DI(7 downto 2) => \NLW_tilt_encoder_cnt_reg[18]_i_5_DI_UNCONNECTED\(7 downto 2),
      DI(1 downto 0) => B"00",
      O(7 downto 2) => \NLW_tilt_encoder_cnt_reg[18]_i_5_O_UNCONNECTED\(7 downto 2),
      O(1) => \tilt_encoder_cnt_reg[18]_i_5_n_14\,
      O(0) => \tilt_encoder_cnt_reg[18]_i_5_n_15\,
      S(7 downto 2) => \NLW_tilt_encoder_cnt_reg[18]_i_5_S_UNCONNECTED\(7 downto 2),
      S(1) => \tilt_encoder_cnt[18]_i_11_n_0\,
      S(0) => \tilt_encoder_cnt[18]_i_12_n_0\
    );
\tilt_encoder_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_18,
      Q => tilt_encoder_cnt(1),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_17,
      Q => tilt_encoder_cnt(2),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_16,
      Q => tilt_encoder_cnt(3),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_15,
      Q => tilt_encoder_cnt(4),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_14,
      Q => tilt_encoder_cnt(5),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_13,
      Q => tilt_encoder_cnt(6),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_12,
      Q => tilt_encoder_cnt(7),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_11,
      Q => tilt_encoder_cnt(8),
      R => tilt_encoder_cnt0
    );
\tilt_encoder_cnt_reg[8]_i_2\: unisim.vcomponents.CARRY8
     port map (
      CI => tilt_encoder_cnt(0),
      CI_TOP => '0',
      CO(7) => \tilt_encoder_cnt_reg[8]_i_2_n_0\,
      CO(6) => \tilt_encoder_cnt_reg[8]_i_2_n_1\,
      CO(5) => \tilt_encoder_cnt_reg[8]_i_2_n_2\,
      CO(4) => \tilt_encoder_cnt_reg[8]_i_2_n_3\,
      CO(3) => \NLW_tilt_encoder_cnt_reg[8]_i_2_CO_UNCONNECTED\(3),
      CO(2) => \tilt_encoder_cnt_reg[8]_i_2_n_5\,
      CO(1) => \tilt_encoder_cnt_reg[8]_i_2_n_6\,
      CO(0) => \tilt_encoder_cnt_reg[8]_i_2_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7) => \tilt_encoder_cnt_reg[8]_i_2_n_8\,
      O(6) => \tilt_encoder_cnt_reg[8]_i_2_n_9\,
      O(5) => \tilt_encoder_cnt_reg[8]_i_2_n_10\,
      O(4) => \tilt_encoder_cnt_reg[8]_i_2_n_11\,
      O(3) => \tilt_encoder_cnt_reg[8]_i_2_n_12\,
      O(2) => \tilt_encoder_cnt_reg[8]_i_2_n_13\,
      O(1) => \tilt_encoder_cnt_reg[8]_i_2_n_14\,
      O(0) => \tilt_encoder_cnt_reg[8]_i_2_n_15\,
      S(7) => \tilt_encoder_cnt[8]_i_3_n_0\,
      S(6) => \tilt_encoder_cnt[8]_i_4_n_0\,
      S(5) => \tilt_encoder_cnt[8]_i_5_n_0\,
      S(4) => \tilt_encoder_cnt[8]_i_6_n_0\,
      S(3) => \tilt_encoder_cnt[8]_i_7_n_0\,
      S(2) => \tilt_encoder_cnt[8]_i_8_n_0\,
      S(1) => \tilt_encoder_cnt[8]_i_9_n_0\,
      S(0) => \tilt_encoder_cnt[8]_i_10_n_0\
    );
\tilt_encoder_cnt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => tilt_count_enable,
      D => FF4_n_10,
      Q => tilt_encoder_cnt(9),
      R => tilt_encoder_cnt0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0_ser2bin is
  port (
    \pos_enc_0[15]\ : out STD_LOGIC;
    \pos_enc_0[14]\ : out STD_LOGIC;
    \pos_enc_0[13]\ : out STD_LOGIC;
    \pos_enc_0[12]\ : out STD_LOGIC;
    \pos_enc_0[11]\ : out STD_LOGIC;
    \pos_enc_0[10]\ : out STD_LOGIC;
    \pos_enc_0[9]\ : out STD_LOGIC;
    \pos_enc_0[8]\ : out STD_LOGIC;
    \pos_enc_0[7]\ : out STD_LOGIC;
    \pos_enc_0[6]\ : out STD_LOGIC;
    \pos_enc_0[5]\ : out STD_LOGIC;
    \pos_enc_0[4]\ : out STD_LOGIC;
    \pos_enc_0[3]\ : out STD_LOGIC;
    \pos_enc_0[2]\ : out STD_LOGIC;
    \pos_enc_0[1]\ : out STD_LOGIC;
    \pos_enc_0[0]\ : out STD_LOGIC;
    \pos_enc_1[15]\ : out STD_LOGIC;
    \pos_enc_1[14]\ : out STD_LOGIC;
    \pos_enc_1[13]\ : out STD_LOGIC;
    \pos_enc_1[12]\ : out STD_LOGIC;
    \pos_enc_1[11]\ : out STD_LOGIC;
    \pos_enc_1[10]\ : out STD_LOGIC;
    \pos_enc_1[9]\ : out STD_LOGIC;
    \pos_enc_1[8]\ : out STD_LOGIC;
    \pos_enc_1[7]\ : out STD_LOGIC;
    \pos_enc_1[6]\ : out STD_LOGIC;
    \pos_enc_1[5]\ : out STD_LOGIC;
    \pos_enc_1[4]\ : out STD_LOGIC;
    \pos_enc_1[3]\ : out STD_LOGIC;
    \pos_enc_1[2]\ : out STD_LOGIC;
    \pos_enc_1[1]\ : out STD_LOGIC;
    \pos_enc_1[0]\ : out STD_LOGIC;
    aclk : in STD_LOGIC;
    AZ_SCK : in STD_LOGIC;
    EL_SCK : in STD_LOGIC;
    AZ_SSEL : in STD_LOGIC;
    EL_SSEL : in STD_LOGIC;
    AZ_MOSI : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    EL_MOSI : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_position_encoder_0_0_ser2bin : entity is "ser2bin";
end user_block2_position_encoder_0_0_ser2bin;

architecture STRUCTURE of user_block2_position_encoder_0_0_ser2bin is
  signal EL_spi_n_0 : STD_LOGIC;
  signal EL_spi_n_1 : STD_LOGIC;
  signal EL_spi_n_10 : STD_LOGIC;
  signal EL_spi_n_11 : STD_LOGIC;
  signal EL_spi_n_12 : STD_LOGIC;
  signal EL_spi_n_13 : STD_LOGIC;
  signal EL_spi_n_14 : STD_LOGIC;
  signal EL_spi_n_15 : STD_LOGIC;
  signal EL_spi_n_16 : STD_LOGIC;
  signal EL_spi_n_2 : STD_LOGIC;
  signal EL_spi_n_3 : STD_LOGIC;
  signal EL_spi_n_4 : STD_LOGIC;
  signal EL_spi_n_5 : STD_LOGIC;
  signal EL_spi_n_6 : STD_LOGIC;
  signal EL_spi_n_7 : STD_LOGIC;
  signal EL_spi_n_8 : STD_LOGIC;
  signal EL_spi_n_9 : STD_LOGIC;
  signal az_temp : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal do_buffer_reg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal do_valid_o_reg : STD_LOGIC;
  signal el_temp : STD_LOGIC_VECTOR ( 15 downto 0 );
begin
\AZ_POS_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(0),
      Q => \pos_enc_0[0]\
    );
\AZ_POS_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(10),
      Q => \pos_enc_0[10]\
    );
\AZ_POS_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(11),
      Q => \pos_enc_0[11]\
    );
\AZ_POS_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(12),
      Q => \pos_enc_0[12]\
    );
\AZ_POS_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(13),
      Q => \pos_enc_0[13]\
    );
\AZ_POS_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(14),
      Q => \pos_enc_0[14]\
    );
\AZ_POS_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(15),
      Q => \pos_enc_0[15]\
    );
\AZ_POS_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(1),
      Q => \pos_enc_0[1]\
    );
\AZ_POS_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(2),
      Q => \pos_enc_0[2]\
    );
\AZ_POS_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(3),
      Q => \pos_enc_0[3]\
    );
\AZ_POS_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(4),
      Q => \pos_enc_0[4]\
    );
\AZ_POS_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(5),
      Q => \pos_enc_0[5]\
    );
\AZ_POS_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(6),
      Q => \pos_enc_0[6]\
    );
\AZ_POS_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(7),
      Q => \pos_enc_0[7]\
    );
\AZ_POS_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(8),
      Q => \pos_enc_0[8]\
    );
\AZ_POS_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => az_temp(9),
      Q => \pos_enc_0[9]\
    );
AZ_spi: entity work.user_block2_position_encoder_0_0_ser2bin_spi
     port map (
      AZ_MOSI => AZ_MOSI,
      AZ_SCK => AZ_SCK,
      AZ_SSEL => AZ_SSEL,
      E(0) => do_valid_o_reg,
      Q(15 downto 0) => do_buffer_reg(15 downto 0),
      aclk => aclk
    );
\EL_POS_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(0),
      Q => \pos_enc_1[0]\
    );
\EL_POS_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(10),
      Q => \pos_enc_1[10]\
    );
\EL_POS_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(11),
      Q => \pos_enc_1[11]\
    );
\EL_POS_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(12),
      Q => \pos_enc_1[12]\
    );
\EL_POS_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(13),
      Q => \pos_enc_1[13]\
    );
\EL_POS_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(14),
      Q => \pos_enc_1[14]\
    );
\EL_POS_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(15),
      Q => \pos_enc_1[15]\
    );
\EL_POS_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(1),
      Q => \pos_enc_1[1]\
    );
\EL_POS_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(2),
      Q => \pos_enc_1[2]\
    );
\EL_POS_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(3),
      Q => \pos_enc_1[3]\
    );
\EL_POS_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(4),
      Q => \pos_enc_1[4]\
    );
\EL_POS_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(5),
      Q => \pos_enc_1[5]\
    );
\EL_POS_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(6),
      Q => \pos_enc_1[6]\
    );
\EL_POS_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(7),
      Q => \pos_enc_1[7]\
    );
\EL_POS_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(8),
      Q => \pos_enc_1[8]\
    );
\EL_POS_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => '1',
      CLR => aresetn,
      D => el_temp(9),
      Q => \pos_enc_1[9]\
    );
EL_spi: entity work.user_block2_position_encoder_0_0_ser2bin_spi_0
     port map (
      E(0) => EL_spi_n_0,
      EL_MOSI => EL_MOSI,
      EL_SCK => EL_SCK,
      EL_SSEL => EL_SSEL,
      Q(15) => EL_spi_n_1,
      Q(14) => EL_spi_n_2,
      Q(13) => EL_spi_n_3,
      Q(12) => EL_spi_n_4,
      Q(11) => EL_spi_n_5,
      Q(10) => EL_spi_n_6,
      Q(9) => EL_spi_n_7,
      Q(8) => EL_spi_n_8,
      Q(7) => EL_spi_n_9,
      Q(6) => EL_spi_n_10,
      Q(5) => EL_spi_n_11,
      Q(4) => EL_spi_n_12,
      Q(3) => EL_spi_n_13,
      Q(2) => EL_spi_n_14,
      Q(1) => EL_spi_n_15,
      Q(0) => EL_spi_n_16,
      aclk => aclk
    );
\az_temp_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(0),
      Q => az_temp(0)
    );
\az_temp_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(10),
      Q => az_temp(10)
    );
\az_temp_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(11),
      Q => az_temp(11)
    );
\az_temp_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(12),
      Q => az_temp(12)
    );
\az_temp_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(13),
      Q => az_temp(13)
    );
\az_temp_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(14),
      Q => az_temp(14)
    );
\az_temp_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(15),
      Q => az_temp(15)
    );
\az_temp_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(1),
      Q => az_temp(1)
    );
\az_temp_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(2),
      Q => az_temp(2)
    );
\az_temp_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(3),
      Q => az_temp(3)
    );
\az_temp_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(4),
      Q => az_temp(4)
    );
\az_temp_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(5),
      Q => az_temp(5)
    );
\az_temp_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(6),
      Q => az_temp(6)
    );
\az_temp_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(7),
      Q => az_temp(7)
    );
\az_temp_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(8),
      Q => az_temp(8)
    );
\az_temp_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => do_valid_o_reg,
      CLR => aresetn,
      D => do_buffer_reg(9),
      Q => az_temp(9)
    );
\el_temp_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_16,
      Q => el_temp(0)
    );
\el_temp_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_6,
      Q => el_temp(10)
    );
\el_temp_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_5,
      Q => el_temp(11)
    );
\el_temp_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_4,
      Q => el_temp(12)
    );
\el_temp_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_3,
      Q => el_temp(13)
    );
\el_temp_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_2,
      Q => el_temp(14)
    );
\el_temp_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_1,
      Q => el_temp(15)
    );
\el_temp_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_15,
      Q => el_temp(1)
    );
\el_temp_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_14,
      Q => el_temp(2)
    );
\el_temp_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_13,
      Q => el_temp(3)
    );
\el_temp_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_12,
      Q => el_temp(4)
    );
\el_temp_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_11,
      Q => el_temp(5)
    );
\el_temp_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_10,
      Q => el_temp(6)
    );
\el_temp_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_9,
      Q => el_temp(7)
    );
\el_temp_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_8,
      Q => el_temp(8)
    );
\el_temp_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => aclk,
      CE => EL_spi_n_0,
      CLR => aresetn,
      D => EL_spi_n_7,
      Q => el_temp(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0_position_encoder is
  port (
    pos_enc_0 : out STD_LOGIC_VECTOR ( 18 downto 0 );
    pos_enc_1 : out STD_LOGIC_VECTOR ( 18 downto 0 );
    ctl_reg : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    ROT_A : in STD_LOGIC;
    ROT_B : in STD_LOGIC;
    TILT_B : in STD_LOGIC;
    TILT_A : in STD_LOGIC;
    AZ_SCK : in STD_LOGIC;
    AZ_SSEL : in STD_LOGIC;
    EL_SCK : in STD_LOGIC;
    EL_SSEL : in STD_LOGIC;
    AZ_MOSI : in STD_LOGIC;
    EL_MOSI : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_position_encoder_0_0_position_encoder : entity is "position_encoder";
end user_block2_position_encoder_0_0_position_encoder;

architecture STRUCTURE of user_block2_position_encoder_0_0_position_encoder is
  signal Q2B_n_10 : STD_LOGIC;
  signal Q2B_n_11 : STD_LOGIC;
  signal Q2B_n_12 : STD_LOGIC;
  signal Q2B_n_13 : STD_LOGIC;
  signal Q2B_n_14 : STD_LOGIC;
  signal Q2B_n_15 : STD_LOGIC;
  signal Q2B_n_16 : STD_LOGIC;
  signal Q2B_n_17 : STD_LOGIC;
  signal Q2B_n_18 : STD_LOGIC;
  signal Q2B_n_19 : STD_LOGIC;
  signal Q2B_n_20 : STD_LOGIC;
  signal Q2B_n_21 : STD_LOGIC;
  signal Q2B_n_22 : STD_LOGIC;
  signal Q2B_n_23 : STD_LOGIC;
  signal Q2B_n_24 : STD_LOGIC;
  signal Q2B_n_25 : STD_LOGIC;
  signal Q2B_n_26 : STD_LOGIC;
  signal Q2B_n_27 : STD_LOGIC;
  signal Q2B_n_28 : STD_LOGIC;
  signal Q2B_n_29 : STD_LOGIC;
  signal Q2B_n_30 : STD_LOGIC;
  signal Q2B_n_31 : STD_LOGIC;
  signal Q2B_n_32 : STD_LOGIC;
  signal Q2B_n_33 : STD_LOGIC;
  signal Q2B_n_34 : STD_LOGIC;
  signal Q2B_n_35 : STD_LOGIC;
  signal Q2B_n_36 : STD_LOGIC;
  signal Q2B_n_37 : STD_LOGIC;
  signal Q2B_n_6 : STD_LOGIC;
  signal Q2B_n_7 : STD_LOGIC;
  signal Q2B_n_8 : STD_LOGIC;
  signal Q2B_n_9 : STD_LOGIC;
  signal S2B_n_0 : STD_LOGIC;
  signal S2B_n_1 : STD_LOGIC;
  signal S2B_n_10 : STD_LOGIC;
  signal S2B_n_11 : STD_LOGIC;
  signal S2B_n_12 : STD_LOGIC;
  signal S2B_n_13 : STD_LOGIC;
  signal S2B_n_14 : STD_LOGIC;
  signal S2B_n_15 : STD_LOGIC;
  signal S2B_n_16 : STD_LOGIC;
  signal S2B_n_17 : STD_LOGIC;
  signal S2B_n_18 : STD_LOGIC;
  signal S2B_n_19 : STD_LOGIC;
  signal S2B_n_2 : STD_LOGIC;
  signal S2B_n_20 : STD_LOGIC;
  signal S2B_n_21 : STD_LOGIC;
  signal S2B_n_22 : STD_LOGIC;
  signal S2B_n_23 : STD_LOGIC;
  signal S2B_n_24 : STD_LOGIC;
  signal S2B_n_25 : STD_LOGIC;
  signal S2B_n_26 : STD_LOGIC;
  signal S2B_n_27 : STD_LOGIC;
  signal S2B_n_28 : STD_LOGIC;
  signal S2B_n_29 : STD_LOGIC;
  signal S2B_n_3 : STD_LOGIC;
  signal S2B_n_30 : STD_LOGIC;
  signal S2B_n_31 : STD_LOGIC;
  signal S2B_n_4 : STD_LOGIC;
  signal S2B_n_5 : STD_LOGIC;
  signal S2B_n_6 : STD_LOGIC;
  signal S2B_n_7 : STD_LOGIC;
  signal S2B_n_8 : STD_LOGIC;
  signal S2B_n_9 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \pos_enc_0[0]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \pos_enc_0[10]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \pos_enc_0[11]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \pos_enc_0[12]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \pos_enc_0[13]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \pos_enc_0[14]_INST_0\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \pos_enc_0[15]_INST_0\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \pos_enc_0[1]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \pos_enc_0[2]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \pos_enc_0[3]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \pos_enc_0[4]_INST_0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \pos_enc_0[5]_INST_0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \pos_enc_0[6]_INST_0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \pos_enc_0[7]_INST_0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \pos_enc_0[8]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \pos_enc_0[9]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \pos_enc_1[0]_INST_0\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \pos_enc_1[10]_INST_0\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \pos_enc_1[11]_INST_0\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \pos_enc_1[12]_INST_0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \pos_enc_1[13]_INST_0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \pos_enc_1[14]_INST_0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \pos_enc_1[15]_INST_0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \pos_enc_1[1]_INST_0\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \pos_enc_1[2]_INST_0\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \pos_enc_1[3]_INST_0\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \pos_enc_1[4]_INST_0\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \pos_enc_1[5]_INST_0\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \pos_enc_1[6]_INST_0\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \pos_enc_1[7]_INST_0\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \pos_enc_1[8]_INST_0\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \pos_enc_1[9]_INST_0\ : label is "soft_lutpair28";
begin
Q2B: entity work.user_block2_position_encoder_0_0_QUAD2BIN
     port map (
      ROT_A => ROT_A,
      ROT_B => ROT_B,
      TILT_A => TILT_A,
      TILT_B => TILT_B,
      aclk => aclk,
      aresetn => aresetn,
      ctl_reg(1 downto 0) => ctl_reg(1 downto 0),
      pos_enc_0(2 downto 0) => pos_enc_0(18 downto 16),
      \pos_enc_0[10]\ => Q2B_n_11,
      \pos_enc_0[11]\ => Q2B_n_10,
      \pos_enc_0[12]\ => Q2B_n_9,
      \pos_enc_0[13]\ => Q2B_n_8,
      \pos_enc_0[14]\ => Q2B_n_7,
      \pos_enc_0[15]\ => Q2B_n_6,
      \pos_enc_0[3]\ => Q2B_n_18,
      \pos_enc_0[4]\ => Q2B_n_17,
      \pos_enc_0[5]\ => Q2B_n_16,
      \pos_enc_0[6]\ => Q2B_n_15,
      \pos_enc_0[7]\ => Q2B_n_14,
      \pos_enc_0[8]\ => Q2B_n_13,
      \pos_enc_0[9]\ => Q2B_n_12,
      \pos_enc_0_0__s_port_\ => Q2B_n_21,
      \pos_enc_0_1__s_port_\ => Q2B_n_20,
      \pos_enc_0_2__s_port_\ => Q2B_n_19,
      pos_enc_1(2 downto 0) => pos_enc_1(18 downto 16),
      \pos_enc_1[10]\ => Q2B_n_27,
      \pos_enc_1[11]\ => Q2B_n_26,
      \pos_enc_1[12]\ => Q2B_n_25,
      \pos_enc_1[13]\ => Q2B_n_24,
      \pos_enc_1[14]\ => Q2B_n_23,
      \pos_enc_1[15]\ => Q2B_n_22,
      \pos_enc_1[3]\ => Q2B_n_34,
      \pos_enc_1[4]\ => Q2B_n_33,
      \pos_enc_1[5]\ => Q2B_n_32,
      \pos_enc_1[6]\ => Q2B_n_31,
      \pos_enc_1[7]\ => Q2B_n_30,
      \pos_enc_1[8]\ => Q2B_n_29,
      \pos_enc_1[9]\ => Q2B_n_28,
      \pos_enc_1_0__s_port_\ => Q2B_n_37,
      \pos_enc_1_1__s_port_\ => Q2B_n_36,
      \pos_enc_1_2__s_port_\ => Q2B_n_35
    );
S2B: entity work.user_block2_position_encoder_0_0_ser2bin
     port map (
      AZ_MOSI => AZ_MOSI,
      AZ_SCK => AZ_SCK,
      AZ_SSEL => AZ_SSEL,
      EL_MOSI => EL_MOSI,
      EL_SCK => EL_SCK,
      EL_SSEL => EL_SSEL,
      aclk => aclk,
      aresetn => aresetn,
      \pos_enc_0[0]\ => S2B_n_15,
      \pos_enc_0[10]\ => S2B_n_5,
      \pos_enc_0[11]\ => S2B_n_4,
      \pos_enc_0[12]\ => S2B_n_3,
      \pos_enc_0[13]\ => S2B_n_2,
      \pos_enc_0[14]\ => S2B_n_1,
      \pos_enc_0[15]\ => S2B_n_0,
      \pos_enc_0[1]\ => S2B_n_14,
      \pos_enc_0[2]\ => S2B_n_13,
      \pos_enc_0[3]\ => S2B_n_12,
      \pos_enc_0[4]\ => S2B_n_11,
      \pos_enc_0[5]\ => S2B_n_10,
      \pos_enc_0[6]\ => S2B_n_9,
      \pos_enc_0[7]\ => S2B_n_8,
      \pos_enc_0[8]\ => S2B_n_7,
      \pos_enc_0[9]\ => S2B_n_6,
      \pos_enc_1[0]\ => S2B_n_31,
      \pos_enc_1[10]\ => S2B_n_21,
      \pos_enc_1[11]\ => S2B_n_20,
      \pos_enc_1[12]\ => S2B_n_19,
      \pos_enc_1[13]\ => S2B_n_18,
      \pos_enc_1[14]\ => S2B_n_17,
      \pos_enc_1[15]\ => S2B_n_16,
      \pos_enc_1[1]\ => S2B_n_30,
      \pos_enc_1[2]\ => S2B_n_29,
      \pos_enc_1[3]\ => S2B_n_28,
      \pos_enc_1[4]\ => S2B_n_27,
      \pos_enc_1[5]\ => S2B_n_26,
      \pos_enc_1[6]\ => S2B_n_25,
      \pos_enc_1[7]\ => S2B_n_24,
      \pos_enc_1[8]\ => S2B_n_23,
      \pos_enc_1[9]\ => S2B_n_22
    );
\pos_enc_0[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_15,
      I1 => Q2B_n_21,
      I2 => ctl_reg(0),
      O => pos_enc_0(0)
    );
\pos_enc_0[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_5,
      I1 => Q2B_n_11,
      I2 => ctl_reg(0),
      O => pos_enc_0(10)
    );
\pos_enc_0[11]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_4,
      I1 => Q2B_n_10,
      I2 => ctl_reg(0),
      O => pos_enc_0(11)
    );
\pos_enc_0[12]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_3,
      I1 => Q2B_n_9,
      I2 => ctl_reg(0),
      O => pos_enc_0(12)
    );
\pos_enc_0[13]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_2,
      I1 => Q2B_n_8,
      I2 => ctl_reg(0),
      O => pos_enc_0(13)
    );
\pos_enc_0[14]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_1,
      I1 => Q2B_n_7,
      I2 => ctl_reg(0),
      O => pos_enc_0(14)
    );
\pos_enc_0[15]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_0,
      I1 => Q2B_n_6,
      I2 => ctl_reg(0),
      O => pos_enc_0(15)
    );
\pos_enc_0[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_14,
      I1 => Q2B_n_20,
      I2 => ctl_reg(0),
      O => pos_enc_0(1)
    );
\pos_enc_0[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_13,
      I1 => Q2B_n_19,
      I2 => ctl_reg(0),
      O => pos_enc_0(2)
    );
\pos_enc_0[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_12,
      I1 => Q2B_n_18,
      I2 => ctl_reg(0),
      O => pos_enc_0(3)
    );
\pos_enc_0[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_11,
      I1 => Q2B_n_17,
      I2 => ctl_reg(0),
      O => pos_enc_0(4)
    );
\pos_enc_0[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_10,
      I1 => Q2B_n_16,
      I2 => ctl_reg(0),
      O => pos_enc_0(5)
    );
\pos_enc_0[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_9,
      I1 => Q2B_n_15,
      I2 => ctl_reg(0),
      O => pos_enc_0(6)
    );
\pos_enc_0[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_8,
      I1 => Q2B_n_14,
      I2 => ctl_reg(0),
      O => pos_enc_0(7)
    );
\pos_enc_0[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_7,
      I1 => Q2B_n_13,
      I2 => ctl_reg(0),
      O => pos_enc_0(8)
    );
\pos_enc_0[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_6,
      I1 => Q2B_n_12,
      I2 => ctl_reg(0),
      O => pos_enc_0(9)
    );
\pos_enc_1[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_31,
      I1 => Q2B_n_37,
      I2 => ctl_reg(0),
      O => pos_enc_1(0)
    );
\pos_enc_1[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_21,
      I1 => Q2B_n_27,
      I2 => ctl_reg(0),
      O => pos_enc_1(10)
    );
\pos_enc_1[11]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_20,
      I1 => Q2B_n_26,
      I2 => ctl_reg(0),
      O => pos_enc_1(11)
    );
\pos_enc_1[12]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_19,
      I1 => Q2B_n_25,
      I2 => ctl_reg(0),
      O => pos_enc_1(12)
    );
\pos_enc_1[13]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_18,
      I1 => Q2B_n_24,
      I2 => ctl_reg(0),
      O => pos_enc_1(13)
    );
\pos_enc_1[14]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_17,
      I1 => Q2B_n_23,
      I2 => ctl_reg(0),
      O => pos_enc_1(14)
    );
\pos_enc_1[15]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_16,
      I1 => Q2B_n_22,
      I2 => ctl_reg(0),
      O => pos_enc_1(15)
    );
\pos_enc_1[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_30,
      I1 => Q2B_n_36,
      I2 => ctl_reg(0),
      O => pos_enc_1(1)
    );
\pos_enc_1[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_29,
      I1 => Q2B_n_35,
      I2 => ctl_reg(0),
      O => pos_enc_1(2)
    );
\pos_enc_1[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_28,
      I1 => Q2B_n_34,
      I2 => ctl_reg(0),
      O => pos_enc_1(3)
    );
\pos_enc_1[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_27,
      I1 => Q2B_n_33,
      I2 => ctl_reg(0),
      O => pos_enc_1(4)
    );
\pos_enc_1[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_26,
      I1 => Q2B_n_32,
      I2 => ctl_reg(0),
      O => pos_enc_1(5)
    );
\pos_enc_1[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_25,
      I1 => Q2B_n_31,
      I2 => ctl_reg(0),
      O => pos_enc_1(6)
    );
\pos_enc_1[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_24,
      I1 => Q2B_n_30,
      I2 => ctl_reg(0),
      O => pos_enc_1(7)
    );
\pos_enc_1[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_23,
      I1 => Q2B_n_29,
      I2 => ctl_reg(0),
      O => pos_enc_1(8)
    );
\pos_enc_1[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => S2B_n_22,
      I1 => Q2B_n_28,
      I2 => ctl_reg(0),
      O => pos_enc_1(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_position_encoder_0_0 is
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of user_block2_position_encoder_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of user_block2_position_encoder_0_0 : entity is "user_block2_position_encoder_0_0,position_encoder,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of user_block2_position_encoder_0_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of user_block2_position_encoder_0_0 : entity is "position_encoder,Vivado 2017.2";
end user_block2_position_encoder_0_0;

architecture STRUCTURE of user_block2_position_encoder_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^pos_enc_0\ : STD_LOGIC_VECTOR ( 18 downto 0 );
  signal \^pos_enc_1\ : STD_LOGIC_VECTOR ( 18 downto 0 );
begin
  pos_enc_0(31) <= \<const0>\;
  pos_enc_0(30) <= \<const0>\;
  pos_enc_0(29) <= \<const0>\;
  pos_enc_0(28) <= \<const0>\;
  pos_enc_0(27) <= \<const0>\;
  pos_enc_0(26) <= \<const0>\;
  pos_enc_0(25) <= \<const0>\;
  pos_enc_0(24) <= \<const0>\;
  pos_enc_0(23) <= \<const0>\;
  pos_enc_0(22) <= \<const0>\;
  pos_enc_0(21) <= \<const0>\;
  pos_enc_0(20) <= \<const0>\;
  pos_enc_0(19) <= \<const0>\;
  pos_enc_0(18 downto 0) <= \^pos_enc_0\(18 downto 0);
  pos_enc_1(31) <= \<const0>\;
  pos_enc_1(30) <= \<const0>\;
  pos_enc_1(29) <= \<const0>\;
  pos_enc_1(28) <= \<const0>\;
  pos_enc_1(27) <= \<const0>\;
  pos_enc_1(26) <= \<const0>\;
  pos_enc_1(25) <= \<const0>\;
  pos_enc_1(24) <= \<const0>\;
  pos_enc_1(23) <= \<const0>\;
  pos_enc_1(22) <= \<const0>\;
  pos_enc_1(21) <= \<const0>\;
  pos_enc_1(20) <= \<const0>\;
  pos_enc_1(19) <= \<const0>\;
  pos_enc_1(18 downto 0) <= \^pos_enc_1\(18 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
U0: entity work.user_block2_position_encoder_0_0_position_encoder
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
      aclk => aclk,
      aresetn => aresetn,
      ctl_reg(1 downto 0) => ctl_reg(1 downto 0),
      pos_enc_0(18 downto 0) => \^pos_enc_0\(18 downto 0),
      pos_enc_1(18 downto 0) => \^pos_enc_1\(18 downto 0)
    );
end STRUCTURE;
