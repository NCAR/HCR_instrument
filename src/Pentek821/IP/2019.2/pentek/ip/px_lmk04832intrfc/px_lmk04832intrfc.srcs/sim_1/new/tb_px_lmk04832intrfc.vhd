----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2017 03:26:17 PM
-- Design Name: 
-- Module Name: tb_px_lmk04832intrfc - Behavioral
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

use work.px_utility_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_lmk04832intrfc is
generic 
( 
    write_read : std_logic := '1';  -- 0 = write, 1 = read
    read_data : std_logic_vector(7 downto 0) := X"8B"

);
end tb_px_lmk04832intrfc;

architecture Behavioral of tb_px_lmk04832intrfc is

component px_lmk04832intrfc
Port 
( 
    

    lmk_sdio       : inout std_logic;     
    lmk_sclk       : out   std_logic;
    lmk_cs_n       : out   std_logic;     
    
    lmk_clkin_sel0 : out std_logic;
    lmk_clkin_sel1 : out std_logic;
    lmk_reset_gpo  : out std_logic;
    status_ld1     : in  std_logic;
    status_ld2     : in  std_logic;
    
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


signal lmk_sdio       : std_logic := 'Z';     
signal lmk_sclk       : std_logic := '0';
signal lmk_cs_n       : std_logic := '0';     

signal lmk_clkin_sel0 : std_logic := '0';
signal lmk_clkin_sel1 : std_logic := '0';
signal lmk_reset_gpo  : std_logic := '0';
signal status_ld1     : std_logic := '0';
signal status_ld2     : std_logic := '0';
               
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
signal lmk_spi_read      : std_logic := '0';
 

signal tb_done           : std_logic := '0';

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
       px_axi_lite_writer(conv_std_logic_vector(4,7),conv_std_logic_vector(10,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid(0), s_axi_csr_awready(0), s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid(0), s_axi_csr_wready(0), s_axi_csr_bresp, s_axi_csr_bvalid(0), s_axi_csr_bready(0));
       -- Write SPI Data
       px_axi_lite_writer(conv_std_logic_vector(8,7),conv_std_logic_vector(100,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid(0), s_axi_csr_awready(0), s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid(0), s_axi_csr_wready(0), s_axi_csr_bresp, s_axi_csr_bvalid(0), s_axi_csr_bready(0));

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

dut: px_lmk04832intrfc 
Port map 
( 
    

    lmk_sdio       => lmk_sdio,      
    lmk_sclk       => lmk_sclk,      
    lmk_cs_n       => lmk_cs_n,      
                    
    lmk_clkin_sel0 => lmk_clkin_sel0,
    lmk_clkin_sel1 => lmk_clkin_sel1,
    lmk_reset_gpo  => lmk_reset_gpo, 
    status_ld1     => status_ld1,   
    status_ld2     => status_ld2,    
    
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

process(lmk_sclk, lmk_cs_n) begin

    if(lmk_cs_n = '1') then
        spi_bit_cntr <= 0;
        lmk_spi_read <= '0';
        lmk_sdio     <= 'Z';
    elsif(rising_edge(lmk_sclk)) then
        
        spi_bit_cntr <= spi_bit_cntr + 1;
        
        -- Read Cycle detected
        if(spi_bit_cntr = 0 and lmk_sdio = '1') then
        
            lmk_spi_read <= '1';    
            
        end if;
        
        if(lmk_spi_read = '1') then
       
            if(spi_bit_cntr >= 16) then
                lmk_sdio <= read_data(23 - spi_bit_cntr);
                
            else
                lmk_sdio <= 'Z';
            end if;
        end if;
    
    end if;

end process;





end Behavioral;
