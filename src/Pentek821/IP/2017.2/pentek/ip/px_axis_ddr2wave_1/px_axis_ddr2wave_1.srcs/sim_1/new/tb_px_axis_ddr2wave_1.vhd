----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/20/2016 01:19:19 PM
-- Design Name: 
-- Module Name: tb_px_axis_ddr2wave_1 - Behavioral
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

entity tb_px_axis_ddr2wave_1 is
Generic (
    ddr4_requestor_id: integer := 0;
    parameter_file_name : string := "..\..\..\test_parameters.txt"
);
end tb_px_axis_ddr2wave_1;

architecture Behavioral of tb_px_axis_ddr2wave_1 is

component px_axis_ddr2wave_1 is
generic ( 
    ddr4_requestor_id: integer := 0
);
port (   
    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI-LITE)
    ----------------------------------------------------------------------------
    s_axi_csr_aclk           : in  std_logic;
    -- associated with s_axi_aclk
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
    
    irq                      : out std_logic; -- Interrupt out
    ----------------------------------------------------------------------------
    -- DDR4 Request Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    -- tuser[127:0] = Request Header
    -- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[35]    = Read = 1, Write = 0
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    m_axis_ddr_aclk          : in  std_logic; 
    m_axis_ddr_rqst_tvalid   : out std_logic;
    m_axis_ddr_rqst_tready   : in  std_logic;   
    m_axis_ddr_rqst_tlast    : out std_logic;
    m_axis_ddr_rqst_tid      : out std_logic_vector(7 downto 0);
    m_axis_ddr_rqst_tdata    : out std_logic_vector(511 downto 0); 
    m_axis_ddr_rqst_tuser    : out std_logic_vector(255 downto 0);
    ----------------------------------------------------------------------------
    -- DDR4 Response Interface (AXI Stream)
    ----------------------------------------------------------------------------
    -- tuser[127:0] = Response Header
    -- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks 
   -- tuser[255:128] = Upper 128-bits of RAM Data 
    s_axis_ddr_rsp_tvalid    : in  std_logic;
    s_axis_ddr_rsp_tlast     : in  std_logic;
    s_axis_ddr_rsp_tid       : in  std_logic_vector(7 downto 0);
    s_axis_ddr_rsp_tdata     : in  std_logic_vector(511 downto 0); 
    s_axis_ddr_rsp_tuser     : in  std_logic_vector(255 downto 0);
    -----------------------------------------------------------------------------
    s_axis_aclk              : in  std_logic; -- AXI Stream Clock
    s_axis_aresetn           : in  std_logic;
    -----------------------------------------------------------------------------
    -- Input Control (AXI4-Stream Slave) from Sync Bus
    -----------------------------------------------------------------------------
    -- synchronous to s_axis_aclk
    -- [0] = gate -- [1] = sync -- [2] = pps
    s_axis_pctl_tdata        : in  std_logic_vector(7 downto 0);  
    s_axis_pctl_tvalid       : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output Packetized Stream (AXI4-Stream Master) 
    ----------------------------------------------------------------------------
    -- No back pressure supported
    -- Constant output flow
    -- If input goes empty and real-time is lost, data with zer value are inserted
    -- in the stream.
    
    -- tuser[63:0]    = timestamp[63:0] -- all zero not supported here
    -- tuser[71:64]   = Gate Positions  -- Only [64] is used here
    -- tuser[79:72]   = Sync Positions  -- Only [72] is used here    
    -- tuser[87:80]   = PPS Positions   -- Only [80] is used here
    -- tuser[92:88]   = Samples/Cycle   
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3=32 bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    m_axis_pdti_tvalid       : out std_logic; 
    m_axis_pdti_tdata        : out std_logic_vector(31 downto 0);
    m_axis_pdti_tuser        : out std_logic_vector(127 downto 0);
    ----------------------------------------------------------------------------
    -- Real Time Lost Status
    ----------------------------------------------------------------------------
    realtime_lost            : out std_logic
);
end component;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------
-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Trigger Clear                   R/W   
-- 0x08 Trigger Length Value            R/W
-- 0x0C TimeStamp Start (Lower)         R/W
-- 0x10 TimeStamp Start (Upper)         R/W
-- 0x14 TimeStamp End   (Lower)         R/W
-- 0x18 TimeStamp End   (Upper)         R/W
-- 0x1C Interrupt Enables               R/W
-- 0x20 Status                          RO 
-- 0x28 Interrupt Status Register       RO 
-- 0x2C Interrupt Flag Register         R/Clr

