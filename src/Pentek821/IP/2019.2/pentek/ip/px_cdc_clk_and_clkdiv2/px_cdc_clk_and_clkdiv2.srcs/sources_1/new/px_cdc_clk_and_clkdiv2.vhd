----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- Pentek CDCM7005 Clock Receiver (Divide by 2 Version)
-- Create Date: 01/24/2017 09:17:54 AM
-- Design Name: 
-- Module Name: px_cdc_clk_and_div2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Pentek CDCM7005 Clock Receiver (Divide by 2 Version)
-- 
-- Dependencies: 
-- 
-- Revision:
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

entity px_cdc_clk_and_clkdiv2 is
generic(
   differential_term        : string := "TERM_100"; -- "TERM_100" or "TERM_NONE"
   ibuf_low_pwr             : boolean := false;
   initial_led_mode         : integer := 0;
   invert_in_clk            : boolean := true 
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
   -- Status Input Signals
   ----------------------------------------------------------------------------
   cdc_stat_vcxo            : in  std_logic;
   cdc_stat_ref             : in  std_logic;
   cdc_stat_lock            : in  std_logic;
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
   full_sample_clk          : out std_logic;
   div2_sample_clk          : out std_logic;
-----------------------------------------------------------------------------
-- LED Drive
-----------------------------------------------------------------------------
   led_n                    : out std_logic;
   clk_good                 : out std_logic
 );
end px_cdc_clk_and_clkdiv2;

architecture Behavioral of px_cdc_clk_and_clkdiv2 is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";



-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------
component px_cdc_clk_and_clkdiv2_csr
generic(
   initial_led_src        : integer := 0 -- Initial LED Mode at Reset          
);
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
    led_mode              : out std_logic_vector(1 downto 0);
    clock_disable         : out std_logic;
    --------------------------------------------------------------------------------
    -- Status Inputs
    --------------------------------------------------------------------------------                      
    clk_ok                : in  std_logic; 
    cdc_stat_vcxo         : in  std_logic;
    cdc_stat_ref          : in  std_logic;
    cdc_stat_lock         : in  std_logic;
    freq_cnt              : in  std_logic_vector(31 downto 0);
    sm_state              : in  std_logic_vector(2 downto 0)
);
end component;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
   function px_boolean_to_std_logic(l: boolean) return std_logic is
   begin
       if l then
          return('1');
       else
          return('0');
       end if;
   end function px_boolean_to_std_logic;


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
constant inv_i               : bit := to_bit(px_boolean_to_std_logic(invert_in_clk));
-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal clkin              : std_logic := '0';
signal clk_bufg           : std_logic := '0';
signal timeout_clr_n      : std_logic := '0';
signal clk_ok             : std_logic := '0';
--signal state              : state_type := RESET_STATE;
signal state              : std_logic_vector(2 downto 0) := "000";
signal timeout_cntr       : std_logic_vector(4 downto 0) := "00000";
signal reset_cnt          : std_logic := '0';
signal cy_count_clk_in_rr : std_logic := '0';
signal cy_count_clk_in_r  : std_logic := '0';
signal count_clk_in       : std_logic_vector(1 downto 0) := "00";
signal count_sys_clk      : std_logic_vector(8 downto 0) := "000000000";
signal counter_tc_ff      : std_logic := '0';
signal count_good_clk_in  : std_logic_vector(3 downto 0) := "0000";
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
signal clock_disable_n    : std_logic := '1';
signal freq_latch         : std_logic_vector(31 downto 0) := x"00000000";
signal frq_fifo_empty     : std_logic := '0';
signal freq_period_cntr   : std_logic_vector(29 downto 0) := (others => '0');
signal timeout            : std_logic := '0';
signal count_good_tc      : std_logic := '0';
signal t1_count_good_tc   : std_logic := '0';
signal t2_count_good_tc   : std_logic := '0';
signal t3_count_good_tc   : std_logic := '0';
signal src_send           : std_logic := '0';
signal src_rcv            : std_logic := '0';
signal dest_req           : std_logic := '0';
signal freq_x             : std_logic_vector(31 downto 0) := x"00000000";
signal t1_man_keepalive_in: std_logic := '0';
signal freq_cntr_l        : std_logic_vector(31 downto 0) := x"00000000";
signal t1_s_axi_csr_aresetn: std_logic := '0';
signal t1_csr_rst         : std_logic := '0';
signal t1_csr_rst_rs      : std_logic := '0';
signal csr_aresetn_bufgrs : std_logic := '0';
signal counter_tc_ff_rs   : std_logic := '0';
signal freq_cntr_rst_rs   : std_logic := '0';
		
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
    O  => full_sample_clk
);

