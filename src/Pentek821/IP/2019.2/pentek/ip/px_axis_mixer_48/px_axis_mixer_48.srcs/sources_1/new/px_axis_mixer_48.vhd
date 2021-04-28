----------------------------------------------------------------------------------
-- Pentek AXI-Stream (PDTI Type) 16-bit Input Data Mixer for 4 or 8 Samples/cycle  
----------------------------------------------------------------------------------
-- px_axis_mixer_48.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2016
--
-- Revision:
-- Revision 1.00 - File Created

-- Additional Comments: 
-- Selectable output resolution of 16 or 24 bits 

-- Register Space
-- 0x000 = Control Register 
-- [00] = Bypass
-- [01] = Mixer
-- [10] = NCO
-- [11] = Zero

-- The input TUSER sideband data is delayed to the output TUSER by the latency
-- of the mixer. 
-- 
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

entity px_axis_mixer_48 is
generic(
   out_res : integer := 16; -- Output Resolution (16 or 24 only) 
   sub_chan: boolean := false; -- Substitute new channel number in user data 
   chan: integer := 0 -- Channel number to substitute when sub_chan = true 0-255   
);
Port ( 
   ---------------------------------------------------------------------------
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
   -- Requires 16-bit data streams
   -- Single 8 Sample per cycle or Dual 4 Sample per cycle
   aclk                : in  std_logic;
   aresetn             : in  std_logic;
   -- tuser[63:0]    = timestamp[63:0]
   -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
   -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
   -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
   -- tuser[91:88]   = Samples/Cycle
   -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   -- tuser[127:104] = Reserved 
   s_axis_pdti_tdata  : in  std_logic_vector(127 downto 0);  -- 8 samples/cycle or dual 4 samples/cycle 
   s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
   s_axis_pdti_tvalid : in  std_logic;
   -----------------------------------------------------------------------------
   -- NCO Input 18-bit
   -----------------------------------------------------------------------------
   s_axis_nco_tdata   : in  std_logic_vector(383 downto 0);  -- 17:0 = I, 41:24 = Q 
   s_axis_nco_tvalid  : in  std_logic; -- not used. It is assumed that the NCO and data stream input   
   -----------------------------------------------------------------------------
   -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- tuser[63:0]    = timestamp[63:0]
   -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
   -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
   -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
   -- tuser[91:88]   = Samples/Cycle
   -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q  
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   -- tuser[127:105] = Reserved  
   m_axis_pdti_tdata  : out std_logic_vector((8*2*out_res)-1 downto 0);  
   m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
   m_axis_pdti_tvalid : out std_logic
);
end px_axis_mixer_48;

architecture Behavioral of px_axis_mixer_48 is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis_pdti:s_axis_pdti:s_axis_nco, ASSOCIATED_RESET aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- Multiplier
-- Latency = 4
-- 16x18 with 17 bit output (symmetrical rounding)
COMPONENT mixer_dsp48_16
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(16 DOWNTO 0)
  );
END COMPONENT;

-- Multiplier
-- Latency = 4
-- 16x18 with 25 bit output (symmetrical rounding)
COMPONENT mixer_dsp48_24
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(24 DOWNTO 0)
  );
END COMPONENT;

-- Control Register Set
-- 1 Control Register
-- 0 Status Registers
COMPONENT px_axis_mixer_csr
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
-- Signals
--------------------------------------------------------------------------------

signal t1_tvalid : std_logic := '0';
signal t2_tvalid : std_logic := '0';
signal t3_tvalid : std_logic := '0';
signal t4_tvalid : std_logic := '0';
signal idata     : std_logic_vector(((out_res+1)*8)-1 downto 0) := (others => '0');
signal qdata     : std_logic_vector(((out_res+1)*8)-1 downto 0) := (others => '0');
signal t1_tdata  : std_logic_vector(127 downto 0) := (others => '0');
signal t2_tdata  : std_logic_vector(127 downto 0) := (others => '0');
signal t3_tdata  : std_logic_vector(127 downto 0) := (others => '0');
signal t4_tdata  : std_logic_vector(127 downto 0) := (others => '0');
signal t1_tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal t2_tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal t3_tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal t4_tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal mode      : std_logic_vector(1 downto 0)   := (others => '0');
signal p1_mode   : std_logic_vector(1 downto 0)   := (others => '0');
signal p2_mode   : std_logic_vector(1 downto 0)   := (others => '0');
signal ctl0_out  : std_logic_vector(31 downto 0)  := (others => '0');
signal ctl0_outx : std_logic_vector(1 downto 0);
signal zero      : std_logic := '0';
signal src_senda : std_logic:= '0';
signal src_rcva  : std_logic:= '0';
signal dest_reqa : std_logic:= '0';
signal t1_s_axi_csr_aresetn: std_logic:= '0';

--------------------------------------------------------------------------------

