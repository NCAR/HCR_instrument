// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Wed Dec 28 22:47:55 2016
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2016.3/pentek/ip/px_axis_fdecfir32_1/px_axis_fdecfir32_1.srcs/sources_1/ip/px_axis_fdecfir32_sr16/px_axis_fdecfir32_sr16_sim_netlist.v
// Design      : px_axis_fdecfir32_sr16
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_fdecfir32_sr16,c_shift_ram_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_shift_ram_v12_0_10,Vivado 2016.3" *) 
(* NotValidForBitStream *)
module px_axis_fdecfir32_sr16
   (A,
    D,
    CLK,
    CE,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [4:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) input [15:0]D;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) output [15:0]Q;

  wire [4:0]A;
  wire CE;
  wire CLK;
  wire [15:0]D;
  wire [15:0]Q;

  (* C_AINIT_VAL = "0000000000000000" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_SINIT_VAL = "0000000000000000" *) 
  (* C_SYNC_ENABLE = "0" *) 
  (* C_SYNC_PRIORITY = "1" *) 
  (* C_WIDTH = "16" *) 
  (* c_addr_width = "5" *) 
  (* c_default_data = "0000000000000000" *) 
  (* c_depth = "32" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "1" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "1" *) 
  (* c_verbosity = "0" *) 
  (* c_xdevicefamily = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_fdecfir32_sr16_c_shift_ram_v12_0_10 U0
       (.A(A),
        .CE(CE),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADDR_WIDTH = "5" *) (* C_AINIT_VAL = "0000000000000000" *) (* C_DEFAULT_DATA = "0000000000000000" *) 
(* C_DEPTH = "32" *) (* C_ELABORATION_DIR = "./" *) (* C_HAS_A = "1" *) 
(* C_HAS_CE = "1" *) (* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_MEM_INIT_FILE = "no_coe_file_loaded" *) (* C_OPT_GOAL = "0" *) 
(* C_PARSER_TYPE = "0" *) (* C_READ_MIF = "0" *) (* C_REG_LAST_BIT = "1" *) 
(* C_SHIFT_TYPE = "1" *) (* C_SINIT_VAL = "0000000000000000" *) (* C_SYNC_ENABLE = "0" *) 
(* C_SYNC_PRIORITY = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "16" *) 
(* C_XDEVICEFAMILY = "kintexu" *) (* ORIG_REF_NAME = "c_shift_ram_v12_0_10" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_fdecfir32_sr16_c_shift_ram_v12_0_10
   (A,
    D,
    CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    Q);
  input [4:0]A;
  input [15:0]D;
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  output [15:0]Q;

  wire [4:0]A;
  wire CE;
  wire CLK;
  wire [15:0]D;
  wire [15:0]Q;

  (* C_AINIT_VAL = "0000000000000000" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_SINIT_VAL = "0000000000000000" *) 
  (* C_SYNC_ENABLE = "0" *) 
  (* C_SYNC_PRIORITY = "1" *) 
  (* C_WIDTH = "16" *) 
  (* c_addr_width = "5" *) 
  (* c_default_data = "0000000000000000" *) 
  (* c_depth = "32" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "1" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "1" *) 
  (* c_verbosity = "0" *) 
  (* c_xdevicefamily = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_fdecfir32_sr16_c_shift_ram_v12_0_10_viv i_synth
       (.A(A),
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
QhSehXUyDurw7ywCoxZaSldQS2za91f9/wgwqih/MLPlu6Je1FOa24AeGYn1f/7NnJAEj3xGkOZT
4ZBBSyWo5g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
ePcQNXYbvz0PkEWzEW14LYoHrV9+Xqi0EP19Y3Ho4xtge1MYNRoNdRWZhY4PuOybTXw4h4QWxuTN
JwfYfNl6dzM7q1JWWH96cfygwFgUZ/pSJLQJ7gus8cQi5INaQ2Z3jLEydep5ee/rGzjz6lKtma+V
w7D4vl5TlNz2UpE77uQ=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
l/9RsfmjItJCDmDrapIifsZAyHbbDmaou/OSfNqFBxp4TMdgrI+ga/eE5eXnvSG3VDo3iQMreC37
/PXdJPI/7RMpuOkSsG9iyuxKn+kWv1LJWKQzi3Yl/0/JWENDV1GOiuKhi2iTkXEisrxlpyp278DY
LC40ixpjEaGpnACQ8wQ=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Led9GJU3esZ32V/vmLYB9/YRd5J1J4LAr/3+W1uQNOYosjyxlv0aMsNDd4K2YnkYb2vkBpLQiZPP
wmE3RzOfIZDThkpi7jHvQjQs1y2BHVmlrrGUC5vYnrY8wukIQldEcmCIbopelmSl8Xed2so6HnuT
B4sL56XHQTqlm1JwfuGDYK1uILoUoMSkU7gJJHKIGe6h/iIePbYanHh5w3aSWtX7JZZf7/2qq6np
hGljC/UsuVkv9wu4Ibk/FdJLZLfqfGyFJjlKoeTfHDKDzq2RYmBPMpdG/AQLz3yZ8lUCkegbPn0N
pyjmqSpAz6iXkDWOaE0ZOAJuA6ywL17jscSrKg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QINgZBsr2Mwet1cQCg4HjNLdDGkH6rdOk+I1T/lxnhtsAOHp7a5EO9EAYCa77tYZsc/YfnA7eW0A
MJdTtJ3yEcBG2tyRfBONW8WNR3XYJbnHKxmH79XvGgUy43yU+5Lrsp3HK6Jn9tUGasB87qit+WZT
ILJgdTkDRWg5RJbAlFMHBUh4R+qSFnH7bsw4PGG9xvSvx8Hx5AbdKX+Z1/7X1rnLVkFjXl9WhKhm
bjqMA/9ItQ67vc12+L1TdVry/JrTCYr2DOC2MoVp57LbK+xecjxoIt6J5f7caaH5QFt2WeVQKsC3
UHYaC5KLY+yezHeODibzEZq5KPNuTUNqS2Ckvg==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Bw6iPTlzMKeyGEG//+fxXTKB4BlemBAuGitIoX566KRcK9Ip5aKxiMUBEiMEILBnvb3Z+UpaQt8T
+fno/Ny6rB0cGXMuBij7CbfVFqvEeJhU9IeVzaDtXRjW6kTr1eUQ6tyUg0COx7yD75AyRxpiPoWK
eAWvPbr+qWtkm8AZ4XQe7zmDyNRYV+RmRaF6Turc7gMGGffiS+XKN/kZAaG4gSLIQGRCAEF1XTsy
YLtdhL3aP5aGtr8+5wcZCmkP/oHDR00sLOKbscknggg3gXeMmZK1ietdvnVVSVc6mBeMoS+xap7p
NhZnQZ7pCYXG3HTWCxSodTE0AwRlmx3ujmwbJg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
PW1ITQlGGYuLlIhb6djZa9vKFzTHaHeIMzbOHSm1pdoMQzDk2vFrPK6PdV2RRnJPhrqcnSEH1Tyb
8UXmyGL7cGboPpLHYR9dvIdBdAHhlAGoC18iGPa850oD2TBZub8fW3/pL1OLXtV6UH6MYSpAnBK+
aeZmLf56ZErMe4YXEFiBZygeJyG7cqfBOQlG/X/J1ooJ/fp6oTTngBzwRWqO1zq1YHlvny1S98uj
vwnmwdFmz44i0JotGERVFXf1I9HGPKf6K0+/dOKndvj7oogo2hg+3s3l7DeIV9GYTBemNka4PYVs
TG2TXBNOEf9sgeWNC8EO6y60ogB+IRTVwwtGSg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
TSnk0dc/JL3LR5ucs39IH7CYRblKzuWDKPh2S7fK5JxbKkD8wGWxa+XFcKJBZY3Jr33FgAIE2VsH
awpBKwbc3i8ISf+AQSXayxH7Oz6i0I92XhUM9dGQMJRTAcNxDq4U8SF1PXTP42jItTFI/nj22ysW
rhSvbZv3iU0AN/X4mgPZEKw9PYQznVEVesmSZBx5EasLirrh54AwBgdkEfh2pnqw28pTpfj5vAPC
1U6oaSnq0gDw7VyUqlJz1wD2a3G6bSqSC9x2pYzIgSTMrgY2BuM1JtTGaNnSnMVEeR6j0DqID2tz
rR3vKJuI5dsD0XTMM6eHtB4AHOHLpRyMopdWFA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21264)
`pragma protect data_block
DuQD7Wl2ztlwL82hFbEF5IYP1e3QRmvk2lPSseceVV6fB4jdHSamHR1MHyVMyFyKT52VvVlA4FT3
7TZGYLQOEa7xP7BH/wBZi6vBu9xN6nafT1+00jaigy0cWsHC6sHbdgYQSWs+aYo8CDrNi6sh+xJi
iMuSrZi6RE93E048UbWTvHOz+0uGaEQ7XfgK6uC+W6JA3xXYKIr8zhadD02tMmTd//QWyNYgRVPF
VNW9SdYG9uoM4KeqRNXqYiBdAOgpcJSvLNp3kqzMy5YbpqOZIplQTKItM0J0s/mE1AII1RlqS+Cl
68n+J/B9Onsr9my5xpIlhOP+BYFOGo1//TDgT1XynK8PPwP3RqH4WtiT7NW5sZWnKvQ7wCDeFUnZ
NzBx/MZdkhQqdfd9wNqHI3BfNOmRs+LTwPaEtRe4EgpsJtZbsiyLC6WqyAlomYWOBEMMGv9X5de+
CBqYodFbEZfKvD6hsg+/l1/gWFp7vVYj4mjy1TrHOnMYJTPXL8fzqll5n39JXQd+LUOeZSq//V5R
m5Ged3rhlCmVvd5gx6GheTy+/kAnDs3utHeGk3IcB64JLPknZBFQ9eBFC97icGNQpz6t+3c63vP6
IkhZxugA3zl0Tfn75zd3DDVhAe8hfjkboZMnMWDUiGIKHreWY+ols6K0NVhhWLzJXhpOxKNcpXWj
EzIJZBqP8mL5BMUaDXa3Qp0q6Kx7Yv/K+uRw76+EYFWu5wnWSxwgEaCtMOm5W25kEVsRUgNSaxIS
2ZIh+/5125aN0WvNeKuJNuvs52zgi6kfVZLpVVjO6AwyaN8EC7MLk/OPjXXUB3AiQ8rdozbI8PZF
wf4XGxZdXdLvPW9LQaMBRgDjNns5pyJL6xy7eY8JPxTkVneAJI46IQCJnY+5YfRciLkpjGIB/cfm
j6ar7zdQtCkRjBvIhk62mZZ2RjwVVqDP3nCB9WBZQivOMPNeMafgwg0dPyo1mTeHuKZqAa1VdFXK
+N5hXkewnTcxRSlSdbIIOPPoznC6M3LtQaxdf0ge5oqzVAs9VDiY64J5vXtuBM3SvUI2GAajoZ2T
B9ZZcDu9+/rzvyKDbFKcuUi7jzdOBawbG6CEoAoeTTPgFBX0igTTMB94ihjGs1WXQFRR/iUNWe7D
LySmU1VuZDKg/dywl1FQm5pv6PfzXpiFymDmBdQfQu/8/1/mUV/dIyd17sxRqa6uYd/ZAmhUU7/v
VgHXLgdl0Vi683Bg2HYXQy5YrVBgWk23j1Qn8q1BvgZrYc8TKLsEVi9Q+NNDyip5qUIBzONXVj8G
scKusY8q1MUcPROIbThgkkuzmGSS7svH91U2JUupvJi/Cnh1/5ykkq9hltEJGY4623yi9zMHCgiI
vRajLtuwcrrUbM6V7/P5QeU9tx4sui7jNdNMNHE2vtKCun9eGpcDsgRRxo9VPedxnFQhbQyNAaxe
+4vBXNNi2ghZ8eY+AglQnNRcWNaAQTfQKCCVGhPG0nj76gG82joqdNNc493ErhFLdUU12rClbAYa
s6Q7wY1dpKMbqGylrSTQkQfAXcIA1saTDYskEWHQFFut2LEcKsIE+uhUnGcw0joCcgBd/Vrx0R28
l0pKQKhmmRsf3iAiUeWb87vOteIWPMweQTvu5iaS768ktsqd/rKOl4xAlYNsQUldU+CIml3QWFdL
cqsyneGUROQsMTAEUNXkj+bSHIRZhevPcqIH82Z11YX+satLzpUwFMRuj9dwbxIGLdGhje0lrkhh
GM2E4GHuWR/WxN6O5XXSqmuUsXGKx6kfe/RnbKZAYHLtweQUgXjlX4zCjawYyM7//JFgHvEGVDQa
+F2s5xEKuADIPNe/Cxa6xoz+l19r9nucRbHZ+8p6gdmp0226XRlDgEdKea00Au8T2RUr5BRJLMs9
rYGB2dJGbzOVXvSBvm6wvKp56qlSMVkJoMDvz/qoddI1qNEeMxYyAoPnuEJ838JwKju2Rvcar62b
dHneGEC+bjcmKWnnI3zrzuAFaqXGo07OdEjy6PtMv498aWdTxJ/pjSXHSO/KgOHisJ6QUYWjEIsd
kqcXjB2qkcg+QdSQzQ7dPLFHG0IkfUYP4pGUazb0Ntmm1Gc7CtfsHloPvlSUN7bLNLR1fc47aKMI
vbaOienYqrm/geatZVKapebhv4xfSY+mATU8WxhLEhC6mqOCGWsJR1mmtR3a3VOJut7V7YKmwD35
HPVRUaVajLgHnFlpx5vN7af7stSodMY08Z+nxsDJxpk7aLTfeHceNrdy+jPmx5ji9pb+b0CJKnDl
YQk59TA2nVA14vd2KTwNKbxtua5DoaKBb1671ezocYz3Ga7eQ4HAybSgQ5/7UkYjhoEJWCmkvJbC
clveZbUjFzOGPE3eynL73LVv87f/RKEpwcZ8FeyhCwHGhi3/exefF95tvERyHmhdsDi7PGgr7+Aw
RVDsF+y1rCbJawEJOLWOQlZ3zU3+4nzsD8ggpA9OOB0dVABcioGIWq7DtRcLpec8LyR0FHu9tU5s
Il2UoiZ7IIZDG/J23fmipXcG9puKrDkNQrFooMWp/0Z/MY2RRqntJ74KVOEPcbMfWGEV7yz4SvTj
IgNEUd80cWE5p+8cZnCInMVSCgKoXn9sCTmLg1Ha39EYC01jHycFj10IFtGHH8K5jwSJjaYwG7lY
n1wcRKzpP5BcBNGQ18oX/T7EqBSuFJe0geKL+pnsqe+3q0vgQ0Tmuto8BRAVGLP6r8QlYQVXS6MP
J7qZcd61Kx/Jo2PZsUvfGuhkk/Ug/2iLpvQTdayKJiogSIsbn+MiyxIXvhyYViFMEtgmBSH49cB+
aCE+iYqf807A91zylKQN4Y4iviXzqgZPx89O3KEIQGfQO1xF43EmAh+YZeeQiWTIarjRliDwlvlr
81e9O20MLT7zY4FCfkkRK1BS/d3F4hm4+ixiPYJ9tzwUxqCLhql9OgI494DMs7w2z0L3PZCAz7WK
fKcor2VRB3eFk9R04B0pj19Aqv5G1G3WDckgw9+jUtejpLGnY0WK4uV9Yv3dBVfdyG7Um99T/Ina
ZBNugyXzcryt+lfI/lwXQroQU61yrQvS4zV2bbdvTrl6DIzrfQqZBURXVulCiaxlMODqdb8abW3h
JcTNtGYl0QO4X8diBm9LR90C2AsXhgMU6xqw6TpsExvDtrChQmiLwoZvim4yGx2g/Lm2HQBH3+xq
Kb+BXrZR3+NgjJIiqHriX2QUa2Tqh1J3sBKLle2QMvH4Tp7X/sU1N1/OlXLYWLSZHhqN1rfmynqj
3ViA0GaPZPvz+EMbYzlPAbYF3iLNZuVQ6Ds+AzFUkbDzD3SpxgD24H8vJ93c6M8gzvgTg0JbYwxn
VIJoEaCVwtCNZPoeUTF4GtZfwjckSopXhHVtoQQAQCIueQSgDXqiQnijQYQ8NJYPLAz+XDq7XvYH
DgXHy6wKN84hP7q1eTooKeWdHXbtrD8Ip9CFtrZwXKFZAy/gNHqTUP4IA5e//+55IMa+ujOLOeiw
/s0AJE3w27N0APD2JXXncURRcRbPS7Nw/OoFLqVO96Z7POd7OL9HN3Q4GyHjaffuFuAIGDPVyhdJ
zabMa/hTeA4he8yi8lDQfuRjLlDpEyRdOmt65HzWcbJd7kmxVxXj/EC3Ny1kign/S5cROYou1kqO
1+S4EG2B+p6Vsw5oQW4TeqgVKO/HaMmaYftQiz3OoIiINJkgFjoIpS62tYysW7rs+6C0XQdpyVhY
BUczrfJIHoALwlMu6e5BJFH0e58ifiOHS1ACicOsZXZlfztCq1NNfSUZIIEwhjBth+Nz6aG5EpoB
SxAWPhYlz5tIzwCALoIVxNLOCT8QjchZNhE1a9CgcLFuDjljKGe4K7J8/fWkgOLoo4jsqAT1NLh8
u54QY3xbfBL5wj9TLVuDTMUvJ8i9HkCRrF5DWumZgzvN5nQ6F58DJMp1utGeYv5GyIH11v4Rw5yo
fBJmf2KYZeEDxX27jQ0pPWda5fEgnyiYtN040EiF/1h1s9jtZ+n4vo9lgvMG4RE66a1ItQTjtrIp
OulYc89UNX666S6eziKAKHtJLx8vM2GYfEmeesm4p6J2sjdVoxHc75YXJbNPi4y/2jo91+WthNs6
stND5QdOrrMN6dkswR8hq/c4AvQtYPFw8Z4PlsMI3cxGm46lFFhT5Z5PlEChPz9geTXNiRDcBGND
EclhyQY9pzkwT88jKBcWqmb9pXBYtnFAufXtWcYIjVLP4VFKvQbGw8MORU2oDKiekYdHT/mvjaOp
GnyY87CMpnyAkDQZQ5g6eOQMTageujMznr/myBCn7qHvqFJ0yxPUZ6smpdBB/aVAAuqyVz2iKI23
brbY3zOwnI0iCF/Ckt2qrVWJNA8KfGryuojBoM6Zuo8YmzmRaGyMFws+qQ5Fbz02YV/l/hahkbLN
j8XCvFVrevWqS/+6Im5P56nxf6QmSQNg90db3LoQV06hE+yKEagJaU9V9fPX3AAFBtCpViJh1bNb
NG4BNigYKFYFoL/scfvUJIoY/lhvs+wOyITHlye+fXBO5bu8+ZHIaCoJwbrgWx/i5BS0IxrXlrbH
dPVVioqJZYNVNYKEztC++49b3dXWzXT4GtKr4F+2cnK9la+6T0oKTL/hHcG9gypG+RWwAlDmZ9ol
g08/rttjVhpstlEDo9099yIuF3F52sCiAd47O7+jwdgUoZ2EViA02Cb5REmkPDL+gjXj1Do+m8+w
dWsDLDvtEtX3K8pd0RKV2vam9QArsf7w5R/+21WlK+MbEPoAdgU1GITakopRknleFxv7fW4kaYOA
ZjNHk4mCv9FrYNiZH9am6IjWmX5wiW2ZcSZ5bxxDaoKNyF1jlKkTiX+5UVFNua8KVbXrKiZgVYX3
uLwtMsWANiVK1k3vSH5oP3Qe3w4qPXYrhx0DKgd54D0mum7VzTMSqIfrQV8ROFpaFZ7Tl9OsRiiH
Qj/pBCWhL8HVXNFAtsbhJxs/fQSmY2Wr8N1GCjc1ePq9jiaACZeOJ71aP2rDLt3k/OYsu90ggi4H
tknF8KFBZgVK+sMvO2rQTocigkYkOYyKSZjdgxEyhmZ48YBpsy1oVO1jasCMAV1zc3rSEOTKBlE+
Nl9S86F9dMhr1Cjbfi2RI7g1SyvCL3B4uLRTNv+3XcfYrYk5BjA9l9gK5Ae+6mPBKt75LKlaBL4k
E1RIIgfzK9YwBrjQbs2uLK4Xajih6cbofYmjHPKhWgxMNd4Ug6kUuZNOTF5I9wiXkqNRJd2JRkz6
levIRHRnoJzc/rwktbYumABEZkE9EnMNoS9UlG2dc0irRhgf+NQm97EYo5bdkezsWbj5fUWKlDUp
CKU63Evw1tfbKG6FNDSn3QfLSblLm1Kfq0Q8JbNYmUb4KrBWNlOnYcWFprjLUw+gFRfiJkbmRT87
Ilq9xV7eW0gjcU29PlBlpACDQckXO3THS2gIYvClWpNQd7Sndo86rga3jufJjY3FXh0aYOWPzUrk
Fya1ewOz19KM3aCp3UUkXJfQtZcrJKDPKHdtYfeC5lXkIvjxh8xbfaKT1+0UAzsUra55ZJHV4I02
Yed3uehnv8H67u+WXd8+iEqGJ4ObrqWCiJnkXCzdsXhmf4LD9XNYbjGtFu7oAbAmhV4RZOU0mESd
6sRu11fA3rAey4wkIzd5jlwxuh/WQVGQCLN31IYP7C4jTGcbCBWXBRdZSA7Sg2+eloPwCivh+NFU
TnlERyHk01rE7NM57+zx6bGsRH0t8yxtsRsHSCMyylUusc/L0a+UjWF9wn2DOwDoaajUG0rzZmTH
ejE/Y7wXYDfdozGf2lQCB2EAwcyuH5NMKPxSy+XmF3GCjLWnTOsmLAUEwmjfw2boteInmXvAFexL
tM5Wlsn8viCrWvsS/HV9jaZa5m/s8qo9AnwuMhdBc0qHh+9+VmO1HrjnQRKjiNBKb8QbGUNYh8Tx
Lk5JvDEtroCeCRkbyer87FLPM+GxoqqdFBH2wecjJvXteHmuGbzNovV1EqrcX8ZhuEk+03gd/3X7
V/iFmvCm2/G7mBhiAbB5mnbydTqijR+ULBxsj4JuiD9WNAmmJl+Cp4GrSw2wggZvmSyEh70sZXfN
ht/DhefjULAWSFCgWZko/DcIczffWHHoOg6mP8+SByN/iTPE2VI9dhyDOCsjx/JS09sJoBiem40M
3Qth13wFePzOkMqe6gHCM//dxhOBTjVyhg/aX4YT0zzWEwNDEs1kRc15RuUwF5hcVt0qawcoK+W9
ehroGDIT0P/SktWDs/wZ8YP/WFlRyN1Tfbx7/yjyTJolhwlf6lzHjsprnhEzK5cVZCQILYv7srn8
EllgQuZP/NYgxVyPY5tXLNrghkuL2QP4/GULtLto0CykRPdEebDtc/iUw1KDj3AQkRuciHx0/wee
ZggNCvmBUdfJODEd8xY1PqMe8J3pvTH5ST3u8OdUeEdOPmEPyKhDA+Pz784FAAwR29yLvMFbvswo
uJFfOtvejA1UPqlsjqO2PCJ46FUTmxpVZVMI70c6oZciQ2PlRbKnxBG+EbT26pRHKyX0HKseNygm
jn+pX3as6fmc4lWaNfi5OUwon0Y/+ZX1qDjfGCwDXF5G3jiOn6YcaKgSQsWg2r8qckS6dulfrSE1
S8v0WRKSSd2ezRwvMZeMTl06lpaqbnidW7kl7O8TKfartXcOpBNQbFdyr0KKxetZ3KbI2oqnZEjI
L/sV5SpfknMHfxxMz+8CCTSxEDiQPMZboQYvOgy9SBF2mGWcBRqxJavq2EIJ7aqeG3zvf4ONmq/j
swRVb4vkpiobrweoN3YK5pzlNJN5PD31vowQepsQxd6rrmm9tHB5OqGYDLz9B3g09Spn8SL2nYFR
1ClBABZPxtAwUk2OGmjM72b1/g/4zTnnDaWa4pEyISyo6/RR1cYXO6HAfjndMBNbdOQs6NcSHVOW
lNglQNysIuQnuw3zCZR6cu+hvtL1iTRURjlTNJWyPJDmfp54HmvKf06R4+zlrkTETkVbE8Zh1F2Z
h6s8sjjMZ3JC3I6SKFVovtLoKU48xaT2DIYk5qbM18E1N2xACmJos63Q//msd5x/T+eSQHhMR01o
ofCnWmMIh/iS+/tBGwnmHjaJOFi/FN0UerGE03NNSzhPozCddFjfpSdEhhSJdDudNX2gBiyRKCOk
7WyJEe5HwfMC4zyKj78ryHqxcdO7SCRzyZhbFUSCiYe4bjYVbPJnVKpxkEyVcsSatjdKE8pAJxFg
0G7Lqwx09jJ78NplVD+kPZ84bNBzN2TIG32PlxGEQg6ZePIdCzWP6WlY53CH0g9nCEk7B/82Bqt+
Ly5f4iyREAs1ptrO8Zc1I69vEAVoQ2jwXvV/q2IBMFfaq3k7GYPmE5okckucn0zlf0TNxqeHZBtv
j2fWJYO6/k0NscBs9KYzMG40QkkCaabKJq77k8D3kdxFB0F/cGU7Q0z9icCyrN4pPHejSxClmsfw
2qcak9QMD56p3WiH2gHHKeKkMQVkWB5mzSbdpI9v45kTO2uTSdlxhjr35Pu/GhjrGUb77kHPAL09
evR3AAg3CVh8I4+Yag3cvjjDYxyultGxwoAvekCj7HZS67aUjbUujvB1NEMo+/apC2+8Qp8L1hdY
FPt0DZxuZIyvXBn28YTBcbQDApqCVTnPBoxGFRR7N10L/nuWbS3L4gnGDzzA1A1b8Cdwoo30oZFJ
vpuotBI8ttPRDs7gMXJOm9YCfDIfJG49uzgxsF2QwABfCnCNnn1EXtOm5wKZPTUaSASS9iqHuSK3
JBNW/PKZ+o4/X6Ca/zviLW2N0smEZbBq0FRpyKhIq1wTNoMyVRmLhX2ztUzmazSIIDdJR2NbMnBk
7VhTTUHE6d1NUX84wqZdda2yghOHOZPUBNmuRJpCBsB9vrz3p8SrvIjtqNvAv3Npg76Aucf9J3A1
CWgz7gWPfkIXn5aF4LLt9ik5h2WlqcVWZhl2EULveIC5MCm7NLVnilG6v7HKNF/d6OHaTpHw+1I2
DhSxXbfwKDUkEEEtDfAiHaqScbqrmf8YqottvwCindAgy5UemRModOxh3aQFOWXPBGQLnPIT6uBB
wIpA/qFNMPOFYtugJbRlRcJe3gL+X90p5235iTkUgkOJqvI8usdkqvdEi2eH4J5LpPzHVPdWqBwY
izd3zOanS977ZgHQv83xUMN6tX4egAL0h6ckyVtWOIvZ5cJydafNzbui7vtN+GOeIweSkCQzVMyQ
lwSsIBI2yTlyDU8PlwUSc94Fh+K6EYWVncPuVBQSFe16a5uKKxi4R2phGHDpWthedz+R9owAoO8U
JUmUWO++PvP7a15IN+tzAo7gpGEsW8EI4z6lXNgR4kYU8WO4ycXpIIlQGrpxwFPZwBnqXj0LT8MS
m9wHRcuwrY1RBpZySx9/yTuR+JrlGHTM2m6dyOoz4PbEuvr+RJkPg0kvy2pKHq6CWLPZkiMj6e61
1l0MLWE6qO1ATMHxGiid9ZlkM1PTN6WQ/6HZ1LQiHd1nlfREyiHxJ9Eehx/7STqjYaaGj+vDFhfe
JeHx6rRQLmACpLnqaFRFfwN/h1+1RxAkKNGcCiGAmu24HED085xcIJQkTroZccER2Bq8+m7eAl5k
Eyky9kPCXj9Ju3Ebm+muDVX8WSKW/00xCrOTpFsvoIa7xIziFJlTXqHP4GWXZErm2JpbSYUdY5N5
5/H7AIvvCj2BisMnZ8VxlpiMRa/nsb/LI0Twz/fRs5AEkTuvX1VYwY4bswf+FxFX5CiZmoYQfErG
E4tS862wyHGxXF4GunhxmzDd3PSBHd+AaRjh7zKeCam71Z1iBTC1Nl0vlmpL14Pg4nOGwoK8w6RF
oD+ulYkYbwpsA0h5Gz/XIc1hn2mkKOYm8Hn5jAN7usvadposBWrZaXx2ELEMUmGe2Zn8eGDS45nB
2EZL7/6TTugwwLmzkWgScwJjgGsW7CTjcOpCi82qcf0tPakZ7yGT/LRAeXHLelFODW3oaEc8zkS5
c1vMk2ReYv6oCv79qYeHYPc+QayGmQKrGsoVEys2GW17ghlNxgQbWkyriE56od1S7cCokFCG3S5r
yf5f6H1C7bFnvymqYIBr1g/XGkTy7qJbpMM+aKg/vdqb8uf+ua+IpeUFOfR+t+UE2Z2A6ZQ4ctWX
PP2Td28xpKqM4K3VJQVa41i6BI1/dAQVzenlE3OT3BFYtBxRPHpDpYszWWbIjAvijl8eN55wAy6+
nPSztuktX3cNKh/Yo4fYrJn7ip3Eu5iU8DAN0YZOefK6YlRgp85J77IMK9I/LTGrIQPVINZTD6P1
0+00ASSEAWiCltKxSm27DEhNsAC4sPIZMmKGJcjFRcGO9mlRUB/gcKM495RPDUZqZeGlj2ElBcxb
EwoEmn+K8kwP+FAN8qX7+3+Ua92f8/HJVUu+RQu1j7VLNbLSVVuH4vAaixGrU9IbI+t8SbbdvL8Q
t7M199A6eQiLig0HjDyMToxJAGWJ0/cbJYk6TY14ZGBMXxsPUodtHVqTvIaLDl3m7V7XTezXD5m/
ugLEjPpjNkkIrbIN+zMg1AK8s72lg2GVCiHOTRapuCUD5d/+y1rzQhfQbh+gqAh8eFi30jiKbKps
tUydYAMwkpKhnhGEIxYDQLtAAOoc8bMouQUHPgffcIg9FrKrRHabYzWXwYwELvb+ilK3GdE7Ocez
xcMML8HNlmnr8ktlJts9kzIa6tFCmwR37aSY4rEOHSelf7AI/GUpk4KoXv3izU69vhlbMdX3IIci
fDdp2qV2HHsL1i0sw4vglM6AnEgiTMvSa6/rs18zL6krDgsB4rXchAufBXQxAQFKKIx3G2c7v3se
3g8rfLwXmVWfqrWxl9SMjOsArvygvzjSoXoS/oB1KTZPBcXpJlUZcmMw6yJ9zGDg0HkEy82DYfjD
nIPtRdapWbttTG2GU9M0sRUVbuONBFsNIEIV6uSScrpnQe6boQvF12Vx6e7Ca4zNQHD2stc7ycUk
kE1Wk6OALjO1igioWgP5dbcMCyIteGQk9BPSrephISo8w0UNH8Fkd/VzNnxMwfxVLPkhyZjsrPAW
MPB/MyOGoRbB0An+6F43aEQT5VJkTRIHCOhD6ipT9PXJZKyqDPdBvmfS2FBh4XkJkexWklUP39qC
LsG0rPoTKYEUDWND7qqoVl3TG2ahi5ZLdJX6VoVrfZn2QELL8LURtCAu+tXCgtO3LmPvW892sdTV
7fPrCgOiwae/+v6AUR092IeflBY3rCMfrxctOMAAirGZuOmEnOWUOmfHc5EzsRgGJ0swqpgTs0AW
a0qgl+TJdxUjxNE5v1qumoKsLtLOAOB3xgvEBY3TQHYdTVbUoS8Iq9qDUNQSsKtunb+TqZVoqd8f
HfEhq2N0FfaQVG6KL7lDFyUc3IAJYJhSvb8H+ikuQ6I2JsyeYkVnee4xoQjJZLuROrLUrbawPf0r
679J25wohhjktnpxyVUftdYb86Q7erlz6N4OBTcjA5X7kgVE6TXd7mO2RgR2Bkj8dUbIhtE4cIPe
0EVw6eCH9ehws0ydbYKVNWd/1Iol2BOV2IxLpmFS53U8WzXDxcblgRHOeYOIhv0LVS1u4/z6O8C0
rLPLUOe5sFrCFcayqQeArfNDce18E1me1+tVAHgGDbpmci5BFvPOdPwHApBVEc8hyaESoLz7J4mi
lNRUJ4x/p7th6bhVrT90HFYOUwfHePx1E/AG1+4Kwh7oawsA/H5RNCZj+6CUFK95h3X6D2U0/19R
9D5w8V7PGxr1LhfmQEsZpv4M9PesR/i9FpBSAo44B9Stk4Z0uUqqoAgU/Fi2Px31Nf62KuN7uypA
hzzcY9DXc638nzy7fDCDN0tIb37z6b5noloxgpTpR9HX1Bl0qyE0mSUYKeoJlToodtRqYTxK/5lc
lugr91I17mbiEvzizVvCbIn+qZyC4gt6l/yUsFxli2Jw1JUfnkiPw06BDk3josGGkyFq80h6OUwB
2ANlRDWkdZXt9Wv4bSL5DIo/YcEzY5d3UCotfMh2cBwicqmGpr+B2wNToGI0WK7I7sSnzTqHTlT1
hodGWIY3RhzZUxzIdry2kPo6XVl5xiWSEIs5RjQRb0fLxGDPUXNhZt0F80hGQyhJIthedmN7XkqC
c4f4T0BWSGwlNOQbh+OScVJ1JTQUuRgyMBTJHJAAV+AzApNcSAQ1+jKPzBZk8aHpF5lLHkypwaGD
sOncsB/GEuQxhG5ZwJUitm0Vz8BNNASWLyXiewKxGdSOi452uC66R7DinvEVdI17HOj070C3sTbW
kPf7xGHTq3lT0tSbiRO4HXNDazueBAsVh74ezMjysf8E9p21X95mEJGmdZFd+yHtUItopVY9IuTd
pPLEDnpVgJMFV6J6igXd8xsFbIEXlbb+7SnzAv+sqUh5FQ5ionX51/LHizKDrfVTXNuJQyIBjo0k
XgPlJJk0YekeEwWCruOV01JEm0JcYz5S+UihqD/Op4ghqlMaIOmnPwDRs4TcTSeQbFeggMJnYQnW
MPX0wmTTNfOqJuEQ3vZiFfz+0mepzxYVn2JrlQ+TSHgx50u0NSzztf5aqXL+Er8PKyQda35YOCV2
HNENkDcMvwqjnpfZ6zmdjblh9WaOYYlPEKrenIlMzbDj6BbnrZClgmSrF8ZwThjbK2Y32meWp3hE
UhGKSlcBrLsobV8hBe0N/boLSpry70kiBMKtgYkkPTwpYgWr/MZfvfkLA92CzIAmiKkvplPTC9zA
W23SjDOG05HKwHvEdVK0sPee3GhuEHYk/r7jMoTCUUcGtILOhn2W6IXebCMZU4MBI5hcJBZh4R5L
v735T3eO41qnsXiX4eOVTDeVThPdTXkAb4dpZMFhNAfEaeJxO0VmmYfX/EtVl0/ukbxCWPnKJA9G
cYStecgpcs4hvbWvpXKth4/dvu0G7J0UVBO4+4SH2Wxt4m3F2L5Z78zXhvz9E48O35keUttd8Bl4
vX1jW6AT14dpeZShgr16P0CkxlKfzjJzuVWpwL4Z1/FuRzaHCegxb2G8mfTNgIljvVLgMhK6aq81
4ijBEsi2o0ilOHxUUoNwwIA7ndhPX/GOxMUMvWhxLyEZlsV01mkN5lD+kxAJIyOsgVt7JLUwTjwH
md+nNPvIZRbi+OCn7wfpSijZ4sCYodeZ8mN1ogvdIY7zYcIzbXBzH8AwWPfUgy7fR7N6vqD9CVmQ
yl9+VorVhkf07X6m7luX5GPrmkUpZHIHEyR6eSSknQRikB4HkOrYZX2aa5Ut1ulAoMfK1LKB+Dxz
e7WFaM7fGQEdQb3gcqZ2yAkcCRC2HqIuF7NA/iWj+dex4ZKyK8Y3XSOmOAWcwVxAca5FU3lQJ0Wi
autO2S31DXn3rOjTPLU3FBn1a0MBIAw9zE8B2wNt2MjCKQ7O84LcYM0cgID8ILLZUs8amEuGjqMf
vJ3IquWtikNXmg/dabrs4/UEcot5/aPqfnZbTrzXsHZA6f7/UfLJEvXg+DwCLTmXutZ59CpAkyEQ
kRhIdeMAe/ivnuRVQcH687ms3whhGjqfMhf7gddIkj7AI1ASc0EDu4q8nwSRo5fQoE4NqoPJ+FG5
wGNfx1EH/zn2vd/+wAfuEuviOJ7zAKcjY9gVGXZHKlUA1u1vbChiuWL57HI6M19TwdCSnN9HUBZg
PtdVXfRnBXFxH8Jyj6DdqlESBhBV3o1Xv2ed+9ZkqwTzH7HULflTaIPxXn1MfxUU6dJLgZqZHQ0l
6dRRvfZG6sq8d9k/FThn1BCN1zbqk16Nx+K0pMJCf2KkfD6ae76mzkxuhTGzVq0F2gzySyxlL8/X
Kc8UQe8Ql6A7isF5ucdKYSXLLLm7QSJqr5231LD/oykRJm3gQRDSVj3qQ8423/QL7baFfZvc8OAZ
ozjugw9SqExcA7sfUIyrO3J1oVyKtjvYPoeGYTG4yhf812lWJaiDpDWsUhoqTe7cxeAAXSwpr/wV
hmT9mMwO+4DOo3ywJWubfC2lVSMcB/vjt+ncj2AEblb0XQ96AdWe+G+uhdGVx9FuNqFeeErmgmup
zjFR5B1XD4hmtHKTLCMCCFDECSqoA+R4vPtvKaDMGFDtK/rtYYklzQKQNoyIvpKaIW+nrvWkO7eO
9CksxZVks1f60lqA9cVVmX2K2btv5vNNIN7KudYWX/8HaauYjXeC4rZxrYmBLC6o2NalDKYbztRj
SQmeiJeIk02SPr/jBvRBbB77bShCxFZdGoWmQAZmrTvGJIsXdUydaWckLde6Q10VwGY0asvO6+ws
tBudcYE/X7cVaqNSVb6OjBO1I8X+j52ZpvVcoT314o8fB4cRpCPMMh3UXdPsIpaIPkRZ3qZylQs8
sfxQlc3pFIrVVA1tt6vlIz72+3bMy9UbjZPNQpqCnifqY0BfhevM2/noQ3cwAy9kD0fjHhbIto20
A6qM7atPMFvjqx/IvHGQc/RFg8Jh0S8SP/aJ1XqQAbna31sYQNP+6wSV7WxNe3Bv95CLdGWBh7SA
v+VXOTzcK5417bpp1G6ZVLdpiYluvyMpQzPCKwlJarWcXi26e0UVtSNMWTSlCFlPiTuNwUBagelR
XuskkFR9xM+J4cHmPV0wCp66gGIYHMRVuEazJuk4/FeZTDzdsgWHZi2aKRoh6hfkRbuNSNOJcQgb
6rUy6z9q0f/2YWaeDXM7OTQhfRy4V6Vy80nABswcGocVMbX7IhLJ0eAm67ISVpCts4hpXb/IkAuE
EtuvLi1HmpooeX7x9bDwt0zcnWroOi3JTkZNHv2AL9ByHmwOInNJi3T+ryWhVGl84ldjzUdJKXme
eWRTyGprhRCC4Ccso1EfxYS8h1pQbX5HTf2kTxTSdKBQmeYk/ALG+rTOAvwqc/BvdUftG7pANbH5
K/33Iy1T5HPDf3gnU9cUJaN0oD5+NfoDQrfG4cr3HcoFg/2Ds/ePsJt7ke4yuGl3fzEcGZdz0hGt
Dz0+YS3gXcgVK45CBTLzAAIjLF7YXsj3aLvCbz6UloPuEcpN7OP1HjHkEMCysFXrvD7QyU5opdwX
ZTr+ZLRz6TAQW2HZdlxKlXmOakGqdgm+Xz23u6XUHVk69x4Y4GemmL41mr3t1j6MNz0868aN2Lt9
Ikx03ImRTbsEErQ3AU+PMNVSDJl7NMHvW8lN5vniMiuT+AP9DA4i5z3qa+LAJzFoVML7R+GsZJ5T
SxlCWMrzoU1u7YhqAc3fDehcRGPL1cnK6w2qhyFpOrB+UznxveuyUsLoV0Bit3yIwCRuG9wDLv8N
k/eGUWu5kDYMKnNmdeZFvAicFMa67TjRxjBKxuDMsnQtNrwobreYuK8CbGgX8MhGCxjJQTZdDrSC
fbrApU5Zmohen2KDwtWf17bhHg1d043XLWVj9rW8FVvjAaqCN0INLnJB0w/Pogq9ydeUPue/FoKC
CbkX/IOLk1uVrQ48T8EEFo65ytsy9G9BpfxCwnxG3JjADnq1GmC9V64TCTFKHF+rVmrJj5/leZOw
QxfMJHR4kCqLW6ttTUpuOGSbHMNvPFHsVkTJzcbXSzAjlRM8KCn9m+LP4UwJw6qTSaslFxXowNdW
QprGKajoID8IcYbK9BTUxVmGM5zTKKqOvEu7V/HlKilBrfxBqHQXdtwYlYLlQOI6oWj7j2E81gqA
bzOzF9Hx3UUk6cgvY+bjFDoA9phq65ZbAuATpBsclxJ24kMpe3539HisfA1pW/OHfpccP9QpY5SH
RwEGD9K0yOKyA9ns27B31emmARU4VmiNUIEsLCSxR2xSYP0S5itDZw6wNk7dMz4J8mTN+etmYcRX
qWpZdsOfLuvBACBAhU75FRFF7ZxjcntbnKd4V1NeWO3Uo5Q/EcPtwITb6IgTUkGfau47u53Qng35
DgtoTMqbMTv+ehzNn5609W4BtTthiraw+vNT2Nb3WO5BeZSW5fbpvb34fJrju4lzAXjFJkv2ckX9
fviWZSoz1Js5MKzFDd+JMsFzPTLKM1fn5eLI6/C9vcGRAQXogHMYYYsTSRwcqvRZb1uyScHrdt6g
S3NQ57CE7FiTnDpCkbY1T8/MlL7CUI1kPMdfSIxCelcQya64GdfKEvWUj0jfiIBi5dJplwoEZflI
M0+v+tn9kluT3SrPkcBRQ5XDSH5G5XyL65zwYrwxSmgDdgEcX4m0V48ldWPygMoDlOcdZ7p28dUc
QuCJr15sGivmY7Q40YWE4sQnqF+ryT4JaQVIfe/p8/lj23iPJgKf0o8xjo3tjtXFTAhY7tYi3vm1
1ZZJEEa4D8vVN83wWWdY/ngiDPfJaQmL6UmI0PRXBV//Mc0rsJn9eAM82Nh6NqvuQcUAswlVazF6
Jh8nfi6cOeXZIkGuvj5IEydEOeUYq2TIDtr2o6L/X5/ANgtQ9yTPm/ydFvtL6QMgC+FCkIsg4hfr
64v3+EDnhW4g1dMVpoVmg3xLKRxGi3ZWN6gJpcah7SEQ9DpXSHDN2L2Jfo3ClU1Cj0rcSTYTL4ql
rUQuExSSDoFtpCEeESHjKYRNRFMBUfE0FonFWYpb6pr/ZaVT+7GvSkoGK7IpcAAa09scGD0bFYdT
wn+QOdKraukdAlSPfYt/phVK1tTkeTcBUqIVI0xecbAxrJjoaby9oCmEmAMBXTLdOvDmRLVCDwA3
HMSBr2DytlNph1N46osOSswY6fe0FgrmpLI6MqvP0if3JU0wkatjvxo84GCQ0qzgmUposiC4PPND
jGtsw3SrZJkasDwbdgrojtGn9cqM0kvc6f4tPhiMjB4p8bRA9+a0rjL40MnXOV8jjZLPXyTLqU6e
nKHINkz7jRqp/xn1r7rLtUpTf/Df0mspQ9gF/WL27h/9dtMEx5nR4qMh7DjH1ClhivTIcf5Kx4Vj
lV9Vr0696rmMA68rkJd8+ibSGZeBJYD10OqGSgMfA9anj4jr8xVeFRBlGlwD3+bpaJ5blOliEqTO
LQmR3ermk3Nkjb20ouSvJ4CVW1xjCrKgTNvkBV1pQxch6dWvTWLUN6eGY40LNgOb6rwHAcHK4OSi
bENsfgqRX/osR3pOKNlzRSHxVgoYb3bSmZ0LtEcJ8z9z48UAMf5Kt5lXtrhs+TZYjMwyCxq9AnoJ
MgVlNm3/n9rqaA8pd71vUnb6CpAxfFWFsT3KOUyivU30aXUqT5uuwuOs7erzi5o2Wm0/tVqaPsSM
UcQx8AtY60dLt/8X28IBgxKfxZuVs23a7z4ZAj0tcSh/i0AKRS553HCsdYrRA2LvY4AEmHPnmmkc
YiqGR7M88342vw8+nSUW/Yu2zF5uLjB09VCjhqdavpRBhz7V7XIaYvComQ/rwcpxKZA9IOhjHVwi
lHCnnNz5Rab380+IrfDJIEzWjt8IljU60FGWx/h+eNljsICDuVzWtpki0Q8/z/JSK1ggwg/COl5v
KauGkeOPunq+wlUGKZ2v79PLA6ALrPdZXf6Vfd5kH9PfN9f5bW+dApUVOMuqkRjGIUNy/cbh+PIt
vQKBUYWcnPGBWrB8nSU31AdDFCSdv7ym1VwxcKiQYeouR+Qyro6iKZ8qNwigkD/W5DVeBT/j1kVe
hCb6ZoZKkUzHOxLF2fATIHMicSQLxEmXBlle/71/dVuuXgD2KOvK1LXsQYT0hLR9moGzoOFfQE7T
JeBZ4pAr2NnAEy2Nx+yjCPRARU1TX6tYdwVE9hVoGAjiZo/8jTrZN0qVWJEunCxjRaUc8OPQLwod
+sbde40kbRpes7MwcGPjgm4hP59eChQ3sJPOg+UcWzWNLDozm7w+KJFftmMD7VQguj7uolw5MUwq
PZ4AwDCmRb1aHiWS2rmidgjhhTt2tDbv+ekPbdWwsJCr4j7mts9AE6WQsaeVZ3ITuwL5lxtXPftv
g9/VuvIWXz3HlDlcjwvOjhh3jXB8oBeaEnkRHq8QjiiLEM0A2tEexhsreORzEUfSP7FrPInKgwA3
S7kAmc7xTmnjwtezP0dvRHzfpVkOQlY+t2vt9VUAFeItpj7MfYB7YlqTXM1C3atckVmMDvBNboIU
LwH4Q9wpXzIgtwBsgItqXxJvIY8vKyjjA+nlmvP1Vop0F9tS7tsIaTgH/sqdqjQOmV86NnlcuySN
oJM7CvIqL9xz2aulNGkFk9/SguXN4mH8lr9bZUqCm2E/o3iIevVjl0SbilsufnF2zVOiW8Mhdt52
3Pl9OR0xIuNX8nvV0f3ck0hGT7RbqZ3l6QMh61Dfuf1zX6j/EpoOJfOPE9zW7lD7RRiiwncszptT
5QrG93JiSL/nn3SFeWdUul05C6I2kKJuaMlgzLrnXTD+adgg0LzFuuUmKjeyBnDZqc38wQXQV9sE
H9OJMHtWBUKYt98PRWNcJW9+Be+cIWuFnMk+xxiwW2R9JlRKtI/Ic+mdX2Q85HGDmRa1LG/LTX0N
zinDb2chLSWC/NvrR24FLD4X2zw3vpHrru8HxOWiNttgRP871Y97TxELoIIY9icx78dK5zSVc9RT
ZaPhxlFnZHx/a8WV7Icm+Z4JAJ+NLOEEf0Hlr9KbzZbXxII+QNl6P0QEhMukAyMF+hzJnZEL5kBm
6knIXmaT6L6xBbNzQxs49n/EU0pHt0o6aIgq9ywJrIQHFcaoDj6lpFls/FmK8vXH5NYpH8g58bCe
I/XcFOk6AnNCZK9XuuoZ3cUxnIdtOzfVCX0YsaIxVizJY51nmkIHdh6oomdWSmtxXgzHPq92ZPjo
d8cA2LFo+zBvTooia74pCO1heuhQEpdG+m8bJ4HfOsVrjM4qUC58isIYwuImGeB2t5pIurgVjJHq
N/uzZHlQpmYJrsjyTZc6DitFmyywMztZ2f67B1o2birB/Mi73/IFYjyNt3btOIGyWlJGxBEgJ12B
6LxmejxvHudf//iagg5WbB2ecbNVFBrt/ltHSr1DJ8Ddrv9TXbehIrTQJNbNGIvcFF04b32pDXPs
F8JsXiFOacrxubJiYZgoeQGpfldJYifOuRW0a50uDpIScciBExMpugR1po0TymTd+WtFJUcDAzoX
432Aw7mTemePXSVbvrVoQVkRZJBhnh9qc/0yd9Dkx0BArikaknYVMERzahzoWaaIcjzIkAyycBhK
kI7RrgWrcwbeWF8nxF3EJQ5mePmrEeZpG36vZtp1xmMmk26kgEvztBGERLxhzRy0I7YJdkEtV5eM
yAJtKnjwbGlMK77EerZeMqHGN0cxpcdhqjaZ6upo2NGkVGf48ra/ahVE4ufJUm+ajWfLO1DvsNtB
KgfnKFB97vbjSgFyOCPv/wIBtPP1Va0HUhUl6j8NK+WXZDIghD4WmL7RfCFUxeqymmsQniEJN60+
CDAMc+FgBVFJrU0fSQzlrfeWm/+7tX7XJFWq7n5hjoVGwRpa72r/Cl7QiBGKBujWDuY0hxS7CQYM
tLkCE2K6Q3clR9ZLrx1daxiLA1PPXGYuOeWN7k/zLe8Hx4OXds0UZ+Y/NayWl1WPBfCAoLFSncfI
/aKV+gfMCiinzLZyRlLOzhrrQx363tnzdyANxWjX3+tOmBJEiix3aG9Ymc7ddXABDT4VI0JwBt4G
93y5rSuF8q8ovUezU5rb6yvL+ej/nmWNXFM+oIqPJtukAQo8WmU7qDhen5ElXVcod8CrneD0Fufn
ILAB4q/GuVuJbxBjdBsBiv2HhCjmUQHdwxDXy+H8UT3oMJ6/MimtBxKJm0wjElAhYVvCfn0j1EHN
tArlvh8s1NRsAFmJIBVvv3pbCxwVI0crduR3IQmMjNHuwXy8JwMsSa7pq6+oAhbxR6tHpNbGcg9Q
7nzOcIGTsqd0O8DZU3hHchfyJKWb2sh0mQh0ODWsVS/9cm9V5T/ka+LWdfZsTbTByPLmlje4cSBa
DHlRO1sL/XDSNm+tZq6SAPQbuXPJIQSOCReFZ5oFQurqjm/21Hr8fKtQtBAd0APMEwCANGWI5nf6
Cg6Y508bRv4OXSkVyeA0hUFH5g8SbkxIBFx8vjv4sVxn84xfAdIjcWNkrYtDu1DjBgCLi8zWrYZJ
cptoBL3fiRZYFwBCDH8u4TrLMt3TVjb8xgV6oGNdD7oBGcMVHjSaRRSxt0UwQVVSMSNT7AKsm0Yt
iEb5P/UMohZTeTP4rzUqym/i0xMxnwDjVLoIbyb5ksePqRj0gVuyJKNCrUPQSvGLR0OjEEmYg2Oi
PHNHSoP0hjSMZJV1KffyMZfQN6xRK6gxK1tyUMoEH1hSj+TiMg6eePFhOQq+Opw+PEotxSEzEwRc
UNtc9Dg9UUPwBxA3PinWp4lEy7qjOdkzizrMG76CceGUJnKH6Uth2SqitwfCWRZJ+BTE0yZuZuav
wgFEZnelQFCWmJAM63GpaD8PffJ49vMm1ApgniTZiQNXoxM+5CCo46HKI2P5xNpWsyEaPTJRuAFk
m2tHEXjfOWc/4UcGtkzniTu6Nqr1ni6QEqqPSKTOZE/DutMXysJtWZymC8XcJf0Bo8Ti9mynEXmo
Ir7Z3SZBPapVmSU5x6AQmOoKG3ZULdLHkLVwgTR3IVCH2YAvL1t/EGmGR/sGoOzf3pHldGobg02t
q/c4kOQ7nLQ7Yy2nFkAhbsPQWqQKtS8nkDmeQtXxgU9FbVYcss1IUF6jH91b5aMuop1PmnVMbm1p
4yqDQt6PEogcGO6+atlmoM0zvg0s2snQdbhIruB7vQx1AlOOdX1F784YxU7EptywHSM0rbICEoQ1
cq/7fqHn45f03tuH4JAZZAyPgziCtPzu+srIbXdPmME6h0A7oV0SgD/5mTFSMSClY7Svc/8BrVwA
fPHbxpr7NLkiMyJVpafMMpPRZfuYb66t/QrEloeIbgU+l93iKdNuHCwHzAdv0ZCPvMRLK8OssVyA
xvRFuHTdkQSBKgXY0TnsU6IY378MYfq93a/sIiv7z/kvAkgZdDnJVdwnNdKl/sMyHUgwaBlSggcE
FF3joRaIwTVeViVSXPrYIB9WPhYRnKGdss2GMxUKOvvCm9ZTaiWjb2PpnlaY3SraFx1OfLcmcAkq
PbUfspK3cCIBg0g3ukczYqNHGliPzQ8fMQpHP8z0M7gKevNr2ZkpbnX0pMXhMO3oal2hnmMzAMCS
V4+KpAnavX2DCvf7qfD5pBWtK6VWte/2riKAd9L2FOqPHkxtVIdyN8U3apNr9CaIQR2or5mjzcDu
1WEBVFTsfRlO3X9o5wV/0l2h0tG5idg1TgbtyM8opvyjvDe4S90Jov8XtzEFYn0g3vv60mWhp7z3
ZeOk6dveIYViyWhh8JvBaOJ7pMOoWed7qHfs2vKBwZApScy4fUCf8AiSdiFOeQmbwOHq+SEtAkFZ
24ARkp09XQ1bvvM80Zl8S+BKpjHxaaa2fcDUKPlBHLcx+aUgMULLU0KwgUpXctoL54Tjyv5p5wpq
1FkwBqcYVwXdt3QHN5h9O1Quh+wAUG/gqDy0pGoosvdzHjk/HSaRl3o6yED8WT2I2p/vqcS4Ta6A
XkXX1eMQV63+VTl3tKJD54iDEOPHJiVx7tn7kEmCwTwveDgR1NltW1WbelEb2s8LCn/3UGbUKtut
NnD/Zjp/YTpCimyFN1MSRb5NpWkwn6sOTwep/lxQNCdwiOak4J65PgtpUkwkkel4HZAti79Fi+NA
jfILE24HOdyElG4V4svLcP5lvob2uOp5uZ5/ZvFONaGkWehjtPSVAPDNlopig7RgURXVZJqYWUGO
8eUfkVVfoEl3Awz+NBC0lYqgkHgYFLoLmLExbHo8Ta5/+KraYbeCC6QJk1isf/7sGB8qXuM4l4Ue
CV+NTKPigGq8pe7XRRKaDK7Ho0JtfvuOAphgoWoGdQEV/2gI4PTFW4YYgrkOn4T62Pg7gFTVjMSO
FX30Tzle3VaXax9FNcYeFDeUjA9YQjHBcGqrWKvEeHEae5RwMY8IvaQkFsYBgHiv5MAD1V084zZh
5mkDY24/OEoy5E77M6ZDq899seHsR5zQfTUoGx1CpLROExK4b8GOQ37hC/RA4UM9WLee5NxBWlr/
e/izpGzZA7UINg+mJwc0pXd8VeD9yk2+syxc9zK452CnRL8ciL4rd9NaGDK/CNLIgSKXo/keGA2I
GyfJ1qxijkLodDPmDbOAxNVhvBtMwbMbZRcPh8s8u0Yyxr3TyDN7eDKJDK19LIzIsKRwjR3venhb
d9417dDRylxp6266rtrNUNrJkvL+rsd0AaUrlFFyBkD25qJdBn9VioOuFYxzy0PK9cG1XeM97ZMe
5xJUExcZSJ2kbOlm8sndiYHCZD/Oma5CB82cNBSXhxzuyHXibFo++7U8LEXfBLy6KEdkTPonVdF8
S4qF9/Lx4IJTwDBmWg8iT36OFi86JqLgtBG+75aiN0F2/Fu5It8zXDBDmLteWTEchF58Cg2yzlBw
lB9kzA0iDtKpvzYpMBfT0n5il+kVDXj4syRc3Mx47YjDlMiAviDVcc9Yy3g3WNHSPVgbU6jzStz8
v5KcahJ7ImS/+GLxXG0Snrgjw5R3jAlcKUrntTCBhCpGjgN6LfhhY34kq6OmiqYxi+c7jp/PdUhG
IrbTJQ6jL6uZne5XDCe84+uc5Lm8DZ/4WD14dhHw4vcGj0QxmQRDCu+f4w842qJm4zCjRT+5RTsg
3oWM8A5A06e+QZ3IfUXPZpfkoXcUrQ6mJImzNuusgUcEaRZ9jrm8K+/pmER2OwiSfkmvmydR0SWB
t1wwRWf+p2kiAja2T5RbZrvsVGQiSIqgGQMH9U/BzXqs9nW4nj283vgjurdVx4oTc4s8dH53dq0S
h2dwWOALIfpNV0TL4ydGuNvT+k68CEnyj3XPsNtRmNkzCLwyUdtdNW119+xggfGRFrlD2LWUYkBW
MREl10RLQrCjVOFqwWY3Okd9ayp5unluhgm3AnsUoGCyOSzWil+/rVAnAn81Z8qs658fIBbO0OGt
auQvv+Z+0F0GwAjIzD+u6aVaj+Lrfdru9p+BH7Ug+7UdIDFidSzIYSN4Pbg5Lx9oeFKvbeSJ9a7j
296+7aIpXgz78AeNTlpnlwNaMnepcYcaCc6ZWzR1DSAWguCOiK0loLTHakfiPqeaKJg7b8taQTR/
MgIbXMdQQjjTGgR621cjzWwgC2/Gmth6Cbb0QzZ2OttIM1HRWuGhKvYO6/ec25UAxPFkg5u0wzrQ
WIA3C0SdgZK14gMeYTYy3j44WvKoNfb9CtHisVgpTaivfemNgh+Qi6MpZMiW/Pjhc+NeM5YYwBJ3
Bgq0kt00lFKWnVSxAhvgwAJ+DMdBH+/uBzdpg5zSujDtgCmJCZwl4wTC8JfPZK3QxKCuJbG3y8Zh
9v+0SGFiLBqKg8hR6xz+7oHl6AOl5leJy+z9WFtQDqM69JuMC+M50ot6GtVWDC+9nT3aqD6AV8qP
3fqMkrAzdgYTdV+M47U3ltpBpDb8IB0+87pdSxP+Ry6mY84yrX6/Q2Lb27G5okWj/c9q+3QRLxEy
eviFZqNa6CcsOuSbwRQ/p+IO1Asf08XfM6exoGG+WIw9vYY5vXfccroyhJlXEjKjzNFpqpsD3gLG
AsjEnVlpYh9XHMkNWy5Qhu/Qej2UORFzGT0LLnuRmjywJt40ag6mbVbmaiuo/RZImCLMVjcr4ARj
Z6EohXO3Zv0N5bEzrGXhZ1UzEpuCakYbowY8DDbdzv2tHdBgVecCB619ekMuhhGRIb82r2PITqZS
+qsulSnKPpfFwSk9p9jIptlDUvkqZJ/R2QmiOcbmsB4ZTJBS8TsvWN0FPTxHUYZUiUBJrE9EOOUt
BkSQbKGI/HIJV74PmvDiEhdyj6kVqzuc2uD+/EJYBs+ne3p1UnLRpObFUW3HzGYfcFZS0GJxFb/e
U+FQ72RcuYAaMxLtA75tHnqXVXr96/aKx/P12ddQuSeDB6yNoNLEH4Rk3Sbbgc63ncf8fYtdKPJJ
D3IxQNHR2QmSHnghMrxahYtL3jP6U69Izn+p1BcD0OVUsqXQSj7e4ujKhJY/2jRsZSzigqViKNCk
dDbcxqLhK/kPCgT/8SPzBjO14RGZxDUJbHvNb8SupDcdeLupqzaZt6ky2q4cPTwg8BpnGgij1EN4
Xw3+reVX0ZdAXD+RK97PcaPMPLlELSVNR/qxqWCDlSa4TjSrW7LmgLTZLcslYG0vQv03Of20vHGj
VXJnHd8GB3nKjzH6j3slkvhlDhIGJ+GmkgVoxfd92qOtmrKLjRsAbrJWJx7urgUooRkjFQcboxdz
ErRKNOeqhIhB/d5Y4s+7+jgP2dEkqLZeqEHI9r1nGuikHw9rocj7Vm+bAhayTigX4bQwUhlEj3kS
gSXgoA0DX8YRIn7Po3Nuidb8u+TqSq50f5al9GOl84w7W3z/iVW/Ty5a9g4LxoMAnZIjp5Hlj+Mm
UwcUnyQwJ2pZkrvfYLHwLBMX8xrSy36tJQYtAklk6uAqGcy4zsA0a9CUyCVaKC3SSarIPZlmdbtY
ucpofxWsKpbISvbQ7hNHclHhJ+G81Ly2WW2GuI2L9gShfrBN5vufhz61xlUyk9OW07WaP/59mRFN
dc09HXUUNT6/Uew97tYBpPvgmHHWStFPVx9IqA+pbS4dcrZADdvWJKYDiClS13dw8Suv5MCR/zSM
Xh8d8JFWduLbmVVtReBZZew+NS6V2oHLjJSqkfDOpHF77yBqYpr/eyrgDotzJzZyziMRqLb9tjrS
dsyhZajtuawPKV+8w7OFA4Xrz+fxCQNxM7Fq/Szz9lNRaWxl35qFzAq49pYBbvGabx50z0L8f9Yx
A78qGhnh7DjFBrOq9Kjj3xdFEPG737qokduEL41SVmsxrnvH8HXXeAW7gtOHPMWQ9q1osSN3SzEs
p4VPaQB2Hx/hkS2ULtOw59v/ZHnSUVlX6DR89XDqg84Y9Zom779NYkLQW2ASAy4f94+tXK02WivE
qm7Sfipf+3/t9rvQPYYyTaHkMc3MyJDuLeLKWm10OLWc59x1vmqecib3YOrBkk4jHqwcWZFzgkEZ
Rshwqa7F4/cV/HO7JuJYweljmuVhhlLJHY/tns4WEwukGxol99F55sGLj5zPhr50B0Hqq9hugq/g
Qn8swZ2fe8f1TljQKqGxxlgrsXKMtFb5n78QuAHi8jexruk/3r24t5zRD11lAqC749z1yTbp1KqD
FbX3yb0WdHiv2LU400UvueY86xUe4L1MNwPQ7WFHPhqNCFMWBvKf2WN4XtETSx5U6B3Svsqd+ecC
/DQTGt+CC2rQkmGr8evThMEKc7Ra2iHl+1Dk19Xdm8VZm1/jrk5yVVw+Ic9olAa4FE+YgyHNcIL4
hF4Sn4pUqlben2ywan0cy5Jn96ErV3k/hu/D4JtBtPpOp6bRzon2M4sLSsq1lktamICEd9Ao7lFa
YubW3JMCeALoghJLp7dOsPJtJazyM93BzWHTREnAJb1gYRBXIEzKtQhbfR8SfCIHWWJEgU9CvT4+
vs2seMetWQhwtTuOheo/ORLPsNaFzxuW2gJ0RZ2OZypKtvcmg4z/avHWe1vke3hOSteXl+1+8jY3
eClSKKHpiVHqZMNpCbTkAqsHaa2TX2AdfyEnD6Gbtjyfx67Vy9jDyjGxQpfK212GOauHsuZsCL8L
SwCa1mCGeI7Vd5Wv3X3OAi+EtK2xfqORwP3FjraYVHQcWMdqFcWq3Gi27q1HtlPnJjGaaoqiVWIJ
HhZEEI1mxUJwo5jX0kSuOL2OdR8cHBAcQ8fJMXy0inadZg78CALUL9qXoOzYCoqd4J9Rix4NMvQR
HRuoT5+cU25mpYguUDRpRrYtcVaJ7aHb6VEmhfQ38g3eAnHuJ8ceIggBx/OCh73XIb+M1i76xWK6
oUhGpLam9WNuuRx+zB7RzWmWnukQDbFmQt005QIphTVF6WbrRX+m3yq1clC0cjcQQtt8rzr2XIWd
CMrDlysEn+QOSHFNjyPZsQn51Rc+jRBdgGS7A6vBeNZny3uwyLaMkdGg1vnzjhi1u8BxwdQ0nbTz
3e3NJ3ouvpN52sOG8z4oBNEUV6duwc/btOLamvOhAF8pjwHrqy7TcvNnM97x3J5hRqs0ZzT0lGD1
HVOknzMGs1SEjzL8X5yk9dzkYZ+wHBfwQgzXORC/jaDsX/pcdrutDvXIoigbeZFGWo5POjBVPBbe
pqF4Q5Zu2W1cURxGbVO1f7VpcuFerzcnJIKrQAT5TzTWPRplNWtlEulYRyNZADZmjU5BhjiqawA6
Fc7lRANEjI23qOtLxY2yWMF/YQi7NPYHd/MYCXI+b6MNx4Gd7N7YkOP0cCfxFsQKZJZyfzUTglSV
zFKC+CLODEHkJO7tmMo5jPd7YFtLsjdJ8ZxS41hNdk8he11lCpMyiFRrnkSejQe5P8v37hCy47cj
OFsxHA1+KPjmjD9XDfQdjm+B5igSEVmq2FIoGA2nmcplhw+GGqVD3WSt+ZrcpEJtVs0qn491Um4u
ZGk30qoZzUa/rt32fYbW8o+DOneTP01zbMBTPsQODPzVpxVX0FzaPZXr/yKHystuoop2LMGE4rCz
iJhfeseR0HZzdsBp+LSJYkR3owc+rwwKvrREQ1hq230CNFqNAiJFIXl4ocgtIRdmD4W/h+0IydW7
ZIxhbbyICpF/24bceRnGVM3KLT9uGA1HuVxZTVaEOgJcrZg9p70oaV4iR6fpIoWiP8p+qI08leEf
YvwfEsqtijv2gYCRigr1wS/YAWJ0alxl3QzUarssi+q/BRXFd7pmFy50CaFEWDR69Rm5hjQDjcN+
QhyT9p7cdDupKNscOG/xi40W2yaW4UBN7Dq0CDQorfqQlH2YoscFz97Z2hMiRRTLEwCQCfGB1lM9
G6kdX10crhOR1s1omx8J4vABzJQCW7V8bCy74iS0baSmRa75fqIJXjOixZlYCChgMVJE3wZXiwu0
HeeinnCIWRWQrvpgyKzSG6tF4P/FpmY5PrNaKwcLD6VHaICG0xS62N6VwfnOwq++Wcp+TdDcjv/E
EqyQJgF3btlEABCBbDkRV9AQYY6lSPl9u1Rqs/C9c94By7UNyvlYdN+9CFSr/96ItqORRB2G11oq
5D1aMrFbyMJ63xFoqL6bBbfJTFr97YaGoOCx37HG1dvDaiLrfAXsHhjtq0B/NGoUYH1e6dbvZCMa
W2F3b9weBP//YmhJT46d1kRKQeT2kd6ogY7H4YRi/2RvUCDYfs5OHQeu3X1iqrc6och+CJ1hI6/8
0g7xhqP5CsLJaI+8iklHqXlYwmeQg3XLKT30MzPaWWRfB4HSvlPow3BoSgmOdJM9Rlzls7I2+fI3
vqm1n+BRCSxK15aPnD5gA5czqRBO7TutNL+kIwNUa4CW/aH/15uT7YqZrGqcsG0V8kBBrIczFmfE
rzZdb0H8OWeIGZ9WVihMZW/pRN2GabfaMxwT//6/W8TK5du4uvbfF6svp6yXfyqabuh5E2GrUDWe
i/edZj6N+yVYsEtlosBkiPxL+u4h1NkRPqY74MFRBeNudS6jt3tKLaXPGwk8smp1gOkeJKCDX4V8
vnEI5VvWHsDTlyGwrUq6pHmVmzLj/9h9uxSzp8ILqeBIr8vtUh+eRXglKi+JLRVxdRs/548QPKR6
5GyAHsHNd3eWBMTAXEX56uk1yc97SCqV3Vh3ORyJ8R2tdJl8l2tr2GwbiCqTI57qcWCppvdL+oSf
5oZiKk0PmeJiwINEAvFqTKx0KxU43z3l7AbzEbBmNhYtqg5HVjqZuuPeuCIiaq8toqu6AExpTB4a
qAbSSjZkjnsp+OgsR1Ww7k24mhrdeis+fmjM3ShDYCitEFrlm77jlN7qtyNvMHwDNw+60QNGIjue
oAQmu87LVnxHvSyUReUz0WtRXjHGfp1sqm2axtwC4QM/8pWnwp0CmSwzOKJ9pmQsz+bwhiDweaP5
4rxcIZlAecfuhFeUGE0+Swz1V6X8Sn1gAjOjpphkEHhYrgFtUUWrOf4xMOjJqKrmXeYsmCFm6oB6
j+40dJEKowoFmJlrxyu5R9xAifPdyCnMoecJ2XWj95sPqrmneJaT5br8tcrDSaO+IfCS8FV0P7KC
C1OWqmu5R1PGu1lzS+tN7F2/I01IU8Ym1ypGWIgmGIFhxnO1KtHf5FVYs7CoqdE5cZ/i4KUiUT4B
K7F14IBHctYGraKorw4pU96hdjhu22QsBCBeVCDfeMsGIbNYOywGFt3/rwNJuKQ5XnBCvYoRNYoL
VNnkS148uKSWVbjNm3hlk33XhiWN/9+b7F0x0gMs1LUOI+0MBi19sM6+c7CQPLGoyN4aaU1FN546
Ikng2dgQtUn7MwZF/7vcIyLvhAWH3/maNdTD+UVAYvNMDxU3+9yKyA3cYv0LAhDaEbMIqFojiVMC
1Z0Q3hQotTvKL/FBeo6VbqwM42sJz1V99Euh28gtyMg/6jJSVE0i6tcqu29Lyw8JWJt3pXrZoARo
exiyQ86MZJIS3HUVzno+awrJ11LYwW6PPIRdhvAiZ5LW6DVuatvgGLnpdHFj/s4Azx42mf4ArlXz
fID4KlmLpt5w+d2DNneyWsNC+0hJeb/3zxly6HUVEFjMZDWr7trbGw46josn57l1dPfHmu7575e0
MEWx71aIr7EngM5MxmCBhD/DNuCC97vJcNaqwMup+xPZks7SewJCpQBrSYlw9S8nwnYZii/qNY/Y
x3njDyroxm/i9aUE0sE2f+xZK1XxpGFAOYU7TQ+8WcxGCjdSCtXU2fAD9KRMbAtm5JPCuNd3oF7S
uTErIDQeFnIdgCwZlHuQYcfMsp9MvqmCXsXWTqH0tUXQgwPxzIY7T88THb59/oNaSO8Y3qinUUAu
ewHGBChu8V80KjqtyYA73Z7ftCqulqf7tD4zQRqlf5EC0yMC2s2nSSeLsK9YLfGWG6PtUjEN0E4d
vmt3l559IMrdooowU/uWNSBEv1oUiJ1YYWRGyhlfk7z7nVvtLKWMX3yermAZdrRIfCLzbFrffGkS
cCboZ0SV+Bd+rJZGmm9sFCr9RKYEPS6GbPY2mgru9mLv2acensOzrQ9ksdqyPL9wsX88LZ2f0dN9
94caIH9RhcakQoSPnvc4letpXBKAFkBidJzP3ADDf+6Otm93Mwgh+Ln88FJiIO4T1r+PExzsS0uI
cSjSXG5gDLklkrsssgZtMkhU7gRUy/ytmgMrzbnduDLMppsJpwU4/8xwObYP9jhO83xOdFkPAAqR
NlMdAETxhnNAqPbiZoCJAk7af8TkmSs1ONioBkUkMHMSlLmXXgNzrT9NMuNgZDhS2QOjLd9yhXY3
Ls1Fa+VZyE98aniqomRIaDYFR3/ww/JWQedqpppLzBthKetV1uBRPjxSkRxjWc1uVgtEXjtietsy
eur7V31Lp5V9o9RhMu/fbPW5AqpuAxb++DqWQ9xZHV3sge3IpvOrk8SyNBIY3l229/ff0ClJzI0R
s4hAyz/pzpMKItaDB8lgBUhwObG4gx6smIn6F/nEq6iJIJB6+zVA3bLWsliSeMuftypD9Ytr9pm8
UkLJ
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
