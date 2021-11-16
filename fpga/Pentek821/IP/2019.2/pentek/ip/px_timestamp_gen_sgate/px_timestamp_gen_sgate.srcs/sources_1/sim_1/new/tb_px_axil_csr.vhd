----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2015 06:09:44 PM
-- Design Name: 
-- Module Name: tb_px_axil_csr - Behavioral
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

entity tb_px_axil_csr is
generic (
   num_addr_bits     : integer := 7; -- Number of address bits 3-7 (Must agree with number of registers
   num_ctl_regs      : integer := 8; -- Number of Control Registers - 0 through 8
   num_stat_regs     : integer := 8; -- Number of Status Registers - 0 through 8
   num_interrupt_regs: integer := 1; -- Number of Interrupt Registers - 0 or 1
   num_interrupt_src : integer := 16 -- Number of Interrupt Source bits - 0 to 32 
);
end tb_px_axil_csr;

architecture Behavioral of tb_px_axil_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_axil_csr
generic (
   num_addr_bits     : integer := 7; -- Number of address bits 3-7 (Must agree with number of registers
   num_ctl_regs      : integer := 8; -- Number of Control Registers - 0 through 8
   num_stat_regs     : integer := 8; -- Number of Status Registers - 0 through 8
   num_interrupt_regs: integer := 1; -- Number of Interrupt Registers - 0 or 1
   num_interrupt_src : integer := 16 -- Number of Interrupt Source bits - 0 to 32 
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(num_addr_bits-1 downto 0);
   s_axi_csr_awprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid   : in  std_logic;
   s_axi_csr_awready   : out std_logic;
   s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0); -- not used
   s_axi_csr_wvalid    : in  std_logic;
   s_axi_csr_wready    : out std_logic;
   s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid    : out std_logic;
   s_axi_csr_bready    : in  std_logic;
   s_axi_csr_araddr    : in  std_logic_vector(num_addr_bits-1 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;
--------------------------------------------------------------------------------
-- Control Register Init Values
-------------------------------------------------------------------------------- 
   reg0_init_val   : in  std_logic_vector(31 downto 0);
   reg1_init_val   : in  std_logic_vector(31 downto 0);
   reg2_init_val   : in  std_logic_vector(31 downto 0);
   reg3_init_val   : in  std_logic_vector(31 downto 0);
   reg4_init_val   : in  std_logic_vector(31 downto 0);
   reg5_init_val   : in  std_logic_vector(31 downto 0);
   reg6_init_val   : in  std_logic_vector(31 downto 0);
   reg7_init_val   : in  std_logic_vector(31 downto 0);   
--------------------------------------------------------------------------------
-- Control Register Outputs
--------------------------------------------------------------------------------
   ctl0_out        : out std_logic_vector(31 downto 0);
   ctl1_out        : out std_logic_vector(31 downto 0);
   ctl2_out        : out std_logic_vector(31 downto 0);
   ctl3_out        : out std_logic_vector(31 downto 0);
   ctl4_out        : out std_logic_vector(31 downto 0);
   ctl5_out        : out std_logic_vector(31 downto 0);
   ctl6_out        : out std_logic_vector(31 downto 0);
   ctl7_out        : out std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------
-- Status Register Inputs
--------------------------------------------------------------------------------
   stat0_in        : in  std_logic_vector(31 downto 0);
   stat1_in        : in  std_logic_vector(31 downto 0);
   stat2_in        : in  std_logic_vector(31 downto 0);
   stat3_in        : in  std_logic_vector(31 downto 0);
   stat4_in        : in  std_logic_vector(31 downto 0);
   stat5_in        : in  std_logic_vector(31 downto 0);
   stat6_in        : in  std_logic_vector(31 downto 0);
   stat7_in        : in  std_logic_vector(31 downto 0);  
--------------------------------------------------------------------------------
-- Interrupt
--------------------------------------------------------------------------------
   intrpt_src_in   : in  std_logic_vector(num_interrupt_src-1 downto 0);        
   irq             : out std_logic
);
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
signal  s_axi_csr_aclk      : std_logic := '0';
signal  s_axi_csr_aresetn   : std_logic := '0';
signal  s_axi_csr_awaddr    : std_logic_vector(num_addr_bits-1  downto 0):= (others => '0');
signal  s_axi_csr_awprot    : std_logic_vector(2 downto 0):= (others => '0'); -- not used
signal  s_axi_csr_awvalid   : std_logic := '0';
signal  s_axi_csr_awready   : std_logic := '0';
signal  s_axi_csr_wdata     : std_logic_vector(31 downto 0):= (others => '0');
signal  s_axi_csr_wstrb     : std_logic_vector(3 downto 0):= (others => '0'); -- not used
signal  s_axi_csr_wvalid    : std_logic := '0';
signal  s_axi_csr_wready    : std_logic := '0';
signal  s_axi_csr_bresp     : std_logic_vector(1 downto 0):= (others => '0');
signal  s_axi_csr_bvalid    : std_logic := '0';
signal  s_axi_csr_bready    : std_logic := '0';
signal  s_axi_csr_araddr    : std_logic_vector(num_addr_bits-1  downto 0);
signal  s_axi_csr_arprot    : std_logic_vector(2 downto 0); -- not used
signal  s_axi_csr_arvalid   : std_logic := '0';
signal  s_axi_csr_arready   : std_logic := '0';
signal  s_axi_csr_rdata     : std_logic_vector(31 downto 0):= (others => '0');
signal  s_axi_csr_rresp     : std_logic_vector(1 downto 0):= (others => '0');
signal  s_axi_csr_rvalid    : std_logic := '0';
signal  s_axi_csr_rready    : std_logic := '0';
--------------------------------------------------------------------------------
-- Control Register Init Values
-------------------------------------------------------------------------------- 
signal  reg0_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg1_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg2_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg3_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg4_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg5_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg6_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg7_init_val   : std_logic_vector(31 downto 0) := x"00000000";   
--------------------------------------------------------------------------------
-- Control Register Outputs
--------------------------------------------------------------------------------
signal  ctl0_out        : std_logic_vector(31 downto 0);
signal  ctl1_out        : std_logic_vector(31 downto 0);
signal  ctl2_out        : std_logic_vector(31 downto 0);
signal  ctl3_out        : std_logic_vector(31 downto 0);
signal  ctl4_out        : std_logic_vector(31 downto 0);
signal  ctl5_out        : std_logic_vector(31 downto 0);
signal  ctl6_out        : std_logic_vector(31 downto 0);
signal  ctl7_out        : std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------
-- Status Register Inputs
--------------------------------------------------------------------------------
signal  stat0_in        : std_logic_vector(31 downto 0) := x"00000000";
signal  stat1_in        : std_logic_vector(31 downto 0) := x"10000000";
signal  stat2_in        : std_logic_vector(31 downto 0) := x"20000000";
signal  stat3_in        : std_logic_vector(31 downto 0) := x"30000000";
signal  stat4_in        : std_logic_vector(31 downto 0) := x"40000000";
signal  stat5_in        : std_logic_vector(31 downto 0) := x"50000000";
signal  stat6_in        : std_logic_vector(31 downto 0) := x"60000000";
signal  stat7_in        : std_logic_vector(31 downto 0) := x"70000000";  
--------------------------------------------------------------------------------
-- Interrupt
--------------------------------------------------------------------------------
signal  intrpt_src_in   : std_logic_vector(num_interrupt_src-1 downto 0) := (others => '0');        
signal  irq             : std_logic;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant NBSP : CHARACTER      := CHARACTER'val(160);  -- space character
constant NUS  : STRING(2 to 1) := (others => ' ');     -- null STRING

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

  -- purpose: Skips white space
  procedure skip_whitespace (
    L : inout LINE) is
    variable readOk : BOOLEAN;
    variable c : CHARACTER;
  begin
    while L /= null and L.all'length /= 0 loop
      if (L.all(1) = ' ' or L.all(1) = NBSP or L.all(1) = HT) then
        read (l, c, readOk);
      else
        exit;
      end if;
    end loop;
  end procedure skip_whitespace;

  procedure Char2QuadBits (C           :     CHARACTER;
                           RESULT      : out STD_ULOGIC_VECTOR(3 downto 0);
                           GOOD        : out BOOLEAN;
                           ISSUE_ERROR : in  BOOLEAN) is
  begin
    case c is
      when '0'       => result := x"0"; good := true;
      when '1'       => result := x"1"; good := true;
      when '2'       => result := x"2"; good := true;
      when '3'       => result := x"3"; good := true;
      when '4'       => result := x"4"; good := true;
      when '5'       => result := x"5"; good := true;
      when '6'       => result := x"6"; good := true;
      when '7'       => result := x"7"; good := true;
      when '8'       => result := x"8"; good := true;
      when '9'       => result := x"9"; good := true;
      when 'A' | 'a' => result := x"A"; good := true;
      when 'B' | 'b' => result := x"B"; good := true;
      when 'C' | 'c' => result := x"C"; good := true;
      when 'D' | 'd' => result := x"D"; good := true;
      when 'E' | 'e' => result := x"E"; good := true;
      when 'F' | 'f' => result := x"F"; good := true;
      when 'Z'       => result := "ZZZZ"; good := true;
      when 'X'       => result := "XXXX"; good := true;
      when others =>
        assert not ISSUE_ERROR
          report
          "STD_LOGIC_1164.HREAD Read a '" & c &
          "', expected a Hex character (0-F)."
          severity error;
        good := false;
    end case;
  end procedure Char2QuadBits;

-- Hex Read
procedure HREAD (L    : inout LINE; VALUE : out STD_ULOGIC_VECTOR;
                   GOOD : out   BOOLEAN) is
    variable ok  : BOOLEAN;
    variable c   : CHARACTER;
    constant ne  : INTEGER := (VALUE'length+3)/4;
    constant pad : INTEGER := ne*4 - VALUE'length;
    variable sv  : STD_ULOGIC_VECTOR(0 to ne*4 - 1);
    variable i   : INTEGER;
    variable lastu  : BOOLEAN := false;       -- last character was an "_"
  begin
    VALUE := (VALUE'range => 'U'); -- initialize to a "U"
    Skip_whitespace (L);
    if VALUE'length > 0 then
      read (l, c, ok);
      i := 0;
      while i < ne loop
        -- Bail out if there was a bad read
        if not ok then
          good := false;
          return;
        elsif c = '_' then
          if i = 0 then
            good := false;                -- Begins with an "_"
            return;
          elsif lastu then
            good := false;                -- "__" detected
            return;
          else
            lastu := true;
          end if;
        else
          Char2QuadBits(c, sv(4*i to 4*i+3), ok, false);
          if not ok then
            good := false;
            return;
          end if;
          i := i + 1;
          lastu := false;
        end if;
        if i < ne then
          read(L, c, ok);
        end if;
      end loop;
      if or_reduce (sv (0 to pad-1)) = '1' then  -- %%% replace with "or"
        good := false;                           -- vector was truncated.
      else
        good  := true;
        VALUE := sv (pad to sv'high);
      end if;
    else
      good := true;                     -- Null input string, skips whitespace
    end if;
  end procedure HREAD;


procedure axi_lite_writer(
    constant addr: in std_logic_vector;
    constant val : in std_logic_vector(31 downto 0);
    constant addr_bits: in integer; -- number of address bits
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
            axi_wstrb               <= "0000";
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
            axi_wstrb               <= "0000";
        else
            wait until rising_edge(axi_aclk);
            wait for 1 ns; 
            axi_wvalid          <= '0';
            axi_wstrb               <= "0000";
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
        if axi_bresp = "00" then
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
    constant addr: in std_logic_vector;
    constant val : in std_logic_vector(31 downto 0); -- comparision value
    constant addr_bits: in integer; -- number of address bits
    constant comp : in std_logic; -- '1' = allow compare
    constant fail_on_error : in std_logic; -- '1' = allow failure on error    
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

begin

uut: px_axil_csr
generic map (
   num_addr_bits     => num_addr_bits,      -- Number of address bits 3-7 (Must agree with number of registers
   num_ctl_regs      => num_ctl_regs,       -- Number of Control Registers - 0 through 8
   num_stat_regs     => num_stat_regs,      -- Number of Status Registers - 0 through 8
   num_interrupt_regs=> num_interrupt_regs, -- Number of Interrupt Registers - 0 or 1
   num_interrupt_src => num_interrupt_src  -- Number of Interrupt Source bits - 0 to 32 
)
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk        => s_axi_csr_aclk,   
   s_axi_csr_aresetn     => s_axi_csr_aresetn,
   s_axi_csr_awaddr      => s_axi_csr_awaddr, 
   s_axi_csr_awprot      => s_axi_csr_awprot, 
   s_axi_csr_awvalid     => s_axi_csr_awvalid,
   s_axi_csr_awready     => s_axi_csr_awready,
   s_axi_csr_wdata       => s_axi_csr_wdata,  
   s_axi_csr_wstrb       => s_axi_csr_wstrb,  
   s_axi_csr_wvalid      => s_axi_csr_wvalid, 
   s_axi_csr_wready      => s_axi_csr_wready, 
   s_axi_csr_bresp       => s_axi_csr_bresp,  
   s_axi_csr_bvalid      => s_axi_csr_bvalid, 
   s_axi_csr_bready      => s_axi_csr_bready, 
   s_axi_csr_araddr      => s_axi_csr_araddr, 
   s_axi_csr_arprot      => s_axi_csr_arprot, 
   s_axi_csr_arvalid     => s_axi_csr_arvalid,
   s_axi_csr_arready     => s_axi_csr_arready,
   s_axi_csr_rdata       => s_axi_csr_rdata,  
   s_axi_csr_rresp       => s_axi_csr_rresp,  
   s_axi_csr_rvalid      => s_axi_csr_rvalid, 
   s_axi_csr_rready      => s_axi_csr_rready, 
--------------------------------------------------------------------------------
-- Control Register Init Values
-------------------------------------------------------------------------------- 
   reg0_init_val     => reg0_init_val,
   reg1_init_val     => reg1_init_val,
   reg2_init_val     => reg2_init_val,
   reg3_init_val     => reg3_init_val,
   reg4_init_val     => reg4_init_val,
   reg5_init_val     => reg5_init_val,
   reg6_init_val     => reg6_init_val,
   reg7_init_val     => reg7_init_val,
--------------------------------------------------------------------------------
-- Control Register Outputs
--------------------------------------------------------------------------------
   ctl0_out          => ctl0_out,
   ctl1_out          => ctl1_out,
   ctl2_out          => ctl2_out,
   ctl3_out          => ctl3_out,
   ctl4_out          => ctl4_out,
   ctl5_out          => ctl5_out,
   ctl6_out          => ctl6_out,
   ctl7_out          => ctl7_out,
--------------------------------------------------------------------------------
-- Status Register Inputs
--------------------------------------------------------------------------------
   stat0_in          => stat0_in,
   stat1_in          => stat1_in,
   stat2_in          => stat2_in,
   stat3_in          => stat3_in,
   stat4_in          => stat4_in,
   stat5_in          => stat5_in,
   stat6_in          => stat6_in,
   stat7_in          => stat7_in,
--------------------------------------------------------------------------------
-- Interrupt
--------------------------------------------------------------------------------
   intrpt_src_in     => intrpt_src_in,    
   irq               => irq             
);

--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------

-- CSR Clock = 250MHz
process
begin
    loop
        s_axi_csr_aclk <= not s_axi_csr_aclk;
        wait for 2 ns;
    end loop;
end process;


test_process: process
variable c_time : time    := 0 ns;
variable d_time : time    := 0 ns;
variable x      : integer := 5;

begin
   wait for 400 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   wait for 40 ns;
   c_time := now;
   -----------------------------------------------------------------------------
   -- Test Control Registers
   -----------------------------------------------------------------------------
   if (num_ctl_regs /= 0) then
      assert false
      report "Writing to Control Registers. Start Time = " & time'image(now) 
      severity NOTE;
      for i in 0 to (num_ctl_regs-1) loop
         axi_lite_writer(conv_std_logic_vector(i*4,num_addr_bits),conv_std_logic_vector(i,32), num_addr_bits, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      end loop;
      
    
      d_time := now - c_time; 
      assert false
      report "Finished Writing the Control Registers. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
   
      c_time := now; 
      assert false
      report "Reading Back and Verifying Control Registers. Start Time = " & time'image(now) 
      severity NOTE;    
      for i in 0 to (num_ctl_regs-1) loop
         axi_lite_reader(conv_std_logic_vector(i*4,num_addr_bits), conv_std_logic_vector(i,32),num_addr_bits, '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
      end loop;

      
      d_time := now - c_time; 
      assert false
      report "Finished Reading and verifying the Control Registers. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  

    end if;
   -----------------------------------------------------------------------------
   -- Test Status Registers
   -----------------------------------------------------------------------------
   if (num_stat_regs /= 0) then
   
   
         c_time := now; 
         assert false
         report "Reading and Verifying Status Registers. Start Time = " & time'image(now) 
         severity NOTE;    
         for i in 0 to (num_stat_regs-1) loop
            axi_lite_reader(conv_std_logic_vector((num_ctl_regs*4)+(i*4),num_addr_bits), (conv_std_logic_vector(i,4) & x"0000000"),num_addr_bits, '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
         end loop;
   
         
         d_time := now - c_time; 
         assert false
         report "Finished Reading and Verifying the Status Registers. End Time = " & time'image(now) 
         severity NOTE;
         assert false
         report "Total Time = " & time'image(d_time) 
         severity NOTE;  
   
   end if;
   -----------------------------------------------------------------------------
   -- Test Interrupt Registers
   -----------------------------------------------------------------------------
   if (num_interrupt_regs /= 0) then
      assert false
      report "Writing to Interrupt Enable Register. Setting all Interrupts Enabled. Start Time = " & time'image(now) 
      severity NOTE;
      axi_lite_writer(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4),num_addr_bits),x"FFFFFFFF", num_addr_bits, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
    
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Interrupt Enable Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
   
      c_time := now; 
      assert false
      report "Reading Back and Verifying Interrupt Enable Register. Start Time = " & time'image(now) 
      severity NOTE;    
      axi_lite_reader(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4),num_addr_bits),x"FFFFFFFF",num_addr_bits, '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);

      d_time := now - c_time; 
      assert false
      report "Finished Reading and Verifying the Interrupt Enable Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
      
      assert false
      report "Clearing the Interrupt Flag Register. Start Time = " & time'image(now) 
      severity NOTE;
      axi_lite_writer(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4)+8,num_addr_bits),x"FFFFFFFF", num_addr_bits, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
      
      d_time := now - c_time; 
      assert false
      report "Finished Clearing the Interrupt Flag Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
      
      c_time := now; 
      assert false
      report "Reading Back and Verifying Interrupt Flag Register is Cleared. Start Time = " & time'image(now) 
      severity NOTE;    
      axi_lite_reader(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4)+8,num_addr_bits),x"00000000",num_addr_bits, '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);

      d_time := now - c_time; 
      assert false
      report "Finished Reading and Verifying the Interrupt Flag Register is Cleared. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
      
      -- Set an Interrupt
      wait until rising_edge(s_axi_csr_aclk);
      wait for 0.5 ns;
      intrpt_src_in(0) <= '1';
      x := 10;
      while ((x /= 0) and (irq = '0')) loop
         wait until rising_edge(s_axi_csr_aclk);
         x := x -1;
         if (x = 0) then
            assert false
            report "Failure. Interrupt Output Did Not Occur!" 
            severity FAILURE;
         end if;
      end loop;
      
      wait until rising_edge(s_axi_csr_aclk);
      wait for 0.5 ns;
      intrpt_src_in(0) <= '0';
      
      c_time := now; 
      assert false
      report "Reading Back and Verifying Interrupt Flag Register is Set. Start Time = " & time'image(now) 
      severity NOTE;    
      axi_lite_reader(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4)+8,num_addr_bits),x"00000001",num_addr_bits, '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
      
      d_time := now - c_time; 
      assert false
      report "Finished Reading and Verifying the Interrupt Flag Register is Set. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
      
      assert false
      report "Clearing the Interrupt Flag Register. Start Time = " & time'image(now) 
      severity NOTE;
      axi_lite_writer(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4)+8,num_addr_bits),x"00000001", num_addr_bits, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
      
      d_time := now - c_time; 
      assert false
      report "Finished Clearing the Interrupt Flag Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
      
      c_time := now; 
      assert false
      report "Reading Back and Verifying Interrupt Flag Register is Cleared. Start Time = " & time'image(now) 
      severity NOTE;    
      axi_lite_reader(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4)+8,num_addr_bits),x"00000000",num_addr_bits, '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);

      d_time := now - c_time; 
      assert false
      report "Finished Reading and Verifying the Interrupt Flag Register is Cleared. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  

      
   end if;
   
   
   
   assert false
   report "Test Complete, Not A Failure." 
   severity FAILURE;  
   wait; 
end process;

end Behavioral;
