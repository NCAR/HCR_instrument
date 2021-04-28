----------------------------------------------------------------------------------
-- Company:  Pentek Inc
-- Engineer: G.L.
-- 	
-- Create Date: 06/06/2017 
-- IP Core Name: PX_DAC38RF89_INTRFC
-- File Name: px_dac38rf89intrfc_pack.vhd 
-- Target Devices: Kintex UltraScale  
-- Tool Versions: 2018.1
-- Description: This is a submodule for the PX_DAC38RF89_INTRFC IP Core. 
-- This submodule interfaces via a Xilinx JESD Core to transfer data to the 
-- Texas Intrument DAC38RF89 analog to digtial converter chip. 
-- It receives dac data via an AXI-Stream slave bus from Pentek backend
-- acquisition cores, packs the DAC data into the appropriate order, output
-- via a AXI-Stream master bus to a Xilinx JESD interface for transfer to
-- the external DAC38RF89 device.
-- This submdoule supports 8-lane JESD operation in the following
-- L-M-F-S-Hd modes (See dac38rf89 datasheet for L-M-F-S-Hd modes details)
-- 82121 - Single Channel 16-bit I/Q 
-- 84111 - Two Channel 16-bit I/Q
-- 88210 - Two Channel 16-bit 
-- 81180 - Single Channel 8-Bit real
-- 82380 - Single Channel 12-bit I/Q
-- 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.0 - 6/6/2017 - Module Created
-- Revision 1.0 - 5/2/2017 - Added support for JESD MODE 5 for Wide DUC Mode
-- Revision 1.1 - 11/16/2018 - Changed Fifo Implementation of all Fifo's from
-- built-in to block-ram. Block-ram provides better routing and timing for
-- fifo's operating at high frequencies.
-- Revision 1.2 - 3/4/2019 - Bug was fixed in the 12-bit mode state machine 
-- that was introduced after changing FIFO implementation to Block-ram.   
--
-- Additional Comments: 
--
-- 

-- (Memory Map)

-- (Additional Info)
-- Example: Requires an externally instantiated JESD Interface to transmit data to 
-- DAC38RF89 digital to analog chip

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

Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_dac38rf89intrfc_pack is
Port
( 
   dac_pack_rst             : in std_logic;
   
   dac_jesd_format_mode     : in std_logic_vector(2 downto 0);
   wide_duc_mode            : in std_logic; 
                            
   tx_core_clk              : in  std_logic;
   dac_sample_clk           : in  std_logic; -- Sample Clock input
   
   sync_latch_clr           : in  std_logic;
   sync_latch_en            : in  std_logic;
   
   s_axis_pdti_a_tdata      : in  std_logic_vector(255 downto 0);
   s_axis_pdti_a_tuser      : in  std_logic_vector(127 downto 0);
   s_axis_pdti_a_tvalid     : in  std_logic;
   
   s_axis_pdti_b_tdata      : in  std_logic_vector(255 downto 0);
   s_axis_pdti_b_tuser      : in  std_logic_vector(127 downto 0);
   s_axis_pdti_b_tvalid     : in  std_logic;
   
   tx_start_of_frame        : in  std_logic_vector(3 downto 0);
   m_axis_jesd_tx_tdata     : out std_logic_vector(255 downto 0);
   m_axis_jesd_tx_tready    : in  std_logic;
   m_axis_jesd_tx_tvalid    : out std_logic
        

);
end px_dac38rf89intrfc_pack;

architecture Behavioral of px_dac38rf89intrfc_pack is

-- signals applied through a XPM CDC module to accomadate clock domain
-- crossings
signal dac_pack_rst_cdc              : std_logic;
signal dac_jesd_format_mode_cdc      : std_logic_vector(2 downto 0);
signal wide_duc_mode_cdc             : std_logic; 
                                     
                                     
signal jesd_fifo_din_a_single        : std_logic_vector(255 downto 0);
signal jesd_fifo_wr_en_a_single      : std_logic;
signal jesd_fifo_rd_en_a_single      : std_logic;
signal jesd_fifo_dout_a_single       : std_logic_vector(255 downto 0);
                                     
signal jesd_fifo_din_a_dual          : std_logic_vector(255 downto 0);
signal jesd_fifo_din_b_dual          : std_logic_vector(255 downto 0);
signal jesd_fifo_wr_en_a_dual        : std_logic;
signal jesd_fifo_wr_en_b_dual        : std_logic;
signal jesd_fifo_rd_en_a_dual        : std_logic;
signal jesd_fifo_rd_en_b_dual        : std_logic;
signal jesd_fifo_dout_a_dual         : std_logic_vector(127 downto 0);
signal jesd_fifo_dout_b_dual         : std_logic_vector(127 downto 0);
                                     
signal jesd_fifo_din_a_single12bit   : std_logic_vector(255 downto 0);
signal jesd_fifo_wr_en_a_single12bit : std_logic;
signal jesd_fifo_dout_a_single12bit  : std_logic_vector(1023 downto 0);
signal jesd_fifo_rd_en_a_single12bit : std_logic;

signal jesd_fifo_din_a_dual12bit     : std_logic_vector(255 downto 0);
signal jesd_fifo_wr_en_a_dual12bit   : std_logic;
signal jesd_fifo_dout_a_dual12bit    : std_logic_vector(511 downto 0);
signal jesd_fifo_rd_en_a_dual12bit   : std_logic;

signal jesd_fifo_din_b_dual12bit     : std_logic_vector(255 downto 0);
signal jesd_fifo_wr_en_b_dual12bit   : std_logic;
signal jesd_fifo_dout_b_dual12bit    : std_logic_vector(511 downto 0);
signal jesd_fifo_rd_en_b_dual12bit   : std_logic;


-- JESD Buffer Fifo empty and valid signals
signal jesd_fifo_empty_a_single  : std_logic;
signal jesd_fifo_dvalid_a_single : std_logic;

signal jesd_fifo_empty_a_dual    : std_logic;
signal jesd_fifo_empty_b_dual    : std_logic;
signal jesd_fifo_dvalid_a_dual   : std_logic;
signal jesd_fifo_dvalid_b_dual   : std_logic;

signal jesd_fifo_empty_a_single12bit  : std_logic;
signal jesd_fifo_dvalid_a_single12bit : std_logic;

signal jesd_fifo_empty_a_dual12bit  : std_logic;
signal jesd_fifo_dvalid_a_dual12bit : std_logic;
signal jesd_fifo_empty_b_dual12bit  : std_logic;
signal jesd_fifo_dvalid_b_dual12bit : std_logic;


-- DAC data output from JESD Buffer fifo
signal jesd_fifo_dout_reg1   : std_logic_vector(1023 downto 0);
signal jesd_fifo_dout_reg2   : std_logic_vector(1023 downto 0);
signal jesd_fifo_dout_reg3   : std_logic_vector(1023 downto 0);
signal jesd_fifo_dvalid_a_reg1 : std_logic;
signal jesd_fifo_dvalid_a_reg2 : std_logic;
signal jesd_fifo_dvalid_a_reg3 : std_logic;
signal jesd_fifo_dvalid_a_reg4 : std_logic;
signal jesd_fifo_dvalid_a_reg5 : std_logic;
signal jesd_fifo_dvalid_a_reg6 : std_logic;
signal jesd_fifo_dvalid_b_reg1 : std_logic;
signal jesd_fifo_dvalid_b_reg2 : std_logic;
signal jesd_fifo_dvalid_b_reg3 : std_logic;
signal jesd_fifo_dvalid_b_reg4 : std_logic;
signal jesd_fifo_dvalid_b_reg5 : std_logic;
signal jesd_fifo_dvalid_b_reg6 : std_logic;


signal sync_latch       : std_logic;

signal tx_start_of_frame_reg     : std_logic_vector(3 downto 0);

-- DAC data from AXI-Stream slave bus from channel A
signal s_axis_pdti_a_tdata_reg1  : std_logic_vector(255 downto 0);
signal s_axis_pdti_a_tvalid_reg1 : std_logic;
signal s_axis_pdti_a_tuser_reg1  : std_logic_vector(127 downto 0);
signal s_axis_pdti_a_tdata_reg2  : std_logic_vector(255 downto 0);
signal s_axis_pdti_a_tvalid_reg2 : std_logic;

-- DAC data from AXI-Stream slave bus from channel B
signal s_axis_pdti_b_tdata_reg1  : std_logic_vector(255 downto 0);
signal s_axis_pdti_b_tvalid_reg1 : std_logic;
signal s_axis_pdti_b_tuser_reg1  : std_logic_vector(127 downto 0);
signal s_axis_pdti_b_tdata_reg2  : std_logic_vector(255 downto 0);
signal s_axis_pdti_b_tvalid_reg2 : std_logic;

-- Array and signals to pack JESD Mode L-M-F-S-Hd 82121 single channel 16-bit I/Q
type dac_data_array   is array(0 to 7) of std_logic_vector(15 downto 0);
signal dac_data_i_a     : dac_data_array;
signal dac_data_q_a     : dac_data_array;

-- Array and signals to pack JESD Mode L-M-F-S-Hd 84111 two channel 16-bit I/Q
type dac_data_dual_array   is array(0 to 3) of std_logic_vector(15 downto 0);
signal dac_data_i_a_dual   : dac_data_dual_array;
signal dac_data_q_a_dual   : dac_data_dual_array;
signal dac_data_i_b_dual   : dac_data_dual_array;
signal dac_data_q_b_dual   : dac_data_dual_array;

