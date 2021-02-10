----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 12/21/2016 08:07:27 AM
-- Design Name: 
-- Module Name: px_axis_pdti_upsizer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Upsizes the number of sample/cycle for Pentek PDTI AXI-S 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- The tuser fields Samples/Cycle, as well as Gate, Sync, and PPS positions are
-- modified to agree with the new number of Samples/Cycle.
-- 
-- The Input Width MUST be less than Output Width! 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_pdti_upsizer is
generic (
    bytes_per_sample       : integer := 2; --  1,2, or 4
    in_samples_per_cycle   : integer := 1;  -- Width of input data stream in samples -- 1,2,4 
    -- Output Width must be greater than input width
    out_samples_per_cycle  : integer := 2;   -- Width of output data stream in samples - 2,4,8
    has_tready             : boolean := false 
);
port (
     axis_aclk             : in std_logic;
     axis_aresetn          : in std_logic;
     -----------------------------------------------------------------------------
     -- Input Data Data/Time/Info Streams (AXI4-Stream Slave) no back pressure
     -----------------------------------------------------------------------------
     -- tuser[63:0]    = timestamp[63:0]
     -- tuser[71:64]   = Gate Positions  
     -- tuser[79:72]   = Sync Positions      
     -- tuser[87:80]   = PPS Positions
     -- tuser[92:88]   = Samples/Cycle
     -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
     -- tuser[95]      = Data Type 0 = Real 1 = I/Q
     -- tuser[103:96]  = channel[7:0] 
     -- tuser[127:104] = Reserved 
     -----------------------------------------------------------------------------
     s_axis_pdti_tdata     : in  std_logic_vector(((in_samples_per_cycle*bytes_per_sample*8)-1) downto 0);
     s_axis_pdti_tuser     : in  std_logic_vector(127 downto 0);
     s_axis_pdti_tvalid    : in  std_logic;
     s_axis_pdti_tready    : out std_logic;
     ----------------------------------------------------------------------------
     -- Output
     ----------------------------------------------------------------------------
     m_axis_pdti_tdata     : out std_logic_vector(((out_samples_per_cycle*bytes_per_sample*8)-1) downto 0);
     m_axis_pdti_tuser     : out std_logic_vector(127 downto 0);
     m_axis_pdti_tvalid    : out std_logic;
     m_axis_pdti_tready    : in  std_logic  
     );
end px_axis_pdti_upsizer;

architecture Behavioral of px_axis_pdti_upsizer is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti:m_axis_pdti, ASSOCIATED_RESET axis_aresetn";


--------------------------------------------------------------------------------
-- Functions
--------------------------------------------------------------------------------
function px_boolean_to_std_logic(l: boolean) return std_logic is
   begin
       if l then
          return('1');
       else
          return('0');
       end if;
   end function px_boolean_to_std_logic;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
constant tr      : std_logic := px_boolean_to_std_logic(has_tready);
constant sig_set : std_logic_vector(31 downto 0) := ("0000000000000000000000001000001" & tr); 
--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Xilinx Core Code extracted to allow variable width
component px_axis_dwidth_upconv
generic (
     C_FAMILY : string := "kintexu";
     C_S_AXIS_TDATA_WIDTH : integer := (in_samples_per_cycle*bytes_per_sample*8);
     C_S_AXIS_TUSER_WIDTH : integer := 128;
     C_M_AXIS_TDATA_WIDTH : integer := (out_samples_per_cycle*bytes_per_sample*8);
     C_M_AXIS_TUSER_WIDTH : integer := ((out_samples_per_cycle/in_samples_per_cycle)*128);
     C_AXIS_SIGNAL_SET : std_logic_vector := sig_set
  ); 
