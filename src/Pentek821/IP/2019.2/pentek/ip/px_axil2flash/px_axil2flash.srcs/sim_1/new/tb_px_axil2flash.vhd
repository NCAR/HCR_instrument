----------------------------------------------------------------------------------
-- Pentek AXI4-LITE to HMC Bridge Test Bench
----------------------------------------------------------------------------------
-- tb_px_axil2hmc .vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2015
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 
-- Simple example of 32 writes followed by 32 reads with read value verification. 
-- The Testbench ends if an error condition is reached or a value is incorrect.
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------

use std.textio.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_axil2flash  is

end tb_px_axil2flash ;

architecture Behavioral of tb_px_axil2flash  is

-- UUT
component px_axil2flash
generic (
   flash_addr_bits : integer := 24 -- number of FLASH Address bits
);
port( 
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
    s_axi_aclk      : in  std_logic;
    s_axi_aresetn   : in  std_logic;
    s_axi_awaddr    : in  std_logic_vector(3 downto 0);
    s_axi_awprot    : in  std_logic_vector(2 downto 0); -- not used
    s_axi_awvalid   : in  std_logic;
    s_axi_awready   : out std_logic;
    s_axi_wdata     : in  std_logic_vector(31 downto 0);
    s_axi_wstrb     : in  std_logic_vector(3 downto 0); -- not used
    s_axi_wvalid    : in  std_logic;
    s_axi_wready    : out std_logic;
    s_axi_bresp     : out std_logic_vector(1 downto 0);
    s_axi_bvalid    : out std_logic;
    s_axi_bready    : in  std_logic;
    s_axi_araddr    : in  std_logic_vector(3 downto 0);
    s_axi_arprot    : in  std_logic_vector(2 downto 0); -- not used
    s_axi_arvalid   : in  std_logic;
    s_axi_arready   : out std_logic;
    s_axi_rdata     : out std_logic_vector(31 downto 0);
    s_axi_rresp     : out std_logic_vector(1 downto 0);
    s_axi_rvalid    : out std_logic;
    s_axi_rready    : in  std_logic;
--------------------------------------------------------------------------------
-- Flash Interface
--------------------------------------------------------------------------------
    flash_d         : inout std_logic_vector(15 downto 0);
    flash_a         : out   std_logic_vector(flash_addr_bits-1 downto 0);
    flash_adv_b     : out   std_logic;
    flash_fwe_b     : out   std_logic;
    flash_fcs_b     : out   std_logic;
    flash_foe_b     : out   std_logic
);
end component;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type test_mem_array_type is array(0 to 255) of std_logic_vector(15 downto 0); 

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------


