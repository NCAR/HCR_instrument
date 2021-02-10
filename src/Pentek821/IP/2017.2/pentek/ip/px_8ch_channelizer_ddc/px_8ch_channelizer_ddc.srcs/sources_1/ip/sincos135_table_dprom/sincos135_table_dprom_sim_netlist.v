// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Tue May  9 12:00:37 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Pentek/IP/2017.1/wip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/sincos135_table_dprom/sincos135_table_dprom_sim_netlist.v
// Design      : sincos135_table_dprom
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "sincos135_table_dprom,blk_mem_gen_v8_3_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_3_6,Vivado 2017.1" *) 
(* NotValidForBitStream *)
module sincos135_table_dprom
   (clka,
    ena,
    addra,
    douta,
    clkb,
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [35:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [9:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [35:0]doutb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire clkb;
  wire [35:0]douta;
  wire [35:0]doutb;
  wire ena;
  wire enb;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [35:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.708242 mW" *) 
  (* C_FAMILY = "kintexu" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "sincos135_table_dprom.mem" *) 
  (* C_INIT_FILE_NAME = "sincos135_table_dprom.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "4" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
  (* C_READ_WIDTH_A = "36" *) 
  (* C_READ_WIDTH_B = "36" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "36" *) 
  (* C_WRITE_WIDTH_B = "36" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  sincos135_table_dprom_blk_mem_gen_v8_3_6 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[35:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_generic_cstr" *) 
module sincos135_table_dprom_blk_mem_gen_generic_cstr
   (douta,
    doutb,
    clka,
    ena,
    enb,
    sleep,
    addra,
    addrb);
  output [35:0]douta;
  output [35:0]doutb;
  input clka;
  input ena;
  input enb;
  input sleep;
  input [9:0]addra;
  input [9:0]addrb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire [35:0]douta;
  wire [35:0]doutb;
  wire ena;
  wire enb;
  wire sleep;

  sincos135_table_dprom_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .douta(douta),
        .doutb(doutb),
        .ena(ena),
        .enb(enb),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module sincos135_table_dprom_blk_mem_gen_prim_width
   (douta,
    doutb,
    clka,
    ena,
    enb,
    sleep,
    addra,
    addrb);
  output [35:0]douta;
  output [35:0]doutb;
  input clka;
  input ena;
  input enb;
  input sleep;
  input [9:0]addra;
  input [9:0]addrb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire [35:0]douta;
  wire [35:0]doutb;
  wire ena;
  wire enb;
  wire sleep;

  sincos135_table_dprom_blk_mem_gen_prim_wrapper_init \prim_init.ram 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .douta(douta),
        .doutb(doutb),
        .ena(ena),
        .enb(enb),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module sincos135_table_dprom_blk_mem_gen_prim_wrapper_init
   (douta,
    doutb,
    clka,
    ena,
    enb,
    sleep,
    addra,
    addrb);
  output [35:0]douta;
  output [35:0]doutb;
  input clka;
  input ena;
  input enb;
  input sleep;
  input [9:0]addra;
  input [9:0]addrb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire [35:0]douta;
  wire [35:0]doutb;
  wire ena;
  wire enb;
  wire sleep;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("COMMON"),
    .DOA_REG(1),
    .DOB_REG(1),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h8BBBAAEEBFFBEAEAEFBFFBBBBFFFFBBBAEEAFFBEAFBEABEABEFEBBBABABAABEE),
    .INITP_01(256'hCDD8998989888DCD89D89D8C9D8CC9DD9888CCCC8888CC8CD9D9D8CC8DD99888),
    .INITP_02(256'h1DDD9988DCCD89898CDCCDDDDCCCCDDD9889CCD89CD89D89D8C8DDD9D9D99D88),
    .INITP_03(256'h0441551515111404154154105410054451110000111100104545410014455111),
    .INITP_04(256'h4444551140041515104004444000044451150041504154154101444545455411),
    .INITP_05(256'h3227667676777232762762736273362267773333777733732626273372266777),
    .INITP_06(256'h2222667723327676732332222333322267763327632762762737222626266277),
    .INITP_07(256'h2BBEAAEAEAEEEBFBEABEABEFABEFFABBAEEEFFFFEEEEFFEFBABABEFFEBBAAEEE),
    .INITP_08(256'hFBBEAAEAEAEEEBFBEABEABEFABEFFABBAEEEFFFFEEEEFFEFBABABEFFEBBAAEEE),
    .INITP_09(256'h8BBBAAEEBFFBEAEAEFBFFBBBBFFFFBBBAEEAFFBEAFBEABEABEFEBBBABABAABEE),
    .INITP_0A(256'hCDD8998989888DCD89D89D8C9D8CC9DD9888CCCC8888CC8CD9D9D8CC8DD99888),
    .INITP_0B(256'h1DDD9988DCCD89898CDCCDDDDCCCCDDD9889CCD89CD89D89D8C8DDD9D9D99D88),
    .INITP_0C(256'h0441551515111404154154105410054451110000111100104545410014455111),
    .INITP_0D(256'h4444551140041515104004444000044451150041504154154101444545455411),
    .INITP_0E(256'h3227667676777232762762736273362267773333777733732626273372266777),
    .INITP_0F(256'h0222667723327676732332222333322267763327632762762737222626266277),
    .INIT_00(256'h3A3A5D323C3E5B5D3E515895407356D942A4542B44E3518A46314FF6488D4D70),
    .INIT_01(256'h2B4B718D2CD16F5A2E676C31300D6A1332C46702348A64FC365F620238456014),
    .INIT_02(256'h1E7787A61F758420218681A422A77F3124DA7CC9261D796A2771771629D674CC),
    .INIT_03(256'h13FB9E12146C9B4715EF9885178395CB182A921819E38F6F1BAD8CCD1C898A35),
    .INIT_04(256'h0B0EB5600BEAB2600CD9AF660DDBAC720EF0A9841017A69D1151A3BD129DA0E3),
    .INIT_05(256'h04D8CE1E051CCAF60673C7D206DDC4B3075AC19908EABE83098EBB720A44B866),
    .INIT_06(256'h0179E6D10121E39101DCE05402AADD19028DDAE00382D7AA038CD47804A8D149),
    .INIT_07(256'h00020000000CFCB80029F96F005BF62800A0F3E100F9F09B0065ED5600E5EA13),
    .INIT_08(256'h0179192F00E515ED006512AA00F90F6500A00C1F005B09D800290691000C0348),
    .INIT_09(256'h04D831E204A82EB7038C2B8803822856028D252002AA22E701DC1FAC01211C6F),
    .INIT_0A(256'h0B0E4AA00A44479A098E448E08EA417D075A3E6706DD3B4D0673382E051C350A),
    .INIT_0B(256'h13FB61EE129D5F1D11515C43101759630EF0567C0DDB538E0CD9509A0BEA4DA0),
    .INIT_0C(256'h1E77785A1C8975CB1BAD733319E37091182A6DE817836A3515EF677B146C64B9),
    .INIT_0D(256'h2B4B8E7329D68B34277188EA261D869624DA833722A780CF21867E5C1F757BE0),
    .INIT_0E(256'h3A3AA2CE38459FEC365F9DFE348A9B0432C498FE300D95ED2E6793CF2CD190A6),
    .INIT_0F(256'h4AF8B508488DB2904631B00A44E3AE7642A4ABD54073A9273E51A76B3C3EA4A3),
    .INIT_10(256'h5D32C5C65B5DC3C25895C1AF56D9BF8D542BBD5C518ABB1D4FF6B9CF4D70B773),
    .INIT_11(256'h718DD4B56F5AD32F6C31D1996A13CFF36702CD3C64FCCB766202C9A16014C7BB),
    .INIT_12(256'h87A6E1898420E08B81A4DE7A7F31DD597CC9DB26796AD9E37716D88F74CCD62A),
    .INIT_13(256'h9E12EC059B47EB949885EA1195CBE87D9218E7D68F6FE61D8CCDE4538A35E377),
    .INIT_14(256'hB560F4F2B260F416AF66F327AC72F225A984F110A69DEFE9A3BDEEAFA0E3ED63),
    .INIT_15(256'hCE1EFB28CAF6FAE4C7D2F98DC4B3F923C199F8A6BE83F716BB72F672B866F5BC),
    .INIT_16(256'hE6D1FE87E391FEDFE054FE24DD19FD56DAE0FD73D7AAFC7ED478FC74D149FB58),
    .INIT_17(256'h0000FFFEFCB8FFF4F96FFFD7F628FFA5F3E1FF60F09BFF07ED56FF9BEA13FF1B),
    .INIT_18(256'h192FFE8715EDFF1B12AAFF9B0F65FF070C1FFF6009D8FFA50691FFD70348FFF4),
    .INIT_19(256'h31E2FB282EB7FB582B88FC742856FC7E2520FD7322E7FD561FACFE241C6FFEDF),
    .INIT_1A(256'h4AA0F4F2479AF5BC448EF672417DF7163E67F8A63B4DF923382EF98D350AFAE4),
    .INIT_1B(256'h61EEEC055F1DED635C43EEAF5963EFE9567CF110538EF225509AF3274DA0F416),
    .INIT_1C(256'h785AE18975CBE3777333E4537091E61D6DE8E7D66A35E87D677BEA1164B9EB94),
    .INIT_1D(256'h8E73D4B58B34D62A88EAD88F8696D9E38337DB2680CFDD597E5CDE7A7BE0E08B),
    .INIT_1E(256'hA2CEC5C69FECC7BB9DFEC9A19B04CB7698FECD3C95EDCFF393CFD19990A6D32F),
    .INIT_1F(256'hB508B508B290B773B00AB9CFAE76BB1DABD5BD5CA927BF8DA76BC1AFA4A3C3C2),
    .INIT_20(256'hC5C6A2CEC3C2A4A3C1AFA76BBF8DA927BD5CABD5BB1DAE76B9CFB00AB773B290),
    .INIT_21(256'hD4B58E73D32F90A6D19993CFCFF395EDCD3C98FECB769B04C9A19DFEC7BB9FEC),
    .INIT_22(256'hE189785AE08B7BE0DE7A7E5CDD5980CFDB268337D9E38696D88F88EAD62A8B34),
    .INIT_23(256'hEC0561EEEB9464B9EA11677BE87D6A35E7D66DE8E61D7091E4537333E37775CB),
    .INIT_24(256'hF4F24AA0F4164DA0F327509AF225538EF110567CEFE95963EEAF5C43ED635F1D),
    .INIT_25(256'hFB2831E2FAE4350AF98D382EF9233B4DF8A63E67F716417DF672448EF5BC479A),
    .INIT_26(256'hFE87192FFEDF1C6FFE241FACFD5622E7FD732520FC7E2856FC742B88FB582EB7),
    .INIT_27(256'hFFFE0000FFF40348FFD70691FFA509D8FF600C1FFF070F65FF9B12AAFF1B15ED),
    .INIT_28(256'hFE87E6D1FF1BEA13FF9BED56FF07F09BFF60F3E1FFA5F628FFD7F96FFFF4FCB8),
    .INIT_29(256'hFB28CE1EFB58D149FC74D478FC7ED7AAFD73DAE0FD56DD19FE24E054FEDFE391),
    .INIT_2A(256'hF4F2B560F5BCB866F672BB72F716BE83F8A6C199F923C4B3F98DC7D2FAE4CAF6),
    .INIT_2B(256'hEC059E12ED63A0E3EEAFA3BDEFE9A69DF110A984F225AC72F327AF66F416B260),
    .INIT_2C(256'hE18987A6E3778A35E4538CCDE61D8F6FE7D69218E87D95CBEA119885EB949B47),
    .INIT_2D(256'hD4B5718DD62A74CCD88F7716D9E3796ADB267CC9DD597F31DE7A81A4E08B8420),
    .INIT_2E(256'hC5C65D32C7BB6014C9A16202CB7664FCCD3C6702CFF36A13D1996C31D32F6F5A),
    .INIT_2F(256'hB5084AF8B7734D70B9CF4FF6BB1D518ABD5C542BBF8D56D9C1AF5895C3C25B5D),
    .INIT_30(256'hA2CE3A3AA4A33C3EA76B3E51A9274073ABD542A4AE7644E3B00A4631B290488D),
    .INIT_31(256'h8E732B4B90A62CD193CF2E6795ED300D98FE32C49B04348A9DFE365F9FEC3845),
    .INIT_32(256'h785A1E777BE01F757E5C218680CF22A7833724DA8696261D88EA27718B3429D6),
    .INIT_33(256'h61EE13FB64B9146C677B15EF6A3517836DE8182A709119E373331BAD75CB1C89),
    .INIT_34(256'h4AA00B0E4DA00BEA509A0CD9538E0DDB567C0EF0596310175C4311515F1D129D),
    .INIT_35(256'h31E204D8350A051C382E06733B4D06DD3E67075A417D08EA448E098E479A0A44),
    .INIT_36(256'h192F01791C6F01211FAC01DC22E702AA2520028D285603822B88038C2EB704A8),
    .INIT_37(256'h000000020348000C0691002909D8005B0C1F00A00F6500F912AA006515ED00E5),
    .INIT_38(256'hE6D10179EA1300E5ED560065F09B00F9F3E100A0F628005BF96F0029FCB8000C),
    .INIT_39(256'hCE1E04D8D14904A8D478038CD7AA0382DAE0028DDD1902AAE05401DCE3910121),
    .INIT_3A(256'hB5600B0EB8660A44BB72098EBE8308EAC199075AC4B306DDC7D20673CAF6051C),
    .INIT_3B(256'h9E1213FBA0E3129DA3BD1151A69D1017A9840EF0AC720DDBAF660CD9B2600BEA),
    .INIT_3C(256'h87A61E778A351C898CCD1BAD8F6F19E39218182A95CB1783988515EF9B47146C),
    .INIT_3D(256'h718D2B4B74CC29D677162771796A261D7CC924DA7F3122A781A4218684201F75),
    .INIT_3E(256'h5D323A3A601438456202365F64FC348A670232C46A13300D6C312E676F5A2CD1),
    .INIT_3F(256'h000000024D70488D4FF64631518A44E3542B42A456D9407358953E515B5D3C3E),
    .INIT_40(256'hE6D10179EA1300E5ED560065F09B00F9F3E100A0F628005BF96F0029FCB8000C),
    .INIT_41(256'hCE1E04D8D14904A8D478038CD7AA0382DAE0028DDD1902AAE05401DCE3910121),
    .INIT_42(256'hB5600B0EB8660A44BB72098EBE8308EAC199075AC4B306DDC7D20673CAF6051C),
    .INIT_43(256'h9E1213FBA0E3129DA3BD1151A69D1017A9840EF0AC720DDBAF660CD9B2600BEA),
    .INIT_44(256'h87A61E778A351C898CCD1BAD8F6F19E39218182A95CB1783988515EF9B47146C),
    .INIT_45(256'h718D2B4B74CC29D677162771796A261D7CC924DA7F3122A781A4218684201F75),
    .INIT_46(256'h5D323A3A601438456202365F64FC348A670232C46A13300D6C312E676F5A2CD1),
    .INIT_47(256'h4AF84AF84D70488D4FF64631518A44E3542B42A456D9407358953E515B5D3C3E),
    .INIT_48(256'h3A3A5D323C3E5B5D3E515895407356D942A4542B44E3518A46314FF6488D4D70),
    .INIT_49(256'h2B4B718D2CD16F5A2E676C31300D6A1332C46702348A64FC365F620238456014),
    .INIT_4A(256'h1E7787A61F758420218681A422A77F3124DA7CC9261D796A2771771629D674CC),
    .INIT_4B(256'h13FB9E12146C9B4715EF9885178395CB182A921819E38F6F1BAD8CCD1C898A35),
    .INIT_4C(256'h0B0EB5600BEAB2600CD9AF660DDBAC720EF0A9841017A69D1151A3BD129DA0E3),
    .INIT_4D(256'h04D8CE1E051CCAF60673C7D206DDC4B3075AC19908EABE83098EBB720A44B866),
    .INIT_4E(256'h0179E6D10121E39101DCE05402AADD19028DDAE00382D7AA038CD47804A8D149),
    .INIT_4F(256'h00020000000CFCB80029F96F005BF62800A0F3E100F9F09B0065ED5600E5EA13),
    .INIT_50(256'h0179192F00E515ED006512AA00F90F6500A00C1F005B09D800290691000C0348),
    .INIT_51(256'h04D831E204A82EB7038C2B8803822856028D252002AA22E701DC1FAC01211C6F),
    .INIT_52(256'h0B0E4AA00A44479A098E448E08EA417D075A3E6706DD3B4D0673382E051C350A),
    .INIT_53(256'h13FB61EE129D5F1D11515C43101759630EF0567C0DDB538E0CD9509A0BEA4DA0),
    .INIT_54(256'h1E77785A1C8975CB1BAD733319E37091182A6DE817836A3515EF677B146C64B9),
    .INIT_55(256'h2B4B8E7329D68B34277188EA261D869624DA833722A780CF21867E5C1F757BE0),
    .INIT_56(256'h3A3AA2CE38459FEC365F9DFE348A9B0432C498FE300D95ED2E6793CF2CD190A6),
    .INIT_57(256'h4AF8B508488DB2904631B00A44E3AE7642A4ABD54073A9273E51A76B3C3EA4A3),
    .INIT_58(256'h5D32C5C65B5DC3C25895C1AF56D9BF8D542BBD5C518ABB1D4FF6B9CF4D70B773),
    .INIT_59(256'h718DD4B56F5AD32F6C31D1996A13CFF36702CD3C64FCCB766202C9A16014C7BB),
    .INIT_5A(256'h87A6E1898420E08B81A4DE7A7F31DD597CC9DB26796AD9E37716D88F74CCD62A),
    .INIT_5B(256'h9E12EC059B47EB949885EA1195CBE87D9218E7D68F6FE61D8CCDE4538A35E377),
    .INIT_5C(256'hB560F4F2B260F416AF66F327AC72F225A984F110A69DEFE9A3BDEEAFA0E3ED63),
    .INIT_5D(256'hCE1EFB28CAF6FAE4C7D2F98DC4B3F923C199F8A6BE83F716BB72F672B866F5BC),
    .INIT_5E(256'hE6D1FE87E391FEDFE054FE24DD19FD56DAE0FD73D7AAFC7ED478FC74D149FB58),
    .INIT_5F(256'h0000FFFEFCB8FFF4F96FFFD7F628FFA5F3E1FF60F09BFF07ED56FF9BEA13FF1B),
    .INIT_60(256'h192FFE8715EDFF1B12AAFF9B0F65FF070C1FFF6009D8FFA50691FFD70348FFF4),
    .INIT_61(256'h31E2FB282EB7FB582B88FC742856FC7E2520FD7322E7FD561FACFE241C6FFEDF),
    .INIT_62(256'h4AA0F4F2479AF5BC448EF672417DF7163E67F8A63B4DF923382EF98D350AFAE4),
    .INIT_63(256'h61EEEC055F1DED635C43EEAF5963EFE9567CF110538EF225509AF3274DA0F416),
    .INIT_64(256'h785AE18975CBE3777333E4537091E61D6DE8E7D66A35E87D677BEA1164B9EB94),
    .INIT_65(256'h8E73D4B58B34D62A88EAD88F8696D9E38337DB2680CFDD597E5CDE7A7BE0E08B),
    .INIT_66(256'hA2CEC5C69FECC7BB9DFEC9A19B04CB7698FECD3C95EDCFF393CFD19990A6D32F),
    .INIT_67(256'hB508B508B290B773B00AB9CFAE76BB1DABD5BD5CA927BF8DA76BC1AFA4A3C3C2),
    .INIT_68(256'hC5C6A2CEC3C2A4A3C1AFA76BBF8DA927BD5CABD5BB1DAE76B9CFB00AB773B290),
    .INIT_69(256'hD4B58E73D32F90A6D19993CFCFF395EDCD3C98FECB769B04C9A19DFEC7BB9FEC),
    .INIT_6A(256'hE189785AE08B7BE0DE7A7E5CDD5980CFDB268337D9E38696D88F88EAD62A8B34),
    .INIT_6B(256'hEC0561EEEB9464B9EA11677BE87D6A35E7D66DE8E61D7091E4537333E37775CB),
    .INIT_6C(256'hF4F24AA0F4164DA0F327509AF225538EF110567CEFE95963EEAF5C43ED635F1D),
    .INIT_6D(256'hFB2831E2FAE4350AF98D382EF9233B4DF8A63E67F716417DF672448EF5BC479A),
    .INIT_6E(256'hFE87192FFEDF1C6FFE241FACFD5622E7FD732520FC7E2856FC742B88FB582EB7),
    .INIT_6F(256'hFFFE0000FFF40348FFD70691FFA509D8FF600C1FFF070F65FF9B12AAFF1B15ED),
    .INIT_70(256'hFE87E6D1FF1BEA13FF9BED56FF07F09BFF60F3E1FFA5F628FFD7F96FFFF4FCB8),
    .INIT_71(256'hFB28CE1EFB58D149FC74D478FC7ED7AAFD73DAE0FD56DD19FE24E054FEDFE391),
    .INIT_72(256'hF4F2B560F5BCB866F672BB72F716BE83F8A6C199F923C4B3F98DC7D2FAE4CAF6),
    .INIT_73(256'hEC059E12ED63A0E3EEAFA3BDEFE9A69DF110A984F225AC72F327AF66F416B260),
    .INIT_74(256'hE18987A6E3778A35E4538CCDE61D8F6FE7D69218E87D95CBEA119885EB949B47),
    .INIT_75(256'hD4B5718DD62A74CCD88F7716D9E3796ADB267CC9DD597F31DE7A81A4E08B8420),
    .INIT_76(256'hC5C65D32C7BB6014C9A16202CB7664FCCD3C6702CFF36A13D1996C31D32F6F5A),
    .INIT_77(256'hB5084AF8B7734D70B9CF4FF6BB1D518ABD5C542BBF8D56D9C1AF5895C3C25B5D),
    .INIT_78(256'hA2CE3A3AA4A33C3EA76B3E51A9274073ABD542A4AE7644E3B00A4631B290488D),
    .INIT_79(256'h8E732B4B90A62CD193CF2E6795ED300D98FE32C49B04348A9DFE365F9FEC3845),
    .INIT_7A(256'h785A1E777BE01F757E5C218680CF22A7833724DA8696261D88EA27718B3429D6),
    .INIT_7B(256'h61EE13FB64B9146C677B15EF6A3517836DE8182A709119E373331BAD75CB1C89),
    .INIT_7C(256'h4AA00B0E4DA00BEA509A0CD9538E0DDB567C0EF0596310175C4311515F1D129D),
    .INIT_7D(256'h31E204D8350A051C382E06733B4D06DD3E67075A417D08EA448E098E479A0A44),
    .INIT_7E(256'h192F01791C6F01211FAC01DC22E702AA2520028D285603822B88038C2EB704A8),
    .INIT_7F(256'h000000000348000C0691002909D8005B0C1F00A00F6500F912AA006515ED00E5),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(36),
    .READ_WIDTH_B(36),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(36),
    .WRITE_WIDTH_B(36)) 
    \DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({addra,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({addrb,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ADDRENA(1'b0),
        .ADDRENB(1'b0),
        .CASDIMUXA(1'b0),
        .CASDIMUXB(1'b0),
        .CASDINA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINB({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINPA({1'b0,1'b0,1'b0,1'b0}),
        .CASDINPB({1'b0,1'b0,1'b0,1'b0}),
        .CASDOMUXA(1'b0),
        .CASDOMUXB(1'b0),
        .CASDOMUXEN_A(1'b0),
        .CASDOMUXEN_B(1'b0),
        .CASDOUTA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED [31:0]),
        .CASDOUTB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED [31:0]),
        .CASDOUTPA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED [3:0]),
        .CASDOUTPB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED [3:0]),
        .CASINDBITERR(1'b0),
        .CASINSBITERR(1'b0),
        .CASOREGIMUXA(1'b0),
        .CASOREGIMUXB(1'b0),
        .CASOREGIMUXEN_A(1'b0),
        .CASOREGIMUXEN_B(1'b0),
        .CASOUTDBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ),
        .CASOUTSBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DINADIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DINBDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DINPADINP({1'b0,1'b0,1'b0,1'b0}),
        .DINPBDINP({1'b0,1'b0,1'b0,1'b0}),
        .DOUTADOUT({douta[34:27],douta[25:18],douta[16:9],douta[7:0]}),
        .DOUTBDOUT({doutb[34:27],doutb[25:18],doutb[16:9],doutb[7:0]}),
        .DOUTPADOUTP({douta[35],douta[26],douta[17],douta[8]}),
        .DOUTPBDOUTP({doutb[35],doutb[26],doutb[17],doutb[8]}),
        .ECCPARITY(\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ECCPIPECE(1'b0),
        .ENARDEN(ena),
        .ENBWREN(enb),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(ena),
        .REGCEB(enb),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .SLEEP(sleep),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_top" *) 
module sincos135_table_dprom_blk_mem_gen_top
   (douta,
    doutb,
    clka,
    ena,
    enb,
    sleep,
    addra,
    addrb);
  output [35:0]douta;
  output [35:0]doutb;
  input clka;
  input ena;
  input enb;
  input sleep;
  input [9:0]addra;
  input [9:0]addrb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire [35:0]douta;
  wire [35:0]doutb;
  wire ena;
  wire enb;
  wire sleep;

  sincos135_table_dprom_blk_mem_gen_generic_cstr \valid.cstr 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .douta(douta),
        .doutb(doutb),
        .ena(ena),
        .enb(enb),
        .sleep(sleep));
endmodule

(* C_ADDRA_WIDTH = "10" *) (* C_ADDRB_WIDTH = "10" *) (* C_ALGORITHM = "1" *) 
(* C_AXI_ID_WIDTH = "4" *) (* C_AXI_SLAVE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) 
(* C_BYTE_SIZE = "9" *) (* C_COMMON_CLK = "1" *) (* C_COUNT_18K_BRAM = "0" *) 
(* C_COUNT_36K_BRAM = "1" *) (* C_CTRL_ECC_ALGO = "NONE" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DISABLE_WARN_BHV_COLL = "0" *) (* C_DISABLE_WARN_BHV_RANGE = "0" *) (* C_ELABORATION_DIR = "./" *) 
(* C_ENABLE_32BIT_ADDRESS = "0" *) (* C_EN_DEEPSLEEP_PIN = "0" *) (* C_EN_ECC_PIPE = "0" *) 
(* C_EN_RDADDRA_CHG = "0" *) (* C_EN_RDADDRB_CHG = "0" *) (* C_EN_SAFETY_CKT = "0" *) 
(* C_EN_SHUTDOWN_PIN = "0" *) (* C_EN_SLEEP_PIN = "0" *) (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.708242 mW" *) 
(* C_FAMILY = "kintexu" *) (* C_HAS_AXI_ID = "0" *) (* C_HAS_ENA = "1" *) 
(* C_HAS_ENB = "1" *) (* C_HAS_INJECTERR = "0" *) (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
(* C_HAS_MEM_OUTPUT_REGS_B = "1" *) (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
(* C_HAS_REGCEA = "0" *) (* C_HAS_REGCEB = "0" *) (* C_HAS_RSTA = "0" *) 
(* C_HAS_RSTB = "0" *) (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "sincos135_table_dprom.mem" *) 
(* C_INIT_FILE_NAME = "sincos135_table_dprom.mif" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "1" *) 
(* C_MEM_TYPE = "4" *) (* C_MUX_PIPELINE_STAGES = "0" *) (* C_PRIM_TYPE = "1" *) 
(* C_READ_DEPTH_A = "1024" *) (* C_READ_DEPTH_B = "1024" *) (* C_READ_WIDTH_A = "36" *) 
(* C_READ_WIDTH_B = "36" *) (* C_RSTRAM_A = "0" *) (* C_RSTRAM_B = "0" *) 
(* C_RST_PRIORITY_A = "CE" *) (* C_RST_PRIORITY_B = "CE" *) (* C_SIM_COLLISION_CHECK = "ALL" *) 
(* C_USE_BRAM_BLOCK = "0" *) (* C_USE_BYTE_WEA = "0" *) (* C_USE_BYTE_WEB = "0" *) 
(* C_USE_DEFAULT_DATA = "0" *) (* C_USE_ECC = "0" *) (* C_USE_SOFTECC = "0" *) 
(* C_USE_URAM = "0" *) (* C_WEA_WIDTH = "1" *) (* C_WEB_WIDTH = "1" *) 
(* C_WRITE_DEPTH_A = "1024" *) (* C_WRITE_DEPTH_B = "1024" *) (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
(* C_WRITE_MODE_B = "WRITE_FIRST" *) (* C_WRITE_WIDTH_A = "36" *) (* C_WRITE_WIDTH_B = "36" *) 
(* C_XDEVICEFAMILY = "kintexu" *) (* ORIG_REF_NAME = "blk_mem_gen_v8_3_6" *) (* downgradeipidentifiedwarnings = "yes" *) 
module sincos135_table_dprom_blk_mem_gen_v8_3_6
   (clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    doutb,
    injectsbiterr,
    injectdbiterr,
    eccpipece,
    sbiterr,
    dbiterr,
    rdaddrecc,
    sleep,
    deepsleep,
    shutdown,
    rsta_busy,
    rstb_busy,
    s_aclk,
    s_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    s_axi_injectsbiterr,
    s_axi_injectdbiterr,
    s_axi_sbiterr,
    s_axi_dbiterr,
    s_axi_rdaddrecc);
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [0:0]wea;
  input [9:0]addra;
  input [35:0]dina;
  output [35:0]douta;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [9:0]addrb;
  input [35:0]dinb;
  output [35:0]doutb;
  input injectsbiterr;
  input injectdbiterr;
  input eccpipece;
  output sbiterr;
  output dbiterr;
  output [9:0]rdaddrecc;
  input sleep;
  input deepsleep;
  input shutdown;
  output rsta_busy;
  output rstb_busy;
  input s_aclk;
  input s_aresetn;
  input [3:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awvalid;
  output s_axi_awready;
  input [35:0]s_axi_wdata;
  input [0:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [3:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [3:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arvalid;
  output s_axi_arready;
  output [3:0]s_axi_rid;
  output [35:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input s_axi_injectsbiterr;
  input s_axi_injectdbiterr;
  output s_axi_sbiterr;
  output s_axi_dbiterr;
  output [9:0]s_axi_rdaddrecc;

  wire \<const0> ;
  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire [35:0]douta;
  wire [35:0]doutb;
  wire ena;
  wire enb;
  wire sleep;

  assign dbiterr = \<const0> ;
  assign rdaddrecc[9] = \<const0> ;
  assign rdaddrecc[8] = \<const0> ;
  assign rdaddrecc[7] = \<const0> ;
  assign rdaddrecc[6] = \<const0> ;
  assign rdaddrecc[5] = \<const0> ;
  assign rdaddrecc[4] = \<const0> ;
  assign rdaddrecc[3] = \<const0> ;
  assign rdaddrecc[2] = \<const0> ;
  assign rdaddrecc[1] = \<const0> ;
  assign rdaddrecc[0] = \<const0> ;
  assign rsta_busy = \<const0> ;
  assign rstb_busy = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[3] = \<const0> ;
  assign s_axi_bid[2] = \<const0> ;
  assign s_axi_bid[1] = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_dbiterr = \<const0> ;
  assign s_axi_rdaddrecc[9] = \<const0> ;
  assign s_axi_rdaddrecc[8] = \<const0> ;
  assign s_axi_rdaddrecc[7] = \<const0> ;
  assign s_axi_rdaddrecc[6] = \<const0> ;
  assign s_axi_rdaddrecc[5] = \<const0> ;
  assign s_axi_rdaddrecc[4] = \<const0> ;
  assign s_axi_rdaddrecc[3] = \<const0> ;
  assign s_axi_rdaddrecc[2] = \<const0> ;
  assign s_axi_rdaddrecc[1] = \<const0> ;
  assign s_axi_rdaddrecc[0] = \<const0> ;
  assign s_axi_rdata[35] = \<const0> ;
  assign s_axi_rdata[34] = \<const0> ;
  assign s_axi_rdata[33] = \<const0> ;
  assign s_axi_rdata[32] = \<const0> ;
  assign s_axi_rdata[31] = \<const0> ;
  assign s_axi_rdata[30] = \<const0> ;
  assign s_axi_rdata[29] = \<const0> ;
  assign s_axi_rdata[28] = \<const0> ;
  assign s_axi_rdata[27] = \<const0> ;
  assign s_axi_rdata[26] = \<const0> ;
  assign s_axi_rdata[25] = \<const0> ;
  assign s_axi_rdata[24] = \<const0> ;
  assign s_axi_rdata[23] = \<const0> ;
  assign s_axi_rdata[22] = \<const0> ;
  assign s_axi_rdata[21] = \<const0> ;
  assign s_axi_rdata[20] = \<const0> ;
  assign s_axi_rdata[19] = \<const0> ;
  assign s_axi_rdata[18] = \<const0> ;
  assign s_axi_rdata[17] = \<const0> ;
  assign s_axi_rdata[16] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7] = \<const0> ;
  assign s_axi_rdata[6] = \<const0> ;
  assign s_axi_rdata[5] = \<const0> ;
  assign s_axi_rdata[4] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[3] = \<const0> ;
  assign s_axi_rid[2] = \<const0> ;
  assign s_axi_rid[1] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_sbiterr = \<const0> ;
  assign s_axi_wready = \<const0> ;
  assign sbiterr = \<const0> ;
  GND GND
       (.G(\<const0> ));
  sincos135_table_dprom_blk_mem_gen_v8_3_6_synth inst_blk_mem_gen
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .douta(douta),
        .doutb(doutb),
        .ena(ena),
        .enb(enb),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_3_6_synth" *) 
module sincos135_table_dprom_blk_mem_gen_v8_3_6_synth
   (douta,
    doutb,
    clka,
    ena,
    enb,
    sleep,
    addra,
    addrb);
  output [35:0]douta;
  output [35:0]doutb;
  input clka;
  input ena;
  input enb;
  input sleep;
  input [9:0]addra;
  input [9:0]addrb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire [35:0]douta;
  wire [35:0]doutb;
  wire ena;
  wire enb;
  wire sleep;

  sincos135_table_dprom_blk_mem_gen_top \gnbram.gnativebmg.native_blk_mem_gen 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .douta(douta),
        .doutb(doutb),
        .ena(ena),
        .enb(enb),
        .sleep(sleep));
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
