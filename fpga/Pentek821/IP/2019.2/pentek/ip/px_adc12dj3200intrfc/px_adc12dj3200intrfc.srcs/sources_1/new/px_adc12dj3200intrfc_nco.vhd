----------------------------------------------------------------------------------
-- Company:  Pentek Inc
-- Engineer: G.L.
-- 	
-- Create Date: 05/08/2017 
-- IP Core Name: PX_ADC12DJ3200_INTRFC
-- File Name: px_adc12dj3200_intrfc_nco.vhd 
-- Target Devices: Kintex UltraScale  
-- Tool Versions: 2016.4
-- Description: This is a submodule for the PX_ADC12DJ3200_INTRFC IP Core.
-- This submodule is an NCO selection controller for the
-- Texas Intrument ADC12DJ3200 analog to digital chip. The ADC chip has four possible
-- NCO selections per ADC that are set VIA external pins. NCO's can be directly 
-- set by software or set by auto control mode. 

-- In auto control mode, the NCO selections
-- are sequenced based on counter length settings from software and GATE/SYNC/PPS events.
-- The sequence of the NCO's is as follows: 0-1-2-3-0-1, etc.  Setting all counter 
-- registers to zero will result in only NCO 0 to always remain selected.  Setting a 
-- counter register to a value other than zero will result in the NCO to remain 
-- selected for the amount of GATE/SYNC/PPS events set in the counter register.  
-- If only one counter is set, that respective NCO selection will remain selected 
-- indefinitely.  If more than one counter register is set, the NCO selections will 
-- remain selected for the number of GATE/SYNC/PPS events before progressing to the next trigger.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.1 - 5/2/2018 - Fixed NCO controller state machine and added 
-- nco_a_cntrl_start and nco_b_cntrl_start
-- 
-- Revision 1.0 - 5/8/2017 - Module Created
-- Additional Comments:
-- 

-- (Memory Map)

-- (Additional Info)
-- Example: Requires adc_nco output ports to be attatched to external FPGA pin

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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity px_adc12dj3200intrfc_nco is
port
(
    adc_sample_clk         : in std_logic;
    
    nco_src                : in std_logic;
    nco_soft_sel           : in std_logic_vector(1 downto 0);
    nco_cntrl_rst          : in std_logic;
    nco_cntrl_en           : in std_logic;
    nco_cntrl_start        : in std_logic;
    nco_auto_cntr_incr_src : in std_logic_vector(1 downto 0);
    nco_sel_auto_cntrs     : in std_logic_vector(31 downto 0);
    
    s_axis_timecntl_tvalid   : in std_logic;
    s_axis_timecntl_tdata    : in std_logic_vector(31 downto 0);

    adc_nco_out             : out std_logic_vector(1 downto 0)
);

end px_adc12dj3200intrfc_nco;

architecture Behavioral of px_adc12dj3200intrfc_nco is


type state_mach_states is (reset_state, 
                           nco_sel_00,
                           nco_sel_01,
                           nco_sel_10,
                           nco_sel_11);

signal next_state : state_mach_states;
signal curr_state : state_mach_states;

signal gate           : std_logic;
signal sync           : std_logic;
signal pps            : std_logic;

signal cntr_incr_reg1 : std_logic;
signal cntr_incr_reg2 : std_logic;
signal cntr_incr      : std_logic;

signal nco_count_done     : std_logic;
signal nco_count_done_reg : std_logic;
signal nco_counter        : std_logic_vector(7 downto 0);
signal nco_counter_reg    : std_logic_vector(7 downto 0);

signal nco_cntrl_start_reg1  : std_logic := '0';
signal nco_cntrl_start_reg2  : std_logic := '0';
signal nco_cntrl_start_pulse : std_logic := '0';


