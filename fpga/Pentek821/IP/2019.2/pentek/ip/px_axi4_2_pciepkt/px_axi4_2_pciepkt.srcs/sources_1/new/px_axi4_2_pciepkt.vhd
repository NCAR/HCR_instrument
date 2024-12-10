----------------------------------------------------------------------------------
-- Company: Pentek
-- Engineer: 
-- 
-- Create Date: 09/17/2019 10:02:20 AM
-- Design Name: 
-- Module Name: px_axi4_2_pciepkt - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Converts an AXI4 MM burst to a PCIe Packet compatible with the 
-- AXI-Stream version of the PCIe Core.

-- Limitations: Supports only aligned transactions. Supports only transactions of full 32-bit words.
--              Supports 512-bit Data, Data Aligned mode of Ultrascale+ PCIe Streaming IP Core only.  

-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 

-- (c) Copyright 2019 Pentek, Inc. All rights reserved.
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
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axi4_2_pciepkt is
generic(
channel_id_width            : integer range 1 to 16 := 5; 
data_axi_addr_width         : integer range 7 to 64 := 64
);
port (
   aclk                     : in  std_logic; 
   -- associated with aclk
   aresetn                  : in  std_logic;
   ----------------------------------------------------------------------------
   -- Input Data Bus (AXI-4 Slave)
   ----------------------------------------------------------------------------  
   s_axi_mm2s_awid          : in  std_logic_vector(channel_id_width-1 downto 0);        
   s_axi_mm2s_awaddr        : in  std_logic_vector(data_axi_addr_width-1 downto 0);       
   s_axi_mm2s_awlen         : in  std_logic_vector(7 downto 0);        
   s_axi_mm2s_awsize        : in  std_logic_vector(2 downto 0);        
   s_axi_mm2s_awburst       : in  std_logic_vector(1 downto 0);        
   s_axi_mm2s_awprot        : in  std_logic_vector(2 downto 0);        
   s_axi_mm2s_awcache       : in  std_logic_vector(3 downto 0);        
   s_axi_mm2s_awuser        : in  std_logic_vector(3 downto 0);        
   s_axi_mm2s_awvalid       : in  std_logic;                           
   s_axi_mm2s_awready       : out std_logic;                            
   s_axi_mm2s_wdata         : in  std_logic_vector(511 downto 0);      
   s_axi_mm2s_wstrb         : in  std_logic_vector(63 downto 0);       
   s_axi_mm2s_wlast         : in  std_logic;                           
   s_axi_mm2s_wvalid        : in  std_logic;                           
   s_axi_mm2s_wready        : out std_logic;                            
   s_axi_mm2s_bresp         : out std_logic_vector(1 downto 0);         
   s_axi_mm2s_bvalid        : out std_logic;                            
   s_axi_mm2s_bready        : in  std_logic;   
   s_axi_mm2s_bid           : out std_logic_vector(channel_id_width-1 downto 0);                   
   ----------------------------------------------------------------------------
   -- Output PCIe Packet Data Stream (AXI-Stream Stream Master)
   ----------------------------------------------------------------------------  
   m_axis_pcie_rq_tvalid         : out std_logic;
   m_axis_pcie_rq_tready         : in  std_logic;
   m_axis_pcie_rq_tdata          : out std_logic_vector(511 downto 0);
   m_axis_pcie_rq_tkeep          : out std_logic_vector(63 downto 0);    
   m_axis_pcie_rq_tuser          : out std_logic_vector(136 downto 0);
   m_axis_pcie_rq_tlast          : out std_logic -- end of packet
   -----------------------------------------------------------------------------
     );
end px_axi4_2_pciepkt;

architecture Behavioral of px_axi4_2_pciepkt is

--------------------------------------------------------------------------------
--Types
--------------------------------------------------------------------------------
type state_type is (
    RESET_STATE,
    MAKE_HEADER_STATE,
    PAYLOAD_STATE,
    FINISH_LAST128_STATE
);

type in_state_type is (
    RESET_STATE,
    GET_ADDR_STATE,
    GET_DATA_STATE,
    WAIT_NOT_AFL_STATE
);

--------------------------------------------------------------------------------
--Signals
--------------------------------------------------------------------------------

