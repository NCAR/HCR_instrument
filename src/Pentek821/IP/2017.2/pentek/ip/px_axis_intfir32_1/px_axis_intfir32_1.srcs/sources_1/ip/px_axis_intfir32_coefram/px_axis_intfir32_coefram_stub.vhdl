-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
-- Date        : Fri Jan 13 14:53:24 2017
-- Host        : Rich-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Pentek/IP/2016.4/pentek/ip/px_axis_intfir32_1/px_axis_intfir32_1.srcs/sources_1/ip/px_axis_intfir32_coefram/px_axis_intfir32_coefram_stub.vhdl
-- Design      : px_axis_intfir32_coefram
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1517-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_axis_intfir32_coefram is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 4 downto 0 );
    d : in STD_LOGIC_VECTOR ( 23 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 4 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    qdpo_ce : in STD_LOGIC;
    qdpo_clk : in STD_LOGIC;
    qdpo : out STD_LOGIC_VECTOR ( 23 downto 0 )
  );

end px_axis_intfir32_coefram;

architecture stub of px_axis_intfir32_coefram is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[4:0],d[23:0],dpra[4:0],clk,we,qdpo_ce,qdpo_clk,qdpo[23:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_11,Vivado 2016.4";
begin
end;
