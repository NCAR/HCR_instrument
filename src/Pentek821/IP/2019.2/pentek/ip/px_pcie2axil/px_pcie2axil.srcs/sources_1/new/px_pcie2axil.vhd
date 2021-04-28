----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2015 11:46:59 AM
-- Design Name: 
-- Module Name: px_pcie2axil - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.0 - File Created
-- Revision 1.1 - Fixed missing signal output rqst_len for rx_engine. 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_pcie2axil is
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
   user_clk                       : in  std_logic;
   user_reset                     : in  std_logic;
   user_lnk_up                    : in  std_logic; 
   aresetn                        : out std_logic; 
   -----------------------------------------------------------------------------
   -- PIO TX Engine
   -----------------------------------------------------------------------------
   -- AXI-S Completer Competion Interface
   m_axis_cc_tdata                : out std_logic_vector(255 downto 0);
   m_axis_cc_tkeep                : out std_logic_vector(7 downto 0);
   m_axis_cc_tlast                : out std_logic;
   m_axis_cc_tvalid               : out std_logic;
   m_axis_cc_tuser                : out std_logic_vector(32 downto 0);
   m_axis_cc_tready               : in  std_logic_vector(3 downto 0);
   -----------------------------------------------------------------------------
   -- PIO RX Engine
   -----------------------------------------------------------------------------
   -- Completer Request Interface
   s_axis_cq_tdata                : in  std_logic_vector(255 downto 0);
   s_axis_cq_tlast                : in  std_logic;
   s_axis_cq_tvalid               : in  std_logic;
   s_axis_cq_tuser                : in  std_logic_vector(84 downto 0);
   s_axis_cq_tkeep                : in  std_logic_vector(7 downto 0);
   --s_axis_cq_tready               : out std_logic_vector(21 downto 0);
   s_axis_cq_tready               : out std_logic;
   --------------------------------------------------------------------------------
   -- AXI LITE Master Interface  
   -- DWORD Addressing
   ------------------------------------------------------------------------------
   m_axi_awaddr                   : out std_logic_vector(num_addr_bits-1 downto 0);
   m_axi_awprot                   : out std_logic_vector(2 downto 0); -- not used
   m_axi_awvalid                  : out std_logic;
   m_axi_awready                  : in  std_logic;
   m_axi_wdata                    : out std_logic_vector(31 downto 0);
   m_axi_wstrb                    : out std_logic_vector(3 downto 0); -- not used
   m_axi_wvalid                   : out std_logic;
   m_axi_wready                   : in  std_logic;
   m_axi_bresp                    : in  std_logic_vector(1 downto 0);
   m_axi_bvalid                   : in  std_logic;
   m_axi_bready                   : out std_logic;
   m_axi_araddr                   : out std_logic_vector(num_addr_bits-1 downto 0);
   m_axi_arprot                   : out std_logic_vector(2 downto 0); -- not used
   m_axi_arvalid                  : out std_logic;
   m_axi_arready                  : in  std_logic;
   m_axi_rdata                    : in  std_logic_vector(31 downto 0);
   m_axi_rvalid                   : in  std_logic;
   m_axi_rready                   : out std_logic;
   m_axi_rresp                    : in  std_logic_vector(1 downto 0);
   ----------------------------------------------------------------------------
   cc_shutdown_rqst               : in  std_logic;
   cc_shutdown_ok                 : out std_logic
);
end px_pcie2axil;

architecture Behavioral of px_pcie2axil is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of user_clk: SIGNAL is "xilinx.com:signal:clock:1.0 user_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of user_clk: SIGNAL is "ASSOCIATED_BUSIF m_axis_cc:s_axis_cq:m_axi, ASSOCIATED_RESET user_reset:aresetn";

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------