-- Mode Control Register
--Bit [0]   - trig_arm
--Bit [1]   - stay_armed
--Bit [3:2] - mode_sel[1:0]
            --  "00" = Gate Mode
            --  "01" = Trig Mode
            --  "10" = Trig Hold Mode
            --  "11" = Timestamp Mode 
--Bit [5:4] - data_mode_sel[1:0]
            -- "00" = Single Sample Real Data
            -- "01" = Packed I/Q Data
            -- "10" = Packed Real Data  -- NOT SUPPORTED YET!
            -- "11" = Unpacked I/Q
-- Trigger Clear Register
-- Bit [0] - Trigger Clear

type param_record_type is RECORD  
    MODE_SEL                  : std_ulogic_vector(3 downto 0);
    DATA_MODE_SEL             : std_ulogic_vector(3 downto 0);
    STAY_ARMED                : boolean; -- false - don't stay armed at end of triggered gate, true - Stay armed at end of triggered gate
    DIV_RATE_VALUE            : std_ulogic_vector(31 downto 0);
    GATE_OUTPUT_DELAY         : std_ulogic_vector(7 downto 0);
    TRIG_SPACE                : std_ulogic_vector(31 downto 0); -- space between triggers
    LL_START_ADDRESS          : std_ulogic_vector(31 downto 0); -- Linked List Start Address  
    INTERRUPT_ENABLE          : std_ulogic_vector(31 downto 0);  -- Interrupt Enables
    LINK1_DESCR_WORD0         : std_ulogic_vector(31 downto 0); -- Value to load to delay counter (value)
    LINK1_DESCR_WORD1         : std_ulogic_vector(31 downto 0); -- Value to load to sample counter (value) 
    LINK1_DESCR_WORD2         : std_ulogic_vector(31 downto 0); -- DDR4 start address
    LINK1_DESCR_WORD3         : std_ulogic_vector(31 downto 0); -- Last address before returning to start address
    LINK1_DESCR_WORD4         : std_ulogic_vector(31 downto 0); -- bit[6:0] = Next Link Address / bit[16]=Disarm at End/ bit[17]=Interrupt at start/ bit[18]=Interrupt at end 
    LINK2_DESCR_WORD0         : std_ulogic_vector(31 downto 0); -- Value to load to delay counter (value)
    LINK2_DESCR_WORD1         : std_ulogic_vector(31 downto 0); -- Value to load to sample counter (value) 
    LINK2_DESCR_WORD2         : std_ulogic_vector(31 downto 0); -- DDR4 start address
    LINK2_DESCR_WORD3         : std_ulogic_vector(31 downto 0); -- Last address before returning to start address
    LINK2_DESCR_WORD4         : std_ulogic_vector(31 downto 0); -- bit[6:0] = Next Link Address / bit[16]=Disarm at End/ bit[17]=Interrupt at start/ bit[18]=Interrupt at end
