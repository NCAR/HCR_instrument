----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2016 10:44:38 AM
-- Design Name: 
-- Module Name: tb_px_axis_saturate - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_axis_saturate is
generic (
   has_tready     : boolean := true; -- When false, m_axis_tready has no effect (always ready)
   has_sat_out    : boolean := false
);
end tb_px_axis_saturate;

architecture Behavioral of tb_px_axis_saturate is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_axis_saturate 
generic (
   in_data_width  : integer := 24;
   out_data_width : integer := 16;
   has_tready     : boolean := false; -- When false, m_axis_tready has no effect (always ready)
   has_tuser      : boolean := false; -- Has tuser streams
   tuser_width    : integer := 1;     -- Number of bits in tuser  
   has_sat_out    : boolean := false
);
port ( 
   axis_aclk      : in  std_logic;                                   
   axis_aresetn   : in  std_logic; 
   -----------------------------------------------------------------------------
   -- Input AXI-S Slave
   -----------------------------------------------------------------------------                                  
   s_axis_tdata   : in  std_logic_vector (in_data_width-1 downto 0); 
   s_axis_tuser   : in  std_logic_vector (tuser_width-1 downto 0);
   s_axis_tvalid  : in  std_logic;
   s_axis_tready  : out std_logic;                                   
   -----------------------------------------------------------------------------
   -- Output AXI-S Master
   -----------------------------------------------------------------------------
   m_axis_tdata   : out std_logic_vector (out_data_width-1 downto 0);
   m_axis_tuser   : out std_logic_vector (tuser_width-1 downto 0); 
   m_axis_tvalid  : out std_logic;
   m_axis_tready  : in  std_logic;
   -----------------------------------------------------------------------------
   sat_out        : out std_logic                                    
);
end component;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type stim_array is array (0 to 7) of std_logic_vector(23 downto 0);

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant stim : stim_array := (
x"002000",
x"004000",
x"006000",
x"008000",
x"008100",
x"010000",
x"020000",
x"030000"
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal axis_aclk      : std_logic := '0';                                   
signal axis_aresetn   : std_logic := '0'; 
                          
signal s_axis_tdata   : std_logic_vector (23 downto 0) := (others => '0');
signal s_axis_tuser   : std_logic_vector (0 downto 0):= (others => '0');   
signal s_axis_tvalid  : std_logic := '0';
signal s_axis_tready  : std_logic := '0';                                   

signal m_axis_tdata   : std_logic_vector (15 downto 0) := (others => '0');
signal m_axis_tuser   : std_logic_vector (0 downto 0) := (others => '0');
signal m_axis_tvalid  : std_logic := '0';
signal m_axis_tready  : std_logic := '0';

signal sat_out        : std_logic := '0';   

signal t1_m_axis_tvalid  : std_logic := '0';
signal t2_m_axis_tvalid  : std_logic := '0';
signal t3_m_axis_tvalid  : std_logic := '0';                                 

--------------------------------------------------------------------------------

begin

uut:  px_axis_saturate
generic map (
   in_data_width  => 24, 
   out_data_width => 16,    
   has_tready     => has_tready,    
   has_tuser      => false,     
   tuser_width    => 1, 
   has_sat_out    => has_sat_out   
)
port map ( 
   axis_aclk      => axis_aclk,                                
   axis_aresetn   => axis_aresetn,
   -----------------------------------------------------------------------------
   -- Input AXI-S Slave
   -----------------------------------------------------------------------------                                  
   s_axis_tdata   => s_axis_tdata,
   s_axis_tuser   => s_axis_tuser,
   s_axis_tvalid  => s_axis_tvalid,
   s_axis_tready  => s_axis_tready,
   -----------------------------------------------------------------------------
   -- Output AXI-S Master
   -----------------------------------------------------------------------------
   m_axis_tdata   => m_axis_tdata,  
   m_axis_tuser   => m_axis_tuser, 
   m_axis_tvalid  => m_axis_tvalid, 
   m_axis_tready  => m_axis_tready, 
   -----------------------------------------------------------------------------
   sat_out        => sat_out                                
);

-- Generate Clock
process
begin
   loop
      wait for 2 ns;
      axis_aclk <= not axis_aclk;
   end loop;
end process;

process
begin
   wait for 100 ns;
   wait until rising_edge(axis_aclk);
   axis_aresetn <= '1';
   wait until rising_edge(axis_aclk);
   wait until rising_edge(axis_aclk);
   wait for 1 ns;
   for i in 0 to 7 loop
      while s_axis_tready = '0' loop
         wait until rising_edge(axis_aclk);
         wait for 1 ns;
      end loop;
         s_axis_tdata  <= stim(i);
         s_axis_tvalid <= '1';
      wait until rising_edge(axis_aclk);
      wait for 1 ns;
   end loop;
   s_axis_tvalid <= '0';   
   wait;    
end process;

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      t1_m_axis_tvalid  <= m_axis_tvalid;
      t2_m_axis_tvalid  <= t1_m_axis_tvalid;
      t3_m_axis_tvalid  <= t2_m_axis_tvalid;
      m_axis_tready     <= t3_m_axis_tvalid;
   end if;
end process;
end Behavioral;
