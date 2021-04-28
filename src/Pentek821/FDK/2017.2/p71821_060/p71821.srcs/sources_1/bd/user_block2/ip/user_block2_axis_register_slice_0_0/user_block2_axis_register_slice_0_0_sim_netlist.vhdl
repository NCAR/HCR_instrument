-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Mon Apr 26 22:24:52 2021
-- Host        : wind running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_axis_register_slice_0_0/user_block2_axis_register_slice_0_0_sim_netlist.vhdl
-- Design      : user_block2_axis_register_slice_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku060-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axisc_register_slice is
  port (
    Q : out STD_LOGIC_VECTOR ( 159 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    aclken : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 159 downto 0 );
    aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axisc_register_slice : entity is "axis_register_slice_v1_1_13_axisc_register_slice";
end user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axisc_register_slice;

architecture STRUCTURE of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axisc_register_slice is
begin
\NO_READY.m_valid_r_reg\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => s_axis_tvalid,
      Q => m_axis_tvalid,
      R => '0'
    );
\NO_READY.storage_data1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(0),
      Q => Q(0),
      R => '0'
    );
\NO_READY.storage_data1_reg[100]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(100),
      Q => Q(100),
      R => '0'
    );
\NO_READY.storage_data1_reg[101]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(101),
      Q => Q(101),
      R => '0'
    );
\NO_READY.storage_data1_reg[102]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(102),
      Q => Q(102),
      R => '0'
    );
\NO_READY.storage_data1_reg[103]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(103),
      Q => Q(103),
      R => '0'
    );
\NO_READY.storage_data1_reg[104]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(104),
      Q => Q(104),
      R => '0'
    );
\NO_READY.storage_data1_reg[105]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(105),
      Q => Q(105),
      R => '0'
    );
\NO_READY.storage_data1_reg[106]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(106),
      Q => Q(106),
      R => '0'
    );
\NO_READY.storage_data1_reg[107]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(107),
      Q => Q(107),
      R => '0'
    );
\NO_READY.storage_data1_reg[108]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(108),
      Q => Q(108),
      R => '0'
    );
\NO_READY.storage_data1_reg[109]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(109),
      Q => Q(109),
      R => '0'
    );
\NO_READY.storage_data1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(10),
      Q => Q(10),
      R => '0'
    );
\NO_READY.storage_data1_reg[110]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(110),
      Q => Q(110),
      R => '0'
    );
\NO_READY.storage_data1_reg[111]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(111),
      Q => Q(111),
      R => '0'
    );
\NO_READY.storage_data1_reg[112]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(112),
      Q => Q(112),
      R => '0'
    );
\NO_READY.storage_data1_reg[113]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(113),
      Q => Q(113),
      R => '0'
    );
\NO_READY.storage_data1_reg[114]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(114),
      Q => Q(114),
      R => '0'
    );
\NO_READY.storage_data1_reg[115]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(115),
      Q => Q(115),
      R => '0'
    );
\NO_READY.storage_data1_reg[116]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(116),
      Q => Q(116),
      R => '0'
    );
\NO_READY.storage_data1_reg[117]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(117),
      Q => Q(117),
      R => '0'
    );
\NO_READY.storage_data1_reg[118]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(118),
      Q => Q(118),
      R => '0'
    );
\NO_READY.storage_data1_reg[119]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(119),
      Q => Q(119),
      R => '0'
    );
\NO_READY.storage_data1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(11),
      Q => Q(11),
      R => '0'
    );
\NO_READY.storage_data1_reg[120]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(120),
      Q => Q(120),
      R => '0'
    );
\NO_READY.storage_data1_reg[121]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(121),
      Q => Q(121),
      R => '0'
    );
\NO_READY.storage_data1_reg[122]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(122),
      Q => Q(122),
      R => '0'
    );
\NO_READY.storage_data1_reg[123]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(123),
      Q => Q(123),
      R => '0'
    );
\NO_READY.storage_data1_reg[124]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(124),
      Q => Q(124),
      R => '0'
    );
\NO_READY.storage_data1_reg[125]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(125),
      Q => Q(125),
      R => '0'
    );
\NO_READY.storage_data1_reg[126]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(126),
      Q => Q(126),
      R => '0'
    );
\NO_READY.storage_data1_reg[127]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(127),
      Q => Q(127),
      R => '0'
    );
