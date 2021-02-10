-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
-- Date        : Fri May 01 23:54:42 2015
-- Host        : Igor running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               E:/px_ip/px_syncbus_intrfc1/px_syncbus_intrfc1.srcs/sources_1/ip/px_axil_csr_sb/px_axil_csr_sb_funcsim.vhdl
-- Design      : px_axil_csr_sb
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku060-ffva1517-2-e-es2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_axil_csr_sb_px_axil_csr is
  port (
    s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl0_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl1_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl2_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl3_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl4_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl5_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl6_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    irq : out STD_LOGIC;
    s_axi_csr_wready : out STD_LOGIC;
    s_axi_csr_awready : out STD_LOGIC;
    s_axi_csr_arready : out STD_LOGIC;
    s_axi_csr_rvalid : out STD_LOGIC;
    s_axi_csr_bvalid : out STD_LOGIC;
    s_axi_csr_aresetn : in STD_LOGIC;
    s_axi_csr_aclk : in STD_LOGIC;
    s_axi_csr_rready : in STD_LOGIC;
    s_axi_csr_bready : in STD_LOGIC;
    s_axi_csr_awvalid : in STD_LOGIC;
    s_axi_csr_wvalid : in STD_LOGIC;
    s_axi_csr_arvalid : in STD_LOGIC;
    intrpt_src_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    stat0_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg0_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg1_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg2_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg3_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg4_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg5_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg6_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of px_axil_csr_sb_px_axil_csr : entity is "px_axil_csr";
end px_axil_csr_sb_px_axil_csr;

architecture STRUCTURE of px_axil_csr_sb_px_axil_csr is
  signal \FSM_sequential_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[3]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][10]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][11]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][12]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][13]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][14]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][16]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][17]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][18]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][19]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][20]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][21]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][22]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][24]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][25]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][26]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][27]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][28]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][29]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][2]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][30]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][3]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][4]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][5]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][6]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][8]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg[3][9]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][10]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][11]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][12]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][13]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][14]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][16]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][17]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][18]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][19]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][20]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][21]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][22]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][24]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][25]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][26]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][27]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][28]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][29]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][2]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][30]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][3]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][4]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][5]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][6]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][8]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg[4][9]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][10]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][11]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][12]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][13]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][14]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][16]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][17]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][18]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][19]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][20]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][21]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][22]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][24]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][25]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][26]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][27]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][28]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][29]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][2]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][30]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][3]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][4]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][5]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][6]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][8]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg[5][9]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][10]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][11]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][12]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][13]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][14]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][16]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][17]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][18]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][19]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][20]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][21]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][22]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][24]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][25]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][26]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][27]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][28]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][29]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][2]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][30]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][3]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][4]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][5]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][6]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_2_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][8]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg[6][9]_i_1_n_0\ : STD_LOGIC;
  signal \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_flag.gen_int_flag_reg[2].int_flag_reg[2]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_flag.gen_int_flag_reg[3].int_flag_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_flag.gen_int_flag_reg[4].int_flag_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_flag.gen_int_flag_reg[5].int_flag_reg[5]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_flag.gen_int_flag_reg[6].int_flag_reg[6]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_3_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_4_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]_i_2_n_7\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[0].int_and[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[0].re_int[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[1].int_and[1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[1].re_int[1]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[2].int_and[2]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[2].re_int[2]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[3].int_and[3]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[3].re_int[3]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[4].int_and[4]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[4].re_int[4]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[5].int_and[5]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[5].re_int[5]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[6].int_and[6]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[6].re_int[6]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[7].int_and[7]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.gen_int_src.gen_int_src_reg[7].re_int[7]_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[0]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[10]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[11]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[12]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[13]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[14]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[15]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[16]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[17]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[18]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[19]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[20]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[21]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[22]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[23]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[24]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[25]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[26]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[27]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[28]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[29]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[30]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[31]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[8]\ : STD_LOGIC;
  signal \gen_int.int_en_reg_reg_n_0_[9]\ : STD_LOGIC;
  signal \gen_int.usr_int_i_1_n_0\ : STD_LOGIC;
  signal \gen_int.usr_int_i_2_n_0\ : STD_LOGIC;
  signal \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal int_flag_reg : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal p_0_in69_in : STD_LOGIC;
  signal p_0_in74_in : STD_LOGIC;
  signal p_0_in79_in : STD_LOGIC;
  signal p_0_in84_in : STD_LOGIC;
  signal p_0_in89_in : STD_LOGIC;
  signal p_0_in94_in : STD_LOGIC;
  signal p_0_in99_in : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 31 downto 7 );
  signal p_1_in10_in : STD_LOGIC;
  signal p_1_in13_in : STD_LOGIC;
  signal p_1_in16_in : STD_LOGIC;
  signal p_1_in1_in : STD_LOGIC;
  signal p_1_in4_in : STD_LOGIC;
  signal p_1_in7_in : STD_LOGIC;
  signal p_67_in : STD_LOGIC;
  signal p_92_out : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal p_93_out : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal p_94_out : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal p_95_out : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \r_addr[5]_i_1_n_0\ : STD_LOGIC;
  signal \r_addr_reg_n_0_[5]\ : STD_LOGIC;
  signal rd_data : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \rd_data[0]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[0]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[0]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[0]_i_5_n_0\ : STD_LOGIC;
  signal \rd_data[10]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[10]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[10]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[11]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[11]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[11]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[12]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[12]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[12]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[13]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[13]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[13]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[14]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[14]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[14]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[15]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[15]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[15]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[16]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[16]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[16]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[17]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[17]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[17]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[18]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[18]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[18]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[19]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[19]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[19]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[1]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[1]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data[1]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[1]_i_5_n_0\ : STD_LOGIC;
  signal \rd_data[1]_i_6_n_0\ : STD_LOGIC;
  signal \rd_data[20]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[20]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[20]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[21]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[21]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[21]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[22]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[22]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[22]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[23]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[23]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[23]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[24]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[24]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[24]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[25]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[25]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[25]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[26]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[26]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[26]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[27]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[27]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[27]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[28]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[28]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[28]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[29]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[29]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[29]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[2]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[2]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data[2]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[2]_i_5_n_0\ : STD_LOGIC;
  signal \rd_data[2]_i_6_n_0\ : STD_LOGIC;
  signal \rd_data[30]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[30]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[30]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[31]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[31]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[31]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[31]_i_5_n_0\ : STD_LOGIC;
  signal \rd_data[31]_i_6_n_0\ : STD_LOGIC;
  signal \rd_data[3]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[3]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[3]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[3]_i_5_n_0\ : STD_LOGIC;
  signal \rd_data[4]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[4]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[4]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[4]_i_5_n_0\ : STD_LOGIC;
  signal \rd_data[5]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[5]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data[5]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[5]_i_5_n_0\ : STD_LOGIC;
  signal \rd_data[5]_i_6_n_0\ : STD_LOGIC;
  signal \rd_data[6]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[6]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data[6]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[6]_i_5_n_0\ : STD_LOGIC;
  signal \rd_data[6]_i_6_n_0\ : STD_LOGIC;
  signal \rd_data[7]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[7]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[7]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[7]_i_5_n_0\ : STD_LOGIC;
  signal \rd_data[7]_i_6_n_0\ : STD_LOGIC;
  signal \rd_data[8]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[8]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[8]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data[9]_i_1_n_0\ : STD_LOGIC;
  signal \rd_data[9]_i_3_n_0\ : STD_LOGIC;
  signal \rd_data[9]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[10]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[11]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[13]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[14]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[15]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[16]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[17]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[18]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[19]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[1]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data_reg[20]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[21]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[22]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[23]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[24]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[25]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[26]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[27]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[28]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[29]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[2]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data_reg[30]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[31]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[3]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[5]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data_reg[6]_i_4_n_0\ : STD_LOGIC;
  signal \rd_data_reg[7]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \rd_data_reg[9]_i_2_n_0\ : STD_LOGIC;
  signal \^s_axi_csr_arready\ : STD_LOGIC;
  signal s_axi_csr_arready_i_1_n_0 : STD_LOGIC;
  signal \^s_axi_csr_awready\ : STD_LOGIC;
  signal s_axi_csr_awready_i_1_n_0 : STD_LOGIC;
  signal s_axi_csr_awready_i_2_n_0 : STD_LOGIC;
  signal \^s_axi_csr_bvalid\ : STD_LOGIC;
  signal s_axi_csr_bvalid_i_1_n_0 : STD_LOGIC;
  signal \s_axi_csr_rdata[31]_i_1_n_0\ : STD_LOGIC;
  signal \^s_axi_csr_rvalid\ : STD_LOGIC;
  signal s_axi_csr_rvalid_i_1_n_0 : STD_LOGIC;
  signal \^s_axi_csr_wready\ : STD_LOGIC;
  signal s_axi_csr_wready_i_1_n_0 : STD_LOGIC;
  signal sel0 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal state : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of state : signal is "yes";
  signal usr_int : STD_LOGIC;
  signal \w_addr[5]_i_1_n_0\ : STD_LOGIC;
  signal \w_addr_reg_n_0_[2]\ : STD_LOGIC;
  signal \w_addr_reg_n_0_[3]\ : STD_LOGIC;
  signal \w_addr_reg_n_0_[4]\ : STD_LOGIC;
  signal \w_addr_reg_n_0_[5]\ : STD_LOGIC;
  signal w_data : STD_LOGIC_VECTOR ( 31 downto 8 );
  signal \w_data[31]_i_1_n_0\ : STD_LOGIC;
  signal \w_data_reg_n_0_[0]\ : STD_LOGIC;
  signal \w_data_reg_n_0_[7]\ : STD_LOGIC;
  signal w_we_i_1_n_0 : STD_LOGIC;
  signal w_we_reg_n_0 : STD_LOGIC;
  signal wr_strb : STD_LOGIC;
  signal \wr_strb[3]_i_1_n_0\ : STD_LOGIC;
  signal \wr_strb_reg_n_0_[1]\ : STD_LOGIC;
  signal \wr_strb_reg_n_0_[2]\ : STD_LOGIC;
  signal \wr_strb_reg_n_0_[3]\ : STD_LOGIC;
  signal \NLW_gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]_i_2_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \NLW_gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]_i_2_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_state_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_state_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_state_reg[2]\ : label is "yes";
  attribute KEEP of \FSM_sequential_state_reg[3]\ : label is "yes";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][0]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][10]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][11]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][12]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][13]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][14]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_2\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][16]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][17]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][18]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][19]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][1]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][20]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][21]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][22]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_2\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][24]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][25]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][26]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][27]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][28]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][29]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][2]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][30]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_2\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][3]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][4]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][5]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][6]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_2\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][8]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[3].cntl_reg[3][9]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][0]_i_1\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][10]_i_1\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][11]_i_1\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][12]_i_1\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][13]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][14]_i_1\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_2\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][16]_i_1\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][17]_i_1\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][18]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][19]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][1]_i_1\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][20]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][21]_i_1\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][22]_i_1\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_2\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][24]_i_1\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][25]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][26]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][27]_i_1\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][28]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][29]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][2]_i_1\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][30]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_2\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][3]_i_1\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][4]_i_1\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][5]_i_1\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][6]_i_1\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_2\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][8]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[4].cntl_reg[4][9]_i_1\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][0]_i_1\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][10]_i_1\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][11]_i_1\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][12]_i_1\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][13]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][14]_i_1\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_2\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][16]_i_1\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][17]_i_1\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][18]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][19]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][1]_i_1\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][20]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][21]_i_1\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][22]_i_1\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_2\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][24]_i_1\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][25]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][26]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][27]_i_1\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][28]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][29]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][2]_i_1\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][30]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_2\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][3]_i_1\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][4]_i_1\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][5]_i_1\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][6]_i_1\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_2\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][8]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[5].cntl_reg[5][9]_i_1\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][0]_i_1\ : label is "soft_lutpair114";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][10]_i_1\ : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][11]_i_1\ : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][12]_i_1\ : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][13]_i_1\ : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][14]_i_1\ : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_2\ : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][16]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][17]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][18]_i_1\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][19]_i_1\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][1]_i_1\ : label is "soft_lutpair114";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][20]_i_1\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][21]_i_1\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][22]_i_1\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_2\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][24]_i_1\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][25]_i_1\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][26]_i_1\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][27]_i_1\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][28]_i_1\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][29]_i_1\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][2]_i_1\ : label is "soft_lutpair113";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][30]_i_1\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_2\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][3]_i_1\ : label is "soft_lutpair113";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][4]_i_1\ : label is "soft_lutpair112";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][5]_i_1\ : label is "soft_lutpair112";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][6]_i_1\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_2\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][8]_i_1\ : label is "soft_lutpair110";
  attribute SOFT_HLUTNM of \gen_cntl.gen_ctl_regs[6].cntl_reg[6][9]_i_1\ : label is "soft_lutpair110";
  attribute SOFT_HLUTNM of \rd_data[1]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \rd_data[2]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \rd_data[31]_i_4\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \rd_data[5]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \rd_data[6]_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \rd_data[7]_i_6\ : label is "soft_lutpair0";
begin
  s_axi_csr_arready <= \^s_axi_csr_arready\;
  s_axi_csr_awready <= \^s_axi_csr_awready\;
  s_axi_csr_bvalid <= \^s_axi_csr_bvalid\;
  s_axi_csr_rvalid <= \^s_axi_csr_rvalid\;
  s_axi_csr_wready <= \^s_axi_csr_wready\;
\FSM_sequential_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"004FFFFF004F0000"
    )
        port map (
      I0 => s_axi_csr_rready,
      I1 => state(1),
      I2 => state(0),
      I3 => state(2),
      I4 => state(3),
      I5 => \FSM_sequential_state[0]_i_2_n_0\,
      O => \FSM_sequential_state[0]_i_1_n_0\
    );
