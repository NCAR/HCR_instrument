----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 12/21/2016 09:45:40 AM
-- Design Name: 
-- Module Name: tb_px_axis_pdti_upsizer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Test bench for px+axis_pdti_upsizer 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_axis_pdti_upsizer is
generic (
    in_samples_per_cycle   : integer := 1;  -- Width of input data stream in samples -- 1,2,4 
    -- Output Width must be greater than input width
    out_samples_per_cycle  : integer := 2   -- Width of output data stream in samples - 2,4,8
);
end tb_px_axis_pdti_upsizer;

architecture Behavioral of tb_px_axis_pdti_upsizer is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_axis_pdti_upsizer
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
end component px_axis_pdti_upsizer;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
constant bytes_per_sample    : integer := 2; 
constant init_data           : std_logic_vector(63 downto 0):= x"0003000200010000";
signal axis_aclk             : std_logic := '0';
signal axis_aresetn          : std_logic := '0';
signal s_axis_pdti_tdata     : std_logic_vector(((in_samples_per_cycle*bytes_per_sample*8)-1) downto 0) := (others => '0');
signal s_axis_pdti_tuser     : std_logic_vector(127 downto 0) := (others => '0');
signal s_axis_pdti_tvalid    : std_logic := '0';
signal s_axis_pdti_tready    : std_logic := '0';
signal m_axis_pdti_tdata     : std_logic_vector(((out_samples_per_cycle*bytes_per_sample*8)-1) downto 0) := (others => '0');
signal m_axis_pdti_tuser     : std_logic_vector(127 downto 0) := (others => '0');
signal m_axis_pdti_tvalid    : std_logic := '0';
signal m_axis_pdti_tready    : std_logic := '0';   
signal cycle : integer := 0;
--------------------------------------------------------------------------------

begin

process
begin
    loop
        wait for 2 ns;
        axis_aclk <= not axis_aclk;
    end loop;
end process;

s_axis_pdti_tuser(92 downto 88) <= conv_std_logic_vector(in_samples_per_cycle,5);

process
begin
   wait for 100 ns;
   axis_aresetn <= '1';
   wait for 100 ns;
   s_axis_pdti_tdata <=  init_data ((s_axis_pdti_tdata'length)-1 downto 0);
   wait until rising_edge(axis_aclk);
   s_axis_pdti_tvalid <= '1';
   if (in_samples_per_cycle = 1) then
    loop
        wait until rising_edge(axis_aclk);
        cycle <= cycle + 1;
        s_axis_pdti_tdata <= s_axis_pdti_tdata + 1;
        if (cycle > 32) then 
            s_axis_pdti_tuser(64) <= '1';
        else
            s_axis_pdti_tuser(64) <= '0';
        end if;     
    end loop;
   end if;
   if (in_samples_per_cycle = 2) then
    loop
        wait until rising_edge(axis_aclk);
        cycle <= cycle + 1;
        s_axis_pdti_tdata <=  s_axis_pdti_tdata + x"00020002";
        if (cycle > 32) then 
            s_axis_pdti_tuser(65 downto 64) <= "11";
        else
            s_axis_pdti_tuser(65 downto 64) <= "00";
        end if;  
    end loop;
   end if;   
   if (in_samples_per_cycle = 4) then
    loop
        wait until rising_edge(axis_aclk);
        cycle <= cycle + 1;
        s_axis_pdti_tdata <=  s_axis_pdti_tdata + x"0004000400040004";
        if (cycle > 32) then 
            s_axis_pdti_tuser(67 downto 64) <= "1111";
        else
            s_axis_pdti_tuser(67 downto 64) <= "0000";
        end if;  
    end loop;
   end if;  
   wait;
end process;

uut: px_axis_pdti_upsizer
generic map (
    bytes_per_sample       => 2, --  1,2, or 4
    in_samples_per_cycle   => in_samples_per_cycle,  -- Width of input data stream in samples -- 1,2,4 
    -- Output Width must be greater than input width
    out_samples_per_cycle  => out_samples_per_cycle,   -- Width of output data stream in samples - 2,4,8
    has_tready             => false 
)
port map (
     axis_aclk           => axis_aclk,    
     axis_aresetn        => axis_aresetn,  
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
     s_axis_pdti_tdata     => s_axis_pdti_tdata,  
     s_axis_pdti_tuser     => s_axis_pdti_tuser,  
     s_axis_pdti_tvalid    => s_axis_pdti_tvalid, 
     s_axis_pdti_tready    => open, 
     ----------------------------------------------------------------------------
     -- Output
     ----------------------------------------------------------------------------
     m_axis_pdti_tdata     => m_axis_pdti_tdata,  
     m_axis_pdti_tuser     => m_axis_pdti_tuser,  
     m_axis_pdti_tvalid    => m_axis_pdti_tvalid, 
     m_axis_pdti_tready    => '1'
     );

end Behavioral;
