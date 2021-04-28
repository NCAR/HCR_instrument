

----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 11/10/2015 10:43:52 AM
-- Design Name: 
-- Module Name: px_axis_traffic_meter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Measures Bytes per second of AXI-S traffic.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- AXI-S bus is pass through with no delay.
-- Does not in this version support counting TKEEP bits to accurately detect
-- only valid bytes. This version assumes all bytes are valid when tvalid is
-- asserted. This will have a minor impact on absolute accuracy.
-- Value is updated once every second as determined by the clock frequency
-- value in the Control Register.
 
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

--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_traffic_meter is
generic (
    init_clk_freq    : integer := 250000000; -- integer in Hz
    div_factor       : integer := 1; -- 1,2, or 4. Divide result by this factor to stay in 32-bit word. Use when rate can be >= 4GBps. Then multiply by the factor to get the full result. 
    num_bytes        : integer := 4; -- Number of bytes in tdata
    has_tkeep        : boolean := true;
    has_tready       : boolean := true;
    has_tuser        : boolean := true;
    has_tlast        : boolean := true;
    tuser_size       : integer := 32 -- number of tuser bits
);
port ( 
    ----------------------------------------------------------------------------
    -- AXI4-Lite Control/Status Interface
    ----------------------------------------------------------------------------
    s_axi_csr_aclk      : in  std_logic;
    s_axi_csr_aresetn   : in  std_logic;
    s_axi_csr_awaddr    : in  std_logic_vector(6 downto 0);
    s_axi_csr_awprot    : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid   : in  std_logic;
    s_axi_csr_awready   : out std_logic;
    s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid    : in  std_logic;
    s_axi_csr_wready    : out std_logic;
    s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid    : out std_logic;
    s_axi_csr_bready    : in  std_logic;
    s_axi_csr_araddr    : in  std_logic_vector(6 downto 0);
    s_axi_csr_arprot    : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid   : in  std_logic;
    s_axi_csr_arready   : out std_logic;
    s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid    : out std_logic;
    s_axi_csr_rready    : in  std_logic;
    ----------------------------------------------------------------------------
    -- AXI-S Slave Input
    ----------------------------------------------------------------------------
    axis_aclk          : in  std_logic;
    axis_aresetn       : in  std_logic;

    s_axis_tdata       : in  std_logic_vector((num_bytes*8)-1 downto 0);
    s_axis_tuser       : in  std_logic_vector(tuser_size-1 downto 0);
    s_axis_tvalid      : in  std_logic;
    s_axis_tready      : out std_logic; 
    s_axis_tkeep       : in  std_logic_vector(num_bytes-1 downto 0);
    s_axis_tlast       : in  std_logic;
    ----------------------------------------------------------------------------
    -- AXI-S Master Output
    ----------------------------------------------------------------------------
    m_axis_tdata       : out std_logic_vector((num_bytes*8)-1 downto 0);
    m_axis_tuser       : out std_logic_vector(tuser_size-1 downto 0);
    m_axis_tvalid      : out std_logic;
    m_axis_tready      : in  std_logic; 
    m_axis_tkeep       : out std_logic_vector(num_bytes-1 downto 0);
    m_axis_tlast       : out std_logic
);
end px_axis_traffic_meter;

architecture Behavioral of px_axis_traffic_meter is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis:m_axis, ASSOCIATED_RESET axis_aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- Control/Status Registers
COMPONENT px_axis_traffic_meter_csr
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
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal s_axis_areset    : std_logic;
signal ctl0_out         : std_logic_vector(31 downto 0) := (others => '0');
signal ctl0_outx        : std_logic_vector(31 downto 0) := (others => '0');
signal stat0_in         : std_logic_vector(31 downto 0) := (others => '0');
signal stat0_inx        : std_logic_vector(31 downto 0) := (others => '0');
signal acc              : std_logic_vector(33 downto 0) := (others => '0');
signal acc_cntr         : std_logic_vector(31 downto 0) := (others => '0');
signal t1_tready        : std_logic := '0';
signal t1_tvalid        : std_logic := '0';
signal t1_rst_n         : std_logic := '0';
signal stat1_in         : std_logic_vector(31 downto 0) := (others => '0');
signal src_send0        : std_logic:= '0';
signal src_rcv0         : std_logic:= '0';
signal dest_req0        : std_logic:= '0';
signal cntrl0_vctr      : std_logic_vector(31 downto 0)  := (others => '0');
signal cntrlx0_vctr     : std_logic_vector(31 downto 0)  := (others => '0');
signal src_senda        : std_logic:= '0';
signal src_rcva         : std_logic:= '0';
signal dest_reqa        : std_logic:= '0';
signal t1_s_axi_csr_aresetn: std_logic:= '0';
--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
 
constant reg0_init_val : std_logic_vector(31 downto 0) := conv_std_logic_vector(init_clk_freq, 32);
constant num_bytes_vector: std_logic_vector(31 downto 0) := conv_std_logic_vector(num_bytes, 32);

--------------------------------------------------------------------------------
 
begin

stat1_in <= x"0000" & x"000" & '0' & conv_std_logic_vector(div_factor, 3);

