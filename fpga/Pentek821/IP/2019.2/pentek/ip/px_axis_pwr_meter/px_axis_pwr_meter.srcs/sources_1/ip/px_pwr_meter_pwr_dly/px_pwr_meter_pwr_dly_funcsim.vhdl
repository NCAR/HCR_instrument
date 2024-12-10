-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
-- Date        : Sun May 17 15:01:14 2015
-- Host        : Igor running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               e:/px_ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_pwr_dly/px_pwr_meter_pwr_dly_funcsim.vhdl
-- Design      : px_pwr_meter_pwr_dly
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku060-ffva1517-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_pwr_meter_pwr_dly_px_vctr_dly is
  port (
    dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of px_pwr_meter_pwr_dly_px_vctr_dly : entity is "px_vctr_dly";
end px_pwr_meter_pwr_dly_px_vctr_dly;

architecture STRUCTURE of px_pwr_meter_pwr_dly_px_vctr_dly is
  signal \gen_gt1.dly_array_reg[1][0]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][10]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][11]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][12]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][13]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][14]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][15]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][16]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][17]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][18]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][19]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][1]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][20]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][21]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][22]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][23]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][24]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][25]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][26]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][27]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][28]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][29]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][2]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][30]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][31]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][3]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][4]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][5]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][6]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][7]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][8]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg[1][9]_srl16_n_0\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][0]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][10]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][11]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][12]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][13]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][14]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][15]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][16]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][17]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][18]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][19]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][1]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][20]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][21]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][22]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][23]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][24]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][25]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][26]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][27]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][28]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][29]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][2]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][30]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][31]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][3]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][4]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][5]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][6]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][7]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][8]\ : STD_LOGIC;
  signal \gen_gt1.dly_array_reg_n_0_[17][9]\ : STD_LOGIC;
  attribute srl_bus_name : string;
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][0]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name : string;
  attribute srl_name of \gen_gt1.dly_array_reg[1][0]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][0]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][10]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][10]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][10]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][11]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][11]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][11]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][12]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][12]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][12]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][13]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][13]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][13]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][14]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][14]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][14]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][15]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][15]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][15]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][16]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][16]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][16]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][17]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][17]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][17]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][18]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][18]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][18]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][19]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][19]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][19]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][1]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][1]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][1]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][20]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][20]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][20]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][21]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][21]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][21]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][22]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][22]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][22]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][23]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][23]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][23]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][24]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][24]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][24]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][25]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][25]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][25]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][26]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][26]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][26]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][27]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][27]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][27]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][28]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][28]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][28]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][29]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][29]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][29]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][2]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][2]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][2]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][30]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][30]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][30]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][31]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][31]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][31]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][3]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][3]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][3]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][4]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][4]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][4]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][5]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][5]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][5]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][6]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][6]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][6]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][7]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][7]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][7]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][8]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][8]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][8]_srl16 ";
  attribute srl_bus_name of \gen_gt1.dly_array_reg[1][9]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1] ";
  attribute srl_name of \gen_gt1.dly_array_reg[1][9]_srl16\ : label is "\U0/gen_gt1.dly_array_reg[1][9]_srl16 ";
