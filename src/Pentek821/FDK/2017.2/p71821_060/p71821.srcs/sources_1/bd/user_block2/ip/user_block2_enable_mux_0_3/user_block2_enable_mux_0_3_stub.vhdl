-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Tue Apr 27 22:17:07 2021
-- Host        : wind running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_enable_mux_0_3/user_block2_enable_mux_0_3_stub.vhdl
-- Design      : user_block2_enable_mux_0_3
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity user_block2_enable_mux_0_3 is
  Port ( 
    EN : in STD_LOGIC;
    I : in STD_LOGIC_VECTOR ( 31 downto 0 );
    O : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end user_block2_enable_mux_0_3;

architecture stub of user_block2_enable_mux_0_3 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "EN,I[31:0],O[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "enable_mux,Vivado 2017.2";
begin
end;