signal in_fifo_en : std_logic := '0';
signal addr_fifo_en : std_logic := '0';
signal afl: std_logic := '0';
signal rst_n: std_logic := '0';
signal addr: std_logic_vector(63 downto 0) := (others => '0');
signal in_state: in_state_type := RESET_STATE;
signal len_dw_burst: std_logic_vector(11 downto 0) := (others => '0');
signal lbyte_en: std_logic_vector(3 downto 0) := (others => '0');
signal pkt_len: std_logic_vector(11 downto 0) := (others => '0');
signal in_fifo_tvalid: std_logic := '0';
signal in_fifo_tkeep: std_logic_vector(63 downto 0) := (others => '0');
signal in_fifo_tdata: std_logic_vector(511 downto 0) := (others => '0');
signal in_fifo_tlast: std_logic := '0';
signal pld_tdata: std_logic_vector(511 downto 0) := (others => '0');
signal pld_tkeep: std_logic_vector(63 downto 0) := (others => '0');
signal pld_tlast: std_logic := '0';
signal pld_tvalid: std_logic := '0';
signal pld_tready: std_logic := '0';
signal s_addr_tuser: std_logic_vector(15 downto 0) := (others => '0');
signal s_addr_tdata: std_logic_vector(63 downto 0) := (others => '0');
signal s_addr_tvalid: std_logic:= '0';
signal m_addr_tuser: std_logic_vector(15 downto 0) := (others => '0');
signal m_addr_tdata: std_logic_vector(63 downto 0) := (others => '0');
signal m_addr_tvalid: std_logic:= '0';
signal m_addr_tready: std_logic:= '0';
signal hdr_addr: std_logic_vector(63 downto 0) := (others => '0');
signal dword_count: std_logic_vector(10 downto 0) := (others => '0'); 
signal req_type      : std_logic_vector(3 downto 0) := (others => '0');
signal tc            : std_logic_vector(2 downto 0) := (others => '0');
signal poisoned_req  : std_logic := '0';
signal tag           : std_logic_vector(7 downto 0) := (others => '0');
signal req_id_en     : std_logic := '0';
signal force_erc     : std_logic := '0';
signal attr          : std_logic_vector(2 downto 0) := (others => '0');
signal comp_id       : std_logic_vector(15 downto 0) := (others => '0');
signal req_id        : std_logic_vector(15 downto 0) := (others => '0');
signal tag_incr      : std_logic := '0';
signal tag_cntr      : std_logic_vector(7 downto 0) := (others => '0');
signal at            : std_logic_vector(1 downto 0) := "00";
signal state: state_type := RESET_STATE;
signal rq_tuser      : std_logic_vector(15 downto 0) := (others => '0'); 
signal packet_tvalid : std_logic := '0'; 
signal packet_tready : std_logic := '0'; 
signal packet_tdata  : std_logic_vector(511 downto 0) := (others => '0');  
signal packet_tkeep_x: std_logic_vector(63 downto 0) := (others => '0');
signal packet_tkeep  : std_logic_vector(15 downto 0) := (others => '0');
signal packet_tlast  : std_logic := '0';    
signal packet_tuser  : std_logic_vector(15 downto 0) := (others => '0'); 
signal out_tkeep     : std_logic_vector(63 downto 0) := (others => '0');
signal out_fifo_afl  : std_logic := '0';
signal m_axis_rq_tvalid_int: std_logic := '0';
signal pld_dw_tkeep: std_logic_vector(15 downto 0) := (others => '0'); 
signal last_tdata: std_logic_vector(127 downto 0) := (others => '0');
signal last_tkeep: std_logic_vector(3 downto 0) := (others => '0');

begin

s_axi_mm2s_bresp <= "00"; 

--------------------------------------------------------------------------------
-- Payload Receiver
--------------------------------------------------------------------------------
-- We need to find the number of bytes in the burst. We do this by storing the 
-- burst and calculating using the burst length and the number of asserted
-- strobe bits at the end of the packet.

gen_addr_zeros: if (data_axi_addr_width < 64) generate
addr(64-data_axi_addr_width downto data_axi_addr_width) <= (others => '0');
end generate;

