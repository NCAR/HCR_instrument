----------------------------------------------------------------------------------
-- Company:  Pentek Inc
-- Engineer: G.L.
-- 	
-- Create Date: 05/08/2017 
-- IP Core Name: PX_ADC12DJ3200_INTRFC
-- File Name: px_adc12dj3200_intrfc_csr.vhd 
-- Target Devices: Kintex UltraScale  
-- Tool Versions: 2016.4
-- Description:  This is a submodule for the PX_ADC12DJ3200_INTRFC IP Core.
-- This submodule is the control and status register software interface for the 
-- PX_ADC12DJ3200_INTRFC IP Core. 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.2 - 3/4/2019 - Fixed software register bit for jesd_buffer_fifo_rst
--                           bit-3 to bit-2
-- Revision 1.1 - 5/2/2018 - Added nco_a_cntrl_start and nco_b_cntrl_start for
-- NCO controller state machine
--
-- Revision 1.0 - 5/8/2017 - Module Created
-- Additional Comments:
-- 

-- (Memory Map)
-- 0x00 - ADC Control Register      R/W
-- 0x04 - ADC SPI Interface         R/W
-- 0x08 - NCO Control Register      R/W
-- 0x0C - NCO A Auto Counters       R/W
-- 0x10 - NOC B Auto Counters       R/W 
-- 0x14 - Reserved                  R/W
-- 0x18 - Over Load Threshold Cnt   R/W
-- 0x1C - ADC Control Status        RO
-- 0x20 - ADC SPI Readback          RO
-- 0x24 - NCO Control Status        RO
-- 0x28 - Interrupt Enables         R/W
-- 0x2C - Interrupt Status          RO
-- 0x30 - Interrupt Flags           R/Clr

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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

Library xpm;
use xpm.vcomponents.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_adc12dj3200intrfc_csr is
generic (
 
    initial_led_select  : integer range 0 to 3 := 0
);
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
    
    irq                      : out std_logic;
    
    --------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------
    rx_core_clk              : in std_logic; 
    adc_sample_clk           : in std_logic;

    jmode                    : out std_logic_vector(4 downto 0);
    jesd_buffer_fifo_rst     : out std_logic;
    
    ---------------------------------------------------------------------------
    -- NCO Control
    ---------------------------------------------------------------------------
    nco_a_src                : out std_logic;
    nco_b_src                : out std_logic;
    nco_a_soft_sel           : out std_logic_vector(1 downto 0);
    nco_b_soft_sel           : out std_logic_vector(1 downto 0);
    nco_a_cntrl_rst          : out std_logic;
    nco_b_cntrl_rst          : out std_logic;
    nco_a_cntrl_en           : out std_logic;
    nco_b_cntrl_en           : out std_logic;
    nco_auto_cntr_incr_src_a : out std_logic_vector(1 downto 0);
    nco_auto_cntr_incr_src_b : out std_logic_vector(1 downto 0);
    nco_a_sel_auto_cntrs     : out std_logic_vector(31 downto 0);
    nco_b_sel_auto_cntrs     : out std_logic_vector(31 downto 0);
    nco_a_cntrl_start        : out std_logic;
    nco_b_cntrl_start        : out std_logic;
    adc_nco_a_status         : in std_logic_vector(1 downto 0);
    adc_nco_b_status         : in std_logic_vector(1 downto 0);
    
    --------------------------------------------------------------------------
    -- ADC12DJ3200 control signals
    --------------------------------------------------------------------------
    -- Over Range Detection
    adc_ora                  : in std_logic_vector(1 downto 0);
    adc_orb                  : in std_logic_vector(1 downto 0);
    
    -- Calibration and sync signals
    adc_calstat              : in  std_logic; 
    adc_caltrig              : out std_logic;
                                   
    --Serial Interface 
    adc_sout                 : in  std_logic;
    adc_sdi                  : inout std_logic;
    adc_scs_n                : out std_logic;
    adc_sclk                 : out std_logic;
    
    -- ADC Power Down
    adc_pd                   : out std_logic;
    
    -- Time Stamp
    adc_tmstp_p              : out std_logic;
    adc_tmptp_n              : out std_logic;
    
    -- /Over_thresh_cnt/led_sel
    led_sel                  : out std_logic_vector(1 downto 0)
    
);
end px_adc12dj3200intrfc_csr;