begin

    gate <= s_axis_timecntl_tdata(0);
    sync <= s_axis_timecntl_tdata(8);
    pps  <= s_axis_timecntl_tdata(16);
    
    process(adc_sample_clk)
    begin
       if(rising_edge(adc_sample_clk)) then
           if nco_cntrl_rst = '1' then
               cntr_incr_reg1 <= '0';
               cntr_incr_reg2 <= '0';
               cntr_incr      <= '0';
           else
           
              if(nco_cntrl_en = '1') then
                  -- Use either gate, sync or pps to increment NCO counter, based
                  -- software selection
                  
                  nco_cntrl_start_reg1  <= nco_cntrl_start;
                  nco_cntrl_start_reg2  <= nco_cntrl_start_reg1;
                  nco_cntrl_start_pulse <= nco_cntrl_start_reg1 and not nco_cntrl_start_reg2;
                  
                  case nco_auto_cntr_incr_src is
                  
                      when "00" =>
                          cntr_incr_reg1 <= gate;
                      when "01" =>
                          cntr_incr_reg1 <= sync;
                      when "10" =>
                          cntr_incr_reg1 <= pps;
                      when "11" =>
                          cntr_incr_reg1 <= '0';
                      when others => 
                          cntr_incr_reg1 <= '0';
                  end case;
                  
                  -- Generate 1 clock cycle pulse 
                  cntr_incr_reg2 <= cntr_incr_reg1;
                  cntr_incr      <= cntr_incr_reg1 and not cntr_incr_reg2;
              end if;
              
           end if;
       end if;
    end process;

    -- State machine
    process(adc_sample_clk)
    begin
       if(rising_edge(adc_sample_clk)) then
           if nco_cntrl_rst = '1' then
              curr_state <= reset_state;
           else
              curr_state <= next_state;
           end if;
       end if;
    end process;
    
    -- State machine that controls sequence of NCO selections based on software
    -- settings
    process(nco_cntrl_start_pulse, nco_sel_auto_cntrs, nco_count_done_reg, curr_state) begin
    
        case curr_state is
        
            when reset_state =>
                
                if(nco_cntrl_start_pulse = '1') then
                    if(nco_sel_auto_cntrs = X"00000000") then
                        next_state <= nco_sel_00;
                    elsif(nco_sel_auto_cntrs(7 downto 0) /= X"00") then
                        next_state <= nco_sel_00; 
                    elsif(nco_sel_auto_cntrs(15 downto 8) /= X"00") then
                        next_state <= nco_sel_01;
                    elsif(nco_sel_auto_cntrs(23 downto 16) /= X"00") then
                        next_state <= nco_sel_10;
                    elsif(nco_sel_auto_cntrs(31 downto 24) /= X"00") then
                        next_state <= nco_sel_11;
                    else
                        next_state <= reset_state;
                    end if;
                else
                    next_state <= reset_state;
                end if;
            
            when nco_sel_00 =>
            
                if(nco_count_done_reg = '1') then
                    if(nco_sel_auto_cntrs(15 downto 8) /= X"00") then
                        next_state <= nco_sel_01;
                    elsif(nco_sel_auto_cntrs(23 downto 16) /= X"00") then
                        next_state <= nco_sel_10;
                    elsif(nco_sel_auto_cntrs(31 downto 24) /= X"00") then
                        next_state <= nco_sel_11;
                    else
                        next_state <= nco_sel_00;
                    end if;
                else
                    next_state <= nco_sel_00;
                end if;
                
            when nco_sel_01 => 
   
                if(nco_count_done_reg = '1') then
                    if(nco_sel_auto_cntrs(23 downto 16) /= X"00") then
                        next_state <= nco_sel_10;
                    elsif(nco_sel_auto_cntrs(31 downto 24) /= X"00") then
                        next_state <= nco_sel_11;
                    elsif(nco_sel_auto_cntrs(7 downto 0) /= X"00") then
                        next_state <= nco_sel_00;
                    else
                        next_state <= nco_sel_01;
                    end if;
                else
                    next_state <= nco_sel_01;
                end if;
            
            when nco_sel_10 =>
                if(nco_count_done_reg = '1') then
                    if(nco_sel_auto_cntrs(31 downto 24) /= X"00") then
                        next_state <= nco_sel_11;
                    elsif(nco_sel_auto_cntrs(7 downto 0) /= X"00") then
                        next_state <= nco_sel_00;
                    elsif(nco_sel_auto_cntrs(15 downto 8) /= X"00") then
                        next_state <= nco_sel_01;
                    else
                        next_state <= nco_sel_10;
                    end if;
                else
                    next_state <= nco_sel_10;
                end if;
                
            when nco_sel_11 =>
                if(nco_count_done_reg = '1') then
                    if(nco_sel_auto_cntrs(7 downto 0) /= X"00") then
                        next_state <= nco_sel_00;
                    elsif(nco_sel_auto_cntrs(15 downto 8) /= X"00") then
                        next_state <= nco_sel_01;
                    elsif(nco_sel_auto_cntrs(23 downto 16) /= X"00") then
                        next_state <= nco_sel_10;
                    else
                        next_state <= nco_sel_11;
                    end if;
                else
                    next_state <= nco_sel_11;
                end if;
                
            when others =>
                next_state <= reset_state;
        end case;
        
    end process;
    
    -- Process to control count done
    process(adc_sample_clk) begin
        if(rising_edge(adc_sample_clk)) then
            
            if(curr_state = reset_state) then
                nco_count_done     <= '0';
                nco_count_done_reg <= '0';
                nco_counter     <= X"01";
                nco_counter_reg <= X"01"; 
            else
            
                nco_count_done_reg <= nco_count_done;
                nco_counter_reg    <= nco_counter;
            
                -- Increment counter every GATE/SYNC/PPS event
                if(cntr_incr = '1') then
                    nco_counter <= nco_counter + '1';
                    
                    -- When the auto counter has been satisfied, set done in order
                    -- to progress to the next NCO selection
                    if((curr_state = nco_sel_00 and nco_counter_reg = nco_sel_auto_cntrs(7 downto 0) ) or
                       (curr_state = nco_sel_01 and nco_counter_reg = nco_sel_auto_cntrs(15 downto 8) ) or
                       (curr_state = nco_sel_10 and nco_counter_reg = nco_sel_auto_cntrs(23 downto 16) ) or
                       (curr_state = nco_sel_11 and nco_counter_reg = nco_sel_auto_cntrs(31 downto 24) ) 
                      ) then
                      
                        nco_count_done <= '1';
                        nco_counter    <= X"01";
                    end if;
                else
                    nco_count_done <= '0';
                end if;
            end if;
        end if;
    end process;
    
    -- Output NCO selection 
    process(adc_sample_clk) begin
        if(rising_edge(adc_sample_clk)) then
        
            -- Software selection
            if(nco_src = '0') then
                adc_nco_out <= nco_soft_sel;
                
            -- Auto controller    
            else
                case curr_state is
                    when nco_sel_00 =>
                        adc_nco_out <= "00";
                    when nco_sel_01 =>
                        adc_nco_out <= "01";
                    when nco_sel_10 =>
                        adc_nco_out <= "10";
                    when nco_sel_11 =>
                        adc_nco_out <= "11";
                    when others =>
                        adc_nco_out <= "00";
                end case;
            end if;
        end if;
    end process;
    
    
    
end Behavioral;
