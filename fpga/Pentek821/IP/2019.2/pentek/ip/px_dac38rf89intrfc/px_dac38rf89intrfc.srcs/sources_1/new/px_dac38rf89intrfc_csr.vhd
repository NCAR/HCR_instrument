----------------------------------------------------------------------------------
-- Company:  Pentek Inc
-- Engineer: G.L.
-- 	
-- Create Date: 06/06/2017 
-- IP Core Name: PX_DAC38RF89_INTRFC
-- File Name: px_dac38rf89intrfc_csr.vhd 
-- Target Devices: Kintex UltraScale  
-- Tool Versions: 2017.1
-- Description:  This is a submodule for the PX_DAC38RF89_INTRFC IP Core.
-- This submodule is the control and status register software interface for the 
-- PX_DAC38RF89_INTRFC IP Core. 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.0 - 6/6/2017 - Module Created
-- Additional Comments:
-- 

-- (Memory Map)
-- 0x00 - DAC Control Register      R/W
-- 0x04 - DAC SPI Control Register  R/W
-- 0x08 - DAC Status Register       RO
-- 0x0C - DAC SPI Status Register   R/W
-- 0x10 - Interrupt Enables         R/W
-- 0x14 - Interrupt Status          RO
-- 0x18 - Interrupt Flags           R/Clr

-- (Additional Info)
-- Example: Requires the pentek Control and Status register px_axil_csr IP Core

----------------------------------------------------------------------------------