\FSM_sequential_state[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"40704C7CFFFCFCFC"
    )
        port map (
      I0 => s_axi_csr_bready,
      I1 => state(1),
      I2 => state(2),
      I3 => s_axi_csr_awvalid,
      I4 => s_axi_csr_wvalid,
      I5 => state(0),
      O => \FSM_sequential_state[0]_i_2_n_0\
    );
\FSM_sequential_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"007CFFFF007C0000"
    )
        port map (
      I0 => s_axi_csr_rready,
      I1 => state(1),
      I2 => state(0),
      I3 => state(2),
      I4 => state(3),
      I5 => \FSM_sequential_state[1]_i_2_n_0\,
      O => \FSM_sequential_state[1]_i_1_n_0\
    );
\FSM_sequential_state[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F7F4F4FCCCFCCCC"
    )
        port map (
      I0 => s_axi_csr_bready,
      I1 => state(1),
      I2 => state(2),
      I3 => s_axi_csr_wvalid,
      I4 => s_axi_csr_awvalid,
      I5 => state(0),
      O => \FSM_sequential_state[1]_i_2_n_0\
    );
\FSM_sequential_state[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \FSM_sequential_state[2]_i_2_n_0\,
      I1 => state(3),
      O => \FSM_sequential_state[2]_i_1_n_0\
    );
\FSM_sequential_state[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F7F7F7FF030F330"
    )
        port map (
      I0 => s_axi_csr_bready,
      I1 => state(1),
      I2 => state(0),
      I3 => s_axi_csr_wvalid,
      I4 => s_axi_csr_awvalid,
      I5 => state(2),
      O => \FSM_sequential_state[2]_i_2_n_0\
    );
\FSM_sequential_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"007FFFFF007F0000"
    )
        port map (
      I0 => state(0),
      I1 => s_axi_csr_rready,
      I2 => state(1),
      I3 => state(2),
      I4 => state(3),
      I5 => \FSM_sequential_state[3]_i_2_n_0\,
      O => \FSM_sequential_state[3]_i_1_n_0\
    );
\FSM_sequential_state[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000010"
    )
        port map (
      I0 => state(2),
      I1 => s_axi_csr_awvalid,
      I2 => s_axi_csr_arvalid,
      I3 => s_axi_csr_wvalid,
      I4 => state(0),
      I5 => state(1),
      O => \FSM_sequential_state[3]_i_2_n_0\
    );
\FSM_sequential_state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \FSM_sequential_state[0]_i_1_n_0\,
      Q => state(0),
      R => s_axi_csr_awready_i_1_n_0
    );
\FSM_sequential_state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \FSM_sequential_state[1]_i_1_n_0\,
      Q => state(1),
      R => s_axi_csr_awready_i_1_n_0
    );
\FSM_sequential_state_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \FSM_sequential_state[2]_i_1_n_0\,
      Q => state(2),
      R => s_axi_csr_awready_i_1_n_0
    );
\FSM_sequential_state_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \FSM_sequential_state[3]_i_1_n_0\,
      Q => state(3),
      R => s_axi_csr_awready_i_1_n_0
    );
\ctl0_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(0),
      Q => ctl0_out(0),
      R => '0'
    );
\ctl0_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(10),
      Q => ctl0_out(10),
      R => '0'
    );
\ctl0_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(11),
      Q => ctl0_out(11),
      R => '0'
    );
\ctl0_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(12),
      Q => ctl0_out(12),
      R => '0'
    );
\ctl0_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(13),
      Q => ctl0_out(13),
      R => '0'
    );
\ctl0_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(14),
      Q => ctl0_out(14),
      R => '0'
    );
\ctl0_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(15),
      Q => ctl0_out(15),
      R => '0'
    );
\ctl0_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(16),
      Q => ctl0_out(16),
      R => '0'
    );
\ctl0_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(17),
      Q => ctl0_out(17),
      R => '0'
    );
\ctl0_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(18),
      Q => ctl0_out(18),
      R => '0'
    );
\ctl0_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(19),
      Q => ctl0_out(19),
      R => '0'
    );
\ctl0_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(1),
      Q => ctl0_out(1),
      R => '0'
    );
\ctl0_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(20),
      Q => ctl0_out(20),
      R => '0'
    );
\ctl0_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(21),
      Q => ctl0_out(21),
      R => '0'
    );
\ctl0_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(22),
      Q => ctl0_out(22),
      R => '0'
    );
\ctl0_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(23),
      Q => ctl0_out(23),
      R => '0'
    );
\ctl0_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(24),
      Q => ctl0_out(24),
      R => '0'
    );
\ctl0_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(25),
      Q => ctl0_out(25),
      R => '0'
    );
\ctl0_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(26),
      Q => ctl0_out(26),
      R => '0'
    );
\ctl0_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(27),
      Q => ctl0_out(27),
      R => '0'
    );
\ctl0_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(28),
      Q => ctl0_out(28),
      R => '0'
    );
\ctl0_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(29),
      Q => ctl0_out(29),
      R => '0'
    );
\ctl0_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(2),
      Q => ctl0_out(2),
      R => '0'
    );
\ctl0_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(30),
      Q => ctl0_out(30),
      R => '0'
    );
\ctl0_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(31),
      Q => ctl0_out(31),
      R => '0'
    );
\ctl0_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(3),
      Q => ctl0_out(3),
      R => '0'
    );
\ctl0_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(4),
      Q => ctl0_out(4),
      R => '0'
    );
\ctl0_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(5),
      Q => ctl0_out(5),
      R => '0'
    );
\ctl0_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(6),
      Q => ctl0_out(6),
      R => '0'
    );
\ctl0_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(7),
      Q => ctl0_out(7),
      R => '0'
    );
\ctl0_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(8),
      Q => ctl0_out(8),
      R => '0'
    );
\ctl0_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(9),
      Q => ctl0_out(9),
      R => '0'
    );
\ctl1_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(0),
      Q => ctl1_out(0),
      R => '0'
    );
\ctl1_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(10),
      Q => ctl1_out(10),
      R => '0'
    );
\ctl1_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(11),
      Q => ctl1_out(11),
      R => '0'
    );
\ctl1_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(12),
      Q => ctl1_out(12),
      R => '0'
    );
\ctl1_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(13),
      Q => ctl1_out(13),
      R => '0'
    );
\ctl1_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(14),
      Q => ctl1_out(14),
      R => '0'
    );
\ctl1_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(15),
      Q => ctl1_out(15),
      R => '0'
    );
\ctl1_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(16),
      Q => ctl1_out(16),
      R => '0'
    );
\ctl1_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(17),
      Q => ctl1_out(17),
      R => '0'
    );
\ctl1_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(18),
      Q => ctl1_out(18),
      R => '0'
    );
\ctl1_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(19),
      Q => ctl1_out(19),
      R => '0'
    );
\ctl1_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(1),
      Q => ctl1_out(1),
      R => '0'
    );
\ctl1_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(20),
      Q => ctl1_out(20),
      R => '0'
    );
\ctl1_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(21),
      Q => ctl1_out(21),
      R => '0'
    );
\ctl1_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(22),
      Q => ctl1_out(22),
      R => '0'
    );
\ctl1_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(23),
      Q => ctl1_out(23),
      R => '0'
    );
\ctl1_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(24),
      Q => ctl1_out(24),
      R => '0'
    );
\ctl1_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(25),
      Q => ctl1_out(25),
      R => '0'
    );
\ctl1_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(26),
      Q => ctl1_out(26),
      R => '0'
    );
\ctl1_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(27),
      Q => ctl1_out(27),
      R => '0'
    );
\ctl1_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(28),
      Q => ctl1_out(28),
      R => '0'
    );
\ctl1_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(29),
      Q => ctl1_out(29),
      R => '0'
    );
\ctl1_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(2),
      Q => ctl1_out(2),
      R => '0'
    );
\ctl1_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(30),
      Q => ctl1_out(30),
      R => '0'
    );
\ctl1_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(31),
      Q => ctl1_out(31),
      R => '0'
    );
\ctl1_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(3),
      Q => ctl1_out(3),
      R => '0'
    );
\ctl1_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(4),
      Q => ctl1_out(4),
      R => '0'
    );
\ctl1_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(5),
      Q => ctl1_out(5),
      R => '0'
    );
\ctl1_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(6),
      Q => ctl1_out(6),
      R => '0'
    );
\ctl1_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(7),
      Q => ctl1_out(7),
      R => '0'
    );
\ctl1_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(8),
      Q => ctl1_out(8),
      R => '0'
    );
\ctl1_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(9),
      Q => ctl1_out(9),
      R => '0'
    );
\ctl2_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(0),
      Q => ctl2_out(0),
      R => '0'
    );
\ctl2_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(10),
      Q => ctl2_out(10),
      R => '0'
    );
\ctl2_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(11),
      Q => ctl2_out(11),
      R => '0'
    );
\ctl2_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(12),
      Q => ctl2_out(12),
      R => '0'
    );
\ctl2_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(13),
      Q => ctl2_out(13),
      R => '0'
    );
\ctl2_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(14),
      Q => ctl2_out(14),
      R => '0'
    );
\ctl2_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(15),
      Q => ctl2_out(15),
      R => '0'
    );
\ctl2_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(16),
      Q => ctl2_out(16),
      R => '0'
    );
\ctl2_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(17),
      Q => ctl2_out(17),
      R => '0'
    );
\ctl2_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(18),
      Q => ctl2_out(18),
      R => '0'
    );
\ctl2_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(19),
      Q => ctl2_out(19),
      R => '0'
    );
\ctl2_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(1),
      Q => ctl2_out(1),
      R => '0'
    );
\ctl2_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(20),
      Q => ctl2_out(20),
      R => '0'
    );
\ctl2_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(21),
      Q => ctl2_out(21),
      R => '0'
    );
\ctl2_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(22),
      Q => ctl2_out(22),
      R => '0'
    );
\ctl2_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(23),
      Q => ctl2_out(23),
      R => '0'
    );
\ctl2_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(24),
      Q => ctl2_out(24),
      R => '0'
    );
\ctl2_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(25),
      Q => ctl2_out(25),
      R => '0'
    );
\ctl2_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(26),
      Q => ctl2_out(26),
      R => '0'
    );
\ctl2_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(27),
      Q => ctl2_out(27),
      R => '0'
    );
\ctl2_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(28),
      Q => ctl2_out(28),
      R => '0'
    );
\ctl2_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(29),
      Q => ctl2_out(29),
      R => '0'
    );
\ctl2_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(2),
      Q => ctl2_out(2),
      R => '0'
    );
\ctl2_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(30),
      Q => ctl2_out(30),
      R => '0'
    );
\ctl2_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(31),
      Q => ctl2_out(31),
      R => '0'
    );
\ctl2_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(3),
      Q => ctl2_out(3),
      R => '0'
    );
\ctl2_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(4),
      Q => ctl2_out(4),
      R => '0'
    );
\ctl2_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(5),
      Q => ctl2_out(5),
      R => '0'
    );
\ctl2_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(6),
      Q => ctl2_out(6),
      R => '0'
    );
\ctl2_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(7),
      Q => ctl2_out(7),
      R => '0'
    );
\ctl2_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(8),
      Q => ctl2_out(8),
      R => '0'
    );
\ctl2_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(9),
      Q => ctl2_out(9),
      R => '0'
    );
\ctl3_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(0),
      Q => ctl3_out(0),
      R => '0'
    );
\ctl3_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(10),
      Q => ctl3_out(10),
      R => '0'
    );
\ctl3_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(11),
      Q => ctl3_out(11),
      R => '0'
    );
\ctl3_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(12),
      Q => ctl3_out(12),
      R => '0'
    );
\ctl3_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(13),
      Q => ctl3_out(13),
      R => '0'
    );
\ctl3_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(14),
      Q => ctl3_out(14),
      R => '0'
    );
\ctl3_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(15),
      Q => ctl3_out(15),
      R => '0'
    );
\ctl3_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(16),
      Q => ctl3_out(16),
      R => '0'
    );
\ctl3_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(17),
      Q => ctl3_out(17),
      R => '0'
    );
\ctl3_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(18),
      Q => ctl3_out(18),
      R => '0'
    );
\ctl3_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(19),
      Q => ctl3_out(19),
      R => '0'
    );
\ctl3_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(1),
      Q => ctl3_out(1),
      R => '0'
    );
\ctl3_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(20),
      Q => ctl3_out(20),
      R => '0'
    );
\ctl3_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(21),
      Q => ctl3_out(21),
      R => '0'
    );
\ctl3_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(22),
      Q => ctl3_out(22),
      R => '0'
    );
\ctl3_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(23),
      Q => ctl3_out(23),
      R => '0'
    );
\ctl3_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(24),
      Q => ctl3_out(24),
      R => '0'
    );
\ctl3_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(25),
      Q => ctl3_out(25),
      R => '0'
    );
\ctl3_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(26),
      Q => ctl3_out(26),
      R => '0'
    );
\ctl3_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(27),
      Q => ctl3_out(27),
      R => '0'
    );
\ctl3_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(28),
      Q => ctl3_out(28),
      R => '0'
    );
\ctl3_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(29),
      Q => ctl3_out(29),
      R => '0'
    );
\ctl3_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(2),
      Q => ctl3_out(2),
      R => '0'
    );
\ctl3_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(30),
      Q => ctl3_out(30),
      R => '0'
    );
\ctl3_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(31),
      Q => ctl3_out(31),
      R => '0'
    );
\ctl3_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(3),
      Q => ctl3_out(3),
      R => '0'
    );
\ctl3_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(4),
      Q => ctl3_out(4),
      R => '0'
    );
\ctl3_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(5),
      Q => ctl3_out(5),
      R => '0'
    );
\ctl3_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(6),
      Q => ctl3_out(6),
      R => '0'
    );
