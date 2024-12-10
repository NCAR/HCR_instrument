----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2017 04:04:55 PM
-- Design Name: 
-- Module Name: tb_px_lmx2594rhaintrfc - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.px_utility_pkg.ALL;

entity tb_px_lmx2594rhaintrfc is
generic 
( 
    write_read : std_logic := '0';  -- 0 = write, 1 = read
    read_data : std_logic_vector(15 downto 0) := X"A28B"

);
end tb_px_lmx2594rhaintrfc;

architecture Behavioral of tb_px_lmx2594rhaintrfc is


component px_lmx2594rhaintrfc 
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
end component;

signal lmx_sdi        : std_logic := '0';    
signal lmx_sclk       : std_logic := '0';
signal lmx_cs_n       : std_logic := '0';
signal lmx_ce         : std_logic := '0';
signal lmx_ld_sdo     : std_logic := '0';


signal s_axi_csr_aclk    : std_logic := '0';
signal s_axi_csr_araddr  : std_logic_vector ( 6 downto 0 ) := (others => '0');
signal s_axi_csr_aresetn : std_logic := '0';
signal s_axi_csr_arprot  : std_logic_vector ( 2 downto 0 ) := (others => '0');
signal s_axi_csr_arready : std_logic_vector ( 0 to 0 ) := (others => '0');
signal s_axi_csr_arvalid : std_logic_vector ( 0 to 0 ) := (others => '0');
signal s_axi_csr_awaddr  : std_logic_vector ( 6 downto 0 ) := (others => '0');
signal s_axi_csr_awprot  : std_logic_vector ( 2 downto 0 ) := (others => '0');
signal s_axi_csr_awready : std_logic_vector ( 0 to 0 ) := (others => '0');
signal s_axi_csr_awvalid : std_logic_vector ( 0 to 0 ) := (others => '0');
signal s_axi_csr_bready  : std_logic_vector ( 0 to 0 ) := (others => '0');
signal s_axi_csr_bresp   : std_logic_vector ( 1 downto 0 ) := (others => '0');
signal s_axi_csr_bvalid  : std_logic_vector ( 0 to 0 ) := (others => '0');
signal s_axi_csr_rdata   : std_logic_vector ( 31 downto 0 ) := (others => '0');
signal s_axi_csr_rready  : std_logic_vector ( 0 to 0 ) := (others => '0');
signal s_axi_csr_rresp   : std_logic_vector ( 1 downto 0 ) := (others => '0');
signal s_axi_csr_rvalid  : std_logic_vector ( 0 to 0 ) := (others => '0');
signal s_axi_csr_wdata   : std_logic_vector ( 31 downto 0 ) := (others => '0');
signal s_axi_csr_wready  : std_logic_vector ( 0 to 0 ) := (others => '0');
signal s_axi_csr_wstrb   : std_logic_vector ( 3 downto 0 ) := (others => '0');
signal s_axi_csr_wvalid  : std_logic_vector ( 0 to 0 ) := (others => '0');

signal spi_bit_cntr      : integer := 0;
signal lmx_spi_read      : std_logic := '0';
signal tb_done : std_logic := '0';

begin

s_axi_csr_aclk    <= not s_axi_csr_aclk after 2 ns;
s_axi_csr_aresetn <= '1' after 200 ns;

test_process: process
variable c_time : time    := 0 ns;
variable d_time : time    := 0 ns;
variable x      : integer := 5;