-- (Technical Support for Pentek's GateFlow FPGA Design Kits)  
-- Technical support for Pentek's GateFlow FPGA Design Kits is available via e-mail 
-- (fpgasupport@pentek.com) or by phone (201-818-5900 ext. 238, 9 AM to 5 PM US 
-- Eastern time.) Names or initials contained within the source code are part of 
-- our revision control regime.  Please do not try to use these references to 
-- pursue technical support                              

-- (c) Copyright 2017 Pentek, Inc. All rights reserved.
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_dac38rf89intrfc_csr is
Port
( 
    s_axi_csr_aclk           : in  std_logic;
    s_axi_csr_aresetn        : in  std_logic;
    s_axi_csr_awaddr         : in  std_logic_vector(6 downto 0);
    s_axi_csr_awprot         : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid        : in  std_logic;
    s_axi_csr_awready        : out std_logic;
    s_axi_csr_wdata          : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb          : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid         : in  std_logic;
    s_axi_csr_wready         : out std_logic;
    s_axi_csr_bresp          : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid         : out std_logic;
    s_axi_csr_bready         : in  std_logic;
    s_axi_csr_araddr         : in  std_logic_vector(6 downto 0);
    s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid        : in  std_logic;
    s_axi_csr_arready        : out std_logic;
    s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid         : out std_logic;
    s_axi_csr_rready         : in  std_logic;
    
    dac_sample_clk           : in std_logic;
    
    dac_pack_rst             : out std_logic;
    sync_latch_clr           : out std_logic;       
    sync_latch_en            : out std_logic;         
    
    --Serial Interface 
    dac_sout                 : in  std_logic;
    dac_sdi                  : inout std_logic;
    dac_scs_n                : out std_logic;
    dac_sclk                 : out std_logic;
    
    --Dac control registers  
    dac_reset_n              : out std_logic;
    dac_txena                : out std_logic;  
    dac_sleep                : out std_logic;
   
    dac_jesd_format_mode     : out std_logic_vector(2 downto 0);
    wide_duc_mode            : out std_logic;    
    
    dac_alarm                : in std_logic;
    
    irq                      : out std_logic
    
    
    
    
);
end px_dac38rf89intrfc_csr;

architecture Behavioral of px_dac38rf89intrfc_csr is

signal s_axi_csr_aresetn_reg : std_logic;

signal csr_reg0_init_val : std_logic_vector(31 downto 0);
signal csr_reg1_init_val : std_logic_vector(31 downto 0);

signal csr_ctl0_out      : std_logic_vector(31 downto 0);
signal csr_ctl1_out      : std_logic_vector(31 downto 0);

signal csr_stat0_in      : std_logic_vector(31 downto 0);
signal csr_stat1_in      : std_logic_vector(31 downto 0);

signal intrpt_src_in     : STD_LOGIC_VECTOR(0 DOWNTO 0);

signal px_serial_int_dac_addr    : std_logic_vector(6 downto 0);
signal px_serial_int_dac_wr_data : std_logic_vector(15 downto 0);
signal px_serial_int_dac_rd_data : std_logic_vector(15 downto 0);
signal px_serial_int_dac_wr_pls  : std_logic;
signal px_serial_int_dac_rd_pls  : std_logic;

signal px_serial_int_dac_sm_rdy  : std_logic;

COMPONENT px_dac_csr
PORT (
  s_axi_csr_aclk : IN STD_LOGIC;
  s_axi_csr_aresetn : IN STD_LOGIC;
  s_axi_csr_awaddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
  s_axi_csr_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  s_axi_csr_awvalid : IN STD_LOGIC;
  s_axi_csr_awready : OUT STD_LOGIC;
  s_axi_csr_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  s_axi_csr_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  s_axi_csr_wvalid : IN STD_LOGIC;
  s_axi_csr_wready : OUT STD_LOGIC;
  s_axi_csr_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
  s_axi_csr_bvalid : OUT STD_LOGIC;
  s_axi_csr_bready : IN STD_LOGIC;
  s_axi_csr_araddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
  s_axi_csr_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  s_axi_csr_arvalid : IN STD_LOGIC;
  s_axi_csr_arready : OUT STD_LOGIC;
  s_axi_csr_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  s_axi_csr_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
  s_axi_csr_rvalid : OUT STD_LOGIC;
  s_axi_csr_rready : IN STD_LOGIC;
  reg0_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  reg1_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  intrpt_src_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
  irq : OUT STD_LOGIC
);
END COMPONENT; 



COMPONENT px_serial_int_dac
  PORT (
    clk_in   : IN STD_LOGIC;
    rst_n    : IN STD_LOGIC;
    data_in  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    addr     : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    wr       : IN STD_LOGIC;
    rd       : IN STD_LOGIC;
    data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    sm_rdy   : OUT STD_LOGIC;
    sdi      : INOUT STD_LOGIC;
    sdenb    : OUT STD_LOGIC;
    sclk     : OUT STD_LOGIC;
    sdo      : IN STD_LOGIC
  );
END COMPONENT;

 
begin

process(s_axi_csr_aclk) begin

    if(rising_edge(s_axi_csr_aclk)) then
        s_axi_csr_aresetn_reg <= s_axi_csr_aresetn;
    end if;

end process;

csr_reg0_init_val <= (others => '0');
csr_reg1_init_val <= (others => '0');
csr_stat0_in      <= (others => '0');

csr: px_dac_csr
PORT map
(
  s_axi_csr_aclk    => s_axi_csr_aclk,          
  s_axi_csr_aresetn => s_axi_csr_aresetn_reg,       
  s_axi_csr_awaddr  => s_axi_csr_awaddr,        
  s_axi_csr_awprot  => s_axi_csr_awprot,        
  s_axi_csr_awvalid => s_axi_csr_awvalid,       
  s_axi_csr_awready => s_axi_csr_awready,       
  s_axi_csr_wdata   => s_axi_csr_wdata,         
  s_axi_csr_wstrb   => s_axi_csr_wstrb,         
  s_axi_csr_wvalid  => s_axi_csr_wvalid,        
  s_axi_csr_wready  => s_axi_csr_wready,        
  s_axi_csr_bresp   => s_axi_csr_bresp,         
  s_axi_csr_bvalid  => s_axi_csr_bvalid,        
  s_axi_csr_bready  => s_axi_csr_bready,        
  s_axi_csr_araddr  => s_axi_csr_araddr,        
  s_axi_csr_arprot  => s_axi_csr_arprot,        
  s_axi_csr_arvalid => s_axi_csr_arvalid,       
  s_axi_csr_arready => s_axi_csr_arready,       
  s_axi_csr_rdata   => s_axi_csr_rdata,         
  s_axi_csr_rresp   => s_axi_csr_rresp,         
  s_axi_csr_rvalid  => s_axi_csr_rvalid,        
  s_axi_csr_rready  => s_axi_csr_rready,        
  
  reg0_init_val     => csr_reg0_init_val,
  reg1_init_val     => csr_reg1_init_val,
  ctl0_out          => csr_ctl0_out,
  ctl1_out          => csr_ctl1_out,
  stat0_in          => csr_stat0_in,
  stat1_in          => csr_stat1_in,
  
  intrpt_src_in     => intrpt_src_in, 
  irq               => irq
);

process(s_axi_csr_aclk) begin
  
      if(rising_edge(s_axi_csr_aclk)) then
          
         
          -- DAC Control Registers - Addr = 0x00
          dac_reset_n <= not csr_ctl0_out(0);
          dac_txena   <= csr_ctl0_out(1);
          dac_sleep   <= csr_ctl0_out(2);
      
          -- SPI Interface control register - Addr = 0x04
          px_serial_int_dac_addr     <= csr_ctl1_out(6 downto 0);   
          px_serial_int_dac_wr_data  <= csr_ctl1_out(23 downto 8);
           
          px_serial_int_dac_wr_pls   <= csr_ctl1_out(24);
          px_serial_int_dac_rd_pls   <= csr_ctl1_out(25);
          
          -- DAC Status Register - Addr = 0x08
          csr_stat0_in    <= (others => '0');
          csr_stat1_in(0) <= dac_alarm; 
          
          -- SPI Interface status register - Addr = 0x0C 
          csr_stat1_in(15 downto 0)  <= px_serial_int_dac_rd_data;
          csr_stat1_in(16)           <= px_serial_int_dac_sm_rdy;
          csr_stat1_in(31 downto 17) <= (others => '0');
          
          -- Control/Status/Flag - Addr = 0x10/0x14/0x1C
          intrpt_src_in(0)           <= dac_alarm;
          
      end if;
  end process;
  
  ------------------------------------------------------------------------------
  -- -- DAC Control Registers - Addr = 0x00
  ------------------------------------------------------------------------------
  xpm_cdc_dac_pack_rst_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl0_out(3),
     dest_clk => dac_sample_clk,
     dest_out => dac_pack_rst
  );
  
  xpm_cdc_sync_latch_clr_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl0_out(4),
     dest_clk => dac_sample_clk,
     dest_out => sync_latch_clr
  );
  
  xpm_cdc_sync_latch_en_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl0_out(5),
     dest_clk => dac_sample_clk,
     dest_out => sync_latch_en
  );
  
  xpm_cdc_jmode_inst: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 3  -- integer; range: 1-1024

  )
  port map (

    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => csr_ctl0_out(10 downto 8),
    dest_clk => dac_sample_clk,
    dest_out => dac_jesd_format_mode
  );
  
  xpm_cdc_wide_duc_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl0_out(11),
     dest_clk => dac_sample_clk,
     dest_out => wide_duc_mode
  );
  
  

   
serial: px_serial_int_dac
  PORT map
  (
    clk_in   => s_axi_csr_aclk,
    rst_n    => s_axi_csr_aresetn_reg, 
    data_in  => px_serial_int_dac_wr_data,
    addr     => px_serial_int_dac_addr,  
    wr       => px_serial_int_dac_wr_pls, 
    rd       => px_serial_int_dac_rd_pls,
    data_out => px_serial_int_dac_rd_data, 
    sm_rdy   => px_serial_int_dac_sm_rdy,
    sdi      => dac_sdi,
    sdenb    => dac_scs_n,
    sclk     => dac_sclk,
    sdo      => dac_sout 
  );


end Behavioral;
