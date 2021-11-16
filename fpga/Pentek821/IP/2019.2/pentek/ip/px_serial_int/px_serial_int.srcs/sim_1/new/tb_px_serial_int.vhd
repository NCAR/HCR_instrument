----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/30/2017 10:24:54 AM
-- Design Name: 
-- Module Name: tb_px_serial_int - Behavioral
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
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity tb_px_serial_int is

generic 
(

   data_reg_width : integer := 8;
   addr_reg_width : integer := 15;
   
   -- 0 for 3-wire, 1 for 4-wire
   bustype_3wire_4wire : std_logic := '0';
   
   -- Select to test read or write
   wr_rd_test     : std_logic := '1'; -- 0 for a write test, 1 for read
   
   -- Data to read or write
   data_in_start   : integer := 0;
   addr_start      : integer := 0;
   read_data_start : integer := 0;
   
   -- Verify read or write data
   
   RD_WR_POL      : std_logic := '0' 

);

end tb_px_serial_int;

architecture Behavioral of tb_px_serial_int is

constant clk_in_half_p : time := 2.0 ns;

signal start_test     : std_logic := '0';

signal clk_in    : std_logic := '0'; 
signal rst_n     : std_logic := '0';
signal data_in   : std_logic_vector(data_reg_width - 1 downto 0) := (others => '0');
signal addr      : std_logic_vector(addr_reg_width - 1 downto 0) := (others => '0');
signal wr        : std_logic := '0';
signal rd        : std_logic := '0';
signal data_out  : std_logic_vector(data_reg_width - 1 downto 0) := (others => '0');
signal sm_rdy    : std_logic := '0';
-- serial signals
signal sdi       : std_logic := '0';
signal sdenb     : std_logic := '0';
signal sclk      : std_logic := '0';
signal sdo       : std_logic := '0';

signal sdenb_reg1  : std_logic := '0';
signal sdenb_reg2  : std_logic := '0';

signal verify_state       : std_logic_vector(2 downto 0) := "001";

signal serial_length      : integer := (1 + data_reg_width + addr_reg_width);
signal addr_bit_cntr      : integer := 0;
signal data_bit_cntr      : integer := 0;

signal read_back_reg      : std_logic_vector(data_reg_width - 1 downto 0) := (others => '0'); 

signal error               : std_logic := '0';
signal addr_error          : std_logic := '0';
signal data_error          : std_logic := '0';
signal data_readback_error : std_logic := '0';



component px_serial_int 
generic 
(
   data_reg_width : integer := 16;
   addr_reg_width : integer := 16;
   
   -- 0 - to use module as a three wire interface
   -- 1 - to use module as a four wire interface
   bustype_3wire_4wire    : std_logic := '0';
   
   -- 0 - for RD = '1' and Write = '0' the write/read polarity on SDI bus line
   -- 1 - for RD = '0' and Write = '1' the write/read polarity on SDI bus line
   RD_WR_POL      : std_logic := '1'
);
port 
(
   -- Interal Interface Signals
   clk_in    : in  std_logic; 
   rst_n     : in  std_logic;
   data_in   : in  std_logic_vector(data_reg_width - 1 downto 0);
   addr      : in  std_logic_vector(addr_reg_width - 1 downto 0);
   wr        : in  std_logic;
   rd        : in  std_logic;
   data_out  : out std_logic_vector(data_reg_width - 1 downto 0);
   sm_rdy    : out std_logic;
   -- serial interface signals
   sdi       : inout std_logic;
   sdenb     : out std_logic;
   sclk      : out std_logic;
   sdo       : in  std_logic
);
end component;

begin

clk_in   <= not clk_in after clk_in_half_p;
rst_n    <= '1' after 100 ns;

start_test <= '1' after 200 ns;



process(clk_in) begin

    if(rising_edge(clk_in)) then
    
        if(start_test = '1') then
            
            if(wr_rd_test = '0') then
                wr <= sm_rdy after 300 ns;
            else
                rd <= sm_rdy after 300 ns;
            end if;
        
        end if;
    
    end if;

