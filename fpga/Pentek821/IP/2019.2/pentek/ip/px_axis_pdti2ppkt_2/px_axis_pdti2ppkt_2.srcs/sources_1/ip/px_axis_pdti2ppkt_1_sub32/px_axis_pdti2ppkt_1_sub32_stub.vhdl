-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
-- Date        : Tue Nov 01 09:41:09 2016
-- Host        : Rich-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Xilinx/Vivado/2016.3/data/ip/pentek/ip/px_axis_pdti2ppkt_1/px_axis_pdti2ppkt_1.srcs/sources_1/ip/px_axis_pdti2ppkt_1_sub32/px_axis_pdti2ppkt_1_sub32_stub.vhdl
-- Design      : px_axis_pdti2ppkt_1_sub32
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_axis_pdti2ppkt_1_sub32 is
  Port ( 
    CLK : in STD_LOGIC;
    C : in STD_LOGIC_VECTOR ( 31 downto 0 );
    CONCAT : in STD_LOGIC_VECTOR ( 31 downto 0 );
    P : out STD_LOGIC_VECTOR ( 32 downto 0 )
  );

end px_axis_pdti2ppkt_1_sub32;

architecture stub of px_axis_pdti2ppkt_1_sub32 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,C[31:0],CONCAT[31:0],P[32:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "xbip_dsp48_macro_v3_0_13,Vivado 2016.3";
begin
end;