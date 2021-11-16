----------------------------------------------------------------------------------
-- Pentek BRAM to DAC wave Module 
----------------------------------------------------------------------------------
-- px_axis_bram2wave_256.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2018
--
-- Revision:
-- Revision 1.0 - File Created


-- Additional Comments: 


-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Trigger Clear                   R/W  
-- 0x08 BRAM Start Address              R/W
-- 0x0C BRAM End Address                R/W
-- 0x10 Status                          RO 
-- 0x14 Interrupt Enables               R/W  
-- 0x18 Status                          RO
-- 0x1C  
-- 0x20  
-- 0x24 Interrupt Enables               R/W   
-- 0x28 Interrupt Status Register       RO                     
-- 0x2C Interrupt Flag Register         R/Clr            

-- Mode Control Register
--Bit [0]   - trig_arm
--Bit [1]   - stay_armed
--Bit [3:2] - mode_sel[1:0]
            --  "00" = Gate Mode
            --  "01" = Trig Mode
            --  "10" = Trig Hold Mode
            --  "11" = Reserved 
--Bit [5:4] - data_mode_sel[1:0]
            -- "00" = Time Packed Real Data (I(t1),I(t0))
            -- "01" = Channel Packed I/Q Data or two channel Real (Q(0), I(0)) 
            -- "10" = Reserved
            -- "11" = Reserved
-- Bit [6]  -- local gate reg mode
-- Bit [7]  -- Local gate register bit 
-- BRAM Start Address    Register
-- Bit [n:0]  -- BRAM Start Address
-- Trigger Clear Register
-- Bit [0] - Trigger Clear
-- Bit [1] - Disarm after trigger ends


-- Interrupts
-- Bit [0] Start of Acquisition
-- Bit [1] End of Acquisition
-- Bit [2] Waiting for Arm Rising Edge
-- Bit [3] Armed Rising Edge
-- Bit [4] Trig Start
-- Bit [5] 
-- Bit [6] 
-- Bit [7] Bad Trigger - trigger occured before acq. ended
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2018 Pentek, Inc. All rights reserved.
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
-- Libraries
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_bram2wave_256 is
generic ( 
    addr_width: integer := 10 -- address width of DPBRAM Read Port
);
port (   
    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI-LITE)
    ----------------------------------------------------------------------------
    s_axi_csr_aclk           : in  std_logic;
    -- associated with s_axi_aclk
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
    
    irq                      : out std_logic; -- Interrupt out
    --------------------------------------------------------------------------------
    -- BRAM Interface
    --------------------------------------------------------------------------------
    -- From BRAM (expects a 2 cycle latency in BRAM) 
    bram_rdport_rst            : out std_logic;
    bram_rdport_clk            : out std_logic;
    bram_rdport_en             : out std_logic;
    bram_rdport_addr           : out std_logic_vector((addr_width-1) downto 0);  
    bram_rdport_rddata         : in  std_logic_vector(255 downto 0);
    -----------------------------------------------------------------------------
    s_axis_aclk              : in  std_logic; -- AXI Stream Clock
    s_axis_aresetn           : in  std_logic;
    -----------------------------------------------------------------------------
    -- Input Control (AXI4-Stream Slave) from Sync Bus
    -----------------------------------------------------------------------------
    -- synchronous to s_axis_aclk
    -- [0] = gate -- [8] = sync -- [16] = pps
    s_axis_pctl_tdata        : in  std_logic_vector(31 downto 0);  
    s_axis_pctl_tvalid       : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output Packetized Stream (AXI4-Stream Master) 
    ----------------------------------------------------------------------------
    -- No back pressure supported
    -- Constant output flow
    -- Stream is zero when not active
    m_axis_pd_tvalid       : out std_logic; 
    m_axis_pd_tdata        : out std_logic_vector(255 downto 0)
);
end px_axis_bram2wave_256;