end record param_record_type;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal s_axi_csr_aclk           : std_logic := '0';
-- associated with s_axi_aclk
signal s_axi_csr_aresetn        : std_logic := '0';
signal s_axi_csr_awaddr         : std_logic_vector(11 downto 0) := (others => '0');
signal s_axi_csr_awprot         : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_awvalid        : std_logic := '0';
signal s_axi_csr_awready        : std_logic := '0';
signal s_axi_csr_wdata          : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_wstrb          : std_logic_vector(3 downto 0) := (others => '0');
signal s_axi_csr_wvalid         : std_logic := '0';
signal s_axi_csr_wready         : std_logic := '0';
signal s_axi_csr_bresp          : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_bvalid         : std_logic := '0';
signal s_axi_csr_bready         : std_logic := '0';
signal s_axi_csr_araddr         : std_logic_vector(11 downto 0) := (others => '0');
signal s_axi_csr_arprot         : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_arvalid        : std_logic := '0';
signal s_axi_csr_arready        : std_logic := '0';
signal s_axi_csr_rdata          : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp          : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid         : std_logic := '0';
signal s_axi_csr_rready         : std_logic := '0';
signal irq                      : std_logic := '0'; -- Interrupt out
----------------------------------------------------------------------------
-- DDR4 Request Interface (AXI Stream)
----------------------------------------------------------------------------  
-- tuser[127:0] = Request Header
-- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
-- tuser[34:32] = Future Address Expansion
-- tuser[35]    = Read = 1, Write = 0
-- tuser[39:36] = Reserved
-- tuser[119:40]= Byte Masks
-- tuser[255:128] = Upper 128-bits of RAM Data 
signal m_axis_ddr_aclk          : std_logic := '0'; 
signal m_axis_ddr_rqst_tvalid   : std_logic := '0';
signal m_axis_ddr_rqst_tready   : std_logic := '1';   
signal m_axis_ddr_rqst_tlast    : std_logic := '0';
signal m_axis_ddr_rqst_tid      : std_logic_vector(7 downto 0) := (others => '0');
signal m_axis_ddr_rqst_tdata    : std_logic_vector(511 downto 0) := (others => '0'); 
signal m_axis_ddr_rqst_tuser    : std_logic_vector(255 downto 0) := (others => '0');
----------------------------------------------------------------------------
-- DDR4 Response Interface (AXI Stream)
----------------------------------------------------------------------------
-- tuser[127:0] = Response Header
-- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
-- tuser[34:32] = Future Address Expansion
-- tuser[39:36] = Reserved
-- tuser[119:40]= Byte Masks 
-- tuser[255:128] = Upper 128-bits of RAM Data 
signal s_axis_ddr_rsp_tvalid    : std_logic := '0';
signal s_axis_ddr_rsp_tlast     : std_logic := '0';
signal s_axis_ddr_rsp_tid       : std_logic_vector(7 downto 0) := (others => '0');
signal s_axis_ddr_rsp_tdata     : std_logic_vector(511 downto 0) := (others => '0'); 
signal s_axis_ddr_rsp_tuser     : std_logic_vector(255 downto 0) := (others => '0');
-----------------------------------------------------------------------------
signal s_axis_aclk              : std_logic := '0'; -- AXI Stream Clock
signal s_axis_aresetn           : std_logic := '0';
-----------------------------------------------------------------------------
-- Input Control (AXI4-Stream Slave) from Sync Bus
-----------------------------------------------------------------------------
-- synchronous to s_axis_aclk
-- [0] = gate -- [1] = sync -- [2] = pps
signal s_axis_pctl_tdata        : std_logic_vector(7 downto 0) := (others => '0');  
signal s_axis_pctl_tvalid       : std_logic := '0';
----------------------------------------------------------------------------
-- Output Packetized Stream (AXI4-Stream Master) 
----------------------------------------------------------------------------
-- No back pressure supported
-- Constant output flow
-- If input goes empty and real-time is lost, data with zer value are inserted
-- in the stream.

-- tuser[63:0]    = timestamp[63:0] -- all zero not supported here
-- tuser[71:64]   = Gate Positions  -- Only [64] is used here
-- tuser[79:72]   = Sync Positions  -- Only [72] is used here    
-- tuser[87:80]   = PPS Positions   -- Only [80] is used here
-- tuser[92:88]   = Samples/Cycle   
-- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3=32 bit
-- tuser[95]      = Data Type 0 = Real 1 = I/Q
-- tuser[103:96]  = channel[7:0] 
-- tuser[127:104] = Reserved 
signal m_axis_pdti_tvalid       : std_logic := '0'; 
signal m_axis_pdti_tdata        : std_logic_vector(31 downto 0) := (others => '0');
signal m_axis_pdti_tuser        : std_logic_vector(127 downto 0) := (others => '0');
----------------------------------------------------------------------------
-- Real Time Lost Status
----------------------------------------------------------------------------
signal realtime_lost            : std_logic := '0';

