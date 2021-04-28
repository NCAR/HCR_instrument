----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2015 10:43:52 AM
-- Design Name: 
-- Module Name: px_axis_pwr_meter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_pwr_meter is
generic (
    calc_magnitude   : boolean := true; 
    has_axis_pwr_out : boolean := true;
    has_axis_mag_out : boolean := true  
);
port ( 
    ----------------------------------------------------------------------------
    -- AXI4-Lite Control/Status Interface
    ----------------------------------------------------------------------------
    s_axi_csr_aclk      : in  std_logic;
    s_axi_csr_aresetn   : in  std_logic;
    s_axi_csr_awaddr    : in  std_logic_vector(6 downto 0);
    s_axi_csr_awprot    : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid   : in  std_logic;
    s_axi_csr_awready   : out std_logic;
    s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid    : in  std_logic;
    s_axi_csr_wready    : out std_logic;
    s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid    : out std_logic;
    s_axi_csr_bready    : in  std_logic;
    s_axi_csr_araddr    : in  std_logic_vector(6 downto 0);
    s_axi_csr_arprot    : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid   : in  std_logic;
    s_axi_csr_arready   : out std_logic;
    s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid    : out std_logic;
    s_axi_csr_rready    : in  std_logic;
    
    irq                 : out std_logic;
    ----------------------------------------------------------------------------
    -- AXI-S Slave Input (Pentek PDTI Type)
    ----------------------------------------------------------------------------

    axis_aclk          : in  std_logic;
    axis_aresetn       : in  std_logic;
    
    -- Only compatible with PDTI format when data is complex and one sample per
    -- clock cycle.
    -- Tiomestamp information is not used by this core
    -- tdata[15:0]  = I[15:0]
    -- tdata[31:16] = Q[15:0]
    -- tuser[64]    = Gate  
    -- tuser[72]    = Sync      
    -- tuser[80]    = PPS 
    s_axis_pdti_tdata  : in  std_logic_vector(31 downto 0);
    s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_pdti_tvalid : in  std_logic;
    ----------------------------------------------------------------------------
    -- AXI-S Master Power Output
    ----------------------------------------------------------------------------
    -- Power[31:0] = Unsigned number 
    m_axis_pwr_tdata   : out std_logic_vector(31 downto 0);
    m_axis_pwr_tvalid  : out std_logic;
    ----------------------------------------------------------------------------
    -- AXI-S Master Magnitude Output
    ----------------------------------------------------------------------------
    -- Magnitude[15:0] = Unsigned number 
    m_axis_mag_tdata   : out std_logic_vector(15 downto 0);
    m_axis_mag_tvalid  : out std_logic;
    
    rdy_out            : out std_logic 
    
);
end px_axis_pwr_meter;

architecture Behavioral of px_axis_pwr_meter is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti:m_axis_pwr:m_axis_mag, ASSOCIATED_RESET axis_aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- Control/Status Registers
COMPONENT px_axis_pwr_meter_csr
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

-- A*B
-- Latency = 4
-- P Carryout
COMPONENT px_pwr_meter_dsp48_isqr
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

-- A*B + PCIN
-- Latency = 5
COMPONENT px_pwr_meter_dsp48_qsqr
  PORT (
    CLK : IN STD_LOGIC;
    PCIN : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END COMPONENT;

-- Accumulator
-- latency = 2
COMPONENT px_pwr_meter_accum
  PORT (
    B : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    BYPASS : IN STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
  );
END COMPONENT;

-- Multiplier
-- 47x17 unsigned
-- 48 bit output
-- Latency = 5
COMPONENT px_pwr_meter_mult_1mk
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(46 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(46 DOWNTO 0)
  );
END COMPONENT;

-- Multiplier
-- 32x17 unsigned
-- 48 bit output
-- Latency = 4
COMPONENT px_pwr_meter_mult_k
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(46 DOWNTO 0)
  );
END COMPONENT;