architecture Behavioral of px_axis_bram2wave_256 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Control/Status Registers
component px_axis_bram2wave_256_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    axis_aclk             : in  std_logic; -- AXI-Stream Clock for clock domain crossing

    s_axi_csr_aclk        : in  std_logic;
    s_axi_csr_aresetn     : in  std_logic;
    s_axi_csr_awaddr      : in  std_logic_vector(5 downto 0);
    s_axi_csr_awprot      : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid     : in  std_logic;
    s_axi_csr_awready     : out std_logic;
    s_axi_csr_wdata       : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb       : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid      : in  std_logic;
    s_axi_csr_wready      : out std_logic;
    s_axi_csr_bresp       : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid      : out std_logic;
    s_axi_csr_bready      : in  std_logic;
    s_axi_csr_araddr      : in  std_logic_vector(5 downto 0);
    s_axi_csr_arprot      : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid     : in  std_logic;
    s_axi_csr_arready     : out std_logic;
    s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid      : out std_logic;
    s_axi_csr_rready      : in  std_logic;
    
    irq                   : out std_logic; -- interrupt
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    trig_clear            : out std_logic;
    trig_arm              : out std_logic;
    disarm                : out std_logic;
    mode_sel              : out std_logic_vector(1 downto 0);
    data_mode_sel         : out std_logic_vector(1 downto 0);
    stay_armed            : out std_logic;
    local_gate_mode       : out std_logic; 
    local_gate            : out std_logic;
    bram_strt_address     : out std_logic_vector(31 downto 0); 
    bram_end_address      : out std_logic_vector(31 downto 0); 
    trig_delay            : out std_logic_vector(31 downto 0);
    trig_len              : out std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------     
    waiting_arm  	        : in  std_logic;     
    armed                 : in  std_logic;
    active                : in  std_logic;
    mode                  : in  std_logic_vector(1 downto 0);
    data_mode             : in  std_logic_vector(1 downto 0);
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    acq_start             : in  std_logic;  
    acq_end               : in  std_logic;  
    waiting_arm_re        : in  std_logic;  
    armed_re              : in  std_logic;
    bad_trig              : in  std_logic;
    trig_start            : in  std_logic
       );
end component;

component px_axis_bram2wave_256_dwncntr
port ( 
    clk     : in  std_logic;
    sclr    : in  std_logic;
    ce      : in  std_logic;
    ld      : in  std_logic; -- qualified by ce
    ld_val  : in  std_logic_vector(31 downto 0);
    tc      : out std_logic;
    count   : out std_logic_vector(31 downto 0)  
);
end component;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type state_type is
(
RESET_STATE,
WAIT_TRIG_ARMED,
TRIG_ARMED_STATE
);

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant GATE_MODE        : std_logic_vector(1 downto 0) := "00";
constant TRIG_MODE        : std_logic_vector(1 downto 0) := "01";
constant TRIG_HOLD_MODE   : std_logic_vector(1 downto 0) := "10";
constant TIME_PACKED_MODE : std_logic_vector(1 downto 0) := "00";
constant IQ_PACKED_MODE   : std_logic_vector(1 downto 0) := "01";

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";
	
ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis_pd:s_axis_pctl";

ATTRIBUTE X_INTERFACE_INFO of bram_rdport_rst: SIGNAL is "xilinx.com:signal:reset:1.0 bram_rdport_rst RST";
ATTRIBUTE X_INTERFACE_PARAMETER of bram_rdport_rst: SIGNAL is "POLARITY ACTIVE_HIGH";

