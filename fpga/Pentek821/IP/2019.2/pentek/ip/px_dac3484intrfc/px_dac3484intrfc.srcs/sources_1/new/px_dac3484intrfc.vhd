----------------------------------------------------------------------------------
-- Company: Pentek, Inc 
-- Engineer: G.L.
-- 
-- Create Date: 09/09/2019 01:58:20 PM
-- Design Name: px_dac3484intrfc
-- Module Name: px_dac3484intrfc - Behavioral
-- Project Name:  
-- Target Devices: Kintex Ultra Scale 
-- Tool Versions: 2019.1
-- Description: This module interfaces to the Texas Instrument Digital to Analog
-- Device
-- 
-- Dependencies: Requires OSERDESE3 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revisoin 1.00 - 10/9/20 - Added TAP delay capability on DAC SYNC and OSTR
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

Library xpm;
use xpm.vcomponents.all;

entity px_dac3484intrfc is
generic (

    initial_sync_tap_delay    : integer := 0;
    initial_ostrb_tap_delay   : integer := 0;
    
    idelaycntrl_refclk_freq   : integer := 200; -- in MHz
    iodelay_grp               : string := "IODELAY_GRP"

);
Port (

    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI-LITE)
    ----------------------------------------------------------------------------
    s_axi_csr_aclk           : in  std_logic;
    -- associated with s_axi_aclk
    s_axi_csr_aresetn        : in  std_logic;
    s_axi_csr_awaddr         : in  std_logic_vector(6 downto 0);
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
    s_axi_csr_araddr         : in  std_logic_vector(6 downto 0);
    s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid        : in  std_logic;
    s_axi_csr_arready        : out std_logic;
    s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid         : out std_logic;
    s_axi_csr_rready         : in  std_logic;
    
    -- Dac Packer Interface
    s_dac_axis_aclk    : in std_logic;
    s_dac_axis_aresetn : in  std_logic;
    s_dac0_axis_tvalid : in std_logic;
    s_dac0_axis_tdata  : in std_logic_vector(31 downto 0);
    s_dac0_axis_tuser  : in std_logic_vector(127 downto 0);
    
    
    s_dac1_axis_tvalid : in std_logic;
    s_dac1_axis_tdata  : in std_logic_vector(31 downto 0);
    s_dac1_axis_tuser  : in std_logic_vector(127 downto 0);
    
    ----------------------------------------------------------------------------
    -- Dac Serdes Interface
    ----------------------------------------------------------------------------
    DAC_CLK_IN     : in  std_logic;
    
    -- Data to the 3484
    DAC_DATA_P    : out std_logic_vector(15 downto 0); -- DAC Data +
    DAC_DATA_N    : out std_logic_vector(15 downto 0); -- DAC Data -
    DAC_DCLK_P    : out std_logic;
    DAC_DCLK_N    : out std_logic;
     
    DAC_SLEEP     : out std_logic;
    DAC_FRAME_P   : out std_logic;
    DAC_FRAME_N   : out std_logic;
    DAC_TXENABLE  : out std_logic;
    DAC_PARITY_P  : out std_logic;
    DAC_PARITY_N  : out std_logic;
    DAC_OSTR_P    : out std_logic;
    DAC_OSTR_N    : out std_logic;
    
    -- DAC Control/Status Signals
    DAC_SYNC_P    : out std_logic; -- DAC Sync +
    DAC_SYNC_N    : out std_logic; -- DAC Sync -
    DAC_RESET_N   : out std_logic;  -- Reset to the DAC
    
    -- DAC SPI Control Bus
    px_spi_sclk   : out std_logic; -- SPI Bus Clock to the DAC
    px_spi_sdi    : inout std_logic; -- SPI Bus Data to the DAC
    px_spi_sdo    : in  std_logic; -- SPI Bus Data from the DAC
    px_spi_en_n   : out std_logic; -- SPI Bus Data to the DAC
    
    irq           : out std_logic
         
    
    

);
end px_dac3484intrfc;

architecture Behavioral of px_dac3484intrfc is

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of s_dac_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_dac_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_dac_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_dac0_axis:s_dac1_axis";




