----------------------------------------------------------------------------------
-- Company:  Pentek Inc
-- Engineer: G.L.
-- 	
-- Create Date: 05/08/2017 
-- IP Core Name: PX_ADC12DJ3200_INTRFC
-- File Name: px_adc12dj3200_intrfc_unpack.vhd 
-- Target Devices: Kintex UltraScale  
-- Tool Versions: 2016.4
-- Description: This is a submodule for the PX_ADC12DJ3200_INTRFC IP Core. 
-- This submodule receives data from a seperate JESD interface, unpacks and
-- reorders the data for output. 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.0 - 5/8/2017   - Module Created
--
-- Revision 1.2 - 11/16/2018 - Changed fifo implementation option of jesd_buffer_fifo 
-- from built-in to block ram. Block Ram results in better routing and timing for
-- fifo's operating at high frequencies.
-- Revision 1.2 - 3/4/2019 - Issue with data inversion with inverting 
-- lane_x_data(0) through lane_x_data(3). Fixed by inverting lane_x_data(4) through
-- lane_x_data(7)
-- Revision 1.3 - 3/28/2019 - Modified code in single channel JMODEs 0 and 5 to
-- output ADC data to both m_axis_adc1_pd and m_axis_adc2_pd
--
--
-- Additional Comments:
-- 

-- (Memory Map)

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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;
Library xpm;
use xpm.vcomponents.all;

entity px_adc12dj3200intrfc_unpack is
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
end px_adc12dj3200intrfc_unpack;

architecture Behavioral of px_adc12dj3200intrfc_unpack is


type lane_x_array   is array(0 to 7) of std_logic_vector(31 downto 0);
type data_t_array is array(0 to 39) of std_logic_vector(15 downto 0);

type state_type_12bit is
(
RESET,
STATE_16BIT_ALL,
STATE_12BIT_0,
STATE_12BIT_1,
STATE_12BIT_2,
STATE_12BIT_3,
STATE_12BIT_4
);

signal curr_state : state_type_12bit;
signal next_state : state_type_12bit;


signal jmode_cdc  : std_logic_vector(4 downto 0);

-- Pipeline delay of AXIE Lite valid signal of JESD backend ADC data
signal s_axis_jesd_rx_pd_tvalid_reg1 : std_logic;
signal s_axis_jesd_rx_pd_tvalid_reg2 : std_logic;
signal s_axis_jesd_rx_pd_tvalid_reg3 : std_logic;
signal s_axis_jesd_rx_pd_tvalid_reg4 : std_logic;
signal s_axis_jesd_rx_pd_tvalid_reg5 : std_logic;
signal s_axis_jesd_rx_pd_tvalid_reg6 : std_logic;
signal s_axis_jesd_rx_pd_tvalid_reg7 : std_logic;


signal ch0_m_axis_rx_tdata_toggle  : std_logic;
signal ch0_m_axis_rx_tdata_sel     : std_logic_vector(1 downto 0) := "00";

signal adc_data_pre_jesd_buffer_tvalid    : std_logic;

signal lane_x_data      : lane_x_array;
signal lane_x_data_reg  : lane_x_array;
signal lane_x_data_reg2 : lane_x_array;

signal data_t       : data_t_array;

signal jesd_buffer_fifo_wr_en         : std_logic;

-- ADC data packing signals for JMode 0 12-bit single channel
signal t0_t19_12bit_single            : std_logic_vector(255 downto 0);
signal t20_t39_12bit_single           : std_logic_vector(255 downto 0);

-- ADC data packing signals for JMode 2 12-bit single channel
signal t0_t9_12bit_dual               : std_logic_vector(255 downto 0);
signal t10_t19_12bit_dual             : std_logic_vector(255 downto 0);

signal t0_t31_8bit_chan               : std_logic_vector(255 downto 0);
signal t0_t15_8bit_chan_a             : std_logic_vector(127 downto 0);
signal t0_t15_8bit_chan_b             : std_logic_vector(127 downto 0);

signal t0_t7_15bit_chan_a             : std_logic_vector(127 downto 0);
signal t0_t7_15bit_chan_b             : std_logic_vector(127 downto 0);

signal t0_t7_16bit_decim16_chan_a       : std_logic_vector(127 downto 0);
signal t0_t7_16bit_decim16_chan_b       : std_logic_vector(127 downto 0);
signal t0_t7_16bit_decim8_chan_a       : std_logic_vector(127 downto 0);
signal t0_t7_16bit_decim8_chan_b       : std_logic_vector(127 downto 0);


signal adc_data_pre_jesd_buffer       : std_logic_vector(255 downto 0);
 
signal jesd_buffer_fifo_srst              : std_logic;
signal jesd_buffer_fifo_empty             : std_logic;
signal jesd_buffer_fifo_prog_empty        : std_logic;
signal jesd_buffer_fifo_rd_en             : std_logic;
signal jesd_buffer_fifo_data_valid        : std_logic;
signal jesd_buffer_fifo_data_valid_reg    : std_logic;
signal adc_data_post_jesd_buffer_dout     : std_logic_vector(255 downto 0);
signal adc_data_post_jesd_buffer_dout_reg : std_logic_vector(255 downto 0);
 
signal adc_data_valid_single_chan     : std_logic;
signal adc_data_single_chan           : std_logic_vector(255 downto 0);
signal adc_data_valid_dual_chan       : std_logic;
signal adc_data_dual_chan_a           : std_logic_vector(127 downto 0);
signal adc_data_dual_chan_b           : std_logic_vector(127 downto 0);
signal adc_data_single_temp           : std_logic_vector(255 downto 0);
signal adc_data_dual_temp             : std_logic_vector(255 downto 0);

signal adc_data_valid_15bit           : std_logic;
signal adc_data_valid_8bit            : std_logic;
signal adc_data_8bit                  : std_logic_vector(255 downto 0);
signal adc_data_15bit_chan_a          : std_logic_vector(127 downto 0);
signal adc_data_15bit_chan_b          : std_logic_vector(127 downto 0);

signal adc_pd_tvalid_toogle           : std_logic;

signal data_sel       : std_logic_vector(2 downto 0);
signal data_sel_reg   : std_logic_vector(2 downto 0);

attribute keep: boolean;
attribute keep of data_t: signal is true;
attribute keep of t0_t19_12bit_single: signal is true;
attribute keep of t20_t39_12bit_single: signal is true;
 

--attribute keep of data_t(1): signal is true;
--attribute keep of data_t(2): signal is true;
--attribute keep of data_t(3): signal is true;
--attribute keep of data_t(4): signal is true;
--attribute keep of data_t(5): signal is true;
--attribute keep of data_t(6): signal is true;
--attribute keep of data_t(7): signal is true;
--attribute keep of data_t(8): signal is true;
--attribute keep of data_t(9): signal is true;
--attribute keep of data_t(10): signal is true;
--attribute keep of data_t(11): signal is true;
--attribute keep of data_t(12): signal is true;
--attribute keep of data_t(13): signal is true;
--attribute keep of data_t(14): signal is true;
--attribute keep of data_t(15): signal is true;
--attribute keep of data_t(16): signal is true;
--attribute keep of data_t(17): signal is true;
--attribute keep of data_t(18): signal is true;
--attribute keep of data_t(19): signal is true;
--attribute keep of data_t(20): signal is true;
--attribute keep of data_t(21): signal is true;
--attribute keep of data_t(22): signal is true;
--attribute keep of data_t(23): signal is true;
--attribute keep of data_t(24): signal is true;
--attribute keep of data_t(25): signal is true;
--attribute keep of data_t(26): signal is true;
--attribute keep of data_t(27): signal is true;
--attribute keep of data_t(28): signal is true;
--attribute keep of data_t(29): signal is true;
--attribute keep of data_t(30): signal is true;
--attribute keep of data_t(31): signal is true;
--attribute keep of data_t(32): signal is true;
--attribute keep of data_t(33): signal is true;
--attribute keep of data_t(34): signal is true;
--attribute keep of data_t(35): signal is true;
--attribute keep of data_t(36): signal is true;
--attribute keep of data_t(37): signal is true;
--attribute keep of data_t(38): signal is true;
--attribute keep of data_t(39): signal is true;

COMPONENT jesd_buffer_fifo
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(255 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    valid : OUT STD_LOGIC;
    prog_empty  : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END COMPONENT;


begin

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
    src_in   => jmode,
    dest_clk => adc_sample_clk,
    dest_out => jmode_cdc
  );


   process(rx_core_clk) begin
       if(rising_edge(rx_core_clk)) then
           case jmode is
               
               --jmode 0
               when "00000" | "00101" =>
                   -- Break down the lanes.  In this mode, re-arrange the lanes
                   -- into the proper data time order
                   lane_x_data(0) <= s_axis_jesd_rx_pd_tdata(31 downto 0); 
                   lane_x_data(1) <= s_axis_jesd_rx_pd_tdata(159 downto 128); 
                   lane_x_data(2) <= s_axis_jesd_rx_pd_tdata(63 downto 32); 
                   lane_x_data(3) <= s_axis_jesd_rx_pd_tdata(191 downto 160); 
                   lane_x_data(4) <= s_axis_jesd_rx_pd_tdata(95 downto 64); 
                   lane_x_data(5) <= s_axis_jesd_rx_pd_tdata(223 downto 192); 
                   lane_x_data(6) <= s_axis_jesd_rx_pd_tdata(127 downto 96); 
                   lane_x_data(7) <= s_axis_jesd_rx_pd_tdata(255 downto 224);
               
               --jmode 2
               when others =>
                   lane_x_data(0) <= s_axis_jesd_rx_pd_tdata(31 downto 0); 
                   lane_x_data(1) <= s_axis_jesd_rx_pd_tdata(63 downto 32); 
                   lane_x_data(2) <= s_axis_jesd_rx_pd_tdata(95 downto 64); 
                   lane_x_data(3) <= s_axis_jesd_rx_pd_tdata(127 downto 96);
                    
                   lane_x_data(4) <= not s_axis_jesd_rx_pd_tdata(159 downto 128);  
                   lane_x_data(5) <= not s_axis_jesd_rx_pd_tdata(191 downto 160);
                   lane_x_data(6) <= not s_axis_jesd_rx_pd_tdata(223 downto 192);   
                   lane_x_data(7) <= not s_axis_jesd_rx_pd_tdata(255 downto 224);    
          
           end case;
           
           lane_x_data_reg  <= lane_x_data;
           lane_x_data_reg2 <= lane_x_data_reg;
       end if;
   end process;
        
   -- Pipeline delay of valid signal to match pipeline delay of data
   process(rx_core_clk) begin
       if(rising_edge(rx_core_clk)) then
           if(s_axis_jesd_rx_pd_tvalid = '0') then
               ch0_m_axis_rx_tdata_toggle    <= '0';
               s_axis_jesd_rx_pd_tvalid_reg1 <= '0';
               s_axis_jesd_rx_pd_tvalid_reg2 <= '0';
               s_axis_jesd_rx_pd_tvalid_reg3 <= '0';
               s_axis_jesd_rx_pd_tvalid_reg4 <= '0';
               s_axis_jesd_rx_pd_tvalid_reg5 <= '0';
               s_axis_jesd_rx_pd_tvalid_reg6 <= '0';
               s_axis_jesd_rx_pd_tvalid_reg7 <= '0';
               
               ch0_m_axis_rx_tdata_sel       <= "00";
               
           else
               
               case jmode is 
               
                   when "00000" | "00010" =>
                       ch0_m_axis_rx_tdata_toggle <= not ch0_m_axis_rx_tdata_toggle;
                                         
                       ch0_m_axis_rx_tdata_sel(1 downto 0)    <= "00";
                   when "10000" =>
                       if(s_axis_jesd_rx_pd_tvalid_reg3 = '1') then
                           ch0_m_axis_rx_tdata_sel    <= ch0_m_axis_rx_tdata_sel + '1';
                       end if;
                       
                       ch0_m_axis_rx_tdata_toggle <= '0';
                   when "01110" =>
                       if(s_axis_jesd_rx_pd_tvalid_reg3 = '1') then
                           ch0_m_axis_rx_tdata_sel(0)    <= not ch0_m_axis_rx_tdata_sel(0);
                       end if;
                       
                       ch0_m_axis_rx_tdata_sel(1)    <= '0';
                       ch0_m_axis_rx_tdata_toggle    <= '0';
                   
                   when others =>
                       ch0_m_axis_rx_tdata_toggle <= '0';
                       ch0_m_axis_rx_tdata_sel    <= "00";
                   
               end case;
               
               s_axis_jesd_rx_pd_tvalid_reg1 <= s_axis_jesd_rx_pd_tvalid;
               s_axis_jesd_rx_pd_tvalid_reg2 <= s_axis_jesd_rx_pd_tvalid_reg1;
               s_axis_jesd_rx_pd_tvalid_reg3 <= s_axis_jesd_rx_pd_tvalid_reg2;
               s_axis_jesd_rx_pd_tvalid_reg4 <= s_axis_jesd_rx_pd_tvalid_reg3;
               s_axis_jesd_rx_pd_tvalid_reg5 <= s_axis_jesd_rx_pd_tvalid_reg4;
               s_axis_jesd_rx_pd_tvalid_reg6 <= s_axis_jesd_rx_pd_tvalid_reg5;
               s_axis_jesd_rx_pd_tvalid_reg7 <= s_axis_jesd_rx_pd_tvalid_reg6;
           end if;       
       end if;
   end process;
   
   
