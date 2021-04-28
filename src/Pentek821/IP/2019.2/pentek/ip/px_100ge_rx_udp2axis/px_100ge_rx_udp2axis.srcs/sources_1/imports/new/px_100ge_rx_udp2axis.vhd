----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 08/30/2019 10:23:27 AM
-- Design Name: 
-- Module Name: px_100ge_rx_udp2axis - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Strips UDP Ethernet headers from AXIS data stream and sets destination based on port #
-- Requires payloads that are multiples of 32-bit words and UDP type packets. Other packets will
-- be discarded.
-- The Xilinx 100Ge IP core AXIS output rounds up the number of bytes to multiples of 64 bytes. 
-- Padding appears to be added to the end of each packet.
-- This core recalculates the true number of TKEEPS to use at the end of a packet, discarding padding
-- as long as the packet payload is a multiple of 32-bit words. If this is not th case up to three 
-- residual padding words may be left on the output flagged as valid data by the calculated TKEEPs.
-- This limitation was to keep the case statement needed to create the output tkeeps to a manigable size.

-- Destination routing can be created based on comparison to up to 8 different port number values.
-- Port numbers that do not compare are routed to highest tdest value as a catch-all.

-- Note: No TREADY Back-pressure 

-- Register Map
-- 0x00 - Bits[7:0]  Port0 Value (Set to expected UDP Destination port to route to tdest = "000" 
--        Bits[15:8] Port1 Value (Set to expected UDP Destination port to route to tdest = "001" 
-- 0x01 - Bits[7:0]  Port2 Value (Set to expected UDP Destination port to route to tdest = "010" 
--        Bits[15:8] Port3 Value (Set to expected UDP Destination port to route to tdest = "011"
-- 0x02 - Bits[7:0]  Port4 Value (Set to expected UDP Destination port to route to tdest = "100" 
--        Bits[15:8] Port5 Value (Set to expected UDP Destination port to route to tdest = "101"
-- 0x03 - Bits[7:0]  Port6 Value (Set to expected UDP Destination port to route to tdest = "110" 
--        Bits[15:8] Port7 Value (Set to expected UDP Destination port to route to tdest = "111"
-- Incoming Port numbers that do not compare to any of the above values are routed to tdest = "111" as a catch-all. 

-- Dependencies: 
-- 
-- Revision:
-- Revision 1.00 - File Created
-- Additional Comments:
-- 

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_100ge_rx_udp2axis is
generic (
    tdest_width : integer := 3 -- 1,2 or 3 
);
port ( 
   ---------------------------------------------------------------------------------
   -- 100GE Core AXI-S RX bus
   ---------------------------------------------------------------------------------
   s_axis_aclk           : in  std_logic;
   s_axis_tvalid         : in std_logic;
   s_axis_tdata          : in std_logic_vector(511 downto 0); 
   s_axis_tuser          : in std_logic_vector(0 downto 0);
   s_axis_tkeep          : in std_logic_vector(63 downto 0);
   s_axis_tlast          : in std_logic; -- end of packet
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
   ----------------------------------------------------------------------------------
   -- AXI-Stream Master
   ----------------------------------------------------------------------------------
   m_axis_aresetn      : in std_logic;
   m_axis_tvalid       : out std_logic;
   m_axis_tdata        : out std_logic_vector(511 downto 0); 
   m_axis_tkeep        : out std_logic_vector(63 downto 0);
   m_axis_tuser        : out std_logic_vector(23 downto 0);
   -- [2:0]  = Channel
   -- [3]    = EOP
   -- [4]    = SOP
   -- [7:5]  = Reserved
   -- [23:8] = UDP Destination Port #  
   m_axis_tlast        : out std_logic; -- end of packet
   m_axis_tdest        : out std_logic_vector(tdest_width-1 downto 0)

);
end px_100ge_rx_udp2axis;

architecture Behavioral of px_100ge_rx_udp2axis is

-------------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------------

type sm_state_type is
(
HEADER_STATE,
PAYLOAD_STATE,
WAIT_TLAST_STATE
);

type axi_state_type is
(
    RESET_STATE,
    WR_ADDR_DATA_STATE,
    WR_DATA_STATE,
    WR_ADDR2_STATE,
    WR_ADDR_STATE,
    WR_DATA2_STATE,
    WR_ADDR_DEC_STATE,
    WR_B_RSP_STATE,
    RD_ADDR_STATE,
    WAIT_RD_BS_STATE,
    WAIT_RDDATA_RDY_STATE
);

-------------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------------

signal sm_state : sm_state_type := HEADER_STATE;
signal keep : std_logic_vector(63 downto 0):= (others => '0');
signal mux_tvalid: std_logic := '0';
signal mux_tlast: std_logic := '0';
signal mux_tkeep: std_logic_vector(63 downto 0) := (others => '0');
signal mux_tdata: std_logic_vector(511 downto 0) := (others => '0');
signal data_in : std_logic_vector(511 downto 0) := (others => '0');
signal cnt_dn: std_logic_vector(3 downto 0) := x"0";
signal axi_state        : axi_state_type := RESET_STATE;
signal rd_data : std_logic_vector(31 downto 0) := (others => '0');
signal w_data : std_logic_vector(31 downto 0) := (others => '0');
signal w_addr : std_logic_vector(1 downto 0) := (others => '0');
signal reg0 : std_logic_vector(31 downto 0) := (others => '0');
signal reg1 : std_logic_vector(31 downto 0) := (others => '0');
signal reg2 : std_logic_vector(31 downto 0) := (others => '0');
signal reg3 : std_logic_vector(31 downto 0) := (others => '0');
signal reg0_cdc : std_logic_vector(31 downto 0) := (others => '0');
signal reg1_cdc : std_logic_vector(31 downto 0) := (others => '0');
signal reg2_cdc : std_logic_vector(31 downto 0) := (others => '0');
signal reg3_cdc : std_logic_vector(31 downto 0) := (others => '0');
signal t1_s_axi_csr_aresetn: std_logic:= '0';
signal w_strb: std_logic:= '0';
signal fifo_tuser : std_logic_vector(3 downto 0) := (others => '0');
signal fifo_tkeep : std_logic_vector(63 downto 0) := (others => '0');
signal port0 : std_logic_vector(15 downto 0) := (others => '0');
signal port1 : std_logic_vector(15 downto 0) := (others => '0');
signal port2 : std_logic_vector(15 downto 0) := (others => '0');
signal port3 : std_logic_vector(15 downto 0) := (others => '0');
signal port4 : std_logic_vector(15 downto 0) := (others => '0');
signal port5 : std_logic_vector(15 downto 0) := (others => '0');
signal port6 : std_logic_vector(15 downto 0) := (others => '0');
signal port7 : std_logic_vector(15 downto 0) := (others => '0');
signal mux_tuser: std_logic_vector(23 downto 0) := (others => '0');
signal t1_tuser: std_logic_vector(23 downto 0) := (others => '0');
signal t1_data: std_logic_vector(175 downto 0) := (others => '0');
signal pyld_length: std_logic_vector(15 downto 0) := (others => '0');
signal x_length: std_logic_vector(15 downto 0) := (others => '0');
signal int_mod_length : INTEGER RANGE 0 TO 63;
signal int_mod_pyld_length : INTEGER RANGE 0 TO 63;
signal t_length: std_logic_vector(15 downto 0) := (others => '0');
signal t1_m_axis_aresetn: std_logic:= '0';
signal t2_m_axis_aresetn: std_logic:= '0';
signal t3_m_axis_aresetn: std_logic:= '0';
signal t4_m_axis_aresetn: std_logic:= '0';
signal t5_m_axis_aresetn: std_logic:= '0';
signal t6_m_axis_aresetn: std_logic:= '0';
signal t7_m_axis_aresetn: std_logic:= '0';
signal t8_m_axis_aresetn: std_logic:= '0';
signal header_udp_port: std_logic_vector(15 downto 0) := (others => '0');

---------------------------------------------------------------------------------
-- Attributes
---------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO: STRING;
ATTRIBUTE X_INTERFACE_PARAMETER: STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of m_axis_aresetn: SIGNAL is "xilinx.com:signal:reset:1.0 m_axis_aresetn RST";
ATTRIBUTE X_INTERFACE_PARAMETER of m_axis_aresetn: SIGNAL is "POLARITY ACTIVE_LOW";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis:s_axis, ASSOCIATED_RESET m_axis_aresetn";


begin

-------------------------------------------------------------------------------
-- AXI4-Lite Interface State Machine
-------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        if t1_s_axi_csr_aresetn = '0' then
           axi_state           <= RESET_STATE;
           s_axi_csr_awready   <= '0'; 
           s_axi_csr_wready    <= '0';  
           s_axi_csr_arready   <= '0'; 
           s_axi_csr_rvalid    <= '0';  
           s_axi_csr_bvalid    <= '0';
           reg0                <= x"00010000";
           reg1                <= x"00030002";
        else 
           case axi_state is 
            when RESET_STATE =>
                if (t1_s_axi_csr_aresetn = '0') then
                    axi_state           <= RESET_STATE;
                    s_axi_csr_awready   <= '0';
                    s_axi_csr_wready    <= '0';
                    s_axi_csr_arready   <= '0'; 
                    s_axi_csr_rvalid    <= '0';  
                    s_axi_csr_bvalid    <= '0';
                    reg0                <= x"00010000";
                    reg1                <= x"00030002";
                elsif (s_axi_csr_awvalid = '1') then  
                    if (s_axi_csr_wvalid = '1') then
                        axi_state <=  WR_ADDR_DATA_STATE;
                    else
                        axi_state <=  WR_ADDR_STATE;
                    end if; 
                elsif (s_axi_csr_wvalid = '1') then
                    axi_state <=  WR_DATA_STATE;
                elsif (s_axi_csr_arvalid = '1') then
                    axi_state <=  RD_ADDR_STATE;
                else
                    axi_state <= RESET_STATE;
                end if;    
             when WR_ADDR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                s_axi_csr_awready <= '1';       
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata;
                w_addr            <= s_axi_csr_awaddr(3 downto 2);
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata;
                axi_state         <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_csr_wready     <= '0';
                if (s_axi_csr_awvalid = '1') then      
                   axi_state         <= WR_ADDR_DEC_STATE;
                   w_addr            <= s_axi_csr_awaddr(3 downto 2);
                   s_axi_csr_awready <= '1';
                else
                   axi_state         <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   s_axi_csr_awready <= '1';
                   axi_state     <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                s_axi_csr_awready <= '0';
                if (s_axi_csr_wvalid = '1') then      
                   axi_state        <= WR_ADDR_DEC_STATE;
                   s_axi_csr_wready <= '1';
                   w_strb           <= s_axi_csr_wstrb(0);
                   w_data           <= s_axi_csr_wdata;
                else
                   axi_state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';   
                if w_strb = '1' then
                  case w_addr(1 downto 0) is 
                    when "00" =>
                        reg0      <= w_data;
                    when "01" =>
                        reg1      <= w_data;
                    when "10" =>
                        reg2      <= w_data;
                    when "11" =>
                        reg3      <= w_data;
                    when others =>
                        reg0      <= w_data;
                  end case; 
                end if;                   
                axi_state         <= WR_B_RSP_STATE;
                s_axi_csr_bresp   <= "00";
                s_axi_csr_bvalid  <= '1';     
            when  WR_B_RSP_STATE =>
                if s_axi_csr_bready = '1' then
                    s_axi_csr_bvalid <= '0';
                    axi_state <= RESET_STATE;
                else
                    axi_state <= WR_B_RSP_STATE;
                end if;    
            when  RD_ADDR_STATE =>
               s_axi_csr_arready <= '1';
               case s_axi_csr_araddr(3 downto 2) is
                  when "00" =>
                    rd_data     <= reg0; 
                  when "01" =>
                    rd_data     <= reg1;
                  when "10" =>
                    rd_data     <= reg2;
                  when "11" =>
                    rd_data     <= reg3;
                  when others =>
                    rd_data     <= reg0;
               end case;
               axi_state   <= WAIT_RD_BS_STATE;
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rdata   <= rd_data;
                s_axi_csr_rvalid  <= '1'; 
                s_axi_csr_rresp   <= "00";
                axi_state         <= WAIT_RDDATA_RDY_STATE;              
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_csr_rready = '1' then
                   s_axi_csr_rvalid <= '0';
                   axi_state        <= RESET_STATE;
                else
                   axi_state        <= WAIT_RDDATA_RDY_STATE;     
                end if;  
            when others =>
               axi_state <= RESET_STATE;
          end case;
       end if;
   end if;  
end process;

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


-- Port numbers to compare to to determine destination (tdest) value.   
port0 <= reg0_cdc(15 downto 0);
port1 <= reg0_cdc(31 downto 16);
port2 <= reg1_cdc(15 downto 0);
port3 <= reg1_cdc(31 downto 16);
port4 <= reg2_cdc(15 downto 0);
port5 <= reg2_cdc(31 downto 16);
port6 <= reg3_cdc(15 downto 0);
port7 <= reg3_cdc(31 downto 16);

t_length <= (s_axis_tdata(311 downto 304) & s_axis_tdata(319 downto 312));
x_length <= t_length - 8; -- subtract UDP 8 for header length
-- Determine number of end of packet TKEEPs required by taking Total Length mod 64
--int_mod_length <= conv_integer(x_length(4 downto 0)); -- modulo 64
--int_mod_pyld_length <= conv_integer(pyld_length(4 downto 0)); -- modulo 64
int_mod_length <= conv_integer(x_length(5 downto 0)); -- modulo 64
int_mod_pyld_length <= conv_integer(pyld_length(5 downto 0)); -- modulo 64

header_udp_port <= (s_axis_tdata(295 downto 288) & s_axis_tdata(303 downto 296));

t1_tuser(7 downto 5) <= "000";

-------------------------------------------------------------
-- Strip out headers and make axi bus
-------------------------------------------------------------

process(s_axis_aclk)
begin
 if rising_edge(s_axis_aclk) then
    t1_m_axis_aresetn <= m_axis_aresetn;
    t2_m_axis_aresetn <= t1_m_axis_aresetn;
    t3_m_axis_aresetn <= t2_m_axis_aresetn;
    t4_m_axis_aresetn <= t3_m_axis_aresetn;
    t5_m_axis_aresetn <= t4_m_axis_aresetn;
    t6_m_axis_aresetn <= t5_m_axis_aresetn;
    t7_m_axis_aresetn <= t6_m_axis_aresetn;
    t8_m_axis_aresetn <= t7_m_axis_aresetn;
    if (t1_m_axis_aresetn = '0') or  (t2_m_axis_aresetn = '0') or  (t3_m_axis_aresetn = '0') or  (t4_m_axis_aresetn = '0') or  (t5_m_axis_aresetn = '0') or  (t6_m_axis_aresetn = '0') or  (t7_m_axis_aresetn = '0') or (t8_m_axis_aresetn = '0') then
        sm_state      <= HEADER_STATE;
        mux_tvalid    <= '0';
        mux_tkeep     <= (others => '1');
        --t1_tuser      <= (others => '1');
        --mux_tuser     <= (others => '1');
    else
        case sm_state is
            when HEADER_STATE =>
                if  (s_axis_tvalid = '1') then  -- Header in first 42 bytes
                    -- test if header is found. Check for Ethernet type (byte 13-16 = 0x0800), UDP protocol (byte 24 = 0x11)
                    if  ((s_axis_tdata(111 downto 96) = x"0008") and  (s_axis_tdata(191 downto 184) = x"11")) then -- Header found    
                        pyld_length <=  x_length; -- calculate UDP payload length            
                        if (s_axis_tlast = '0') then
                            t1_data    <= s_axis_tdata(511 downto 336);
                            sm_state   <= PAYLOAD_STATE; 
                            mux_tvalid <= '0';
                            mux_tlast  <= '0';
                            mux_tkeep  <= (others => '1');
                            t1_tuser(23 downto 8) <= header_udp_port;
                            if    (header_udp_port = port0) then
                                t1_tuser(4 downto 0) <= "10000"; -- SOP,not TLAST, CH0
                            elsif (header_udp_port = port1) then
                                t1_tuser(4 downto 0) <= "10001"; -- SOP,not TLAST, CH1
                            elsif (header_udp_port = port2) then
                                t1_tuser(4 downto 0) <= "10010"; -- SOP,not TLAST, CH2
                            elsif (header_udp_port = port3) then
                                t1_tuser(4 downto 0) <= "10011"; -- SOP,not TLAST, CH3
                            elsif (header_udp_port = port4) then
                                t1_tuser(4 downto 0) <= "10100"; -- SOP,not TLAST, CH4
                            elsif (header_udp_port = port5) then
                                t1_tuser(4 downto 0) <= "10101"; -- SOP,not TLAST, CH5
                            elsif (header_udp_port = port6) then
                                t1_tuser(4 downto 0) <= "10110"; -- SOP,not TLAST, CH6
                            else
                                t1_tuser(4 downto 0) <= "10111"; -- SOP,not TLAST, CH7
                            end if;
                        else
                            mux_tdata(175 downto 0)   <= s_axis_tdata(511 downto 336);
                            mux_tdata(511 downto 176) <= (others => '0');
                            mux_tvalid <= '1';
                            mux_tlast  <= '1';
                            case int_mod_length is -- by definition if tlast in first beat, there can't be more than 22 bytes
                                when 0 => 
                                    mux_tkeep <= x"FFFFFFFFFFFFFFFF";
                                when 1 to 4 =>
                                    mux_tkeep <= x"000000000000000F";
                                when 5 to 8 =>
                                    mux_tkeep <= x"00000000000000FF";
                                when 9 to 12 =>
                                    mux_tkeep <= x"0000000000000FFF";
                                when 13 to 16 =>
                                    mux_tkeep <= x"000000000000FFFF";
                                when 17 to 20 =>
                                    mux_tkeep <= x"00000000000FFFFF";
                                when 21 to 24 =>
                                    mux_tkeep <= x"0000000000FFFFFF";
                                when others => 
                                    mux_tkeep <= x"FFFFFFFFFFFFFFFF";
                            end case;    
                            mux_tuser(23 downto 8) <= header_udp_port;
                            if    (header_udp_port = port0) then
                                mux_tuser(4 downto 0) <= "11000"; -- SOP,TLAST, CH0
                            elsif (header_udp_port = port1) then
                                mux_tuser(4 downto 0) <= "11001"; -- SOP,LAST,  CH1
                            elsif (header_udp_port = port2) then
                                mux_tuser(4 downto 0) <= "11010"; -- SOP,TLAST, CH2
                            elsif (header_udp_port = port3) then
                                mux_tuser(4 downto 0) <= "11011"; -- SOP,TLAST, CH3
                            elsif (header_udp_port = port4) then
                                mux_tuser(4 downto 0) <= "11100"; -- SOP,TLAST, CH4
                            elsif (header_udp_port = port5) then
                                mux_tuser(4 downto 0) <= "11101"; -- SOP,TLAST, CH5
                            elsif (header_udp_port = port6) then
                                mux_tuser(4 downto 0) <= "11110"; -- SOP,TLAST, CH6
                            else
                                mux_tuser(4 downto 0) <= "11111"; -- SOP,TLAST, CH7
                            end if;
                        end if;
                    else -- not a header! Discard Packet.
                       sm_state <= WAIT_TLAST_STATE; -- wait to find a tlast to synchronize to SOP
                       mux_tvalid <= '0';
                       mux_tlast  <= '0';
                       mux_tkeep  <= (others => '1');
                    end if;
                else
                    mux_tvalid <= '0';
                    mux_tlast  <= '0';
                    mux_tkeep  <= (others => '1');
                end if;    
            when WAIT_TLAST_STATE => -- Wait for end of packet to discard.
                if  (s_axis_tvalid = '1') and (s_axis_tlast = '1') then
                    sm_state    <= HEADER_STATE;
                end if;
            when PAYLOAD_STATE =>
                if (s_axis_tvalid = '1') then
                    mux_tdata     <= s_axis_tdata(335 downto 0) & t1_data;
                    t1_data       <= s_axis_tdata(511 downto 336);
                    t1_tuser(4)   <= '0';      
                    mux_tvalid    <= '1';
                    if (s_axis_tlast = '1') then
                        mux_tlast   <= '1';
                        mux_tuser(4 downto 0) <= t1_tuser(4) & '1' & t1_tuser(2 downto 0); -- EOP
                        sm_state    <= HEADER_STATE;
                        case int_mod_pyld_length is 
                                when 0 => 
                                    mux_tkeep <= x"FFFFFFFFFFFFFFFF";
                                when 1 to 4 =>
                                    mux_tkeep <= x"000000000000000F";
                                when 5 to 8 =>
                                    mux_tkeep <= x"00000000000000FF";
                                when 9 to 12 =>
                                    mux_tkeep <= x"0000000000000FFF";
                                when 13 to 16 =>
                                    mux_tkeep <= x"000000000000FFFF";
                                when 17 to 20 =>
                                    mux_tkeep <= x"00000000000FFFFF";
                                when 21 to 24 =>
                                    mux_tkeep <= x"0000000000FFFFFF";
                                when 25 to 28 =>
                                    mux_tkeep <= x"000000000FFFFFFF";
                                when 29 to 32 =>
                                    mux_tkeep <= x"00000000FFFFFFFF";
                                when 33 to 36 =>
                                    mux_tkeep <= x"0000000FFFFFFFFF";
                                when 37 to 40 =>
                                    mux_tkeep <= x"000000FFFFFFFFFF";
                                when 41 to 44 =>
                                    mux_tkeep <= x"00000FFFFFFFFFFF";
                                when 45 to 48 =>
                                    mux_tkeep <= x"0000FFFFFFFFFFFF";
                                when 49 to 52 =>
                                    mux_tkeep <= x"000FFFFFFFFFFFFF";
                                when 53 to 56 =>
                                    mux_tkeep <= x"00FFFFFFFFFFFFFF";
                                when 57 to 60 =>
                                    mux_tkeep <= x"0FFFFFFFFFFFFFFF";
                                when 61 to 63 =>
                                    mux_tkeep <= x"FFFFFFFFFFFFFFFF";
                                when others => 
                                    mux_tkeep <= x"FFFFFFFFFFFFFFFF";
                            end case;    
                    else
                        sm_state <= PAYLOAD_STATE;
                        mux_tkeep <= (others => '1');
                        mux_tlast <= '0';
                        mux_tuser(4 downto 0) <= t1_tuser(4) & '0' & t1_tuser(2 downto 0);
                    end if;
                else
                    mux_tvalid <= '0';
                    mux_tlast  <= '0';
                    mux_tkeep  <= (others => '1');
                end if;
            when others =>
                sm_state <= HEADER_STATE;
        end case;
    end if;
 end if;
end process;



-------------------------------------------------------------------------------------------------
-- Output AXI-S
-------------------------------------------------------------------------------------------------
                                 
process(s_axis_aclk)
begin
 if rising_edge(s_axis_aclk) then
    m_axis_tvalid <= mux_tvalid;
    m_axis_tlast  <= mux_tlast;
    m_axis_tdata  <= mux_tdata;
    m_axis_tkeep  <= mux_tkeep;
    m_axis_tuser  <= mux_tuser; 
    m_axis_tdest  <= mux_tuser(tdest_width-1 downto 0);
 end if;
end process;
 
 



end Behavioral;
