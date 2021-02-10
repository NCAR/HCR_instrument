----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 02/19/2016 02:07:18 PM
-- Design Name: 
-- Module Name: px_axis_iq_fmtr_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

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
-- Libraries
-------------------------------------------------------------------------------

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

-- Unpacked Q State will only work if there is at least on low cycle of tvalid between valid data inputs.

entity px_axis_iq_fmtr_1 is
generic(
   out_type : integer := 0 -- Output Type 1 = 48-bit Interface - 24-bit output is Packed I/Q (48-bit total)
                           -- Output Type 0 = 32-bit Interface - 24-bit output is unpacked to consecutive 32-bit words     
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

-----------------------------------------------------------------------------
-- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
-----------------------------------------------------------------------------
-- Requires 24-bit data streams
-- Single Sample per cycle
aclk                : in  std_logic;
aresetn             : in  std_logic;
-- tuser[63:0]    = timestamp[63:0]
-- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
-- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
-- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
-- tuser[91:88]   = Samples/Cycle
-- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
-- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
-- tuser[95]      = Data Type 0 = Real 1 = I/Q
-- tuser[103:96]  = channel[7:0] 
-- tuser[127:104] = Reserved 
s_axis_pdti_tdata  : in  std_logic_vector(47 downto 0);  
s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
s_axis_pdti_tvalid : in  std_logic;
-----------------------------------------------------------------------------
-- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
-----------------------------------------------------------------------------
-- tuser[63:0]    = timestamp[63:0]
-- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
-- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
-- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
-- tuser[91:88]   = Samples/Cycle
-- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q  
-- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
-- tuser[95]      = Data Type 0 = Real 1 = I/Q
-- tuser[103:96]  = channel[7:0] 
-- tuser[127:105] = Reserved  (104 = saturate marker) 
m_axis_pdti_tdata  : out std_logic_vector((31 + (out_type*16)) downto 0);  
m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
m_axis_pdti_tvalid : out std_logic

);
end px_axis_iq_fmtr_1;

architecture Behavioral of px_axis_iq_fmtr_1 is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis_pdti:s_axis_pdti, ASSOCIATED_RESET aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- Symmetrical Rounding
COMPONENT px_axis_iq_fmtr_rnd
  PORT (
    axis_aclk : IN STD_LOGIC;
    axis_aresetn : IN STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    s_axis_tuser  : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_axis_tvalid : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_tuser  : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC
  );
END COMPONENT;