component g3_pio_rx_engine
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
  req_tc                         : out std_logic_vector(2 downto 0);    -- Memory Read TC
  req_attr                       : out std_logic_vector(2 downto 0);    -- Memory Read Attribute
  req_len                        : out std_logic_vector(10 downto 0);   -- memory read length
  req_rid                        : out std_logic_vector(15 downto 0);   -- Memory Read Requestor ID { 8'b0 (Bus no),
  req_bar_hit                    : out std_logic_vector(2 downto 0);                                     
            
  req_tag                        : out std_logic_vector(7 downto 0);    -- Memory Read Tag
  req_be                         : out std_logic_vector(3 downto 0);    -- Memory Read Byte Enables
  req_addr                       : out std_logic_vector(num_addr_bits-1 downto 0);   -- Memory Read Address
  req_at                         : out std_logic_vector(1 downto 0);    -- Address Translation
  -- outputs to the tx block in case of an ur                       
  -- required to form the completions                               
  req_des_qword0                 : out std_logic_vector(63 downto 0);   -- DWord0 and Dword1 of descriptor of the request
  req_des_qword1                 : out std_logic_vector(63 downto 0);   -- DWord2 and Dword3 of descriptor of the request
  req_des_tph_present            : out std_logic;                       -- TPH Present in the request
  req_des_tph_type               : out std_logic_vector(1 downto 0);    -- If TPH Present then TPH type
  req_des_tph_st_tag             : out std_logic_vector(7 downto 0);    -- TPH Steering tag of the request
  --output to indicate that the request was a mem lock read req     
  req_mem_lock                   : out std_logic;                   
  req_mem                        : out std_logic;                   
  --------------------------------------------------------------------------------
  -- AXI LITE Master Interface  
  -- DWORD Addressing
  ------------------------------------------------------------------------------
  m_axi_awaddr                   : out std_logic_vector(num_addr_bits-1 downto 0);
  m_axi_awprot                   : out std_logic_vector(2 downto 0); -- not used
  m_axi_awvalid                  : out std_logic;
  m_axi_awready                  : in  std_logic;
  m_axi_wdata                    : out std_logic_vector(31 downto 0);
  m_axi_wstrb                    : out std_logic_vector(3 downto 0); -- not used
  m_axi_wvalid                   : out std_logic;
  m_axi_wready                   : in  std_logic;
  m_axi_bresp                    : in  std_logic_vector(1 downto 0);
  m_axi_bvalid                   : in  std_logic;
  m_axi_bready                   : out std_logic

);
end component;

component g3_pio_tx_engine
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
  -- axi-s completer competion interface
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
  m_axi_araddr                   : out std_logic_vector(num_addr_bits-1 downto 0);
  m_axi_arprot                   : out std_logic_vector(2 downto 0); -- not used
  m_axi_arvalid                  : out std_logic;
  m_axi_arready                  : in  std_logic;
  m_axi_rdata                    : in  std_logic_vector(31 downto 0);
  m_axi_rvalid                   : in  std_logic;
  m_axi_rready                   : out std_logic;
  m_axi_rresp                    : in  std_logic_vector(1 downto 0)
);
end component;

-------------------------------------------------------------------------------  
-- Signals
-------------------------------------------------------------------------------

signal req_compl: std_logic := '0';
signal req_compl_wd: std_logic := '0';
signal req_compl_ur: std_logic := '0';
signal compl_done: std_logic := '0';
signal req_tc: std_logic_vector(2 downto 0) := (others => '0');
signal req_td: std_logic := '0';
signal req_ep: std_logic := '0';
signal req_attr: std_logic_vector(2 downto 0) := (others => '0');
signal req_len: std_logic_vector(10 downto 0) := (others => '0');
signal req_rid: std_logic_vector(15 downto 0) := (others => '0');
signal req_tag: std_logic_vector(7 downto 0) := (others => '0');
signal req_be: std_logic_vector(3 downto 0) := (others => '0');
signal req_addr: std_logic_vector(num_addr_bits-1 downto 0) := (others => '0');
signal req_at: std_logic_vector(1 downto 0) := (others => '0');
signal req_des_qword0: std_logic_vector(63 downto 0) := (others => '0');
signal req_des_qword1: std_logic_vector(63 downto 0) := (others => '0');
signal req_des_tph_present: std_logic := '0';
signal req_des_tph_type: std_logic_vector(1 downto 0) := (others => '0');
signal req_des_tph_st_tag: std_logic_vector(7 downto 0) := (others => '0');
signal req_mem_lock: std_logic := '0';
signal req_mem: std_logic := '0';
signal req_bar_hit: std_logic_vector(2 downto 0) := (others => '0');
--signal int_completion_busy: std_logic;
signal int_s_axis_cq_tready: std_logic := '0';
signal int_m_axis_cc_tready: std_logic := '0';
signal resetn: std_logic := '0';
signal p_aresetn: std_logic := '0'; 
signal p1_aresetn: std_logic := '0';
signal p2_aresetn: std_logic := '0';
signal p3_aresetn: std_logic := '0';
signal p4_aresetn: std_logic := '0';
-------------------------------------------------------------------------------

begin

