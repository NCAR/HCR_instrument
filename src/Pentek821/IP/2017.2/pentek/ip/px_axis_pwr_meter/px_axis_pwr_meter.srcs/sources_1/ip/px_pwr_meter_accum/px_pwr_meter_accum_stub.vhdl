-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
-- Date        : Tue Nov 01 21:27:57 2016
-- Host        : Igor2 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Xilinx/Vivado/2016.3/data/ip/pentek/ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_accum/px_pwr_meter_accum_stub.vhdl
-- Design      : px_pwr_meter_accum
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_pwr_meter_accum is
  Port ( 
    B : in STD_LOGIC_VECTOR ( 32 downto 0 );
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    BYPASS : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 35 downto 0 )
  );

end px_pwr_meter_accum;

architecture stub of px_pwr_meter_accum is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "B[32:0],CLK,CE,BYPASS,Q[35:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "c_accum_v12_0_10,Vivado 2016.3";
begin
end;
