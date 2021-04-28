----------------------------------------------------------------------------------
-- Pentek HMC to PCI Express DMA  - PCIe Packetizer
----------------------------------------------------------------------------------
-- px_dma_hmc2pcie_pcie_packetizer.vhd
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

entity px_dma_ppkt2pcie_pcie_packetizer is
generic(
    pcie_channel : std_logic_vector(2 downto 0);
    lite         : boolean := false -- lite = 256 bit input
);
port (
    clk                       : in  std_logic;
    rst_n                     : in  std_logic;
    
    abort                     : in  std_logic; 
    abort_busy                : out std_logic; 
    byte_swap                 : in  std_logic;
    fifo_empty                : out std_logic;
    ----------------------------------------------------------------------------
    -- Payload Data (AXI Stream)
    ----------------------------------------------------------------------------
    -- tuser
    -- [63:0]  = Destination Address
    -- [68:64] = first dw offset
    -- [69]    = SOP
    -- [71:70] = PCIe AT
    -- [75:72] = valid first bytes
    -- [79:76] = valid last bytes
    -- [87:80] = number of DWORDS in packet
    afl                       : out std_logic;
    s_axis_payload_tvalid     : in  std_logic;
    s_axis_payload_tlast      : in  std_logic;
    s_axis_payload_tdata      : in  std_logic_vector(511 downto 0);
    s_axis_payload_tuser      : in  std_logic_vector(95 downto 0);   
    s_axis_payload_tkeep      : in  std_logic_vector(15 downto 0);
    ----------------------------------------------------------------------------
    -- PCIe Packet Output Data (AXI Stream)
    ----------------------------------------------------------------------------    
    m_axis_rq_tvalid          : out std_logic;
    m_axis_rq_tready          : in  std_logic;    
    m_axis_rq_tlast           : out std_logic;
    m_axis_rq_tdata           : out std_logic_vector(255 downto 0);
    m_axis_rq_tuser           : out std_logic_vector(59 downto 0);   
    m_axis_rq_tkeep           : out std_logic_vector(7 downto 0)    
    
);
end px_dma_ppkt2pcie_pcie_packetizer;

architecture Behavioral of px_dma_ppkt2pcie_pcie_packetizer is

--------------------------------------------------------------------------------
--Types
--------------------------------------------------------------------------------
type state_type is (
    RESET_STATE,
    MAKE_HEADER_STATE,
    PAYLOAD1_STATE,
    PAYLOAD2_STATE
);

