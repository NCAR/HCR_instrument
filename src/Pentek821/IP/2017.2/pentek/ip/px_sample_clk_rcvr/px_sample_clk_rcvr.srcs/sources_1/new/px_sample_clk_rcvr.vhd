----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 10/22/2016 09:17:54 AM
-- Design Name: 
-- Module Name: px_sample_clk_rcvr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Sample Clock Receiver, Including BUFG and Frequency Counter
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.10 - 7/25/17 Made Good Clock Count longer.
-- Revision 1.00 - First Release
-- Revision 0.01 - File Created
-- Additional Comments:
-- 

-- Register Map
-- 0x00 Control
-- 0x04 Clock Status    
-- 0x08 Frequecy Counter
-- 0x0C Interrupt Enable Register
-- 0x10 Interrupt Status Register
-- 0x14 Interrupt Flag Register


-- Gate Receive Buffer Control
-- [0]     Clock Disable

----------------------------------------------------------------------------------

-- (c) Copyright 2016 Pentek, Inc. All rights reserved.
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
Library UNISIM;
use UNISIM.vcomponents.all;

entity px_sample_clk_rcvr is
generic(
   min_freq_div             : integer := 32; -- Minimumum Frequency = CSR_ACLK/min_freq_div (valid range 2,4,8,16,32)
   differential_term        : string := "TERM_100"; -- "TERM_100" or "TERM_NONE"
   ibuf_low_pwr             : boolean := false
);
port (
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(4 downto 0);
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
   s_axi_csr_araddr         : in  std_logic_vector(4 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
    
   irq                      : out std_logic; -- Interrupt out (overload)
----------------------------------------------------------------------------
-- Clock Input from CDCM7005
----------------------------------------------------------------------------
   clk_in_p                 : in std_logic;
   clk_in_n                 : in std_logic;   
----------------------------------------------------------------------------
-- Frequency Counter Ref Clock
----------------------------------------------------------------------------
   refclk                   : in std_logic;   -- 200MHz Reference Clock
----------------------------------------------------------------------------
-- Clock Output
----------------------------------------------------------------------------
   sample_clk               : out std_logic;
-----------------------------------------------------------------------------
-- LED Drive
-----------------------------------------------------------------------------
   led_n                    : out std_logic;
   clk_good                 : out std_logic
 );
end px_sample_clk_rcvr;

architecture Behavioral of px_sample_clk_rcvr is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------
component px_sample_clk_rcvr_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk        : in  std_logic;
    s_axi_csr_aresetn     : in  std_logic;
    s_axi_csr_awaddr      : in  std_logic_vector(4 downto 0); -- only [5:0] used
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
    s_axi_csr_araddr      : in  std_logic_vector(4 downto 0);  -- only [5:0] used
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
    clock_disable         : out std_logic;
    --------------------------------------------------------------------------------
    -- Status Inputs
    --------------------------------------------------------------------------------                      
    clk_ok                : in  std_logic; 
    freq_cnt              : in  std_logic_vector(31 downto 0);
    s0                    : in  std_logic;
    s1                    : in  std_logic;
    sm_state              : in  std_logic_vector(2 downto 0)
);
end component;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant RESET_STATE         : std_logic_vector(2 downto 0) := "000";
constant START_TIMEOUT_CNTR_STATE : std_logic_vector(2 downto 0) := "001";
constant KEEP_ALIVE_STATE    : std_logic_vector(2 downto 0) := "010";
constant TIMEOUT_STATE       : std_logic_vector(2 downto 0) := "011";
constant TIMEOUT_STATE_WAIT1 : std_logic_vector(2 downto 0) := "100";
constant TIMEOUT_STATE_WAIT2 : std_logic_vector(2 downto 0) := "101";
constant TIMEOUT_STATE_WAIT3 : std_logic_vector(2 downto 0) := "110";
constant GOOD_CLOCK_STATE    : std_logic_vector(2 downto 0) := "111";

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal clkin              : std_logic := '0';
signal clk_bufg           : std_logic := '0';
signal keep_alive_clock   : std_logic := '0';
signal timeout_clr_n      : std_logic := '0';
signal ignore1            : std_logic := '0';
signal s0                 : std_logic := '0';
signal s1                 : std_logic := '0';
signal clk_ok             : std_logic := '0';
--signal state              : state_type := RESET_STATE;
signal state              : std_logic_vector(2 downto 0) := "000";
signal timeout_cntr       : std_logic_vector(4 downto 0) := "00000";
signal reset_cnt          : std_logic := '0';
signal cy_count_clk_in_rr : std_logic := '0';
signal cy_count_clk_in_r  : std_logic := '0';
signal count_clk_in       : std_logic := '0';
signal count_sys_clk      : std_logic_vector(5 downto 0) := "000000";
signal counter_tc_ff      : std_logic := '0';
signal count_good_clk_in  : std_logic_vector(29 downto 0) := (others => '0');
signal fifo_wr            : std_logic := '0';
signal freq_cntr_rst_rr   : std_logic := '0';
signal freq_cntr_rst_rrr  : std_logic := '0';
signal freq_cntr_rst_r    : std_logic := '0';
signal freq_cntr          : std_logic_vector(31 downto 0) := x"00000000";
signal freq_cntr_rst      : std_logic := '0';
signal led_mode           : std_logic_vector(1 downto 0) := "00";
signal led_lite           : std_logic := '0';
signal t1_cdc_stat_vcxo   : std_logic := '0';
signal t1_cdc_stat_ref    : std_logic := '0';
signal t1_cdc_stat_lock   : std_logic := '0';
signal clock_disable      : std_logic := '0';
signal freq_latch         : std_logic_vector(31 downto 0) := x"00000000";
signal frq_fifo_empty     : std_logic := '0';
signal freq_period_cntr   : std_logic_vector(29 downto 0) := (others => '0');
signal timeout            : std_logic := '0';
signal count_good_tc      : std_logic := '0';
signal t1_count_good_tc   : std_logic := '0';
signal t2_count_good_tc   : std_logic := '0';
signal t3_count_good_tc   : std_logic := '0';
signal det_clk            : std_logic := '0';
signal src_send           : std_logic := '0';
signal src_rcv            : std_logic := '0';
signal dest_req           : std_logic := '0';
signal freq_x             : std_logic_vector(31 downto 0) := x"00000000";
signal freq_cntr_l        : std_logic_vector(31 downto 0) := x"00000000";
signal t1_s_axi_csr_aresetn: std_logic := '0';

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

