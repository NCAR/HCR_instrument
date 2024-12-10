-------------------------------------------------------------------------------
-- PCIE Gen3 EP RX ENGINE 
-------------------------------------------------------------------------------
--  Copyright (c) 2015 Pentek, Inc.  All rights reserved.
-------------------------------------------------------------------------------
-- Title        : PCIE Gen3 EP RX ENGINE
-- Project      : 
-------------------------------------------------------------------------------
-- Filename     : g3_pio_rx_engine.vhd
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
-- Description:  PCIE Gen3 EP RX ENGINE

-- Note: This interface only supports byte and 1DW, MEM READ and MEM WRITE
-- accesses. All other types of accesses are not supported. 


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;
-------------------------------------------------------------------------------
-- Entity
-------------------------------------------------------------------------------

entity g3_pio_rx_engine is
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
  cc_shutdown_rqst               : in  std_logic; 
  cc_shutdown_ok                 : out std_logic;
  -- completer request interface
  s_axis_cq_tdata                : in  std_logic_vector(255 downto 0);
  s_axis_cq_tlast                : in  std_logic;
  s_axis_cq_tvalid               : in  std_logic;
  s_axis_cq_tuser                : in  std_logic_vector(84 downto 0);
  s_axis_cq_tkeep                : in  std_logic_vector(7 downto 0);
  s_axis_cq_tready               : out std_logic;
  -- memory read data handshake with completion
  -- transmit unit. transmit unit reponds to
  -- req_compl assertion and responds with compl_done
  -- assertion when a completion w/ data is transmitted.
  req_compl                      : out std_logic;
  req_compl_wd                   : out std_logic;
  req_compl_ur                   : out std_logic;
  compl_done                     : in  std_logic;
  req_tc                         : out std_logic_vector(2 downto 0);    -- memory read tc
  req_attr                       : out std_logic_vector(2 downto 0);    -- memory read attribute
  req_len                        : out std_logic_vector(10 downto 0);   -- memory read length
  req_rid                        : out std_logic_vector(15 downto 0);   -- memory read requestor id { 8'b0 (bus no),
  --                            3'b0 (dev no),
  --                            5'b0 (func no)}
  req_tag                        : out std_logic_vector(7 downto 0);    -- memory read tag
  req_be                         : out std_logic_vector(3 downto 0);    -- memory read byte enables
  req_addr                       : out std_logic_vector(num_addr_bits-1 downto 0);   -- memory read address
  req_at                         : out std_logic_vector(1 downto 0);    -- address translation
  req_bar_hit                    : out std_logic_vector(2 downto 0);
  -- outputs to the tx block in case of an ur
  -- required to form the completions
  req_des_qword0                 : out std_logic_vector(63 downto 0);   -- dword0 and dword1 of descriptor of the request
  req_des_qword1                 : out std_logic_vector(63 downto 0);   -- dword2 and dword3 of descriptor of the request
  req_des_tph_present            : out std_logic;                       -- tph present in the request
  req_des_tph_type               : out std_logic_vector(1 downto 0);    -- if tph present then tph type
  req_des_tph_st_tag             : out std_logic_vector(7 downto 0);    -- tph steering tag of the request
  --output to indicate that the request was a mem lock read req
  req_mem_lock                   : out std_logic;
  req_mem                        : out std_logic;
  --------------------------------------------------------------------------------
  -- AXI LITE Master Interface  
  -- DWORD Addressing
  ------------------------------------------------------------------------------
  m_axi_awaddr    : out std_logic_vector(num_addr_bits-1 downto 0);
  m_axi_awprot    : out std_logic_vector(2 downto 0); -- not used
  m_axi_awvalid   : out std_logic;
  m_axi_awready   : in  std_logic;
  m_axi_wdata     : out std_logic_vector(31 downto 0);
  m_axi_wstrb     : out std_logic_vector(3 downto 0); -- not used
  m_axi_wvalid    : out std_logic;
  m_axi_wready    : in  std_logic;
  m_axi_bresp     : in  std_logic_vector(1 downto 0);
  m_axi_bvalid    : in  std_logic;
  m_axi_bready    : out std_logic
);
end g3_pio_rx_engine;

