--------------------------------------------------------------------------------
-- Pentek Data Stream to PCIe DMA State Machine
--------------------------------------------------------------------------------
-- px_dma_ppkt2axi_dma_sm.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2018
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 
--  
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- Descriptor Control Word
-- [0:0]   = AUTO
-- [1:1]   = Reserved
-- [2:2]   = Reserved
-- [3:3]   = INCR AXI MODE
-- [4:4]   = Reserved
-- [5:5]   = Reserved
-- [6:6]   = Reserved
-- [7:7]   = EOP END
-- [8:8]   = LINK END INT EN
-- [9:9]   = CHAIN END INT EN
-- [10:10] = CHAIN END
-- [11:11] = Output Meta Data
-- [13:12] = Reserved
-- [15:14] = Reserved

-- Descriptor

-- DWORD 0 -- descriptor_ram_readdata[31:0]	   Control Word
-- DWORD 1 -- descriptor_ram_readdata[63:32]    Bytes to Transfer[31:0]
-- DWORD 2 -- descriptor_ram_readdata[95:64]    Destination Address[31:0] 
-- DWORD 3 -- descriptor_ram_readdata[127:96]   Destination Address[63:32] 
-- DWORD 4 -- descriptor_ram_readdata[159:128]  Destination  Meta Data Address[31:0] 
-- DWORD 5 -- descriptor_ram_readdata[191:160]  Destination  Meta Data Address[63:32] 
-- DWORD 6 -- descriptor_ram_readdata[223:192]  Next Link Address[31:0]
-- DWORD 7 -- descriptor_ram_readdata[255:224]  Next Link Address[63:32]
 
-------------------------------------------------------------------------------

-- (c) Copyright 2018 Pentek, Inc. All rights reserved.
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

entity px_dma_ppld2axi_dma_sm is
generic(
desc_ram_addr_width         : integer range 7 to 64 := 32   
);
port (
  clk                         : in  std_logic;
  rst_n                       : in  std_logic;
  ----------------------------------------------------------------------------
  -- Buffer Read Requests to Reader Module
  ----------------------------------------------------------------------------
  buffer_rd_rqst_valid        : out std_logic; 
  buffer_rd_rqst_ready        : in  std_logic; 
  buffer_rd_rqst_data         : out std_logic_vector(167 downto 0);
  -- buffer_rd_rqst_data[63:0]    = Destination Start Address -- PCIe Address -- Address must be on 4 byte address boundary
  -- buffer_rd_rqst_data[127:64]  = Destination Meta Start Address  -- Address must be on 4 byte address boundary
  -- buffer_rd_rqst_data[159:128] = Size in bytes
  -- buffer_rd_rqst_data[160]     = Write Meta Data
  -- buffer_rd_rqst_data[161]     = INCR AXI Type 
  -- buffer_rd_rqst_data[162]     = Reserved 
  -- buffer_rd_rqst_data[163]     = Allow end on EOF      
  -- buffer_rd_rqst_data[167:164] = reserved
  buffer_rd_complete          : in  std_logic; -- All reads of FIFO required for the Buffer Read Request have completed.                
  buffer_actual_bytes         : in  std_logic_vector(31 downto 0); -- Actual number of bytes sent
  buffer_actual_bytes_valid   : in  std_logic;                      
  ----------------------------------------------------------------------------
  -- Descriptor RAM interface
  ----------------------------------------------------------------------------
  -- Associated with clk
  m_axi_descr_araddr          : out std_logic_vector(desc_ram_addr_width -1 downto 0);
  m_axi_descr_arprot          : out std_logic_vector(2 downto 0);
  m_axi_descr_arsize          : out std_logic_vector(2 downto 0);
  m_axi_descr_arburst         : out std_logic_vector(1 downto 0);
  m_axi_descr_arlen           : out std_logic_vector(7 downto 0);
  m_axi_descr_arvalid         : out std_logic;
  m_axi_descr_arready         : in  std_logic;
  m_axi_descr_rdata           : in  std_logic_vector(255 downto 0);
  m_axi_descr_rresp           : in  std_logic_vector(1 downto 0);
  m_axi_descr_rvalid          : in  std_logic;
  m_axi_descr_rlast           : in  std_logic;
  m_axi_descr_rready          : out std_logic;          
  ----------------------------------------------------------------------------
  -- Controls
  ----------------------------------------------------------------------------
  dma_restart                 : in  std_logic; -- DMA Reset
  dma_advance                 : in  std_logic; -- DMA Advance
  dma_abort                   : in  std_logic; -- DMA Abort
  abort_all_out               : out std_logic; -- Abort to associated logic
  abort_all_done              : in  std_logic; 
  start_link_descr_addr       : in  std_logic_vector(63 downto 0);
  ----------------------------------------------------------------------------
  -- Status
  ----------------------------------------------------------------------------
  abort_cmplt                 : out std_logic; -- Abort Complete Status
  dma_active                  : out std_logic; -- Active Status 
  dma_paused                  : out std_logic; -- Pause Status 
  waiting_for_adv             : out std_logic; -- Waiting For Advance Status
  link_end                    : out std_logic; -- Link End interrupt pulse (one clock cycle)
  chain_end                   : out std_logic; -- Link End interrupt pulse (one clock cycle)
  link_end_int                : out std_logic; -- Link End interrupt pulse (one clock cycle)
  chain_end_int               : out std_logic; -- Link End interrupt pulse (one clock cycle)
  link_start                  : out std_logic; -- Start of link pulse 
 
  current_link_address        : out std_logic_vector(63 downto 0);  -- Current Link
  last_link_address           : out std_logic_vector(63 downto 0);  -- Last Link
  bytes_last_transferred      : out std_logic_vector(31 downto 0)   -- Last Bytes Transferred
  );
