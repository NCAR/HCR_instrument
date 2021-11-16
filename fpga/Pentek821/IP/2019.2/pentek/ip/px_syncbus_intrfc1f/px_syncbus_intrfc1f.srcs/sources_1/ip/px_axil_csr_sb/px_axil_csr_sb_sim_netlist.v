// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Fri Dec 20 11:08:11 2019
// Host        : DESKTOP-A2UUJ55 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/ip/2019.2/pentek/ip/px_syncbus_intrfc1f/px_syncbus_intrfc1f.srcs/sources_1/ip/px_axil_csr_sb/px_axil_csr_sb_sim_netlist.v
// Design      : px_axil_csr_sb
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axil_csr_sb,px_axil_csr,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "px_axil_csr,Vivado 2019.2" *) 
(* NotValidForBitStream *)
module px_axil_csr_sb
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
    reg3_init_val,
    reg4_init_val,
    reg5_init_val,
    reg6_init_val,
    ctl0_out,
    ctl1_out,
    ctl2_out,
    ctl3_out,
    ctl4_out,
    ctl5_out,
    ctl6_out,
    stat0_in,
    intrpt_src_in,
    irq);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME s_axi_csr_aclk, ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input s_axi_csr_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 s_axi_csr_aresetn RST" *) (* x_interface_parameter = "XIL_INTERFACENAME s_axi_csr_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axi_csr_aresetn;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi_csr AWADDR" *) (* x_interface_parameter = "XIL_INTERFACENAME s_axi_csr, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 7, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [6:0]s_axi_csr_awaddr;
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
  input [31:0]reg3_init_val;
  input [31:0]reg4_init_val;
  input [31:0]reg5_init_val;
  input [31:0]reg6_init_val;
  output [31:0]ctl0_out;
  output [31:0]ctl1_out;
  output [31:0]ctl2_out;
  output [31:0]ctl3_out;
  output [31:0]ctl4_out;
  output [31:0]ctl5_out;
  output [31:0]ctl6_out;
  input [31:0]stat0_in;
  input [7:0]intrpt_src_in;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 irq INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME irq, SENSITIVITY EDGE_RISING, PortWidth 1" *) output irq;

  wire \<const0> ;
  wire [31:0]ctl0_out;
  wire [31:0]ctl1_out;
  wire [31:0]ctl2_out;
  wire [31:0]ctl3_out;
  wire [31:0]ctl4_out;
  wire [31:0]ctl5_out;
  wire [31:0]ctl6_out;
  wire [7:0]intrpt_src_in;
  wire irq;
  wire [31:0]reg0_init_val;
  wire [31:0]reg1_init_val;
  wire [31:0]reg2_init_val;
  wire [31:0]reg3_init_val;
  wire [31:0]reg4_init_val;
  wire [31:0]reg5_init_val;
  wire [31:0]reg6_init_val;
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

  assign s_axi_csr_bresp[1] = \<const0> ;
  assign s_axi_csr_bresp[0] = \<const0> ;
  assign s_axi_csr_rresp[1] = \<const0> ;
  assign s_axi_csr_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  px_axil_csr_sb_px_axil_csr U0
       (.ctl0_out(ctl0_out),
        .ctl1_out(ctl1_out),
        .ctl2_out(ctl2_out),
        .ctl3_out(ctl3_out),
        .ctl4_out(ctl4_out),
        .ctl5_out(ctl5_out),
        .ctl6_out(ctl6_out),
        .intrpt_src_in(intrpt_src_in),
        .irq(irq),
        .reg0_init_val(reg0_init_val),
        .reg1_init_val(reg1_init_val),
        .reg2_init_val(reg2_init_val),
        .reg3_init_val(reg3_init_val),
        .reg4_init_val(reg4_init_val),
        .reg5_init_val(reg5_init_val),
        .reg6_init_val(reg6_init_val),
        .s_axi_csr_aclk(s_axi_csr_aclk),
        .s_axi_csr_araddr(s_axi_csr_araddr[5:2]),
        .s_axi_csr_aresetn(s_axi_csr_aresetn),
        .s_axi_csr_arready(s_axi_csr_arready),
        .s_axi_csr_arvalid(s_axi_csr_arvalid),
        .s_axi_csr_awaddr(s_axi_csr_awaddr[5:2]),
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
        .stat0_in(stat0_in));
endmodule