attribute DIFF_TERM_ADV: string; 
attribute DIFF_TERM_ADV of clk_in_p   : signal is differential_term;
attribute DIFF_TERM_ADV of clk_in_n   : signal is differential_term;

-------------------------------------------------------------------------------

begin

-------------------------------------------------------------------------------
-- CLOCK Input buffering
-------------------------------------------------------------------------------
clk_ibufgds_inst : IBUFGDS
generic map (
    --DIFF_TERM    => differential_term, -- Differential Termination 
    IBUF_LOW_PWR => ibuf_low_pwr, -- Low power (TRUE) vs. performance (FALSE)
    IOSTANDARD   => "LVDS"
)
port map (
    I  => clk_in_p,
    IB => clk_in_n,
    O  => clkin
);

clk_det_bufg: BUFG
port map (
    I  => clkin,
    O  => det_clk
);
  
BUFGCTRL_inst : BUFGCTRL
generic map (
   INIT_OUT => 0,              -- Initial value of BUFGCTRL output, 0-1
   PRESELECT_I0 => FALSE,      -- BUFGCTRL output uses I0 input, FALSE, TRUE
   PRESELECT_I1 => FALSE,      -- BUFGCTRL output uses I1 input, FALSE, TRUE
   -- Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
   IS_CE0_INVERTED => '0',     -- Optional inversion for CE0
   IS_CE1_INVERTED => '0',     -- Optional inversion for CE1
   IS_I0_INVERTED => '0',      -- Optional inversion for I0
   IS_I1_INVERTED => '0',      -- Optional inversion for I1
   IS_IGNORE0_INVERTED => '0', -- Optional inversion for IGNORE0
   IS_IGNORE1_INVERTED => '0', -- Optional inversion for IGNORE1
   IS_S0_INVERTED => '0',      -- Optional inversion for S0
   IS_S1_INVERTED => '0'       -- Optional inversion for S1
)
port map (
   O   => clk_bufg,          -- 1-bit output: Clock output
   CE0 => '1',               -- 1-bit input: Clock enable input for I0
   CE1 => '1',               -- 1-bit input: Clock enable input for I1
   I0  => keep_alive_clock,  -- 1-bit input: Primary clock
   I1  => clkin,             -- 1-bit input: Secondary clock
   IGNORE0 => '0',       -- 1-bit input: Clock ignore input for I0
   IGNORE1 => ignore1,       -- 1-bit input: Clock ignore input for I1
   S0  => s0,                -- 1-bit input: Clock select for I0
   S1  => s1                 -- 1-bit input: Clock select for I1
);