end px_dma_ppld2axi_dma_sm;

architecture Behavioral of px_dma_ppld2axi_dma_sm is

 -------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

type state_type is (
   RESET_STATE,
   RD_LINK_DESCR_STATE,
   RD_LINK_DESCR_STATE2,
   RD_LINK_DESCR_STATE2a,
   RD_LINK_DESCR_STATE3,
   WAIT_FOR_DESCR_READ_STATE,
   WAIT_FOR_DESCR_READ_STATE2,
   WAIT_DESCR_VALID_STATE,
   WAIT_ADV_STATE,
   STRT_READ_STATE,
   SEND_BUF_READ_STATE,
   WAIT_BUF_READ_CMPLT_STATE,
   EXEC_CMPLT_STATE,
   LOOP_INCR_STATE,
   ABORT_STATE,
   ABORT_CMPLT_STATE
);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal state                        : state_type := RESET_STATE;
signal t1_start_link_descr_addr     : std_logic_vector(63 downto 0) := (others => '0');
signal first_time                   : std_logic := '0';
signal t1_rst                       : std_logic := '0';
signal t2_rst                       : std_logic := '0';
signal t1_dma_restart               : std_logic := '0';
signal descriptor_control_word      : std_logic_vector(31 downto 0) := (others => '0');         
signal descriptor_src_addr          : std_logic_vector(63 downto 0) := (others => '0'); 
signal descriptor_dest_addr         : std_logic_vector(63 downto 0) := (others => '0');            
signal descriptor_bytes_to_transfer : std_logic_vector(31 downto 0) := (others => '0');    
signal descriptor_next_link_addr    : std_logic_vector(63 downto 0) := (others => '0');                                 
signal descriptor_src_meta_addr     : std_logic_vector(63 downto 0) := (others => '0'); 
signal descriptor_dest_meta_addr    : std_logic_vector(63 downto 0) := (others => '0'); 
signal loop_cnt                     : std_logic_vector(15 downto 0) := (others => '0');
signal src_addr_cntr                : std_logic_vector(63 downto 0) := (others => '0');
signal src_meta_addr_cntr           : std_logic_vector(63 downto 0) := (others => '0');
signal dest_addr_cntr               : std_logic_vector(63 downto 0) := (others => '0');
signal dest_meta_addr_cntr          : std_logic_vector(63 downto 0) := (others => '0');  
signal current_link_address_int     : std_logic_vector(63 downto 0) := (others => '0');
signal abort_ff                     : std_logic := '0';
signal abort_ex_out                 : std_logic := '0';
signal descriptor_ram_address_int   : std_logic_vector(15 downto 0) := (others => '0');
signal sum_actual_bytes             : std_logic_vector(31 downto 0) := (others => '0');
signal descriptor_ram_readdata      : std_logic_vector(255 downto 0) := (others => '0');

begin


  m_axi_descr_arprot          <= "000";
  m_axi_descr_arsize          <= "110"; -- 64 byte width
  m_axi_descr_arburst         <= "00";  -- fixed 
  m_axi_descr_arlen           <= x"00"; -- 1
  m_axi_descr_rready          <= '1';       

