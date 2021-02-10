-------------------------------------------------------------------------------
-- Pentek PCIe to AXI-S DMA State Machine
-------------------------------------------------------------------------------
-- px_dma_pcie2pd_dma_sm.vhd
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
--  
-- Descriptor Control Word
-- [0:0]   = AUTO
-- [1:1]   = Reserved
-- [2:2]   = Reserved
-- [3:3]   = INCR MODE
-- [4:4]   = Reserved
-- [5:5]   = Reserved
-- [6:6]   = 
-- [7:7]   = Use Meta Data bytes to TRNSFR
-- [8:8]   = LINK END INT EN
-- [9:9]   = CHAIN END INT EN
-- [10:10] = CHAIN END
-- [11:11] = 
-- [13:12] = PCIE AT
-- [15:14] = Reserved
-- [31:16] = INCR LOOP COUNT[15:0]

-- Descriptor

-- DWORD 0 -- descriptor_ram_readdata[31:0]	   Control Word
-- DWORD 1 -- descriptor_ram_readdata[63:32]    Bytes to Transfer[31:0]
-- DWORD 2 -- descriptor_ram_readdata[95:64]    Source Address[31:0] 
-- DWORD 3 -- descriptor_ram_readdata[127:96]   Source Address[63:32] 
-- DWORD 4 -- descriptor_ram_readdata[159:128]  Source Meta Data Address[31:0] 
-- DWORD 5 -- descriptor_ram_readdata[191:160]  Source Meta Data Address[63:32] 
-- DWORD 6 -- descriptor_ram_readdata[223:192]  Loop Address Increment Value[31:0] 
-- DWORD 7 -- descriptor_ram_readdata[255:224]  Next Link Address[15:0]

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

entity px_dma_pcie2pd_dma_sm is
port (
  clk                         : in  std_logic;
  rst_n                       : in  std_logic;
  ----------------------------------------------------------------------------
  -- Buffer Read Requests to PCIe Reader Module
  ----------------------------------------------------------------------------
  buffer_rd_rqst_valid        : out std_logic; 
  buffer_rd_rqst_ready        : in  std_logic; 
  buffer_rd_rqst_data         : out std_logic_vector(167 downto 0);
  -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
  -- buffer_rd_rqst_data[127:64]  = Source Meta Address -- Meta Address must be on 16 byte address boundry
  -- buffer_rd_rqst_data[128]     = 0 = Use Descriptor Length 1 = Use Meta Data Length
  -- buffer_rd_rqst_data[130:129] = PCIe AT 
  -- buffer_rd_rqst_data[135:131] = Reserved 
  -- buffer_rd_rqst_data[167:136] = Size in bytes                                                                    
  buffer_rqst_complete        : in  std_logic; -- All HMC requests required for a Buffer Read Request have been issued
  buffer_rd_complete          : in  std_logic; -- All reads of the HMC required for the Buffer Read Request have completed.                
  buffer_actual_bytes         : in  std_logic_vector(31 downto 0); -- Actual number of bytes sent
  all_tags_returned           : in  std_logic;
  buffer_actual_bytes_valid   : in  std_logic;
  ----------------------------------------------------------------------------
  -- Descriptor RAM interface
  ----------------------------------------------------------------------------
  -- Associated with clk
  descriptor_ram_address      : out std_logic_vector(15 downto 0);        
  descriptor_ram_readdata     : in  std_logic_vector(255 downto 0);          
  ----------------------------------------------------------------------------
  -- Controls
  ----------------------------------------------------------------------------
  dma_restart                 : in  std_logic; -- DMA Reset
  dma_advance                 : in  std_logic; -- DMA Advance
  dma_abort                   : in  std_logic; -- DMA Abort
  abort_all_out               : out std_logic; -- Abort to associated logic
  abort_all_done              : in  std_logic; 
  start_link_descr_addr       : in  std_logic_vector(15 downto 0);
  ----------------------------------------------------------------------------
  -- Status
  ----------------------------------------------------------------------------
  abort_cmplt                 : out std_logic; -- Abort Complete Status
  waiting_for_adv             : out std_logic; -- Waiting For Advance Status
  dma_active                  : out std_logic; -- Active Status 
  dma_paused                  : out std_logic; -- Pause Status 
  link_end                    : out std_logic; -- Link End interrupt pulse (one clock cycle)
  chain_end                   : out std_logic; -- Link End interrupt pulse (one clock cycle)
  link_end_int                : out std_logic; -- Link End interrupt pulse (one clock cycle)
  chain_end_int               : out std_logic; -- Link End interrupt pulse (one clock cycle)
  link_start                  : out std_logic; -- Start of link pulse 
 
  current_link_address        : out std_logic_vector(31 downto 0);  -- Current Link
  last_link_address           : out std_logic_vector(31 downto 0);  -- Last Link
  bytes_last_transferred      : out std_logic_vector(31 downto 0)  -- Last Bytes Transferred
  );