begin

zero <= mode(1) and mode(0);

gens1tos8: for i in 0 to 7 generate

gen16: if (out_res = 16) generate

multi16_inst: mixer_dsp48_16
  PORT MAP (
    CLK  => aclk,
    CE   => '1',
    SCLR => zero,
    A    => s_axis_pdti_tdata((i*16)+15 downto (i*16)),
    B    => s_axis_nco_tdata((i*48)+17 downto i*48), 
    P    => idata((i*17)+16 downto i*17)
  );
  
multq16_inst: mixer_dsp48_16
    PORT MAP (
      CLK  => aclk,
      CE   => '1',
      SCLR => zero,
      A    => s_axis_pdti_tdata((i*16)+15 downto (i*16)),
      B    => s_axis_nco_tdata((i*48)+41 downto (i*48)+24),
      P    => qdata((i*17)+16 downto i*17)
    );

   m_axis_pdti_tuser(94 downto 93) <= "01";
end generate gen16;

gen24: if (out_res = 24) generate

multi24_inst: mixer_dsp48_24
  PORT MAP (
    CLK  => aclk,
    CE   => '1',
    SCLR => zero,
    A    => s_axis_pdti_tdata,
    B    => s_axis_nco_tdata((i*48)+17 downto i*48),
    P    => idata((i*25)+24 downto i*25)
  );
  
multq24_inst: mixer_dsp48_24
  PORT MAP (
    CLK  => aclk,
    CE   => '1',
    SCLR => zero,
    A    => s_axis_pdti_tdata,
    B    => s_axis_nco_tdata((i*48)+41 downto (i*48)+24),
    P    => qdata((i*25)+24 downto i*25)
  );

   m_axis_pdti_tuser(94 downto 93) <= "10";
end generate gen24;

end generate gens1tos8;

--------------------------------------------------------------------------------
-- Output Multiplexer
--------------------------------------------------------------------------------
process(aclk)
begin
   if rising_edge(aclk) then
      t1_tdata  <= s_axis_pdti_tdata;
      t2_tdata  <= t1_tdata;
      t3_tdata  <= t2_tdata;
      t4_tdata  <= t3_tdata;
      t1_tuser  <= s_axis_pdti_tuser;
      t2_tuser  <= t1_tuser;
      t3_tuser  <= t2_tuser;
      t4_tuser  <= t3_tuser;
      t1_tvalid <= s_axis_pdti_tvalid;
      t2_tvalid <= t1_tvalid;
      t3_tvalid <= t2_tvalid;
      t4_tvalid <= t3_tvalid;
      case mode is
         when "00" =>  -- bypass
            m_axis_pdti_tuser(95) <= '0'; 
         when "01" =>  -- mixer
            m_axis_pdti_tuser(95) <= '1'; 
         when "10" =>  -- nco
            m_axis_pdti_tuser(95) <= '1'; 
         when "11" =>  -- zero    
            m_axis_pdti_tuser(95) <= '1'; 
         when others => 
            m_axis_pdti_tuser(95) <= '1'; 
      end case;      
      m_axis_pdti_tuser(127 downto 104) <=  t4_tuser(127 downto 104);
      m_axis_pdti_tuser(92 downto 0)    <= '0' & t4_tuser(91 downto 0);
      m_axis_pdti_tvalid  <= t4_tvalid;
   end if;
end process;

gen_16out: if (out_res = 16) generate
gen_16lout: for i in 0 to 7 generate

process(aclk)
begin
   if rising_edge(aclk) then
      case mode is
         when "00" =>  -- bypass
               m_axis_pdti_tdata(((i*32)+31) downto (i*32)) <= x"0000" & t4_tdata((i*16)+15 downto (i*16));   
         when "01" =>  -- mixer
            if (idata((i*17)+16) = '0') and (idata((i*17)+15) = '1') then
               m_axis_pdti_tdata((i*32)+15)          <= '0';
               m_axis_pdti_tdata((i*32)+14 downto (i*32)) <= (others => '1');
            else
               m_axis_pdti_tdata((i*32)+15 downto (i*32)) <= idata((i*17)+15 downto i*17); --(15 downto 0);
            end if; 
            if (qdata((i*17)+16) = '0') and (qdata((i*17)+15) = '1') then
               m_axis_pdti_tdata((i*32)+31) <= '0';
               m_axis_pdti_tdata((i*32)+30 downto (i*32)+16) <= (others => '1');
            else
               m_axis_pdti_tdata((i*32)+31 downto (i*32)+16) <= qdata((i*17)+15 downto i*17); --(15 downto 0);
            end if;      
         when "10" =>  -- nco
               m_axis_pdti_tdata((i*32)+31 downto (i*32)) <= s_axis_nco_tdata((i*48)+41 downto (i*48)+26) & s_axis_nco_tdata((i*48)+17 downto (i*48)+2);
         when "11" =>  -- zero    
            m_axis_pdti_tdata((i*32)+31 downto (i*32)) <= (others => '0');
         when others => 
            m_axis_pdti_tdata((i*32)+31 downto (i*32)) <= (others => '0');
      end case;      
   end if;
