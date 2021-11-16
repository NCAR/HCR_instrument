-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2700185 Thu Oct 24 18:46:05 MDT 2019
-- Date        : Thu May  7 06:05:43 2020
-- Host        : Rich-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Pentek/IP/2019.2/pentek/ip/px_axis_pdti2ppkt_16/px_axis_pdti2ppkt_16.srcs/sources_1/ip/px_axil_csr_flw_16/px_axil_csr_flw_16_stub.vhdl
-- Design      : px_axil_csr_flw_16
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_axil_csr_flw_16 is
  Port ( 
    s_axi_csr_aclk : in STD_LOGIC;
    s_axi_csr_aresetn : in STD_LOGIC;
    s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_awvalid : in STD_LOGIC;
    s_axi_csr_awready : out STD_LOGIC;
    s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_csr_wvalid : in STD_LOGIC;
    s_axi_csr_wready : out STD_LOGIC;
    s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_bvalid : out STD_LOGIC;
    s_axi_csr_bready : in STD_LOGIC;
    s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_arvalid : in STD_LOGIC;
    s_axi_csr_arready : out STD_LOGIC;
    s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_rvalid : out STD_LOGIC;
    s_axi_csr_rready : in STD_LOGIC;
    reg0_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg1_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg2_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg3_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg4_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg5_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg6_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg7_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl0_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl1_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl2_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl3_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl4_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl5_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl6_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl7_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    stat0_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    stat1_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    stat2_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    stat3_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    stat4_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    intrpt_src_in : in STD_LOGIC_VECTOR ( 4 downto 0 );
    irq : out STD_LOGIC
  );

end px_axil_csr_flw_16;

architecture stub of px_axil_csr_flw_16 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s_axi_csr_aclk,s_axi_csr_aresetn,s_axi_csr_awaddr[6:0],s_axi_csr_awprot[2:0],s_axi_csr_awvalid,s_axi_csr_awready,s_axi_csr_wdata[31:0],s_axi_csr_wstrb[3:0],s_axi_csr_wvalid,s_axi_csr_wready,s_axi_csr_bresp[1:0],s_axi_csr_bvalid,s_axi_csr_bready,s_axi_csr_araddr[6:0],s_axi_csr_arprot[2:0],s_axi_csr_arvalid,s_axi_csr_arready,s_axi_csr_rdata[31:0],s_axi_csr_rresp[1:0],s_axi_csr_rvalid,s_axi_csr_rready,reg0_init_val[31:0],reg1_init_val[31:0],reg2_init_val[31:0],reg3_init_val[31:0],reg4_init_val[31:0],reg5_init_val[31:0],reg6_init_val[31:0],reg7_init_val[31:0],ctl0_out[31:0],ctl1_out[31:0],ctl2_out[31:0],ctl3_out[31:0],ctl4_out[31:0],ctl5_out[31:0],ctl6_out[31:0],ctl7_out[31:0],stat0_in[31:0],stat1_in[31:0],stat2_in[31:0],stat3_in[31:0],stat4_in[31:0],intrpt_src_in[4:0],irq";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "px_axil_csr,Vivado 2019.2";
begin
end;
