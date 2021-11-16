----------------------------------------------------------------------------------
-- Pentek AXI-Stream NCO (Single Sample/cycle PD type Axis Output)
----------------------------------------------------------------------------------
-- px_axis_nco_1.vhd
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
-- Revision 1.00 - File Created

-- Additional Comments: 
--  


-- Register Space
-- 0x000 = Frequency (AXI-S Sample Rate * (FREQ_REG[31:0]/0x100000000)) 
-- 0x004 = Offset (OFFSET[31:0]/0x100000000) * 2PI   
-- 0x008 = Control Register 
--    [0] = SYNC_RST_EN  
--    [1] = SYNC LOAD ENABLE '0' = SYNC ignored, '1' = SYNC Loads Freq and Offset

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

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
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_nco_1 is
generic (
   num_bits : integer  := 18 -- 16 to 20
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
   -- Requires 16-bit data streams
   -- Single Sample per cycle
   
   -- Only s_axis_pdti_tvalid and s_axis_pdti_tuser(72) (SYNC) are used
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
   s_axis_pdti_tdata  : in  std_logic_vector(15 downto 0);  
   s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
   s_axis_pdti_tvalid : in  std_logic;
   -----------------------------------------------------------------------------
   -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- If greater than 16, value is sign extended to 24 bits
   -- I is in lower portion of word
   -- I = Cosine, Q = -Sine
   -- tdata = Q,I
   m_axis_pd_tdata     : out std_logic_vector(((((num_bits+7)/8)*8)*2)-1 downto 0);  
   m_axis_pd_tvalid    : out std_logic     
);
end px_axis_nco_1;

architecture Behavioral of px_axis_nco_1 is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti:m_axis_pd, ASSOCIATED_RESET aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

COMPONENT px_axis_nco_dds
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_phase_tvalid : IN STD_LOGIC;
    s_axis_phase_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END COMPONENT;

component px_axis_nco_round_gen
    Generic(
           in_data_width   : integer := 17;   -- Number of data bits for input
           -- one less than input width
           out_data_width  : integer := 16;   -- Number of data bits for output
           rnd_type         : integer := 0;  -- 0 = Round to nearest (.5 rounds up)
                                             -- 1 = Round to nearest Even
                                             -- (.5 rounds to closest even number)
                                             --  2 = Symetric Rounding (symetric
                                             --     around zero) larger, but better.
           input_reg    : integer := 1     -- 1 Pipeline Latency = 3 (but faster)
                                           -- 0 Pipeline Latency = 2 (but slower)
          );

    Port ( DATA_IN : in std_logic_vector(in_data_width-1 downto 0); -- Data input
           DATA_OUT : out std_logic_vector(out_data_width-1 downto 0); -- Data Output
           SAT_OUT : out std_logic; -- Saturation flag
           CLK : in std_logic;      -- Clock
           CE : in std_logic;       -- Clock Enable
           ACLR : in std_logic      -- ASYNC Clear
          );      
end component;

-- Control/Status Registers
-- 3 Control registers
COMPONENT px_axis_nco_csr
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
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal t1_sync               : std_logic   := '0';
signal sync_re               : std_logic   := '0';
signal t1_sync_re            : std_logic   := '0';
signal t1_aresetn            : std_logic   := '0';
signal t2_aresetn            : std_logic   := '0';
signal dds_aresetn           : std_logic   := '0';
signal phase_tdata           : std_logic_vector(63 downto 0) := (others =>'0');
signal i_rnd_out             : std_logic_vector(num_bits-1 downto 0) := (others => '0');
signal q_rnd_out             : std_logic_vector(num_bits-1 downto 0) := (others => '0');
signal dds_tvalid            : std_logic := '0';
signal dds_tdata             : std_logic_vector(47 downto 0) := (others => '0');
signal offset                : std_logic_vector(31 downto 0) := (others => '0');
signal freq                  : std_logic_vector(31 downto 0) := (others => '0');
signal sync_rst_en           : std_logic   := '0';
signal sync_ld_en            : std_logic   := '0';
signal t1_dds_tvalid         : std_logic   := '0';
signal t2_dds_tvalid         : std_logic   := '0';
signal t3_dds_tvalid         : std_logic   := '0';
signal p2_i_rnd_out          : std_logic_vector(num_bits-1 downto 0) := (others => '0');
signal p2_q_rnd_out          : std_logic_vector(num_bits-1 downto 0) := (others => '0');
signal p1_i_rnd_out          : std_logic_vector(num_bits-1 downto 0) := (others => '0');
signal p1_q_rnd_out          : std_logic_vector(num_bits-1 downto 0) := (others => '0');
signal ctl0_out              : std_logic_vector(31 downto 0) := (others => '0');
signal ctl1_out              : std_logic_vector(31 downto 0) := (others => '0');
signal ctl2_out              : std_logic_vector(31 downto 0) := (others => '0');
signal ctl_vctr              : std_logic_vector(65 downto 0) := (others => '0');
signal ctl_vctrx             : std_logic_vector(65 downto 0) := (others => '0');
signal src_senda             : std_logic:= '0';
signal src_rcva              : std_logic:= '0';
signal dest_reqa             : std_logic:= '0';
signal t1_s_axi_csr_aresetn     : std_logic:= '0';
--------------------------------------------------------------------------------

begin