buffer_rd_rqst_data(167 downto 164)    <= "0000";
buffer_rd_rqst_data(162)               <= '0'; 

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
         m_axi_descr_arvalid  <= '0';           
         m_axi_descr_araddr       <= t1_start_link_descr_addr(desc_ram_addr_width -1 downto 0); -- from register
         current_link_address     <= t1_start_link_descr_addr; -- from register
         last_link_address        <= x"0000000000000000";
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
               m_axi_descr_araddr       <= t1_start_link_descr_addr(desc_ram_addr_width -1 downto 0); -- from register
               m_axi_descr_arvalid  <= '0'; 
               current_link_address     <= t1_start_link_descr_addr; -- from register
               current_link_address_int <= t1_start_link_descr_addr; -- from register
      ----------------------------------------------------------------------
      -- Read Link Descriptor State
      ---------------------------------------------------------------------- 
            when RD_LINK_DESCR_STATE =>
               if (first_time= '0') then
                  m_axi_descr_araddr       <= descriptor_next_link_addr(desc_ram_addr_width -1 downto 0);
                  current_link_address     <= descriptor_next_link_addr;
                  current_link_address_int <= descriptor_next_link_addr;
               end if;              

               dma_active           <= '0'; 
               link_end             <= '0';
               link_end_int         <= '0';
               state <= RD_LINK_DESCR_STATE2;
               m_axi_descr_arvalid         <= '1';              
      ----------------------------------------------------------------------
      -- Read Link Descriptor State
      ---------------------------------------------------------------------- 
            when RD_LINK_DESCR_STATE2 =>   
               if m_axi_descr_arready = '1' then
                  state                 <= RD_LINK_DESCR_STATE2a;
                  m_axi_descr_arvalid   <= '0';
               end if;
      ----------------------------------------------------------------------
      -- Wait for Descriptor Data
      ----------------------------------------------------------------------
           when RD_LINK_DESCR_STATE2a  =>
               if m_axi_descr_rvalid = '1' then
                  descriptor_ram_readdata <= m_axi_descr_rdata;
                  state                   <= RD_LINK_DESCR_STATE3;
               end if;
      ----------------------------------------------------------------------
      -- Read Link Descriptor State
      ---------------------------------------------------------------------- 
            when RD_LINK_DESCR_STATE3 =>   
               state    <= WAIT_FOR_DESCR_READ_STATE;
               link_start           <= '1'; 
      ----------------------------------------------------------------------
      -- Wait for Descriptor Read Result State
      ----------------------------------------------------------------------
            when WAIT_FOR_DESCR_READ_STATE => 
               link_start                   <= '0';
               state    <= WAIT_DESCR_VALID_STATE;

                  -- DWORD 0 -- descriptor_ram_readdata[31:0]	   Control Word
                  -- DWORD 1 -- descriptor_ram_readdata[63:32]    Bytes to Transfer[31:0]
                  -- DWORD 2 -- descriptor_ram_readdata[95:64]    Destination Address[31:0] 
                  -- DWORD 3 -- descriptor_ram_readdata[127:96]   Destination Address[63:32] 
                  -- DWORD 4 -- descriptor_ram_readdata[159:128]  Destination  Meta Data Address[31:0] 
                  -- DWORD 5 -- descriptor_ram_readdata[191:160]  Destination  Meta Data Address[63:32] 
                  -- DWORD 6 -- descriptor_ram_readdata[223:192]  Next Link Address[31:0] 
                  -- DWORD 7 -- descriptor_ram_readdata[255:224]  Next Link Address[63:32]
                                 
                  -- Latch Descriptor
                  descriptor_control_word          <= descriptor_ram_readdata(31 downto 0);
                  if (descriptor_ram_readdata(63 downto 34) /= 0) then -- Don't allow a length of 0
                    descriptor_bytes_to_transfer   <= descriptor_ram_readdata(63 downto 34) & "00";
                  else
                    descriptor_bytes_to_transfer   <= descriptor_ram_readdata(63 downto 35) & "100"; 
                  end if;
                  descriptor_dest_addr             <= descriptor_ram_readdata(127 downto 64);   -- Must Be 64 Byte Boundary!!!!
                  descriptor_dest_meta_addr        <= descriptor_ram_readdata(191 downto 128);  -- Must Be 64 Byte Boundary!!!!
                  descriptor_next_link_addr        <= descriptor_ram_readdata(255 downto 192);  -- Must Be 64 Byte Boundary!!!!                        
      ----------------------------------------------------------------------
      -- Wait for Link Descriptor Valid
      ----------------------------------------------------------------------     
            when WAIT_DESCR_VALID_STATE => 
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
                   
                   
                   -- Descriptor Control Word
                   -- [0:0]   = AUTO
                   -- [1:1]   = Reserved
                   -- [2:2]   = Reserved
                   -- [3:3]   = INCR AXI MODE
                   -- [4:4]   = Reserved
                   -- [5:5]   = Reserved
                   -- [6:6]   = Reserved
                   -- [7:7]   = EOP END
                   -- [8:8]   = LINK END INT EN
                   -- [9:9]   = CHAIN END INT EN
                   -- [10:10] = CHAIN END
                   -- [11:11] = Output Meta Data
                   -- [13:12] = Reserved
                   -- [15:14] = Reserved
                   
                   -- buffer_rd_rqst_data[63:0]    = Destination Start Address -- PCIe Address -- Address must be on 4 byte address boundary
                   -- buffer_rd_rqst_data[127:64]  = Destination Meta Start Address  -- Address must be on 4 byte address boundary
                   -- buffer_wr_rqst_data[159:128] = Size in bytes
                   -- buffer_wr_rqst_data[160]     = Write Meta Data
                   -- buffer_wr_rqst_data[161]     = INCR AXI Type 
                   -- buffer_wr_rqst_data[162]     = Reserved 
                   -- buffer_wr_rqst_data[163]     = Allow end on EOF      
                   -- buffer_rd_rqst_data[167:164] = reserved
                   
                   -- Buffer Read Destination Start Address[63:0] 
                      buffer_rd_rqst_data(63 downto 0)   <= descriptor_dest_addr;   
                   -- Buffer Read Destination Meta Data Start Address[63:0] 
                      buffer_rd_rqst_data(127 downto 64) <= descriptor_dest_meta_addr;           
                   -- Buffer Write Size[31:0]
                   buffer_rd_rqst_data(159 downto 128)   <= descriptor_bytes_to_transfer;
                   -- Write Meta Data
                   buffer_rd_rqst_data(160)              <= descriptor_control_word(11); 
                   buffer_rd_rqst_data(161)              <= descriptor_control_word(3);
                   buffer_rd_rqst_data(163)              <= descriptor_control_word(7);                      
              end if;
      ----------------------------------------------------------------------
      -- Send Buffer Read Request
      ----------------------------------------------------------------------
            when SEND_BUF_READ_STATE =>
               if (abort_ff = '1' ) then
                  state           <= ABORT_STATE;
                  abort_ex_out    <= '1';
               elsif (buffer_rd_rqst_ready = '1') then
                  buffer_rd_rqst_valid <= '0';
                  state <= WAIT_BUF_READ_CMPLT_STATE;
               else
                  state <= SEND_BUF_READ_STATE;
               end if;
      ----------------------------------------------------------------------
      -- Wait for Buffer Read Complete
      ----------------------------------------------------------------------
            when WAIT_BUF_READ_CMPLT_STATE =>
               if (abort_ff = '1' ) then
                  state           <= ABORT_STATE;
                  abort_ex_out    <= '1';
               else
                  if (buffer_rd_complete = '1') then
                     state <= EXEC_CMPLT_STATE;
                  else
                     state <= WAIT_BUF_READ_CMPLT_STATE;
                  end if;                
               end if; 
      ----------------------------------------------------------------------
      -- Execution Complete State
      ----------------------------------------------------------------------  
            when EXEC_CMPLT_STATE =>
               -- Check if end of chain
               if (descriptor_control_word(10) = '1') then
                  state <= RESET_STATE; -- Chain end detected so start over
                  chain_end     <= '1'; 
                  chain_end_int <= descriptor_control_word(9);
               else
                  state <= RD_LINK_DESCR_STATE; -- Continue to next link descriptor
               end if; 
               dma_active       <= '0';
               link_end         <= '1';
               link_end_int     <= descriptor_control_word(8);
               
               last_link_address<= current_link_address_int;
               bytes_last_transferred <= sum_actual_bytes;
               --bytes_last_transferred <= buffer_actual_bytes; -- descriptor_bytes_to_transfer;
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
        if buffer_actual_bytes_valid = '1' then
            sum_actual_bytes <= buffer_actual_bytes; 
        end if;
    end if;    
end process;


end Behavioral;
