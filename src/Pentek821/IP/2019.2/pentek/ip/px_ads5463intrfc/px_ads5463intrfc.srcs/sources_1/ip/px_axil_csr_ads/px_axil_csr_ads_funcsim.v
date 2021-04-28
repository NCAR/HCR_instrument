// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
// Date        : Fri May 01 21:04:34 2015
// Host        : Igor running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               E:/px_ip/px_ads5485intrfc/px_ads5485intrfc.srcs/sources_1/ip/px_axil_csr_ads/px_axil_csr_ads_funcsim.v
// Design      : px_axil_csr_ads
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e-es2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axil_csr_ads,px_axil_csr,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "px_axil_csr,Vivado 2015.1" *) 
(* NotValidForBitStream *)
module px_axil_csr_ads
   (s_axi_csr_aclk,
    s_axi_csr_aresetn,
    s_axi_csr_awaddr,
    s_axi_csr_awprot,
    s_axi_csr_awvalid,
    s_axi_csr_awready,
    s_axi_csr_wdata,
    s_axi_csr_wstrb,
    s_axi_csr_wvalid,
    s_axi_csr_wready,
    s_axi_csr_bresp,
    s_axi_csr_bvalid,
    s_axi_csr_bready,
    s_axi_csr_araddr,
    s_axi_csr_arprot,
    s_axi_csr_arvalid,
    s_axi_csr_arready,
    s_axi_csr_rdata,
    s_axi_csr_rresp,
    s_axi_csr_rvalid,
    s_axi_csr_rready,
    reg0_init_val,
    reg1_init_val,
    reg2_init_val,
    ctl0_out,
    ctl1_out,
    ctl2_out,
    stat0_in,
    stat1_in,
    intrpt_src_in,
    irq);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK" *) input s_axi_csr_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 s_axi_csr_aresetn RST" *) input s_axi_csr_aresetn;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr AWADDR" *) input [6:0]s_axi_csr_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr AWPROT" *) input [2:0]s_axi_csr_awprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr AWVALID" *) input s_axi_csr_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr AWREADY" *) output s_axi_csr_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr WDATA" *) input [31:0]s_axi_csr_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr WSTRB" *) input [3:0]s_axi_csr_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr WVALID" *) input s_axi_csr_wvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr WREADY" *) output s_axi_csr_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr BRESP" *) output [1:0]s_axi_csr_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr BVALID" *) output s_axi_csr_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr BREADY" *) input s_axi_csr_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr ARADDR" *) input [6:0]s_axi_csr_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr ARPROT" *) input [2:0]s_axi_csr_arprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr ARVALID" *) input s_axi_csr_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr ARREADY" *) output s_axi_csr_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr RDATA" *) output [31:0]s_axi_csr_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr RRESP" *) output [1:0]s_axi_csr_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr RVALID" *) output s_axi_csr_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr RREADY" *) input s_axi_csr_rready;
  input [31:0]reg0_init_val;
  input [31:0]reg1_init_val;
  input [31:0]reg2_init_val;
  output [31:0]ctl0_out;
  output [31:0]ctl1_out;
  output [31:0]ctl2_out;
  input [31:0]stat0_in;
  input [31:0]stat1_in;
  input [1:0]intrpt_src_in;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 irq INTERRUPT" *) output irq;

  wire \<const0> ;
  wire [31:0]ctl0_out;
  wire [31:0]ctl1_out;
  wire [31:0]ctl2_out;
  wire [1:0]intrpt_src_in;
  wire irq;
  wire [31:0]reg0_init_val;
  wire [31:0]reg1_init_val;
  wire [31:0]reg2_init_val;
  wire s_axi_csr_aclk;
  wire [6:0]s_axi_csr_araddr;
  wire s_axi_csr_aresetn;
  wire s_axi_csr_arready;
  wire s_axi_csr_arvalid;
  wire [6:0]s_axi_csr_awaddr;
  wire s_axi_csr_awready;
  wire s_axi_csr_awvalid;
  wire s_axi_csr_bready;
  wire s_axi_csr_bvalid;
  wire [31:0]s_axi_csr_rdata;
  wire s_axi_csr_rready;
  wire s_axi_csr_rvalid;
  wire [31:0]s_axi_csr_wdata;
  wire s_axi_csr_wready;
  wire [3:0]s_axi_csr_wstrb;
  wire s_axi_csr_wvalid;
  wire [31:0]stat0_in;
  wire [31:0]stat1_in;

  assign s_axi_csr_bresp[1] = \<const0> ;
  assign s_axi_csr_bresp[0] = \<const0> ;
  assign s_axi_csr_rresp[1] = \<const0> ;
  assign s_axi_csr_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  px_axil_csr_ads_px_axil_csr U0
       (.ctl0_out(ctl0_out),
        .ctl1_out(ctl1_out),
        .ctl2_out(ctl2_out),
        .intrpt_src_in(intrpt_src_in),
        .irq(irq),
        .reg0_init_val(reg0_init_val),
        .reg1_init_val(reg1_init_val),
        .reg2_init_val(reg2_init_val),
        .s_axi_csr_aclk(s_axi_csr_aclk),
        .s_axi_csr_araddr(s_axi_csr_araddr[4:2]),
        .s_axi_csr_aresetn(s_axi_csr_aresetn),
        .s_axi_csr_arready(s_axi_csr_arready),
        .s_axi_csr_arvalid(s_axi_csr_arvalid),
        .s_axi_csr_awaddr(s_axi_csr_awaddr[4:2]),
        .s_axi_csr_awready(s_axi_csr_awready),
        .s_axi_csr_awvalid(s_axi_csr_awvalid),
        .s_axi_csr_bready(s_axi_csr_bready),
        .s_axi_csr_bvalid(s_axi_csr_bvalid),
        .s_axi_csr_rdata(s_axi_csr_rdata),
        .s_axi_csr_rready(s_axi_csr_rready),
        .s_axi_csr_rvalid(s_axi_csr_rvalid),
        .s_axi_csr_wdata(s_axi_csr_wdata),
        .s_axi_csr_wready(s_axi_csr_wready),
        .s_axi_csr_wstrb(s_axi_csr_wstrb),
        .s_axi_csr_wvalid(s_axi_csr_wvalid),
        .stat0_in(stat0_in),
        .stat1_in(stat1_in));
endmodule

