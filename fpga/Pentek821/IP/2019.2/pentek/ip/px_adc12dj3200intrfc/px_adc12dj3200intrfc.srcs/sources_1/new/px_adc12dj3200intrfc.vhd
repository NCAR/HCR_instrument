----------------------------------------------------------------------------------
-- Company:  Pentek Inc
-- Engineer: G.L.
-- 	
-- Create Date: 05/08/2017 
-- IP Core Name: PX_ADC12DJ3200_INTRFC
-- File Name: px_adc12dj3200_intrfc.vhd 
-- Target Devices: Kintex UltraScale  
-- Tool Versions: 2016.4
-- Description: This is the top level module for the PX_ADC12DJ3200INTRFC IP Core. 
-- This interfaces to the Texas Intrument ADC12DJ3200 analog to digtial converter 
-- chip. It receives analog data via a AXI-Stream slave bus from a JESD interface, 
-- unpacks and re-orders the data for output via a AXI-Stream master bus. This IP 
-- Core supports 8-lane, 4-lane and 2-lane JESD operation in Jmodes 0,2,9,11,14 and 16. A software register 
-- set allows for additional control of the ADC12DJ3200 device. (See datasheet
-- for ADC12DJ3200 device.)
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revisoin 1.2 - 3/4/2019 - Added jesd_buffer_fifo_rst for component 
--                           px_adc12dj3200intrfc_unpack
-- Revision 1.1 - 5/2/2018 - Added nco_a_cntrl_start and nco_b_cntrl_start from
-- csr to NCO controller.
-- Added an additional pipeline to s_axis_timecntl_tdata and s_axis_timecntl_tvalid
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
-- 0x18 - Reserved                  R/W
-- 0x1C - ADC Control Status        RO
-- 0x20 - ADC SPI Readback          RO
-- 0x24 - NCO Control Status        RO
-- 0x28 - Interrupt Enables         R/W
-- 0x2C - Interrupt Status          RO
-- 0x30 - Interrupt Flags           R/Clr

-- (Additional Info)
-- Example: Requires a seperate JESD Interface to receive data from the 
-- ADC12DJ3200 analog to digital chip

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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;
Library xpm;
use xpm.vcomponents.all;


entity px_adc12dj3200intrfc is
generic (

    initial_led_select    : integer range 0 to 3 := 0;
    led_pulse_stretch     : integer range 0 to 65535:= 65535 -- counts to pulse stretch LED

);
Port 
(
    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI4-LITE)
    ----------------------------------------------------------------------------
    -- associated with s_axi_csr_aclk
    s_axi_csr_aclk           : in  std_logic;
    s_axi_csr_aresetn        : in  std_logic;
    s_axi_csr_awaddr         : in  std_logic_vector(11 downto 0);
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
    s_axi_csr_araddr         : in  std_logic_vector(11 downto 0);
    s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid        : in  std_logic;
    s_axi_csr_arready        : out std_logic;
    s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid         : out std_logic;
    s_axi_csr_rready         : in  std_logic;
    
    irq                      : out std_logic;
        
    -- Timing events interface
    -- associated with adc_sample_clk
    s_axis_timecntl_tvalid   : in std_logic;
    s_axis_timecntl_tdata    : in std_logic_vector(31 downto 0);
    
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
    
    -- NCO Selection
    adc_nco_a_out            : out std_logic_vector(1 downto 0);
    adc_nco_b_out            : out std_logic_vector(1 downto 0);
    adc_pd                   : out std_logic;
                                              
    -- Time Stamp
    adc_tmstp_p              : out std_logic;
    adc_tmptp_n              : out std_logic;
    
    -- JESD Mode  
    jmode                    : out std_logic_vector(4 downto 0);
    
    -- LED input and output control
    ext_led_src              : in std_logic;
    ovld_led_n               : out std_logic;

    rx_core_clk              : in std_logic;
    
    s_axis_jesd_rx_pd_tdata  : in std_logic_vector(255 downto 0);
    s_axis_jesd_rx_pd_tvalid : in std_logic;
    
    adc_sample_clk           : in std_logic;
    
    m_axis_adc1_pd_tdata      : out std_logic_vector(255 downto 0);
    m_axis_adc1_pd_tvalid     : out std_logic;
    
    m_axis_adc2_pd_tdata      : out std_logic_vector(255 downto 0);
    m_axis_adc2_pd_tvalid     : out std_logic

);
end px_adc12dj3200intrfc;

architecture Behavioral of px_adc12dj3200intrfc is


ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of rx_core_clk: SIGNAL is "xilinx.com:signal:clock:1.0 rx_core_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of rx_core_clk: SIGNAL is "ASSOCIATED_BUSIF s_axis_jesd_rx_pd";