architecture Behavioral of g3_pio_rx_engine is

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant PIO_RX_MEM_RD_FMT_TYPE    : std_logic_vector(3 downto 0) := "0000";    -- Memory Read
constant PIO_RX_MEM_WR_FMT_TYPE    : std_logic_vector(3 downto 0) := "0001";    -- Memory Write
constant PIO_RX_IO_RD_FMT_TYPE     : std_logic_vector(3 downto 0) := "0010";    -- IO Read
constant PIO_RX_IO_WR_FMT_TYPE     : std_logic_vector(3 downto 0) := "0011";    -- IO Write
constant PIO_RX_ATOP_FAA_FMT_TYPE  : std_logic_vector(3 downto 0) := "0100";    -- Fetch and ADD
constant PIO_RX_ATOP_UCS_FMT_TYPE  : std_logic_vector(3 downto 0) := "0101";    -- Unconditional SWAP
constant PIO_RX_ATOP_CAS_FMT_TYPE  : std_logic_vector(3 downto 0) := "0110";    -- Compare and SWAP
constant PIO_RX_MEM_LK_RD_FMT_TYPE : std_logic_vector(3 downto 0) := "0111";    -- Locked Read Request
constant PIO_RX_MSG_FMT_TYPE       : std_logic_vector(3 downto 0) := "1100";    -- MSG Transaction apart from Vendor Defined and ATS
constant PIO_RX_MSG_VD_FMT_TYPE    : std_logic_vector(3 downto 0) := "1101";    -- MSG Transaction apart from Vendor Defined and ATS
constant PIO_RX_MSG_ATS_FMT_TYPE   : std_logic_vector(3 downto 0) := "1110";    -- MSG Transaction apart from Vendor Defined and ATS
constant BAR_ID_SELECT             : integer := 112;

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

-- State Machine States
type state_mach_states is (
   PIO_RX_RST_STATE,
   PIO_WR_DATA_STATE, 
   PIO_RX_WAIT_STATE,
   PIO_RX_WAIT1_STATE,
   PIO_FINISH_WAIT_STATE,
   PIO_FINISH_WAIT_STATE1,
   PIO_FINISH_WAIT_STATE2,
   PIO_FINISH_WAIT_STATE3,
   PIO_FINISH_WAIT_STATE4,
   PIO_RX_64_QW1,    
   PIO_RX_DATA,      
   PIO_RX_DATA2     
   );

type out_sm_states is (
   RESET_STATE,
   WAIT_FOR_WR_DATA,
   WAIT_FOR_BOTH_READY,
   WAIT_FOR_AW_READY,
   WAIT_FOR_W_READY,
   WAIT_FOR_BRESP
   );

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal state: state_mach_states := PIO_RX_RST_STATE;
signal output_sm_state: out_sm_states := RESET_STATE;
signal trn_type: std_logic_vector(3 downto 0) := (others => '0');
signal sop: std_logic := '0';                  -- Start of packet
signal s_axis_cq_tdata_q: std_logic_vector(255 downto 0) := (others => '0');
signal s_axis_cq_tuser_q: std_logic_vector(84 downto 0) := (others => '0');
signal wr_addr :std_logic_vector(num_addr_bits-1 downto 0) := (others => '0');   -- Memory Write Address
signal wr_be   :std_logic_vector(3 downto 0) := (others => '0');    -- Memory Write Byte Enable
signal wr_data :std_logic_vector(31 downto 0) := (others => '0');   -- Memory Write Data
signal wr_en   :std_logic := '0';                       -- Memory Write Enable
signal wr_busy :std_logic := '0';                       -- Memory Write Busy
signal int_S_AXIS_CQ_TREADY: std_logic := '0';
signal int_REQ_ADDR: std_logic_vector(num_addr_bits-1 downto 0) := (others => '0');
signal wr_addr_bar0_masked: std_logic_vector(num_addr_bits-1 downto 0) := (others => '0');
signal wr_addr_bar1_masked: std_logic_vector(num_addr_bits-1 downto 0) := (others => '0');
signal wr_addr_bar2_masked: std_logic_vector(num_addr_bits-1 downto 0) := (others => '0');
signal wr_addr_bar3_masked: std_logic_vector(num_addr_bits-1 downto 0) := (others => '0');
signal wr_addr_bar4_masked: std_logic_vector(num_addr_bits-1 downto 0) := (others => '0');
signal wr_addr_bar5_masked: std_logic_vector(num_addr_bits-1 downto 0) := (others => '0');
signal bar_hit: std_logic_vector(2 downto 0) := "000";
signal t1_cc_shutdown_rqst: std_logic := '0';
signal  p_cc_shutdown_ok: std_logic := '0';