-- Array and signals to pack JESD Mode L-M-F-S-Hd 81180 single channel 8-bit real
type dac_data_8bit_array   is array(0 to 31) of std_logic_vector(7 downto 0);
signal dac_data_8bit       : dac_data_8bit_array;

-- Array and signals to pack JESD Mode L-M-F-S-Hd 82380 single channel 12-bit I/Q
type dac_data_12bit_array   is array(0 to 31) of std_logic_vector(11 downto 0);
signal dac_data_i_a_12bit     : dac_data_12bit_array;
signal dac_data_q_a_12bit     : dac_data_12bit_array;

-- Array and signals to pack JESD Mode L-M-F-S-Hd 82380 single channel 12-bit I/Q
type dac_data_dual_12bit_array   is array(0 to 31) of std_logic_vector(11 downto 0);
signal dac_data_a_dual_12bit     : dac_data_dual_12bit_array;
signal dac_data_b_dual_12bit     : dac_data_dual_12bit_array;

-- Array and signals to pack JESD Mode L-M-F-S-Hd 82121 dual channel 16-bit real
signal dac_data_dual_a     : dac_data_array;
signal dac_data_dual_b     : dac_data_array;

-- JESD Lanes
type lane_x_array   is array(0 to 7) of std_logic_vector(31 downto 0);
signal lane_x_data  : lane_x_array;
signal tx_tvalid    : std_logic;


COMPONENT jesd_buff_fifo
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
    prog_empty : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT jesd_buff_fifo_dual
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    valid : OUT STD_LOGIC;
    prog_empty : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT jesd_buff_fifo_12bit
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(1023 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    valid : OUT STD_LOGIC;
    prog_empty : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT jesd_buff_fifo_12bit_dual
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    valid : OUT STD_LOGIC;
    prog_empty : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END COMPONENT;


begin

process(dac_sample_clk) begin
    if(rising_edge(dac_sample_clk)) then
        s_axis_pdti_a_tdata_reg1  <= s_axis_pdti_a_tdata;
        s_axis_pdti_a_tvalid_reg1 <= s_axis_pdti_a_tvalid;
        s_axis_pdti_a_tuser_reg1  <= s_axis_pdti_a_tuser;
        
        s_axis_pdti_a_tdata_reg2  <= s_axis_pdti_a_tdata_reg1;
        s_axis_pdti_a_tvalid_reg2 <= s_axis_pdti_a_tvalid_reg1;
                
        s_axis_pdti_b_tdata_reg1  <= s_axis_pdti_b_tdata;
        s_axis_pdti_b_tvalid_reg1 <= s_axis_pdti_b_tvalid;
        s_axis_pdti_b_tuser_reg1  <= s_axis_pdti_b_tuser;
        
        s_axis_pdti_b_tdata_reg2  <= s_axis_pdti_b_tdata_reg1;
        s_axis_pdti_b_tvalid_reg2 <= s_axis_pdti_b_tvalid_reg1;
        --s_axis_pdti_b_tdata_reg  <= s_axis_pdti_b_tdata;
        --s_axis_pdti_b_tvalid_reg <= s_axis_pdti_b_tvalid;
                
    end if;

end process;

 xpm_cdc_dack_pack_rst_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => dac_sample_clk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => dac_pack_rst,
     dest_clk => tx_core_clk,
     dest_out => dac_pack_rst_cdc
  );
  
  xpm_cdc_jmode_inst: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 3  -- integer; range: 1-1024

  )
  port map (

    src_clk  => dac_sample_clk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => dac_jesd_format_mode,
    dest_clk => tx_core_clk,
    dest_out => dac_jesd_format_mode_cdc
  );
  
  xpm_cdc_wide_duc_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => dac_sample_clk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => wide_duc_mode,
     dest_clk => tx_core_clk,
     dest_out => wide_duc_mode_cdc
  );
  
  
  

-- Process to latch the sync when sync latch is enabled
process(dac_sample_clk) begin
    if(rising_edge(dac_sample_clk)) then
        
        if(dac_pack_rst = '1' or sync_latch_clr = '1') then
            sync_latch <= '0';
        elsif(sync_latch_en = '1' and s_axis_pdti_a_tuser_reg1(72) = '1') then
            sync_latch <= '1';
        end if;
    end if;

end process;

--                  
process(dac_sample_clk) begin

    if(rising_edge(dac_sample_clk)) then
        case dac_jesd_format_mode is
            
        when "000" | "011" =>
            
            jesd_fifo_din_a_single   <= s_axis_pdti_a_tdata_reg1;
            
            -- When sync has been received, beginning writing to JESD buffer FIFOs
            jesd_fifo_wr_en_a_single <= s_axis_pdti_a_tuser_reg1(64) and s_axis_pdti_a_tvalid_reg1;
            
            jesd_fifo_wr_en_a_dual         <= '0';
            jesd_fifo_wr_en_b_dual         <= '0';
            jesd_fifo_wr_en_a_single12bit  <= '0';
            jesd_fifo_wr_en_a_dual12bit    <= '0';
            jesd_fifo_wr_en_b_dual12bit    <= '0';
            
        -- JESD Modes L-M-F-S-Hd 84111-2TX and 82121-2Tx    
        when "001" =>
                        
            -- DAC Acquisition Channel A
            -- Must swap upper and lower halfs to compenstate for Xilinx
            -- outputting the upper half first and lower half second
            jesd_fifo_din_a_dual(127 downto 0)     <= s_axis_pdti_a_tdata_reg1(255 downto 128);
            jesd_fifo_din_a_dual(255 downto 128)   <= s_axis_pdti_a_tdata_reg1(127 downto 0);
            
            -- DAC Acquisition Channel B
            -- Must swap upper and lower halfs to compenstate for Xilinx
            -- outputting the upper half first and second half second
            jesd_fifo_din_b_dual(127 downto 0)     <= s_axis_pdti_b_tdata_reg1(255 downto 128);
            jesd_fifo_din_b_dual(255 downto 128)   <= s_axis_pdti_b_tdata_reg1(127 downto 0);
                                           
            jesd_fifo_wr_en_a_dual <= s_axis_pdti_a_tuser_reg1(64) and s_axis_pdti_a_tvalid_reg1;
            jesd_fifo_wr_en_b_dual <= s_axis_pdti_b_tuser_reg1(64) and s_axis_pdti_b_tvalid_reg1;
            
            jesd_fifo_wr_en_a_single      <= '0';
            jesd_fifo_wr_en_a_single12bit <= '0';
            jesd_fifo_wr_en_a_dual12bit   <= '0';
            jesd_fifo_wr_en_b_dual12bit   <= '0';
            
        when "100" => 
            
            if(wide_duc_mode = '1') then 
        
                jesd_fifo_din_a_single12bit   <= s_axis_pdti_a_tdata_reg1;
                
                jesd_fifo_wr_en_a_single12bit <= s_axis_pdti_a_tuser_reg1(64) and s_axis_pdti_a_tvalid_reg1;
                
                jesd_fifo_wr_en_a_single       <= '0';
                jesd_fifo_wr_en_a_dual         <= '0';
                jesd_fifo_wr_en_b_dual         <= '0';
                jesd_fifo_wr_en_a_dual12bit    <= '0';
                jesd_fifo_wr_en_b_dual12bit    <= '0';
                
            else
            
                jesd_fifo_din_a_dual12bit   <= s_axis_pdti_a_tdata_reg1;
                jesd_fifo_din_b_dual12bit   <= s_axis_pdti_b_tdata_reg1;
                
                jesd_fifo_wr_en_a_dual12bit <= s_axis_pdti_a_tuser_reg1(64) and s_axis_pdti_a_tvalid_reg1;
                jesd_fifo_wr_en_b_dual12bit <= s_axis_pdti_b_tuser_reg1(64) and s_axis_pdti_b_tvalid_reg1;
                
                jesd_fifo_wr_en_a_single12bit <= '0';
                jesd_fifo_wr_en_a_single      <= '0';
                jesd_fifo_wr_en_a_dual        <= '0';
                jesd_fifo_wr_en_b_dual        <= '0';
                
            end if;
             
        -- JESD Modes L-M-F-S-Hd 84111-2TX and 82121-2Tx    
        when "101" =>
                        
            if(wide_duc_mode = '1') then
            
                jesd_fifo_din_a_single   <= s_axis_pdti_a_tdata_reg1;
                
                -- When sync has been received, beginning writing to JESD buffer FIFOs
                jesd_fifo_wr_en_a_single <= s_axis_pdti_a_tuser_reg1(64) and s_axis_pdti_a_tvalid_reg1;
                
                jesd_fifo_wr_en_a_dual        <= '0'; 
                jesd_fifo_wr_en_b_dual        <= '0';
                jesd_fifo_wr_en_a_single12bit <= '0';
                jesd_fifo_wr_en_a_dual12bit   <= '0';
                jesd_fifo_wr_en_b_dual12bit   <= '0';
           
            else
               -- DAC Acquisition Channel A
               -- Must swap upper and lower halfs to compenstate for Xilinx
               -- outputting the upper half first and lower half second
               jesd_fifo_din_a_dual(127 downto 0)     <= s_axis_pdti_a_tdata_reg1(255 downto 128);
               jesd_fifo_din_a_dual(255 downto 128)   <= s_axis_pdti_a_tdata_reg1(127 downto 0);
               
               -- DAC Acquisition Channel B
               -- Must swap upper and lower halfs to compenstate for Xilinx
               -- outputting the upper half first and second half second
               jesd_fifo_din_b_dual(127 downto 0)     <= s_axis_pdti_b_tdata_reg1(255 downto 128);
               jesd_fifo_din_b_dual(255 downto 128)   <= s_axis_pdti_b_tdata_reg1(127 downto 0);
                                              
               jesd_fifo_wr_en_a_dual <= s_axis_pdti_a_tuser_reg1(64) and s_axis_pdti_a_tvalid_reg1;
               jesd_fifo_wr_en_b_dual <= s_axis_pdti_b_tuser_reg1(64) and s_axis_pdti_b_tvalid_reg1;
               
               jesd_fifo_wr_en_a_single      <= '0';
               jesd_fifo_wr_en_a_single12bit <= '0';
               jesd_fifo_wr_en_a_dual12bit   <= '0';
               jesd_fifo_wr_en_b_dual12bit   <= '0';

             end if;         
        
        when others =>
            jesd_fifo_wr_en_a_single      <= '0';
            jesd_fifo_wr_en_a_dual        <= '0';
            jesd_fifo_wr_en_b_dual        <= '0';
            jesd_fifo_wr_en_a_single12bit <= '0';
            jesd_fifo_wr_en_a_dual12bit   <= '0';
            jesd_fifo_wr_en_b_dual12bit   <= '0';
        
        end case;
        
    end if;

