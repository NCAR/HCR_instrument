----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2016 10:53:43 AM
-- Design Name: 
-- Module Name: tb_px_axis_mixer_1 - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.numeric_std.ALL;
use work.px_utility_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_axis_mixer_2 is
generic(
   out_res : integer := 16; -- Output Resolution (16 or 24 only) 
   sub_chan: boolean := false; -- Substitute new channel number in user data 
   chan: integer := 0; -- Channel number to substitute when sub_chan = true 0-255  
   bypass : boolean := false 
);
end tb_px_axis_mixer_2;

architecture Behavioral of tb_px_axis_mixer_2 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
component px_axis_mixer_2 
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
   -- Single Sample per cycle
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
   s_axis_pdti_tdata  : in  std_logic_vector(31 downto 0);  
   s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
   s_axis_pdti_tvalid : in  std_logic;
   -----------------------------------------------------------------------------
   -- NCO Input 18-bit
   -----------------------------------------------------------------------------
   s_axis_nco_tdata   : in  std_logic_vector(95 downto 0);  -- 17:0 = I, 41:24 = Q 
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
   m_axis_pdti_tdata  : out std_logic_vector((2*2*out_res)-1 downto 0);  
   m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
   m_axis_pdti_tvalid : out std_logic
);
end component px_axis_mixer_48;

COMPONENT tb_mixer_dds
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_phase_tvalid : IN STD_LOGIC;
    s_axis_phase_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

----------------------------------------------------------------------------
-- AXI4-Lite Control/Status Interface
----------------------------------------------------------------------------
signal s_axi_csr_aclk      : std_logic := '0';
signal s_axi_csr_aresetn   : std_logic := '0';
signal s_axi_csr_awaddr    : std_logic_vector(6 downto 0) := (others => '0');
signal s_axi_csr_awprot    : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_awvalid   : std_logic := '0';
signal s_axi_csr_awready   : std_logic := '0';
signal s_axi_csr_wdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_wstrb     : std_logic_vector(3 downto 0) := (others => '0');
signal s_axi_csr_wvalid    : std_logic := '0';
signal s_axi_csr_wready    : std_logic := '0';
signal s_axi_csr_bresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_bvalid    : std_logic := '0';
signal s_axi_csr_bready    : std_logic := '0';
signal s_axi_csr_araddr    : std_logic_vector(6 downto 0) := (others => '0');
signal s_axi_csr_arprot    : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_arvalid   : std_logic := '0';
signal s_axi_csr_arready   : std_logic := '0';
signal s_axi_csr_rdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid    : std_logic := '0';
signal s_axi_csr_rready    : std_logic := '0';

-----------------------------------------------------------------------------
-- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
-----------------------------------------------------------------------------
signal aclk                : std_logic := '0';
signal aresetn             : std_logic := '0';
-- tuser[63:0]    = timestamp[63:0]
-- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
-- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
-- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
-- tuser[92:88]   = Samples/Cycle
-- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
-- tuser[95]      = Data Type 0 = Real 1 = I/Q
-- tuser[103:96]  = channel[7:0] 
-- tuser[127:104] = Reserved 
-- tdata[15:0]    = real = Real , IQ = I
-- tdata[31:16]   = real = Duplicate Real or 0 , IQ = Q
signal s_axis_pdti_tdata  : std_logic_vector(31 downto 0) := x"80008000";  
signal s_axis_pdti_tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal s_axis_pdti_tvalid : std_logic := '1';
 -----------------------------------------------------------------------------