BUFGCE_DIV_inst : BUFGCE_DIV
generic map (
   BUFGCE_DIVIDE => 2,     -- 1-8
   -- Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
   IS_CE_INVERTED => '0',  -- Optional inversion for CE
   IS_CLR_INVERTED => '0', -- Optional inversion for CLR
   IS_I_INVERTED => inv_i    -- Optional inversion for I
)
port map (
   O   => clk_bufg,     -- 1-bit output: Buffer
   CE  => clock_disable_n,   -- 1-bit input: Buffer enable
   CLR => '0', -- 1-bit input: Asynchronous clear
   I   => clkin      -- 1-bit input: Buffer
);
  
div2_sample_clk <= clk_bufg;

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        if (t1_s_axi_csr_aresetn = '0') then
             timeout_clr_n <= '0';
             clk_ok        <= '0';
             state         <= RESET_STATE;
        else
            case state is
                when RESET_STATE =>
                    if (t1_s_axi_csr_aresetn = '0') then
                       timeout_clr_n <= '0';
                       state <= RESET_STATE;
                    else
                       state <= START_TIMEOUT_CNTR_STATE;
                       timeout_clr_n <= '1';
                    end if;
                when START_TIMEOUT_CNTR_STATE =>
                    state <= KEEP_ALIVE_STATE;
                    clk_ok <= '0';
                when KEEP_ALIVE_STATE =>
                    clk_ok <= '0';
                    if (timeout = '1') then
                        state <= TIMEOUT_STATE;
                        timeout_clr_n <= '0';
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
                when GOOD_CLOCK_STATE =>
                    clk_ok <= '1';
                    if (counter_tc_ff = '1') or (clock_disable = '1') then
                       state <= START_TIMEOUT_CNTR_STATE;
                       timeout_clr_n <= '1';
                    else
                       state  <= GOOD_CLOCK_STATE;
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

--reset_cnt <= (not cy_count_clk_in_rr) and cy_count_clk_in_r;

process(clk_bufg) 
begin 
   if rising_edge(clk_bufg) then
      count_clk_in <= count_clk_in+1;
   end if;
end process;   

gdrst_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 2, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => clk_bufg,
    src_rst    => t1_csr_rst_rs,   -- optional; required when RST_USED = 1
    src_pulse  => count_clk_in(1),
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => reset_cnt
  );

process(s_axi_csr_aclk) 
   begin 
     if rising_edge(s_axi_csr_aclk) then
        if (reset_cnt = '1') or (t1_s_axi_csr_aresetn = '0') then
           count_sys_clk <= "000000000";
        elsif (count_sys_clk(8) = '0') then
           count_sys_clk <= count_sys_clk + 1;
        end if;
     end if;
end process;

counter_tc_ff <= count_sys_clk(8);

cntrff_cdc_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => counter_tc_ff,
     dest_clk => clk_bufg,
     dest_out => counter_tc_ff_rs
  );

-- Good Clock Count
process(clk_bufg) 
begin 
   if rising_edge(clk_bufg) then
      if (csr_aresetn_bufgrs = '0') or (counter_tc_ff_rs = '1') then
         count_good_clk_in <= "0000";
      elsif count_good_clk_in /= "1111" then
        count_good_clk_in <= count_good_clk_in + 1;
      end if;
   end if;
end process;   