end process;

-- 128:512 bit wide fifos. 
-- These FIFO's are used by all L-M-F-S-Hd modes, but are mostly needed because
-- of mode 82380.
-- The complexity of L-M-F-S-Hd mode 82380 creates an odd JESD framing scenerio, which
-- requires these FIFO's to buffer 16-bit DAC samples received from Pentek backend 
-- acquistion Cores Prior to packing into 12-bit samples for JESD. In 82380, there
-- are 3 Octets per frame. 
fif0_inst_a_single: jesd_buff_fifo
  PORT map 
  (
    rst        => dac_pack_rst,
    wr_clk      => dac_sample_clk,  
    rd_clk      => tx_core_clk,
    din         => jesd_fifo_din_a_single,
    wr_en       => jesd_fifo_wr_en_a_single,
    rd_en       => jesd_fifo_rd_en_a_single,
    dout        => jesd_fifo_dout_a_single,
    full        => open,
    empty       => jesd_fifo_empty_a_single,
    prog_empty  => open,
    valid       => jesd_fifo_dvalid_a_single,
    wr_rst_busy => open,
    rd_rst_busy => open
  );
  
fifo_inst_a_dual: jesd_buff_fifo_dual
  PORT map 
  (
    rst        => dac_pack_rst,
    wr_clk      => dac_sample_clk,
    rd_clk      => tx_core_clk,
    din         => jesd_fifo_din_a_dual,
    wr_en       => jesd_fifo_wr_en_a_dual,
    rd_en       => jesd_fifo_rd_en_a_dual,
    dout        => jesd_fifo_dout_a_dual,
    full        => open,
    empty       => jesd_fifo_empty_a_dual,
    valid       => jesd_fifo_dvalid_a_dual,
    prog_empty  => open,
    wr_rst_busy => open,
    rd_rst_busy => open
  );
  
fifo_inst_b_dual: jesd_buff_fifo_dual
  PORT map 
  (
    rst        => dac_pack_rst,
    wr_clk      => dac_sample_clk,
    rd_clk      => tx_core_clk,
    din         => jesd_fifo_din_b_dual,
    wr_en       => jesd_fifo_wr_en_b_dual,
    rd_en       => jesd_fifo_rd_en_b_dual,
    dout        => jesd_fifo_dout_b_dual,
    full        => open,
    empty       => jesd_fifo_empty_b_dual,
    valid       => jesd_fifo_dvalid_b_dual,
    prog_empty  => open,
    wr_rst_busy => open,
    rd_rst_busy => open
  );
  
fifo_inst_single12bit: jesd_buff_fifo_12bit
  PORT map 
  (
    rst        => dac_pack_rst,
    wr_clk      => dac_sample_clk,
    rd_clk      => tx_core_clk,
    din         => jesd_fifo_din_a_single12bit,
    wr_en       => jesd_fifo_wr_en_a_single12bit,
    rd_en       => jesd_fifo_rd_en_a_single12bit,
    dout        => jesd_fifo_dout_a_single12bit,
    full        => open,
    empty       => jesd_fifo_empty_a_single12bit,
    valid       => jesd_fifo_dvalid_a_single12bit,
    prog_empty  => open,
    wr_rst_busy => open,
    rd_rst_busy => open
  );
  
fifo_inst_dual12bit_a: jesd_buff_fifo_12bit_dual
  PORT map
  (
    rst        => dac_pack_rst,
    wr_clk      => dac_sample_clk,
    rd_clk      => tx_core_clk,
    din         => jesd_fifo_din_a_dual12bit,
    wr_en       => jesd_fifo_wr_en_a_dual12bit,
    rd_en       => jesd_fifo_rd_en_a_dual12bit,
    dout        => jesd_fifo_dout_a_dual12bit,
    full        => open,
    empty       => jesd_fifo_empty_a_dual12bit,
    valid       => jesd_fifo_dvalid_a_dual12bit,
    prog_empty  => open,
    wr_rst_busy => open,
    rd_rst_busy => open
  );
  