--signal dcnt: std_logic_vector(15 downto 0) := (others => '0');\
signal dcnt: std_logic_vector(31 downto 0) := (others => '0');
signal reset_done : std_logic := '0';
signal init_done  : std_logic := '0';
signal hr : std_logic := '0';
shared variable param_record : param_record_type;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Trigger Clear                   R/W  
-- 0x08 Linked List Start Address Load  R/W
-- 0x0C Linked List Start Address       R/W
-- 0x10 FIFO Flush                      R/W
-- 0x14 Output Rate Div                 R/W
-- 0x18 Output Gate Delay               R/W
-- 0x1C                                 R/W
-- 0x20 Status                          RO
-- 0x24 Current Link/Next Link          RO 
-- 0x28 
-- 0x2C 
-- 0x34 Interrupt Enables               R/W
-- 0x38 Interrupt Status Register       RO 
-- 0x3C Interrupt Flag Register         R/Clr


-- CSR Register Addresses
constant MODE_CNTL_REG          : std_logic_vector(15 downto 0) := x"0000";
constant TRIG_CLEAR_REG         : std_logic_vector(15 downto 0) := x"0004";
constant LL_START_LD_REG        : std_logic_vector(15 downto 0) := x"0008";
constant LL_START_REG           : std_logic_vector(15 downto 0) := x"000C";
constant FIFO_FLUSH_REG         : std_logic_vector(15 downto 0) := x"0010"; 
constant DIV_RATE_REG           : std_logic_vector(15 downto 0) := x"0014";
constant OUTPUT_GATE_DLY_REG    : std_logic_vector(15 downto 0) := x"0018";
constant STATUS_REG             : std_logic_vector(15 downto 0) := x"0020";
constant LINK_NUMBER_REG        : std_logic_vector(15 downto 0) := x"0024";
constant INTRPT_EN_REG          : std_logic_vector(15 downto 0) := x"0034";
constant INTRPT_STAT_REG        : std_logic_vector(15 downto 0) := x"0038";
constant INTRPT_FLAG_REG        : std_logic_vector(15 downto 0) := x"003C";
constant LINKED_LIST            : std_logic_vector(15 downto 0) := x"0800";

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