process(clk_bufg)
begin
   if rising_edge(clk_bufg) then
      if (csr_aresetn_bufgrs = '0') or (counter_tc_ff_rs = '1') then
         count_good_tc    <= '0';
         t1_count_good_tc <= '0';
      else
         if count_good_clk_in = "1111" then
            count_good_tc <= '1';
         else
            count_good_tc <= '0';
         end if;  
         t1_count_good_tc <= count_good_tc;
      end if;
   end if;   
end process;  

cntgtc_cdc_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 2, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => clk_bufg,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => t1_count_good_tc,
     dest_clk => s_axi_csr_aclk,
     dest_out => t3_count_good_tc
  );
  
bufgcsrrst_cdc_inst: xpm_cdc_sync_rst
  generic map (
     -- Common module parameters
     DEST_SYNC_FF    => 2, -- integer; range: 2-10
     INIT            => 0, -- integer; 0=initialize synchronization registers to 0,
                           --          1=initialize synchronization registers to 1
     SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
     src_rst  => t1_s_axi_csr_aresetn,
     dest_clk => clk_bufg,
     dest_rst => csr_aresetn_bufgrs
  );  

--------------------------------------------------------------------------------
-- Frequency Counter
--------------------------------------------------------------------------------

fifo_wr <= freq_cntr_rst_rs;

process(clk_bufg) 
begin 
   if rising_edge(clk_bufg) then
      --if (freq_cntr_rst_rr = '1') and (freq_cntr_rst_rrr = '0') then 
      if (freq_cntr_rst_rs = '1') then 
         freq_cntr  <= x"00000000";
      else
         freq_cntr  <= freq_cntr + 1;
      end if;
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

freqrst_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 2, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => refclk,
    src_rst    => t1_csr_rst_rs,   -- optional; required when RST_USED = 1
    src_pulse  => freq_cntr_rst,
    dest_clk   => clk_bufg,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => freq_cntr_rst_rs
  );
  
csrrst_cdc_inst: xpm_cdc_sync_rst
generic map (
   -- Common module parameters
   DEST_SYNC_FF    => 2, -- integer; range: 2-10
   INIT            => 1, -- integer; 0=initialize synchronization registers to 0,
                         --          1=initialize synchronization registers to 1
   SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
   src_rst  => t1_csr_rst,
   dest_clk => refclk,
   dest_rst => t1_csr_rst_rs
);
    
t1_csr_rst <= not t1_s_axi_csr_aresetn;

--------------------------------------------------------------------------------
-- LED
--------------------------------------------------------------------------------

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if t1_man_keepalive_in = '1' then
        led_lite <= '0';
      else
         case led_mode is
            -- VCXO with External Reference Clock
            when "00" => 
               led_lite <= clk_ok;
            when "01" => 
               led_lite <= clk_ok and cdc_stat_vcxo; 
            when "10" => 
               led_lite <= clk_ok  and cdc_stat_vcxo and cdc_stat_ref and cdc_stat_lock;
            when "11" =>    
               led_lite <= clk_ok  and cdc_stat_vcxo and cdc_stat_ref and cdc_stat_lock;
            when others =>
              led_lite <= clk_ok  and cdc_stat_vcxo and cdc_stat_ref and cdc_stat_lock;
         end case;
      end if;
      t1_cdc_stat_vcxo <= cdc_stat_vcxo;
      t1_cdc_stat_ref  <= cdc_stat_ref; 
      t1_cdc_stat_lock <= cdc_stat_lock;
      
      led_n <= not led_lite;
   end if;
end process;


csr_inst: px_cdc_clk_and_clkdiv2_csr
generic map(
   initial_led_src          => initial_led_mode          
)
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
    led_mode                => led_mode,
    clock_disable           => clock_disable,
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	           
    clk_ok                  => clk_ok,
    cdc_stat_vcxo           => t1_cdc_stat_vcxo, 
    cdc_stat_ref            => t1_cdc_stat_ref,  
    cdc_stat_lock           => t1_cdc_stat_lock,
    freq_cnt                => freq_latch,
    sm_state                => state
);

clock_disable_n <= not clock_disable;

process(clk_bufg)
begin
   if rising_edge(clk_bufg) then
      if fifo_wr = '1' then
         freq_cntr_l <= freq_cntr(30 downto 0) & '0';
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
