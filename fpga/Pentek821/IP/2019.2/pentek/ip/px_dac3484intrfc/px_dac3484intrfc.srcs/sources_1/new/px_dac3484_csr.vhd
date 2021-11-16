----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2019 02:17:47 PM
-- Design Name: 
-- Module Name: px_dac3484_csr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revisoin 1.00 - 10/9/20 - Added software registers to support 
--                           TAP delay capability on DAC SYNC and OSTR
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

Library xpm;
use xpm.vcomponents.all;

entity px_dac3484_csr is
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
end px_dac3484_csr;

architecture Behavioral of px_dac3484_csr is

signal s_axi_csr_aresetn_reg   : std_logic; 

signal reg0_init_val     : std_logic_vector(31 downto 0) := (others => '0');
signal reg1_init_val     : std_logic_vector(31 downto 0) := (others => '0');
signal reg2_init_val     : std_logic_vector(31 downto 0) := "0000000" & conv_std_logic_vector(initial_ostrb_tap_delay, 9) & "0000000" & conv_std_logic_vector(initial_sync_tap_delay, 9);
signal ctlx              : std_logic_vector(63 downto 0) := (others => '0');
signal ctlx_cdc          : std_logic_vector(63 downto 0) := (others => '0');
signal ctl0_out          : std_logic_vector(31 downto 0) := (others => '0');
signal ctl0_out_cdc      : std_logic_vector(31 downto 0) := (others => '0');
signal ctl1_out          : std_logic_vector(31 downto 0) := (others => '0');
signal ctl2_out          : std_logic_vector(31 downto 0) := (others => '0');
signal ctl2_out_cdc      : std_logic_vector(31 downto 0) := (others => '0');
signal stat0_in          : std_logic_vector(31 downto 0) := (others => '0');
signal stat1_in          : std_logic_vector(31 downto 0) := (others => '0');


signal dac0_gate_cdc            : std_logic;
signal dac1_gate_cdc            : std_logic;
signal dac_sync_cdc             : std_logic;
signal dac_ostr_cdc             : std_logic;

signal src_send07           : std_logic:= '0';
signal src_rcv07            : std_logic:= '0';
signal dest_req07           : std_logic:= '0';

signal intrpt_src_in        : std_logic_vector(3 downto 0);


COMPONENT dac3484_csr_intrfc
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
    ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT dac3484_serial_int
  PORT (
    clk_in : IN STD_LOGIC;
    rst_n : IN STD_LOGIC;
    data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    addr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    wr : IN STD_LOGIC;
    rd : IN STD_LOGIC;
    data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    sm_rdy : OUT STD_LOGIC;
    sdi : INOUT STD_LOGIC;
    sdenb : OUT STD_LOGIC;
    sclk : OUT STD_LOGIC;
    sdo : IN STD_LOGIC
  );
END COMPONENT;

begin

reg0_init_val <= (others => '0');
reg1_init_val <= (others => '0');
stat0_in      <= (others => '0');

process(s_axi_csr_aclk) begin
    if(rising_edge(s_axi_csr_aclk)) then
        s_axi_csr_aresetn_reg <= s_axi_csr_aresetn;
    end if;    
end process;

