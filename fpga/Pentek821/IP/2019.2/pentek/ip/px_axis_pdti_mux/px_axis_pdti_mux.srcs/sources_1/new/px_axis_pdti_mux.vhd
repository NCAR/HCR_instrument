----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 02/24/2015 08:27:02 AM
-- Design Name: 
-- Module Name: px_axispdti_8mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: AXI4-Stream 8:1 Mux with AXI-Lite Control
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
-- Latency = 1 or 2
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
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_pdti_mux is
generic(
    data_byte_width         : integer := 2;  -- Width of input data stream in bytes
    num_input_streams       : integer := 2; -- Number of Input Streams 2-8
    add_input_regs          : boolean := false -- Add input registers
);
port (
    --------------------------------------------------------------------------------
    -- AXI LITE Slave Interface  
    -- DWORD Addressing
    --------------------------------------------------------------------------------
    s_axi_csr_aclk            : in  std_logic;
    s_axi_csr_aresetn         : in  std_logic;
    s_axi_csr_awaddr          : in  std_logic_vector(2 downto 0);
    s_axi_csr_awprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_awvalid         : in  std_logic;
    s_axi_csr_awready         : out std_logic;
    s_axi_csr_wdata           : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb           : in  std_logic_vector(3 downto 0); -- not used
    s_axi_csr_wvalid          : in  std_logic;
    s_axi_csr_wready          : out std_logic;
    s_axi_csr_bresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid          : out std_logic;
    s_axi_csr_bready          : in  std_logic;
    s_axi_csr_araddr          : in  std_logic_vector(2 downto 0);
    s_axi_csr_arprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_arvalid         : in  std_logic;
    s_axi_csr_arready         : out std_logic;
    s_axi_csr_rdata           : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid          : out std_logic;
    s_axi_csr_rready          : in  std_logic;
    -----------------------------------------------------------------------------
    -- AXI4- Stream Clock
    -----------------------------------------------------------------------------
    s_axis_aclk               : in  std_logic;
    s_axis_aresetn            : in  std_logic;
    -----------------------------------------------------------------------------
    -- Input Data Data/Time/Info Streams (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[63:0]    = timestamp[63:0]
    -- tuser[71:64]   = Gate Positions  
    -- tuser[79:72]   = Sync Positions      
    -- tuser[87:80]   = PPS Positions
    -- tuser[92:88]   = Samples/Cycle
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    -----------------------------------------------------------------------------
    -- Channel 0 
    s_axis_i0_pdti_tdata  : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_i0_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_i0_pdti_tvalid : in  std_logic;
    -- Channel 1 
    s_axis_i1_pdti_tdata  : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_i1_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_i1_pdti_tvalid : in  std_logic;    
    -- Channel 2 
    s_axis_i2_pdti_tdata  : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_i2_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_i2_pdti_tvalid : in  std_logic;
    -- Channel 3 
    s_axis_i3_pdti_tdata  : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_i3_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_i3_pdti_tvalid : in  std_logic;
    -- Channel 4 
    s_axis_i4_pdti_tdata  : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_i4_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_i4_pdti_tvalid : in  std_logic;
    -- Channel 5 
    s_axis_i5_pdti_tdata  : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_i5_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_i5_pdti_tvalid : in  std_logic;    
    -- Channel 6 
    s_axis_i6_pdti_tdata  : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_i6_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_i6_pdti_tvalid : in  std_logic;
    -- Channel 7 
    s_axis_i7_pdti_tdata  : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_i7_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_i7_pdti_tvalid : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output
    ----------------------------------------------------------------------------
    m_axis_pdti_tdata     : out std_logic_vector(((data_byte_width*8)-1) downto 0);
    m_axis_pdti_tuser     : out std_logic_vector(127 downto 0);
    m_axis_pdti_tvalid    : out std_logic    
);
end px_axis_pdti_mux;

architecture Behavioral of px_axis_pdti_mux is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_i0_pdti:s_axis_i1_pdti:s_axis_i2_pdti:s_axis_i3_pdti:s_axis_i4_pdti:s_axis_i5_pdti:s_axis_i6_pdti:s_axis_i7_pdti:m_axis_pdti, ASSOCIATED_RESET s_axis_aresetn";

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal axi_state        : axi_state_type := RESET_STATE;
signal sel_reg          : std_logic_vector(2 downto 0)  := (others => '0');
signal t1_sel_reg       : std_logic_vector(2 downto 0)  := (others => '0');
signal t2_sel_reg       : std_logic_vector(2 downto 0)  := (others => '0');
signal rd_data          : std_logic_vector(2 downto 0)  := (others => '0');
signal w_data           : std_logic_vector(2 downto 0)  := (others => '0');
signal ch0_tdata        : std_logic_vector(((data_byte_width*8)-1) downto 0):= (others => '0');
signal ch0_tuser        : std_logic_vector(127 downto 0) := (others => '0');
signal ch0_tvalid       : std_logic := '0';                     
signal ch1_tdata        : std_logic_vector(((data_byte_width*8)-1) downto 0):= (others => '0');
signal ch1_tuser        : std_logic_vector(127 downto 0) := (others => '0');
signal ch1_tvalid       : std_logic := '0';                                 
signal ch2_tdata        : std_logic_vector(((data_byte_width*8)-1) downto 0):= (others => '0');
signal ch2_tuser        : std_logic_vector(127 downto 0) := (others => '0');
signal ch2_tvalid       : std_logic := '0';                                 
signal ch3_tdata        : std_logic_vector(((data_byte_width*8)-1) downto 0):= (others => '0');
signal ch3_tuser        : std_logic_vector(127 downto 0) := (others => '0');
signal ch3_tvalid       : std_logic := '0';  
signal ch4_tdata        : std_logic_vector(((data_byte_width*8)-1) downto 0):= (others => '0');
signal ch4_tuser        : std_logic_vector(127 downto 0) := (others => '0');
signal ch4_tvalid       : std_logic := '0';                     
signal ch5_tdata        : std_logic_vector(((data_byte_width*8)-1) downto 0):= (others => '0');
signal ch5_tuser        : std_logic_vector(127 downto 0) := (others => '0');
signal ch5_tvalid       : std_logic := '0';                                 
signal ch6_tdata        : std_logic_vector(((data_byte_width*8)-1) downto 0):= (others => '0');
signal ch6_tuser        : std_logic_vector(127 downto 0) := (others => '0');
signal ch6_tvalid       : std_logic := '0';                                 
signal ch7_tdata        : std_logic_vector(((data_byte_width*8)-1) downto 0):= (others => '0');
signal ch7_tuser        : std_logic_vector(127 downto 0) := (others => '0');
signal ch7_tvalid       : std_logic := '0';                                 
signal w_strb           : std_logic := '0';
signal sel              : std_logic_vector(2 downto 0) := (others => '0');
signal selx             : std_logic_vector(2 downto 0) := (others => '0');
signal src_senda        : std_logic:= '0';
signal src_rcva         : std_logic:= '0';
signal dest_reqa        : std_logic:= '0';
signal t1_s_axi_csr_aresetn: std_logic:= '0';
-------------------------------------------------------------------------------

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
           sel_reg             <= (others => '0');
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
                    sel_reg             <= (others => '0');
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
                w_data            <= s_axi_csr_wdata(2 downto 0);
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata(2 downto 0);
                axi_state         <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_csr_wready     <= '0';
                if (s_axi_csr_awvalid = '1') then      
                   axi_state  <= WR_ADDR_DEC_STATE;
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
                   w_data           <= s_axi_csr_wdata(2 downto 0);
                else
                   axi_state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';   
                if w_strb = '1' then
                  sel_reg           <= w_data;
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
               rd_data     <= sel_reg; 
               axi_state   <= WAIT_RD_BS_STATE;
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rdata(2 downto 0) <= rd_data;
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

s_axi_csr_rdata(31 downto 3) <= x"0000000" & '0';

--------------------------------------------------------------------------------
-- Optional Input Registers
--------------------------------------------------------------------------------

gen_in_regs: if (add_input_regs = true) generate

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        ch0_tdata  <= s_axis_i0_pdti_tdata; 
        ch0_tuser  <= s_axis_i0_pdti_tuser; 
        ch0_tvalid <= s_axis_i0_pdti_tvalid;          
        ch1_tdata  <= s_axis_i1_pdti_tdata; 
        ch1_tuser  <= s_axis_i1_pdti_tuser; 
        ch1_tvalid <= s_axis_i1_pdti_tvalid;            
        ch2_tdata  <= s_axis_i2_pdti_tdata; 
        ch2_tuser  <= s_axis_i2_pdti_tuser; 
        ch2_tvalid <= s_axis_i2_pdti_tvalid;            
        ch3_tdata  <= s_axis_i3_pdti_tdata; 
        ch3_tuser  <= s_axis_i3_pdti_tuser; 
        ch3_tvalid <= s_axis_i3_pdti_tvalid;  
        ch4_tdata  <= s_axis_i4_pdti_tdata; 
        ch4_tuser  <= s_axis_i4_pdti_tuser; 
        ch4_tvalid <= s_axis_i4_pdti_tvalid;          
        ch5_tdata  <= s_axis_i5_pdti_tdata; 
        ch5_tuser  <= s_axis_i5_pdti_tuser; 
        ch5_tvalid <= s_axis_i5_pdti_tvalid;            
        ch6_tdata  <= s_axis_i6_pdti_tdata; 
        ch6_tuser  <= s_axis_i6_pdti_tuser; 
        ch6_tvalid <= s_axis_i6_pdti_tvalid;            
        ch7_tdata  <= s_axis_i7_pdti_tdata; 
        ch7_tuser  <= s_axis_i7_pdti_tuser; 
        ch7_tvalid <= s_axis_i7_pdti_tvalid;          
    end if;
end process;

end generate;

gen_no_in_regs: if (add_input_regs = false) generate

        ch0_tdata  <= s_axis_i0_pdti_tdata; 
        ch0_tuser  <= s_axis_i0_pdti_tuser; 
        ch0_tvalid <= s_axis_i0_pdti_tvalid;          
        ch1_tdata  <= s_axis_i1_pdti_tdata; 
        ch1_tuser  <= s_axis_i1_pdti_tuser; 
        ch1_tvalid <= s_axis_i1_pdti_tvalid;            
        ch2_tdata  <= s_axis_i2_pdti_tdata; 
        ch2_tuser  <= s_axis_i2_pdti_tuser; 
        ch2_tvalid <= s_axis_i2_pdti_tvalid;            
        ch3_tdata  <= s_axis_i3_pdti_tdata; 
        ch3_tuser  <= s_axis_i3_pdti_tuser; 
        ch3_tvalid <= s_axis_i3_pdti_tvalid;
        ch4_tdata  <= s_axis_i4_pdti_tdata; 
        ch4_tuser  <= s_axis_i4_pdti_tuser; 
        ch4_tvalid <= s_axis_i4_pdti_tvalid;          
        ch5_tdata  <= s_axis_i5_pdti_tdata; 
        ch5_tuser  <= s_axis_i5_pdti_tuser; 
        ch5_tvalid <= s_axis_i5_pdti_tvalid;            
        ch6_tdata  <= s_axis_i6_pdti_tdata; 
        ch6_tuser  <= s_axis_i6_pdti_tuser; 
        ch6_tvalid <= s_axis_i6_pdti_tvalid;            
        ch7_tdata  <= s_axis_i7_pdti_tdata; 
        ch7_tuser  <= s_axis_i7_pdti_tuser; 
        ch7_tvalid <= s_axis_i7_pdti_tvalid; 

end generate;


gen_2: if (num_input_streams = 2) generate 
   sel <="00" & sel_reg(0);
end generate;
gen_34: if ((num_input_streams = 3) or  (num_input_streams = 4)) generate 
   sel <= '0' & sel_reg(1 downto 0);
end generate;
gen_5678: if (num_input_streams > 4) generate 
   sel <= sel_reg(2 downto 0);
end generate;

--------------------------------------------------------------------------------
-- Clock Boundary Crossing
--------------------------------------------------------------------------------

ctl_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 3 -- integer; range: 1-1024
)
port map (
  src_clk    => s_axi_csr_aclk,
  src_in     => sel,
  src_send   => src_senda,
  src_rcv    => src_rcva,
  dest_clk   => s_axis_aclk,
  dest_req   => dest_reqa,
  dest_ack   => dest_reqa, 
  dest_out   => selx
);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcva = '1') then
       src_senda <= '0';
     elsif (src_rcva = '0') and (src_senda = '0') then
       src_senda <= '1';
     end if;  
   end if;