architecture Behavioral of px_adc12dj3200intrfc_csr is

signal s_axi_csr_aresetn_reg : std_logic := '0';

signal adc_pd_reg                : std_logic := '0';
signal adc_caltrig_reg           : std_logic := '0';

signal adc_ora_cdc              : std_logic_vector(1 downto 0):= (others => '0');
signal adc_orb_cdc              : std_logic_vector(1 downto 0):= (others => '0');
signal adc_calstat_reg          : std_logic := '0'; 

signal px_serial_int_adc_addr    : std_logic_vector(14 downto 0) := (others => '0');
signal px_serial_int_adc_wr_data : std_logic_vector(7 downto 0) := (others => '0');
signal px_serial_int_adc_rd_data : std_logic_vector(7 downto 0) := (others => '0');
signal px_serial_int_adc_wr      : std_logic := '0';
signal px_serial_int_adc_rd      : std_logic := '0';

signal px_serial_int_adc_sm_rdy  : std_logic := '0';

constant csr_reg0_init_val : std_logic_vector(31 downto 0) := X"00000" & "00" & conv_std_logic_vector(initial_led_select, 2) & X"00";
constant csr_reg1_init_val : std_logic_vector(31 downto 0) := (others => '0');
constant csr_reg2_init_val : std_logic_vector(31 downto 0) := (others => '0');
constant csr_reg3_init_val : std_logic_vector(31 downto 0) := (others => '0');
constant csr_reg4_init_val : std_logic_vector(31 downto 0) := (others => '0');
constant csr_reg5_init_val : std_logic_vector(31 downto 0) := (others => '0'); --reserved 
constant csr_reg6_init_val : std_logic_vector(31 downto 0) := (others => '0'); --reserved

signal csr_ctl0_out      : std_logic_vector(31 downto 0) := (others => '0');
signal csr_ctl1_out      : std_logic_vector(31 downto 0) := (others => '0');
signal csr_ctl2_out      : std_logic_vector(31 downto 0) := (others => '0');
signal csr_ctl3_out      : std_logic_vector(31 downto 0) := (others => '0');
signal csr_ctl4_out      : std_logic_vector(31 downto 0) := (others => '0');
signal csr_ctl5_out      : std_logic_vector(31 downto 0) := (others => '0');
signal csr_ctl6_out      : std_logic_vector(31 downto 0) := (others => '0');

signal csr_stat0_in      : std_logic_vector(31 downto 0) := (others => '0');
signal csr_stat1_in      : std_logic_vector(31 downto 0) := (others => '0');
signal csr_stat2_in      : std_logic_vector(31 downto 0) := (others => '0');

signal intrpt_src_in     : std_logic_vector(4 downto 0) := (others => '0');