process(user_clk)
begin
    if rising_edge(user_clk) then 
        resetn      <= not (user_reset or not user_lnk_up);  
        p_aresetn   <= resetn;   
        p1_aresetn  <= p_aresetn;
        p2_aresetn  <= p1_aresetn;
        p3_aresetn  <= p2_aresetn;
        p4_aresetn  <= p3_aresetn;
        aresetn     <= p4_aresetn and p3_aresetn and p2_aresetn and p1_aresetn;
    end if;    
end process;    

-------------------------------------------------------------------------------
-- Receive Controller
-------------------------------------------------------------------------------

--s_axis_cq_tready <= "1111111111111111111111" when (int_s_axis_cq_tready = '1') else "0000000000000000000000";
s_axis_cq_tready <= int_s_axis_cq_tready;
  
rx_engine_inst:  g3_pio_rx_engine
generic map (
   num_addr_bits         => num_addr_bits,        
   bar0_size_bits        => bar0_size_bits,       
   bar0_addr_translation => bar0_addr_translation,
   bar1_size_bits        => bar1_size_bits,       
   bar1_addr_translation => bar1_addr_translation,
   bar2_size_bits        => bar2_size_bits,       
   bar2_addr_translation => bar2_addr_translation,
   bar3_size_bits        => bar3_size_bits,       
   bar3_addr_translation => bar3_addr_translation,
   bar4_size_bits        => bar4_size_bits,       
   bar4_addr_translation => bar4_addr_translation,
   bar5_size_bits        => bar5_size_bits,       
   bar5_addr_translation => bar5_addr_translation  
   )