-- Unsigned Adder
-- Latency = 2
COMPONENT px_pwr_meter_add48
  PORT (
    A : IN STD_LOGIC_VECTOR(46 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(46 DOWNTO 0);
    CLK : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    S : OUT STD_LOGIC_VECTOR(46 DOWNTO 0)
  );
END COMPONENT;

-- Unsigned Subtract
-- Latency = 2
COMPONENT px_pwr_meter_1mk_sub
  PORT (
    A : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    CLK : IN STD_LOGIC;
    S : OUT STD_LOGIC_VECTOR(16 DOWNTO 0)
  );
END COMPONENT;

--Cordic implementation of Square Root
COMPONENT px_pwr_meter_mag_cordic
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_cartesian_tvalid : IN STD_LOGIC;
    s_axis_cartesian_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END COMPONENT;

-- Vector Delay of 18
COMPONENT px_pwr_meter_pwr_dly
  PORT (
    clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal t5_pwr           : std_logic_vector(47 downto 0);
signal i_pcout          : std_logic_vector(47 downto 0);
signal tvalid_dly       : std_logic_vector(4 downto 0);
signal tvalid_cntr      : std_logic_vector(2 downto 0);
signal bypass           : std_logic := '0';
signal pwr_accum        : std_logic_vector(35 downto 0);
signal t1_pwr_accum     : std_logic_vector(35 downto 0);
signal t5_tvalid        : std_logic := '0';
signal t1_acc_tvalid    : std_logic := '0';
signal t2_acc_tvalid    : std_logic := '0';
signal t3_acc_tvalid    : std_logic := '0';
signal t4_acc_tvalid    : std_logic := '0';
signal t5_acc_tvalid    : std_logic := '0';
signal t6_acc_tvalid    : std_logic := '0';
signal t7_acc_tvalid    : std_logic := '0';
signal t8_acc_tvalid    : std_logic := '0';
signal t9_acc_tvalid    : std_logic := '0';
signal t10_acc_tvalid   : std_logic := '0';
signal out_vld_dly      : std_logic_vector(17 downto 0) := (others => '0');
signal coef_1mk         : std_logic_vector(16 downto 0) := (others => '0');
signal coef_k           : std_logic_vector(16 downto 0) := (others => '0');
signal t1_k             : std_logic_vector(16 downto 0) := (others => '0');
signal iir_pwr          : std_logic_vector(46 downto 0) := (others => '0');
signal x1mk             : std_logic_vector(46 downto 0) := (others => '0');
signal t1_x1mk          : std_logic_vector(46 downto 0) := (others => '0');
signal ak               : std_logic_vector(46 downto 0) := (others => '0');
signal t1_ak            : std_logic_vector(46 downto 0) := (others => '0');
signal t1_bypass        : std_logic := '0';
signal s_axis_areset    : std_logic;
signal acc_good         : std_logic := '0';
signal k                : std_logic_vector(16 downto 0) := (others => '0');
signal reg0_init_val    : std_logic_vector(31 downto 0) := (others => '0');
signal reg1_init_val    : std_logic_vector(31 downto 0) := (others => '0');
signal ctl0_out         : std_logic_vector(31 downto 0) := (others => '0');
signal ctl1_out         : std_logic_vector(31 downto 0) := (others => '0');
signal ctl0_outx        : std_logic_vector(31 downto 0) := (others => '0');
signal ctl1_outx        : std_logic_vector(31 downto 0) := (others => '0');
signal stat0_in         : std_logic_vector(31 downto 0) := (others => '0');
signal stat1_in         : std_logic_vector(31 downto 0) := (others => '0');
signal stat0_inx        : std_logic_vector(31 downto 0) := (others => '0');
signal stat1_inx        : std_logic_vector(31 downto 0) := (others => '0');
signal intrpt_src_in    : std_logic_vector(0 downto 0) := (others => '0');
signal irqx             : std_logic := '0';            
signal calc_rst_n       : std_logic := '0';
signal t1_gate          : std_logic := '0';
signal t2_gate          : std_logic := '0';
signal t3_gate          : std_logic := '0';
signal t4_gate          : std_logic := '0';
signal t5_gate          : std_logic := '0';
signal t3_gate_re       : std_logic := '0';
signal t1_sync          : std_logic := '0';
signal t2_sync          : std_logic := '0';
signal t3_sync          : std_logic := '0';
signal t3_sync_re       : std_logic := '0';
signal t1_pps           : std_logic := '0';
signal t2_pps           : std_logic := '0';
signal t3_pps           : std_logic := '0';
signal t3_pps_re        : std_logic := '0';
signal t27_mag          : std_logic_vector(23 downto 0) := (others => '0');
signal t9_pwr           : std_logic_vector(31 downto 0) := (others => '0');
signal t27_pwr          : std_logic_vector(31 downto 0) := (others => '0');
signal rdy_cntr         : std_logic_vector(19 downto 0) := (others => '0');
signal rdy_cntr_ld_val  : std_logic_vector(19 downto 0) := (others => '0');
signal rdy              : std_logic := '0';      
signal src_send01       : std_logic:= '0';
signal src_rcv01        : std_logic:= '0';
signal dest_req01       : std_logic:= '0';
signal cntrl01_vctr     : std_logic_vector(63 downto 0)  := (others => '0');
signal cntrlx01_vctr    : std_logic_vector(63 downto 0)  := (others => '0');
signal src_senda        : std_logic:= '0';
signal src_rcva         : std_logic:= '0';
signal dest_reqa        : std_logic:= '0';
signal stat01           : std_logic_vector(63 downto 0)  := (others => '0');
signal stat01x          : std_logic_vector(63 downto 0)  := (others => '0');
signal src_sends        : std_logic:= '0';
signal src_rcvs         : std_logic:= '0';
signal dest_reqs        : std_logic:= '0';
signal t1_s_axi_csr_aresetn: std_logic:= '0';
--------------------------------------------------------------------------------
 
begin

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        t1_gate <= s_axis_pdti_tuser(64);
        if tvalid_dly(0) = '1' then
            t2_gate <= t1_gate;
            t3_gate <= t2_gate;
        end if;    
        t3_gate_re <= t2_gate and not t3_gate;
        t4_gate    <= t3_gate;
        t5_gate    <= t4_gate;
        t1_sync <= s_axis_pdti_tuser(72);
        if tvalid_dly(0) = '1' then
            t2_sync <= t1_sync;
            t3_sync <= t2_sync;
        end if;    
        t3_sync_re <= t2_sync and not t3_sync;
        
        t1_pps <= s_axis_pdti_tuser(80);
        if tvalid_dly(0) = '1' then
            t2_pps <= t1_pps;
            t3_pps <= t2_pps;
        end if;    
        t3_pps_re <= t2_pps and not t3_pps;
    end if; 
end process; 
 
--------------------------------------------------------------------------------
-- (I^2) + (Q^2)
--------------------------------------------------------------------------------

-- A*B
-- Latency = 4
-- P Carryout
isqr_inst : px_pwr_meter_dsp48_isqr
port map (
    clk   => axis_aclk,
    a     => s_axis_pdti_tdata(15 downto 0), -- I
    b     => s_axis_pdti_tdata(15 downto 0),
    pcout => i_pcout,
    p     => open
);

-- A*B + PCIN
-- Latency = 5
qsqr_inst : px_pwr_meter_dsp48_qsqr
port map (
    clk   => axis_aclk,
    a     => s_axis_pdti_tdata(31 downto 16), -- Q
    b     => s_axis_pdti_tdata(31 downto 16),
    pcin  => i_pcout,
    p     => t5_pwr
);

-- Delay tvalids to align with pwr output of DSP48s.
process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if (axis_aresetn = '0') then
           tvalid_dly(4 downto 0) <= "00000";  
        else
           tvalid_dly(4 downto 0) <= tvalid_dly(3 downto 0) & s_axis_pdti_tvalid; 
        end if;
    end if; 
end process; 

t5_tvalid <= tvalid_dly(4) and (t5_gate or not ctl0_out(1));  

--------------------------------------------------------------------------------
-- Accumulate to average 8 power samples
--------------------------------------------------------------------------------
-- The simple IIR used for the main averager requires an 8 cycle delay
-- between input samples due to latency in the DSP48 block.
-- We will average eight incoming samples ahead of it to reduce the input
-- rate.

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if ( calc_rst_n = '0') then
            tvalid_cntr <= "000";
        elsif (t5_tvalid = '1') then
            tvalid_cntr <= tvalid_cntr + 1;
        end if; 
    end if;
end process;

bypass <= '1' when ((t5_tvalid = '1') and (tvalid_cntr = "000")) else '0'; 

accum_inst : px_pwr_meter_accum
port map (
   b      => t5_pwr(32 downto 0),
   clk    => axis_aclk,
   ce     => t5_tvalid,
   bypass => bypass,
   q      => pwr_accum
);

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if ( calc_rst_n = '0') then
            t1_pwr_accum <= (others => '0');
        elsif (t1_bypass = '1') then
            t1_pwr_accum <= pwr_accum;
        end if; 
    end if;
end process;

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if ( calc_rst_n = '0') then
            t1_bypass <= '0';
            t1_acc_tvalid <= '0';
            t2_acc_tvalid <= '0';
            t3_acc_tvalid <= '0';
            t4_acc_tvalid <= '0';
            t5_acc_tvalid <= '0';
            t6_acc_tvalid <= '0';
            t7_acc_tvalid <= '0';
            t8_acc_tvalid <= '0';
            t9_acc_tvalid <= '0';
            t10_acc_tvalid<= '0';
        else
            t1_bypass     <= bypass and acc_good;
            t1_acc_tvalid <= t1_bypass;
            t2_acc_tvalid <= t1_acc_tvalid;
            t3_acc_tvalid <= t2_acc_tvalid;
            t4_acc_tvalid <= t3_acc_tvalid;
            t5_acc_tvalid <= t4_acc_tvalid;
            t6_acc_tvalid <= t5_acc_tvalid;
            t7_acc_tvalid <= t6_acc_tvalid;
            t8_acc_tvalid <= t7_acc_tvalid;
            t9_acc_tvalid <= t8_acc_tvalid;
            t10_acc_tvalid<= t9_acc_tvalid;
        end if; 
    end if;
end process;

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if ( calc_rst_n = '0') then
            acc_good <= '0';
        elsif (tvalid_cntr = "111") then
            acc_good <= '1';
        end if;
    end if;
end process;        

--------------------------------------------------------------------------------
-- IIR Averager
--------------------------------------------------------------------------------
-- x(t) = (a(t)*k) + (x(t-1)*(1-k)) 


-- 1 - k
sub_1mk_inst : px_pwr_meter_1mk_sub
port map (
   a   => "10000000000000000",
   b   => k,
   clk => axis_aclk,
   s   => coef_1mk
);

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
       t1_k   <= k;
       coef_k <= t1_k;
    end if;
end process;

-- Multiplication unsigned 47x17
-- (x(t-1)*(1-k)) 
-- Latency = 5
mult_1mk_inst : px_pwr_meter_mult_1mk
port map (
   clk => axis_aclk,
   a   => coef_1mk,
   b   => iir_pwr(46 downto 0),
   p   => x1mk
);

-- Multiplication 32x16
--(a(t)*k)
-- Latency = 4
mult_k_inst : px_pwr_meter_mult_k
port map (
   clk => axis_aclk,
   a   => t1_pwr_accum(35 downto 4),
   b   => coef_k,
   p   => ak
);

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if ( calc_rst_n = '0') then
            t1_x1mk <= (others => '0');
            t1_ak   <= (others => '0'); 
        elsif (t5_acc_tvalid = '1') then
            t1_x1mk <= x1mk;
            t1_ak   <= ak;
        end if; 
    end if;
end process;
  
-- Unsigned Adder  
-- Latency = 2  
iir_add_inst : px_pwr_meter_add48
port map (
   a    => t1_ak,
   b    => t1_x1mk,
   clk  => axis_aclk,
   sclr => s_axis_areset,
   s    => iir_pwr
);

s_axis_areset <= not calc_rst_n;

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if ( calc_rst_n = '0') then
            t9_pwr  <= (others => '0');
        elsif (t8_acc_tvalid = '1') then
            t9_pwr  <= iir_pwr(44 downto 13);      
        end if; 
    end if;
end process;

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------

-- 0x00 - Control Register
-- 0x04 - Average control (k coefficient)
-- 0x08 - Power Reading
-- 0x0C - Magnitude Reading
-- 0x10 - Interrupt Enables
-- 0x14 - Interrupt Status
-- 0x18 - Interrupt Flags

-- Control Register 0 Bit Definitions
-- bit [0]   - Power Measurement Reset
-- bit [1]   - Measure only while Gate is active
-- bit [3:2] - Reset Mode
--      "00" = Manual Reset Only
--      "01" = Reset on Sync 
--      "10" = Reset on Rising Edge of Gate
--      "11" = Reset on Rising Edge of PPS

-- k Coefficient = control Reg 1[17:0] 
-- time constant = 1/k, where:
-- 1/k = 1    is "10000000000000000"
-- 1/k = 1/2  is "01000000000000000"
-- 1/k = 1/4  is "00100000000000000"


reg0_init_val <= x"00000000";
reg1_init_val <= x"00000000";

-- So that status, control and interrupt signals are synchronous with the data
-- stream clock, the entire control register block runs on the data stream clock.
csr : px_axis_pwr_meter_csr
  PORT MAP (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr    => s_axi_csr_awaddr,
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
    s_axi_csr_araddr    => s_axi_csr_araddr,
    s_axi_csr_arprot    => s_axi_csr_arprot,
    s_axi_csr_arvalid   => s_axi_csr_arvalid,
    s_axi_csr_arready   => s_axi_csr_arready,
    s_axi_csr_rdata     => s_axi_csr_rdata,
    s_axi_csr_rresp     => s_axi_csr_rresp,
    s_axi_csr_rvalid    => s_axi_csr_rvalid,
    s_axi_csr_rready    => s_axi_csr_rready,
    reg0_init_val       => reg0_init_val,
    reg1_init_val       => reg1_init_val,
    ctl0_out            => ctl0_outx,
    ctl1_out            => ctl1_outx,
    stat0_in            => stat0_inx,
    stat1_in            => stat1_inx,
    intrpt_src_in       => intrpt_src_in,
    irq                 => irqx
  );


process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
       irq <= irqx;
    end if;
end process;

--------------------------------------------------------------------------------
-- Clock Boundary Crossing
--------------------------------------------------------------------------------

cntrl01_vctr <= ctl1_outx & ctl0_outx;

cntl01_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 64  -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => cntrl01_vctr ,
  src_send => src_send01,
  src_rcv  => src_rcv01,
  dest_clk => axis_aclk,
  dest_req => dest_req01,
  dest_ack => dest_req01, 
  dest_out => cntrlx01_vctr
);

ctl0_out <= cntrlx01_vctr(31 downto 0);
ctl1_out <= cntrlx01_vctr(63 downto 32);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcv01 = '1') then
       src_send01 <= '0';
     elsif (src_rcv01 = '0') and (src_send01 = '0') then
       src_send01 <= '1';
     end if;  
   end if;
