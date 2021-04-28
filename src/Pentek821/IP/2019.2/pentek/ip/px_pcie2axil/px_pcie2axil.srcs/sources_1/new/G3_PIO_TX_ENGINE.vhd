-------------------------------------------------------------------------------
--  PCIE Gen3 EP RX ENGINE 
-------------------------------------------------------------------------------
--  Copyright (c) 2015 Pentek, Inc.  All rights reserved.
-------------------------------------------------------------------------------
-- Title        : PCIE Gen3 EP TX ENGINE
-- Project      : 
-------------------------------------------------------------------------------
-- Filename     : g3_pio_tx_engine.vhd
-- Author       : RK
-- Created      : 04/14/2015
-- Last Modified: 04/14/2015
-- Modified by  : RK
--                Pentek, Inc.
--                One Park Way
--                Upper Saddle River, NJ  07458
--                (201) 818-5900
--                www.pentek.com
-------------------------------------------------------------------------------
-- ******************************* Change Log ****************************** --
-- 04/14/2015: Created

-------------------------------------------------------------------------------
-- Description:  PCIE Gen3 EP TX ENGINE.

-- Note: This interface only supports byte and 1DW MEM READ
-- accesses. All other types of accesses are not supported. 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;
-------------------------------------------------------------------------------
-- Entity
-------------------------------------------------------------------------------

entity g3_pio_tx_engine  is
generic (
   num_addr_bits         : integer := 28;
   bar0_size_bits        : integer := 16;
   bar0_addr_translation : std_logic_vector(31 downto 0) := x"00000000";
   bar1_size_bits        : integer := 16;
   bar1_addr_translation : std_logic_vector(31 downto 0) := x"10000000";
   bar2_size_bits        : integer := 16;
   bar2_addr_translation : std_logic_vector(31 downto 0) := x"20000000";
   bar3_size_bits        : integer := 16;
   bar3_addr_translation : std_logic_vector(31 downto 0) := x"30000000";
   bar4_size_bits        : integer := 16;
   bar4_addr_translation : std_logic_vector(31 downto 0) := x"40000000";
   bar5_size_bits        : integer := 16;
   bar5_addr_translation : std_logic_vector(31 downto 0) := x"50000000"    
   );
port (
  axi_aclk                       : in  std_logic;
  axi_aresetn                    : in  std_logic;
  -- axi-s completer completion interface
  m_axis_cc_tdata                : out std_logic_vector(255 downto 0);
  m_axis_cc_tkeep                : out std_logic_vector(7 downto 0);
  m_axis_cc_tlast                : out std_logic;
  m_axis_cc_tvalid               : out std_logic;
  m_axis_cc_tuser                : out std_logic_vector(32 downto 0);
  m_axis_cc_tready               : in  std_logic;
  -- pio rx engine interface
  req_compl                      : in  std_logic;
  req_compl_wd                   : in  std_logic;
  req_compl_ur                   : in  std_logic;
  compl_done                     : out std_logic;

  req_tc                         : in  std_logic_vector(2 downto 0);
  req_td                         : in  std_logic;
  req_ep                         : in  std_logic;
  req_attr                       : in  std_logic_vector(2 downto 0);
  req_rid                        : in  std_logic_vector(15 downto 0);
  req_tag                        : in  std_logic_vector(7 downto 0);
  req_be                         : in  std_logic_vector(3 downto 0);
  req_addr                       : in  std_logic_vector(num_addr_bits-1 downto 0);
  req_at                         : in  std_logic_vector(1 downto 0);
  req_bar_hit                    : in  std_logic_vector(2 downto 0);
  
  completer_id                   : in  std_logic_vector(15 downto 0);
  -- inputs to the tx block in case of an ur
  -- required to form the completions
  req_des_qword0                 : in  std_logic_vector(63 downto 0);
  req_des_qword1                 : in  std_logic_vector(63 downto 0);
  req_des_tph_present            : in  std_logic;
  req_des_tph_type               : in  std_logic_vector(1 downto 0);
  req_des_tph_st_tag             : in  std_logic_vector(7 downto 0);
  --indicate that the request was a mem lock read req
  req_mem_lock                   : in  std_logic;
  req_mem                        : in  std_logic;  
  --------------------------------------------------------------------------------
  -- AXI LITE Master Interface  
  -- DWORD Addressing
  ------------------------------------------------------------------------------
  m_axi_araddr    : out std_logic_vector(num_addr_bits-1 downto 0);
  m_axi_arprot    : out std_logic_vector(2 downto 0); -- not used
  m_axi_arvalid   : out std_logic;
  m_axi_arready   : in  std_logic;
  m_axi_rdata     : in  std_logic_vector(31 downto 0);
  m_axi_rvalid    : in  std_logic;
  m_axi_rready    : out std_logic;
  m_axi_rresp     : in  std_logic_vector(1 downto 0)
);
end g3_pio_tx_engine;