process(rx_core_clk) begin

    if(rising_edge(rx_core_clk)) then
    
        case jmode is
            when "00000" | "00010" | "00101" | "00111" | "01001" | "01011" =>
                jesd_buffer_fifo_wr_en <= s_axis_jesd_rx_pd_tvalid_reg5;
            when "01110" =>
                jesd_buffer_fifo_wr_en <= s_axis_jesd_rx_pd_tvalid_reg5 and ch0_m_axis_rx_tdata_sel(0);
            when "10000" =>
                jesd_buffer_fifo_wr_en <= s_axis_jesd_rx_pd_tvalid_reg7 and not ch0_m_axis_rx_tdata_sel(1) and ch0_m_axis_rx_tdata_sel(0);
            when others =>
                jesd_buffer_fifo_wr_en <= '0';
        end case;
    end if;
end process;
   
   
process(rx_core_clk) begin
    if(rising_edge(rx_core_clk)) then
         if(ch0_m_axis_rx_tdata_toggle = '0' and s_axis_jesd_rx_pd_tvalid_reg2 = '1') then
             
             
             case jmode is 
             
             -- Jmode 0 - 12-Bit signle channel
             when "00000" =>
                 -- Break down data from t0 to t39
                 data_t(0)  <= lane_x_data_reg(0)(7 downto 0) & lane_x_data_reg(0)(15 downto 12) & X"0";
                 data_t(1)  <= lane_x_data_reg(1)(7 downto 0) & lane_x_data_reg(1)(15 downto 12) & X"0";
                 data_t(2)  <= lane_x_data_reg(2)(7 downto 0) & lane_x_data_reg(2)(15 downto 12) & X"0";
                 data_t(3)  <= lane_x_data_reg(3)(7 downto 0) & lane_x_data_reg(3)(15 downto 12) & X"0";
                 data_t(4)  <= lane_x_data_reg(4)(7 downto 0) & lane_x_data_reg(4)(15 downto 12) & X"0";
                 data_t(5)  <= lane_x_data_reg(5)(7 downto 0) & lane_x_data_reg(5)(15 downto 12) & X"0";
                 data_t(6)  <= lane_x_data_reg(6)(7 downto 0) & lane_x_data_reg(6)(15 downto 12) & X"0";
                 data_t(7)  <= lane_x_data_reg(7)(7 downto 0) & lane_x_data_reg(7)(15 downto 12) & X"0";
                 
                 data_t(8)  <= lane_x_data_reg(0)(11 downto 8) & lane_x_data_reg(0)(23 downto 16) & X"0";
                 data_t(9)  <= lane_x_data_reg(1)(11 downto 8) & lane_x_data_reg(1)(23 downto 16) & X"0";
                 data_t(10) <= lane_x_data_reg(2)(11 downto 8) & lane_x_data_reg(2)(23 downto 16) & X"0";
                 data_t(11) <= lane_x_data_reg(3)(11 downto 8) & lane_x_data_reg(3)(23 downto 16) & X"0";
                 data_t(12) <= lane_x_data_reg(4)(11 downto 8) & lane_x_data_reg(4)(23 downto 16) & X"0";
                 data_t(13) <= lane_x_data_reg(5)(11 downto 8) & lane_x_data_reg(5)(23 downto 16) & X"0";
                 data_t(14) <= lane_x_data_reg(6)(11 downto 8) & lane_x_data_reg(6)(23 downto 16) & X"0";
                 data_t(15) <= lane_x_data_reg(7)(11 downto 8) & lane_x_data_reg(7)(23 downto 16) & X"0";
                 
                 data_t(16) <= lane_x_data_reg(0)(31 downto 24) & lane_x_data(0)(7 downto 4) & X"0";
                 data_t(17) <= lane_x_data_reg(1)(31 downto 24) & lane_x_data(1)(7 downto 4) & X"0";
                 data_t(18) <= lane_x_data_reg(2)(31 downto 24) & lane_x_data(2)(7 downto 4) & X"0";
                 data_t(19) <= lane_x_data_reg(3)(31 downto 24) & lane_x_data(3)(7 downto 4) & X"0";
                 data_t(20) <= lane_x_data_reg(4)(31 downto 24) & lane_x_data(4)(7 downto 4) & X"0";
                 data_t(21) <= lane_x_data_reg(5)(31 downto 24) & lane_x_data(5)(7 downto 4) & X"0";
                 data_t(22) <= lane_x_data_reg(6)(31 downto 24) & lane_x_data(6)(7 downto 4) & X"0";
                 data_t(23) <= lane_x_data_reg(7)(31 downto 24) & lane_x_data(7)(7 downto 4) & X"0";
                 
                 data_t(24) <= lane_x_data(0)(3 downto 0) & lane_x_data(0)(15 downto 8) & X"0";
                 data_t(25) <= lane_x_data(1)(3 downto 0) & lane_x_data(1)(15 downto 8) & X"0";
                 data_t(26) <= lane_x_data(2)(3 downto 0) & lane_x_data(2)(15 downto 8) & X"0";
                 data_t(27) <= lane_x_data(3)(3 downto 0) & lane_x_data(3)(15 downto 8) & X"0";
                 data_t(28) <= lane_x_data(4)(3 downto 0) & lane_x_data(4)(15 downto 8) & X"0";
                 data_t(29) <= lane_x_data(5)(3 downto 0) & lane_x_data(5)(15 downto 8) & X"0";
                 data_t(30) <= lane_x_data(6)(3 downto 0) & lane_x_data(6)(15 downto 8) & X"0";
                 data_t(31) <= lane_x_data(7)(3 downto 0) & lane_x_data(7)(15 downto 8) & X"0";
                 
                 data_t(32) <= lane_x_data(0)(23 downto 16) & lane_x_data(0)(31 downto 28) & X"0";
                 data_t(33) <= lane_x_data(1)(23 downto 16) & lane_x_data(1)(31 downto 28) & X"0";
                 data_t(34) <= lane_x_data(2)(23 downto 16) & lane_x_data(2)(31 downto 28) & X"0";
                 data_t(35) <= lane_x_data(3)(23 downto 16) & lane_x_data(3)(31 downto 28) & X"0";
                 data_t(36) <= lane_x_data(4)(23 downto 16) & lane_x_data(4)(31 downto 28) & X"0";
                 data_t(37) <= lane_x_data(5)(23 downto 16) & lane_x_data(5)(31 downto 28) & X"0";
                 data_t(38) <= lane_x_data(6)(23 downto 16) & lane_x_data(6)(31 downto 28) & X"0";
                 data_t(39) <= lane_x_data(7)(23 downto 16) & lane_x_data(7)(31 downto 28) & X"0";
           
             -- Jmode 2 - 12-Bit Dual Channel
             when "00010" =>
                 -- Break down data from t0 to t19 for channel A
                 data_t(0)  <= lane_x_data_reg(0)(7 downto 0) & lane_x_data_reg(0)(15 downto 12) & X"0";
                 data_t(1)  <= lane_x_data_reg(1)(7 downto 0) & lane_x_data_reg(1)(15 downto 12) & X"0";
                 data_t(2)  <= lane_x_data_reg(2)(7 downto 0) & lane_x_data_reg(2)(15 downto 12) & X"0";
                 data_t(3)  <= lane_x_data_reg(3)(7 downto 0) & lane_x_data_reg(3)(15 downto 12) & X"0";
                 data_t(4)  <= lane_x_data_reg(0)(11 downto 8) & lane_x_data_reg(0)(23 downto 16) & X"0";
                 data_t(5)  <= lane_x_data_reg(1)(11 downto 8) & lane_x_data_reg(1)(23 downto 16) & X"0";
                 data_t(6)  <= lane_x_data_reg(2)(11 downto 8) & lane_x_data_reg(2)(23 downto 16) & X"0";
                 data_t(7)  <= lane_x_data_reg(3)(11 downto 8) & lane_x_data_reg(3)(23 downto 16) & X"0";
                 data_t(8)  <= lane_x_data_reg(0)(31 downto 24) & lane_x_data(0)(7 downto 4) & X"0";
                 data_t(9)  <= lane_x_data_reg(1)(31 downto 24) & lane_x_data(1)(7 downto 4) & X"0";
                 data_t(10) <= lane_x_data_reg(2)(31 downto 24) & lane_x_data(2)(7 downto 4) & X"0";
                 data_t(11) <= lane_x_data_reg(3)(31 downto 24) & lane_x_data(3)(7 downto 4) & X"0";
                 data_t(12) <= lane_x_data(0)(3 downto 0) & lane_x_data(0)(15 downto 8) & X"0";
                 data_t(13) <= lane_x_data(1)(3 downto 0) & lane_x_data(1)(15 downto 8) & X"0";
                 data_t(14) <= lane_x_data(2)(3 downto 0) & lane_x_data(2)(15 downto 8) & X"0";
                 data_t(15) <= lane_x_data(3)(3 downto 0) & lane_x_data(3)(15 downto 8) & X"0";
                 data_t(16) <= lane_x_data(0)(23 downto 16) & lane_x_data(0)(31 downto 28) & X"0";
                 data_t(17) <= lane_x_data(1)(23 downto 16) & lane_x_data(1)(31 downto 28) & X"0";
                 data_t(18) <= lane_x_data(2)(23 downto 16) & lane_x_data(2)(31 downto 28) & X"0";
                 data_t(19) <= lane_x_data(3)(23 downto 16) & lane_x_data(3)(31 downto 28) & X"0";
                 
                 -- Break down data from t20 to t39 for channel B
                 data_t(20) <= lane_x_data_reg(4)(7 downto 0) & lane_x_data_reg(4)(15 downto 12) & X"0";
                 data_t(21) <= lane_x_data_reg(5)(7 downto 0) & lane_x_data_reg(5)(15 downto 12) & X"0";
                 data_t(22) <= lane_x_data_reg(6)(7 downto 0) & lane_x_data_reg(6)(15 downto 12) & X"0";
                 data_t(23) <= lane_x_data_reg(7)(7 downto 0) & lane_x_data_reg(7)(15 downto 12) & X"0";
                 data_t(24) <= lane_x_data_reg(4)(11 downto 8) & lane_x_data_reg(4)(23 downto 16) & X"0";
                 data_t(25) <= lane_x_data_reg(5)(11 downto 8) & lane_x_data_reg(5)(23 downto 16) & X"0";
                 data_t(26) <= lane_x_data_reg(6)(11 downto 8) & lane_x_data_reg(6)(23 downto 16) & X"0";
                 data_t(27) <= lane_x_data_reg(7)(11 downto 8) & lane_x_data_reg(7)(23 downto 16) & X"0";
                 data_t(28) <= lane_x_data_reg(4)(31 downto 24) & lane_x_data(4)(7 downto 4) & X"0";
                 data_t(29) <= lane_x_data_reg(5)(31 downto 24) & lane_x_data(5)(7 downto 4) & X"0";
                 data_t(30) <= lane_x_data_reg(6)(31 downto 24) & lane_x_data(6)(7 downto 4) & X"0";
                 data_t(31) <= lane_x_data_reg(7)(31 downto 24) & lane_x_data(7)(7 downto 4) & X"0";
                 data_t(32) <= lane_x_data(4)(3 downto 0) & lane_x_data(4)(15 downto 8) & X"0";
                 data_t(33) <= lane_x_data(5)(3 downto 0) & lane_x_data(5)(15 downto 8) & X"0";
                 data_t(34) <= lane_x_data(6)(3 downto 0) & lane_x_data(6)(15 downto 8) & X"0";
                 data_t(35) <= lane_x_data(7)(3 downto 0) & lane_x_data(7)(15 downto 8) & X"0";
                 data_t(36) <= lane_x_data(4)(23 downto 16) & lane_x_data(4)(31 downto 28) & X"0";
                 data_t(37) <= lane_x_data(5)(23 downto 16) & lane_x_data(5)(31 downto 28) & X"0";
                 data_t(38) <= lane_x_data(6)(23 downto 16) & lane_x_data(6)(31 downto 28) & X"0";
                 data_t(39) <= lane_x_data(7)(23 downto 16) & lane_x_data(7)(31 downto 28) & X"0";
                 
             -- Jmode 5 - 8-Bit DES Data
             when "00101" =>
                 data_t(0)  <= X"00" & lane_x_data_reg2(0)(7 downto 0);
                 data_t(1)  <= X"00" & lane_x_data_reg2(1)(7 downto 0);
                 data_t(2)  <= X"00" & lane_x_data_reg2(2)(7 downto 0);
                 data_t(3)  <= X"00" & lane_x_data_reg2(3)(7 downto 0);
                 data_t(4)  <= X"00" & lane_x_data_reg2(4)(7 downto 0);
                 data_t(5)  <= X"00" & lane_x_data_reg2(5)(7 downto 0);
                 data_t(6)  <= X"00" & lane_x_data_reg2(6)(7 downto 0);
                 data_t(7)  <= X"00" & lane_x_data_reg2(7)(7 downto 0);
                 data_t(8)  <= X"00" & lane_x_data_reg2(0)(15 downto 8);
                 data_t(9)  <= X"00" & lane_x_data_reg2(1)(15 downto 8);
                 data_t(10) <= X"00" & lane_x_data_reg2(2)(15 downto 8);
                 data_t(11) <= X"00" & lane_x_data_reg2(3)(15 downto 8);
                 data_t(12) <= X"00" & lane_x_data_reg2(4)(15 downto 8);
                 data_t(13) <= X"00" & lane_x_data_reg2(5)(15 downto 8);
                 data_t(14) <= X"00" & lane_x_data_reg2(6)(15 downto 8);
                 data_t(15) <= X"00" & lane_x_data_reg2(7)(15 downto 8);
                 data_t(16) <= X"00" & lane_x_data_reg2(0)(23 downto 16);
                 data_t(17) <= X"00" & lane_x_data_reg2(1)(23 downto 16);
                 data_t(18) <= X"00" & lane_x_data_reg2(2)(23 downto 16);
                 data_t(19) <= X"00" & lane_x_data_reg2(3)(23 downto 16);
                 data_t(20) <= X"00" & lane_x_data_reg2(4)(23 downto 16);
                 data_t(21) <= X"00" & lane_x_data_reg2(5)(23 downto 16);
                 data_t(22) <= X"00" & lane_x_data_reg2(6)(23 downto 16);
                 data_t(23) <= X"00" & lane_x_data_reg2(7)(23 downto 16);
                 data_t(24) <= X"00" & lane_x_data_reg2(0)(31 downto 24);
                 data_t(25) <= X"00" & lane_x_data_reg2(1)(31 downto 24);
                 data_t(26) <= X"00" & lane_x_data_reg2(2)(31 downto 24);
                 data_t(27) <= X"00" & lane_x_data_reg2(3)(31 downto 24);
                 data_t(28) <= X"00" & lane_x_data_reg2(4)(31 downto 24);
                 data_t(29) <= X"00" & lane_x_data_reg2(5)(31 downto 24);
                 data_t(30) <= X"00" & lane_x_data_reg2(6)(31 downto 24);
                 data_t(31) <= X"00" & lane_x_data_reg2(7)(31 downto 24);
                 
             -- Jmode 7 - 8-Bit Dual Channel Data
             when "00111" =>
                 data_t(0)  <= X"00" & lane_x_data_reg2(0)(7 downto 0);
                 data_t(1)  <= X"00" & lane_x_data_reg2(1)(7 downto 0);
                 data_t(2)  <= X"00" & lane_x_data_reg2(2)(7 downto 0);
                 data_t(3)  <= X"00" & lane_x_data_reg2(3)(7 downto 0);
                 data_t(4)  <= X"00" & lane_x_data_reg2(0)(15 downto 8);
                 data_t(5)  <= X"00" & lane_x_data_reg2(1)(15 downto 8);
                 data_t(6)  <= X"00" & lane_x_data_reg2(2)(15 downto 8);
                 data_t(7)  <= X"00" & lane_x_data_reg2(3)(15 downto 8);
                 data_t(8)  <= X"00" & lane_x_data_reg2(0)(23 downto 16);
                 data_t(9)  <= X"00" & lane_x_data_reg2(1)(23 downto 16);
                 data_t(10) <= X"00" & lane_x_data_reg2(2)(23 downto 16);
                 data_t(11) <= X"00" & lane_x_data_reg2(3)(23 downto 16);
                 data_t(12) <= X"00" & lane_x_data_reg2(0)(31 downto 24);
                 data_t(13) <= X"00" & lane_x_data_reg2(1)(31 downto 24);
                 data_t(14) <= X"00" & lane_x_data_reg2(2)(31 downto 24);
                 data_t(15) <= X"00" & lane_x_data_reg2(3)(31 downto 24);
                 
                 
                 data_t(16) <= X"00" & lane_x_data_reg2(4)(7 downto 0);
                 data_t(17) <= X"00" & lane_x_data_reg2(5)(7 downto 0);
                 data_t(18) <= X"00" & lane_x_data_reg2(6)(7 downto 0);
                 data_t(19) <= X"00" & lane_x_data_reg2(7)(7 downto 0);
                 data_t(20) <= X"00" & lane_x_data_reg2(4)(15 downto 8);
                 data_t(21) <= X"00" & lane_x_data_reg2(5)(15 downto 8);
                 data_t(22) <= X"00" & lane_x_data_reg2(6)(15 downto 8);
                 data_t(23) <= X"00" & lane_x_data_reg2(7)(15 downto 8);
                 data_t(24) <= X"00" & lane_x_data_reg2(4)(23 downto 16);
                 data_t(25) <= X"00" & lane_x_data_reg2(5)(23 downto 16);
                 data_t(26) <= X"00" & lane_x_data_reg2(6)(23 downto 16);
                 data_t(27) <= X"00" & lane_x_data_reg2(7)(23 downto 16);
                 data_t(28) <= X"00" & lane_x_data_reg2(4)(31 downto 24);
                 data_t(29) <= X"00" & lane_x_data_reg2(5)(31 downto 24);
                 data_t(30) <= X"00" & lane_x_data_reg2(6)(31 downto 24);
                 data_t(31) <= X"00" & lane_x_data_reg2(7)(31 downto 24);
                 
             -- Jmode 9 - 15-Bit Dual Channel Real
             when "01001" =>
                 -- Break down data from t0 to t7 for channel A
                 data_t(0) <= lane_x_data_reg2(0)(7 downto 0)  & lane_x_data_reg2(0)(15 downto 8);
                 data_t(1) <= lane_x_data_reg2(1)(7 downto 0)  & lane_x_data_reg2(1)(15 downto 8);
                 data_t(2) <= lane_x_data_reg2(2)(7 downto 0)  & lane_x_data_reg2(2)(15 downto 8);
                 data_t(3) <= lane_x_data_reg2(3)(7 downto 0)  & lane_x_data_reg2(3)(15 downto 8);
                 data_t(4) <= lane_x_data_reg2(0)(23 downto 16) & lane_x_data_reg2(0)(31 downto 24);
                 data_t(5) <= lane_x_data_reg2(1)(23 downto 16) & lane_x_data_reg2(1)(31 downto 24);
                 data_t(6) <= lane_x_data_reg2(2)(23 downto 16) & lane_x_data_reg2(2)(31 downto 24);
                 data_t(7) <= lane_x_data_reg2(3)(23 downto 16) & lane_x_data_reg2(3)(31 downto 24);
                 
                 -- Break down data from t0 to t7 for channel B
                 data_t(20) <= lane_x_data_reg2(4)(7 downto 0)  & lane_x_data_reg2(4)(15 downto 8);
                 data_t(21) <= lane_x_data_reg2(5)(7 downto 0)  & lane_x_data_reg2(5)(15 downto 8);
                 data_t(22) <= lane_x_data_reg2(6)(7 downto 0)  & lane_x_data_reg2(6)(15 downto 8);
                 data_t(23) <= lane_x_data_reg2(7)(7 downto 0)  & lane_x_data_reg2(7)(15 downto 8);
                 data_t(24) <= lane_x_data_reg2(4)(23 downto 16) & lane_x_data_reg2(4)(31 downto 24);
                 data_t(25) <= lane_x_data_reg2(5)(23 downto 16) & lane_x_data_reg2(5)(31 downto 24);
                 data_t(26) <= lane_x_data_reg2(6)(23 downto 16) & lane_x_data_reg2(6)(31 downto 24);
                 data_t(27) <= lane_x_data_reg2(7)(23 downto 16) & lane_x_data_reg2(7)(31 downto 24);

                 data_t(8)  <= (others => '0');
                 data_t(9)  <= (others => '0');
                 data_t(10) <= (others => '0');
                 data_t(11) <= (others => '0');
                 data_t(12) <= (others => '0');
                 data_t(13) <= (others => '0');
                 data_t(14) <= (others => '0');
                 data_t(15) <= (others => '0');
                 data_t(16) <= (others => '0');
                 data_t(17) <= (others => '0');
                 data_t(18) <= (others => '0');
                 data_t(19) <= (others => '0');
             
                 data_t(28) <= (others => '0');
                 data_t(29) <= (others => '0');
                 data_t(30) <= (others => '0');
                 data_t(31) <= (others => '0');
                 data_t(32) <= (others => '0');
                 data_t(33) <= (others => '0');
                 data_t(34) <= (others => '0');
                 data_t(35) <= (others => '0');
                 data_t(36) <= (others => '0');
                 data_t(37) <= (others => '0');
                 data_t(38) <= (others => '0');
                 data_t(39) <= (others => '0'); 
             
             -- Jmode 11 - 15-Bit Dual Channel I/Q
             when "01011" =>
                 -- Break down data from t0 to t7 for channel A
                 data_t(0) <= lane_x_data_reg2(0)(7 downto 0)  & lane_x_data_reg2(0)(15 downto 8);
                 data_t(1) <= lane_x_data_reg2(2)(7 downto 0)  & lane_x_data_reg2(2)(15 downto 8);
                 data_t(2) <= lane_x_data_reg2(1)(7 downto 0)  & lane_x_data_reg2(1)(15 downto 8);
                 data_t(3) <= lane_x_data_reg2(3)(7 downto 0)  & lane_x_data_reg2(3)(15 downto 8);
                 data_t(4) <= lane_x_data_reg2(0)(23 downto 16) & lane_x_data_reg2(0)(31 downto 24);
                 data_t(5) <= lane_x_data_reg2(2)(23 downto 16) & lane_x_data_reg2(2)(31 downto 24);
                 data_t(6) <= lane_x_data_reg2(1)(23 downto 16) & lane_x_data_reg2(1)(31 downto 24);
                 data_t(7) <= lane_x_data_reg2(3)(23 downto 16) & lane_x_data_reg2(3)(31 downto 24);
                 
                 -- Break down data from t0 to t7 for channel B
                 data_t(20) <= lane_x_data_reg2(4)(7 downto 0)  & lane_x_data_reg2(4)(15 downto 8);
                 data_t(21) <= lane_x_data_reg2(6)(7 downto 0)  & lane_x_data_reg2(6)(15 downto 8);
                 data_t(22) <= lane_x_data_reg2(5)(7 downto 0)  & lane_x_data_reg2(5)(15 downto 8);
                 data_t(23) <= lane_x_data_reg2(7)(7 downto 0)  & lane_x_data_reg2(7)(15 downto 8);
                 data_t(24) <= lane_x_data_reg2(4)(23 downto 16) & lane_x_data_reg2(4)(31 downto 24);
                 data_t(25) <= lane_x_data_reg2(6)(23 downto 16) & lane_x_data_reg2(6)(31 downto 24);
                 data_t(26) <= lane_x_data_reg2(5)(23 downto 16) & lane_x_data_reg2(5)(31 downto 24);
                 data_t(27) <= lane_x_data_reg2(7)(23 downto 16) & lane_x_data_reg2(7)(31 downto 24);

                 data_t(8)  <= (others => '0');
                 data_t(9)  <= (others => '0');
                 data_t(10) <= (others => '0');
                 data_t(11) <= (others => '0');
                 data_t(12) <= (others => '0');
                 data_t(13) <= (others => '0');
                 data_t(14) <= (others => '0');
                 data_t(15) <= (others => '0');
                 data_t(16) <= (others => '0');
                 data_t(17) <= (others => '0');
                 data_t(18) <= (others => '0');
                 data_t(19) <= (others => '0');
             
                 data_t(28) <= (others => '0');
                 data_t(29) <= (others => '0');
                 data_t(30) <= (others => '0');
                 data_t(31) <= (others => '0');
                 data_t(32) <= (others => '0');
                 data_t(33) <= (others => '0');
                 data_t(34) <= (others => '0');
                 data_t(35) <= (others => '0');
                 data_t(36) <= (others => '0');
                 data_t(37) <= (others => '0');
                 data_t(38) <= (others => '0');
                 data_t(39) <= (others => '0');
                 
             when "01110" =>
                 if(ch0_m_axis_rx_tdata_sel = "00") then
                     data_t(0) <= lane_x_data_reg2(0)(7 downto 0)    & lane_x_data_reg2(0)(15 downto 8);    -- IA T0
                     data_t(1) <= lane_x_data_reg2(1)(7 downto 0)    & lane_x_data_reg2(1)(15 downto 8);    -- QA T0
                     data_t(2) <= lane_x_data_reg2(0)(23 downto 16)  & lane_x_data_reg2(0)(31 downto 24);   -- IA T1
                     data_t(3) <= lane_x_data_reg2(1)(23 downto 16)  & lane_x_data_reg2(1)(31 downto 24);   -- QA T1
                     
                     data_t(20) <= lane_x_data_reg2(4)(7 downto 0)    & lane_x_data_reg2(4)(15 downto 8);   -- IB T0
                     data_t(21) <= lane_x_data_reg2(5)(7 downto 0)    & lane_x_data_reg2(5)(15 downto 8);   -- QB T0
                     data_t(22) <= lane_x_data_reg2(4)(23 downto 16)  & lane_x_data_reg2(4)(31 downto 24);  -- IB T1
                     data_t(23) <= lane_x_data_reg2(5)(23 downto 16)  & lane_x_data_reg2(5)(31 downto 24);  -- QB T1
                 end if;
                 
                 if(ch0_m_axis_rx_tdata_sel = "01") then
                     data_t(4) <= lane_x_data_reg2(0)(7 downto 0)    & lane_x_data_reg2(0)(15 downto 8);    -- IA T2
                     data_t(5) <= lane_x_data_reg2(1)(7 downto 0)    & lane_x_data_reg2(1)(15 downto 8);    -- QA T2
                     data_t(6) <= lane_x_data_reg2(0)(23 downto 16)  & lane_x_data_reg2(0)(31 downto 24);   -- IA T3
                     data_t(7) <= lane_x_data_reg2(1)(23 downto 16)  & lane_x_data_reg2(1)(31 downto 24);   -- QA T3
                     
                     data_t(24) <= lane_x_data_reg2(4)(7 downto 0)    & lane_x_data_reg2(4)(15 downto 8);   -- IB T2
                     data_t(25) <= lane_x_data_reg2(5)(7 downto 0)    & lane_x_data_reg2(5)(15 downto 8);   -- QB T2
                     data_t(26) <= lane_x_data_reg2(4)(23 downto 16)  & lane_x_data_reg2(4)(31 downto 24);  -- IB T3
                     data_t(27) <= lane_x_data_reg2(5)(23 downto 16)  & lane_x_data_reg2(5)(31 downto 24);  -- QB T3
                 end if;
                 
                 
             when "10000" =>
                 
                 if(ch0_m_axis_rx_tdata_sel = "00") then
                     data_t(0) <= lane_x_data_reg2(0)(7 downto 0)  & lane_x_data_reg2(0)(15 downto 8);     -- IA T0   
                     data_t(1) <= lane_x_data_reg2(0)(23 downto 16)  & lane_x_data_reg2(0)(31 downto 24);  -- QA T0
                     
                     data_t(20) <= lane_x_data_reg2(4)(7 downto 0)  & lane_x_data_reg2(4)(15 downto 8);    -- IB T0
                     data_t(21) <= lane_x_data_reg2(4)(23 downto 16)  & lane_x_data_reg2(4)(31 downto 24); -- QB T0
                 end if;    
                     
                 if(ch0_m_axis_rx_tdata_sel = "01") then
                     data_t(2) <= lane_x_data_reg2(0)(7 downto 0)  & lane_x_data_reg2(0)(15 downto 8);     -- IA T1
                     data_t(3) <= lane_x_data_reg2(0)(23 downto 16)  & lane_x_data_reg2(0)(31 downto 24);  -- QA T1
                     
                     data_t(22) <= lane_x_data_reg2(4)(7 downto 0)  & lane_x_data_reg2(4)(15 downto 8);    -- IB T1
                     data_t(23) <= lane_x_data_reg2(4)(23 downto 16)  & lane_x_data_reg2(4)(31 downto 24); -- QB T1
                 end if;
                     
                 if(ch0_m_axis_rx_tdata_sel = "10") then    
                     data_t(4) <= lane_x_data_reg2(0)(7 downto 0)  & lane_x_data_reg2(0)(15 downto 8);      -- IA T2
                     data_t(5) <= lane_x_data_reg2(0)(23 downto 16)  & lane_x_data_reg2(0)(31 downto 24);   -- QA T2
                     
                     data_t(24) <= lane_x_data_reg2(4)(7 downto 0)  & lane_x_data_reg2(4)(15 downto 8);     -- IB T2
                     data_t(25) <= lane_x_data_reg2(4)(23 downto 16)  & lane_x_data_reg2(4)(31 downto 24);  -- QB T2
                 end if;
                     
                 if(ch0_m_axis_rx_tdata_sel = "11") then
                     data_t(6) <= lane_x_data_reg2(0)(7 downto 0)  & lane_x_data_reg2(0)(15 downto 8);      -- IA T3
                     data_t(7) <= lane_x_data_reg2(0)(23 downto 16)  & lane_x_data_reg2(0)(31 downto 24);   -- QA T3
                                                                                        
                     data_t(26) <= lane_x_data_reg2(4)(7 downto 0)  & lane_x_data_reg2(4)(15 downto 8);     -- IB T3
                     data_t(27) <= lane_x_data_reg2(4)(23 downto 16)  & lane_x_data_reg2(4)(31 downto 24);  -- QB T3
                 end if;
                 
             when others =>
             
             end case;
             
         end if; 
     end if;
