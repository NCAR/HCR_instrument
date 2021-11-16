----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/13/2016 02:08:50 PM
-- Design Name: 
-- Module Name: px_axis_nco_2_mod - Behavioral
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

Library UNISIM;
use UNISIM.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_nco_2_mod is
port ( 
    --------------------------------------------------------------------------------
    -- Control Inputs
    --------------------------------------------------------------------------------    
    freq_val                 : in  std_logic_vector(31 downto 0);    
    off_val                  : in  std_logic_vector(31 downto 0);         
    sync_ld_en               : in  std_logic;
    sync_rst_en              : in  std_logic;      
    -----------------------------------------------------------------------------
    -- Timing Events (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tdata[n-1:0]       = Gate Positions
    -- tdata[2n-1:n]      = Sync Positions   
    -- tdata[3n-1:2n]     = PPS Positions  
    s_axis_aclk              : in  std_logic; -- Timestamp clock (usually data sample clock
    s_axis_aresetn           : in  std_logic; -- reset   
    s_axis_ptctl_tdata       : in  std_logic_vector(7  downto 0);
    s_axis_ptctl_tvalid      : in  std_logic;
    -----------------------------------------------------------------------------
    -- Test Signal Output (AXI4-Stream Master) no back pressure
    -----------------------------------------------------------------------------
    m_axis_pd_tdata          : out std_logic_vector(95 downto 0);
    m_axis_pd_tvalid         : out std_logic
);
end px_axis_nco_2_mod;

architecture Behavioral of px_axis_nco_2_mod is
    
    --------------------------------------------------------------------------------
    -- Components
    --------------------------------------------------------------------------------
    
    -- DDS
    -- 11 clock latency
    -- Clock Enable
    -- 20-bit output
    -- 32-bit phase and frequency
    COMPONENT px_axis_nco_2_dds
    PORT (
        aclk    : IN STD_LOGIC;
        aclken  : in std_logic;
        aresetn : IN STD_LOGIC;
        s_axis_phase_tvalid : IN STD_LOGIC;
        s_axis_phase_tdata  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        m_axis_data_tvalid  : OUT STD_LOGIC;
        m_axis_data_tdata   : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
      );
    END COMPONENT;

    --------------------------------------------------------------------------------
    -- Types
    --------------------------------------------------------------------------------
    type phase_i is array(0 to 1) of std_logic_vector(31 downto 0);
    --------------------------------------------------------------------------------
    -- Signals
    --------------------------------------------------------------------------------

    signal t1_s_axis_aresetn    : std_logic;                        
    signal t1_arm_load          : std_logic;                                      
    signal arm_re               : std_logic;                              
    signal t2_pps_re            : std_logic; 
    signal t2_pps_fe            : std_logic; 
    signal t3_cntr_load         : std_logic; 
    signal load_armed           : std_logic;  
    signal t2_sync_re           : std_logic; 
    signal t3_sync_re           : std_logic; 
    signal t1_s_axis_ptctl_tdata: std_logic_vector(1 downto 0);
    signal t1_s_axis_ptctl_tvalid : std_logic;   
    signal t2_s_axis_ptctl_tvalid : std_logic; 
    signal t3_s_axis_ptctl_tvalid : std_logic; 
    signal t4_s_axis_ptctl_tvalid : std_logic; 
    signal t5_s_axis_ptctl_tvalid : std_logic; 
    signal t6_s_axis_ptctl_tvalid : std_logic;
    signal t7_s_axis_ptctl_tvalid : std_logic;
    signal t8_s_axis_ptctl_tvalid : std_logic;
    signal t9_s_axis_ptctl_tvalid : std_logic;
    signal t10_s_axis_ptctl_tvalid: std_logic;
    signal t11_s_axis_ptctl_tvalid: std_logic;
    signal t12_s_axis_ptctl_tvalid: std_logic;
    signal t13_s_axis_ptctl_tvalid: std_logic;
    signal t14_s_axis_ptctl_tvalid: std_logic;
    signal t15_s_axis_ptctl_tvalid: std_logic;
    signal t16_s_axis_ptctl_tvalid: std_logic;
    signal t17_s_axis_ptctl_tvalid: std_logic;
    signal t2_sync               : std_logic;
    signal sync_or               : std_logic;
    signal t6_dds_s_axis_phase_tdata: std_logic_vector((2*64)-1 downto 0); 
    signal dds_aresetn           : std_logic;
    signal t4_cntr_load          : std_logic;
    signal t5_cntr_load          : std_logic;
    signal t2_s_axis_aresetn     : std_logic;
    signal t3_s_axis_aresetn     : std_logic;
    signal t4_s_axis_aresetn     : std_logic;
    signal t5_dds_load_offset    : std_logic_vector(31 downto 0);
    signal t17_dds_m_axis_data_tvalid: std_logic_vector(2-1 downto 0);
    signal t3_ramp_load_offset   : std_logic_vector(15 downto 0);
    signal t17_dds_m_axis_data_tdata: std_logic_vector((2*48)-1 downto 0);
    signal t2_sync_offset        : std_logic_vector(15 downto 0);
    signal t4_offset_gen_phase_i_of_n: std_logic_vector(31 downto 0);
    signal ph_i                  : phase_i;
    --------------------------------------------------------------------------------
    -- Constants
    --------------------------------------------------------------------------------
    
    constant iwidth: integer := 2;
    
    attribute max_fanout : integer;
    attribute max_fanout of t6_s_axis_ptctl_tvalid: signal is 400;
     
    attribute keep: boolean;

    attribute keep of t2_s_axis_ptctl_tvalid : signal is true;
    attribute keep of t3_s_axis_ptctl_tvalid : signal is true;
    attribute keep of t4_s_axis_ptctl_tvalid : signal is true;
    attribute keep of t5_s_axis_ptctl_tvalid : signal is true;
    attribute keep of t6_s_axis_ptctl_tvalid : signal is true;
    attribute keep of t7_s_axis_ptctl_tvalid : signal is true;
    attribute keep of t8_s_axis_ptctl_tvalid : signal is true;
    attribute keep of t9_s_axis_ptctl_tvalid : signal is true;
    attribute keep of t10_s_axis_ptctl_tvalid: signal is true;
    attribute keep of t11_s_axis_ptctl_tvalid: signal is true;
    attribute keep of t12_s_axis_ptctl_tvalid: signal is true;
    attribute keep of t13_s_axis_ptctl_tvalid: signal is true;
    attribute keep of t14_s_axis_ptctl_tvalid: signal is true;
    attribute keep of t15_s_axis_ptctl_tvalid: signal is true;
    attribute keep of t16_s_axis_ptctl_tvalid: signal is true;
    attribute keep of t17_s_axis_ptctl_tvalid: signal is true;

    --------------------------------------------------------------------------------
    -- Functions
    --------------------------------------------------------------------------------
    
    function gen_phase_i_of_n(phase_in : std_logic_vector(31 downto 0); i : integer range 0 to 1) return std_logic_vector is
    variable result : std_logic_vector(31 downto 0);
    begin
    case i is
       when 0 =>
          result := x"00000000";
       when 1 => 
          result := phase_in(31 downto 0);
       when others =>
          result := x"00000000";
    end case;
    return result;            
    end function gen_phase_i_of_n;
    
    function find_first_ptctl_position (signal_in : std_logic_vector; w : integer) return integer is
    variable result: integer := 0;
    variable found : std_logic := '0';
    variable indata : std_logic_vector(w-1 downto 0) := signal_in;
    begin
    result := w; -- if no set positions, return w
    found := '0';
    for i in 0 to (w-1) loop 
        if (indata(i) = '1') and (found = '0') then
            result := i; 
            found  := '1';
        end if;
    end loop;
    return result; 
    end function find_first_ptctl_position;
    
    --------------------------------------------------------------------------------
    
    begin
    
    -------------------------------------------------------------------------------
    
    process(s_axis_aclk)
    begin
       if rising_edge(s_axis_aclk) then
           t1_s_axis_aresetn        <= s_axis_aresetn; 
           t2_s_axis_aresetn        <= t1_s_axis_aresetn;    
           t3_s_axis_aresetn        <= t2_s_axis_aresetn;         
           t1_s_axis_ptctl_tdata    <= s_axis_ptctl_tdata(3 downto 2); 
           t1_s_axis_ptctl_tvalid   <= s_axis_ptctl_tvalid;
       end if;
    end process;
    
    
    process(s_axis_aclk)
    begin
       if rising_edge(s_axis_aclk) then
          -- reset must be two cycles wide
          dds_aresetn      <= not (((not t1_s_axis_aresetn) or (not t2_s_axis_aresetn)) or (sync_rst_en and (t2_sync_re or t3_sync_re)));
          if (((sync_ld_en = '1') and ((t2_sync_re = '1') or (t3_sync_re = '1'))) or (sync_ld_en = '0')) and (s_axis_ptctl_tvalid = '1') then
             t3_ramp_load_offset <= t2_sync_offset;
          end if;   
          t3_cntr_load <= t2_sync_re; 
          t4_cntr_load <= t3_cntr_load;
          t5_cntr_load <= t4_cntr_load;
          if t1_s_axis_aresetn = '0' then
            t2_sync    <= '0';
            t2_sync_re <= '0';
            t3_sync_re <= '0';
            t2_sync_offset <= (others => '0');
          elsif (t1_s_axis_ptctl_tvalid = '1') then
             t2_sync        <= sync_or;
             t2_sync_re     <= sync_or and not t2_sync;
             t3_sync_re     <= t2_sync_re;
             t2_sync_offset <= conv_std_logic_vector(find_first_ptctl_position( t1_s_axis_ptctl_tdata(1 downto 0), 2),16);
          end if;
       end if;
    end process;
    
    -- tdata[n-1:0]       = Gate Positions
    -- tdata[2n-1:n]      = Sync Positions   
    -- tdata[3n-1:2n]     = PPS Positions  
    
    sync_or <= t1_s_axis_ptctl_tdata(0) or t1_s_axis_ptctl_tdata(1);
        
    --------------------------------------------------------------------------------
    -- DDS Cores
    --------------------------------------------------------------------------------
    process(s_axis_aclk)
    begin
        if rising_edge(s_axis_aclk) then
           if (t2_s_axis_aresetn = '0') then
              t5_dds_load_offset <= (others => '0');
           elsif t4_cntr_load = '1' then
              t5_dds_load_offset <= t4_offset_gen_phase_i_of_n + off_val;
           end if;
           t4_offset_gen_phase_i_of_n <= gen_phase_i_of_n(freq_val, conv_integer(t3_ramp_load_offset));
        end if;
    end process;
    
    
gen_dds: for i in 0 to 1 generate
    
    dds_inst : px_axis_nco_2_dds
    port map (
        aclk                => s_axis_aclk,
        aclken              => t6_s_axis_ptctl_tvalid,
        aresetn             => dds_aresetn,
        s_axis_phase_tvalid => '1',
        s_axis_phase_tdata  => t6_dds_s_axis_phase_tdata((63+(i*64)) downto (i*64)),
        m_axis_data_tvalid  => t17_dds_m_axis_data_tvalid(i),
        m_axis_data_tdata   => t17_dds_m_axis_data_tdata((47+(i*48)) downto (i*48))

      );
    
   
    
    -- generate phase offsets
    process(s_axis_aclk)
    begin
        if rising_edge(s_axis_aclk) then
           if (t3_s_axis_aresetn = '0') then
              t6_dds_s_axis_phase_tdata(63+(i*64) downto 32+(i*64)) <= x"00000000";
           elsif t5_cntr_load = '1' then
              t6_dds_s_axis_phase_tdata(63+(i*64) downto 32+(i*64)) <= ph_i(i)(31 downto 0) - t5_dds_load_offset; 
           end if;
           ph_i(i) <= gen_phase_i_of_n(freq_val, i);
        end if;
    end process;
       
    process(s_axis_aclk)
    begin
        if rising_edge(s_axis_aclk) then
           if (t3_s_axis_aresetn = '0') then
              t6_dds_s_axis_phase_tdata(31+(i*64) downto (i*64)) <= (others => '0');
           elsif t5_cntr_load = '1' then
              -- generate frequency (phase increment)
              t6_dds_s_axis_phase_tdata(31+(i*64) downto (i*64)) <= freq_val(30 downto 0) & '0';
           end if;
        end if;
    end process;
        
end generate;
    
    process(s_axis_aclk)
    begin
       if rising_edge(s_axis_aclk) then     
           t2_s_axis_ptctl_tvalid   <= t1_s_axis_ptctl_tvalid;
           t3_s_axis_ptctl_tvalid   <= t2_s_axis_ptctl_tvalid;
           t4_s_axis_ptctl_tvalid   <= t3_s_axis_ptctl_tvalid;
           t5_s_axis_ptctl_tvalid   <= t4_s_axis_ptctl_tvalid;
           t6_s_axis_ptctl_tvalid   <= t5_s_axis_ptctl_tvalid;   
           t7_s_axis_ptctl_tvalid   <= t6_s_axis_ptctl_tvalid;   
           t8_s_axis_ptctl_tvalid  <= t7_s_axis_ptctl_tvalid;
           t9_s_axis_ptctl_tvalid  <= t8_s_axis_ptctl_tvalid; 
           t10_s_axis_ptctl_tvalid <= t9_s_axis_ptctl_tvalid; 
           t11_s_axis_ptctl_tvalid <= t10_s_axis_ptctl_tvalid; 
           t12_s_axis_ptctl_tvalid <= t11_s_axis_ptctl_tvalid; 
           t13_s_axis_ptctl_tvalid <= t12_s_axis_ptctl_tvalid;
           t14_s_axis_ptctl_tvalid <= t13_s_axis_ptctl_tvalid;
           t15_s_axis_ptctl_tvalid <= t14_s_axis_ptctl_tvalid;
           t16_s_axis_ptctl_tvalid <= t15_s_axis_ptctl_tvalid;
           t17_s_axis_ptctl_tvalid <= t16_s_axis_ptctl_tvalid;
        end if;
    end process;
         
    --------------------------------------------------------------------------------
    -- Output
    --------------------------------------------------------------------------------
    
    process(s_axis_aclk)
    begin
       if rising_edge(s_axis_aclk) then 
           m_axis_pd_tdata <= t17_dds_m_axis_data_tdata; 
           m_axis_pd_tvalid<= t17_s_axis_ptctl_tvalid; 
       end if;
    end process;

       
end Behavioral;
