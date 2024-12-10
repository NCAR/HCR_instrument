----------------------------------------------------------------------------------
-- Pentek PCIe to AXI-S DMA Testbench
----------------------------------------------------------------------------------
-- tb_px_dma_pcie2hmc.vhd
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

entity tb_px_dma_pcie2pd is
Generic (
    pcie_channel          : integer range 0 to 7 := 2; -- 0-7 (must be unique)   
    parameter_file_name : string := "..\..\..\test_parameters.txt"
);
end tb_px_dma_pcie2pd;

architecture Behavioral of tb_px_dma_pcie2pd is

-- UUT
component px_dma_pcie2pd is
generic(
   pcie_channel             : integer range 0 to 7 := 0 -- 0-7 (must be unique) 
);
port (
   aclk                     : in  std_logic;
   aresetn                  : in  std_logic;
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI-LITE)
   ----------------------------------------------------------------------------
   -- associated with aclk
   
   s_axi_csr_aresetn        : in  std_logic; -- reset control/status registers only
   s_axi_csr_awaddr         : in  std_logic_vector(5 downto 0);
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
   s_axi_csr_araddr         : in  std_logic_vector(5 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
   
   irq                      : out std_logic; -- Interrupt out
   ----------------------------------------------------------------------------
   -- Linked List Descriptor RAM (AXI-LITE) 
   ----------------------------------------------------------------------------
   -- associated with aclk
   s_axi_descr_awaddr       : in  std_logic_vector(15 downto 0);
   s_axi_descr_awprot       : in  std_logic_vector(2 downto 0);
   s_axi_descr_awvalid      : in  std_logic;
   s_axi_descr_awready      : out std_logic;
   s_axi_descr_wdata        : in  std_logic_vector(31 downto 0);
   s_axi_descr_wstrb        : in  std_logic_vector(3 downto 0);
   s_axi_descr_wvalid       : in  std_logic;
   s_axi_descr_wready       : out std_logic;
   s_axi_descr_bresp        : out std_logic_vector(1 downto 0);
   s_axi_descr_bvalid       : out std_logic;
   s_axi_descr_bready       : in  std_logic;
   s_axi_descr_araddr       : in  std_logic_vector(15 downto 0);
   s_axi_descr_arprot       : in  std_logic_vector(2 downto 0);
   s_axi_descr_arvalid      : in  std_logic;
   s_axi_descr_arready      : out std_logic;
   s_axi_descr_rdata        : out std_logic_vector(31 downto 0);
   s_axi_descr_rresp        : out std_logic_vector(1 downto 0);
   s_axi_descr_rvalid       : out std_logic;
   s_axi_descr_rready       : in  std_logic;   
   ----------------------------------------------------------------------------
   -- Output PCIe Requester Request Data Stream (AXI-Stream Stream Master)
   ----------------------------------------------------------------------------
   -- associated with aclk
   -- Address aligned mode  
   m_axis_pcie_rq_tvalid    : out std_logic;
   m_axis_pcie_rq_tready    : in  std_logic;
   m_axis_pcie_rq_tdata     : out std_logic_vector(255 downto 0); -- not used for read requests
   m_axis_pcie_rq_tkeep     : out std_logic_vector(31 downto 0);    
   m_axis_pcie_rq_tuser     : out std_logic_vector(59 downto 0);
   m_axis_pcie_rq_tlast     : out std_logic; -- end of packet
   ----------------------------------------------------------------------------
   -- Input PCIe Requester Completion Data Stream (AXI-Stream Stream Slave)
   ----------------------------------------------------------------------------
   -- associated with aclk
   -- address aligned mode
   s_axis_pcie_rc_tvalid    : in  std_logic;
   s_axis_pcie_rc_tready    : out std_logic;
   s_axis_pcie_rc_tdata     : in  std_logic_vector(255 downto 0);
   s_axis_pcie_rc_tkeep     : in  std_logic_vector(31 downto 0);    
   s_axis_pcie_rc_tuser     : in  std_logic_vector(74 downto 0);
   s_axis_pcie_rc_tlast     : in  std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- Data Output (AXI4-Stream Master) 
   -----------------------------------------------------------------------------
   m_axis_rcv_buf_tvalid    : out std_logic;
   m_axis_rcv_buf_tlast     : out std_logic;
   m_axis_rcv_buf_tdata     : out std_logic_vector(255 downto 0);
   m_axis_rcv_buf_tkeep     : out std_logic_vector(31 downto 0);
   m_axis_rcv_buf_tready    : in  std_logic;
   ----------------------------------------------------------------------------
   -- PCI Express Misc. Control
   ------------------------------------------------------------------------------ 
   -- associated with aclk
   -- [2:0] - max payload size
   -- [6:4] - max request size
   -- [7]   - byte swap
   s_axis_cntl_tdata        : in  std_logic_vector(7 downto 0);   
   s_axis_cntl_tvalid       : in  std_logic 
);
end component px_dma_pcie2pd;

-- 32 deep and 128 wide
-- Common Clock
-- AXI-S FIFO
-- AFL at 26
component px_dma_pcie2pd_rqst_fifo
  port (
    s_aclk          : in  std_logic;
    s_aresetn       : in  std_logic;
    s_axis_tvalid   : in  std_logic;
    s_axis_tready   : out std_logic;
    s_axis_tdata    : in  std_logic_vector(127 downto 0);
    s_axis_tuser    : in  std_logic_vector(59 downto 0);
    m_axis_tvalid   : out std_logic;
    m_axis_tready   : in  std_logic;
    m_axis_tdata    : out std_logic_vector(127 downto 0);
    m_axis_tuser    : out std_logic_vector(59 downto 0);
    axis_prog_full  : out std_logic
  );
end component;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------


