----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2017 03:31:52 PM
-- Design Name: 
-- Module Name: px_lmx2594rhaintrfc - Behavioral
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

entity px_lmx2594rhaintrfc is
Port( 

    lmx_sdi        : inout std_logic;     
    lmx_sclk       : out std_logic;
    lmx_cs_n       : out std_logic;
    lmx_ce         : out std_logic;
    lmx_ld_sdo     : in std_logic;
    
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   -- DWORD Addressing
   --------------------------------------------------------------------------------
   s_axi_csr_aclk : in STD_LOGIC;
   s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
   s_axi_csr_aresetn : in STD_LOGIC;
   s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
   s_axi_csr_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
   s_axi_csr_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
   s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
   s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
   s_axi_csr_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
   s_axi_csr_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
   s_axi_csr_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
   s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
   s_axi_csr_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
   s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
   s_axi_csr_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
   s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
   s_axi_csr_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
   s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
   s_axi_csr_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
   s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
   s_axi_csr_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 )

);
end px_lmx2594rhaintrfc;

architecture Behavioral of px_lmx2594rhaintrfc is

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";


signal s_axi_csr_aresetn_reg : std_logic;

signal reg0_init_val : std_logic_vector(31 downto 0) := (others => '0');
signal reg1_init_val : std_logic_vector(31 downto 0) := (others => '0');
signal reg2_init_val : std_logic_vector(31 downto 0) := (others => '0');
signal ctl0_out      : std_logic_vector(31 downto 0) := (others => '0');
signal ctl1_out      : std_logic_vector(31 downto 0) := (others => '0');
signal ctl2_out      : std_logic_vector(31 downto 0) := (others => '0');
signal stat0_in      : std_logic_vector(31 downto 0) := (others => '0');
signal stat1_in      : std_logic_vector(31 downto 0) := (others => '0');


signal px_lmx_spi_rst_n    : std_logic := '0';
signal px_lmx_spi_data_in  : std_logic_vector(15 downto 0) := (others => '0');
signal px_lmx_spi_data_out : std_logic_vector(15 downto 0) := (others => '0');
signal px_lmx_spi_addr     : std_logic_vector(6 downto 0) := (others => '0');
signal px_lmx_spi_wr       : std_logic := '0';
signal px_lmx_spi_rd       : std_logic := '0';
signal px_lmx_spi_sm_rdy   : std_logic := '0';
signal lmx_ld_sdo_reg      : std_logic := '0';

COMPONENT px_lmx2594rha_csr
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
    stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

COMPONENT px_lmx2594rh_spi
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

csr_inst: px_lmx2594rha_csr
  PORT map 
  (
    s_axi_csr_aclk    => s_axi_csr_aclk,
    s_axi_csr_aresetn => s_axi_csr_aresetn_reg,
    s_axi_csr_awaddr  => s_axi_csr_awaddr(6 downto 0) ,
    s_axi_csr_awprot  => s_axi_csr_awprot ,
    s_axi_csr_awvalid => s_axi_csr_awvalid(0),
    s_axi_csr_awready => s_axi_csr_awready(0),
    s_axi_csr_wdata   => s_axi_csr_wdata  ,
    s_axi_csr_wstrb   => s_axi_csr_wstrb  ,
    s_axi_csr_wvalid  => s_axi_csr_wvalid(0) ,
    s_axi_csr_wready  => s_axi_csr_wready(0) ,
    s_axi_csr_bresp   => s_axi_csr_bresp  ,
    s_axi_csr_bvalid  => s_axi_csr_bvalid(0) ,
    s_axi_csr_bready  => s_axi_csr_bready(0) ,
    s_axi_csr_araddr  => s_axi_csr_araddr ,
    s_axi_csr_arprot  => s_axi_csr_arprot ,
    s_axi_csr_arvalid => s_axi_csr_arvalid(0),
    s_axi_csr_arready => s_axi_csr_arready(0),
    s_axi_csr_rdata   => s_axi_csr_rdata  ,
    s_axi_csr_rresp   => s_axi_csr_rresp  ,
    s_axi_csr_rvalid  => s_axi_csr_rvalid(0) ,
    s_axi_csr_rready  => s_axi_csr_rready(0) ,
    
    
    reg0_init_val     => reg0_init_val,
    reg1_init_val     => reg1_init_val,
    reg2_init_val     => reg2_init_val,
    ctl0_out          => ctl0_out,
    ctl1_out          => ctl1_out,
    ctl2_out          => ctl2_out,
    stat0_in          => stat0_in,
    stat1_in          => stat1_in
  );
  
process(s_axi_csr_aclk) begin

    if(rising_edge(s_axi_csr_aclk)) then
    
        s_axi_csr_aresetn_reg <= s_axi_csr_aresetn;

        -- LMK control register
        
        px_lmx_spi_rst_n   <= not ctl0_out(0);
        px_lmx_spi_wr      <= ctl0_out(1);
        px_lmx_spi_rd      <= ctl0_out(2);
        lmx_ce             <= ctl0_out(3);
        
        px_lmx_spi_addr    <= ctl1_out(6 downto 0);
        px_lmx_spi_data_in <= ctl2_out(15 downto 0);
        
        lmx_ld_sdo_reg <= lmx_ld_sdo;
        
        -- Control and SPI status register 
        stat0_in(0)            <= px_lmx_spi_sm_rdy;
        stat0_in(1)            <= lmx_ld_sdo_reg;
        stat0_in(31 downto 2)  <= (others => '0');
        stat1_in(15 downto 0)  <= px_lmx_spi_data_out;
        stat1_in(31 downto 16) <= (others => '0');

            
    end if;

end process;



lmx_spi: px_lmx2594rh_spi
  port map
  (
    clk_in   => s_axi_csr_aclk,
    rst_n    => px_lmx_spi_rst_n,
    data_in  => px_lmx_spi_data_in,
    addr     => px_lmx_spi_addr,
    wr       => px_lmx_spi_wr,
    rd       => px_lmx_spi_rd,
    data_out => px_lmx_spi_data_out,
    sm_rdy   => px_lmx_spi_sm_rdy,
    sdi      => lmx_sdi,
    sdenb    => lmx_cs_n,
    sclk     => lmx_sclk,
    sdo      => lmx_ld_sdo
  );



end Behavioral;
