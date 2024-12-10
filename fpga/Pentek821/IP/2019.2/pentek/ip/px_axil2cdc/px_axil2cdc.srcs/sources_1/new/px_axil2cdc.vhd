----------------------------------------------------------------------------------
-- Pentek AXI-Lite to CDCM7005 Clock Generator Control Interface
----------------------------------------------------------------------------------
-- px_axil2cdc.vhd
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

-- Register Map
-- 0x00 Control Register                R/W   
-- 0x04 Load Value Register             R/W   
-- 0x08 Write Req Register              R/W
-- 0x0C Status Register                 RO 
-- 0x10 Reserved                        RO 
-- 0x14 Interrupt Enables               R/W
-- 0x18 Interrupt Status Register       RO 
-- 0x1C Interrupt Flag Register         R/Clr

-------------------------------------------------------------------------------
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
-- Libraries
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity px_axil2cdc is
generic (
    clock_division : integer range 1 to 64 := 8;
    load_defaults  : boolean  := true;
    has_sync_bus_sig : boolean := true; 
    default_word0  : std_logic_vector(31 downto 0) := x"00000000";
    default_word1  : std_logic_vector(31 downto 0) := x"00000000";
    default_word2  : std_logic_vector(31 downto 0) := x"00000000";
    default_word3  : std_logic_vector(31 downto 0) := x"00000000"
);
port (
    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI4-LITE)
    ----------------------------------------------------------------------------
    -- associated with aclk
    aclk                     : in  std_logic;
    aresetn                  : in  std_logic;
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
    
    irq                      : out std_logic; -- Interrupt out
    ----------------------------------------------------------------------------
    -- Status Input Signals
    ----------------------------------------------------------------------------
    cdc_stat_vcxo            : in  std_logic;
    cdc_stat_ref             : in  std_logic;
    cdc_stat_lock            : in  std_logic;
    ----------------------------------------------------------------------------
    -- CDC Interface
    ----------------------------------------------------------------------------
    cdc_dat                  : out std_logic; -- cdc data input
    cdc_clk                  : out std_logic; -- cdc clock input
    cdc_le                   : out std_logic; -- cdc latch enable
    cdc_rst_n                : out std_logic;  -- cdc reset_n
    ----------------------------------------------------------------------------
    -- Clock Control Outputs
    ----------------------------------------------------------------------------
    vcxo_en                  : out  std_logic;
    vcxo_sel_n               : out  std_logic;
    clk_mux_sel              : out  std_logic_vector(1 downto 0);
    ----------------------------------------------------------------------------
    -- Status Outputs
    ----------------------------------------------------------------------------
    stat_vcxo                : out std_logic;
    stat_ref                 : out std_logic;
    stat_lock                : out std_logic; 
    ----------------------------------------------------------------------------
    -- SYNC Bus Signals
    ----------------------------------------------------------------------------
    cdc_sync_rst_in_p        : in  std_logic;
    cdc_sync_rst_in_n        : in  std_logic;
    cdc_sync_rst_out         : out std_logic;
    ----------------------------------------------------------------------------
    -- LED Drives
    ----------------------------------------------------------------------------
    cdc_stat_vcxo_led_n      : out std_logic;
    cdc_stat_ref_led_n       : out std_logic;
    cdc_stat_lock_led_n      : out std_logic
);
end px_axil2cdc;