ATTRIBUTE X_INTERFACE_INFO of bram_rdport_clk: SIGNAL is "xilinx.com:signal:clock:1.0 bram_rdport_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of bram_rdport_clk: SIGNAL is "ASSOCIATED_BUSIF bram_rdport, ASSOCIATED_RESET bram_rdport_rst";

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal state             : state_type;
signal trig_clear        : std_logic := '0'; 
signal trig_arm          : std_logic := '0'; 
signal mode_sel          : std_logic_vector(1 downto 0) := (others => '0');  
signal data_mode_sel     : std_logic_vector(1 downto 0) := (others => '0');  
signal stay_armed        : std_logic := '0'; 
signal trig_len          : std_logic_vector(31 downto 0) := (others => '0');  
signal trig_dly          : std_logic_vector(31 downto 0) := (others => '0');  
signal waiting_arm       : std_logic := '0'; 
signal armed             : std_logic := '0'; 
signal active            : std_logic := '0'; 
signal mode              : std_logic_vector(1 downto 0) := (others => '0');  
signal data_mode         : std_logic_vector(1 downto 0) := (others => '0');  
signal acq_start         : std_logic := '0'; 
signal acq_end           : std_logic := '0'; 
signal waiting_arm_re    : std_logic := '0'; 
signal armed_re          : std_logic := '0'; 
signal xirq              : std_logic := '0'; 
signal xempty            : std_logic := '0'; 
signal xor_csr_irq       : std_logic := '0'; 
signal t1_s_axis_pctl_tvalid: std_logic := '0';
signal t2_s_axis_pctl_tvalid: std_logic := '0'; 
signal t2_gatetrig      : std_logic := '0'; 
signal t2_gate          : std_logic := '0'; 
signal t3_gate          : std_logic := '0';   
signal t3_gatetrig      : std_logic := '0'; 
signal t4_gatetrig      : std_logic := '0'; 
signal t2_trig_re       : std_logic := '0';     
signal t2_trig_cntr_ld  : std_logic := '0';   
signal t2_trig_cntr_ce  : std_logic := '0';   
signal trig_cntr_ld_val : std_logic_vector(31 downto 0) := (others => '0'); 
signal trig_dly_cntr_ld_val : std_logic_vector(31 downto 0) := (others => '0');   
signal pack_cntr        : std_logic := '0';
signal t1_waiting_arm   : std_logic := '0';
signal t1_armed         : std_logic := '0';
signal t1_csr_irq       : std_logic := '0';
signal frst             : std_logic := '0';
signal t4_mux_gate      : std_logic := '0';
signal t5_mux_gate      : std_logic := '0';
signal t5x_mux_gate     : std_logic := '0';
signal t3_trig_cntr_tc  : std_logic := '0';
signal t3_ts_gate       : std_logic := '0';
signal t3_trig_hold     : std_logic := '0';
signal trig_cntr_sclr   : std_logic := '0';
signal trig_count       : std_logic_vector(31 downto 0) := (others => '0'); 
signal dly_count        : std_logic_vector(31 downto 0) := (others => '0'); 
signal disarm            : std_logic := '0';
signal t3_trig_cntr_ld   : std_logic := '0';
signal t4_trig_cntr_ld   : std_logic := '0';
signal t2_trig_dly_cntr_ce: std_logic := '0';
signal t3_trig_dly_cntr_tc: std_logic := '0';
signal t4_trig_dly_cntr_tc: std_logic := '0';
signal local_gate_mode   : std_logic := '0'; 
signal local_gate        : std_logic := '0';
signal t1_s_axis_pctl_tdata: std_logic_vector(31 downto 0) := (others => '0');
signal t2_s_axis_pctl_tdata: std_logic_vector(31 downto 0) := (others => '0');
signal t3_s_axis_pctl_tdata: std_logic_vector(31 downto 0) := (others => '0');
signal t4_s_axis_pctl_tdata: std_logic_vector(31 downto 0) := (others => '0');
signal qual_gate         : std_logic := '0'; 
signal t1_qual_gate      : std_logic := '0'; 
signal t1_active         : std_logic := '0';
signal t2_active         : std_logic := '0';
signal t3_active         : std_logic := '0';
signal data_cntr         : std_logic_vector(3 downto 0) := (others => '0');
signal ltch_bram_end_addr : std_logic_vector(addr_width-1 downto 0) := (others => '0');
signal bram_strt_address: std_logic_vector(31 downto 0) := (others => '0');
signal bram_end_address: std_logic_vector(31 downto 0) := (others => '0');
signal bram_addr: std_logic_vector(addr_width-1 downto 0) := (others => '0');
signal p_csr_irq         : std_logic := '0'; 
signal retrig            : std_logic := '0';
signal t1_retrig         : std_logic := '0';
signal t2_retrig         : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';             
signal p_disarm_at_end     : std_logic := '0'; 
signal disarm_at_end       : std_logic := '0';
signal trig_start          : std_logic := '0';
signal bad_trig            : std_logic := '0';
signal t1_bad_trig         : std_logic := '0';
--------------------------------------------------------------------------------

