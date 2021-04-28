----------------------------------------------------------------------------------
-- Company:  Pentek Inc
-- Engineer: G.L.
-- 	
-- Create Date: 05/16/2018 
-- IP Core Name: PX_JESD_SYNC_MOD
-- File Name: px_jesd_sync_mod.vhd 
-- Target Devices: Kintex UltraScale  
-- Tool Versions: 2018.1
-- Description: This module is used to control JESD SYNC to support
-- snchronization of multiple JESD interfaces. This can be used for either
-- RX or TX direction
-- 
-- Dependencies: 
-- Requires a seperate Xilinx JESD interface 
--
-- Revision:
-- Revision 1.0 - 3/4/2019 - Very strange bug was occuring as a result of 
-- asynchroneously clearing of logic. Changed logic to clear synchroneously,
-- which removed the bug.
--
-- Revision 1.0 - 5/16/2018 - Module Created
-- Additional Comments:
-- 

-- (Memory Map)
-- 0x00 - JESD Sync Control Register R/W
-- 0x04 - JESD Sync Status Register  R/W

-- (Additional Info)
-- Example: Requires a seperate JESD Interface  

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;

Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_jesd_sync_mod is
generic (
   
    jesd_interface_type : string  := "rx";
    jesd_bus_width      : integer := 128

);
Port 
( 
    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI4-LITE)
    ----------------------------------------------------------------------------
    -- associated with s_axi_csr_aclk
    s_axi_csr_aclk           : in  std_logic;
    s_axi_csr_aresetn        : in  std_logic;
    s_axi_csr_awaddr         : in  std_logic_vector(11 downto 0);
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
    s_axi_csr_araddr         : in  std_logic_vector(11 downto 0);
    s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid        : in  std_logic;
    s_axi_csr_arready        : out std_logic;
    s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid         : out std_logic;
    s_axi_csr_rready         : in  std_logic;
    
    jesd_core_clk            : in std_logic;
    s_axis_rx_tdata          : in std_logic_vector(jesd_bus_width - 1 downto 0);
    s_axis_rx_tvalid         : in std_logic;
    s_axis_tx_tdata          : in std_logic_vector(jesd_bus_width - 1 downto 0); 
    s_axis_tx_tready         : out std_logic;
    
    m_axis_rx_tdata          : out std_logic_vector(jesd_bus_width - 1 downto 0);
    m_axis_rx_tvalid         : out std_logic;
    m_axis_tx_tdata          : out std_logic_vector(jesd_bus_width - 1 downto 0); 
    m_axis_tx_tready         : in std_logic;
    
    sample_clk               : in std_logic;
    s_axis_timecntl_tdata    : in std_logic_vector(7 downto 0);
    s_axis_timecntl_tvalid   : in std_logic;
    
    -- Sync From rx/tx
    jesd_sync_in             : in std_logic;
    -- Sync out to rx/tx
    jesd_sync_out            : out std_logic;
    
    irq                      : out std_logic
);
end px_jesd_sync_mod;

architecture Behavioral of px_jesd_sync_mod is

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";
  
ATTRIBUTE X_INTERFACE_INFO of sample_clk: SIGNAL is "xilinx.com:signal:clock:1.0 sample_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of sample_clk: SIGNAL is "ASSOCIATED_BUSIF s_axis_timecntl";

ATTRIBUTE X_INTERFACE_INFO of jesd_core_clk: SIGNAL is "xilinx.com:signal:clock:1.0 jesd_core_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of jesd_core_clk: SIGNAL is "ASSOCIATED_BUSIF s_axis_rx:s_axis_tx:m_axis_rx:m_axis_tx";

signal s_axi_csr_aresetn_reg : std_logic := '0';