end process;   

stat01 <= stat1_in & stat0_in;

stat_xclk:  xpm_cdc_handshake
generic map (
  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 64  -- integer; range: 1-1024
)
port map (
  src_clk    => axis_aclk,
  src_in     => stat01,
  src_send   => src_senda,
  src_rcv    => src_rcva,
  dest_clk   => s_axi_csr_aclk,
  dest_req   => dest_reqa,
  dest_ack   => dest_reqa, 
  dest_out   => stat01x
);

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
     if (src_rcva = '1') then
       src_senda <= '0';
     elsif (src_rcva = '0') and (src_senda = '0') then
       src_senda <= '1';
     end if;  
   end if;
end process;   

stat0_inx <= stat01x(31 downto 0);
stat1_inx <= stat01x(63 downto 32);

--------------------------------------------------------------------------------
-- Averager filter time constant (k)
k <= ctl1_out(16 downto 0);

-- Control Register 0 Bit Definitions
-- bit [0]   - Power Measurement Reset
-- bit [1]   - Measure only while Gate is active
-- bit [3:2] - Reset Mode
--      "00" = Manual Reset Only
--      "01" = Reset on Rising Edge of Gate
--      "10" = Reset on Sync 
--      "11" = Reset on Rising Edge of PPS

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if (axis_aresetn = '0') then
           calc_rst_n <= '0';
        else
            case ctl0_out(3 downto 2) is
                when "00" =>  
                    calc_rst_n <= not ctl0_out(0);
                when "01" => 
                    calc_rst_n <= not (ctl0_out(0) or t3_gate_re);
                when "10" => 
                    calc_rst_n <= not (ctl0_out(0) or t3_sync_re);
                when "11" =>
                    calc_rst_n <= not (ctl0_out(0) or t3_pps_re);
                when others =>
                    calc_rst_n <= not (ctl0_out(0) or t3_pps_re);
            end case;
        end if;    
    end if;