process(aclk)
begin
    if rising_edge(aclk) then
        if rst_n = '0' then
            in_state <= RESET_STATE;
            addr_fifo_en <= '0';
            in_fifo_en   <= '0';
            s_axi_mm2s_awready <= '0';
            s_axi_mm2s_wready  <= '0';
            s_axi_mm2s_bvalid  <= '0';
        else
            case in_state is
                when RESET_STATE =>
                    if (rst_n = '1') and (afl = '0') then
                       s_axi_mm2s_awready <= '1';
                       in_state <= GET_ADDR_STATE;
                    end if;
                    s_axi_mm2s_wready  <= '0';
                    s_axi_mm2s_bvalid  <= '0';
                    addr_fifo_en <= '0';
                    in_fifo_en   <= '0';
                when GET_ADDR_STATE =>
                    if s_axi_mm2s_awvalid = '1' then
                        addr(data_axi_addr_width-1 downto 0) <= s_axi_mm2s_awaddr;
                        len_dw_burst <= (s_axi_mm2s_awlen & "0000") + 16;
                        s_axi_mm2s_wready <= '1';
                        in_state <= GET_DATA_STATE;
                        in_fifo_en <= '1';
                        lbyte_en <= "1111";
                        s_axi_mm2s_awready <= '0';
                        s_axi_mm2s_bid <= s_axi_mm2s_awid;
                    end if;
                    if s_axi_mm2s_bready = '1' then
                        s_axi_mm2s_bvalid <= '0';
                    end if;
                    addr_fifo_en <= '0';
                when GET_DATA_STATE =>
                    if (s_axi_mm2s_wvalid = '1') and (s_axi_mm2s_wlast = '1') then
                        if s_axi_mm2s_wstrb(60) = '1' then
                            pkt_len <= len_dw_burst;
                        elsif s_axi_mm2s_wstrb(56) = '1' then
                            pkt_len <= len_dw_burst - 1;
                        elsif s_axi_mm2s_wstrb(52) = '1' then
                            pkt_len <= len_dw_burst - 2;
                        elsif s_axi_mm2s_wstrb(48) = '1' then
                            pkt_len <= len_dw_burst - 3;
                        elsif s_axi_mm2s_wstrb(44) = '1' then
                            pkt_len <= len_dw_burst - 4;
                        elsif s_axi_mm2s_wstrb(40) = '1' then
                            pkt_len <= len_dw_burst - 5;
                        elsif s_axi_mm2s_wstrb(36) = '1' then
                            pkt_len <= len_dw_burst - 6;
                        elsif s_axi_mm2s_wstrb(32) = '1' then
                            pkt_len <= len_dw_burst - 7;
                        elsif s_axi_mm2s_wstrb(28) = '1' then
                            pkt_len <= len_dw_burst - 8;
                        elsif s_axi_mm2s_wstrb(24) = '1' then
                            pkt_len <= len_dw_burst - 9;
                        elsif s_axi_mm2s_wstrb(20) = '1' then
                            pkt_len <= len_dw_burst - 10;
                        elsif s_axi_mm2s_wstrb(16) = '1' then
                            pkt_len <= len_dw_burst - 11;
                        elsif s_axi_mm2s_wstrb(12) = '1' then
                            pkt_len <= len_dw_burst - 12;
                        elsif s_axi_mm2s_wstrb(8)  = '1' then
                            pkt_len <= len_dw_burst - 13;
                        elsif s_axi_mm2s_wstrb(4)  = '1' then
                            pkt_len <= len_dw_burst - 14;
                        else 
                            pkt_len <= len_dw_burst - 15; 
                            if  (len_dw_burst = x"010") then
                                lbyte_en <= "0000"; 
                            end if; 
                        end if;    
                        s_axi_mm2s_wready  <= '0';
                        s_axi_mm2s_bvalid  <= '1';
                        if (afl = '0') then
                          s_axi_mm2s_awready <= '1';
                          in_state <= GET_ADDR_STATE;
                        else
                          in_state <= WAIT_NOT_AFL_STATE;
                        end if;
                        in_fifo_en <= '0';
                        addr_fifo_en <= '1';
                    end if;  
                when WAIT_NOT_AFL_STATE =>
                    addr_fifo_en <= '0';
                    if s_axi_mm2s_bready = '1' then
                           s_axi_mm2s_bvalid <= '0';
                    end if;
                    if (afl = '0') then
                        s_axi_mm2s_awready <= '1';
                        in_state <= GET_ADDR_STATE;
                    end if;
                    addr_fifo_en <= '0';
                when others =>
                   in_state <= RESET_STATE;
             end case;
         end if;               
    end if;
