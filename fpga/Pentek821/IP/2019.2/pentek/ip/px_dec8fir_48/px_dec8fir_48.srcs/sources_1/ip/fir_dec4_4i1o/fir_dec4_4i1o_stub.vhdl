-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
-- Date        : Thu May 05 15:21:53 2016
-- Host        : Rich-PC running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Xilinx/Vivado/2016.1/data/ip/pentek/ip/px_dec8fir_48/px_dec8fir_48.srcs/sources_1/ip/fir_dec4_4i1o/fir_dec4_4i1o_stub.vhdl
-- Design      : fir_dec4_4i1o
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fir_dec4_4i1o is
  Port ( 
    aclk : in STD_LOGIC;
    s_axis_data_tvalid : in STD_LOGIC;
    s_axis_data_tready : out STD_LOGIC;
    s_axis_data_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_data_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_config_tvalid : in STD_LOGIC;
    s_axis_config_tready : out STD_LOGIC;
    s_axis_config_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_data_tvalid : out STD_LOGIC;
    m_axis_data_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_data_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );

end fir_dec4_4i1o;

architecture stub of fir_dec4_4i1o is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,s_axis_data_tvalid,s_axis_data_tready,s_axis_data_tuser[127:0],s_axis_data_tdata[63:0],s_axis_config_tvalid,s_axis_config_tready,s_axis_config_tdata[7:0],m_axis_data_tvalid,m_axis_data_tuser[127:0],m_axis_data_tdata[15:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fir_compiler_v7_2_6,Vivado 2016.1";
begin
end;