\ctl3_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(7),
      Q => ctl3_out(7),
      R => '0'
    );
\ctl3_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(8),
      Q => ctl3_out(8),
      R => '0'
    );
\ctl3_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(9),
      Q => ctl3_out(9),
      R => '0'
    );
\ctl4_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(0),
      Q => ctl4_out(0),
      R => '0'
    );
\ctl4_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(10),
      Q => ctl4_out(10),
      R => '0'
    );
\ctl4_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(11),
      Q => ctl4_out(11),
      R => '0'
    );
\ctl4_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(12),
      Q => ctl4_out(12),
      R => '0'
    );
\ctl4_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(13),
      Q => ctl4_out(13),
      R => '0'
    );
\ctl4_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(14),
      Q => ctl4_out(14),
      R => '0'
    );
\ctl4_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(15),
      Q => ctl4_out(15),
      R => '0'
    );
\ctl4_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(16),
      Q => ctl4_out(16),
      R => '0'
    );
\ctl4_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(17),
      Q => ctl4_out(17),
      R => '0'
    );
\ctl4_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(18),
      Q => ctl4_out(18),
      R => '0'
    );
\ctl4_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(19),
      Q => ctl4_out(19),
      R => '0'
    );
\ctl4_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(1),
      Q => ctl4_out(1),
      R => '0'
    );
\ctl4_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(20),
      Q => ctl4_out(20),
      R => '0'
    );
\ctl4_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(21),
      Q => ctl4_out(21),
      R => '0'
    );
\ctl4_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(22),
      Q => ctl4_out(22),
      R => '0'
    );
\ctl4_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(23),
      Q => ctl4_out(23),
      R => '0'
    );
\ctl4_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(24),
      Q => ctl4_out(24),
      R => '0'
    );
\ctl4_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(25),
      Q => ctl4_out(25),
      R => '0'
    );
\ctl4_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(26),
      Q => ctl4_out(26),
      R => '0'
    );
\ctl4_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(27),
      Q => ctl4_out(27),
      R => '0'
    );
\ctl4_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(28),
      Q => ctl4_out(28),
      R => '0'
    );
\ctl4_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(29),
      Q => ctl4_out(29),
      R => '0'
    );
\ctl4_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(2),
      Q => ctl4_out(2),
      R => '0'
    );
\ctl4_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(30),
      Q => ctl4_out(30),
      R => '0'
    );
\ctl4_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(31),
      Q => ctl4_out(31),
      R => '0'
    );
\ctl4_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(3),
      Q => ctl4_out(3),
      R => '0'
    );
\ctl4_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(4),
      Q => ctl4_out(4),
      R => '0'
    );
\ctl4_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(5),
      Q => ctl4_out(5),
      R => '0'
    );
\ctl4_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(6),
      Q => ctl4_out(6),
      R => '0'
    );
\ctl4_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(7),
      Q => ctl4_out(7),
      R => '0'
    );
\ctl4_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(8),
      Q => ctl4_out(8),
      R => '0'
    );
\ctl4_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(9),
      Q => ctl4_out(9),
      R => '0'
    );
\ctl5_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(0),
      Q => ctl5_out(0),
      R => '0'
    );
\ctl5_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(10),
      Q => ctl5_out(10),
      R => '0'
    );
\ctl5_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(11),
      Q => ctl5_out(11),
      R => '0'
    );
\ctl5_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(12),
      Q => ctl5_out(12),
      R => '0'
    );
\ctl5_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(13),
      Q => ctl5_out(13),
      R => '0'
    );
\ctl5_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(14),
      Q => ctl5_out(14),
      R => '0'
    );
\ctl5_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(15),
      Q => ctl5_out(15),
      R => '0'
    );
\ctl5_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(16),
      Q => ctl5_out(16),
      R => '0'
    );
\ctl5_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(17),
      Q => ctl5_out(17),
      R => '0'
    );
\ctl5_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(18),
      Q => ctl5_out(18),
      R => '0'
    );
\ctl5_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(19),
      Q => ctl5_out(19),
      R => '0'
    );
\ctl5_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(1),
      Q => ctl5_out(1),
      R => '0'
    );
\ctl5_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(20),
      Q => ctl5_out(20),
      R => '0'
    );
\ctl5_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(21),
      Q => ctl5_out(21),
      R => '0'
    );
\ctl5_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(22),
      Q => ctl5_out(22),
      R => '0'
    );
\ctl5_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(23),
      Q => ctl5_out(23),
      R => '0'
    );
\ctl5_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(24),
      Q => ctl5_out(24),
      R => '0'
    );
\ctl5_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(25),
      Q => ctl5_out(25),
      R => '0'
    );
\ctl5_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(26),
      Q => ctl5_out(26),
      R => '0'
    );
\ctl5_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(27),
      Q => ctl5_out(27),
      R => '0'
    );
\ctl5_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(28),
      Q => ctl5_out(28),
      R => '0'
    );
\ctl5_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(29),
      Q => ctl5_out(29),
      R => '0'
    );
\ctl5_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(2),
      Q => ctl5_out(2),
      R => '0'
    );
\ctl5_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(30),
      Q => ctl5_out(30),
      R => '0'
    );
\ctl5_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(31),
      Q => ctl5_out(31),
      R => '0'
    );
\ctl5_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(3),
      Q => ctl5_out(3),
      R => '0'
    );
\ctl5_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(4),
      Q => ctl5_out(4),
      R => '0'
    );
\ctl5_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(5),
      Q => ctl5_out(5),
      R => '0'
    );
\ctl5_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(6),
      Q => ctl5_out(6),
      R => '0'
    );
\ctl5_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(7),
      Q => ctl5_out(7),
      R => '0'
    );
\ctl5_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(8),
      Q => ctl5_out(8),
      R => '0'
    );
\ctl5_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(9),
      Q => ctl5_out(9),
      R => '0'
    );
\ctl6_out_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(0),
      Q => ctl6_out(0),
      R => '0'
    );
\ctl6_out_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(10),
      Q => ctl6_out(10),
      R => '0'
    );
\ctl6_out_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(11),
      Q => ctl6_out(11),
      R => '0'
    );
\ctl6_out_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(12),
      Q => ctl6_out(12),
      R => '0'
    );
\ctl6_out_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(13),
      Q => ctl6_out(13),
      R => '0'
    );
\ctl6_out_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(14),
      Q => ctl6_out(14),
      R => '0'
    );
\ctl6_out_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(15),
      Q => ctl6_out(15),
      R => '0'
    );
\ctl6_out_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(16),
      Q => ctl6_out(16),
      R => '0'
    );
\ctl6_out_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(17),
      Q => ctl6_out(17),
      R => '0'
    );
\ctl6_out_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(18),
      Q => ctl6_out(18),
      R => '0'
    );
\ctl6_out_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(19),
      Q => ctl6_out(19),
      R => '0'
    );
\ctl6_out_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(1),
      Q => ctl6_out(1),
      R => '0'
    );
\ctl6_out_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(20),
      Q => ctl6_out(20),
      R => '0'
    );
\ctl6_out_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(21),
      Q => ctl6_out(21),
      R => '0'
    );
\ctl6_out_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(22),
      Q => ctl6_out(22),
      R => '0'
    );
\ctl6_out_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(23),
      Q => ctl6_out(23),
      R => '0'
    );
\ctl6_out_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(24),
      Q => ctl6_out(24),
      R => '0'
    );
\ctl6_out_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(25),
      Q => ctl6_out(25),
      R => '0'
    );
\ctl6_out_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(26),
      Q => ctl6_out(26),
      R => '0'
    );
\ctl6_out_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(27),
      Q => ctl6_out(27),
      R => '0'
    );
\ctl6_out_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(28),
      Q => ctl6_out(28),
      R => '0'
    );
\ctl6_out_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(29),
      Q => ctl6_out(29),
      R => '0'
    );
\ctl6_out_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(2),
      Q => ctl6_out(2),
      R => '0'
    );
\ctl6_out_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(30),
      Q => ctl6_out(30),
      R => '0'
    );
\ctl6_out_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(31),
      Q => ctl6_out(31),
      R => '0'
    );
\ctl6_out_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(3),
      Q => ctl6_out(3),
      R => '0'
    );
\ctl6_out_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(4),
      Q => ctl6_out(4),
      R => '0'
    );
\ctl6_out_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(5),
      Q => ctl6_out(5),
      R => '0'
    );
\ctl6_out_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(6),
      Q => ctl6_out(6),
      R => '0'
    );
\ctl6_out_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(7),
      Q => ctl6_out(7),
      R => '0'
    );
\ctl6_out_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(8),
      Q => ctl6_out(8),
      R => '0'
    );