\NO_READY.storage_data1_reg[128]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(128),
      Q => Q(128),
      R => '0'
    );
\NO_READY.storage_data1_reg[129]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(129),
      Q => Q(129),
      R => '0'
    );
\NO_READY.storage_data1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(12),
      Q => Q(12),
      R => '0'
    );
\NO_READY.storage_data1_reg[130]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(130),
      Q => Q(130),
      R => '0'
    );
\NO_READY.storage_data1_reg[131]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(131),
      Q => Q(131),
      R => '0'
    );
\NO_READY.storage_data1_reg[132]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(132),
      Q => Q(132),
      R => '0'
    );
\NO_READY.storage_data1_reg[133]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(133),
      Q => Q(133),
      R => '0'
    );
\NO_READY.storage_data1_reg[134]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(134),
      Q => Q(134),
      R => '0'
    );
\NO_READY.storage_data1_reg[135]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(135),
      Q => Q(135),
      R => '0'
    );
\NO_READY.storage_data1_reg[136]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(136),
      Q => Q(136),
      R => '0'
    );
\NO_READY.storage_data1_reg[137]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(137),
      Q => Q(137),
      R => '0'
    );
\NO_READY.storage_data1_reg[138]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(138),
      Q => Q(138),
      R => '0'
    );
\NO_READY.storage_data1_reg[139]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(139),
      Q => Q(139),
      R => '0'
    );
\NO_READY.storage_data1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(13),
      Q => Q(13),
      R => '0'
    );
\NO_READY.storage_data1_reg[140]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(140),
      Q => Q(140),
      R => '0'
    );
\NO_READY.storage_data1_reg[141]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(141),
      Q => Q(141),
      R => '0'
    );
\NO_READY.storage_data1_reg[142]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(142),
      Q => Q(142),
      R => '0'
    );
\NO_READY.storage_data1_reg[143]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(143),
      Q => Q(143),
      R => '0'
    );
\NO_READY.storage_data1_reg[144]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(144),
      Q => Q(144),
      R => '0'
    );
\NO_READY.storage_data1_reg[145]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(145),
      Q => Q(145),
      R => '0'
    );
\NO_READY.storage_data1_reg[146]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(146),
      Q => Q(146),
      R => '0'
    );
\NO_READY.storage_data1_reg[147]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(147),
      Q => Q(147),
      R => '0'
    );
\NO_READY.storage_data1_reg[148]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(148),
      Q => Q(148),
      R => '0'
    );
\NO_READY.storage_data1_reg[149]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(149),
      Q => Q(149),
      R => '0'
    );
\NO_READY.storage_data1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(14),
      Q => Q(14),
      R => '0'
    );
\NO_READY.storage_data1_reg[150]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(150),
      Q => Q(150),
      R => '0'
    );
\NO_READY.storage_data1_reg[151]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(151),
      Q => Q(151),
      R => '0'
    );
\NO_READY.storage_data1_reg[152]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(152),
      Q => Q(152),
      R => '0'
    );
\NO_READY.storage_data1_reg[153]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(153),
      Q => Q(153),
      R => '0'
    );
\NO_READY.storage_data1_reg[154]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(154),
      Q => Q(154),
      R => '0'
    );
\NO_READY.storage_data1_reg[155]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(155),
      Q => Q(155),
      R => '0'
    );
\NO_READY.storage_data1_reg[156]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(156),
      Q => Q(156),
      R => '0'
    );
\NO_READY.storage_data1_reg[157]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(157),
      Q => Q(157),
      R => '0'
    );
\NO_READY.storage_data1_reg[158]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(158),
      Q => Q(158),
      R => '0'
    );
\NO_READY.storage_data1_reg[159]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(159),
      Q => Q(159),
      R => '0'
    );
\NO_READY.storage_data1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(15),
      Q => Q(15),
      R => '0'
    );
\NO_READY.storage_data1_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(16),
      Q => Q(16),
      R => '0'
    );
\NO_READY.storage_data1_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(17),
      Q => Q(17),
      R => '0'
    );
\NO_READY.storage_data1_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(18),
      Q => Q(18),
      R => '0'
    );
\NO_READY.storage_data1_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(19),
      Q => Q(19),
      R => '0'
    );
\NO_READY.storage_data1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(1),
      Q => Q(1),
      R => '0'
    );
\NO_READY.storage_data1_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(20),
      Q => Q(20),
      R => '0'
    );