csr_inst: dac3484_csr_intrfc
  PORT map
  (
    s_axi_csr_aclk    => s_axi_csr_aclk,
    s_axi_csr_aresetn => s_axi_csr_aresetn_reg,
    s_axi_csr_awaddr  => s_axi_csr_awaddr ,
    s_axi_csr_awprot  => s_axi_csr_awprot ,
    s_axi_csr_awvalid => s_axi_csr_awvalid,
    s_axi_csr_awready => s_axi_csr_awready,
    s_axi_csr_wdata   => s_axi_csr_wdata  ,
    s_axi_csr_wstrb   => s_axi_csr_wstrb  ,
    s_axi_csr_wvalid  => s_axi_csr_wvalid ,
    s_axi_csr_wready  => s_axi_csr_wready ,
    s_axi_csr_bresp   => s_axi_csr_bresp  ,
    s_axi_csr_bvalid  => s_axi_csr_bvalid ,
    s_axi_csr_bready  => s_axi_csr_bready ,
    s_axi_csr_araddr  => s_axi_csr_araddr ,
    s_axi_csr_arprot  => s_axi_csr_arprot ,
    s_axi_csr_arvalid => s_axi_csr_arvalid,
    s_axi_csr_arready => s_axi_csr_arready,
    s_axi_csr_rdata   => s_axi_csr_rdata  ,
    s_axi_csr_rresp   => s_axi_csr_rresp  ,
    s_axi_csr_rvalid  => s_axi_csr_rvalid ,
    s_axi_csr_rready  => s_axi_csr_rready ,
    reg0_init_val     => reg0_init_val,
    reg1_init_val     => reg1_init_val,
    reg2_init_val     => reg2_init_val,
    ctl0_out          => ctl0_out,
    ctl1_out          => ctl1_out,
    ctl2_out          => ctl2_out,
    stat0_in          => stat0_in,
    stat1_in          => stat1_in,
    intrpt_src_in     => intrpt_src_in,
    irq               => irq
  );
  
  stat1_in(31 downto 17) <= (others => '0');
  
  serial_int_inst: dac3484_serial_int
  PORT map
  (
    clk_in   => s_axi_csr_aclk,
    rst_n    => s_axi_csr_aresetn_reg,
    data_in  => ctl1_out(15 downto 0),
    addr     => ctl1_out(22 downto 16),
    wr       => ctl1_out(24),
    rd       => ctl1_out(25),
    data_out => stat1_in(15 downto 0),
    sm_rdy   => stat1_in(16),
    sdi      => dac_sdi,
    sdenb    => dac_sdenb,
    sclk     => dac_sclk,
    sdo      => dac_sdo
  );
  
  
  
  ctlx <= ctl2_out & ctl0_out;
          
  cdc:  xpm_cdc_handshake
  generic map (
  
    -- Common module generics
    DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_SYNC_FF    => 3, -- integer; range: 2-10
    WIDTH          => 64  -- integer; range: 1-1024
  )
  port map (
  
    src_clk  => s_axi_csr_aclk,
    src_in   => ctlx ,
    src_send => src_send07,
    src_rcv  => src_rcv07,
    dest_clk => s_dac_axis_aclk,
    dest_req => dest_req07,
    dest_ack => dest_req07, 
    dest_out => ctlx_cdc
  );
  
  ctl0_out_cdc <= ctlx_cdc(31 downto 0);
  ctl2_out_cdc <= ctlx_cdc(63 downto 32); 
     
  process(s_axi_csr_aclk)
  begin
     if rising_edge(s_axi_csr_aclk) then
       if (src_rcv07 = '1') then
         src_send07 <= '0';
       elsif (src_rcv07 = '0') and (src_send07 = '0') then
         src_send07 <= '1';
       end if;  
     end if;
  end process;
  
  
  process(s_dac_axis_aclk)
  begin
     if rising_edge(s_dac_axis_aclk) then
         dac_reseta_n_in    <= not ctl0_out_cdc(0);
         dac_txenable       <= ctl0_out_cdc(1);
         dac_serdes_int_rst <= ctl0_out_cdc(2);                
         dac_mode           <= ctl0_out_cdc(6 downto 4);
         
         sync_tap_delay     <= ctl2_out_cdc(8 downto 0);
         sync_tap_delay_ld  <= ctl2_out_cdc(9);
         ostrb_tap_delay    <= ctl2_out_cdc(24 downto 16);
         ostrb_tap_delay_ld <= ctl2_out_cdc(25);
     
     end if;
  end process;
  
  dac0_gate_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => s_dac_axis_aclk,
    src_rst    => s_axi_csr_aresetn_reg,  -- optional; required when RST_USED = 1
    src_pulse  => dac0_gate,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => dac0_gate_cdc 
);

dac1_gate_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => s_dac_axis_aclk,
    src_rst    => s_axi_csr_aresetn_reg,  -- optional; required when RST_USED = 1
    src_pulse  => dac1_gate,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => dac1_gate_cdc 
);

dac_sync_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => s_dac_axis_aclk,
    src_rst    => s_axi_csr_aresetn_reg,  -- optional; required when RST_USED = 1
    src_pulse  => dac_sync,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => dac_sync_cdc 
);

dac_ostr_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => s_dac_axis_aclk,
    src_rst    => s_axi_csr_aresetn_reg,  -- optional; required when RST_USED = 1
    src_pulse  => dac_ostr,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => dac_ostr_cdc 
);
   
  intrpt_src_in(0) <= dac0_gate_cdc; 
  intrpt_src_in(1) <= dac1_gate_cdc; 
  intrpt_src_in(2) <= dac_sync_cdc; 
  intrpt_src_in(3) <= dac_ostr_cdc; 


end Behavioral;