end process;

s_axi_mm2s_wready <= in_fifo_en;
in_fifo_tvalid <= in_fifo_en and s_axi_mm2s_wvalid;
in_fifo_tkeep  <= s_axi_mm2s_wstrb; 
in_fifo_tdata  <= s_axi_mm2s_wdata;
in_fifo_tlast  <= s_axi_mm2s_wlast;
s_addr_tuser  <= lbyte_en & pkt_len;
s_addr_tdata  <= addr;
s_addr_tvalid <= addr_fifo_en;

--------------------------------------------------------------------------------
-- Payload FIFO
--------------------------------------------------------------------------------
payload_fifo_inst : xpm_fifo_axis
   generic map (
      CDC_SYNC_STAGES => 2,            -- DECIMAL
      CLOCKING_MODE => "common_clock", -- String
      ECC_MODE => "no_ecc",            -- String
      FIFO_DEPTH => 512,              -- DECIMAL
      FIFO_MEMORY_TYPE => "auto",      -- String
      PACKET_FIFO => "true",           -- String
      PROG_EMPTY_THRESH => 10,         -- DECIMAL
      PROG_FULL_THRESH => 256,        -- DECIMAL
      RD_DATA_COUNT_WIDTH => 1,        -- DECIMAL
      RELATED_CLOCKS => 0,             -- DECIMAL
--      SIM_ASSERT_CHK => 0,           -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      TDATA_WIDTH => 512,              -- DECIMAL
      TDEST_WIDTH => 1,                -- DECIMAL
      TID_WIDTH => 1,                  -- DECIMAL
      TUSER_WIDTH => 1,                -- DECIMAL
      USE_ADV_FEATURES => "1002",      -- String
      WR_DATA_COUNT_WIDTH => 1         -- DECIMAL
   )
   port map (
      almost_empty_axis     => open,
      almost_full_axis      => open,
      dbiterr_axis          => open,
      m_axis_tdata          => pld_tdata,
      m_axis_tdest          => open,
      m_axis_tid            => open,
      m_axis_tkeep          => pld_tkeep,
      m_axis_tlast          => pld_tlast,
      m_axis_tstrb          => open,
      m_axis_tuser          => open,
      m_axis_tvalid         => pld_tvalid,
      prog_empty_axis       => open,
      prog_full_axis        => afl,
      rd_data_count_axis    => open,
      s_axis_tready         => open,
      sbiterr_axis          => open,
      wr_data_count_axis    => open, 
      injectdbiterr_axis    => '0',
      injectsbiterr_axis    => '0',
      m_aclk                => aclk,
      m_axis_tready         => pld_tready,
      s_aclk                => aclk,
      s_aresetn             => rst_n,
      s_axis_tdata          => in_fifo_tdata,
      s_axis_tdest          => "0",
      s_axis_tid            => "0",
      s_axis_tkeep          => in_fifo_tkeep,
      s_axis_tlast          => in_fifo_tlast,
      s_axis_tstrb          => x"FFFFFFFFFFFFFFFF",
      s_axis_tuser          => "0",
      s_axis_tvalid         => in_fifo_tvalid
   );

--------------------------------------------------------------------------------
-- Address FIFO
--------------------------------------------------------------------------------
-- This FIFO holds the address and packet length info to construct a header from.