--------------------------------------------------------------------------------
-- Pass through Slave to Master
--------------------------------------------------------------------------------

    m_axis_tdata     <=  s_axis_tdata;   
    m_axis_tuser     <=  s_axis_tuser;  
    m_axis_tvalid    <=  s_axis_tvalid;  
    s_axis_tready    <=  m_axis_tready;  
    m_axis_tkeep     <=  s_axis_tkeep;   
    m_axis_tlast     <=  s_axis_tlast;   


--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------

-- 0x00 - Frequency Value Register
-- 0x04 - Bytes per Second Reading

-- Clock Domain crossing for the Control/Status Register accesses.


-- So that status, control and interrupt signals are synchronous with the data
-- stream clock, the entire control register block runs on the data stream clock.
csr : px_axis_traffic_meter_csr
  PORT MAP (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr    => s_axi_csr_awaddr,
    s_axi_csr_awprot    => s_axi_csr_awprot,
    s_axi_csr_awvalid   => s_axi_csr_awvalid,
    s_axi_csr_awready   => s_axi_csr_awready,
    s_axi_csr_wdata     => s_axi_csr_wdata,
    s_axi_csr_wstrb     => s_axi_csr_wstrb,
    s_axi_csr_wvalid    => s_axi_csr_wvalid,
    s_axi_csr_wready    => s_axi_csr_wready,
    s_axi_csr_bresp     => s_axi_csr_bresp,
    s_axi_csr_bvalid    => s_axi_csr_bvalid,
    s_axi_csr_bready    => s_axi_csr_bready,
    s_axi_csr_araddr    => s_axi_csr_araddr,
    s_axi_csr_arprot    => s_axi_csr_arprot,
    s_axi_csr_arvalid   => s_axi_csr_arvalid,
    s_axi_csr_arready   => s_axi_csr_arready,
    s_axi_csr_rdata     => s_axi_csr_rdata,
    s_axi_csr_rresp     => s_axi_csr_rresp,
    s_axi_csr_rvalid    => s_axi_csr_rvalid,
    s_axi_csr_rready    => s_axi_csr_rready,
    reg0_init_val       => reg0_init_val,
    ctl0_out            => ctl0_out,
    stat0_in            => stat0_in,
    stat1_in            => stat1_in    
);


cntl02_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 32  -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => ctl0_out ,
  src_send => src_send0,
  src_rcv  => src_rcv0,
  dest_clk => axis_aclk,
  dest_req => dest_req0,
  dest_ack => dest_req0, 
  dest_out => ctl0_outx
);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
     if (src_rcv0 = '1') then
       src_send0 <= '0';
     elsif (src_rcv0 = '0') and (src_send0 = '0') then
       src_send0 <= '1';
     end if;  
   end if;
end process;   

--------------------------------------------------------------------------------
-- Count for 1 second.
--------------------------------------------------------------------------------

process(axis_aclk)
begin
  if rising_edge(axis_aclk) then
     if ((t1_rst_n = '0') or (acc_cntr = x"00000000")) then
        acc_cntr <= ctl0_outx; 
     else
        acc_cntr <= acc_cntr - 1;
     end if;
     if ((t1_rst_n = '0') or (acc_cntr = x"00000000")) then
        case div_factor is
            when 1 =>
               stat0_inx <= acc(31 downto 0);
            when 2 =>
               stat0_inx <= acc(32 downto 1); -- use when result can be greater or equal to 4GBps. Then mulriply reading by 2.
            when 4 =>
               stat0_inx <= acc(33 downto 2); -- use when result can be greater or equal to 8GBps. Then mulriply reading by 4.
            when others =>
               stat0_inx <= acc(31 downto 0);
         end case;       
     end if;
   end if;
end process;

stat_xclk:  xpm_cdc_handshake
generic map (
  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 32  -- integer; range: 1-1024
)
port map (
  src_clk    => axis_aclk,
  src_in     => stat0_inx,
  src_send   => src_senda,
  src_rcv    => src_rcva,
  dest_clk   => s_axi_csr_aclk,
  dest_req   => dest_reqa,
  dest_ack   => dest_reqa, 
  dest_out   => stat0_in
);

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
     if (src_rcva = '1') then
       src_senda <= '0';
     elsif (src_rcva = '0') and (src_senda = '0') then
       src_senda <= '1';
     end if;  
   end if;
end process;   

--------------------------------------------------------------------------------
-- Accumulate the number of valid bytes over 1 second.
--------------------------------------------------------------------------------

gen_tready: if (has_tready = true) generate
    process(axis_aclk)
       begin
          if rising_edge(axis_aclk) then
              t1_tready <= m_axis_tready;     
          end if;
    end process;
          
end generate gen_tready;

gen_no_tready: if (has_tready = false) generate
       
    t1_tready <= '1';     
          
end generate gen_no_tready;

process(axis_aclk)
begin
  if rising_edge(axis_aclk) then
     t1_rst_n <= axis_aresetn;
     t1_tvalid <= s_axis_tvalid;
     if ( t1_rst_n = '0') then
        acc <= "00" & x"00000000";   
     elsif  (acc_cntr = x"00000000") then
        if (t1_tvalid = '1') and (t1_tready = '1') then
           acc <= ("00" & num_bytes_vector);
        else
           acc <= ("00" & x"00000000");  
        end if;
     elsif  (t1_tvalid = '1') and (t1_tready = '1') then         
        acc <= acc + ("00" & num_bytes_vector);
     end if;
   end if;
end process;

end Behavioral;
