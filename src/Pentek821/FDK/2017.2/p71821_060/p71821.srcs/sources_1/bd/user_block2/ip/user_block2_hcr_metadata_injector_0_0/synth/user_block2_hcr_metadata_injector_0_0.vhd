-- (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: NCAR:EOL:hcr_metadata_injector:1.0
-- IP Revision: 2104272203

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY user_block2_hcr_metadata_injector_0_0 IS
  PORT (
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    i_data_TVALID : IN STD_LOGIC;
    i_data_TREADY : OUT STD_LOGIC;
    i_data_TDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    i_data_TDEST : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    i_data_TKEEP : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    i_data_TSTRB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    i_data_TUSER : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    i_data_TLAST : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    i_data_TID : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    o_data_TVALID : OUT STD_LOGIC;
    o_data_TREADY : IN STD_LOGIC;
    o_data_TDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    o_data_TDEST : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    o_data_TKEEP : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    o_data_TSTRB : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    o_data_TUSER : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    o_data_TLAST : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    o_data_TID : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    pulse_metadata_V_TVALID : IN STD_LOGIC;
    pulse_metadata_V_TREADY : OUT STD_LOGIC;
    pulse_metadata_V_TDATA : IN STD_LOGIC_VECTOR(823 DOWNTO 0);
    pos_enc_0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    pos_enc_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    flags : IN STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END user_block2_hcr_metadata_injector_0_0;

ARCHITECTURE user_block2_hcr_metadata_injector_0_0_arch OF user_block2_hcr_metadata_injector_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF user_block2_hcr_metadata_injector_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT hcr_metadata_injector IS
    PORT (
      ap_clk : IN STD_LOGIC;
      ap_rst_n : IN STD_LOGIC;
      ap_start : IN STD_LOGIC;
      ap_done : OUT STD_LOGIC;
      ap_idle : OUT STD_LOGIC;
      ap_ready : OUT STD_LOGIC;
      i_data_TVALID : IN STD_LOGIC;
      i_data_TREADY : OUT STD_LOGIC;
      i_data_TDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      i_data_TDEST : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      i_data_TKEEP : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      i_data_TSTRB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      i_data_TUSER : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      i_data_TLAST : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      i_data_TID : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      o_data_TVALID : OUT STD_LOGIC;
      o_data_TREADY : IN STD_LOGIC;
      o_data_TDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      o_data_TDEST : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      o_data_TKEEP : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      o_data_TSTRB : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      o_data_TUSER : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      o_data_TLAST : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      o_data_TID : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      pulse_metadata_V_TVALID : IN STD_LOGIC;
      pulse_metadata_V_TREADY : OUT STD_LOGIC;
      pulse_metadata_V_TDATA : IN STD_LOGIC_VECTOR(823 DOWNTO 0);
      pos_enc_0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      pos_enc_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      flags : IN STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
  END COMPONENT hcr_metadata_injector;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF user_block2_hcr_metadata_injector_0_0_arch: ARCHITECTURE IS "hcr_metadata_injector,Vivado 2017.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF user_block2_hcr_metadata_injector_0_0_arch : ARCHITECTURE IS "user_block2_hcr_metadata_injector_0_0,hcr_metadata_injector,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF ap_clk: SIGNAL IS "xilinx.com:signal:clock:1.0 ap_clk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF ap_rst_n: SIGNAL IS "xilinx.com:signal:reset:1.0 ap_rst_n RST";
  ATTRIBUTE X_INTERFACE_INFO OF ap_start: SIGNAL IS "xilinx.com:interface:acc_handshake:1.0 ap_ctrl start";
  ATTRIBUTE X_INTERFACE_INFO OF ap_done: SIGNAL IS "xilinx.com:interface:acc_handshake:1.0 ap_ctrl done";
  ATTRIBUTE X_INTERFACE_INFO OF ap_idle: SIGNAL IS "xilinx.com:interface:acc_handshake:1.0 ap_ctrl idle";
  ATTRIBUTE X_INTERFACE_INFO OF ap_ready: SIGNAL IS "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ready";
  ATTRIBUTE X_INTERFACE_INFO OF i_data_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 i_data TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF i_data_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 i_data TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF i_data_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 i_data TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF i_data_TDEST: SIGNAL IS "xilinx.com:interface:axis:1.0 i_data TDEST";
  ATTRIBUTE X_INTERFACE_INFO OF i_data_TKEEP: SIGNAL IS "xilinx.com:interface:axis:1.0 i_data TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF i_data_TSTRB: SIGNAL IS "xilinx.com:interface:axis:1.0 i_data TSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF i_data_TUSER: SIGNAL IS "xilinx.com:interface:axis:1.0 i_data TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF i_data_TLAST: SIGNAL IS "xilinx.com:interface:axis:1.0 i_data TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF i_data_TID: SIGNAL IS "xilinx.com:interface:axis:1.0 i_data TID";
  ATTRIBUTE X_INTERFACE_INFO OF o_data_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 o_data TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF o_data_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 o_data TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF o_data_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 o_data TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF o_data_TDEST: SIGNAL IS "xilinx.com:interface:axis:1.0 o_data TDEST";
  ATTRIBUTE X_INTERFACE_INFO OF o_data_TKEEP: SIGNAL IS "xilinx.com:interface:axis:1.0 o_data TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF o_data_TSTRB: SIGNAL IS "xilinx.com:interface:axis:1.0 o_data TSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF o_data_TUSER: SIGNAL IS "xilinx.com:interface:axis:1.0 o_data TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF o_data_TLAST: SIGNAL IS "xilinx.com:interface:axis:1.0 o_data TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF o_data_TID: SIGNAL IS "xilinx.com:interface:axis:1.0 o_data TID";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_V_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_V TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_V_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_V TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_V_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_V TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF pos_enc_0: SIGNAL IS "xilinx.com:signal:data:1.0 pos_enc_0 DATA";
  ATTRIBUTE X_INTERFACE_INFO OF pos_enc_1: SIGNAL IS "xilinx.com:signal:data:1.0 pos_enc_1 DATA";
  ATTRIBUTE X_INTERFACE_INFO OF flags: SIGNAL IS "xilinx.com:signal:data:1.0 flags DATA";
BEGIN
  U0 : hcr_metadata_injector
    PORT MAP (
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      ap_start => ap_start,
      ap_done => ap_done,
      ap_idle => ap_idle,
      ap_ready => ap_ready,
      i_data_TVALID => i_data_TVALID,
      i_data_TREADY => i_data_TREADY,
      i_data_TDATA => i_data_TDATA,
      i_data_TDEST => i_data_TDEST,
      i_data_TKEEP => i_data_TKEEP,
      i_data_TSTRB => i_data_TSTRB,
      i_data_TUSER => i_data_TUSER,
      i_data_TLAST => i_data_TLAST,
      i_data_TID => i_data_TID,
      o_data_TVALID => o_data_TVALID,
      o_data_TREADY => o_data_TREADY,
      o_data_TDATA => o_data_TDATA,
      o_data_TDEST => o_data_TDEST,
      o_data_TKEEP => o_data_TKEEP,
      o_data_TSTRB => o_data_TSTRB,
      o_data_TUSER => o_data_TUSER,
      o_data_TLAST => o_data_TLAST,
      o_data_TID => o_data_TID,
      pulse_metadata_V_TVALID => pulse_metadata_V_TVALID,
      pulse_metadata_V_TREADY => pulse_metadata_V_TREADY,
      pulse_metadata_V_TDATA => pulse_metadata_V_TDATA,
      pos_enc_0 => pos_enc_0,
      pos_enc_1 => pos_enc_1,
      flags => flags
    );
END user_block2_hcr_metadata_injector_0_0_arch;
