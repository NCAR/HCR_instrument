-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
-- Date        : Mon May  8 09:05:27 2017
-- Host        : Mike-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top px_10ge_udp_tx_multi8 -prefix
--               px_10ge_udp_tx_multi8_ px_10ge_udp_tx_multi8_sim_netlist.vhdl
-- Design      : px_10ge_udp_tx_multi8
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_10ge_udp_tx_multi8 is
  port (
    A : in STD_LOGIC_VECTOR ( 15 downto 0 );
    P : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of px_10ge_udp_tx_multi8 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of px_10ge_udp_tx_multi8 : entity is "px_10ge_udp_tx_multi8,mult_gen_v12_0_12,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of px_10ge_udp_tx_multi8 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of px_10ge_udp_tx_multi8 : entity is "mult_gen_v12_0_12,Vivado 2017.1";
end px_10ge_udp_tx_multi8;

architecture STRUCTURE of px_10ge_udp_tx_multi8 is
  signal \<const0>\ : STD_LOGIC;
  signal \^a\ : STD_LOGIC_VECTOR ( 15 downto 0 );
begin
  P(15 downto 3) <= \^a\(12 downto 0);
  P(2) <= \<const0>\;
  P(1) <= \<const0>\;
  P(0) <= \<const0>\;
  \^a\(12 downto 0) <= A(12 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
end STRUCTURE;
