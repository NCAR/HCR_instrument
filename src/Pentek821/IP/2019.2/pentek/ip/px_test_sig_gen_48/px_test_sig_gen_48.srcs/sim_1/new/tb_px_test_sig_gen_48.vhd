----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2015 01:07:16 PM
-- Design Name: 
-- Module Name: tb_ptk_timestamp_gen - Behavioral
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

use std.textio.all;

library IEEE;
use IEEE.math_real.all;
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

entity tb_px_test_sig_gen_48 is
Generic (
    parameter_file_name : string := "..\..\..\test_parameters.txt";
    des : std_logic := '0' -- DES Control
);
end tb_px_test_sig_gen_48;

architecture Behavioral of tb_px_test_sig_gen_48 is

component px_test_sig_gen_48
port (
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI4-LITE)
   ----------------------------------------------------------------------------
   -- associated with s_axi_csr_aclk
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(4 downto 0);
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
   s_axi_csr_araddr         : in  std_logic_vector(4 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
   
   irq                      : out std_logic; -- Interrupt out
   -----------------------------------------------------------------------------
   -- Timing Events (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- tdata[n-1:0]       = Gate Positions
   -- tdata[2n-1:n]      = Sync Positions   
   -- tdata[3n-1:2n]     = PPS Positions  
   s_axis_aclk              : in std_logic; -- Timestamp clock (usually data sample clock
   s_axis_aresetn           : in std_logic; -- reset   
   s_axis_ptctl_tdata       : in std_logic_vector(31 downto 0);
   s_axis_ptctl_tvalid      : in std_logic;
   -----------------------------------------------------------------------------
   -- Test Signal Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   m_axis_pd_testsig_tdata  : out std_logic_vector((8*16)-1 downto 0);
   m_axis_pd_testsig_tvalid : out std_logic;
   des_ctl                  : in std_logic
);
end component;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type param_record_type is RECORD  
   -- Counter Load Mode
   -- 0x0 Always on Arm
   -- 0x1 Always on Arm
   -- 0x2 PPS rising edge
   -- 0x3 PPS falling edge
   -- 0x4 SYNC rising edge
   -- 0x5 SYNC falling edge
   -- 0x6 Gate rising_edge
   -- 0x7 Gate falling edge 
    LOAD_MODE           : std_ulogic_vector(3 downto 0);
    STAY_ARMED          : boolean; -- false - Disable counter loading, true - Enable Counter loading
    SELECT_SINE         : boolean; -- false - 64-bit sample count, no pps count, true - 32-bit sample count and 32-bit pps count
    SINE_FREQ_VALUE     : real; -- in MHz (example 2.5  = 2.5MHz) must have decimal point
    SAMPLE_FREQ         : real; -- in MHz (example 200.0 = 200MHz) must have decimal point
    TICKS_PER_CYCLE     : integer;
end record param_record_type;

constant samples_per_cycle : integer := 8; 

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
signal s_axi_csr_aclk           : std_logic:= '0';
signal s_axi_csr_aresetn        : std_logic:= '0';
signal s_axi_csr_awaddr         : std_logic_vector(4 downto 0):=(others => '0');
signal s_axi_csr_awprot         : std_logic_vector(2 downto 0):=(others => '0');
signal s_axi_csr_awvalid        : std_logic:= '0';
signal s_axi_csr_awready        : std_logic:= '0';
signal s_axi_csr_wdata          : std_logic_vector(31 downto 0):=(others => '0');
signal s_axi_csr_wstrb          : std_logic_vector(3 downto 0):=(others => '0');
signal s_axi_csr_wvalid         : std_logic:= '0';
signal s_axi_csr_wready         : std_logic:= '0';
signal s_axi_csr_bresp          : std_logic_vector(1 downto 0):=(others => '0');
signal s_axi_csr_bvalid         : std_logic:= '0';
signal s_axi_csr_bready         : std_logic:= '0';
signal s_axi_csr_araddr         : std_logic_vector(4 downto 0):=(others => '0');
signal s_axi_csr_arprot         : std_logic_vector(2 downto 0):=(others => '0');
signal s_axi_csr_arvalid        : std_logic:= '0';
signal s_axi_csr_arready        : std_logic:= '0';
signal s_axi_csr_rdata          : std_logic_vector(31 downto 0):=(others => '0');
signal s_axi_csr_rresp          : std_logic_vector(1 downto 0):=(others => '0');
signal s_axi_csr_rvalid         : std_logic:= '0';
signal s_axi_csr_rready         : std_logic:= '0';
signal des_ctl                  : std_logic:= des;   
signal irq                      : std_logic:= '0'; -- Interrupt out
   -----------------------------------------------------------------------------
   -- Timing Events (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- tdata[7:0]       = Gate Positions
   -- tdata[15:8]      = Sync Positions   
   -- tdata[23:16]     = PPS Positions  
signal s_axis_aclk              : std_logic:= '0'; -- Timestamp clock (usually data sample clock
signal s_axis_aresetn           : std_logic:= '0'; -- reset   
signal s_axis_ptctl_tdata    : std_logic_vector(31  downto 0):=(others => '0');
signal s_axis_ptctl_tvalid   : std_logic:= '0';

-----------------------------------------------------------------------------
-- Test Signal Output (AXI4-Stream Master) no back pressure
-----------------------------------------------------------------------------

signal m_axis_pd_testsig_tdata   : std_logic_vector((samples_per_cycle*16)-1 downto 0):=(others => '0');
signal m_axis_pd_testsig_tvalid  : std_logic := '0';

signal reset_done : std_logic := '0';
signal init_done  : std_logic := '0';
shared variable param_record : param_record_type;

signal sample_freq_hz_r : real;
signal sample_freq_hz_p : real;
signal sample_period_ht : time := 1 ns;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
-- 0x00 Mode Control                    R/W   
-- 0x04 Frequency Value                 R/W   
-- 0x18 Interrupt Status Register       RO 
-- 0x1C Interrupt Flag Register         R/Clr

-- CSR Register Addresses
constant MODE_CNTL_REG          : std_logic_vector(4 downto 0) := "00000";
constant FREQENCY_VAL_REG       : std_logic_vector(4 downto 0) := "00100";
constant INTRPT_EN_REG          : std_logic_vector(4 downto 0) := "10100";
constant INTRPT_STATUS_REG      : std_logic_vector(4 downto 0) := "11000";
constant INTRPT_FLAG_REG        : std_logic_vector(4 downto 0) := "11100";

constant NBSP : CHARACTER       := CHARACTER'val(160);  -- space character
constant NUS  : STRING(2 to 1)  := (others => ' ');     -- null STRING

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
        axi_araddr           <= addr; -- Byte Address
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
--------------------------------------------------------------------------------

begin

uut: px_test_sig_gen_48
port map(
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI4-LITE)
   ----------------------------------------------------------------------------
   -- associated with s_axi_csr_aclk
   s_axi_csr_aclk           => s_axi_csr_aclk,    
   s_axi_csr_aresetn        => s_axi_csr_aresetn, 
   s_axi_csr_awaddr         => s_axi_csr_awaddr,  
   s_axi_csr_awprot         => s_axi_csr_awprot,  
   s_axi_csr_awvalid        => s_axi_csr_awvalid, 
   s_axi_csr_awready        => s_axi_csr_awready, 
   s_axi_csr_wdata          => s_axi_csr_wdata,   
   s_axi_csr_wstrb          => s_axi_csr_wstrb,   
   s_axi_csr_wvalid         => s_axi_csr_wvalid,  
   s_axi_csr_wready         => s_axi_csr_wready,  
   s_axi_csr_bresp          => s_axi_csr_bresp,   
   s_axi_csr_bvalid         => s_axi_csr_bvalid,  
   s_axi_csr_bready         => s_axi_csr_bready,  
   s_axi_csr_araddr         => s_axi_csr_araddr,  
   s_axi_csr_arprot         => s_axi_csr_arprot,  
   s_axi_csr_arvalid        => s_axi_csr_arvalid, 
   s_axi_csr_arready        => s_axi_csr_arready, 
   s_axi_csr_rdata          => s_axi_csr_rdata,   
   s_axi_csr_rresp          => s_axi_csr_rresp,   
   s_axi_csr_rvalid         => s_axi_csr_rvalid,  
   s_axi_csr_rready         => s_axi_csr_rready,  
   
   irq                      => irq,               
   -----------------------------------------------------------------------------
   -- Timing Events (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- tdata[7:0]       = Gate Positions
   -- tdata[15:8]      = Sync Positions   
   -- tdata[23:16]     = PPS Positions  
   s_axis_aclk              => s_axis_aclk,             
   s_axis_aresetn           => s_axis_aresetn,           
   s_axis_ptctl_tdata    => s_axis_ptctl_tdata,  
   s_axis_ptctl_tvalid   => s_axis_ptctl_tvalid,
   -----------------------------------------------------------------------------
   -- Test Signal Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   m_axis_pd_testsig_tdata     => m_axis_pd_testsig_tdata, 
   m_axis_pd_testsig_tvalid    => m_axis_pd_testsig_tvalid,
   des_ctl => des_ctl
);

--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------

-- Clock = 250MHz
process
begin
    loop
        s_axi_csr_aclk <= not s_axi_csr_aclk;
        wait for 2 ns;
    end loop;
end process;

sample_freq_hz_r <= param_record.SAMPLE_FREQ * 1000000.0;
sample_freq_hz_p <= 1000000000.0/sample_freq_hz_r;
sample_period_ht <= (sample_freq_hz_p/2.0)* (1.0 ns);

-- Clock = 200MHz Data Sample clock
process
begin
    loop
        s_axis_aclk <= not s_axis_aclk;
        wait for sample_period_ht;
    end loop;
end process;

process
begin
wait for 400 ns;
s_axis_aresetn <= '1';
s_axi_csr_aresetn <= '1';
wait for 40 ns;
reset_done <= '1';
wait;
end process;

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
setup_process: process
variable c_time : time := 0 ns;
variable d_time : time := 0 ns;
variable cntr_load_mode: std_logic_vector(2 downto 0) := "000";
variable stay_armed : std_logic := '0';
variable sel_sine : std_logic := '0'; 
variable ticks_per_cycle: std_logic_vector(15 downto 0) := x"0000";
variable cntl_val: std_logic_vector(31 downto 0) := x"00000000";
variable sine_freq_val_real: real;
variable sine_freq_val: std_logic_vector(31 downto 0) := x"00000000";
begin
    wait until reset_done = '1';
    c_time := now; 
    assert false
    report "Writing the desired values to the Control Registers. Start Time = " & time'image(now) 
    severity NOTE;
        
    cntr_load_mode          := to_stdlogicvector(param_record.LOAD_MODE(2 downto 0));
    stay_armed              := To_Std_Logic(param_record.STAY_ARMED);    
    sel_sine                := To_Std_Logic(param_record.SELECT_SINE);  
    ticks_per_cycle         := conv_std_logic_vector(param_record.TICKS_PER_CYCLE, 16);
    sine_freq_val_real      := 4294967296.0*(param_record.SINE_FREQ_VALUE/param_record.SAMPLE_FREQ);
    sine_freq_val           := conv_std_logic_vector((Integer(sine_freq_val_real)), 32);
-- Control
    --Bit [0]   - Counter Reset
    --Bit [1]   - Arm Load 
    --Bit [2]   - Arm Clear 
    --Bit [3]   - Stay Armed
    --Bit [6:4] - Load_mode
        -- 000 Always on Arm
        -- 001 Always on Arm
        -- 010 PPS rising edge
        -- 011 PPS falling edge
        -- 100 SYNC rising edge
        -- 101 SYNC falling edge
        -- 110 Gate rising_edge
        -- 111 Gate falling edge 
    --Bit [7]   - Output Select
    cntl_val := x"0000" & x"00" & sel_sine & cntr_load_mode & stay_armed & "000";
 
    -- Write BufferA Descriptor Control Word   
    axi_lite_writer( FREQENCY_VAL_REG , sine_freq_val          , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( MODE_CNTL_REG    , cntl_val               , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( INTRPT_EN_REG    ,(x"000000" & x"03")     , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
     
    d_time := now - c_time; 
    assert false
    report "Finished writing the desired values to the Control Registers. End Time = " & time'image(now) 
    severity NOTE;
    assert false
    report "Total Time = " & time'image(d_time) 
    severity NOTE;  

    c_time := now; 
    assert false
    report "Reading back and verifying Control Register writes. Start Time = " & time'image(now) 
    severity NOTE;    
        
    -- Read BufferA Descriptor Control Word   
    axi_lite_reader( MODE_CNTL_REG    , cntl_val               , '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready );
    axi_lite_reader( FREQENCY_VAL_REG , sine_freq_val          , '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready );
    axi_lite_reader( INTRPT_EN_REG    , (x"000000" & x"03")    , '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready );
            
    d_time := now - c_time; 
    assert false
    report "Finished reading back and verifying Control Register writes. End Time = " & time'image(now) 
    severity NOTE;
    assert false
    report "Total Time = " & time'image(d_time) 
    severity NOTE; 
    
    -- Arm load
    axi_lite_writer( MODE_CNTL_REG          , (cntl_val(31 downto 2) & "10") , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    wait for 200 ns;
    init_done <= '1'; 
    wait until rising_edge(s_axis_aclk);
    wait for 0.5 ns; 
    if cntr_load_mode = "010" then -- PPS Rising Edge
        s_axis_ptctl_tdata((samples_per_cycle*2)-1  downto 0) <= (others => '0');
        s_axis_ptctl_tdata((samples_per_cycle*3)-1  downto (samples_per_cycle*2)) <= (others => '1');
        --s_axis_ptctl_tdata <= x"FF0000";
    elsif cntr_load_mode = "011" then
        --s_axis_ptctl_tdata <= x"FF0000";
        s_axis_ptctl_tdata((samples_per_cycle*2)-1  downto 0) <= (others => '0');
        s_axis_ptctl_tdata((samples_per_cycle*3)-1  downto (samples_per_cycle*2)) <= (others => '1');
    elsif cntr_load_mode = "100" then
        s_axis_ptctl_tdata((samples_per_cycle*1)-1  downto 0) <= (others => '0');
        s_axis_ptctl_tdata((samples_per_cycle*2)-1  downto (samples_per_cycle*1)) <= (others => '1');
        s_axis_ptctl_tdata((samples_per_cycle*3)-1  downto (samples_per_cycle*2)) <= (others => '0');
        --s_axis_ptctl_tdata <= x"00FF00";    
    elsif cntr_load_mode = "101" then
        s_axis_ptctl_tdata((samples_per_cycle*1)-1  downto 0) <= (others => '0');
        s_axis_ptctl_tdata((samples_per_cycle*2)-1  downto (samples_per_cycle*1)) <= (others => '1');
        s_axis_ptctl_tdata((samples_per_cycle*3)-1  downto (samples_per_cycle*2)) <= (others => '0');
        --s_axis_ptctl_tdata <= x"00FF00";
    elsif cntr_load_mode = "110" then
        s_axis_ptctl_tdata((samples_per_cycle*1)-1  downto 0) <= (others => '1');
        s_axis_ptctl_tdata((samples_per_cycle*2)-1  downto (samples_per_cycle*1)) <= (others => '0');
        s_axis_ptctl_tdata((samples_per_cycle*3)-1  downto (samples_per_cycle*2)) <= (others => '0');
        --s_axis_ptctl_tdata <= x"0000FF";
    elsif cntr_load_mode = "111" then
        s_axis_ptctl_tdata((samples_per_cycle*1)-1  downto 0) <= (others => '1');
        s_axis_ptctl_tdata((samples_per_cycle*2)-1  downto (samples_per_cycle*1)) <= (others => '0');
        s_axis_ptctl_tdata((samples_per_cycle*3)-1  downto (samples_per_cycle*2)) <= (others => '0');
        --s_axis_ptctl_tdata <= x"0000FF";
    end if;            
    s_axis_ptctl_tvalid <= '1';
    wait until rising_edge(s_axis_aclk);
    wait for 0.5 ns;   
    s_axis_ptctl_tdata    <= (others => '0');
    loop                    
        for i in 0 to (conv_integer(ticks_per_cycle)-1) loop
            if (i = (conv_integer(ticks_per_cycle)-1)) then
               s_axis_ptctl_tvalid <= '1'; 
            else
               s_axis_ptctl_tvalid <= '0'; 
            end if;
            wait until rising_edge(s_axis_aclk);
            wait for 0.5 ns;
            s_axis_ptctl_tdata    <= (others => '0');
        end loop;
    end loop;
    wait; 
end process;


read_test_parameters: process
file paramfile: text;
variable l: LINE;
variable ok :boolean; 
begin
    assert false
    report "Reading Parameters from File." 
    severity NOTE; 
    file_open(paramfile, parameter_file_name, READ_MODE);
    if not ENDFILE(paramfile) then -- If the file is not empty ...
         READLINE(ParamFile,l); -- ... read a line ...
         assert (l'LENGTH /= 0) -- ... if it isn't empty ..
         report "Parameter is missing. Exiting."
         severity FAILURE;
         HREAD(l,param_record.LOAD_MODE, ok);
    else
         assert false
         report "Not enough parameters in File. Exiting."
         severity FAILURE;
    end if;
    if not ENDFILE(paramfile) then -- If the file is not empty ...
         READLINE(ParamFile,l); -- ... read a line ...
         assert (l'LENGTH /= 0) -- ... if it isn't empty ..
         report "Parameter is missing. Exiting."
         severity FAILURE;
         READ (l, param_record.STAY_ARMED, ok);
    else
         assert false
         report "Not enough parameters in File. Exiting."
         severity FAILURE;
    end if;  
    if not ENDFILE(paramfile) then -- If the file is not empty ...
         READLINE(ParamFile,l); -- ... read a line ...
         assert (l'LENGTH /= 0) -- ... if it isn't empty ..
         report "Parameter is missing. Exiting."
         severity FAILURE;
         READ(l,param_record.SELECT_SINE, ok);
    else
         assert false
         report "Not enough parameters in File. Exiting."
         severity FAILURE;
    end if;    
    if not ENDFILE(paramfile) then -- If the file is not empty ...
         READLINE(ParamFile,l); -- ... read a line ...
         assert (l'LENGTH /= 0) -- ... if it isn't empty ..
         report "Parameter is missing. Exiting."
         severity FAILURE;
         READ(l,param_record.SINE_FREQ_VALUE, ok);
    else
         assert false
         report "Not enough parameters in File. Exiting."
         severity FAILURE;
    end if;    
    if not ENDFILE(paramfile) then -- If the file is not empty ...
         READLINE(ParamFile,l); -- ... read a line ...
         assert (l'LENGTH /= 0) -- ... if it isn't empty ..
         report "Parameter is missing. Exiting."
         severity FAILURE;
         READ(l,param_record.SAMPLE_FREQ, ok);
    else
         assert false
         report "Not enough parameters in File. Exiting."
         severity FAILURE;
    end if;       
    if not ENDFILE(paramfile) then -- If the file is not empty ...
         READLINE(ParamFile,l); -- ... read a line ...
         assert (l'LENGTH /= 0) -- ... if it isn't empty ..
         report "Parameter is missing. Exiting."
         severity FAILURE;
         READ(l,param_record.TICKS_PER_CYCLE, ok);
    else
         assert false
         report "Not enough parameters in File. Exiting."
         severity FAILURE;
    end if;   
    

    report "Reading Parameters is complete." 
    severity NOTE;          
    file_close(paramfile);
    wait;
end process;
  



end Behavioral;