begin
\gen_gt1.dly_array_reg[0][0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][0]_srl16_n_0\,
      Q => dout(0),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][10]_srl16_n_0\,
      Q => dout(10),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][11]_srl16_n_0\,
      Q => dout(11),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][12]_srl16_n_0\,
      Q => dout(12),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][13]_srl16_n_0\,
      Q => dout(13),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][14]_srl16_n_0\,
      Q => dout(14),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][15]_srl16_n_0\,
      Q => dout(15),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][16]_srl16_n_0\,
      Q => dout(16),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][17]_srl16_n_0\,
      Q => dout(17),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][18]_srl16_n_0\,
      Q => dout(18),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][19]_srl16_n_0\,
      Q => dout(19),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][1]_srl16_n_0\,
      Q => dout(1),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][20]_srl16_n_0\,
      Q => dout(20),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][21]_srl16_n_0\,
      Q => dout(21),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][22]_srl16_n_0\,
      Q => dout(22),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][23]_srl16_n_0\,
      Q => dout(23),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][24]_srl16_n_0\,
      Q => dout(24),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][25]_srl16_n_0\,
      Q => dout(25),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][26]_srl16_n_0\,
      Q => dout(26),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][27]_srl16_n_0\,
      Q => dout(27),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][28]_srl16_n_0\,
      Q => dout(28),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][29]_srl16_n_0\,
      Q => dout(29),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][2]_srl16_n_0\,
      Q => dout(2),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][30]_srl16_n_0\,
      Q => dout(30),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][31]_srl16_n_0\,
      Q => dout(31),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][3]_srl16_n_0\,
      Q => dout(3),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][4]_srl16_n_0\,
      Q => dout(4),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][5]_srl16_n_0\,
      Q => dout(5),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][6]_srl16_n_0\,
      Q => dout(6),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][7]_srl16_n_0\,
      Q => dout(7),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][8]_srl16_n_0\,
      Q => dout(8),
      R => '0'
    );
\gen_gt1.dly_array_reg[0][9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \gen_gt1.dly_array_reg[1][9]_srl16_n_0\,
      Q => dout(9),
      R => '0'
    );
