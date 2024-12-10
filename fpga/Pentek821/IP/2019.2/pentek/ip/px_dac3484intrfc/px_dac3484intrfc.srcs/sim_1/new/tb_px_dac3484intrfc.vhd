----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/10/2019 09:12:56 AM
-- Design Name: 
-- Module Name: tb_px_dac3484intrfc - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

Library xpm;
use xpm.vcomponents.all;


entity tb_px_dac3484intrfc is
--  Port ( );
end tb_px_dac3484intrfc;

architecture Behavioral of tb_px_dac3484intrfc is

constant dac_clk_in_period        : time := 3.2 ns;
constant dac_axis_aclk_period     : time := dac_clk_in_period*2;


-- Only two modes
-- "000" Real mode
-- "001" I/Q Mode
signal dac_mode           : std_logic_vector(2 downto 0)   := "000";

signal dac_clk_in         : std_logic := '0';
signal axis_aresetn       : std_logic := '0';
signal dac_axis_aclk      : std_logic := '0';

signal s_dac_axis_aresetn : std_logic := '0';


signal s_dac0_axis_tvalid : std_logic := '0';
signal s_dac0_axis_tdata  : std_logic_vector(31 downto 0)  := X"00020001";
signal s_dac0_axis_tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal s_dac1_axis_tvalid : std_logic := '0';
signal s_dac1_axis_tdata  : std_logic_vector(31 downto 0)  := X"80028001";
signal s_dac1_axis_tuser  : std_logic_vector(127 downto 0) := (others => '0');

signal m_dac0_axis_tvalid : std_logic := '0';
signal m_dac0_axis_tdata  : std_logic_vector(31 downto 0)  := (others => '0');
signal m_dac0_axis_tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal m_dac1_axis_tvalid : std_logic := '0';
signal m_dac1_axis_tdata  : std_logic_vector(31 downto 0)  := (others => '0');
signal m_dac1_axis_tuser  : std_logic_vector(127 downto 0) := (others => '0');
 
signal dac_data_out       : std_logic_vector(63 downto 0)  := (others => '0');
signal dac_sync_out       : std_logic := '0'; 

signal serdes_rst         : std_logic := '1';
signal serdes_rst_reg1    : std_logic := '1';
signal serdes_rst_reg2    : std_logic := '1';

signal start              : std_logic := '0';
signal start_reg1         : std_logic := '0';
signal start_reg2         : std_logic := '0';
signal start_reg3         : std_logic := '0';

signal dac_serdes_int_rst : std_logic := '0';

signal sync_tap_delay           : std_logic_vector(8 downto 0) := "000000000";    
signal sync_tap_delay_ld        : std_logic := '0';
signal ostrb_tap_delay          : std_logic_vector(8 downto 0) := "000000000";
signal ostrb_tap_delay_ld       : std_logic := '0';

signal DAC_DATA_P      : std_logic_vector(15 downto 0); -- DAC Data +
signal DAC_DATA_N      : std_logic_vector(15 downto 0); -- DAC Data -
signal DAC_DCLK_P      : std_logic;
signal DAC_DCLK_N      : std_logic;
  
signal DAC_FRAME_P   : std_logic;
signal DAC_FRAME_N   : std_logic;
signal DAC_PARITY_P  : std_logic;
signal DAC_PARITY_N  : std_logic;
signal DAC_OSTR_P    : std_logic;
signal DAC_OSTR_N    : std_logic;
     

signal DAC_SYNC_P    : std_logic; -- DAC Sync +
signal DAC_SYNC_N    : std_logic; -- DAC Sync -
signal DAC_RESET_N   : std_logic;  -- Reset to the DAC    

