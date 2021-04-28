-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Tue Apr 27 22:17:07 2021
-- Host        : wind running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_enable_mux_0_3/user_block2_enable_mux_0_3_sim_netlist.vhdl
-- Design      : user_block2_enable_mux_0_3
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_enable_mux_0_3 is
  port (
    EN : in STD_LOGIC;
    I : in STD_LOGIC_VECTOR ( 31 downto 0 );
    O : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of user_block2_enable_mux_0_3 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of user_block2_enable_mux_0_3 : entity is "user_block2_enable_mux_0_3,enable_mux,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of user_block2_enable_mux_0_3 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of user_block2_enable_mux_0_3 : entity is "enable_mux,Vivado 2017.2";
end user_block2_enable_mux_0_3;

architecture STRUCTURE of user_block2_enable_mux_0_3 is
begin
\O[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(0),
      O => O(0)
    );
\O[10]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(10),
      O => O(10)
    );
\O[11]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(11),
      O => O(11)
    );
\O[12]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(12),
      O => O(12)
    );
\O[13]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(13),
      O => O(13)
    );
\O[14]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(14),
      O => O(14)
    );
\O[15]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(15),
      O => O(15)
    );
\O[16]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(16),
      O => O(16)
    );
\O[17]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(17),
      O => O(17)
    );
\O[18]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(18),
      O => O(18)
    );
\O[19]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(19),
      O => O(19)
    );
\O[1]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(1),
      O => O(1)
    );
\O[20]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(20),
      O => O(20)
    );
\O[21]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(21),
      O => O(21)
    );
\O[22]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(22),
      O => O(22)
    );
\O[23]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(23),
      O => O(23)
    );
\O[24]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(24),
      O => O(24)
    );
\O[25]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(25),
      O => O(25)
    );
\O[26]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(26),
      O => O(26)
    );
\O[27]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(27),
      O => O(27)
    );
\O[28]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(28),
      O => O(28)
    );
\O[29]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(29),
      O => O(29)
    );
\O[2]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(2),
      O => O(2)
    );
\O[30]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(30),
      O => O(30)
    );
\O[31]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(31),
      O => O(31)
    );
\O[3]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(3),
      O => O(3)
    );
\O[4]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(4),
      O => O(4)
    );
\O[5]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(5),
      O => O(5)
    );
\O[6]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(6),
      O => O(6)
    );
\O[7]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(7),
      O => O(7)
    );
\O[8]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(8),
      O => O(8)
    );
\O[9]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(9),
      O => O(9)
    );
end STRUCTURE;
