----------------------------------------------------------------------------------
-- Pentek AXI4-LITE to DDR4 Requester Test Bench
----------------------------------------------------------------------------------
-- tb_px_axil2ddr_rq .vhd
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

entity tb_px_axil2ddr_rq is
   generic (
       id      : integer := 0 -- range = 0 to 255 
   );
--  Port ( );
end tb_px_axil2ddr_rq;

architecture Behavioral of tb_px_axil2ddr_rq is

component px_axil2ddr_rq
generic ( 
    id      : integer := 0; -- range = 0 to 255 
    has_irq : boolean := true -- Has Interrupt Output when true. 
);
port (
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
    irq             : out std_logic;
   ----------------------------------------------------------------------------
    -- DDR4 Request Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    -- tuser[127:0]  = Request Header
    -- tuser[31:0]  = Address (Address must be aligned to the request size boundaries)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[35]    = Read = 1, Write = 0
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    m_axis_rqst_tvalid    : out std_logic;
    m_axis_rqst_tready    : in  std_logic;   
    m_axis_rqst_tlast     : out std_logic;
    m_axis_rqst_tid       : out std_logic_vector(7 downto 0);
    m_axis_rqst_tdata     : out std_logic_vector(511 downto 0); 
    m_axis_rqst_tuser     : out std_logic_vector(255 downto 0);
    ----------------------------------------------------------------------------
    -- DDR4 Response Interface (AXI Stream)
    ----------------------------------------------------------------------------
    -- tuser[127:0] = Response Header
    -- tuser[31:0]  = Address (Address must be aligned to the request size boundaries)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks 
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    s_axis_rsp_tvalid     : in  std_logic;
    s_axis_rsp_tlast      : in  std_logic;
    s_axis_rsp_tid        : in  std_logic_vector(7 downto 0);
    s_axis_rsp_tdata      : in  std_logic_vector(511 downto 0); 
    s_axis_rsp_tuser      : in  std_logic_vector(255 downto 0)
    );
end component px_axil2ddr_rq;


--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type test_mem_array_type is array(0 to 3) of std_logic_vector(511 downto 0); 

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
signal irq                  : std_logic := '0';
----------------------------------------------------------------------------
-- Request Interface (AXI Stream)
----------------------------------------------------------------------------  
 
signal m_axis_rqst_tvalid    : std_logic := '0';
signal m_axis_rqst_tready    : std_logic := '0';
signal m_axis_rqst_tlast     : std_logic := '0';
signal m_axis_rqst_tuser     : std_logic_vector(255 downto 0):= (others => '0');
signal m_axis_rqst_tdata     : std_logic_vector(511 downto 0):= (others => '0'); -- (not used for reads)
signal m_axis_rqst_tid       : std_logic_vector(7 downto 0):= (others => '0');
----------------------------------------------------------------------------
-- Response Interface (AXI Stream)
----------------------------------------------------------------------------  

signal s_axis_rsp_tvalid     : std_logic := '0';
signal s_axis_rsp_tlast      : std_logic := '0';
signal s_axis_rsp_tdata      : std_logic_vector(511 downto 0):= (others => '0'); -- unused fpr write responses
signal s_axis_rsp_tuser      : std_logic_vector(255 downto 0):= (others => '0');
signal s_axis_rsp_tid        : std_logic_vector(7 downto 0):= (others => '0');    

signal reset_done : std_logic := '0';

signal test_mem_array : test_mem_array_type;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
-- Register Addresses
constant DDR_ADDR_REG1: std_logic_vector(3 downto 0)       := x"0";
constant DDR_ADDR_REG2: std_logic_vector(3 downto 0)       := x"4";
constant DDR_DATA_REG : std_logic_vector(3 downto 0)       := x"8";

constant TEST_START_ADDRESS : std_logic_vector(33 downto 0)  := "00" & x"40000000";

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