type param_record_type is RECORD
    
    PCIE_RQST_SIZE      : std_ulogic_vector(3 downto 0);  -- Maximum PCIe Read Request Size (Determined by PCIe Host, usually 512) 0x0=128 0x1=256 0x2= 512 0x3=1024 0x4=2048 0x5=4096
    LINK_START_ADDRESS  : std_ulogic_vector(15 downto 0); -- First Linked List Descriptor address (must be on 64 byte boundaries)   
    PCIE_A_Address      : std_ulogic_vector(63 downto 0); -- PCIe Destination Start Address to program in first descriptor (DWORD address boundary) 
    PCIE_A_MetaAddress  : std_ulogic_vector(63 downto 0); -- PCIe Meta Data Destination Start Address to program in first descriptor (must be DWORD address boundary)   
    BufferA_ByteSize    : integer range 1 to 16383;      -- Buffer A bytes to transfer. (limited in size for test) to program first descriptor with
    META_LENGTHA        : integer range 1 to 16383;      -- Buffer A bytes to transfer in meta data. (limited in size for test)
    PCIE_B_Address      : std_ulogic_vector(63 downto 0); -- PCIe Destination Start Address to program in second descriptor (DWORD address boundary)               
    PCIE_B_MetaAddress  : std_ulogic_vector(63 downto 0); -- PCIe Meta Data Destination Start Address to program in second descriptor (must be DWORD address boundary)   
    BufferB_ByteSize    : integer range 1 to 16383;      -- Buffer B bytes to transfer. (limited in size for test) to program second descriptor with                       
    META_LENGTHB        : integer range 1 to 16383;      -- Buffer B bytes to transfer in meta data. (limited in size for test)    
                                           
    A_AUTO              : boolean;                     -- First Descriptor Auto Mode (test does not yet support manual setting '0')
    A_INCR_MODE         : boolean;                     -- First Descriptor Loop Increment Mode
    A_USE_META_LEN      : boolean;                     -- First Descriptor Use Meta Data Length Mode
    A_LINK_END_INT_EN   : boolean;                     -- First Descriptor Enable Link End Interrupt 
    A_CHAIN_END_INT_EN  : boolean;                     -- First Descriptor Enable Chain End Interrupt 
    A_CHAIN_END         : boolean;                     -- First Descriptor Is End of Chain. 
    A_LOOP_LENGTH       : integer range 0 to 16383;      -- First Descriptor number of times to loop in Loop Increment Mode (# loops -1)
    A_LOOP_ADDR_INCR    : std_ulogic_vector(31 downto 0); -- First Descriptor number of bytes to increment address in loop increment mode. 
      
    B_AUTO              : boolean;                     -- Second Descriptor Auto Mode (test does not yet support manual setting '0')         
    B_INCR_MODE         : boolean;                     -- Second Descriptor Loop Increment Mode                                              
    B_USE_META_LEN      : boolean;                     -- Second Descriptor Use Meta Data Length Mode                                                                                           
    B_LINK_END_INT_EN   : boolean;                     -- Second Descriptor Enable Link End Interrupt                                        
    B_CHAIN_END_INT_EN  : boolean;                     -- Second Descriptor Enable Chain End Interrupt                                       
    B_CHAIN_END         : boolean;                     -- Second Descriptor Is End of Chain.                                                                                                   
    B_LOOP_LENGTH       : integer range 0 to 16383;      -- Second Descriptor number of times to loop in Loop Increment Mode (# loops -1)      
    B_LOOP_ADDR_INCR    : std_ulogic_vector(31 downto 0); -- Second Descriptor number of bytes to increment address in loop increment mode.      "00";
end record param_record_type;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------


----------------------------------------------------------------------------
-- Control/Status Registers (AXI-LITE)
----------------------------------------------------------------------------
-- associated with aclk
signal aclk                     : std_logic := '0';
signal aresetn                  : std_logic := '0';
signal s_axi_csr_aresetn        : std_logic := '0';
signal s_axi_csr_awaddr         : std_logic_vector(15 downto 0) := (others => '0');
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
signal s_axi_csr_araddr         : std_logic_vector(15 downto 0) := (others => '0');
signal s_axi_csr_arprot         : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_arvalid        : std_logic := '0';
signal s_axi_csr_arready        : std_logic := '0';
signal s_axi_csr_rdata          : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp          : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid         : std_logic := '0';
signal s_axi_csr_rready         : std_logic := '1';

signal irq                      : std_logic := '0'; -- Interrupt out
----------------------------------------------------------------------------
-- Linked List RAM (AXI-LITE) 
----------------------------------------------------------------------------
signal s_axi_descr_awaddr       : std_logic_vector(15 downto 0):= (others => '0');
signal s_axi_descr_awprot       : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_descr_awvalid      : std_logic := '0';
signal s_axi_descr_awready      : std_logic := '0';
signal s_axi_descr_wdata        : std_logic_vector(31 downto 0):= (others => '0');
signal s_axi_descr_wstrb        : std_logic_vector(3 downto 0) := (others => '0');
signal s_axi_descr_wvalid       : std_logic := '0';
signal s_axi_descr_wready       : std_logic := '0';
signal s_axi_descr_bresp        : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_descr_bvalid       : std_logic := '0';
signal s_axi_descr_bready       : std_logic := '0';
signal s_axi_descr_araddr       : std_logic_vector(15 downto 0):= (others => '0');
signal s_axi_descr_arprot       : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_descr_arvalid      : std_logic := '0';
signal s_axi_descr_arready      : std_logic := '0';
signal s_axi_descr_rdata        : std_logic_vector(31 downto 0):= (others => '0');
signal s_axi_descr_rresp        : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_descr_rvalid       : std_logic := '0';
signal s_axi_descr_rready       : std_logic := '1';   

----------------------------------------------------------------------------
-- Output PCIe Request Stream (AXI-Stream Stream Master)
----------------------------------------------------------------------------
   
signal m_axis_pcie_rq_tvalid    : std_logic := '0';
signal m_axis_pcie_rq_tready    : std_logic := '0';
signal m_axis_pcie_rq_tdata     : std_logic_vector(255 downto 0):= (others => '0'); -- not used for read requests
signal m_axis_pcie_rq_tkeep     : std_logic_vector(31 downto 0):= (others => '0');    
signal m_axis_pcie_rq_tuser     : std_logic_vector(59 downto 0):= (others => '0');
signal m_axis_pcie_rq_tlast     : std_logic; -- end of packet
----------------------------------------------------------------------------
-- Input PCIe Requester Completion Data Stream (AXI-Stream Stream Slave)
----------------------------------------------------------------------------
-- address aligned mode
signal s_axis_pcie_rc_tvalid    : std_logic := '0';
signal s_axis_pcie_rc_tready    : std_logic := '0';
signal s_axis_pcie_rc_tdata     : std_logic_vector(255 downto 0):= (others => '0');
signal s_axis_pcie_rc_tkeep     : std_logic_vector(31 downto 0):= (others => '0');    
signal s_axis_pcie_rc_tuser     : std_logic_vector(74 downto 0):= (others => '0');
signal s_axis_pcie_rc_tlast     : std_logic := '0'; -- end of packet
----------------------------------------------------------------------------
-- HMC Write Request Interface (AXI Stream)
----------------------------------------------------------------------------  
signal m_axis_rcv_buf_tvalid    : std_logic := '0';
signal m_axis_rcv_buf_tlast     : std_logic := '0';
signal m_axis_rcv_buf_tdata     : std_logic_vector(255 downto 0):= (others => '0');
signal m_axis_rcv_buf_tkeep     : std_logic_vector(31 downto 0):= (others => '0');
signal m_axis_rcv_buf_tready    : std_logic := '1';
   
----------------------------------------------------------------------------
-- PCI Express Control
----------------------------------------------------------------------------
signal max_pcie_pkt_256         : std_logic := '0'; -- '1' = 256 byte is max PCIe packet size, '0' = 128 byte is max size  

signal BufferAControlWord: std_logic_vector(31 downto 0);
signal BufferBControlWord: std_logic_vector(31 downto 0);
signal reset_done : std_logic := '0';

signal wr_rsp_tvalid     : std_logic := '0';
signal wr_rsp_tuser      : std_logic_vector(71 downto 0)   := (others => '0');   

signal s_axis_cntl_tdata   : std_logic_vector(7 downto 0):= x"00";   
signal s_axis_cntl_tvalid  : std_logic:= '1'; 

signal meta_ram_buffer_a : std_logic_vector(127 downto 0):= (others => '0');
signal meta_ram_buffer_b : std_logic_vector(127 downto 0):= (others => '0');


signal rqst_in_tuser     : std_logic_vector(143 downto 0):= (others => '0');
signal pcie_rq_tvalid    : std_logic := '0';
signal pcie_rq_tready    : std_logic := '0';
signal pcie_rq_tdata     : std_logic_vector(255 downto 0):= (others => '0'); -- not used for read requests
signal pcie_rq_tkeep     : std_logic_vector(7 downto 0):= (others => '0');    
signal pcie_rq_tuser     : std_logic_vector(59 downto 0):= (others => '0');
signal rqst_fifo_tuser   : std_logic_vector(59 downto 0):= (others => '0');

signal rqst_size         : std_logic_vector(3 downto 0):= (others => '0');

shared variable param_record : param_record_type;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
-- CSR Register Addresses
constant DMA_RESET_REG: std_logic_vector(15 downto 0)       := x"0000"; --"000000";
constant DMA_ADV_REG: std_logic_vector(15 downto 0)         := x"0004";--"000100";
constant DMA_ABORT_REG: std_logic_vector(15 downto 0)       := x"0008";--"000100";
constant DMA_LL_START_REG: std_logic_vector(15 downto 0)    := x"000C";--"001100";
constant DMA_STATUS_REG: std_logic_vector(15 downto 0)      := x"0020";--"100000";
constant INTRPT_ENABLE_REG: std_logic_vector(15 downto 0)   := x"0034";--"110100";

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

-- Descriptor Control Word
-- [0:0]   = AUTO
-- [1:1]   = Reserved
-- [2:2]   = Reserved
-- [3:3]   = INCR MODE
-- [4:4]   = Reserved
-- [5:5]   = Reserved
-- [6:6]   = Reserved
-- [7:7]   = Use Meta Data bytes to TRNSFR
-- [8:8]   = LINK END INT EN
-- [9:9]   = CHAIN END INT EN
-- [10:10] = CHAIN END
-- [11:11] = Reserved
-- [13:12] = PCIE AT
-- [15:14] = Reserved
-- [31:16] = INCR LOOP COUNT[15:0]
 
BufferAControlWord(0) <= To_Std_Logic(param_record.A_AUTO);        
BufferAControlWord(1) <= '0';             
BufferAControlWord(2) <= '0';         
BufferAControlWord(3) <= To_Std_Logic(param_record.A_INCR_MODE);
BufferAControlWord(4) <= '0';
BufferAControlWord(5) <= '0';
BufferAControlWord(6) <= '0';               
BufferAControlWord(7) <= To_Std_Logic(param_record.A_USE_META_LEN);       
BufferAControlWord(8) <= To_Std_Logic(param_record.A_LINK_END_INT_EN);   
BufferAControlWord(9) <= To_Std_Logic(param_record.A_CHAIN_END_INT_EN);  
BufferAControlWord(10) <= To_Std_Logic(param_record.A_CHAIN_END);         
BufferAControlWord(11) <= '0';          
BufferAControlWord(13 downto 12) <= "00";
BufferAControlWord(15 downto 14) <= "00";       
BufferAControlWord(31 downto 16) <= conv_std_logic_vector(param_record.A_LOOP_LENGTH-1, 16);       

BufferBControlWord(0) <= To_Std_Logic(param_record.B_AUTO);          
BufferBControlWord(1) <= '0';  
BufferBControlWord(2) <= '0';         
BufferBControlWord(3) <= To_Std_Logic(param_record.B_INCR_MODE);         
BufferBControlWord(4) <= '0';    
BufferBControlWord(5) <= '0';  
BufferBControlWord(6) <= '0';  
BufferBControlWord(7) <= To_Std_Logic(param_record.B_USE_META_LEN);       
BufferBControlWord(8) <= To_Std_Logic(param_record.B_LINK_END_INT_EN);   
BufferBControlWord(9) <= To_Std_Logic(param_record.B_CHAIN_END_INT_EN);  
BufferBControlWord(10) <= To_Std_Logic(param_record.B_CHAIN_END);         
BufferBControlWord(11) <= '0';          
BufferBControlWord(13 downto 12) <= "00";
BufferBControlWord(15 downto 14) <= "00";   
BufferBControlWord(31 downto 16) <= conv_std_logic_vector(param_record.B_LOOP_LENGTH-1, 16);


meta_ram_buffer_a(95 downto 64) <= conv_std_logic_vector(param_record.META_LENGTHA, 32);
meta_ram_buffer_b(95 downto 64) <= conv_std_logic_vector(param_record.META_LENGTHB, 32);

rqst_size <= to_stdlogicvector(param_record.PCIE_RQST_SIZE); -- Maximum Read Request Size allowed by Host
s_axis_cntl_tdata(6 downto 4) <= rqst_size(2 downto 0);

px_dma_pcie2pd_inst: px_dma_pcie2pd
generic map(
pcie_channel =>  pcie_channel    -- 0-7 (must be unique)   
)
port map(
   aclk                     => aclk, 
   aresetn                  => aresetn,
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI-LITE)
   ----------------------------------------------------------------------------
   s_axi_csr_aresetn        => s_axi_csr_aresetn,
   s_axi_csr_awaddr         => s_axi_csr_awaddr(5 downto 0), 
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
   s_axi_csr_araddr         => s_axi_csr_araddr(5 downto 0), 
   s_axi_csr_arprot         => s_axi_csr_arprot, 
   s_axi_csr_arvalid        => s_axi_csr_arvalid,
   s_axi_csr_arready        => s_axi_csr_arready,
   s_axi_csr_rdata          => s_axi_csr_rdata,  
   s_axi_csr_rresp          => s_axi_csr_rresp, 
   s_axi_csr_rvalid         => s_axi_csr_rvalid, 
   s_axi_csr_rready         => s_axi_csr_rready, 
   
   irq                      => irq,  -- Interrupt out
   ----------------------------------------------------------------------------
   -- Linked List RAM (AXI-LITE) 
   ----------------------------------------------------------------------------
   s_axi_descr_awaddr       => s_axi_descr_awaddr, 
   s_axi_descr_awprot       => s_axi_descr_awprot, 
   s_axi_descr_awvalid      => s_axi_descr_awvalid,
   s_axi_descr_awready      => s_axi_descr_awready,
   s_axi_descr_wdata        => s_axi_descr_wdata,  
   s_axi_descr_wstrb        => s_axi_descr_wstrb,  
   s_axi_descr_wvalid       => s_axi_descr_wvalid, 
   s_axi_descr_wready       => s_axi_descr_wready, 
   s_axi_descr_bresp        => s_axi_descr_bresp, 
   s_axi_descr_bvalid       => s_axi_descr_bvalid, 
   s_axi_descr_bready       => s_axi_descr_bready, 
   s_axi_descr_araddr       => s_axi_descr_araddr, 
   s_axi_descr_arprot       => s_axi_descr_arprot, 
   s_axi_descr_arvalid      => s_axi_descr_arvalid,
   s_axi_descr_arready      => s_axi_descr_arready,
   s_axi_descr_rdata        => s_axi_descr_rdata,  
   s_axi_descr_rresp        => s_axi_descr_rresp,  
   s_axi_descr_rvalid       => s_axi_descr_rvalid, 
   s_axi_descr_rready       => s_axi_descr_rready, 
   ----------------------------------------------------------------------------
   -- Output PCIe Packet Data Stream (AXI-Stream Stream Master)
   ----------------------------------------------------------------------------
   m_axis_pcie_rq_tvalid    => m_axis_pcie_rq_tvalid,
   m_axis_pcie_rq_tready    => m_axis_pcie_rq_tready,  
   m_axis_pcie_rq_tdata     => m_axis_pcie_rq_tdata, 
   m_axis_pcie_rq_tkeep     => m_axis_pcie_rq_tkeep,   
   m_axis_pcie_rq_tuser     => m_axis_pcie_rq_tuser, 
   m_axis_pcie_rq_tlast     => m_axis_pcie_rq_tlast, 
   ----------------------------------------------------------------------------
   -- Input PCIe Requester Completion Data Stream (AXI-Stream Stream Slave)
   ----------------------------------------------------------------------------
   -- address aligned mode
   s_axis_pcie_rc_tvalid    => s_axis_pcie_rc_tvalid, 
   s_axis_pcie_rc_tready    => s_axis_pcie_rc_tready, 
   s_axis_pcie_rc_tdata     => s_axis_pcie_rc_tdata,  
   s_axis_pcie_rc_tkeep     => s_axis_pcie_rc_tkeep,  
   s_axis_pcie_rc_tuser     => s_axis_pcie_rc_tuser,  
   s_axis_pcie_rc_tlast     => s_axis_pcie_rc_tlast,  
   -----------------------------------------------------------------------------
   -- Data Output (AXI4-Stream Master) 
   -----------------------------------------------------------------------------
   m_axis_rcv_buf_tvalid    => m_axis_rcv_buf_tvalid, 
   m_axis_rcv_buf_tlast     => m_axis_rcv_buf_tlast,  
   m_axis_rcv_buf_tdata     => m_axis_rcv_buf_tdata,  
   m_axis_rcv_buf_tkeep     => m_axis_rcv_buf_tkeep,  
   m_axis_rcv_buf_tready    => m_axis_rcv_buf_tready, 
   ------------------------- ---------------------------------------------------
   -- PCI Express Control    
   ------------------------- ---------------------------------------------------
   s_axis_cntl_tdata        => s_axis_cntl_tdata,
   s_axis_cntl_tvalid       => '1'
   );   
--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------

-- Clock = 250MHz
process
begin
    loop
        aclk <= not aclk;
        wait for 2 ns;
    end loop;
end process;

process
begin
wait for 400 ns;
aresetn <= '1';
s_axi_csr_aresetn <= '1';
wait for 40 ns;
reset_done <= '1';
wait;
end process;

--------------------------------------------------------------------------------
-- Set Up Linked List RAM and DMA registers
--------------------------------------------------------------------------------
-- DWORD 0 -- descriptor_ram_readdata[31:0]	    Control Word
-- DWORD 1 -- descriptor_ram_readdata[63:32]    Bytes to Transfer[31:0]
-- DWORD 2 -- descriptor_ram_readdata[95:64]    Source Address[31:0] 
-- DWORD 3 -- descriptor_ram_readdata[127:96]   Source Address[63:32] 
-- DWORD 4 -- descriptor_ram_readdata[159:128]  Source Meta Data Address[31:0] 
-- DWORD 5 -- descriptor_ram_readdata[191:160]  Source Meta Data Address[63:32] 
-- DWORD 6 -- descriptor_ram_readdata[223:192]  Loop Address Increment Value[31:0] 
-- DWORD 7 -- descriptor_ram_readdata[255:224]  Next Link Address[15:0]

setup_process: process
variable c_time : time := 0 ns;
variable d_time : time := 0 ns;

begin
    wait until reset_done = '1';
    c_time := now; 
    assert false
    report "Writing the Linked List Descriptors. Start Time = " & time'image(now) 
    severity NOTE;

    -- Write BufferA Descriptor Control Word   
    axi_lite_writer( x"0000", BufferAControlWord, aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Bytes to Transfer
    axi_lite_writer( x"0004", (conv_std_logic_vector(param_record.BufferA_ByteSize, 32)), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Source Address [31:0] 
    axi_lite_writer( x"0008", to_stdlogicvector(param_record.PCIE_A_Address(31 downto 0)), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Source Address [63:32] 
    axi_lite_writer( x"000C", to_stdlogicvector(param_record.PCIE_A_Address(63 downto 32)), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Source Meta Address [31:0] 
    axi_lite_writer( x"0010", to_stdlogicvector(param_record.PCIE_A_MetaAddress(31 downto 0)) , aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Source Meta Address [63:32] 
    axi_lite_writer( x"0014", to_stdlogicvector(param_record.PCIE_A_MetaAddress(63 downto 32)), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Loop Address Increment
    axi_lite_writer( x"0018", to_stdlogicvector(param_record.A_LOOP_ADDR_INCR), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Next Link Address
    axi_lite_writer( x"001C", x"00000020" , aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);

    -- Write BufferB Descriptor Control Word   
    axi_lite_writer( x"0020", BufferBControlWord, aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Bytes to Transfer
    axi_lite_writer( x"0024", (conv_std_logic_vector(param_record.BufferB_ByteSize, 32)), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Source Address [31:0] 
    axi_lite_writer( x"0028", to_stdlogicvector(param_record.PCIE_B_Address(31 downto 0)), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Source Address [63:32] 
    axi_lite_writer( x"002C", to_stdlogicvector(param_record.PCIE_B_Address(63 downto 32)), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Source Meta Address [31:0] 
    axi_lite_writer( x"0030", to_stdlogicvector(param_record.PCIE_B_MetaAddress(31 downto 0)), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Source Meta Address [63:32] 
    axi_lite_writer( x"0034", to_stdlogicvector(param_record.PCIE_B_MetaAddress(63 downto 32)), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Loop Address Increment
    axi_lite_writer( x"0038", to_stdlogicvector(param_record.B_LOOP_ADDR_INCR), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Next Link Address
    axi_lite_writer( x"003C", x"00000000" , aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);

    d_time := now - c_time; 
    assert false
    report "Finished writing the Linked List Descriptors. End Time = " & time'image(now) 
    severity NOTE;
    assert false
    report "Total Time = " & time'image(d_time) 
    severity NOTE;  

    c_time := now; 
    assert false
    report "Reading back and verifying Linked List Descriptors. Start Time = " & time'image(now) 
    severity NOTE;    
        

    -- Read BufferA Descriptor Control Word   
    axi_lite_reader( x"0000", BufferAControlWord, '1', '1', aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Bytes to Transfer
    axi_lite_reader( x"0004", (conv_std_logic_vector(param_record.BufferA_ByteSize, 32)), '1', '1', aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Address [31:0] 
    axi_lite_reader( x"0008", to_stdlogicvector(param_record.PCIE_A_Address(31 downto 0)), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Address [63:32] 
    axi_lite_reader( x"000C", to_stdlogicvector(param_record.PCIE_A_Address(63 downto 32)), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Meta Address [31:0] 
    axi_lite_reader( x"0010", to_stdlogicvector(param_record.PCIE_A_MetaAddress(31 downto 0)), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Meta Address [63:32] 
    axi_lite_reader( x"0014", to_stdlogicvector(param_record.PCIE_A_MetaAddress(63 downto 32)), '1', '1', aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Loop Address Increment
    axi_lite_reader( x"0018", to_stdlogicvector(param_record.A_LOOP_ADDR_INCR), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Next Link Address
    axi_lite_reader( x"001C", x"00000020" , '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);

    -- Read BufferB Descriptor Control Word   
    axi_lite_reader( x"0020", BufferBControlWord, '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferB Descriptor Bytes to Transfer
    axi_lite_reader( x"0024", (conv_std_logic_vector(param_record.BufferB_ByteSize, 32)), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferB Descriptor Source Address [31:0] 
    axi_lite_reader( x"0028", to_stdlogicvector(param_record.PCIE_B_Address(31 downto 0)), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferB Descriptor Source Address [63:32] 
    axi_lite_reader( x"002C", to_stdlogicvector(param_record.PCIE_B_Address(63 downto 32)), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferB Descriptor Source Meta Address [31:0] 
    axi_lite_reader( x"0030", to_stdlogicvector(param_record.PCIE_B_MetaAddress(31 downto 0)), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferB Descriptor Source Meta Address [63:32] 
    axi_lite_reader( x"0034", to_stdlogicvector(param_record.PCIE_B_MetaAddress(63 downto 32)), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferB Descriptor Loop Address Increment
    axi_lite_reader( x"0038", to_stdlogicvector(param_record.B_LOOP_ADDR_INCR), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferB Next Link Address
    axi_lite_reader( x"003C", x"00000000" , '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);

    d_time := now - c_time; 
    assert false
    report "Finished Reading the Linked List Descriptors. End Time = " & time'image(now) 
    severity NOTE;
    assert false
    report "Total Time = " & time'image(d_time) 
    severity NOTE;  

    -- Write Linked List Start Address 
    assert false
    report "Writing the Linked List Start Address." 
    severity NOTE;  
    axi_lite_writer( DMA_LL_START_REG, (x"0000" & to_stdlogicvector(param_record.LINK_START_ADDRESS)), aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    assert false
    report "Verifing the Linked List Start Address." 
    severity NOTE;     
    axi_lite_reader(DMA_LL_START_REG, (x"0000" & to_stdlogicvector(param_record.LINK_START_ADDRESS)) , '1', '1',  aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
  
    -- Enable DMA Interrupts
    assert false
    report "Enabling DMA Link End and Chain End Interrupts." 
    severity NOTE;    
    axi_lite_writer( INTRPT_ENABLE_REG, x"00000003", aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    
    -- abort
        axi_lite_writer( DMA_ABORT_REG, x"00000001" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
        axi_lite_writer( DMA_ABORT_REG, x"00000000" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
              
    wait for 500 ns;
    
     -- Reset the DMA
    assert false
    report "Resetting the DMA." 
    severity NOTE;    
    axi_lite_writer( DMA_RESET_REG, x"00000001" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( DMA_RESET_REG, x"00000000" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);

    -- Start the DMA
    assert false
    report "Starting the DMA" 
    severity NOTE;    
    axi_lite_writer( DMA_ADV_REG, x"00000001" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    axi_lite_writer( DMA_ADV_REG, x"00000000" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
  
    wait for 1700 ns;
    -- abort
    --axi_lite_writer( DMA_ABORT_REG, x"00000001" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    --axi_lite_writer( DMA_ABORT_REG, x"00000000" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
           

    wait; 
end process;


--------------------------------------------------------------------------------
-- PCIe Requestor Request Interface
--------------------------------------------------------------------------------

rqst_in_tuser     <=  x"000000000000000000000" & m_axis_pcie_rq_tuser;  

rqst_fifo_inst : px_dma_pcie2pd_rqst_fifo
  PORT MAP (
    s_aclk          => aclk,
    s_aresetn       => aresetn,
    s_axis_tvalid   => m_axis_pcie_rq_tvalid,
    s_axis_tready   => m_axis_pcie_rq_tready,
    s_axis_tdata    => m_axis_pcie_rq_tdata(127 downto 0),
    s_axis_tuser    =>  m_axis_pcie_rq_tuser, --rqst_in_tuser,
    m_axis_tvalid   => pcie_rq_tvalid,
    m_axis_tready   => pcie_rq_tready,
    m_axis_tdata    => pcie_rq_tdata(127 downto 0),
    m_axis_tuser    => rqst_fifo_tuser,
    axis_prog_full  => open
  );
  
pcie_rq_tdata(255 downto 128) <= (others => '0');
pcie_rq_tuser                 <= rqst_fifo_tuser(59 downto 0);  
pcie_rq_tkeep                 <= x"0F"; 

-- Complete Read Requests
pcie_rd_rqst_process: process
variable tag    : std_logic_vector(7 downto 0);               
variable buffer_addrx: std_logic_vector(63 downto 0);    
--variable buffer_addr: integer;  
variable buffer_addr: std_logic_vector(31 downto 0);     
variable dword_count: std_logic_vector(10 downto 0);
variable byte_count: std_logic_vector(12 downto 0);
variable dw_offset: std_logic_vector(1 downto 0);
variable datax: std_logic_vector(511 downto 0);
variable datax1: std_logic_vector(255 downto 0);
variable datax2: std_logic_vector(255 downto 0);
variable datax3: std_logic_vector(255 downto 0);
variable rqst_cmplt : std_logic := '0';
variable dwcnt: std_logic_vector(10 downto 0);

begin
    s_axis_pcie_rc_tvalid     <= '0';
    s_axis_pcie_rc_tuser      <= (others => '0');
    s_axis_pcie_rc_tdata      <= (others => '0'); 
    s_axis_pcie_rc_tkeep      <= (others => '0');
    wait until reset_done = '1';
    wait for 100 ns;
    wait until rising_edge(aclk);
    wait for 0.5 ns;  
    loop   
      pcie_rq_tready <= '1';
      -- Wait for a request
      if  (pcie_rq_tvalid = '0') then
        wait until(pcie_rq_tvalid = '1');
      end if;
      wait until rising_edge(aclk);
      dword_count      := pcie_rq_tdata(74 downto 64); -- DWORDs requested
      buffer_addrx     := pcie_rq_tdata(63 downto 2) & "00"; -- Source Start Address
      --buffer_addr      := conv_integer(('0' &  pcie_rq_tdata(13 downto 2) & "00"));
      buffer_addr      := pcie_rq_tdata(31 downto 2) & "00";
      tag              := pcie_rq_tdata(103 downto 96); -- Tag
      byte_count       := dword_count & "00";
      dw_offset        := pcie_rq_tuser(9 downto 8);
      wait for 0.5 ns;    
      pcie_rq_tready <= '0';    

  
     if    buffer_addrx(63 downto 10) = to_stdlogicvector(param_record.PCIE_A_MetaAddress(63 downto 10)) then
            wait until rising_edge(aclk);
            wait for 0.5 ns; 
            s_axis_pcie_rc_tdata(255 downto 0) <=  x"0000000000000000000000000000000000000000" & '0' & "000" & "000" & '0' & x"0000" & tag & x"0000" &
                                     '0' & '0' & "000" &  "00000010000" & '0' & '1' & '0' & byte_count & "0000" & buffer_addrx(11 downto 0);
            s_axis_pcie_rc_tlast <= '0';
            s_axis_pcie_rc_tvalid <= '1';
            s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
            s_axis_pcie_rc_tuser(31 downto 0) <= x"00000000";  
            s_axis_pcie_rc_tuser(32)          <= '1';            
            wait until rising_edge(aclk);
            wait for 0.5 ns; 
            s_axis_pcie_rc_tdata(127 downto 0)   <= meta_ram_buffer_a(127 downto 0);
            s_axis_pcie_rc_tdata(255 downto 128) <= (others => '0');
            s_axis_pcie_rc_tlast <= '1';
            s_axis_pcie_rc_tvalid <= '1';
            s_axis_pcie_rc_tkeep <= x"0000FFFF";
            s_axis_pcie_rc_tuser(31 downto 0) <= x"0000FFFF"; 
            s_axis_pcie_rc_tuser(32)          <= '0';     
            wait until rising_edge(aclk);
            wait for 0.5 ns; 
            s_axis_pcie_rc_tvalid <= '0';
            s_axis_pcie_rc_tlast <= '0';
     elsif buffer_addrx(63 downto 10) = to_stdlogicvector(param_record.PCIE_B_MetaAddress(63 downto 10)) then
            wait until rising_edge(aclk);
            wait for 0.5 ns; 
            s_axis_pcie_rc_tdata(255 downto 0) <=  x"0000000000000000000000000000000000000000" & '0' & "000" & "000" & '0' & x"0000" & tag & x"0000" &
                                     '0' & '0' & "000" &  "00000010000" & '0' & '1' & '0' & byte_count & "0000" & buffer_addrx(11 downto 0);
            s_axis_pcie_rc_tlast <= '0';
            s_axis_pcie_rc_tvalid <= '1';
            s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
            s_axis_pcie_rc_tuser(31 downto 0) <= x"00000000";  
            s_axis_pcie_rc_tuser(32)          <= '1';               
            wait until rising_edge(aclk);
            wait for 0.5 ns; 
            s_axis_pcie_rc_tdata(127 downto 0)   <= meta_ram_buffer_b(127 downto 0);
            s_axis_pcie_rc_tdata(255 downto 128) <= (others => '0');
            s_axis_pcie_rc_tlast <= '1';
            s_axis_pcie_rc_tvalid <= '1';
            s_axis_pcie_rc_tkeep <= x"0000FFFF";
            s_axis_pcie_rc_tuser(31 downto 0) <= x"0000FFFF";  
            s_axis_pcie_rc_tuser(32)          <= '0';    
            wait until rising_edge(aclk);
            wait for 0.5 ns; 
            s_axis_pcie_rc_tvalid <= '0';
            s_axis_pcie_rc_tlast <= '0';
     else
        
        -- PCs usually return requests broken up into 64 byte packets
        while(byte_count > 0) loop
            wait until rising_edge(aclk);
            wait for 0.5 ns; 
            if (byte_count > 64) then
               rqst_cmplt   := '0';
               dwcnt        := "00001000000";
            else
               rqst_cmplt   := '1';
               dwcnt        := byte_count(12 downto 2);
            end if; 
            s_axis_pcie_rc_tdata(255 downto 0) <=  x"0000000000000000000000000000000000000000" & '0' & "000" & "000" & '0' & x"0000" & tag & x"0000" &
                                            '0' & '0' & "000" &  dwcnt & '0' & rqst_cmplt & '0' & byte_count & "0000" & buffer_addrx(11 downto 0);
            s_axis_pcie_rc_tlast <= '0';
            s_axis_pcie_rc_tvalid <= '1';
            s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
            s_axis_pcie_rc_tuser(31 downto 0) <= x"00000000"; 
            s_axis_pcie_rc_tuser(32)          <= '1';                

            datax :=   "00" & ((buffer_addr(31 downto 2))+ 15) &
                       "00" & ((buffer_addr(31 downto 2))+ 14) &
                       "00" & ((buffer_addr(31 downto 2))+ 13) &
                       "00" & ((buffer_addr(31 downto 2))+ 12) &
                       "00" & ((buffer_addr(31 downto 2))+ 11) &
                       "00" & ((buffer_addr(31 downto 2))+ 10) &
                       "00" & ((buffer_addr(31 downto 2))+ 9) &
                       "00" & ((buffer_addr(31 downto 2))+ 8) &
                       "00" & ((buffer_addr(31 downto 2))+ 7) &
                       "00" & ((buffer_addr(31 downto 2))+ 6) &
                       "00" & ((buffer_addr(31 downto 2))+ 5) &
                       "00" & ((buffer_addr(31 downto 2))+ 4) &
                       "00" & ((buffer_addr(31 downto 2))+ 3) &
                       "00" & ((buffer_addr(31 downto 2))+ 2) &
                       "00" & ((buffer_addr(31 downto 2))+ 1) &
                       "00" & (buffer_addr(31 downto 2));
            case dw_offset is
                when "00" =>
                    datax1 :=  datax(255 downto 0);
                    datax2 :=  datax(511 downto 256);
                    datax3 :=  (others => '0');
                when "01" =>
                    datax1 :=  datax(223 downto 0) & x"00000000";
                    datax2 :=  datax(479 downto 224);
                    datax3 :=  x"00000000" & x"00000000" & x"00000000" & x"00000000" & x"00000000" & x"00000000" & x"00000000" & datax(511 downto 480);
                when "10" =>
                    datax1 :=  datax(191 downto 0) & x"00000000" & x"00000000";
                    datax2 :=  datax(447 downto 192);
                    datax3 :=  x"00000000" & x"00000000" & x"00000000" & x"00000000" & x"00000000" & x"00000000" & datax(511 downto 448);
                when "11" =>
                    datax1 :=  datax(159 downto 0) & x"00000000" & x"00000000" & x"00000000";
                    datax2 :=  datax(415 downto 160);
                    datax3 :=  x"00000000" & x"00000000" & x"00000000" & x"00000000" & x"00000000" & datax(511 downto 416);
                when others =>
                    datax1 :=  datax(159 downto 0) & x"00000000" & x"00000000" & x"00000000";
                    datax2 :=  datax(415 downto 160);
                    datax3 :=  x"00000000" & x"00000000" & x"00000000" & x"00000000" & x"00000000" & datax(511 downto 416);
            end case;
            if (byte_count >= 64) then
                byte_count := byte_count - 64;
                buffer_addr := buffer_addr + 64;
                if dw_offset /= "00" then -- three outputs
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;                                 
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax1;
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '1';
                    case dw_offset is
                        when "01" =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"FFF0";
                        when "10" =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"FF00";
                        when "11" =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"F000";
                        when others =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"FFFF";   
                    end case;
                    s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                    s_axis_pcie_rc_tuser(31 downto 16) <= x"FFFF"; 
                    s_axis_pcie_rc_tuser(32)          <= '0';    
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax2;
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '1';
                    s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                    s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFFFF";   
                    s_axis_pcie_rc_tuser(32)          <= '0';                      
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;    
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax3;
                    s_axis_pcie_rc_tlast <= '1';
                    s_axis_pcie_rc_tvalid <= '1';
                    case dw_offset is
                        when "01" =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"000F";
                           s_axis_pcie_rc_tkeep <= x"0000000F";
                        when "10" =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"00FF";
                           s_axis_pcie_rc_tkeep <= x"000000FF";
                        when "11" =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"0FFF";
                           s_axis_pcie_rc_tkeep <= x"00000FFF";
                        when others =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"0000"; 
                           s_axis_pcie_rc_tkeep <= x"00000000";  
                    end case;
                    s_axis_pcie_rc_tuser(31 downto 16) <= x"0000"; 
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;   
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '0';
                    s_axis_pcie_rc_tuser(32)          <= '0';    
                else -- two outputs
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax1;
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '1';
                    s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                    s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFFFF";
                    s_axis_pcie_rc_tuser(32)          <= '0';    
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;    
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax2;
                    s_axis_pcie_rc_tlast <= '1';
                    s_axis_pcie_rc_tvalid <= '1';
                    s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                    s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFFFF";
                    s_axis_pcie_rc_tuser(32)          <= '0';    
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;   
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '0';
                end if;
            elsif (byte_count >= 32) then
                if ((byte_count+(conv_integer(dw_offset)*4))>64) then -- three outputs
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;                                 
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax1;
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '1';
                    case dw_offset is
                        when "00" =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"FFFF";
                        when "01" =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"FFF0";
                        when "10" =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"FF00";
                        when "11" =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"F000";
                        when others =>
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"FFFF";   
                    end case;
                    s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                    s_axis_pcie_rc_tuser(31 downto 16) <= x"FFFF"; 
                    s_axis_pcie_rc_tuser(32)          <= '0';    
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax2;
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '1';
                    s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                    s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFFFF"; 
                    s_axis_pcie_rc_tuser(32)          <= '0';    
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;    
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax3;
                    s_axis_pcie_rc_tlast <= '1';
                    s_axis_pcie_rc_tvalid <= '1';
                    if ((byte_count+(conv_integer(dw_offset)*4))<=68) then
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"000F";
                           s_axis_pcie_rc_tkeep <= x"0000000F";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=72) then
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"00FF";
                           s_axis_pcie_rc_tkeep <= x"000000FF";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=76) then
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"0FFF";
                           s_axis_pcie_rc_tkeep <= x"00000FFF";
                    else
                           s_axis_pcie_rc_tuser(15 downto 0) <= x"0000"; 
                           s_axis_pcie_rc_tkeep <= x"00000000";  
                    end if;
                    s_axis_pcie_rc_tuser(31 downto 16) <= x"0000"; 
                    s_axis_pcie_rc_tuser(32)          <= '0';    
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;   
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '0';  
                byte_count := "0000000000000";              
                else  -- two outputs
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax1;
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '1';
                    case dw_offset is
                       when "00" =>
                          s_axis_pcie_rc_tuser(15 downto 0) <= x"FFFF";
                       when "01" =>
                          s_axis_pcie_rc_tuser(15 downto 0) <= x"FFF0";
                       when "10" =>
                          s_axis_pcie_rc_tuser(15 downto 0) <= x"FF00";
                       when "11" =>
                          s_axis_pcie_rc_tuser(15 downto 0) <= x"F000";
                       when others =>
                          s_axis_pcie_rc_tuser(15 downto 0) <= x"FFFF";   
                    end case;
                    s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                    s_axis_pcie_rc_tuser(31 downto 16) <= x"FFFF"; 
                    s_axis_pcie_rc_tuser(32)          <= '0';    
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;    
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax2;
                    s_axis_pcie_rc_tlast <= '1';
                    s_axis_pcie_rc_tvalid <= '1';
                    if ((byte_count+(conv_integer(dw_offset)*4))<=36) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"0000000F";
                           s_axis_pcie_rc_tkeep <= x"0000000F";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=40) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"000000FF";
                           s_axis_pcie_rc_tkeep <= x"000000FF";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=44) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"00000FFF";
                           s_axis_pcie_rc_tkeep <= x"00000FFF";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=48) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"0000FFFF";
                           s_axis_pcie_rc_tkeep <= x"0000FFFF";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=52) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"000FFFFF";
                           s_axis_pcie_rc_tkeep <= x"000FFFFF";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=56) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"00FFFFFF";
                           s_axis_pcie_rc_tkeep <= x"00FFFFFF";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=60) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"0FFFFFFF";
                           s_axis_pcie_rc_tkeep <= x"0FFFFFFF";
                    else
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFFFF"; 
                           s_axis_pcie_rc_tkeep <= x"FFFFFFFF";  
                    end if;
                    s_axis_pcie_rc_tuser(32)          <= '0';    
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;   
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '0';    
                    byte_count := "0000000000000";          
                end if; 
            else
                if ((byte_count+(conv_integer(dw_offset)*4))>32) then -- two outputs
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax1;
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '1';
                    case dw_offset is
                       when "00" =>
                          s_axis_pcie_rc_tuser(15 downto 0) <= x"FFFF";
                       when "01" =>
                          s_axis_pcie_rc_tuser(15 downto 0) <= x"FFF0";
                       when "10" =>
                          s_axis_pcie_rc_tuser(15 downto 0) <= x"FF00";
                       when "11" =>
                          s_axis_pcie_rc_tuser(15 downto 0) <= x"F000";
                       when others =>
                          s_axis_pcie_rc_tuser(15 downto 0) <= x"FFFF";   
                    end case;
                    s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                    s_axis_pcie_rc_tuser(31 downto 16) <= x"FFFF";
                    s_axis_pcie_rc_tuser(32)          <= '0';     
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;    
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax2;
                    s_axis_pcie_rc_tlast <= '1';
                    s_axis_pcie_rc_tvalid <= '1';
                    if ((byte_count+(conv_integer(dw_offset)*4))<=36) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"0000000F";
                           s_axis_pcie_rc_tkeep <= x"0000000F";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=40) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"000000FF";
                           s_axis_pcie_rc_tkeep <= x"000000FF";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=44) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"00000FFF";
                           s_axis_pcie_rc_tkeep <= x"00000FFF";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=48) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"0000FFFF";
                           s_axis_pcie_rc_tkeep <= x"0000FFFF";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=52) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"000FFFFF";
                           s_axis_pcie_rc_tkeep <= x"000FFFFF";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=56) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"00FFFFFF";
                           s_axis_pcie_rc_tkeep <= x"00FFFFFF";
                    elsif ((byte_count+(conv_integer(dw_offset)*4))<=60) then
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"0FFFFFFF";
                           s_axis_pcie_rc_tkeep <= x"0FFFFFFF";
                    else
                           s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFFFF"; 
                           s_axis_pcie_rc_tkeep <= x"FFFFFFFF";  
                    end if;
                    s_axis_pcie_rc_tuser(32)          <= '0';    
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;   
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '0';  
                    byte_count := "0000000000000";
               else  -- one output
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;    
                    s_axis_pcie_rc_tdata(255 downto 0) <= datax1;
                    s_axis_pcie_rc_tlast <= '1';
                    s_axis_pcie_rc_tvalid <= '1';
                    case dw_offset is
                       when "00" =>
                          if (byte_count<=4) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"0000000F";
                                 s_axis_pcie_rc_tkeep <= x"0000000F";
                          elsif (byte_count<=8) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"000000FF";
                                 s_axis_pcie_rc_tkeep <= x"000000FF";
                          elsif (byte_count<=12) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"00000FFF";
                                 s_axis_pcie_rc_tkeep <= x"00000FFF";
                          elsif (byte_count<=16) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"0000FFFF";
                                 s_axis_pcie_rc_tkeep <= x"0000FFFF";
                          elsif (byte_count<=20) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"000FFFFF";
                                 s_axis_pcie_rc_tkeep <= x"000FFFFF";
                          elsif (byte_count<=24) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"00FFFFFF";
                                 s_axis_pcie_rc_tkeep <= x"00FFFFFF";
                          elsif (byte_count<=28) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"0FFFFFFF";
                                 s_axis_pcie_rc_tkeep <= x"0FFFFFFF";
                          else
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFFFF"; 
                                 s_axis_pcie_rc_tkeep <= x"FFFFFFFF";  
                          end if;
                       when "01" =>
                          if (byte_count<=4) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"000000F0";
                                 s_axis_pcie_rc_tkeep <= x"000000FF";
                          elsif (byte_count<=8) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"00000FF0";
                                 s_axis_pcie_rc_tkeep <= x"00000FFF";
                          elsif (byte_count<=12) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"0000FFF0";
                                 s_axis_pcie_rc_tkeep <= x"0000FFFF";
                          elsif (byte_count<=16) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"000FFFF0";
                                 s_axis_pcie_rc_tkeep <= x"000FFFFF";
                          elsif (byte_count<=20) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"00FFFFF0";
                                 s_axis_pcie_rc_tkeep <= x"00FFFFFF";
                          elsif (byte_count<=24) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"0FFFFFF0";
                                 s_axis_pcie_rc_tkeep <= x"0FFFFFFF";
                          elsif (byte_count<=28) then
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFFF0";
                                 s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                          else
                                 s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFFF0"; 
                                 s_axis_pcie_rc_tkeep <= x"FFFFFFFF";  
                          end if;
                       when "10" =>
                          if (byte_count<=4) then
                                  s_axis_pcie_rc_tuser(31 downto 0) <= x"00000F00";
                                  s_axis_pcie_rc_tkeep <= x"00000FFF";
                           elsif (byte_count<=8) then
                                  s_axis_pcie_rc_tuser(31 downto 0) <= x"0000FF00";
                                  s_axis_pcie_rc_tkeep <= x"0000FFFF";
                           elsif (byte_count<=12) then
                                  s_axis_pcie_rc_tuser(31 downto 0) <= x"000FFF00";
                                  s_axis_pcie_rc_tkeep <= x"000FFFFF";
                           elsif (byte_count<=16) then
                                  s_axis_pcie_rc_tuser(31 downto 0) <= x"00FFFF00";
                                  s_axis_pcie_rc_tkeep <= x"00FFFFFF";
                           elsif (byte_count<=20) then
                                  s_axis_pcie_rc_tuser(31 downto 0) <= x"0FFFFF00";
                                  s_axis_pcie_rc_tkeep <= x"0FFFFFFF";
                           elsif (byte_count<=24) then
                                  s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFF00";
                                  s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                           elsif (byte_count<=28) then
                                  s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFF00";
                                  s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                           else
                                  s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFFF00"; 
                                  s_axis_pcie_rc_tkeep <= x"FFFFFFFF";  
                           end if;                          
                       when "11" =>
                           if (byte_count<=4) then
                                   s_axis_pcie_rc_tuser(31 downto 0) <= x"0000F000";
                                   s_axis_pcie_rc_tkeep <= x"0000FFFF";
                            elsif (byte_count<=8) then
                                   s_axis_pcie_rc_tuser(31 downto 0) <= x"000FF000";
                                   s_axis_pcie_rc_tkeep <= x"000FFFFF";
                            elsif (byte_count<=12) then
                                   s_axis_pcie_rc_tuser(31 downto 0) <= x"00FFF000";
                                   s_axis_pcie_rc_tkeep <= x"00FFFFFF";
                            elsif (byte_count<=16) then
                                   s_axis_pcie_rc_tuser(31 downto 0) <= x"0FFFF000";
                                   s_axis_pcie_rc_tkeep <= x"0FFFFFFF";
                            elsif (byte_count<=20) then
                                   s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFF000";
                                   s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                            elsif (byte_count<=24) then
                                   s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFF000";
                                   s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                            elsif (byte_count<=28) then
                                   s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFF000";
                                   s_axis_pcie_rc_tkeep <= x"FFFFFFFF";
                            else
                                   s_axis_pcie_rc_tuser(31 downto 0) <= x"FFFFF000"; 
                                   s_axis_pcie_rc_tkeep <= x"FFFFFFFF";  
                            end if;  
                             
                       when others =>
                          s_axis_pcie_rc_tuser(15 downto 0) <= x"FFFF";
                          s_axis_pcie_rc_tkeep <= x"FFFFFFFF";    
                             
                    end case;
                    s_axis_pcie_rc_tuser(32)          <= '0'; 
                    wait until rising_edge(aclk);
                    wait for 0.5 ns;   
                    s_axis_pcie_rc_tlast <= '0';
                    s_axis_pcie_rc_tvalid <= '0';       
                    s_axis_pcie_rc_tuser(32)          <= '0';    
                    byte_count := "0000000000000";         
               end if; 
            end if; 
        end loop;
     end if;
        wait until rising_edge(aclk);
        wait until rising_edge(aclk);
        wait until rising_edge(aclk);
        wait until rising_edge(aclk); 
        wait for 0.5 ns;  
    end loop;
end process;


--------------------------------------------------------------------------------
-- Read the test Parameters from the parameter file
--------------------------------------------------------------------------------
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
         HREAD(l,param_record.PCIE_RQST_SIZE, ok);
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
         HREAD (l, param_record.LINK_START_ADDRESS, ok);
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
         HREAD(l,param_record.PCIE_A_Address, ok);
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
         HREAD(l,param_record.PCIE_A_MetaAddress, ok);
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
         READ(l,param_record.BufferA_ByteSize);
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
         READ(l,param_record.META_LENGTHA);
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
         HREAD(l,param_record.PCIE_B_Address, ok);
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
         HREAD(l,param_record.PCIE_B_MetaAddress, ok);
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
         READ(l,param_record.BufferB_ByteSize);
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
         READ(l,param_record.META_LENGTHB);
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
         READ(l,param_record.A_AUTO);
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
         READ(l,param_record.A_INCR_MODE);
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
         READ(l,param_record.A_USE_META_LEN);
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
         READ(l,param_record.A_LINK_END_INT_EN);
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
         READ(l,param_record.A_CHAIN_END_INT_EN);
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
         READ(l,param_record.A_CHAIN_END);
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
         READ(l,param_record.A_LOOP_LENGTH);
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
         HREAD(l,param_record.A_LOOP_ADDR_INCR, ok);
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
         READ(l,param_record.B_AUTO);
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
         READ(l,param_record.B_INCR_MODE);
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
         READ(l,param_record.B_USE_META_LEN);
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
         READ(l,param_record.B_LINK_END_INT_EN);
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
         READ(l,param_record.B_CHAIN_END_INT_EN);
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
         READ(l,param_record.B_CHAIN_END);
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
         READ(l,param_record.B_LOOP_LENGTH);
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
         HREAD(l,param_record.B_LOOP_ADDR_INCR, ok);
    else
         assert false
         report "Not enough parameters in File. Exiting."
         severity FAILURE;
    end if;               
    assert false
    report "Reading Parameters is complete." 
    severity NOTE;          
    file_close(paramfile);
    wait;
end process;
  

end Behavioral;
