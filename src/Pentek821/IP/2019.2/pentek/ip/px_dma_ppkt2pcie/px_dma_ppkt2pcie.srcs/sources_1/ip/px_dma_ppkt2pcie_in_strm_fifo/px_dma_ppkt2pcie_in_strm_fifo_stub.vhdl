-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
-- Date        : Fri Feb 05 10:20:01 2016
-- Host        : Rich-PC running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Xilinx/Vivado/2015.4/data/ip/pentek/px_dma_ppkt2pcie/px_dma_ppkt2pcie.srcs/sources_1/ip/px_dma_ppkt2pcie_in_strm_fifo/px_dma_ppkt2pcie_in_strm_fifo_stub.vhdl
-- Design      : px_dma_ppkt2pcie_in_strm_fifo
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1517-2-e-es2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity px_dma_ppkt2pcie_in_strm_fifo is
  Port ( 
    m_aclk : in STD_LOGIC;
    s_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tuser : in STD_LOGIC_VECTOR ( 87 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tuser : out STD_LOGIC_VECTOR ( 87 downto 0 );
    axis_prog_full : out STD_LOGIC
  );

end px_dma_ppkt2pcie_in_strm_fifo;

architecture stub of px_dma_ppkt2pcie_in_strm_fifo is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "m_aclk,s_aclk,s_aresetn,s_axis_tvalid,s_axis_tready,s_axis_tdata[511:0],s_axis_tlast,s_axis_tuser[87:0],m_axis_tvalid,m_axis_tready,m_axis_tdata[511:0],m_axis_tlast,m_axis_tuser[87:0],axis_prog_full";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v13_0_1,Vivado 2015.4";
begin
end;