\ctl6_out_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(9),
      Q => ctl6_out(9),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[0]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(0),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(10),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(10),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(11),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(11),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(12),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(12),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(13),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(13),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(14),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(14),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000004FFFFFFFF"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I1 => \wr_strb_reg_n_0_[1]\,
      I2 => \w_addr_reg_n_0_[3]\,
      I3 => \w_addr_reg_n_0_[4]\,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(15),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(15),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(16),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(16),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(17),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(17),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(18),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(18),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(19),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(19),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in16_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(1),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(20),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(20),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(21),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(21),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(22),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(22),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000004FFFFFFFF"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I1 => \wr_strb_reg_n_0_[2]\,
      I2 => \w_addr_reg_n_0_[3]\,
      I3 => \w_addr_reg_n_0_[4]\,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(23),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(23),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(24),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(24),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(25),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(25),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(26),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(26),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(27),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(27),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(28),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(28),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(29),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(29),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in13_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(2),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(30),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(30),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000004FFFFFFFF"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I1 => \wr_strb_reg_n_0_[3]\,
      I2 => \w_addr_reg_n_0_[3]\,
      I3 => \w_addr_reg_n_0_[4]\,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(31),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(31),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \w_addr_reg_n_0_[5]\,
      I1 => w_we_reg_n_0,
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in10_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(3),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in7_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(4),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in4_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(5),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in1_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(6),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000004FFFFFFFF"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I1 => wr_strb,
      I2 => \w_addr_reg_n_0_[3]\,
      I3 => \w_addr_reg_n_0_[4]\,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[7]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(7),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(8),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(8),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(9),
      I1 => s_axi_csr_aresetn,
      I2 => reg0_init_val(9),
      O => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(0),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(10),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(11),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(12),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(13),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(14),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(15),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(16),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(17),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(18),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(19),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(1),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(20),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(21),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(22),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(23),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(24),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(25),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(26),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(27),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(28),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(29),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(2),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(30),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(31),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(3),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(4),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(5),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(6),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(7),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(8),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(9),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[0]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(0),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(10),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(10),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(11),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(11),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(12),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(12),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(13),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(13),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(14),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(14),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000020FFFFFFFF"
    )
        port map (
      I0 => \wr_strb_reg_n_0_[1]\,
      I1 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \w_addr_reg_n_0_[4]\,
      I4 => \w_addr_reg_n_0_[3]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(15),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(15),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(16),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(16),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(17),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(17),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(18),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(18),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(19),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(19),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in16_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(1),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(20),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(20),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(21),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(21),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(22),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(22),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000020FFFFFFFF"
    )
        port map (
      I0 => \wr_strb_reg_n_0_[2]\,
      I1 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \w_addr_reg_n_0_[4]\,
      I4 => \w_addr_reg_n_0_[3]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(23),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(23),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(24),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(24),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(25),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(25),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(26),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(26),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(27),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(27),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(28),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(28),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(29),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(29),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in13_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(2),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(30),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(30),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000200FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[2]\,
      I1 => \w_addr_reg_n_0_[4]\,
      I2 => \w_addr_reg_n_0_[3]\,
      I3 => \wr_strb_reg_n_0_[3]\,
      I4 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(31),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(31),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in10_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(3),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in7_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(4),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in4_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(5),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in1_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(6),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000020FFFFFFFF"
    )
        port map (
      I0 => wr_strb,
      I1 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \w_addr_reg_n_0_[4]\,
      I4 => \w_addr_reg_n_0_[3]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[7]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(7),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(8),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(8),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(9),
      I1 => s_axi_csr_aresetn,
      I2 => reg1_init_val(9),
      O => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(0),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(10),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(11),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(12),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(13),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(14),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(15),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(16),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(17),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(18),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(19),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(1),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(20),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(21),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(22),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(23),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(24),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(25),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(26),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(27),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(28),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(29),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(2),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(30),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(31),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(3),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(4),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(5),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(6),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(7),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(8),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(9),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[0]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(0),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(10),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(10),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(11),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(11),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(12),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(12),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(13),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(13),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(14),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(14),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000200FFFFFFFF"
    )
        port map (
      I0 => \wr_strb_reg_n_0_[1]\,
      I1 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \w_addr_reg_n_0_[3]\,
      I4 => \w_addr_reg_n_0_[4]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(15),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(15),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(16),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(16),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(17),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(17),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(18),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(18),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(19),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(19),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in16_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(1),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(20),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(20),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(21),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(21),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(22),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(22),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000200FFFFFFFF"
    )
        port map (
      I0 => \wr_strb_reg_n_0_[2]\,
      I1 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \w_addr_reg_n_0_[3]\,
      I4 => \w_addr_reg_n_0_[4]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(23),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(23),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(24),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(24),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(25),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(25),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(26),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(26),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(27),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(27),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(28),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(28),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(29),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(29),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in13_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(2),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(30),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(30),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000200FFFFFFFF"
    )
        port map (
      I0 => \wr_strb_reg_n_0_[3]\,
      I1 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \w_addr_reg_n_0_[3]\,
      I4 => \w_addr_reg_n_0_[4]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(31),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(31),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in10_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(3),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in7_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(4),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in4_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(5),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in1_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(6),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000200FFFFFFFF"
    )
        port map (
      I0 => wr_strb,
      I1 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \w_addr_reg_n_0_[3]\,
      I4 => \w_addr_reg_n_0_[4]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[7]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(7),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(8),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(8),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(9),
      I1 => s_axi_csr_aresetn,
      I2 => reg2_init_val(9),
      O => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(0),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(10),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(11),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(12),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(13),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(14),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(15),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(16),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(17),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(18),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(19),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(1),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(20),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(21),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(22),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(23),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(24),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(25),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(26),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(27),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(28),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(29),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(2),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(30),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(31),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(3),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(4),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(5),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(6),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(7),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(8),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(9),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[0]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(0),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][0]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(10),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(10),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][10]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(11),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(11),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][11]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(12),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(12),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][12]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(13),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(13),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][13]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(14),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(14),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][14]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00002000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[3]\,
      I1 => \w_addr_reg_n_0_[4]\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \wr_strb_reg_n_0_[1]\,
      I4 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(15),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(15),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(16),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(16),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][16]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(17),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(17),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][17]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(18),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(18),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][18]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(19),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(19),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][19]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in16_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(1),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][1]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(20),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(20),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][20]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(21),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(21),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][21]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(22),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(22),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][22]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00002000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[3]\,
      I1 => \w_addr_reg_n_0_[4]\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \wr_strb_reg_n_0_[2]\,
      I4 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(23),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(23),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(24),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(24),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][24]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(25),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(25),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][25]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(26),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(26),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][26]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(27),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(27),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][27]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(28),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(28),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][28]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(29),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(29),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][29]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in13_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(2),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][2]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(30),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(30),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][30]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00002000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[3]\,
      I1 => \w_addr_reg_n_0_[4]\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \wr_strb_reg_n_0_[3]\,
      I4 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(31),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(31),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in10_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(3),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][3]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in7_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(4),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][4]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in4_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(5),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][5]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in1_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(6),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][6]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00002000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[3]\,
      I1 => \w_addr_reg_n_0_[4]\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => wr_strb,
      I4 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[7]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(7),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(8),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(8),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][8]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg[3][9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(9),
      I1 => s_axi_csr_aresetn,
      I2 => reg3_init_val(9),
      O => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][9]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][0]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(0),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][10]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(10),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][11]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(11),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][12]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(12),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][13]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(13),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][14]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(14),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(15),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][16]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(16),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][17]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(17),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][18]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(18),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][19]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(19),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][1]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(1),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][20]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(20),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][21]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(21),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][22]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(22),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(23),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][24]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(24),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][25]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(25),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][26]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(26),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][27]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(27),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][28]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(28),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][29]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(29),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][2]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(2),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][30]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(30),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(31),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][3]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(3),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][4]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(4),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][5]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(5),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][6]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(6),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(7),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][8]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(8),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[3].cntl_reg[3][9]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(9),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[0]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(0),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][0]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(10),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(10),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][10]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(11),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(11),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][11]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(12),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(12),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][12]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(13),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(13),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][13]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(14),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(14),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][14]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000200FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[3]\,
      I2 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I3 => \wr_strb_reg_n_0_[1]\,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(15),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(15),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(16),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(16),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][16]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(17),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(17),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][17]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(18),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(18),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][18]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(19),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(19),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][19]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in16_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(1),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][1]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(20),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(20),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][20]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(21),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(21),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][21]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(22),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(22),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][22]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000200FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[3]\,
      I2 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I3 => \wr_strb_reg_n_0_[2]\,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(23),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(23),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(24),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(24),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][24]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(25),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(25),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][25]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(26),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(26),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][26]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(27),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(27),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][27]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(28),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(28),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][28]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(29),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(29),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][29]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in13_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(2),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][2]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(30),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(30),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][30]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000200FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[3]\,
      I2 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I3 => \wr_strb_reg_n_0_[3]\,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(31),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(31),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in10_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(3),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][3]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in7_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(4),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][4]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in4_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(5),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][5]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in1_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(6),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][6]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000200FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[3]\,
      I2 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I3 => wr_strb,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[7]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(7),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(8),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(8),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][8]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg[4][9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(9),
      I1 => s_axi_csr_aresetn,
      I2 => reg4_init_val(9),
      O => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][9]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][0]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(0),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][10]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(10),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][11]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(11),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][12]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(12),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][13]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(13),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][14]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(14),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(15),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][16]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(16),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][17]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(17),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][18]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(18),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][19]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(19),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][1]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(1),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][20]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(20),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][21]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(21),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][22]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(22),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(23),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][24]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(24),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][25]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(25),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][26]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(26),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][27]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(27),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][28]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(28),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][29]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(29),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][2]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(2),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][30]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(30),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(31),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][3]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(3),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][4]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(4),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][5]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(5),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][6]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(6),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(7),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][8]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(8),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[4].cntl_reg[4][9]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(9),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[0]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(0),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][0]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(10),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(10),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][10]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(11),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(11),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][11]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(12),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(12),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][12]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(13),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(13),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][13]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(14),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(14),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][14]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02000000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[3]\,
      I2 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I3 => \wr_strb_reg_n_0_[1]\,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(15),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(15),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(16),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(16),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][16]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(17),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(17),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][17]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(18),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(18),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][18]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(19),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(19),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][19]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in16_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(1),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][1]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(20),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(20),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][20]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(21),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(21),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][21]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(22),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(22),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][22]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02000000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[3]\,
      I2 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I3 => \wr_strb_reg_n_0_[2]\,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(23),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(23),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(24),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(24),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][24]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(25),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(25),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][25]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(26),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(26),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][26]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(27),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(27),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][27]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(28),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(28),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][28]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(29),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(29),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][29]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in13_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(2),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][2]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(30),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(30),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][30]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02000000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[3]\,
      I2 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I3 => \wr_strb_reg_n_0_[3]\,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(31),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(31),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in10_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(3),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][3]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in7_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(4),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][4]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in4_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(5),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][5]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in1_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(6),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][6]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02000000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[3]\,
      I2 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I3 => wr_strb,
      I4 => \w_addr_reg_n_0_[2]\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[7]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(7),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(8),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(8),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][8]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg[5][9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(9),
      I1 => s_axi_csr_aresetn,
      I2 => reg5_init_val(9),
      O => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][9]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][0]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(0),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][10]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(10),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][11]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(11),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][12]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(12),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][13]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(13),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][14]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(14),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(15),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][16]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(16),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][17]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(17),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][18]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(18),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][19]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(19),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][1]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(1),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][20]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(20),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][21]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(21),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][22]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(22),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(23),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][24]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(24),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][25]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(25),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][26]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(26),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][27]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(27),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][28]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(28),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][29]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(29),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][2]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(2),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][30]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(30),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(31),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][3]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(3),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][4]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(4),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][5]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(5),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][6]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(6),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(7),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][8]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(8),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[5].cntl_reg[5][9]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(9),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[0]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(0),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][0]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(10),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(10),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][10]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(11),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(11),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][11]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(12),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(12),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][12]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(13),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(13),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][13]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(14),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(14),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][14]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00002000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[2]\,
      I2 => \w_addr_reg_n_0_[3]\,
      I3 => \wr_strb_reg_n_0_[1]\,
      I4 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(15),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(15),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(16),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(16),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][16]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(17),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(17),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][17]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(18),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(18),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][18]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(19),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(19),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][19]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in16_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(1),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][1]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(20),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(20),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][20]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(21),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(21),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][21]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(22),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(22),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][22]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00002000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[2]\,
      I2 => \w_addr_reg_n_0_[3]\,
      I3 => \wr_strb_reg_n_0_[2]\,
      I4 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(23),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(23),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(24),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(24),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][24]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(25),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(25),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][25]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(26),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(26),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][26]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(27),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(27),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][27]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(28),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(28),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][28]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(29),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(29),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][29]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in13_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(2),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][2]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(30),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(30),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][30]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00002000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[2]\,
      I2 => \w_addr_reg_n_0_[3]\,
      I3 => \wr_strb_reg_n_0_[3]\,
      I4 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(31),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(31),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in10_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(3),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][3]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in7_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(4),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][4]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in4_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(5),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][5]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_1_in1_in,
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(6),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][6]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00002000FFFFFFFF"
    )
        port map (
      I0 => \w_addr_reg_n_0_[4]\,
      I1 => \w_addr_reg_n_0_[2]\,
      I2 => \w_addr_reg_n_0_[3]\,
      I3 => wr_strb,
      I4 => \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0\,
      I5 => s_axi_csr_aresetn,
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \w_data_reg_n_0_[7]\,
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(7),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_2_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(8),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(8),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][8]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg[6][9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => w_data(9),
      I1 => s_axi_csr_aresetn,
      I2 => reg6_init_val(9),
      O => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][9]_i_1_n_0\
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][0]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(0),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][10]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(10),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][11]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(11),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][12]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(12),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][13]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(13),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][14]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(14),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(15),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][16]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(16),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][17]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(17),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][18]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(18),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][19]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(19),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][1]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(1),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][20]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(20),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][21]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(21),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][22]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(22),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(23),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][24]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(24),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][25]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(25),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][26]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(26),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][27]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(27),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][28]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(28),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][29]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(29),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][2]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(2),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][30]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(30),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(31),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][3]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(3),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][4]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(4),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][5]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(5),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][6]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(6),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_2_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(7),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][8]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(8),
      R => '0'
    );
\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0\,
      D => \gen_cntl.gen_ctl_regs[6].cntl_reg[6][9]_i_1_n_0\,
      Q => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(9),
      R => '0'
    );
\gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFFFFFAAAAAAAA"
    )
        port map (
      I0 => p_93_out(0),
      I1 => wr_strb,
      I2 => p_67_in,
      I3 => w_we_reg_n_0,
      I4 => \w_data_reg_n_0_[0]\,
      I5 => int_flag_reg(0),
      O => \gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1_n_0\
    );
\gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1_n_0\,
      Q => int_flag_reg(0),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEEEEEEEEEEEEEEE"
    )
        port map (
      I0 => p_93_out(1),
      I1 => int_flag_reg(1),
      I2 => p_1_in16_in,
      I3 => wr_strb,
      I4 => p_67_in,
      I5 => w_we_reg_n_0,
      O => \gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1_n_0\
    );
\gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1_n_0\,
      Q => int_flag_reg(1),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_flag.gen_int_flag_reg[2].int_flag_reg[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEEEEEEEEEEEEEEE"
    )
        port map (
      I0 => p_93_out(2),
      I1 => int_flag_reg(2),
      I2 => p_1_in13_in,
      I3 => wr_strb,
      I4 => p_67_in,
      I5 => w_we_reg_n_0,
      O => \gen_int.gen_int_flag.gen_int_flag_reg[2].int_flag_reg[2]_i_1_n_0\
    );
\gen_int.gen_int_flag.gen_int_flag_reg[2].int_flag_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_flag.gen_int_flag_reg[2].int_flag_reg[2]_i_1_n_0\,
      Q => int_flag_reg(2),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_flag.gen_int_flag_reg[3].int_flag_reg[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFFFFFAAAAAAAA"
    )
        port map (
      I0 => p_93_out(3),
      I1 => wr_strb,
      I2 => p_67_in,
      I3 => w_we_reg_n_0,
      I4 => p_1_in10_in,
      I5 => int_flag_reg(3),
      O => \gen_int.gen_int_flag.gen_int_flag_reg[3].int_flag_reg[3]_i_1_n_0\
    );
\gen_int.gen_int_flag.gen_int_flag_reg[3].int_flag_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_flag.gen_int_flag_reg[3].int_flag_reg[3]_i_1_n_0\,
      Q => int_flag_reg(3),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_flag.gen_int_flag_reg[4].int_flag_reg[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFFFFFAAAAAAAA"
    )
        port map (
      I0 => p_93_out(4),
      I1 => wr_strb,
      I2 => p_67_in,
      I3 => w_we_reg_n_0,
      I4 => p_1_in7_in,
      I5 => int_flag_reg(4),
      O => \gen_int.gen_int_flag.gen_int_flag_reg[4].int_flag_reg[4]_i_1_n_0\
    );
\gen_int.gen_int_flag.gen_int_flag_reg[4].int_flag_reg_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_flag.gen_int_flag_reg[4].int_flag_reg[4]_i_1_n_0\,
      Q => int_flag_reg(4),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_flag.gen_int_flag_reg[5].int_flag_reg[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEEEEEEEEEEEEEEE"
    )
        port map (
      I0 => p_93_out(5),
      I1 => int_flag_reg(5),
      I2 => p_1_in4_in,
      I3 => wr_strb,
      I4 => p_67_in,
      I5 => w_we_reg_n_0,
      O => \gen_int.gen_int_flag.gen_int_flag_reg[5].int_flag_reg[5]_i_1_n_0\
    );
\gen_int.gen_int_flag.gen_int_flag_reg[5].int_flag_reg_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_flag.gen_int_flag_reg[5].int_flag_reg[5]_i_1_n_0\,
      Q => int_flag_reg(5),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_flag.gen_int_flag_reg[6].int_flag_reg[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEEEEEEEEEEEEEEE"
    )
        port map (
      I0 => p_93_out(6),
      I1 => int_flag_reg(6),
      I2 => p_1_in1_in,
      I3 => wr_strb,
      I4 => p_67_in,
      I5 => w_we_reg_n_0,
      O => \gen_int.gen_int_flag.gen_int_flag_reg[6].int_flag_reg[6]_i_1_n_0\
    );
\gen_int.gen_int_flag.gen_int_flag_reg[6].int_flag_reg_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_flag.gen_int_flag_reg[6].int_flag_reg[6]_i_1_n_0\,
      Q => int_flag_reg(6),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFFFFFAAAAAAAA"
    )
        port map (
      I0 => p_93_out(7),
      I1 => wr_strb,
      I2 => p_67_in,
      I3 => w_we_reg_n_0,
      I4 => \w_data_reg_n_0_[7]\,
      I5 => int_flag_reg(7),
      O => \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_1_n_0\
    );
\gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \w_addr_reg_n_0_[5]\,
      O => \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_3_n_0\
    );
\gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \w_addr_reg_n_0_[2]\,
      I1 => \w_addr_reg_n_0_[3]\,
      I2 => \w_addr_reg_n_0_[4]\,
      O => \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_4_n_0\
    );
\gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_1_n_0\,
      Q => int_flag_reg(7),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]_i_2\: unisim.vcomponents.CARRY8
     port map (
      CI => '1',
      CI_TOP => '0',
      CO(7 downto 2) => \NLW_gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]_i_2_CO_UNCONNECTED\(7 downto 2),
      CO(1) => p_67_in,
      CO(0) => \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]_i_2_n_7\,
      DI(7 downto 2) => \NLW_gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]_i_2_DI_UNCONNECTED\(7 downto 2),
      DI(1) => '0',
      DI(0) => '0',
      O(7 downto 0) => \NLW_gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]_i_2_O_UNCONNECTED\(7 downto 0),
      S(7 downto 2) => \NLW_gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7]_i_2_S_UNCONNECTED\(7 downto 2),
      S(1) => \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_3_n_0\,
      S(0) => \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_4_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[0].int_and[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \gen_int.int_en_reg_reg_n_0_[0]\,
      I1 => p_93_out(0),
      O => \gen_int.gen_int_src.gen_int_src_reg[0].int_and[0]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[0].int_and_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[0].int_and[0]_i_1_n_0\,
      Q => p_92_out(0),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[0].re_int[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => p_95_out(0),
      I1 => p_94_out(0),
      O => \gen_int.gen_int_src.gen_int_src_reg[0].re_int[0]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[0].re_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[0].re_int[0]_i_1_n_0\,
      Q => p_93_out(0),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[0].t1_intrpt_src_in_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => intrpt_src_in(0),
      Q => p_95_out(0),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[0].t2_intrpt_src_in_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => p_95_out(0),
      Q => p_94_out(0),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[1].int_and[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in99_in,
      I1 => p_93_out(1),
      O => \gen_int.gen_int_src.gen_int_src_reg[1].int_and[1]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[1].int_and_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[1].int_and[1]_i_1_n_0\,
      Q => p_92_out(1),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[1].re_int[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => p_95_out(1),
      I1 => p_94_out(1),
      O => \gen_int.gen_int_src.gen_int_src_reg[1].re_int[1]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[1].re_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[1].re_int[1]_i_1_n_0\,
      Q => p_93_out(1),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[1].t1_intrpt_src_in_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => intrpt_src_in(1),
      Q => p_95_out(1),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[1].t2_intrpt_src_in_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => p_95_out(1),
      Q => p_94_out(1),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[2].int_and[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in94_in,
      I1 => p_93_out(2),
      O => \gen_int.gen_int_src.gen_int_src_reg[2].int_and[2]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[2].int_and_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[2].int_and[2]_i_1_n_0\,
      Q => p_92_out(2),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[2].re_int[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => p_95_out(2),
      I1 => p_94_out(2),
      O => \gen_int.gen_int_src.gen_int_src_reg[2].re_int[2]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[2].re_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[2].re_int[2]_i_1_n_0\,
      Q => p_93_out(2),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[2].t1_intrpt_src_in_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => intrpt_src_in(2),
      Q => p_95_out(2),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[2].t2_intrpt_src_in_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => p_95_out(2),
      Q => p_94_out(2),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[3].int_and[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in89_in,
      I1 => p_93_out(3),
      O => \gen_int.gen_int_src.gen_int_src_reg[3].int_and[3]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[3].int_and_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[3].int_and[3]_i_1_n_0\,
      Q => p_92_out(3),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[3].re_int[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => p_95_out(3),
      I1 => p_94_out(3),
      O => \gen_int.gen_int_src.gen_int_src_reg[3].re_int[3]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[3].re_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[3].re_int[3]_i_1_n_0\,
      Q => p_93_out(3),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[3].t1_intrpt_src_in_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => intrpt_src_in(3),
      Q => p_95_out(3),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[3].t2_intrpt_src_in_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => p_95_out(3),
      Q => p_94_out(3),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[4].int_and[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in84_in,
      I1 => p_93_out(4),
      O => \gen_int.gen_int_src.gen_int_src_reg[4].int_and[4]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[4].int_and_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[4].int_and[4]_i_1_n_0\,
      Q => p_92_out(4),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[4].re_int[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => p_95_out(4),
      I1 => p_94_out(4),
      O => \gen_int.gen_int_src.gen_int_src_reg[4].re_int[4]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[4].re_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[4].re_int[4]_i_1_n_0\,
      Q => p_93_out(4),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[4].t1_intrpt_src_in_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => intrpt_src_in(4),
      Q => p_95_out(4),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[4].t2_intrpt_src_in_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => p_95_out(4),
      Q => p_94_out(4),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[5].int_and[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in79_in,
      I1 => p_93_out(5),
      O => \gen_int.gen_int_src.gen_int_src_reg[5].int_and[5]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[5].int_and_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[5].int_and[5]_i_1_n_0\,
      Q => p_92_out(5),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[5].re_int[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => p_95_out(5),
      I1 => p_94_out(5),
      O => \gen_int.gen_int_src.gen_int_src_reg[5].re_int[5]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[5].re_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[5].re_int[5]_i_1_n_0\,
      Q => p_93_out(5),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[5].t1_intrpt_src_in_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => intrpt_src_in(5),
      Q => p_95_out(5),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[5].t2_intrpt_src_in_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => p_95_out(5),
      Q => p_94_out(5),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[6].int_and[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in74_in,
      I1 => p_93_out(6),
      O => \gen_int.gen_int_src.gen_int_src_reg[6].int_and[6]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[6].int_and_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[6].int_and[6]_i_1_n_0\,
      Q => p_92_out(6),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[6].re_int[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => p_95_out(6),
      I1 => p_94_out(6),
      O => \gen_int.gen_int_src.gen_int_src_reg[6].re_int[6]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[6].re_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[6].re_int[6]_i_1_n_0\,
      Q => p_93_out(6),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[6].t1_intrpt_src_in_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => intrpt_src_in(6),
      Q => p_95_out(6),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[6].t2_intrpt_src_in_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => p_95_out(6),
      Q => p_94_out(6),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[7].int_and[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in69_in,
      I1 => p_93_out(7),
      O => \gen_int.gen_int_src.gen_int_src_reg[7].int_and[7]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[7].int_and_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[7].int_and[7]_i_1_n_0\,
      Q => p_92_out(7),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[7].re_int[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => p_95_out(7),
      I1 => p_94_out(7),
      O => \gen_int.gen_int_src.gen_int_src_reg[7].re_int[7]_i_1_n_0\
    );
\gen_int.gen_int_src.gen_int_src_reg[7].re_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.gen_int_src.gen_int_src_reg[7].re_int[7]_i_1_n_0\,
      Q => p_93_out(7),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[7].t1_intrpt_src_in_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => intrpt_src_in(7),
      Q => p_95_out(7),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.gen_int_src.gen_int_src_reg[7].t2_intrpt_src_in_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => p_95_out(7),
      Q => p_94_out(7),
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000800000000"
    )
        port map (
      I0 => w_we_reg_n_0,
      I1 => \w_addr_reg_n_0_[5]\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \w_addr_reg_n_0_[4]\,
      I4 => \w_addr_reg_n_0_[3]\,
      I5 => \wr_strb_reg_n_0_[1]\,
      O => p_1_in(15)
    );
\gen_int.int_en_reg[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000800000000"
    )
        port map (
      I0 => w_we_reg_n_0,
      I1 => \w_addr_reg_n_0_[5]\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \w_addr_reg_n_0_[4]\,
      I4 => \w_addr_reg_n_0_[3]\,
      I5 => \wr_strb_reg_n_0_[2]\,
      O => p_1_in(23)
    );
\gen_int.int_en_reg[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0100000000000000"
    )
        port map (
      I0 => \w_addr_reg_n_0_[2]\,
      I1 => \w_addr_reg_n_0_[4]\,
      I2 => \w_addr_reg_n_0_[3]\,
      I3 => \wr_strb_reg_n_0_[3]\,
      I4 => w_we_reg_n_0,
      I5 => \w_addr_reg_n_0_[5]\,
      O => p_1_in(31)
    );
\gen_int.int_en_reg[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000800000000"
    )
        port map (
      I0 => w_we_reg_n_0,
      I1 => \w_addr_reg_n_0_[5]\,
      I2 => \w_addr_reg_n_0_[2]\,
      I3 => \w_addr_reg_n_0_[4]\,
      I4 => \w_addr_reg_n_0_[3]\,
      I5 => wr_strb,
      O => p_1_in(7)
    );
\gen_int.int_en_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(7),
      D => \w_data_reg_n_0_[0]\,
      Q => \gen_int.int_en_reg_reg_n_0_[0]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(15),
      D => w_data(10),
      Q => \gen_int.int_en_reg_reg_n_0_[10]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(15),
      D => w_data(11),
      Q => \gen_int.int_en_reg_reg_n_0_[11]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(15),
      D => w_data(12),
      Q => \gen_int.int_en_reg_reg_n_0_[12]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(15),
      D => w_data(13),
      Q => \gen_int.int_en_reg_reg_n_0_[13]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(15),
      D => w_data(14),
      Q => \gen_int.int_en_reg_reg_n_0_[14]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(15),
      D => w_data(15),
      Q => \gen_int.int_en_reg_reg_n_0_[15]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(23),
      D => w_data(16),
      Q => \gen_int.int_en_reg_reg_n_0_[16]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(23),
      D => w_data(17),
      Q => \gen_int.int_en_reg_reg_n_0_[17]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(23),
      D => w_data(18),
      Q => \gen_int.int_en_reg_reg_n_0_[18]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(23),
      D => w_data(19),
      Q => \gen_int.int_en_reg_reg_n_0_[19]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(7),
      D => p_1_in16_in,
      Q => p_0_in99_in,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(23),
      D => w_data(20),
      Q => \gen_int.int_en_reg_reg_n_0_[20]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(23),
      D => w_data(21),
      Q => \gen_int.int_en_reg_reg_n_0_[21]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(23),
      D => w_data(22),
      Q => \gen_int.int_en_reg_reg_n_0_[22]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(23),
      D => w_data(23),
      Q => \gen_int.int_en_reg_reg_n_0_[23]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(31),
      D => w_data(24),
      Q => \gen_int.int_en_reg_reg_n_0_[24]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(31),
      D => w_data(25),
      Q => \gen_int.int_en_reg_reg_n_0_[25]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(31),
      D => w_data(26),
      Q => \gen_int.int_en_reg_reg_n_0_[26]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(31),
      D => w_data(27),
      Q => \gen_int.int_en_reg_reg_n_0_[27]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(31),
      D => w_data(28),
      Q => \gen_int.int_en_reg_reg_n_0_[28]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(31),
      D => w_data(29),
      Q => \gen_int.int_en_reg_reg_n_0_[29]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(7),
      D => p_1_in13_in,
      Q => p_0_in94_in,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(31),
      D => w_data(30),
      Q => \gen_int.int_en_reg_reg_n_0_[30]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(31),
      D => w_data(31),
      Q => \gen_int.int_en_reg_reg_n_0_[31]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(7),
      D => p_1_in10_in,
      Q => p_0_in89_in,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(7),
      D => p_1_in7_in,
      Q => p_0_in84_in,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(7),
      D => p_1_in4_in,
      Q => p_0_in79_in,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(7),
      D => p_1_in1_in,
      Q => p_0_in74_in,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(7),
      D => \w_data_reg_n_0_[7]\,
      Q => p_0_in69_in,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(15),
      D => w_data(8),
      Q => \gen_int.int_en_reg_reg_n_0_[8]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.int_en_reg_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => p_1_in(15),
      D => w_data(9),
      Q => \gen_int.int_en_reg_reg_n_0_[9]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.irq_reg\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => usr_int,
      Q => irq,
      R => s_axi_csr_awready_i_1_n_0
    );
\gen_int.usr_int_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FD"
    )
        port map (
      I0 => \gen_int.usr_int_i_2_n_0\,
      I1 => p_92_out(7),
      I2 => p_92_out(6),
      O => \gen_int.usr_int_i_1_n_0\
    );
\gen_int.usr_int_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => p_92_out(5),
      I1 => p_92_out(4),
      I2 => p_92_out(1),
      I3 => p_92_out(0),
      I4 => p_92_out(3),
      I5 => p_92_out(2),
      O => \gen_int.usr_int_i_2_n_0\
    );
\gen_int.usr_int_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \gen_int.usr_int_i_1_n_0\,
      Q => usr_int,
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(0),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(0),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(10),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(10),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(11),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(11),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(12),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(12),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(13),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(13),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(14),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(14),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(15),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(15),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(16),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(16),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(17),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(17),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(18),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(18),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(19),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(19),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(1),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(1),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(20),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(20),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(21),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(21),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(22),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(22),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(23),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(23),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(24),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(24),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(25),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(25),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(26),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(26),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(27),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(27),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(28),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(28),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(29),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(29),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(2),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(2),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(30),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(30),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(31),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(31),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(3),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(3),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(4),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(4),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(5),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(5),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(6),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(6),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(7),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(7),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(8),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(8),
      R => '0'
    );
\gen_stat.gen_stat_regs[0].stat_reg_reg[0][9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => stat0_in(9),
      Q => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(9),
      R => '0'
    );
\r_addr[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000008"
    )
        port map (
      I0 => s_axi_csr_aresetn,
      I1 => state(3),
      I2 => state(2),
      I3 => state(0),
      I4 => state(1),
      O => \r_addr[5]_i_1_n_0\
    );
\r_addr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \r_addr[5]_i_1_n_0\,
      D => s_axi_csr_araddr(0),
      Q => sel0(0),
      R => '0'
    );
\r_addr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \r_addr[5]_i_1_n_0\,
      D => s_axi_csr_araddr(1),
      Q => sel0(1),
      R => '0'
    );
\r_addr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \r_addr[5]_i_1_n_0\,
      D => s_axi_csr_araddr(2),
      Q => sel0(2),
      R => '0'
    );
\r_addr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \r_addr[5]_i_1_n_0\,
      D => s_axi_csr_araddr(3),
      Q => \r_addr_reg_n_0_[5]\,
      R => '0'
    );
\rd_data[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \rd_data_reg[0]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[0]_i_3_n_0\,
      I3 => \r_addr_reg_n_0_[5]\,
      I4 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(0),
      O => \rd_data[0]_i_1_n_0\
    );
\rd_data[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => int_flag_reg(0),
      I1 => \rd_data[7]_i_6_n_0\,
      I2 => p_94_out(0),
      I3 => sel0(0),
      I4 => \gen_int.int_en_reg_reg_n_0_[0]\,
      O => \rd_data[0]_i_3_n_0\
    );
\rd_data[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(0),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(0),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(0),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(0),
      O => \rd_data[0]_i_4_n_0\
    );
\rd_data[0]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(0),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(0),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(0),
      O => \rd_data[0]_i_5_n_0\
    );
\rd_data[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[10]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[10]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(10),
      O => \rd_data[10]_i_1_n_0\
    );
\rd_data[10]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(10),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(10),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(10),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(10),
      O => \rd_data[10]_i_3_n_0\
    );
\rd_data[10]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(10),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(10),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(10),
      O => \rd_data[10]_i_4_n_0\
    );
\rd_data[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[11]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[11]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(11),
      O => \rd_data[11]_i_1_n_0\
    );
\rd_data[11]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(11),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(11),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(11),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(11),
      O => \rd_data[11]_i_3_n_0\
    );
\rd_data[11]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(11),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(11),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(11),
      O => \rd_data[11]_i_4_n_0\
    );
\rd_data[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[12]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[12]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(12),
      O => \rd_data[12]_i_1_n_0\
    );
\rd_data[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(12),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(12),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(12),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(12),
      O => \rd_data[12]_i_3_n_0\
    );
\rd_data[12]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(12),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(12),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(12),
      O => \rd_data[12]_i_4_n_0\
    );