-------------------------------------------------------------------------------

begin

 -- Generate a signal that indicates if we are currently receiving a packet.
 -- This value is one clock cycle delayed from what is actually on the AXIS
 -- data bus.

   
s_axis_cq_tready <= int_s_axis_cq_tready;

req_addr <= int_req_addr;

sop <= s_axis_cq_tuser(40) and s_axis_cq_tvalid; -- start of frame


process(axi_aclk)
begin
   if rising_edge(axi_aclk) then
      if(axi_aresetn = '0') then
         s_axis_cq_tdata_q    <= (others => '0');
         s_axis_cq_tuser_q    <= (others => '0');
         t1_cc_shutdown_rqst  <= '0';
         cc_shutdown_ok       <= '1';
      elsif (s_axis_cq_tvalid = '1') then
         s_axis_cq_tdata_q    <= s_axis_cq_tdata;
         s_axis_cq_tuser_q    <= s_axis_cq_tuser;
         t1_cc_shutdown_rqst  <= cc_shutdown_rqst;
         cc_shutdown_ok       <= p_cc_shutdown_ok;
      end if;   
    end if;
end process;


process(axi_aclk)
begin
   if rising_edge(axi_aclk) then
      if(axi_aresetn = '0') then
         int_s_axis_cq_tready<= '0';

         req_compl           <= '0';
         req_compl_wd        <= '0';
         req_compl_ur        <= '0';

         req_tc              <= "000";
         req_attr            <= "000";
         req_len             <= "00000000000";
         req_rid             <= x"0000";
         req_tag             <= x"00";
         req_be              <= x"0";
         req_at              <= "00";

         wr_be               <= x"0";
         wr_en               <= '0';

         state               <= PIO_RX_RST_STATE;
         trn_type            <= x"0";

         req_des_tph_present <= '0';
         req_des_tph_type    <= "00";
         req_des_tph_st_tag  <= x"00";

         req_mem_lock        <= '0';
         req_mem             <= '0';
         req_bar_hit         <= "000";
         p_cc_shutdown_ok    <= '1';
      else
         wr_en               <= '0';
         req_compl           <= '0';
         case state is
            -- Reset State
            when PIO_RX_RST_STATE =>
               if (t1_cc_shutdown_rqst = '1') then -- Shutdown Request
                  int_s_axis_cq_tready   <= '0';
                  p_cc_shutdown_ok       <= '1';
                  state                  <= PIO_RX_RST_STATE;
               elsif ((sop = '1') and (int_s_axis_cq_tready = '1')) then --sop_if 
                  p_cc_shutdown_ok       <= '0';
                  case  s_axis_cq_tdata(78 downto 75) is -- Req_Type_fsm
                     when PIO_RX_MEM_RD_FMT_TYPE =>
                        trn_type             <= s_axis_cq_tdata(78 downto 75);                    
                        req_len              <= s_axis_cq_tdata(74 downto 64);                    
                        int_s_axis_cq_tready <= '0';                                              
                        req_mem              <= '1';                                              
                        state                <= pio_rx_wait1_state;                               
                        req_be               <= s_axis_cq_tuser(3 downto 0);                      
                        req_des_qword0       <= s_axis_cq_tdata(63 downto 0);                     
                        req_des_qword1       <= s_axis_cq_tdata(127 downto 64);                   
                        int_req_addr         <= s_axis_cq_tdata(num_addr_bits-1 downto 2) & "00"; 
                        req_des_tph_present  <= s_axis_cq_tuser(42);                              
                        req_des_tph_type     <= s_axis_cq_tuser(44 downto 43);                    
                        req_des_tph_st_tag   <= s_axis_cq_tuser(52 downto 45);                    
                        if (s_axis_cq_tdata(74 downto 65) = "0000000000") then                    
                           req_compl        <= '0';                                               
                           req_compl_wd     <= '1';                                               
                           req_tc           <= S_axis_cq_tdata(123 downto 121);                   
                           req_attr         <= S_axis_cq_tdata(126 downto 124);                   
                           req_rid          <= S_axis_cq_tdata(95 downto 80);                     
                           req_tag          <= S_axis_cq_tdata(103 downto 96);                    
                           req_at           <= S_axis_cq_tdata(1 downto 0);                       
                           req_bar_hit      <= S_axis_cq_tdata(bar_id_select+2 downto bar_id_select);
                        else
                           req_compl        <= '0';
                           req_compl_wd     <= '0';
                           req_compl_ur     <= '1';
                        end if;
                     when PIO_RX_MEM_WR_FMT_TYPE =>
                        trn_type         <= s_axis_cq_tdata(78 downto 75);
                        req_len          <= s_axis_cq_tdata(74 downto 64);
                        req_mem          <= '0';
                        if (S_AXIS_CQ_TDATA(74 downto 65) = "0000000000") then
                           state            <= PIO_WR_DATA_STATE;
                           wr_be            <= s_axis_cq_tuser(3 downto 0);
                           wr_addr          <= s_axis_cq_tdata(num_addr_bits-1 downto 2) & "00";  
                           bar_hit          <= s_axis_cq_tdata(bar_id_select+2 downto bar_id_select);                       
                        else -- Payload > 1DWORD
                           state             <= PIO_RX_RST_STATE;
                        end if;   
                     when others => -- other TLPs
                        state        <= PIO_RX_RST_STATE;
                  end case;
                  -- Req_Type_fsm
               else
                  --int_S_AXIS_CQ_TREADY <= not fifo_full;
                  int_s_axis_cq_tready <= '1';
                  state                <= PIO_RX_RST_STATE;
               end if;--sop_if
            when PIO_WR_DATA_STATE => 
              if    (s_axis_cq_tuser(11 downto 8) /= "0000") then 
                  wr_data    <= s_axis_cq_tdata(31 downto 0);
              elsif (s_axis_cq_tuser(15 downto 12) /= "0000") then
                  wr_data    <= s_axis_cq_tdata(63 downto 32);
              elsif (s_axis_cq_tuser(19 downto 16) /= "0000") then
                  wr_data    <= s_axis_cq_tdata(95 downto 64); 
              elsif (s_axis_cq_tuser(23 downto 20) /= "0000") then
                  wr_data    <= s_axis_cq_tdata(127 downto 96);    
              elsif (s_axis_cq_tuser(27 downto 24) /= "0000") then
                  wr_data    <= s_axis_cq_tdata(159 downto 128);
              elsif (s_axis_cq_tuser(31 downto 28) /= "0000") then
                  wr_data    <= s_axis_cq_tdata(191 downto 160);
              elsif (s_axis_cq_tuser(35 downto 32) /= "0000") then
                  wr_data    <= s_axis_cq_tdata(223 downto 192);
              else
                  wr_data    <= s_axis_cq_tdata(255 downto 224);
              end if; 
              state                <= PIO_RX_WAIT1_STATE;
              int_s_axis_cq_tready <= '0'; 
              wr_en                <= '1';        
            when PIO_RX_WAIT1_STATE =>
               wr_en           <= '0';
               state           <= PIO_RX_WAIT_STATE;
            when PIO_RX_WAIT_STATE =>
               wr_en           <= '0';
               if ((trn_type = PIO_RX_MEM_WR_FMT_TYPE) and (wr_busy = '0')) then
                  state           <= PIO_FINISH_WAIT_STATE;
                  req_compl       <= '0';
                  req_compl_wd    <= '0';
                  req_compl_ur    <= '0';
               elsif ((trn_type = PIO_RX_IO_WR_FMT_TYPE) and (wr_busy= '0')) then
                  state           <= PIO_FINISH_WAIT_STATE;
                  req_compl       <= '0';
                  req_compl_wd    <= '0';
                  req_compl_ur    <= '0';
               elsif ((trn_type = PIO_RX_MEM_RD_FMT_TYPE) and (compl_done='1')) then
                  state           <= PIO_FINISH_WAIT_STATE;
                  req_compl       <= '0';
                  req_compl_wd    <= '0';
                  req_compl_ur    <= '0';
               elsif ((trn_type = PIO_RX_MEM_LK_RD_FMT_TYPE) and (compl_done='1')) then
                  state           <= PIO_FINISH_WAIT_STATE;
                  req_compl       <= '0';
                  req_compl_wd    <= '0';
                  req_compl_ur    <= '0';
               elsif ((trn_type = PIO_RX_IO_RD_FMT_TYPE) and (compl_done='1')) then
                  state           <= PIO_FINISH_WAIT_STATE;
                  req_compl       <= '0';
                  req_compl_wd    <= '0';
                  req_compl_ur    <= '0';
               elsif (((trn_type = PIO_RX_ATOP_FAA_FMT_TYPE) or (trn_type = PIO_RX_ATOP_UCS_FMT_TYPE) or
                            (trn_type = PIO_RX_ATOP_CAS_FMT_TYPE)) and (compl_done='1')) then
                  state             <= PIO_FINISH_WAIT_STATE;
                  req_compl       <= '0';
                  req_compl_wd    <= '0';
                  req_compl_ur    <= '0';
               else
                  state           <= PIO_RX_WAIT_STATE;
               end if;
               -- end PIO_RX_WAIT_STATE
            when PIO_FINISH_WAIT_STATE =>
               state             <= PIO_FINISH_WAIT_STATE1;
            -- end PIO_RX_WAIT_STATE
            when PIO_FINISH_WAIT_STATE1 =>
               state             <= PIO_FINISH_WAIT_STATE2;
            -- end PIO_RX_WAIT_STATE
            when PIO_FINISH_WAIT_STATE2 =>
               state             <= PIO_FINISH_WAIT_STATE3;
            when PIO_FINISH_WAIT_STATE3 =>
               state             <= PIO_FINISH_WAIT_STATE4;
            -- end PIO_RX_WAIT_STATE
            when PIO_FINISH_WAIT_STATE4 =>
               state             <= PIO_RX_RST_STATE;
            when others =>
               state             <= PIO_RX_RST_STATE;
         end case; -- state
      end if;-- axi_aresetn
   end if; -- End of always Block