architecture Behavioral of g3_pio_tx_engine is

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant C_DATA_WIDTH            : integer := 256;
constant STRB_WIDTH              : integer := 32;  -- TSTRB width
constant KEEP_WIDTH              : integer := 8;
constant PARITY_WIDTH            : integer := 32;   -- TPARITY width
constant AXISTEN_IF_WIDTH        : std_logic_vector(1 downto 0):= "10";

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

-- State Machine States
type state_mach_states is (
  PIO_TX_RST_STATE,                 
  PIO_TX_COMPL_C1,                                  
  PIO_TX_COMPL_WD_C1,               
  PIO_TX_COMPL_WD_C2,                             
  PIO_TX_CPL_UR_C1,                                      
  PIO_TX_COMPL_WAIT_TREADY,  
  PIO_FINISH_WAIT
);

type reader_states is (
   RST_STATE,
   WAIT_RQST_STATE,
   WAIT_RD_ADDR_READY_STATE,
   WAIT_RD_VALID_STATE,
   WAIT_FINISHED,
   WAIT_COMPL_DONE
);

constant  PAYLOAD_LEN                    : std_logic_vector(1 downto 0) := "01";

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal byte_count: std_logic_vector(11 downto 0);
signal lower_addr: std_logic_vector(6 downto 0);

signal case_concat: std_logic_vector(4 downto 0);
signal state: state_mach_states;
signal reader_state: reader_states;  

signal data_available: std_logic;
signal reg_rd_data: std_logic_vector(31 downto 0);

signal int_m_axis_cc_tdata: std_logic_vector(255 downto 0);
signal int_compl_done: std_logic;
signal rd_addr_bar0_masked: std_logic_vector(num_addr_bits-1 downto 0);
signal rd_addr_bar1_masked: std_logic_vector(num_addr_bits-1 downto 0);
signal rd_addr_bar2_masked: std_logic_vector(num_addr_bits-1 downto 0);
signal rd_addr_bar3_masked: std_logic_vector(num_addr_bits-1 downto 0);
signal rd_addr_bar4_masked: std_logic_vector(num_addr_bits-1 downto 0);
signal rd_addr_bar5_masked: std_logic_vector(num_addr_bits-1 downto 0);

-------------------------------------------------------------------------------

begin

m_axis_cc_tdata <= int_m_axis_cc_tdata;
 

-- Calculate the byte_count for 1DW or 2DW packets

process(req_be)
begin
   case(req_be) is
      when "1111" =>
         byte_count <= x"004";
      when "0111" =>
         byte_count <= x"003";
      when "1110" =>
         byte_count <= x"003";
      when "0011" | "0110" | "1100" =>
         byte_count <= x"002";
      when "0001" | "0010" | "0100" | "1000" | "0000" =>
         byte_count <= x"001";
      when others =>
         byte_count <= x"00" & "XXXX";
   end case;
end process;

case_concat <= req_compl_wd & req_be(3 downto 0); 

process(case_concat, req_addr)
begin
    if case_concat(4) = '0' then
         lower_addr <= "0000000";
    elsif  case_concat(3 downto 0) = "0000" then 
         lower_addr <= req_addr(6 downto 2) & "00";
    elsif case_concat(0) = '1' then 
         lower_addr <= req_addr(6 downto 2) & "00";
    elsif case_concat(1 downto 0) = "10" then
         lower_addr <= req_addr(6 downto 2) & "01";
    elsif case_concat(2 downto 0) = "100" then
         lower_addr <= req_addr(6 downto 2) & "10";
    elsif case_concat(3 downto 0) = "1000" then 
         lower_addr <= req_addr(6 downto 2) & "11";
    else 
         lower_addr <= "0000000";
    end if;
end process;


gen_rd_addr_bar0: for i in 0 to (num_addr_bits-1) generate
      rd_addr_bar0_masked(i) <= req_addr(i) when (i < bar0_size_bits) else '0';