end process;
   
   -- Sort data into the correct time order prior to writing to JESD Buffer Fifo 
   jmode0_single : for i in 0 to 20 generate
   
      sort_data: if i < 20 generate
          process(rx_core_clk) begin
               if(rising_edge(rx_core_clk)) then
                   if(jmode = "00000") then
                       if(s_axis_jesd_rx_pd_tvalid_reg3 = '0') then
                           t0_t19_12bit_single(((i+1)*12-1) downto i*12 ) <= (others => '0');
                           t20_t39_12bit_single(((i+1)*12-1) downto i*12 ) <= (others => '0');
                       else
                           
                           if(ch0_m_axis_rx_tdata_toggle = '1') then
                               t0_t19_12bit_single(((i+1)*12-1) downto i*12 ) <= data_t(i)(15 downto 4);
                           end if;
                           
                           if(ch0_m_axis_rx_tdata_toggle = '0') then
                               t20_t39_12bit_single(((i+1)*12-1) downto i*12 ) <= data_t(i+20)(15 downto 4);
                           end if;
                           
                       end if;
                   else
                       t0_t19_12bit_single(((i+1)*12-1) downto i*12 )  <= (others => '0');
                       t20_t39_12bit_single(((i+1)*12-1) downto i*12 ) <= (others => '0');
                   end if;
               end if;
          end process;
      end generate;
      
       pad_zeros: if i = 20 generate
           t0_t19_12bit_single(255 downto 240)  <= X"0000";
           t20_t39_12bit_single(255 downto 240) <= X"0000";
       end generate;
   end generate;
   
   -- Sort data into the correct time order prior to writing to JESD Buffer Fifo
   jmode2_dual : for i in 0 to 10 generate
       
      sort_data: if i < 10 generate   
   
          process(rx_core_clk) begin
               if(rising_edge(rx_core_clk)) then
                   if(jmode = "00010") then
                       if(s_axis_jesd_rx_pd_tvalid_reg3 = '0') then
                           t0_t9_12bit_dual(((i+1)*12-1) downto i*12 )                  <= (others => '0');
                           t0_t9_12bit_dual((((i+1)*12-1) + 128) downto (i*12 + 128) )  <= (others => '0');
                           t10_t19_12bit_dual(((i+1)*12-1) downto i*12 )                <= (others => '0');
                           t10_t19_12bit_dual((((i+1)*12-1) + 128) downto (i*12 + 128)) <= (others => '0');
                       else
                           
                           if(ch0_m_axis_rx_tdata_toggle = '1') then
                               -- Channel A t0-t9
                               t0_t9_12bit_dual(((i+1)*12-1) downto i*12 )                 <= data_t(i)(15 downto 4);
                               -- Channel B t0-t9
                               t0_t9_12bit_dual((((i+1)*12-1) + 128) downto (i*12 + 128) ) <= data_t(i+20)(15 downto 4);
                           end if;
                           
                           if(ch0_m_axis_rx_tdata_toggle = '0') then
                               -- Channel A t10-t19
                               t10_t19_12bit_dual(((i+1)*12-1) downto i*12 ) <= data_t(i+10)(15 downto 4);
                               -- Channel B t10-t19
                               t10_t19_12bit_dual((((i+1)*12-1) + 128) downto (i*12 + 128)) <= data_t(i+30)(15 downto 4);
                           end if;
                       end if;
                   else
                       t0_t9_12bit_dual(((i+1)*12-1) downto i*12 )                  <= (others => '0');
                       t0_t9_12bit_dual((((i+1)*12-1) + 128) downto (i*12 + 128) )  <= (others => '0'); 
                       t10_t19_12bit_dual(((i+1)*12-1) downto i*12 )                <= (others => '0');
                       t10_t19_12bit_dual((((i+1)*12-1) + 128) downto (i*12 + 128)) <= (others => '0');
                   end if;
               end if;
           end process;
       end generate;  
       
       pad_zeros: if i = 10 generate
           t0_t9_12bit_dual(255 downto 248)   <= X"00";
           t0_t9_12bit_dual(127 downto 120)   <= X"00";
           t10_t19_12bit_dual(255 downto 248) <= X"00";
           t10_t19_12bit_dual(127 downto 120) <= X"00";
       end generate;
   end generate;
   
   -- Sort data into the correct time order prior to writing to JESD Buffer Fifo
   jmode5_8bit : for i in 0 to 31 generate
       process(rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if(jmode = "00101") then
                   if(s_axis_jesd_rx_pd_tvalid_reg3 = '0') then
                       t0_t31_8bit_chan((((i+1)*8)-1) downto i*8) <= (others => '0');
                   else
                       -- Channel A t0-t31
                       t0_t31_8bit_chan((((i+1)*8)-1) downto i*8) <= data_t(i)(7 downto 0);
                        
                   end if;
               else
                   t0_t31_8bit_chan((((i+1)*8)-1) downto i*8) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   -- Sort data into the correct time order prior to writing to JESD Buffer Fifo
   jmode7_8bit_dual_chan : for i in 0 to 15 generate
       process(rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if(jmode = "00111") then
                   if(s_axis_jesd_rx_pd_tvalid_reg3 = '0') then
                       t0_t15_8bit_chan_a((((i+1)*8)-1) downto i*8) <= (others => '0');
                       t0_t15_8bit_chan_b((((i+1)*8)-1) downto i*8) <= (others => '0');
                   else
                       -- Channel A t0-t15
                       -- Channel B t0-t15
                       t0_t15_8bit_chan_a((((i+1)*8)-1) downto i*8) <= data_t(i)(7 downto 0);
                       t0_t15_8bit_chan_b((((i+1)*8)-1) downto i*8) <= data_t(i+16)(7 downto 0);
                        
                   end if;
               else
                   t0_t15_8bit_chan_a((((i+1)*8)-1) downto i*8) <= (others => '0');
                   t0_t15_8bit_chan_b((((i+1)*8)-1) downto i*8) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   -- Sort data into the correct time order prior to writing to JESD Buffer Fifo
   jmode9_or_11_15bit : for i in 0 to 7 generate
       process(rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if(jmode = "01001" or jmode = "01011") then
                   if(s_axis_jesd_rx_pd_tvalid_reg3 = '0') then
                       t0_t7_15bit_chan_a((((i+1)*16)-1) downto i*16) <= (others => '0');
                       t0_t7_15bit_chan_b((((i+1)*16)-1) downto i*16) <= (others => '0');
                   else
                       -- Channel A t0-t7
                       t0_t7_15bit_chan_a((((i+1)*16)-1) downto i*16) <= data_t(i)(15 downto 0);
                       
                       -- Channel B t0-t7
                       t0_t7_15bit_chan_b((((i+1)*16)-1) downto i*16) <= data_t(i+20)(15 downto 0);
                        
                   end if;
               else
                   t0_t7_15bit_chan_a((((i+1)*16)-1) downto i*16) <= (others => '0');
                   t0_t7_15bit_chan_b((((i+1)*16)-1) downto i*16) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   -- Sort data into the correct time order prior to writing to JESD Buffer Fifo
   jmode_14_16bit_decimation8 : for i in 0 to 7 generate
       process(rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if(jmode = "01110") then
                   if(s_axis_jesd_rx_pd_tvalid_reg5 = '0') then
                       t0_t7_16bit_decim8_chan_a((((i+1)*16)-1) downto i*16) <= (others => '0');
                       t0_t7_16bit_decim8_chan_b((((i+1)*16)-1) downto i*16) <= (others => '0');
                   else
                   
                       
                       if(ch0_m_axis_rx_tdata_sel(0) = '0') then
                           -- Channel A t0-t7
                           t0_t7_16bit_decim8_chan_a((((i+1)*16)-1) downto i*16) <= data_t(i)(15 downto 0);
                           
                           -- Channel B t0-t7
                           t0_t7_16bit_decim8_chan_b((((i+1)*16)-1) downto i*16) <= data_t(i+20)(15 downto 0);
                       end if;
                        
                   end if;
               else
                   t0_t7_16bit_decim8_chan_a((((i+1)*16)-1) downto i*16) <= (others => '0');
                   t0_t7_16bit_decim8_chan_b((((i+1)*16)-1) downto i*16) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   -- Sort data into the correct time order prior to writing to JESD Buffer Fifo
   jmode_16_16bit_decimation16 : for i in 0 to 7 generate
       process(rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if(jmode = "10000") then
                   if(s_axis_jesd_rx_pd_tvalid_reg7 = '0') then
                       t0_t7_16bit_decim16_chan_a((((i+1)*16)-1) downto i*16) <= (others => '0');
                       t0_t7_16bit_decim16_chan_b((((i+1)*16)-1) downto i*16) <= (others => '0');
                   else
                   
                       
                       if(ch0_m_axis_rx_tdata_sel = "00") then
                           -- Channel A t0-t7
                           t0_t7_16bit_decim16_chan_a((((i+1)*16)-1) downto i*16) <= data_t(i)(15 downto 0);
                           
                           -- Channel B t0-t7
                           t0_t7_16bit_decim16_chan_b((((i+1)*16)-1) downto i*16) <= data_t(i+20)(15 downto 0);
                       end if;
                        
                   end if;
               else
                   t0_t7_16bit_decim16_chan_a((((i+1)*16)-1) downto i*16) <= (others => '0');
                   t0_t7_16bit_decim16_chan_b((((i+1)*16)-1) downto i*16) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   -- Pre Fifo mux according to JMODE
   process(rx_core_clk) begin
       if(rising_edge(rx_core_clk)) then                                   
       
           jesd_buffer_fifo_srst <= jesd_buffer_fifo_rst;
       
           if(s_axis_jesd_rx_pd_tvalid_reg5 = '0') then
               adc_data_pre_jesd_buffer_tvalid          <= '0';
               adc_data_pre_jesd_buffer                 <= (others => '0');
           else
               
               adc_data_pre_jesd_buffer_tvalid          <= ch0_m_axis_rx_tdata_toggle;
               
                
               case jmode is

                   when "00000" =>               
                       if(ch0_m_axis_rx_tdata_toggle = '1') then
                           
                           adc_data_pre_jesd_buffer <= t0_t19_12bit_single;
                       else
                           adc_data_pre_jesd_buffer <= t20_t39_12bit_single;
                       end if;
                       
                   when "00010" =>
                       if(ch0_m_axis_rx_tdata_toggle = '1') then
                           adc_data_pre_jesd_buffer <= t0_t9_12bit_dual;
                       else
                           adc_data_pre_jesd_buffer <= t10_t19_12bit_dual;
                       end if;
                       
                   when "00101" =>
                   
                       adc_data_pre_jesd_buffer <= t0_t31_8bit_chan;
                       
                   when "00111" => 
                   
                       adc_data_pre_jesd_buffer(127 downto 0)   <= t0_t15_8bit_chan_a;
                       adc_data_pre_jesd_buffer(255 downto 128) <= t0_t15_8bit_chan_b;
                   
                   when "01001" ! "01011" =>
                       adc_data_pre_jesd_buffer(127 downto 0)   <= t0_t7_15bit_chan_a;
                       adc_data_pre_jesd_buffer(255 downto 128) <= t0_t7_15bit_chan_b;
                   
                   when "01110" =>
                       adc_data_pre_jesd_buffer(127 downto 0)   <= t0_t7_16bit_decim8_chan_a;
                       adc_data_pre_jesd_buffer(255 downto 128) <= t0_t7_16bit_decim8_chan_b;
                   when "10000" => 
                       adc_data_pre_jesd_buffer(127 downto 0)   <= t0_t7_16bit_decim16_chan_a;
                       adc_data_pre_jesd_buffer(255 downto 128) <= t0_t7_16bit_decim16_chan_b;
                   when others => 
                       adc_data_pre_jesd_buffer <= (others => '0');    
               
               end case;
               
           end if;       
       end if;
   end process;

   
   -- Pentek applications expect 16-bit wide data samples on boundaries of 128,256,512
   -- dma packet sizes. ADC12DJ3200 in 12-bit mode requires a special relationship 
   -- between rx_core_clk and adc_sample_clock in order to achieve this. 
   -- In Jmode-0, 12-bit single channel operation, ADC12DJ3200 provides 20 12-bit 
   -- samples at 320 Mhz. 
   -- In Jmode-2, 2-bit dual channel, ADC12DJ3200 provides 10 12-bit samples per 
   -- channel at 320 Mhz.
   -- In order to be compatible with Pentek applications that expect 16-bit packed
   -- data, adc_sample_clk must be 25 percent faster(400 Mhz), than rx_core_clk in order
   -- pack 12-bit data into 16-bit words successfully without data loss.  
    
   jesd_buffer_fifo_inst: jesd_buffer_fifo
   port map
   (
        rst         => jesd_buffer_fifo_srst,                
        wr_clk      => rx_core_clk,
        rd_clk      => adc_sample_clk,
        din         => adc_data_pre_jesd_buffer, 
        wr_en       => jesd_buffer_fifo_wr_en,
        rd_en       => jesd_buffer_fifo_rd_en,
        dout        => adc_data_post_jesd_buffer_dout, 
        full        => open,
        empty       => jesd_buffer_fifo_empty,
        valid       => jesd_buffer_fifo_data_valid,
        prog_empty  => jesd_buffer_fifo_prog_empty,
        wr_rst_busy => open,
        rd_rst_busy => open
   );
   
   process(adc_sample_clk) begin
       if(rising_edge(adc_sample_clk)) then
           if(jesd_buffer_fifo_empty = '1') then
               curr_state <= RESET;
           else
               curr_state <= next_state;
           end if;
       end if;
   
   end process;
   
   -- State Machine process
   process(curr_state, jesd_buffer_fifo_empty, jesd_buffer_fifo_prog_empty, jesd_buffer_fifo_data_valid) begin
       case curr_state is
       
           when RESET   =>
               
               if((jmode_cdc = "00000" or jmode_cdc = "00010") and jesd_buffer_fifo_empty = '0') then
                   next_state <= STATE_12BIT_0;
               elsif(jesd_buffer_fifo_empty = '0') then
                   next_state <= STATE_16BIT_ALL;
               elsif(jesd_buffer_fifo_empty = '1') then
                   next_state <= RESET;
               else
                   next_state <= RESET;
               end if;
               
           -- STATE_12BIT_0 to STATE_12BIT_4 is used to control packing of
           -- 12-bit data into 16-bit fields
           when STATE_12BIT_0 =>
               
               if(jesd_buffer_fifo_data_valid = '1') then
                   next_state <= STATE_12BIT_1;
               elsif(jesd_buffer_fifo_empty = '1') then
                   next_state <= RESET;
               else
                   next_state <= STATE_12BIT_0;
               end if; 
           when STATE_12BIT_1 =>
               
               if(jesd_buffer_fifo_data_valid = '1') then
                   next_state <= STATE_12BIT_2;
               elsif(jesd_buffer_fifo_empty = '1') then
                   next_state <= RESET;
               else
                   next_state <= STATE_12BIT_1;
               end if;
           when STATE_12BIT_2 =>
               
               if(jesd_buffer_fifo_data_valid = '1') then
                   next_state <= STATE_12BIT_3;
               elsif(jesd_buffer_fifo_empty = '1') then
                   next_state <= RESET;
               else
                   next_state <= STATE_12BIT_2;
               end if;
           when STATE_12BIT_3 =>
               
               if(jesd_buffer_fifo_data_valid = '1') then
                   next_state <= STATE_12BIT_4;
               elsif(jesd_buffer_fifo_empty = '1') then
                   next_state <= RESET;
               else
                   next_state <= STATE_12BIT_3;
               end if;
           when STATE_12BIT_4 =>
               
               if(jesd_buffer_fifo_empty = '1') then
                   next_state <= RESET;
               else
                   next_state <= STATE_12BIT_0;
               end if;
            
           -- Go to this state for all other modes
           WHEN STATE_16BIT_ALL =>
               if(jesd_buffer_fifo_empty = '1') then
                   next_state <= RESET;
               else
                   next_state <= STATE_16BIT_ALL;
               end if;
             
           when others =>
               next_state <= RESET;      
           
       end case;
       
   end process;
   
   -- Control data_sel and jesd_buffer_fifo_rd_en
   process(adc_sample_clk) begin
       if(rising_edge(adc_sample_clk)) then
           case curr_state is
           
           when RESET => 
               data_sel <= "000";
               jesd_buffer_fifo_rd_en <= '0';
               
           when STATE_12BIT_0 =>
               data_sel <= "000";
               jesd_buffer_fifo_rd_en <= not jesd_buffer_fifo_prog_empty;
            
           when STATE_12BIT_1 =>
               data_sel <= "001";
               jesd_buffer_fifo_rd_en <= '0';
           
           when STATE_12BIT_2 =>
               data_sel <= "010";
               jesd_buffer_fifo_rd_en <= not jesd_buffer_fifo_prog_empty;
           
           when STATE_12BIT_3 =>
               data_sel <= "011";
               jesd_buffer_fifo_rd_en <= not jesd_buffer_fifo_prog_empty;
           
           when STATE_12BIT_4 =>
               data_sel <= "100";
               jesd_buffer_fifo_rd_en <= not jesd_buffer_fifo_prog_empty;
               
           when STATE_16BIT_ALL =>
               data_sel <= "000";
               jesd_buffer_fifo_rd_en <= not jesd_buffer_fifo_prog_empty;
           
           when others =>
               data_sel               <= "000";
               jesd_buffer_fifo_rd_en <= '0';
           
           end case; 
       end if;
   
   end process;
   
   -- Process to pack 12-bit data into 16-bit time ordered data 
   process(adc_sample_clk) begin
       if(rising_edge(adc_sample_clk)) then
                                  
           if(s_axis_jesd_rx_pd_tvalid_reg5 = '0') then
               
               adc_data_valid_single_chan <= '0';
               adc_data_valid_dual_chan   <= '0';
               adc_data_valid_15bit       <= '0';
               adc_data_single_chan       <= (others => '0');
               adc_data_single_temp       <= (others => '0');
               adc_data_dual_chan_a       <= (others => '0');
               adc_data_dual_chan_b       <= (others => '0');
               adc_data_dual_temp         <= (others => '0');
               
               adc_data_post_jesd_buffer_dout_reg <= (others => '0');
                        
           else
               jesd_buffer_fifo_data_valid_reg    <= jesd_buffer_fifo_data_valid;
               adc_data_post_jesd_buffer_dout_reg <= adc_data_post_jesd_buffer_dout;
               data_sel_reg                       <= data_sel;
           
               -- Jmode-0 Pack 12-bit into 16 bit words in single channel
               if(jmode_cdc = "00000") then
               
                   case data_sel is 
                           
                   when "000" =>
                       
                       if(jesd_buffer_fifo_data_valid_reg = '1') then
                           adc_data_single_chan(15 downto 0)    <= adc_data_post_jesd_buffer_dout_reg(11 downto 0)    & X"0";
                           adc_data_single_chan(31 downto 16)   <= adc_data_post_jesd_buffer_dout_reg(23 downto 12)   & X"0";
                           adc_data_single_chan(47 downto 32)   <= adc_data_post_jesd_buffer_dout_reg(35 downto 24)   & X"0";
                           adc_data_single_chan(63 downto 48)   <= adc_data_post_jesd_buffer_dout_reg(47 downto 36)   & X"0";
                           adc_data_single_chan(79 downto 64)   <= adc_data_post_jesd_buffer_dout_reg(59 downto 48)   & X"0";
                           adc_data_single_chan(95 downto 80)   <= adc_data_post_jesd_buffer_dout_reg(71 downto 60)   & X"0";
                           adc_data_single_chan(111 downto 96)  <= adc_data_post_jesd_buffer_dout_reg(83 downto 72)   & X"0";
                           adc_data_single_chan(127 downto 112) <= adc_data_post_jesd_buffer_dout_reg(95 downto 84)   & X"0";
                           adc_data_single_chan(143 downto 128) <= adc_data_post_jesd_buffer_dout_reg(107 downto 96)  & X"0";
                           adc_data_single_chan(159 downto 144) <= adc_data_post_jesd_buffer_dout_reg(119 downto 108) & X"0";
                           adc_data_single_chan(175 downto 160) <= adc_data_post_jesd_buffer_dout_reg(131 downto 120) & X"0";
                           adc_data_single_chan(191 downto 176) <= adc_data_post_jesd_buffer_dout_reg(143 downto 132) & X"0";
                           adc_data_single_chan(207 downto 192) <= adc_data_post_jesd_buffer_dout_reg(155 downto 144) & X"0";
                           adc_data_single_chan(223 downto 208) <= adc_data_post_jesd_buffer_dout_reg(167 downto 156) & X"0";
                           adc_data_single_chan(239 downto 224) <= adc_data_post_jesd_buffer_dout_reg(179 downto 168) & X"0";
                           adc_data_single_chan(255 downto 240) <= adc_data_post_jesd_buffer_dout_reg(191 downto 180) & X"0";
                           
                           adc_data_single_temp(47 downto 0)   <= adc_data_post_jesd_buffer_dout_reg(239 downto 192);
                           adc_data_single_temp(255 downto 48) <= (others => '0');
                           
                           adc_data_valid_single_chan <= '1';
                           
                       end if;
                   
                       
                       
                   when "001" =>
                                
                       if(jesd_buffer_fifo_data_valid_reg = '1') then
                           adc_data_single_chan(15 downto 0)    <= adc_data_single_temp(11 downto 0)    & X"0";
                           adc_data_single_chan(31 downto 16)   <= adc_data_single_temp(23 downto 12)   & X"0";
                           adc_data_single_chan(47 downto 32)   <= adc_data_single_temp(35 downto 24)   & X"0";
                           adc_data_single_chan(63 downto 48)   <= adc_data_single_temp(47 downto 36)   & X"0";
                           adc_data_single_chan(79 downto 64)   <= adc_data_post_jesd_buffer_dout_reg(11 downto 0)    & X"0";
                           adc_data_single_chan(95 downto 80)   <= adc_data_post_jesd_buffer_dout_reg(23 downto 12)   & X"0";
                           adc_data_single_chan(111 downto 96)  <= adc_data_post_jesd_buffer_dout_reg(35 downto 24)   & X"0";
                           adc_data_single_chan(127 downto 112) <= adc_data_post_jesd_buffer_dout_reg(47 downto 36)   & X"0";
                           adc_data_single_chan(143 downto 128) <= adc_data_post_jesd_buffer_dout_reg(59 downto 48)   & X"0";
                           adc_data_single_chan(159 downto 144) <= adc_data_post_jesd_buffer_dout_reg(71 downto 60)   & X"0";
                           adc_data_single_chan(175 downto 160) <= adc_data_post_jesd_buffer_dout_reg(83 downto 72)   & X"0";
                           adc_data_single_chan(191 downto 176) <= adc_data_post_jesd_buffer_dout_reg(95 downto 84)   & X"0";
                           adc_data_single_chan(207 downto 192) <= adc_data_post_jesd_buffer_dout_reg(107 downto 96)  & X"0";
                           adc_data_single_chan(223 downto 208) <= adc_data_post_jesd_buffer_dout_reg(119 downto 108) & X"0";
                           adc_data_single_chan(239 downto 224) <= adc_data_post_jesd_buffer_dout_reg(131 downto 120) & X"0";
                           adc_data_single_chan(255 downto 240) <= adc_data_post_jesd_buffer_dout_reg(143 downto 132) & X"0";
                           
                           adc_data_single_temp(95 downto 0)   <= adc_data_post_jesd_buffer_dout_reg(239 downto 144);
                           adc_data_single_temp(255 downto 96) <= (others => '0');
                           
                       end if;
                       
                       
                   when "010" =>
                       
                       if(jesd_buffer_fifo_data_valid_reg = '1') then
                           adc_data_single_chan(15 downto 0)    <= adc_data_single_temp(11 downto 0)  & X"0";
                           adc_data_single_chan(31 downto 16)   <= adc_data_single_temp(23 downto 12) & X"0";
                           adc_data_single_chan(47 downto 32)   <= adc_data_single_temp(35 downto 24) & X"0";
                           adc_data_single_chan(63 downto 48)   <= adc_data_single_temp(47 downto 36) & X"0";
                           adc_data_single_chan(79 downto 64)   <= adc_data_single_temp(59 downto 48) & X"0";
                           adc_data_single_chan(95 downto 80)   <= adc_data_single_temp(71 downto 60) & X"0";
                           adc_data_single_chan(111 downto 96)  <= adc_data_single_temp(83 downto 72) & X"0";
                           adc_data_single_chan(127 downto 112) <= adc_data_single_temp(95 downto 84) & X"0";
                           adc_data_single_chan(143 downto 128) <= adc_data_post_jesd_buffer_dout_reg(11 downto 0)  & X"0";
                           adc_data_single_chan(159 downto 144) <= adc_data_post_jesd_buffer_dout_reg(23 downto 12) & X"0";
                           adc_data_single_chan(175 downto 160) <= adc_data_post_jesd_buffer_dout_reg(35 downto 24) & X"0";
                           adc_data_single_chan(191 downto 176) <= adc_data_post_jesd_buffer_dout_reg(47 downto 36) & X"0";
                           adc_data_single_chan(207 downto 192) <= adc_data_post_jesd_buffer_dout_reg(59 downto 48) & X"0";
                           adc_data_single_chan(223 downto 208) <= adc_data_post_jesd_buffer_dout_reg(71 downto 60) & X"0";
                           adc_data_single_chan(239 downto 224) <= adc_data_post_jesd_buffer_dout_reg(83 downto 72) & X"0";
                           adc_data_single_chan(255 downto 240) <= adc_data_post_jesd_buffer_dout_reg(95 downto 84) & X"0";
                           
                           adc_data_single_temp(143 downto 0)   <= adc_data_post_jesd_buffer_dout_reg(239 downto 96);
                           adc_data_single_temp(255 downto 144) <= (others => '0');
                           
                       end if;
                       
                   when "011" =>
                   
                       if(jesd_buffer_fifo_data_valid_reg = '1') then
                           adc_data_single_chan(15 downto 0)    <= adc_data_single_temp(11 downto 0)  & X"0";
                           adc_data_single_chan(31 downto 16)   <= adc_data_single_temp(23 downto 12) & X"0";
                           adc_data_single_chan(47 downto 32)   <= adc_data_single_temp(35 downto 24) & X"0";
                           adc_data_single_chan(63 downto 48)   <= adc_data_single_temp(47 downto 36) & X"0";
                           adc_data_single_chan(79 downto 64)   <= adc_data_single_temp(59 downto 48) & X"0";
                           adc_data_single_chan(95 downto 80)   <= adc_data_single_temp(71 downto 60) & X"0";
                           adc_data_single_chan(111 downto 96)  <= adc_data_single_temp(83 downto 72) & X"0";
                           adc_data_single_chan(127 downto 112) <= adc_data_single_temp(95 downto 84) & X"0";
                           adc_data_single_chan(143 downto 128) <= adc_data_single_temp(107 downto 96)  & X"0";
                           adc_data_single_chan(159 downto 144) <= adc_data_single_temp(119 downto 108) & X"0";
                           adc_data_single_chan(175 downto 160) <= adc_data_single_temp(131 downto 120) & X"0";
                           adc_data_single_chan(191 downto 176) <= adc_data_single_temp(143 downto 132) & X"0";
                           adc_data_single_chan(207 downto 192) <= adc_data_post_jesd_buffer_dout_reg(11 downto 0)  & X"0";
                           adc_data_single_chan(223 downto 208) <= adc_data_post_jesd_buffer_dout_reg(23 downto 12) & X"0";
                           adc_data_single_chan(239 downto 224) <= adc_data_post_jesd_buffer_dout_reg(35 downto 24) & X"0";
                           adc_data_single_chan(255 downto 240) <= adc_data_post_jesd_buffer_dout_reg(47 downto 36) & X"0";
                           
                           adc_data_single_temp(191 downto 0)   <= adc_data_post_jesd_buffer_dout_reg(239 downto 48);
                           adc_data_single_temp(255 downto 192) <= (others => '0');
                           
                       end if;
                       
                   when "100" =>
                       
                       adc_data_single_chan(15 downto 0)    <= adc_data_single_temp(11 downto 0)  & X"0";
                       adc_data_single_chan(31 downto 16)   <= adc_data_single_temp(23 downto 12) & X"0";
                       adc_data_single_chan(47 downto 32)   <= adc_data_single_temp(35 downto 24) & X"0";
                       adc_data_single_chan(63 downto 48)   <= adc_data_single_temp(47 downto 36) & X"0";
                       adc_data_single_chan(79 downto 64)   <= adc_data_single_temp(59 downto 48) & X"0";
                       adc_data_single_chan(95 downto 80)   <= adc_data_single_temp(71 downto 60) & X"0";
                       adc_data_single_chan(111 downto 96)  <= adc_data_single_temp(83 downto 72) & X"0";
                       adc_data_single_chan(127 downto 112) <= adc_data_single_temp(95 downto 84) & X"0";
                       adc_data_single_chan(143 downto 128) <= adc_data_single_temp(107 downto 96)  & X"0";
                       adc_data_single_chan(159 downto 144) <= adc_data_single_temp(119 downto 108) & X"0";
                       adc_data_single_chan(175 downto 160) <= adc_data_single_temp(131 downto 120) & X"0";
                       adc_data_single_chan(191 downto 176) <= adc_data_single_temp(143 downto 132) & X"0";
                       adc_data_single_chan(207 downto 192) <= adc_data_single_temp(155 downto 144) & X"0";
                       adc_data_single_chan(223 downto 208) <= adc_data_single_temp(167 downto 156) & X"0";
                       adc_data_single_chan(239 downto 224) <= adc_data_single_temp(179 downto 168) & X"0";
                       adc_data_single_chan(255 downto 240) <= adc_data_single_temp(191 downto 180) & X"0";
                       
                       adc_data_single_temp(255 downto 0) <= (others => '0');
                   
                   when others =>
                       adc_data_single_chan <= (others => '0');
                       adc_data_single_temp <= (others => '0');
                   end case;
               else
                   adc_data_single_chan <= (others => '0');
                   adc_data_single_temp <= (others => '0');
               end if;
               
               -- Jmode-2 Pack 12-bit into 16 bit words in dual channel
               if(jmode_cdc = "00010") then
                   case data_sel is 
                           
                   when "000" =>
                       
                       if(jesd_buffer_fifo_data_valid_reg = '1') then
                           adc_data_dual_chan_a(15 downto 0)    <= adc_data_post_jesd_buffer_dout_reg(11 downto 0)    & X"0";
                           adc_data_dual_chan_a(31 downto 16)   <= adc_data_post_jesd_buffer_dout_reg(23 downto 12)   & X"0";
                           adc_data_dual_chan_a(47 downto 32)   <= adc_data_post_jesd_buffer_dout_reg(35 downto 24)   & X"0";
                           adc_data_dual_chan_a(63 downto 48)   <= adc_data_post_jesd_buffer_dout_reg(47 downto 36)   & X"0";
                           adc_data_dual_chan_a(79 downto 64)   <= adc_data_post_jesd_buffer_dout_reg(59 downto 48)   & X"0";
                           adc_data_dual_chan_a(95 downto 80)   <= adc_data_post_jesd_buffer_dout_reg(71 downto 60)   & X"0";
                           adc_data_dual_chan_a(111 downto 96)  <= adc_data_post_jesd_buffer_dout_reg(83 downto 72)   & X"0";
                           adc_data_dual_chan_a(127 downto 112) <= adc_data_post_jesd_buffer_dout_reg(95 downto 84)   & X"0";
                           
                           adc_data_dual_chan_b(15 downto 0)    <= adc_data_post_jesd_buffer_dout_reg(139 downto 128) & X"0";
                           adc_data_dual_chan_b(31 downto 16)   <= adc_data_post_jesd_buffer_dout_reg(151 downto 140) & X"0";
                           adc_data_dual_chan_b(47 downto 32)   <= adc_data_post_jesd_buffer_dout_reg(163 downto 152) & X"0";
                           adc_data_dual_chan_b(63 downto 48)   <= adc_data_post_jesd_buffer_dout_reg(175 downto 164) & X"0";
                           adc_data_dual_chan_b(79 downto 64)   <= adc_data_post_jesd_buffer_dout_reg(187 downto 176) & X"0";
                           adc_data_dual_chan_b(95 downto 80)   <= adc_data_post_jesd_buffer_dout_reg(199 downto 188) & X"0";
                           adc_data_dual_chan_b(111 downto 96)  <= adc_data_post_jesd_buffer_dout_reg(211 downto 200) & X"0";
                           adc_data_dual_chan_b(127 downto 112) <= adc_data_post_jesd_buffer_dout_reg(223 downto 212) & X"0";
                                                                                                  
                           adc_data_dual_temp(23 downto 0)    <= adc_data_post_jesd_buffer_dout_reg(119 downto 96);
                           adc_data_dual_temp(127 downto 24)  <= (others => '0');
                           
                           adc_data_dual_temp(151 downto 128) <= adc_data_post_jesd_buffer_dout_reg(247 downto 224);
                           adc_data_dual_temp(255 downto 152) <= (others => '0');
                           
                           adc_data_valid_dual_chan <= '1';
                           
                       end if;
                   
                       
                       
                   when "001" =>
                                
                       if(jesd_buffer_fifo_data_valid_reg = '1') then
                           adc_data_dual_chan_a(15 downto 0)    <= adc_data_dual_temp(11 downto 0)    & X"0";
                           adc_data_dual_chan_a(31 downto 16)   <= adc_data_dual_temp(23 downto 12)   & X"0";
                           adc_data_dual_chan_a(47 downto 32)   <= adc_data_post_jesd_buffer_dout_reg(11 downto 0)     & X"0";
                           adc_data_dual_chan_a(63 downto 48)   <= adc_data_post_jesd_buffer_dout_reg(23 downto 12)    & X"0";
                           adc_data_dual_chan_a(79 downto 64)   <= adc_data_post_jesd_buffer_dout_reg(35 downto 24)    & X"0";
                           adc_data_dual_chan_a(95 downto 80)   <= adc_data_post_jesd_buffer_dout_reg(47 downto 36)    & X"0";
                           adc_data_dual_chan_a(111 downto 96)  <= adc_data_post_jesd_buffer_dout_reg(59 downto 48)    & X"0";
                           adc_data_dual_chan_a(127 downto 112) <= adc_data_post_jesd_buffer_dout_reg(71 downto 60)    & X"0";
                           
                           adc_data_dual_chan_b(15 downto 0)    <= adc_data_dual_temp(139 downto 128) & X"0";
                           adc_data_dual_chan_b(31 downto 16)   <= adc_data_dual_temp(151 downto 140) & X"0";
                           adc_data_dual_chan_b(47 downto 32)   <= adc_data_post_jesd_buffer_dout_reg(139 downto 128) & X"0";
                           adc_data_dual_chan_b(63 downto 48)   <= adc_data_post_jesd_buffer_dout_reg(151 downto 140) & X"0";
                           adc_data_dual_chan_b(79 downto 64)   <= adc_data_post_jesd_buffer_dout_reg(163 downto 152) & X"0";
                           adc_data_dual_chan_b(95 downto 80)   <= adc_data_post_jesd_buffer_dout_reg(175 downto 164) & X"0";
                           adc_data_dual_chan_b(111 downto 96)  <= adc_data_post_jesd_buffer_dout_reg(187 downto 176) & X"0";
                           adc_data_dual_chan_b(127 downto 112) <= adc_data_post_jesd_buffer_dout_reg(199 downto 188) & X"0";
                                                                                                  
                           adc_data_dual_temp(47 downto 0)    <= adc_data_post_jesd_buffer_dout_reg(119 downto 72);
                           adc_data_dual_temp(127 downto 48)  <= (others => '0');
                           
                           adc_data_dual_temp(175 downto 128) <= adc_data_post_jesd_buffer_dout_reg(247 downto 200);
                           adc_data_dual_temp(255 downto 177) <= (others => '0');
                           
                       end if;
                       
                       
                   when "010" =>
                       
                       if(jesd_buffer_fifo_data_valid_reg = '1') then
                           adc_data_dual_chan_a(15 downto 0)    <= adc_data_dual_temp(11 downto 0)    & X"0";
                           adc_data_dual_chan_a(31 downto 16)   <= adc_data_dual_temp(23 downto 12)   & X"0";
                           adc_data_dual_chan_a(47 downto 32)   <= adc_data_dual_temp(35 downto 24)   & X"0";
                           adc_data_dual_chan_a(63 downto 48)   <= adc_data_dual_temp(47 downto 36)   & X"0";
                           adc_data_dual_chan_a(79 downto 64)   <= adc_data_post_jesd_buffer_dout_reg(11 downto 0)    & X"0";
                           adc_data_dual_chan_a(95 downto 80)   <= adc_data_post_jesd_buffer_dout_reg(23 downto 12)   & X"0";
                           adc_data_dual_chan_a(111 downto 96)  <= adc_data_post_jesd_buffer_dout_reg(35 downto 24)   & X"0";
                           adc_data_dual_chan_a(127 downto 112) <= adc_data_post_jesd_buffer_dout_reg(47 downto 36)   & X"0";
                                                                   
                           adc_data_dual_chan_b(15 downto 0)    <= adc_data_dual_temp(139 downto 128) & X"0";
                           adc_data_dual_chan_b(31 downto 16)   <= adc_data_dual_temp(151 downto 140) & X"0";
                           adc_data_dual_chan_b(47 downto 32)   <= adc_data_dual_temp(163 downto 152) & X"0";
                           adc_data_dual_chan_b(63 downto 48)   <= adc_data_dual_temp(175 downto 164) & X"0";
                           adc_data_dual_chan_b(79 downto 64)   <= adc_data_post_jesd_buffer_dout_reg(139 downto 128) & X"0";
                           adc_data_dual_chan_b(95 downto 80)   <= adc_data_post_jesd_buffer_dout_reg(151 downto 140) & X"0";
                           adc_data_dual_chan_b(111 downto 96)  <= adc_data_post_jesd_buffer_dout_reg(163 downto 152) & X"0";
                           adc_data_dual_chan_b(127 downto 112) <= adc_data_post_jesd_buffer_dout_reg(175 downto 164) & X"0";
                                                                                                  
                           adc_data_dual_temp(71 downto 0)    <= adc_data_post_jesd_buffer_dout_reg(119 downto 48);
                           adc_data_dual_temp(127 downto 72)  <= (others => '0');
                           
                           adc_data_dual_temp(199 downto 128) <= adc_data_post_jesd_buffer_dout_reg(247 downto 176);
                           adc_data_dual_temp(255 downto 200) <= (others => '0');  
                           
                       end if;
                       
                   when "011" =>
                   
                       if(jesd_buffer_fifo_data_valid_reg = '1') then
                           adc_data_dual_chan_a(15 downto 0)    <= adc_data_dual_temp(11 downto 0)    & X"0";
                           adc_data_dual_chan_a(31 downto 16)   <= adc_data_dual_temp(23 downto 12)   & X"0";
                           adc_data_dual_chan_a(47 downto 32)   <= adc_data_dual_temp(35 downto 24)   & X"0";
                           adc_data_dual_chan_a(63 downto 48)   <= adc_data_dual_temp(47 downto 36)   & X"0";
                           adc_data_dual_chan_a(79 downto 64)   <= adc_data_dual_temp(59 downto 48)   & X"0";
                           adc_data_dual_chan_a(95 downto 80)   <= adc_data_dual_temp(71 downto 60)   & X"0";
                           adc_data_dual_chan_a(111 downto 96)  <= adc_data_post_jesd_buffer_dout_reg(11 downto 0)  & X"0";
                           adc_data_dual_chan_a(127 downto 112) <= adc_data_post_jesd_buffer_dout_reg(23 downto 12) & X"0";
                                                                   
                           adc_data_dual_chan_b(15 downto 0)    <= adc_data_dual_temp(139 downto 128) & X"0";
                           adc_data_dual_chan_b(31 downto 16)   <= adc_data_dual_temp(151 downto 140) & X"0";
                           adc_data_dual_chan_b(47 downto 32)   <= adc_data_dual_temp(163 downto 152) & X"0";
                           adc_data_dual_chan_b(63 downto 48)   <= adc_data_dual_temp(175 downto 164) & X"0";
                           adc_data_dual_chan_b(79 downto 64)   <= adc_data_dual_temp(187 downto 176) & X"0";
                           adc_data_dual_chan_b(95 downto 80)   <= adc_data_dual_temp(199 downto 188) & X"0";
                           adc_data_dual_chan_b(111 downto 96)  <= adc_data_post_jesd_buffer_dout_reg(139 downto 128) & X"0";
                           adc_data_dual_chan_b(127 downto 112) <= adc_data_post_jesd_buffer_dout_reg(151 downto 140) & X"0";
                                                                                                  
                           adc_data_dual_temp(95 downto 0)    <= adc_data_post_jesd_buffer_dout_reg(119 downto 24);
                           adc_data_dual_temp(127 downto 96)  <= (others => '0');
                           
                           adc_data_dual_temp(223 downto 128) <= adc_data_post_jesd_buffer_dout_reg(247 downto 152);
                           adc_data_dual_temp(255 downto 224) <= (others => '0');  
                           
                       end if;
                       
                   when "100" =>
                       
                       adc_data_dual_chan_a(15 downto 0)    <= adc_data_dual_temp(11 downto 0)    & X"0";
                       adc_data_dual_chan_a(31 downto 16)   <= adc_data_dual_temp(23 downto 12)   & X"0";
                       adc_data_dual_chan_a(47 downto 32)   <= adc_data_dual_temp(35 downto 24)   & X"0";
                       adc_data_dual_chan_a(63 downto 48)   <= adc_data_dual_temp(47 downto 36)   & X"0";
                       adc_data_dual_chan_a(79 downto 64)   <= adc_data_dual_temp(59 downto 48)   & X"0";
                       adc_data_dual_chan_a(95 downto 80)   <= adc_data_dual_temp(71 downto 60)   & X"0";
                       adc_data_dual_chan_a(111 downto 96)  <= adc_data_dual_temp(83 downto 72)   & X"0";
                       adc_data_dual_chan_a(127 downto 112) <= adc_data_dual_temp(95 downto 84)   & X"0";
                       
                       adc_data_dual_chan_b(15 downto 0)    <= adc_data_dual_temp(139 downto 128) & X"0";
                       adc_data_dual_chan_b(31 downto 16)   <= adc_data_dual_temp(151 downto 140) & X"0";
                       adc_data_dual_chan_b(47 downto 32)   <= adc_data_dual_temp(163 downto 152) & X"0";
                       adc_data_dual_chan_b(63 downto 48)   <= adc_data_dual_temp(175 downto 164) & X"0";
                       adc_data_dual_chan_b(79 downto 64)   <= adc_data_dual_temp(187 downto 176) & X"0";
                       adc_data_dual_chan_b(95 downto 80)   <= adc_data_dual_temp(199 downto 188) & X"0";
                       adc_data_dual_chan_b(111 downto 96)  <= adc_data_dual_temp(211 downto 200) & X"0";
                       adc_data_dual_chan_b(127 downto 112) <= adc_data_dual_temp(223 downto 212) & X"0";
                           
                       adc_data_dual_temp(255 downto 0) <= (others => '0');
                   
                   when others =>
                       adc_data_dual_chan_a <= (others => '0');
                       adc_data_dual_chan_b <= (others => '0');
                       adc_data_dual_temp   <= (others => '0');
                   end case;
               else
                   adc_data_dual_chan_a <= (others => '0');
                   adc_data_dual_chan_b <= (others => '0');
                   adc_data_dual_temp   <= (others => '0');
               end if;
               
               -- Jmode-5 - 8-bit
               if(jmode_cdc = "00101" or jmode_cdc = "00111") then
                   adc_data_8bit       <= adc_data_post_jesd_buffer_dout_reg(255 downto 0);
                   adc_data_valid_8bit <= jesd_buffer_fifo_data_valid_reg;
               else
                   adc_data_8bit        <= (others => '0'); 
                   adc_data_valid_8bit  <= '0';
               end if;
               
               -- Jmode-9 or Jmode-11 are essentially 16 Bit
               if(jmode_cdc = "01001" or jmode_cdc = "01011" or jmode_cdc = "10000" or jmode_cdc = "01110") then
                   adc_data_15bit_chan_a <= adc_data_post_jesd_buffer_dout_reg(127 downto 0);
                   adc_data_15bit_chan_b <= adc_data_post_jesd_buffer_dout_reg(255 downto 128);
                   
                   adc_data_valid_15bit  <= jesd_buffer_fifo_data_valid_reg;
               else
                   adc_data_15bit_chan_a <= (others => '0'); 
                   adc_data_15bit_chan_b <= (others => '0');
                   adc_data_valid_15bit  <= '0';
               end if;
               
           end if;
       end if;
   end process;
   
   -- Pack data into AXI-Stream master bus for output
   process(adc_sample_clk) begin
       if(rising_edge(adc_sample_clk)) then
           case jmode_cdc is
           
           when "00000" =>
               m_axis_adc1_pd_tvalid <= adc_data_valid_single_chan;
               m_axis_adc1_pd_tdata  <= adc_data_single_chan;
               
               m_axis_adc2_pd_tvalid <= adc_data_valid_single_chan;
               m_axis_adc2_pd_tdata  <= adc_data_single_chan;
               
               adc_pd_tvalid_toogle     <= '0';
           
           when "00010" =>
           
               if(s_axis_jesd_rx_pd_tvalid_reg5 = '0') then
               
                   adc_pd_tvalid_toogle  <= '0';
                   m_axis_adc1_pd_tvalid <= '0';
                   m_axis_adc2_pd_tvalid <= '0';
                   m_axis_adc1_pd_tdata  <= (others => '0');
                   m_axis_adc2_pd_tdata  <= (others => '0');
               else
                   if(adc_data_valid_dual_chan = '1') then
                       adc_pd_tvalid_toogle <= not adc_pd_tvalid_toogle;
                   end if;
                   
                   m_axis_adc1_pd_tvalid <= adc_pd_tvalid_toogle and adc_data_valid_dual_chan;
                   m_axis_adc2_pd_tvalid <= adc_pd_tvalid_toogle and adc_data_valid_dual_chan;
                   
                   if(adc_pd_tvalid_toogle = '0') then
                       m_axis_adc1_pd_tdata(127 downto 0) <= adc_data_dual_chan_a;
                       m_axis_adc2_pd_tdata(127 downto 0) <= adc_data_dual_chan_b;
                   else
                       m_axis_adc1_pd_tdata(255 downto 128)  <= adc_data_dual_chan_a;
                       m_axis_adc2_pd_tdata(255 downto 128)  <= adc_data_dual_chan_b;
                   end if;
               end if;
               
            when "00101" =>
               m_axis_adc1_pd_tvalid <= adc_data_valid_8bit;
               m_axis_adc1_pd_tdata  <= adc_data_8bit;
               
               m_axis_adc2_pd_tvalid <= adc_data_valid_8bit;
               m_axis_adc2_pd_tdata  <= adc_data_8bit;
               
               adc_pd_tvalid_toogle     <= '0';
               
            when "00111" =>
               
               if(s_axis_jesd_rx_pd_tvalid_reg5 = '0') then
               
                   adc_pd_tvalid_toogle  <= '0';
                   m_axis_adc1_pd_tvalid <= '0';
                   m_axis_adc2_pd_tvalid <= '0';
                   m_axis_adc1_pd_tdata  <= (others => '0');
                   m_axis_adc2_pd_tdata  <= (others => '0');
               else
                   if(adc_data_valid_8bit = '1') then
                       adc_pd_tvalid_toogle <= not adc_pd_tvalid_toogle;
                   end if;
                   
                   m_axis_adc1_pd_tvalid <= adc_pd_tvalid_toogle and adc_data_valid_8bit;
                   m_axis_adc2_pd_tvalid <= adc_pd_tvalid_toogle and adc_data_valid_8bit;
                   
                   if(adc_pd_tvalid_toogle = '0') then
                       m_axis_adc1_pd_tdata(127 downto 0) <= adc_data_8bit(127 downto 0);
                       m_axis_adc2_pd_tdata(127 downto 0) <= adc_data_8bit(255 downto 128);
                   else
                       m_axis_adc1_pd_tdata(255 downto 128)  <= adc_data_8bit(127 downto 0);
                       m_axis_adc2_pd_tdata(255 downto 128)  <= adc_data_8bit(255 downto 128);
                   end if;
               end if;
                
               
            when "01001" | "01011" | "10000" | "01110" =>
               
               if(s_axis_jesd_rx_pd_tvalid_reg5 = '0') then 
               
                   adc_pd_tvalid_toogle  <= '0';
                   m_axis_adc1_pd_tvalid <= '0';
                   m_axis_adc2_pd_tvalid <= '0';
                   m_axis_adc1_pd_tdata  <= (others => '0');
                   m_axis_adc2_pd_tdata  <= (others => '0');
               else
                   if(adc_data_valid_15bit = '1') then
                       adc_pd_tvalid_toogle <= not adc_pd_tvalid_toogle;
                   end if;
                   
                   if(adc_pd_tvalid_toogle = '0') then
                       m_axis_adc1_pd_tdata(127 downto 0) <= adc_data_15bit_chan_a;
                       m_axis_adc2_pd_tdata(127 downto 0) <= adc_data_15bit_chan_b;
                   else
                       m_axis_adc1_pd_tdata(255 downto 128)  <= adc_data_15bit_chan_a;
                       m_axis_adc2_pd_tdata(255 downto 128)  <= adc_data_15bit_chan_b;
                   end if;
                   
                   m_axis_adc1_pd_tvalid <= adc_pd_tvalid_toogle and adc_data_valid_15bit;
                   m_axis_adc2_pd_tvalid <= adc_pd_tvalid_toogle and adc_data_valid_15bit;
                   
               end if;
               
           when others => 
               m_axis_adc1_pd_tvalid <= '0';
               m_axis_adc1_pd_tdata  <= (others => '0');
               
               m_axis_adc2_pd_tvalid <= '0';
               m_axis_adc2_pd_tdata  <= (others => '0');
               
               adc_pd_tvalid_toogle  <= '0';
           
           end case;
       end if;
   end process;

end Behavioral;