addr_fifo_inst : xpm_fifo_axis
   generic map (
      CDC_SYNC_STAGES => 2,            -- DECIMAL
      CLOCKING_MODE => "common_clock", -- String
      ECC_MODE => "no_ecc",            -- String
      FIFO_DEPTH => 512,              -- DECIMAL
      FIFO_MEMORY_TYPE => "auto",      -- String
      PACKET_FIFO => "false",          -- String
      PROG_EMPTY_THRESH => 10,         -- DECIMAL
      PROG_FULL_THRESH => 10,          -- DECIMAL
      RD_DATA_COUNT_WIDTH => 1,        -- DECIMAL
      RELATED_CLOCKS => 0,             -- DECIMAL
--      SIM_ASSERT_CHK => 0,           -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      TDATA_WIDTH => 64,              -- DECIMAL
      TDEST_WIDTH => 1,                -- DECIMAL
      TID_WIDTH => 1,                  -- DECIMAL
      TUSER_WIDTH => 16,                -- DECIMAL
      USE_ADV_FEATURES => "1000",      -- String
      WR_DATA_COUNT_WIDTH => 1         -- DECIMAL
   )
   port map (
      almost_empty_axis     => open,
      almost_full_axis      => open,
      dbiterr_axis          => open,
      m_axis_tdata          => m_addr_tdata,
      m_axis_tdest          => open,
      m_axis_tid            => open,
      m_axis_tkeep          => open,
      m_axis_tlast          => open,
      m_axis_tstrb          => open,
      m_axis_tuser          => m_addr_tuser,
      m_axis_tvalid         => m_addr_tvalid,
      prog_empty_axis       => open,
      prog_full_axis        => open,
      rd_data_count_axis    => open,
      s_axis_tready         => open,
      sbiterr_axis          => open,
      wr_data_count_axis    => open, 
      injectdbiterr_axis    => '0',
      injectsbiterr_axis    => '0',
      m_aclk                => aclk,
      m_axis_tready         => m_addr_tready,
      s_aclk                => aclk,
      s_aresetn             => rst_n,
      s_axis_tdata          => s_addr_tdata,
      s_axis_tdest          => "0",
      s_axis_tid            => "0",
      s_axis_tkeep          =>  x"FF",
      s_axis_tlast          => '0',
      s_axis_tstrb          => x"FF",
      s_axis_tuser          => s_addr_tuser,
      s_axis_tvalid         => s_addr_tvalid
   );

--------------------------------------------------------------------------------
-- Packet Generating State Machine
--------------------------------------------------------------------------------

hdr_addr        <= m_addr_tdata(63 downto 0);
dword_count     <= m_addr_tuser(10 downto 0);
req_type        <= "0001"; -- Memory Write Type
poisoned_req    <= '0';
--tag             <= pcie_channel & tag_cntr; 
tag             <= tag_cntr; 
req_id_en       <= '0';
force_erc       <= '0';
attr            <= "000";
comp_id         <= x"0000";
req_id          <= x"0000";
tc              <= "000"; 
at              <= "00";

pld_dw_tkeep <= pld_tkeep(60) & pld_tkeep(56) & pld_tkeep(52)& pld_tkeep(48)& pld_tkeep(44)& pld_tkeep(40)& pld_tkeep(36)& pld_tkeep(32)& pld_tkeep(28)& pld_tkeep(24)& pld_tkeep(20)& pld_tkeep(16)& pld_tkeep(12)& pld_tkeep(8) & pld_tkeep(4) & pld_tkeep(0);