signal reg0_init_val     : std_logic_vector(31 downto 0) := X"00000000";
signal ctl0_out          : std_logic_vector(31 downto 0) := X"00000000";
signal stat0_in          : std_logic_vector(31 downto 0) := X"00000000";
signal stat1_in          : std_logic_vector(31 downto 0) := X"00000000";
signal stat1_in_cdc      : std_logic_vector(31 downto 0) := X"00000000";
signal intrpt_src_in     : std_logic_vector(3 downto 0)  := "0000";
signal intrpt_src_in_cdc : std_logic_vector(3 downto 0)  := "0000";

signal jesd_sync_in_reg   : std_logic;
signal jesd_sync_out_reg1 : std_logic;
signal jesd_sync_out_reg2 : std_logic;

signal ctl0_out_cdc      : std_logic_vector(31 downto 0) := X"00000000";

signal jesd_sync_latch_clr : std_logic := '0'; 
signal jesd_sync_sel       : std_logic := '0';
signal jesd_sync_en        : std_logic := '0';

signal sync_reg            : std_logic := '0';
signal sync_cdc            : std_logic := '0';
signal sync_cdc_reg1       : std_logic := '0';
signal sync_cdc_reg2       : std_logic := '0';

signal sync_pulse          : std_logic := '0';

signal sync_to_tvalid_cntr_en : std_logic := '0';
signal sync_to_tvalid_cntr    : std_logic_vector(7 downto 0) := (others => '0');

signal s_axis_rx_tdata_reg   : std_logic_vector(jesd_bus_width - 1 downto 0);
signal s_axis_rx_tvalid_reg  : std_logic;
signal m_axis_tx_tready_reg  : std_logic;

signal tvalid_tready_received : std_logic;

COMPONENT px_jesd_sync_mod_csr
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
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

begin


gen_rx: if jesd_interface_type = "rx" generate

    stat0_in               <= X"00000000";
    tvalid_tready_received <= s_axis_rx_tvalid_reg;   

end generate gen_rx;

gen_tx: if jesd_interface_type = "tx" generate

    stat0_in <= X"00000001";    
    tvalid_tready_received <= m_axis_tx_tready_reg;

end generate gen_tx;

process(s_axi_csr_aclk) begin

    if(rising_edge(s_axi_csr_aclk)) then
        s_axi_csr_aresetn_reg <= s_axi_csr_aresetn;
    end if;

end process;

s_axis_tx_tready <= m_axis_tx_tready;
m_axis_tx_tdata  <= s_axis_tx_tdata;


csr: px_jesd_sync_mod_csr
PORT MAP
(
    s_axi_csr_aclk    => s_axi_csr_aclk,   
    s_axi_csr_aresetn => s_axi_csr_aresetn_reg,
    s_axi_csr_awaddr  => s_axi_csr_awaddr(6 downto 0), 
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
    s_axi_csr_araddr  => s_axi_csr_araddr(6 downto 0), 
    s_axi_csr_arprot  => s_axi_csr_arprot, 
    s_axi_csr_arvalid => s_axi_csr_arvalid,
    s_axi_csr_arready => s_axi_csr_arready,
    s_axi_csr_rdata   => s_axi_csr_rdata,  
    s_axi_csr_rresp   => s_axi_csr_rresp,  
    s_axi_csr_rvalid  => s_axi_csr_rvalid, 
    s_axi_csr_rready  => s_axi_csr_rready,
        
    reg0_init_val     => reg0_init_val,
    ctl0_out          => ctl0_out,     
    stat0_in          => stat0_in,     
    stat1_in          => stat1_in_cdc,     
    intrpt_src_in     => intrpt_src_in_cdc,
    irq               => irq
);