end px_dma_pcie2pd_dma_sm;

architecture Behavioral of px_dma_pcie2pd_dma_sm is



-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

type state_type is (
   RESET_STATE,
   RD_LINK_DESCR_STATE,
   RD_LINK_DESCR_STATE2,
   RD_LINK_DESCR_STATE3,
   WAIT_FOR_DESCR_READ_STATE,
   WAIT_DESCR_VALID_STATE,
   WAIT_ADV_STATE,
   STRT_READ_STATE,
   SEND_BUF_READ_STATE,
   WAIT_BUF_WRITE_CMPLT_STATE,
   EXEC_CMPLT_STATE,
   LOOP_INCR_STATE,
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
signal descriptor_control_word      : std_logic_vector(31 downto 0) := (others => '0');         
signal descriptor_src_addr          : std_logic_vector(63 downto 0) := (others => '0');           
signal descriptor_bytes_to_transfer : std_logic_vector(31 downto 0) := (others => '0');    
signal descriptor_next_link_addr    : std_logic_vector(15 downto 0) := (others => '0');       
signal descriptor_sync_addr         : std_logic_vector(15 downto 0) := (others => '0');                           
signal descriptor_src_meta_addr     : std_logic_vector(63 downto 0) := (others => '0'); 
signal loop_cnt                     : std_logic_vector(15 downto 0) := (others => '0');
signal descriptor_incr_value        : std_logic_vector(31 downto 0) := (others => '0');
signal loop_cmplt                   : std_logic := '0'; 
signal loop_cntr                    : std_logic_vector(15 downto 0) := (others => '0');
signal src_addr_cntr                : std_logic_vector(63 downto 0) := (others => '0');
signal src_meta_addr_cntr           : std_logic_vector(63 downto 0) := (others => '0');
signal cntr_incr                    : std_logic := '0'; 
signal cntr_load                    : std_logic := '0';    
signal first_loop                   : std_logic := '0';   
signal current_link_address_int     : std_logic_vector(31 downto 0) := (others => '0');
signal abort_ff                     : std_logic := '0';
signal abort_ex_out                 : std_logic := '0';
signal descriptor_ram_address_int   : std_logic_vector(15 downto 0) := (others => '0');
signal sum_actual_bytes             : std_logic_vector(31 downto 0) := (others => '0');
signal descriptor_loop_cnt          : std_logic_vector(2 downto 0) := (others => '0');

-------------------------------------------------------------------------------

begin

descriptor_ram_address <= descriptor_ram_address_int;

buffer_rd_rqst_data(135 downto 131) <= "00000";  

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
      t1_start_link_descr_addr <= start_link_descr_addr;
      t2_rst <= t1_rst or t1_dma_restart;
      if (t2_rst = '1') then
         state <= RESET_STATE;
         first_time           <= '0';
         chain_end            <= '0';
         link_end             <= '0';
         waiting_for_adv      <= '1';
         buffer_rd_rqst_valid <= '0';
         dma_paused           <= '0';
         dma_active           <= '0';
         link_end_int         <= '0';
         chain_end_int        <= '0';
         abort_ex_out         <= '0';
         abort_cmplt          <= '0'; 
         link_start           <= '0'; 
         cntr_incr            <= '0';
         cntr_load            <= '0';
         first_loop           <= '0';              
         descriptor_ram_address_int   <= x"0000";      

         descriptor_ram_address_int   <= t1_start_link_descr_addr; -- from register
         current_link_address     <= x"0000" & t1_start_link_descr_addr; -- from register
         last_link_address        <= x"00000000";
         bytes_last_transferred   <= x"00000000";
      else
         case state is
      ----------------------------------------------------------------------
      -- Reset State
      ----------------------------------------------------------------------
            when RESET_STATE =>
               if (t2_rst = '1') then
                  state <= RESET_STATE;  
               elsif (abort_ff = '1' ) then
                  state        <= ABORT_STATE; 
                  abort_ex_out <= '1';
               elsif (dma_advance = '1') then                            
                  state <= RD_LINK_DESCR_STATE; 
                  first_time   <= '1';
               else
                  state <= RESET_STATE;
               end if;   
               chain_end            <= '0';
               link_end             <= '0';
               waiting_for_adv      <= '1';
               buffer_rd_rqst_valid <= '0';
               dma_paused           <= '0';
               dma_active           <= '0';
               link_end_int         <= '0';
               chain_end_int        <= '0';
               abort_cmplt          <= '0'; 
               link_start           <= '0'; 
               cntr_incr            <= '0';
               cntr_load            <= '0';
               first_loop           <= '0'; 

               descriptor_ram_address_int   <= t1_start_link_descr_addr; -- from register
               current_link_address     <= x"0000" & t1_start_link_descr_addr; -- from register
               current_link_address_int <= x"0000" & t1_start_link_descr_addr; -- from register
      ----------------------------------------------------------------------
      -- Read Link Descriptor State
      ---------------------------------------------------------------------- 
            when RD_LINK_DESCR_STATE =>
               if (first_time= '0') then
                  descriptor_ram_address_int   <= descriptor_next_link_addr; -- from last link
                  current_link_address     <= x"0000" & descriptor_next_link_addr;
                  current_link_address_int <= x"0000" & descriptor_next_link_addr;
               end if;              
      
               dma_active           <= '0'; 
               link_end             <= '0';
               link_end_int         <= '0';
               state <= RD_LINK_DESCR_STATE2;
      ----------------------------------------------------------------------
      -- Read Link Descriptor State
      ---------------------------------------------------------------------- 
            when RD_LINK_DESCR_STATE2 =>   
               state    <= RD_LINK_DESCR_STATE3;
      ----------------------------------------------------------------------
      -- Read Link Descriptor State
      ---------------------------------------------------------------------- 
            when RD_LINK_DESCR_STATE3 =>   
               state    <= WAIT_FOR_DESCR_READ_STATE;
               link_start           <= '1'; 
               first_loop           <= '1'; 
      ----------------------------------------------------------------------
      -- Wait for Descriptor Read Result State
      ----------------------------------------------------------------------
            when WAIT_FOR_DESCR_READ_STATE => 
               link_start                   <= '0';
               state    <= WAIT_DESCR_VALID_STATE;
      
                  -- DWORD 0 -- descriptor_ram_readdata[31:0]      Control Word
                  -- DWORD 1 -- descriptor_ram_readdata[63:32]    Bytes to Transfer[31:0]
                  -- DWORD 2 -- descriptor_ram_readdata[95:64]    Source Address[31:0] 
                  -- DWORD 3 -- descriptor_ram_readdata[127:96]   Source Address[63:32] 
                  -- DWORD 4 -- descriptor_ram_readdata[159:128]  Source  Meta Data Address[31:0] 
                  -- DWORD 5 -- descriptor_ram_readdata[191:160]  Source  Meta Data Address[63:32] 
                  -- DWORD 6 -- descriptor_ram_readdata[223:192]  Loop Address Increment Value[31:0] 
                  -- DWORD 7 -- descriptor_ram_readdata[255:224]  Next Link Address[15:0]
                                 
                  -- Latch Descriptor
                  descriptor_control_word          <= descriptor_ram_readdata(31 downto 0);
                  if (descriptor_ram_readdata(63 downto 34) /= 0) then -- Don't allow a length of 0
                    descriptor_bytes_to_transfer   <= descriptor_ram_readdata(63 downto 34) & "00";
                  else
                    descriptor_bytes_to_transfer   <= descriptor_ram_readdata(63 downto 35) & "100"; 
                  end if;
                  descriptor_src_addr              <= descriptor_ram_readdata(127 downto 66) & "00";
                  descriptor_src_meta_addr         <= descriptor_ram_readdata(191 downto 130) & "00";
                  descriptor_incr_value            <= descriptor_ram_readdata(223 downto 192); 
                  descriptor_next_link_addr        <= descriptor_ram_readdata(239 downto 229) & "00000";    
                  cntr_load                    <= '1';             
      ----------------------------------------------------------------------
      -- Wait for Link Descriptor Valid
      ----------------------------------------------------------------------     
            when WAIT_DESCR_VALID_STATE => 
               cntr_load            <= '0'; 
               if (abort_ff = '1' ) then
                  state           <= ABORT_STATE; 
                  abort_ex_out    <= '1';
               -- If manual mode, wait for advance 
               elsif (descriptor_control_word(0) = '0') then
                  if (first_time = '0') then
                    waiting_for_adv<= '1';
                    dma_paused     <= '1';
                    state          <= WAIT_ADV_STATE;
                  else
                    state          <= STRT_READ_STATE;
                  end if; 
               -- If auto mode 
               else
                  state           <= STRT_READ_STATE;
               end if;
               first_time  <= '0'; -- Clear "first time"  
      ----------------------------------------------------------------------
      -- Wait for Advance
      ----------------------------------------------------------------------
            when WAIT_ADV_STATE =>  
               if (abort_ff = '1' ) then
                  state           <= ABORT_STATE;
                  abort_ex_out    <= '1'; 
               -- Advance Pulse occurred.
               elsif (dma_advance = '1') then
                  state           <= STRT_READ_STATE;
               -- Otherwise continue waitng for advance pulse.  
               else
                  state           <= WAIT_ADV_STATE;
               end if;                     
      ----------------------------------------------------------------------
      -- Start Read State
      ----------------------------------------------------------------------
            when STRT_READ_STATE =>
               -- Send Read Request
               if (abort_ff = '1' ) then
                    state           <= ABORT_STATE;
                    abort_ex_out    <= '1';
               else 
                   state <= SEND_BUF_READ_STATE;                
                   buffer_rd_rqst_valid <= '1'; 
                   dma_active        <= '1'; 
                   dma_paused        <= '0';
                   waiting_for_adv   <= '0';
                   
                   -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
                   -- buffer_rd_rqst_data[127:64]  = Source Meta Address -- Meta Address must be on 16 byte address boundry
                   -- buffer_rd_rqst_data[128]     = 0 = Use Descriptor Length 1 = Use Meta Data Length
                   -- buffer_rd_rqst_data[130:129] = PCIe AT 
                   -- buffer_rd_rqst_data[135:131] = Reserved 
                   -- buffer_rd_rqst_data[167:136] = Size in bytes    
                   
                   
                   -- Buffer Read Source Start Address[63:0]
                   if descriptor_control_word(3) = '0' then
                      buffer_rd_rqst_data(63 downto 0)   <= descriptor_src_addr;
                   else 
                      buffer_rd_rqst_data(63 downto 0)   <= src_addr_cntr;
                   end if;     
                   -- Buffer Read Source Meta Data Start Address[63:0] (only 33:0 used)
                   if descriptor_control_word(3) = '0' then
                      buffer_rd_rqst_data(127 downto 64) <= descriptor_src_meta_addr;
                   else
                      buffer_rd_rqst_data(127 downto 64) <= src_meta_addr_cntr;
                   end if;     
                   -- Use Meta Data Length
                   buffer_rd_rqst_data(128)               <= descriptor_control_word(7);
                   -- PCIe AT
                   buffer_rd_rqst_data(130 downto 129)    <= descriptor_control_word(13 downto 12);
                   -- Buffer Size[31:0]
                   buffer_rd_rqst_data(167 downto 136)    <= descriptor_bytes_to_transfer;
                   
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
                  state <= WAIT_BUF_WRITE_CMPLT_STATE;
               else
                  state <= SEND_BUF_READ_STATE;
               end if;
      ----------------------------------------------------------------------
      -- Wait for Buffer Read Complete
      ----------------------------------------------------------------------
            when WAIT_BUF_WRITE_CMPLT_STATE =>
               if (abort_ff = '1' ) then
                  state           <= ABORT_STATE;
                  abort_ex_out    <= '1';
               elsif (descriptor_control_word(3) = '0') then  -- Not loop mode
                  if (buffer_rd_complete = '1') then  
                     --if (descriptor_control_word(5) = '0') then
                         state <= EXEC_CMPLT_STATE;
                     --else
                     --    state <= WRITE_SYNC_STATE;
                     --    m_axis_sync_ram_tuser  <= descriptor_sync_addr(10 downto 1) & '0'; 
                     --    m_axis_sync_ram_tvalid <= '1';                                  
                     --    m_axis_sync_ram_tdata  <= x"01";                                
                     --end if; 
                  else
                    state <= WAIT_BUF_WRITE_CMPLT_STATE;
                  end if;                 
               else -- loop mode
                  if (loop_cmplt = '1') then -- looping is complete
                      if (buffer_rd_complete = '1') then
                         --if (descriptor_control_word(5) = '0') then
                             state <= EXEC_CMPLT_STATE;
                         --else
                         --    state <= WRITE_SYNC_STATE;
                         --    m_axis_sync_ram_tuser  <= descriptor_sync_addr(10 downto 1) & '0'; 
                         --    m_axis_sync_ram_tvalid <= '1';                                  
                         --    m_axis_sync_ram_tdata  <= x"01";                                
                         --end if;
                      else
                         state <= WAIT_BUF_WRITE_CMPLT_STATE;
                      end if;   
                  else -- loop
                     state <= LOOP_INCR_STATE;
                     cntr_incr <= '1';          
                  end if;           
               end if;
      ----------------------------------------------------------------------
      -- Loop Increment State             
      ----------------------------------------------------------------------
           when LOOP_INCR_STATE =>
             cntr_incr <= '0';
             first_loop <= '0';
             state            <= STRT_READ_STATE;    
      ----------------------------------------------------------------------
      -- Execution Complete State
      ----------------------------------------------------------------------  
            when EXEC_CMPLT_STATE =>
               -- Check if end of chain
               if all_tags_returned = '0' then -- wait for all tags to be returned
                  state    <= EXEC_CMPLT_STATE;  -- continue
               elsif (descriptor_control_word(10) = '1') then
                  state <= RESET_STATE; -- Chain end detected so start over
                  chain_end     <= '1'; 
                  chain_end_int <= descriptor_control_word(9);
               else
                  state <= RD_LINK_DESCR_STATE; -- Continue to next link descriptor
               end if; 
               if all_tags_returned = '1' then -- wait for all tags to be returned
                dma_active       <= '0';
                link_end         <= '1';
                link_end_int     <= descriptor_control_word(8);
                last_link_address<= current_link_address_int;
                bytes_last_transferred <= sum_actual_bytes;
               end if; 
      ----------------------------------------------------------------------    
            when ABORT_STATE =>
               first_time           <= '0';
               chain_end            <= '0';
               link_end             <= '0';
               waiting_for_adv      <= '0';
               buffer_rd_rqst_valid <= '0';
               dma_paused           <= '0';
               dma_active           <= '0';
               link_end_int         <= '0';
               chain_end_int        <= '0';
               abort_ex_out         <= '0';
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
        --loop_cnt <= descriptor_control_word(31 downto 16);
        if t2_rst = '1' then
            src_addr_cntr       <= (others => '0');
            src_meta_addr_cntr  <= (others => '0');
            loop_cntr           <= (others => '0');
        elsif cntr_load = '1' then
            src_addr_cntr       <= descriptor_src_addr;     
            src_meta_addr_cntr  <= descriptor_src_meta_addr;
            loop_cntr           <= descriptor_control_word(31 downto 16); --loop_cnt;
                  
        elsif cntr_incr = '1' then   -- Only the lower 32 bits of addresses increment, upper 32 bits stay latched.
            src_addr_cntr(31 downto 0)      <= src_addr_cntr(31 downto 0) + descriptor_incr_value; 
            src_meta_addr_cntr(31 downto 0)     <= src_meta_addr_cntr(31 downto 0) + x"00000010";

            if loop_cntr /= x"0000" then
                loop_cntr       <= loop_cntr - 1;
            end if;     
        end if;
        if  (loop_cntr = x"0000") then
            loop_cmplt <= '1';
        else
            loop_cmplt <= '0';
        end if;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if cntr_load = '1' then
            sum_actual_bytes <= (others => '0');
        elsif buffer_actual_bytes_valid = '1' then
            sum_actual_bytes <= sum_actual_bytes + buffer_actual_bytes; 
        end if;
    end if;    
end process;
            
end Behavioral;