port  map(
  axi_aclk                       => user_clk,            
  axi_aresetn                    => resetn,    
  cc_shutdown_rqst               => cc_shutdown_rqst,
  cc_shutdown_ok                 => cc_shutdown_ok,          
  -- completer request interface -- completer request
  s_axis_cq_tdata                => s_axis_cq_tdata,     
  s_axis_cq_tlast                => s_axis_cq_tlast,     
  s_axis_cq_tvalid               => s_axis_cq_tvalid,   
  s_axis_cq_tuser                => s_axis_cq_tuser,     
  s_axis_cq_tkeep                => s_axis_cq_tkeep,     
  s_axis_cq_tready               => int_s_axis_cq_tready,         
  -- memory read data handshake with completion
  -- transmit unit. transmit unit reponds to
  -- req_compl assertion and responds with compl_done
  -- assertion when a completion w/ data is transmitted.
  req_compl                      => req_compl,   
  req_compl_wd                   => req_compl_wd,
  req_compl_ur                   => req_compl_ur,
  compl_done                     => compl_done,  
  req_tc                         => req_tc,        -- memory read tc
  req_attr                       => req_attr,      -- memory read attribute
  req_len                        => req_len,                   
  req_rid                        => req_rid,       -- memory read requestor id { 8'b0 (bus no),
  req_bar_hit                    => req_bar_hit,
  req_tag                        => req_tag,       -- memory read tag
  req_be                         => req_be,        -- memory read byte enables
  req_addr                       => req_addr,      -- memory read address
  req_at                         => req_at,        -- address translation
  -- outputs to the tx block in case of an ur
  -- required to form the completions
  req_des_qword0                 => req_des_qword0,         -- dword0 and dword1 of descriptor of the request
  req_des_qword1                 => req_des_qword1,         -- dword2 and dword3 of descriptor of the request
  req_des_tph_present            => req_des_tph_present,    -- tph present in the request
  req_des_tph_type               => req_des_tph_type,       -- if tph present then tph type
  req_des_tph_st_tag             => req_des_tph_st_tag,     -- tph steering tag of the request
  --output to indicate that the request was a mem lock read req
  req_mem_lock                   => req_mem_lock,
  req_mem                        => req_mem,     
  --------------------------------------------------------------------------------
  -- AXI LITE Master Interface  
  -- DWORD Addressing
  ------------------------------------------------------------------------------
  m_axi_awaddr                   => m_axi_awaddr, 
  m_axi_awprot                   => m_axi_awprot, 
  m_axi_awvalid                  => m_axi_awvalid,
  m_axi_awready                  => m_axi_awready,
  m_axi_wdata                    => m_axi_wdata,  
  m_axi_wstrb                    => m_axi_wstrb,  
  m_axi_wvalid                   => m_axi_wvalid, 
  m_axi_wready                   => m_axi_wready, 
  m_axi_bresp                    => m_axi_bresp,  
  m_axi_bvalid                   => m_axi_bvalid, 
  m_axi_bready                   => m_axi_bready 
);

-------------------------------------------------------------------------------
-- Transmit Controller
-------------------------------------------------------------------------------

req_td <= '0';
req_ep <= '0';

int_m_axis_cc_tready <= '1' when (m_axis_cc_tready /= "0000") else '0';

tx_engine_inst: g3_pio_tx_engine
generic map (
   num_addr_bits         => num_addr_bits,        
   bar0_size_bits        => bar0_size_bits,       
   bar0_addr_translation => bar0_addr_translation,
   bar1_size_bits        => bar1_size_bits,       
   bar1_addr_translation => bar1_addr_translation,
   bar2_size_bits        => bar2_size_bits,       
   bar2_addr_translation => bar2_addr_translation,
   bar3_size_bits        => bar3_size_bits,       
   bar3_addr_translation => bar3_addr_translation,
   bar4_size_bits        => bar4_size_bits,       
   bar4_addr_translation => bar4_addr_translation,
   bar5_size_bits        => bar5_size_bits,       
   bar5_addr_translation => bar5_addr_translation  
   )
port map (
  axi_aclk                       => user_clk,            
  axi_aresetn                    => resetn,   
  -- axi-s completer completion interface
  m_axis_cc_tdata                => m_axis_cc_tdata,
  m_axis_cc_tkeep                => m_axis_cc_tkeep, 
  m_axis_cc_tlast                => m_axis_cc_tlast,
  m_axis_cc_tvalid               => m_axis_cc_tvalid,
  m_axis_cc_tuser                => m_axis_cc_tuser, 
  m_axis_cc_tready               => int_m_axis_cc_tready,
  -- PIO RX Engine Interface
  req_compl                      => req_compl,   
  req_compl_wd                   => req_compl_wd,
  req_compl_ur                   => req_compl_ur, 
  compl_done                     => compl_done,                  

  req_tc                         => req_tc,        -- Memory Read TC
  req_td                         => req_td,
  req_ep                         => req_ep,
  req_attr                       => req_attr,      -- Memory Read Attribute
  req_rid                        => req_rid,       -- Memory Read Requestor ID { 8'b0 (Bus no),
  req_bar_hit                    => req_bar_hit,
  req_tag                        => req_tag,       -- Memory Read Tag
  req_be                         => req_be,        -- Memory Read Byte Enables
  req_addr                       => req_addr,      -- Memory Read Address
  req_at                         => req_at,        -- Address Translation

  completer_id                   => x"0000",
  -- Inputs to the TX Block in case of an UR
  -- Required to form the completions
  req_des_qword0                 => req_des_qword0,         -- DWord0 and Dword1 of descriptor of the request
  req_des_qword1                 => req_des_qword1,         -- DWord2 and Dword3 of descriptor of the request
  req_des_tph_present            => req_des_tph_present,    -- TPH Present in the request
  req_des_tph_type               => req_des_tph_type,       -- If TPH Present then TPH type
  req_des_tph_st_tag             => req_des_tph_st_tag,     -- TPH Steering tag of the request
  --Output to Indicate that the Request was a Mem lock Read Req
  req_mem_lock                   => req_mem_lock,
  req_mem                        => req_mem,     
  --------------------------------------------------------------------------------
  -- AXI LITE Master Interface  
  -- DWORD Addressing
  ------------------------------------------------------------------------------
  m_axi_araddr                   => m_axi_araddr, 
  m_axi_arprot                   => m_axi_arprot, 
  m_axi_arvalid                  => m_axi_arvalid,
  m_axi_arready                  => m_axi_arready,
  m_axi_rdata                    => m_axi_rdata,  
  m_axi_rvalid                   => m_axi_rvalid, 
  m_axi_rready                   => m_axi_rready, 
  m_axi_rresp                    => m_axi_rresp
);

--process(user_clk)
--begin
--   if rising_edge(user_clk) then
--      if (resetn = '0' ) then
--         int_completion_busy  <= '0';
--      elsif ((req_compl = '1') or (req_compl_wd = '1') or (req_compl_ur = '1')) and (int_completion_busy = '0') then
--         int_completion_busy  <= '1';
--      elsif (compl_done= '1') then
--         int_completion_busy  <= '0';
--     end if;
--  end if;
--end process;

--cc_shutdown_ok <= not int_completion_busy;

end Behavioral;