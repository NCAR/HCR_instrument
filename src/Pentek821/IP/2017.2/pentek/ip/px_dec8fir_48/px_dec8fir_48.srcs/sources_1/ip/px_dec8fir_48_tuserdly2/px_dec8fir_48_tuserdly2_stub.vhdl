-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
-- Date        : Fri Nov 11 08:11:58 2016
-- Host        : Rich-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Nav/IP/2016.3/pentek/ip/px_dec8fir_48/px_dec8fir_48.srcs/sources_1/ip/px_dec8fir_48_tuserdly2/px_dec8fir_48_tuserdly2_stub.vhdl
-- Design      : px_dec8fir_48_tuserdly2
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_dec8fir_48_tuserdly2 is
  Port ( 
    D : in STD_LOGIC_VECTOR ( 127 downto 0 );
    CLK : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );

end px_dec8fir_48_tuserdly2;

architecture stub of px_dec8fir_48_tuserdly2 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "D[127:0],CLK,Q[127:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "c_shift_ram_v12_0_10,Vivado 2016.3";
begin
end;