end process;

--------------------------------------------------------------------------------
-- Output Multiplexer
--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        t1_sel_reg <= selx;
        t2_sel_reg <= t1_sel_reg;
        case t2_sel_reg is
            when "000" =>
                m_axis_pdti_tdata  <= ch0_tdata;
                m_axis_pdti_tuser  <= ch0_tuser;
                m_axis_pdti_tvalid <= ch0_tvalid;
            when "001" =>
                m_axis_pdti_tdata  <= ch1_tdata;
                m_axis_pdti_tuser  <= ch1_tuser;
                m_axis_pdti_tvalid <= ch1_tvalid;
            when "010" =>
                m_axis_pdti_tdata  <= ch2_tdata;
                m_axis_pdti_tuser  <= ch2_tuser;
                m_axis_pdti_tvalid <= ch2_tvalid;            
            when "011" =>
                m_axis_pdti_tdata  <= ch3_tdata;
                m_axis_pdti_tuser  <= ch3_tuser;
                m_axis_pdti_tvalid <= ch3_tvalid;
            when "100" =>
                m_axis_pdti_tdata  <= ch4_tdata;
                m_axis_pdti_tuser  <= ch4_tuser;
                m_axis_pdti_tvalid <= ch4_tvalid;
            when "101" =>
                m_axis_pdti_tdata  <= ch5_tdata;
                m_axis_pdti_tuser  <= ch5_tuser;
                m_axis_pdti_tvalid <= ch5_tvalid;
            when "110" =>
                m_axis_pdti_tdata  <= ch6_tdata;
                m_axis_pdti_tuser  <= ch6_tuser;
                m_axis_pdti_tvalid <= ch6_tvalid;            
            when "111" =>
                m_axis_pdti_tdata  <= ch7_tdata;
                m_axis_pdti_tuser  <= ch7_tuser;
                m_axis_pdti_tvalid <= ch7_tvalid;
            when others =>
                m_axis_pdti_tdata  <= ch7_tdata;
                m_axis_pdti_tuser  <= ch7_tuser;
                m_axis_pdti_tvalid <= ch7_tvalid;            
        end case;        
    end if;
end process;
end Behavioral;