ATTRIBUTE X_INTERFACE_INFO of adc_sample_clk: SIGNAL is "xilinx.com:signal:clock:1.0 adc_sample_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of adc_sample_clk: SIGNAL is "ASSOCIATED_BUSIF s_axis_timecntl:m_axis_adc1_pd:m_axis_adc2_pd";

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

signal jmode_sig     : std_logic_vector(4 downto 0);

signal jesd_buffer_fifo_rst     : std_logic := '0';

signal nco_a_src                : std_logic := '0';
signal nco_b_src                : std_logic := '0';
signal nco_a_soft_sel           : std_logic_vector(1 downto 0) := "00";
signal nco_b_soft_sel           : std_logic_vector(1 downto 0) := "00";
signal nco_a_cntrl_rst          : std_logic := '0';
signal nco_b_cntrl_rst          : std_logic := '0';
signal nco_a_cntrl_en           : std_logic := '0';
signal nco_b_cntrl_en           : std_logic := '0';
signal nco_a_sel_auto_cntrs     : std_logic_vector(31 downto 0) := X"00000000";
signal nco_b_sel_auto_cntrs     : std_logic_vector(31 downto 0) := X"00000000";
signal nco_a_cntrl_start        : std_logic := '0';
signal nco_b_cntrl_start        : std_logic := '0';
signal nco_auto_cntr_incr_src_a : std_logic_vector(1 downto 0) := "00";
signal nco_auto_cntr_incr_src_b : std_logic_vector(1 downto 0) := "00";
signal adc_nco_a                : std_logic_vector(1 downto 0) := "00";
signal adc_nco_b                : std_logic_vector(1 downto 0) := "00";

signal led_lite         : std_logic:= '0';
signal pls_strch_cntr   : std_logic_vector(15 downto 0) := (others => '0');

signal t1_adc_ora       : std_logic_vector(1 downto 0) := "00";
signal t1_adc_orb       : std_logic_vector(1 downto 0) := "00";
signal t2_adc_ora       : std_logic_vector(1 downto 0) := "00";
signal t2_adc_orb       : std_logic_vector(1 downto 0) := "00";
signal t3_adc_ora       : std_logic_vector(1 downto 0) := "00";
signal t3_adc_orb       : std_logic_vector(1 downto 0) := "00";
signal adc_overload_a   : std_logic := '0';
signal adc_overload_b   : std_logic := '0';

-- /Over_thresh_cnt/led_sel
signal led_selx                  : std_logic_vector(1 downto 0) := "00";
              
signal led_sel                   : std_logic_vector(1 downto 0)  := "00";

signal ctl_x                     : std_logic_vector(1 downto 0) := (others => '0');
signal ctl                       : std_logic_vector(1 downto 0) := (others => '0');
signal src_rcvc                  : std_logic := '0';
signal src_sendc                 : std_logic := '0';
signal dest_reqc                 : std_logic := '0';

signal s_axis_timecntl_tvalid_reg    : std_logic;
signal s_axis_timecntl_tdata_reg     : std_logic_vector(31 downto 0);


component px_adc12dj3200intrfc_csr
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
    
    -- led_sel
    led_sel                  : out std_logic_vector(1 downto 0)
);
end component;

component px_adc12dj3200intrfc_unpack 
Port 
( 
     jmode : in std_logic_vector(4 downto 0);
     
     jesd_buffer_fifo_rst     : in std_logic;
    
     rx_core_clk              : in std_logic;
     s_axis_jesd_rx_pd_tdata  : in std_logic_vector(255 downto 0);
     s_axis_jesd_rx_pd_tvalid : in std_logic;
    
     adc_sample_clk           : in std_logic;
     
     m_axis_adc1_pd_tdata     : out std_logic_vector(255 downto 0);
     m_axis_adc1_pd_tvalid    : out std_logic;
     
     m_axis_adc2_pd_tdata     : out std_logic_vector(255 downto 0);
     m_axis_adc2_pd_tvalid    : out std_logic

);
end component;

component px_adc12dj3200intrfc_nco is

port
(
    adc_sample_clk           : in std_logic;
    
    nco_src                  : in std_logic;
    nco_soft_sel             : in std_logic_vector(1 downto 0);
    nco_cntrl_rst            : in std_logic;
    nco_cntrl_en             : in std_logic;
    nco_cntrl_start          : in std_logic;
    nco_auto_cntr_incr_src   : in std_logic_vector(1 downto 0);
    nco_sel_auto_cntrs       : in std_logic_vector(31 downto 0);
    
    
    s_axis_timecntl_tvalid   : in std_logic;
    s_axis_timecntl_tdata    : in std_logic_vector(31 downto 0);

    adc_nco_out              : out std_logic_vector(1 downto 0)
);