end process; -- pio_rx_sm_256


-------------------------------------------------------------------------------
-- Output State Machine
-------------------------------------------------------------------------------

gen_wr_addr_bar0: for i in 0 to (num_addr_bits-1) generate
      wr_addr_bar0_masked(i) <= wr_addr(i) when (i < bar0_size_bits) else '0';    
end generate;

gen_wr_addr_bar1: for i in 0 to (num_addr_bits-1) generate
      wr_addr_bar1_masked(i) <= wr_addr(i) when (i < bar1_size_bits) else '0';
end generate;

gen_wr_addr_bar2: for i in 0 to (num_addr_bits-1) generate
      wr_addr_bar2_masked(i) <= wr_addr(i) when (i < bar2_size_bits) else '0';  
end generate;

gen_wr_addr_bar3: for i in 0 to (num_addr_bits-1) generate
      wr_addr_bar3_masked(i) <= wr_addr(i) when (i < bar3_size_bits) else '0'; 
end generate;

gen_wr_addr_bar4: for i in 0 to (num_addr_bits-1) generate
      wr_addr_bar4_masked(i) <= wr_addr(i) when (i < bar4_size_bits) else '0'; 
end generate;

gen_wr_addr_bar5: for i in 0 to (num_addr_bits-1) generate
      wr_addr_bar5_masked(i) <= wr_addr(i) when (i < bar5_size_bits) else '0';  