architecture Behavioral of px_axil2cdc is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Control/Status Registers
component px_axil2cdc_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressingend Behavioral;
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
    cntl_word             : out std_logic_vector(31 downto 0);
    wr_req                : out std_logic;
    reg_rst               : out std_logic;
    vcxo_en               : out std_logic;
    vcxo_sel_n            : out std_logic;
    clk_mux_sel           : out std_logic_vector(1 downto 0);
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
end component;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------
-- State definitions
type state_cdc_ctrl is (
cdc_start_st,
cdc_le_start_st,
cdc_wr_loop_st,
cdc_wr_chg_data_st,
cdc_le_stop_st,
cdc_req_done_st
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal cdc_state        : state_cdc_ctrl;
signal t1_cdc_stat_vcxo : std_logic := '0';
signal t1_cdc_stat_ref  : std_logic := '0';
signal t1_cdc_stat_lock : std_logic := '0';
signal cntl_word        : std_logic_vector(31 downto 0) := (others => '0');
signal wr_req           : std_logic := '0';
signal reg_rst          : std_logic := '0';
signal rst_n            : std_logic := '0';
signal sm_ready         : std_logic := '0';
signal data             : std_logic_vector(31 downto 0) := (others => '0');
signal default_word_sel : std_logic_vector(1 downto 0) := (others => '0');
signal default_done     : std_logic := '0';
signal clock_divide     : std_logic_vector(5 downto 0) := (others => '0');
-- CDC 32-bit shift register
signal shft_enab        : std_logic := '0';   -- Shift enable
signal shft_ld          : std_logic := '0';   -- Shift reg load
signal sr_ser_out       : std_logic := '0';   -- SR serial data out
-- Shift register bit counter
signal bit_ctr          : std_logic_vector(4 downto 0) := (others => '0');  -- SR bit counter
signal bit_ctr_ld       : std_logic := '0';   -- Load
signal bit_ctr_ce       : std_logic := '0';   -- Clock enable
signal bit_ctr_tc       : std_logic := '0';   -- Terminal count
signal clock_en         : std_logic := '0';
signal sr_reg_q         : std_logic_vector(31 downto 0) := (others => '0');
signal cdc_sync_rst_in_en : std_logic := '0';
signal t1_rst_n         : std_logic := '0';
signal cdc_sync_rst_in  : std_logic := '0';
signal wr_req_ff        : std_logic := '0';
signal t1_wr_req_ff     : std_logic := '0';
signal t1_aresetn       : std_logic := '0';
signal t1_s_axi_csr_aresetn  : std_logic := '0';
--------------------------------------------------------------------------------

begin

gen_has_sync_bus_sig: if (has_sync_bus_sig = true) generate

sync_rst_IBUFDS_inst : IBUFDS
generic map (
    DIFF_TERM => true
)
port map (
  O  => cdc_sync_rst_in,    -- 1-bit output: Buffer output
  I  => cdc_sync_rst_in_p,  -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
  IB => cdc_sync_rst_in_n   -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
);

end generate;

gen_no_sync_bus_sig: if (has_sync_bus_sig = false) generate

cdc_sync_rst_in          <= '0';

end generate;

process(aclk)
begin
   if rising_edge(aclk) then
        cdc_stat_vcxo_led_n <= not t1_cdc_stat_vcxo;
        cdc_stat_ref_led_n  <= not t1_cdc_stat_ref; 
        cdc_stat_lock_led_n <= not t1_cdc_stat_lock;
        stat_vcxo           <= t1_cdc_stat_vcxo;
        stat_ref            <= t1_cdc_stat_ref; 
        stat_lock           <= t1_cdc_stat_lock;
        t1_cdc_stat_vcxo    <= cdc_stat_vcxo;
        t1_cdc_stat_ref     <= cdc_stat_ref; 
        t1_cdc_stat_lock    <= cdc_stat_lock;
    end if;
end process;

csr_inst: px_axil2cdc_csr
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
-- Address Range - BASE + 0x00 -> BASE + 0x3F
--------------------------------------------------------------------------------
    s_axi_csr_aclk          => aclk,   
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
    cntl_word               => cntl_word,
    wr_req                  => wr_req, 
    reg_rst                 => reg_rst,  
    vcxo_en                 => vcxo_en,    
    clk_mux_sel             => clk_mux_sel,
    vcxo_sel_n              => vcxo_sel_n, 
    cdc_sync_rst_out        => cdc_sync_rst_out,  
    cdc_sync_rst_in_en      => cdc_sync_rst_in_en,
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------    
    cdc_stat_vcxo           => t1_cdc_stat_vcxo, 
    cdc_stat_ref            => t1_cdc_stat_ref,  
    cdc_stat_lock           => t1_cdc_stat_lock, 
    sm_ready                => sm_ready,
    default_load_done       => default_done 
);

process(cntl_word, default_word_sel, default_done)
begin 
   if((load_defaults = true) and (default_done = '0')) then
      case default_word_sel is
         when "00" => 
            data <= default_word0;
         when "01" => 
            data <= default_word1;
         when "10" => 
            data <= default_word2;
         when "11" => 
            data <= default_word3;
         when others =>
            data <= default_word0;
       end case;
   else
      data <= cntl_word;
   end if;
