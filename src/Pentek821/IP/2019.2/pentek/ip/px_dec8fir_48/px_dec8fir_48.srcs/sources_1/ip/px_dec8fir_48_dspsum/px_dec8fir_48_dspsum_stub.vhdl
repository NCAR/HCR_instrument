-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sun Jun  9 07:09:42 2019
-- Host        : Igor2 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Pentek/IP/2019.1/pentek/ip/px_dec8fir_48/px_dec8fir_48.srcs/sources_1/ip/px_dec8fir_48_dspsum/px_dec8fir_48_dspsum_stub.vhdl
-- Design      : px_dec8fir_48_dspsum
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_dec8fir_48_dspsum is
  Port ( 
    CLK : in STD_LOGIC;
    A : in STD_LOGIC_VECTOR ( 26 downto 0 );
    D : in STD_LOGIC_VECTOR ( 26 downto 0 );
    P : out STD_LOGIC_VECTOR ( 26 downto 0 )
  );

end px_dec8fir_48_dspsum;

architecture stub of px_dec8fir_48_dspsum is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,A[26:0],D[26:0],P[26:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "xbip_dsp48_macro_v3_0_17,Vivado 2019.1";
begin
end;