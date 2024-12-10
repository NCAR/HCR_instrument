// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
// Date        : Sun May 17 15:01:14 2015
// Host        : Igor running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               e:/px_ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_pwr_dly/px_pwr_meter_pwr_dly_funcsim.v
// Design      : px_pwr_meter_pwr_dly
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_pwr_meter_pwr_dly,px_vctr_dly,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "px_vctr_dly,Vivado 2015.1" *) 
(* NotValidForBitStream *)
module px_pwr_meter_pwr_dly
   (clk,
    din,
    dout);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) input clk;
  input [31:0]din;
  output [31:0]dout;

  wire clk;
  wire [31:0]din;
  wire [31:0]dout;

  px_pwr_meter_pwr_dly_px_vctr_dly U0
       (.clk(clk),
        .din(din),
        .dout(dout));
endmodule

(* ORIG_REF_NAME = "px_vctr_dly" *) 
module px_pwr_meter_pwr_dly_px_vctr_dly
   (dout,
    clk,
    din);
  output [31:0]dout;
  input clk;
  input [31:0]din;

  wire clk;
  wire [31:0]din;
  wire [31:0]dout;
  wire \gen_gt1.dly_array_reg[1][0]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][10]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][11]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][12]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][13]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][14]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][15]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][16]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][17]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][18]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][19]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][1]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][20]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][21]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][22]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][23]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][24]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][25]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][26]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][27]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][28]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][29]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][2]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][30]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][31]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][3]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][4]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][5]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][6]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][7]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][8]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg[1][9]_srl16_n_0 ;
  wire \gen_gt1.dly_array_reg_n_0_[17][0] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][10] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][11] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][12] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][13] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][14] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][15] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][16] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][17] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][18] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][19] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][1] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][20] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][21] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][22] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][23] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][24] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][25] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][26] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][27] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][28] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][29] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][2] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][30] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][31] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][3] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][4] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][5] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][6] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][7] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][8] ;
  wire \gen_gt1.dly_array_reg_n_0_[17][9] ;

  FDRE \gen_gt1.dly_array_reg[0][0] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][0]_srl16_n_0 ),
        .Q(dout[0]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][10] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][10]_srl16_n_0 ),
        .Q(dout[10]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][11] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][11]_srl16_n_0 ),
        .Q(dout[11]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][12] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][12]_srl16_n_0 ),
        .Q(dout[12]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][13] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][13]_srl16_n_0 ),
        .Q(dout[13]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][14] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][14]_srl16_n_0 ),
        .Q(dout[14]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][15] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][15]_srl16_n_0 ),
        .Q(dout[15]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][16] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][16]_srl16_n_0 ),
        .Q(dout[16]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][17] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][17]_srl16_n_0 ),
        .Q(dout[17]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][18] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][18]_srl16_n_0 ),
        .Q(dout[18]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][19] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][19]_srl16_n_0 ),
        .Q(dout[19]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][1] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][1]_srl16_n_0 ),
        .Q(dout[1]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][20] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][20]_srl16_n_0 ),
        .Q(dout[20]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][21] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][21]_srl16_n_0 ),
        .Q(dout[21]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][22] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][22]_srl16_n_0 ),
        .Q(dout[22]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][23] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][23]_srl16_n_0 ),
        .Q(dout[23]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][24] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][24]_srl16_n_0 ),
        .Q(dout[24]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][25] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][25]_srl16_n_0 ),
        .Q(dout[25]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][26] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][26]_srl16_n_0 ),
        .Q(dout[26]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][27] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][27]_srl16_n_0 ),
        .Q(dout[27]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][28] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][28]_srl16_n_0 ),
        .Q(dout[28]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][29] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][29]_srl16_n_0 ),
        .Q(dout[29]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][2] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][2]_srl16_n_0 ),
        .Q(dout[2]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][30] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][30]_srl16_n_0 ),
        .Q(dout[30]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][31] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][31]_srl16_n_0 ),
        .Q(dout[31]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][3] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][3]_srl16_n_0 ),
        .Q(dout[3]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][4] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][4]_srl16_n_0 ),
        .Q(dout[4]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][5] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][5]_srl16_n_0 ),
        .Q(dout[5]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][6] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][6]_srl16_n_0 ),
        .Q(dout[6]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][7] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][7]_srl16_n_0 ),
        .Q(dout[7]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][8] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][8]_srl16_n_0 ),
        .Q(dout[8]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[0][9] 
       (.C(clk),
        .CE(1'b1),
        .D(\gen_gt1.dly_array_reg[1][9]_srl16_n_0 ),
        .Q(dout[9]),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][0] 
       (.C(clk),
        .CE(1'b1),
        .D(din[0]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][0] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][10] 
       (.C(clk),
        .CE(1'b1),
        .D(din[10]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][10] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][11] 
       (.C(clk),
        .CE(1'b1),
        .D(din[11]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][11] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][12] 
       (.C(clk),
        .CE(1'b1),
        .D(din[12]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][12] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][13] 
       (.C(clk),
        .CE(1'b1),
        .D(din[13]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][13] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][14] 
       (.C(clk),
        .CE(1'b1),
        .D(din[14]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][14] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][15] 
       (.C(clk),
        .CE(1'b1),
        .D(din[15]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][15] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][16] 
       (.C(clk),
        .CE(1'b1),
        .D(din[16]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][16] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][17] 
       (.C(clk),
        .CE(1'b1),
        .D(din[17]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][17] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][18] 
       (.C(clk),
        .CE(1'b1),
        .D(din[18]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][18] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][19] 
       (.C(clk),
        .CE(1'b1),
        .D(din[19]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][19] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][1] 
       (.C(clk),
        .CE(1'b1),
        .D(din[1]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][1] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][20] 
       (.C(clk),
        .CE(1'b1),
        .D(din[20]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][20] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][21] 
       (.C(clk),
        .CE(1'b1),
        .D(din[21]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][21] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][22] 
       (.C(clk),
        .CE(1'b1),
        .D(din[22]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][22] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][23] 
       (.C(clk),
        .CE(1'b1),
        .D(din[23]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][23] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][24] 
       (.C(clk),
        .CE(1'b1),
        .D(din[24]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][24] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][25] 
       (.C(clk),
        .CE(1'b1),
        .D(din[25]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][25] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][26] 
       (.C(clk),
        .CE(1'b1),
        .D(din[26]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][26] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][27] 
       (.C(clk),
        .CE(1'b1),
        .D(din[27]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][27] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][28] 
       (.C(clk),
        .CE(1'b1),
        .D(din[28]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][28] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][29] 
       (.C(clk),
        .CE(1'b1),
        .D(din[29]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][29] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][2] 
       (.C(clk),
        .CE(1'b1),
        .D(din[2]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][2] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][30] 
       (.C(clk),
        .CE(1'b1),
        .D(din[30]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][30] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][31] 
       (.C(clk),
        .CE(1'b1),
        .D(din[31]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][31] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][3] 
       (.C(clk),
        .CE(1'b1),
        .D(din[3]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][3] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][4] 
       (.C(clk),
        .CE(1'b1),
        .D(din[4]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][4] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][5] 
       (.C(clk),
        .CE(1'b1),
        .D(din[5]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][5] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][6] 
       (.C(clk),
        .CE(1'b1),
        .D(din[6]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][6] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][7] 
       (.C(clk),
        .CE(1'b1),
        .D(din[7]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][7] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][8] 
       (.C(clk),
        .CE(1'b1),
        .D(din[8]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][8] ),
        .R(1'b0));
  FDRE \gen_gt1.dly_array_reg[17][9] 
       (.C(clk),
        .CE(1'b1),
        .D(din[9]),
        .Q(\gen_gt1.dly_array_reg_n_0_[17][9] ),
        .R(1'b0));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][0]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][0]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][0] ),
        .Q(\gen_gt1.dly_array_reg[1][0]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][10]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][10]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][10] ),
        .Q(\gen_gt1.dly_array_reg[1][10]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][11]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][11]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][11] ),
        .Q(\gen_gt1.dly_array_reg[1][11]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][12]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][12]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][12] ),
        .Q(\gen_gt1.dly_array_reg[1][12]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][13]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][13]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][13] ),
        .Q(\gen_gt1.dly_array_reg[1][13]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][14]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][14]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][14] ),
        .Q(\gen_gt1.dly_array_reg[1][14]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][15]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][15]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][15] ),
        .Q(\gen_gt1.dly_array_reg[1][15]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][16]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][16]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][16] ),
        .Q(\gen_gt1.dly_array_reg[1][16]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][17]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][17]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][17] ),
        .Q(\gen_gt1.dly_array_reg[1][17]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][18]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][18]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][18] ),
        .Q(\gen_gt1.dly_array_reg[1][18]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][19]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][19]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][19] ),
        .Q(\gen_gt1.dly_array_reg[1][19]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][1]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][1]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][1] ),
        .Q(\gen_gt1.dly_array_reg[1][1]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][20]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][20]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][20] ),
        .Q(\gen_gt1.dly_array_reg[1][20]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][21]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][21]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][21] ),
        .Q(\gen_gt1.dly_array_reg[1][21]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][22]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][22]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][22] ),
        .Q(\gen_gt1.dly_array_reg[1][22]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][23]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][23]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][23] ),
        .Q(\gen_gt1.dly_array_reg[1][23]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][24]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][24]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][24] ),
        .Q(\gen_gt1.dly_array_reg[1][24]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][25]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][25]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][25] ),
        .Q(\gen_gt1.dly_array_reg[1][25]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][26]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][26]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][26] ),
        .Q(\gen_gt1.dly_array_reg[1][26]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][27]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][27]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][27] ),
        .Q(\gen_gt1.dly_array_reg[1][27]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][28]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][28]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][28] ),
        .Q(\gen_gt1.dly_array_reg[1][28]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][29]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][29]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][29] ),
        .Q(\gen_gt1.dly_array_reg[1][29]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][2]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][2]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][2] ),
        .Q(\gen_gt1.dly_array_reg[1][2]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][30]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][30]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][30] ),
        .Q(\gen_gt1.dly_array_reg[1][30]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][31]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][31]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][31] ),
        .Q(\gen_gt1.dly_array_reg[1][31]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][3]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][3]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][3] ),
        .Q(\gen_gt1.dly_array_reg[1][3]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][4]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][4]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][4] ),
        .Q(\gen_gt1.dly_array_reg[1][4]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][5]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][5]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][5] ),
        .Q(\gen_gt1.dly_array_reg[1][5]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][6]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][6]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][6] ),
        .Q(\gen_gt1.dly_array_reg[1][6]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][7]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][7]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][7] ),
        .Q(\gen_gt1.dly_array_reg[1][7]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][8]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][8]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][8] ),
        .Q(\gen_gt1.dly_array_reg[1][8]_srl16_n_0 ));
  (* srl_bus_name = "\U0/gen_gt1.dly_array_reg[1] " *) 
  (* srl_name = "\U0/gen_gt1.dly_array_reg[1][9]_srl16 " *) 
  SRL16E \gen_gt1.dly_array_reg[1][9]_srl16 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(clk),
        .D(\gen_gt1.dly_array_reg_n_0_[17][9] ),
        .Q(\gen_gt1.dly_array_reg[1][9]_srl16_n_0 ));
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