end process;
    
                   
process(aclk)
begin
   if rising_edge(aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
      t1_aresetn <= aresetn;
      if(rst_n = '0') then
         clock_divide <= (others => '0');
         clock_en     <= '0';
      elsif(clock_divide = (conv_std_logic_vector(clock_division, 6) - 1)) then
         clock_divide <= (others => '0');
         clock_en     <= '1';
      else
        clock_divide  <= clock_divide + 1;
        clock_en      <= '0';
      end if;
   end if;
end process;

rst_n <= '0' when ((reg_rst = '1') or (t1_aresetn = '0')) else '1';



--------------------------------------------------------------------------------
-- CDC Shift Register
--------------------------------------------------------------------------------

process(aclk)
begin
   if rising_edge(aclk) then
      if (rst_n = '0') then
         sr_reg_q <= (others => '0');
      elsif clock_en = '1' then
         if (shft_ld = '1') then 
            sr_reg_q <= data; 
         elsif (shft_enab = '1') then 
            sr_reg_q <= sr_reg_q(30 downto 0) & '0';
		   end if; 
	   end if;
   end if;
end process;

sr_ser_out <= sr_reg_q(31);

-------------------------------------------------------------------------------
-- Shift Register Bit Counter
-------------------------------------------------------------------------------
--
--This counter cycles from 31 downto 0 when counting the number of bits clocked
--out by the shift register.  The counter also corresponds to the order in
-- which the bits are serially output by the SR register, i.e. MSB to LSB.
process(aclk)
begin
   if rising_edge(aclk) then
      if (rst_n = '0') then
         bit_ctr <= (others => '1');
      elsif clock_en = '1' then
         if (bit_ctr_ld = '1') then
            bit_ctr <= (others => '1');
         -- disable counter when terminal count reached
         elsif (bit_ctr_ce = '1' and bit_ctr_tc = '0') then
            bit_ctr <= bit_ctr - 1;
         end if;
      end if;
   end if;
end process;

-- Terminal count reached at 0
bit_ctr_tc <= '1' when (bit_ctr = "00000") else '0';

--------------------------------------------------------------------------------
-- CDC Output Data
--------------------------------------------------------------------------------

process (sr_ser_out, cdc_state)
begin
   if (cdc_state = cdc_start_st) then
      cdc_dat <= '0';
   else
      cdc_dat <= sr_ser_out;
   end if;
end process;

---------------------------------------------------------------------------------
-- Miscellaneous Logic
---------------------------------------------------------------------------------

process(aclk)
begin
   if rising_edge(aclk) then
      t1_rst_n   <= rst_n;
   end if;
end process;

cdc_rst_n <= not ((cdc_sync_rst_in and cdc_sync_rst_in_en) or (not t1_rst_n));

process(aclk)
begin
   if rising_edge(aclk) then
     if (rst_n = '0') then
         wr_req_ff <= '0';
     elsif (wr_req = '1') then
        wr_req_ff <= '1';
     elsif  clock_en = '1' then
        wr_req_ff <= '0';
     end if;
     if  clock_en = '1' then
        t1_wr_req_ff <= wr_req_ff;
     end if;   
   end if;
end process;
    
--------------------------------------------------------------------------------
-- Serial CDC State Machine
--------------------------------------------------------------------------------

process (aclk)
begin
   if rising_edge(aclk) then
      if (rst_n = '0') then
         cdc_state         <= cdc_start_st;
         default_done      <= '0';
         default_word_sel  <= "00";
         cdc_clk           <= '0';
         cdc_le            <= '1';
         sm_ready          <= '0';
         shft_enab         <= '0';
         shft_ld           <= '1';
         bit_ctr_ld        <= '1';
         bit_ctr_ce        <= '0';
      elsif clock_en = '1' then
         case cdc_state is
         ----------------
         -- Start cycle
         ----------------
            when cdc_start_st =>
            -- Default signal outputs
               cdc_clk     <= '0';  -- CDC interface
               cdc_le      <= '1';
               if ((LOAD_DEFAULTS = true) and (default_done = '0')) then
                  sm_ready          <= '0';
               else
                  sm_ready          <= '1';
               end if;
               shft_enab   <= '0';  -- Shift register signals
               shft_ld     <= '1';
               bit_ctr_ld  <= '1';  -- Bit counter signals
               bit_ctr_ce  <= '0';
               -- Wait for input command
               if (((t1_wr_req_ff = '1') and (sm_ready = '1')) or ((load_defaults = true) and
                  (default_done = '0'))) then -- Check for write command
                  cdc_state   <= cdc_le_start_st;
               else
                  cdc_state   <= cdc_start_st;
               end if;
         ---------------------------
         -- LE Start (CDC_LE -> 0)
         ---------------------------
            when cdc_le_start_st =>
               bit_ctr_ld  <= '0';  -- Remove bit ctr load
               shft_ld     <= '0';  -- Remove the SR load
               cdc_le      <= '0';
               sm_ready    <= '0';
               cdc_state   <= cdc_wr_loop_st;
         -----------------------
         -- Write Control Word 
         -----------------------
         -- Loop here (CLK -> H) to shift out control byte
            when cdc_wr_loop_st =>
               cdc_clk     <= '1';
               shft_enab   <= '1';  -- Clock shift register
               bit_ctr_ce  <= '1';  -- Decrement bit ctr
               cdc_state   <= cdc_wr_chg_data_st;
         -- Change data with falling edge of clock (CLK -> L)
            when cdc_wr_chg_data_st =>
               cdc_clk     <= '0';
               shft_enab   <= '0';  -- Remove shift enab
               bit_ctr_ce  <= '0';  -- Remove bit ctr CE
         -- Test for byte transfer done
               if (bit_ctr_tc = '1') then
                  cdc_state <= cdc_le_stop_st;
               else
                  cdc_state <= cdc_wr_loop_st;
               end if;
            --------------------------
            -- LE Stop (CDC_LE -> 1)
            --------------------------
               when cdc_le_stop_st =>
                  cdc_le      <= '1';
                  cdc_state   <= cdc_req_done_st;
            ----------------------------------------------
            -- Wait for read/write request to be removed
            ----------------------------------------------
               when cdc_req_done_st =>
                  if ((load_defaults = true) and (default_done = '0')) then
                     default_word_sel <= default_word_sel + '1';
                     if(default_word_sel = "10") then
                        default_done  <= '1';
                        cdc_state     <= cdc_start_st;
                     else
                        cdc_state     <= cdc_le_start_st;
                     end if;
                     bit_ctr_ld <= '1';
                     shft_ld    <= '1';
                  else
                     cdc_state   <= cdc_start_st;

                  end if;
            when others =>
               cdc_state <= cdc_start_st;
         end case;
      end if;
   end if;
end process;

end Behavioral;