end process;

end generate gen_16lout;
end generate gen_16out;

gen_24out: if (out_res = 24) generate
gen_24lout: for i in 0 to 7 generate

process(aclk)
begin
   if rising_edge(aclk) then
      case mode is
         when "00" =>  -- bypass
               m_axis_pdti_tdata(((i*48)+47) downto (i*48)) <= x"000000" & t4_tdata((i*16)+15 downto (i*16)) & x"00";
         when "01" =>  -- mixer
            if (idata((i*25)+24) = '0') and (idata((i*25)+23) = '1') then
               m_axis_pdti_tdata((i*48)+23)          <= '0';
               m_axis_pdti_tdata((i*48)+22 downto (i*48)) <= (others => '1');
            else
               m_axis_pdti_tdata((i*48)+23 downto (i*48)) <= idata((i*25)+23 downto i*25); --(23 downto 0);
            end if; 
            if (qdata((i*25)+24) = '0') and (qdata((i*25)+23) = '1') then
               m_axis_pdti_tdata((i*48)+47) <= '0';
               m_axis_pdti_tdata((i*48)+46 downto (i*48)+24) <= (others => '1');
            else
               m_axis_pdti_tdata((i*48)+47 downto (i*48)+24) <= qdata((i*25)+23 downto i*25); --(23 downto 0);
            end if;      
         when "10" =>  -- nco
               m_axis_pdti_tdata((i*48)+47 downto (i*48)) <= s_axis_nco_tdata((i*48)+41 downto (i*48)+24) & "000000" & s_axis_nco_tdata((i*48)+17 downto (i*48)) & "000000";
         when "11" =>  -- zero    
            m_axis_pdti_tdata((i*48)+47 downto (i*48)) <= (others => '0');
         when others => 
            m_axis_pdti_tdata((i*48)+47 downto (i*48)) <= (others => '0');
      end case;      
   end if;
end process;

end generate gen_24lout;
end generate gen_24out;

   -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q  
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   
  
   
gensubch: if (sub_chan = true) generate   
m_axis_pdti_tuser(103 downto 96)  <= conv_std_logic_vector(chan, 8); 
end generate;

genkeepch: if (sub_chan = false) generate   
process(aclk)
begin
   if rising_edge(aclk) then
      m_axis_pdti_tuser(103 downto 96)  <= t4_tuser(103 downto 96);
   end if;
end process;       
end generate;

csr_inst: px_axis_mixer_csr
  PORT MAP (
    s_axi_csr_aclk    => s_axi_csr_aclk,
    s_axi_csr_aresetn => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr  => s_axi_csr_awaddr,
    s_axi_csr_awprot  => s_axi_csr_awprot,
    s_axi_csr_awvalid => s_axi_csr_awvalid,
    s_axi_csr_awready => s_axi_csr_awready,
    s_axi_csr_wdata   => s_axi_csr_wdata,
    s_axi_csr_wstrb   => s_axi_csr_wstrb,
    s_axi_csr_wvalid  => s_axi_csr_wvalid,
    s_axi_csr_wready  => s_axi_csr_wready,
    s_axi_csr_bresp   => s_axi_csr_bresp,
    s_axi_csr_bvalid  => s_axi_csr_bvalid,
    s_axi_csr_bready  => s_axi_csr_bready,
    s_axi_csr_araddr  => s_axi_csr_araddr,
    s_axi_csr_arprot  => s_axi_csr_arprot,
    s_axi_csr_arvalid => s_axi_csr_arvalid,
    s_axi_csr_arready => s_axi_csr_arready,
    s_axi_csr_rdata   => s_axi_csr_rdata,
    s_axi_csr_rresp   => s_axi_csr_rresp,
    s_axi_csr_rvalid  => s_axi_csr_rvalid,
    s_axi_csr_rready  => s_axi_csr_rready,
    reg0_init_val     => x"00000000",
    ctl0_out          => ctl0_out
  );

-- Control Register
-- [00] = Bypass
-- [01] = Mixer
-- [10] = NCO
-- [11] = Zero

ctl_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 2  -- integer; range: 1-1024
)
port map (
  src_clk    => s_axi_csr_aclk,
  src_in     => ctl0_out(1 downto 0),
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

p2_mode(0)    <= ctl0_outx(0);
p2_mode(1)    <= ctl0_outx(1);
 
process(aclk)
begin
   if rising_edge(aclk) then
     p1_mode <= p2_mode;
     mode    <= p1_mode;
   end if;
end process;   

end Behavioral;
