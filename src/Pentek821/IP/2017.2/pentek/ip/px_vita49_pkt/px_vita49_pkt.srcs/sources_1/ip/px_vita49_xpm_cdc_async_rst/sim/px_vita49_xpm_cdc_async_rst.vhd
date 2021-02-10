-- (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
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

-- IP VLNV: pentek.com:px_ip:px_xpm_cdc_async_rst:1.1
-- IP Revision: 10

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY px_vita49_xpm_cdc_async_rst IS
  PORT (
    dest_clk : IN STD_LOGIC;
    src_arst : IN STD_LOGIC;
    dest_arst : OUT STD_LOGIC
  );
END px_vita49_xpm_cdc_async_rst;

ARCHITECTURE px_vita49_xpm_cdc_async_rst_arch OF px_vita49_xpm_cdc_async_rst IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF px_vita49_xpm_cdc_async_rst_arch: ARCHITECTURE IS "yes";
  COMPONENT px_xpm_cdc_async_rst IS
    GENERIC (
      DEST_SYNC_FF : INTEGER;
      RST_ACTIVE_HIGH : INTEGER
    );
    PORT (
      dest_clk : IN STD_LOGIC;
      src_arst : IN STD_LOGIC;
      dest_arst : OUT STD_LOGIC
    );
  END COMPONENT px_xpm_cdc_async_rst;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF dest_clk: SIGNAL IS "xilinx.com:signal:clock:1.0 dest_clk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF src_arst: SIGNAL IS "xilinx.com:signal:reset:1.0 src_arst RST";
  ATTRIBUTE X_INTERFACE_INFO OF dest_arst: SIGNAL IS "xilinx.com:signal:reset:1.0 dest_arst RST";
BEGIN
  U0 : px_xpm_cdc_async_rst
    GENERIC MAP (
      DEST_SYNC_FF => 2,
      RST_ACTIVE_HIGH => 0
    )
    PORT MAP (
      dest_clk => dest_clk,
      src_arst => src_arst,
      dest_arst => dest_arst
    );
END px_vita49_xpm_cdc_async_rst_arch;