-- Control Register
COMPONENT px_axis_iqfmtr_csr
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
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type state_type is (
RESET_STATE,
PACKED_STATE,
UNPACKED_I_STATE,
UNPACKED_Q_STATE
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal t1_i_data  : std_logic_vector(23 downto 0);
signal t1_q_data  : std_logic_vector(23 downto 0); 
signal t1_tuser   : std_logic_vector(127 downto 0);  
signal t1_dval    : std_logic;   
signal t2_dval    : std_logic;   
signal t1_aresetn : std_logic;
signal sync       : std_logic; 
signal t1_toggle  : std_logic; 
signal t2_i_invert: std_logic_vector(23 downto 0);
signal t2_q_invert: std_logic_vector(23 downto 0);
signal t5_i_rnd   : std_logic_vector(15 downto 0);
signal t5_q_rnd   : std_logic_vector(15 downto 0);
signal t5_dval    : std_logic;
signal t2_tuser   : std_logic_vector(127 downto 0);     
signal t5_tuser   : std_logic_vector(127 downto 0);   
signal t3_i_invert: std_logic_vector(23 downto 0);
signal t4_i_invert: std_logic_vector(23 downto 0);
signal t5_i_invert: std_logic_vector(23 downto 0);
signal t3_q_invert: std_logic_vector(23 downto 0);
signal t4_q_invert: std_logic_vector(23 downto 0);
signal t5_q_invert: std_logic_vector(23 downto 0);
signal t6_mux_data: std_logic_vector((31 + (out_type*16)) downto 0); 
signal t6_mux_tuser: std_logic_vector(127 downto 0);   
signal t6_mux_dval : std_logic; 
signal ctl0_out   : std_logic_vector(31 downto 0);
signal ctl0_outx  : std_logic_vector(4 downto 0);
signal x_bypass_n : std_logic;
signal x_invert   : std_logic;
signal x_offset   : std_logic;
signal x_unpacked : std_logic;
signal x_sync_en  : std_logic;
signal t1_mode    : std_logic_vector(1 downto 0);
signal state      : state_type;
signal save_tuser : std_logic_vector(127 downto 0);
signal save_qdata : std_logic_vector(23 downto 0);
signal src_senda   : std_logic:= '0';
signal src_rcva    : std_logic:= '0';
signal dest_reqa   : std_logic:= '0'; 
signal t1_s_axi_csr_aresetn: std_logic:= '0';
--------------------------------------------------------------------------------

begin

process(aclk)
begin
   if rising_edge(aclk) then
      t1_i_data        <= s_axis_pdti_tdata(23 downto 0);
      t1_q_data        <= s_axis_pdti_tdata(47 downto 24);
      t1_tuser         <= s_axis_pdti_tuser; 
      t1_dval          <= s_axis_pdti_tvalid;
      t2_dval          <= t1_dval;
      t1_aresetn       <= aresetn;
   end if;
end process;  

sync <= t1_tuser(72);

-- ============================================================================
-- Create Inversion Controls for Output Formatting
-- ============================================================================

-- Inverse Spectrum = I0  I1  I2  I3
--                   -Q0 -Q1 -Q2 -Q3

-- Offset Spectrum  = I0  -I1  I2 -I3
--                    Q0  -Q1  Q2 -Q3

process(aclk)
begin
   if rising_edge(aclk) then
      if ((sync = '1') and (x_sync_en = '1')) or (t1_aresetn = '0') then
         t1_toggle <= '0';
      elsif t1_dval = '1' then
         t1_toggle <= not t1_toggle;
      end if;
   end if;   
end process;

t1_mode <= (x_offset and x_bypass_n) & (x_invert and x_bypass_n);

process(aclk)
begin
   if rising_edge(aclk) then
      case t1_mode is
         when "00" =>
            t2_i_invert <= t1_i_data;
            t2_q_invert <= t1_q_data;
         when "01" =>
            t2_i_invert <= t1_i_data;
            t2_q_invert <= x"000000" - t1_q_data;
         when "10" =>
            if t1_toggle = '0' then
               t2_i_invert <= t1_i_data;
               t2_q_invert <= t1_q_data;
            else
               t2_i_invert <= x"000000" - t1_i_data;
               t2_q_invert <= x"000000" - t1_q_data;
            end if;
         when "11" =>
            if t1_toggle = '0' then
               t2_i_invert <= t1_i_data;
               t2_q_invert <= x"000000" - t1_q_data;
            else
               t2_i_invert <= x"000000" - t1_i_data;
               t2_q_invert <= t1_q_data;
            end if;   
         when others =>
            t2_i_invert <= t1_i_data;
            t2_q_invert <= t1_q_data;
      end case;   
   end if;
end process;   

--------------------------------------------------------------------------------
-- Output 16-bit Rounding
--------------------------------------------------------------------------------

gen_rndtype0: if (out_type = 0) generate
-- Symmetric Rounding
-- Latency = 3
round_gen_i: px_axis_iq_fmtr_rnd
  PORT MAP (
    axis_aclk     => aclk,
    axis_aresetn  => t1_aresetn,
    s_axis_tdata  => t2_i_invert,
    s_axis_tuser  => t2_tuser,
    s_axis_tvalid => t2_dval,
    m_axis_tdata  => t5_i_rnd,
    m_axis_tuser  => t5_tuser,
    m_axis_tvalid => t5_dval
  );
  
round_gen_q: px_axis_iq_fmtr_rnd
    PORT MAP (
      axis_aclk     => aclk,
      axis_aresetn  => t1_aresetn,
      s_axis_tdata  => t2_q_invert,
      s_axis_tuser  => x"00000000000000000000000000000000",
      s_axis_tvalid => t2_dval,
      m_axis_tdata  => t5_q_rnd,
      m_axis_tuser  => open,
      m_axis_tvalid => open
    );  
end generate;
          
process(aclk)
begin
   if rising_edge(aclk) then    
      t2_tuser    <= t1_tuser;         
      t3_i_invert <= t2_i_invert;    
      t4_i_invert <= t3_i_invert;
      t5_i_invert <= t4_i_invert;          
      t3_q_invert <= t2_q_invert;    
      t4_q_invert <= t3_q_invert;
      t5_q_invert <= t4_q_invert;         
   end if;
end process;           
      
          
--------------------------------------------------------------------------------
-- Output
--------------------------------------------------------------------------------

-- tuser[63:0]    = timestamp[63:0]
-- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
-- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
-- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
-- tuser[91:88]   = Samples/Cycle
-- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
-- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
-- tuser[95]      = Data Type 0 = Real 1 = I/Q
-- tuser[103:96]  = channel[7:0] 
-- tuser[127:104] = Reserved 

gen_outtype0: if (out_type = 0) generate
-- 32-bit output width.
-- Requires rounding 24-bit values to 16 bit for packed format.
process(aclk)
begin
   if rising_edge(aclk) then
      if t1_aresetn = '0' then
         state <= RESET_STATE;
         t6_mux_data  <= (others => '0');
         t6_mux_tuser <= (others => '0');
         t6_mux_dval <= '0';
      else
         case state is
            when RESET_STATE =>
               t6_mux_data  <= (others => '0');
               t6_mux_tuser <= (others => '0');
               t6_mux_dval <= '0';
               if x_unpacked = '1' then
                  state <= UNPACKED_I_STATE;
               else
                  state <= PACKED_STATE;
               end if;   
            when PACKED_STATE  =>
               if  t5_dval = '1' then
                  t6_mux_data  <= t5_q_rnd & t5_i_rnd;
                  t6_mux_tuser <= t5_tuser(127 downto 95) & "01" & t5_tuser(92 downto 0); 
               end if;  
               if x_unpacked = '1' then
                  state <= UNPACKED_I_STATE;
               else
                  state <= PACKED_STATE;
               end if;    
               t6_mux_dval <= t5_dval;
            when UNPACKED_I_STATE =>
               t6_mux_dval <= t5_dval;
               if (t5_dval = '1') then
                  t6_mux_data  <= t5_i_invert & x"00";
                  t6_mux_tuser <= t5_tuser(127 downto 95) & "100" & t5_tuser(91 downto 0); 
                  save_qdata   <= t5_q_invert;
                  save_tuser   <= t5_tuser;
                  state <= UNPACKED_Q_STATE;
               else
                  state <= UNPACKED_I_STATE;
               end if;   
            when UNPACKED_Q_STATE => 
               t6_mux_dval <= '1';
               t6_mux_data <= save_qdata & x"00";
               t6_mux_tuser <= save_tuser(127 downto 95) & "101" & save_tuser(91 downto 0); 
               if x_unpacked = '1' then
                  state <= UNPACKED_I_STATE;
               else
                  state <= PACKED_STATE;
               end if;   
            when others =>
               state <= RESET_STATE;
          end case;     
      end if; 
   end if;
end process;

end generate; 

gen_outtype1: if (out_type = 1) generate
-- unpacked has no effect in this output type. Data is always unpacked 24-bit
process(aclk)
begin
   if rising_edge(aclk) then   
      t6_mux_data  <= t5_q_invert & t5_i_invert;
      t6_mux_tuser <= t5_tuser;
      t6_mux_dval  <= t5_dval; 
   end if;
end process;

end generate;

-- Ouput
process(aclk)
begin
   if rising_edge(aclk) then   
      m_axis_pdti_tdata  <= t6_mux_data; 
      m_axis_pdti_tuser  <= t6_mux_tuser;
      m_axis_pdti_tvalid <= t6_mux_dval; 
   end if;
end process;

--------------------------------------------------------------------------------
-- Control Register
--------------------------------------------------------------------------------
csr_inst : px_axis_iqfmtr_csr
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
    ctl0_out => ctl0_out
  );
  
ctl_xclk:  xpm_cdc_handshake
  generic map (
  
    -- Common module generics
    DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_SYNC_FF    => 4, -- integer; range: 2-10
    WIDTH          => 5  -- integer; range: 1-1024
  )
  port map (
    src_clk    => s_axi_csr_aclk,
    src_in     => ctl0_out(4 downto 0),
    src_send   => src_senda,
    src_rcv    => src_rcva,
    dest_clk   => aclk,
    dest_req   => dest_reqa,
    dest_ack   => dest_reqa, 
    dest_out   => ctl0_outx
  );
  
  process(s_axi_csr_aclk)
  begin
     if rising_edge(s_axi_csr_aclk) then
       t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
       if (src_rcva = '1') then
         src_senda <= '0';
       elsif (src_rcva = '0') and (src_senda = '0') then
         src_senda <= '1';
       end if;  
     end if;
  end process;   

x_bypass_n <= ctl0_outx(0);
x_invert   <= ctl0_outx(1);
x_offset   <= ctl0_outx(2);
x_unpacked <= ctl0_outx(3);
x_sync_en  <= ctl0_outx(4);

end Behavioral;
