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

-- IP VLNV: pentek.com:px_ip:px_vctr2scalar:1.0
-- IP Revision: 15

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY user_block2_px_vctr2scalar_0_0 IS
  PORT (
    input_vector : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    output_scalar : OUT STD_LOGIC
  );
END user_block2_px_vctr2scalar_0_0;

ARCHITECTURE user_block2_px_vctr2scalar_0_0_arch OF user_block2_px_vctr2scalar_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF user_block2_px_vctr2scalar_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT px_vctr2scalar IS
    GENERIC (
      synchronize : BOOLEAN;
      num_sync_ff : INTEGER;
      has_srst : BOOLEAN;
      val_at_rst_low : BOOLEAN;
      srst_active_high : BOOLEAN;
      invert : BOOLEAN
    );
    PORT (
      input_vector : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      output_scalar : OUT STD_LOGIC;
      clk : IN STD_LOGIC;
      srst : IN STD_LOGIC
    );
  END COMPONENT px_vctr2scalar;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF user_block2_px_vctr2scalar_0_0_arch: ARCHITECTURE IS "px_vctr2scalar,Vivado 2017.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF user_block2_px_vctr2scalar_0_0_arch : ARCHITECTURE IS "user_block2_px_vctr2scalar_0_0,px_vctr2scalar,{}";
BEGIN
  U0 : px_vctr2scalar
    GENERIC MAP (
      synchronize => false,
      num_sync_ff => 2,
      has_srst => false,
      val_at_rst_low => true,
      srst_active_high => false,
      invert => false
    )
    PORT MAP (
      input_vector => input_vector,
      output_scalar => output_scalar,
      clk => '0',
      srst => '0'
    );
END user_block2_px_vctr2scalar_0_0_arch;
