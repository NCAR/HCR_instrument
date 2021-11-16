----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 04/16/2018 12:15:19 PM
-- Design Name: 
-- Module Name: px_pdti_dec16fir_8 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Decimate by 16 FIR for 8 sample/cycle data stream
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: -- Latency = 82
--

-- Memory Map
-- 0x00 Bit[0] Manual Sync (toggle to synchronize decimation
--      Bit[1] External Sync Enable - set to one to allow SYNC signal in tuser to synchronize decimation

----------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2018 Pentek, Inc. All rights reserved.
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
use IEEE.STD_LOGIC_ARITH.conv_std_logic_vector;
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.numeric_std.all;
Library xpm;
use xpm.vcomponents.all;

library UNISIM;
use UNISIM.VComponents.all;

entity px_pdti_dec16fir_8 is
port (
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
s_axi_csr_aclk           : in  std_logic;
s_axi_csr_aresetn        : in  std_logic;
s_axi_csr_awaddr         : in  std_logic_vector(4 downto 0);
s_axi_csr_awprot         : in  std_logic_vector(2 downto 0);
s_axi_csr_awvalid        : in  std_logic;
s_axi_csr_awready        : out std_logic;
s_axi_csr_wdata          : in  std_logic_vector(31 downto 0);
s_axi_csr_wstrb          : in  std_logic_vector(3 downto 0);
s_axi_csr_wvalid         : in  std_logic;
s_axi_csr_wready         : out std_logic;
s_axi_csr_bresp          : out std_logic_vector(1 downto 0);
s_axi_csr_bvalid         : out std_logic;
s_axi_csr_bready         : in  std_logic;
s_axi_csr_araddr         : in  std_logic_vector(4 downto 0);
s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
s_axi_csr_arvalid        : in  std_logic;
s_axi_csr_arready        : out std_logic;
s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
s_axi_csr_rvalid         : out std_logic;
s_axi_csr_rready         : in  std_logic;
-------------------------------------------------------------------------------
axis_aclk          : in std_logic;
axis_aresetn       : in std_logic;
-------------------------------------------------------------------------------
-- Input AXI-S PDTI
-------------------------------------------------------------------------------
-- [ Q7 I7 Q6 I6 Q5 I5 Q4 I4 Q3 I3 Q2 I2 I1 Q0 I0 ]  I0 is oldest sample
s_axis_pdti_tvalid : in std_logic;
s_axis_pdti_tdata  : in std_logic_vector(255 downto 0);
s_axis_pdti_tuser  : in std_logic_vector(127 downto 0);
-------------------------------------------------------------------------------
-- Output AXI-S PDTI
-------------------------------------------------------------------------------
m_axis_pdti_tvalid : out std_logic;
m_axis_pdti_tdata  : out std_logic_vector(31 downto 0);
m_axis_pdti_tuser  : out std_logic_vector(127 downto 0)
);
end px_pdti_dec16fir_8;

architecture Behavioral of px_pdti_dec16fir_8 is

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

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Stage 1 Half Band Dec 2
-- 15-Tap Beta = 9.5
component px_pdti_dec16fir_8_st1
generic(
    num_fraction_bits: integer := 18
);
port (
clk       : in std_logic;
ce        : in std_logic;
d_tm7     : in std_logic_vector(15 downto 0);
d_tm6     : in std_logic_vector(15 downto 0);
d_tm5     : in std_logic_vector(15 downto 0);
d_tm4     : in std_logic_vector(15 downto 0);
d_tm3     : in std_logic_vector(15 downto 0);
d_tm2     : in std_logic_vector(15 downto 0);
d_tm1     : in std_logic_vector(15 downto 0);
d_t       : in std_logic_vector(15 downto 0);
dout_tm3  : out std_logic_vector(15 downto 0);
dout_tm2  : out std_logic_vector(15 downto 0);
dout_tm1  : out std_logic_vector(15 downto 0);
dout_t    : out std_logic_vector(15 downto 0) 
);
end component;

-- Stage 2 Half Band Dec 2
-- 19-Tap Beta = 9.9
component px_pdti_dec16fir_8_st2
generic (
    num_fraction_bits: integer := 18
);
port (
clk       : in std_logic;
ce        : in std_logic;
d_tm3     : in std_logic_vector(15 downto 0);
d_tm2     : in std_logic_vector(15 downto 0);
d_tm1     : in std_logic_vector(15 downto 0);
d_t       : in std_logic_vector(15 downto 0);
dout_tm1  : out std_logic_vector(15 downto 0);
dout_t    : out std_logic_vector(15 downto 0) 
);
end component;

-- Stage 3 Half Band Dec 2
-- 29-Tap Beta = 10
component px_pdti_dec16fir_8_st3
generic (
    num_fraction_bits: integer := 18
);
port (
clk       : in std_logic;
ce        : in std_logic;
d_tm1     : in std_logic_vector(15 downto 0);
d_t       : in std_logic_vector(15 downto 0);
dout_t    : out std_logic_vector(15 downto 0) 
);
end component;

-- 56 tap FIR Dec = 2
COMPONENT px_axis_pdti_dec16fir_8_st4
  PORT (
    aresetn : IN STD_LOGIC;
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tuser : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
signal t1_s_axis_pdti_tvalid : std_logic := '0';
signal t1_s_axis_pdti_tdata  : std_logic_vector(255 downto 0) := (others => '0');
signal st1i_tm3  : std_logic_vector(15 downto 0) := (others => '0'); 
signal st1i_tm2  : std_logic_vector(15 downto 0) := (others => '0');
signal st1i_tm1  : std_logic_vector(15 downto 0) := (others => '0');
signal st1i_t    : std_logic_vector(15 downto 0) := (others => '0');  
signal st2i_tm1  : std_logic_vector(15 downto 0) := (others => '0');
signal st2i_t    : std_logic_vector(15 downto 0) := (others => '0'); 
signal st3i_t    : std_logic_vector(15 downto 0) := (others => '0');   
signal st1q_tm3  : std_logic_vector(15 downto 0) := (others => '0'); 
signal st1q_tm2  : std_logic_vector(15 downto 0) := (others => '0');
signal st1q_tm1  : std_logic_vector(15 downto 0) := (others => '0');
signal st1q_t    : std_logic_vector(15 downto 0) := (others => '0');  
signal st2q_tm1  : std_logic_vector(15 downto 0) := (others => '0');
signal st2q_t    : std_logic_vector(15 downto 0) := (others => '0'); 
signal st3q_t    : std_logic_vector(15 downto 0) := (others => '0'); 
signal t1_axis_aresetn: std_logic := '0';
signal st4_i     : std_logic_vector(23 downto 0) := (others => '0');
signal st4_q     : std_logic_vector(23 downto 0) := (others => '0');  
signal t1_s_axis_pdti_tuser: std_logic_vector(127 downto 0) := (others => '0');  
signal t33_s_axis_pdti_tuser: std_logic_vector(127 downto 0) := (others => '0');  
signal t65_s_axis_pdti_tuser: std_logic_vector(127 downto 0) := (others => '0');
signal t81_s_axis_pdti_tuser: std_logic_vector(127 downto 0) := (others => '0');
signal gate_ff    : std_logic_vector(87 downto 64) := (others => '0');
signal out_tvalid : std_logic;
signal axi_state        : axi_state_type := RESET_STATE;
signal ctl_reg          : std_logic_vector(1 downto 0)  := (others => '0');
signal rd_data          : std_logic_vector(1 downto 0)  := (others => '0');
signal w_data           : std_logic_vector(1 downto 0)  := (others => '0');
signal w_strb           : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic:= '0';
signal t2_syncn         : std_logic:= '0'; 
signal t1_sync          : std_logic:= '0';
signal sync             : std_logic:= '0';  
signal  t1_s_axi_csr_areset: std_logic:= '0'; 
signal sync_en          : std_logic:= '0';  
signal man_sync         : std_logic:= '0'; 

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------
ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti:m_axis_pdti, ASSOCIATED_RESET axis_aresetn";

---------------------------------------------------------------------------------

begin

xpm_cdc_single_inst: xpm_cdc_single
    generic map (
       DEST_SYNC_FF   => 4, -- integer; range: 2-10
       INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
       SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
       SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
    )
    port map (
       src_clk  => axis_aclk,  -- optional; required when SRC_INPUT_REG = 1
       src_in   => '0',
       dest_clk =>axis_aclk,
       dest_out => open
    );

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
       t1_axis_aresetn       <= axis_aresetn;
       t1_s_axis_pdti_tvalid <= s_axis_pdti_tvalid;
       t1_s_axis_pdti_tdata  <= s_axis_pdti_tdata;
       t1_s_axis_pdti_tuser  <= s_axis_pdti_tuser;
    end if;   
end process;

gen_tuser_dly: for i in 0 to 127 generate

tuser_dly1 : SRLC32E
   generic map (
      INIT => X"00000000",    -- Initial contents of shift register
      IS_CLK_INVERTED => '0'  -- Optional inversion for CLK
   )
   port map (
      Q => t33_s_axis_pdti_tuser(i),  -- 1-bit output: SRL Data
      Q31 => open, -- 1-bit output: SRL Cascade Data
      A => "11111",     -- 5-bit input: Selects SRL depth
      CE => t1_s_axis_pdti_tvalid,   -- 1-bit input: Clock enable
      CLK => axis_aclk, -- 1-bit input: Clock
      D => t1_s_axis_pdti_tuser(i)    -- 1-bit input: SRL Data
   );
   
tuser_dly2 : SRLC32E
      generic map (
         INIT => X"00000000",    -- Initial contents of shift register
         IS_CLK_INVERTED => '0'  -- Optional inversion for CLK
      )
      port map (
         Q => t65_s_axis_pdti_tuser(i),  -- 1-bit output: SRL Data
         Q31 => open,      -- 1-bit output: SRL Cascade Data
         A => "11111",     -- 5-bit input: Selects SRL depth
         CE => t1_s_axis_pdti_tvalid,   -- 1-bit input: Clock enable
         CLK => axis_aclk, -- 1-bit input: Clock
         D => t33_s_axis_pdti_tuser(i)   -- 1-bit input: SRL Data
      );
      
 tuser_dly3 : SRLC16E
     generic map (
        INIT => X"0000",    -- Initial contents of shift register
        IS_CLK_INVERTED => '0'  -- Optional inversion for CLK
     )
     port map (
        Q => t81_s_axis_pdti_tuser(i),  -- 1-bit output: SRL Data
        A0 => '1',  --Selects SRL depth
        A1 => '1',  --Selects SRL depth
        A2 => '1',  --Selects SRL depth
        A3 => '1',  --Selects SRL depth
        CE => t1_s_axis_pdti_tvalid,   -- 1-bit input: Clock enable
        CLK => axis_aclk, -- 1-bit input: Clock
        D => t65_s_axis_pdti_tuser(i)   -- 1-bit input: SRL Data
     );
      
end generate;

-------------------------
-- Gate/trig/PPS stretch
-------------------------

gen_gate_strch_dly: for i in 64 to 87 generate

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if t1_axis_aresetn = '0' then
            m_axis_pdti_tuser(i) <= '0';
        elsif out_tvalid = '0' then
            gate_ff(i) <= t81_s_axis_pdti_tuser(i) or gate_ff(i);
        else
            gate_ff(i) <= '0';
        end if;
        if out_tvalid = '1' then
            m_axis_pdti_tuser(i) <= t81_s_axis_pdti_tuser(i) or gate_ff(i);
        end if;    

    end if;    
end process; 

end generate;

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if out_tvalid = '1' then
           m_axis_pdti_tuser(63 downto 0)  <= t81_s_axis_pdti_tuser(63 downto 0);
           m_axis_pdti_tuser(127 downto 88)<= t81_s_axis_pdti_tuser(127 downto 88);
           m_axis_pdti_tdata(15 downto 0)  <= st4_i(15 downto 0);
           m_axis_pdti_tdata(31 downto 16) <= st4_q(15 downto 0);
        end if;  
    end if;    
end process; 

--------------------------------------------------------------------------------
-- Stage 1 FIR
--------------------------------------------------------------------------------
-- -7.   0.   1160.   0.  -11719.   0.   76099.   131072.   76099.   0.  -11719.   0.   1160.   0.  -7.

st1i_inst: px_pdti_dec16fir_8_st1
generic map(
    num_fraction_bits => 19
)
port map (
clk       => axis_aclk,
ce        => t1_s_axis_pdti_tvalid,
d_tm7     => t1_s_axis_pdti_tdata(15 downto 0),
d_tm6     => t1_s_axis_pdti_tdata(47 downto 32),
d_tm5     => t1_s_axis_pdti_tdata(79 downto 64),
d_tm4     => t1_s_axis_pdti_tdata(111 downto 96),
d_tm3     => t1_s_axis_pdti_tdata(143 downto 128),
d_tm2     => t1_s_axis_pdti_tdata(175 downto 160),
d_tm1     => t1_s_axis_pdti_tdata(207 downto 192),
d_t       => t1_s_axis_pdti_tdata(239 downto 224),
dout_tm3  => st1i_tm3,
dout_tm2  => st1i_tm2,
dout_tm1  => st1i_tm1,
dout_t    => st1i_t
);

st1q_inst: px_pdti_dec16fir_8_st1
generic map(
    num_fraction_bits => 19
)
port map (
clk       => axis_aclk,
ce        => t1_s_axis_pdti_tvalid,
d_tm7     => t1_s_axis_pdti_tdata(31 downto 16),
d_tm6     => t1_s_axis_pdti_tdata(63 downto 48),
d_tm5     => t1_s_axis_pdti_tdata(95 downto 80),
d_tm4     => t1_s_axis_pdti_tdata(127 downto 112),
d_tm3     => t1_s_axis_pdti_tdata(159 downto 144),
d_tm2     => t1_s_axis_pdti_tdata(191 downto 176),
d_tm1     => t1_s_axis_pdti_tdata(223 downto 208),
d_t       => t1_s_axis_pdti_tdata(255 downto 240),
dout_tm3  => st1q_tm3,
dout_tm2  => st1q_tm2,
dout_tm1  => st1q_tm1,
dout_t    => st1q_t
);

--------------------------------------------------------------------------------
-- Stage 2 FIR
--------------------------------------------------------------------------------
-- 4.   0.  -384.   0.   3461.   0.  -16276.   0.   78733.   131072.   78733.   0.
--  -16276.   0.   3461.   0.  -384.   0.   4

st2i_inst: px_pdti_dec16fir_8_st2
generic map(
    num_fraction_bits => 18
)
port map (
clk       => axis_aclk,
ce        => t1_s_axis_pdti_tvalid,
d_tm3     => st1i_tm3,
d_tm2     => st1i_tm2,
d_tm1     => st1i_tm1,
d_t       => st1i_t,   
dout_tm1  => st2i_tm1,
dout_t    => st2i_t
);

st2q_inst: px_pdti_dec16fir_8_st2
generic map(
    num_fraction_bits => 18
)
port map (
clk       => axis_aclk,
ce        => t1_s_axis_pdti_tvalid,
d_tm3     => st1q_tm3,
d_tm2     => st1q_tm2,
d_tm1     => st1q_tm1,
d_t       => st1q_t,   
dout_tm1  => st2q_tm1,
dout_t    => st2q_t
);

--------------------------------------------------------------------------------
-- Stage 3 FIR
--------------------------------------------------------------------------------
-- 0.   20.   0.  -215.   0.   1025.   0.  -3362.   0.   8938.   0.  -22317.   0.
-- 81446.   131072.   81446.   0.  -22317.   0.   8938.   0.  -3362.   0.   1025.
-- 0.  -215.   0.   20.   0.


st3i_inst: px_pdti_dec16fir_8_st3
generic map(
    num_fraction_bits => 18
)
port map (
clk       => axis_aclk,
ce        => t1_s_axis_pdti_tvalid,
d_tm1     => st2i_tm1,
d_t       => st2i_t,   
dout_t    => st3i_t
);

st3q_inst: px_pdti_dec16fir_8_st3
generic map(
    num_fraction_bits => 18
)
port map (
clk       => axis_aclk,
ce        => t1_s_axis_pdti_tvalid,
d_tm1     => st2q_tm1,
d_t       => st2q_t,   
dout_t    => st3q_t
);

--------------------------------------------------------------------------------
-- Stage 4 FIR
--------------------------------------------------------------------------------
-- -5.  -41.  -115.  -119.   74.   260.   3.  -486.  -223.   768.   667.  -1056. 
-- -1423.   1262.   2584.  -1253.  -4254.   836.   6568.   285.  -9779.  -2643. 
-- 14541.   7557.  -23149.  -20346.   50695.   131070.   131070.   50695.  -20346.
-- -23149.   7557.   14541.  -2643.  -9779.   285.   6568.   836.  -4254.  -1253. 
-- 2584.   1262.  -1423.  -1056.   667.   768.  -223.  -486.   3.   260.   74.
-- -119.  -115.  -41.  -5.

st4i_inst : px_axis_pdti_dec16fir_8_st4
  PORT MAP (
    aresetn => t2_syncn,
    aclk => axis_aclk,
    s_axis_data_tvalid => t1_s_axis_pdti_tvalid,
    s_axis_data_tready => open,
    s_axis_data_tdata => st3i_t,
    m_axis_data_tvalid => m_axis_pdti_tvalid,
    m_axis_data_tuser => open,
    m_axis_data_tdata => st4_i
  );
  
st4q_inst : px_axis_pdti_dec16fir_8_st4
 PORT MAP (
    aresetn => t2_syncn,
    aclk => axis_aclk,
    s_axis_data_tvalid => t1_s_axis_pdti_tvalid,
    s_axis_data_tready => open,
    s_axis_data_tdata => st3q_t,
    m_axis_data_tvalid => out_tvalid,
    m_axis_data_tuser => open,
    m_axis_data_tdata => st4_q
  );

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
           ctl_reg             <= (others => '0');
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
                    ctl_reg             <= (others => '0');
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
                w_data            <= s_axi_csr_wdata(1 downto 0);
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata(1 downto 0);
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
                   w_data           <= s_axi_csr_wdata(1 downto 0);
                else
                   axi_state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';   
                if w_strb = '1' then
                  ctl_reg           <= w_data(1 downto 0);
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
               rd_data     <= ctl_reg; 
               axi_state   <= WAIT_RD_BS_STATE;
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rdata(1 downto 0) <= rd_data;
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

s_axi_csr_rdata(31 downto 2) <= x"000000" & "000000";  

t1_s_axi_csr_areset <= not t1_s_axi_csr_aresetn;

ms_cdc_pulse_inst: xpm_cdc_pulse
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
    REG_OUTPUT     => 0, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages

  )
  port map (

    src_clk    => s_axi_csr_aclk,
    src_rst    => t1_s_axi_csr_areset,   -- optional; required when RST_USED = 1
    src_pulse  => ctl_reg(0),
    dest_clk   => axis_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => man_sync
  );
  
en_cdc_inst: xpm_cdc_single
    generic map (
       DEST_SYNC_FF   => 4, -- integer; range: 2-10
       INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
       SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
       SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
    )
    port map (
       src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
       src_in   => ctl_reg(1),
       dest_clk => axis_aclk,
       dest_out => sync_en
    );

process(axis_aclk)
  begin
      if rising_edge(axis_aclk) then
        if (t1_axis_aresetn = '0') or (man_sync = '1') or ((t1_s_axis_pdti_tuser(79 downto 72) /= x"00") and (sync_en = '1')) then  
            sync <= '1';
        else
            sync <= '0';
        end if;
        t1_sync <= sync;                                                                                                                                                    
        t2_syncn <= not(sync or t1_sync);     
      end if;
end process;

end Behavioral;