----------------------------------------------------------------------------
-- Control/Status Registers (AXI-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_aclk
signal s_axi_aclk           : std_logic := '0';
signal s_axi_aresetn        : std_logic := '0';
signal s_axi_awaddr         : std_logic_vector(3 downto 0) := (others => '0');
signal s_axi_awprot         : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_awvalid        : std_logic := '0';
signal s_axi_awready        : std_logic := '0';
signal s_axi_wdata          : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_wstrb          : std_logic_vector(3 downto 0) := (others => '0');
signal s_axi_wvalid         : std_logic := '0';
signal s_axi_wready         : std_logic := '0';
signal s_axi_bresp          : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_bvalid         : std_logic := '0';
signal s_axi_bready         : std_logic := '0';
signal s_axi_araddr         : std_logic_vector(3 downto 0) := (others => '0');
signal s_axi_arprot         : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_arvalid        : std_logic := '0';
signal s_axi_arready        : std_logic := '0';
signal s_axi_rdata          : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_rresp          : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_rvalid         : std_logic := '0';
signal s_axi_rready         : std_logic := '1';

--------------------------------------------------------------------------------
-- Flash Interface
--------------------------------------------------------------------------------
signal flash_d              : std_logic_vector(15 downto 0) := (others => '0');
signal flash_a              : std_logic_vector(23 downto 0) := (others => '0');
signal flash_adv_b          : std_logic := '1';
signal flash_fwe_b          : std_logic := '1';
signal flash_fcs_b          : std_logic := '1';
signal flash_foe_b          : std_logic := '1';

signal reset_done : std_logic := '0';

signal test_mem_array : test_mem_array_type;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
-- Register Addresses
constant FLASH_ADDR_REG : std_logic_vector(3 downto 0)       := x"0";
constant FLASH_DATA_REG : std_logic_vector(3 downto 0)       := x"4";

constant NBSP : CHARACTER      := CHARACTER'val(160);  -- space character
constant NUS  : STRING(2 to 1) := (others => ' ');     -- null STRING

--------------------------------------------------------------------------------
-- Functions
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Functions
--------------------------------------------------------------------------------

function To_Std_Logic(L: BOOLEAN) return std_logic is
begin
    if L then
       return('1');
    else
       return('0');
    end if;
end function To_Std_Logic;


function to_boolean (ivalue : std_logic) return BOOLEAN is
begin
    if ivalue = '0' then
        return false;
    else
        return true;
    end if;    
end function to_boolean;

function or_reduce (l : STD_ULOGIC_VECTOR) return STD_ULOGIC is
    variable result : STD_ULOGIC := '0';
  begin
    for i in l'reverse_range loop
      result := (l(i) or result);
    end loop;
    return result;
  end function or_reduce;

-- Convert to Hex String
function to_hstring (value     : STD_ULOGIC_VECTOR) return STRING is
    constant ne     : INTEGER := (value'length+3)/4;
    variable pad    : STD_ULOGIC_VECTOR(0 to (ne*4 - value'length) - 1);
    variable ivalue : STD_ULOGIC_VECTOR(0 to ne*4 - 1);
    variable result : STRING(1 to ne);
    variable quad   : STD_ULOGIC_VECTOR(0 to 3);
  begin
    if value'length < 1 then
      --return NUS;
    else
      if value (value'left) = 'Z' then
        pad := (others => 'Z');
      else
        pad := (others => '0');
      end if;
      ivalue := pad & value;
      for i in 0 to ne-1 loop
        quad := To_X01Z(ivalue(4*i to 4*i+3));
        case quad is
          when x"0"   => result(i+1) := '0';
          when x"1"   => result(i+1) := '1';
          when x"2"   => result(i+1) := '2';
          when x"3"   => result(i+1) := '3';
          when x"4"   => result(i+1) := '4';
          when x"5"   => result(i+1) := '5';
          when x"6"   => result(i+1) := '6';
          when x"7"   => result(i+1) := '7';
          when x"8"   => result(i+1) := '8';
          when x"9"   => result(i+1) := '9';
          when x"A"   => result(i+1) := 'A';
          when x"B"   => result(i+1) := 'B';
          when x"C"   => result(i+1) := 'C';
          when x"D"   => result(i+1) := 'D';
          when x"E"   => result(i+1) := 'E';
          when x"F"   => result(i+1) := 'F';
          when "ZZZZ" => result(i+1) := 'Z';
          when others => result(i+1) := 'X';
        end case;
      end loop;
      return result;
    end if;
  end function to_hstring;


--------------------------------------------------------------------------------
-- Procedures
--------------------------------------------------------------------------------

procedure axi_lite_writer(
    constant addr      : in std_logic_vector;
    constant val       : in std_logic_vector(31 downto 0);
    signal axi_aclk    : in std_logic;
    signal axi_awaddr  : out  std_logic_vector;
    signal axi_awprot  : out  std_logic_vector(2 downto 0);
    signal axi_awvalid : out  std_logic;
    signal axi_awready : in   std_logic;
    signal axi_wdata   : out  std_logic_vector(31 downto 0);
    signal axi_wstrb   : out  std_logic_vector(3 downto 0);
    signal axi_wvalid  : out  std_logic;
    signal axi_wready  : in   std_logic;
    signal axi_bresp   : in   std_logic_vector(1 downto 0);
    signal axi_bvalid  : in   std_logic;
    signal axi_bready  : out  std_logic
    ) is
    begin
        assert false
        report "Writing x" & (to_hstring(To_StdULogicVector(val))) & " to Address: x" &  (to_hstring(To_StdULogicVector(addr)))
        severity NOTE;
        wait until rising_edge(axi_aclk);
        wait for 1 ns;
        axi_awaddr           <= addr; -- Byte Address
        axi_awprot           <= "000";
        axi_awvalid          <= '1';
        axi_wvalid           <= '1';
        axi_wdata            <= val;
        axi_wstrb            <= "1111";
        axi_bready           <= '1';
        while ((axi_awready = '0') and (axi_wready = '0')) loop
            wait until rising_edge(axi_aclk);
            wait for 1 ns;
        end loop;
        if (axi_awready = '1') and (axi_wready = '1') then
            wait until rising_edge(axi_aclk);
            wait for 1 ns; 
            axi_awvalid         <= '0';
            axi_wvalid          <= '0';
            axi_wstrb           <= "0000";
        elsif (axi_awready = '1') then
            wait until rising_edge(axi_aclk);
            wait for 1 ns; 
            axi_awvalid          <= '0';
            while (axi_wready = '0') loop
                wait until rising_edge(axi_aclk);
                wait for 1 ns;
            end loop;
            wait until rising_edge(axi_aclk);
            wait for 1 ns; 
            axi_wvalid          <= '0';
            axi_wstrb           <= "0000";
        else
            wait until rising_edge(axi_aclk);
            wait for 1 ns; 
            axi_wvalid          <= '0';
            axi_wstrb           <= "0000";
            while (axi_awready = '0') loop
                wait until rising_edge(axi_aclk);
                wait for 1 ns;
            end loop;
            wait until rising_edge(axi_aclk);
            wait for 1 ns; 
            axi_awvalid         <= '0';
        end if;
        while (axi_bvalid = '0') loop
            wait until rising_edge(axi_aclk);
            wait for 1 ns;
        end loop;
        wait until rising_edge(axi_aclk);
        wait for 1 ns;             
        axi_bready           <= '0';
        if (axi_bresp = "00") or (axi_bresp = "01") then
            assert false
            report "Write completed at time = " & time'image(now)
            severity NOTE;
        else
            assert false
            report "Write completed with error at time = " & time'image(now)
            severity NOTE;
        end if;          
end;

procedure axi_lite_reader(
    constant addr            : in std_logic_vector;
    constant val             : in std_logic_vector(31 downto 0); -- comparision value
    constant comp            : in std_logic; -- '1' = allow compare
    constant fail_on_error   : in std_logic; -- '1' = allow failure on error    
    signal axi_aclk          : in std_logic; 
    signal axi_araddr        : out std_logic_vector;
    signal axi_arprot        : out std_logic_vector(2 downto 0);
    signal axi_arvalid       : out std_logic;
    signal axi_arready       : in std_logic;
    signal axi_rdata         : in std_logic_vector(31 downto 0);
    signal axi_rresp         : in std_logic_vector(1 downto 0);
    signal axi_rvalid        : in std_logic;
    signal axi_rready        : out std_logic
    ) is
    begin
        assert false
        report "Reading Address: x" &  (to_hstring(To_StdULogicVector(addr)))
        severity NOTE;
        wait until rising_edge(axi_aclk);
        wait for 1 ns;
        axi_araddr          <= addr; -- Byte Address
        axi_arprot           <= "000";
        axi_arvalid          <= '1';
        while (axi_arready = '0') loop
            wait until rising_edge(axi_aclk);
            wait for 1 ns;
        end loop;
        wait until rising_edge(axi_aclk);
        wait for 1 ns; 
        axi_arvalid          <= '0';
        axi_rready           <= '1';
        while (axi_rvalid = '0') loop
           wait until rising_edge(axi_aclk);
        end loop;
        wait until rising_edge(axi_aclk);
        wait for 1 ns; 
        if (axi_rresp(1) = '1') then
            assert false
            report "Read Response Error at time = " & time'image(now)
            severity FAILURE;            
        end if; 
        --axi_rready           <= '0';
        if (comp = '1') then
            assert false
            report "Value is: x" &  (to_hstring(To_StdULogicVector(axi_rdata))) & " Should be: x" &  (to_hstring(To_StdULogicVector(val)))
            severity NOTE;
        else
            assert false
            report "Value is: x" &  (to_hstring(To_StdULogicVector(axi_rdata)))
            severity NOTE;
        end if;    
    
        if (val = axi_rdata) or (comp = '0') then
            assert false
            report "Read completed successfully at time = " & time'image(now)
            severity NOTE;
        else
            if (fail_on_error = '1') then
                assert false
                report "Read error at time = " & time'image(now)
                severity FAILURE;            
            else
                assert false
                report "Read error at time = " & time'image(now)
                severity NOTE;               
            end if;
        end if;    
              
end;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

begin

uut: px_axil2flash
generic map(
  flash_addr_bits => 24
)
port map(
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI-LITE)
   ----------------------------------------------------------------------------
   -- associated with s_axi_aclk
   s_axi_aclk           => s_axi_aclk,   
   s_axi_aresetn        => s_axi_aresetn,
   s_axi_awaddr         => s_axi_awaddr, 
   s_axi_awprot         => s_axi_awprot, 
   s_axi_awvalid        => s_axi_awvalid,
   s_axi_awready        => s_axi_awready,
   s_axi_wdata          => s_axi_wdata,  
   s_axi_wstrb          => s_axi_wstrb,  
   s_axi_wvalid         => s_axi_wvalid, 
   s_axi_wready         => s_axi_wready, 
   s_axi_bresp          => s_axi_bresp, 
   s_axi_bvalid         => s_axi_bvalid, 
   s_axi_bready         => s_axi_bready, 
   s_axi_araddr         => s_axi_araddr, 
   s_axi_arprot         => s_axi_arprot, 
   s_axi_arvalid        => s_axi_arvalid,
   s_axi_arready        => s_axi_arready,
   s_axi_rdata          => s_axi_rdata,  
   s_axi_rresp          => s_axi_rresp, 
   s_axi_rvalid         => s_axi_rvalid, 
   s_axi_rready         => s_axi_rready, 
   --------------------------------------------------------------------------------
   -- Flash Interface
   --------------------------------------------------------------------------------
   flash_d              => flash_d,    
   flash_a              => flash_a,    
   flash_adv_b          => flash_adv_b,
   flash_fwe_b          => flash_fwe_b,
   flash_fcs_b          => flash_fcs_b,
   flash_foe_b          => flash_foe_b
   );   
   
--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------

-- CSR Clock = 250MHz
process
begin
    loop
        s_axi_aclk <= not s_axi_aclk;
        wait for 2 ns;
    end loop;
end process;


process
begin
wait for 400 ns;
s_axi_aresetn <= '1';
wait for 40 ns;
reset_done <= '1';
wait;
end process;

tst_process: process
begin
   wait until reset_done = '1';
   assert false
   report "Writing 32 DWORDS to the FLASH. Start Time = " & time'image(now)
   severity NOTE;
   assert false
   report "Taking Advantage of auto-increment mode, we only have to set the addresss once if data writes are to be contiguous."
   severity NOTE;
   -- Set the Desired FLASH Address[31:0] = 0x00000000 
   axi_lite_writer( FLASH_ADDR_REG,x"00000000", s_axi_aclk, s_axi_awaddr, s_axi_awprot, s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready);
   for i in 0 to 31 loop
    axi_lite_writer( FLASH_DATA_REG,conv_std_logic_vector(i, 32), s_axi_aclk, s_axi_awaddr, s_axi_awprot, s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready);
   end loop;
   assert false
   report "Writing of 32 DWORDS to the FLASH is complete. End Time = " & time'image(now)
   severity NOTE;
   assert false
   report "Reading back and verifying 32 DWORD reads from the FLASH. Start Time = " & time'image(now)
   severity NOTE;
   assert false
   report "Taking Advantage of auto-increment mode, we only have to set the addresss once if data reads are to be contiguous."
   severity NOTE;
   -- Set the Desired Flash Address[31:0] = 0x00000000 
   axi_lite_writer( FLASH_ADDR_REG,x"00000000", s_axi_aclk, s_axi_awaddr, s_axi_awprot, s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready);
   for i in 0 to 31 loop
      axi_lite_reader( FLASH_DATA_REG,conv_std_logic_vector(i, 32), '1', '1', s_axi_aclk, s_axi_araddr, s_axi_arprot, s_axi_arvalid, s_axi_arready, s_axi_rdata, s_axi_rresp, s_axi_rvalid, s_axi_rready);
   end loop;
   assert false
   report "Test End. Not a Failure. Writing of 32 DWORDS to the FLASH is complete with no errors. End Time = " & time'image(now)
   severity FAILURE;   
end process;

--------------------------------------------------------------------------------
-- Flash Access Handling
--------------------------------------------------------------------------------

process(flash_fwe_b)
begin
   if rising_edge(flash_fwe_b) then
      if (flash_fcs_b = '0') then
         test_mem_array(conv_integer(flash_a(7 downto 0)))(15 downto 0)   <=  flash_d;
      end if;   
   end if;
end process;

flash_d <= test_mem_array(conv_integer(flash_a(7 downto 0)))(15 downto 0) when (flash_foe_b = '0') else (others => 'Z');


end Behavioral;