\rd_data[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[13]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[13]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(13),
      O => \rd_data[13]_i_1_n_0\
    );
\rd_data[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(13),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(13),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(13),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(13),
      O => \rd_data[13]_i_3_n_0\
    );
\rd_data[13]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(13),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(13),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(13),
      O => \rd_data[13]_i_4_n_0\
    );
\rd_data[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[14]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[14]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(14),
      O => \rd_data[14]_i_1_n_0\
    );
\rd_data[14]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(14),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(14),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(14),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(14),
      O => \rd_data[14]_i_3_n_0\
    );
\rd_data[14]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(14),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(14),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(14),
      O => \rd_data[14]_i_4_n_0\
    );
\rd_data[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[15]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[15]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(15),
      O => \rd_data[15]_i_1_n_0\
    );
\rd_data[15]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(15),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(15),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(15),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(15),
      O => \rd_data[15]_i_3_n_0\
    );
\rd_data[15]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(15),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(15),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(15),
      O => \rd_data[15]_i_4_n_0\
    );
\rd_data[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[16]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[16]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(16),
      O => \rd_data[16]_i_1_n_0\
    );
\rd_data[16]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(16),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(16),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(16),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(16),
      O => \rd_data[16]_i_3_n_0\
    );
\rd_data[16]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(16),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(16),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(16),
      O => \rd_data[16]_i_4_n_0\
    );
\rd_data[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[17]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[17]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(17),
      O => \rd_data[17]_i_1_n_0\
    );
\rd_data[17]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(17),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(17),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(17),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(17),
      O => \rd_data[17]_i_3_n_0\
    );
\rd_data[17]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(17),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(17),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(17),
      O => \rd_data[17]_i_4_n_0\
    );
\rd_data[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[18]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[18]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(18),
      O => \rd_data[18]_i_1_n_0\
    );
\rd_data[18]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(18),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(18),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(18),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(18),
      O => \rd_data[18]_i_3_n_0\
    );
\rd_data[18]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(18),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(18),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(18),
      O => \rd_data[18]_i_4_n_0\
    );
\rd_data[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[19]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[19]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(19),
      O => \rd_data[19]_i_1_n_0\
    );
\rd_data[19]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(19),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(19),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(19),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(19),
      O => \rd_data[19]_i_3_n_0\
    );
\rd_data[19]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(19),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(19),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(19),
      O => \rd_data[19]_i_4_n_0\
    );
\rd_data[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFE2E2E2"
    )
        port map (
      I0 => \rd_data[1]_i_2_n_0\,
      I1 => \r_addr_reg_n_0_[5]\,
      I2 => \rd_data[1]_i_3_n_0\,
      I3 => \rd_data[31]_i_3_n_0\,
      I4 => \rd_data_reg[1]_i_4_n_0\,
      O => \rd_data[1]_i_1_n_0\
    );
\rd_data[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => sel0(1),
      I1 => sel0(2),
      I2 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(1),
      I3 => sel0(0),
      O => \rd_data[1]_i_2_n_0\
    );
\rd_data[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => int_flag_reg(1),
      I1 => \rd_data[7]_i_6_n_0\,
      I2 => p_94_out(1),
      I3 => sel0(0),
      I4 => p_0_in99_in,
      O => \rd_data[1]_i_3_n_0\
    );
\rd_data[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(1),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(1),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(1),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(1),
      O => \rd_data[1]_i_5_n_0\
    );
\rd_data[1]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(1),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(1),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(1),
      O => \rd_data[1]_i_6_n_0\
    );
\rd_data[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[20]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[20]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(20),
      O => \rd_data[20]_i_1_n_0\
    );
\rd_data[20]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(20),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(20),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(20),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(20),
      O => \rd_data[20]_i_3_n_0\
    );
\rd_data[20]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(20),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(20),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(20),
      O => \rd_data[20]_i_4_n_0\
    );
\rd_data[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[21]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[21]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(21),
      O => \rd_data[21]_i_1_n_0\
    );
\rd_data[21]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(21),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(21),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(21),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(21),
      O => \rd_data[21]_i_3_n_0\
    );
\rd_data[21]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(21),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(21),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(21),
      O => \rd_data[21]_i_4_n_0\
    );
\rd_data[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[22]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[22]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(22),
      O => \rd_data[22]_i_1_n_0\
    );
\rd_data[22]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(22),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(22),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(22),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(22),
      O => \rd_data[22]_i_3_n_0\
    );
\rd_data[22]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(22),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(22),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(22),
      O => \rd_data[22]_i_4_n_0\
    );
\rd_data[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[23]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[23]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(23),
      O => \rd_data[23]_i_1_n_0\
    );
\rd_data[23]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(23),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(23),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(23),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(23),
      O => \rd_data[23]_i_3_n_0\
    );
\rd_data[23]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(23),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(23),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(23),
      O => \rd_data[23]_i_4_n_0\
    );
\rd_data[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[24]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[24]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(24),
      O => \rd_data[24]_i_1_n_0\
    );
\rd_data[24]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(24),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(24),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(24),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(24),
      O => \rd_data[24]_i_3_n_0\
    );
\rd_data[24]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(24),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(24),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(24),
      O => \rd_data[24]_i_4_n_0\
    );
\rd_data[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[25]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[25]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(25),
      O => \rd_data[25]_i_1_n_0\
    );
\rd_data[25]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(25),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(25),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(25),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(25),
      O => \rd_data[25]_i_3_n_0\
    );
\rd_data[25]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(25),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(25),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(25),
      O => \rd_data[25]_i_4_n_0\
    );
\rd_data[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[26]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[26]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(26),
      O => \rd_data[26]_i_1_n_0\
    );
\rd_data[26]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(26),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(26),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(26),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(26),
      O => \rd_data[26]_i_3_n_0\
    );
\rd_data[26]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(26),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(26),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(26),
      O => \rd_data[26]_i_4_n_0\
    );
\rd_data[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[27]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[27]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(27),
      O => \rd_data[27]_i_1_n_0\
    );
\rd_data[27]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(27),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(27),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(27),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(27),
      O => \rd_data[27]_i_3_n_0\
    );
\rd_data[27]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(27),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(27),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(27),
      O => \rd_data[27]_i_4_n_0\
    );
\rd_data[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[28]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[28]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(28),
      O => \rd_data[28]_i_1_n_0\
    );
\rd_data[28]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(28),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(28),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(28),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(28),
      O => \rd_data[28]_i_3_n_0\
    );
\rd_data[28]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(28),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(28),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(28),
      O => \rd_data[28]_i_4_n_0\
    );
\rd_data[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[29]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[29]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(29),
      O => \rd_data[29]_i_1_n_0\
    );
\rd_data[29]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(29),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(29),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(29),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(29),
      O => \rd_data[29]_i_3_n_0\
    );
\rd_data[29]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(29),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(29),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(29),
      O => \rd_data[29]_i_4_n_0\
    );
\rd_data[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFE2E2E2"
    )
        port map (
      I0 => \rd_data[2]_i_2_n_0\,
      I1 => \r_addr_reg_n_0_[5]\,
      I2 => \rd_data[2]_i_3_n_0\,
      I3 => \rd_data[31]_i_3_n_0\,
      I4 => \rd_data_reg[2]_i_4_n_0\,
      O => \rd_data[2]_i_1_n_0\
    );
\rd_data[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => sel0(1),
      I1 => sel0(2),
      I2 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(2),
      I3 => sel0(0),
      O => \rd_data[2]_i_2_n_0\
    );
\rd_data[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => int_flag_reg(2),
      I1 => \rd_data[7]_i_6_n_0\,
      I2 => p_94_out(2),
      I3 => sel0(0),
      I4 => p_0_in94_in,
      O => \rd_data[2]_i_3_n_0\
    );
\rd_data[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(2),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(2),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(2),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(2),
      O => \rd_data[2]_i_5_n_0\
    );
\rd_data[2]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(2),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(2),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(2),
      O => \rd_data[2]_i_6_n_0\
    );
\rd_data[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[30]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[30]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(30),
      O => \rd_data[30]_i_1_n_0\
    );
\rd_data[30]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(30),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(30),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(30),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(30),
      O => \rd_data[30]_i_3_n_0\
    );
\rd_data[30]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(30),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(30),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(30),
      O => \rd_data[30]_i_4_n_0\
    );
\rd_data[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[31]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[31]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(31),
      O => \rd_data[31]_i_1_n_0\
    );
\rd_data[31]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1555"
    )
        port map (
      I0 => \r_addr_reg_n_0_[5]\,
      I1 => sel0(0),
      I2 => sel0(1),
      I3 => sel0(2),
      O => \rd_data[31]_i_3_n_0\
    );
\rd_data[31]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(1),
      I2 => \r_addr_reg_n_0_[5]\,
      I3 => sel0(0),
      O => \rd_data[31]_i_4_n_0\
    );
\rd_data[31]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(31),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(31),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(31),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(31),
      O => \rd_data[31]_i_5_n_0\
    );
\rd_data[31]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(31),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(31),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(31),
      O => \rd_data[31]_i_6_n_0\
    );
\rd_data[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \rd_data_reg[3]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[3]_i_3_n_0\,
      I3 => \r_addr_reg_n_0_[5]\,
      I4 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(3),
      O => \rd_data[3]_i_1_n_0\
    );
\rd_data[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => int_flag_reg(3),
      I1 => \rd_data[7]_i_6_n_0\,
      I2 => p_94_out(3),
      I3 => sel0(0),
      I4 => p_0_in89_in,
      O => \rd_data[3]_i_3_n_0\
    );
\rd_data[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(3),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(3),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(3),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(3),
      O => \rd_data[3]_i_4_n_0\
    );
\rd_data[3]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(3),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(3),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(3),
      O => \rd_data[3]_i_5_n_0\
    );
\rd_data[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \rd_data_reg[4]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[4]_i_3_n_0\,
      I3 => \r_addr_reg_n_0_[5]\,
      I4 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(4),
      O => \rd_data[4]_i_1_n_0\
    );
\rd_data[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => int_flag_reg(4),
      I1 => \rd_data[7]_i_6_n_0\,
      I2 => p_94_out(4),
      I3 => sel0(0),
      I4 => p_0_in84_in,
      O => \rd_data[4]_i_3_n_0\
    );
\rd_data[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(4),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(4),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(4),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(4),
      O => \rd_data[4]_i_4_n_0\
    );
\rd_data[4]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(4),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(4),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(4),
      O => \rd_data[4]_i_5_n_0\
    );
\rd_data[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFE2E2E2"
    )
        port map (
      I0 => \rd_data[5]_i_2_n_0\,
      I1 => \r_addr_reg_n_0_[5]\,
      I2 => \rd_data[5]_i_3_n_0\,
      I3 => \rd_data[31]_i_3_n_0\,
      I4 => \rd_data_reg[5]_i_4_n_0\,
      O => \rd_data[5]_i_1_n_0\
    );
\rd_data[5]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => sel0(1),
      I1 => sel0(2),
      I2 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(5),
      I3 => sel0(0),
      O => \rd_data[5]_i_2_n_0\
    );
\rd_data[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => int_flag_reg(5),
      I1 => \rd_data[7]_i_6_n_0\,
      I2 => p_94_out(5),
      I3 => sel0(0),
      I4 => p_0_in79_in,
      O => \rd_data[5]_i_3_n_0\
    );
