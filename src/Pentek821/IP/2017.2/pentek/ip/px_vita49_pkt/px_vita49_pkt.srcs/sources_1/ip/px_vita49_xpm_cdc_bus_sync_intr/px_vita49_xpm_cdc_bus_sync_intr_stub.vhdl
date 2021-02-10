-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2.1 (win64) Build 1957588 Wed Aug  9 16:32:24 MDT 2017
-- Date        : Thu Oct 26 16:19:56 2017
-- Host        : Mike-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/pentek/ip/2017.2/wip/px_vita49_pkt/px_vita49_pkt.srcs/sources_1/ip/px_vita49_xpm_cdc_bus_sync_intr/px_vita49_xpm_cdc_bus_sync_intr_stub.vhdl
-- Design      : px_vita49_xpm_cdc_bus_sync_intr
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku035-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_vita49_xpm_cdc_bus_sync_intr is
  Port ( 
    src_clk : in STD_LOGIC;
    src_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    dest_clk : in STD_LOGIC;
    dest_out : out STD_LOGIC_VECTOR ( 5 downto 0 )
  );

end px_vita49_xpm_cdc_bus_sync_intr;

architecture stub of px_vita49_xpm_cdc_bus_sync_intr is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "src_clk,src_in[5:0],dest_clk,dest_out[5:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "px_xpm_cdc_bus_sync,Vivado 2017.2.1";
begin
end;