sample_clk <= clk_bufg;

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        keep_alive_clock <= not keep_alive_clock;
    end if;
end process;

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn; 
        if (t1_s_axi_csr_aresetn = '0') then
             timeout_clr_n <= '0';
             ignore1       <= '0';
             s0            <= '0';
             s1            <= '0';
             clk_ok        <= '0';
             state         <= RESET_STATE;
        else
            case state is
                when RESET_STATE =>
                    if (t1_s_axi_csr_aresetn = '0') then
                       timeout_clr_n <= '0';
                       ignore1 <= '0';
                       s0 <= '0';
                       s1 <= '0';
                       state <= RESET_STATE;
                    else
                       state <= START_TIMEOUT_CNTR_STATE;
                       timeout_clr_n <= '1';
                    end if;
                when START_TIMEOUT_CNTR_STATE =>
                    state <= KEEP_ALIVE_STATE;
                    clk_ok <= '0';
                when KEEP_ALIVE_STATE =>
                    s0 <= '1';
                    s1 <= '0';
                    clk_ok <= '0';
                    if (timeout = '1') then
                        state <= TIMEOUT_STATE;
                        timeout_clr_n <= '0';
                        ignore1  <= '1';
                    elsif (counter_tc_ff = '0') and (t3_count_good_tc = '1') and (clock_disable = '0') then -- 16 clock cycles detected and clock is good frequency
                        state <= GOOD_CLOCK_STATE;
                    else
                        state <= KEEP_ALIVE_STATE;
                    end if; 
                when TIMEOUT_STATE =>
                    state <= TIMEOUT_STATE_WAIT1;
                when TIMEOUT_STATE_WAIT1 =>
                    state <= TIMEOUT_STATE_WAIT2;
                when TIMEOUT_STATE_WAIT2 =>
                    state <= TIMEOUT_STATE_WAIT3;
                when TIMEOUT_STATE_WAIT3 => 
                    state <= START_TIMEOUT_CNTR_STATE;
                    timeout_clr_n <= '1';
                    ignore1  <= '0';
                when GOOD_CLOCK_STATE =>
                    clk_ok <= '1';
                    if (counter_tc_ff = '1') or (clock_disable = '1') then
                       state <= START_TIMEOUT_CNTR_STATE;
                       timeout_clr_n <= '1';
                       s0 <= '1';
                       s1 <= '0';
                    else
                       state  <= GOOD_CLOCK_STATE;
                       s0     <= '0';
                       s1     <= '1';
                    end if;
                 when others =>
                    state <= RESET_STATE;
             end case;        
        end if;
    end if;
end process;

-- Switchover timeout Counter
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        if (t1_s_axi_csr_aresetn = '0') or (timeout_clr_n = '0') then
            timeout_cntr <= "00000";
        elsif  timeout_cntr /= "11111" then
            timeout_cntr <=  timeout_cntr + 1;    
        end if;
        if timeout_cntr = "11111" then 
            timeout <= '1';
        else
            timeout <= '0';
        end if;  
        clk_good <= clk_ok;
    end if;
