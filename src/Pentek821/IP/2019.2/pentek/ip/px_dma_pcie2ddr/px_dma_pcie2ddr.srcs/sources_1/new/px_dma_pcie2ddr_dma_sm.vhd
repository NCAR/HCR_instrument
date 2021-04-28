-------------------------------------------------------------------------------
-- Pentek PCIe to DDR4 DMA State Machine
-------------------------------------------------------------------------------
-- px_dma_pcie2ddr_dma_sm.vhd
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


--------------------------------------------------------------------------------
 
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_dma_pcie2ddr_dma_sm is
port (
  clk                         : in  std_logic;
  rst_n                       : in  std_logic;
  ----------------------------------------------------------------------------
  -- Buffer Read Requests to PCIe Reader Module
  ----------------------------------------------------------------------------
  buffer_rd_rqst_valid        : out std_logic; 
  buffer_rd_rqst_ready        : in  std_logic; 
  buffer_rd_rqst_data         : out std_logic_vector(135 downto 0);
  -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
  -- buffer_rd_rqst_data[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
  -- buffer_rd_rqst_data[127:96]  = Size in bytes
  -- buffer_rd_rqst_data[129:128] = PCIe AT 
  -- buffer_rd_rqst_data[135:130] = Reserved                                                               
  pcie_rd_complete            : in  std_logic; -- All reads of PCIe required for the DMA have completed.       
  ddr_wr_complete             : in  std_logic; -- All writes to DDR4 SDRAM required for the DMA have completed.         
  buffer_actual_bytes         : in  std_logic_vector(31 downto 0); -- Actual number of bytes sent
  all_tags_returned           : in  std_logic;
  buffer_actual_bytes_valid   : in  std_logic;         
  ----------------------------------------------------------------------------
  -- Controls
  ----------------------------------------------------------------------------
  dma_restart                 : in  std_logic; -- DMA Reset
  dma_advance                 : in  std_logic; -- DMA Advance
  dma_abort                   : in  std_logic; -- DMA Abort
  abort_all_out               : out std_logic; -- Abort to associated logic
  abort_all_done              : in  std_logic; 
  source_addr                 : in  std_logic_vector(63 downto 0);   
  dest_addr                   : in  std_logic_vector(31 downto 0);
  length                      : in  std_logic_vector(31 downto 0);
  pcie_at                     : in  std_logic_vector(1 downto 0);
  ----------------------------------------------------------------------------
  -- Status
  ----------------------------------------------------------------------------
  abort_cmplt                 : out std_logic; -- Abort Complete Status
  dma_active                  : out std_logic; -- Active Status 
  dma_end                     : out std_logic; -- DMA End interrupt pulse (one clock cycle)
  bytes_last_transferred      : out std_logic_vector(31 downto 0)  -- Last Bytes Transferred
  );
end px_dma_pcie2ddr_dma_sm;

architecture Behavioral of px_dma_pcie2ddr_dma_sm is

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

type state_type is (
   RESET_STATE,
   RD_LINK_DESCR_STATE,
   WAIT_DESCR_VALID_STATE,
   STRT_READ_STATE,
   SEND_BUF_READ_STATE,
   WAIT_PCIE_RD_CMPLT_STATE,
   WAIT_DDR_WR_CMPLT_STATE,
   EXEC_CMPLT_STATE,
   ABORT_STATE,
   ABORT_CMPLT_STATE
);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal state                        : state_type := RESET_STATE;
signal t1_start_link_descr_addr     : std_logic_vector(15 downto 0) := (others => '0');
signal first_time                   : std_logic := '0';
signal t1_rst                       : std_logic := '0';
signal t2_rst                       : std_logic := '0';
signal t1_dma_restart               : std_logic := '0';        
signal descriptor_src_addr          : std_logic_vector(63 downto 0) := (others => '0');           
signal descriptor_bytes_to_transfer : std_logic_vector(31 downto 0) := (others => '0');                             
signal descriptor_dest_addr         : std_logic_vector(31 downto 0) := (others => '0'); 
signal descriptor_incr_value        : std_logic_vector(31 downto 0) := (others => '0');
signal abort_ff                     : std_logic := '0';
signal abort_ex_out                 : std_logic := '0';
signal t1_actual_bytes              : std_logic_vector(31 downto 0) := (others => '0');
signal descriptor_at                : std_logic_vector(1 downto 0)  := (others => '0');
-------------------------------------------------------------------------------

begin


buffer_rd_rqst_data(135 downto 130) <= "000000";  

process(clk)
begin
 if rising_edge(clk) then
    if (t2_rst = '1') or (abort_ex_out = '1') then
        abort_ff <= '0';
    elsif dma_abort = '1' then
        abort_ff <= '1';
    end if;
 end if;
end process;

abort_all_out <= abort_ex_out; 

process(clk)
begin
   if rising_edge(clk) then
      t1_rst <= not rst_n;
      t1_dma_restart <= dma_restart;
      t2_rst <= t1_rst or t1_dma_restart;
      if (t2_rst = '1') then
         state <= RESET_STATE;
         dma_end              <= '0';
         buffer_rd_rqst_valid <= '0';
         dma_active           <= '0';
         abort_ex_out         <= '0';
         abort_cmplt          <= '0';           
         bytes_last_transferred   <= x"00000000";
      else
         case state is
      ----------------------------------------------------------------------
      -- Reset State
      ----------------------------------------------------------------------
            when RESET_STATE =>
               if (t2_rst = '1') then
                  state <= RESET_STATE;  
                  abort_ex_out         <= '0';
               elsif (abort_ff = '1' ) then
                  state        <= ABORT_STATE; 
                  abort_ex_out <= '1';
               elsif (dma_advance = '1') then                            
                  state <= RD_LINK_DESCR_STATE; 
                  first_time   <= '1';
                  abort_ex_out         <= '0';
               else
                  state <= RESET_STATE;
                  abort_ex_out         <= '0';
               end if;   
               buffer_rd_rqst_valid <= '0';
               dma_active           <= '0';
               dma_end              <= '0';
               abort_cmplt          <= '0'; 
      ----------------------------------------------------------------------
      -- Read Link Descriptor State
      ---------------------------------------------------------------------- 
            when RD_LINK_DESCR_STATE =>
               dma_active           <= '0'; 
               dma_end              <= '0';  
               -- Latch AT
               descriptor_at                    <= pcie_at;
               -- Latch Length
               if (length(31 downto 2) /= 0) then -- Don't allow a length of 0
                 descriptor_bytes_to_transfer   <= length(31 downto 2) & "00";
               else
                 descriptor_bytes_to_transfer   <= length(31 downto 3) & "100"; 
               end if;
               -- Latch Source Address
               descriptor_src_addr              <= source_addr(63 downto 2) & "00";
               descriptor_dest_addr             <= dest_addr(31 downto 2) & "00";
                
               state <= WAIT_DESCR_VALID_STATE;
      ----------------------------------------------------------------------
      -- Wait for Descriptor Valid
      ----------------------------------------------------------------------     
            when WAIT_DESCR_VALID_STATE => 
               if (abort_ff = '1' ) then
                  state            <= ABORT_STATE; 
                  abort_ex_out     <= '1';
               else
                  state           <= STRT_READ_STATE;
               end if;                 
      ----------------------------------------------------------------------
      -- Start Read State
      ----------------------------------------------------------------------
            when STRT_READ_STATE =>
               -- Send Read Request
               if (abort_ff = '1' ) then
                    state               <= ABORT_STATE;
                    abort_ex_out        <= '1';
               else 
                   state <= SEND_BUF_READ_STATE;                
                   buffer_rd_rqst_valid <= '1'; 
                   dma_active           <= '1'; 
                   -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
                   -- buffer_rd_rqst_data[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
                   -- buffer_rd_rqst_data[127:96]  = Size in bytes
                   -- buffer_rd_rqst_data[129:128] = PCIe AT 
                   -- buffer_rd_rqst_data[135:130] = Reserved 
                   buffer_rd_rqst_data(63 downto 0)   <= descriptor_src_addr;
                   buffer_rd_rqst_data(95 downto 64)  <= descriptor_dest_addr;
                   buffer_rd_rqst_data(127 downto 96) <= descriptor_bytes_to_transfer;
                   buffer_rd_rqst_data(129 downto 128)<= descriptor_at; 
              end if;
      ----------------------------------------------------------------------
      -- Send PCIe Buffer Read Request
      ----------------------------------------------------------------------
            when SEND_BUF_READ_STATE =>
               if (abort_ff = '1' ) then
                  state           <= ABORT_STATE;
                  abort_ex_out    <= '1';
               elsif (buffer_rd_rqst_ready = '1') then
                  buffer_rd_rqst_valid <= '0';
                  state <= WAIT_PCIE_RD_CMPLT_STATE;
               else
                  state <= SEND_BUF_READ_STATE;
               end if;
      ----------------------------------------------------------------------
      -- Wait for PCIe Read Complete
      ----------------------------------------------------------------------
            when WAIT_PCIE_RD_CMPLT_STATE =>
               if (abort_ff = '1' ) then
                  state           <= ABORT_STATE;
                  abort_ex_out    <= '1';
               else
                  if (pcie_rd_complete = '1') then  
                    state <= WAIT_DDR_WR_CMPLT_STATE;
                  else
                    state <= WAIT_PCIE_RD_CMPLT_STATE;
                  end if;                   
               end if; 
      ----------------------------------------------------------------------
      -- Wait for DDR4 Write Complete
      ----------------------------------------------------------------------
            when WAIT_DDR_WR_CMPLT_STATE =>
            if (abort_ff = '1' ) then
               state           <= ABORT_STATE;
               abort_ex_out    <= '1';
            else
               if (ddr_wr_complete = '1') then  
                 state <= EXEC_CMPLT_STATE;
               else
                 state <= WAIT_DDR_WR_CMPLT_STATE;
               end if;                   
            end if;         
      ----------------------------------------------------------------------
      -- Execution Complete State
      ----------------------------------------------------------------------  
            when EXEC_CMPLT_STATE =>
               -- Check if end of chain
               if all_tags_returned = '0' then -- wait for all tags to be returned
                  state       <= EXEC_CMPLT_STATE;  -- continue
               else
                  state       <= RESET_STATE; -- Chain end detected so start over
                  dma_end     <= '1'; 
                  dma_active  <= '0';
                  bytes_last_transferred <= t1_actual_bytes;
               end if; 
      ----------------------------------------------------------------------    
            when ABORT_STATE =>
               dma_end                <= '0';
               dma_active             <= '0';
               abort_ex_out           <= '0';
               bytes_last_transferred <= x"00000000";
               if (abort_all_done = '1') then
                  state <= ABORT_CMPLT_STATE;
                  abort_cmplt       <= '1';   
               else
                  state <= ABORT_STATE;
               end if;   
            when ABORT_CMPLT_STATE =>
               state <= RESET_STATE;
               abort_cmplt       <= '0'; 
            when others => 
               state <= RESET_STATE;
         end case; 
       end if;  
   end if;
end process;


process(clk)
begin
    if rising_edge(clk) then
        if buffer_actual_bytes_valid = '1' then
            t1_actual_bytes <= buffer_actual_bytes; 
        end if;
    end if;    
end process;
            
end Behavioral;
