-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Tue Apr 27 22:17:07 2021
-- Host        : wind running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_enable_mux_0_2/user_block2_enable_mux_0_2_sim_netlist.vhdl
-- Design      : user_block2_enable_mux_0_2
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_enable_mux_0_2 is
  port (
    EN : in STD_LOGIC;
    I : in STD_LOGIC_VECTOR ( 7 downto 0 );
    O : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of user_block2_enable_mux_0_2 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of user_block2_enable_mux_0_2 : entity is "user_block2_enable_mux_0_2,enable_mux,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of user_block2_enable_mux_0_2 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of user_block2_enable_mux_0_2 : entity is "enable_mux,Vivado 2017.2";
end user_block2_enable_mux_0_2;

architecture STRUCTURE of user_block2_enable_mux_0_2 is
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
\O[1]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => EN,
      I1 => I(1),
      O => O(1)
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
end STRUCTURE;