-- Latency = 11
dds_inst : px_axis_nco_dds
  PORT MAP (
    aclk                => aclk,
    aresetn             => dds_aresetn,
    s_axis_phase_tvalid => s_axis_pdti_tvalid,
    s_axis_phase_tdata  => phase_tdata,
    m_axis_data_tvalid  => dds_tvalid,
    m_axis_data_tdata   => dds_tdata
  );
  
  
process(aclk)
begin
   if rising_edge(aclk) then
      -- reset must be two cycles wide
      dds_aresetn      <= not (((not t1_aresetn) or (not t2_aresetn)) or (sync_rst_en and (sync_re or t1_sync_re)));
      t1_aresetn       <= aresetn;
      t2_aresetn       <= t1_aresetn;
      if (((sync_ld_en = '1') and ((sync_re = '1') or (t1_sync_re = '1'))) or (sync_ld_en = '0')) and (s_axis_pdti_tvalid = '1') then
         phase_tdata   <= offset & freq;
      end if;    
      if (s_axis_pdti_tvalid = '1') then
         t1_sync <= s_axis_pdti_tuser(72); 
         sync_re <= s_axis_pdti_tuser(72) and not t1_sync;
         t1_sync_re <= sync_re;
      end if;
   end if;
end process;

--------------------------------------------------------------------------------
-- Rounding
--------------------------------------------------------------------------------

-- Round Data
gen_rnd: if (num_bits < 20) generate

round_gen_i: px_axis_nco_round_gen
    Generic Map
          (
           in_data_width   => 20,
           out_data_width  => num_bits,
           rnd_type        => 2,
           input_reg       => 1
          )

    Port Map
          ( 
           DATA_IN         => dds_tdata(19 downto 0), 
           DATA_OUT        => i_rnd_out,
           SAT_OUT         => open,
           CLK             => aclk,
           CE              => '1',
           ACLR            => '0'
          );   

round_gen_q: px_axis_nco_round_gen
    Generic Map
          (
           in_data_width   => 20,
           out_data_width  => num_bits,
           rnd_type        => 2,
           input_reg       => 1
          )

    Port Map
          ( 
           DATA_IN         => dds_tdata(43 downto 24), 
           DATA_OUT        => q_rnd_out,
           SAT_OUT         => open,
           CLK             => aclk,
           CE              => '1',
           ACLR            => '0'
          );  
              
end generate gen_rnd;

gen_nornd: if (num_bits = 20) generate

process(aclk)
begin
   if rising_edge(aclk) then
      if (s_axis_pdti_tvalid = '1') then
         p2_i_rnd_out <= dds_tdata(19 downto 0);
         p2_q_rnd_out <= dds_tdata(43 downto 24);
         p1_i_rnd_out <= p2_i_rnd_out;
         p1_q_rnd_out <= p2_q_rnd_out;
         i_rnd_out <= p1_i_rnd_out;
         q_rnd_out <= p1_q_rnd_out;
      end if;    
   end if;
end process;

end generate gen_nornd;

gen_17: if (num_bits = 17) generate
   m_axis_pd_tdata(23 downto 17) <= "0000000";
   m_axis_pd_tdata(47 downto 41) <= "0000000";
end generate;
gen_18: if (num_bits = 18) generate
   m_axis_pd_tdata(23 downto 18) <= "000000";
   m_axis_pd_tdata(47 downto 42) <= "000000";
end generate;
gen_19: if (num_bits = 19) generate
   m_axis_pd_tdata(23 downto 19) <= "00000";
   m_axis_pd_tdata(47 downto 43) <= "00000";
end generate;

process(aclk)
begin
   if rising_edge(aclk) then
      t1_dds_tvalid <= dds_tvalid;
      t2_dds_tvalid <= t1_dds_tvalid;
      t3_dds_tvalid <= t2_dds_tvalid;
   end if;
end process;   

m_axis_pd_tdata(num_bits-1 downto 0)       <= i_rnd_out;
m_axis_pd_tdata((num_bits-1)+24 downto 24) <= q_rnd_out;
m_axis_pd_tvalid                           <= t3_dds_tvalid;

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------

csr_inst : px_axis_nco_csr
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
    reg0_init_val       => x"40000000",
    reg1_init_val       => x"00000000",
    reg2_init_val       => x"00000000",
    ctl0_out            => ctl0_out,
    ctl1_out            => ctl1_out,
    ctl2_out            => ctl2_out
  );

ctl_vctr <= ctl2_out(1 downto 0) & ctl1_out & ctl0_out;
  
ctl_xclk:  xpm_cdc_handshake
  generic map (
  
    -- Common module generics
    DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_SYNC_FF    => 4, -- integer; range: 2-10
    WIDTH          => 66 -- integer; range: 1-1024
  )
  port map (
    src_clk    => s_axi_csr_aclk,
    src_in     => ctl_vctr,
    src_send   => src_senda,
    src_rcv    => src_rcva,
    dest_clk   => aclk,
    dest_req   => dest_reqa,
    dest_ack   => dest_reqa, 
    dest_out   => ctl_vctrx
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

process(aclk)
begin
   if rising_edge(aclk) then
      freq         <= ctl_vctrx(31 downto 0);  -- Frequency
      offset       <= ctl_vctrx(63 downto 32); -- Phase Offset
      sync_rst_en  <= ctl_vctrx(64);
      sync_ld_en   <= ctl_vctrx(65); 
   end if;
end process;   


end Behavioral;
