----------------------------------------------------------------------------------
-- Control/Status Registers for px_axil2cdc
----------------------------------------------------------------------------------
-- ptk_dma_timestamp_csr.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2015
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 
--  

-------------------------------------------------------------------------------

-- (c) Copyright 2015 Pentek, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Pentek, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Pentek, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND PENTEK HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Pentek shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Pentek had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Pentek products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Pentek products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Register Map
-- 0x00 Control Register                R/W   
-- 0x04 Load Value Register             R/W   
-- 0x08 Write Req Register              R/W
-- 0x0C Status Register                 RO 
-- 0x10 Reserved                        RO 
-- 0x14 Interrupt Enables               R/W
-- 0x18 Interrupt Status Register       RO 
-- 0x1C Interrupt Flag Register         R/Clr

-- Status Register

-- Bit [0] = cdc_stat_vcxo        
-- Bit [1] = cdc_stat_ref         
-- Bit [2] = cdc_stat_lock                    
-- Bit [3] = default_load_done    
-- Bit [4] = sm_ready 

-- Interrupts

-- Bit [0] = vcxo lost
-- Bit [1] = vcxo found
-- Bit [2] = ref lost
-- Bit [3] = ref found
-- Bit [4] = lock lost
-- Bit [5] = lock found 
-- Bit [6] = cdc write done
          
----------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axil2cdc_csr is
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk            : in  std_logic;
    s_axi_csr_aresetn         : in  std_logic;
    s_axi_csr_awaddr          : in  std_logic_vector(4 downto 0); -- only [5:0] used
    s_axi_csr_awprot          : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid         : in  std_logic;
    s_axi_csr_awready         : out std_logic;
    s_axi_csr_wdata           : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb           : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid          : in  std_logic;
    s_axi_csr_wready          : out std_logic;
    s_axi_csr_bresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid          : out std_logic;
    s_axi_csr_bready          : in  std_logic;
    s_axi_csr_araddr          : in  std_logic_vector(4 downto 0);  -- only [5:0] used
    s_axi_csr_arprot          : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid         : in  std_logic;
    s_axi_csr_arready         : out std_logic;
    s_axi_csr_rdata           : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid          : out std_logic;
    s_axi_csr_rready          : in  std_logic;
    
    irq                   : out std_logic; -- interrupt
    --------------------------------------------------------------------------------
    -- Control Outputs
    --------------------------------------------------------------------------------    
    cntl_word             : out std_logic_vector(31 downto 0);
    wr_req                : out std_logic;
    reg_rst               : out std_logic;
    vcxo_en               : out std_logic;
    clk_mux_sel           : out std_logic_vector(1 downto 0);
    vcxo_sel_n            : out std_logic;
    cdc_sync_rst_out      : out std_logic;
    cdc_sync_rst_in_en    : out std_logic;
    -------------------------------------------------------------------------------
    -- Status Sources
    --------------------------------------------------------------------------------
    cdc_stat_vcxo         : in  std_logic;
    cdc_stat_ref          : in  std_logic;
    cdc_stat_lock         : in  std_logic;
    sm_ready              : in  std_logic;
    default_load_done     : in  std_logic
);
end  px_axil2cdc_csr;

architecture Behavioral of px_axil2cdc_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Generic AXI-Lite Control/Status Register Set
component px_axil_csr_0
  port (
    s_axi_csr_aclk : in std_logic;
    s_axi_csr_aresetn : in std_logic;
    s_axi_csr_awaddr : in std_logic_vector(6 downto 0);
    s_axi_csr_awprot : in std_logic_vector(2 downto 0);
    s_axi_csr_awvalid : in std_logic;
    s_axi_csr_awready : out std_logic;
    s_axi_csr_wdata : in std_logic_vector(31 downto 0);
    s_axi_csr_wstrb : in std_logic_vector(3 downto 0);
    s_axi_csr_wvalid : in std_logic;
    s_axi_csr_wready : out std_logic;
    s_axi_csr_bresp : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid : out std_logic;
    s_axi_csr_bready : in std_logic;
    s_axi_csr_araddr : in std_logic_vector(6 downto 0);
    s_axi_csr_arprot : in std_logic_vector(2 downto 0);
    s_axi_csr_arvalid : in std_logic;
    s_axi_csr_arready : out std_logic;
    s_axi_csr_rdata : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid : out std_logic;
    s_axi_csr_rready : in std_logic;
    reg0_init_val : in std_logic_vector(31 downto 0);
    reg1_init_val : in std_logic_vector(31 downto 0);
    reg2_init_val : in std_logic_vector(31 downto 0);
    ctl0_out : out std_logic_vector(31 downto 0);
    ctl1_out : out std_logic_vector(31 downto 0);
    ctl2_out : out std_logic_vector(31 downto 0);
    stat0_in : in std_logic_vector(31 downto 0);
    stat1_in : in std_logic_vector(31 downto 0);
    intrpt_src_in : in std_logic_vector(6 downto 0);
    irq : out std_logic
  );