-- NCO Input 18-bit
-----------------------------------------------------------------------------
signal s_axis_nco_tdata   : std_logic_vector(95 downto 0);  -- 17:0 = I, 41:24 = Q 
signal s_axis_nco_tdata_a : std_logic_vector(47 downto 0);  -- 17:0 = I, 41:24 = Q 
signal s_axis_nco_tvalid  : std_logic; -- not used. It is assumed that the NCO and data stream input
-----------------------------------------------------------------------------
-- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
-----------------------------------------------------------------------------
-- tuser[63:0]    = timestamp[63:0]
-- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
-- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
-- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
-- tuser[92:88]   = Samples/Cycle
-- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
-- tuser[95]      = Data Type 0 = Real 1 = I/Q
-- tuser[103:96]  = channel[7:0] 
-- tuser[127:104] = Reserved 
-- tdata[15:0]    = real = Real , IQ = I
-- tdata[31:16]   = real = Duplicate Real or 0 , IQ = Q
signal m_axis_pdti_tdata  : std_logic_vector((2*2*out_res)-1 downto 0) := (others => '0');  
signal m_axis_pdti_tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal m_axis_pdti_tvalid : std_logic := '0';

--------------------------------------------------------------------------------

begin

-- generate clocks
process
begin
   loop
      aclk <= not aclk;
      wait for 5 ns;
   end loop;
end process;

process
begin
   loop
      s_axi_csr_aclk <= not s_axi_csr_aclk;
      wait for 2 ns;
   end loop;
end process;

uut: px_axis_mixer_2 
generic map (
   out_res => out_res, -- Output Resolution (16 or 24 only) 
   sub_chan => sub_chan, -- Substitute new channel number in user data 
   chan => chan-- Channel number to substitute when sub_chan = true 0-255   
)
Port map( 
   ---------------------------------------------------------------------------
   -- AXI4-Lite Control/Status Interface
   ----------------------------------------------------------------------------
   s_axi_csr_aclk      => s_axi_csr_aclk,      
   s_axi_csr_aresetn   => s_axi_csr_aresetn,   
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
   -----------------------------------------------------------------------------
   -- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- Requires 16-bit data streams
   -- Single Sample per cycle
   aclk                => aclk,   
   aresetn             => aresetn,
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
   s_axis_pdti_tdata  => s_axis_pdti_tdata, 
   s_axis_pdti_tuser  => s_axis_pdti_tuser, 
   s_axis_pdti_tvalid => s_axis_pdti_tvalid,
   -----------------------------------------------------------------------------
   -- NCO Input 18-bit
   -----------------------------------------------------------------------------
   s_axis_nco_tdata   => s_axis_nco_tdata, 
   s_axis_nco_tvalid  => s_axis_nco_tvalid,
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
   -- tuser[127:105] = Reserved  
   m_axis_pdti_tdata   => m_axis_pdti_tdata,  
   m_axis_pdti_tuser   => m_axis_pdti_tuser,  
   m_axis_pdti_tvalid  => m_axis_pdti_tvalid 
);

nco_inst : tb_mixer_dds
  PORT MAP (
    aclk => aclk,
    aresetn => aresetn,
    s_axis_phase_tvalid => s_axis_pdti_tvalid,
    s_axis_phase_tdata  => x"01000000",
    m_axis_data_tvalid  => s_axis_nco_tvalid,
    m_axis_data_tdata   => s_axis_nco_tdata_a
  );
  
s_axis_nco_tdata <=  s_axis_nco_tdata_a & s_axis_nco_tdata_a; 

test_process: process
variable c_time : time    := 0 ns;
variable d_time : time    := 0 ns;
variable dat      : std_logic_vector(31 downto 0) := x"00000000";
begin
   wait for 100 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   aresetn <= '1';
   wait for 40 ns;
   c_time := now;
   -----------------------------------------------------------------------------
   -- Set up Control Registers
   -----------------------------------------------------------------------------
   if (bypass = true) then
      dat := x"00000000";
   else
      dat := x"00000001";
   end if;
      assert false
      report "Writing to Control Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer("0000000",dat, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Control Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 
   wait for 10 us;
   assert false
   report "Test Complete, Not A Failure." 
   severity FAILURE;
end process;   


end Behavioral;
