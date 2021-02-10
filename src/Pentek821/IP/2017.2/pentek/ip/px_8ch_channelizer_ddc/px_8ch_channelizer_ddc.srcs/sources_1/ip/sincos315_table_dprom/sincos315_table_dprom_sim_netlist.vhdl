-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
-- Date        : Tue May  9 12:00:40 2017
-- Host        : Rich-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Pentek/IP/2017.1/wip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/sincos315_table_dprom/sincos315_table_dprom_sim_netlist.vhdl
-- Design      : sincos315_table_dprom
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku060-ffva1517-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sincos315_table_dprom_blk_mem_gen_prim_wrapper_init is
  port (
    douta : out STD_LOGIC_VECTOR ( 35 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    enb : in STD_LOGIC;
    sleep : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of sincos315_table_dprom_blk_mem_gen_prim_wrapper_init : entity is "blk_mem_gen_prim_wrapper_init";
end sincos315_table_dprom_blk_mem_gen_prim_wrapper_init;

architecture STRUCTURE of sincos315_table_dprom_blk_mem_gen_prim_wrapper_init is
  signal \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute box_type : string;
  attribute box_type of \DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\ : label is "PRIMITIVE";
begin
\DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram\: unisim.vcomponents.RAMB36E2
    generic map(
      CASCADE_ORDER_A => "NONE",
      CASCADE_ORDER_B => "NONE",
      CLOCK_DOMAINS => "COMMON",
      DOA_REG => 1,
      DOB_REG => 1,
      ENADDRENA => "FALSE",
      ENADDRENB => "FALSE",
      EN_ECC_PIPE => "FALSE",
      EN_ECC_READ => "FALSE",
      EN_ECC_WRITE => "FALSE",
      INITP_00 => X"4445511400415151040044440000444511500415041541541014445454554110",
      INITP_01 => X"2276676767772327627627362733622677733337777337326262733722667774",
      INITP_02 => X"2226677233276767323322223333222677633276327627627372226262662773",
      INITP_03 => X"BBEAAEAEAEEEBFBEABEABEFABEFFABBAEEEFFFFEEEEFFEFBABABEFFEBBAAEEE2",
      INITP_04 => X"BBBAAEEBFFBEAEAEFBFFBBBBFFFFBBBAEEAFFBEAFBEABEABEFEBBBABABAABEEF",
      INITP_05 => X"DD8998989888DCD89D89D8C9D8CC9DD9888CCCC8888CC8CD9D9D8CC8DD998888",
      INITP_06 => X"DDD9988DCCD89898CDCCDDDDCCCCDDD9889CCD89CD89D89D8C8DDD9D9D99D88C",
      INITP_07 => X"4415515151114041541541054100544511100001111001045454100144551111",
      INITP_08 => X"4415515151114041541541054100544511100001111001045454100144551111",
      INITP_09 => X"4445511400415151040044440000444511500415041541541014445454554110",
      INITP_0A => X"2276676767772327627627362733622677733337777337326262733722667774",
      INITP_0B => X"2226677233276767323322223333222677633276327627627372226262662773",
      INITP_0C => X"BBEAAEAEAEEEBFBEABEABEFABEFFABBAEEEFFFFEEEEFFEFBABABEFFEBBAAEEE2",
      INITP_0D => X"BBBAAEEBFFBEAEAEFBFFBBBBFFFFBBBAEEAFFBEAFBEABEABEFEBBBABABAABEEF",
      INITP_0E => X"DD8998989888DCD89D89D8C9D8CC9DD9888CCCC8888CC8CD9D9D8CC8DD998888",
      INITP_0F => X"DDD9988DCCD89898CDCCDDDDCCCCDDD9889CCD89CD89D89D8C8DDD9D9D99D88C",
      INIT_00 => X"C3C2A4A3C1AFA76BBF8DA927BD5CABD5BB1DAE76B9CFB00AB773B290B508B508",
      INIT_01 => X"D32F90A6D19993CFCFF395EDCD3C98FECB769B04C9A19DFEC7BB9FECC5C6A2CE",
      INIT_02 => X"E08B7BE0DE7A7E5CDD5980CFDB268337D9E38696D88F88EAD62A8B34D4B58E73",
      INIT_03 => X"EB9464B9EA11677BE87D6A35E7D66DE8E61D7091E4537333E37775CBE189785A",
      INIT_04 => X"F4164DA0F327509AF225538EF110567CEFE95963EEAF5C43ED635F1DEC0561EE",
      INIT_05 => X"FAE4350AF98D382EF9233B4DF8A63E67F716417DF672448EF5BC479AF4F24AA0",
      INIT_06 => X"FEDF1C6FFE241FACFD5622E7FD732520FC7E2856FC742B88FB582EB7FB2831E2",
      INIT_07 => X"FFF40348FFD70691FFA509D8FF600C1FFF070F65FF9B12AAFF1B15EDFE87192F",
      INIT_08 => X"FF1BEA13FF9BED56FF07F09BFF60F3E1FFA5F628FFD7F96FFFF4FCB8FFFE0000",
      INIT_09 => X"FB58D149FC74D478FC7ED7AAFD73DAE0FD56DD19FE24E054FEDFE391FE87E6D1",
      INIT_0A => X"F5BCB866F672BB72F716BE83F8A6C199F923C4B3F98DC7D2FAE4CAF6FB28CE1E",
      INIT_0B => X"ED63A0E3EEAFA3BDEFE9A69DF110A984F225AC72F327AF66F416B260F4F2B560",
      INIT_0C => X"E3778A35E4538CCDE61D8F6FE7D69218E87D95CBEA119885EB949B47EC059E12",
      INIT_0D => X"D62A74CCD88F7716D9E3796ADB267CC9DD597F31DE7A81A4E08B8420E18987A6",
      INIT_0E => X"C7BB6014C9A16202CB7664FCCD3C6702CFF36A13D1996C31D32F6F5AD4B5718D",
      INIT_0F => X"B7734D70B9CF4FF6BB1D518ABD5C542BBF8D56D9C1AF5895C3C25B5DC5C65D32",
      INIT_10 => X"A4A33C3EA76B3E51A9274073ABD542A4AE7644E3B00A4631B290488DB5084AF8",
      INIT_11 => X"90A62CD193CF2E6795ED300D98FE32C49B04348A9DFE365F9FEC3845A2CE3A3A",
      INIT_12 => X"7BE01F757E5C218680CF22A7833724DA8696261D88EA27718B3429D68E732B4B",
      INIT_13 => X"64B9146C677B15EF6A3517836DE8182A709119E373331BAD75CB1C89785A1E77",
      INIT_14 => X"4DA00BEA509A0CD9538E0DDB567C0EF0596310175C4311515F1D129D61EE13FB",
      INIT_15 => X"350A051C382E06733B4D06DD3E67075A417D08EA448E098E479A0A444AA00B0E",
      INIT_16 => X"1C6F01211FAC01DC22E702AA2520028D285603822B88038C2EB704A831E204D8",
      INIT_17 => X"0348000C0691002909D8005B0C1F00A00F6500F912AA006515ED00E5192F0179",
      INIT_18 => X"EA1300E5ED560065F09B00F9F3E100A0F628005BF96F0029FCB8000C00000002",
      INIT_19 => X"D14904A8D478038CD7AA0382DAE0028DDD1902AAE05401DCE3910121E6D10179",
      INIT_1A => X"B8660A44BB72098EBE8308EAC199075AC4B306DDC7D20673CAF6051CCE1E04D8",
      INIT_1B => X"A0E3129DA3BD1151A69D1017A9840EF0AC720DDBAF660CD9B2600BEAB5600B0E",
      INIT_1C => X"8A351C898CCD1BAD8F6F19E39218182A95CB1783988515EF9B47146C9E1213FB",
      INIT_1D => X"74CC29D677162771796A261D7CC924DA7F3122A781A4218684201F7587A61E77",
      INIT_1E => X"601438456202365F64FC348A670232C46A13300D6C312E676F5A2CD1718D2B4B",
      INIT_1F => X"4D70488D4FF64631518A44E3542B42A456D9407358953E515B5D3C3E5D323A3A",
      INIT_20 => X"3C3E5B5D3E515895407356D942A4542B44E3518A46314FF6488D4D704AF84AF8",
      INIT_21 => X"2CD16F5A2E676C31300D6A1332C46702348A64FC365F6202384560143A3A5D32",
      INIT_22 => X"1F758420218681A422A77F3124DA7CC9261D796A2771771629D674CC2B4B718D",
      INIT_23 => X"146C9B4715EF9885178395CB182A921819E38F6F1BAD8CCD1C898A351E7787A6",
      INIT_24 => X"0BEAB2600CD9AF660DDBAC720EF0A9841017A69D1151A3BD129DA0E313FB9E12",
      INIT_25 => X"051CCAF60673C7D206DDC4B3075AC19908EABE83098EBB720A44B8660B0EB560",
      INIT_26 => X"0121E39101DCE05402AADD19028DDAE00382D7AA038CD47804A8D14904D8CE1E",
      INIT_27 => X"000CFCB80029F96F005BF62800A0F3E100F9F09B0065ED5600E5EA130179E6D1",
      INIT_28 => X"00E515ED006512AA00F90F6500A00C1F005B09D800290691000C034800020000",
      INIT_29 => X"04A82EB7038C2B8803822856028D252002AA22E701DC1FAC01211C6F0179192F",
      INIT_2A => X"0A44479A098E448E08EA417D075A3E6706DD3B4D0673382E051C350A04D831E2",
      INIT_2B => X"129D5F1D11515C43101759630EF0567C0DDB538E0CD9509A0BEA4DA00B0E4AA0",
      INIT_2C => X"1C8975CB1BAD733319E37091182A6DE817836A3515EF677B146C64B913FB61EE",
      INIT_2D => X"29D68B34277188EA261D869624DA833722A780CF21867E5C1F757BE01E77785A",
      INIT_2E => X"38459FEC365F9DFE348A9B0432C498FE300D95ED2E6793CF2CD190A62B4B8E73",
      INIT_2F => X"488DB2904631B00A44E3AE7642A4ABD54073A9273E51A76B3C3EA4A33A3AA2CE",
      INIT_30 => X"5B5DC3C25895C1AF56D9BF8D542BBD5C518ABB1D4FF6B9CF4D70B7734AF8B508",
      INIT_31 => X"6F5AD32F6C31D1996A13CFF36702CD3C64FCCB766202C9A16014C7BB5D32C5C6",
      INIT_32 => X"8420E08B81A4DE7A7F31DD597CC9DB26796AD9E37716D88F74CCD62A718DD4B5",
      INIT_33 => X"9B47EB949885EA1195CBE87D9218E7D68F6FE61D8CCDE4538A35E37787A6E189",
      INIT_34 => X"B260F416AF66F327AC72F225A984F110A69DEFE9A3BDEEAFA0E3ED639E12EC05",
      INIT_35 => X"CAF6FAE4C7D2F98DC4B3F923C199F8A6BE83F716BB72F672B866F5BCB560F4F2",
      INIT_36 => X"E391FEDFE054FE24DD19FD56DAE0FD73D7AAFC7ED478FC74D149FB58CE1EFB28",
      INIT_37 => X"FCB8FFF4F96FFFD7F628FFA5F3E1FF60F09BFF07ED56FF9BEA13FF1BE6D1FE87",
      INIT_38 => X"15EDFF1B12AAFF9B0F65FF070C1FFF6009D8FFA50691FFD70348FFF40000FFFE",
      INIT_39 => X"2EB7FB582B88FC742856FC7E2520FD7322E7FD561FACFE241C6FFEDF192FFE87",
      INIT_3A => X"479AF5BC448EF672417DF7163E67F8A63B4DF923382EF98D350AFAE431E2FB28",
      INIT_3B => X"5F1DED635C43EEAF5963EFE9567CF110538EF225509AF3274DA0F4164AA0F4F2",
      INIT_3C => X"75CBE3777333E4537091E61D6DE8E7D66A35E87D677BEA1164B9EB9461EEEC05",
      INIT_3D => X"8B34D62A88EAD88F8696D9E38337DB2680CFDD597E5CDE7A7BE0E08B785AE189",
      INIT_3E => X"9FECC7BB9DFEC9A19B04CB7698FECD3C95EDCFF393CFD19990A6D32F8E73D4B5",
      INIT_3F => X"B290B773B00AB9CFAE76BB1DABD5BD5CA927BF8DA76BC1AFA4A3C3C2A2CEC5C6",
      INIT_40 => X"15EDFF1B12AAFF9B0F65FF070C1FFF6009D8FFA50691FFD70348FFF40000FFFE",
      INIT_41 => X"2EB7FB582B88FC742856FC7E2520FD7322E7FD561FACFE241C6FFEDF192FFE87",
      INIT_42 => X"479AF5BC448EF672417DF7163E67F8A63B4DF923382EF98D350AFAE431E2FB28",
      INIT_43 => X"5F1DED635C43EEAF5963EFE9567CF110538EF225509AF3274DA0F4164AA0F4F2",
      INIT_44 => X"75CBE3777333E4537091E61D6DE8E7D66A35E87D677BEA1164B9EB9461EEEC05",
      INIT_45 => X"8B34D62A88EAD88F8696D9E38337DB2680CFDD597E5CDE7A7BE0E08B785AE189",
      INIT_46 => X"9FECC7BB9DFEC9A19B04CB7698FECD3C95EDCFF393CFD19990A6D32F8E73D4B5",
      INIT_47 => X"B290B773B00AB9CFAE76BB1DABD5BD5CA927BF8DA76BC1AFA4A3C3C2A2CEC5C6",
      INIT_48 => X"C3C2A4A3C1AFA76BBF8DA927BD5CABD5BB1DAE76B9CFB00AB773B290B508B508",
      INIT_49 => X"D32F90A6D19993CFCFF395EDCD3C98FECB769B04C9A19DFEC7BB9FECC5C6A2CE",
      INIT_4A => X"E08B7BE0DE7A7E5CDD5980CFDB268337D9E38696D88F88EAD62A8B34D4B58E73",
      INIT_4B => X"EB9464B9EA11677BE87D6A35E7D66DE8E61D7091E4537333E37775CBE189785A",
      INIT_4C => X"F4164DA0F327509AF225538EF110567CEFE95963EEAF5C43ED635F1DEC0561EE",
      INIT_4D => X"FAE4350AF98D382EF9233B4DF8A63E67F716417DF672448EF5BC479AF4F24AA0",
      INIT_4E => X"FEDF1C6FFE241FACFD5622E7FD732520FC7E2856FC742B88FB582EB7FB2831E2",
      INIT_4F => X"FFF40348FFD70691FFA509D8FF600C1FFF070F65FF9B12AAFF1B15EDFE87192F",
      INIT_50 => X"FF1BEA13FF9BED56FF07F09BFF60F3E1FFA5F628FFD7F96FFFF4FCB8FFFE0000",
      INIT_51 => X"FB58D149FC74D478FC7ED7AAFD73DAE0FD56DD19FE24E054FEDFE391FE87E6D1",
      INIT_52 => X"F5BCB866F672BB72F716BE83F8A6C199F923C4B3F98DC7D2FAE4CAF6FB28CE1E",
      INIT_53 => X"ED63A0E3EEAFA3BDEFE9A69DF110A984F225AC72F327AF66F416B260F4F2B560",
      INIT_54 => X"E3778A35E4538CCDE61D8F6FE7D69218E87D95CBEA119885EB949B47EC059E12",
      INIT_55 => X"D62A74CCD88F7716D9E3796ADB267CC9DD597F31DE7A81A4E08B8420E18987A6",
      INIT_56 => X"C7BB6014C9A16202CB7664FCCD3C6702CFF36A13D1996C31D32F6F5AD4B5718D",
      INIT_57 => X"B7734D70B9CF4FF6BB1D518ABD5C542BBF8D56D9C1AF5895C3C25B5DC5C65D32",
      INIT_58 => X"A4A33C3EA76B3E51A9274073ABD542A4AE7644E3B00A4631B290488DB5084AF8",
      INIT_59 => X"90A62CD193CF2E6795ED300D98FE32C49B04348A9DFE365F9FEC3845A2CE3A3A",
      INIT_5A => X"7BE01F757E5C218680CF22A7833724DA8696261D88EA27718B3429D68E732B4B",
      INIT_5B => X"64B9146C677B15EF6A3517836DE8182A709119E373331BAD75CB1C89785A1E77",
      INIT_5C => X"4DA00BEA509A0CD9538E0DDB567C0EF0596310175C4311515F1D129D61EE13FB",
      INIT_5D => X"350A051C382E06733B4D06DD3E67075A417D08EA448E098E479A0A444AA00B0E",
      INIT_5E => X"1C6F01211FAC01DC22E702AA2520028D285603822B88038C2EB704A831E204D8",
      INIT_5F => X"0348000C0691002909D8005B0C1F00A00F6500F912AA006515ED00E5192F0179",
      INIT_60 => X"EA1300E5ED560065F09B00F9F3E100A0F628005BF96F0029FCB8000C00000002",
      INIT_61 => X"D14904A8D478038CD7AA0382DAE0028DDD1902AAE05401DCE3910121E6D10179",
      INIT_62 => X"B8660A44BB72098EBE8308EAC199075AC4B306DDC7D20673CAF6051CCE1E04D8",
      INIT_63 => X"A0E3129DA3BD1151A69D1017A9840EF0AC720DDBAF660CD9B2600BEAB5600B0E",
      INIT_64 => X"8A351C898CCD1BAD8F6F19E39218182A95CB1783988515EF9B47146C9E1213FB",
      INIT_65 => X"74CC29D677162771796A261D7CC924DA7F3122A781A4218684201F7587A61E77",
      INIT_66 => X"601438456202365F64FC348A670232C46A13300D6C312E676F5A2CD1718D2B4B",
      INIT_67 => X"4D70488D4FF64631518A44E3542B42A456D9407358953E515B5D3C3E5D323A3A",
      INIT_68 => X"3C3E5B5D3E515895407356D942A4542B44E3518A46314FF6488D4D704AF84AF8",
      INIT_69 => X"2CD16F5A2E676C31300D6A1332C46702348A64FC365F6202384560143A3A5D32",
      INIT_6A => X"1F758420218681A422A77F3124DA7CC9261D796A2771771629D674CC2B4B718D",
      INIT_6B => X"146C9B4715EF9885178395CB182A921819E38F6F1BAD8CCD1C898A351E7787A6",
      INIT_6C => X"0BEAB2600CD9AF660DDBAC720EF0A9841017A69D1151A3BD129DA0E313FB9E12",
      INIT_6D => X"051CCAF60673C7D206DDC4B3075AC19908EABE83098EBB720A44B8660B0EB560",
      INIT_6E => X"0121E39101DCE05402AADD19028DDAE00382D7AA038CD47804A8D14904D8CE1E",
      INIT_6F => X"000CFCB80029F96F005BF62800A0F3E100F9F09B0065ED5600E5EA130179E6D1",
      INIT_70 => X"00E515ED006512AA00F90F6500A00C1F005B09D800290691000C034800020000",
      INIT_71 => X"04A82EB7038C2B8803822856028D252002AA22E701DC1FAC01211C6F0179192F",
      INIT_72 => X"0A44479A098E448E08EA417D075A3E6706DD3B4D0673382E051C350A04D831E2",
      INIT_73 => X"129D5F1D11515C43101759630EF0567C0DDB538E0CD9509A0BEA4DA00B0E4AA0",
      INIT_74 => X"1C8975CB1BAD733319E37091182A6DE817836A3515EF677B146C64B913FB61EE",
      INIT_75 => X"29D68B34277188EA261D869624DA833722A780CF21867E5C1F757BE01E77785A",
      INIT_76 => X"38459FEC365F9DFE348A9B0432C498FE300D95ED2E6793CF2CD190A62B4B8E73",
      INIT_77 => X"488DB2904631B00A44E3AE7642A4ABD54073A9273E51A76B3C3EA4A33A3AA2CE",
      INIT_78 => X"5B5DC3C25895C1AF56D9BF8D542BBD5C518ABB1D4FF6B9CF4D70B7734AF8B508",
      INIT_79 => X"6F5AD32F6C31D1996A13CFF36702CD3C64FCCB766202C9A16014C7BB5D32C5C6",
      INIT_7A => X"8420E08B81A4DE7A7F31DD597CC9DB26796AD9E37716D88F74CCD62A718DD4B5",
      INIT_7B => X"9B47EB949885EA1195CBE87D9218E7D68F6FE61D8CCDE4538A35E37787A6E189",
      INIT_7C => X"B260F416AF66F327AC72F225A984F110A69DEFE9A3BDEEAFA0E3ED639E12EC05",
      INIT_7D => X"CAF6FAE4C7D2F98DC4B3F923C199F8A6BE83F716BB72F672B866F5BCB560F4F2",
      INIT_7E => X"E391FEDFE054FE24DD19FD56DAE0FD73D7AAFC7ED478FC74D149FB58CE1EFB28",
      INIT_7F => X"FCB8FFF4F96FFFD7F628FFA5F3E1FF60F09BFF07ED56FF9BEA13FF1BE6D1FE87",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RDADDRCHANGEA => "FALSE",
      RDADDRCHANGEB => "FALSE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      RSTREG_PRIORITY_A => "REGCE",
      RSTREG_PRIORITY_B => "REGCE",
      SIM_COLLISION_CHECK => "ALL",
      SLEEP_ASYNC => "FALSE",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36
    )
        port map (
      ADDRARDADDR(14 downto 5) => addra(9 downto 0),
      ADDRARDADDR(4 downto 0) => B"00000",
      ADDRBWRADDR(14 downto 5) => addrb(9 downto 0),
      ADDRBWRADDR(4 downto 0) => B"00000",
      ADDRENA => '0',
      ADDRENB => '0',
      CASDIMUXA => '0',
      CASDIMUXB => '0',
      CASDINA(31 downto 0) => B"00000000000000000000000000000000",
      CASDINB(31 downto 0) => B"00000000000000000000000000000000",
      CASDINPA(3 downto 0) => B"0000",
      CASDINPB(3 downto 0) => B"0000",
      CASDOMUXA => '0',
      CASDOMUXB => '0',
      CASDOMUXEN_A => '0',
      CASDOMUXEN_B => '0',
      CASDOUTA(31 downto 0) => \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED\(31 downto 0),
      CASDOUTB(31 downto 0) => \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED\(31 downto 0),
      CASDOUTPA(3 downto 0) => \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED\(3 downto 0),
      CASDOUTPB(3 downto 0) => \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED\(3 downto 0),
      CASINDBITERR => '0',
      CASINSBITERR => '0',
      CASOREGIMUXA => '0',
      CASOREGIMUXB => '0',
      CASOREGIMUXEN_A => '0',
      CASOREGIMUXEN_B => '0',
      CASOUTDBITERR => \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED\,
      CASOUTSBITERR => \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clka,
      DBITERR => \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\,
      DINADIN(31 downto 0) => B"00000000000000000000000000000000",
      DINBDIN(31 downto 0) => B"00000000000000000000000000000000",
      DINPADINP(3 downto 0) => B"0000",
      DINPBDINP(3 downto 0) => B"0000",
      DOUTADOUT(31 downto 24) => douta(34 downto 27),
      DOUTADOUT(23 downto 16) => douta(25 downto 18),
      DOUTADOUT(15 downto 8) => douta(16 downto 9),
      DOUTADOUT(7 downto 0) => douta(7 downto 0),
      DOUTBDOUT(31 downto 24) => doutb(34 downto 27),
      DOUTBDOUT(23 downto 16) => doutb(25 downto 18),
      DOUTBDOUT(15 downto 8) => doutb(16 downto 9),
      DOUTBDOUT(7 downto 0) => doutb(7 downto 0),
      DOUTPADOUTP(3) => douta(35),
      DOUTPADOUTP(2) => douta(26),
      DOUTPADOUTP(1) => douta(17),
      DOUTPADOUTP(0) => douta(8),
      DOUTPBDOUTP(3) => doutb(35),
      DOUTPBDOUTP(2) => doutb(26),
      DOUTPBDOUTP(1) => doutb(17),
      DOUTPBDOUTP(0) => doutb(8),
      ECCPARITY(7 downto 0) => \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\(7 downto 0),
      ECCPIPECE => '0',
      ENARDEN => ena,
      ENBWREN => enb,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => ena,
      REGCEB => enb,
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_DEVICE_8SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\,
      SLEEP => sleep,
      WEA(3 downto 0) => B"0000",
      WEBWE(7 downto 0) => B"00000000"
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sincos315_table_dprom_blk_mem_gen_prim_width is
  port (
    douta : out STD_LOGIC_VECTOR ( 35 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    enb : in STD_LOGIC;
    sleep : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of sincos315_table_dprom_blk_mem_gen_prim_width : entity is "blk_mem_gen_prim_width";
end sincos315_table_dprom_blk_mem_gen_prim_width;

architecture STRUCTURE of sincos315_table_dprom_blk_mem_gen_prim_width is
begin
\prim_init.ram\: entity work.sincos315_table_dprom_blk_mem_gen_prim_wrapper_init
     port map (
      addra(9 downto 0) => addra(9 downto 0),
      addrb(9 downto 0) => addrb(9 downto 0),
      clka => clka,
      douta(35 downto 0) => douta(35 downto 0),
      doutb(35 downto 0) => doutb(35 downto 0),
      ena => ena,
      enb => enb,
      sleep => sleep
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sincos315_table_dprom_blk_mem_gen_generic_cstr is
  port (
    douta : out STD_LOGIC_VECTOR ( 35 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    enb : in STD_LOGIC;
    sleep : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of sincos315_table_dprom_blk_mem_gen_generic_cstr : entity is "blk_mem_gen_generic_cstr";
end sincos315_table_dprom_blk_mem_gen_generic_cstr;

architecture STRUCTURE of sincos315_table_dprom_blk_mem_gen_generic_cstr is
begin
\ramloop[0].ram.r\: entity work.sincos315_table_dprom_blk_mem_gen_prim_width
     port map (
      addra(9 downto 0) => addra(9 downto 0),
      addrb(9 downto 0) => addrb(9 downto 0),
      clka => clka,
      douta(35 downto 0) => douta(35 downto 0),
      doutb(35 downto 0) => doutb(35 downto 0),
      ena => ena,
      enb => enb,
      sleep => sleep
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sincos315_table_dprom_blk_mem_gen_top is
  port (
    douta : out STD_LOGIC_VECTOR ( 35 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    enb : in STD_LOGIC;
    sleep : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of sincos315_table_dprom_blk_mem_gen_top : entity is "blk_mem_gen_top";
end sincos315_table_dprom_blk_mem_gen_top;

architecture STRUCTURE of sincos315_table_dprom_blk_mem_gen_top is
begin
\valid.cstr\: entity work.sincos315_table_dprom_blk_mem_gen_generic_cstr
     port map (
      addra(9 downto 0) => addra(9 downto 0),
      addrb(9 downto 0) => addrb(9 downto 0),
      clka => clka,
      douta(35 downto 0) => douta(35 downto 0),
      doutb(35 downto 0) => doutb(35 downto 0),
      ena => ena,
      enb => enb,
      sleep => sleep
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sincos315_table_dprom_blk_mem_gen_v8_3_6_synth is
  port (
    douta : out STD_LOGIC_VECTOR ( 35 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    enb : in STD_LOGIC;
    sleep : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of sincos315_table_dprom_blk_mem_gen_v8_3_6_synth : entity is "blk_mem_gen_v8_3_6_synth";
end sincos315_table_dprom_blk_mem_gen_v8_3_6_synth;

architecture STRUCTURE of sincos315_table_dprom_blk_mem_gen_v8_3_6_synth is
begin
\gnbram.gnativebmg.native_blk_mem_gen\: entity work.sincos315_table_dprom_blk_mem_gen_top
     port map (
      addra(9 downto 0) => addra(9 downto 0),
      addrb(9 downto 0) => addrb(9 downto 0),
      clka => clka,
      douta(35 downto 0) => douta(35 downto 0),
      doutb(35 downto 0) => doutb(35 downto 0),
      ena => ena,
      enb => enb,
      sleep => sleep
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sincos315_table_dprom_blk_mem_gen_v8_3_6 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    regcea : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 35 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 35 downto 0 );
    clkb : in STD_LOGIC;
    rstb : in STD_LOGIC;
    enb : in STD_LOGIC;
    regceb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 0 to 0 );
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 35 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    injectsbiterr : in STD_LOGIC;
    injectdbiterr : in STD_LOGIC;
    eccpipece : in STD_LOGIC;
    sbiterr : out STD_LOGIC;
    dbiterr : out STD_LOGIC;
    rdaddrecc : out STD_LOGIC_VECTOR ( 9 downto 0 );
    sleep : in STD_LOGIC;
    deepsleep : in STD_LOGIC;
    shutdown : in STD_LOGIC;
    rsta_busy : out STD_LOGIC;
    rstb_busy : out STD_LOGIC;
    s_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 35 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 35 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    s_axi_injectsbiterr : in STD_LOGIC;
    s_axi_injectdbiterr : in STD_LOGIC;
    s_axi_sbiterr : out STD_LOGIC;
    s_axi_dbiterr : out STD_LOGIC;
    s_axi_rdaddrecc : out STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  attribute C_ADDRA_WIDTH : integer;
  attribute C_ADDRA_WIDTH of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 10;
  attribute C_ADDRB_WIDTH : integer;
  attribute C_ADDRB_WIDTH of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 10;
  attribute C_ALGORITHM : integer;
  attribute C_ALGORITHM of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 4;
  attribute C_AXI_SLAVE_TYPE : integer;
  attribute C_AXI_SLAVE_TYPE of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1;
  attribute C_BYTE_SIZE : integer;
  attribute C_BYTE_SIZE of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 9;
  attribute C_COMMON_CLK : integer;
  attribute C_COMMON_CLK of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1;
  attribute C_COUNT_18K_BRAM : string;
  attribute C_COUNT_18K_BRAM of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "0";
  attribute C_COUNT_36K_BRAM : string;
  attribute C_COUNT_36K_BRAM of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "1";
  attribute C_CTRL_ECC_ALGO : string;
  attribute C_CTRL_ECC_ALGO of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "NONE";
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "0";
  attribute C_DISABLE_WARN_BHV_COLL : integer;
  attribute C_DISABLE_WARN_BHV_COLL of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_DISABLE_WARN_BHV_RANGE : integer;
  attribute C_DISABLE_WARN_BHV_RANGE of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "./";
  attribute C_ENABLE_32BIT_ADDRESS : integer;
  attribute C_ENABLE_32BIT_ADDRESS of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_EN_DEEPSLEEP_PIN : integer;
  attribute C_EN_DEEPSLEEP_PIN of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_EN_ECC_PIPE : integer;
  attribute C_EN_ECC_PIPE of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_EN_RDADDRA_CHG : integer;
  attribute C_EN_RDADDRA_CHG of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_EN_RDADDRB_CHG : integer;
  attribute C_EN_RDADDRB_CHG of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_EN_SAFETY_CKT : integer;
  attribute C_EN_SAFETY_CKT of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_EN_SHUTDOWN_PIN : integer;
  attribute C_EN_SHUTDOWN_PIN of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_EN_SLEEP_PIN : integer;
  attribute C_EN_SLEEP_PIN of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_EST_POWER_SUMMARY : string;
  attribute C_EST_POWER_SUMMARY of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "Estimated Power for IP     :     5.708242 mW";
  attribute C_FAMILY : string;
  attribute C_FAMILY of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "kintexu";
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_HAS_ENA : integer;
  attribute C_HAS_ENA of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1;
  attribute C_HAS_ENB : integer;
  attribute C_HAS_ENB of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1;
  attribute C_HAS_INJECTERR : integer;
  attribute C_HAS_INJECTERR of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_A : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_A of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1;
  attribute C_HAS_MEM_OUTPUT_REGS_B : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_B of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1;
  attribute C_HAS_MUX_OUTPUT_REGS_A : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_A of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_B : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_B of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_HAS_REGCEA : integer;
  attribute C_HAS_REGCEA of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_HAS_REGCEB : integer;
  attribute C_HAS_REGCEB of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_HAS_RSTA : integer;
  attribute C_HAS_RSTA of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_HAS_RSTB : integer;
  attribute C_HAS_RSTB of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_HAS_SOFTECC_INPUT_REGS_A : integer;
  attribute C_HAS_SOFTECC_INPUT_REGS_A of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B : integer;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_INITA_VAL : string;
  attribute C_INITA_VAL of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "0";
  attribute C_INITB_VAL : string;
  attribute C_INITB_VAL of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "0";
  attribute C_INIT_FILE : string;
  attribute C_INIT_FILE of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "sincos315_table_dprom.mem";
  attribute C_INIT_FILE_NAME : string;
  attribute C_INIT_FILE_NAME of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "sincos315_table_dprom.mif";
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_LOAD_INIT_FILE : integer;
  attribute C_LOAD_INIT_FILE of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 4;
  attribute C_MUX_PIPELINE_STAGES : integer;
  attribute C_MUX_PIPELINE_STAGES of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_PRIM_TYPE : integer;
  attribute C_PRIM_TYPE of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1;
  attribute C_READ_DEPTH_A : integer;
  attribute C_READ_DEPTH_A of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1024;
  attribute C_READ_DEPTH_B : integer;
  attribute C_READ_DEPTH_B of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1024;
  attribute C_READ_WIDTH_A : integer;
  attribute C_READ_WIDTH_A of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 36;
  attribute C_READ_WIDTH_B : integer;
  attribute C_READ_WIDTH_B of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 36;
  attribute C_RSTRAM_A : integer;
  attribute C_RSTRAM_A of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_RSTRAM_B : integer;
  attribute C_RSTRAM_B of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_RST_PRIORITY_A : string;
  attribute C_RST_PRIORITY_A of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "CE";
  attribute C_RST_PRIORITY_B : string;
  attribute C_RST_PRIORITY_B of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "CE";
  attribute C_SIM_COLLISION_CHECK : string;
  attribute C_SIM_COLLISION_CHECK of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "ALL";
  attribute C_USE_BRAM_BLOCK : integer;
  attribute C_USE_BRAM_BLOCK of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_USE_BYTE_WEA : integer;
  attribute C_USE_BYTE_WEA of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_USE_BYTE_WEB : integer;
  attribute C_USE_BYTE_WEB of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_USE_DEFAULT_DATA : integer;
  attribute C_USE_DEFAULT_DATA of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_USE_SOFTECC : integer;
  attribute C_USE_SOFTECC of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_USE_URAM : integer;
  attribute C_USE_URAM of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 0;
  attribute C_WEA_WIDTH : integer;
  attribute C_WEA_WIDTH of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1;
  attribute C_WEB_WIDTH : integer;
  attribute C_WEB_WIDTH of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1;
  attribute C_WRITE_DEPTH_A : integer;
  attribute C_WRITE_DEPTH_A of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1024;
  attribute C_WRITE_DEPTH_B : integer;
  attribute C_WRITE_DEPTH_B of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 1024;
  attribute C_WRITE_MODE_A : string;
  attribute C_WRITE_MODE_A of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "WRITE_FIRST";
  attribute C_WRITE_MODE_B : string;
  attribute C_WRITE_MODE_B of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "WRITE_FIRST";
  attribute C_WRITE_WIDTH_A : integer;
  attribute C_WRITE_WIDTH_A of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 36;
  attribute C_WRITE_WIDTH_B : integer;
  attribute C_WRITE_WIDTH_B of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is 36;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "kintexu";
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "blk_mem_gen_v8_3_6";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of sincos315_table_dprom_blk_mem_gen_v8_3_6 : entity is "yes";
end sincos315_table_dprom_blk_mem_gen_v8_3_6;

architecture STRUCTURE of sincos315_table_dprom_blk_mem_gen_v8_3_6 is
  signal \<const0>\ : STD_LOGIC;
begin
  dbiterr <= \<const0>\;
  rdaddrecc(9) <= \<const0>\;
  rdaddrecc(8) <= \<const0>\;
  rdaddrecc(7) <= \<const0>\;
  rdaddrecc(6) <= \<const0>\;
  rdaddrecc(5) <= \<const0>\;
  rdaddrecc(4) <= \<const0>\;
  rdaddrecc(3) <= \<const0>\;
  rdaddrecc(2) <= \<const0>\;
  rdaddrecc(1) <= \<const0>\;
  rdaddrecc(0) <= \<const0>\;
  rsta_busy <= \<const0>\;
  rstb_busy <= \<const0>\;
  s_axi_arready <= \<const0>\;
  s_axi_awready <= \<const0>\;
  s_axi_bid(3) <= \<const0>\;
  s_axi_bid(2) <= \<const0>\;
  s_axi_bid(1) <= \<const0>\;
  s_axi_bid(0) <= \<const0>\;
  s_axi_bresp(1) <= \<const0>\;
  s_axi_bresp(0) <= \<const0>\;
  s_axi_bvalid <= \<const0>\;
  s_axi_dbiterr <= \<const0>\;
  s_axi_rdaddrecc(9) <= \<const0>\;
  s_axi_rdaddrecc(8) <= \<const0>\;
  s_axi_rdaddrecc(7) <= \<const0>\;
  s_axi_rdaddrecc(6) <= \<const0>\;
  s_axi_rdaddrecc(5) <= \<const0>\;
  s_axi_rdaddrecc(4) <= \<const0>\;
  s_axi_rdaddrecc(3) <= \<const0>\;
  s_axi_rdaddrecc(2) <= \<const0>\;
  s_axi_rdaddrecc(1) <= \<const0>\;
  s_axi_rdaddrecc(0) <= \<const0>\;
  s_axi_rdata(35) <= \<const0>\;
  s_axi_rdata(34) <= \<const0>\;
  s_axi_rdata(33) <= \<const0>\;
  s_axi_rdata(32) <= \<const0>\;
  s_axi_rdata(31) <= \<const0>\;
  s_axi_rdata(30) <= \<const0>\;
  s_axi_rdata(29) <= \<const0>\;
  s_axi_rdata(28) <= \<const0>\;
  s_axi_rdata(27) <= \<const0>\;
  s_axi_rdata(26) <= \<const0>\;
  s_axi_rdata(25) <= \<const0>\;
  s_axi_rdata(24) <= \<const0>\;
  s_axi_rdata(23) <= \<const0>\;
  s_axi_rdata(22) <= \<const0>\;
  s_axi_rdata(21) <= \<const0>\;
  s_axi_rdata(20) <= \<const0>\;
  s_axi_rdata(19) <= \<const0>\;
  s_axi_rdata(18) <= \<const0>\;
  s_axi_rdata(17) <= \<const0>\;
  s_axi_rdata(16) <= \<const0>\;
  s_axi_rdata(15) <= \<const0>\;
  s_axi_rdata(14) <= \<const0>\;
  s_axi_rdata(13) <= \<const0>\;
  s_axi_rdata(12) <= \<const0>\;
  s_axi_rdata(11) <= \<const0>\;
  s_axi_rdata(10) <= \<const0>\;
  s_axi_rdata(9) <= \<const0>\;
  s_axi_rdata(8) <= \<const0>\;
  s_axi_rdata(7) <= \<const0>\;
  s_axi_rdata(6) <= \<const0>\;
  s_axi_rdata(5) <= \<const0>\;
  s_axi_rdata(4) <= \<const0>\;
  s_axi_rdata(3) <= \<const0>\;
  s_axi_rdata(2) <= \<const0>\;
  s_axi_rdata(1) <= \<const0>\;
  s_axi_rdata(0) <= \<const0>\;
  s_axi_rid(3) <= \<const0>\;
  s_axi_rid(2) <= \<const0>\;
  s_axi_rid(1) <= \<const0>\;
  s_axi_rid(0) <= \<const0>\;
  s_axi_rlast <= \<const0>\;
  s_axi_rresp(1) <= \<const0>\;
  s_axi_rresp(0) <= \<const0>\;
  s_axi_rvalid <= \<const0>\;
  s_axi_sbiterr <= \<const0>\;
  s_axi_wready <= \<const0>\;
  sbiterr <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst_blk_mem_gen: entity work.sincos315_table_dprom_blk_mem_gen_v8_3_6_synth
     port map (
      addra(9 downto 0) => addra(9 downto 0),
      addrb(9 downto 0) => addrb(9 downto 0),
      clka => clka,
      douta(35 downto 0) => douta(35 downto 0),
      doutb(35 downto 0) => doutb(35 downto 0),
      ena => ena,
      enb => enb,
      sleep => sleep
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sincos315_table_dprom is
  port (
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 35 downto 0 );
    clkb : in STD_LOGIC;
    enb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of sincos315_table_dprom : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of sincos315_table_dprom : entity is "sincos315_table_dprom,blk_mem_gen_v8_3_6,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of sincos315_table_dprom : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of sincos315_table_dprom : entity is "blk_mem_gen_v8_3_6,Vivado 2017.1";
end sincos315_table_dprom;

architecture STRUCTURE of sincos315_table_dprom is
  signal NLW_U0_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_rsta_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_rstb_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_arready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_awready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_bvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rlast_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_wready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_rdaddrecc_UNCONNECTED : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal NLW_U0_s_axi_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_s_axi_bresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_s_axi_rdaddrecc_UNCONNECTED : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal NLW_U0_s_axi_rdata_UNCONNECTED : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal NLW_U0_s_axi_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_s_axi_rresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_ADDRA_WIDTH : integer;
  attribute C_ADDRA_WIDTH of U0 : label is 10;
  attribute C_ADDRB_WIDTH : integer;
  attribute C_ADDRB_WIDTH of U0 : label is 10;
  attribute C_ALGORITHM : integer;
  attribute C_ALGORITHM of U0 : label is 1;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of U0 : label is 4;
  attribute C_AXI_SLAVE_TYPE : integer;
  attribute C_AXI_SLAVE_TYPE of U0 : label is 0;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of U0 : label is 1;
  attribute C_BYTE_SIZE : integer;
  attribute C_BYTE_SIZE of U0 : label is 9;
  attribute C_COMMON_CLK : integer;
  attribute C_COMMON_CLK of U0 : label is 1;
  attribute C_COUNT_18K_BRAM : string;
  attribute C_COUNT_18K_BRAM of U0 : label is "0";
  attribute C_COUNT_36K_BRAM : string;
  attribute C_COUNT_36K_BRAM of U0 : label is "1";
  attribute C_CTRL_ECC_ALGO : string;
  attribute C_CTRL_ECC_ALGO of U0 : label is "NONE";
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of U0 : label is "0";
  attribute C_DISABLE_WARN_BHV_COLL : integer;
  attribute C_DISABLE_WARN_BHV_COLL of U0 : label is 0;
  attribute C_DISABLE_WARN_BHV_RANGE : integer;
  attribute C_DISABLE_WARN_BHV_RANGE of U0 : label is 0;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of U0 : label is "./";
  attribute C_ENABLE_32BIT_ADDRESS : integer;
  attribute C_ENABLE_32BIT_ADDRESS of U0 : label is 0;
  attribute C_EN_DEEPSLEEP_PIN : integer;
  attribute C_EN_DEEPSLEEP_PIN of U0 : label is 0;
  attribute C_EN_ECC_PIPE : integer;
  attribute C_EN_ECC_PIPE of U0 : label is 0;
  attribute C_EN_RDADDRA_CHG : integer;
  attribute C_EN_RDADDRA_CHG of U0 : label is 0;
  attribute C_EN_RDADDRB_CHG : integer;
  attribute C_EN_RDADDRB_CHG of U0 : label is 0;
  attribute C_EN_SAFETY_CKT : integer;
  attribute C_EN_SAFETY_CKT of U0 : label is 0;
  attribute C_EN_SHUTDOWN_PIN : integer;
  attribute C_EN_SHUTDOWN_PIN of U0 : label is 0;
  attribute C_EN_SLEEP_PIN : integer;
  attribute C_EN_SLEEP_PIN of U0 : label is 0;
  attribute C_EST_POWER_SUMMARY : string;
  attribute C_EST_POWER_SUMMARY of U0 : label is "Estimated Power for IP     :     5.708242 mW";
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "kintexu";
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of U0 : label is 0;
  attribute C_HAS_ENA : integer;
  attribute C_HAS_ENA of U0 : label is 1;
  attribute C_HAS_ENB : integer;
  attribute C_HAS_ENB of U0 : label is 1;
  attribute C_HAS_INJECTERR : integer;
  attribute C_HAS_INJECTERR of U0 : label is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_A : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_A of U0 : label is 1;
  attribute C_HAS_MEM_OUTPUT_REGS_B : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_B of U0 : label is 1;
  attribute C_HAS_MUX_OUTPUT_REGS_A : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_A of U0 : label is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_B : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_B of U0 : label is 0;
  attribute C_HAS_REGCEA : integer;
  attribute C_HAS_REGCEA of U0 : label is 0;
  attribute C_HAS_REGCEB : integer;
  attribute C_HAS_REGCEB of U0 : label is 0;
  attribute C_HAS_RSTA : integer;
  attribute C_HAS_RSTA of U0 : label is 0;
  attribute C_HAS_RSTB : integer;
  attribute C_HAS_RSTB of U0 : label is 0;
  attribute C_HAS_SOFTECC_INPUT_REGS_A : integer;
  attribute C_HAS_SOFTECC_INPUT_REGS_A of U0 : label is 0;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B : integer;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B of U0 : label is 0;
  attribute C_INITA_VAL : string;
  attribute C_INITA_VAL of U0 : label is "0";
  attribute C_INITB_VAL : string;
  attribute C_INITB_VAL of U0 : label is "0";
  attribute C_INIT_FILE : string;
  attribute C_INIT_FILE of U0 : label is "sincos315_table_dprom.mem";
  attribute C_INIT_FILE_NAME : string;
  attribute C_INIT_FILE_NAME of U0 : label is "sincos315_table_dprom.mif";
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of U0 : label is 0;
  attribute C_LOAD_INIT_FILE : integer;
  attribute C_LOAD_INIT_FILE of U0 : label is 1;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 4;
  attribute C_MUX_PIPELINE_STAGES : integer;
  attribute C_MUX_PIPELINE_STAGES of U0 : label is 0;
  attribute C_PRIM_TYPE : integer;
  attribute C_PRIM_TYPE of U0 : label is 1;
  attribute C_READ_DEPTH_A : integer;
  attribute C_READ_DEPTH_A of U0 : label is 1024;
  attribute C_READ_DEPTH_B : integer;
  attribute C_READ_DEPTH_B of U0 : label is 1024;
  attribute C_READ_WIDTH_A : integer;
  attribute C_READ_WIDTH_A of U0 : label is 36;
  attribute C_READ_WIDTH_B : integer;
  attribute C_READ_WIDTH_B of U0 : label is 36;
  attribute C_RSTRAM_A : integer;
  attribute C_RSTRAM_A of U0 : label is 0;
  attribute C_RSTRAM_B : integer;
  attribute C_RSTRAM_B of U0 : label is 0;
  attribute C_RST_PRIORITY_A : string;
  attribute C_RST_PRIORITY_A of U0 : label is "CE";
  attribute C_RST_PRIORITY_B : string;
  attribute C_RST_PRIORITY_B of U0 : label is "CE";
  attribute C_SIM_COLLISION_CHECK : string;
  attribute C_SIM_COLLISION_CHECK of U0 : label is "ALL";
  attribute C_USE_BRAM_BLOCK : integer;
  attribute C_USE_BRAM_BLOCK of U0 : label is 0;
  attribute C_USE_BYTE_WEA : integer;
  attribute C_USE_BYTE_WEA of U0 : label is 0;
  attribute C_USE_BYTE_WEB : integer;
  attribute C_USE_BYTE_WEB of U0 : label is 0;
  attribute C_USE_DEFAULT_DATA : integer;
  attribute C_USE_DEFAULT_DATA of U0 : label is 0;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of U0 : label is 0;
  attribute C_USE_SOFTECC : integer;
  attribute C_USE_SOFTECC of U0 : label is 0;
  attribute C_USE_URAM : integer;
  attribute C_USE_URAM of U0 : label is 0;
  attribute C_WEA_WIDTH : integer;
  attribute C_WEA_WIDTH of U0 : label is 1;
  attribute C_WEB_WIDTH : integer;
  attribute C_WEB_WIDTH of U0 : label is 1;
  attribute C_WRITE_DEPTH_A : integer;
  attribute C_WRITE_DEPTH_A of U0 : label is 1024;
  attribute C_WRITE_DEPTH_B : integer;
  attribute C_WRITE_DEPTH_B of U0 : label is 1024;
  attribute C_WRITE_MODE_A : string;
  attribute C_WRITE_MODE_A of U0 : label is "WRITE_FIRST";
  attribute C_WRITE_MODE_B : string;
  attribute C_WRITE_MODE_B of U0 : label is "WRITE_FIRST";
  attribute C_WRITE_WIDTH_A : integer;
  attribute C_WRITE_WIDTH_A of U0 : label is 36;
  attribute C_WRITE_WIDTH_B : integer;
  attribute C_WRITE_WIDTH_B of U0 : label is 36;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of U0 : label is "kintexu";
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
begin
U0: entity work.sincos315_table_dprom_blk_mem_gen_v8_3_6
     port map (
      addra(9 downto 0) => addra(9 downto 0),
      addrb(9 downto 0) => addrb(9 downto 0),
      clka => clka,
      clkb => clkb,
      dbiterr => NLW_U0_dbiterr_UNCONNECTED,
      deepsleep => '0',
      dina(35 downto 0) => B"000000000000000000000000000000000000",
      dinb(35 downto 0) => B"000000000000000000000000000000000000",
      douta(35 downto 0) => douta(35 downto 0),
      doutb(35 downto 0) => doutb(35 downto 0),
      eccpipece => '0',
      ena => ena,
      enb => enb,
      injectdbiterr => '0',
      injectsbiterr => '0',
      rdaddrecc(9 downto 0) => NLW_U0_rdaddrecc_UNCONNECTED(9 downto 0),
      regcea => '0',
      regceb => '0',
      rsta => '0',
      rsta_busy => NLW_U0_rsta_busy_UNCONNECTED,
      rstb => '0',
      rstb_busy => NLW_U0_rstb_busy_UNCONNECTED,
      s_aclk => '0',
      s_aresetn => '0',
      s_axi_araddr(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_arburst(1 downto 0) => B"00",
      s_axi_arid(3 downto 0) => B"0000",
      s_axi_arlen(7 downto 0) => B"00000000",
      s_axi_arready => NLW_U0_s_axi_arready_UNCONNECTED,
      s_axi_arsize(2 downto 0) => B"000",
      s_axi_arvalid => '0',
      s_axi_awaddr(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_awburst(1 downto 0) => B"00",
      s_axi_awid(3 downto 0) => B"0000",
      s_axi_awlen(7 downto 0) => B"00000000",
      s_axi_awready => NLW_U0_s_axi_awready_UNCONNECTED,
      s_axi_awsize(2 downto 0) => B"000",
      s_axi_awvalid => '0',
      s_axi_bid(3 downto 0) => NLW_U0_s_axi_bid_UNCONNECTED(3 downto 0),
      s_axi_bready => '0',
      s_axi_bresp(1 downto 0) => NLW_U0_s_axi_bresp_UNCONNECTED(1 downto 0),
      s_axi_bvalid => NLW_U0_s_axi_bvalid_UNCONNECTED,
      s_axi_dbiterr => NLW_U0_s_axi_dbiterr_UNCONNECTED,
      s_axi_injectdbiterr => '0',
      s_axi_injectsbiterr => '0',
      s_axi_rdaddrecc(9 downto 0) => NLW_U0_s_axi_rdaddrecc_UNCONNECTED(9 downto 0),
      s_axi_rdata(35 downto 0) => NLW_U0_s_axi_rdata_UNCONNECTED(35 downto 0),
      s_axi_rid(3 downto 0) => NLW_U0_s_axi_rid_UNCONNECTED(3 downto 0),
      s_axi_rlast => NLW_U0_s_axi_rlast_UNCONNECTED,
      s_axi_rready => '0',
      s_axi_rresp(1 downto 0) => NLW_U0_s_axi_rresp_UNCONNECTED(1 downto 0),
      s_axi_rvalid => NLW_U0_s_axi_rvalid_UNCONNECTED,
      s_axi_sbiterr => NLW_U0_s_axi_sbiterr_UNCONNECTED,
      s_axi_wdata(35 downto 0) => B"000000000000000000000000000000000000",
      s_axi_wlast => '0',
      s_axi_wready => NLW_U0_s_axi_wready_UNCONNECTED,
      s_axi_wstrb(0) => '0',
      s_axi_wvalid => '0',
      sbiterr => NLW_U0_sbiterr_UNCONNECTED,
      shutdown => '0',
      sleep => '0',
      wea(0) => '0',
      web(0) => '0'
    );
end STRUCTURE;