component px_dac3484_csr
generic (

    initial_sync_tap_delay    : integer := 0;
    initial_ostrb_tap_delay   : integer := 0

);
Port( 

    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI-LITE)
    ----------------------------------------------------------------------------
    s_axi_csr_aclk           : in  std_logic;
    -- associated with s_axi_aclk
    s_axi_csr_aresetn        : in  std_logic;
    s_axi_csr_awaddr         : in  std_logic_vector(6 downto 0);
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
    s_axi_csr_araddr         : in  std_logic_vector(6 downto 0);
    s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid        : in  std_logic;
    s_axi_csr_arready        : out std_logic;
    s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid         : out std_logic;
    s_axi_csr_rready         : in  std_logic;
    
    dac0_gate                : in  std_logic;
    dac1_gate                : in  std_logic;
    dac_sync                 : in  std_logic;
    dac_ostr                 : in  std_logic;
    irq                      : out std_logic; -- Interrupt out
    
    s_dac_axis_aclk          : in  std_logic;
    
    dac_mode                 : out std_logic_vector(2 downto 0);
                             
    dac_reseta_n_in          : out std_logic;
    dac_txenable             : out std_logic;
    
    dac_serdes_int_rst       : out std_logic;
    
    sync_tap_delay           : out std_logic_vector(8 downto 0);    
    sync_tap_delay_ld        : out std_logic;
    ostrb_tap_delay          : out std_logic_vector(8 downto 0);
    ostrb_tap_delay_ld       : out std_logic; 
    
    dac_sclk                 : out std_logic; -- SPI Bus Clock to the DAC
    dac_sdi                  : inout std_logic; -- SPI Bus Data to the DAC
    dac_sdo                  : in std_logic; -- SPI Bus Data from the DAC
    dac_sdenb                : out std_logic -- SPI Bus Data to the DAC   

    
    
    

);
end component; 

component px_dac3484_packer 
Port (

-- Dac Packer Interface
    s_dac_axis_aclk  : in std_logic;
    
    s_dac0_axis_tvalid : in std_logic;
    s_dac0_axis_tdata  : in std_logic_vector(31 downto 0);
    s_dac0_axis_tuser  : in std_logic_vector(127 downto 0);
    
    s_dac1_axis_tvalid : in std_logic;
    s_dac1_axis_tdata  : in std_logic_vector(31 downto 0);
    s_dac1_axis_tuser  : in std_logic_vector(127 downto 0);
    
    dac_mode         : in std_logic_vector(2 downto 0);
           
    dac_data_out     : out std_logic_vector(63 downto 0);
    dac_sync_out     : out std_logic


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

    s_dac_axis_aresetn : in std_logic;

    DAC_CLK_IN         : in  std_logic;
    s_dac_axis_aclk    : in std_logic;
    DAC_DATA_A_IN      : in  std_logic_vector (63 downto 0);
    DAC_RESETA_N_IN    : in  std_logic;
    DAC_SYNC_IN        : in  std_logic;
    DAC_SERDES_INT_RST : in std_logic;
    
    sync_tap_delay     : in std_logic_vector(8 downto 0);    
    sync_tap_delay_ld  : in std_logic;
    ostrb_tap_delay    : in std_logic_vector(8 downto 0);
    ostrb_tap_delay_ld : in std_logic; 
    
    DAC_OSTR           : out std_logic;
    
    -- Data to the 3484
    DAC_DATA_P    : out std_logic_vector(15 downto 0); -- DAC Data +
    DAC_DATA_N    : out std_logic_vector(15 downto 0); -- DAC Data -
    DAC_DCLK_P    : out std_logic;
    DAC_DCLK_N    : out std_logic;
     
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

-- DAC SPI Control Bus

signal dac_mode         : std_logic_vector(2 downto 0);
signal dac_reseta_n_in  : std_logic;
signal dac_data_out     : std_logic_vector(63 downto 0);
signal dac0_gate        : std_logic; 
signal dac1_gate        : std_logic; 
signal dac_sync         : std_logic;
signal dac_ostr         : std_logic;

signal sync_tap_delay     : std_logic_vector(8 downto 0);    
signal sync_tap_delay_ld  : std_logic;
signal ostrb_tap_delay    : std_logic_vector(8 downto 0);
signal ostrb_tap_delay_ld : std_logic; 

signal dac_serdes_int_rst : std_logic;
    
begin

dac_sleep <= '0';

process(s_dac_axis_aclk) begin

    if(rising_edge(s_dac_axis_aclk)) then
        dac0_gate <= s_dac0_axis_tuser(64);
        dac1_gate <= s_dac1_axis_tuser(64);
    end if;

end process;


csr_inst: px_dac3484_csr
generic map (

    initial_sync_tap_delay    => initial_sync_tap_delay,
    initial_ostrb_tap_delay   => initial_ostrb_tap_delay

)
Port map
( 

    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI-LITE)
    ----------------------------------------------------------------------------
    s_axi_csr_aclk           => s_axi_csr_aclk,
    -- associated with s_axi_aclk
    s_axi_csr_aresetn        => s_axi_csr_aresetn,
    s_axi_csr_awaddr         => s_axi_csr_awaddr ,
    s_axi_csr_awprot         => s_axi_csr_awprot ,
    s_axi_csr_awvalid        => s_axi_csr_awvalid,
    s_axi_csr_awready        => s_axi_csr_awready,
    s_axi_csr_wdata          => s_axi_csr_wdata  ,
    s_axi_csr_wstrb          => s_axi_csr_wstrb  ,
    s_axi_csr_wvalid         => s_axi_csr_wvalid ,
    s_axi_csr_wready         => s_axi_csr_wready ,
    s_axi_csr_bresp          => s_axi_csr_bresp  ,
    s_axi_csr_bvalid         => s_axi_csr_bvalid ,
    s_axi_csr_bready         => s_axi_csr_bready ,
    s_axi_csr_araddr         => s_axi_csr_araddr ,
    s_axi_csr_arprot         => s_axi_csr_arprot ,
    s_axi_csr_arvalid        => s_axi_csr_arvalid,
    s_axi_csr_arready        => s_axi_csr_arready,
    s_axi_csr_rdata          => s_axi_csr_rdata  ,
    s_axi_csr_rresp          => s_axi_csr_rresp  ,
    s_axi_csr_rvalid         => s_axi_csr_rvalid ,
    s_axi_csr_rready         => s_axi_csr_rready ,
    
    irq                      => irq,
    dac0_gate                => dac0_gate,
    dac1_gate                => dac1_gate,
    dac_sync                 => dac_sync,
    dac_ostr                 => dac_ostr,
    
    s_dac_axis_aclk          => s_dac_axis_aclk,
    
    dac_mode                 => dac_mode,
                             
    dac_reseta_n_in          => dac_reseta_n_in,
    dac_txenable             => dac_txenable,
    
    dac_serdes_int_rst       => dac_serdes_int_rst,
    
    sync_tap_delay           => sync_tap_delay,    
    sync_tap_delay_ld        => sync_tap_delay_ld,
    ostrb_tap_delay          => ostrb_tap_delay,
    ostrb_tap_delay_ld       => ostrb_tap_delay_ld,
    
    dac_sclk                 => px_spi_sclk,
    dac_sdi                  => px_spi_sdi,
    dac_sdo                  => px_spi_sdo,
    dac_sdenb                => px_spi_en_n
    
    
    

);