end process;


dut: px_serial_int 
generic map 
(
   data_reg_width => data_reg_width,
   addr_reg_width => addr_reg_width,
   
   -- 0 - to use module as a three wire interface
   -- 1 - to use module as a four wire interface
   bustype_3wire_4wire    => bustype_3wire_4wire,
   
   -- 0 - for RD = '1' and Write = '0' the write/read polarity on SDI bus line
   -- 1 - for RD = '0' and Write = '1' the write/read polarity on SDI bus line
   RD_WR_POL      => RD_WR_POL
)
port map
(
   clk_in    => clk_in, 
   rst_n     => rst_n,
   data_in   => data_in,
   addr      => addr,
   wr        => wr,
   rd        => rd,
   data_out  => data_out,
   sm_rdy    => sm_rdy,
   -- adc serial signals
   sdi       => sdi,  
   sdenb     => sdenb,
   sclk      => sclk, 
   sdo       => sdo  
);


verification: process(sdenb, sclk) begin

    if(sdenb = '1') then
        verify_state  <= "001";
        addr_bit_cntr <= 0;
        data_bit_cntr <= 0;
        sdo           <= '0';
        sdi           <= 'Z';
    elsif(rising_edge(sclk)) then
    
        -- Verify whether its a read or write    
        if(verify_state = "001") then
            
            if(wr_rd_test = '0' and sdi /= '0') then
                error <= '1';
            elsif(wr_rd_test = '1' and sdi /= '1') then
                error <= '1';
            end if;
            
            verify_state    <= "010";
            addr_bit_cntr   <= 0;
        end if;
        
        -- Verify correct address
        if(verify_state = "010") then
          
            if(addr(addr_reg_width - 1 - addr_bit_cntr) /= sdi) then
                addr_error <= '1';
            end if;
            
            if(addr_bit_cntr = addr_reg_width - 1) then
                if(wr_rd_test = '0') then
                    verify_state <= "100";
                else
                    verify_state <= "101";
                end if;
            end if;
        
            addr_bit_cntr <= addr_bit_cntr + 1;
        end if;
        
        -- Verify write data
        if(verify_state = "100") then
          
            if(data_in(data_reg_width - 1 - data_bit_cntr) /= sdi) then
                data_error <= '1';
            end if;
            
            if(data_bit_cntr = data_reg_width - 1) then
                verify_state <= "001";
            end if;
        
            data_bit_cntr <= data_bit_cntr + 1;
        end if;
        
        if(verify_state = "101") then
            
            data_bit_cntr <= data_bit_cntr + 1;
            
            if(data_bit_cntr = data_reg_width - 1) then
                verify_state <= "110";
            end if;
            
        end if;
        
        if(verify_state = "110") then
            verify_state <= "001";
        end if;
        
    end if;
    
    if(falling_edge(sclk)) then
        if(verify_state = "101") then
            
            if(bustype_3wire_4wire = '0') then
                sdi <= read_back_reg(data_reg_width - 1 - data_bit_cntr);
            else
                sdo <= read_back_reg(data_reg_width - 1 - data_bit_cntr);
            end if;
        end if;
        
    end if;

end process;
                
process(clk_in) begin
    if(rising_edge(clk_in)) then
        
        sdenb_reg1 <= sdenb;  
        sdenb_reg2 <= sdenb_reg1;
    
        if(start_test = '1' and sdenb_reg1 = '1' and sdenb_reg2 = '0') then
        
            addr          <= addr + '1';
        
            if(wr_rd_test = '0') then  
                data_in       <= data_in + '1';
            else
                if(read_back_reg /= data_out) then
                    data_readback_error <= '1';
                end if;
                read_back_reg <= read_back_reg + '1';
                
            end if;
        end if;
    end if;
end process;
                

end Behavioral;