end process;

reset_cnt <= (not cy_count_clk_in_rr) and cy_count_clk_in_r;

process(det_clk, t1_s_axi_csr_aresetn, reset_cnt) 
begin 
   if (t1_s_axi_csr_aresetn = '0') or (reset_cnt = '1') then
      count_clk_in <= '0';
   elsif rising_edge(det_clk) then
      count_clk_in <= '1';
   end if;
end process;   
     
process(s_axi_csr_aclk) 
   begin 
     if rising_edge(s_axi_csr_aclk) then
        if (t1_s_axi_csr_aresetn = '0') then
           cy_count_clk_in_r  <= '0';
           cy_count_clk_in_rr <= '0';
        else
           cy_count_clk_in_r <= count_clk_in;
           cy_count_clk_in_rr <= cy_count_clk_in_r;
        end if;
     end if;
end process;

process(s_axi_csr_aclk) 
   begin 
     if rising_edge(s_axi_csr_aclk) then
        if (reset_cnt = '1') or (t1_s_axi_csr_aresetn = '0') then
           count_sys_clk <= "000000";
        --elsif (count_sys_clk(5) = '0') then
        elsif (counter_tc_ff = '0') then
           count_sys_clk <= count_sys_clk + 1;
        end if;
     end if;
end process;

div2: if (min_freq_div = 2) generate 
counter_tc_ff <= count_sys_clk(1);
end generate;
div4: if (min_freq_div = 4) generate 
counter_tc_ff <= count_sys_clk(2);
end generate;
div8: if (min_freq_div = 8) generate 
counter_tc_ff <= count_sys_clk(3);
end generate;
div16: if (min_freq_div = 16) generate 
counter_tc_ff <= count_sys_clk(4);
end generate;
div32: if (min_freq_div = 32) generate 
counter_tc_ff <= count_sys_clk(5);
end generate;

-- Good Clock Count
process(det_clk, t1_s_axi_csr_aresetn, counter_tc_ff) 
begin 
   if (t1_s_axi_csr_aresetn = '0') or (counter_tc_ff = '1') then
      count_good_clk_in <= "000000000000000000000000000000";
   elsif rising_edge(det_clk) then
      if count_good_clk_in /= "111111111111111111111111111111" then
        count_good_clk_in <= count_good_clk_in + 1;
      end if;
   end if;
end process;   

process(det_clk, t1_s_axi_csr_aresetn, counter_tc_ff)
begin
   if (t1_s_axi_csr_aresetn = '0') or (counter_tc_ff = '1') then
      count_good_tc <= '0';
      t1_count_good_tc <= '0';
   elsif rising_edge(det_clk) then
    if count_good_clk_in = "111111111111111111111111111111" then
      count_good_tc <= '1';
    else
      count_good_tc <= '0';
    end if;  
    t1_count_good_tc <= count_good_tc;
   end if;
end process;  

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       t2_count_good_tc <= t1_count_good_tc;
       t3_count_good_tc <= t2_count_good_tc;
    end if;
end process; 
--------------------------------------------------------------------------------
-- Frequency Counter
--------------------------------------------------------------------------------

fifo_wr <= '1' when (freq_cntr_rst_rr = '1') and (freq_cntr_rst_rrr = '0') else '0';

process(clk_bufg) 
begin 
   if rising_edge(clk_bufg) then
      if (freq_cntr_rst_rr = '1') and (freq_cntr_rst_rrr = '0') then 
         freq_cntr  <= x"00000000";
      else
         freq_cntr  <= freq_cntr + 1;
      end if;
   end if;
end process;   

process(clk_bufg, freq_cntr_rst) 
begin 
   if freq_cntr_rst = '1' then
     freq_cntr_rst_r <= '1';
   elsif rising_edge(clk_bufg) then
     if freq_cntr_rst_rr = '1' then
       freq_cntr_rst_r <= '0';
     end if;
   end if;
end process;   

