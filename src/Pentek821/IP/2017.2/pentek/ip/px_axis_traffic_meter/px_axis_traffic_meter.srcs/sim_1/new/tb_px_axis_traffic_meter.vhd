----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2015 10:40:46 AM
-- Design Name: 
-- Module Name: tb_px_axis_traffic_meter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

use work.px_utility_pkg.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_axis_traffic_meter is
generic (
    init_clk_freq    : integer := 1000; -- integer in Hz
    div_factor       : integer := 1; -- 1,2, or 4. Divide result by this factor to stay in 32-bit word. Use when rate can be >= 4GBps. Then multiply by the factor to get the full result. 
    num_bytes        : integer := 4 -- Number of bytes in tdata
);
end tb_px_axis_traffic_meter;

architecture Behavioral of tb_px_axis_traffic_meter is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_axis_traffic_meter
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
end component px_axis_traffic_meter;


--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal axis_aclk          : std_logic := '0';
signal axis_aresetn       : std_logic := '0';
signal s_axis_tdata       : std_logic_vector((num_bytes*8)-1 downto 0):= (others => '0');
signal s_axis_tuser       : std_logic_vector(31 downto 0):= (others => '0');
signal s_axis_tvalid      : std_logic := '0';
signal s_axis_tready      : std_logic := '0';
signal s_axis_tlast       : std_logic := '0';
signal s_axis_tkeep       : std_logic_vector(num_bytes-1 downto 0):= (others => '0');
signal m_axis_tdata       : std_logic_vector((num_bytes*8)-1 downto 0):= (others => '0');
signal m_axis_tuser       : std_logic_vector(31 downto 0):= (others => '0');
signal m_axis_tvalid      : std_logic := '0';
signal m_axis_tready      : std_logic := '0';
signal m_axis_tlast       : std_logic := '0';
signal m_axis_tkeep       : std_logic_vector(num_bytes-1 downto 0):= (others => '0');
signal s_axi_csr_aclk     : std_logic := '0';
signal s_axi_csr_aresetn  : std_logic := '0';
signal s_axi_csr_awaddr   : std_logic_vector(6 downto 0):= (others => '0');
signal s_axi_csr_awprot   : std_logic_vector(2 downto 0):= (others => '0');
signal s_axi_csr_awvalid  : std_logic := '0';
signal s_axi_csr_awready  : std_logic := '0';
signal s_axi_csr_wdata    : std_logic_vector(31 downto 0):= (others => '0');
signal s_axi_csr_wstrb    : std_logic_vector(3 downto 0):= (others => '0');
signal s_axi_csr_wvalid   : std_logic := '0';
signal s_axi_csr_wready   : std_logic := '0';
signal s_axi_csr_bresp    : std_logic_vector(1 downto 0):= (others => '0');
signal s_axi_csr_bvalid   : std_logic := '0';
signal s_axi_csr_bready   : std_logic := '0';
signal s_axi_csr_araddr   : std_logic_vector(6 downto 0):= (others => '0');
signal s_axi_csr_arprot   : std_logic_vector(2 downto 0):= (others => '0');
signal s_axi_csr_arvalid  : std_logic := '0';
signal s_axi_csr_arready  : std_logic := '0';
signal s_axi_csr_rdata    : std_logic_vector(31 downto 0):= (others => '0');
signal s_axi_csr_rresp    : std_logic_vector(1 downto 0):= (others => '0');
signal s_axi_csr_rvalid   : std_logic := '0';
signal s_axi_csr_rready   : std_logic := '0';

    
type   chars is array (integer range 0 to 9) of character;
constant to_character: chars := ( 0 => '0', 1=> '1', 2=> '2',  3 => '3', 4 => '4',
				  5=> '5', 6=> '6', 7 => '7', 8 => '8', 9 => '9');