process(aclk)
begin
    if rising_edge(aclk) then
        rst_n <= aresetn; 
        if rst_n = '0' then
            state <= RESET_STATE;
            m_addr_tready  <= '0';
            pld_tready     <= '0';
            packet_tlast   <= '0';
            packet_tvalid  <= '0';
            packet_tkeep   <= x"0000";
            tag_incr       <= '0';
        else
            case state is
                when RESET_STATE =>
                    packet_tlast   <= '0';
                    packet_tvalid  <= '0';
                    packet_tkeep   <= x"0000";
                    tag_incr       <= '0';
                    if (rst_n =  '1') and (out_fifo_afl = '0') then -- Address and packet FIFO not afl
                        state <= MAKE_HEADER_STATE;
                        m_addr_tready     <= '1';
                        pld_tready        <= '1';
                    else
                        state <= RESET_STATE;
                        pld_tready        <= '0';
                        m_addr_tready     <= '0';
                    end if;
                when MAKE_HEADER_STATE =>  -- Tack on the required header
                    if (m_addr_tvalid = '1') and (pld_tvalid = '1') then -- Address and Payload is available
                        m_addr_tready     <= '0';
                        if (pld_tlast = '1') then
                            if (pld_dw_tkeep(15 downto 12) = "0000") then -- no data left to shift into next cycle;
                                state <= RESET_STATE;
                                packet_tlast   <= '1';  
                            else
                                state <= FINISH_LAST128_STATE;
                                packet_tlast   <= '0';  
                            end if;
                            pld_tready     <= '0';
                        else
                            state              <= PAYLOAD_STATE; -- fifo has valid data in it  
                            packet_tlast       <= '0';                                                 
                        end if;
                        packet_tvalid <= '1';
                        last_tdata       <= pld_tdata(511 downto 384);
                        last_tkeep       <= pld_dw_tkeep(15 downto 12);
                        -- Header + first data (Data Aligned)
                        packet_tdata <= pld_tdata(383 downto 0) & force_erc & attr & tc & req_id_en & comp_id & tag & req_id & poisoned_req & req_type & dword_count & hdr_addr(63 downto 2) & at;
                        packet_tuser(3 downto 0 ) <= "1111"; -- First BE
                        packet_tuser(11 downto 8 )<= m_addr_tuser(15 downto 12); -- Last BE
                        packet_tkeep              <= pld_dw_tkeep(11 downto 0) & x"F";
                        tag_incr                  <= '1'; -- increment tag counter 
                    else
                        state <= MAKE_HEADER_STATE;
                    end if;    
                when PAYLOAD_STATE => 
                    tag_incr           <= '0';
                    packet_tdata       <= pld_tdata(383 downto 0)    & last_tdata;
                    last_tdata      <= in_fifo_tdata(511 downto 384);
                    if (pld_tlast = '1') then
                        if (pld_dw_tkeep(15 downto 12)= "0000") then -- no data left to shift into next cycle;
                            state <= RESET_STATE;
                            packet_tlast   <= '1';  
                        else
                            state <= FINISH_LAST128_STATE;
                            packet_tlast   <= '0';  
                        end if;
                        pld_tready     <= '0';
                    else
                        state              <= PAYLOAD_STATE; -- fifo has valid data in it  
                        packet_tlast       <= '0';                                                 
                    end if;
                    packet_tkeep       <= pld_dw_tkeep(11 downto 0) & last_tkeep;
                    packet_tvalid      <= '1';            
                when FINISH_LAST128_STATE => -- Finish last 128 bits of data
                    tag_incr           <= '0';
                    packet_tdata(511 downto 128) <= (others => '0'); 
                    packet_tdata(127 downto 0)   <= last_tdata;
                    packet_tlast       <= '1';   
                    state              <= RESET_STATE;
                    pld_tready         <= '0';
                    packet_tkeep       <= x"000" & last_tkeep;
                    packet_tvalid      <= '1';
                when others =>
                    state        <= RESET_STATE;
            end case;
        end if;
    end if;
end process;
--------------------------------------------------------------------------------
-- Output FIFO
--------------------------------------------------------------------------------
-- The PCIe Core interface requires that packets be fed to it in contiguous
-- fashion with no interruption of tvalid.  Therefore we need to buffer up a packet
-- until it is completely constructed before presenting it to the PCIe Requestor 
-- Request AXI stream bus.
-- A "Store and Forward" FIFO is used to accomplish this. 

pkt_fifo_inst : xpm_fifo_axis
   generic map (
      CDC_SYNC_STAGES => 2,            -- DECIMAL
      CLOCKING_MODE => "common_clock", -- String
      ECC_MODE => "no_ecc",            -- String
      FIFO_DEPTH => 512,              -- DECIMAL
      FIFO_MEMORY_TYPE => "auto",      -- String
      PACKET_FIFO => "true",           -- String
      PROG_EMPTY_THRESH => 10,         -- DECIMAL
      PROG_FULL_THRESH => 256,        -- DECIMAL
      RD_DATA_COUNT_WIDTH => 1,        -- DECIMAL
      RELATED_CLOCKS => 0,             -- DECIMAL
--      SIM_ASSERT_CHK => 0,           -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      TDATA_WIDTH => 512,              -- DECIMAL
      TDEST_WIDTH => 1,                -- DECIMAL
      TID_WIDTH => 1,                  -- DECIMAL
      TUSER_WIDTH => 16,                -- DECIMAL
      USE_ADV_FEATURES => "1002",      -- String
      WR_DATA_COUNT_WIDTH => 1         -- DECIMAL
   )
   port map (
      almost_empty_axis     => open,
      almost_full_axis      => open,
      dbiterr_axis          => open,
      m_axis_tdata          => m_axis_pcie_rq_tdata,
      m_axis_tdest          => open,
      m_axis_tid            => open,
      m_axis_tkeep          => m_axis_pcie_rq_tkeep,
      m_axis_tlast          => m_axis_pcie_rq_tlast,
      m_axis_tstrb          => open,
      m_axis_tuser          => rq_tuser,
      m_axis_tvalid         => m_axis_pcie_rq_tvalid,
      prog_empty_axis       => open,
      prog_full_axis        => out_fifo_afl,
      rd_data_count_axis    => open,
      s_axis_tready         => packet_tready,
      sbiterr_axis          => open,
      wr_data_count_axis    => open, 
      injectdbiterr_axis    => '0',
      injectsbiterr_axis    => '0',
      m_aclk                => aclk,
      m_axis_tready         => m_axis_pcie_rq_tready,
      s_aclk                => aclk,
      s_aresetn             => rst_n,
      s_axis_tdata          => packet_tdata,
      s_axis_tdest          => "0",
      s_axis_tid            => "0",
      s_axis_tkeep          => packet_tkeep_x,
      s_axis_tlast          => packet_tlast,
      s_axis_tstrb          => x"FFFFFFFFFFFFFFFF",
      s_axis_tuser          => packet_tuser,
      s_axis_tvalid         => packet_tvalid
   );