\gen_gt1.dly_array_reg[17][0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(0),
      Q => \gen_gt1.dly_array_reg_n_0_[17][0]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(10),
      Q => \gen_gt1.dly_array_reg_n_0_[17][10]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(11),
      Q => \gen_gt1.dly_array_reg_n_0_[17][11]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(12),
      Q => \gen_gt1.dly_array_reg_n_0_[17][12]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(13),
      Q => \gen_gt1.dly_array_reg_n_0_[17][13]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(14),
      Q => \gen_gt1.dly_array_reg_n_0_[17][14]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(15),
      Q => \gen_gt1.dly_array_reg_n_0_[17][15]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(16),
      Q => \gen_gt1.dly_array_reg_n_0_[17][16]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(17),
      Q => \gen_gt1.dly_array_reg_n_0_[17][17]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(18),
      Q => \gen_gt1.dly_array_reg_n_0_[17][18]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(19),
      Q => \gen_gt1.dly_array_reg_n_0_[17][19]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(1),
      Q => \gen_gt1.dly_array_reg_n_0_[17][1]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(20),
      Q => \gen_gt1.dly_array_reg_n_0_[17][20]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(21),
      Q => \gen_gt1.dly_array_reg_n_0_[17][21]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(22),
      Q => \gen_gt1.dly_array_reg_n_0_[17][22]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(23),
      Q => \gen_gt1.dly_array_reg_n_0_[17][23]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(24),
      Q => \gen_gt1.dly_array_reg_n_0_[17][24]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(25),
      Q => \gen_gt1.dly_array_reg_n_0_[17][25]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(26),
      Q => \gen_gt1.dly_array_reg_n_0_[17][26]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(27),
      Q => \gen_gt1.dly_array_reg_n_0_[17][27]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(28),
      Q => \gen_gt1.dly_array_reg_n_0_[17][28]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(29),
      Q => \gen_gt1.dly_array_reg_n_0_[17][29]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(2),
      Q => \gen_gt1.dly_array_reg_n_0_[17][2]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(30),
      Q => \gen_gt1.dly_array_reg_n_0_[17][30]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(31),
      Q => \gen_gt1.dly_array_reg_n_0_[17][31]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(3),
      Q => \gen_gt1.dly_array_reg_n_0_[17][3]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(4),
      Q => \gen_gt1.dly_array_reg_n_0_[17][4]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(5),
      Q => \gen_gt1.dly_array_reg_n_0_[17][5]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(6),
      Q => \gen_gt1.dly_array_reg_n_0_[17][6]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(7),
      Q => \gen_gt1.dly_array_reg_n_0_[17][7]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(8),
      Q => \gen_gt1.dly_array_reg_n_0_[17][8]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[17][9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => din(9),
      Q => \gen_gt1.dly_array_reg_n_0_[17][9]\,
      R => '0'
    );
\gen_gt1.dly_array_reg[1][0]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][0]\,
      Q => \gen_gt1.dly_array_reg[1][0]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][10]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][10]\,
      Q => \gen_gt1.dly_array_reg[1][10]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][11]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][11]\,
      Q => \gen_gt1.dly_array_reg[1][11]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][12]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][12]\,
      Q => \gen_gt1.dly_array_reg[1][12]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][13]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][13]\,
      Q => \gen_gt1.dly_array_reg[1][13]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][14]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][14]\,
      Q => \gen_gt1.dly_array_reg[1][14]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][15]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][15]\,
      Q => \gen_gt1.dly_array_reg[1][15]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][16]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][16]\,
      Q => \gen_gt1.dly_array_reg[1][16]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][17]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][17]\,
      Q => \gen_gt1.dly_array_reg[1][17]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][18]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][18]\,
      Q => \gen_gt1.dly_array_reg[1][18]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][19]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][19]\,
      Q => \gen_gt1.dly_array_reg[1][19]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][1]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][1]\,
      Q => \gen_gt1.dly_array_reg[1][1]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][20]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][20]\,
      Q => \gen_gt1.dly_array_reg[1][20]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][21]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][21]\,
      Q => \gen_gt1.dly_array_reg[1][21]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][22]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][22]\,
      Q => \gen_gt1.dly_array_reg[1][22]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][23]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][23]\,
      Q => \gen_gt1.dly_array_reg[1][23]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][24]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][24]\,
      Q => \gen_gt1.dly_array_reg[1][24]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][25]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][25]\,
      Q => \gen_gt1.dly_array_reg[1][25]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][26]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][26]\,
      Q => \gen_gt1.dly_array_reg[1][26]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][27]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][27]\,
      Q => \gen_gt1.dly_array_reg[1][27]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][28]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][28]\,
      Q => \gen_gt1.dly_array_reg[1][28]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][29]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][29]\,
      Q => \gen_gt1.dly_array_reg[1][29]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][2]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][2]\,
      Q => \gen_gt1.dly_array_reg[1][2]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][30]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][30]\,
      Q => \gen_gt1.dly_array_reg[1][30]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][31]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][31]\,
      Q => \gen_gt1.dly_array_reg[1][31]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][3]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][3]\,
      Q => \gen_gt1.dly_array_reg[1][3]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][4]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][4]\,
      Q => \gen_gt1.dly_array_reg[1][4]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][5]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][5]\,
      Q => \gen_gt1.dly_array_reg[1][5]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][6]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][6]\,
      Q => \gen_gt1.dly_array_reg[1][6]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][7]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][7]\,
      Q => \gen_gt1.dly_array_reg[1][7]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][8]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][8]\,
      Q => \gen_gt1.dly_array_reg[1][8]_srl16_n_0\
    );
\gen_gt1.dly_array_reg[1][9]_srl16\: unisim.vcomponents.SRL16E
     port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => clk,
      D => \gen_gt1.dly_array_reg_n_0_[17][9]\,
      Q => \gen_gt1.dly_array_reg[1][9]_srl16_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_pwr_meter_pwr_dly is
  port (
    clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dout : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of px_pwr_meter_pwr_dly : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of px_pwr_meter_pwr_dly : entity is "px_pwr_meter_pwr_dly,px_vctr_dly,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of px_pwr_meter_pwr_dly : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of px_pwr_meter_pwr_dly : entity is "px_vctr_dly,Vivado 2015.1";
end px_pwr_meter_pwr_dly;

architecture STRUCTURE of px_pwr_meter_pwr_dly is
begin
U0: entity work.px_pwr_meter_pwr_dly_px_vctr_dly
     port map (
      clk => clk,
      din(31 downto 0) => din(31 downto 0),
      dout(31 downto 0) => dout(31 downto 0)
    );
end STRUCTURE;