\NO_READY.storage_data1_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(21),
      Q => Q(21),
      R => '0'
    );
\NO_READY.storage_data1_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(22),
      Q => Q(22),
      R => '0'
    );
\NO_READY.storage_data1_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(23),
      Q => Q(23),
      R => '0'
    );
\NO_READY.storage_data1_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(24),
      Q => Q(24),
      R => '0'
    );
\NO_READY.storage_data1_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(25),
      Q => Q(25),
      R => '0'
    );
\NO_READY.storage_data1_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(26),
      Q => Q(26),
      R => '0'
    );
\NO_READY.storage_data1_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(27),
      Q => Q(27),
      R => '0'
    );
\NO_READY.storage_data1_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(28),
      Q => Q(28),
      R => '0'
    );
\NO_READY.storage_data1_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(29),
      Q => Q(29),
      R => '0'
    );
\NO_READY.storage_data1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(2),
      Q => Q(2),
      R => '0'
    );
\NO_READY.storage_data1_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(30),
      Q => Q(30),
      R => '0'
    );
\NO_READY.storage_data1_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(31),
      Q => Q(31),
      R => '0'
    );
\NO_READY.storage_data1_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(32),
      Q => Q(32),
      R => '0'
    );
\NO_READY.storage_data1_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(33),
      Q => Q(33),
      R => '0'
    );
\NO_READY.storage_data1_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(34),
      Q => Q(34),
      R => '0'
    );
\NO_READY.storage_data1_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(35),
      Q => Q(35),
      R => '0'
    );
\NO_READY.storage_data1_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(36),
      Q => Q(36),
      R => '0'
    );
\NO_READY.storage_data1_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(37),
      Q => Q(37),
      R => '0'
    );
\NO_READY.storage_data1_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(38),
      Q => Q(38),
      R => '0'
    );
\NO_READY.storage_data1_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(39),
      Q => Q(39),
      R => '0'
    );
\NO_READY.storage_data1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(3),
      Q => Q(3),
      R => '0'
    );
\NO_READY.storage_data1_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(40),
      Q => Q(40),
      R => '0'
    );
\NO_READY.storage_data1_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(41),
      Q => Q(41),
      R => '0'
    );
\NO_READY.storage_data1_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(42),
      Q => Q(42),
      R => '0'
    );
\NO_READY.storage_data1_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(43),
      Q => Q(43),
      R => '0'
    );
\NO_READY.storage_data1_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(44),
      Q => Q(44),
      R => '0'
    );
\NO_READY.storage_data1_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(45),
      Q => Q(45),
      R => '0'
    );
\NO_READY.storage_data1_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(46),
      Q => Q(46),
      R => '0'
    );
\NO_READY.storage_data1_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(47),
      Q => Q(47),
      R => '0'
    );
\NO_READY.storage_data1_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(48),
      Q => Q(48),
      R => '0'
    );
\NO_READY.storage_data1_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(49),
      Q => Q(49),
      R => '0'
    );
\NO_READY.storage_data1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(4),
      Q => Q(4),
      R => '0'
    );
\NO_READY.storage_data1_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(50),
      Q => Q(50),
      R => '0'
    );
\NO_READY.storage_data1_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(51),
      Q => Q(51),
      R => '0'
    );
\NO_READY.storage_data1_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(52),
      Q => Q(52),
      R => '0'
    );
\NO_READY.storage_data1_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(53),
      Q => Q(53),
      R => '0'
    );
\NO_READY.storage_data1_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(54),
      Q => Q(54),
      R => '0'
    );
\NO_READY.storage_data1_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(55),
      Q => Q(55),
      R => '0'
    );
\NO_READY.storage_data1_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(56),
      Q => Q(56),
      R => '0'
    );
\NO_READY.storage_data1_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(57),
      Q => Q(57),
      R => '0'
    );
\NO_READY.storage_data1_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(58),
      Q => Q(58),
      R => '0'
    );
\NO_READY.storage_data1_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(59),
      Q => Q(59),
      R => '0'
    );
\NO_READY.storage_data1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(5),
      Q => Q(5),
      R => '0'
    );
\NO_READY.storage_data1_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(60),
      Q => Q(60),
      R => '0'
    );
\NO_READY.storage_data1_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(61),
      Q => Q(61),
      R => '0'
    );