fifo_inst_dual12bit_b: jesd_buff_fifo_12bit_dual
  PORT map
  (
    rst        => dac_pack_rst,
    wr_clk      => dac_sample_clk,
    rd_clk      => tx_core_clk,
    din         => jesd_fifo_din_b_dual12bit,
    wr_en       => jesd_fifo_wr_en_b_dual12bit,
    rd_en       => jesd_fifo_rd_en_b_dual12bit,
    dout        => jesd_fifo_dout_b_dual12bit,
    full        => open,
    empty       => jesd_fifo_empty_b_dual12bit,
    valid       => jesd_fifo_dvalid_b_dual12bit,
    prog_empty  => open,
    wr_rst_busy => open,
    rd_rst_busy => open
  );


  
  
   process(tx_core_clk) begin
   
       if(rising_edge(tx_core_clk)) then
       
       
           case dac_jesd_format_mode_cdc is
           
           -- JESD Modes L-M-F-S-Hd 82121-1TX, 81180-1TX
           when "000" | "011" => 
           
           
               jesd_fifo_dout_reg1(1023 downto 256) <= (others => '0');
               jesd_fifo_dout_reg1(255 downto 0)    <= jesd_fifo_dout_a_single;
                
               jesd_fifo_dvalid_a_reg1 <= jesd_fifo_dvalid_a_single;
               jesd_fifo_dvalid_b_reg1 <= '0';
           
           -- 82380-1TX
           when "100" =>
               
               if(wide_duc_mode = '1') then
                   jesd_fifo_dout_reg1(1023 downto 768) <= jesd_fifo_dout_a_single12bit(255 downto 0);
                   jesd_fifo_dout_reg1(767 downto 512)  <= jesd_fifo_dout_a_single12bit(511 downto 256);
                   jesd_fifo_dout_reg1(511 downto 256)  <= jesd_fifo_dout_a_single12bit(767 downto 512); 
                   jesd_fifo_dout_reg1(255 downto 0)    <= jesd_fifo_dout_a_single12bit(1023 downto 768);
                   
                   jesd_fifo_dvalid_a_reg1 <= jesd_fifo_dvalid_a_single12bit;
                   jesd_fifo_dvalid_b_reg1 <= '0';
                   
               else
                   jesd_fifo_dout_reg1(1023 downto 768) <= jesd_fifo_dout_b_dual12bit(255 downto 0);
                   jesd_fifo_dout_reg1(767 downto 512)  <= jesd_fifo_dout_b_dual12bit(511 downto 256);
                   jesd_fifo_dout_reg1(511 downto 256)  <= jesd_fifo_dout_a_dual12bit(255 downto 0); 
                   jesd_fifo_dout_reg1(255 downto 0)    <= jesd_fifo_dout_a_dual12bit(511 downto 256);
                   
                   jesd_fifo_dvalid_a_reg1 <= jesd_fifo_dvalid_a_dual12bit;
                   jesd_fifo_dvalid_b_reg1 <= jesd_fifo_dvalid_b_dual12bit;
                   
               end if;
           
           -- JESD Mode L-M-F-S-Hd 84111-2TX and 82121-2TX
           when "001" =>
       
               jesd_fifo_dout_reg1(1023 downto 256) <= (others => '0');                   
               jesd_fifo_dout_reg1(255 downto 128)  <= jesd_fifo_dout_b_dual; 
               jesd_fifo_dout_reg1(127 downto 0)    <= jesd_fifo_dout_a_dual;
               
               jesd_fifo_dvalid_a_reg1  <= jesd_fifo_dvalid_a_dual;
               jesd_fifo_dvalid_b_reg1  <= jesd_fifo_dvalid_b_dual;
               
           -- JESD Mode L-M-F-S-Hd 84111-2TX and 82121-2TX
           when "101" =>
           
               if(wide_duc_mode = '1') then
                   jesd_fifo_dout_reg1(1023 downto 256) <= (others => '0');   
                   jesd_fifo_dout_reg1(255 downto 0)    <= jesd_fifo_dout_a_single;
                   
                   jesd_fifo_dvalid_a_reg1 <= jesd_fifo_dvalid_a_single;
                   jesd_fifo_dvalid_b_reg1 <= '0';
                   
               else
                   jesd_fifo_dout_reg1(1023 downto 256) <= (others => '0');                   
                   jesd_fifo_dout_reg1(255 downto 128)  <= jesd_fifo_dout_b_dual; 
                   jesd_fifo_dout_reg1(127 downto 0)    <= jesd_fifo_dout_a_dual;
                   
                   jesd_fifo_dvalid_a_reg1  <= jesd_fifo_dvalid_a_dual;
                   jesd_fifo_dvalid_b_reg1  <= jesd_fifo_dvalid_b_dual;
               
               end if;
               
           when others =>
               jesd_fifo_dout_reg1   <= (others => '0');
               jesd_fifo_dvalid_a_reg1 <= '0';
               jesd_fifo_dvalid_b_reg1 <= '0';
           
           end case;
           
                                 
           jesd_fifo_dout_reg2   <= jesd_fifo_dout_reg1;
           jesd_fifo_dout_reg3   <= jesd_fifo_dout_reg2;
          
           -- Match the clock cycle latency of the data
           jesd_fifo_dvalid_a_reg2 <= jesd_fifo_dvalid_a_reg1;
           jesd_fifo_dvalid_a_reg3 <= jesd_fifo_dvalid_a_reg2;
           jesd_fifo_dvalid_a_reg4 <= jesd_fifo_dvalid_a_reg3;
           jesd_fifo_dvalid_a_reg5 <= jesd_fifo_dvalid_a_reg4;
           jesd_fifo_dvalid_a_reg6 <= jesd_fifo_dvalid_a_reg5;
           
           jesd_fifo_dvalid_b_reg2 <= jesd_fifo_dvalid_b_reg1;
           jesd_fifo_dvalid_b_reg3 <= jesd_fifo_dvalid_b_reg2;
           jesd_fifo_dvalid_b_reg4 <= jesd_fifo_dvalid_b_reg3;
           jesd_fifo_dvalid_b_reg5 <= jesd_fifo_dvalid_b_reg4;
           jesd_fifo_dvalid_b_reg6 <= jesd_fifo_dvalid_b_reg5;
           
       end if;
   end process;
   
   -- FIFO read enables vary based on JESD mode
   process(tx_core_clk) begin
   
       if(rising_edge(tx_core_clk)) then
           tx_start_of_frame_reg     <= tx_start_of_frame;
           
           if(dac_pack_rst_cdc = '1') then
               jesd_fifo_rd_en_a_single      <= '0';
               jesd_fifo_rd_en_a_dual        <= '0';
               jesd_fifo_rd_en_b_dual        <= '0';
               jesd_fifo_rd_en_a_single12bit <= '0';
               jesd_fifo_rd_en_a_dual12bit   <= '0';
               jesd_fifo_rd_en_b_dual12bit   <= '0';
           else
               case dac_jesd_format_mode_cdc is
               
               -- JESD Modes 82121-1TX and 81180-1TX. Read FIFO's when not empty
               when "000" | "011" =>
                   if(jesd_fifo_empty_a_single = '0' ) then
                       jesd_fifo_rd_en_a_single <= '1';
                   else
                       jesd_fifo_rd_en_a_single <= '0';
                   end if;
                   
                   jesd_fifo_rd_en_a_dual         <= '0';
                   jesd_fifo_rd_en_b_dual         <= '0';
                   jesd_fifo_rd_en_a_single12bit  <= '0';
                   jesd_fifo_rd_en_a_dual12bit    <= '0';
                   jesd_fifo_rd_en_b_dual12bit   <= '0';
                   
               -- JESD Mode 84111-2TX. Read FIFO's when not empty.  Channel A and B 
               -- are independent 
               when "001" =>
                   if(jesd_fifo_empty_a_dual = '0' ) then
                       jesd_fifo_rd_en_a_dual <= '1';
                   else
                       jesd_fifo_rd_en_a_dual <= '0';
                   end if;
                   
                   if(jesd_fifo_empty_b_dual = '0' ) then
                       jesd_fifo_rd_en_b_dual <= '1';
                   else
                       jesd_fifo_rd_en_b_dual <= '0';
                   end if;
                   
                   jesd_fifo_rd_en_a_single         <= '0';
                   jesd_fifo_rd_en_a_single12bit    <= '0';
                   jesd_fifo_rd_en_a_dual12bit      <= '0';
                   jesd_fifo_rd_en_b_dual12bit      <= '0';
                   
               -- JESD Mode 82830-1TX. Read FIFO's when not empty and JESD frame is
               -- frame "1001", which is the first frame of three.  This is
               -- ensure data is started in the proper frame
               when "100" =>
               
                   if(wide_duc_mode_cdc = '1') then
                   
                       if(jesd_fifo_empty_a_single12bit = '0' and tx_start_of_frame_reg = "0010") then
                           jesd_fifo_rd_en_a_single12bit <= '1';
                       else
                           jesd_fifo_rd_en_a_single12bit <= '0';
                       end if;
                       
                       jesd_fifo_rd_en_a_single      <= '0';
                       jesd_fifo_rd_en_a_dual        <= '0';
                       jesd_fifo_rd_en_b_dual        <= '0';
                       jesd_fifo_rd_en_a_dual12bit   <= '0';
                       jesd_fifo_rd_en_b_dual12bit   <= '0';
                   
                   else
                       if(jesd_fifo_empty_a_dual12bit = '0' and tx_start_of_frame_reg = "0010") then
                           jesd_fifo_rd_en_a_dual12bit <= '1';
                       else
                           jesd_fifo_rd_en_a_dual12bit <= '0';
                       end if;
                       
                       if(jesd_fifo_empty_b_dual12bit = '0' and tx_start_of_frame_reg = "0010") then
                           jesd_fifo_rd_en_b_dual12bit <= '1';
                       else
                           jesd_fifo_rd_en_b_dual12bit <= '0';
                       end if;
                       
                       jesd_fifo_rd_en_a_single      <= '0';
                       jesd_fifo_rd_en_a_dual        <= '0';
                       jesd_fifo_rd_en_b_dual        <= '0';
                       jesd_fifo_rd_en_a_single12bit <= '0';
                   end if;
                   
               when "101" =>
                   if(wide_duc_mode_cdc = '1') then
                   
                       if(jesd_fifo_empty_a_single = '0' ) then
                           jesd_fifo_rd_en_a_single <= '1';
                       else
                           jesd_fifo_rd_en_a_single <= '0';
                       end if;
                   
                       jesd_fifo_rd_en_a_dual <= '0';
                       jesd_fifo_rd_en_b_dual <= '0';
                   else
                       if(jesd_fifo_empty_a_dual = '0' ) then
                           jesd_fifo_rd_en_a_dual <= '1';
                       else
                           jesd_fifo_rd_en_a_dual <= '0';
                       end if;
                       
                       if(jesd_fifo_empty_b_dual = '0' ) then
                           jesd_fifo_rd_en_b_dual <= '1';
                       else
                           jesd_fifo_rd_en_b_dual <= '0';
                       end if;
                       
                       jesd_fifo_rd_en_a_single         <= '0';
                       
                   end if;
                   
                   jesd_fifo_rd_en_a_single12bit    <= '0';
                   jesd_fifo_rd_en_a_dual12bit      <= '0';
                   jesd_fifo_rd_en_b_dual12bit      <= '0';

               when others =>
                   jesd_fifo_rd_en_a_single      <= '0';
                   jesd_fifo_rd_en_a_dual        <= '0';
                   jesd_fifo_rd_en_b_dual        <= '0';
                   jesd_fifo_rd_en_a_single12bit <= '0';
                   jesd_fifo_rd_en_a_dual12bit   <= '0';
                   jesd_fifo_rd_en_b_dual12bit   <= '0';
               
               end case;
           end if;
           
       end if;
   
   end process;
   
   -- Sort Channel A I/Q DAC data T31 - T0 in JESD Mode L-M-F-S-Hd 82121-1TX 
   generate_16bits: for i in 0 to 7 generate
       process(tx_core_clk) begin
   
           if(rising_edge(tx_core_clk)) then
               if(dac_jesd_format_mode_cdc = "000" or (dac_jesd_format_mode_cdc = "101" and wide_duc_mode_cdc = '1')) then
                   dac_data_i_a(i) <= jesd_fifo_dout_reg2( ((i*2+1)*16 - 1) downto ((i*2*16)) );
                   dac_data_q_a(i) <= jesd_fifo_dout_reg2( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) );
               else
                   dac_data_i_a(i) <= (others => '0');
                   dac_data_q_a(i) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   -- Sort Channel A I/Q DAC data T15 - T0 in JESD Mode L-M-F-S-Hd 84111-2TX
   generate_dual_16bits_iq_a: for i in 0 to 3 generate
       process(tx_core_clk) begin
   
           if(rising_edge(tx_core_clk)) then
               if(dac_jesd_format_mode_cdc = "001") then
                   dac_data_i_a_dual(i) <= jesd_fifo_dout_reg2( ((i*2+1)*16 - 1) downto ((i*2*16)) );
                   dac_data_q_a_dual(i) <= jesd_fifo_dout_reg2( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) );
               else
                   dac_data_i_a_dual(i) <= (others => '0');
                   dac_data_q_a_dual(i) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   -- Sort Channel B I/Q DAC data T15 - T0 in JESD Mode L-M-F-S-Hd 84111-2TX
   generate_dual_16bits_iq_b: for i in 4 to 7 generate
       process(tx_core_clk) begin
   
           if(rising_edge(tx_core_clk)) then
               if(dac_jesd_format_mode_cdc = "001") then
                   dac_data_i_b_dual(i-4) <= jesd_fifo_dout_reg2( ((i*2+1)*16 - 1) downto ((i*2*16)) );
                   dac_data_q_b_dual(i-4) <= jesd_fifo_dout_reg2( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) );
               else
                   dac_data_i_b_dual(i-4) <= (others => '0');
                   dac_data_q_b_dual(i-4) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   -- Sort Channel A Real DAC data T127 - T0 in JESD Mode L-M-F-S-Hd 81180-1TX
   loop_8bit_data: for i in 0 to 31 generate
       
       process(tx_core_clk) begin
           if(rising_edge(tx_core_clk)) then
               if(dac_jesd_format_mode_cdc = "011") then
                   dac_data_8bit(i) <= jesd_fifo_dout_reg2(((i+1)*8 - 1) downto i*8);  
               else
                   dac_data_8bit(i) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
  
   -- Sort Channel A I/Q DAC data T31 - T0 in JESD Mode L-M-F-S-Hd 82380-1TX
   generate_12bits: for i in 0 to 31 generate
       process(tx_core_clk) begin
   
           if(rising_edge(tx_core_clk)) then                     
               if(dac_jesd_format_mode_cdc = "100" and wide_duc_mode_cdc = '1') then
                   dac_data_i_a_12bit(i) <= jesd_fifo_dout_reg2( ((i*2+1)*16 - 1) downto ((i*2*16)+4) );
                   dac_data_q_a_12bit(i) <= jesd_fifo_dout_reg2( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)+4) );
               else
                   dac_data_i_a_12bit(i) <= (others => '0');
                   dac_data_q_a_12bit(i) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   -- Sort Channel A I/Q DAC data T31 - T0 in JESD Mode L-M-F-S-Hd 82380-1TX
   generate_a_dual12bits: for i in 0 to 31 generate
       process(tx_core_clk) begin
   
           if(rising_edge(tx_core_clk)) then
               if(dac_jesd_format_mode_cdc = "100" and wide_duc_mode_cdc = '0') then
                   dac_data_a_dual_12bit(i) <= jesd_fifo_dout_reg2( ((i+1)*16 - 1) downto ((i*16)+4) );
               else
                   dac_data_a_dual_12bit(i) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   -- Sort Channel A I/Q DAC data T31 - T0 in JESD Mode L-M-F-S-Hd 82380-1TX
   generate_b_dual12bits: for i in 32 to 63 generate
       process(tx_core_clk) begin
   
           if(rising_edge(tx_core_clk)) then
               if(dac_jesd_format_mode_cdc = "100" and wide_duc_mode_cdc = '0' ) then
                   dac_data_b_dual_12bit(i-32) <= jesd_fifo_dout_reg2( ((i+1)*16 - 1) downto ((i*16)+4) );
               else
                   dac_data_b_dual_12bit(i-32) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   
   -- Sort Channel A I/Q DAC data T15 - T0 in JESD Mode L-M-F-S-Hd 84111-2TX
   generate_dual_16bits_a: for i in 0 to 7 generate
       process(tx_core_clk) begin
   
           if(rising_edge(tx_core_clk)) then
               if(dac_jesd_format_mode_cdc = "101" and wide_duc_mode_cdc = '0') then
                   dac_data_dual_a(i) <= jesd_fifo_dout_reg2( ((i+1)*16 - 1) downto ((i*16)) );
               else
                   dac_data_dual_a(i) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   -- Sort Channel B I/Q DAC data T15 - T0 in JESD Mode L-M-F-S-Hd 84111-2TX
   generate_dual_16bits_b: for i in 8 to 15 generate
       process(tx_core_clk) begin
   
           if(rising_edge(tx_core_clk)) then
               if(dac_jesd_format_mode_cdc = "101" and wide_duc_mode_cdc = '0') then
                   dac_data_dual_b(i-8) <= jesd_fifo_dout_reg2( ((i+1)*16 - 1) downto ((i*16)) );
               else
                   dac_data_dual_b(i-8) <= (others => '0');
               end if;
           end if;
       end process;
   end generate;
   
   
   process(tx_core_clk) begin
   
       if(rising_edge(tx_core_clk)) then
           if(dac_pack_rst_cdc = '1') then
               tx_tvalid <= '0';
           else
               if(jesd_fifo_dvalid_a_reg3 = '1' or jesd_fifo_dvalid_b_reg3 = '1') then
                   tx_tvalid <= '1';
               end if;
           end if;
       end if;
   end process;
   
   
   -- Pack data into the appropriate JESD lane order based on the 
   -- JESD L-M-F-S-Hd mode of operation
   process(tx_core_clk) begin
   
       if(rising_edge(tx_core_clk)) then
           case dac_jesd_format_mode_cdc is
           
               -- DAC L-M-F-S-Hd mode 82121-1TX
               -- Single Channel 16-Bit I/Q
               when "000" =>
               
                   if(jesd_fifo_dvalid_a_reg3 = '1') then
                       lane_x_data(0) <= dac_data_i_a(6)(15 downto 8) & dac_data_i_a(4)(15 downto 8) & dac_data_i_a(2)(15 downto 8) & dac_data_i_a(0)(15 downto 8);
                       lane_x_data(1) <= dac_data_i_a(6)(7 downto 0)  & dac_data_i_a(4)(7 downto 0)  & dac_data_i_a(2)(7 downto 0)  & dac_data_i_a(0)(7 downto 0);
                       lane_x_data(2) <= dac_data_i_a(7)(15 downto 8) & dac_data_i_a(5)(15 downto 8) & dac_data_i_a(3)(15 downto 8) & dac_data_i_a(1)(15 downto 8);
                       lane_x_data(3) <= dac_data_i_a(7)(7 downto 0)  & dac_data_i_a(5)(7 downto 0)  & dac_data_i_a(3)(7 downto 0)  & dac_data_i_a(1)(7 downto 0);
                       lane_x_data(4) <= dac_data_q_a(6)(15 downto 8) & dac_data_q_a(4)(15 downto 8) & dac_data_q_a(2)(15 downto 8) & dac_data_q_a(0)(15 downto 8);
                       lane_x_data(5) <= dac_data_q_a(6)(7 downto 0)  & dac_data_q_a(4)(7 downto 0)  & dac_data_q_a(2)(7 downto 0)  & dac_data_q_a(0)(7 downto 0);
                       lane_x_data(6) <= dac_data_q_a(7)(15 downto 8) & dac_data_q_a(5)(15 downto 8) & dac_data_q_a(3)(15 downto 8) & dac_data_q_a(1)(15 downto 8);
                       lane_x_data(7) <= dac_data_q_a(7)(7 downto 0)  & dac_data_q_a(5)(7 downto 0)  & dac_data_q_a(3)(7 downto 0)  & dac_data_q_a(1)(7 downto 0);
                   else
                       lane_x_data(0) <= (others => '0');
                       lane_x_data(1) <= (others => '0');
                       lane_x_data(2) <= (others => '0');
                       lane_x_data(3) <= (others => '0');
                       lane_x_data(4) <= (others => '0');
                       lane_x_data(5) <= (others => '0');
                       lane_x_data(6) <= (others => '0');
                       lane_x_data(7) <= (others => '0');
                   end if;
           
               -- DAC L-M-F-S-Hd mode 84111-2TX
               -- Dual Channel 16-Bit I/Q
               when "001" =>
                   
                   if(jesd_fifo_dvalid_a_reg3 = '1') then
                       lane_x_data(0) <= dac_data_i_a_dual(3)(15 downto 8) & dac_data_i_a_dual(2)(15 downto 8) & dac_data_i_a_dual(1)(15 downto 8) & dac_data_i_a_dual(0)(15 downto 8);
                       lane_x_data(1) <= dac_data_i_a_dual(3)(7 downto 0)  & dac_data_i_a_dual(2)(7 downto 0)  & dac_data_i_a_dual(1)(7 downto 0)  & dac_data_i_a_dual(0)(7 downto 0);
                       lane_x_data(2) <= dac_data_q_a_dual(3)(15 downto 8) & dac_data_q_a_dual(2)(15 downto 8) & dac_data_q_a_dual(1)(15 downto 8) & dac_data_q_a_dual(0)(15 downto 8);
                       lane_x_data(3) <= dac_data_q_a_dual(3)(7 downto 0)  & dac_data_q_a_dual(2)(7 downto 0)  & dac_data_q_a_dual(1)(7 downto 0)  & dac_data_q_a_dual(0)(7 downto 0);
                   else
                       lane_x_data(0) <= (others => '0');
                       lane_x_data(1) <= (others => '0');
                       lane_x_data(2) <= (others => '0');
                       lane_x_data(3) <= (others => '0');
                       
                   end if;
                   
                   if(jesd_fifo_dvalid_b_reg3 = '1') then
                       lane_x_data(4) <= dac_data_i_b_dual(3)(15 downto 8) & dac_data_i_b_dual(2)(15 downto 8) & dac_data_i_b_dual(1)(15 downto 8) & dac_data_i_b_dual(0)(15 downto 8);
                       lane_x_data(5) <= dac_data_i_b_dual(3)(7 downto 0)  & dac_data_i_b_dual(2)(7 downto 0)  & dac_data_i_b_dual(1)(7 downto 0)  & dac_data_i_b_dual(0)(7 downto 0);
                       lane_x_data(6) <= dac_data_q_b_dual(3)(15 downto 8) & dac_data_q_b_dual(2)(15 downto 8) & dac_data_q_b_dual(1)(15 downto 8) & dac_data_q_b_dual(0)(15 downto 8);
                       lane_x_data(7) <= dac_data_q_b_dual(3)(7 downto 0)  & dac_data_q_b_dual(2)(7 downto 0)  & dac_data_q_b_dual(1)(7 downto 0)  & dac_data_q_b_dual(0)(7 downto 0);
                       
                   else
                       lane_x_data(4) <= (others => '0');
                       lane_x_data(5) <= (others => '0');
                       lane_x_data(6) <= (others => '0');
                       lane_x_data(7) <= (others => '0');
                   end if;
               
               -- DAC L-M-F-S-Hd mode 81180-1TX
               -- Single Channel 8-Bit Real
               when "011" =>
                   if(jesd_fifo_dvalid_a_reg3 = '1') then
                       lane_x_data(0) <= dac_data_8bit(24) & dac_data_8bit(16) & dac_data_8bit(8)  & dac_data_8bit(0);
                       lane_x_data(1) <= dac_data_8bit(25) & dac_data_8bit(17) & dac_data_8bit(9)  & dac_data_8bit(1);
                       lane_x_data(2) <= dac_data_8bit(26) & dac_data_8bit(18) & dac_data_8bit(10) & dac_data_8bit(2);
                       lane_x_data(3) <= dac_data_8bit(27) & dac_data_8bit(19) & dac_data_8bit(11) & dac_data_8bit(3); 
                       lane_x_data(4) <= dac_data_8bit(28) & dac_data_8bit(20) & dac_data_8bit(12) & dac_data_8bit(4);
                       lane_x_data(5) <= dac_data_8bit(29) & dac_data_8bit(21) & dac_data_8bit(13) & dac_data_8bit(5);
                       lane_x_data(6) <= dac_data_8bit(30) & dac_data_8bit(22) & dac_data_8bit(14) & dac_data_8bit(6);
                       lane_x_data(7) <= dac_data_8bit(31) & dac_data_8bit(23) & dac_data_8bit(15) & dac_data_8bit(7);
                   else
                       lane_x_data(0) <= (others => '0');
                       lane_x_data(1) <= (others => '0');
                       lane_x_data(2) <= (others => '0');
                       lane_x_data(3) <= (others => '0');
                       lane_x_data(4) <= (others => '0');
                       lane_x_data(5) <= (others => '0');
                       lane_x_data(6) <= (others => '0');
                       lane_x_data(7) <= (others => '0');
                   end if;
               
               -- DAC L-M-F-S-Hd mode 82380-1TX
               -- Single Channel 12-Bit I/Q
               when "100" =>
                  
                   if(wide_duc_mode = '1') then  
                       
                       -- Pack for JESD Frame "1001"
                       if(jesd_fifo_dvalid_a_reg3 = '1') then
                           
                           lane_x_data(0) <= dac_data_i_a_12bit(8)(11 downto 4)  & dac_data_i_a_12bit(1)(7 downto 0) & dac_data_i_a_12bit(0)(3 downto 0)  & dac_data_i_a_12bit(1)(11 downto 8) & dac_data_i_a_12bit(0)(11 downto 4);
                           lane_x_data(1) <= dac_data_i_a_12bit(10)(11 downto 4) & dac_data_i_a_12bit(3)(7 downto 0) & dac_data_i_a_12bit(2)(3 downto 0)  & dac_data_i_a_12bit(3)(11 downto 8) & dac_data_i_a_12bit(2)(11 downto 4);
                           lane_x_data(2) <= dac_data_i_a_12bit(12)(11 downto 4) & dac_data_i_a_12bit(5)(7 downto 0) & dac_data_i_a_12bit(4)(3 downto 0)  & dac_data_i_a_12bit(5)(11 downto 8) & dac_data_i_a_12bit(4)(11 downto 4);
                           lane_x_data(3) <= dac_data_i_a_12bit(14)(11 downto 4) & dac_data_i_a_12bit(7)(7 downto 0) & dac_data_i_a_12bit(6)(3 downto 0)  & dac_data_i_a_12bit(7)(11 downto 8) & dac_data_i_a_12bit(6)(11 downto 4);
                                                                                                                                                                                              
                           lane_x_data(4) <= dac_data_q_a_12bit(8)(11 downto 4)  & dac_data_q_a_12bit(1)(7 downto 0) & dac_data_q_a_12bit(0)(3 downto 0)  & dac_data_q_a_12bit(1)(11 downto 8) & dac_data_q_a_12bit(0)(11 downto 4);
                           lane_x_data(5) <= dac_data_q_a_12bit(10)(11 downto 4) & dac_data_q_a_12bit(3)(7 downto 0) & dac_data_q_a_12bit(2)(3 downto 0)  & dac_data_q_a_12bit(3)(11 downto 8) & dac_data_q_a_12bit(2)(11 downto 4);
                           lane_x_data(6) <= dac_data_q_a_12bit(12)(11 downto 4) & dac_data_q_a_12bit(5)(7 downto 0) & dac_data_q_a_12bit(4)(3 downto 0)  & dac_data_q_a_12bit(5)(11 downto 8) & dac_data_q_a_12bit(4)(11 downto 4);
                           lane_x_data(7) <= dac_data_q_a_12bit(14)(11 downto 4) & dac_data_q_a_12bit(7)(7 downto 0) & dac_data_q_a_12bit(6)(3 downto 0)  & dac_data_q_a_12bit(7)(11 downto 8) & dac_data_q_a_12bit(6)(11 downto 4);
                           
                       -- Pack for JESD Frame "0100"     
                       elsif(jesd_fifo_dvalid_a_reg4 = '1') then    
                           
                           lane_x_data(0) <= dac_data_i_a_12bit(16)(3 downto 0) & dac_data_i_a_12bit(17)(11 downto 8) & dac_data_i_a_12bit(16)(11 downto 4)  & dac_data_i_a_12bit(9)(7 downto 0)  & dac_data_i_a_12bit(8)(3 downto 0)  & dac_data_i_a_12bit(9)(11 downto 8) ;  
                           lane_x_data(1) <= dac_data_i_a_12bit(18)(3 downto 0) & dac_data_i_a_12bit(19)(11 downto 8) & dac_data_i_a_12bit(18)(11 downto 4)  & dac_data_i_a_12bit(11)(7 downto 0) & dac_data_i_a_12bit(10)(3 downto 0) & dac_data_i_a_12bit(11)(11 downto 8); 
                           lane_x_data(2) <= dac_data_i_a_12bit(20)(3 downto 0) & dac_data_i_a_12bit(21)(11 downto 8) & dac_data_i_a_12bit(20)(11 downto 4)  & dac_data_i_a_12bit(13)(7 downto 0) & dac_data_i_a_12bit(12)(3 downto 0) & dac_data_i_a_12bit(13)(11 downto 8); 
                           lane_x_data(3) <= dac_data_i_a_12bit(22)(3 downto 0) & dac_data_i_a_12bit(23)(11 downto 8) & dac_data_i_a_12bit(22)(11 downto 4)  & dac_data_i_a_12bit(15)(7 downto 0) & dac_data_i_a_12bit(14)(3 downto 0) & dac_data_i_a_12bit(15)(11 downto 8);
                                                                                                                                                                                                                                                                            
                           lane_x_data(4) <= dac_data_q_a_12bit(16)(3 downto 0) & dac_data_q_a_12bit(17)(11 downto 8) & dac_data_q_a_12bit(16)(11 downto 4)  & dac_data_q_a_12bit(9)(7 downto 0)  & dac_data_q_a_12bit(8)(3 downto 0)  & dac_data_q_a_12bit(9)(11 downto 8) ;   
                           lane_x_data(5) <= dac_data_q_a_12bit(18)(3 downto 0) & dac_data_q_a_12bit(19)(11 downto 8) & dac_data_q_a_12bit(18)(11 downto 4)  & dac_data_q_a_12bit(11)(7 downto 0) & dac_data_q_a_12bit(10)(3 downto 0) & dac_data_q_a_12bit(11)(11 downto 8); 
                           lane_x_data(6) <= dac_data_q_a_12bit(20)(3 downto 0) & dac_data_q_a_12bit(21)(11 downto 8) & dac_data_q_a_12bit(20)(11 downto 4)  & dac_data_q_a_12bit(13)(7 downto 0) & dac_data_q_a_12bit(12)(3 downto 0) & dac_data_q_a_12bit(13)(11 downto 8); 
                           lane_x_data(7) <= dac_data_q_a_12bit(22)(3 downto 0) & dac_data_q_a_12bit(23)(11 downto 8) & dac_data_q_a_12bit(22)(11 downto 4)  & dac_data_q_a_12bit(15)(7 downto 0) & dac_data_q_a_12bit(14)(3 downto 0) & dac_data_q_a_12bit(15)(11 downto 8);
                       
                       -- Pack for JESD Frame "0010"
                       elsif(jesd_fifo_dvalid_a_reg5 = '1') then
                           
                           lane_x_data(0) <= dac_data_i_a_12bit(25)(7 downto 0) & dac_data_i_a_12bit(24)(3 downto 0) & dac_data_i_a_12bit(25)(11 downto 8) & dac_data_i_a_12bit(24)(11 downto 4) & dac_data_i_a_12bit(17)(7 downto 0);
                           lane_x_data(1) <= dac_data_i_a_12bit(27)(7 downto 0) & dac_data_i_a_12bit(26)(3 downto 0) & dac_data_i_a_12bit(27)(11 downto 8) & dac_data_i_a_12bit(26)(11 downto 4) & dac_data_i_a_12bit(19)(7 downto 0);
                           lane_x_data(2) <= dac_data_i_a_12bit(29)(7 downto 0) & dac_data_i_a_12bit(28)(3 downto 0) & dac_data_i_a_12bit(29)(11 downto 8) & dac_data_i_a_12bit(28)(11 downto 4) & dac_data_i_a_12bit(21)(7 downto 0);
                           lane_x_data(3) <= dac_data_i_a_12bit(31)(7 downto 0) & dac_data_i_a_12bit(30)(3 downto 0) & dac_data_i_a_12bit(31)(11 downto 8) & dac_data_i_a_12bit(30)(11 downto 4) & dac_data_i_a_12bit(23)(7 downto 0);
                                                                                                                                                           
                           lane_x_data(4) <= dac_data_q_a_12bit(25)(7 downto 0) & dac_data_q_a_12bit(24)(3 downto 0) & dac_data_q_a_12bit(25)(11 downto 8) & dac_data_q_a_12bit(24)(11 downto 4) & dac_data_q_a_12bit(17)(7 downto 0);
                           lane_x_data(5) <= dac_data_q_a_12bit(27)(7 downto 0) & dac_data_q_a_12bit(26)(3 downto 0) & dac_data_q_a_12bit(27)(11 downto 8) & dac_data_q_a_12bit(26)(11 downto 4) & dac_data_q_a_12bit(19)(7 downto 0);
                           lane_x_data(6) <= dac_data_q_a_12bit(29)(7 downto 0) & dac_data_q_a_12bit(28)(3 downto 0) & dac_data_q_a_12bit(29)(11 downto 8) & dac_data_q_a_12bit(28)(11 downto 4) & dac_data_q_a_12bit(21)(7 downto 0);
                           lane_x_data(7) <= dac_data_q_a_12bit(31)(7 downto 0) & dac_data_q_a_12bit(30)(3 downto 0) & dac_data_q_a_12bit(31)(11 downto 8) & dac_data_q_a_12bit(30)(11 downto 4) & dac_data_q_a_12bit(23)(7 downto 0);
                       
                       else
                           lane_x_data(0) <= (others => '0');
                           lane_x_data(1) <= (others => '0');
                           lane_x_data(2) <= (others => '0');
                           lane_x_data(3) <= (others => '0');
                           lane_x_data(4) <= (others => '0');
                           lane_x_data(5) <= (others => '0');
                           lane_x_data(6) <= (others => '0');
                           lane_x_data(7) <= (others => '0');
                           
                       end if;
                       
                   else
                       -- Pack for JESD Frame "1001"
                       if(jesd_fifo_dvalid_a_reg3 = '1') then
                           lane_x_data(0) <= dac_data_a_dual_12bit(8)(11 downto 4)  & dac_data_a_dual_12bit(1)(7 downto 0) & dac_data_a_dual_12bit(0)(3 downto 0)  & dac_data_a_dual_12bit(1)(11 downto 8) & dac_data_a_dual_12bit(0)(11 downto 4);
                           lane_x_data(1) <= dac_data_a_dual_12bit(10)(11 downto 4) & dac_data_a_dual_12bit(3)(7 downto 0) & dac_data_a_dual_12bit(2)(3 downto 0)  & dac_data_a_dual_12bit(3)(11 downto 8) & dac_data_a_dual_12bit(2)(11 downto 4);
                           lane_x_data(2) <= dac_data_a_dual_12bit(12)(11 downto 4) & dac_data_a_dual_12bit(5)(7 downto 0) & dac_data_a_dual_12bit(4)(3 downto 0)  & dac_data_a_dual_12bit(5)(11 downto 8) & dac_data_a_dual_12bit(4)(11 downto 4);
                           lane_x_data(3) <= dac_data_a_dual_12bit(14)(11 downto 4) & dac_data_a_dual_12bit(7)(7 downto 0) & dac_data_a_dual_12bit(6)(3 downto 0)  & dac_data_a_dual_12bit(7)(11 downto 8) & dac_data_a_dual_12bit(6)(11 downto 4);
                                                                                                                                                                                      
                       -- Pack for JESD Frame "0100"     
                       elsif(jesd_fifo_dvalid_a_reg4 = '1') then    
                           lane_x_data(0) <= dac_data_a_dual_12bit(16)(3 downto 0) & dac_data_a_dual_12bit(17)(11 downto 8) & dac_data_a_dual_12bit(16)(11 downto 4)  & dac_data_a_dual_12bit(9)(7 downto 0)  & dac_data_a_dual_12bit(8)(3 downto 0)  & dac_data_a_dual_12bit(9)(11 downto 8) ;  
                           lane_x_data(1) <= dac_data_a_dual_12bit(18)(3 downto 0) & dac_data_a_dual_12bit(19)(11 downto 8) & dac_data_a_dual_12bit(18)(11 downto 4)  & dac_data_a_dual_12bit(11)(7 downto 0) & dac_data_a_dual_12bit(10)(3 downto 0) & dac_data_a_dual_12bit(11)(11 downto 8); 
                           lane_x_data(2) <= dac_data_a_dual_12bit(20)(3 downto 0) & dac_data_a_dual_12bit(21)(11 downto 8) & dac_data_a_dual_12bit(20)(11 downto 4)  & dac_data_a_dual_12bit(13)(7 downto 0) & dac_data_a_dual_12bit(12)(3 downto 0) & dac_data_a_dual_12bit(13)(11 downto 8); 
                           lane_x_data(3) <= dac_data_a_dual_12bit(22)(3 downto 0) & dac_data_a_dual_12bit(23)(11 downto 8) & dac_data_a_dual_12bit(22)(11 downto 4)  & dac_data_a_dual_12bit(15)(7 downto 0) & dac_data_a_dual_12bit(14)(3 downto 0) & dac_data_a_dual_12bit(15)(11 downto 8);
                                                                                                                                                                                                                                                                
                       -- Pack for JESD Frame "0010"
                       elsif(jesd_fifo_dvalid_a_reg5 = '1') then
                           lane_x_data(0) <= dac_data_a_dual_12bit(25)(7 downto 0) & dac_data_a_dual_12bit(24)(3 downto 0) & dac_data_a_dual_12bit(25)(11 downto 8) & dac_data_a_dual_12bit(24)(11 downto 4) & dac_data_a_dual_12bit(17)(7 downto 0);
                           lane_x_data(1) <= dac_data_a_dual_12bit(27)(7 downto 0) & dac_data_a_dual_12bit(26)(3 downto 0) & dac_data_a_dual_12bit(27)(11 downto 8) & dac_data_a_dual_12bit(26)(11 downto 4) & dac_data_a_dual_12bit(19)(7 downto 0);
                           lane_x_data(2) <= dac_data_a_dual_12bit(29)(7 downto 0) & dac_data_a_dual_12bit(28)(3 downto 0) & dac_data_a_dual_12bit(29)(11 downto 8) & dac_data_a_dual_12bit(28)(11 downto 4) & dac_data_a_dual_12bit(21)(7 downto 0);
                           lane_x_data(3) <= dac_data_a_dual_12bit(31)(7 downto 0) & dac_data_a_dual_12bit(30)(3 downto 0) & dac_data_a_dual_12bit(31)(11 downto 8) & dac_data_a_dual_12bit(30)(11 downto 4) & dac_data_a_dual_12bit(23)(7 downto 0);
                                                                                                                                                     
                       else
                           lane_x_data(0) <= (others => '0'); 
                           lane_x_data(1) <= (others => '0');
                           lane_x_data(2) <= (others => '0');
                           lane_x_data(3) <= (others => '0');
                       end if; 
                       
                       -- Pack for JESD Frame "1001"
                       if(jesd_fifo_dvalid_b_reg3 = '1') then

                           lane_x_data(4) <= dac_data_b_dual_12bit(8)(11 downto 4)  & dac_data_b_dual_12bit(1)(7 downto 0) & dac_data_b_dual_12bit(0)(3 downto 0)  & dac_data_b_dual_12bit(1)(11 downto 8) & dac_data_b_dual_12bit(0)(11 downto 4);
                           lane_x_data(5) <= dac_data_b_dual_12bit(10)(11 downto 4) & dac_data_b_dual_12bit(3)(7 downto 0) & dac_data_b_dual_12bit(2)(3 downto 0)  & dac_data_b_dual_12bit(3)(11 downto 8) & dac_data_b_dual_12bit(2)(11 downto 4);
                           lane_x_data(6) <= dac_data_b_dual_12bit(12)(11 downto 4) & dac_data_b_dual_12bit(5)(7 downto 0) & dac_data_b_dual_12bit(4)(3 downto 0)  & dac_data_b_dual_12bit(5)(11 downto 8) & dac_data_b_dual_12bit(4)(11 downto 4);
                           lane_x_data(7) <= dac_data_b_dual_12bit(14)(11 downto 4) & dac_data_b_dual_12bit(7)(7 downto 0) & dac_data_b_dual_12bit(6)(3 downto 0)  & dac_data_b_dual_12bit(7)(11 downto 8) & dac_data_b_dual_12bit(6)(11 downto 4);
                           
                       -- Pack for JESD Frame "0100"     
                       elsif(jesd_fifo_dvalid_b_reg4 = '1') then    
                                                                                                                                                                                                                                                                
                           lane_x_data(4) <= dac_data_b_dual_12bit(16)(3 downto 0) & dac_data_b_dual_12bit(17)(11 downto 8) & dac_data_b_dual_12bit(16)(11 downto 4)  & dac_data_b_dual_12bit(9)(7 downto 0)  & dac_data_b_dual_12bit(8)(3 downto 0)  & dac_data_b_dual_12bit(9)(11 downto 8) ;   
                           lane_x_data(5) <= dac_data_b_dual_12bit(18)(3 downto 0) & dac_data_b_dual_12bit(19)(11 downto 8) & dac_data_b_dual_12bit(18)(11 downto 4)  & dac_data_b_dual_12bit(11)(7 downto 0) & dac_data_b_dual_12bit(10)(3 downto 0) & dac_data_b_dual_12bit(11)(11 downto 8); 
                           lane_x_data(6) <= dac_data_b_dual_12bit(20)(3 downto 0) & dac_data_b_dual_12bit(21)(11 downto 8) & dac_data_b_dual_12bit(20)(11 downto 4)  & dac_data_b_dual_12bit(13)(7 downto 0) & dac_data_b_dual_12bit(12)(3 downto 0) & dac_data_b_dual_12bit(13)(11 downto 8); 
                           lane_x_data(7) <= dac_data_b_dual_12bit(22)(3 downto 0) & dac_data_b_dual_12bit(23)(11 downto 8) & dac_data_b_dual_12bit(22)(11 downto 4)  & dac_data_b_dual_12bit(15)(7 downto 0) & dac_data_b_dual_12bit(14)(3 downto 0) & dac_data_b_dual_12bit(15)(11 downto 8);
                           
                       -- Pack for JESD Frame "0010"
                       elsif(jesd_fifo_dvalid_b_reg5 = '1') then

                           lane_x_data(4) <= dac_data_b_dual_12bit(25)(7 downto 0) & dac_data_b_dual_12bit(24)(3 downto 0) & dac_data_b_dual_12bit(25)(11 downto 8) & dac_data_b_dual_12bit(24)(11 downto 4) & dac_data_b_dual_12bit(17)(7 downto 0);
                           lane_x_data(5) <= dac_data_b_dual_12bit(27)(7 downto 0) & dac_data_b_dual_12bit(26)(3 downto 0) & dac_data_b_dual_12bit(27)(11 downto 8) & dac_data_b_dual_12bit(26)(11 downto 4) & dac_data_b_dual_12bit(19)(7 downto 0);
                           lane_x_data(6) <= dac_data_b_dual_12bit(29)(7 downto 0) & dac_data_b_dual_12bit(28)(3 downto 0) & dac_data_b_dual_12bit(29)(11 downto 8) & dac_data_b_dual_12bit(28)(11 downto 4) & dac_data_b_dual_12bit(21)(7 downto 0);
                           lane_x_data(7) <= dac_data_b_dual_12bit(31)(7 downto 0) & dac_data_b_dual_12bit(30)(3 downto 0) & dac_data_b_dual_12bit(31)(11 downto 8) & dac_data_b_dual_12bit(30)(11 downto 4) & dac_data_b_dual_12bit(23)(7 downto 0);
                       
                       else
                           lane_x_data(4) <= (others => '0');
                           lane_x_data(5) <= (others => '0');
                           lane_x_data(6) <= (others => '0');
                           lane_x_data(7) <= (others => '0');
                       end if; 
                       
                   end if;
               
               when "101" =>
                   if(wide_duc_mode = '1') then
                       if(jesd_fifo_dvalid_a_reg3 = '1') then
                           lane_x_data(0) <= dac_data_i_a(6)(15 downto 8) & dac_data_i_a(4)(15 downto 8) & dac_data_i_a(2)(15 downto 8) & dac_data_i_a(0)(15 downto 8);
                           lane_x_data(1) <= dac_data_i_a(6)(7 downto 0)  & dac_data_i_a(4)(7 downto 0)  & dac_data_i_a(2)(7 downto 0)  & dac_data_i_a(0)(7 downto 0);
                           lane_x_data(2) <= dac_data_i_a(7)(15 downto 8) & dac_data_i_a(5)(15 downto 8) & dac_data_i_a(3)(15 downto 8) & dac_data_i_a(1)(15 downto 8);
                           lane_x_data(3) <= dac_data_i_a(7)(7 downto 0)  & dac_data_i_a(5)(7 downto 0)  & dac_data_i_a(3)(7 downto 0)  & dac_data_i_a(1)(7 downto 0);
                           lane_x_data(4) <= dac_data_q_a(6)(15 downto 8) & dac_data_q_a(4)(15 downto 8) & dac_data_q_a(2)(15 downto 8) & dac_data_q_a(0)(15 downto 8);
                           lane_x_data(5) <= dac_data_q_a(6)(7 downto 0)  & dac_data_q_a(4)(7 downto 0)  & dac_data_q_a(2)(7 downto 0)  & dac_data_q_a(0)(7 downto 0);
                           lane_x_data(6) <= dac_data_q_a(7)(15 downto 8) & dac_data_q_a(5)(15 downto 8) & dac_data_q_a(3)(15 downto 8) & dac_data_q_a(1)(15 downto 8);
                           lane_x_data(7) <= dac_data_q_a(7)(7 downto 0)  & dac_data_q_a(5)(7 downto 0)  & dac_data_q_a(3)(7 downto 0)  & dac_data_q_a(1)(7 downto 0);
                       else
                           lane_x_data(0) <= (others => '0');
                           lane_x_data(1) <= (others => '0');
                           lane_x_data(2) <= (others => '0');
                           lane_x_data(3) <= (others => '0');
                           lane_x_data(4) <= (others => '0');
                           lane_x_data(5) <= (others => '0');
                           lane_x_data(6) <= (others => '0');
                           lane_x_data(7) <= (others => '0');
                       end if;
                       
                   else
                       if(jesd_fifo_dvalid_a_reg3 = '1') then
                           lane_x_data(0) <= dac_data_dual_a(6)(15 downto 8) & dac_data_dual_a(4)(15 downto 8) & dac_data_dual_a(2)(15 downto 8) & dac_data_dual_a(0)(15 downto 8);
                           lane_x_data(1) <= dac_data_dual_a(6)(7 downto 0)  & dac_data_dual_a(4)(7 downto 0)  & dac_data_dual_a(2)(7 downto 0)  & dac_data_dual_a(0)(7 downto 0);
                           lane_x_data(2) <= dac_data_dual_a(7)(15 downto 8) & dac_data_dual_a(5)(15 downto 8) & dac_data_dual_a(3)(15 downto 8) & dac_data_dual_a(1)(15 downto 8);
                           lane_x_data(3) <= dac_data_dual_a(7)(7 downto 0)  & dac_data_dual_a(5)(7 downto 0)  & dac_data_dual_a(3)(7 downto 0)  & dac_data_dual_a(1)(7 downto 0);
                           
                       else
                           lane_x_data(0) <= (others => '0');
                           lane_x_data(1) <= (others => '0');
                           lane_x_data(2) <= (others => '0');
                           lane_x_data(3) <= (others => '0');
                       
                       end if;
                       
                       if(jesd_fifo_dvalid_b_reg3 = '1') then
                           lane_x_data(4) <= dac_data_dual_b(6)(15 downto 8) & dac_data_dual_b(4)(15 downto 8) & dac_data_dual_b(2)(15 downto 8) & dac_data_dual_b(0)(15 downto 8);
                           lane_x_data(5) <= dac_data_dual_b(6)(7 downto 0)  & dac_data_dual_b(4)(7 downto 0)  & dac_data_dual_b(2)(7 downto 0)  & dac_data_dual_b(0)(7 downto 0);
                           lane_x_data(6) <= dac_data_dual_b(7)(15 downto 8) & dac_data_dual_b(5)(15 downto 8) & dac_data_dual_b(3)(15 downto 8) & dac_data_dual_b(1)(15 downto 8);
                           lane_x_data(7) <= dac_data_dual_b(7)(7 downto 0)  & dac_data_dual_b(5)(7 downto 0)  & dac_data_dual_b(3)(7 downto 0)  & dac_data_dual_b(1)(7 downto 0);
                           
                       else
                           lane_x_data(4) <= (others => '0');
                           lane_x_data(5) <= (others => '0');
                           lane_x_data(6) <= (others => '0');
                           lane_x_data(7) <= (others => '0');
                           
                       end if;
                   end if;
               
               when others =>
                   lane_x_data(0) <= (others => '0');
                   lane_x_data(1) <= (others => '0');
                   lane_x_data(2) <= (others => '0');
                   lane_x_data(3) <= (others => '0');
                   lane_x_data(4) <= (others => '0');
                   lane_x_data(5) <= (others => '0');
                   lane_x_data(6) <= (others => '0');
                   lane_x_data(7) <= (others => '0'); 
           end case;
       end if;
   end process;

   m_axis_jesd_tx_tdata  <= lane_x_data(7) & lane_x_data(6) & lane_x_data(5) & lane_x_data(4) &
                            lane_x_data(3) & lane_x_data(2) & lane_x_data(1) & lane_x_data(0);
   m_axis_jesd_tx_tvalid <= tx_tvalid;


end Behavioral;
