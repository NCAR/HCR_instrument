-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sun Jun  9 09:10:30 2019
-- Host        : Igor2 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Pentek/IP/2019.1/pentek/ip/px_timestamp_gen_sgate/px_timestamp_gen_sgate.srcs/sources_1/ip/px_timestamp_gen_dsp48accl/px_timestamp_gen_dsp48accl_stub.vhdl
-- Design      : px_timestamp_gen_dsp48accl
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1517-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_timestamp_gen_dsp48accl is
  Port ( 
    CLK : in STD_LOGIC;
    SEL : in STD_LOGIC_VECTOR ( 0 to 0 );
    C : in STD_LOGIC_VECTOR ( 47 downto 0 );
    CARRYCASCOUT : out STD_LOGIC;
    P : out STD_LOGIC_VECTOR ( 47 downto 0 );
    CEP : in STD_LOGIC;
    SCLRP : in STD_LOGIC
  );

end px_timestamp_gen_dsp48accl;

architecture stub of px_timestamp_gen_dsp48accl is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,SEL[0:0],C[47:0],CARRYCASCOUT,P[47:0],CEP,SCLRP";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "xbip_dsp48_macro_v3_0_17,Vivado 2019.1";
begin
end;