end component;


---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg1            : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg2            : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg0            : std_logic_vector(31 downto 0) := (others => '0');
signal int_src_stat         : std_logic_vector(6 downto 0)  := (others => '0');
signal t1_cntl_reg2_0       : std_logic:= '0';
signal awaddr               : std_logic_vector(6 downto 0) := (others => '0');
signal araddr               : std_logic_vector(6 downto 0) := (others => '0');

---------------------------------------------------------------------------------

begin

awaddr <= "00" & s_axi_csr_awaddr;
araddr <= "00" & s_axi_csr_araddr;

px_axil_csr_0_inst: px_axil_csr_0
  port map (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => s_axi_csr_aresetn,
    s_axi_csr_awaddr    => awaddr,
    s_axi_csr_awprot    => s_axi_csr_awprot,
    s_axi_csr_awvalid   => s_axi_csr_awvalid,
    s_axi_csr_awready   => s_axi_csr_awready,
    s_axi_csr_wdata     => s_axi_csr_wdata,
    s_axi_csr_wstrb     => s_axi_csr_wstrb,
    s_axi_csr_wvalid    => s_axi_csr_wvalid,
    s_axi_csr_wready    => s_axi_csr_wready,
    s_axi_csr_bresp     => s_axi_csr_bresp,
    s_axi_csr_bvalid    => s_axi_csr_bvalid,
    s_axi_csr_bready    => s_axi_csr_bready,
    s_axi_csr_araddr    => araddr,
    s_axi_csr_arprot    => s_axi_csr_arprot,
    s_axi_csr_arvalid   => s_axi_csr_arvalid,
    s_axi_csr_arready   => s_axi_csr_arready,
    s_axi_csr_rdata     => s_axi_csr_rdata,
    s_axi_csr_rresp     => s_axi_csr_rresp,
    s_axi_csr_rvalid    => s_axi_csr_rvalid,
    s_axi_csr_rready    => s_axi_csr_rready,
    reg0_init_val       => x"00000000",
    reg1_init_val       => x"00000000",
    reg2_init_val       => x"00000000",
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    stat0_in            => stat_reg0,
    stat1_in            => x"00000000",
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------

-- Bit [0] = CDC Reset
-- Bit [1] = CDC RESET Out to SYNC Bus
-- Bit [2] = CDC RESET In from SYNC Bus Enable
-- Bit [6:4] = Clock Mux Control
-- Bit [7] = VCXO Output Disable 

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       reg_rst             <= cntl_reg0(0); 
       cntl_word           <= cntl_reg1; 
       t1_cntl_reg2_0      <= cntl_reg2(0);
       wr_req              <= cntl_reg2(0) and not t1_cntl_reg2_0;
       vcxo_en             <= not cntl_reg0(7);  
       if (cntl_reg0(6)= '1') then
          clk_mux_sel      <= cntl_reg0(5 downto 4);
       else
          clk_mux_sel      <= ((not cntl_reg0(5)) & cntl_reg0(4));
       end if; 
       vcxo_sel_n          <= cntl_reg0(6); 
       
       cdc_sync_rst_out    <= cntl_reg0(1);
       cdc_sync_rst_in_en  <= cntl_reg0(2);   
    end if;
end process;

--------------------------------------------------------------------------------
-- Status Registers
--------------------------------------------------------------------------------
-- Bit [0] = cdc_stat_vcxo        
-- Bit [1] = cdc_stat_ref         
-- Bit [2] = cdc_stat_lock                    
-- Bit [3] = default_load_done    
-- Bit [4] = sm_ready 

stat_reg0 <= x"000000" & "000" & sm_ready & default_load_done & cdc_stat_lock & cdc_stat_ref & cdc_stat_vcxo;

--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------

-- Bit [0] = vcxo lost
-- Bit [1] = vcxo found
-- Bit [2] = ref lost
-- Bit [3] = ref found
-- Bit [4] = lock lost
-- Bit [5] = lock found 
-- Bit [6] = cdc write done

int_src_stat <= sm_ready & cdc_stat_lock & (not cdc_stat_lock) & cdc_stat_ref & (not cdc_stat_ref) & cdc_stat_vcxo & (not cdc_stat_vcxo);

                    
end Behavioral;