end process;

--------------------------------------------------------------------------------
-- Compute the Square-Root to get Magnitude
--------------------------------------------------------------------------------

gen_cordic: if (calc_magnitude = true) generate

-- CORDIC Square Root
-- Latency = 18
cordic_inst : px_pwr_meter_mag_cordic
  port map (
    aclk                    => axis_aclk,
    s_axis_cartesian_tvalid => t9_acc_tvalid,
    s_axis_cartesian_tdata  => t9_pwr,
    m_axis_dout_tvalid      => open,
    m_axis_dout_tdata       => t27_mag
  );
  
end generate;  

gen_nocordic: if (calc_magnitude = false) generate

t27_mag           <= (others => '0');

end generate;

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if ( calc_rst_n = '0') then
            out_vld_dly(17 downto 0)   <= (others => '0');
        else
            out_vld_dly(17 downto 0) <= out_vld_dly(16 downto 0) & t10_acc_tvalid;
        end if; 
    end if;
end process;

-- Delay Power value to come out at the same time as the Magnitude  
-- Delay = 18 
pwr_dly_inst: px_pwr_meter_pwr_dly
port map (
    clk  => axis_aclk,
    din  => t9_pwr,
    dout => t27_pwr
  );
  
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      if ( calc_rst_n = '0') then
        stat0_in              <= x"00000000";
        stat1_in(15 downto 0) <= x"0000";
        m_axis_pwr_tdata      <= x"00000000";
        m_axis_mag_tdata      <= x"0000";
      elsif out_vld_dly(16) = '1' then
        stat0_in              <= t27_pwr;
        stat1_in(15 downto 0) <= t27_mag(15 downto 0);
        m_axis_pwr_tdata      <= t27_pwr;
        m_axis_mag_tdata      <= t27_mag(15 downto 0);
      end if;
   end if;