\rd_data[5]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(5),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(5),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(5),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(5),
      O => \rd_data[5]_i_5_n_0\
    );
\rd_data[5]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(5),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(5),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(5),
      O => \rd_data[5]_i_6_n_0\
    );
\rd_data[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CACFCAC0"
    )
        port map (
      I0 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(6),
      I1 => \rd_data[6]_i_2_n_0\,
      I2 => \r_addr_reg_n_0_[5]\,
      I3 => \rd_data[6]_i_3_n_0\,
      I4 => \rd_data_reg[6]_i_4_n_0\,
      O => \rd_data[6]_i_1_n_0\
    );
\rd_data[6]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => int_flag_reg(6),
      I1 => \rd_data[7]_i_6_n_0\,
      I2 => p_94_out(6),
      I3 => sel0(0),
      I4 => p_0_in74_in,
      O => \rd_data[6]_i_2_n_0\
    );
\rd_data[6]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(1),
      I2 => sel0(0),
      O => \rd_data[6]_i_3_n_0\
    );
\rd_data[6]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(6),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(6),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(6),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(6),
      O => \rd_data[6]_i_5_n_0\
    );
\rd_data[6]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(6),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(6),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(6),
      O => \rd_data[6]_i_6_n_0\
    );
\rd_data[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => \rd_data_reg[7]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[7]_i_3_n_0\,
      I3 => \r_addr_reg_n_0_[5]\,
      I4 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(7),
      O => \rd_data[7]_i_1_n_0\
    );
\rd_data[7]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => int_flag_reg(7),
      I1 => \rd_data[7]_i_6_n_0\,
      I2 => p_94_out(7),
      I3 => sel0(0),
      I4 => p_0_in69_in,
      O => \rd_data[7]_i_3_n_0\
    );
\rd_data[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(7),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(7),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(7),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(7),
      O => \rd_data[7]_i_4_n_0\
    );
\rd_data[7]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(7),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(7),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(7),
      O => \rd_data[7]_i_5_n_0\
    );
\rd_data[7]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(1),
      I2 => \r_addr_reg_n_0_[5]\,
      O => \rd_data[7]_i_6_n_0\
    );
\rd_data[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[8]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[8]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(8),
      O => \rd_data[8]_i_1_n_0\
    );
\rd_data[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(8),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(8),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(8),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(8),
      O => \rd_data[8]_i_3_n_0\
    );
\rd_data[8]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(8),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(8),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(8),
      O => \rd_data[8]_i_4_n_0\
    );
\rd_data[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8B88BBBB8B888B88"
    )
        port map (
      I0 => \rd_data_reg[9]_i_2_n_0\,
      I1 => \rd_data[31]_i_3_n_0\,
      I2 => \rd_data[31]_i_4_n_0\,
      I3 => \gen_int.int_en_reg_reg_n_0_[9]\,
      I4 => \r_addr_reg_n_0_[5]\,
      I5 => \gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0\(9),
      O => \rd_data[9]_i_1_n_0\
    );
\rd_data[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4\(9),
      I1 => \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3\(9),
      I2 => sel0(1),
      I3 => \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2\(9),
      I4 => sel0(0),
      I5 => \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1\(9),
      O => \rd_data[9]_i_3_n_0\
    );
\rd_data[9]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7\(9),
      I1 => sel0(1),
      I2 => \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6\(9),
      I3 => sel0(0),
      I4 => \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5\(9),
      O => \rd_data[9]_i_4_n_0\
    );
\rd_data_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[0]_i_1_n_0\,
      Q => rd_data(0),
      R => '0'
    );
\rd_data_reg[0]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[0]_i_4_n_0\,
      I1 => \rd_data[0]_i_5_n_0\,
      O => \rd_data_reg[0]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[10]_i_1_n_0\,
      Q => rd_data(10),
      R => '0'
    );
\rd_data_reg[10]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[10]_i_3_n_0\,
      I1 => \rd_data[10]_i_4_n_0\,
      O => \rd_data_reg[10]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[11]_i_1_n_0\,
      Q => rd_data(11),
      R => '0'
    );
\rd_data_reg[11]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[11]_i_3_n_0\,
      I1 => \rd_data[11]_i_4_n_0\,
      O => \rd_data_reg[11]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[12]_i_1_n_0\,
      Q => rd_data(12),
      R => '0'
    );
\rd_data_reg[12]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[12]_i_3_n_0\,
      I1 => \rd_data[12]_i_4_n_0\,
      O => \rd_data_reg[12]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[13]_i_1_n_0\,
      Q => rd_data(13),
      R => '0'
    );
\rd_data_reg[13]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[13]_i_3_n_0\,
      I1 => \rd_data[13]_i_4_n_0\,
      O => \rd_data_reg[13]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[14]_i_1_n_0\,
      Q => rd_data(14),
      R => '0'
    );
\rd_data_reg[14]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[14]_i_3_n_0\,
      I1 => \rd_data[14]_i_4_n_0\,
      O => \rd_data_reg[14]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[15]_i_1_n_0\,
      Q => rd_data(15),
      R => '0'
    );
\rd_data_reg[15]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[15]_i_3_n_0\,
      I1 => \rd_data[15]_i_4_n_0\,
      O => \rd_data_reg[15]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[16]_i_1_n_0\,
      Q => rd_data(16),
      R => '0'
    );
\rd_data_reg[16]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[16]_i_3_n_0\,
      I1 => \rd_data[16]_i_4_n_0\,
      O => \rd_data_reg[16]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[17]_i_1_n_0\,
      Q => rd_data(17),
      R => '0'
    );
\rd_data_reg[17]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[17]_i_3_n_0\,
      I1 => \rd_data[17]_i_4_n_0\,
      O => \rd_data_reg[17]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[18]_i_1_n_0\,
      Q => rd_data(18),
      R => '0'
    );
\rd_data_reg[18]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[18]_i_3_n_0\,
      I1 => \rd_data[18]_i_4_n_0\,
      O => \rd_data_reg[18]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[19]_i_1_n_0\,
      Q => rd_data(19),
      R => '0'
    );
\rd_data_reg[19]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[19]_i_3_n_0\,
      I1 => \rd_data[19]_i_4_n_0\,
      O => \rd_data_reg[19]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[1]_i_1_n_0\,
      Q => rd_data(1),
      R => '0'
    );
\rd_data_reg[1]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[1]_i_5_n_0\,
      I1 => \rd_data[1]_i_6_n_0\,
      O => \rd_data_reg[1]_i_4_n_0\,
      S => sel0(2)
    );
\rd_data_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[20]_i_1_n_0\,
      Q => rd_data(20),
      R => '0'
    );
\rd_data_reg[20]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[20]_i_3_n_0\,
      I1 => \rd_data[20]_i_4_n_0\,
      O => \rd_data_reg[20]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[21]_i_1_n_0\,
      Q => rd_data(21),
      R => '0'
    );
\rd_data_reg[21]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[21]_i_3_n_0\,
      I1 => \rd_data[21]_i_4_n_0\,
      O => \rd_data_reg[21]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[22]_i_1_n_0\,
      Q => rd_data(22),
      R => '0'
    );
\rd_data_reg[22]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[22]_i_3_n_0\,
      I1 => \rd_data[22]_i_4_n_0\,
      O => \rd_data_reg[22]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[23]_i_1_n_0\,
      Q => rd_data(23),
      R => '0'
    );
\rd_data_reg[23]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[23]_i_3_n_0\,
      I1 => \rd_data[23]_i_4_n_0\,
      O => \rd_data_reg[23]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[24]_i_1_n_0\,
      Q => rd_data(24),
      R => '0'
    );
\rd_data_reg[24]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[24]_i_3_n_0\,
      I1 => \rd_data[24]_i_4_n_0\,
      O => \rd_data_reg[24]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[25]_i_1_n_0\,
      Q => rd_data(25),
      R => '0'
    );
\rd_data_reg[25]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[25]_i_3_n_0\,
      I1 => \rd_data[25]_i_4_n_0\,
      O => \rd_data_reg[25]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[26]_i_1_n_0\,
      Q => rd_data(26),
      R => '0'
    );
\rd_data_reg[26]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[26]_i_3_n_0\,
      I1 => \rd_data[26]_i_4_n_0\,
      O => \rd_data_reg[26]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[27]_i_1_n_0\,
      Q => rd_data(27),
      R => '0'
    );
\rd_data_reg[27]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[27]_i_3_n_0\,
      I1 => \rd_data[27]_i_4_n_0\,
      O => \rd_data_reg[27]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[28]_i_1_n_0\,
      Q => rd_data(28),
      R => '0'
    );
\rd_data_reg[28]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[28]_i_3_n_0\,
      I1 => \rd_data[28]_i_4_n_0\,
      O => \rd_data_reg[28]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[29]_i_1_n_0\,
      Q => rd_data(29),
      R => '0'
    );
\rd_data_reg[29]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[29]_i_3_n_0\,
      I1 => \rd_data[29]_i_4_n_0\,
      O => \rd_data_reg[29]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[2]_i_1_n_0\,
      Q => rd_data(2),
      R => '0'
    );
\rd_data_reg[2]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[2]_i_5_n_0\,
      I1 => \rd_data[2]_i_6_n_0\,
      O => \rd_data_reg[2]_i_4_n_0\,
      S => sel0(2)
    );
\rd_data_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[30]_i_1_n_0\,
      Q => rd_data(30),
      R => '0'
    );
\rd_data_reg[30]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[30]_i_3_n_0\,
      I1 => \rd_data[30]_i_4_n_0\,
      O => \rd_data_reg[30]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[31]_i_1_n_0\,
      Q => rd_data(31),
      R => '0'
    );
\rd_data_reg[31]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[31]_i_5_n_0\,
      I1 => \rd_data[31]_i_6_n_0\,
      O => \rd_data_reg[31]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[3]_i_1_n_0\,
      Q => rd_data(3),
      R => '0'
    );
\rd_data_reg[3]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[3]_i_4_n_0\,
      I1 => \rd_data[3]_i_5_n_0\,
      O => \rd_data_reg[3]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[4]_i_1_n_0\,
      Q => rd_data(4),
      R => '0'
    );
\rd_data_reg[4]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[4]_i_4_n_0\,
      I1 => \rd_data[4]_i_5_n_0\,
      O => \rd_data_reg[4]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[5]_i_1_n_0\,
      Q => rd_data(5),
      R => '0'
    );
\rd_data_reg[5]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[5]_i_5_n_0\,
      I1 => \rd_data[5]_i_6_n_0\,
      O => \rd_data_reg[5]_i_4_n_0\,
      S => sel0(2)
    );
\rd_data_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[6]_i_1_n_0\,
      Q => rd_data(6),
      R => '0'
    );
\rd_data_reg[6]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[6]_i_5_n_0\,
      I1 => \rd_data[6]_i_6_n_0\,
      O => \rd_data_reg[6]_i_4_n_0\,
      S => sel0(2)
    );
\rd_data_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[7]_i_1_n_0\,
      Q => rd_data(7),
      R => '0'
    );
\rd_data_reg[7]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[7]_i_4_n_0\,
      I1 => \rd_data[7]_i_5_n_0\,
      O => \rd_data_reg[7]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[8]_i_1_n_0\,
      Q => rd_data(8),
      R => '0'
    );
\rd_data_reg[8]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[8]_i_3_n_0\,
      I1 => \rd_data[8]_i_4_n_0\,
      O => \rd_data_reg[8]_i_2_n_0\,
      S => sel0(2)
    );
\rd_data_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => \rd_data[9]_i_1_n_0\,
      Q => rd_data(9),
      R => '0'
    );
\rd_data_reg[9]_i_2\: unisim.vcomponents.MUXF7
     port map (
      I0 => \rd_data[9]_i_3_n_0\,
      I1 => \rd_data[9]_i_4_n_0\,
      O => \rd_data_reg[9]_i_2_n_0\,
      S => sel0(2)
    );
s_axi_csr_arready_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FDFF0100"
    )
        port map (
      I0 => state(0),
      I1 => state(1),
      I2 => state(2),
      I3 => state(3),
      I4 => \^s_axi_csr_arready\,
      O => s_axi_csr_arready_i_1_n_0
    );
s_axi_csr_arready_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => s_axi_csr_arready_i_1_n_0,
      Q => \^s_axi_csr_arready\,
      R => s_axi_csr_awready_i_1_n_0
    );
s_axi_csr_awready_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s_axi_csr_aresetn,
      O => s_axi_csr_awready_i_1_n_0
    );
s_axi_csr_awready_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF99FF000011A2"
    )
        port map (
      I0 => state(0),
      I1 => state(2),
      I2 => s_axi_csr_awvalid,
      I3 => state(1),
      I4 => state(3),
      I5 => \^s_axi_csr_awready\,
      O => s_axi_csr_awready_i_2_n_0
    );
s_axi_csr_awready_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => s_axi_csr_awready_i_2_n_0,
      Q => \^s_axi_csr_awready\,
      R => s_axi_csr_awready_i_1_n_0
    );
s_axi_csr_bvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF7FFF00002200"
    )
        port map (
      I0 => state(1),
      I1 => state(0),
      I2 => s_axi_csr_bready,
      I3 => state(2),
      I4 => state(3),
      I5 => \^s_axi_csr_bvalid\,
      O => s_axi_csr_bvalid_i_1_n_0
    );
s_axi_csr_bvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => s_axi_csr_bvalid_i_1_n_0,
      Q => \^s_axi_csr_bvalid\,
      R => s_axi_csr_awready_i_1_n_0
    );
