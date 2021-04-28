-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2700185 Thu Oct 24 18:46:05 MDT 2019
-- Date        : Thu May  7 06:05:42 2020
-- Host        : Rich-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Pentek/IP/2019.2/pentek/ip/px_axis_pdti2ppkt_16/px_axis_pdti2ppkt_16.srcs/sources_1/ip/px_axis_pdti2ppkt_16_wc/px_axis_pdti2ppkt_16_wc_stub.vhdl
-- Design      : px_axis_pdti2ppkt_16_wc
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_axis_pdti2ppkt_16_wc is
  Port ( 
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 )
  );

end px_axis_pdti2ppkt_16_wc;

architecture stub of px_axis_pdti2ppkt_16_wc is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,aresetn,s_axis_tvalid,s_axis_tready,s_axis_tdata[127:0],s_axis_tuser[127:0],m_axis_tvalid,m_axis_tready,m_axis_tdata[255:0],m_axis_tuser[255:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "axis_dwidth_converter_v1_1_19_axis_dwidth_converter,Vivado 2019.2";
begin
end;