end generate;

gen_rd_addr_bar1: for i in 0 to (num_addr_bits-1) generate
      rd_addr_bar1_masked(i) <= req_addr(i) when (i < bar1_size_bits) else '0';
end generate;

gen_rd_addr_bar2: for i in 0 to (num_addr_bits-1) generate
      rd_addr_bar2_masked(i) <= req_addr(i) when (i < bar2_size_bits) else '0';
end generate;

gen_rd_addr_bar3: for i in 0 to (num_addr_bits-1) generate
      rd_addr_bar3_masked(i) <= req_addr(i) when (i < bar3_size_bits) else '0';  
end generate;

gen_rd_addr_bar4: for i in 0 to (num_addr_bits-1) generate
      rd_addr_bar4_masked(i) <= req_addr(i) when (i < bar4_size_bits) else '0';
end generate;

gen_rd_addr_bar5: for i in 0 to (num_addr_bits-1) generate
      rd_addr_bar5_masked(i) <= req_addr(i) when (i < bar5_size_bits) else '0';
end generate;

m_axi_arprot <= "000";

-- READ State Machine  
process(axi_aclk)
begin
   if rising_edge(axi_aclk) then
      if(axi_aresetn = '0') then
         reader_state   <= RST_STATE;
         m_axi_arvalid  <= '0';
         m_axi_rready   <= '0';
         data_available <= '0';
      else
         case reader_state is
            -- Reset state
            when RST_STATE =>
               if(axi_aresetn = '0') then
                  reader_state <= RST_STATE;
               else
                  reader_state <= WAIT_RQST_STATE;
               end if;
            -- Wait for a request
            when WAIT_RQST_STATE =>
               -- Read Completion Request w/ Data 
               if req_compl_wd = '1' then
                   m_axi_arvalid <= '1';
                   case req_bar_hit is
                      when "000" => 
                         m_axi_araddr  <= bar0_addr_translation(num_addr_bits-1 downto 0) + rd_addr_bar0_masked;
                      when "001" =>
                         m_axi_araddr  <= bar1_addr_translation(num_addr_bits-1 downto 0) + rd_addr_bar1_masked;
                      when "010" => 
                         m_axi_araddr  <= bar2_addr_translation(num_addr_bits-1 downto 0) + rd_addr_bar2_masked;
                      when "011" =>
                         m_axi_araddr  <= bar3_addr_translation(num_addr_bits-1 downto 0) + rd_addr_bar3_masked;
                      when "100" => 
                         m_axi_araddr  <= bar4_addr_translation(num_addr_bits-1 downto 0) + rd_addr_bar4_masked;
                      when "101" =>
                         m_axi_araddr  <= bar5_addr_translation(num_addr_bits-1 downto 0) + rd_addr_bar5_masked;
                      when others => 
                         m_axi_araddr  <= bar5_addr_translation(num_addr_bits-1 downto 0) + rd_addr_bar5_masked;
                   end case;         
                  
                  reader_state <= WAIT_RD_ADDR_READY_STATE;
               else
                  reader_state <= WAIT_RQST_STATE;
               end if;
            -- Read the first address
            when WAIT_RD_ADDR_READY_STATE =>
               if (m_axi_arready = '1') then
                  m_axi_arvalid <= '0';
                  m_axi_rready  <= '1';
                  reader_state <= WAIT_RD_VALID_STATE;
               else
                  reader_state <= WAIT_RD_ADDR_READY_STATE; 
               end if;
            when WAIT_RD_VALID_STATE =>
               if (m_axi_rvalid = '1') then
                  m_axi_rready    <= '0';
                  reg_rd_data     <= m_axi_rdata;
                  data_available  <= '1';
                  reader_state    <= WAIT_COMPL_DONE; -- Wait until the data is available at FIFO out. 
               else
                  reader_state <= WAIT_RD_VALID_STATE;
               end if;      
            when WAIT_COMPL_DONE =>
               data_available <= '0';
               if int_compl_done = '1' then
                  reader_state <= WAIT_FINISHED;
               else -- wait until all data taken
                  reader_state <= WAIT_COMPL_DONE;
               end if;   
            when WAIT_FINISHED =>
               reader_state <= WAIT_RQST_STATE;              
            when others =>
               reader_state <= RST_STATE;
         end case;
     end if;    
   end if;
end process;
            

COMPL_DONE <= int_compl_done;