\s_axi_csr_rdata[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"02000000"
    )
        port map (
      I0 => state(3),
      I1 => state(2),
      I2 => state(0),
      I3 => state(1),
      I4 => s_axi_csr_aresetn,
      O => \s_axi_csr_rdata[31]_i_1_n_0\
    );
\s_axi_csr_rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(0),
      Q => s_axi_csr_rdata(0),
      R => '0'
    );
\s_axi_csr_rdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(10),
      Q => s_axi_csr_rdata(10),
      R => '0'
    );
\s_axi_csr_rdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(11),
      Q => s_axi_csr_rdata(11),
      R => '0'
    );
\s_axi_csr_rdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(12),
      Q => s_axi_csr_rdata(12),
      R => '0'
    );
\s_axi_csr_rdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(13),
      Q => s_axi_csr_rdata(13),
      R => '0'
    );
\s_axi_csr_rdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(14),
      Q => s_axi_csr_rdata(14),
      R => '0'
    );
\s_axi_csr_rdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(15),
      Q => s_axi_csr_rdata(15),
      R => '0'
    );
\s_axi_csr_rdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(16),
      Q => s_axi_csr_rdata(16),
      R => '0'
    );
\s_axi_csr_rdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(17),
      Q => s_axi_csr_rdata(17),
      R => '0'
    );
\s_axi_csr_rdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(18),
      Q => s_axi_csr_rdata(18),
      R => '0'
    );
\s_axi_csr_rdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(19),
      Q => s_axi_csr_rdata(19),
      R => '0'
    );
\s_axi_csr_rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(1),
      Q => s_axi_csr_rdata(1),
      R => '0'
    );
\s_axi_csr_rdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(20),
      Q => s_axi_csr_rdata(20),
      R => '0'
    );
\s_axi_csr_rdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(21),
      Q => s_axi_csr_rdata(21),
      R => '0'
    );
\s_axi_csr_rdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(22),
      Q => s_axi_csr_rdata(22),
      R => '0'
    );
\s_axi_csr_rdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(23),
      Q => s_axi_csr_rdata(23),
      R => '0'
    );
\s_axi_csr_rdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(24),
      Q => s_axi_csr_rdata(24),
      R => '0'
    );
\s_axi_csr_rdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(25),
      Q => s_axi_csr_rdata(25),
      R => '0'
    );
\s_axi_csr_rdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(26),
      Q => s_axi_csr_rdata(26),
      R => '0'
    );
\s_axi_csr_rdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(27),
      Q => s_axi_csr_rdata(27),
      R => '0'
    );
\s_axi_csr_rdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(28),
      Q => s_axi_csr_rdata(28),
      R => '0'
    );
\s_axi_csr_rdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(29),
      Q => s_axi_csr_rdata(29),
      R => '0'
    );
\s_axi_csr_rdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(2),
      Q => s_axi_csr_rdata(2),
      R => '0'
    );
\s_axi_csr_rdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(30),
      Q => s_axi_csr_rdata(30),
      R => '0'
    );
\s_axi_csr_rdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(31),
      Q => s_axi_csr_rdata(31),
      R => '0'
    );
\s_axi_csr_rdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(3),
      Q => s_axi_csr_rdata(3),
      R => '0'
    );
\s_axi_csr_rdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(4),
      Q => s_axi_csr_rdata(4),
      R => '0'
    );
\s_axi_csr_rdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(5),
      Q => s_axi_csr_rdata(5),
      R => '0'
    );
\s_axi_csr_rdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(6),
      Q => s_axi_csr_rdata(6),
      R => '0'
    );
\s_axi_csr_rdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(7),
      Q => s_axi_csr_rdata(7),
      R => '0'
    );
\s_axi_csr_rdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(8),
      Q => s_axi_csr_rdata(8),
      R => '0'
    );
\s_axi_csr_rdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => \s_axi_csr_rdata[31]_i_1_n_0\,
      D => rd_data(9),
      Q => s_axi_csr_rdata(9),
      R => '0'
    );
s_axi_csr_rvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF7FFFFF00220000"
    )
        port map (
      I0 => state(1),
      I1 => state(0),
      I2 => s_axi_csr_rready,
      I3 => state(2),
      I4 => state(3),
      I5 => \^s_axi_csr_rvalid\,
      O => s_axi_csr_rvalid_i_1_n_0
    );
s_axi_csr_rvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => s_axi_csr_rvalid_i_1_n_0,
      Q => \^s_axi_csr_rvalid\,
      R => s_axi_csr_awready_i_1_n_0
    );
s_axi_csr_wready_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFB7B700002606"
    )
        port map (
      I0 => state(0),
      I1 => state(2),
      I2 => state(1),
      I3 => s_axi_csr_wvalid,
      I4 => state(3),
      I5 => \^s_axi_csr_wready\,
      O => s_axi_csr_wready_i_1_n_0
    );
s_axi_csr_wready_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => s_axi_csr_wready_i_1_n_0,
      Q => \^s_axi_csr_wready\,
      R => s_axi_csr_awready_i_1_n_0
    );
\w_addr[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0200020200002020"
    )
        port map (
      I0 => s_axi_csr_aresetn,
      I1 => state(3),
      I2 => state(1),
      I3 => s_axi_csr_awvalid,
      I4 => state(2),
      I5 => state(0),
      O => \w_addr[5]_i_1_n_0\
    );
\w_addr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_addr[5]_i_1_n_0\,
      D => s_axi_csr_awaddr(0),
      Q => \w_addr_reg_n_0_[2]\,
      R => '0'
    );
\w_addr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_addr[5]_i_1_n_0\,
      D => s_axi_csr_awaddr(1),
      Q => \w_addr_reg_n_0_[3]\,
      R => '0'
    );
\w_addr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_addr[5]_i_1_n_0\,
      D => s_axi_csr_awaddr(2),
      Q => \w_addr_reg_n_0_[4]\,
      R => '0'
    );
\w_addr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_addr[5]_i_1_n_0\,
      D => s_axi_csr_awaddr(3),
      Q => \w_addr_reg_n_0_[5]\,
      R => '0'
    );
\w_data[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000202200220000"
    )
        port map (
      I0 => s_axi_csr_aresetn,
      I1 => state(3),
      I2 => s_axi_csr_wvalid,
      I3 => state(1),
      I4 => state(2),
      I5 => state(0),
      O => \w_data[31]_i_1_n_0\
    );
\w_data_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(0),
      Q => \w_data_reg_n_0_[0]\,
      R => '0'
    );
\w_data_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(10),
      Q => w_data(10),
      R => '0'
    );
\w_data_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(11),
      Q => w_data(11),
      R => '0'
    );
\w_data_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(12),
      Q => w_data(12),
      R => '0'
    );
\w_data_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(13),
      Q => w_data(13),
      R => '0'
    );
\w_data_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(14),
      Q => w_data(14),
      R => '0'
    );
\w_data_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(15),
      Q => w_data(15),
      R => '0'
    );
\w_data_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(16),
      Q => w_data(16),
      R => '0'
    );
\w_data_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(17),
      Q => w_data(17),
      R => '0'
    );
\w_data_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(18),
      Q => w_data(18),
      R => '0'
    );
\w_data_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(19),
      Q => w_data(19),
      R => '0'
    );
\w_data_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(1),
      Q => p_1_in16_in,
      R => '0'
    );
\w_data_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(20),
      Q => w_data(20),
      R => '0'
    );
\w_data_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(21),
      Q => w_data(21),
      R => '0'
    );
\w_data_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(22),
      Q => w_data(22),
      R => '0'
    );
\w_data_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(23),
      Q => w_data(23),
      R => '0'
    );
\w_data_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(24),
      Q => w_data(24),
      R => '0'
    );
\w_data_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(25),
      Q => w_data(25),
      R => '0'
    );
\w_data_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(26),
      Q => w_data(26),
      R => '0'
    );
\w_data_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(27),
      Q => w_data(27),
      R => '0'
    );
\w_data_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(28),
      Q => w_data(28),
      R => '0'
    );
\w_data_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(29),
      Q => w_data(29),
      R => '0'
    );
\w_data_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(2),
      Q => p_1_in13_in,
      R => '0'
    );
\w_data_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(30),
      Q => w_data(30),
      R => '0'
    );
\w_data_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(31),
      Q => w_data(31),
      R => '0'
    );
\w_data_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(3),
      Q => p_1_in10_in,
      R => '0'
    );
\w_data_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(4),
      Q => p_1_in7_in,
      R => '0'
    );
\w_data_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(5),
      Q => p_1_in4_in,
      R => '0'
    );
\w_data_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(6),
      Q => p_1_in1_in,
      R => '0'
    );
\w_data_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(7),
      Q => \w_data_reg_n_0_[7]\,
      R => '0'
    );
\w_data_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(8),
      Q => w_data(8),
      R => '0'
    );
\w_data_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \w_data[31]_i_1_n_0\,
      D => s_axi_csr_wdata(9),
      Q => w_data(9),
      R => '0'
    );
w_we_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF7F0040"
    )
        port map (
      I0 => state(0),
      I1 => state(1),
      I2 => state(2),
      I3 => state(3),
      I4 => w_we_reg_n_0,
      O => w_we_i_1_n_0
    );
w_we_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => '1',
      D => w_we_i_1_n_0,
      Q => w_we_reg_n_0,
      R => s_axi_csr_awready_i_1_n_0
    );
\wr_strb[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00002606"
    )
        port map (
      I0 => state(0),
      I1 => state(2),
      I2 => state(1),
      I3 => s_axi_csr_wvalid,
      I4 => state(3),
      O => \wr_strb[3]_i_1_n_0\
    );
\wr_strb_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \wr_strb[3]_i_1_n_0\,
      D => s_axi_csr_wstrb(0),
      Q => wr_strb,
      R => s_axi_csr_awready_i_1_n_0
    );
\wr_strb_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \wr_strb[3]_i_1_n_0\,
      D => s_axi_csr_wstrb(1),
      Q => \wr_strb_reg_n_0_[1]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\wr_strb_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \wr_strb[3]_i_1_n_0\,
      D => s_axi_csr_wstrb(2),
      Q => \wr_strb_reg_n_0_[2]\,
      R => s_axi_csr_awready_i_1_n_0
    );
\wr_strb_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_csr_aclk,
      CE => \wr_strb[3]_i_1_n_0\,
      D => s_axi_csr_wstrb(3),
      Q => \wr_strb_reg_n_0_[3]\,
      R => s_axi_csr_awready_i_1_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_axil_csr_sb is
  port (
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
    ctl0_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl1_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl2_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl3_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl4_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl5_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl6_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    stat0_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    intrpt_src_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    irq : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of px_axil_csr_sb : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of px_axil_csr_sb : entity is "px_axil_csr_sb,px_axil_csr,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of px_axil_csr_sb : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of px_axil_csr_sb : entity is "px_axil_csr,Vivado 2015.1";
end px_axil_csr_sb;

architecture STRUCTURE of px_axil_csr_sb is
  signal \<const0>\ : STD_LOGIC;
begin
  s_axi_csr_bresp(1) <= \<const0>\;
  s_axi_csr_bresp(0) <= \<const0>\;
  s_axi_csr_rresp(1) <= \<const0>\;
  s_axi_csr_rresp(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
U0: entity work.px_axil_csr_sb_px_axil_csr
     port map (
      ctl0_out(31 downto 0) => ctl0_out(31 downto 0),
      ctl1_out(31 downto 0) => ctl1_out(31 downto 0),
      ctl2_out(31 downto 0) => ctl2_out(31 downto 0),
      ctl3_out(31 downto 0) => ctl3_out(31 downto 0),
      ctl4_out(31 downto 0) => ctl4_out(31 downto 0),
      ctl5_out(31 downto 0) => ctl5_out(31 downto 0),
      ctl6_out(31 downto 0) => ctl6_out(31 downto 0),
      intrpt_src_in(7 downto 0) => intrpt_src_in(7 downto 0),
      irq => irq,
      reg0_init_val(31 downto 0) => reg0_init_val(31 downto 0),
      reg1_init_val(31 downto 0) => reg1_init_val(31 downto 0),
      reg2_init_val(31 downto 0) => reg2_init_val(31 downto 0),
      reg3_init_val(31 downto 0) => reg3_init_val(31 downto 0),
      reg4_init_val(31 downto 0) => reg4_init_val(31 downto 0),
      reg5_init_val(31 downto 0) => reg5_init_val(31 downto 0),
      reg6_init_val(31 downto 0) => reg6_init_val(31 downto 0),
      s_axi_csr_aclk => s_axi_csr_aclk,
      s_axi_csr_araddr(3 downto 0) => s_axi_csr_araddr(5 downto 2),
      s_axi_csr_aresetn => s_axi_csr_aresetn,
      s_axi_csr_arready => s_axi_csr_arready,
      s_axi_csr_arvalid => s_axi_csr_arvalid,
      s_axi_csr_awaddr(3 downto 0) => s_axi_csr_awaddr(5 downto 2),
      s_axi_csr_awready => s_axi_csr_awready,
      s_axi_csr_awvalid => s_axi_csr_awvalid,
      s_axi_csr_bready => s_axi_csr_bready,
      s_axi_csr_bvalid => s_axi_csr_bvalid,
      s_axi_csr_rdata(31 downto 0) => s_axi_csr_rdata(31 downto 0),
      s_axi_csr_rready => s_axi_csr_rready,
      s_axi_csr_rvalid => s_axi_csr_rvalid,
      s_axi_csr_wdata(31 downto 0) => s_axi_csr_wdata(31 downto 0),
      s_axi_csr_wready => s_axi_csr_wready,
      s_axi_csr_wstrb(3 downto 0) => s_axi_csr_wstrb(3 downto 0),
      s_axi_csr_wvalid => s_axi_csr_wvalid,
      stat0_in(31 downto 0) => stat0_in(31 downto 0)
    );
end STRUCTURE;