\NO_READY.storage_data1_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(62),
      Q => Q(62),
      R => '0'
    );
\NO_READY.storage_data1_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(63),
      Q => Q(63),
      R => '0'
    );
\NO_READY.storage_data1_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(64),
      Q => Q(64),
      R => '0'
    );
\NO_READY.storage_data1_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(65),
      Q => Q(65),
      R => '0'
    );
\NO_READY.storage_data1_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(66),
      Q => Q(66),
      R => '0'
    );
\NO_READY.storage_data1_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(67),
      Q => Q(67),
      R => '0'
    );
\NO_READY.storage_data1_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(68),
      Q => Q(68),
      R => '0'
    );
\NO_READY.storage_data1_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(69),
      Q => Q(69),
      R => '0'
    );
\NO_READY.storage_data1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(6),
      Q => Q(6),
      R => '0'
    );
\NO_READY.storage_data1_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(70),
      Q => Q(70),
      R => '0'
    );
\NO_READY.storage_data1_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(71),
      Q => Q(71),
      R => '0'
    );
\NO_READY.storage_data1_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(72),
      Q => Q(72),
      R => '0'
    );
\NO_READY.storage_data1_reg[73]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(73),
      Q => Q(73),
      R => '0'
    );
\NO_READY.storage_data1_reg[74]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(74),
      Q => Q(74),
      R => '0'
    );
\NO_READY.storage_data1_reg[75]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(75),
      Q => Q(75),
      R => '0'
    );
\NO_READY.storage_data1_reg[76]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(76),
      Q => Q(76),
      R => '0'
    );
\NO_READY.storage_data1_reg[77]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(77),
      Q => Q(77),
      R => '0'
    );
\NO_READY.storage_data1_reg[78]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(78),
      Q => Q(78),
      R => '0'
    );
\NO_READY.storage_data1_reg[79]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(79),
      Q => Q(79),
      R => '0'
    );
\NO_READY.storage_data1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(7),
      Q => Q(7),
      R => '0'
    );
\NO_READY.storage_data1_reg[80]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(80),
      Q => Q(80),
      R => '0'
    );
\NO_READY.storage_data1_reg[81]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(81),
      Q => Q(81),
      R => '0'
    );
\NO_READY.storage_data1_reg[82]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(82),
      Q => Q(82),
      R => '0'
    );
\NO_READY.storage_data1_reg[83]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(83),
      Q => Q(83),
      R => '0'
    );
\NO_READY.storage_data1_reg[84]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(84),
      Q => Q(84),
      R => '0'
    );
\NO_READY.storage_data1_reg[85]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(85),
      Q => Q(85),
      R => '0'
    );
\NO_READY.storage_data1_reg[86]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(86),
      Q => Q(86),
      R => '0'
    );
\NO_READY.storage_data1_reg[87]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(87),
      Q => Q(87),
      R => '0'
    );
\NO_READY.storage_data1_reg[88]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(88),
      Q => Q(88),
      R => '0'
    );
\NO_READY.storage_data1_reg[89]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(89),
      Q => Q(89),
      R => '0'
    );
\NO_READY.storage_data1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(8),
      Q => Q(8),
      R => '0'
    );
\NO_READY.storage_data1_reg[90]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(90),
      Q => Q(90),
      R => '0'
    );
\NO_READY.storage_data1_reg[91]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(91),
      Q => Q(91),
      R => '0'
    );
\NO_READY.storage_data1_reg[92]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(92),
      Q => Q(92),
      R => '0'
    );
\NO_READY.storage_data1_reg[93]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(93),
      Q => Q(93),
      R => '0'
    );
\NO_READY.storage_data1_reg[94]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(94),
      Q => Q(94),
      R => '0'
    );
\NO_READY.storage_data1_reg[95]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(95),
      Q => Q(95),
      R => '0'
    );
\NO_READY.storage_data1_reg[96]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(96),
      Q => Q(96),
      R => '0'
    );
\NO_READY.storage_data1_reg[97]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(97),
      Q => Q(97),
      R => '0'
    );
\NO_READY.storage_data1_reg[98]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(98),
      Q => Q(98),
      R => '0'
    );
\NO_READY.storage_data1_reg[99]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(99),
      Q => Q(99),
      R => '0'
    );