process(axi_aclk)
begin
   if rising_edge(axi_aclk) then
      if(axi_aresetn = '0') then
         state                   <= PIO_TX_RST_STATE;
         int_m_axis_cc_tdata         <= (others => '0');
         m_axis_cc_tkeep         <= (others => '0');
         m_axis_cc_tlast         <= '0';
         m_axis_cc_tvalid        <= '0';
         m_axis_cc_tuser         <= (others => '0');
         int_compl_done          <= '0';
      else -- reset_else_block
         case state is
            when PIO_TX_RST_STATE =>  -- Reset_State
               state                   <= PIO_TX_RST_STATE;
               int_m_axis_cc_tdata         <= (others => '0');
               m_axis_cc_tkeep         <= (others => '1');
               m_axis_cc_tlast         <= '0';
               m_axis_cc_tvalid        <= '0';
               m_axis_cc_tuser         <= (others => '0');
               int_COMPL_DONE          <= '0';
               if (req_compl ='1') then
                  state <= PIO_TX_COMPL_C1;
               elsif (req_compl_wd = '1') then
                  state <= PIO_TX_COMPL_WD_C1;
               elsif (req_compl_ur = '1') then
                  state <= PIO_TX_CPL_UR_C1;
               else
                  state <= PIO_TX_RST_STATE;
               end if;
             -- end PIO_TX_RST_STATE
            when PIO_TX_COMPL_C1 => -- Completion Without Payload 
                                    -- Sent in a Single Beat When Interface Width is 256 bit
                  m_axis_cc_tvalid  <= '1';
                  m_axis_cc_tlast   <= '1';
                  m_axis_cc_tkeep   <= x"07";
                  int_m_axis_cc_tdata   <= x"0000000000000000000000000000000000000000" &   -- Tied to 0 for 3DW completion descriptor
                                       '0' &            -- Force ECRC
                                       req_attr &       -- 3- bits
                                       req_tc &         -- 3- bits
                                       '0' &            -- Completer ID to control selection of Client
                                                        -- Supplied Bus number
                                       completer_id &   -- Completer Bus number - selected if Compl ID    = 1
                                                        -- Compl Dev / Func no - sel if Compl ID = 1
                                       req_tag  &       -- Select Client Tag or core's internal tag
                                       req_rid &        -- Requester ID - 16 bits
                                       '0' &            -- Rsvd
                                       '0' &            -- Posioned completion
                                       "000" &          -- Successfull completion
                                       "00000000001"&         -- DWord Count 
                                       "00" &           -- Rsvd
                                       '0' &            -- Locked Read Completion
                                       '0' &  x"004" &  -- Byte Count
                                       "000000" &       -- Rsvd
                                       req_at &         -- Adress Type - 2 bits
                                       '0' &            -- Rsvd
                                       lower_addr;      -- Starting address of the mem byte - 7 bits
                  m_axis_cc_tuser  <= '0' & x"00000000";
                  state <= PIO_TX_COMPL_WAIT_TREADY;
             -- end PIO_TX_COMPL
             when PIO_TX_COMPL_WD_C1 =>   -- Completion With Payload (Address Aligned)
               if (data_available = '1') then                           
                        m_axis_cc_tvalid  <= '1';
                        m_axis_cc_tkeep   <= x"FF";
                        int_m_axis_cc_tdata   <= x"00000000000000000000000000000000" & -- Tied to 0 for 3DW completion descriptor
                                             x"00000000" &      -- 
                                             '0' &              -- Force ECRC
                                             req_attr &         -- 3- bits
                                             req_tc &           -- 3- bits
                                             '0' &              -- Completer ID to control selection of Client
                                                                -- Supplied Bus number
                                             completer_id &     -- Completer Bus number - selected if Compl ID    = 1
                                                                -- Compl Dev / Func no - sel if Compl ID = 1
                                             req_tag &          -- Select Client Tag or core's internal tag
                                             req_rid &          -- Requester ID - 16 bits
                                             '0' &              -- Rsvd
                                             '0' &              -- Posioned completion
                                             "000" &            -- SuccessFull completion
                                             "00000000001" &    -- DWord Count 
                                             "00" &             -- Rsvd
                                             req_mem_lock &     -- Locked Read Completion
                                             '0' & byte_count & -- Byte Count 
                                             "000000" &         -- Rsvd
                                             req_at &           -- Adress Type - 2 bits
                                             '0' &              -- Rsvd
                                             lower_addr;        -- Starting address of the mem byte - 7 bits                  
                        m_axis_cc_tuser   <= '0' & x"00000000";
                        state <= PIO_TX_COMPL_WD_C2;
               else
                  state <= PIO_TX_COMPL_WD_C1;
               end if;        
            when PIO_TX_COMPL_WD_C2 =>   -- Completion With Payload  (Address Aligned)  Data cycle
                   if (m_axis_cc_tready = '1') then                         
                      m_axis_cc_tlast   <= '1';
                      case req_addr(4 downto 2) is
                        when "000" =>
                           m_axis_cc_tkeep   <= x"01";
                        when "001" =>      
                           m_axis_cc_tkeep   <= x"03";
                        when "010" =>      
                           m_axis_cc_tkeep   <= x"07";
                        when "011" =>      
                           m_axis_cc_tkeep   <= x"0F";
                        when "100" =>      
                           m_axis_cc_tkeep   <= x"1F";
                        when "101" =>      
                           m_axis_cc_tkeep   <= x"3F";
                        when "110" =>      
                           m_axis_cc_tkeep   <= x"7F";
                        when "111" =>      
                           m_axis_cc_tkeep   <= x"FF";
                        when others =>     
                            m_axis_cc_tkeep  <= x"FF";
                       end case;                                           
                       int_m_axis_cc_tdata   <= reg_rd_data & reg_rd_data & reg_rd_data & reg_rd_data & reg_rd_data & reg_rd_data & reg_rd_data & reg_rd_data;
                       m_axis_cc_tuser       <= '0' & x"00000000";
                       state <= PIO_TX_COMPL_WAIT_TREADY;
                   else
                       state  <= PIO_TX_COMPL_WD_C2;
                   end if; 
              -- end -- PIO_TX_COMPL_WD
              when PIO_TX_COMPL_WAIT_TREADY =>
                if(m_axis_cc_tready = '1') then
                  state       <= PIO_FINISH_WAIT;
                  m_axis_cc_tvalid  <= '0';
                  m_axis_cc_tlast   <= '0';
                  int_compl_done    <= '1';
                else
                  state             <= PIO_TX_COMPL_WAIT_TREADY;
                end if; 
              when PIO_FINISH_WAIT =>
                  state             <= PIO_TX_RST_STATE;
              when PIO_TX_CPL_UR_C1 => -- Completions with UR 
                  m_axis_cc_tvalid  <= '1';
                  m_axis_cc_tlast   <= '1';
                  m_axis_cc_tkeep   <= x"FF";
                  int_m_axis_cc_tdata   <= req_des_qword1 &    -- 64 bits - Descriptor of the request 2 DW
                       req_des_qword0 &        -- 64 bits - Descriptor of the request 2 DW
                       x"00" &                 -- Rsvd
                       req_des_tph_st_tag &    -- TPH Steering tag - 8 bits
                       "00000" &               -- Rsvd
                       req_des_tph_type &      -- TPH type - 2 bits
                       req_des_tph_present &   -- TPH present - 1 bit
                       "0000" & req_be &                -- Request Byte enables - 8bits
                       '0' &                   -- Force ECRC
                       req_attr &        -- 3- bits
                       req_tc &                -- 3- bits
                       '0' &                   -- Completer ID to control selection of Client
                                               -- Supplied Bus number
                       completer_id &          -- Completer Bus number - selected if Compl ID    = 1
                                               -- Compl Dev / Func no - sel if Compl ID = 1
                       req_tag &               -- Select Client Tag or core's internal tag
                       req_rid &               -- Requester ID - 16 bits
                       '0' &                   -- Rsvd
                       '0' &                   -- Posioned completion
                       "001" &                 -- Completion Status - UR
                       "000" & x"05" &         -- DWord Count -55
                       "00" &                  -- Rsvd
                       req_mem_lock &          -- Locked Read Completion
                       '0' & x"014" &          -- Byte Count
                       "000000" &              -- Rsvd
                       req_at &                -- Adress Type - 2 bits
                       '0' &                   -- Rsvd
                       lower_addr;             -- Starting address of the mem byte - 7 bits
                  m_axis_cc_tuser   <= '0' & x"00000000";
                  state       <= PIO_TX_COMPL_WAIT_TREADY;
            when others =>
               state        <= PIO_TX_RST_STATE;
         end case;
      end if; 
   end if;
end process;

end Behavioral; -- G3_PIO_TX_ENGINE
