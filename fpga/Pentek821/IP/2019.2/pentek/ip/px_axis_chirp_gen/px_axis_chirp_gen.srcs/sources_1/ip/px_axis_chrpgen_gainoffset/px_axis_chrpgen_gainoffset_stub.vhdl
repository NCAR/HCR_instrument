-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sat Jun  8 09:53:19 2019
-- Host        : Igor2 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Pentek/IP/2019.1/pentek/ip/px_axis_chirp_gen/px_axis_chirp_gen.srcs/sources_1/ip/px_axis_chrpgen_gainoffset/px_axis_chrpgen_gainoffset_stub.vhdl
-- Design      : px_axis_chrpgen_gainoffset
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku11p-ffva1156-1-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_axis_chrpgen_gainoffset is
  Port ( 
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    A : in STD_LOGIC_VECTOR ( 15 downto 0 );
    B : in STD_LOGIC_VECTOR ( 16 downto 0 );
    D : in STD_LOGIC_VECTOR ( 15 downto 0 );
    P : out STD_LOGIC_VECTOR ( 17 downto 0 )
  );

end px_axis_chrpgen_gainoffset;

architecture stub of px_axis_chrpgen_gainoffset is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,CE,A[15:0],B[16:0],D[15:0],P[17:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "xbip_dsp48_macro_v3_0_17,Vivado 2019.1";
begin
end;