end generate;


process(axi_aclk)
begin
   if rising_edge(axi_aclk) then
      if (axi_aresetn = '0') then
         wr_busy       <= '0';
         m_axi_wvalid  <= '0';
         m_axi_awvalid <= '0';
         m_axi_bready  <= '0';
         output_sm_state <= RESET_STATE;
      else
         case output_sm_state is
            when RESET_STATE =>
               if (axi_aresetn = '0') then
                  wr_busy       <= '0';
                  m_axi_wvalid  <= '0';
                  m_axi_awvalid <= '0';
                  m_axi_bready  <= '0';     
                  output_sm_state <= RESET_STATE;          
               else
                  output_sm_state <= WAIT_FOR_WR_DATA;
               end if;
            when WAIT_FOR_WR_DATA =>
               if (wr_en = '1') then
                  wr_busy       <= '1';
                  m_axi_wdata   <= wr_data;
                  case bar_hit is
                     when "000" => 
                        m_axi_awaddr  <= bar0_addr_translation(num_addr_bits-1 downto 0) + wr_addr_bar0_masked;
                     when "001" =>
                        m_axi_awaddr  <= bar1_addr_translation(num_addr_bits-1 downto 0) + wr_addr_bar1_masked;
                     when "010" => 
                        m_axi_awaddr  <= bar2_addr_translation(num_addr_bits-1 downto 0) + wr_addr_bar2_masked;
                     when "011" =>
                        m_axi_awaddr  <= bar3_addr_translation(num_addr_bits-1 downto 0) + wr_addr_bar3_masked;
                     when "100" => 
                        m_axi_awaddr  <= bar4_addr_translation(num_addr_bits-1 downto 0) + wr_addr_bar4_masked;
                     when "101" =>
                        m_axi_awaddr  <= bar5_addr_translation(num_addr_bits-1 downto 0) + wr_addr_bar5_masked;
                     when others => 
                        m_axi_awaddr  <= bar5_addr_translation(num_addr_bits-1 downto 0) + wr_addr_bar5_masked;
                  end case;                                                                                  
                  m_axi_wstrb   <= wr_be(3 downto 0);
                  m_axi_wvalid  <= '1';
                  m_axi_awvalid <= '1';
                  output_sm_state <= WAIT_FOR_BOTH_READY;
               else
                  output_sm_state <= WAIT_FOR_WR_DATA;
               end if;
            when  WAIT_FOR_BOTH_READY =>
               if (m_axi_wready = '1') and (m_axi_awready = '1') then
                  m_axi_wvalid  <= '0';
                  m_axi_awvalid <= '0';
                  m_axi_bready  <= '1';
                  output_sm_state <= WAIT_FOR_BRESP;
               elsif (m_axi_wready = '1') then
                  m_axi_wvalid  <= '0';
                  output_sm_state <= WAIT_FOR_AW_READY; 
               elsif (m_axi_awready = '1') then
                  m_axi_awvalid <= '0';
                  output_sm_state <= WAIT_FOR_W_READY;
               else
                  output_sm_state <= WAIT_FOR_BOTH_READY;
               end if; 
            when  WAIT_FOR_AW_READY => 
               if (m_axi_awready = '1') then
                  m_axi_awvalid <= '0';
                  m_axi_bready  <= '1';
                  output_sm_state <= WAIT_FOR_BRESP;
               else
                  output_sm_state <= WAIT_FOR_AW_READY; 
               end if;
            when  WAIT_FOR_W_READY => 
               if (m_axi_wready = '1') then
                  m_axi_wvalid <= '0';
                  m_axi_bready  <= '1';
                  output_sm_state <= WAIT_FOR_BRESP;
               else
                  output_sm_state <= WAIT_FOR_W_READY;
               end if; 
            when WAIT_FOR_BRESP =>
               if (m_axi_bvalid = '1') then
                  m_axi_bready  <= '0';
                  output_sm_state <= WAIT_FOR_WR_DATA;
                  wr_busy       <= '0';
               else
                  output_sm_state <= WAIT_FOR_BRESP;
               end if; 
            when others => 
               output_sm_state <= RESET_STATE;
         end case;
      end if;
   end if;
end process;   

m_axi_awprot <= "000";

end Behavioral;