(* ORIG_REF_NAME = "px_axil_csr" *) 
module px_axil_csr_ads_px_axil_csr
   (s_axi_csr_rdata,
    ctl0_out,
    ctl1_out,
    ctl2_out,
    irq,
    s_axi_csr_wready,
    s_axi_csr_awready,
    s_axi_csr_arready,
    s_axi_csr_rvalid,
    s_axi_csr_bvalid,
    s_axi_csr_aclk,
    s_axi_csr_rready,
    s_axi_csr_bready,
    s_axi_csr_awvalid,
    s_axi_csr_wvalid,
    s_axi_csr_arvalid,
    intrpt_src_in,
    s_axi_csr_wstrb,
    s_axi_csr_wdata,
    s_axi_csr_awaddr,
    s_axi_csr_araddr,
    stat1_in,
    stat0_in,
    s_axi_csr_aresetn,
    reg0_init_val,
    reg1_init_val,
    reg2_init_val);
  output [31:0]s_axi_csr_rdata;
  output [31:0]ctl0_out;
  output [31:0]ctl1_out;
  output [31:0]ctl2_out;
  output irq;
  output s_axi_csr_wready;
  output s_axi_csr_awready;
  output s_axi_csr_arready;
  output s_axi_csr_rvalid;
  output s_axi_csr_bvalid;
  input s_axi_csr_aclk;
  input s_axi_csr_rready;
  input s_axi_csr_bready;
  input s_axi_csr_awvalid;
  input s_axi_csr_wvalid;
  input s_axi_csr_arvalid;
  input [1:0]intrpt_src_in;
  input [3:0]s_axi_csr_wstrb;
  input [31:0]s_axi_csr_wdata;
  input [2:0]s_axi_csr_awaddr;
  input [2:0]s_axi_csr_araddr;
  input [31:0]stat1_in;
  input [31:0]stat0_in;
  input s_axi_csr_aresetn;
  input [31:0]reg0_init_val;
  input [31:0]reg1_init_val;
  input [31:0]reg2_init_val;

  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[0]_i_2_n_0 ;
  wire \FSM_sequential_state[1]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_2_n_0 ;
  wire \FSM_sequential_state[2]_i_1_n_0 ;
  wire \FSM_sequential_state[2]_i_2_n_0 ;
  wire \FSM_sequential_state[3]_i_1_n_0 ;
  wire \FSM_sequential_state[3]_i_2_n_0 ;
  wire [31:0]ctl0_out;
  wire [31:0]ctl1_out;
  wire [31:0]ctl2_out;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1_n_0 ;
  wire [31:0]\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1_n_0 ;
  wire [31:0]\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1_n_0 ;
  wire [31:0]\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 ;
  wire \gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1_n_0 ;
  wire \gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1_n_0 ;
  wire \gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_2_n_0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[0].int_and[0]_i_1_n_0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[0].re_int[0]_i_1_n_0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[1].int_and[1]_i_1_n_0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[1].re_int[1]_i_1_n_0 ;
  wire \gen_int.int_en_reg_reg_n_0_[0] ;
  wire \gen_int.int_en_reg_reg_n_0_[10] ;
  wire \gen_int.int_en_reg_reg_n_0_[11] ;
  wire \gen_int.int_en_reg_reg_n_0_[12] ;
  wire \gen_int.int_en_reg_reg_n_0_[13] ;
  wire \gen_int.int_en_reg_reg_n_0_[14] ;
  wire \gen_int.int_en_reg_reg_n_0_[15] ;
  wire \gen_int.int_en_reg_reg_n_0_[16] ;
  wire \gen_int.int_en_reg_reg_n_0_[17] ;
  wire \gen_int.int_en_reg_reg_n_0_[18] ;
  wire \gen_int.int_en_reg_reg_n_0_[19] ;
  wire \gen_int.int_en_reg_reg_n_0_[20] ;
  wire \gen_int.int_en_reg_reg_n_0_[21] ;
  wire \gen_int.int_en_reg_reg_n_0_[22] ;
  wire \gen_int.int_en_reg_reg_n_0_[23] ;
  wire \gen_int.int_en_reg_reg_n_0_[24] ;
  wire \gen_int.int_en_reg_reg_n_0_[25] ;
  wire \gen_int.int_en_reg_reg_n_0_[26] ;
  wire \gen_int.int_en_reg_reg_n_0_[27] ;
  wire \gen_int.int_en_reg_reg_n_0_[28] ;
  wire \gen_int.int_en_reg_reg_n_0_[29] ;
  wire \gen_int.int_en_reg_reg_n_0_[2] ;
  wire \gen_int.int_en_reg_reg_n_0_[30] ;
  wire \gen_int.int_en_reg_reg_n_0_[31] ;
  wire \gen_int.int_en_reg_reg_n_0_[3] ;
  wire \gen_int.int_en_reg_reg_n_0_[4] ;
  wire \gen_int.int_en_reg_reg_n_0_[5] ;
  wire \gen_int.int_en_reg_reg_n_0_[6] ;
  wire \gen_int.int_en_reg_reg_n_0_[7] ;
  wire \gen_int.int_en_reg_reg_n_0_[8] ;
  wire \gen_int.int_en_reg_reg_n_0_[9] ;
  wire \gen_int.usr_int_i_1_n_0 ;
  wire [31:0]\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 ;
  wire [31:0]\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 ;
  wire [1:0]int_flag_reg;
  wire [1:0]intrpt_src_in;
  wire irq;
  wire p_0_in16_in;
  wire [1:0]p_116_out;
  wire [1:0]p_117_out;
  wire [1:0]p_118_out;
  wire [1:0]p_119_out;
  wire [31:7]p_1_in;
  wire \r_addr[4]_i_1_n_0 ;
  wire [31:0]rd_data;
  wire \rd_data[0]_i_2_n_0 ;
  wire \rd_data[0]_i_3_n_0 ;
  wire \rd_data[10]_i_1_n_0 ;
  wire \rd_data[10]_i_2_n_0 ;
  wire \rd_data[11]_i_1_n_0 ;
  wire \rd_data[11]_i_2_n_0 ;
  wire \rd_data[12]_i_1_n_0 ;
  wire \rd_data[12]_i_2_n_0 ;
  wire \rd_data[13]_i_1_n_0 ;
  wire \rd_data[13]_i_2_n_0 ;
  wire \rd_data[14]_i_1_n_0 ;
  wire \rd_data[14]_i_2_n_0 ;
  wire \rd_data[15]_i_1_n_0 ;
  wire \rd_data[15]_i_2_n_0 ;
  wire \rd_data[16]_i_1_n_0 ;
  wire \rd_data[16]_i_2_n_0 ;
  wire \rd_data[17]_i_1_n_0 ;
  wire \rd_data[17]_i_2_n_0 ;
  wire \rd_data[18]_i_1_n_0 ;
  wire \rd_data[18]_i_2_n_0 ;
  wire \rd_data[19]_i_1_n_0 ;
  wire \rd_data[19]_i_2_n_0 ;
  wire \rd_data[1]_i_2_n_0 ;
  wire \rd_data[1]_i_3_n_0 ;
  wire \rd_data[20]_i_1_n_0 ;
  wire \rd_data[20]_i_2_n_0 ;
  wire \rd_data[21]_i_1_n_0 ;
  wire \rd_data[21]_i_2_n_0 ;
  wire \rd_data[22]_i_1_n_0 ;
  wire \rd_data[22]_i_2_n_0 ;
  wire \rd_data[23]_i_1_n_0 ;
  wire \rd_data[23]_i_2_n_0 ;
  wire \rd_data[24]_i_1_n_0 ;
  wire \rd_data[24]_i_2_n_0 ;
  wire \rd_data[25]_i_1_n_0 ;
  wire \rd_data[25]_i_2_n_0 ;
  wire \rd_data[26]_i_1_n_0 ;
  wire \rd_data[26]_i_2_n_0 ;
  wire \rd_data[27]_i_1_n_0 ;
  wire \rd_data[27]_i_2_n_0 ;
  wire \rd_data[28]_i_1_n_0 ;
  wire \rd_data[28]_i_2_n_0 ;
  wire \rd_data[29]_i_1_n_0 ;
  wire \rd_data[29]_i_2_n_0 ;
  wire \rd_data[2]_i_1_n_0 ;
  wire \rd_data[2]_i_2_n_0 ;
  wire \rd_data[30]_i_1_n_0 ;
  wire \rd_data[30]_i_2_n_0 ;
  wire \rd_data[31]_i_1_n_0 ;
  wire \rd_data[31]_i_2_n_0 ;
  wire \rd_data[3]_i_1_n_0 ;
  wire \rd_data[3]_i_2_n_0 ;
  wire \rd_data[4]_i_1_n_0 ;
  wire \rd_data[4]_i_2_n_0 ;
  wire \rd_data[5]_i_1_n_0 ;
  wire \rd_data[5]_i_2_n_0 ;
  wire \rd_data[6]_i_1_n_0 ;
  wire \rd_data[6]_i_2_n_0 ;
  wire \rd_data[7]_i_1_n_0 ;
  wire \rd_data[7]_i_2_n_0 ;
  wire \rd_data[8]_i_1_n_0 ;
  wire \rd_data[8]_i_2_n_0 ;
  wire \rd_data[9]_i_1_n_0 ;
  wire \rd_data[9]_i_2_n_0 ;
  wire \rd_data_reg[0]_i_1_n_0 ;
  wire \rd_data_reg[1]_i_1_n_0 ;
  wire [31:0]reg0_init_val;
  wire [31:0]reg1_init_val;
  wire [31:0]reg2_init_val;
  wire s_axi_csr_aclk;
  wire [2:0]s_axi_csr_araddr;
  wire s_axi_csr_aresetn;
  wire s_axi_csr_arready;
  wire s_axi_csr_arready_i_1_n_0;
  wire s_axi_csr_arvalid;
  wire [2:0]s_axi_csr_awaddr;
  wire s_axi_csr_awready;
  wire s_axi_csr_awready_i_1_n_0;
  wire s_axi_csr_awready_i_2_n_0;
  wire s_axi_csr_awvalid;
  wire s_axi_csr_bready;
  wire s_axi_csr_bvalid;
  wire s_axi_csr_bvalid_i_1_n_0;
  wire [31:0]s_axi_csr_rdata;
  wire \s_axi_csr_rdata[31]_i_1_n_0 ;
  wire s_axi_csr_rready;
  wire s_axi_csr_rvalid;
  wire s_axi_csr_rvalid_i_1_n_0;
  wire [31:0]s_axi_csr_wdata;
  wire s_axi_csr_wready;
  wire s_axi_csr_wready_i_1_n_0;
  wire [3:0]s_axi_csr_wstrb;
  wire s_axi_csr_wvalid;
  wire [2:0]sel0;
  wire [31:0]stat0_in;
  wire [31:0]stat1_in;
  (* RTL_KEEP = "yes" *) wire [3:0]state;
  wire usr_int;
  wire \w_addr[4]_i_1_n_0 ;
  wire \w_addr_reg_n_0_[2] ;
  wire \w_addr_reg_n_0_[3] ;
  wire \w_addr_reg_n_0_[4] ;
  wire [31:2]w_data;
  wire \w_data[31]_i_1_n_0 ;
  wire \w_data_reg_n_0_[0] ;
  wire \w_data_reg_n_0_[1] ;
  wire w_we_i_1_n_0;
  wire w_we_reg_n_0;
  wire wr_strb;
  wire \wr_strb[3]_i_1_n_0 ;
  wire \wr_strb_reg_n_0_[1] ;
  wire \wr_strb_reg_n_0_[2] ;
  wire \wr_strb_reg_n_0_[3] ;

  LUT6 #(
    .INIT(64'h004FFFFF004F0000)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(s_axi_csr_rready),
        .I1(state[1]),
        .I2(state[0]),
        .I3(state[2]),
        .I4(state[3]),
        .I5(\FSM_sequential_state[0]_i_2_n_0 ),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h40704C7CFFFCFCFC)) 
    \FSM_sequential_state[0]_i_2 
       (.I0(s_axi_csr_bready),
        .I1(state[1]),
        .I2(state[2]),
        .I3(s_axi_csr_awvalid),
        .I4(s_axi_csr_wvalid),
        .I5(state[0]),
        .O(\FSM_sequential_state[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h007CFFFF007C0000)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(s_axi_csr_rready),
        .I1(state[1]),
        .I2(state[0]),
        .I3(state[2]),
        .I4(state[3]),
        .I5(\FSM_sequential_state[1]_i_2_n_0 ),
        .O(\FSM_sequential_state[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7F7F4F4FCCCFCCCC)) 
    \FSM_sequential_state[1]_i_2 
       (.I0(s_axi_csr_bready),
        .I1(state[1]),
        .I2(state[2]),
        .I3(s_axi_csr_wvalid),
        .I4(s_axi_csr_awvalid),
        .I5(state[0]),
        .O(\FSM_sequential_state[1]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[2]_i_1 
       (.I0(\FSM_sequential_state[2]_i_2_n_0 ),
        .I1(state[3]),
        .O(\FSM_sequential_state[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7F7F7F7FF030F330)) 
    \FSM_sequential_state[2]_i_2 
       (.I0(s_axi_csr_bready),
        .I1(state[1]),
        .I2(state[0]),
        .I3(s_axi_csr_wvalid),
        .I4(s_axi_csr_awvalid),
        .I5(state[2]),
        .O(\FSM_sequential_state[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h007FFFFF007F0000)) 
    \FSM_sequential_state[3]_i_1 
       (.I0(state[0]),
        .I1(s_axi_csr_rready),
        .I2(state[1]),
        .I3(state[2]),
        .I4(state[3]),
        .I5(\FSM_sequential_state[3]_i_2_n_0 ),
        .O(\FSM_sequential_state[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000010)) 
    \FSM_sequential_state[3]_i_2 
       (.I0(state[2]),
        .I1(s_axi_csr_awvalid),
        .I2(s_axi_csr_arvalid),
        .I3(s_axi_csr_wvalid),
        .I4(state[0]),
        .I5(state[1]),
        .O(\FSM_sequential_state[3]_i_2_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(state[0]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1]_i_1_n_0 ),
        .Q(state[1]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[2]_i_1_n_0 ),
        .Q(state[2]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[3]_i_1_n_0 ),
        .Q(state[3]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE \ctl0_out_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [0]),
        .Q(ctl0_out[0]),
        .R(1'b0));
  FDRE \ctl0_out_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [10]),
        .Q(ctl0_out[10]),
        .R(1'b0));
  FDRE \ctl0_out_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [11]),
        .Q(ctl0_out[11]),
        .R(1'b0));
  FDRE \ctl0_out_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [12]),
        .Q(ctl0_out[12]),
        .R(1'b0));
  FDRE \ctl0_out_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [13]),
        .Q(ctl0_out[13]),
        .R(1'b0));
  FDRE \ctl0_out_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [14]),
        .Q(ctl0_out[14]),
        .R(1'b0));
  FDRE \ctl0_out_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [15]),
        .Q(ctl0_out[15]),
        .R(1'b0));
  FDRE \ctl0_out_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [16]),
        .Q(ctl0_out[16]),
        .R(1'b0));
  FDRE \ctl0_out_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [17]),
        .Q(ctl0_out[17]),
        .R(1'b0));
  FDRE \ctl0_out_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [18]),
        .Q(ctl0_out[18]),
        .R(1'b0));
  FDRE \ctl0_out_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [19]),
        .Q(ctl0_out[19]),
        .R(1'b0));
  FDRE \ctl0_out_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [1]),
        .Q(ctl0_out[1]),
        .R(1'b0));
  FDRE \ctl0_out_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [20]),
        .Q(ctl0_out[20]),
        .R(1'b0));
  FDRE \ctl0_out_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [21]),
        .Q(ctl0_out[21]),
        .R(1'b0));
  FDRE \ctl0_out_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [22]),
        .Q(ctl0_out[22]),
        .R(1'b0));
  FDRE \ctl0_out_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [23]),
        .Q(ctl0_out[23]),
        .R(1'b0));
  FDRE \ctl0_out_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [24]),
        .Q(ctl0_out[24]),
        .R(1'b0));
  FDRE \ctl0_out_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [25]),
        .Q(ctl0_out[25]),
        .R(1'b0));
  FDRE \ctl0_out_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [26]),
        .Q(ctl0_out[26]),
        .R(1'b0));
  FDRE \ctl0_out_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [27]),
        .Q(ctl0_out[27]),
        .R(1'b0));
  FDRE \ctl0_out_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [28]),
        .Q(ctl0_out[28]),
        .R(1'b0));
  FDRE \ctl0_out_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [29]),
        .Q(ctl0_out[29]),
        .R(1'b0));
  FDRE \ctl0_out_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [2]),
        .Q(ctl0_out[2]),
        .R(1'b0));
  FDRE \ctl0_out_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [30]),
        .Q(ctl0_out[30]),
        .R(1'b0));
  FDRE \ctl0_out_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [31]),
        .Q(ctl0_out[31]),
        .R(1'b0));
  FDRE \ctl0_out_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [3]),
        .Q(ctl0_out[3]),
        .R(1'b0));
  FDRE \ctl0_out_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [4]),
        .Q(ctl0_out[4]),
        .R(1'b0));
  FDRE \ctl0_out_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [5]),
        .Q(ctl0_out[5]),
        .R(1'b0));
  FDRE \ctl0_out_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [6]),
        .Q(ctl0_out[6]),
        .R(1'b0));
  FDRE \ctl0_out_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [7]),
        .Q(ctl0_out[7]),
        .R(1'b0));
  FDRE \ctl0_out_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [8]),
        .Q(ctl0_out[8]),
        .R(1'b0));
  FDRE \ctl0_out_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [9]),
        .Q(ctl0_out[9]),
        .R(1'b0));
  FDRE \ctl1_out_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [0]),
        .Q(ctl1_out[0]),
        .R(1'b0));
  FDRE \ctl1_out_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [10]),
        .Q(ctl1_out[10]),
        .R(1'b0));
  FDRE \ctl1_out_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [11]),
        .Q(ctl1_out[11]),
        .R(1'b0));
  FDRE \ctl1_out_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [12]),
        .Q(ctl1_out[12]),
        .R(1'b0));
  FDRE \ctl1_out_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [13]),
        .Q(ctl1_out[13]),
        .R(1'b0));
  FDRE \ctl1_out_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [14]),
        .Q(ctl1_out[14]),
        .R(1'b0));
  FDRE \ctl1_out_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [15]),
        .Q(ctl1_out[15]),
        .R(1'b0));
  FDRE \ctl1_out_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [16]),
        .Q(ctl1_out[16]),
        .R(1'b0));
  FDRE \ctl1_out_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [17]),
        .Q(ctl1_out[17]),
        .R(1'b0));
  FDRE \ctl1_out_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [18]),
        .Q(ctl1_out[18]),
        .R(1'b0));
  FDRE \ctl1_out_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [19]),
        .Q(ctl1_out[19]),
        .R(1'b0));
  FDRE \ctl1_out_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [1]),
        .Q(ctl1_out[1]),
        .R(1'b0));
  FDRE \ctl1_out_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [20]),
        .Q(ctl1_out[20]),
        .R(1'b0));
  FDRE \ctl1_out_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [21]),
        .Q(ctl1_out[21]),
        .R(1'b0));
  FDRE \ctl1_out_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [22]),
        .Q(ctl1_out[22]),
        .R(1'b0));
  FDRE \ctl1_out_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [23]),
        .Q(ctl1_out[23]),
        .R(1'b0));
  FDRE \ctl1_out_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [24]),
        .Q(ctl1_out[24]),
        .R(1'b0));
  FDRE \ctl1_out_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [25]),
        .Q(ctl1_out[25]),
        .R(1'b0));
  FDRE \ctl1_out_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [26]),
        .Q(ctl1_out[26]),
        .R(1'b0));
  FDRE \ctl1_out_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [27]),
        .Q(ctl1_out[27]),
        .R(1'b0));
  FDRE \ctl1_out_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [28]),
        .Q(ctl1_out[28]),
        .R(1'b0));
  FDRE \ctl1_out_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [29]),
        .Q(ctl1_out[29]),
        .R(1'b0));
  FDRE \ctl1_out_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [2]),
        .Q(ctl1_out[2]),
        .R(1'b0));
  FDRE \ctl1_out_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [30]),
        .Q(ctl1_out[30]),
        .R(1'b0));
  FDRE \ctl1_out_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [31]),
        .Q(ctl1_out[31]),
        .R(1'b0));
  FDRE \ctl1_out_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [3]),
        .Q(ctl1_out[3]),
        .R(1'b0));
  FDRE \ctl1_out_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [4]),
        .Q(ctl1_out[4]),
        .R(1'b0));
  FDRE \ctl1_out_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [5]),
        .Q(ctl1_out[5]),
        .R(1'b0));
  FDRE \ctl1_out_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [6]),
        .Q(ctl1_out[6]),
        .R(1'b0));
  FDRE \ctl1_out_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [7]),
        .Q(ctl1_out[7]),
        .R(1'b0));
  FDRE \ctl1_out_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [8]),
        .Q(ctl1_out[8]),
        .R(1'b0));
  FDRE \ctl1_out_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [9]),
        .Q(ctl1_out[9]),
        .R(1'b0));
  FDRE \ctl2_out_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [0]),
        .Q(ctl2_out[0]),
        .R(1'b0));
  FDRE \ctl2_out_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [10]),
        .Q(ctl2_out[10]),
        .R(1'b0));
  FDRE \ctl2_out_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [11]),
        .Q(ctl2_out[11]),
        .R(1'b0));
  FDRE \ctl2_out_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [12]),
        .Q(ctl2_out[12]),
        .R(1'b0));
  FDRE \ctl2_out_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [13]),
        .Q(ctl2_out[13]),
        .R(1'b0));
  FDRE \ctl2_out_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [14]),
        .Q(ctl2_out[14]),
        .R(1'b0));
  FDRE \ctl2_out_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [15]),
        .Q(ctl2_out[15]),
        .R(1'b0));
  FDRE \ctl2_out_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [16]),
        .Q(ctl2_out[16]),
        .R(1'b0));
  FDRE \ctl2_out_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [17]),
        .Q(ctl2_out[17]),
        .R(1'b0));
  FDRE \ctl2_out_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [18]),
        .Q(ctl2_out[18]),
        .R(1'b0));
  FDRE \ctl2_out_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [19]),
        .Q(ctl2_out[19]),
        .R(1'b0));
  FDRE \ctl2_out_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [1]),
        .Q(ctl2_out[1]),
        .R(1'b0));
  FDRE \ctl2_out_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [20]),
        .Q(ctl2_out[20]),
        .R(1'b0));
  FDRE \ctl2_out_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [21]),
        .Q(ctl2_out[21]),
        .R(1'b0));
  FDRE \ctl2_out_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [22]),
        .Q(ctl2_out[22]),
        .R(1'b0));
  FDRE \ctl2_out_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [23]),
        .Q(ctl2_out[23]),
        .R(1'b0));
  FDRE \ctl2_out_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [24]),
        .Q(ctl2_out[24]),
        .R(1'b0));
  FDRE \ctl2_out_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [25]),
        .Q(ctl2_out[25]),
        .R(1'b0));
  FDRE \ctl2_out_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [26]),
        .Q(ctl2_out[26]),
        .R(1'b0));
  FDRE \ctl2_out_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [27]),
        .Q(ctl2_out[27]),
        .R(1'b0));
  FDRE \ctl2_out_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [28]),
        .Q(ctl2_out[28]),
        .R(1'b0));
  FDRE \ctl2_out_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [29]),
        .Q(ctl2_out[29]),
        .R(1'b0));
  FDRE \ctl2_out_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [2]),
        .Q(ctl2_out[2]),
        .R(1'b0));
  FDRE \ctl2_out_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [30]),
        .Q(ctl2_out[30]),
        .R(1'b0));
  FDRE \ctl2_out_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [31]),
        .Q(ctl2_out[31]),
        .R(1'b0));
  FDRE \ctl2_out_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [3]),
        .Q(ctl2_out[3]),
        .R(1'b0));
  FDRE \ctl2_out_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [4]),
        .Q(ctl2_out[4]),
        .R(1'b0));
  FDRE \ctl2_out_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [5]),
        .Q(ctl2_out[5]),
        .R(1'b0));
  FDRE \ctl2_out_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [6]),
        .Q(ctl2_out[6]),
        .R(1'b0));
  FDRE \ctl2_out_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [7]),
        .Q(ctl2_out[7]),
        .R(1'b0));
  FDRE \ctl2_out_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [8]),
        .Q(ctl2_out[8]),
        .R(1'b0));
  FDRE \ctl2_out_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [9]),
        .Q(ctl2_out[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1 
       (.I0(\w_data_reg_n_0_[0] ),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[0]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1 
       (.I0(w_data[10]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[10]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1 
       (.I0(w_data[11]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[11]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1 
       (.I0(w_data[12]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[12]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1 
       (.I0(w_data[13]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[13]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1 
       (.I0(w_data[14]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[14]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00020000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(\wr_strb_reg_n_0_[1] ),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2 
       (.I0(w_data[15]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[15]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1 
       (.I0(w_data[16]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[16]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1 
       (.I0(w_data[17]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[17]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1 
       (.I0(w_data[18]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[18]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1 
       (.I0(w_data[19]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[19]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1 
       (.I0(\w_data_reg_n_0_[1] ),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[1]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1 
       (.I0(w_data[20]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[20]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1 
       (.I0(w_data[21]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[21]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1 
       (.I0(w_data[22]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[22]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00020000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(\wr_strb_reg_n_0_[2] ),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2 
       (.I0(w_data[23]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[23]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1 
       (.I0(w_data[24]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[24]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1 
       (.I0(w_data[25]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[25]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1 
       (.I0(w_data[26]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[26]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1 
       (.I0(w_data[27]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[27]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1 
       (.I0(w_data[28]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[28]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1 
       (.I0(w_data[29]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[29]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1 
       (.I0(w_data[2]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[2]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1 
       (.I0(w_data[30]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[30]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00020000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(\wr_strb_reg_n_0_[3] ),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2 
       (.I0(w_data[31]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[31]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1 
       (.I0(w_data[3]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[3]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1 
       (.I0(w_data[4]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[4]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1 
       (.I0(w_data[5]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[5]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1 
       (.I0(w_data[6]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[6]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00020000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(wr_strb),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2 
       (.I0(w_data[7]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[7]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1 
       (.I0(w_data[8]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[8]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1 
       (.I0(w_data[9]),
        .I1(s_axi_csr_aresetn),
        .I2(reg0_init_val[9]),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1_n_0 ));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][0] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [0]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][10] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [10]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][11] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [11]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][12] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [12]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][13] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [13]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][14] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [14]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][15] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [15]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][16] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [16]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][17] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [17]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][18] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [18]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][19] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [19]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][1] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [1]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][20] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [20]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][21] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [21]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][22] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [22]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][23] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [23]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][24] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [24]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][25] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [25]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][26] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [26]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][27] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [27]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][28] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [28]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][29] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [29]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][2] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [2]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][30] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [30]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][31] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [31]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][3] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [3]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][4] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [4]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][5] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [5]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][6] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [6]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][7] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [7]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][8] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [8]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][9] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1 
       (.I0(\w_data_reg_n_0_[0] ),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[0]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1 
       (.I0(w_data[10]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[10]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1 
       (.I0(w_data[11]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[11]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1 
       (.I0(w_data[12]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[12]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1 
       (.I0(w_data[13]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[13]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1 
       (.I0(w_data[14]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[14]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00080000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(\wr_strb_reg_n_0_[1] ),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2 
       (.I0(w_data[15]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[15]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1 
       (.I0(w_data[16]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[16]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1 
       (.I0(w_data[17]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[17]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1 
       (.I0(w_data[18]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[18]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1 
       (.I0(w_data[19]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[19]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1 
       (.I0(\w_data_reg_n_0_[1] ),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[1]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1 
       (.I0(w_data[20]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[20]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1 
       (.I0(w_data[21]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[21]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1 
       (.I0(w_data[22]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[22]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00080000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(\wr_strb_reg_n_0_[2] ),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2 
       (.I0(w_data[23]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[23]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1 
       (.I0(w_data[24]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[24]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1 
       (.I0(w_data[25]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[25]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1 
       (.I0(w_data[26]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[26]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1 
       (.I0(w_data[27]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[27]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1 
       (.I0(w_data[28]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[28]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1 
       (.I0(w_data[29]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[29]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1 
       (.I0(w_data[2]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[2]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1 
       (.I0(w_data[30]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[30]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00080000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(\wr_strb_reg_n_0_[3] ),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2 
       (.I0(w_data[31]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[31]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1 
       (.I0(w_data[3]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[3]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1 
       (.I0(w_data[4]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[4]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1 
       (.I0(w_data[5]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[5]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1 
       (.I0(w_data[6]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[6]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00080000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(wr_strb),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2 
       (.I0(w_data[7]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[7]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1 
       (.I0(w_data[8]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[8]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1 
       (.I0(w_data[9]),
        .I1(s_axi_csr_aresetn),
        .I2(reg1_init_val[9]),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1_n_0 ));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][0] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [0]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][10] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [10]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][11] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [11]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][12] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [12]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][13] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [13]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][14] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [14]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][15] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [15]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][16] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [16]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][17] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [17]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][18] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [18]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][19] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [19]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][1] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [1]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][20] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [20]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][21] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [21]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][22] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [22]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][23] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [23]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][24] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [24]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][25] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [25]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][26] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [26]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][27] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [27]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][28] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [28]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][29] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [29]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][2] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [2]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][30] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [30]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][31] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [31]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][3] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [3]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][4] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [4]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][5] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [5]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][6] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [6]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][7] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [7]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][8] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [8]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][9] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1 
       (.I0(\w_data_reg_n_0_[0] ),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[0]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1 
       (.I0(w_data[10]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[10]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1 
       (.I0(w_data[11]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[11]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1 
       (.I0(w_data[12]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[12]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1 
       (.I0(w_data[13]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[13]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1 
       (.I0(w_data[14]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[14]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00200000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(\wr_strb_reg_n_0_[1] ),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2 
       (.I0(w_data[15]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[15]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1 
       (.I0(w_data[16]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[16]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1 
       (.I0(w_data[17]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[17]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1 
       (.I0(w_data[18]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[18]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1 
       (.I0(w_data[19]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[19]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1 
       (.I0(\w_data_reg_n_0_[1] ),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[1]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1 
       (.I0(w_data[20]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[20]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1 
       (.I0(w_data[21]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[21]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1 
       (.I0(w_data[22]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[22]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00200000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(\wr_strb_reg_n_0_[2] ),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2 
       (.I0(w_data[23]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[23]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1 
       (.I0(w_data[24]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[24]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1 
       (.I0(w_data[25]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[25]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1 
       (.I0(w_data[26]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[26]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1 
       (.I0(w_data[27]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[27]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1 
       (.I0(w_data[28]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[28]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1 
       (.I0(w_data[29]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[29]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1 
       (.I0(w_data[2]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[2]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1 
       (.I0(w_data[30]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[30]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00200000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(\wr_strb_reg_n_0_[3] ),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2 
       (.I0(w_data[31]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[31]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1 
       (.I0(w_data[3]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[3]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1 
       (.I0(w_data[4]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[4]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1 
       (.I0(w_data[5]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[5]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1 
       (.I0(w_data[6]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[6]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00200000FFFFFFFF)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(\w_addr_reg_n_0_[2] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[4] ),
        .I4(wr_strb),
        .I5(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2 
       (.I0(w_data[7]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[7]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1 
       (.I0(w_data[8]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[8]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1 
       (.I0(w_data[9]),
        .I1(s_axi_csr_aresetn),
        .I2(reg2_init_val[9]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1_n_0 ));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][0] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [0]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][10] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [10]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][11] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [11]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][12] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [12]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][13] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [13]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][14] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [14]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][15] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [15]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][16] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [16]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][17] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [17]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][18] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [18]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][19] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [19]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][1] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [1]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][20] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [20]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][21] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [21]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][22] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [22]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][23] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [23]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][24] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [24]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][25] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [25]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][26] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [26]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][27] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [27]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][28] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [28]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][29] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [29]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][2] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [2]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][30] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [30]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][31] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [31]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][3] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [3]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][4] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [4]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][5] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [5]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][6] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [6]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][7] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [7]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][8] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [8]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][9] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [9]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFBAA0000)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1 
       (.I0(p_117_out[0]),
        .I1(\w_data_reg_n_0_[0] ),
        .I2(\gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_2_n_0 ),
        .I3(int_flag_reg[0]),
        .I4(s_axi_csr_aresetn),
        .O(\gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1_n_0 ),
        .Q(int_flag_reg[0]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFBAA0000)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1 
       (.I0(p_117_out[1]),
        .I1(\w_data_reg_n_0_[1] ),
        .I2(\gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_2_n_0 ),
        .I3(int_flag_reg[1]),
        .I4(s_axi_csr_aresetn),
        .O(\gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_2 
       (.I0(wr_strb),
        .I1(\w_addr_reg_n_0_[4] ),
        .I2(\w_addr_reg_n_0_[3] ),
        .I3(\w_addr_reg_n_0_[2] ),
        .I4(w_we_reg_n_0),
        .O(\gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1_n_0 ),
        .Q(int_flag_reg[1]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h8)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].int_and[0]_i_1 
       (.I0(\gen_int.int_en_reg_reg_n_0_[0] ),
        .I1(p_117_out[0]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[0].int_and[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].int_and_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[0].int_and[0]_i_1_n_0 ),
        .Q(p_116_out[0]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].re_int[0]_i_1 
       (.I0(p_119_out[0]),
        .I1(p_118_out[0]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[0].re_int[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].re_int_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[0].re_int[0]_i_1_n_0 ),
        .Q(p_117_out[0]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].t1_intrpt_src_in_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(intrpt_src_in[0]),
        .Q(p_119_out[0]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].t2_intrpt_src_in_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(p_119_out[0]),
        .Q(p_118_out[0]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].int_and[1]_i_1 
       (.I0(p_0_in16_in),
        .I1(p_117_out[1]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[1].int_and[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].int_and_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[1].int_and[1]_i_1_n_0 ),
        .Q(p_116_out[1]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].re_int[1]_i_1 
       (.I0(p_119_out[1]),
        .I1(p_118_out[1]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[1].re_int[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].re_int_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[1].re_int[1]_i_1_n_0 ),
        .Q(p_117_out[1]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].t1_intrpt_src_in_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(intrpt_src_in[1]),
        .Q(p_119_out[1]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].t2_intrpt_src_in_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(p_119_out[1]),
        .Q(p_118_out[1]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT5 #(
    .INIT(32'h20000000)) 
    \gen_int.int_en_reg[15]_i_1 
       (.I0(\wr_strb_reg_n_0_[1] ),
        .I1(\w_addr_reg_n_0_[3] ),
        .I2(\w_addr_reg_n_0_[4] ),
        .I3(\w_addr_reg_n_0_[2] ),
        .I4(w_we_reg_n_0),
        .O(p_1_in[15]));
  LUT5 #(
    .INIT(32'h20000000)) 
    \gen_int.int_en_reg[23]_i_1 
       (.I0(\wr_strb_reg_n_0_[2] ),
        .I1(\w_addr_reg_n_0_[3] ),
        .I2(\w_addr_reg_n_0_[4] ),
        .I3(\w_addr_reg_n_0_[2] ),
        .I4(w_we_reg_n_0),
        .O(p_1_in[23]));
  LUT5 #(
    .INIT(32'h20000000)) 
    \gen_int.int_en_reg[31]_i_1 
       (.I0(\wr_strb_reg_n_0_[3] ),
        .I1(\w_addr_reg_n_0_[3] ),
        .I2(\w_addr_reg_n_0_[4] ),
        .I3(\w_addr_reg_n_0_[2] ),
        .I4(w_we_reg_n_0),
        .O(p_1_in[31]));
  LUT5 #(
    .INIT(32'h20000000)) 
    \gen_int.int_en_reg[7]_i_1 
       (.I0(wr_strb),
        .I1(\w_addr_reg_n_0_[3] ),
        .I2(\w_addr_reg_n_0_[4] ),
        .I3(\w_addr_reg_n_0_[2] ),
        .I4(w_we_reg_n_0),
        .O(p_1_in[7]));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[7]),
        .D(\w_data_reg_n_0_[0] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[0] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[15]),
        .D(w_data[10]),
        .Q(\gen_int.int_en_reg_reg_n_0_[10] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[15]),
        .D(w_data[11]),
        .Q(\gen_int.int_en_reg_reg_n_0_[11] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[15]),
        .D(w_data[12]),
        .Q(\gen_int.int_en_reg_reg_n_0_[12] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[15]),
        .D(w_data[13]),
        .Q(\gen_int.int_en_reg_reg_n_0_[13] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[15]),
        .D(w_data[14]),
        .Q(\gen_int.int_en_reg_reg_n_0_[14] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[15]),
        .D(w_data[15]),
        .Q(\gen_int.int_en_reg_reg_n_0_[15] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[23]),
        .D(w_data[16]),
        .Q(\gen_int.int_en_reg_reg_n_0_[16] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[23]),
        .D(w_data[17]),
        .Q(\gen_int.int_en_reg_reg_n_0_[17] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[23]),
        .D(w_data[18]),
        .Q(\gen_int.int_en_reg_reg_n_0_[18] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[23]),
        .D(w_data[19]),
        .Q(\gen_int.int_en_reg_reg_n_0_[19] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[7]),
        .D(\w_data_reg_n_0_[1] ),
        .Q(p_0_in16_in),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[23]),
        .D(w_data[20]),
        .Q(\gen_int.int_en_reg_reg_n_0_[20] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[23]),
        .D(w_data[21]),
        .Q(\gen_int.int_en_reg_reg_n_0_[21] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[23]),
        .D(w_data[22]),
        .Q(\gen_int.int_en_reg_reg_n_0_[22] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[23]),
        .D(w_data[23]),
        .Q(\gen_int.int_en_reg_reg_n_0_[23] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[31]),
        .D(w_data[24]),
        .Q(\gen_int.int_en_reg_reg_n_0_[24] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[31]),
        .D(w_data[25]),
        .Q(\gen_int.int_en_reg_reg_n_0_[25] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[31]),
        .D(w_data[26]),
        .Q(\gen_int.int_en_reg_reg_n_0_[26] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[31]),
        .D(w_data[27]),
        .Q(\gen_int.int_en_reg_reg_n_0_[27] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[31]),
        .D(w_data[28]),
        .Q(\gen_int.int_en_reg_reg_n_0_[28] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[31]),
        .D(w_data[29]),
        .Q(\gen_int.int_en_reg_reg_n_0_[29] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[7]),
        .D(w_data[2]),
        .Q(\gen_int.int_en_reg_reg_n_0_[2] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[31]),
        .D(w_data[30]),
        .Q(\gen_int.int_en_reg_reg_n_0_[30] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[31]),
        .D(w_data[31]),
        .Q(\gen_int.int_en_reg_reg_n_0_[31] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[7]),
        .D(w_data[3]),
        .Q(\gen_int.int_en_reg_reg_n_0_[3] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[7]),
        .D(w_data[4]),
        .Q(\gen_int.int_en_reg_reg_n_0_[4] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[7]),
        .D(w_data[5]),
        .Q(\gen_int.int_en_reg_reg_n_0_[5] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[7]),
        .D(w_data[6]),
        .Q(\gen_int.int_en_reg_reg_n_0_[6] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[7]),
        .D(w_data[7]),
        .Q(\gen_int.int_en_reg_reg_n_0_[7] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[15]),
        .D(w_data[8]),
        .Q(\gen_int.int_en_reg_reg_n_0_[8] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(p_1_in[15]),
        .D(w_data[9]),
        .Q(\gen_int.int_en_reg_reg_n_0_[9] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE \gen_int.irq_reg 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(usr_int),
        .Q(irq),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    \gen_int.usr_int_i_1 
       (.I0(p_116_out[1]),
        .I1(p_116_out[0]),
        .O(\gen_int.usr_int_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.usr_int_reg 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.usr_int_i_1_n_0 ),
        .Q(usr_int),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[0]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [0]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[10]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [10]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[11]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [11]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[12]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [12]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[13]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [13]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[14]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [14]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[15]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [15]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[16]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [16]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[17]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [17]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[18]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [18]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[19]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [19]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[1]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [1]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[20]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [20]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[21]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [21]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[22]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [22]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[23]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [23]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[24]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [24]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[25]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [25]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[26]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [26]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[27]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [27]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[28]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [28]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[29]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [29]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[2]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [2]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[30]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [30]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[31]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [31]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[3]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [3]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[4]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [4]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[5]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [5]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[6]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [6]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[7]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [7]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[8]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [8]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[9]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [9]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[0]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [0]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[10]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [10]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[11]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [11]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[12]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [12]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[13]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [13]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[14]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [14]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[15]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [15]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[16]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [16]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[17]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [17]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[18]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [18]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[19]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [19]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[1]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [1]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[20]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [20]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[21]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [21]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[22]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [22]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[23]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [23]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[24]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [24]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[25]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [25]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[26]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [26]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[27]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [27]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[28]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [28]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[29]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [29]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[2]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [2]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[30]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [30]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[31]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [31]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[3]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [3]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[4]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [4]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[5]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [5]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[6]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [6]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[7]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [7]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[8]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [8]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[1].stat_reg_reg[1][9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat1_in[9]),
        .Q(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [9]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00000008)) 
    \r_addr[4]_i_1 
       (.I0(s_axi_csr_aresetn),
        .I1(state[3]),
        .I2(state[2]),
        .I3(state[0]),
        .I4(state[1]),
        .O(\r_addr[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_addr_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(\r_addr[4]_i_1_n_0 ),
        .D(s_axi_csr_araddr[0]),
        .Q(sel0[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_addr_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(\r_addr[4]_i_1_n_0 ),
        .D(s_axi_csr_araddr[1]),
        .Q(sel0[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_addr_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(\r_addr[4]_i_1_n_0 ),
        .D(s_axi_csr_araddr[2]),
        .Q(sel0[2]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[0]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [0]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [0]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [0]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [0]),
        .O(\rd_data[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[0]_i_3 
       (.I0(int_flag_reg[0]),
        .I1(p_118_out[0]),
        .I2(sel0[1]),
        .I3(\gen_int.int_en_reg_reg_n_0_[0] ),
        .I4(sel0[0]),
        .I5(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [0]),
        .O(\rd_data[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[10]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [10]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[10] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[10]_i_2_n_0 ),
        .O(\rd_data[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[10]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [10]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [10]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [10]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [10]),
        .O(\rd_data[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[11]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [11]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[11] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[11]_i_2_n_0 ),
        .O(\rd_data[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[11]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [11]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [11]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [11]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [11]),
        .O(\rd_data[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[12]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [12]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[12] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[12]_i_2_n_0 ),
        .O(\rd_data[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[12]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [12]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [12]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [12]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [12]),
        .O(\rd_data[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[13]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [13]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[13] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[13]_i_2_n_0 ),
        .O(\rd_data[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[13]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [13]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [13]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [13]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [13]),
        .O(\rd_data[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[14]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [14]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[14] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[14]_i_2_n_0 ),
        .O(\rd_data[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[14]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [14]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [14]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [14]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [14]),
        .O(\rd_data[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[15]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [15]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[15] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[15]_i_2_n_0 ),
        .O(\rd_data[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[15]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [15]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [15]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [15]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [15]),
        .O(\rd_data[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[16]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [16]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[16] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[16]_i_2_n_0 ),
        .O(\rd_data[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[16]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [16]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [16]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [16]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [16]),
        .O(\rd_data[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[17]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [17]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[17] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[17]_i_2_n_0 ),
        .O(\rd_data[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[17]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [17]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [17]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [17]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [17]),
        .O(\rd_data[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[18]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [18]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[18] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[18]_i_2_n_0 ),
        .O(\rd_data[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[18]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [18]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [18]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [18]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [18]),
        .O(\rd_data[18]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[19]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [19]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[19] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[19]_i_2_n_0 ),
        .O(\rd_data[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[19]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [19]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [19]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [19]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [19]),
        .O(\rd_data[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[1]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [1]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [1]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [1]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [1]),
        .O(\rd_data[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[1]_i_3 
       (.I0(int_flag_reg[1]),
        .I1(p_118_out[1]),
        .I2(sel0[1]),
        .I3(p_0_in16_in),
        .I4(sel0[0]),
        .I5(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [1]),
        .O(\rd_data[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[20]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [20]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[20] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[20]_i_2_n_0 ),
        .O(\rd_data[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[20]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [20]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [20]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [20]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [20]),
        .O(\rd_data[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[21]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [21]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[21] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[21]_i_2_n_0 ),
        .O(\rd_data[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[21]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [21]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [21]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [21]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [21]),
        .O(\rd_data[21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[22]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [22]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[22] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[22]_i_2_n_0 ),
        .O(\rd_data[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[22]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [22]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [22]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [22]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [22]),
        .O(\rd_data[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[23]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [23]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[23] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[23]_i_2_n_0 ),
        .O(\rd_data[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[23]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [23]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [23]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [23]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [23]),
        .O(\rd_data[23]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[24]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [24]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[24] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[24]_i_2_n_0 ),
        .O(\rd_data[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[24]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [24]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [24]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [24]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [24]),
        .O(\rd_data[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[25]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [25]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[25] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[25]_i_2_n_0 ),
        .O(\rd_data[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[25]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [25]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [25]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [25]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [25]),
        .O(\rd_data[25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[26]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [26]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[26] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[26]_i_2_n_0 ),
        .O(\rd_data[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[26]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [26]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [26]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [26]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [26]),
        .O(\rd_data[26]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[27]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [27]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[27] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[27]_i_2_n_0 ),
        .O(\rd_data[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[27]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [27]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [27]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [27]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [27]),
        .O(\rd_data[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[28]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [28]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[28] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[28]_i_2_n_0 ),
        .O(\rd_data[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[28]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [28]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [28]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [28]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [28]),
        .O(\rd_data[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[29]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [29]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[29] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[29]_i_2_n_0 ),
        .O(\rd_data[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[29]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [29]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [29]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [29]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [29]),
        .O(\rd_data[29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[2]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [2]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[2] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[2]_i_2_n_0 ),
        .O(\rd_data[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[2]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [2]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [2]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [2]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [2]),
        .O(\rd_data[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[30]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [30]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[30] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[30]_i_2_n_0 ),
        .O(\rd_data[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[30]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [30]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [30]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [30]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [30]),
        .O(\rd_data[30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[31]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [31]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[31] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[31]_i_2_n_0 ),
        .O(\rd_data[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[31]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [31]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [31]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [31]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [31]),
        .O(\rd_data[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[3]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [3]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[3] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[3]_i_2_n_0 ),
        .O(\rd_data[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[3]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [3]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [3]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [3]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [3]),
        .O(\rd_data[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[4]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [4]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[4] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[4]_i_2_n_0 ),
        .O(\rd_data[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[4]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [4]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [4]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [4]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [4]),
        .O(\rd_data[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[5]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [5]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[5] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[5]_i_2_n_0 ),
        .O(\rd_data[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[5]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [5]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [5]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [5]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [5]),
        .O(\rd_data[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[6]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [6]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[6] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[6]_i_2_n_0 ),
        .O(\rd_data[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[6]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [6]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [6]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [6]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [6]),
        .O(\rd_data[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[7]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [7]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[7] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[7]_i_2_n_0 ),
        .O(\rd_data[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[7]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [7]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [7]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [7]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [7]),
        .O(\rd_data[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[8]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [8]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[8] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[8]_i_2_n_0 ),
        .O(\rd_data[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[8]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [8]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [8]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [8]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [8]),
        .O(\rd_data[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00E2FFFF00E20000)) 
    \rd_data[9]_i_1 
       (.I0(\gen_stat.gen_stat_regs[1].stat_reg_reg[1]_0 [9]),
        .I1(sel0[0]),
        .I2(\gen_int.int_en_reg_reg_n_0_[9] ),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(\rd_data[9]_i_2_n_0 ),
        .O(\rd_data[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rd_data[9]_i_2 
       (.I0(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_1 [9]),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_4 [9]),
        .I2(sel0[1]),
        .I3(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_3 [9]),
        .I4(sel0[0]),
        .I5(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_2 [9]),
        .O(\rd_data[9]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data_reg[0]_i_1_n_0 ),
        .Q(rd_data[0]),
        .R(1'b0));
  MUXF7 \rd_data_reg[0]_i_1 
       (.I0(\rd_data[0]_i_2_n_0 ),
        .I1(\rd_data[0]_i_3_n_0 ),
        .O(\rd_data_reg[0]_i_1_n_0 ),
        .S(sel0[2]));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[10]_i_1_n_0 ),
        .Q(rd_data[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[11]_i_1_n_0 ),
        .Q(rd_data[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[12]_i_1_n_0 ),
        .Q(rd_data[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[13]_i_1_n_0 ),
        .Q(rd_data[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[14]_i_1_n_0 ),
        .Q(rd_data[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[15]_i_1_n_0 ),
        .Q(rd_data[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[16]_i_1_n_0 ),
        .Q(rd_data[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[17]_i_1_n_0 ),
        .Q(rd_data[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[18]_i_1_n_0 ),
        .Q(rd_data[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[19]_i_1_n_0 ),
        .Q(rd_data[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data_reg[1]_i_1_n_0 ),
        .Q(rd_data[1]),
        .R(1'b0));
  MUXF7 \rd_data_reg[1]_i_1 
       (.I0(\rd_data[1]_i_2_n_0 ),
        .I1(\rd_data[1]_i_3_n_0 ),
        .O(\rd_data_reg[1]_i_1_n_0 ),
        .S(sel0[2]));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[20]_i_1_n_0 ),
        .Q(rd_data[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[21]_i_1_n_0 ),
        .Q(rd_data[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[22]_i_1_n_0 ),
        .Q(rd_data[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[23]_i_1_n_0 ),
        .Q(rd_data[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[24]_i_1_n_0 ),
        .Q(rd_data[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[25]_i_1_n_0 ),
        .Q(rd_data[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[26]_i_1_n_0 ),
        .Q(rd_data[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[27]_i_1_n_0 ),
        .Q(rd_data[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[28]_i_1_n_0 ),
        .Q(rd_data[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[29]_i_1_n_0 ),
        .Q(rd_data[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[2]_i_1_n_0 ),
        .Q(rd_data[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[30]_i_1_n_0 ),
        .Q(rd_data[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[31]_i_1_n_0 ),
        .Q(rd_data[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[3]_i_1_n_0 ),
        .Q(rd_data[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[4]_i_1_n_0 ),
        .Q(rd_data[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[5]_i_1_n_0 ),
        .Q(rd_data[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[6]_i_1_n_0 ),
        .Q(rd_data[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[7]_i_1_n_0 ),
        .Q(rd_data[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[8]_i_1_n_0 ),
        .Q(rd_data[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[9]_i_1_n_0 ),
        .Q(rd_data[9]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFDFF0100)) 
    s_axi_csr_arready_i_1
       (.I0(state[0]),
        .I1(state[1]),
        .I2(state[2]),
        .I3(state[3]),
        .I4(s_axi_csr_arready),
        .O(s_axi_csr_arready_i_1_n_0));
  FDRE s_axi_csr_arready_reg
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(s_axi_csr_arready_i_1_n_0),
        .Q(s_axi_csr_arready),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    s_axi_csr_awready_i_1
       (.I0(s_axi_csr_aresetn),
        .O(s_axi_csr_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFF99FF000011A2)) 
    s_axi_csr_awready_i_2
       (.I0(state[0]),
        .I1(state[2]),
        .I2(s_axi_csr_awvalid),
        .I3(state[1]),
        .I4(state[3]),
        .I5(s_axi_csr_awready),
        .O(s_axi_csr_awready_i_2_n_0));
  FDRE s_axi_csr_awready_reg
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(s_axi_csr_awready_i_2_n_0),
        .Q(s_axi_csr_awready),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFF7FFF00002200)) 
    s_axi_csr_bvalid_i_1
       (.I0(state[1]),
        .I1(state[0]),
        .I2(s_axi_csr_bready),
        .I3(state[2]),
        .I4(state[3]),
        .I5(s_axi_csr_bvalid),
        .O(s_axi_csr_bvalid_i_1_n_0));
  FDRE s_axi_csr_bvalid_reg
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(s_axi_csr_bvalid_i_1_n_0),
        .Q(s_axi_csr_bvalid),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT5 #(
    .INIT(32'h02000000)) 
    \s_axi_csr_rdata[31]_i_1 
       (.I0(state[3]),
        .I1(state[2]),
        .I2(state[0]),
        .I3(state[1]),
        .I4(s_axi_csr_aresetn),
        .O(\s_axi_csr_rdata[31]_i_1_n_0 ));
  FDRE \s_axi_csr_rdata_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[0]),
        .Q(s_axi_csr_rdata[0]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[10]),
        .Q(s_axi_csr_rdata[10]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[11]),
        .Q(s_axi_csr_rdata[11]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[12]),
        .Q(s_axi_csr_rdata[12]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[13]),
        .Q(s_axi_csr_rdata[13]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[14]),
        .Q(s_axi_csr_rdata[14]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[15]),
        .Q(s_axi_csr_rdata[15]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[16]),
        .Q(s_axi_csr_rdata[16]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[17]),
        .Q(s_axi_csr_rdata[17]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[18]),
        .Q(s_axi_csr_rdata[18]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[19]),
        .Q(s_axi_csr_rdata[19]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[1]),
        .Q(s_axi_csr_rdata[1]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[20]),
        .Q(s_axi_csr_rdata[20]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[21]),
        .Q(s_axi_csr_rdata[21]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[22]),
        .Q(s_axi_csr_rdata[22]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[23]),
        .Q(s_axi_csr_rdata[23]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[24]),
        .Q(s_axi_csr_rdata[24]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[25]),
        .Q(s_axi_csr_rdata[25]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[26]),
        .Q(s_axi_csr_rdata[26]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[27]),
        .Q(s_axi_csr_rdata[27]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[28]),
        .Q(s_axi_csr_rdata[28]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[29]),
        .Q(s_axi_csr_rdata[29]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[2]),
        .Q(s_axi_csr_rdata[2]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[30]),
        .Q(s_axi_csr_rdata[30]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[31]),
        .Q(s_axi_csr_rdata[31]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[3]),
        .Q(s_axi_csr_rdata[3]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[4]),
        .Q(s_axi_csr_rdata[4]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[5]),
        .Q(s_axi_csr_rdata[5]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[6]),
        .Q(s_axi_csr_rdata[6]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[7]),
        .Q(s_axi_csr_rdata[7]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[8]),
        .Q(s_axi_csr_rdata[8]),
        .R(1'b0));
  FDRE \s_axi_csr_rdata_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(\s_axi_csr_rdata[31]_i_1_n_0 ),
        .D(rd_data[9]),
        .Q(s_axi_csr_rdata[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFF7FFFFF00220000)) 
    s_axi_csr_rvalid_i_1
       (.I0(state[1]),
        .I1(state[0]),
        .I2(s_axi_csr_rready),
        .I3(state[2]),
        .I4(state[3]),
        .I5(s_axi_csr_rvalid),
        .O(s_axi_csr_rvalid_i_1_n_0));
  FDRE s_axi_csr_rvalid_reg
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(s_axi_csr_rvalid_i_1_n_0),
        .Q(s_axi_csr_rvalid),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFB7B700002606)) 
    s_axi_csr_wready_i_1
       (.I0(state[0]),
        .I1(state[2]),
        .I2(state[1]),
        .I3(s_axi_csr_wvalid),
        .I4(state[3]),
        .I5(s_axi_csr_wready),
        .O(s_axi_csr_wready_i_1_n_0));
  FDRE s_axi_csr_wready_reg
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(s_axi_csr_wready_i_1_n_0),
        .Q(s_axi_csr_wready),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'h1011004400000000)) 
    \w_addr[4]_i_1 
       (.I0(state[3]),
        .I1(state[1]),
        .I2(s_axi_csr_awvalid),
        .I3(state[2]),
        .I4(state[0]),
        .I5(s_axi_csr_aresetn),
        .O(\w_addr[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \w_addr_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(\w_addr[4]_i_1_n_0 ),
        .D(s_axi_csr_awaddr[0]),
        .Q(\w_addr_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_addr_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(\w_addr[4]_i_1_n_0 ),
        .D(s_axi_csr_awaddr[1]),
        .Q(\w_addr_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_addr_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(\w_addr[4]_i_1_n_0 ),
        .D(s_axi_csr_awaddr[2]),
        .Q(\w_addr_reg_n_0_[4] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0045050000000000)) 
    \w_data[31]_i_1 
       (.I0(state[3]),
        .I1(s_axi_csr_wvalid),
        .I2(state[1]),
        .I3(state[2]),
        .I4(state[0]),
        .I5(s_axi_csr_aresetn),
        .O(\w_data[31]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[0]),
        .Q(\w_data_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[10]),
        .Q(w_data[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[11]),
        .Q(w_data[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[12]),
        .Q(w_data[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[13]),
        .Q(w_data[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[14]),
        .Q(w_data[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[15]),
        .Q(w_data[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[16]),
        .Q(w_data[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[17]),
        .Q(w_data[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[18]),
        .Q(w_data[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[19]),
        .Q(w_data[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[1]),
        .Q(\w_data_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[20]),
        .Q(w_data[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[21]),
        .Q(w_data[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[22]),
        .Q(w_data[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[23]),
        .Q(w_data[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[24]),
        .Q(w_data[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[25]),
        .Q(w_data[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[26]),
        .Q(w_data[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[27]),
        .Q(w_data[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[28]),
        .Q(w_data[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[29]),
        .Q(w_data[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[2]),
        .Q(w_data[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[30]),
        .Q(w_data[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[31]),
        .Q(w_data[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[3]),
        .Q(w_data[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[4]),
        .Q(w_data[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[5]),
        .Q(w_data[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[6]),
        .Q(w_data[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[7]),
        .Q(w_data[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[8]),
        .Q(w_data[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(\w_data[31]_i_1_n_0 ),
        .D(s_axi_csr_wdata[9]),
        .Q(w_data[9]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFF7F0040)) 
    w_we_i_1
       (.I0(state[0]),
        .I1(state[1]),
        .I2(state[2]),
        .I3(state[3]),
        .I4(w_we_reg_n_0),
        .O(w_we_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    w_we_reg
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(w_we_i_1_n_0),
        .Q(w_we_reg_n_0),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT5 #(
    .INIT(32'h00002606)) 
    \wr_strb[3]_i_1 
       (.I0(state[0]),
        .I1(state[2]),
        .I2(state[1]),
        .I3(s_axi_csr_wvalid),
        .I4(state[3]),
        .O(\wr_strb[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \wr_strb_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(\wr_strb[3]_i_1_n_0 ),
        .D(s_axi_csr_wstrb[0]),
        .Q(wr_strb),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_strb_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(\wr_strb[3]_i_1_n_0 ),
        .D(s_axi_csr_wstrb[1]),
        .Q(\wr_strb_reg_n_0_[1] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_strb_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(\wr_strb[3]_i_1_n_0 ),
        .D(s_axi_csr_wstrb[2]),
        .Q(\wr_strb_reg_n_0_[2] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_strb_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(\wr_strb[3]_i_1_n_0 ),
        .D(s_axi_csr_wstrb[3]),
        .Q(\wr_strb_reg_n_0_[3] ),
        .R(s_axi_csr_awready_i_1_n_0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