(* ORIG_REF_NAME = "px_axil_csr" *) 
module px_axil_csr_sb_px_axil_csr
   (s_axi_csr_rdata,
    ctl0_out,
    ctl1_out,
    ctl2_out,
    ctl3_out,
    ctl4_out,
    ctl5_out,
    ctl6_out,
    irq,
    s_axi_csr_awready,
    s_axi_csr_wready,
    s_axi_csr_bvalid,
    s_axi_csr_arready,
    s_axi_csr_rvalid,
    s_axi_csr_aclk,
    intrpt_src_in,
    s_axi_csr_wstrb,
    s_axi_csr_wdata,
    s_axi_csr_awaddr,
    s_axi_csr_araddr,
    stat0_in,
    s_axi_csr_aresetn,
    s_axi_csr_awvalid,
    s_axi_csr_wvalid,
    s_axi_csr_bready,
    s_axi_csr_arvalid,
    s_axi_csr_rready,
    reg6_init_val,
    reg5_init_val,
    reg4_init_val,
    reg3_init_val,
    reg2_init_val,
    reg1_init_val,
    reg0_init_val);
  output [31:0]s_axi_csr_rdata;
  output [31:0]ctl0_out;
  output [31:0]ctl1_out;
  output [31:0]ctl2_out;
  output [31:0]ctl3_out;
  output [31:0]ctl4_out;
  output [31:0]ctl5_out;
  output [31:0]ctl6_out;
  output irq;
  output s_axi_csr_awready;
  output s_axi_csr_wready;
  output s_axi_csr_bvalid;
  output s_axi_csr_arready;
  output s_axi_csr_rvalid;
  input s_axi_csr_aclk;
  input [7:0]intrpt_src_in;
  input [3:0]s_axi_csr_wstrb;
  input [31:0]s_axi_csr_wdata;
  input [3:0]s_axi_csr_awaddr;
  input [3:0]s_axi_csr_araddr;
  input [31:0]stat0_in;
  input s_axi_csr_aresetn;
  input s_axi_csr_awvalid;
  input s_axi_csr_wvalid;
  input s_axi_csr_bready;
  input s_axi_csr_arvalid;
  input s_axi_csr_rready;
  input [31:0]reg6_init_val;
  input [31:0]reg5_init_val;
  input [31:0]reg4_init_val;
  input [31:0]reg3_init_val;
  input [31:0]reg2_init_val;
  input [31:0]reg1_init_val;
  input [31:0]reg0_init_val;

  wire \FSM_onehot_state[0]_i_1_n_0 ;
  wire \FSM_onehot_state[0]_i_2_n_0 ;
  wire \FSM_onehot_state[0]_i_3_n_0 ;
  wire \FSM_onehot_state[11]_i_1_n_0 ;
  wire \FSM_onehot_state[1]_i_1_n_0 ;
  wire \FSM_onehot_state[2]_i_1_n_0 ;
  wire \FSM_onehot_state[3]_i_1_n_0 ;
  wire \FSM_onehot_state[4]_i_1_n_0 ;
  wire \FSM_onehot_state[5]_i_1_n_0 ;
  wire \FSM_onehot_state[6]_i_1_n_0 ;
  wire \FSM_onehot_state[7]_i_1_n_0 ;
  wire \FSM_onehot_state[8]_i_1_n_0 ;
  wire \FSM_onehot_state_reg_n_0_[0] ;
  wire \FSM_onehot_state_reg_n_0_[10] ;
  wire \FSM_onehot_state_reg_n_0_[11] ;
  wire \FSM_onehot_state_reg_n_0_[1] ;
  wire \FSM_onehot_state_reg_n_0_[2] ;
  wire \FSM_onehot_state_reg_n_0_[3] ;
  wire \FSM_onehot_state_reg_n_0_[4] ;
  wire \FSM_onehot_state_reg_n_0_[5] ;
  wire \FSM_onehot_state_reg_n_0_[6] ;
  wire \FSM_onehot_state_reg_n_0_[7] ;
  wire \FSM_onehot_state_reg_n_0_[9] ;
  wire [31:0]ctl0_out;
  wire [31:0]ctl1_out;
  wire [31:0]ctl2_out;
  wire [31:0]ctl3_out;
  wire [31:0]ctl4_out;
  wire [31:0]ctl5_out;
  wire [31:0]ctl6_out;
  wire data00;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1_n_0 ;
  wire [31:0]\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 ;
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
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_3_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1_n_0 ;
  wire [31:0]\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 ;
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
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_3_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1_n_0 ;
  wire [31:0]\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][0]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][10]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][11]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][12]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][13]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][14]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][16]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][17]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][18]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][19]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][1]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][20]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][21]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][22]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][24]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][25]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][26]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][27]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][28]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][29]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][2]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][30]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_3_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][3]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][4]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][5]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][6]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][8]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[3].cntl_reg[3][9]_i_1_n_0 ;
  wire [31:0]\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][0]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][10]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][11]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][12]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][13]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][14]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][16]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][17]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][18]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][19]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][1]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][20]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][21]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][22]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][24]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][25]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][26]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][27]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][28]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][29]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][2]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][30]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_3_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][3]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][4]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][5]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][6]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][8]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[4].cntl_reg[4][9]_i_1_n_0 ;
  wire [31:0]\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][0]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][10]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][11]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][12]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][13]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][14]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][16]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][17]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][18]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][19]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][1]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][20]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][21]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][22]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][24]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][25]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][26]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][27]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][28]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][29]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][2]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][30]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_3_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][3]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][4]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][5]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][6]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][8]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[5].cntl_reg[5][9]_i_1_n_0 ;
  wire [31:0]\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][0]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][10]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][11]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][12]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][13]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][14]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][16]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][17]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][18]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][19]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][1]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][20]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][21]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][22]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][24]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][25]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][26]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][27]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][28]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][29]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][2]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][30]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_3_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][3]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][4]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][5]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][6]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_2_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][8]_i_1_n_0 ;
  wire \gen_cntl.gen_ctl_regs[6].cntl_reg[6][9]_i_1_n_0 ;
  wire [31:0]\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 ;
  wire \gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1_n_0 ;
  wire \gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1_n_0 ;
  wire \gen_int.gen_int_flag.gen_int_flag_reg[2].int_flag_reg[2]_i_1_n_0 ;
  wire \gen_int.gen_int_flag.gen_int_flag_reg[3].int_flag_reg[3]_i_1_n_0 ;
  wire \gen_int.gen_int_flag.gen_int_flag_reg[4].int_flag_reg[4]_i_1_n_0 ;
  wire \gen_int.gen_int_flag.gen_int_flag_reg[5].int_flag_reg[5]_i_1_n_0 ;
  wire \gen_int.gen_int_flag.gen_int_flag_reg[6].int_flag_reg[6]_i_1_n_0 ;
  wire \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_1_n_0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[0].int_and_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[0].re_int_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[1].int_and_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[1].re_int_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[2].int_and_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[2].re_int_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[3].int_and_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[3].re_int_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[4].int_and_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[4].re_int_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[5].int_and_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[5].re_int_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[6].int_and_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[6].re_int_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[7].int_and_reg0 ;
  wire \gen_int.gen_int_src.gen_int_src_reg[7].re_int_reg0 ;
  wire \gen_int.int_en_reg[15]_i_1_n_0 ;
  wire \gen_int.int_en_reg[23]_i_1_n_0 ;
  wire \gen_int.int_en_reg[31]_i_1_n_0 ;
  wire \gen_int.int_en_reg[7]_i_1_n_0 ;
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
  wire \gen_int.int_en_reg_reg_n_0_[30] ;
  wire \gen_int.int_en_reg_reg_n_0_[31] ;
  wire \gen_int.int_en_reg_reg_n_0_[8] ;
  wire \gen_int.int_en_reg_reg_n_0_[9] ;
  wire \gen_int.usr_int_i_1_n_0 ;
  wire \gen_int.usr_int_i_2_n_0 ;
  wire [31:0]\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 ;
  wire [7:0]int_and;
  wire [7:0]int_flag_reg;
  wire [7:0]intrpt_src_in;
  wire irq;
  wire p_0_in;
  wire p_0_in21_in;
  wire p_0_in24_in;
  wire p_0_in27_in;
  wire p_0_in30_in;
  wire p_0_in33_in;
  wire p_0_in36_in;
  wire p_0_in39_in;
  wire [31:7]p_0_in__0;
  wire p_1_in;
  wire p_1_in10_in;
  wire p_1_in13_in;
  wire p_1_in16_in;
  wire p_1_in4_in;
  wire p_1_in7_in;
  wire r_addr;
  wire \r_addr[5]_i_1_n_0 ;
  wire [2:0]r_addr_num;
  wire \r_addr_reg_n_0_[5] ;
  wire [31:0]rd_data;
  wire \rd_data[0]_i_1_n_0 ;
  wire \rd_data[0]_i_2_n_0 ;
  wire \rd_data[0]_i_3_n_0 ;
  wire \rd_data[0]_i_4_n_0 ;
  wire \rd_data[0]_i_5_n_0 ;
  wire \rd_data[10]_i_1_n_0 ;
  wire \rd_data[10]_i_2_n_0 ;
  wire \rd_data[10]_i_3_n_0 ;
  wire \rd_data[10]_i_4_n_0 ;
  wire \rd_data[11]_i_1_n_0 ;
  wire \rd_data[11]_i_2_n_0 ;
  wire \rd_data[11]_i_3_n_0 ;
  wire \rd_data[11]_i_4_n_0 ;
  wire \rd_data[12]_i_1_n_0 ;
  wire \rd_data[12]_i_2_n_0 ;
  wire \rd_data[12]_i_3_n_0 ;
  wire \rd_data[12]_i_4_n_0 ;
  wire \rd_data[13]_i_1_n_0 ;
  wire \rd_data[13]_i_2_n_0 ;
  wire \rd_data[13]_i_3_n_0 ;
  wire \rd_data[13]_i_4_n_0 ;
  wire \rd_data[14]_i_1_n_0 ;
  wire \rd_data[14]_i_2_n_0 ;
  wire \rd_data[14]_i_3_n_0 ;
  wire \rd_data[14]_i_4_n_0 ;
  wire \rd_data[15]_i_1_n_0 ;
  wire \rd_data[15]_i_2_n_0 ;
  wire \rd_data[15]_i_3_n_0 ;
  wire \rd_data[15]_i_4_n_0 ;
  wire \rd_data[16]_i_1_n_0 ;
  wire \rd_data[16]_i_2_n_0 ;
  wire \rd_data[16]_i_3_n_0 ;
  wire \rd_data[16]_i_4_n_0 ;
  wire \rd_data[17]_i_1_n_0 ;
  wire \rd_data[17]_i_2_n_0 ;
  wire \rd_data[17]_i_3_n_0 ;
  wire \rd_data[17]_i_4_n_0 ;
  wire \rd_data[18]_i_1_n_0 ;
  wire \rd_data[18]_i_2_n_0 ;
  wire \rd_data[18]_i_3_n_0 ;
  wire \rd_data[18]_i_4_n_0 ;
  wire \rd_data[19]_i_1_n_0 ;
  wire \rd_data[19]_i_2_n_0 ;
  wire \rd_data[19]_i_3_n_0 ;
  wire \rd_data[19]_i_4_n_0 ;
  wire \rd_data[1]_i_1_n_0 ;
  wire \rd_data[1]_i_2_n_0 ;
  wire \rd_data[1]_i_3_n_0 ;
  wire \rd_data[1]_i_4_n_0 ;
  wire \rd_data[1]_i_5_n_0 ;
  wire \rd_data[20]_i_1_n_0 ;
  wire \rd_data[20]_i_2_n_0 ;
  wire \rd_data[20]_i_3_n_0 ;
  wire \rd_data[20]_i_4_n_0 ;
  wire \rd_data[21]_i_1_n_0 ;
  wire \rd_data[21]_i_2_n_0 ;
  wire \rd_data[21]_i_3_n_0 ;
  wire \rd_data[21]_i_4_n_0 ;
  wire \rd_data[22]_i_1_n_0 ;
  wire \rd_data[22]_i_2_n_0 ;
  wire \rd_data[22]_i_3_n_0 ;
  wire \rd_data[22]_i_4_n_0 ;
  wire \rd_data[23]_i_1_n_0 ;
  wire \rd_data[23]_i_2_n_0 ;
  wire \rd_data[23]_i_3_n_0 ;
  wire \rd_data[23]_i_4_n_0 ;
  wire \rd_data[24]_i_1_n_0 ;
  wire \rd_data[24]_i_2_n_0 ;
  wire \rd_data[24]_i_3_n_0 ;
  wire \rd_data[24]_i_4_n_0 ;
  wire \rd_data[25]_i_1_n_0 ;
  wire \rd_data[25]_i_2_n_0 ;
  wire \rd_data[25]_i_3_n_0 ;
  wire \rd_data[25]_i_4_n_0 ;
  wire \rd_data[26]_i_1_n_0 ;
  wire \rd_data[26]_i_2_n_0 ;
  wire \rd_data[26]_i_3_n_0 ;
  wire \rd_data[26]_i_4_n_0 ;
  wire \rd_data[27]_i_1_n_0 ;
  wire \rd_data[27]_i_2_n_0 ;
  wire \rd_data[27]_i_3_n_0 ;
  wire \rd_data[27]_i_4_n_0 ;
  wire \rd_data[28]_i_1_n_0 ;
  wire \rd_data[28]_i_2_n_0 ;
  wire \rd_data[28]_i_3_n_0 ;
  wire \rd_data[28]_i_4_n_0 ;
  wire \rd_data[29]_i_1_n_0 ;
  wire \rd_data[29]_i_2_n_0 ;
  wire \rd_data[29]_i_3_n_0 ;
  wire \rd_data[29]_i_4_n_0 ;
  wire \rd_data[2]_i_1_n_0 ;
  wire \rd_data[2]_i_2_n_0 ;
  wire \rd_data[2]_i_3_n_0 ;
  wire \rd_data[2]_i_4_n_0 ;
  wire \rd_data[2]_i_5_n_0 ;
  wire \rd_data[30]_i_1_n_0 ;
  wire \rd_data[30]_i_2_n_0 ;
  wire \rd_data[30]_i_3_n_0 ;
  wire \rd_data[30]_i_4_n_0 ;
  wire \rd_data[31]_i_1_n_0 ;
  wire \rd_data[31]_i_2_n_0 ;
  wire \rd_data[31]_i_3_n_0 ;
  wire \rd_data[31]_i_4_n_0 ;
  wire \rd_data[31]_i_5_n_0 ;
  wire \rd_data[3]_i_1_n_0 ;
  wire \rd_data[3]_i_2_n_0 ;
  wire \rd_data[3]_i_3_n_0 ;
  wire \rd_data[3]_i_4_n_0 ;
  wire \rd_data[3]_i_5_n_0 ;
  wire \rd_data[4]_i_1_n_0 ;
  wire \rd_data[4]_i_2_n_0 ;
  wire \rd_data[4]_i_3_n_0 ;
  wire \rd_data[4]_i_4_n_0 ;
  wire \rd_data[4]_i_5_n_0 ;
  wire \rd_data[5]_i_1_n_0 ;
  wire \rd_data[5]_i_2_n_0 ;
  wire \rd_data[5]_i_3_n_0 ;
  wire \rd_data[5]_i_4_n_0 ;
  wire \rd_data[5]_i_5_n_0 ;
  wire \rd_data[6]_i_1_n_0 ;
  wire \rd_data[6]_i_2_n_0 ;
  wire \rd_data[6]_i_3_n_0 ;
  wire \rd_data[6]_i_4_n_0 ;
  wire \rd_data[6]_i_5_n_0 ;
  wire \rd_data[7]_i_1_n_0 ;
  wire \rd_data[7]_i_2_n_0 ;
  wire \rd_data[7]_i_3_n_0 ;
  wire \rd_data[7]_i_4_n_0 ;
  wire \rd_data[7]_i_5_n_0 ;
  wire \rd_data[7]_i_6_n_0 ;
  wire \rd_data[7]_i_7_n_0 ;
  wire \rd_data[8]_i_1_n_0 ;
  wire \rd_data[8]_i_2_n_0 ;
  wire \rd_data[8]_i_3_n_0 ;
  wire \rd_data[8]_i_4_n_0 ;
  wire \rd_data[9]_i_1_n_0 ;
  wire \rd_data[9]_i_2_n_0 ;
  wire \rd_data[9]_i_3_n_0 ;
  wire \rd_data[9]_i_4_n_0 ;
  wire [7:0]re_int;
  wire [31:0]reg0_init_val;
  wire [31:0]reg1_init_val;
  wire [31:0]reg2_init_val;
  wire [31:0]reg3_init_val;
  wire [31:0]reg4_init_val;
  wire [31:0]reg5_init_val;
  wire [31:0]reg6_init_val;
  wire reg_clr1__1;
  wire s_axi_csr_aclk;
  wire [3:0]s_axi_csr_araddr;
  wire s_axi_csr_aresetn;
  wire s_axi_csr_arready;
  wire s_axi_csr_arready_i_1_n_0;
  wire s_axi_csr_arvalid;
  wire [3:0]s_axi_csr_awaddr;
  wire s_axi_csr_awready;
  wire s_axi_csr_awready_i_1_n_0;
  wire s_axi_csr_awready_i_2_n_0;
  wire s_axi_csr_awready_i_3_n_0;
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
  wire s_axi_csr_wready_i_2_n_0;
  wire [3:0]s_axi_csr_wstrb;
  wire s_axi_csr_wvalid;
  wire [31:0]stat0_in;
  wire [7:0]t1_intrpt_src_in;
  wire [7:0]t2_intrpt_src_in;
  wire usr_int;
  wire \w_addr[5]_i_1_n_0 ;
  wire [5:2]w_addr__0;
  wire w_data;
  wire \w_data_reg_n_0_[0] ;
  wire \w_data_reg_n_0_[10] ;
  wire \w_data_reg_n_0_[11] ;
  wire \w_data_reg_n_0_[12] ;
  wire \w_data_reg_n_0_[13] ;
  wire \w_data_reg_n_0_[14] ;
  wire \w_data_reg_n_0_[15] ;
  wire \w_data_reg_n_0_[16] ;
  wire \w_data_reg_n_0_[17] ;
  wire \w_data_reg_n_0_[18] ;
  wire \w_data_reg_n_0_[19] ;
  wire \w_data_reg_n_0_[20] ;
  wire \w_data_reg_n_0_[21] ;
  wire \w_data_reg_n_0_[22] ;
  wire \w_data_reg_n_0_[23] ;
  wire \w_data_reg_n_0_[24] ;
  wire \w_data_reg_n_0_[25] ;
  wire \w_data_reg_n_0_[26] ;
  wire \w_data_reg_n_0_[27] ;
  wire \w_data_reg_n_0_[28] ;
  wire \w_data_reg_n_0_[29] ;
  wire \w_data_reg_n_0_[30] ;
  wire \w_data_reg_n_0_[31] ;
  wire \w_data_reg_n_0_[7] ;
  wire \w_data_reg_n_0_[8] ;
  wire \w_data_reg_n_0_[9] ;
  wire w_we_i_1_n_0;
  wire w_we_reg_n_0;
  wire \wr_strb[3]_i_1_n_0 ;
  wire \wr_strb_reg_n_0_[2] ;
  wire \wr_strb_reg_n_0_[3] ;

  LUT6 #(
    .INIT(64'hEAEAEAEAEAEAFFEA)) 
    \FSM_onehot_state[0]_i_1 
       (.I0(\FSM_onehot_state[0]_i_2_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[7] ),
        .I2(s_axi_csr_bready),
        .I3(\FSM_onehot_state[0]_i_3_n_0 ),
        .I4(s_axi_csr_arvalid),
        .I5(s_axi_csr_wvalid),
        .O(\FSM_onehot_state[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_onehot_state[0]_i_2 
       (.I0(\FSM_onehot_state_reg_n_0_[11] ),
        .I1(s_axi_csr_rready),
        .O(\FSM_onehot_state[0]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_onehot_state[0]_i_3 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(s_axi_csr_awvalid),
        .O(\FSM_onehot_state[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    \FSM_onehot_state[11]_i_1 
       (.I0(s_axi_csr_rready),
        .I1(\FSM_onehot_state_reg_n_0_[11] ),
        .I2(\FSM_onehot_state_reg_n_0_[10] ),
        .O(\FSM_onehot_state[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \FSM_onehot_state[1]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(s_axi_csr_awvalid),
        .I2(s_axi_csr_wvalid),
        .O(\FSM_onehot_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \FSM_onehot_state[2]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(s_axi_csr_awvalid),
        .I2(s_axi_csr_wvalid),
        .O(\FSM_onehot_state[2]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hF4)) 
    \FSM_onehot_state[3]_i_1 
       (.I0(s_axi_csr_wvalid),
        .I1(\FSM_onehot_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .O(\FSM_onehot_state[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \FSM_onehot_state[4]_i_1 
       (.I0(s_axi_csr_awvalid),
        .I1(\FSM_onehot_state_reg_n_0_[0] ),
        .I2(s_axi_csr_wvalid),
        .O(\FSM_onehot_state[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    \FSM_onehot_state[5]_i_1 
       (.I0(s_axi_csr_awvalid),
        .I1(\FSM_onehot_state_reg_n_0_[5] ),
        .I2(\FSM_onehot_state_reg_n_0_[4] ),
        .O(\FSM_onehot_state[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFFF8F8F8)) 
    \FSM_onehot_state[6]_i_1 
       (.I0(s_axi_csr_awvalid),
        .I1(\FSM_onehot_state_reg_n_0_[5] ),
        .I2(\FSM_onehot_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_state_reg_n_0_[3] ),
        .I4(s_axi_csr_wvalid),
        .O(\FSM_onehot_state[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    \FSM_onehot_state[7]_i_1 
       (.I0(s_axi_csr_bready),
        .I1(\FSM_onehot_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_state_reg_n_0_[6] ),
        .O(\FSM_onehot_state[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    \FSM_onehot_state[8]_i_1 
       (.I0(s_axi_csr_wvalid),
        .I1(s_axi_csr_arvalid),
        .I2(s_axi_csr_awvalid),
        .I3(\FSM_onehot_state_reg_n_0_[0] ),
        .O(\FSM_onehot_state[8]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_state_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[0]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[0] ),
        .S(s_axi_csr_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state_reg_n_0_[9] ),
        .Q(\FSM_onehot_state_reg_n_0_[10] ),
        .R(s_axi_csr_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[11]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[11] ),
        .R(s_axi_csr_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[1]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[1] ),
        .R(s_axi_csr_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[2]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[2] ),
        .R(s_axi_csr_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[3]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[3] ),
        .R(s_axi_csr_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[4]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[4] ),
        .R(s_axi_csr_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[5]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[5] ),
        .R(s_axi_csr_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[6]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[6] ),
        .R(s_axi_csr_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[7]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[7] ),
        .R(s_axi_csr_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[8]_i_1_n_0 ),
        .Q(r_addr),
        .R(s_axi_csr_awready_i_1_n_0));
  (* FSM_ENCODED_STATES = "wr_addr_state:000000000100,wr_addr2_state:000000100000,wr_data_state:000000010000,wait_rddata_rdy_state:100000000000,wait_rd_cmplt_state:010000000000,wr_addr_data_state:000000000010,reset_state:000000000001,wait_rd_bs_state:001000000000,wr_b_rsp_state:000010000000,rd_addr_state:000100000000,wr_addr_dec_state:000001000000,wr_data2_state:000000001000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(r_addr),
        .Q(\FSM_onehot_state_reg_n_0_[9] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE \ctl0_out_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [0]),
        .Q(ctl0_out[0]),
        .R(1'b0));
  FDRE \ctl0_out_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [10]),
        .Q(ctl0_out[10]),
        .R(1'b0));
  FDRE \ctl0_out_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [11]),
        .Q(ctl0_out[11]),
        .R(1'b0));
  FDRE \ctl0_out_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [12]),
        .Q(ctl0_out[12]),
        .R(1'b0));
  FDRE \ctl0_out_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [13]),
        .Q(ctl0_out[13]),
        .R(1'b0));
  FDRE \ctl0_out_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [14]),
        .Q(ctl0_out[14]),
        .R(1'b0));
  FDRE \ctl0_out_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [15]),
        .Q(ctl0_out[15]),
        .R(1'b0));
  FDRE \ctl0_out_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [16]),
        .Q(ctl0_out[16]),
        .R(1'b0));
  FDRE \ctl0_out_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [17]),
        .Q(ctl0_out[17]),
        .R(1'b0));
  FDRE \ctl0_out_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [18]),
        .Q(ctl0_out[18]),
        .R(1'b0));
  FDRE \ctl0_out_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [19]),
        .Q(ctl0_out[19]),
        .R(1'b0));
  FDRE \ctl0_out_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [1]),
        .Q(ctl0_out[1]),
        .R(1'b0));
  FDRE \ctl0_out_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [20]),
        .Q(ctl0_out[20]),
        .R(1'b0));
  FDRE \ctl0_out_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [21]),
        .Q(ctl0_out[21]),
        .R(1'b0));
  FDRE \ctl0_out_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [22]),
        .Q(ctl0_out[22]),
        .R(1'b0));
  FDRE \ctl0_out_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [23]),
        .Q(ctl0_out[23]),
        .R(1'b0));
  FDRE \ctl0_out_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [24]),
        .Q(ctl0_out[24]),
        .R(1'b0));
  FDRE \ctl0_out_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [25]),
        .Q(ctl0_out[25]),
        .R(1'b0));
  FDRE \ctl0_out_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [26]),
        .Q(ctl0_out[26]),
        .R(1'b0));
  FDRE \ctl0_out_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [27]),
        .Q(ctl0_out[27]),
        .R(1'b0));
  FDRE \ctl0_out_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [28]),
        .Q(ctl0_out[28]),
        .R(1'b0));
  FDRE \ctl0_out_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [29]),
        .Q(ctl0_out[29]),
        .R(1'b0));
  FDRE \ctl0_out_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [2]),
        .Q(ctl0_out[2]),
        .R(1'b0));
  FDRE \ctl0_out_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [30]),
        .Q(ctl0_out[30]),
        .R(1'b0));
  FDRE \ctl0_out_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [31]),
        .Q(ctl0_out[31]),
        .R(1'b0));
  FDRE \ctl0_out_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [3]),
        .Q(ctl0_out[3]),
        .R(1'b0));
  FDRE \ctl0_out_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [4]),
        .Q(ctl0_out[4]),
        .R(1'b0));
  FDRE \ctl0_out_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [5]),
        .Q(ctl0_out[5]),
        .R(1'b0));
  FDRE \ctl0_out_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [6]),
        .Q(ctl0_out[6]),
        .R(1'b0));
  FDRE \ctl0_out_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [7]),
        .Q(ctl0_out[7]),
        .R(1'b0));
  FDRE \ctl0_out_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [8]),
        .Q(ctl0_out[8]),
        .R(1'b0));
  FDRE \ctl0_out_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [9]),
        .Q(ctl0_out[9]),
        .R(1'b0));
  FDRE \ctl1_out_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [0]),
        .Q(ctl1_out[0]),
        .R(1'b0));
  FDRE \ctl1_out_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [10]),
        .Q(ctl1_out[10]),
        .R(1'b0));
  FDRE \ctl1_out_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [11]),
        .Q(ctl1_out[11]),
        .R(1'b0));
  FDRE \ctl1_out_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [12]),
        .Q(ctl1_out[12]),
        .R(1'b0));
  FDRE \ctl1_out_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [13]),
        .Q(ctl1_out[13]),
        .R(1'b0));
  FDRE \ctl1_out_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [14]),
        .Q(ctl1_out[14]),
        .R(1'b0));
  FDRE \ctl1_out_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [15]),
        .Q(ctl1_out[15]),
        .R(1'b0));
  FDRE \ctl1_out_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [16]),
        .Q(ctl1_out[16]),
        .R(1'b0));
  FDRE \ctl1_out_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [17]),
        .Q(ctl1_out[17]),
        .R(1'b0));
  FDRE \ctl1_out_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [18]),
        .Q(ctl1_out[18]),
        .R(1'b0));
  FDRE \ctl1_out_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [19]),
        .Q(ctl1_out[19]),
        .R(1'b0));
  FDRE \ctl1_out_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [1]),
        .Q(ctl1_out[1]),
        .R(1'b0));
  FDRE \ctl1_out_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [20]),
        .Q(ctl1_out[20]),
        .R(1'b0));
  FDRE \ctl1_out_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [21]),
        .Q(ctl1_out[21]),
        .R(1'b0));
  FDRE \ctl1_out_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [22]),
        .Q(ctl1_out[22]),
        .R(1'b0));
  FDRE \ctl1_out_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [23]),
        .Q(ctl1_out[23]),
        .R(1'b0));
  FDRE \ctl1_out_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [24]),
        .Q(ctl1_out[24]),
        .R(1'b0));
  FDRE \ctl1_out_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [25]),
        .Q(ctl1_out[25]),
        .R(1'b0));
  FDRE \ctl1_out_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [26]),
        .Q(ctl1_out[26]),
        .R(1'b0));
  FDRE \ctl1_out_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [27]),
        .Q(ctl1_out[27]),
        .R(1'b0));
  FDRE \ctl1_out_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [28]),
        .Q(ctl1_out[28]),
        .R(1'b0));
  FDRE \ctl1_out_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [29]),
        .Q(ctl1_out[29]),
        .R(1'b0));
  FDRE \ctl1_out_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [2]),
        .Q(ctl1_out[2]),
        .R(1'b0));
  FDRE \ctl1_out_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [30]),
        .Q(ctl1_out[30]),
        .R(1'b0));
  FDRE \ctl1_out_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [31]),
        .Q(ctl1_out[31]),
        .R(1'b0));
  FDRE \ctl1_out_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [3]),
        .Q(ctl1_out[3]),
        .R(1'b0));
  FDRE \ctl1_out_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [4]),
        .Q(ctl1_out[4]),
        .R(1'b0));
  FDRE \ctl1_out_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [5]),
        .Q(ctl1_out[5]),
        .R(1'b0));
  FDRE \ctl1_out_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [6]),
        .Q(ctl1_out[6]),
        .R(1'b0));
  FDRE \ctl1_out_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [7]),
        .Q(ctl1_out[7]),
        .R(1'b0));
  FDRE \ctl1_out_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [8]),
        .Q(ctl1_out[8]),
        .R(1'b0));
  FDRE \ctl1_out_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [9]),
        .Q(ctl1_out[9]),
        .R(1'b0));
  FDRE \ctl2_out_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [0]),
        .Q(ctl2_out[0]),
        .R(1'b0));
  FDRE \ctl2_out_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [10]),
        .Q(ctl2_out[10]),
        .R(1'b0));
  FDRE \ctl2_out_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [11]),
        .Q(ctl2_out[11]),
        .R(1'b0));
  FDRE \ctl2_out_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [12]),
        .Q(ctl2_out[12]),
        .R(1'b0));
  FDRE \ctl2_out_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [13]),
        .Q(ctl2_out[13]),
        .R(1'b0));
  FDRE \ctl2_out_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [14]),
        .Q(ctl2_out[14]),
        .R(1'b0));
  FDRE \ctl2_out_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [15]),
        .Q(ctl2_out[15]),
        .R(1'b0));
  FDRE \ctl2_out_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [16]),
        .Q(ctl2_out[16]),
        .R(1'b0));
  FDRE \ctl2_out_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [17]),
        .Q(ctl2_out[17]),
        .R(1'b0));
  FDRE \ctl2_out_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [18]),
        .Q(ctl2_out[18]),
        .R(1'b0));
  FDRE \ctl2_out_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [19]),
        .Q(ctl2_out[19]),
        .R(1'b0));
  FDRE \ctl2_out_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [1]),
        .Q(ctl2_out[1]),
        .R(1'b0));
  FDRE \ctl2_out_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [20]),
        .Q(ctl2_out[20]),
        .R(1'b0));
  FDRE \ctl2_out_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [21]),
        .Q(ctl2_out[21]),
        .R(1'b0));
  FDRE \ctl2_out_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [22]),
        .Q(ctl2_out[22]),
        .R(1'b0));
  FDRE \ctl2_out_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [23]),
        .Q(ctl2_out[23]),
        .R(1'b0));
  FDRE \ctl2_out_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [24]),
        .Q(ctl2_out[24]),
        .R(1'b0));
  FDRE \ctl2_out_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [25]),
        .Q(ctl2_out[25]),
        .R(1'b0));
  FDRE \ctl2_out_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [26]),
        .Q(ctl2_out[26]),
        .R(1'b0));
  FDRE \ctl2_out_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [27]),
        .Q(ctl2_out[27]),
        .R(1'b0));
  FDRE \ctl2_out_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [28]),
        .Q(ctl2_out[28]),
        .R(1'b0));
  FDRE \ctl2_out_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [29]),
        .Q(ctl2_out[29]),
        .R(1'b0));
  FDRE \ctl2_out_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [2]),
        .Q(ctl2_out[2]),
        .R(1'b0));
  FDRE \ctl2_out_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [30]),
        .Q(ctl2_out[30]),
        .R(1'b0));
  FDRE \ctl2_out_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [31]),
        .Q(ctl2_out[31]),
        .R(1'b0));
  FDRE \ctl2_out_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [3]),
        .Q(ctl2_out[3]),
        .R(1'b0));
  FDRE \ctl2_out_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [4]),
        .Q(ctl2_out[4]),
        .R(1'b0));
  FDRE \ctl2_out_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [5]),
        .Q(ctl2_out[5]),
        .R(1'b0));
  FDRE \ctl2_out_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [6]),
        .Q(ctl2_out[6]),
        .R(1'b0));
  FDRE \ctl2_out_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [7]),
        .Q(ctl2_out[7]),
        .R(1'b0));
  FDRE \ctl2_out_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [8]),
        .Q(ctl2_out[8]),
        .R(1'b0));
  FDRE \ctl2_out_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [9]),
        .Q(ctl2_out[9]),
        .R(1'b0));
  FDRE \ctl3_out_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [0]),
        .Q(ctl3_out[0]),
        .R(1'b0));
  FDRE \ctl3_out_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [10]),
        .Q(ctl3_out[10]),
        .R(1'b0));
  FDRE \ctl3_out_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [11]),
        .Q(ctl3_out[11]),
        .R(1'b0));
  FDRE \ctl3_out_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [12]),
        .Q(ctl3_out[12]),
        .R(1'b0));
  FDRE \ctl3_out_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [13]),
        .Q(ctl3_out[13]),
        .R(1'b0));
  FDRE \ctl3_out_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [14]),
        .Q(ctl3_out[14]),
        .R(1'b0));
  FDRE \ctl3_out_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [15]),
        .Q(ctl3_out[15]),
        .R(1'b0));
  FDRE \ctl3_out_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [16]),
        .Q(ctl3_out[16]),
        .R(1'b0));
  FDRE \ctl3_out_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [17]),
        .Q(ctl3_out[17]),
        .R(1'b0));
  FDRE \ctl3_out_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [18]),
        .Q(ctl3_out[18]),
        .R(1'b0));
  FDRE \ctl3_out_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [19]),
        .Q(ctl3_out[19]),
        .R(1'b0));
  FDRE \ctl3_out_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [1]),
        .Q(ctl3_out[1]),
        .R(1'b0));
  FDRE \ctl3_out_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [20]),
        .Q(ctl3_out[20]),
        .R(1'b0));
  FDRE \ctl3_out_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [21]),
        .Q(ctl3_out[21]),
        .R(1'b0));
  FDRE \ctl3_out_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [22]),
        .Q(ctl3_out[22]),
        .R(1'b0));
  FDRE \ctl3_out_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [23]),
        .Q(ctl3_out[23]),
        .R(1'b0));
  FDRE \ctl3_out_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [24]),
        .Q(ctl3_out[24]),
        .R(1'b0));
  FDRE \ctl3_out_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [25]),
        .Q(ctl3_out[25]),
        .R(1'b0));
  FDRE \ctl3_out_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [26]),
        .Q(ctl3_out[26]),
        .R(1'b0));
  FDRE \ctl3_out_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [27]),
        .Q(ctl3_out[27]),
        .R(1'b0));
  FDRE \ctl3_out_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [28]),
        .Q(ctl3_out[28]),
        .R(1'b0));
  FDRE \ctl3_out_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [29]),
        .Q(ctl3_out[29]),
        .R(1'b0));
  FDRE \ctl3_out_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [2]),
        .Q(ctl3_out[2]),
        .R(1'b0));
  FDRE \ctl3_out_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [30]),
        .Q(ctl3_out[30]),
        .R(1'b0));
  FDRE \ctl3_out_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [31]),
        .Q(ctl3_out[31]),
        .R(1'b0));
  FDRE \ctl3_out_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [3]),
        .Q(ctl3_out[3]),
        .R(1'b0));
  FDRE \ctl3_out_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [4]),
        .Q(ctl3_out[4]),
        .R(1'b0));
  FDRE \ctl3_out_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [5]),
        .Q(ctl3_out[5]),
        .R(1'b0));
  FDRE \ctl3_out_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [6]),
        .Q(ctl3_out[6]),
        .R(1'b0));
  FDRE \ctl3_out_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [7]),
        .Q(ctl3_out[7]),
        .R(1'b0));
  FDRE \ctl3_out_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [8]),
        .Q(ctl3_out[8]),
        .R(1'b0));
  FDRE \ctl3_out_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [9]),
        .Q(ctl3_out[9]),
        .R(1'b0));
  FDRE \ctl4_out_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [0]),
        .Q(ctl4_out[0]),
        .R(1'b0));
  FDRE \ctl4_out_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [10]),
        .Q(ctl4_out[10]),
        .R(1'b0));
  FDRE \ctl4_out_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [11]),
        .Q(ctl4_out[11]),
        .R(1'b0));
  FDRE \ctl4_out_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [12]),
        .Q(ctl4_out[12]),
        .R(1'b0));
  FDRE \ctl4_out_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [13]),
        .Q(ctl4_out[13]),
        .R(1'b0));
  FDRE \ctl4_out_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [14]),
        .Q(ctl4_out[14]),
        .R(1'b0));
  FDRE \ctl4_out_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [15]),
        .Q(ctl4_out[15]),
        .R(1'b0));
  FDRE \ctl4_out_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [16]),
        .Q(ctl4_out[16]),
        .R(1'b0));
  FDRE \ctl4_out_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [17]),
        .Q(ctl4_out[17]),
        .R(1'b0));
  FDRE \ctl4_out_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [18]),
        .Q(ctl4_out[18]),
        .R(1'b0));
  FDRE \ctl4_out_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [19]),
        .Q(ctl4_out[19]),
        .R(1'b0));
  FDRE \ctl4_out_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [1]),
        .Q(ctl4_out[1]),
        .R(1'b0));
  FDRE \ctl4_out_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [20]),
        .Q(ctl4_out[20]),
        .R(1'b0));
  FDRE \ctl4_out_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [21]),
        .Q(ctl4_out[21]),
        .R(1'b0));
  FDRE \ctl4_out_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [22]),
        .Q(ctl4_out[22]),
        .R(1'b0));
  FDRE \ctl4_out_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [23]),
        .Q(ctl4_out[23]),
        .R(1'b0));
  FDRE \ctl4_out_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [24]),
        .Q(ctl4_out[24]),
        .R(1'b0));
  FDRE \ctl4_out_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [25]),
        .Q(ctl4_out[25]),
        .R(1'b0));
  FDRE \ctl4_out_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [26]),
        .Q(ctl4_out[26]),
        .R(1'b0));
  FDRE \ctl4_out_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [27]),
        .Q(ctl4_out[27]),
        .R(1'b0));
  FDRE \ctl4_out_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [28]),
        .Q(ctl4_out[28]),
        .R(1'b0));
  FDRE \ctl4_out_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [29]),
        .Q(ctl4_out[29]),
        .R(1'b0));
  FDRE \ctl4_out_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [2]),
        .Q(ctl4_out[2]),
        .R(1'b0));
  FDRE \ctl4_out_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [30]),
        .Q(ctl4_out[30]),
        .R(1'b0));
  FDRE \ctl4_out_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [31]),
        .Q(ctl4_out[31]),
        .R(1'b0));
  FDRE \ctl4_out_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [3]),
        .Q(ctl4_out[3]),
        .R(1'b0));
  FDRE \ctl4_out_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [4]),
        .Q(ctl4_out[4]),
        .R(1'b0));
  FDRE \ctl4_out_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [5]),
        .Q(ctl4_out[5]),
        .R(1'b0));
  FDRE \ctl4_out_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [6]),
        .Q(ctl4_out[6]),
        .R(1'b0));
  FDRE \ctl4_out_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [7]),
        .Q(ctl4_out[7]),
        .R(1'b0));
  FDRE \ctl4_out_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [8]),
        .Q(ctl4_out[8]),
        .R(1'b0));
  FDRE \ctl4_out_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [9]),
        .Q(ctl4_out[9]),
        .R(1'b0));
  FDRE \ctl5_out_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [0]),
        .Q(ctl5_out[0]),
        .R(1'b0));
  FDRE \ctl5_out_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [10]),
        .Q(ctl5_out[10]),
        .R(1'b0));
  FDRE \ctl5_out_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [11]),
        .Q(ctl5_out[11]),
        .R(1'b0));
  FDRE \ctl5_out_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [12]),
        .Q(ctl5_out[12]),
        .R(1'b0));
  FDRE \ctl5_out_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [13]),
        .Q(ctl5_out[13]),
        .R(1'b0));
  FDRE \ctl5_out_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [14]),
        .Q(ctl5_out[14]),
        .R(1'b0));
  FDRE \ctl5_out_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [15]),
        .Q(ctl5_out[15]),
        .R(1'b0));
  FDRE \ctl5_out_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [16]),
        .Q(ctl5_out[16]),
        .R(1'b0));
  FDRE \ctl5_out_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [17]),
        .Q(ctl5_out[17]),
        .R(1'b0));
  FDRE \ctl5_out_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [18]),
        .Q(ctl5_out[18]),
        .R(1'b0));
  FDRE \ctl5_out_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [19]),
        .Q(ctl5_out[19]),
        .R(1'b0));
  FDRE \ctl5_out_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [1]),
        .Q(ctl5_out[1]),
        .R(1'b0));
  FDRE \ctl5_out_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [20]),
        .Q(ctl5_out[20]),
        .R(1'b0));
  FDRE \ctl5_out_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [21]),
        .Q(ctl5_out[21]),
        .R(1'b0));
  FDRE \ctl5_out_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [22]),
        .Q(ctl5_out[22]),
        .R(1'b0));
  FDRE \ctl5_out_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [23]),
        .Q(ctl5_out[23]),
        .R(1'b0));
  FDRE \ctl5_out_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [24]),
        .Q(ctl5_out[24]),
        .R(1'b0));
  FDRE \ctl5_out_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [25]),
        .Q(ctl5_out[25]),
        .R(1'b0));
  FDRE \ctl5_out_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [26]),
        .Q(ctl5_out[26]),
        .R(1'b0));
  FDRE \ctl5_out_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [27]),
        .Q(ctl5_out[27]),
        .R(1'b0));
  FDRE \ctl5_out_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [28]),
        .Q(ctl5_out[28]),
        .R(1'b0));
  FDRE \ctl5_out_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [29]),
        .Q(ctl5_out[29]),
        .R(1'b0));
  FDRE \ctl5_out_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [2]),
        .Q(ctl5_out[2]),
        .R(1'b0));
  FDRE \ctl5_out_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [30]),
        .Q(ctl5_out[30]),
        .R(1'b0));
  FDRE \ctl5_out_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [31]),
        .Q(ctl5_out[31]),
        .R(1'b0));
  FDRE \ctl5_out_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [3]),
        .Q(ctl5_out[3]),
        .R(1'b0));
  FDRE \ctl5_out_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [4]),
        .Q(ctl5_out[4]),
        .R(1'b0));
  FDRE \ctl5_out_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [5]),
        .Q(ctl5_out[5]),
        .R(1'b0));
  FDRE \ctl5_out_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [6]),
        .Q(ctl5_out[6]),
        .R(1'b0));
  FDRE \ctl5_out_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [7]),
        .Q(ctl5_out[7]),
        .R(1'b0));
  FDRE \ctl5_out_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [8]),
        .Q(ctl5_out[8]),
        .R(1'b0));
  FDRE \ctl5_out_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [9]),
        .Q(ctl5_out[9]),
        .R(1'b0));
  FDRE \ctl6_out_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [0]),
        .Q(ctl6_out[0]),
        .R(1'b0));
  FDRE \ctl6_out_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [10]),
        .Q(ctl6_out[10]),
        .R(1'b0));
  FDRE \ctl6_out_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [11]),
        .Q(ctl6_out[11]),
        .R(1'b0));
  FDRE \ctl6_out_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [12]),
        .Q(ctl6_out[12]),
        .R(1'b0));
  FDRE \ctl6_out_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [13]),
        .Q(ctl6_out[13]),
        .R(1'b0));
  FDRE \ctl6_out_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [14]),
        .Q(ctl6_out[14]),
        .R(1'b0));
  FDRE \ctl6_out_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [15]),
        .Q(ctl6_out[15]),
        .R(1'b0));
  FDRE \ctl6_out_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [16]),
        .Q(ctl6_out[16]),
        .R(1'b0));
  FDRE \ctl6_out_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [17]),
        .Q(ctl6_out[17]),
        .R(1'b0));
  FDRE \ctl6_out_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [18]),
        .Q(ctl6_out[18]),
        .R(1'b0));
  FDRE \ctl6_out_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [19]),
        .Q(ctl6_out[19]),
        .R(1'b0));
  FDRE \ctl6_out_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [1]),
        .Q(ctl6_out[1]),
        .R(1'b0));
  FDRE \ctl6_out_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [20]),
        .Q(ctl6_out[20]),
        .R(1'b0));
  FDRE \ctl6_out_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [21]),
        .Q(ctl6_out[21]),
        .R(1'b0));
  FDRE \ctl6_out_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [22]),
        .Q(ctl6_out[22]),
        .R(1'b0));
  FDRE \ctl6_out_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [23]),
        .Q(ctl6_out[23]),
        .R(1'b0));
  FDRE \ctl6_out_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [24]),
        .Q(ctl6_out[24]),
        .R(1'b0));
  FDRE \ctl6_out_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [25]),
        .Q(ctl6_out[25]),
        .R(1'b0));
  FDRE \ctl6_out_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [26]),
        .Q(ctl6_out[26]),
        .R(1'b0));
  FDRE \ctl6_out_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [27]),
        .Q(ctl6_out[27]),
        .R(1'b0));
  FDRE \ctl6_out_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [28]),
        .Q(ctl6_out[28]),
        .R(1'b0));
  FDRE \ctl6_out_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [29]),
        .Q(ctl6_out[29]),
        .R(1'b0));
  FDRE \ctl6_out_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [2]),
        .Q(ctl6_out[2]),
        .R(1'b0));
  FDRE \ctl6_out_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [30]),
        .Q(ctl6_out[30]),
        .R(1'b0));
  FDRE \ctl6_out_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [31]),
        .Q(ctl6_out[31]),
        .R(1'b0));
  FDRE \ctl6_out_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [3]),
        .Q(ctl6_out[3]),
        .R(1'b0));
  FDRE \ctl6_out_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [4]),
        .Q(ctl6_out[4]),
        .R(1'b0));
  FDRE \ctl6_out_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [5]),
        .Q(ctl6_out[5]),
        .R(1'b0));
  FDRE \ctl6_out_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [6]),
        .Q(ctl6_out[6]),
        .R(1'b0));
  FDRE \ctl6_out_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [7]),
        .Q(ctl6_out[7]),
        .R(1'b0));
  FDRE \ctl6_out_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [8]),
        .Q(ctl6_out[8]),
        .R(1'b0));
  FDRE \ctl6_out_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [9]),
        .Q(ctl6_out[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1 
       (.I0(reg0_init_val[0]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[0] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1 
       (.I0(reg0_init_val[10]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[10] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1 
       (.I0(reg0_init_val[11]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[11] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1 
       (.I0(reg0_init_val[12]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[12] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1 
       (.I0(reg0_init_val[13]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[13] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1 
       (.I0(reg0_init_val[14]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[14] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_1 
       (.I0(data00),
        .I1(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(p_0_in__0[15]));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2 
       (.I0(reg0_init_val[15]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[15] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1 
       (.I0(reg0_init_val[16]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[16] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1 
       (.I0(reg0_init_val[17]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[17] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1 
       (.I0(reg0_init_val[18]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[18] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1 
       (.I0(reg0_init_val[19]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[19] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1 
       (.I0(reg0_init_val[1]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in16_in),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1 
       (.I0(reg0_init_val[20]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[20] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1 
       (.I0(reg0_init_val[21]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[21] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1 
       (.I0(reg0_init_val[22]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[22] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_1 
       (.I0(\wr_strb_reg_n_0_[2] ),
        .I1(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(p_0_in__0[23]));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2 
       (.I0(reg0_init_val[23]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[23] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1 
       (.I0(reg0_init_val[24]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[24] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1 
       (.I0(reg0_init_val[25]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[25] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1 
       (.I0(reg0_init_val[26]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[26] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1 
       (.I0(reg0_init_val[27]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[27] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1 
       (.I0(reg0_init_val[28]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[28] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1 
       (.I0(reg0_init_val[29]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[29] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1 
       (.I0(reg0_init_val[2]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in13_in),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1 
       (.I0(reg0_init_val[30]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[30] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_1 
       (.I0(\wr_strb_reg_n_0_[3] ),
        .I1(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(p_0_in__0[31]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2 
       (.I0(reg0_init_val[31]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[31] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00010000)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3 
       (.I0(w_addr__0[5]),
        .I1(w_addr__0[2]),
        .I2(w_addr__0[3]),
        .I3(w_addr__0[4]),
        .I4(w_we_reg_n_0),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1 
       (.I0(reg0_init_val[3]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in10_in),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1 
       (.I0(reg0_init_val[4]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in7_in),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1 
       (.I0(reg0_init_val[5]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in4_in),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1 
       (.I0(reg0_init_val[6]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_1 
       (.I0(p_0_in),
        .I1(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2 
       (.I0(reg0_init_val[7]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[7] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1 
       (.I0(reg0_init_val[8]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[8] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1 
       (.I0(reg0_init_val[9]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[9] ),
        .O(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1_n_0 ));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][0] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[7]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][0]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [0]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][10] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[15]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][10]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [10]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][11] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[15]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][11]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [11]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][12] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[15]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][12]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [12]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][13] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[15]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][13]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [13]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][14] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[15]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][14]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [14]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][15] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[15]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][15]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [15]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][16] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[23]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][16]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [16]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][17] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[23]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][17]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [17]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][18] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[23]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][18]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [18]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][19] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[23]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][19]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [19]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][1] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[7]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][1]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [1]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][20] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[23]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][20]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [20]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][21] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[23]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][21]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [21]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][22] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[23]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][22]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [22]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][23] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[23]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][23]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [23]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][24] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[31]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][24]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [24]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][25] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[31]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][25]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [25]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][26] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[31]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][26]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [26]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][27] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[31]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][27]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [27]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][28] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[31]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][28]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [28]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][29] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[31]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][29]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [29]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][2] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[7]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][2]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [2]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][30] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[31]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][30]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [30]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][31] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[31]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][31]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [31]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][3] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[7]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][3]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [3]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][4] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[7]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][4]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [4]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][5] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[7]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][5]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [5]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][6] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[7]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][6]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [6]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][7] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[7]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][7]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [7]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][8] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[15]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][8]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [8]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0][9] 
       (.C(s_axi_csr_aclk),
        .CE(p_0_in__0[15]),
        .D(\gen_cntl.gen_ctl_regs[0].cntl_reg[0][9]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1 
       (.I0(reg1_init_val[0]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[0] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1 
       (.I0(reg1_init_val[10]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[10] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1 
       (.I0(reg1_init_val[11]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[11] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1 
       (.I0(reg1_init_val[12]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[12] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1 
       (.I0(reg1_init_val[13]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[13] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1 
       (.I0(reg1_init_val[14]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[14] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1 
       (.I0(data00),
        .I1(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2 
       (.I0(reg1_init_val[15]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[15] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1 
       (.I0(reg1_init_val[16]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[16] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1 
       (.I0(reg1_init_val[17]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[17] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1 
       (.I0(reg1_init_val[18]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[18] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1 
       (.I0(reg1_init_val[19]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[19] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1 
       (.I0(reg1_init_val[1]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in16_in),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1 
       (.I0(reg1_init_val[20]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[20] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1 
       (.I0(reg1_init_val[21]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[21] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1 
       (.I0(reg1_init_val[22]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[22] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1 
       (.I0(\wr_strb_reg_n_0_[2] ),
        .I1(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2 
       (.I0(reg1_init_val[23]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[23] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1 
       (.I0(reg1_init_val[24]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[24] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1 
       (.I0(reg1_init_val[25]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[25] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1 
       (.I0(reg1_init_val[26]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[26] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1 
       (.I0(reg1_init_val[27]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[27] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1 
       (.I0(reg1_init_val[28]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[28] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1 
       (.I0(reg1_init_val[29]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[29] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1 
       (.I0(reg1_init_val[2]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in13_in),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1 
       (.I0(reg1_init_val[30]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[30] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1 
       (.I0(\wr_strb_reg_n_0_[3] ),
        .I1(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2 
       (.I0(reg1_init_val[31]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[31] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h00100000)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_3 
       (.I0(w_addr__0[5]),
        .I1(w_addr__0[3]),
        .I2(w_addr__0[2]),
        .I3(w_addr__0[4]),
        .I4(w_we_reg_n_0),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1 
       (.I0(reg1_init_val[3]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in10_in),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1 
       (.I0(reg1_init_val[4]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in7_in),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1 
       (.I0(reg1_init_val[5]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in4_in),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1 
       (.I0(reg1_init_val[6]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1 
       (.I0(p_0_in),
        .I1(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2 
       (.I0(reg1_init_val[7]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[7] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1 
       (.I0(reg1_init_val[8]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[8] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1 
       (.I0(reg1_init_val[9]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[9] ),
        .O(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1_n_0 ));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][0] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][0]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [0]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][10] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][10]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [10]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][11] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][11]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [11]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][12] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][12]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [12]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][13] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][13]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [13]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][14] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][14]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [14]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][15] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [15]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][16] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][16]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [16]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][17] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][17]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [17]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][18] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][18]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [18]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][19] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][19]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [19]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][1] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][1]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [1]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][20] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][20]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [20]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][21] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][21]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [21]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][22] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][22]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [22]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][23] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][23]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [23]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][24] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][24]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [24]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][25] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][25]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [25]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][26] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][26]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [26]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][27] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][27]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [27]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][28] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][28]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [28]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][29] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][29]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [29]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][2] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][2]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [2]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][30] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][30]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [30]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][31] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][31]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [31]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][3] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][3]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [3]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][4] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][4]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [4]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][5] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][5]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [5]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][6] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][6]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [6]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][7] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][7]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [7]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][8] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][8]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [8]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1][9] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[1].cntl_reg[1][9]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1 
       (.I0(reg2_init_val[0]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[0] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1 
       (.I0(reg2_init_val[10]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[10] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1 
       (.I0(reg2_init_val[11]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[11] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1 
       (.I0(reg2_init_val[12]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[12] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1 
       (.I0(reg2_init_val[13]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[13] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1 
       (.I0(reg2_init_val[14]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[14] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1 
       (.I0(data00),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2 
       (.I0(reg2_init_val[15]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[15] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1 
       (.I0(reg2_init_val[16]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[16] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1 
       (.I0(reg2_init_val[17]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[17] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1 
       (.I0(reg2_init_val[18]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[18] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1 
       (.I0(reg2_init_val[19]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[19] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1 
       (.I0(reg2_init_val[1]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in16_in),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1 
       (.I0(reg2_init_val[20]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[20] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1 
       (.I0(reg2_init_val[21]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[21] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1 
       (.I0(reg2_init_val[22]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[22] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1 
       (.I0(\wr_strb_reg_n_0_[2] ),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2 
       (.I0(reg2_init_val[23]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[23] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1 
       (.I0(reg2_init_val[24]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[24] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1 
       (.I0(reg2_init_val[25]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[25] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1 
       (.I0(reg2_init_val[26]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[26] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1 
       (.I0(reg2_init_val[27]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[27] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1 
       (.I0(reg2_init_val[28]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[28] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1 
       (.I0(reg2_init_val[29]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[29] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1 
       (.I0(reg2_init_val[2]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in13_in),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1 
       (.I0(reg2_init_val[30]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[30] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1 
       (.I0(\wr_strb_reg_n_0_[3] ),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2 
       (.I0(reg2_init_val[31]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[31] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h00000008)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_3 
       (.I0(w_addr__0[3]),
        .I1(w_we_reg_n_0),
        .I2(w_addr__0[4]),
        .I3(w_addr__0[2]),
        .I4(w_addr__0[5]),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1 
       (.I0(reg2_init_val[3]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in10_in),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1 
       (.I0(reg2_init_val[4]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in7_in),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1 
       (.I0(reg2_init_val[5]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in4_in),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1 
       (.I0(reg2_init_val[6]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1 
       (.I0(p_0_in),
        .I1(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2 
       (.I0(reg2_init_val[7]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[7] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1 
       (.I0(reg2_init_val[8]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[8] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1 
       (.I0(reg2_init_val[9]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[9] ),
        .O(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1_n_0 ));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][0] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][0]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [0]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][10] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][10]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [10]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][11] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][11]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [11]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][12] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][12]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [12]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][13] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][13]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [13]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][14] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][14]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [14]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][15] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [15]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][16] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][16]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [16]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][17] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][17]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [17]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][18] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][18]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [18]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][19] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][19]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [19]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][1] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][1]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [1]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][20] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][20]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [20]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][21] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][21]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [21]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][22] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][22]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [22]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][23] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][23]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [23]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][24] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][24]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [24]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][25] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][25]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [25]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][26] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][26]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [26]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][27] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][27]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [27]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][28] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][28]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [28]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][29] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][29]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [29]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][2] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][2]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [2]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][30] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][30]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [30]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][31] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][31]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [31]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][3] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][3]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [3]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][4] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][4]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [4]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][5] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][5]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [5]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][6] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][6]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [6]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][7] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][7]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [7]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][8] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][8]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [8]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2][9] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[2].cntl_reg[2][9]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][0]_i_1 
       (.I0(reg3_init_val[0]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[0] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][10]_i_1 
       (.I0(reg3_init_val[10]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[10] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][11]_i_1 
       (.I0(reg3_init_val[11]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[11] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][12]_i_1 
       (.I0(reg3_init_val[12]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[12] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][13]_i_1 
       (.I0(reg3_init_val[13]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[13] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][14]_i_1 
       (.I0(reg3_init_val[14]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[14] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][14]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1 
       (.I0(data00),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_2 
       (.I0(reg3_init_val[15]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[15] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][16]_i_1 
       (.I0(reg3_init_val[16]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[16] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][17]_i_1 
       (.I0(reg3_init_val[17]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[17] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][18]_i_1 
       (.I0(reg3_init_val[18]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[18] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][19]_i_1 
       (.I0(reg3_init_val[19]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[19] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][1]_i_1 
       (.I0(reg3_init_val[1]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in16_in),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][20]_i_1 
       (.I0(reg3_init_val[20]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[20] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][21]_i_1 
       (.I0(reg3_init_val[21]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[21] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][22]_i_1 
       (.I0(reg3_init_val[22]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[22] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][22]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1 
       (.I0(\wr_strb_reg_n_0_[2] ),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_2 
       (.I0(reg3_init_val[23]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[23] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][24]_i_1 
       (.I0(reg3_init_val[24]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[24] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][25]_i_1 
       (.I0(reg3_init_val[25]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[25] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][26]_i_1 
       (.I0(reg3_init_val[26]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[26] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][27]_i_1 
       (.I0(reg3_init_val[27]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[27] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][28]_i_1 
       (.I0(reg3_init_val[28]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[28] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][29]_i_1 
       (.I0(reg3_init_val[29]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[29] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][2]_i_1 
       (.I0(reg3_init_val[2]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in13_in),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][30]_i_1 
       (.I0(reg3_init_val[30]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[30] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][30]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1 
       (.I0(\wr_strb_reg_n_0_[3] ),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_2 
       (.I0(reg3_init_val[31]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[31] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00400000)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_3 
       (.I0(w_addr__0[5]),
        .I1(w_addr__0[3]),
        .I2(w_addr__0[2]),
        .I3(w_addr__0[4]),
        .I4(w_we_reg_n_0),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][3]_i_1 
       (.I0(reg3_init_val[3]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in10_in),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][4]_i_1 
       (.I0(reg3_init_val[4]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in7_in),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][5]_i_1 
       (.I0(reg3_init_val[5]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in4_in),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][6]_i_1 
       (.I0(reg3_init_val[6]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][6]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1 
       (.I0(p_0_in),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_2 
       (.I0(reg3_init_val[7]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[7] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][8]_i_1 
       (.I0(reg3_init_val[8]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[8] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[3].cntl_reg[3][9]_i_1 
       (.I0(reg3_init_val[9]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[9] ),
        .O(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][9]_i_1_n_0 ));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][0] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][0]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [0]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][10] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][10]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [10]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][11] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][11]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [11]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][12] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][12]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [12]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][13] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][13]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [13]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][14] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][14]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [14]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][15] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [15]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][16] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][16]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [16]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][17] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][17]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [17]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][18] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][18]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [18]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][19] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][19]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [19]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][1] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][1]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [1]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][20] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][20]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [20]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][21] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][21]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [21]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][22] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][22]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [22]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][23] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][23]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [23]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][24] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][24]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [24]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][25] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][25]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [25]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][26] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][26]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [26]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][27] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][27]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [27]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][28] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][28]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [28]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][29] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][29]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [29]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][2] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][2]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [2]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][30] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][30]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [30]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][31] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][31]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [31]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][3] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][3]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [3]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][4] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][4]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [4]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][5] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][5]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [5]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][6] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][6]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [6]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][7] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][7]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [7]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][8] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][8]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [8]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3][9] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[3].cntl_reg[3][9]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][0]_i_1 
       (.I0(reg4_init_val[0]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[0] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][10]_i_1 
       (.I0(reg4_init_val[10]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[10] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][11]_i_1 
       (.I0(reg4_init_val[11]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[11] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][12]_i_1 
       (.I0(reg4_init_val[12]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[12] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][13]_i_1 
       (.I0(reg4_init_val[13]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[13] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][14]_i_1 
       (.I0(reg4_init_val[14]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[14] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][14]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1 
       (.I0(data00),
        .I1(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_2 
       (.I0(reg4_init_val[15]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[15] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][16]_i_1 
       (.I0(reg4_init_val[16]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[16] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][17]_i_1 
       (.I0(reg4_init_val[17]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[17] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][18]_i_1 
       (.I0(reg4_init_val[18]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[18] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][19]_i_1 
       (.I0(reg4_init_val[19]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[19] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][1]_i_1 
       (.I0(reg4_init_val[1]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in16_in),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][20]_i_1 
       (.I0(reg4_init_val[20]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[20] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][21]_i_1 
       (.I0(reg4_init_val[21]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[21] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][22]_i_1 
       (.I0(reg4_init_val[22]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[22] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][22]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1 
       (.I0(\wr_strb_reg_n_0_[2] ),
        .I1(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_2 
       (.I0(reg4_init_val[23]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[23] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][24]_i_1 
       (.I0(reg4_init_val[24]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[24] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][25]_i_1 
       (.I0(reg4_init_val[25]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[25] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][26]_i_1 
       (.I0(reg4_init_val[26]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[26] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][27]_i_1 
       (.I0(reg4_init_val[27]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[27] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][28]_i_1 
       (.I0(reg4_init_val[28]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[28] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][29]_i_1 
       (.I0(reg4_init_val[29]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[29] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][2]_i_1 
       (.I0(reg4_init_val[2]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in13_in),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][30]_i_1 
       (.I0(reg4_init_val[30]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[30] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][30]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1 
       (.I0(\wr_strb_reg_n_0_[3] ),
        .I1(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_2 
       (.I0(reg4_init_val[31]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[31] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h00040000)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_3 
       (.I0(w_addr__0[2]),
        .I1(w_addr__0[4]),
        .I2(w_addr__0[5]),
        .I3(w_addr__0[3]),
        .I4(w_we_reg_n_0),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][3]_i_1 
       (.I0(reg4_init_val[3]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in10_in),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][4]_i_1 
       (.I0(reg4_init_val[4]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in7_in),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][5]_i_1 
       (.I0(reg4_init_val[5]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in4_in),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][6]_i_1 
       (.I0(reg4_init_val[6]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][6]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1 
       (.I0(p_0_in),
        .I1(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_2 
       (.I0(reg4_init_val[7]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[7] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][8]_i_1 
       (.I0(reg4_init_val[8]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[8] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[4].cntl_reg[4][9]_i_1 
       (.I0(reg4_init_val[9]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[9] ),
        .O(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][9]_i_1_n_0 ));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][0] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][0]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [0]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][10] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][10]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [10]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][11] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][11]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [11]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][12] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][12]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [12]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][13] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][13]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [13]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][14] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][14]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [14]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][15] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [15]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][16] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][16]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [16]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][17] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][17]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [17]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][18] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][18]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [18]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][19] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][19]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [19]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][1] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][1]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [1]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][20] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][20]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [20]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][21] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][21]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [21]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][22] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][22]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [22]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][23] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][23]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [23]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][24] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][24]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [24]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][25] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][25]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [25]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][26] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][26]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [26]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][27] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][27]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [27]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][28] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][28]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [28]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][29] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][29]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [29]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][2] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][2]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [2]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][30] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][30]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [30]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][31] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][31]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [31]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][3] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][3]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [3]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][4] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][4]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [4]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][5] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][5]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [5]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][6] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][6]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [6]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][7] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][7]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [7]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][8] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][8]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [8]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4][9] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[4].cntl_reg[4][9]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][0]_i_1 
       (.I0(reg5_init_val[0]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[0] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][10]_i_1 
       (.I0(reg5_init_val[10]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[10] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][11]_i_1 
       (.I0(reg5_init_val[11]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[11] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][12]_i_1 
       (.I0(reg5_init_val[12]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[12] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][13]_i_1 
       (.I0(reg5_init_val[13]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[13] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][14]_i_1 
       (.I0(reg5_init_val[14]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[14] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][14]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1 
       (.I0(data00),
        .I1(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_2 
       (.I0(reg5_init_val[15]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[15] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][16]_i_1 
       (.I0(reg5_init_val[16]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[16] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][17]_i_1 
       (.I0(reg5_init_val[17]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[17] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][18]_i_1 
       (.I0(reg5_init_val[18]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[18] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][19]_i_1 
       (.I0(reg5_init_val[19]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[19] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][1]_i_1 
       (.I0(reg5_init_val[1]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in16_in),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][20]_i_1 
       (.I0(reg5_init_val[20]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[20] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][21]_i_1 
       (.I0(reg5_init_val[21]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[21] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][22]_i_1 
       (.I0(reg5_init_val[22]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[22] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][22]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1 
       (.I0(\wr_strb_reg_n_0_[2] ),
        .I1(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_2 
       (.I0(reg5_init_val[23]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[23] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][24]_i_1 
       (.I0(reg5_init_val[24]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[24] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][25]_i_1 
       (.I0(reg5_init_val[25]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[25] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][26]_i_1 
       (.I0(reg5_init_val[26]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[26] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][27]_i_1 
       (.I0(reg5_init_val[27]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[27] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][28]_i_1 
       (.I0(reg5_init_val[28]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[28] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][29]_i_1 
       (.I0(reg5_init_val[29]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[29] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][2]_i_1 
       (.I0(reg5_init_val[2]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in13_in),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][30]_i_1 
       (.I0(reg5_init_val[30]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[30] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][30]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1 
       (.I0(\wr_strb_reg_n_0_[3] ),
        .I1(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_2 
       (.I0(reg5_init_val[31]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[31] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h00400000)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_3 
       (.I0(w_addr__0[3]),
        .I1(w_addr__0[4]),
        .I2(w_addr__0[2]),
        .I3(w_addr__0[5]),
        .I4(w_we_reg_n_0),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][3]_i_1 
       (.I0(reg5_init_val[3]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in10_in),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][4]_i_1 
       (.I0(reg5_init_val[4]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in7_in),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][5]_i_1 
       (.I0(reg5_init_val[5]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in4_in),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][6]_i_1 
       (.I0(reg5_init_val[6]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][6]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1 
       (.I0(p_0_in),
        .I1(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_2 
       (.I0(reg5_init_val[7]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[7] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][8]_i_1 
       (.I0(reg5_init_val[8]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[8] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[5].cntl_reg[5][9]_i_1 
       (.I0(reg5_init_val[9]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[9] ),
        .O(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][9]_i_1_n_0 ));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][0] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][0]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [0]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][10] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][10]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [10]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][11] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][11]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [11]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][12] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][12]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [12]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][13] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][13]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [13]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][14] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][14]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [14]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][15] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [15]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][16] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][16]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [16]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][17] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][17]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [17]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][18] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][18]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [18]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][19] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][19]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [19]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][1] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][1]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [1]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][20] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][20]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [20]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][21] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][21]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [21]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][22] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][22]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [22]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][23] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][23]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [23]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][24] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][24]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [24]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][25] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][25]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [25]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][26] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][26]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [26]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][27] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][27]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [27]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][28] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][28]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [28]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][29] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][29]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [29]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][2] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][2]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [2]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][30] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][30]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [30]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][31] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][31]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [31]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][3] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][3]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [3]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][4] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][4]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [4]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][5] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][5]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [5]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][6] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][6]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [6]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][7] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][7]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [7]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][8] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][8]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [8]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5][9] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[5].cntl_reg[5][9]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][0]_i_1 
       (.I0(reg6_init_val[0]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[0] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][10]_i_1 
       (.I0(reg6_init_val[10]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[10] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][11]_i_1 
       (.I0(reg6_init_val[11]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[11] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][12]_i_1 
       (.I0(reg6_init_val[12]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[12] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][13]_i_1 
       (.I0(reg6_init_val[13]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[13] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][14]_i_1 
       (.I0(reg6_init_val[14]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[14] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][14]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1 
       (.I0(data00),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_2 
       (.I0(reg6_init_val[15]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[15] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][16]_i_1 
       (.I0(reg6_init_val[16]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[16] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][17]_i_1 
       (.I0(reg6_init_val[17]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[17] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][18]_i_1 
       (.I0(reg6_init_val[18]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[18] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][19]_i_1 
       (.I0(reg6_init_val[19]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[19] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][1]_i_1 
       (.I0(reg6_init_val[1]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in16_in),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][20]_i_1 
       (.I0(reg6_init_val[20]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[20] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][21]_i_1 
       (.I0(reg6_init_val[21]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[21] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][22]_i_1 
       (.I0(reg6_init_val[22]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[22] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][22]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1 
       (.I0(\wr_strb_reg_n_0_[2] ),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_2 
       (.I0(reg6_init_val[23]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[23] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][24]_i_1 
       (.I0(reg6_init_val[24]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[24] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][25]_i_1 
       (.I0(reg6_init_val[25]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[25] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][26]_i_1 
       (.I0(reg6_init_val[26]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[26] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][27]_i_1 
       (.I0(reg6_init_val[27]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[27] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][28]_i_1 
       (.I0(reg6_init_val[28]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[28] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][29]_i_1 
       (.I0(reg6_init_val[29]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[29] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][2]_i_1 
       (.I0(reg6_init_val[2]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in13_in),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][30]_i_1 
       (.I0(reg6_init_val[30]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[30] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][30]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1 
       (.I0(\wr_strb_reg_n_0_[3] ),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_2 
       (.I0(reg6_init_val[31]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[31] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00400000)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_3 
       (.I0(w_addr__0[2]),
        .I1(w_addr__0[3]),
        .I2(w_addr__0[4]),
        .I3(w_addr__0[5]),
        .I4(w_we_reg_n_0),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][3]_i_1 
       (.I0(reg6_init_val[3]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in10_in),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][4]_i_1 
       (.I0(reg6_init_val[4]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in7_in),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][5]_i_1 
       (.I0(reg6_init_val[5]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in4_in),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][6]_i_1 
       (.I0(reg6_init_val[6]),
        .I1(s_axi_csr_aresetn),
        .I2(p_1_in),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][6]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1 
       (.I0(p_0_in),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_3_n_0 ),
        .I2(s_axi_csr_aresetn),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_2 
       (.I0(reg6_init_val[7]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[7] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][8]_i_1 
       (.I0(reg6_init_val[8]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[8] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \gen_cntl.gen_ctl_regs[6].cntl_reg[6][9]_i_1 
       (.I0(reg6_init_val[9]),
        .I1(s_axi_csr_aresetn),
        .I2(\w_data_reg_n_0_[9] ),
        .O(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][9]_i_1_n_0 ));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][0] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][0]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [0]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][10] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][10]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [10]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][11] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][11]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [11]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][12] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][12]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [12]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][13] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][13]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [13]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][14] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][14]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [14]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][15] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [15]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][16] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][16]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [16]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][17] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][17]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [17]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][18] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][18]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [18]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][19] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][19]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [19]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][1] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][1]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [1]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][20] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][20]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [20]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][21] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][21]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [21]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][22] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][22]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [22]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][23] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][23]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [23]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][24] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][24]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [24]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][25] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][25]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [25]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][26] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][26]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [26]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][27] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][27]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [27]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][28] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][28]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [28]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][29] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][29]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [29]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][2] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][2]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [2]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][30] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][30]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [30]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][31] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][31]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [31]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][3] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][3]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [3]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][4] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][4]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [4]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][5] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][5]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [5]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][6] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][6]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [6]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][7] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][7]_i_2_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [7]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][8] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][8]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [8]),
        .R(1'b0));
  FDRE \gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6][9] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][15]_i_1_n_0 ),
        .D(\gen_cntl.gen_ctl_regs[6].cntl_reg[6][9]_i_1_n_0 ),
        .Q(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hF7F0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1 
       (.I0(\w_data_reg_n_0_[0] ),
        .I1(reg_clr1__1),
        .I2(re_int[0]),
        .I3(int_flag_reg[0]),
        .O(\gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_flag.gen_int_flag_reg[0].int_flag_reg[0]_i_1_n_0 ),
        .Q(int_flag_reg[0]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'hF7F0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1 
       (.I0(p_1_in16_in),
        .I1(reg_clr1__1),
        .I2(re_int[1]),
        .I3(int_flag_reg[1]),
        .O(\gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_flag.gen_int_flag_reg[1].int_flag_reg[1]_i_1_n_0 ),
        .Q(int_flag_reg[1]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hF7F0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[2].int_flag_reg[2]_i_1 
       (.I0(p_1_in13_in),
        .I1(reg_clr1__1),
        .I2(re_int[2]),
        .I3(int_flag_reg[2]),
        .O(\gen_int.gen_int_flag.gen_int_flag_reg[2].int_flag_reg[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[2].int_flag_reg_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_flag.gen_int_flag_reg[2].int_flag_reg[2]_i_1_n_0 ),
        .Q(int_flag_reg[2]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'hF7F0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[3].int_flag_reg[3]_i_1 
       (.I0(p_1_in10_in),
        .I1(reg_clr1__1),
        .I2(re_int[3]),
        .I3(int_flag_reg[3]),
        .O(\gen_int.gen_int_flag.gen_int_flag_reg[3].int_flag_reg[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[3].int_flag_reg_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_flag.gen_int_flag_reg[3].int_flag_reg[3]_i_1_n_0 ),
        .Q(int_flag_reg[3]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hF7F0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[4].int_flag_reg[4]_i_1 
       (.I0(p_1_in7_in),
        .I1(reg_clr1__1),
        .I2(re_int[4]),
        .I3(int_flag_reg[4]),
        .O(\gen_int.gen_int_flag.gen_int_flag_reg[4].int_flag_reg[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[4].int_flag_reg_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_flag.gen_int_flag_reg[4].int_flag_reg[4]_i_1_n_0 ),
        .Q(int_flag_reg[4]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hF7F0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[5].int_flag_reg[5]_i_1 
       (.I0(p_1_in4_in),
        .I1(reg_clr1__1),
        .I2(re_int[5]),
        .I3(int_flag_reg[5]),
        .O(\gen_int.gen_int_flag.gen_int_flag_reg[5].int_flag_reg[5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[5].int_flag_reg_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_flag.gen_int_flag_reg[5].int_flag_reg[5]_i_1_n_0 ),
        .Q(int_flag_reg[5]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hF7F0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[6].int_flag_reg[6]_i_1 
       (.I0(p_1_in),
        .I1(reg_clr1__1),
        .I2(re_int[6]),
        .I3(int_flag_reg[6]),
        .O(\gen_int.gen_int_flag.gen_int_flag_reg[6].int_flag_reg[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[6].int_flag_reg_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_flag.gen_int_flag_reg[6].int_flag_reg[6]_i_1_n_0 ),
        .Q(int_flag_reg[6]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hF7F0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_1 
       (.I0(\w_data_reg_n_0_[7] ),
        .I1(reg_clr1__1),
        .I2(re_int[7]),
        .I3(int_flag_reg[7]),
        .O(\gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000008000000)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_2 
       (.I0(p_0_in),
        .I1(w_addr__0[5]),
        .I2(w_addr__0[2]),
        .I3(w_addr__0[3]),
        .I4(w_we_reg_n_0),
        .I5(w_addr__0[4]),
        .O(reg_clr1__1));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_flag.gen_int_flag_reg[7].int_flag_reg[7]_i_1_n_0 ),
        .Q(int_flag_reg[7]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].int_and[0]_i_1 
       (.I0(re_int[0]),
        .I1(\gen_int.int_en_reg_reg_n_0_[0] ),
        .O(\gen_int.gen_int_src.gen_int_src_reg[0].int_and_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].int_and_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[0].int_and_reg0 ),
        .Q(int_and[0]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].re_int[0]_i_1 
       (.I0(t1_intrpt_src_in[0]),
        .I1(t2_intrpt_src_in[0]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[0].re_int_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].re_int_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[0].re_int_reg0 ),
        .Q(re_int[0]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].t1_intrpt_src_in_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(intrpt_src_in[0]),
        .Q(t1_intrpt_src_in[0]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[0].t2_intrpt_src_in_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(t1_intrpt_src_in[0]),
        .Q(t2_intrpt_src_in[0]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].int_and[1]_i_1 
       (.I0(re_int[1]),
        .I1(p_0_in39_in),
        .O(\gen_int.gen_int_src.gen_int_src_reg[1].int_and_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].int_and_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[1].int_and_reg0 ),
        .Q(int_and[1]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].re_int[1]_i_1 
       (.I0(t1_intrpt_src_in[1]),
        .I1(t2_intrpt_src_in[1]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[1].re_int_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].re_int_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[1].re_int_reg0 ),
        .Q(re_int[1]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].t1_intrpt_src_in_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(intrpt_src_in[1]),
        .Q(t1_intrpt_src_in[1]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[1].t2_intrpt_src_in_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(t1_intrpt_src_in[1]),
        .Q(t2_intrpt_src_in[1]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \gen_int.gen_int_src.gen_int_src_reg[2].int_and[2]_i_1 
       (.I0(re_int[2]),
        .I1(p_0_in36_in),
        .O(\gen_int.gen_int_src.gen_int_src_reg[2].int_and_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[2].int_and_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[2].int_and_reg0 ),
        .Q(int_and[2]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \gen_int.gen_int_src.gen_int_src_reg[2].re_int[2]_i_1 
       (.I0(t1_intrpt_src_in[2]),
        .I1(t2_intrpt_src_in[2]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[2].re_int_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[2].re_int_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[2].re_int_reg0 ),
        .Q(re_int[2]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[2].t1_intrpt_src_in_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(intrpt_src_in[2]),
        .Q(t1_intrpt_src_in[2]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[2].t2_intrpt_src_in_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(t1_intrpt_src_in[2]),
        .Q(t2_intrpt_src_in[2]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \gen_int.gen_int_src.gen_int_src_reg[3].int_and[3]_i_1 
       (.I0(re_int[3]),
        .I1(p_0_in33_in),
        .O(\gen_int.gen_int_src.gen_int_src_reg[3].int_and_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[3].int_and_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[3].int_and_reg0 ),
        .Q(int_and[3]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \gen_int.gen_int_src.gen_int_src_reg[3].re_int[3]_i_1 
       (.I0(t1_intrpt_src_in[3]),
        .I1(t2_intrpt_src_in[3]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[3].re_int_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[3].re_int_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[3].re_int_reg0 ),
        .Q(re_int[3]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[3].t1_intrpt_src_in_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(intrpt_src_in[3]),
        .Q(t1_intrpt_src_in[3]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[3].t2_intrpt_src_in_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(t1_intrpt_src_in[3]),
        .Q(t2_intrpt_src_in[3]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \gen_int.gen_int_src.gen_int_src_reg[4].int_and[4]_i_1 
       (.I0(re_int[4]),
        .I1(p_0_in30_in),
        .O(\gen_int.gen_int_src.gen_int_src_reg[4].int_and_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[4].int_and_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[4].int_and_reg0 ),
        .Q(int_and[4]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \gen_int.gen_int_src.gen_int_src_reg[4].re_int[4]_i_1 
       (.I0(t1_intrpt_src_in[4]),
        .I1(t2_intrpt_src_in[4]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[4].re_int_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[4].re_int_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[4].re_int_reg0 ),
        .Q(re_int[4]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[4].t1_intrpt_src_in_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(intrpt_src_in[4]),
        .Q(t1_intrpt_src_in[4]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[4].t2_intrpt_src_in_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(t1_intrpt_src_in[4]),
        .Q(t2_intrpt_src_in[4]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \gen_int.gen_int_src.gen_int_src_reg[5].int_and[5]_i_1 
       (.I0(re_int[5]),
        .I1(p_0_in27_in),
        .O(\gen_int.gen_int_src.gen_int_src_reg[5].int_and_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[5].int_and_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[5].int_and_reg0 ),
        .Q(int_and[5]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \gen_int.gen_int_src.gen_int_src_reg[5].re_int[5]_i_1 
       (.I0(t1_intrpt_src_in[5]),
        .I1(t2_intrpt_src_in[5]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[5].re_int_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[5].re_int_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[5].re_int_reg0 ),
        .Q(re_int[5]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[5].t1_intrpt_src_in_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(intrpt_src_in[5]),
        .Q(t1_intrpt_src_in[5]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[5].t2_intrpt_src_in_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(t1_intrpt_src_in[5]),
        .Q(t2_intrpt_src_in[5]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \gen_int.gen_int_src.gen_int_src_reg[6].int_and[6]_i_1 
       (.I0(re_int[6]),
        .I1(p_0_in24_in),
        .O(\gen_int.gen_int_src.gen_int_src_reg[6].int_and_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[6].int_and_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[6].int_and_reg0 ),
        .Q(int_and[6]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \gen_int.gen_int_src.gen_int_src_reg[6].re_int[6]_i_1 
       (.I0(t1_intrpt_src_in[6]),
        .I1(t2_intrpt_src_in[6]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[6].re_int_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[6].re_int_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[6].re_int_reg0 ),
        .Q(re_int[6]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[6].t1_intrpt_src_in_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(intrpt_src_in[6]),
        .Q(t1_intrpt_src_in[6]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[6].t2_intrpt_src_in_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(t1_intrpt_src_in[6]),
        .Q(t2_intrpt_src_in[6]),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \gen_int.gen_int_src.gen_int_src_reg[7].int_and[7]_i_1 
       (.I0(re_int[7]),
        .I1(p_0_in21_in),
        .O(\gen_int.gen_int_src.gen_int_src_reg[7].int_and_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[7].int_and_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[7].int_and_reg0 ),
        .Q(int_and[7]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    \gen_int.gen_int_src.gen_int_src_reg[7].re_int[7]_i_1 
       (.I0(t1_intrpt_src_in[7]),
        .I1(t2_intrpt_src_in[7]),
        .O(\gen_int.gen_int_src.gen_int_src_reg[7].re_int_reg0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[7].re_int_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\gen_int.gen_int_src.gen_int_src_reg[7].re_int_reg0 ),
        .Q(re_int[7]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[7].t1_intrpt_src_in_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(intrpt_src_in[7]),
        .Q(t1_intrpt_src_in[7]),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.gen_int_src.gen_int_src_reg[7].t2_intrpt_src_in_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(t1_intrpt_src_in[7]),
        .Q(t2_intrpt_src_in[7]),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'h0002000000000000)) 
    \gen_int.int_en_reg[15]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(w_addr__0[3]),
        .I2(w_addr__0[2]),
        .I3(w_addr__0[4]),
        .I4(w_addr__0[5]),
        .I5(data00),
        .O(\gen_int.int_en_reg[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0002000000000000)) 
    \gen_int.int_en_reg[23]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(w_addr__0[3]),
        .I2(w_addr__0[2]),
        .I3(w_addr__0[4]),
        .I4(w_addr__0[5]),
        .I5(\wr_strb_reg_n_0_[2] ),
        .O(\gen_int.int_en_reg[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0002000000000000)) 
    \gen_int.int_en_reg[31]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(w_addr__0[3]),
        .I2(w_addr__0[2]),
        .I3(w_addr__0[4]),
        .I4(w_addr__0[5]),
        .I5(\wr_strb_reg_n_0_[3] ),
        .O(\gen_int.int_en_reg[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0002000000000000)) 
    \gen_int.int_en_reg[7]_i_1 
       (.I0(w_we_reg_n_0),
        .I1(w_addr__0[3]),
        .I2(w_addr__0[2]),
        .I3(w_addr__0[4]),
        .I4(w_addr__0[5]),
        .I5(p_0_in),
        .O(\gen_int.int_en_reg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[0] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[0] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[10] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[10] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[11] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[11] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[12] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[12] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[13] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[13] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[14] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[14] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[15] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[15] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[23]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[16] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[16] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[23]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[17] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[17] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[23]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[18] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[18] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[23]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[19] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[19] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[7]_i_1_n_0 ),
        .D(p_1_in16_in),
        .Q(p_0_in39_in),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[23]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[20] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[20] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[23]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[21] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[21] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[23]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[22] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[22] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[23]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[23] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[23] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[31]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[24] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[24] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[31]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[25] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[25] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[31]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[26] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[26] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[31]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[27] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[27] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[31]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[28] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[28] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[31]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[29] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[29] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[7]_i_1_n_0 ),
        .D(p_1_in13_in),
        .Q(p_0_in36_in),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[31]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[30] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[30] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[31]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[31] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[31] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[7]_i_1_n_0 ),
        .D(p_1_in10_in),
        .Q(p_0_in33_in),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[7]_i_1_n_0 ),
        .D(p_1_in7_in),
        .Q(p_0_in30_in),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[7]_i_1_n_0 ),
        .D(p_1_in4_in),
        .Q(p_0_in27_in),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[7]_i_1_n_0 ),
        .D(p_1_in),
        .Q(p_0_in24_in),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[7]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[7] ),
        .Q(p_0_in21_in),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[8] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[8] ),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_int.int_en_reg_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(\gen_int.int_en_reg[15]_i_1_n_0 ),
        .D(\w_data_reg_n_0_[9] ),
        .Q(\gen_int.int_en_reg_reg_n_0_[9] ),
        .R(s_axi_csr_awready_i_1_n_0));
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 irq INTR" *) 
  (* x_interface_parameter = "SENSITIVITY EDGE_RISING" *) 
  FDRE \gen_int.irq_reg 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(usr_int),
        .Q(irq),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT5 #(
    .INIT(32'hFFFEFFFF)) 
    \gen_int.usr_int_i_1 
       (.I0(int_and[2]),
        .I1(int_and[3]),
        .I2(int_and[0]),
        .I3(int_and[1]),
        .I4(\gen_int.usr_int_i_2_n_0 ),
        .O(\gen_int.usr_int_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \gen_int.usr_int_i_2 
       (.I0(int_and[6]),
        .I1(int_and[7]),
        .I2(int_and[5]),
        .I3(int_and[4]),
        .O(\gen_int.usr_int_i_2_n_0 ));
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
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [0]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][10] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[10]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [10]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][11] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[11]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [11]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][12] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[12]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [12]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][13] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[13]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [13]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][14] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[14]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [14]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][15] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[15]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [15]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][16] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[16]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [16]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][17] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[17]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [17]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][18] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[18]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [18]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][19] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[19]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [19]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][1] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[1]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [1]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][20] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[20]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [20]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][21] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[21]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [21]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][22] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[22]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [22]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][23] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[23]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [23]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][24] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[24]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [24]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][25] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[25]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [25]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][26] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[26]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [26]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][27] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[27]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [27]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][28] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[28]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [28]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][29] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[29]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [29]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][2] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[2]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [2]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][30] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[30]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [30]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][31] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[31]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [31]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][3] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[3]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [3]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][4] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[4]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [4]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][5] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[5]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [5]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][6] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[6]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [6]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][7] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[7]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [7]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][8] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[8]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [8]),
        .R(1'b0));
  FDRE \gen_stat.gen_stat_regs[0].stat_reg_reg[0][9] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(stat0_in[9]),
        .Q(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [9]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h8)) 
    \r_addr[5]_i_1 
       (.I0(s_axi_csr_aresetn),
        .I1(r_addr),
        .O(\r_addr[5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \r_addr_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(\r_addr[5]_i_1_n_0 ),
        .D(s_axi_csr_araddr[0]),
        .Q(r_addr_num[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_addr_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(\r_addr[5]_i_1_n_0 ),
        .D(s_axi_csr_araddr[1]),
        .Q(r_addr_num[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_addr_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(\r_addr[5]_i_1_n_0 ),
        .D(s_axi_csr_araddr[2]),
        .Q(r_addr_num[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \r_addr_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(\r_addr[5]_i_1_n_0 ),
        .D(s_axi_csr_araddr[3]),
        .Q(\r_addr_reg_n_0_[5] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAAF0AAAAAACCAACC)) 
    \rd_data[0]_i_1 
       (.I0(\rd_data[0]_i_2_n_0 ),
        .I1(\rd_data[0]_i_3_n_0 ),
        .I2(\rd_data[0]_i_4_n_0 ),
        .I3(\r_addr_reg_n_0_[5] ),
        .I4(\rd_data[31]_i_2_n_0 ),
        .I5(r_addr_num[2]),
        .O(\rd_data[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF8888888FF888888)) 
    \rd_data[0]_i_2 
       (.I0(\rd_data[7]_i_5_n_0 ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [0]),
        .I2(int_flag_reg[0]),
        .I3(\rd_data[0]_i_5_n_0 ),
        .I4(\r_addr_reg_n_0_[5] ),
        .I5(\rd_data[7]_i_7_n_0 ),
        .O(\rd_data[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[0]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [0]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [0]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [0]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [0]),
        .O(\rd_data[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[0]_i_4 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [0]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [0]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [0]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEFFFCFFFEF)) 
    \rd_data[0]_i_5 
       (.I0(\gen_int.int_en_reg_reg_n_0_[0] ),
        .I1(r_addr_num[2]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[1]),
        .I4(r_addr_num[0]),
        .I5(t2_intrpt_src_in[0]),
        .O(\rd_data[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[10]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[10]_i_2_n_0 ),
        .I4(\rd_data[10]_i_3_n_0 ),
        .I5(\rd_data[10]_i_4_n_0 ),
        .O(\rd_data[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[10]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [10]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [10]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [10]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [10]),
        .O(\rd_data[10]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[10]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [10]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [10]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [10]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[10]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[10]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[10] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [10]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[10]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[11]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[11]_i_2_n_0 ),
        .I4(\rd_data[11]_i_3_n_0 ),
        .I5(\rd_data[11]_i_4_n_0 ),
        .O(\rd_data[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[11]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [11]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [11]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [11]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [11]),
        .O(\rd_data[11]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[11]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [11]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [11]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [11]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[11]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[11]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[11] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [11]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[11]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[12]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[12]_i_2_n_0 ),
        .I4(\rd_data[12]_i_3_n_0 ),
        .I5(\rd_data[12]_i_4_n_0 ),
        .O(\rd_data[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[12]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [12]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [12]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [12]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [12]),
        .O(\rd_data[12]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[12]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [12]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [12]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [12]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[12]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[12] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [12]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[12]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[13]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[13]_i_2_n_0 ),
        .I4(\rd_data[13]_i_3_n_0 ),
        .I5(\rd_data[13]_i_4_n_0 ),
        .O(\rd_data[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[13]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [13]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [13]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [13]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [13]),
        .O(\rd_data[13]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[13]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [13]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [13]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [13]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[13]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[13]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[13] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [13]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[13]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[14]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[14]_i_2_n_0 ),
        .I4(\rd_data[14]_i_3_n_0 ),
        .I5(\rd_data[14]_i_4_n_0 ),
        .O(\rd_data[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[14]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [14]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [14]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [14]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [14]),
        .O(\rd_data[14]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[14]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [14]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [14]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [14]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[14]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[14]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[14] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [14]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[14]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[15]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[15]_i_2_n_0 ),
        .I4(\rd_data[15]_i_3_n_0 ),
        .I5(\rd_data[15]_i_4_n_0 ),
        .O(\rd_data[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[15]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [15]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [15]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [15]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [15]),
        .O(\rd_data[15]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[15]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [15]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [15]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [15]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[15]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[15] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [15]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[15]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[16]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[16]_i_2_n_0 ),
        .I4(\rd_data[16]_i_3_n_0 ),
        .I5(\rd_data[16]_i_4_n_0 ),
        .O(\rd_data[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[16]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [16]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [16]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [16]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [16]),
        .O(\rd_data[16]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[16]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [16]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [16]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [16]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[16]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[16]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[16] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [16]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[16]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[17]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[17]_i_2_n_0 ),
        .I4(\rd_data[17]_i_3_n_0 ),
        .I5(\rd_data[17]_i_4_n_0 ),
        .O(\rd_data[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[17]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [17]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [17]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [17]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [17]),
        .O(\rd_data[17]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[17]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [17]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [17]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [17]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[17]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[17]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[17] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [17]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[17]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[18]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[18]_i_2_n_0 ),
        .I4(\rd_data[18]_i_3_n_0 ),
        .I5(\rd_data[18]_i_4_n_0 ),
        .O(\rd_data[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[18]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [18]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [18]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [18]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [18]),
        .O(\rd_data[18]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[18]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [18]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [18]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [18]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[18]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[18]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[18] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [18]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[18]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[19]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[19]_i_2_n_0 ),
        .I4(\rd_data[19]_i_3_n_0 ),
        .I5(\rd_data[19]_i_4_n_0 ),
        .O(\rd_data[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[19]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [19]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [19]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [19]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [19]),
        .O(\rd_data[19]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[19]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [19]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [19]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [19]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[19]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[19]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[19] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [19]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[19]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAAAAACCAACC)) 
    \rd_data[1]_i_1 
       (.I0(\rd_data[1]_i_2_n_0 ),
        .I1(\rd_data[1]_i_3_n_0 ),
        .I2(\rd_data[1]_i_4_n_0 ),
        .I3(\r_addr_reg_n_0_[5] ),
        .I4(\rd_data[31]_i_2_n_0 ),
        .I5(r_addr_num[2]),
        .O(\rd_data[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF8888888FF888888)) 
    \rd_data[1]_i_2 
       (.I0(\rd_data[7]_i_5_n_0 ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [1]),
        .I2(int_flag_reg[1]),
        .I3(\rd_data[1]_i_5_n_0 ),
        .I4(\r_addr_reg_n_0_[5] ),
        .I5(\rd_data[7]_i_7_n_0 ),
        .O(\rd_data[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[1]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [1]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [1]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [1]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [1]),
        .O(\rd_data[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[1]_i_4 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [1]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [1]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [1]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEFFFCFFFEF)) 
    \rd_data[1]_i_5 
       (.I0(p_0_in39_in),
        .I1(r_addr_num[2]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[1]),
        .I4(r_addr_num[0]),
        .I5(t2_intrpt_src_in[1]),
        .O(\rd_data[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[20]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[20]_i_2_n_0 ),
        .I4(\rd_data[20]_i_3_n_0 ),
        .I5(\rd_data[20]_i_4_n_0 ),
        .O(\rd_data[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[20]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [20]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [20]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [20]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [20]),
        .O(\rd_data[20]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[20]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [20]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [20]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [20]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[20]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[20]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[20] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [20]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[20]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[21]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[21]_i_2_n_0 ),
        .I4(\rd_data[21]_i_3_n_0 ),
        .I5(\rd_data[21]_i_4_n_0 ),
        .O(\rd_data[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[21]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [21]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [21]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [21]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [21]),
        .O(\rd_data[21]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[21]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [21]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [21]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [21]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[21]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[21]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[21] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [21]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[21]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[22]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[22]_i_2_n_0 ),
        .I4(\rd_data[22]_i_3_n_0 ),
        .I5(\rd_data[22]_i_4_n_0 ),
        .O(\rd_data[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[22]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [22]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [22]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [22]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [22]),
        .O(\rd_data[22]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[22]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [22]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [22]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [22]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[22]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[22]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[22] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [22]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[22]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[23]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[23]_i_2_n_0 ),
        .I4(\rd_data[23]_i_3_n_0 ),
        .I5(\rd_data[23]_i_4_n_0 ),
        .O(\rd_data[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[23]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [23]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [23]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [23]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [23]),
        .O(\rd_data[23]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[23]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [23]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [23]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [23]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[23]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[23]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[23] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [23]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[23]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[24]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[24]_i_2_n_0 ),
        .I4(\rd_data[24]_i_3_n_0 ),
        .I5(\rd_data[24]_i_4_n_0 ),
        .O(\rd_data[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[24]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [24]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [24]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [24]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [24]),
        .O(\rd_data[24]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[24]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [24]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [24]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [24]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[24]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[24]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[24] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [24]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[24]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[25]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[25]_i_2_n_0 ),
        .I4(\rd_data[25]_i_3_n_0 ),
        .I5(\rd_data[25]_i_4_n_0 ),
        .O(\rd_data[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[25]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [25]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [25]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [25]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [25]),
        .O(\rd_data[25]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[25]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [25]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [25]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [25]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[25]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[25]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[25] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [25]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[25]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[26]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[26]_i_2_n_0 ),
        .I4(\rd_data[26]_i_3_n_0 ),
        .I5(\rd_data[26]_i_4_n_0 ),
        .O(\rd_data[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[26]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [26]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [26]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [26]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [26]),
        .O(\rd_data[26]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[26]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [26]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [26]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [26]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[26]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[26]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[26] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [26]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[26]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[27]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[27]_i_2_n_0 ),
        .I4(\rd_data[27]_i_3_n_0 ),
        .I5(\rd_data[27]_i_4_n_0 ),
        .O(\rd_data[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[27]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [27]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [27]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [27]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [27]),
        .O(\rd_data[27]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[27]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [27]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [27]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [27]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[27]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[27]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[27] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [27]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[27]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[28]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[28]_i_2_n_0 ),
        .I4(\rd_data[28]_i_3_n_0 ),
        .I5(\rd_data[28]_i_4_n_0 ),
        .O(\rd_data[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[28]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [28]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [28]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [28]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [28]),
        .O(\rd_data[28]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[28]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [28]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [28]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [28]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[28]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[28]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[28] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [28]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[28]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[29]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[29]_i_2_n_0 ),
        .I4(\rd_data[29]_i_3_n_0 ),
        .I5(\rd_data[29]_i_4_n_0 ),
        .O(\rd_data[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[29]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [29]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [29]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [29]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [29]),
        .O(\rd_data[29]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[29]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [29]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [29]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [29]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[29]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[29]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[29] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [29]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[29]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAAAAACCAACC)) 
    \rd_data[2]_i_1 
       (.I0(\rd_data[2]_i_2_n_0 ),
        .I1(\rd_data[2]_i_3_n_0 ),
        .I2(\rd_data[2]_i_4_n_0 ),
        .I3(\r_addr_reg_n_0_[5] ),
        .I4(\rd_data[31]_i_2_n_0 ),
        .I5(r_addr_num[2]),
        .O(\rd_data[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF8888888FF888888)) 
    \rd_data[2]_i_2 
       (.I0(\rd_data[7]_i_5_n_0 ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [2]),
        .I2(int_flag_reg[2]),
        .I3(\rd_data[2]_i_5_n_0 ),
        .I4(\r_addr_reg_n_0_[5] ),
        .I5(\rd_data[7]_i_7_n_0 ),
        .O(\rd_data[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[2]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [2]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [2]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [2]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [2]),
        .O(\rd_data[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[2]_i_4 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [2]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [2]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [2]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEFFFCFFFEF)) 
    \rd_data[2]_i_5 
       (.I0(p_0_in36_in),
        .I1(r_addr_num[2]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[1]),
        .I4(r_addr_num[0]),
        .I5(t2_intrpt_src_in[2]),
        .O(\rd_data[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[30]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[30]_i_2_n_0 ),
        .I4(\rd_data[30]_i_3_n_0 ),
        .I5(\rd_data[30]_i_4_n_0 ),
        .O(\rd_data[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[30]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [30]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [30]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [30]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [30]),
        .O(\rd_data[30]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[30]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [30]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [30]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [30]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[30]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[30]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[30] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [30]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[30]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[31]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[31]_i_3_n_0 ),
        .I4(\rd_data[31]_i_4_n_0 ),
        .I5(\rd_data[31]_i_5_n_0 ),
        .O(\rd_data[31]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \rd_data[31]_i_2 
       (.I0(r_addr_num[1]),
        .I1(r_addr_num[0]),
        .O(\rd_data[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[31]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [31]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [31]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [31]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [31]),
        .O(\rd_data[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[31]_i_4 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [31]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [31]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [31]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[31]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[31]_i_5 
       (.I0(\gen_int.int_en_reg_reg_n_0_[31] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [31]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[31]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAAAAACCAACC)) 
    \rd_data[3]_i_1 
       (.I0(\rd_data[3]_i_2_n_0 ),
        .I1(\rd_data[3]_i_3_n_0 ),
        .I2(\rd_data[3]_i_4_n_0 ),
        .I3(\r_addr_reg_n_0_[5] ),
        .I4(\rd_data[31]_i_2_n_0 ),
        .I5(r_addr_num[2]),
        .O(\rd_data[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF8888888FF888888)) 
    \rd_data[3]_i_2 
       (.I0(\rd_data[7]_i_5_n_0 ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [3]),
        .I2(int_flag_reg[3]),
        .I3(\rd_data[3]_i_5_n_0 ),
        .I4(\r_addr_reg_n_0_[5] ),
        .I5(\rd_data[7]_i_7_n_0 ),
        .O(\rd_data[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[3]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [3]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [3]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [3]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [3]),
        .O(\rd_data[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[3]_i_4 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [3]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [3]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [3]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEFFFCFFFEF)) 
    \rd_data[3]_i_5 
       (.I0(p_0_in33_in),
        .I1(r_addr_num[2]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[1]),
        .I4(r_addr_num[0]),
        .I5(t2_intrpt_src_in[3]),
        .O(\rd_data[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAAAAACCAACC)) 
    \rd_data[4]_i_1 
       (.I0(\rd_data[4]_i_2_n_0 ),
        .I1(\rd_data[4]_i_3_n_0 ),
        .I2(\rd_data[4]_i_4_n_0 ),
        .I3(\r_addr_reg_n_0_[5] ),
        .I4(\rd_data[31]_i_2_n_0 ),
        .I5(r_addr_num[2]),
        .O(\rd_data[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF8888888FF888888)) 
    \rd_data[4]_i_2 
       (.I0(\rd_data[7]_i_5_n_0 ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [4]),
        .I2(int_flag_reg[4]),
        .I3(\rd_data[4]_i_5_n_0 ),
        .I4(\r_addr_reg_n_0_[5] ),
        .I5(\rd_data[7]_i_7_n_0 ),
        .O(\rd_data[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[4]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [4]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [4]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [4]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [4]),
        .O(\rd_data[4]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[4]_i_4 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [4]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [4]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [4]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEFFFCFFFEF)) 
    \rd_data[4]_i_5 
       (.I0(p_0_in30_in),
        .I1(r_addr_num[2]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[1]),
        .I4(r_addr_num[0]),
        .I5(t2_intrpt_src_in[4]),
        .O(\rd_data[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAAAAACCAACC)) 
    \rd_data[5]_i_1 
       (.I0(\rd_data[5]_i_2_n_0 ),
        .I1(\rd_data[5]_i_3_n_0 ),
        .I2(\rd_data[5]_i_4_n_0 ),
        .I3(\r_addr_reg_n_0_[5] ),
        .I4(\rd_data[31]_i_2_n_0 ),
        .I5(r_addr_num[2]),
        .O(\rd_data[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF8888888FF888888)) 
    \rd_data[5]_i_2 
       (.I0(\rd_data[7]_i_5_n_0 ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [5]),
        .I2(int_flag_reg[5]),
        .I3(\rd_data[5]_i_5_n_0 ),
        .I4(\r_addr_reg_n_0_[5] ),
        .I5(\rd_data[7]_i_7_n_0 ),
        .O(\rd_data[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[5]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [5]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [5]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [5]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [5]),
        .O(\rd_data[5]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[5]_i_4 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [5]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [5]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [5]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEFFFCFFFEF)) 
    \rd_data[5]_i_5 
       (.I0(p_0_in27_in),
        .I1(r_addr_num[2]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[1]),
        .I4(r_addr_num[0]),
        .I5(t2_intrpt_src_in[5]),
        .O(\rd_data[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAAAAACCAACC)) 
    \rd_data[6]_i_1 
       (.I0(\rd_data[6]_i_2_n_0 ),
        .I1(\rd_data[6]_i_3_n_0 ),
        .I2(\rd_data[6]_i_4_n_0 ),
        .I3(\r_addr_reg_n_0_[5] ),
        .I4(\rd_data[31]_i_2_n_0 ),
        .I5(r_addr_num[2]),
        .O(\rd_data[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF8888888FF888888)) 
    \rd_data[6]_i_2 
       (.I0(\rd_data[7]_i_5_n_0 ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [6]),
        .I2(int_flag_reg[6]),
        .I3(\rd_data[6]_i_5_n_0 ),
        .I4(\r_addr_reg_n_0_[5] ),
        .I5(\rd_data[7]_i_7_n_0 ),
        .O(\rd_data[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[6]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [6]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [6]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [6]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [6]),
        .O(\rd_data[6]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[6]_i_4 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [6]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [6]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [6]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEFFFCFFFEF)) 
    \rd_data[6]_i_5 
       (.I0(p_0_in24_in),
        .I1(r_addr_num[2]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[1]),
        .I4(r_addr_num[0]),
        .I5(t2_intrpt_src_in[6]),
        .O(\rd_data[6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAF0AAAAAACCAACC)) 
    \rd_data[7]_i_1 
       (.I0(\rd_data[7]_i_2_n_0 ),
        .I1(\rd_data[7]_i_3_n_0 ),
        .I2(\rd_data[7]_i_4_n_0 ),
        .I3(\r_addr_reg_n_0_[5] ),
        .I4(\rd_data[31]_i_2_n_0 ),
        .I5(r_addr_num[2]),
        .O(\rd_data[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF8888888FF888888)) 
    \rd_data[7]_i_2 
       (.I0(\rd_data[7]_i_5_n_0 ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [7]),
        .I2(int_flag_reg[7]),
        .I3(\rd_data[7]_i_6_n_0 ),
        .I4(\r_addr_reg_n_0_[5] ),
        .I5(\rd_data[7]_i_7_n_0 ),
        .O(\rd_data[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[7]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [7]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [7]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [7]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [7]),
        .O(\rd_data[7]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[7]_i_4 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [7]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [7]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [7]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[7]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \rd_data[7]_i_5 
       (.I0(\r_addr_reg_n_0_[5] ),
        .I1(r_addr_num[1]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[2]),
        .O(\rd_data[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEFFFCFFFEF)) 
    \rd_data[7]_i_6 
       (.I0(p_0_in21_in),
        .I1(r_addr_num[2]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[1]),
        .I4(r_addr_num[0]),
        .I5(t2_intrpt_src_in[7]),
        .O(\rd_data[7]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hEF)) 
    \rd_data[7]_i_7 
       (.I0(r_addr_num[1]),
        .I1(r_addr_num[2]),
        .I2(\r_addr_reg_n_0_[5] ),
        .O(\rd_data[7]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[8]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[8]_i_2_n_0 ),
        .I4(\rd_data[8]_i_3_n_0 ),
        .I5(\rd_data[8]_i_4_n_0 ),
        .O(\rd_data[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[8]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [8]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [8]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [8]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [8]),
        .O(\rd_data[8]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[8]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [8]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [8]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [8]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[8]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[8] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [8]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0D080500)) 
    \rd_data[9]_i_1 
       (.I0(r_addr_num[2]),
        .I1(\rd_data[31]_i_2_n_0 ),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(\rd_data[9]_i_2_n_0 ),
        .I4(\rd_data[9]_i_3_n_0 ),
        .I5(\rd_data[9]_i_4_n_0 ),
        .O(\rd_data[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \rd_data[9]_i_2 
       (.I0(\gen_cntl.gen_ctl_regs[1].cntl_reg_reg[1]_2 [9]),
        .I1(\gen_cntl.gen_ctl_regs[3].cntl_reg_reg[3]_4 [9]),
        .I2(r_addr_num[0]),
        .I3(r_addr_num[1]),
        .I4(\gen_cntl.gen_ctl_regs[0].cntl_reg_reg[0]_1 [9]),
        .I5(\gen_cntl.gen_ctl_regs[2].cntl_reg_reg[2]_3 [9]),
        .O(\rd_data[9]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \rd_data[9]_i_3 
       (.I0(\gen_cntl.gen_ctl_regs[4].cntl_reg_reg[4]_5 [9]),
        .I1(\gen_cntl.gen_ctl_regs[6].cntl_reg_reg[6]_7 [9]),
        .I2(\gen_cntl.gen_ctl_regs[5].cntl_reg_reg[5]_6 [9]),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .O(\rd_data[9]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C000000000000A0)) 
    \rd_data[9]_i_4 
       (.I0(\gen_int.int_en_reg_reg_n_0_[9] ),
        .I1(\gen_stat.gen_stat_regs[0].stat_reg_reg[0]_0 [9]),
        .I2(\r_addr_reg_n_0_[5] ),
        .I3(r_addr_num[0]),
        .I4(r_addr_num[1]),
        .I5(r_addr_num[2]),
        .O(\rd_data[9]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rd_data_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(\rd_data[0]_i_1_n_0 ),
        .Q(rd_data[0]),
        .R(1'b0));
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
        .D(\rd_data[1]_i_1_n_0 ),
        .Q(rd_data[1]),
        .R(1'b0));
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
  LUT3 #(
    .INIT(8'hBA)) 
    s_axi_csr_arready_i_1
       (.I0(r_addr),
        .I1(\FSM_onehot_state_reg_n_0_[9] ),
        .I2(s_axi_csr_arready),
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
  LUT4 #(
    .INIT(16'hABAA)) 
    s_axi_csr_awready_i_2
       (.I0(s_axi_csr_awready_i_3_n_0),
        .I1(\FSM_onehot_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_state_reg_n_0_[6] ),
        .I3(s_axi_csr_awready),
        .O(s_axi_csr_awready_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hFEEE)) 
    s_axi_csr_awready_i_3
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_state_reg_n_0_[5] ),
        .I3(s_axi_csr_awvalid),
        .O(s_axi_csr_awready_i_3_n_0));
  FDRE s_axi_csr_awready_reg
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(s_axi_csr_awready_i_2_n_0),
        .Q(s_axi_csr_awready),
        .R(s_axi_csr_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hF7F0)) 
    s_axi_csr_bvalid_i_1
       (.I0(s_axi_csr_bready),
        .I1(\FSM_onehot_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_state_reg_n_0_[6] ),
        .I3(s_axi_csr_bvalid),
        .O(s_axi_csr_bvalid_i_1_n_0));
  FDRE s_axi_csr_bvalid_reg
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(s_axi_csr_bvalid_i_1_n_0),
        .Q(s_axi_csr_bvalid),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    \s_axi_csr_rdata[31]_i_1 
       (.I0(s_axi_csr_aresetn),
        .I1(\FSM_onehot_state_reg_n_0_[10] ),
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
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hF7F0)) 
    s_axi_csr_rvalid_i_1
       (.I0(s_axi_csr_rready),
        .I1(\FSM_onehot_state_reg_n_0_[11] ),
        .I2(\FSM_onehot_state_reg_n_0_[10] ),
        .I3(s_axi_csr_rvalid),
        .O(s_axi_csr_rvalid_i_1_n_0));
  FDRE s_axi_csr_rvalid_reg
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(s_axi_csr_rvalid_i_1_n_0),
        .Q(s_axi_csr_rvalid),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT5 #(
    .INIT(32'hFAFBFAFA)) 
    s_axi_csr_wready_i_1
       (.I0(s_axi_csr_wready_i_2_n_0),
        .I1(\FSM_onehot_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_state_reg_n_0_[5] ),
        .I4(s_axi_csr_wready),
        .O(s_axi_csr_wready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    s_axi_csr_wready_i_2
       (.I0(s_axi_csr_wvalid),
        .I1(\FSM_onehot_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_state_reg_n_0_[1] ),
        .O(s_axi_csr_wready_i_2_n_0));
  FDRE s_axi_csr_wready_reg
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(s_axi_csr_wready_i_1_n_0),
        .Q(s_axi_csr_wready),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT5 #(
    .INIT(32'hAAAAAA80)) 
    \w_addr[5]_i_1 
       (.I0(s_axi_csr_aresetn),
        .I1(s_axi_csr_awvalid),
        .I2(\FSM_onehot_state_reg_n_0_[5] ),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\w_addr[5]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \w_addr_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(\w_addr[5]_i_1_n_0 ),
        .D(s_axi_csr_awaddr[0]),
        .Q(w_addr__0[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_addr_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(\w_addr[5]_i_1_n_0 ),
        .D(s_axi_csr_awaddr[1]),
        .Q(w_addr__0[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_addr_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(\w_addr[5]_i_1_n_0 ),
        .D(s_axi_csr_awaddr[2]),
        .Q(w_addr__0[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_addr_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(\w_addr[5]_i_1_n_0 ),
        .D(s_axi_csr_awaddr[3]),
        .Q(w_addr__0[5]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hAAAAA888)) 
    \w_data[31]_i_1 
       (.I0(s_axi_csr_aresetn),
        .I1(\FSM_onehot_state_reg_n_0_[4] ),
        .I2(s_axi_csr_wvalid),
        .I3(\FSM_onehot_state_reg_n_0_[3] ),
        .I4(\FSM_onehot_state_reg_n_0_[1] ),
        .O(w_data));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[0]),
        .Q(\w_data_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[10] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[10]),
        .Q(\w_data_reg_n_0_[10] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[11] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[11]),
        .Q(\w_data_reg_n_0_[11] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[12] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[12]),
        .Q(\w_data_reg_n_0_[12] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[13] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[13]),
        .Q(\w_data_reg_n_0_[13] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[14] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[14]),
        .Q(\w_data_reg_n_0_[14] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[15] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[15]),
        .Q(\w_data_reg_n_0_[15] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[16] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[16]),
        .Q(\w_data_reg_n_0_[16] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[17] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[17]),
        .Q(\w_data_reg_n_0_[17] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[18] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[18]),
        .Q(\w_data_reg_n_0_[18] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[19] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[19]),
        .Q(\w_data_reg_n_0_[19] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[1]),
        .Q(p_1_in16_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[20] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[20]),
        .Q(\w_data_reg_n_0_[20] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[21] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[21]),
        .Q(\w_data_reg_n_0_[21] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[22] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[22]),
        .Q(\w_data_reg_n_0_[22] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[23] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[23]),
        .Q(\w_data_reg_n_0_[23] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[24] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[24]),
        .Q(\w_data_reg_n_0_[24] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[25] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[25]),
        .Q(\w_data_reg_n_0_[25] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[26] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[26]),
        .Q(\w_data_reg_n_0_[26] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[27] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[27]),
        .Q(\w_data_reg_n_0_[27] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[28] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[28]),
        .Q(\w_data_reg_n_0_[28] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[29] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[29]),
        .Q(\w_data_reg_n_0_[29] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[2] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[2]),
        .Q(p_1_in13_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[30] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[30]),
        .Q(\w_data_reg_n_0_[30] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[31] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[31]),
        .Q(\w_data_reg_n_0_[31] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[3] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[3]),
        .Q(p_1_in10_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[4] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[4]),
        .Q(p_1_in7_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[5] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[5]),
        .Q(p_1_in4_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[6] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[6]),
        .Q(p_1_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[7] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[7]),
        .Q(\w_data_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[8] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[8]),
        .Q(\w_data_reg_n_0_[8] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \w_data_reg[9] 
       (.C(s_axi_csr_aclk),
        .CE(w_data),
        .D(s_axi_csr_wdata[9]),
        .Q(\w_data_reg_n_0_[9] ),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hBA)) 
    w_we_i_1
       (.I0(\FSM_onehot_state_reg_n_0_[6] ),
        .I1(\FSM_onehot_state_reg_n_0_[7] ),
        .I2(w_we_reg_n_0),
        .O(w_we_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    w_we_reg
       (.C(s_axi_csr_aclk),
        .CE(1'b1),
        .D(w_we_i_1_n_0),
        .Q(w_we_reg_n_0),
        .R(s_axi_csr_awready_i_1_n_0));
  LUT4 #(
    .INIT(16'hFFEA)) 
    \wr_strb[3]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_state_reg_n_0_[3] ),
        .I2(s_axi_csr_wvalid),
        .I3(\FSM_onehot_state_reg_n_0_[4] ),
        .O(\wr_strb[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \wr_strb_reg[0] 
       (.C(s_axi_csr_aclk),
        .CE(\wr_strb[3]_i_1_n_0 ),
        .D(s_axi_csr_wstrb[0]),
        .Q(p_0_in),
        .R(s_axi_csr_awready_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \wr_strb_reg[1] 
       (.C(s_axi_csr_aclk),
        .CE(\wr_strb[3]_i_1_n_0 ),
        .D(s_axi_csr_wstrb[1]),
        .Q(data00),
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

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
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