packer_inst: px_dac3484_packer 
Port map
(

-- Dac Packer Interface
    s_dac_axis_aclk      => s_dac_axis_aclk,          
            
    s_dac0_axis_tvalid   => s_dac0_axis_tvalid,
    s_dac0_axis_tdata    => s_dac0_axis_tdata,  
    s_dac0_axis_tuser    => s_dac0_axis_tuser, 
    
    s_dac1_axis_tvalid     => s_dac1_axis_tvalid,
    s_dac1_axis_tdata      => s_dac1_axis_tdata,
    s_dac1_axis_tuser      => s_dac1_axis_tuser,
    
    dac_mode             => dac_mode,    
                                     
    dac_data_out         => dac_data_out,
    dac_sync_out         => dac_sync
);

serdes_intrfc_inst: px_dac3484_serdes
generic map(

    initial_sync_tap_delay    => initial_sync_tap_delay,
    initial_ostrb_tap_delay   => initial_ostrb_tap_delay,
    
    idelaycntrl_refclk_freq   => idelaycntrl_refclk_freq,
    iodelay_grp               => iodelay_grp

)
Port map
( 
    
    s_dac_axis_aresetn => s_dac_axis_aresetn,

    DAC_CLK_IN         => DAC_CLK_IN,       
    s_dac_axis_aclk    => s_dac_axis_aclk,   
  
    DAC_DATA_A_IN      => dac_data_out,
    
    DAC_RESETA_N_IN    => dac_reseta_n_in,   
    DAC_SYNC_IN        => dac_sync,       
    DAC_SERDES_INT_RST => DAC_SERDES_INT_RST,
    
    sync_tap_delay     => sync_tap_delay,    
    sync_tap_delay_ld  => sync_tap_delay_ld,
    ostrb_tap_delay    => ostrb_tap_delay,
    ostrb_tap_delay_ld => ostrb_tap_delay_ld,
      
    DAC_OSTR           => dac_ostr,
    
    -- Data to the 3484
    DAC_DATA_P        => DAC_DATA_P,      
    DAC_DATA_N        => DAC_DATA_N,      
     
    DAC_DCLK_P        => DAC_DCLK_P,   
    DAC_DCLK_N        => DAC_DCLK_N,   
   
    DAC_FRAME_P      => DAC_FRAME_P,  
    DAC_FRAME_N      => DAC_FRAME_N,  
    DAC_PARITY_P     => DAC_PARITY_P, 
    DAC_PARITY_N     => DAC_PARITY_N, 
    DAC_OSTR_P       => DAC_OSTR_P,   
    DAC_OSTR_N       => DAC_OSTR_N,   
  
    -- DAC Control/Status Signals
    DAC_SYNC_P      => DAC_SYNC_P,
    DAC_SYNC_N      => DAC_SYNC_N,
    DAC_RESET_N     => DAC_RESET_N



);


end Behavioral;
