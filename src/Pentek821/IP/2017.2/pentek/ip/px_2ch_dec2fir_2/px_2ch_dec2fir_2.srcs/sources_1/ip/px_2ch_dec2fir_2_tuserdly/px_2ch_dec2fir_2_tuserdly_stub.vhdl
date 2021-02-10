-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
-- Date        : Fri Jan 20 13:45:01 2017
-- Host        : Rich-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Pentek/IP/2016.4/wip/px_2ch_dec2fir_2/px_2ch_dec2fir_2.srcs/sources_1/ip/px_2ch_dec2fir_2_tuserdly/px_2ch_dec2fir_2_tuserdly_stub.vhdl
-- Design      : px_2ch_dec2fir_2_tuserdly
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_2ch_dec2fir_2_tuserdly is
  Port ( 
    D : in STD_LOGIC_VECTOR ( 127 downto 0 );
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );

end px_2ch_dec2fir_2_tuserdly;

architecture stub of px_2ch_dec2fir_2_tuserdly is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "D[127:0],CLK,CE,Q[127:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "c_shift_ram_v12_0_10,Vivado 2016.4";
begin
end;