end component;

begin

process(adc_sample_clk) begin
    if(rising_edge(adc_sample_clk)) then
        adc_nco_a_out <= adc_nco_a; 
        adc_nco_b_out <= adc_nco_b;
        
        s_axis_timecntl_tvalid_reg <= s_axis_timecntl_tvalid;  
        s_axis_timecntl_tdata_reg  <= s_axis_timecntl_tdata;  
        
    end if;
end process;

xpm_cdc_jmode_inst: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 5  -- integer; range: 1-1024

  )
  port map (

    src_clk  => rx_core_clk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => jmode_sig,
    dest_clk => adc_sample_clk,
    dest_out => jmode
  );

adc12d_csr_i: px_adc12dj3200intrfc_csr
generic map
(

    initial_led_select  => initial_led_select
)
Port map
(
    s_axi_csr_aclk           => s_axi_csr_aclk   , 
    s_axi_csr_aresetn        => s_axi_csr_aresetn, 
    s_axi_csr_awaddr         => s_axi_csr_awaddr(6 downto 0) , 
    s_axi_csr_awprot         => s_axi_csr_awprot , 
    s_axi_csr_awvalid        => s_axi_csr_awvalid, 
    s_axi_csr_awready        => s_axi_csr_awready, 
    s_axi_csr_wdata          => s_axi_csr_wdata  , 
    s_axi_csr_wstrb          => s_axi_csr_wstrb  , 
    s_axi_csr_wvalid         => s_axi_csr_wvalid , 
    s_axi_csr_wready         => s_axi_csr_wready , 
    s_axi_csr_bresp          => s_axi_csr_bresp  , 
    s_axi_csr_bvalid         => s_axi_csr_bvalid , 
    s_axi_csr_bready         => s_axi_csr_bready , 
    s_axi_csr_araddr         => s_axi_csr_araddr(6 downto 0) , 
    s_axi_csr_arprot         => s_axi_csr_arprot , 
    s_axi_csr_arvalid        => s_axi_csr_arvalid, 
    s_axi_csr_arready        => s_axi_csr_arready, 
    s_axi_csr_rdata          => s_axi_csr_rdata  , 
    s_axi_csr_rresp          => s_axi_csr_rresp  , 
    s_axi_csr_rvalid         => s_axi_csr_rvalid , 
    s_axi_csr_rready         => s_axi_csr_rready ,
    
    irq                      => irq,
    
    rx_core_clk              => rx_core_clk,
    adc_sample_clk           => adc_sample_clk,
    
    jmode                    => jmode_sig,
    jesd_buffer_fifo_rst     => jesd_buffer_fifo_rst,
    
    nco_a_src                => nco_a_src,
    nco_b_src                => nco_b_src,
    nco_a_soft_sel           => nco_a_soft_sel,
    nco_b_soft_sel           => nco_b_soft_sel,
    nco_a_cntrl_rst          => nco_a_cntrl_rst,        
    nco_b_cntrl_rst          => nco_b_cntrl_rst,    
    nco_a_cntrl_en           => nco_a_cntrl_en,     
    nco_b_cntrl_en           => nco_b_cntrl_en,     
    nco_auto_cntr_incr_src_a => nco_auto_cntr_incr_src_a,
    nco_auto_cntr_incr_src_b => nco_auto_cntr_incr_src_b,
    nco_a_sel_auto_cntrs     => nco_a_sel_auto_cntrs,
    nco_b_sel_auto_cntrs     => nco_b_sel_auto_cntrs,
    nco_a_cntrl_start        => nco_a_cntrl_start,        
    nco_b_cntrl_start        => nco_b_cntrl_start,   
    adc_nco_a_status         => adc_nco_a,
    adc_nco_b_status         => adc_nco_b,
    
    
    adc_ora                  => t3_adc_ora,                
    adc_orb                  => t3_adc_orb,                
                              
    adc_calstat              => adc_calstat,            
    adc_caltrig              => adc_caltrig,            
                                                     
    adc_sout                 => adc_sout,               
    adc_sdi                  => adc_sdi,                
    adc_scs_n                => adc_scs_n,              
    adc_sclk                 => adc_sclk,               
                              
    adc_pd                   => adc_pd,                 
                              
    adc_tmstp_p              => adc_tmstp_p,            
    adc_tmptp_n              => adc_tmptp_n,
             
    led_sel                  => led_selx           
);
  