\NO_READY.storage_data1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(9),
      Q => Q(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is "32'b00000000000000000000000010000010";
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 32;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 128;
  attribute C_FAMILY : string;
  attribute C_FAMILY of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is "kintexu";
  attribute C_REG_CONFIG : integer;
  attribute C_REG_CONFIG of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is "yes";
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is "axis_register_slice_v1_1_13_axis_register_slice";
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice : entity is 160;
end user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice;

architecture STRUCTURE of user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
begin
  m_axis_tdest(0) <= \<const0>\;
  m_axis_tid(0) <= \<const0>\;
  m_axis_tkeep(3) <= \<const1>\;
  m_axis_tkeep(2) <= \<const1>\;
  m_axis_tkeep(1) <= \<const1>\;
  m_axis_tkeep(0) <= \<const1>\;
  m_axis_tlast <= \<const0>\;
  m_axis_tstrb(3) <= \<const0>\;
  m_axis_tstrb(2) <= \<const0>\;
  m_axis_tstrb(1) <= \<const0>\;
  m_axis_tstrb(0) <= \<const0>\;
  s_axis_tready <= \<const1>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
axisc_register_slice_0: entity work.user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axisc_register_slice
     port map (
      D(159 downto 32) => s_axis_tuser(127 downto 0),
      D(31 downto 0) => s_axis_tdata(31 downto 0),
      Q(159 downto 32) => m_axis_tuser(127 downto 0),
      Q(31 downto 0) => m_axis_tdata(31 downto 0),
      aclk => aclk,
      aclken => aclken,
      m_axis_tvalid => m_axis_tvalid,
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity user_block2_axis_register_slice_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 127 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of user_block2_axis_register_slice_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of user_block2_axis_register_slice_0_0 : entity is "user_block2_axis_register_slice_0_0,axis_register_slice_v1_1_13_axis_register_slice,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of user_block2_axis_register_slice_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of user_block2_axis_register_slice_0_0 : entity is "axis_register_slice_v1_1_13_axis_register_slice,Vivado 2017.2";
end user_block2_axis_register_slice_0_0;

architecture STRUCTURE of user_block2_axis_register_slice_0_0 is
  signal NLW_inst_m_axis_tlast_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_s_axis_tready_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axis_tdest_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axis_tid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axis_tkeep_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axis_tstrb_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of inst : label is "32'b00000000000000000000000010000010";
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of inst : label is 32;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of inst : label is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of inst : label is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of inst : label is 128;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "kintexu";
  attribute C_REG_CONFIG : integer;
  attribute C_REG_CONFIG of inst : label is 1;
  attribute DowngradeIPIdentifiedWarnings of inst : label is "yes";
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of inst : label is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of inst : label is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of inst : label is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of inst : label is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of inst : label is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of inst : label is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of inst : label is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of inst : label is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of inst : label is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of inst : label is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of inst : label is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of inst : label is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of inst : label is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of inst : label is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of inst : label is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of inst : label is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of inst : label is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of inst : label is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of inst : label is 1;
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of inst : label is 160;
begin
inst: entity work.user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice
     port map (
      aclk => aclk,
      aclken => '1',
      aresetn => aresetn,
      m_axis_tdata(31 downto 0) => m_axis_tdata(31 downto 0),
      m_axis_tdest(0) => NLW_inst_m_axis_tdest_UNCONNECTED(0),
      m_axis_tid(0) => NLW_inst_m_axis_tid_UNCONNECTED(0),
      m_axis_tkeep(3 downto 0) => NLW_inst_m_axis_tkeep_UNCONNECTED(3 downto 0),
      m_axis_tlast => NLW_inst_m_axis_tlast_UNCONNECTED,
      m_axis_tready => '1',
      m_axis_tstrb(3 downto 0) => NLW_inst_m_axis_tstrb_UNCONNECTED(3 downto 0),
      m_axis_tuser(127 downto 0) => m_axis_tuser(127 downto 0),
      m_axis_tvalid => m_axis_tvalid,
      s_axis_tdata(31 downto 0) => s_axis_tdata(31 downto 0),
      s_axis_tdest(0) => '0',
      s_axis_tid(0) => '0',
      s_axis_tkeep(3 downto 0) => B"1111",
      s_axis_tlast => '1',
      s_axis_tready => NLW_inst_s_axis_tready_UNCONNECTED,
      s_axis_tstrb(3 downto 0) => B"1111",
      s_axis_tuser(127 downto 0) => s_axis_tuser(127 downto 0),
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