packet_tkeep_x(3 downto 0)   <= packet_tkeep(0)  & packet_tkeep(0)  & packet_tkeep(0)  & packet_tkeep(0);
packet_tkeep_x(7 downto 4)   <= packet_tkeep(1)  & packet_tkeep(1)  & packet_tkeep(1)  & packet_tkeep(1);
packet_tkeep_x(11 downto 8)  <= packet_tkeep(2)  & packet_tkeep(2)  & packet_tkeep(2)  & packet_tkeep(2);
packet_tkeep_x(15 downto 12) <= packet_tkeep(3)  & packet_tkeep(3)  & packet_tkeep(3)  & packet_tkeep(3);
packet_tkeep_x(19 downto 16) <= packet_tkeep(4)  & packet_tkeep(4)  & packet_tkeep(4)  & packet_tkeep(4);
packet_tkeep_x(23 downto 20) <= packet_tkeep(5)  & packet_tkeep(5)  & packet_tkeep(5)  & packet_tkeep(5);
packet_tkeep_x(27 downto 24) <= packet_tkeep(6)  & packet_tkeep(6)  & packet_tkeep(6)  & packet_tkeep(6);
packet_tkeep_x(31 downto 28) <= packet_tkeep(7)  & packet_tkeep(7)  & packet_tkeep(7)  & packet_tkeep(7);
packet_tkeep_x(35 downto 32) <= packet_tkeep(8)  & packet_tkeep(8)  & packet_tkeep(8)  & packet_tkeep(8);
packet_tkeep_x(39 downto 36) <= packet_tkeep(9)  & packet_tkeep(9)  & packet_tkeep(9)  & packet_tkeep(9);
packet_tkeep_x(43 downto 40) <= packet_tkeep(10) & packet_tkeep(10) & packet_tkeep(10) & packet_tkeep(10);
packet_tkeep_x(47 downto 44) <= packet_tkeep(11) & packet_tkeep(11) & packet_tkeep(11) & packet_tkeep(11);
packet_tkeep_x(51 downto 48) <= packet_tkeep(12) & packet_tkeep(12) & packet_tkeep(12) & packet_tkeep(12);
packet_tkeep_x(55 downto 52) <= packet_tkeep(13) & packet_tkeep(13) & packet_tkeep(13) & packet_tkeep(13);
packet_tkeep_x(59 downto 56) <= packet_tkeep(14) & packet_tkeep(14) & packet_tkeep(14) & packet_tkeep(14);
packet_tkeep_x(63 downto 60) <= packet_tkeep(15) & packet_tkeep(15) & packet_tkeep(15) & packet_tkeep(15);

--------------------------------------------------------------------------------
-- Tag Counter
--------------------------------------------------------------------------------

process(aclk)
begin
    if rising_edge(aclk) then
        if rst_n = '0' then
            tag_cntr <= "00000000";
        elsif tag_incr = '1' then
            tag_cntr <= tag_cntr + 1;
        end if;
    end if;
end process;


packet_tuser(15 downto 12) <= "0000";

m_axis_pcie_rq_tuser(3 downto 0)   <= rq_tuser(3 downto 0);
m_axis_pcie_rq_tuser(7 downto 4)   <= (others => '0');
m_axis_pcie_rq_tuser(11 downto 8)  <= rq_tuser(11 downto 8);
m_axis_pcie_rq_tuser(136 downto 12)<= (others => '0');



end Behavioral;