type abort_state_type is (
    RESET_STATE,
    NORMAL_STATE,
    START_ABORT_STATE,
    WAIT1_STATE,
    WAIT2_STATE,
    WAIT3_STATE,
    WAIT4_STATE,
    WAIT5_STATE,
    WAIT6_STATE,
    WAIT7_STATE,
    WAIT8_STATE
);

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- AXI Stream FIFO
-- "Store and Forward" FIFO (Packet FIFO type)
-- Block RAM
-- 256x256
-- AFL at 247
-- common clock
component px_dma_ppkt2pcie_req_pktcnstr_fifo
  port (
    s_aclk : in std_logic;
    s_aresetn : in std_logic;
    s_axis_tvalid : in std_logic;
    s_axis_tready : out std_logic;
    s_axis_tdata : in std_logic_vector(255 downto 0);
    s_axis_tkeep : in std_logic_vector(31 downto 0);
    s_axis_tlast : in std_logic;
    s_axis_tuser : in std_logic_vector(15 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in std_logic;
    m_axis_tdata : out std_logic_vector(255 downto 0);
    m_axis_tkeep : out std_logic_vector(31 downto 0);
    m_axis_tlast : out std_logic;
    m_axis_tuser : out std_logic_vector(15 downto 0);
    axis_data_count : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    axis_prog_full : out std_logic
  );
end component;

-- AXI Stream FIFO
-- "Store and Forward" FIFO (Packet FIFO type)
-- Distributed RAM
-- 128x512
-- AFL at 64
-- common clock
component px_dma_ppkt2pcie_req_in_fifo
  port (
    s_aclk : in std_logic;
    s_aresetn : in std_logic;
    s_axis_tvalid : in std_logic;
    s_axis_tready : out std_logic;
    s_axis_tdata : in std_logic_vector(511 downto 0);
    s_axis_tlast : in std_logic;
    s_axis_tuser : in std_logic_vector(111 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in std_logic;
    m_axis_tdata : out std_logic_vector(511 downto 0);
    m_axis_tlast : out std_logic;
    m_axis_tuser : out std_logic_vector(111 downto 0);
    axis_data_count : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    axis_prog_full : out std_logic
  );
end component;

-- AXI Stream FIFO
-- "Store and Forward" FIFO (Packet FIFO type)
-- Distributed RAM
-- 32x256
-- AFL at 24
-- common clock
component px_dma_ppkt2pcie_req_in_lfifo
  port (
    s_aclk : in std_logic;
    s_aresetn : in std_logic;
    s_axis_tvalid : in std_logic;
    s_axis_tready : out std_logic;
    s_axis_tdata : in std_logic_vector(255 downto 0);
    s_axis_tlast : in std_logic;
    s_axis_tuser : in std_logic_vector(111 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in std_logic;
    m_axis_tdata : out std_logic_vector(255 downto 0);
    m_axis_tlast : out std_logic;
    m_axis_tuser : out std_logic_vector(111 downto 0);
    axis_data_count : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    axis_prog_full : out std_logic
  );
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal state         : state_type := RESET_STATE;
signal abort_state   : abort_state_type := RESET_STATE;
signal payload_tuser : std_logic_vector(111 downto 0) := (others => '0');
signal rstn          : std_logic := '0';
signal out_fifo_rst_n: std_logic := '0';
signal in_fifo_tvalid: std_logic := '0';
signal in_fifo_tready: std_logic := '0';
signal in_fifo_tdata : std_logic_vector(511 downto 0) := (others => '0');
signal in_fifo_tdata_bs : std_logic_vector(511 downto 0) := (others => '0');
signal in_fifo_tlast : std_logic := '0';
signal in_fifo_tuser : std_logic_vector(111 downto 0) := (others => '0');
signal in_fifo_tkeep : std_logic_vector(15 downto 0) := (others => '0'); 
signal tag_cntr      : std_logic_vector(2 downto 0) := (others => '0');
signal packet_tvalid : std_logic := '0'; 
signal packet_tready : std_logic := '0'; 
signal packet_tdata  : std_logic_vector(255 downto 0) := (others => '0');  
signal packet_tkeep_x: std_logic_vector(31 downto 0) := (others => '0');
signal packet_tkeep  : std_logic_vector(7 downto 0) := (others => '0');
signal packet_tlast  : std_logic := '0';    
signal packet_tuser  : std_logic_vector(15 downto 0) := (others => '0');  
signal rq_tuser      : std_logic_vector(15 downto 0) := (others => '0');  
signal out_tkeep     : std_logic_vector(31 downto 0) := (others => '0');
signal out_fifo_afl  : std_logic := '0';
signal abort_ff      : std_logic := '0';
signal out_fifo_abort_rst: std_logic := '0';
signal addr          : std_logic_vector(63 downto 0) := (others => '0');
signal dword_count   : std_logic_vector(10 downto 0) := (others => '0');
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
signal m_axis_rq_tvalid_int: std_logic := '0';
signal disable_output: std_logic := '0';
signal abort_busy_int: std_logic := '0';
signal at            : std_logic_vector(1 downto 0) := "00";
signal disc          : std_logic := '0';
signal in_fifo_count : std_logic_vector(7 downto 0) := x"00";
signal pkt_fifo_count : std_logic_vector(8 downto 0) := '0' & x"00";
signal m_axis_rq_tready_int: std_logic := '0';
--------------------------------------------------------------------------------

begin

process(clk)
begin
    if rising_edge(clk) then
        rstn <= not ((not rst_n) or abort_ff);
    end if;
end process;

out_fifo_rst_n  <= not (out_fifo_abort_rst or (not rst_n));

--------------------------------------------------------------------------------
-- Input FIFO
--------------------------------------------------------------------------------
-- Input is still in 512-bit format.
-- The state machine unpacks it to the required 256-bit format for the PCIe core
-- interface.

payload_tuser <= s_axis_payload_tkeep & s_axis_payload_tuser;

gen_nlt_fifo: if (lite = false) generate

-- "Store and Forward" FIFO
req_in_fifo_inst: px_dma_ppkt2pcie_req_in_fifo
port map (
    s_aclk          => clk,
    s_aresetn       => rstn,
    s_axis_tvalid   => s_axis_payload_tvalid,
    s_axis_tready   => open, -- no back pressure
    s_axis_tdata    => s_axis_payload_tdata,
    s_axis_tlast    => s_axis_payload_tlast,
    s_axis_tuser    => payload_tuser,
    m_axis_tvalid   => in_fifo_tvalid,
    m_axis_tready   => in_fifo_tready,
    m_axis_tdata    => in_fifo_tdata,
    m_axis_tlast    => in_fifo_tlast,
    m_axis_tuser    => in_fifo_tuser,
    axis_data_count => in_fifo_count,
    axis_prog_full  => afl
  );

end generate;

gen_lt_fifo: if (lite = true) generate

-- "Store and Forward" FIFO
req_in_fifo_inst: px_dma_ppkt2pcie_req_in_lfifo
port map (
    s_aclk          => clk,
    s_aresetn       => rstn,
    s_axis_tvalid   => s_axis_payload_tvalid,
    s_axis_tready   => open, -- no back pressure
    s_axis_tdata    => s_axis_payload_tdata(255 downto 0),
    s_axis_tlast    => s_axis_payload_tlast,
    s_axis_tuser    => payload_tuser,
    m_axis_tvalid   => in_fifo_tvalid,
    m_axis_tready   => in_fifo_tready,
    m_axis_tdata    => in_fifo_tdata(255 downto 0),
    m_axis_tlast    => in_fifo_tlast,
    m_axis_tuser    => in_fifo_tuser,
    axis_data_count => in_fifo_count,
    axis_prog_full  => afl
  );

in_fifo_tdata(511 downto 256) <= (others => '0');

end generate;

in_fifo_tkeep <= in_fifo_tuser(111 downto 96);

process(clk)
begin
   if rising_edge(clk) then
      if (in_fifo_count = x"00") and (pkt_fifo_count = ('0' & x"00")) then
       fifo_empty  <= '1';
      else
       fifo_empty  <= '0';
      end if; 
   end if;
end process;   
 

--------------------------------------------------------------------------------
-- Packet Generating State Machine
--------------------------------------------------------------------------------

addr            <= in_fifo_tuser(63 downto 0);
dword_count     <= "000" & in_fifo_tuser(87 downto 80);
req_type        <= "0001"; -- Memory Write Type
poisoned_req    <= '0';
tag             <= "00" & pcie_channel & tag_cntr; -- top 2 bits are reserved
req_id_en       <= '0';
force_erc       <= '0';
attr            <= "000";
comp_id         <= x"0000";
req_id          <= x"0000";
tc              <= "000"; 
at              <= in_fifo_tuser(71 downto 70);

gen_nlt_sm: if (lite = false) generate
process(clk)
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            state <= RESET_STATE;
            in_fifo_tready <= '0';
            packet_tlast   <= '0';
            packet_tvalid  <= '0';
            packet_tkeep   <= x"00";
            tag_incr       <= '0';
        else
            case state is
                when RESET_STATE =>
                    in_fifo_tready <= '0';
                    packet_tlast   <= '0';
                    packet_tvalid  <= '0';
                    packet_tkeep   <= x"00";
                    tag_incr       <= '0';
                    --if (abort = '0') and (rst_n =  '1') and (out_fifo_afl = '0') then -- Payload is available
                    if (abort_busy_int = '0') and (rst_n =  '1') and (out_fifo_afl = '0') then -- Payload is available
                        state <= MAKE_HEADER_STATE;
                    else
                        state <= RESET_STATE;
                    end if;
                when MAKE_HEADER_STATE =>  -- Tack on the required header
                    if (abort_busy_int = '1') then
                       state <= RESET_STATE;
                    elsif in_fifo_tvalid = '1' then -- Payload is available
                        if (in_fifo_tuser(67) = '0')  then
                            state <= PAYLOAD1_STATE; -- First 256 bits has valid data in it
                        else
                            state <= PAYLOAD2_STATE; -- First 256 bits is invalid
                            in_fifo_tready     <= '1';
                        end if;                                                         
                        
                        packet_tvalid <= '1';
                        -- Header (address Aligned)
                        packet_tdata <= x"00000000000000000000000000000000" & force_erc & attr & tc & req_id_en & comp_id & tag & req_id & poisoned_req & req_type & dword_count & addr(63 downto 2) & at;
                        packet_tuser(3 downto 0 ) <= in_fifo_tuser(75 downto 72); -- First BE
                        packet_tuser(7 downto 4 ) <= in_fifo_tuser(79 downto 76); -- Last BE
                        packet_tuser(10 downto 8) <= in_fifo_tuser(66 downto 64); -- first DW offset
                        packet_tuser(11)          <= '0'; -- discontinue bit off
                        packet_tlast              <= '0';
                        packet_tkeep              <= x"FF";
                        tag_incr                  <= '1'; -- increment tag counter
                    else
                        state <= MAKE_HEADER_STATE;
                    end if;    
                when PAYLOAD1_STATE => -- Use the first 256 bits of payload
                    tag_incr           <= '0';
                    if byte_swap = '0' then
                        packet_tdata   <= in_fifo_tdata(255 downto 0);
                    else
                        packet_tdata   <= in_fifo_tdata_bs(255 downto 0);
                    end if;
                    if (abort_busy_int = '1') then
                       packet_tlast    <= '0';
                       state           <= RESET_STATE;
                    elsif (in_fifo_tkeep(8) = '0') then
                       state           <= RESET_STATE;
                       packet_tlast    <= in_fifo_tlast;  
                    else
                        state <= PAYLOAD2_STATE;              
                    end if;
                    in_fifo_tready <= '1';
                    packet_tkeep       <= in_fifo_tkeep(7 downto 0);
                    packet_tvalid      <= '1';            
                when PAYLOAD2_STATE => -- Use the second 256 bits of payload
                    tag_incr           <= '0';
                    if byte_swap = '0' then
                       packet_tdata       <= in_fifo_tdata(511 downto 256);
                    else
                       packet_tdata       <= in_fifo_tdata_bs(511 downto 256);
                    end if;               
                    if (abort_busy_int = '1') then
                       packet_tlast       <= '0';
                       state              <= RESET_STATE;
                    elsif (in_fifo_tlast = '1') or (in_fifo_tvalid = '0') then
                       packet_tlast       <= '1';
                       state              <= RESET_STATE;
                    else
                       packet_tlast       <= '0';
                       state              <= PAYLOAD1_STATE;
                    end if;
                    in_fifo_tready     <= '0';
                    packet_tkeep       <= in_fifo_tkeep(15 downto 8);
                    packet_tvalid      <= '1';
                when others =>
                    state        <= RESET_STATE;
            end case;
        end if;
    end if;
end process;

gen_bs: for i in 0 to 15 generate
in_fifo_tdata_bs((32*i)+31 downto (32*i)+24) <= in_fifo_tdata((32*i)+7 downto (32*i)+0);
in_fifo_tdata_bs((32*i)+23 downto (32*i)+16) <= in_fifo_tdata((32*i)+15 downto (32*i)+8);
in_fifo_tdata_bs((32*i)+15 downto (32*i)+8 ) <= in_fifo_tdata((32*i)+23 downto (32*i)+16);
in_fifo_tdata_bs((32*i)+7  downto (32*i)+0 ) <= in_fifo_tdata((32*i)+31 downto (32*i)+24);
end generate;

end generate gen_nlt_sm;

gen_lt_sm: if (lite = true) generate
process(clk)
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            state <= RESET_STATE;
            in_fifo_tready <= '0';
            packet_tlast   <= '0';
            packet_tvalid  <= '0';
            packet_tkeep   <= x"00";
            tag_incr       <= '0';
        else
            case state is
                when RESET_STATE =>
                    in_fifo_tready <= '0';
                    packet_tlast   <= '0';
                    packet_tvalid  <= '0';
                    packet_tkeep   <= x"00";
                    tag_incr       <= '0';
                    --if (abort = '0') and (rst_n =  '1') and (out_fifo_afl = '0') then -- Payload is available
                    if (abort_busy_int = '0') and (rst_n =  '1') and (out_fifo_afl = '0') then -- Payload is available
                        state <= MAKE_HEADER_STATE;
                    else
                        state <= RESET_STATE;
                    end if;
                when MAKE_HEADER_STATE =>  -- Tack on the required header
                    if (abort_busy_int = '1') then
                        state <= RESET_STATE;
                    elsif in_fifo_tvalid = '1' then -- Payload is available
                        state <= PAYLOAD1_STATE; -- First 256 bits has valid data in it
                        in_fifo_tready     <= '1';                        
                        packet_tvalid      <= '1';
                        -- Header (address Aligned)
                        packet_tdata <= x"00000000000000000000000000000000" & force_erc & attr & tc & req_id_en & comp_id & tag & req_id & poisoned_req & req_type & dword_count & addr(63 downto 2) & at;
                        packet_tuser(3 downto 0 ) <= in_fifo_tuser(75 downto 72); -- First BE
                        packet_tuser(7 downto 4 ) <= in_fifo_tuser(79 downto 76); -- Last BE
                        packet_tuser(10 downto 8) <= in_fifo_tuser(66 downto 64); -- first DW offset
                        packet_tuser(11)          <= '0'; -- discontinue bit off
                        packet_tlast              <= '0';
                        packet_tkeep              <= x"FF";
                        tag_incr                  <= '1'; -- increment tag counter
                    else
                        state <= MAKE_HEADER_STATE;
                    end if;    
                when PAYLOAD1_STATE => -- Use the second 256 bits of payload
                    tag_incr              <= '0';
                    if byte_swap = '0' then
                       packet_tdata       <= in_fifo_tdata(255 downto 0);
                    else
                       packet_tdata       <= in_fifo_tdata_bs(255 downto 0);
                    end if;          
                    if (abort_busy_int = '1') then
                       packet_tlast       <= '0';
                       state              <= RESET_STATE;
                       in_fifo_tready     <= '0';
                    elsif (in_fifo_tlast = '1') or (in_fifo_tvalid = '0') then
                       packet_tlast       <= '1';
                       state              <= RESET_STATE;
                       in_fifo_tready     <= '0';
                    else
                       packet_tlast       <= '0';
                       state              <= PAYLOAD1_STATE;
                    end if;
                    packet_tkeep          <= in_fifo_tkeep(7 downto 0);
                    packet_tvalid         <= '1';
                when others =>
                    state        <= RESET_STATE;
            end case;
        end if;
    end if;
end process;

gen_bs: for i in 0 to 7 generate
in_fifo_tdata_bs((32*i)+31 downto (32*i)+24) <= in_fifo_tdata((32*i)+7 downto (32*i)+0);
in_fifo_tdata_bs((32*i)+23 downto (32*i)+16) <= in_fifo_tdata((32*i)+15 downto (32*i)+8);
in_fifo_tdata_bs((32*i)+15 downto (32*i)+8 ) <= in_fifo_tdata((32*i)+23 downto (32*i)+16);
in_fifo_tdata_bs((32*i)+7  downto (32*i)+0 ) <= in_fifo_tdata((32*i)+31 downto (32*i)+24);
end generate;

end generate gen_lt_sm;


packet_tkeep_x(3 downto 0)   <= packet_tkeep(0) & packet_tkeep(0) & packet_tkeep(0) & packet_tkeep(0);
packet_tkeep_x(7 downto 4)   <= packet_tkeep(1) & packet_tkeep(1) & packet_tkeep(1) & packet_tkeep(1);
packet_tkeep_x(11 downto 8)  <= packet_tkeep(2) & packet_tkeep(2) & packet_tkeep(2) & packet_tkeep(2);
packet_tkeep_x(15 downto 12) <= packet_tkeep(3) & packet_tkeep(3) & packet_tkeep(3) & packet_tkeep(3);
packet_tkeep_x(19 downto 16) <= packet_tkeep(4) & packet_tkeep(4) & packet_tkeep(4) & packet_tkeep(4);
packet_tkeep_x(23 downto 20) <= packet_tkeep(5) & packet_tkeep(5) & packet_tkeep(5) & packet_tkeep(5);
packet_tkeep_x(27 downto 24) <= packet_tkeep(6) & packet_tkeep(6) & packet_tkeep(6) & packet_tkeep(6);
packet_tkeep_x(31 downto 28) <= packet_tkeep(7) & packet_tkeep(7) & packet_tkeep(7) & packet_tkeep(7);

--------------------------------------------------------------------------------
-- Tag Counter
--------------------------------------------------------------------------------

process(clk)
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            tag_cntr <= "000";
        elsif tag_incr = '1' then
            tag_cntr <= tag_cntr + 1;
        end if;
    end if;
end process;


packet_tuser(15 downto 12) <= "0000";

--------------------------------------------------------------------------------
-- Output FIFO
--------------------------------------------------------------------------------
-- The PCIe Core interface requires that packets be fed to it in contiguous
-- fashion with no interruption of tvalid.  Therefore we need to buffer up a packet
-- until it is completely constructed before presenting it to the PCIe Requestor 
-- Request AXI stream bus.
-- A "Store and Forward" FIFO is used to accomplish this. 
req_pktcnstr_fifo_inst: px_dma_ppkt2pcie_req_pktcnstr_fifo
port map (
    s_aclk          => clk,
    s_aresetn       => out_fifo_rst_n,
    s_axis_tvalid   => packet_tvalid,
    s_axis_tready   => packet_tready,
    s_axis_tdata    => packet_tdata,
    s_axis_tkeep    => packet_tkeep_x,
    s_axis_tlast    => packet_tlast,
    s_axis_tuser    => packet_tuser,
    m_axis_tvalid   => m_axis_rq_tvalid_int,
    m_axis_tready   => m_axis_rq_tready,
    m_axis_tdata    => m_axis_rq_tdata,
    m_axis_tkeep    => out_tkeep,
    m_axis_tlast    => m_axis_rq_tlast,
    m_axis_tuser    => rq_tuser,
    axis_data_count => pkt_fifo_count,
    axis_prog_full  => out_fifo_afl
  );

m_axis_rq_tuser(10 downto 0) <= rq_tuser(10 downto 0);
m_axis_rq_tuser(11)          <= m_axis_rq_tvalid_int and disc;
m_axis_rq_tuser(59 downto 12)<= (others => '0');

m_axis_rq_tkeep  <= out_tkeep(28) & out_tkeep(24) & out_tkeep(20) & out_tkeep(16) & out_tkeep(12) & out_tkeep(8) & out_tkeep(4) & out_tkeep(0);
m_axis_rq_tvalid <= m_axis_rq_tvalid_int and not disable_output;

process(clk)
begin
if rising_edge(clk) then
    if (rst_n = '0') or (abort_busy_int = '0') then
        disable_output <= '0';
    elsif (abort_busy_int = '1') and (m_axis_rq_tvalid_int= '0') then
        disable_output <= '1';
    end if;
end if;
end process;

abort_busy <= abort_busy_int;

 
--------------------------------------------------------------------------------
-- Abort State Machine
--------------------------------------------------------------------------------

disc                 <= '0';

process(clk)
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            abort_state <= RESET_STATE;
            out_fifo_abort_rst   <= '0';
            abort_busy_int       <= '0';
            --disc                 <= '0';
            abort_ff             <= '0'; 
        else
        case abort_state is 
            when RESET_STATE =>
                out_fifo_abort_rst   <= '0';
                abort_busy_int       <= '0';
                --disc                 <= '0';
                abort_ff             <= '0'; 
                abort_state <= NORMAL_STATE;
            when NORMAL_STATE =>
                if abort = '1' then
                   abort_state <= START_ABORT_STATE; 
                   abort_busy_int       <= '1';
                   --disc                 <= '1'; 
                   abort_ff             <= '1'; 
                else
                   abort_state <= NORMAL_STATE;
                end if;
            when START_ABORT_STATE =>
               if (m_axis_rq_tvalid_int = '0') then
                 abort_state <= WAIT1_STATE;
                 out_fifo_abort_rst <= '1';
               else
                 abort_state <= START_ABORT_STATE;
               end if;
            when WAIT1_STATE =>
               abort_state <= WAIT2_STATE; 
            when WAIT2_STATE =>
               abort_state <= WAIT3_STATE; 
            when WAIT3_STATE =>
               abort_state <= WAIT4_STATE;
            when WAIT4_STATE =>
               abort_state <= WAIT5_STATE; 
            when WAIT5_STATE =>
               abort_state <= WAIT6_STATE;
            when WAIT6_STATE =>
               abort_state <= WAIT7_STATE;  
            when WAIT7_STATE =>
               abort_state <= WAIT8_STATE;
            when WAIT8_STATE =>
               abort_state <= RESET_STATE;
            when others =>
               abort_state <= RESET_STATE;
        end case;
      end if;    
    end if;
end process;
end Behavioral;