begin

   if(tb_done = '0') then
       wait for 400 ns;
       wait until rising_edge(s_axi_csr_aclk);
       
       --reset SPI interface
       px_axi_lite_writer(conv_std_logic_vector(0,7),conv_std_logic_vector(1,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid(0), s_axi_csr_awready(0), s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid(0), s_axi_csr_wready(0), s_axi_csr_bresp, s_axi_csr_bvalid(0), s_axi_csr_bready(0));
       px_axi_lite_writer(conv_std_logic_vector(0,7),conv_std_logic_vector(0,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid(0), s_axi_csr_awready(0), s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid(0), s_axi_csr_wready(0), s_axi_csr_bresp, s_axi_csr_bvalid(0), s_axi_csr_bready(0));
       
       --Write SPI Addres
       px_axi_lite_writer(conv_std_logic_vector(4,7),"0000000000000000000000000" & "1110011", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid(0), s_axi_csr_awready(0), s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid(0), s_axi_csr_wready(0), s_axi_csr_bresp, s_axi_csr_bvalid(0), s_axi_csr_bready(0));
       -- Write SPI Data
       px_axi_lite_writer(conv_std_logic_vector(8,7),X"0000" & X"F2E8", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid(0), s_axi_csr_awready(0), s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid(0), s_axi_csr_wready(0), s_axi_csr_bresp, s_axi_csr_bvalid(0), s_axi_csr_bready(0));

       if(write_read = '0') then
           -- Toogle Write BIT
           px_axi_lite_writer(conv_std_logic_vector(0,7),conv_std_logic_vector(2,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid(0), s_axi_csr_awready(0), s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid(0), s_axi_csr_wready(0), s_axi_csr_bresp, s_axi_csr_bvalid(0), s_axi_csr_bready(0));
           px_axi_lite_writer(conv_std_logic_vector(0,7),conv_std_logic_vector(0,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid(0), s_axi_csr_awready(0), s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid(0), s_axi_csr_wready(0), s_axi_csr_bresp, s_axi_csr_bvalid(0), s_axi_csr_bready(0));
           wait for 2000 ns;
       else
           -- Toogle Read BIT
           px_axi_lite_writer(conv_std_logic_vector(0,7),conv_std_logic_vector(4,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid(0), s_axi_csr_awready(0), s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid(0), s_axi_csr_wready(0), s_axi_csr_bresp, s_axi_csr_bvalid(0), s_axi_csr_bready(0));
           px_axi_lite_writer(conv_std_logic_vector(0,7),conv_std_logic_vector(0,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid(0), s_axi_csr_awready(0), s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid(0), s_axi_csr_wready(0), s_axi_csr_bresp, s_axi_csr_bvalid(0), s_axi_csr_bready(0));
           wait for 2000 ns;
       end if;
       
       tb_done <= '1';
       wait until rising_edge(s_axi_csr_aclk);
   else
       wait until rising_edge(s_axi_csr_aclk);
   end if;
end process;



dut: px_lmx2594rhaintrfc 
Port map
( 

    lmx_sdi        => lmx_sdi,    
    lmx_sclk       => lmx_sclk,   
    lmx_cs_n       => lmx_cs_n,   
    lmx_ce         => lmx_ce,     
    lmx_ld_sdo     => lmx_ld_sdo, 
    
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   -- DWORD Addressing
   --------------------------------------------------------------------------------
   s_axi_csr_aclk    => s_axi_csr_aclk,   
   s_axi_csr_araddr  => s_axi_csr_araddr, 
   s_axi_csr_aresetn => s_axi_csr_aresetn,
   s_axi_csr_arprot  => s_axi_csr_arprot, 
   s_axi_csr_arready => s_axi_csr_arready,
   s_axi_csr_arvalid => s_axi_csr_arvalid,
   s_axi_csr_awaddr  => s_axi_csr_awaddr, 
   s_axi_csr_awprot  => s_axi_csr_awprot, 
   s_axi_csr_awready => s_axi_csr_awready,
   s_axi_csr_awvalid => s_axi_csr_awvalid,
   s_axi_csr_bready  => s_axi_csr_bready, 
   s_axi_csr_bresp   => s_axi_csr_bresp,  
   s_axi_csr_bvalid  => s_axi_csr_bvalid, 
   s_axi_csr_rdata   => s_axi_csr_rdata,  
   s_axi_csr_rready  => s_axi_csr_rready, 
   s_axi_csr_rresp   => s_axi_csr_rresp,  
   s_axi_csr_rvalid  => s_axi_csr_rvalid, 
   s_axi_csr_wdata   => s_axi_csr_wdata,  
   s_axi_csr_wready  => s_axi_csr_wready, 
   s_axi_csr_wstrb   => s_axi_csr_wstrb,  
   s_axi_csr_wvalid  => s_axi_csr_wvalid  

);


process(lmx_sclk, lmx_cs_n) begin

    if(lmx_cs_n = '1') then
        spi_bit_cntr <= 0;
        lmx_spi_read <= '0';
        lmx_ld_sdo   <= '0';
    elsif(rising_edge(lmx_sclk)) then
        
        spi_bit_cntr <= spi_bit_cntr + 1;
        
        -- Read Cycle detected
        if(spi_bit_cntr = 0 and lmx_sdi = '1') then
        
            lmx_spi_read <= '1';    
            
        end if;
        
        if(lmx_spi_read = '1') then
       
            if(spi_bit_cntr >= 8) then
                lmx_ld_sdo <= read_data(23 - spi_bit_cntr);
                
            else
                lmx_ld_sdo <= '0';
            end if;
        end if;
    
    end if;

end process;

end Behavioral;