uut: px_axil2ddr_rq
generic map(
id            =>  id     -- 0-31 Channel number (must be unique)  
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
   irq                  => irq,
   ----------------------------------------------------------------------------
   -- Request Interface (AXI Stream)
   ----------------------------------------------------------------------------
   m_axis_rqst_tvalid    => m_axis_rqst_tvalid,
   m_axis_rqst_tready    => m_axis_rqst_tready, 
   m_axis_rqst_tlast     => m_axis_rqst_tlast,   
   m_axis_rqst_tuser     => m_axis_rqst_tuser,  
   m_axis_rqst_tdata     => m_axis_rqst_tdata, 
   m_axis_rqst_tid       => m_axis_rqst_tid, 
   ----------------------------------------------------------------------------
   -- Response Interface (AXI Stream)
   ----------------------------------------------------------------------------    
   s_axis_rsp_tvalid     => s_axis_rsp_tvalid,
   s_axis_rsp_tlast      => '1',
   s_axis_rsp_tdata      => s_axis_rsp_tdata, 
   s_axis_rsp_tuser      => s_axis_rsp_tuser,
   s_axis_rsp_tid        => s_axis_rsp_tid 
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
   report "Writing 32 DWORDS to the Simulated RAM. Start Time = " & time'image(now)
   severity NOTE;
   assert false
   report "Taking Advantage of auto-increment mode, we only have to set the addresss once if data writes are to be contiguous."
   severity NOTE;
   -- Set the Desired DDR Address[31:0] 
   axi_lite_writer( DDR_ADDR_REG1,TEST_START_ADDRESS(31 downto 0), s_axi_aclk, s_axi_awaddr, s_axi_awprot, s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready);
   -- Set the Desired DDR Address[33:32] 
   axi_lite_writer( DDR_ADDR_REG2,(x"000000" & x"00"), s_axi_aclk, s_axi_awaddr, s_axi_awprot, s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready);
   for i in 0 to 31 loop
    axi_lite_writer( DDR_DATA_REG, conv_std_logic_vector(i, 32), s_axi_aclk, s_axi_awaddr, s_axi_awprot, s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready);
   end loop;
   assert false
   report "Writing of 32 DWORDS to the Simulated RAM is complete. End Time = " & time'image(now)
   severity NOTE;
   assert false
   report "Reading back and verifying 32 DWORD reads from the Simulated RAM. Start Time = " & time'image(now)
   severity NOTE;
   assert false
   report "Taking Advantage of auto-increment mode, we only have to set the addresss once if data reads are to be contiguous."
   severity NOTE;
   -- Set the Desired DDR Address[31:0] 
   axi_lite_writer( DDR_ADDR_REG1,TEST_START_ADDRESS(31 downto 0), s_axi_aclk, s_axi_awaddr, s_axi_awprot, s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready);
   -- Set the Desired DDR Address[34:32] and byte enables 
   axi_lite_writer( DDR_ADDR_REG2,(x"000000" & x"00"), s_axi_aclk, s_axi_awaddr, s_axi_awprot, s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready);
   for i in 0 to 31 loop
      axi_lite_reader( DDR_DATA_REG,conv_std_logic_vector(i, 32), '1', '1', s_axi_aclk, s_axi_araddr, s_axi_arprot, s_axi_arvalid, s_axi_arready, s_axi_rdata, s_axi_rresp, s_axi_rvalid, s_axi_rready);
   end loop;
   assert false
   report "Test End. Not a Failure. Writing of 32 DWORDS to the Simulated RAM is complete with no errors. End Time = " & time'image(now)
   severity FAILURE;   
end process;

--------------------------------------------------------------------------------
-- Request Handling
--------------------------------------------------------------------------------
-- tuser[31:0]  = Address (Address must be aligned to the request size boundaries)
-- tuser[34:32] = Future Address Expansion
-- tuser[35]    = Read = 1, Write = 0
-- tuser[39:36] = Reserved
-- tuser[119:40]= Byte Enables  


rqst_process: process

file MyFile: text;	
VARIABLE l : LINE; -- declare a line variable
variable addr: std_logic_vector(31 downto 0) :=(others => '0');

variable write_access: std_logic := '0';
variable tuser :  std_logic_vector(119 downto 0) :=(others => '0'); 
variable tid: std_logic_vector(7 downto 0) :=(others => '0');
 
begin
								
wait until reset_done = '1';
wait for 100 ns;
wait until rising_edge(s_axi_aclk);
wait for 0.5 ns; 
m_axis_rqst_tready    <= '1';
s_axis_rsp_tvalid     <= '0';
loop
    m_axis_rqst_tready    <= '1';
    if m_axis_rqst_tvalid = '0' then
        wait until (m_axis_rqst_tvalid = '1');
    end if;
    wait until rising_edge(s_axi_aclk);
    m_axis_rqst_tready    <= '0';
    addr := m_axis_rqst_tuser(31 downto 0);
    tuser:= m_axis_rqst_tuser(119 downto 0); 
    tid  := m_axis_rqst_tid;
    if (m_axis_rqst_tuser(35) = '0') then
        write_access := '1';
    else
        write_access := '0';
    end if; 
    if (write_access = '1') then
       if tuser(40) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(31 downto 0)   <=  m_axis_rqst_tdata(31 downto 0);
       end if;     
       if tuser(44) = '0' then
           test_mem_array(conv_integer(addr(7 downto 6)))(63 downto 32)   <=  m_axis_rqst_tdata(63 downto 32);
              end if; 
       if tuser(48) = '0' then
                   test_mem_array(conv_integer(addr(7 downto 6)))(95 downto 64)   <=  m_axis_rqst_tdata(95 downto 64);
              end if; 
       if tuser(52) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(127 downto 96)   <=  m_axis_rqst_tdata(127 downto 96);       
              end if; 
       if tuser(56) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(159 downto 128)   <=  m_axis_rqst_tdata(159 downto 128);       
              end if; 
       if tuser(60) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(191 downto 160)   <=  m_axis_rqst_tdata(191 downto 160);       
              end if; 
       if tuser(64) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(223 downto 192)   <=  m_axis_rqst_tdata(223 downto 192);       
              end if; 
       if tuser(68) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(255 downto 224)   <=  m_axis_rqst_tdata(255 downto 224);       
              end if; 
       if tuser(72) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(287 downto 256)   <=  m_axis_rqst_tdata(287 downto 256);       
              end if; 
       if tuser(76) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(319 downto 288)   <=  m_axis_rqst_tdata(319 downto 288);       
              end if; 
       if tuser(80) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(351 downto 320)   <=  m_axis_rqst_tdata(351 downto 320);       
              end if; 
       if tuser(84) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(383 downto 352)   <=  m_axis_rqst_tdata(383 downto 352);       
              end if; 
       if tuser(88) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(415 downto 384)   <=  m_axis_rqst_tdata(415 downto 384);       
              end if; 
       if tuser(92) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(447 downto 416)   <=  m_axis_rqst_tdata(447 downto 416);       
              end if; 
       if tuser(96) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(479 downto 448)   <=  m_axis_rqst_tdata(479 downto 448);
              end if; 
       if tuser(100) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(511 downto 480)   <=  m_axis_rqst_tdata(511 downto 480);
              end if; 
       if tuser(104) = '0' then
            test_mem_array(conv_integer(addr(7 downto 6)))(511 downto 480)   <=  m_axis_rqst_tdata(511 downto 480);
              end if; 
    end if;         
    wait until rising_edge(s_axi_aclk);
    wait until rising_edge(s_axi_aclk);
    wait until rising_edge(s_axi_aclk);
    wait until rising_edge(s_axi_aclk);
    wait for 0.5 ns;
    if (write_access = '0') then
       s_axis_rsp_tvalid             <= '1';
       s_axis_rsp_tdata <=  test_mem_array(conv_integer(addr(7 downto 6)))(511 downto 0); 
       s_axis_rsp_tuser <= x"0000000000000000000000000000000000" & tuser;
      
       s_axis_rsp_tid  <= tid;
       wait until rising_edge(s_axi_aclk);
       wait for 0.5 ns;
       s_axis_rsp_tvalid             <= '0';
       wait until rising_edge(s_axi_aclk);
       wait for 0.5 ns;
   end if;    
end loop;    

end process;




end Behavioral;
