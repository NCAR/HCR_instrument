-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Mon Apr 26 16:13:24 2021
-- Host        : wind running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_hcr_controller_0_0/user_block2_hcr_controller_0_0_stub.vhdl
-- Design      : user_block2_hcr_controller_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity user_block2_hcr_controller_0_0 is
  Port ( 
    pps_ce0 : out STD_LOGIC;
    pps_we0 : out STD_LOGIC;
    mt_pulse_V_ap_vld : out STD_LOGIC;
    control_flags_V_ap_vld : out STD_LOGIC;
    filter_select_ch0_V_ap_vld : out STD_LOGIC;
    filter_select_ch1_V_ap_vld : out STD_LOGIC;
    filter_select_ch2_V_ap_vld : out STD_LOGIC;
    s_axi_cfg_bus_AWADDR : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_cfg_bus_AWVALID : in STD_LOGIC;
    s_axi_cfg_bus_AWREADY : out STD_LOGIC;
    s_axi_cfg_bus_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_cfg_bus_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_cfg_bus_WVALID : in STD_LOGIC;
    s_axi_cfg_bus_WREADY : out STD_LOGIC;
    s_axi_cfg_bus_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_cfg_bus_BVALID : out STD_LOGIC;
    s_axi_cfg_bus_BREADY : in STD_LOGIC;
    s_axi_cfg_bus_ARADDR : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_cfg_bus_ARVALID : in STD_LOGIC;
    s_axi_cfg_bus_ARREADY : out STD_LOGIC;
    s_axi_cfg_bus_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_cfg_bus_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_cfg_bus_RVALID : out STD_LOGIC;
    s_axi_cfg_bus_RREADY : in STD_LOGIC;
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    interrupt : out STD_LOGIC;
    coef_ch0_V_V_TVALID : out STD_LOGIC;
    coef_ch0_V_V_TREADY : in STD_LOGIC;
    coef_ch0_V_V_TDATA : out STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_ch1_V_V_TVALID : out STD_LOGIC;
    coef_ch1_V_V_TREADY : in STD_LOGIC;
    coef_ch1_V_V_TDATA : out STD_LOGIC_VECTOR ( 23 downto 0 );
    coef_ch2_V_V_TVALID : out STD_LOGIC;
    coef_ch2_V_V_TREADY : in STD_LOGIC;
    coef_ch2_V_V_TDATA : out STD_LOGIC_VECTOR ( 23 downto 0 );
    mt_pulse_V : out STD_LOGIC_VECTOR ( 7 downto 0 );
    control_flags_V : out STD_LOGIC_VECTOR ( 31 downto 0 );
    filter_select_ch0_V : out STD_LOGIC_VECTOR ( 1 downto 0 );
    filter_select_ch1_V : out STD_LOGIC_VECTOR ( 1 downto 0 );
    filter_select_ch2_V : out STD_LOGIC_VECTOR ( 1 downto 0 );
    pulse_metadata_ch0_V_TVALID : out STD_LOGIC;
    pulse_metadata_ch0_V_TREADY : in STD_LOGIC;
    pulse_metadata_ch0_V_TDATA : out STD_LOGIC_VECTOR ( 823 downto 0 );
    pulse_metadata_ch1_V_TVALID : out STD_LOGIC;
    pulse_metadata_ch1_V_TREADY : in STD_LOGIC;
    pulse_metadata_ch1_V_TDATA : out STD_LOGIC_VECTOR ( 823 downto 0 );
    pulse_metadata_ch2_V_TVALID : out STD_LOGIC;
    pulse_metadata_ch2_V_TREADY : in STD_LOGIC;
    pulse_metadata_ch2_V_TDATA : out STD_LOGIC_VECTOR ( 823 downto 0 );
    pps_address0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    pps_d0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    pps_q0 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );

end user_block2_hcr_controller_0_0;

architecture stub of user_block2_hcr_controller_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "pps_ce0,pps_we0,mt_pulse_V_ap_vld,control_flags_V_ap_vld,filter_select_ch0_V_ap_vld,filter_select_ch1_V_ap_vld,filter_select_ch2_V_ap_vld,s_axi_cfg_bus_AWADDR[12:0],s_axi_cfg_bus_AWVALID,s_axi_cfg_bus_AWREADY,s_axi_cfg_bus_WDATA[31:0],s_axi_cfg_bus_WSTRB[3:0],s_axi_cfg_bus_WVALID,s_axi_cfg_bus_WREADY,s_axi_cfg_bus_BRESP[1:0],s_axi_cfg_bus_BVALID,s_axi_cfg_bus_BREADY,s_axi_cfg_bus_ARADDR[12:0],s_axi_cfg_bus_ARVALID,s_axi_cfg_bus_ARREADY,s_axi_cfg_bus_RDATA[31:0],s_axi_cfg_bus_RRESP[1:0],s_axi_cfg_bus_RVALID,s_axi_cfg_bus_RREADY,ap_clk,ap_rst_n,interrupt,coef_ch0_V_V_TVALID,coef_ch0_V_V_TREADY,coef_ch0_V_V_TDATA[23:0],coef_ch1_V_V_TVALID,coef_ch1_V_V_TREADY,coef_ch1_V_V_TDATA[23:0],coef_ch2_V_V_TVALID,coef_ch2_V_V_TREADY,coef_ch2_V_V_TDATA[23:0],mt_pulse_V[7:0],control_flags_V[31:0],filter_select_ch0_V[1:0],filter_select_ch1_V[1:0],filter_select_ch2_V[1:0],pulse_metadata_ch0_V_TVALID,pulse_metadata_ch0_V_TREADY,pulse_metadata_ch0_V_TDATA[823:0],pulse_metadata_ch1_V_TVALID,pulse_metadata_ch1_V_TREADY,pulse_metadata_ch1_V_TDATA[823:0],pulse_metadata_ch2_V_TVALID,pulse_metadata_ch2_V_TREADY,pulse_metadata_ch2_V_TDATA[823:0],pps_address0[0:0],pps_d0[0:0],pps_q0[0:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "hcr_controller,Vivado 2017.2";
begin
end;
