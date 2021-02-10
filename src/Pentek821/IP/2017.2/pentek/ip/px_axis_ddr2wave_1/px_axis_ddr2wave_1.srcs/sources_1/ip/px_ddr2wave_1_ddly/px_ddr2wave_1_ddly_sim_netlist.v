// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Mon Mar 27 12:36:15 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2016.4/wip/px_axis_ddr2wave_1/px_axis_ddr2wave_1.srcs/sources_1/ip/px_ddr2wave_1_ddly/px_ddr2wave_1_ddly_sim_netlist.v
// Design      : px_ddr2wave_1_ddly
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_ddr2wave_1_ddly,c_shift_ram_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_shift_ram_v12_0_10,Vivado 2016.4" *) 
(* NotValidForBitStream *)
module px_ddr2wave_1_ddly
   (D,
    CLK,
    CE,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) input [8:0]D;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) output [8:0]Q;

  wire CE;
  wire CLK;
  wire [8:0]D;
  wire [8:0]Q;

  (* c_addr_width = "4" *) 
  (* c_ainit_val = "000000000" *) 
  (* c_default_data = "000000000" *) 
  (* c_depth = "32" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "0" *) 
  (* c_has_ce = "1" *) 
  (* c_has_sclr = "0" *) 
  (* c_has_sinit = "0" *) 
  (* c_has_sset = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "0" *) 
  (* c_sinit_val = "000000000" *) 
  (* c_sync_enable = "0" *) 
  (* c_sync_priority = "1" *) 
  (* c_verbosity = "0" *) 
  (* c_width = "9" *) 
  (* c_xdevicefamily = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_ddr2wave_1_ddly_c_shift_ram_v12_0_10 U0
       (.A({1'b0,1'b0,1'b0,1'b0}),
        .CE(CE),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADDR_WIDTH = "4" *) (* C_AINIT_VAL = "000000000" *) (* C_DEFAULT_DATA = "000000000" *) 
(* C_DEPTH = "32" *) (* C_ELABORATION_DIR = "./" *) (* C_HAS_A = "0" *) 
(* C_HAS_CE = "1" *) (* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_MEM_INIT_FILE = "no_coe_file_loaded" *) (* C_OPT_GOAL = "0" *) 
(* C_PARSER_TYPE = "0" *) (* C_READ_MIF = "0" *) (* C_REG_LAST_BIT = "1" *) 
(* C_SHIFT_TYPE = "0" *) (* C_SINIT_VAL = "000000000" *) (* C_SYNC_ENABLE = "0" *) 
(* C_SYNC_PRIORITY = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "9" *) 
(* C_XDEVICEFAMILY = "kintexu" *) (* ORIG_REF_NAME = "c_shift_ram_v12_0_10" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_ddr2wave_1_ddly_c_shift_ram_v12_0_10
   (A,
    D,
    CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    Q);
  input [3:0]A;
  input [8:0]D;
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  output [8:0]Q;

  wire CE;
  wire CLK;
  wire [8:0]D;
  wire [8:0]Q;

  (* c_addr_width = "4" *) 
  (* c_ainit_val = "000000000" *) 
  (* c_default_data = "000000000" *) 
  (* c_depth = "32" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "0" *) 
  (* c_has_ce = "1" *) 
  (* c_has_sclr = "0" *) 
  (* c_has_sinit = "0" *) 
  (* c_has_sset = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "0" *) 
  (* c_sinit_val = "000000000" *) 
  (* c_sync_enable = "0" *) 
  (* c_sync_priority = "1" *) 
  (* c_verbosity = "0" *) 
  (* c_width = "9" *) 
  (* c_xdevicefamily = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_ddr2wave_1_ddly_c_shift_ram_v12_0_10_viv i_synth
       (.A({1'b0,1'b0,1'b0,1'b0}),
        .CE(CE),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
of6EBD3LINr6babdn6nrOIb1AsEkPd7G2xyAmRRNAW/kOl3oaiz8iaULce6bDa5SQjkJPIaQXORu
rA/HRghWjQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
UiSveIrFN3XAU/XkbBkVqCHAe1Y8IfHlqrt1hlh346/hefiqfZ5rkZNZhu085WMw1zS47/13NO2U
IwPeYa2WCydHQxqt9PGygbmepZcU/7MwkjxkvhbcakvH3A3RrA6Gnh5K3v+/dei39oQXn2Yf9CXK
IIR/PieIVZ3eprwvjhw=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
ayFi19EXsqIAV2NpuGU52JFSiOqKl1DdqYsKMX37oNaWQBp+XhZ4bdTWbpIjyl+nelyDPoK2xxQw
OVTJxJR3x0fBorId0jtI4UdxdGxSEGBx1eg6mwaxEtASxDY8AONnGRTUUfwmfuPeoQxnhjwVnpsx
JWEXyl6krJktVlxTp7k=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Vo8VffvuskbdOx6tcz3JH03fcIQMUd5iBywDqmpihLHgoPBxu/djwE2Wu7kiR88PWJaNEj7ohFZv
zvUWKDPYVlovhQo7qBUK/DuG3Pg5B2RF5Q+SWdSXKS6rhnv8wchvSPISTy1Evh4Bl+BNF+2pJpjR
un6ScX9SLQdNmBTEpFPNGZVOs/DcbJK9DBXmPSTiyHHHbfXDpfaSWm+AiLVvTRfnuAXBv/7M/M02
WIZOymomjNkDJHycP/mWLeylLBkXxUO4SkvqmQQQVgx/T8sR3FCvTDwIPiMSgDKTQVQ03RIOeFxL
orSDcWDEdOOBItv4QWWm/SrWqXlHBKJCqtkjsg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
dq24mOrMj/1+5KeOJE84gP132kHy6UPWybkSrbE9jHRcQp+IWOSBgq6NFm15WNlQnrb9YRfnt75c
zPambbvh0gbhd663kLBqZtLr91IPCeVzLtiWUOBUjeSiIGUShKXR5psnKcLJzm/AlPcMuOOdAknb
qVMLbe65us8/eQ4YZvUkIQs1QQhXhBSeCKWEn+VX1I38VPPhmXaFAUr7wZ6LD+EQr7+ACsRqe4+e
KI/X+hNLEXiVP17eI6RXbvPdi6TPs/0KLYMxslkoJrxEqgC3HvQWBbIq9MjMJBvXrwajVLOcJeln
nti1B67c0vxMUqU5FFz+v43g55s+dUr1brZ+ng==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TmPPpQCnuHbpxwBtCVk229BjMiZB3o4JVmGA/AUzXfnf9eWjxDgoe99eRhNmCq+BLqtTx4PY0uC+
vnZz9Bm5W1Aip5MI6eFxOTsVZpAfzZj5GvUQXSan7jLZ7Nwr08FXPyZMi8aGJLa6EMpWHHSJGLZt
lM98SyX7y7e85kLBgh2KUdvGEL1FmKql4ryIbGABoVQw5fHgbp0Dl5d3GHGzIrDU80Isu9PmWK5O
FInWf8rU3J8RUVJbERhc68QqVlQC7ljJGHdyCVgOwJV4E8gRpvK1g7r5Ha61tO63Yf5Juk2wbFUm
BCCxeCAZSeoi6LsVj2ymtwxA/QHHUaPukwBEUw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
jyfnEfVrP6dhlvrEQOKOFrDwvgKRzqH76XgAf9peZepMoy7H4Yza5jwWUZOA9KUZqXQiBmIf6nJX
oxzf6PcoP/1eNt/QrwqTTNy958HiPGdnhpe9G/bAbfi1qETR5VIGv29nkpp827ZrdmUO1vU9rKyv
7/H4M5/K8Ejqsrz7qNNqzmq8dy1+PlV2PC61KyT6f0198bwBcD5UxkIVxjRIz0wc45As+JTfOav1
VCkKBJv++DCWDBDfPqU2T6gShZoUcZIlY+AGBoCZerO/MA7eQP0hgs/5CbqrWXwV3UXESFCOky35
ZnU3hGM3p7Ask52tm5RRaQ+N4NVtRFBDYVK6sw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
Y7wSUEhKsF5tI4M/IMu74xH34zrCe6ICmo6egimPESMlVM6FA9q3R7tYIAkHnlkrGyAgA/NZlVni
uRJzT2UaYBL7yXT4r281X8+p+Zfl3xXQ0pKj1tv88FpXrj/GsChVF+FJZ46jbssgcwuxxvp/0gfJ
//ufU6Tc74uIaDuPPS9q1ojEDj+IQJ5/XsPY+tmG6San+AAvf2ctcy9MdNj3XaBCFiPrA4tK+UOV
hLJ/yiSBTpeZ8Sdxd3gihKYSbL7RBL4s5y57EcJAAzzzpfW8/RTwZ0wofqz+3g5QvUOgDbS3Pmbs
FK0d/6f+bHqldDUz7jZif3LVxFdMzR2U7KknaQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 12080)
`pragma protect data_block
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
`pragma protect end_protected
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