begin
 

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        bram_rdport_rst  <= not t1_s_axi_csr_aresetn; 
   end if;
end process;

--------------------------------------------------------------------------------
-- Control/Status Registers  
--------------------------------------------------------------------------------

-- Control/Status Registers
csr_inst: px_axis_bram2wave_256_csr
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    axis_aclk             => s_axis_aclk,
    
    s_axi_csr_aclk        => s_axi_csr_aclk,                        
    s_axi_csr_aresetn     => t1_s_axi_csr_aresetn,                     
    s_axi_csr_awaddr      => s_axi_csr_awaddr(5 downto 0),          
    s_axi_csr_awprot      => s_axi_csr_awprot,                      
    s_axi_csr_awvalid     => s_axi_csr_awvalid,                     
    s_axi_csr_awready     => s_axi_csr_awready,                     
    s_axi_csr_wdata       => s_axi_csr_wdata(31 downto 0),                       
    s_axi_csr_wstrb       => s_axi_csr_wstrb,                       
    s_axi_csr_wvalid      => s_axi_csr_wvalid,                      
    s_axi_csr_wready      => s_axi_csr_wready,                      
    s_axi_csr_bresp       => s_axi_csr_bresp(1 downto 0),                       
    s_axi_csr_bvalid      => s_axi_csr_bvalid,                      
    s_axi_csr_bready      => s_axi_csr_bready,                      
    s_axi_csr_araddr      => s_axi_csr_araddr(5 downto 0),          
    s_axi_csr_arprot      => s_axi_csr_arprot,                      
    s_axi_csr_arvalid     => s_axi_csr_arvalid,                     
    s_axi_csr_arready     => s_axi_csr_arready,                     
    s_axi_csr_rdata       => s_axi_csr_rdata(31 downto 0),                       
    s_axi_csr_rresp       => s_axi_csr_rresp,                       
    s_axi_csr_rvalid      => s_axi_csr_rvalid,                      
    s_axi_csr_rready      => s_axi_csr_rready,                      
    
    irq                   => p_csr_irq,             -- interrupt
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    trig_clear            => trig_clear,   
    trig_arm              => trig_arm,    
    disarm                => disarm, 
    mode_sel              => mode_sel,     
    data_mode_sel         => data_mode_sel,
    stay_armed            => stay_armed, 
    local_gate_mode       => local_gate_mode,     
    local_gate            => local_gate,
    bram_strt_address     => bram_strt_address,
    bram_end_address      => bram_end_address,
    trig_delay            => trig_dly,
    trig_len              => trig_len,
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------     
    waiting_arm  	        => waiting_arm,
    armed                 => armed,      
    active                => active,     
    mode                  => mode,       
    data_mode             => data_mode, 
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    acq_start             => acq_start,       
    acq_end               => acq_end,         
    waiting_arm_re        => waiting_arm_re,  
    armed_re              => armed_re,
    bad_trig              => t1_bad_trig, -- trigger occured before last acq was complete
    trig_start            => trig_start                  
    );

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        irq <= p_csr_irq;
   end if;
end process;