adc12dj3200_unpack_inst: px_adc12dj3200intrfc_unpack 
Port map
( 
     jmode                    => jmode_sig,
     
     jesd_buffer_fifo_rst     => jesd_buffer_fifo_rst,
    
     rx_core_clk              => rx_core_clk,             
     s_axis_jesd_rx_pd_tdata  => s_axis_jesd_rx_pd_tdata, 
     s_axis_jesd_rx_pd_tvalid => s_axis_jesd_rx_pd_tvalid,
                               
     adc_sample_clk           => adc_sample_clk,                 
     m_axis_adc1_pd_tdata     => m_axis_adc1_pd_tdata,   
     m_axis_adc1_pd_tvalid    => m_axis_adc1_pd_tvalid,   
     
     m_axis_adc2_pd_tdata     => m_axis_adc2_pd_tdata,  
     m_axis_adc2_pd_tvalid    => m_axis_adc2_pd_tvalid 

);

nco_a_inst: px_adc12dj3200intrfc_nco 
port map
(
    adc_sample_clk           => adc_sample_clk,
    
    nco_src                  => nco_a_src,
    nco_soft_sel             => nco_a_soft_sel,
    nco_cntrl_rst            => nco_a_cntrl_rst,
    nco_cntrl_en             => nco_a_cntrl_en,
    nco_cntrl_start          => nco_a_cntrl_start,
    nco_auto_cntr_incr_src   => nco_auto_cntr_incr_src_a,
    nco_sel_auto_cntrs       => nco_a_sel_auto_cntrs,
    
    s_axis_timecntl_tvalid   => s_axis_timecntl_tvalid_reg,
    s_axis_timecntl_tdata    => s_axis_timecntl_tdata_reg,

    adc_nco_out              => adc_nco_a
);

nco_b_inst: px_adc12dj3200intrfc_nco 
port map
(
    adc_sample_clk           => adc_sample_clk,
    
    nco_src                  => nco_b_src,
    nco_soft_sel             => nco_b_soft_sel,
    nco_cntrl_rst            => nco_b_cntrl_rst,
    nco_cntrl_en             => nco_b_cntrl_en,
    nco_cntrl_start          => nco_b_cntrl_start,
    nco_auto_cntr_incr_src   => nco_auto_cntr_incr_src_b,
    nco_sel_auto_cntrs       => nco_b_sel_auto_cntrs,
    
    s_axis_timecntl_tvalid   => s_axis_timecntl_tvalid_reg,
    s_axis_timecntl_tdata    => s_axis_timecntl_tdata_reg,

    adc_nco_out              => adc_nco_b
);

ctl_x <= led_selx;

ctl_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 2  -- integer; range: 1-1024
)
port map (
  src_clk    => s_axi_csr_aclk,
  src_in     => ctl_x,
  src_send   => src_sendc,
  src_rcv    => src_rcvc,
  dest_clk   => adc_sample_clk,
  dest_req   => dest_reqc,
  dest_ack   => dest_reqc, 
  dest_out   => ctl
);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcvc = '1') then
       src_sendc <= '0';
     elsif (src_rcvc = '0') and (src_sendc = '0') then
       src_sendc <= '1';
     end if;  
   end if;
end process;   

led_sel         <= ctl(1 downto 0);

process(adc_sample_clk)
begin
   if rising_edge(adc_sample_clk) then
   
      t1_adc_ora   <= adc_ora;   
      t1_adc_orb   <= adc_orb;   
      t2_adc_ora   <= t1_adc_ora;   
      t2_adc_orb   <= t1_adc_orb;   
      t3_adc_ora   <= t2_adc_ora;   
      t3_adc_orb   <= t2_adc_orb;   
   
      adc_overload_a <= t3_adc_ora(0);    -- raw data saturation
      adc_overload_b <= t3_adc_orb(0);    -- raw data saturation

   end if;
end process;

led_lite <= (adc_overload_a or adc_overload_b) when (led_sel = "00") else
            ext_led_src  when (led_sel = "10") else '0';

-- Pulse Stretcher keeps LED lit longer than overload so it is more visible.
process(adc_sample_clk)
begin
   if rising_edge(adc_sample_clk) then
      if led_lite = '1' then
         pls_strch_cntr    <= conv_std_logic_vector(led_pulse_stretch, 16);
      elsif pls_strch_cntr /= 0 then
         pls_strch_cntr    <= pls_strch_cntr - 1;
      end if;
    end if;
end process;

process(adc_sample_clk)
begin
   if rising_edge(adc_sample_clk) then
      if (pls_strch_cntr = 0) or (led_sel = "11") then
         ovld_led_n <= '1'; -- Overload LED Drive (active low)
      else
         ovld_led_n <= '0';
      end if;
    end if;
end process;

end Behavioral;