process(clk_bufg) 
begin 
   if rising_edge(clk_bufg) then
       freq_cntr_rst_rr  <= freq_cntr_rst_r;
       freq_cntr_rst_rrr <= freq_cntr_rst_rr;
   end if;
end process; 

process(refclk) 
begin 
   if rising_edge(refclk) then
      if (t1_s_axi_csr_aresetn = '0') then
        freq_period_cntr <= (others => '0');  
      else
        freq_period_cntr  <= freq_period_cntr + 1;
      end if;
      if freq_period_cntr = "111111111111111111111111111111" then
         freq_cntr_rst <= '1';
      else
         freq_cntr_rst <= '0';
      end if;
   end if;
end process;   

--------------------------------------------------------------------------------
-- LED
--------------------------------------------------------------------------------

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      led_lite <= clk_ok;     
      led_n <= not led_lite;
   end if;
end process;


csr_inst: px_sample_clk_rcvr_csr
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
-- Address Range - BASE + 0x00 -> BASE + 0x3F
--------------------------------------------------------------------------------
    s_axi_csr_aclk          => s_axi_csr_aclk,   
    s_axi_csr_aresetn       => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr        => s_axi_csr_awaddr,  
    s_axi_csr_awprot        => s_axi_csr_awprot,  
    s_axi_csr_awvalid       => s_axi_csr_awvalid, 
    s_axi_csr_awready       => s_axi_csr_awready, 
    s_axi_csr_wdata         => s_axi_csr_wdata,   
    s_axi_csr_wstrb         => s_axi_csr_wstrb,   
    s_axi_csr_wvalid        => s_axi_csr_wvalid,  
    s_axi_csr_wready        => s_axi_csr_wready,  
    s_axi_csr_bresp         => s_axi_csr_bresp,   
    s_axi_csr_bvalid        => s_axi_csr_bvalid,  
    s_axi_csr_bready        => s_axi_csr_bready,  
    s_axi_csr_araddr        => s_axi_csr_araddr,  
    s_axi_csr_arprot        => s_axi_csr_arprot,  
    s_axi_csr_arvalid       => s_axi_csr_arvalid, 
    s_axi_csr_arready       => s_axi_csr_arready, 
    s_axi_csr_rdata         => s_axi_csr_rdata,   
    s_axi_csr_rresp         => s_axi_csr_rresp,   
    s_axi_csr_rvalid        => s_axi_csr_rvalid,  
    s_axi_csr_rready        => s_axi_csr_rready,  
    
    irq                     => irq,           
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    clock_disable           => clock_disable,
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	           
    clk_ok                  => clk_ok,
    freq_cnt                => freq_latch,
    s0                      => s0,
    s1                      => s1,
    sm_state                => state
);

process(clk_bufg)
begin
   if rising_edge(clk_bufg) then
      if fifo_wr = '1' then
         freq_cntr_l <= freq_cntr;
      end if;
   end if;
end process;   

frq_xclk_inst :  xpm_cdc_handshake
    generic map (
  
      -- Common module generics
      DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
      DEST_SYNC_FF   => 4, -- integer; range: 2-10
      SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
      SRC_SYNC_FF    => 4, -- integer; range: 2-10
      WIDTH          => 32  -- integer; range: 1-1024
    )
    port map (
  
      src_clk  => clk_bufg,
      src_in   => freq_cntr_l,
      src_send => src_send,
      src_rcv  => src_rcv,
      dest_clk => s_axi_csr_aclk,
      dest_req => dest_req,
      dest_ack => dest_req, -- optional; required when DEST_EXT_HSK = 1
      dest_out => freq_x
   );
   
process(clk_bufg)
begin
   if rising_edge(clk_bufg) then
     if (src_rcv = '1') then
       src_send <= '0';
     elsif (src_rcv = '0') and (src_send = '0') then
       src_send <= '1';
     end if;  
   end if;
end process;   

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if dest_req = '1' then
         freq_latch <= freq_x;
      end if;
   end if;
end process;   
 

end Behavioral;