COMPONENT tb_fifo
  PORT (
    s_axis_aresetn : IN STD_LOGIC;
    s_axis_aclk : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;


component px_dac3484_packer 
Port (

-- Dac Packer Interface
    s_dac_axis_aclk    : in std_logic;
    s_dac0_axis_tvalid : in std_logic;
    s_dac0_axis_tdata  : in std_logic_vector(31 downto 0);
    s_dac0_axis_tuser  : in std_logic_vector(127 downto 0);
    
    s_dac1_axis_tvalid : in std_logic;
    s_dac1_axis_tdata  : in std_logic_vector(31 downto 0);
    s_dac1_axis_tuser  : in std_logic_vector(127 downto 0);
    
    dac_mode           : in std_logic_vector(2 downto 0);
    
    dac_data_out       : out std_logic_vector(63 downto 0);
    dac_sync_out       : out std_logic
    
);
end component;

component px_dac3484_serdes
generic (

    initial_sync_tap_delay    : integer := 0;
    initial_ostrb_tap_delay   : integer := 0;
    
    idelaycntrl_refclk_freq   : integer := 200; -- in MHz
    iodelay_grp               : string := "IODELAY_GRP"

);
Port ( 

    DAC_CLK_IN     : in  std_logic;
    s_dac_axis_aclk : in std_logic;
    s_dac_axis_aresetn : in  std_logic;
    DAC_DATA_A_IN  : in  std_logic_vector (63 downto 0);
    dac_reseta_n_in : in  std_logic;
    dac_sync_in    : in  std_logic;
    dac_serdes_int_rst : in std_logic;
    DAC_CLK        : out std_logic;
    
    sync_tap_delay           : in std_logic_vector(8 downto 0);    
    sync_tap_delay_ld        : in std_logic;
    ostrb_tap_delay          : in std_logic_vector(8 downto 0);
    ostrb_tap_delay_ld       : in std_logic; 
    
    dac_ostr       : out std_logic;
    -- Data to the 3484
    DAC_DATA_P      : out std_logic_vector(15 downto 0); -- DAC Data +
    DAC_DATA_N      : out std_logic_vector(15 downto 0); -- DAC Data -
    DAC_DCLK_P      : out std_logic;
    DAC_DCLK_N      : out std_logic;
     
    DAC_FRAME_P   : out std_logic;
    DAC_FRAME_N   : out std_logic;
    DAC_PARITY_P  : out std_logic;
    DAC_PARITY_N  : out std_logic;
    DAC_OSTR_P       : out std_logic;
    DAC_OSTR_N       : out std_logic;
        
    -- DAC Control/Status Signals
    DAC_SYNC_P    : out std_logic; -- DAC Sync +
    DAC_SYNC_N    : out std_logic; -- DAC Sync -
    DAC_RESET_N   : out std_logic  -- Reset to the DAC    



);
end component;

begin

s_dac_axis_aresetn   <= '1' after 200 ns;

dac_clk_in      <= not dac_clk_in after dac_clk_in_period/2;

process(dac_clk_in) begin
    if(rising_edge(dac_clk_in)) then
        dac_axis_aclk <= not dac_axis_aclk;
    end if;
end process;
axis_aresetn  <= '1' after 1 us;
serdes_rst    <= '0' after 5 us;      

start <= '1' after 10.0 us;

process(dac_axis_aclk) begin
                          
    if(rising_edge(dac_axis_aclk)) then
    
        serdes_rst_reg1    <= serdes_rst;
        serdes_rst_reg2    <= serdes_rst_reg1;
        dac_serdes_int_rst <= not serdes_rst_reg1 and serdes_rst_reg2;
        
    
        start_reg1 <= start;
        start_reg2 <= start_reg1;
        start_reg3 <= start_reg2;
    
        if(start = '1') then
            
            case dac_mode is
            
            when "000" =>
                s_dac0_axis_tvalid    <= not s_dac0_axis_tvalid;
                s_dac0_axis_tuser(64) <= '1';
                
                if(s_dac0_axis_tvalid = '1') then
                     s_dac0_axis_tdata(15 downto 0)  <= s_dac0_axis_tdata(15 downto 0)  + 2;
                     s_dac0_axis_tdata(31 downto 16) <= s_dac0_axis_tdata(31 downto 16) + 2;
                     
                end if;
                
                s_dac1_axis_tvalid    <= not s_dac1_axis_tvalid;
                s_dac1_axis_tuser(64) <= '1';
                
                if(s_dac1_axis_tvalid = '1') then
                     s_dac1_axis_tdata(15 downto 0)  <= s_dac1_axis_tdata(15 downto 0)  + 2;
                     s_dac1_axis_tdata(31 downto 16) <= s_dac1_axis_tdata(31 downto 16) + 2;
                     
                end if;
            
            when "001" =>
                s_dac0_axis_tvalid    <= '1';
                s_dac0_axis_tuser(64) <= '1';
                
                if(s_dac0_axis_tvalid = '1') then
                     s_dac0_axis_tdata(15 downto 0)  <= s_dac0_axis_tdata(15 downto 0)  + 2;
                     s_dac0_axis_tdata(31 downto 16) <= s_dac0_axis_tdata(31 downto 16) + 2;
                     
                end if;
                
                s_dac1_axis_tvalid    <= '1';
                s_dac1_axis_tuser(64) <= '1';
                
                if(s_dac1_axis_tvalid = '1') then
                     s_dac1_axis_tdata(15 downto 0)  <= s_dac1_axis_tdata(15 downto 0)  + 2;
                     s_dac1_axis_tdata(31 downto 16) <= s_dac1_axis_tdata(31 downto 16) + 2;
                     
                end if;
            
            when others => 
                
            end case;
            
            
        end if;
    end if;

end process;


tb_fifo_inst_chan0: tb_fifo
  PORT MAP
  (
    s_axis_aresetn => axis_aresetn, 
    s_axis_aclk    => dac_axis_aclk,
    s_axis_tvalid  => s_dac0_axis_tvalid,
    s_axis_tready  => open, 
    s_axis_tdata   => s_dac0_axis_tdata,
    s_axis_tuser   => s_dac0_axis_tuser,
    m_axis_tvalid  => m_dac0_axis_tvalid,
    m_axis_tready  => '1',
    m_axis_tdata   => m_dac0_axis_tdata,
    m_axis_tuser   => m_dac0_axis_tuser
  );
  
tb_fifo_inst_chan1: tb_fifo
  PORT MAP
  (
    s_axis_aresetn => axis_aresetn, 
    s_axis_aclk    => dac_axis_aclk,
    s_axis_tvalid  => s_dac1_axis_tvalid,
    s_axis_tready  => open,              
    s_axis_tdata   => s_dac1_axis_tdata,
    s_axis_tuser   => s_dac1_axis_tuser,
    m_axis_tvalid  => m_dac1_axis_tvalid,
    m_axis_tready  => '1',
    m_axis_tdata   => m_dac1_axis_tdata,
    m_axis_tuser   => m_dac1_axis_tuser
  );


dut: px_dac3484_packer 
Port map
(

-- Dac Packer Interface
    s_dac_axis_aclk    => dac_axis_aclk,    
    s_dac0_axis_tvalid => m_dac0_axis_tvalid, 
    s_dac0_axis_tdata  => m_dac0_axis_tdata,  
    s_dac0_axis_tuser  => m_dac0_axis_tuser,  
                        
    s_dac1_axis_tvalid => m_dac1_axis_tvalid, 
    s_dac1_axis_tdata  => m_dac1_axis_tdata,  
    s_dac1_axis_tuser  => m_dac1_axis_tuser,  
                        
    dac_mode           => dac_mode,           
                        
    dac_data_out       => dac_data_out,       
    dac_sync_out       => dac_sync_out       
    
);


sync_tap_delay_ld <= '1' after 1000 ns;

dut2: px_dac3484_serdes
generic map (

    initial_sync_tap_delay    => 0,
    initial_ostrb_tap_delay   => 0,
    
    idelaycntrl_refclk_freq   => 200,
    iodelay_grp               => "IODELAY_GRP"

) 
Port map
( 

    DAC_CLK_IN         => dac_clk_in,
    s_dac_axis_aclk    => dac_axis_aclk,
    s_dac_axis_aresetn => s_dac_axis_aresetn,
    DAC_DATA_A_IN      => dac_data_out,
    dac_reseta_n_in    => '1',    
    dac_sync_in        => dac_sync_out,
    dac_serdes_int_rst => dac_serdes_int_rst,
    DAC_CLK            => open,
    
    sync_tap_delay      => sync_tap_delay     ,  
    sync_tap_delay_ld   => sync_tap_delay_ld  ,
    ostrb_tap_delay     => ostrb_tap_delay    ,
    ostrb_tap_delay_ld  => ostrb_tap_delay_ld ,
    
    dac_ostr           => open,
    -- Data to the 3484
    DAC_DATA_P         => DAC_DATA_P ,
    DAC_DATA_N         => DAC_DATA_N ,
    DAC_DCLK_P         => DAC_DCLK_P ,
    DAC_DCLK_N         => DAC_DCLK_N ,
     
    DAC_FRAME_P       => DAC_FRAME_P  ,
    DAC_FRAME_N       => DAC_FRAME_N  ,
    DAC_PARITY_P      => DAC_PARITY_P ,
    DAC_PARITY_N      => DAC_PARITY_N ,
    DAC_OSTR_P        => DAC_OSTR_P   ,
    DAC_OSTR_N        => DAC_OSTR_N   ,
        
    -- DAC Control/Status Signals
    DAC_SYNC_P        => DAC_SYNC_P ,
    DAC_SYNC_N        => DAC_SYNC_N ,
    DAC_RESET_N       => DAC_RESET_N



);






end Behavioral;
