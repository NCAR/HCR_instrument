-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
-- Date        : Fri May 12 15:44:48 2017
-- Host        : Rich-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Pentek/IP/2017.1/wip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/px_8chddcs1_winrom_g/px_8chddcs1_winrom_g_stub.vhdl
-- Design      : px_8chddcs1_winrom_g
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1517-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_8chddcs1_winrom_g is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 3 downto 0 );
    clk : in STD_LOGIC;
    qspo : out STD_LOGIC_VECTOR ( 17 downto 0 )
  );

end px_8chddcs1_winrom_g;

architecture stub of px_8chddcs1_winrom_g is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[3:0],clk,qspo[17:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_11,Vivado 2017.1";
begin
end;