port (
    aclk          : in std_logic;
    aresetn       : in std_logic;
    aclken        : in std_logic;
    s_axis_tvalid : in std_logic;
    s_axis_tid    : in std_logic_vector(0 downto 0);
    s_axis_tdest  : in std_logic_vector(0 downto 0);
    s_axis_tkeep  : in std_logic_vector(C_S_AXIS_TDATA_WIDTH/8-1 downto 0);
    s_axis_tstrb  : in std_logic_vector(C_S_AXIS_TDATA_WIDTH/8-1 downto 0); 
    s_axis_tready : out std_logic;
    s_axis_tdata  : in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
    s_axis_tlast  : in std_logic;
    s_axis_tuser  : in std_logic_vector(C_S_AXIS_TUSER_WIDTH-1 downto 0); 
    m_axis_tid    : out std_logic_vector(0 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in std_logic;
    m_axis_tdata  : out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
    m_axis_tlast  : out std_logic;
    m_axis_tkeep  : out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
    m_axis_tstrb  : out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
    m_axis_tdest  : out std_logic_vector(0 downto 0);
    m_axis_tuser  : out std_logic_vector(C_M_AXIS_TUSER_WIDTH-1 downto 0)
  );
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
signal wc_tuser : std_logic_vector(((out_samples_per_cycle/in_samples_per_cycle)*128)-1 downto 0); 
signal tkeep    : std_logic_vector((in_samples_per_cycle*bytes_per_sample)-1 downto 0);
signal wc_tkeep : std_logic_vector((out_samples_per_cycle*bytes_per_sample)-1 downto 0);
--------------------------------------------------------------------------------

begin

gen_cnv: if (out_samples_per_cycle > in_samples_per_cycle) generate
--------------------------------------------------------------------------------
-- Change the Timing signal bits and Samples/cycle info to the correct values 
--------------------------------------------------------------------------------

m_axis_pdti_tuser(92 downto 88) <= conv_std_logic_vector(out_samples_per_cycle,5);

gen_g12: if (in_samples_per_cycle = 1) and (out_samples_per_cycle = 2) generate
    m_axis_pdti_tuser(71 downto 64) <= "000000" & wc_tuser(192) & wc_tuser(64);
    m_axis_pdti_tuser(79 downto 72) <= "000000" & wc_tuser(200) & wc_tuser(72);
    m_axis_pdti_tuser(87 downto 80) <= "000000" & wc_tuser(208) & wc_tuser(80);
end generate;     
gen_g14: if (in_samples_per_cycle = 1) and (out_samples_per_cycle = 4) generate
    m_axis_pdti_tuser(71 downto 64) <= "0000" & wc_tuser(448) & wc_tuser(320) & wc_tuser(192) & wc_tuser(64);
    m_axis_pdti_tuser(79 downto 72) <= "0000" & wc_tuser(456) & wc_tuser(328) & wc_tuser(200) & wc_tuser(72);
    m_axis_pdti_tuser(87 downto 80) <= "0000" & wc_tuser(464) & wc_tuser(336) & wc_tuser(208) & wc_tuser(80);
end generate;   
gen_g18: if (in_samples_per_cycle = 1) and (out_samples_per_cycle = 8) generate
    m_axis_pdti_tuser(71 downto 64) <= wc_tuser(960) & wc_tuser(832) & wc_tuser(704) & wc_tuser(576) & wc_tuser(448) & wc_tuser(320) & wc_tuser(192) & wc_tuser(64);
    m_axis_pdti_tuser(79 downto 72) <= wc_tuser(968) & wc_tuser(840) & wc_tuser(712) & wc_tuser(584) & wc_tuser(456) & wc_tuser(328) & wc_tuser(200) & wc_tuser(72);
    m_axis_pdti_tuser(87 downto 80) <= wc_tuser(976) & wc_tuser(848) & wc_tuser(720) & wc_tuser(592) & wc_tuser(464) & wc_tuser(336) & wc_tuser(208) & wc_tuser(80);
end generate;  

gen_g24: if (in_samples_per_cycle = 2) and (out_samples_per_cycle = 4) generate
    m_axis_pdti_tuser(71 downto 64) <= "0000" & wc_tuser(193 downto 192) & wc_tuser(65 downto 64);
    m_axis_pdti_tuser(79 downto 72) <= "0000" & wc_tuser(201 downto 200) & wc_tuser(73 downto 72);
    m_axis_pdti_tuser(87 downto 80) <= "0000" & wc_tuser(209 downto 208) & wc_tuser(81 downto 80);
end generate;   
gen_g28: if (in_samples_per_cycle = 2) and (out_samples_per_cycle = 8) generate
    m_axis_pdti_tuser(71 downto 64) <= wc_tuser(449 downto 448) & wc_tuser(321 downto 320) &  wc_tuser(193 downto 192) & wc_tuser(65 downto 64);
    m_axis_pdti_tuser(79 downto 72) <= wc_tuser(457 downto 456) & wc_tuser(329 downto 328) &  wc_tuser(201 downto 200) & wc_tuser(73 downto 72);
    m_axis_pdti_tuser(87 downto 80) <= wc_tuser(465 downto 464) & wc_tuser(337 downto 336) &  wc_tuser(209 downto 208) & wc_tuser(81 downto 80);    
end generate;  

gen_g48: if (in_samples_per_cycle = 4) and (out_samples_per_cycle = 8) generate
    m_axis_pdti_tuser(71 downto 64) <= wc_tuser(195 downto 192) & wc_tuser(67 downto 64);
    m_axis_pdti_tuser(79 downto 72) <= wc_tuser(203 downto 200) & wc_tuser(75 downto 72);
    m_axis_pdti_tuser(87 downto 80) <= wc_tuser(211 downto 208) & wc_tuser(83 downto 80);
end generate;  

m_axis_pdti_tuser(63 downto 0)   <= wc_tuser(63 downto 0);
m_axis_pdti_tuser(127 downto 93) <= wc_tuser(127 downto 93);

--------------------------------------------------------------------------------

widthconv_inst: px_axis_dwidth_upconv
generic map (
     C_FAMILY => "kintexu",
     C_S_AXIS_TDATA_WIDTH => (in_samples_per_cycle*bytes_per_sample*8),
     C_M_AXIS_TDATA_WIDTH => (out_samples_per_cycle*bytes_per_sample*8),
     C_S_AXIS_TUSER_WIDTH => 128,
     C_M_AXIS_TUSER_WIDTH => ((out_samples_per_cycle/in_samples_per_cycle)*128),
     C_AXIS_SIGNAL_SET => sig_set
  ) 
port map (
    aclk          => axis_aclk,
    aresetn       => axis_aresetn,
    aclken        => '1',
    s_axis_tvalid => s_axis_pdti_tvalid,
    s_axis_tready => s_axis_pdti_tready,
    s_axis_tdata  => s_axis_pdti_tdata,
    s_axis_tlast  => '0',
    s_axis_tid    => "0", 
    s_axis_tkeep  => tkeep, 
    s_axis_tstrb  => tkeep,   
    s_axis_tdest  => "0", 
    s_axis_tuser  => s_axis_pdti_tuser,    
    m_axis_tvalid => m_axis_pdti_tvalid,
    m_axis_tready => m_axis_pdti_tready,
    m_axis_tdata  => m_axis_pdti_tdata,
    m_axis_tlast  => open,
    m_axis_tid    => open,
    m_axis_tkeep  => wc_tkeep,
    m_axis_tstrb  => open, 
    m_axis_tdest  => open,
    m_axis_tuser  => wc_tuser
  );
end generate;

-- Input and outputs are same size
gen_ncnv: if (out_samples_per_cycle = in_samples_per_cycle) generate

     m_axis_pdti_tdata     <= s_axis_pdti_tdata;
     m_axis_pdti_tuser     <= s_axis_pdti_tuser;
     m_axis_pdti_tvalid    <= s_axis_pdti_tvalid;
     s_axis_pdti_tready    <= m_axis_pdti_tready;  

end generate;

end Behavioral;