function convert_string(in_int: integer) return string is
variable x: integer;
variable temp: integer range 0 to 9;
variable out_string :string(1 to 6);
variable ln: integer:= 0;
begin
	out_string := "      ";
	x:= in_int;
	if (x > 99999) then
		temp := (x/100000);
		out_string := to_character(temp) & "     ";
		x := x - (temp*100000);
		ln := 1;	
	end if;
	if (x > 9999) then
		temp := (x/10000);
		out_string := out_string(1) & to_character(temp) & "    ";
		x := x - (temp*10000);
		ln:= 1;
	elsif (ln= 1) then
		out_string := out_string(1) & "0    ";
	end if;
	if (x > 999) then
		temp := (x/1000);
		out_string := out_string(1 to 2) & to_character(temp) & "   ";
		x := x - (temp*1000);
		ln:= 1;
	elsif (ln= 1) then
		out_string := out_string(1 to 2) & "0   ";	
	end if;
	if (x > 99) then
		temp := (x/100);
		out_string := out_string(1 to 3) & to_character(temp) & "  ";
		x := x - (temp*100);
		ln:= 1;
	elsif (ln= 1) then
		out_string := out_string(1 to 3) & "0  ";
	end if;
	if (x > 9) then
		temp := (x/10);
		out_string := out_string(1 to 4) & to_character(temp) & " ";
		x := x - (temp*10);
		ln:= 1;
	elsif (ln= 1) then
		out_string := out_string(1 to 4) & "0 ";
	end if;
		temp := x;
		out_string := out_string(1 to 5) & to_character(temp);
		
	return out_string;	
end;

begin



uut: px_axis_traffic_meter
generic map(
    init_clk_freq    => init_clk_freq, -- integer in Hz
    div_factor      => div_factor, -- 1,2, or 4. Divide result by this factor to stay in 32-bit word. Use when rate can be >= 4GBps. Then multiply by the factor to get the full result. 
    num_bytes        => num_bytes, -- Number of bytes in tdata
    has_tkeep        => true,
    has_tready       => true,
    has_tuser        => true,
    has_tlast        => true,
    tuser_size       => 32 -- number of tuser bits
)
port map ( 
    ----------------------------------------------------------------------------
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
    ----------------------------------------------------------------------------
    -- AXI-S Slave Input
    ----------------------------------------------------------------------------
    axis_aclk           => axis_aclk,   
    axis_aresetn        => axis_aresetn,

    s_axis_tdata        => s_axis_tdata,  
    s_axis_tuser        => s_axis_tuser,  
    s_axis_tvalid       => s_axis_tvalid, 
    s_axis_tready       => s_axis_tready,
    s_axis_tkeep        => s_axis_tkeep,
    s_axis_tlast        => s_axis_tlast,
    ----------------------------------------------------------------------------
    -- AXI-S Master Input
    ----------------------------------------------------------------------------
    m_axis_tdata        => m_axis_tdata,  
    m_axis_tuser        => m_axis_tuser,  
    m_axis_tvalid       => m_axis_tvalid, 
    m_axis_tready       => m_axis_tready,
    m_axis_tkeep        => m_axis_tkeep,
    m_axis_tlast        => m_axis_tlast
);

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        s_axis_tvalid <= not s_axis_tvalid;
    end if; 
end process;

m_axis_tready <= '1';
s_axis_tuser  <= (others => '0');
s_axis_tlast  <= '0';
s_axis_tkeep  <= (others => '1');

-- For the purpose of the test bench we will not vary the clock period with the generic clock rate value.
process
begin
    loop
        wait for 2.5 ns;
        axis_aclk <= not axis_aclk;
    end loop;    
end process;

process
begin
    loop
        wait for 2.0 ns;
        s_axi_csr_aclk <= not s_axi_csr_aclk;
    end loop;    
end process;

stim_proc: process
begin
    wait for 400 ns;
    wait until rising_edge(s_axi_csr_aclk);
    s_axi_csr_aresetn <= '1';
    axis_aresetn    <= '1';
    wait until rising_edge(s_axi_csr_aclk);
    wait until rising_edge(s_axi_csr_aclk);
    wait until rising_edge(s_axi_csr_aclk);
    wait until rising_edge(s_axi_csr_aclk);
    for i in 0 to init_clk_freq-1 loop
       wait until rising_edge(axis_aclk);
    end loop;    
    wait for 200 ns;
    px_axi_lite_reader("0000100",x"00000000",'0', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
    assert false
    report "AXI-S Traffic Rate = " & convert_string(conv_integer(s_axi_csr_rdata)*div_factor) & " Bytes per Second." 
    severity NOTE;
    wait for 200 ns;
    assert false
    report "Not a Failure, Test Complete."
    severity FAILURE; 
wait;
end process;


end Behavioral;
