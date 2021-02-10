-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2.1 (win64) Build 1957588 Wed Aug  9 16:32:24 MDT 2017
-- Date        : Thu Oct 26 16:19:12 2017
-- Host        : Mike-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/pentek/ip/2017.2/wip/px_vita49_pkt/px_vita49_pkt.srcs/sources_1/ip/px_vita49_pkt_ppkt_upsizer/px_vita49_pkt_ppkt_upsizer_stub.vhdl
-- Design      : px_vita49_pkt_ppkt_upsizer
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku035-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_vita49_pkt_ppkt_upsizer is
  Port ( 
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_ppkt_tvalid : in STD_LOGIC;
    s_axis_ppkt_tready : out STD_LOGIC;
    s_axis_ppkt_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_ppkt_tuser : in STD_LOGIC_VECTOR ( 79 downto 0 );
    s_axis_ppkt_tkeep : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_ppkt_tlast : in STD_LOGIC;
    m_axis_ppkt_tvalid : out STD_LOGIC;
    m_axis_ppkt_tready : in STD_LOGIC;
    m_axis_ppkt_tdata : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_ppkt_tuser : out STD_LOGIC_VECTOR ( 79 downto 0 );
    m_axis_ppkt_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_ppkt_tlast : out STD_LOGIC
  );

end px_vita49_pkt_ppkt_upsizer;

architecture stub of px_vita49_pkt_ppkt_upsizer is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,aresetn,s_axis_ppkt_tvalid,s_axis_ppkt_tready,s_axis_ppkt_tdata[31:0],s_axis_ppkt_tuser[79:0],s_axis_ppkt_tkeep[1:0],s_axis_ppkt_tlast,m_axis_ppkt_tvalid,m_axis_ppkt_tready,m_axis_ppkt_tdata[255:0],m_axis_ppkt_tuser[79:0],m_axis_ppkt_tkeep[15:0],m_axis_ppkt_tlast";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "px_ppkt_width_upsizer,Vivado 2017.2.1";
begin
end;
