----------------------------------------------------------------------------------
-- Company: Pentek
-- Engineer: 
-- 
-- Create Date: 09/19/2019 10:41:53 AM
-- Design Name: 
-- Module Name: px_100ge_arp_resp - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Responds to an ARP Request from 100GE MAC
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 

-- Register Map
-- 0x00 - OUR IP ADDRESS
-- 0x04 - OUR MAC ADDRESS[31:0]  
-- 0x08 - OUR MAC_ADDRESS[47:32]
-- 0x0C - REQUEST IP_ADDRESS[31:0]
-- 0x10 - EXECUTE REQUEST PULSE
-- 0x14 - REQUEST MAC ADDRESS RESPONSE[31:0]
-- 0x18 - REQUEST MAC ADDRESS RESPONSE[47:32]
-- 0x1C - INTERRUPT ENABLE
-- 0x20 - INTERRUPT STATUS
-- 0x24 - INTERRUPT FLAG   

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

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;


entity px_100ge_arp_resp is
port (
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   --------------------------------------------------------------------------------
   s_axi_csr_aclk        : in  std_logic;
   s_axi_csr_aresetn     : in  std_logic;
   s_axi_csr_awaddr      : in  std_logic_vector(6 downto 0);
   s_axi_csr_awprot      : in  std_logic_vector(2 downto 0); 
   s_axi_csr_awvalid     : in  std_logic;
   s_axi_csr_awready     : out std_logic;
   s_axi_csr_wdata       : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb       : in  std_logic_vector(3 downto 0); 
   s_axi_csr_wvalid      : in  std_logic;
   s_axi_csr_wready      : out std_logic;
   s_axi_csr_bresp       : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid      : out std_logic;
   s_axi_csr_bready      : in  std_logic;
   s_axi_csr_araddr      : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot      : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid     : in  std_logic;
   s_axi_csr_arready     : out std_logic;
   s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid      : out std_logic;
   s_axi_csr_rready      : in  std_logic;
   
   irq                   : out std_logic;
   ---------------------------------------------------------------------------------
   -- 100GE Core AXI-S RX bus
   ---------------------------------------------------------------------------------
   s_axis_aresetn        : in  std_logic;
   s_axis_aclk           : in  std_logic;
   s_axis_tvalid         : in  std_logic;
   s_axis_tdata          : in  std_logic_vector(511 downto 0); 
   s_axis_tuser          : in  std_logic_vector(0 downto 0);
   s_axis_tkeep          : in  std_logic_vector(63 downto 0);
   s_axis_tlast          : in  std_logic; -- end of packet
   ----------------------------------------------------------------------------------
   -- 100GE Core AXI-S RX bus (ARP Response)
   ----------------------------------------------------------------------------------
   m_axis_arp_tvalid     : out std_logic;
   m_axis_arp_tready     : in  std_logic;
   m_axis_arp_tdata      : out std_logic_vector(511 downto 0); 
   m_axis_arp_tuser      : out std_logic_vector(0 downto 0);
   m_axis_arp_tkeep      : out std_logic_vector(63 downto 0);
   m_axis_arp_tlast      : out std_logic; -- end of packet   
   ----------------------------------------------------------------------------------
   -- AXI-Stream Master  (pass-through from s_axis)
   ----------------------------------------------------------------------------------
   m_axis_tvalid         : out std_logic;
   m_axis_tdata          : out std_logic_vector(511 downto 0); 
   m_axis_tuser          : out std_logic_vector(0 downto 0);
   m_axis_tkeep          : out std_logic_vector(63 downto 0);
   m_axis_tlast          : out std_logic; -- end of packet
   ----------------------------------------------------------------------------------
   -- IP and MAC address outputs
   ----------------------------------------------------------------------------------
   ip_address            : out std_logic_vector(31 downto 0);
   mac_address           : out std_logic_vector(47 downto 0)
);
end px_100ge_arp_resp;

