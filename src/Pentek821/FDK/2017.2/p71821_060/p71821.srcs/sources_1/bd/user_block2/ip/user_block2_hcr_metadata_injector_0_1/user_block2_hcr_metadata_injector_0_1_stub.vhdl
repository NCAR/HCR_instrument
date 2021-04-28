-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Tue Apr 27 22:17:20 2021
-- Host        : wind running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_hcr_metadata_injector_0_1/user_block2_hcr_metadata_injector_0_1_stub.vhdl
-- Design      : user_block2_hcr_metadata_injector_0_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity user_block2_hcr_metadata_injector_0_1 is
  Port ( 
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_idle : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    i_data_TVALID : in STD_LOGIC;
    i_data_TREADY : out STD_LOGIC;
    i_data_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    i_data_TDEST : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_data_TKEEP : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_data_TSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    i_data_TUSER : in STD_LOGIC_VECTOR ( 127 downto 0 );
    i_data_TLAST : in STD_LOGIC_VECTOR ( 0 to 0 );
    i_data_TID : in STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TVALID : out STD_LOGIC;
    o_data_TREADY : in STD_LOGIC;
    o_data_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    o_data_TDEST : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TKEEP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    o_data_TSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    o_data_TUSER : out STD_LOGIC_VECTOR ( 127 downto 0 );
    o_data_TLAST : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_data_TID : out STD_LOGIC_VECTOR ( 0 to 0 );
    pulse_metadata_V_TVALID : in STD_LOGIC;
    pulse_metadata_V_TREADY : out STD_LOGIC;
    pulse_metadata_V_TDATA : in STD_LOGIC_VECTOR ( 823 downto 0 );
    pos_enc_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pos_enc_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    flags : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );

end user_block2_hcr_metadata_injector_0_1;

architecture stub of user_block2_hcr_metadata_injector_0_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "ap_clk,ap_rst_n,ap_start,ap_done,ap_idle,ap_ready,i_data_TVALID,i_data_TREADY,i_data_TDATA[31:0],i_data_TDEST[0:0],i_data_TKEEP[3:0],i_data_TSTRB[3:0],i_data_TUSER[127:0],i_data_TLAST[0:0],i_data_TID[0:0],o_data_TVALID,o_data_TREADY,o_data_TDATA[31:0],o_data_TDEST[0:0],o_data_TKEEP[3:0],o_data_TSTRB[3:0],o_data_TUSER[127:0],o_data_TLAST[0:0],o_data_TID[0:0],pulse_metadata_V_TVALID,pulse_metadata_V_TREADY,pulse_metadata_V_TDATA[823:0],pos_enc_0[31:0],pos_enc_1[31:0],flags[15:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "hcr_metadata_injector,Vivado 2017.2";
begin
end;