-- Register inputs
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
     t1_s_axis_pctl_tdata  <= s_axis_pctl_tdata;
     t2_s_axis_pctl_tdata  <= t1_s_axis_pctl_tdata;
     t3_s_axis_pctl_tdata  <= t2_s_axis_pctl_tdata;
     t4_s_axis_pctl_tdata  <= t3_s_axis_pctl_tdata;
     t1_s_axis_pctl_tvalid <= s_axis_pctl_tvalid;
     t2_s_axis_pctl_tvalid <= t1_s_axis_pctl_tvalid;
     if (local_gate_mode = '0') then
         t2_gatetrig <= t1_s_axis_pctl_tdata(0);
         t2_gate     <= t1_s_axis_pctl_tdata(0);
     else
         t2_gatetrig <= local_gate;
         t2_gate     <= local_gate;
      end if;      
      t3_gatetrig  <= t2_gatetrig;
      t4_gatetrig  <= t3_gatetrig;
      t3_gate      <= t2_gate; 
      trig_start   <= t2_trig_re;
   end if;
end process;

t2_trig_re <= (t2_gatetrig and not t3_gatetrig);

--------------------------------------------------------------------------------
-- Trigger Controls
--------------------------------------------------------------------------------

-- trigger load
t2_trig_cntr_ld     <= '1' when ((mode = TRIG_MODE) and (t2_trig_re = '1') and (armed = '1')) else '0';   
t2_trig_dly_cntr_ce <= '1' when ((mode = TRIG_MODE) and (armed = '1')) else '0'; 
t2_trig_cntr_ce     <= '1' when ((mode = TRIG_MODE) and (t2_s_axis_pctl_tvalid = '1') and (t3_trig_dly_cntr_tc = '1') and (armed = '1')) else '0';

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then   
      t4_trig_dly_cntr_tc  <= t3_trig_dly_cntr_tc;
      
      if(data_mode = TIME_PACKED_MODE) then
          trig_cntr_ld_val     <= "0000" & trig_len(31 downto 4);
      else
          trig_cntr_ld_val     <= "000"  & trig_len(31 downto 3);
      end if;   
      if (t2_s_axis_pctl_tvalid = '1') then
        t3_trig_cntr_ld <= t2_trig_cntr_ld;
      end if;
      t4_trig_cntr_ld <= t3_trig_cntr_ld;
   end if;  
end process;

trig_dly_cntr_ld_val <= trig_dly;

-- Multiplexer for trigger sources
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
     if armed = '1' then
         case mode is
            when TRIG_MODE =>
               t4_mux_gate <= (not t3_trig_cntr_tc) and t3_trig_dly_cntr_tc;
            when TRIG_HOLD_MODE =>
               t4_mux_gate <= t3_trig_hold;
            when GATE_MODE =>
               t4_mux_gate <= t3_gate;
            when others =>
               t4_mux_gate <= '0';
         end case; 
      else
        t4_mux_gate <= '0';   
      end if;
   end if;
end process;   

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
        qual_gate    <= t4_mux_gate and active;
        t1_qual_gate <= qual_gate;
        acq_start    <= qual_gate and not t1_qual_gate;
        acq_end      <= (not qual_gate) and t1_qual_gate;
   end if;
end process;  

--------------------------------------------------------------------------------
-- Trigger Hold
--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
     if trig_cntr_sclr = '1' or (mode /= TRIG_HOLD_MODE )then
        t3_trig_hold <= '0'; 
     elsif ((mode = TRIG_HOLD_MODE) and (t2_trig_re = '1') and (armed = '1')) then
        t3_trig_hold <= '1';  
     end if;
   end if;
end process;

--------------------------------------------------------------------------------
-- Trigger Counter
--------------------------------------------------------------------------------

dwncntr_dly_inst: px_axis_bram2wave_256_dwncntr 
port map ( 
    clk     => s_axis_aclk,
    sclr    => trig_cntr_sclr,
    ce      => t2_trig_dly_cntr_ce,
    ld      => t2_trig_cntr_ld,
    ld_val  => trig_dly_cntr_ld_val,
    tc      => t3_trig_dly_cntr_tc,
    count   => dly_count 
);

dwncntr_inst: px_axis_bram2wave_256_dwncntr 
port map ( 
    clk     => s_axis_aclk,
    sclr    => trig_cntr_sclr,
    ce      => t2_trig_cntr_ce,
    ld      => t2_trig_cntr_ld,
    ld_val  => trig_cntr_ld_val,
    tc      => t3_trig_cntr_tc,
    count   => trig_count 
);

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
      if (trig_count(31 downto 1) /= "0000000000000000000000000000000") then
         bad_trig <= t2_trig_cntr_ld;
      else
         bad_trig <= '0';  
      end if;  
      t1_bad_trig <= bad_trig; 
    end if;