uut: px_axis_ddr2wave_1
generic map ( 
    ddr4_requestor_id => ddr4_requestor_id
)
port map (   
    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI-LITE)
    ----------------------------------------------------------------------------
    s_axi_csr_aclk                => s_axi_csr_aclk,    
    -- associated with s_axi_aclk  
    s_axi_csr_aresetn             => s_axi_csr_aresetn, 
    s_axi_csr_awaddr              => s_axi_csr_awaddr,  
    s_axi_csr_awprot              => s_axi_csr_awprot,  
    s_axi_csr_awvalid             => s_axi_csr_awvalid, 
    s_axi_csr_awready             => s_axi_csr_awready, 
    s_axi_csr_wdata               => s_axi_csr_wdata,   
    s_axi_csr_wstrb               => s_axi_csr_wstrb,   
    s_axi_csr_wvalid              => s_axi_csr_wvalid,  
    s_axi_csr_wready              => s_axi_csr_wready,  
    s_axi_csr_bresp               => s_axi_csr_bresp,   
    s_axi_csr_bvalid              => s_axi_csr_bvalid,  
    s_axi_csr_bready              => s_axi_csr_bready,  
    s_axi_csr_araddr              => s_axi_csr_araddr,  
    s_axi_csr_arprot              => s_axi_csr_arprot,  
    s_axi_csr_arvalid             => s_axi_csr_arvalid, 
    s_axi_csr_arready             => s_axi_csr_arready, 
    s_axi_csr_rdata               => s_axi_csr_rdata,   
    s_axi_csr_rresp               => s_axi_csr_rresp,   
    s_axi_csr_rvalid              => s_axi_csr_rvalid,  
    s_axi_csr_rready              => s_axi_csr_rready,  
                                  
    irq                           => irq,               
    ----------------------------------------------------------------------------
    -- DDR4 Request Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    -- tuser[127:0] = Request Header
    -- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[35]    = Read = 1, Write = 0
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    m_axis_ddr_aclk                => m_axis_ddr_aclk,       
    m_axis_ddr_rqst_tvalid         => m_axis_ddr_rqst_tvalid,
    m_axis_ddr_rqst_tready         => m_axis_ddr_rqst_tready,
    m_axis_ddr_rqst_tlast          => m_axis_ddr_rqst_tlast, 
    m_axis_ddr_rqst_tid            => m_axis_ddr_rqst_tid,   
    m_axis_ddr_rqst_tdata          => m_axis_ddr_rqst_tdata, 
    m_axis_ddr_rqst_tuser          => m_axis_ddr_rqst_tuser, 
    ----------------------------------------------------------------------------
    -- DDR4 Response Interface (AXI Stream)
    ----------------------------------------------------------------------------
    -- tuser[127:0] = Response Header
    -- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks 
   -- tuser[255:128] = Upper 128-bits of RAM Data 
    s_axis_ddr_rsp_tvalid           => s_axis_ddr_rsp_tvalid,
    s_axis_ddr_rsp_tlast            => s_axis_ddr_rsp_tlast, 
    s_axis_ddr_rsp_tid              => s_axis_ddr_rsp_tid,   
    s_axis_ddr_rsp_tdata            => s_axis_ddr_rsp_tdata, 
    s_axis_ddr_rsp_tuser            => s_axis_ddr_rsp_tuser, 
    -----------------------------------------------------------------------------
    s_axis_aclk                     => s_axis_aclk,   
    s_axis_aresetn                  => s_axis_aresetn,
    -----------------------------------------------------------------------------
    -- Input Control (AXI4-Stream Slave) from Sync Bus
    -----------------------------------------------------------------------------
    -- synchronous to s_axis_aclk
    -- [0] = gate -- [1] = sync -- [2] = pps
    s_axis_pctl_tdata               => s_axis_pctl_tdata, 
    s_axis_pctl_tvalid              => s_axis_pctl_tvalid, 
    ----------------------------------------------------------------------------
    -- Output Packetized Stream (AXI4-Stream Master) 
    ----------------------------------------------------------------------------
    -- No back pressure supported
    -- Constant output flow
    -- If input goes empty and real-time is lost, data with zer value are inserted
    -- in the stream.
    
    -- tuser[63:0]    = timestamp[63:0] -- all zero not supported here
    -- tuser[71:64]   = Gate Positions  -- Only [64] is used here
    -- tuser[79:72]   = Sync Positions  -- Only [72] is used here    
    -- tuser[87:80]   = PPS Positions   -- Only [80] is used here
    -- tuser[92:88]   = Samples/Cycle   
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3=32 bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    m_axis_pdti_tvalid                => m_axis_pdti_tvalid,
    m_axis_pdti_tdata                 => m_axis_pdti_tdata, 
    m_axis_pdti_tuser                 => m_axis_pdti_tuser, 
    ----------------------------------------------------------------------------
    -- Real Time Lost Status
    ----------------------------------------------------------------------------
    realtime_lost                     => realtime_lost
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

-- Clock = 200MHz Data Sample clock
process
begin
    loop
        s_axis_aclk <= not s_axis_aclk;
        wait for 2.5 ns;
    end loop;
end process;