xpm_cdc_jmode_inst: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 32  -- integer; range: 1-1024

  )
  port map (

    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => ctl0_out,
    dest_clk => jesd_core_clk,
    dest_out => ctl0_out_cdc
  );
  
  process(jesd_core_clk) begin
      if(rising_edge(jesd_core_clk)) then
          jesd_sync_latch_clr <= ctl0_out_cdc(0);
          jesd_sync_sel       <= ctl0_out_cdc(1);
          jesd_sync_en        <= ctl0_out_cdc(2);
          
          s_axis_rx_tdata_reg   <= s_axis_rx_tdata;   
          s_axis_rx_tvalid_reg  <= s_axis_rx_tvalid;
          m_axis_rx_tdata       <= s_axis_rx_tdata_reg; 
          m_axis_rx_tvalid      <= s_axis_rx_tvalid_reg;
                    
          m_axis_tx_tready_reg  <= m_axis_tx_tready;  
      end if;
  end process;

  process(sample_clk) begin
      if(rising_edge(sample_clk)) then
          sync_reg <= s_axis_timecntl_tdata(1);
      end if;
  end process;
  
  xpm_cdc_sync_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => sample_clk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => sync_reg,
     dest_clk => jesd_core_clk,
     dest_out => sync_cdc
  );
  
  stat1_in(31 downto 8) <= (others => '0');
  stat1_in(7 downto 0)  <= sync_to_tvalid_cntr;
  
  xpm_cdc_state1_inst: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 32  -- integer; range: 1-1024

  )
  port map (

    src_clk  => jesd_core_clk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => stat1_in,
    dest_clk => s_axi_csr_aclk,
    dest_out => stat1_in_cdc
  );
  
  intrpt_src_in(0) <= jesd_sync_in_reg;
  intrpt_src_in(1) <= sync_cdc;
  intrpt_src_in(2) <= jesd_sync_out_reg2;
  intrpt_src_in(3) <= tvalid_tready_received;
  
  xpm_cdc_interrupt_inst: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 4  -- integer; range: 1-1024

  )
  port map (

    src_clk  => jesd_core_clk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => intrpt_src_in,
    dest_clk => s_axi_csr_aclk,
    dest_out => intrpt_src_in_cdc
  );
  
  process(jesd_core_clk, jesd_sync_latch_clr) begin
      
      if(rising_edge(jesd_core_clk)) then
          if(jesd_sync_latch_clr = '1') then
              jesd_sync_in_reg       <= '0';
              jesd_sync_out          <= '0';
              jesd_sync_out_reg1     <= '0';
              jesd_sync_out_reg2     <= '0';
              sync_to_tvalid_cntr_en <= '0';
                                  
              sync_cdc_reg1       <= '0';
              sync_cdc_reg2       <= '0';
              sync_pulse          <= '0';
              sync_to_tvalid_cntr <= (others => '0');
          else
          
              jesd_sync_in_reg   <= jesd_sync_in;
                        
              sync_cdc_reg1    <= sync_cdc;
              sync_cdc_reg2    <= sync_cdc_reg1;
              
              jesd_sync_out_reg2 <= jesd_sync_out_reg1;
              jesd_sync_out      <= jesd_sync_out_reg2;
              
              sync_pulse       <= jesd_sync_out_reg1 and not jesd_sync_out_reg2;
              
              if( jesd_sync_sel = '0') then
                  jesd_sync_out_reg1 <= jesd_sync_in_reg;
              else
                  
                  if(jesd_sync_in_reg = '1' and sync_cdc_reg1 = '1' and jesd_sync_en = '1') then
                      jesd_sync_out_reg1 <= '1';
                  end if;
                  
                  if(sync_pulse = '1') then
                      sync_to_tvalid_cntr_en <= '1';
                                         
                  -- Based on JESD Interface type, disable counter enable when
                  -- tvalid or tready has been asserted
                  elsif(s_axis_rx_tvalid_reg = '1' or m_axis_tx_tready_reg = '1') then
                      sync_to_tvalid_cntr_en <= '0';
                  else
                      if(sync_to_tvalid_cntr_en = '1') then
                          sync_to_tvalid_cntr <= sync_to_tvalid_cntr + '1';
                      end if;
                  end if;
              end if;
          end if;
      end if;
  end process;
  
  
  
  
  
  
  

end Behavioral;