end process;

stat1_in(31 downto 16) <= x"0000";

m_axis_pwr_tvalid <= out_vld_dly(17);
m_axis_mag_tvalid <= out_vld_dly(17);

--------------------------------------------------------------------------------
-- Averager Ready Indicator
--------------------------------------------------------------------------------

rdy_cntr_ld_val <= "00000000000000001000" when (k(16) = '1') else
                   "00000000000000010000" when (k(15) = '1') else
                   "00000000000000100000" when (k(14) = '1') else 
                   "00000000000001000000" when (k(13) = '1') else 
                   "00000000000010000000" when (k(12) = '1') else 
                   "00000000000100000000" when (k(11) = '1') else 
                   "00000000001000000000" when (k(10) = '1') else 
                   "00000000010000000000" when (k(9) = '1') else 
                   "00000000100000000000" when (k(8) = '1') else 
                   "00000001000000000000" when (k(7) = '1') else 
                   "00000010000000000000" when (k(6) = '1') else 
                   "00000100000000000000" when (k(5) = '1') else 
                   "00001000000000000000" when (k(4) = '1') else 
                   "00010000000000000000" when (k(3) = '1') else 
                   "00100000000000000000" when (k(2) = '1') else 
                   "01000000000000000000" when (k(1) = '1') else 
                   "10000000000000000000"; 

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      if ( calc_rst_n = '0') then
        rdy_cntr <= rdy_cntr_ld_val;
      elsif (out_vld_dly(16) = '1') and (rdy_cntr /= "00000000000000000000") then
        rdy_cntr <= rdy_cntr - 1;
      end if; 
      if ( calc_rst_n = '0') then
        rdy <= '0';
      elsif (rdy_cntr = "00000000000000000000") then
        rdy <= '1';
      end if; 
      rdy_out <= rdy;
   end if;
end process;

rdy_xclk:  xpm_cdc_handshake
generic map (
  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 1  -- integer; range: 1-1024
)
port map (
  src_clk    => axis_aclk,
  src_in(0)  => rdy,
  src_send   => src_sends,
  src_rcv    => src_rcvs,
  dest_clk   => s_axi_csr_aclk,
  dest_req   => dest_reqs,
  dest_ack   => dest_reqs, 
  dest_out(0)=> intrpt_src_in(0)
);

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
     if (src_rcvs = '1') then
       src_sends <= '0';
     elsif (src_rcvs = '0') and (src_sends = '0') then
       src_sends <= '1';
     end if;  
   end if;
end process;   


end Behavioral;