end process; 

--------------------------------------------------------------------------------
-- Trigger Control State Machine
--------------------------------------------------------------------------------

retrig  <= t4_trig_cntr_ld and active;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        waiting_arm_re <= waiting_arm and not t1_waiting_arm;
        t1_waiting_arm <= waiting_arm;
        t1_armed       <= armed;
        armed_re       <= armed and not t1_armed;
        if (s_axis_aresetn = '0') then
           trig_cntr_sclr <= '1';
           armed          <= '0'; 
           mode           <= "00"; 
           data_mode      <= "00"; 
           active         <= '0';
           state <= RESET_STATE;
        else
            case state is
                when RESET_STATE =>
                    trig_cntr_sclr <= '1';
                    armed          <= '0';
                    mode           <= "00"; 
                    data_mode      <= "00";
                    active         <= '0';
                    waiting_arm    <= '0';
                    if (s_axis_aresetn = '0') then
                       state <= RESET_STATE;
                    elsif (trig_clear = '0') then 
                       state <= WAIT_TRIG_ARMED; 
                    end if;
                when WAIT_TRIG_ARMED =>
                    trig_cntr_sclr <= '0';
                    waiting_arm    <= '1';
                    if (trig_clear = '1') then
                       state <= RESET_STATE;
                    elsif (trig_arm = '1') and (disarm = '0') then
                       state <= TRIG_ARMED_STATE;
                    else
                       state <= WAIT_TRIG_ARMED; 
                    end if;
                    mode      <= mode_sel;
                    data_mode <= data_mode_sel;
                when TRIG_ARMED_STATE =>   
                    armed          <= '1';
                    waiting_arm    <= '0';
                    if  (((t4_mux_gate = '0') and ((t4_trig_dly_cntr_tc = '1') or (retrig= '1'))) or (trig_clear = '1')) and ((active = '1') or (t4_trig_cntr_ld = '1')) then
                        active <= '0'; 
                        trig_cntr_sclr <= trig_clear;       
                        if (stay_armed = '0') or (trig_clear = '1') or (disarm = '1') or (disarm_at_end = '1') then
                            state <= RESET_STATE;
                        else    
                            state <= TRIG_ARMED_STATE;
                        end if;             
                    elsif (t4_mux_gate = '1') then        
                        active    <= '1';  
                    else    
                        if (trig_clear = '1') or (disarm = '1') then
                            state <= RESET_STATE;
                        else 
                            state <= TRIG_ARMED_STATE;
                        end if;    
                    end if;     
                when others =>
                   state <= RESET_STATE;
            end case;    
        end if;
     end if;
end process;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       t1_retrig    <= retrig;
       t2_retrig    <= t1_retrig;
       t1_active    <= active;
       t2_active    <= t1_active;
       t3_active    <= t2_active;
       if (s_axis_aresetn = '0') or (active = '0') or (t1_retrig = '1') or (bram_addr = ltch_bram_end_addr) then
         ltch_bram_end_addr <= bram_end_address(addr_width-1 downto 0);
         bram_addr          <= bram_strt_address(addr_width-1 downto 0);
       else
          if (t2_retrig = '0') then
            bram_addr <= bram_addr + 1;
          end if;
       end if;
    end if;
end process;

bram_rdport_addr   <= bram_addr(addr_width-1 downto 0);
bram_rdport_clk    <= s_axis_aclk;
bram_rdport_en     <= '1';  


--------------------------------------------------------------------------------
-- Output
--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      if t2_active = '0' then
         m_axis_pd_tdata <= (others => '0');
      else
         m_axis_pd_tdata <= bram_rdport_rddata;
      end if;
   end if;
end process;   
     
 m_axis_pd_tvalid <= '1';    

end Behavioral;