-- Clock = Memory clock
process
begin
    loop
        m_axis_ddr_aclk <= not m_axis_ddr_aclk;
        wait for 1.5 ns;
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
variable trig_mode_sel: std_logic_vector(1 downto 0) := "00";
variable dat_mode_sel: std_logic_vector(1 downto 0) := "00";
variable stay_armed : std_logic := '0';
variable cntl_val: std_logic_vector(31 downto 0) := x"00000000";
variable div_rate: std_logic_vector(31 downto 0) := x"00000000";
variable gate_out_dly: std_logic_vector(7 downto 0) := x"00";
variable ll_start : std_logic_vector(31 downto 0) := x"00000000";
variable int_en : std_logic_vector(31 downto 0) := x"00000000";
begin
    wait until reset_done = '1';
    c_time := now; 
    assert false
    report "Writing the desired values to the Control Registers. Start Time = " & time'image(now) 
    severity NOTE;
        
    trig_mode_sel     := to_stdlogicvector(param_record.MODE_SEL(1 downto 0));
    dat_mode_sel      := to_stdlogicvector(param_record.DATA_MODE_SEL(1 downto 0));
    stay_armed        := To_Std_Logic(param_record.STAY_ARMED);  
    ll_start          := to_stdlogicvector(param_record.LL_START_ADDRESS); 
    div_rate          := to_stdlogicvector(param_record.DIV_RATE_VALUE);
    gate_out_dly      := to_stdlogicvector(param_record.GATE_OUTPUT_DELAY(7 downto 0));
    int_en            := to_stdlogicvector(param_record.INTERRUPT_ENABLE);
    cntl_val := x"0000" & x"00" & "00" & dat_mode_sel & trig_mode_sel & stay_armed & '0';
 
    -- Write Control Words   
    axi_lite_writer( MODE_CNTL_REG(11 downto 0)   , cntl_val    , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( TRIG_CLEAR_REG(11 downto 0)  , x"00000000" , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready); 
    axi_lite_writer( LL_START_REG(11 downto 0)    , ll_start    , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);          
    axi_lite_writer( DIV_RATE_REG(11 downto 0)    , div_rate    , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"000")   , to_stdlogicvector(param_record.LINK1_DESCR_WORD0) , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"004")   , to_stdlogicvector(param_record.LINK1_DESCR_WORD1) , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"008")   , to_stdlogicvector(param_record.LINK1_DESCR_WORD2) , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"00C")   , to_stdlogicvector(param_record.LINK1_DESCR_WORD3) , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"010")   , to_stdlogicvector(param_record.LINK1_DESCR_WORD4) , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"014")   , x"00000000" , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"018")   , x"00000000" , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"01c")   , x"00000000" , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"020")   , to_stdlogicvector(param_record.LINK2_DESCR_WORD0) , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"024")   , to_stdlogicvector(param_record.LINK2_DESCR_WORD1) , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"028")   , to_stdlogicvector(param_record.LINK2_DESCR_WORD2) , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"02C")   , to_stdlogicvector(param_record.LINK2_DESCR_WORD3) , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"030")   , to_stdlogicvector(param_record.LINK2_DESCR_WORD4) , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"034")   , x"00000000" , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"038")   , x"00000000" , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( (LINKED_LIST(11 downto 0) + x"03c")   , x"00000000" , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
 
    axi_lite_writer( OUTPUT_GATE_DLY_REG(11 downto 0)           , (x"000000" & gate_out_dly) , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( FIFO_FLUSH_REG(11 downto 0)  , x"00000001" , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    wait for 200 ns;
    axi_lite_writer( FIFO_FLUSH_REG(11 downto 0)  , x"00000000"    , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);      
    axi_lite_writer( INTRPT_EN_REG(11 downto 0)   , int_en , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    -- Load Linked List Start Address
    axi_lite_writer( LL_START_LD_REG(11 downto 0) , x"00000001" , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( LL_START_LD_REG(11 downto 0) , x"00000000" , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
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
        
    -- Read Control Words   
    axi_lite_reader( MODE_CNTL_REG(11 downto 0)   , cntl_val    , '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready );
    axi_lite_reader((LINKED_LIST(11 downto 0) + x"004")   , to_stdlogicvector(param_record.LINK1_DESCR_WORD1) , '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready );
                    
    d_time := now - c_time; 
    assert false
    report "Finished reading back and verifying Control Register writes. End Time = " & time'image(now) 
    severity NOTE;
    assert false
    report "Total Time = " & time'image(d_time) 
    severity NOTE; 
    
    -- Arm trigger
    axi_lite_writer( MODE_CNTL_REG(11 downto 0)          , (cntl_val(31 downto 1) & '1') , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    wait for 20 ns;
    axi_lite_writer( MODE_CNTL_REG(11 downto 0)          , (cntl_val(31 downto 1) & '0') , s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    -- Check if it is armed
    wait for 100 ns;
    axi_lite_reader( STATUS_REG(11 downto 0)    , x"00000000" , '0', '0', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready );
    if s_axi_csr_rdata(1) /= '1' then
        assert false
        report "Failure! - Not Armed!"
        severity FAILURE; 
    else
        assert false
        report "Trigger Mechanism is armed." 
        severity NOTE; 
    end if;
    wait for 40 ns;
    init_done <= '1';
    wait; 
end process;


    -- tuser[127:0] = Request Header
    -- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[35]    = Read = 1, Write = 0
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    process(m_axis_ddr_aclk)
    begin
        if rising_edge(m_axis_ddr_aclk) then
           s_axis_ddr_rsp_tvalid <= m_axis_ddr_rqst_tvalid;
           s_axis_ddr_rsp_tlast  <= m_axis_ddr_rqst_tlast;
           s_axis_ddr_rsp_tid    <= m_axis_ddr_rqst_tid;
           s_axis_ddr_rsp_tdata  <= (dcnt+15) & (dcnt+14) &
                                    (dcnt+13) & (dcnt+12) &
                                    (dcnt+11) & (dcnt+10) &
                                    (dcnt+9)  & (dcnt+8)  &
                                    (dcnt+7)  & (dcnt+6)  &
                                    (dcnt+5)  & (dcnt+4)  &
                                    (dcnt+3)  & (dcnt+2)  &
                                    (dcnt+1)  & dcnt;
           s_axis_ddr_rsp_tuser  <= m_axis_ddr_rqst_tuser;
        end if;
    end process;    

    m_axis_ddr_rqst_tready        <= '1';

    dcnt <= x"0000" & m_axis_ddr_rqst_tuser(17 downto 2);


s_axis_pctl_tvalid <= '1';

gate_input_process: process
variable g_cntr : std_logic_vector(31 downto 0) := x"00000000";
begin
   wait until (init_done = '1');
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   loop
     wait until rising_edge(s_axis_aclk);
     wait for 0.5 ns;  
     if (param_record.MODE_SEL(1 downto 0) = "00") then -- gate mode
        if (g_cntr < to_stdlogicvector(param_record.LINK1_DESCR_WORD1)) then
             s_axis_pctl_tdata(0) <= '1';
        else
             s_axis_pctl_tdata(0) <= '0';
        end if;
     else
        if (g_cntr = x"00000000" ) or (g_cntr =  to_stdlogicvector(param_record.TRIG_SPACE)) then
           s_axis_pctl_tdata(0) <= '1';
        else
           s_axis_pctl_tdata(0) <= '0';
        end if;
     end if;
        g_cntr := g_cntr + 1;
   end loop;
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
         HREAD(l,param_record.MODE_SEL, ok);
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
         HREAD(l,param_record.DATA_MODE_SEL, ok);
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
         HREAD(l,param_record.DIV_RATE_VALUE, ok);
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
         HREAD(l,param_record.GATE_OUTPUT_DELAY, ok);
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
         HREAD(l,param_record.TRIG_SPACE, ok);
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
         HREAD(l,param_record.LL_START_ADDRESS, ok);
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
         HREAD(l,param_record.INTERRUPT_ENABLE, ok);
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
         HREAD(l,param_record.LINK1_DESCR_WORD0 , ok);
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
         HREAD(l,param_record.LINK1_DESCR_WORD1 , ok);
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
         HREAD(l,param_record.LINK1_DESCR_WORD2 , ok);
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
         HREAD(l,param_record.LINK1_DESCR_WORD3 , ok);
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
         HREAD(l,param_record.LINK1_DESCR_WORD4 , ok);
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
         HREAD(l,param_record.LINK2_DESCR_WORD0 , ok);
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
         HREAD(l,param_record.LINK2_DESCR_WORD1 , ok);
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
         HREAD(l,param_record.LINK2_DESCR_WORD2 , ok);
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
         HREAD(l,param_record.LINK2_DESCR_WORD3 , ok);
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
         HREAD(l,param_record.LINK2_DESCR_WORD4 , ok);
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