COMPONENT px_adc12_csr
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
    reg2_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg3_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg4_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg5_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg6_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl3_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl4_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl5_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl6_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat2_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT px_serial_int_adc
  PORT 
  (
    clk_in   : IN STD_LOGIC;
    rst_n    : IN STD_LOGIC;
    data_in  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    addr     : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    wr       : IN STD_LOGIC;
    rd       : IN STD_LOGIC;
    data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
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


csr: px_adc12_csr
  port map
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
    reg2_init_val     => csr_reg2_init_val,
    reg3_init_val     => csr_reg3_init_val,
    reg4_init_val     => csr_reg4_init_val,
    reg5_init_val     => csr_reg5_init_val,
    reg6_init_val     => csr_reg6_init_val,
    ctl0_out          => csr_ctl0_out,
    ctl1_out          => csr_ctl1_out,
    ctl2_out          => csr_ctl2_out,
    ctl3_out          => csr_ctl3_out,
    ctl4_out          => csr_ctl4_out,
    ctl5_out          => csr_ctl5_out,
    ctl6_out          => csr_ctl6_out,
    stat0_in          => csr_stat0_in,
    stat1_in          => csr_stat1_in,
    stat2_in          => csr_stat2_in,
    intrpt_src_in     => intrpt_src_in,
    irq               => irq
  );
  
  
  process(s_axi_csr_aclk) begin
      if(rising_edge(s_axi_csr_aclk)) then
          adc_pd      <= adc_pd_reg;            
          adc_caltrig <= adc_caltrig_reg;  
          
          adc_calstat_reg <= adc_calstat;
                 
            
      end if;
  end process;

  process(s_axi_csr_aclk) begin
  
      if(rising_edge(s_axi_csr_aclk)) then
          
          -- ADC Control Registers - Addr = 0x00
          adc_caltrig_reg      <= csr_ctl0_out(0);
          adc_pd_reg           <= csr_ctl0_out(1);
          
          --LED Sel
          led_sel              <= csr_ctl0_out(10 downto 9);

          -- SPI Interface control register - Addr = 0x04
          px_serial_int_adc_addr     <= csr_ctl1_out(14 downto 0);   
          px_serial_int_adc_wr_data  <= csr_ctl1_out(23 downto 16);
           
          px_serial_int_adc_wr       <= csr_ctl1_out(24);
          px_serial_int_adc_rd       <= csr_ctl1_out(25);
          
          -- ADC Status Registers - Addr = 0x14
          csr_stat0_in(0)           <= adc_calstat_reg;
          csr_stat0_in(2 downto 1)  <= adc_ora_cdc;
          csr_stat0_in(4 downto 3)  <= adc_orb_cdc;
          csr_stat0_in(31 downto 5) <= (others => '0');
          
          
          -- SPI Interface status register - Addr = 0x18 
          csr_stat1_in(7 downto 0)  <= px_serial_int_adc_rd_data;
          csr_stat1_in(8)           <= '0';
          csr_stat1_in(9)           <= px_serial_int_adc_sm_rdy;
          csr_stat1_in(31 downto 10) <= (others => '0');
          
          -- Control/Status/Flag
          intrpt_src_in(0)           <= adc_calstat_reg;
          intrpt_src_in(2 downto 1)  <= adc_ora_cdc;
          intrpt_src_in(4 downto 3)  <= adc_orb_cdc;
          
      end if;
  end process;
  
  ------------------------------------------------------------------------------
  ------------------ ADC Control Register - Addr = 0x00 ------------------------
  ------------------------------------------------------------------------------
  
  xpm_cdc_jesd_buf_fifo_rst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl0_out(2),
     dest_clk => rx_core_clk,
     dest_out => jesd_buffer_fifo_rst
  );
 
  xpm_cdc_jmode_inst: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 5  -- integer; range: 1-1024

  )
  port map (

    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => csr_ctl0_out(8 downto 4),
    dest_clk => rx_core_clk,
    dest_out => jmode
  );
  
  ------------------------------------------------------------------------------
  --------------------- NCO Control Register - Addr = 0x08 ---------------------
  ------------------------------------------------------------------------------
  xpm_cdc_nco_a_src: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl2_out(0),
     dest_clk => adc_sample_clk,
     dest_out => nco_a_src
  );
  
  xpm_cdc_nco_b_src: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl2_out(1),
     dest_clk => adc_sample_clk,
     dest_out => nco_b_src
  );
  
  xpm_cdc_nco_soft_sel_a: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 2  -- integer; range: 1-1024

  )
  port map (

    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => csr_ctl2_out(5 downto 4),
    dest_clk => adc_sample_clk,
    dest_out => nco_a_soft_sel
  );
  
  xpm_cdc_nco_soft_sel_b: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 2  -- integer; range: 1-1024

  )
  port map (

    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => csr_ctl2_out(7 downto 6),
    dest_clk => adc_sample_clk,
    dest_out => nco_b_soft_sel
  );
  
  xpm_cdc_nco_a_cntrl_rst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl2_out(8),
     dest_clk => adc_sample_clk,
     dest_out => nco_a_cntrl_rst
  );
  
  xpm_cdc_nco_b_cntrl_rst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl2_out(9),
     dest_clk => adc_sample_clk,
     dest_out => nco_b_cntrl_rst
  );
  
  xpm_cdc_nco_a_cntrl_en: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl2_out(10),
     dest_clk => adc_sample_clk,
     dest_out => nco_a_cntrl_en
  );
  
  xpm_cdc_nco_b_cntrl_en: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl2_out(11),
     dest_clk => adc_sample_clk,
     dest_out => nco_b_cntrl_en
  );
  
  xpm_cdc_nco_cntr_incr_src_a: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 2  -- integer; range: 1-1024

  )
  port map (

    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => csr_ctl2_out(13 downto 12),
    dest_clk => adc_sample_clk,
    dest_out => nco_auto_cntr_incr_src_a
  );
  
  xpm_cdc_nco_cntr_incr_src_b: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 2  -- integer; range: 1-1024

  )
  port map (

    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => csr_ctl2_out(15 downto 14),
    dest_clk => adc_sample_clk,
    dest_out => nco_auto_cntr_incr_src_b
  );
  
  xpm_cdc_nco_a_cntrl_start: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl2_out(16),
     dest_clk => adc_sample_clk,
     dest_out => nco_a_cntrl_start
  ); 
  
  
  xpm_cdc_nco_b_cntrl_start: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => csr_ctl2_out(17),
     dest_clk => adc_sample_clk,
     dest_out => nco_b_cntrl_start
  ); 
    
  
  ------------------------------------------------------------------------------
  ---------------- NCO A Auto Counter Registers - Addr = 0x0C ------------------
  ------------------------------------------------------------------------------
  
  xpm_cdc_nco_a_sel_0: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 32  -- integer; range: 1-1024

  )
  port map (

    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => csr_ctl3_out,
    dest_clk => adc_sample_clk,
    dest_out => nco_a_sel_auto_cntrs
  );
  
  ------------------------------------------------------------------------------
  ---------------- NCO A Auto Counter Registers - Addr = 0x10 ------------------
  ------------------------------------------------------------------------------
  
  xpm_cdc_nco_b_sel_0: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 32  -- integer; range: 1-1024

  )
  port map (

    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => csr_ctl4_out,
    dest_clk => adc_sample_clk,
    dest_out => nco_b_sel_auto_cntrs
  );
  
  ------------------------------------------------------------------------------
  ---------------- NCO Selection Status Register - Addr = 0x1C -----------------
  ------------------------------------------------------------------------------
  
  xpm_cdc_nco_sel_stat_a: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 2  -- integer; range: 1-1024

  )
  port map (

    src_clk  => adc_sample_clk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => adc_nco_a_status,
    dest_clk => s_axi_csr_aclk,
    dest_out => csr_stat2_in(1 downto 0)
  );
  
  xpm_cdc_nco_sel_stat_b: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 2  -- integer; range: 1-1024

  )
  port map (

    src_clk  => adc_sample_clk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => adc_nco_b_status,
    dest_clk => s_axi_csr_aclk,
    dest_out => csr_stat2_in(3 downto 2)
  );
  
  csr_stat2_in(31 downto 4) <= (others => '0');
  
  
  
  xpm_cdc_ora_stat: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 2  -- integer; range: 1-1024

  )
  port map (

    src_clk  => adc_sample_clk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => adc_ora,
    dest_clk => s_axi_csr_aclk,
    dest_out => adc_ora_cdc
  );
  
  xpm_cdc_orb_stat: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 2  -- integer; range: 1-1024

  )
  port map (

    src_clk  => adc_sample_clk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => adc_orb,
    dest_clk => s_axi_csr_aclk,
    dest_out => adc_orb_cdc
  );
  
  serial: px_serial_int_adc
  port map
  (
    clk_in   => s_axi_csr_aclk,
    rst_n    => s_axi_csr_aresetn_reg,
    data_in  => px_serial_int_adc_wr_data,
    addr     => px_serial_int_adc_addr,
    wr       => px_serial_int_adc_wr,
    rd       => px_serial_int_adc_rd,
    data_out => px_serial_int_adc_rd_data,
    sm_rdy   => px_serial_int_adc_sm_rdy,
    sdi      => adc_sdi,       
    sdenb    => adc_scs_n,       
    sclk     => adc_sclk,     
    sdo      => adc_sout       
  );

  
  
 
  
end Behavioral;