architecture Behavioral of px_100ge_arp_resp is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
COMPONENT px_100ge_arp_resp_csr
  PORT (
    s_axi_csr_aclk : IN STD_LOGIC;
    s_axi_csr_aresetn : IN STD_LOGIC;
    s_axi_csr_awaddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_awvalid : IN STD_LOGIC;
    s_axi_csr_awready : OUT STD_LOGIC;
    s_axi_csr_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_csr_wvalid : IN STD_LOGIC;
    s_axi_csr_wready : OUT STD_LOGIC;
    s_axi_csr_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_bvalid : OUT STD_LOGIC;
    s_axi_csr_bready : IN STD_LOGIC;
    s_axi_csr_araddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_arvalid : IN STD_LOGIC;
    s_axi_csr_arready : OUT STD_LOGIC;
    s_axi_csr_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_rvalid : OUT STD_LOGIC;
    s_axi_csr_rready : IN STD_LOGIC;
    reg0_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg1_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg2_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg3_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg4_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl3_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl4_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;
--------------------------------------------------------------------------------
-- ATTRIBUTES
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aresetn: SIGNAL is "xilinx.com:signal:reset:1.0 s_axi_csr_aresetn RST";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aresetn: SIGNAL is "POLARITY ACTIVE_LOW";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aresetn: SIGNAL is "xilinx.com:signal:reset:1.0 s_axis_aresetn RST";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aresetn: SIGNAL is "POLARITY ACTIVE_LOW";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";
			

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis:m_axis:m_axis_arp, ASSOCIATED_RESET s_axis_aresetn";

-------------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------------

type sm_state_type is
(
HEADER_STATE,
PAYLOAD_STATE,
WAIT_TLAST_STATE
);

type rsp_state_type is
(
RESET_STATE,
WAIT_TREADY_STATE
);

-------------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------------

signal reg0 : std_logic_vector(31 downto 0) := (others => '0');
signal reg1 : std_logic_vector(31 downto 0) := (others => '0');
signal reg2 : std_logic_vector(31 downto 0) := (others => '0');
signal reg3 : std_logic_vector(31 downto 0) := (others => '0');
signal reg4 : std_logic_vector(31 downto 0) := (others => '0');
signal reg0_cdc : std_logic_vector(31 downto 0) := (others => '0');
signal reg1_cdc : std_logic_vector(31 downto 0) := (others => '0');
signal reg2_cdc : std_logic_vector(31 downto 0) := (others => '0');
signal reg3_cdc : std_logic_vector(31 downto 0) := (others => '0');
signal t1_s_axi_csr_aresetn: std_logic:= '0';
signal sm_state : sm_state_type := HEADER_STATE;
signal rsp_state        : rsp_state_type := RESET_STATE;
signal t1_s_axis_aresetn: std_logic := '0';
signal t2_s_axis_aresetn: std_logic := '0';
signal t3_s_axis_aresetn: std_logic := '0';
signal t4_s_axis_aresetn: std_logic := '0';
signal t5_s_axis_aresetn: std_logic := '0';
signal t6_s_axis_aresetn: std_logic := '0';
signal t7_s_axis_aresetn: std_logic := '0';
signal t8_s_axis_aresetn: std_logic := '0';
signal respond: std_logic := '0';
signal our_ip_addr_rvrs: std_logic_vector(31 downto 0) := (others => '0');
signal our_mac_addr_rvrs : std_logic_vector(47 downto 0) := (others => '0');
signal src_ip_addr: std_logic_vector(31 downto 0) := (others => '0');
signal src_mac_addr: std_logic_vector(47 downto 0) := (others => '0');
signal got_resp: std_logic := '0';
signal rsp_src_mac_addr: std_logic_vector(47 downto 0) := (others => '0');
signal rqst_ip_addr_rvrs: std_logic_vector(31 downto 0) := (others => '0');
signal request: std_logic := '0';
signal stat0_in: std_logic_vector(31 downto 0) := (others => '0');
signal stat1_in: std_logic_vector(31 downto 0) := (others => '0');
signal intrpt_src_in: std_logic_vector(0 downto 0) := (others => '0');
signal irq_x: std_logic := '0';
signal rsp_src_mac_addr_rvrs: std_logic_vector(47 downto 0) := (others => '0');
signal axis_rst: std_logic := '0';
signal csr_rst: std_logic := '0';

begin

m_axis_arp_tuser <= "0";

-- ARP 
-------------------------------------------------
-- MAC Destination (FF:FF:FF:FF:FF:FF) | MAC Source |0x0806     (14 bytes)
-- 0x0001 0x800 -- IPV4
-- 0x0604 0x0001 
-- SOURCE MAC
-- SOURCE IP
-- DEST MAC
-- DEST IP

-- 

process(s_axis_aclk)
begin
 if rising_edge(s_axis_aclk) then
    t1_s_axis_aresetn <= s_axis_aresetn;
    t2_s_axis_aresetn <= t1_s_axis_aresetn;
    t3_s_axis_aresetn <= t2_s_axis_aresetn;
    t4_s_axis_aresetn <= t3_s_axis_aresetn;
    t5_s_axis_aresetn <= t4_s_axis_aresetn;
    t6_s_axis_aresetn <= t5_s_axis_aresetn;
    t7_s_axis_aresetn <= t6_s_axis_aresetn;
    t8_s_axis_aresetn <= t7_s_axis_aresetn;
    m_axis_tdata         <= s_axis_tdata;
    m_axis_tuser         <= s_axis_tuser;
    m_axis_tkeep         <= s_axis_tkeep; 
    m_axis_tlast         <= s_axis_tlast; 
    if (t1_s_axis_aresetn = '0') or  (t2_s_axis_aresetn = '0') or  (t3_s_axis_aresetn = '0') or  (t4_s_axis_aresetn = '0') or  (t5_s_axis_aresetn = '0') or  (t6_s_axis_aresetn = '0') or  (t7_s_axis_aresetn = '0') or (t8_s_axis_aresetn = '0') then
        sm_state      <= HEADER_STATE;
        m_axis_tvalid <= '0';
        respond       <= '0';
        got_resp      <= '0'; 
    else
        case sm_state is
            when HEADER_STATE =>
                if  (s_axis_tvalid = '1')  then  
                    -- Test if ARP header is found. Check for ARP Frame (byte 13-16 = 0x0806)  and IP Address that matches ours -- One beat long packet
                    if  (s_axis_tdata(167 downto 96) = x"000406000801000608") and  (s_axis_tdata(335 downto 304) = our_ip_addr_rvrs) and (s_axis_tlast  = '1') then -- ARP Request found
                       if (s_axis_tdata(175 downto 168) = x"01") then -- Request
                           m_axis_tvalid    <= '0'; 
                           respond          <= '1';
                           src_ip_addr      <= s_axis_tdata(255 downto 224);
                           src_mac_addr     <= s_axis_tdata(223 downto 176); 
                           got_resp         <= '0';
                       else -- Response
                           respond          <= '0';
                           m_axis_tvalid    <= '0'; 
                           rsp_src_mac_addr <= s_axis_tdata(223 downto 176); 
                           got_resp         <= '1';
                       end if; 
                    elsif (s_axis_tlast  = '0') then 
                       sm_state    <= WAIT_TLAST_STATE;
                       m_axis_tvalid <= '1'; 
                       respond    <= '0';
                       got_resp   <= '0';
                    else
                       m_axis_tvalid <= '1';
                       respond    <= '0';
                       got_resp   <= '0'; 
                    end if;
                else
                    m_axis_tvalid <= '0';
                    respond    <= '0';
                    got_resp   <= '0'; 
                end if;    
            when WAIT_TLAST_STATE => -- Wait for end of packet
                m_axis_tvalid <= s_axis_tvalid;
                if  (s_axis_tvalid = '1') and (s_axis_tlast = '1') then
                    sm_state    <= HEADER_STATE;
                end if;
            when others =>
                sm_state <= HEADER_STATE;
        end case;
    end if;
 end if;
end process;

--------------------------------------------------------------------------------
-- ARP Response/Request
--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
 if rising_edge(s_axis_aclk) then
    if (t1_s_axis_aresetn = '0') then
        rsp_state         <= RESET_STATE;
        m_axis_arp_tvalid <= '0';
    else
        case rsp_state is
            when RESET_STATE =>
                if respond = '1' then
                   m_axis_arp_tdata(335 downto 0) <= src_ip_addr       & src_mac_addr    & our_ip_addr_rvrs & our_mac_addr_rvrs & x"02000406000801000608" & our_mac_addr_rvrs & src_mac_addr;
                   m_axis_arp_tvalid <= '1';
                   if m_axis_arp_tready = '0' then
                     rsp_state <= WAIT_TREADY_STATE;
                   end if;
                elsif request = '1' then -- send Request
                   m_axis_arp_tdata(335 downto 0) <= rqst_ip_addr_rvrs & x"FFFFFFFFFFFF" & our_ip_addr_rvrs & our_mac_addr_rvrs & x"01000406000801000608" & our_mac_addr_rvrs & x"FFFFFFFFFFFF";
                   m_axis_arp_tvalid <= '1';
                   if m_axis_arp_tready = '0' then
                     rsp_state <= WAIT_TREADY_STATE;
                   end if; 
                else
                   m_axis_arp_tvalid <= '0';
                end if;
            when WAIT_TREADY_STATE =>
                if m_axis_arp_tready = '1' then
                    m_axis_arp_tvalid <= '0';
                    rsp_state <= RESET_STATE;
                end if;
            when others =>
                rsp_state <= RESET_STATE;
        end case;
    end if;
 end if;
end process;

m_axis_arp_tdata(511 downto 336)  <= (others => '0');
m_axis_arp_tkeep(63 downto 0)     <= (others => '1');
m_axis_arp_tlast <= '1';

-------------------------------------------------------------------------------
-- AXI4-Lite Interface State Machine
-------------------------------------------------------------------------------

csr_inst : px_100ge_arp_resp_csr
  PORT MAP (
    s_axi_csr_aclk => s_axi_csr_aclk,
    s_axi_csr_aresetn => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr => s_axi_csr_awaddr,
    s_axi_csr_awprot => s_axi_csr_awprot,
    s_axi_csr_awvalid => s_axi_csr_awvalid,
    s_axi_csr_awready => s_axi_csr_awready,
    s_axi_csr_wdata => s_axi_csr_wdata,
    s_axi_csr_wstrb => s_axi_csr_wstrb,
    s_axi_csr_wvalid => s_axi_csr_wvalid,
    s_axi_csr_wready => s_axi_csr_wready,
    s_axi_csr_bresp => s_axi_csr_bresp,
    s_axi_csr_bvalid => s_axi_csr_bvalid,
    s_axi_csr_bready => s_axi_csr_bready,
    s_axi_csr_araddr => s_axi_csr_araddr,
    s_axi_csr_arprot => s_axi_csr_arprot,
    s_axi_csr_arvalid => s_axi_csr_arvalid,
    s_axi_csr_arready => s_axi_csr_arready,
    s_axi_csr_rdata => s_axi_csr_rdata,
    s_axi_csr_rresp => s_axi_csr_rresp,
    s_axi_csr_rvalid => s_axi_csr_rvalid,
    s_axi_csr_rready => s_axi_csr_rready,
    reg0_init_val => x"00000000",
    reg1_init_val => x"00000000",
    reg2_init_val => x"00000000",
    reg3_init_val => x"00000000",
    reg4_init_val => x"00000000",
    ctl0_out => reg0,
    ctl1_out => reg1,
    ctl2_out => reg2,
    ctl3_out => reg3,
    ctl4_out => reg4,
    stat0_in => stat0_in,
    stat1_in => stat1_in,
    intrpt_src_in => intrpt_src_in,
    irq => irq_x
  );
  
stat0_in <= rsp_src_mac_addr_rvrs(31 downto 0);
stat1_in <= x"0000" & rsp_src_mac_addr_rvrs(47 downto 32);  

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        irq <= irq_x;
   end if;  
end process;

axis_rst <= not t2_s_axis_aresetn;
csr_rst  <= not t1_s_axi_csr_aresetn;

xpm_cdc_reg0_inst : xpm_cdc_array_single
   generic map (
      DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 0,   -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      SIM_ASSERT_CHK => 0, -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      SRC_INPUT_REG => 1,  -- DECIMAL; 0=do not register input, 1=register input
      WIDTH => 32           -- DECIMAL; range: 1-1024
   )
   port map (
      dest_out => reg0_cdc, 
      dest_clk => s_axis_aclk, 
      src_clk => s_axi_csr_aclk,   
      src_in => reg0    
   );

xpm_cdc_reg1_inst : xpm_cdc_array_single
   generic map (
      DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 0,   -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      SIM_ASSERT_CHK => 0, -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      SRC_INPUT_REG => 1,  -- DECIMAL; 0=do not register input, 1=register input
      WIDTH => 32           -- DECIMAL; range: 1-1024
   )
   port map (
      dest_out => reg1_cdc, 
      dest_clk => s_axis_aclk, 
      src_clk => s_axi_csr_aclk,   
      src_in => reg1    
   );
   
xpm_cdc_reg2_inst : xpm_cdc_array_single
   generic map (
      DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 0,   -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      SIM_ASSERT_CHK => 0, -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      SRC_INPUT_REG => 1,  -- DECIMAL; 0=do not register input, 1=register input
      WIDTH => 32           -- DECIMAL; range: 1-1024
   )
   port map (
      dest_out => reg2_cdc, 
      dest_clk => s_axis_aclk, 
      src_clk => s_axi_csr_aclk,   
      src_in => reg2    
   );
   
xpm_cdc_reg3_inst : xpm_cdc_array_single
   generic map (
      DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 0,   -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      SIM_ASSERT_CHK => 0, -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      SRC_INPUT_REG => 1,  -- DECIMAL; 0=do not register input, 1=register input
      WIDTH => 32           -- DECIMAL; range: 1-1024
   )
   port map (
      dest_out => reg3_cdc, 
      dest_clk => s_axis_aclk, 
      src_clk => s_axi_csr_aclk,   
      src_in => reg3    
   );
   
exe_cdc_pulse_inst : xpm_cdc_pulse
   generic map (
      DEST_SYNC_FF => 2, 
      INIT_SYNC_FF => 0, 
      REG_OUTPUT => 1,   
      RST_USED => 1,      
      SIM_ASSERT_CHK => 0  
   )
   port map (
      dest_pulse => request, 
      dest_clk => s_axis_aclk,  
      dest_rst => axis_rst,     
      src_clk => s_axi_csr_aclk,  
      src_pulse => reg4(0),  
      src_rst => csr_rst   
   );
   
irq_cdc_pulse_inst : xpm_cdc_pulse
   generic map (
      DEST_SYNC_FF => 2,  
      INIT_SYNC_FF => 0, 
      REG_OUTPUT => 1,   
      RST_USED => 1,   
      SIM_ASSERT_CHK => 0  
   )
   port map (
      dest_pulse => intrpt_src_in(0), 
      dest_clk => s_axi_csr_aclk,   
      dest_rst => csr_rst,     
      src_clk => s_axis_aclk,     
      src_pulse => got_resp,  
      src_rst => axis_rst       
   );
   
our_ip_addr_rvrs  <= reg0_cdc(7 downto 0) & reg0_cdc(15 downto 8) & reg0_cdc(23 downto 16) & reg0_cdc(31 downto 24);
our_mac_addr_rvrs <= reg1_cdc(7 downto 0) & reg1_cdc(15 downto 8) & reg1_cdc(23 downto 16) & reg1_cdc(31 downto 24) & reg2_cdc(7 downto 0) & reg2_cdc(15 downto 8);
rqst_ip_addr_rvrs <= reg3_cdc(7 downto 0) & reg3_cdc(15 downto 8) & reg3_cdc(23 downto 16) & reg3_cdc(31 downto 24);
rsp_src_mac_addr_rvrs <= rsp_src_mac_addr(7 downto 0) & rsp_src_mac_addr(15 downto 8) & rsp_src_mac_addr(23 downto 16) & rsp_src_mac_addr(31 downto 24) & rsp_src_mac_addr(39 downto 32) & rsp_src_mac_addr(47 downto 40);

process(s_axis_aclk)
begin
 if rising_edge(s_axis_aclk) then
    ip_address  <= reg0_cdc;
    mac_address <= reg2_cdc(15 downto 0) & reg1_cdc;
 end if;
 end process;


end Behavioral;
