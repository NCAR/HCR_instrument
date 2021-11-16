----------------------------------------------------------------------------------
-- Testbench for ptk_dma_ppld2axi.vhd
----------------------------------------------------------------------------------
-- tb_px_dma_ppld2axi.vhd
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
-- For this version DMA, the input is afixed 512-bit input width and data
-- must be presented synchronous with the PCIe clock. If your data stream
-- is in another clock domain, use an axis clock converter.

--  This test bench uses a fixed 256 byte max payload size.
----------------------------------------------------------------------------------
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
use work.px_utility_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_dma_ppld2axi is
Generic (
   channel_id              : integer range 0 to 31 := 2; -- 0-31    
   parameter_file_name     : string := "..\..\..\..\test_parameters.txt"; -- input test parameter file
   out_file_name           : string := "..\..\..\..\test_results.txt" -- Testbebch Output file
);
end tb_px_dma_ppld2axi;

architecture Behavioral of tb_px_dma_ppld2axi is

-- UUT
component px_dma_ppld2axi
generic(
channel_id                  : integer range 0 to 7 := 0; -- 0-7 (must be unique)
channel_id_width            : integer range 1 to 16 := 5; -- 0-6 (must be unique)
desc_axi_addr_width         : integer range 7 to 64 := 64;
data_axi_addr_width         : integer range 7 to 64 := 64
);
port (
   aclk                     : in  std_logic; 
   -- associated with aclk
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
   -- Linked List Descriptor RAM (AXI-4) 
   ----------------------------------------------------------------------------
   -- Associated with aclk
   m_axi_descr_arid         : out std_logic_vector(channel_id_width-1 downto 0);
   m_axi_descr_araddr       : out std_logic_vector(desc_axi_addr_width-1 downto 0);
   m_axi_descr_arprot       : out std_logic_vector(2 downto 0);
   m_axi_descr_arsize       : out std_logic_vector(2 downto 0);
   m_axi_descr_arburst      : out std_logic_vector(1 downto 0);
   m_axi_descr_arlen        : out std_logic_vector(7 downto 0);
   m_axi_descr_arvalid      : out std_logic;
   m_axi_descr_arready      : in  std_logic;
   m_axi_descr_rdata        : in  std_logic_vector(255 downto 0);
   m_axi_descr_rresp        : in  std_logic_vector(1 downto 0);
   m_axi_descr_rvalid       : in  std_logic;
   m_axi_descr_rlast        : in  std_logic;
   m_axi_descr_rready       : out std_logic;    
   m_axi_descr_rid          : in  std_logic_vector(channel_id_width-1 downto 0);
   -----------------------------------------------------------------------------
   -- Input AXI-S PPLD Stream (Pre-Packaged Payloads Packets)
   -----------------------------------------------------------------------------
   s_axis_ppld_tvalid       : in  std_logic;
   s_axis_ppld_tready       : out std_logic;
   s_axis_ppld_tdata        : in  std_logic_vector(511 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = Start of Payload Packet   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[77:76]   = Reserved
   -- tuser[78]      = Acq. Start
   -- tuser[79]      = Acq. End (Input PPKT had tlast)
   -- tuser[96:80]   = Payload Size (bytes)
   -- tuser[103:97]  = Number Valid Bytes in cycle
   s_axis_ppld_tuser        : in  std_logic_vector(103 downto 0);
   s_axis_ppld_tkeep        : in  std_logic_vector(63 downto 0); -- One per byte
   s_axis_ppld_tlast        : in  std_logic; -- End of Payload Packet    
   ----------------------------------------------------------------------------
   -- Output Data Bus (AXI-4 Master)
   ----------------------------------------------------------------------------  
   m_axi_s2mm_awid          : out std_logic_vector(channel_id_width-1 downto 0);       
   m_axi_s2mm_awaddr        : out std_logic_vector(data_axi_addr_width-1 downto 0);       
   m_axi_s2mm_awlen         : out std_logic_vector(7 downto 0);        
   m_axi_s2mm_awsize        : out std_logic_vector(2 downto 0);        
   m_axi_s2mm_awburst       : out std_logic_vector(1 downto 0);        
   m_axi_s2mm_awprot        : out std_logic_vector(2 downto 0);        
   m_axi_s2mm_awcache       : out std_logic_vector(3 downto 0);        
   m_axi_s2mm_awuser        : out std_logic_vector(3 downto 0);        
   m_axi_s2mm_awvalid       : out std_logic;                           
   m_axi_s2mm_awready       : in std_logic;                            
   m_axi_s2mm_wdata         : out std_logic_vector(511 downto 0);      
   m_axi_s2mm_wstrb         : out std_logic_vector(63 downto 0);       
   m_axi_s2mm_wlast         : out std_logic;                           
   m_axi_s2mm_wvalid        : out std_logic;                           
   m_axi_s2mm_wready        : in std_logic;                            
   m_axi_s2mm_bresp         : in std_logic_vector(1 downto 0);         
   m_axi_s2mm_bvalid        : in std_logic;                            
   m_axi_s2mm_bready        : out std_logic;           
   m_axi_s2mm_bid           : in  std_logic_vector(channel_id_width-1 downto 0);          
   ----------------------------------------------------------------------------
   -- Misc. Control
   ------------------------------------------------------------------------------ 
   -- 64,128,256,512,1024,2048,4096,8192 bytes
   payload_size_ctl         : out std_logic_vector(13 downto 0);
   payload_size_ctl_en      : out std_logic;
   external_fifo_rstn       : out std_logic
);
end component;

COMPONENT tb_px_axis_ppkt2ppld
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
  override_pkt_size_en : IN STD_LOGIC;
  override_pkt_size : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
  axis_aclk : IN STD_LOGIC;
  axis_aresetn : IN STD_LOGIC;
  fifo_rst_in_n : IN STD_LOGIC;
  s_axis_ppkt_tvalid : IN STD_LOGIC;
  s_axis_ppkt_tready : OUT STD_LOGIC;
  s_axis_ppkt_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
  s_axis_ppkt_tuser : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
  s_axis_ppkt_tkeep : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  s_axis_ppkt_tlast : IN STD_LOGIC;
  m_axis_pktfifo_aresetn : OUT STD_LOGIC;
  m_axis_pktfifo_tvalid : OUT STD_LOGIC;
  m_axis_pktfifo_tready : IN STD_LOGIC;
  m_axis_pktfifo_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
  m_axis_pktfifo_tuser : OUT STD_LOGIC_VECTOR(103 DOWNTO 0);
  m_axis_pktfifo_tkeep : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
  m_axis_pktfifo_tlast : OUT STD_LOGIC;
  s_axis_pktfifo_tvalid : IN STD_LOGIC;
  s_axis_pktfifo_tready : OUT STD_LOGIC;
  s_axis_pktfifo_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
  s_axis_pktfifo_tuser : IN STD_LOGIC_VECTOR(103 DOWNTO 0);
  s_axis_pktfifo_tkeep : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
  s_axis_pktfifo_tlast : IN STD_LOGIC;
  m_axis_ppld_tvalid : OUT STD_LOGIC;
  m_axis_ppld_tready : IN STD_LOGIC;
  m_axis_ppld_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
  m_axis_ppld_tuser : OUT STD_LOGIC_VECTOR(103 DOWNTO 0);
  m_axis_ppld_tkeep : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
  m_axis_ppld_tlast : OUT STD_LOGIC;
  m_axis_ppld_tdest : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END COMPONENT;

COMPONENT tb_pktfifo
  PORT (
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tkeep : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    s_axis_tuser : IN STD_LOGIC_VECTOR(103 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tkeep : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC;
    m_axis_tuser : OUT STD_LOGIC_VECTOR(103 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------


type param_record_type is RECORD
    INDATA_GATE_LENGTH  : integer;                        -- Length in 16 byte samples of active gate time for input stream.
    INDATA_GATE_INACTIVETIME  : integer;                  -- Length in 16 byte samples of inactive gate time between active gates. (must be multiple of  input_data_stream_width)
    INDATA_GATE_REPEAT  : integer;                        -- number of times to repeat the active gate period. 
    MAX_PAYLOAD_SIZE    : integer;                        -- Controls maximum payload size allowed. 1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192
    LINK_START_ADDRESS  : std_logic_vector(63 downto 0); -- First Linked List Descriptor address (must be on 64 byte boundaries) 
    dest_A_Address      : std_logic_vector(63 downto 0); -- Destination Start Address to program in first descriptor (DWORD address boundary) 
    dest_A_MetaAddress  : std_logic_vector(63 downto 0); -- Meta Data Destination Start Address to program in first descriptor (must be DWORD address boundary)   
    BufferA_ByteSize    : integer range 1 to 16383;       -- Buffer A bytes to transfer. (limited in size for test) to program first descriptor with
    dest_B_Address      : std_logic_vector(63 downto 0); -- Destination Start Address to program in second descriptor (DWORD address boundary)               
    dest_B_MetaAddress  : std_logic_vector(63 downto 0); -- Meta Data Destination Start Address to program in second descriptor (must be DWORD address boundary)   
    BufferB_ByteSize    : integer range 1 to 16383;       -- Buffer B bytes to transfer. (limited in size for test) to program second descriptor with                       
    A_AUTO              : boolean;                        -- First Descriptor Auto Mode (test does not yet support manual setting '0')
    A_WRITE_META        : boolean;                        -- First Descriptor Write Meta Data Enable  
    A_INCR_MODE         : boolean;                        -- First Descriptor Loop Increment Mode
    A_EOP_END           : boolean;                        -- First Descriptor Use Meta Data Length Mode
    A_LINK_END_INT_EN   : boolean;                        -- First Descriptor Enable Link End Interrupt 
    A_CHAIN_END_INT_EN  : boolean;                        -- First Descriptor Enable Chain End Interrupt 
    A_CHAIN_END         : boolean;                        -- First Descriptor Is End of Chain.          
    B_AUTO              : boolean;                     -- Second Descriptor Auto Mode (test does not yet support manual setting '0')
    B_WRITE_META        : boolean;                     -- Second Descriptor Fetch Meta Data Enable           
    B_INCR_MODE         : boolean;                     -- Second Descriptor Loop Increment Mode                                           
    B_EOP_END           : boolean;                     -- Second Descriptor Use Meta Data Length Mode                                                                                        
    B_LINK_END_INT_EN   : boolean;                     -- Second Descriptor Enable Link End Interrupt                                        
    B_CHAIN_END_INT_EN  : boolean;                     -- Second Descriptor Enable Chain End Interrupt                                       
    B_CHAIN_END         : boolean;                     -- Second Descriptor Is End of Chain.                                                                                                     
end record param_record_type;


constant input_data_stream_width : integer := 32;  

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
signal s_axi_csr_awaddr         : std_logic_vector(5 downto 0) := (others => '0');
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
signal s_axi_csr_araddr         : std_logic_vector(5 downto 0) := (others => '0');
signal s_axi_csr_arprot         : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_arvalid        : std_logic := '0';
signal s_axi_csr_arready        : std_logic := '0';
signal s_axi_csr_rdata          : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp          : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid         : std_logic := '0';
signal s_axi_csr_rready         : std_logic := '1';

signal irq                      : std_logic := '0'; -- Interrupt out

signal s_axi_ppld_csr_awaddr         : std_logic_vector(6 downto 0) := (others => '0');
signal s_axi_ppld_csr_awprot         : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_ppld_csr_awvalid        : std_logic := '0';
signal s_axi_ppld_csr_awready        : std_logic := '0';
signal s_axi_ppld_csr_wdata          : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_ppld_csr_wstrb          : std_logic_vector(3 downto 0) := (others => '0');
signal s_axi_ppld_csr_wvalid         : std_logic := '0';
signal s_axi_ppld_csr_wready         : std_logic := '0';
signal s_axi_ppld_csr_bresp          : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_ppld_csr_bvalid         : std_logic := '0';
signal s_axi_ppld_csr_bready         : std_logic := '0';
signal s_axi_ppld_csr_araddr         : std_logic_vector(6 downto 0) := (others => '0');
signal s_axi_ppld_csr_arprot         : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_ppld_csr_arvalid        : std_logic := '0';
signal s_axi_ppld_csr_arready        : std_logic := '0';
signal s_axi_ppld_csr_rdata          : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_ppld_csr_rresp          : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_ppld_csr_rvalid         : std_logic := '0';
signal s_axi_ppld_csr_rready         : std_logic := '1';
----------------------------------------------------------------------------
-- Linked List RAM (AXI-LITE) 
----------------------------------------------------------------------------
-- associated with aclk
signal m_axi_descr_araddr          : std_logic_vector(63 downto 0):= (others => '0');
signal m_axi_descr_arprot          : std_logic_vector(2 downto 0):= (others => '0');
signal m_axi_descr_arsize          : std_logic_vector(2 downto 0):= (others => '0');
signal m_axi_descr_arburst         : std_logic_vector(1 downto 0):= (others => '0');
signal m_axi_descr_arlen           : std_logic_vector(7 downto 0):= (others => '0');
signal m_axi_descr_arvalid         : std_logic := '0';
signal m_axi_descr_arready         : std_logic := '0';
signal m_axi_descr_rdata           : std_logic_vector(255 downto 0):= (others => '0');
signal m_axi_descr_rresp           : std_logic_vector(1 downto 0):= (others => '0');
signal m_axi_descr_rvalid          : std_logic := '0';
signal m_axi_descr_rlast           : std_logic := '0';
signal m_axi_descr_rready          : std_logic := '0';   

-----------------------------------------------------------------------------
-- Input AXI-S PPLD Stream (Pre-Packaged Payloads Packets)
-----------------------------------------------------------------------------
signal s_axis_ppld_tvalid       : std_logic := '0';
signal s_axis_ppld_tready       : std_logic := '0';
signal s_axis_ppld_tdata        : std_logic_vector(511 downto 0) := (others => '0');
signal s_axis_ppld_tuser        : std_logic_vector(103 downto 0) := (others => '0');
signal s_axis_ppld_tkeep        : std_logic_vector(63 downto 0) := (others => '0'); -- One per byte
signal s_axis_ppld_tlast        : std_logic := '0'; -- End of Payload Packet    

signal s_axis_ppkt_tvalid       : std_logic := '0';
signal s_axis_ppkt_tready       : std_logic := '0';
signal s_axis_ppkt_tdata        : std_logic_vector(511 downto 0) := (others => '0');
signal s_axis_ppkt_tuser        : std_logic_vector(79 downto 0) := (others => '0');
signal s_axis_ppkt_tkeep        : std_logic_vector(31 downto 0) := (others => '0'); -- One per byte
signal s_axis_ppkt_tlast        : std_logic := '0'; -- End of Payload Packet

signal m_axis_pktfifo_aresetn : STD_LOGIC := '0';
signal m_axis_pktfifo_tvalid : STD_LOGIC := '0';
signal m_axis_pktfifo_tready :STD_LOGIC := '0';
signal m_axis_pktfifo_tdata : STD_LOGIC_VECTOR(511 DOWNTO 0) := (others => '0');
signal m_axis_pktfifo_tuser : STD_LOGIC_VECTOR(103 DOWNTO 0) := (others => '0');
signal m_axis_pktfifo_tkeep : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal m_axis_pktfifo_tlast : STD_LOGIC := '0';
signal s_axis_pktfifo_tvalid :STD_LOGIC := '0';
signal s_axis_pktfifo_tready : STD_LOGIC := '0';
signal s_axis_pktfifo_tdata : STD_LOGIC_VECTOR(511 DOWNTO 0) := (others => '0');
signal s_axis_pktfifo_tuser : STD_LOGIC_VECTOR(103 DOWNTO 0) := (others => '0');
signal s_axis_pktfifo_tkeep : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal s_axis_pktfifo_tlast : STD_LOGIC;    
-------------------------------------------------------------------------------------
-- AXI-4 Write Bus
-------------------------------------------------------------------------------------
signal m_axi_s2mm_awid          :  std_logic_vector(4 downto 0):= (others => '0');        
signal m_axi_s2mm_awaddr        :  std_logic_vector(63 downto 0):= (others => '0');       
signal m_axi_s2mm_awlen         :  std_logic_vector(7 downto 0):= (others => '0');        
signal m_axi_s2mm_awsize        :  std_logic_vector(2 downto 0):= (others => '0');        
signal m_axi_s2mm_awburst       :  std_logic_vector(1 downto 0):= (others => '0');        
signal m_axi_s2mm_awprot        :  std_logic_vector(2 downto 0):= (others => '0');        
signal m_axi_s2mm_awcache       :  std_logic_vector(3 downto 0):= (others => '0');        
signal m_axi_s2mm_awuser        :  std_logic_vector(3 downto 0):= (others => '0');        
signal m_axi_s2mm_awvalid       :  std_logic := '0';                           
signal m_axi_s2mm_awready       : std_logic := '0';                            
signal m_axi_s2mm_wdata         :  std_logic_vector(511 downto 0):= (others => '0');      
signal m_axi_s2mm_wstrb         :  std_logic_vector(63 downto 0):= (others => '0');       
signal m_axi_s2mm_wlast         :  std_logic := '0';                           
signal m_axi_s2mm_wvalid        :  std_logic := '0';                           
signal m_axi_s2mm_wready        : std_logic := '0';                            
signal m_axi_s2mm_bresp         : std_logic_vector(1 downto 0):= (others => '0');         
signal m_axi_s2mm_bvalid        : std_logic := '0';                            
signal m_axi_s2mm_bready        :  std_logic := '0';   

signal BufferAControlWord    : std_logic_vector(31 downto 0);
signal BufferBControlWord    : std_logic_vector(31 downto 0);
signal reset_done            : std_logic := '0';
signal config_done           : std_logic := '0';

signal   payload_size_ctl        :  std_logic_vector(16 downto 0):= (others => '0');
signal   payload_size_ctl_en     :  std_logic := '0';
signal   fifo_rst_in_n           :  std_logic := '0';

shared variable param_record : param_record_type;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
-- Register Map
-- 0x00 DMA RESTART		           R/W
-- 0x04 DMA ADVANCE 	              R/W
-- 0x08 DMA ABORT                  R/W
-- 0x0C DMA START LINK ADDRESS LS  R/W
-- 0x10 DMA START LINK ADDRESS MS  R/W
-- 0x14 FIFO FLUSH                 R/W
-- 0x18 OUT SIZE CTL               R/W
-- 0x1C DMA STATUS                 RO	
-- 0x20 CURRENT LINK ADDRESS LS    RO
-- 0x24 CURRENT LINK ADDRESS MS    RO
-- 0x28 LAST LINK ADDRESS    LS    RO
-- 0x2C LAST LINK ADDRESS    MS    RO
-- 0x30 BYTES LAST TRANSFERRED     RO
-- 0x34 INTERRUPT ENABLE           R/W	
-- 0x38 INTERRUPT STATUS           RO
-- 0x3C INTERRUPT FLAG	           R/Clr
-- CSR Register Addresses
constant DMA_RESET_REG: std_logic_vector(5 downto 0)       := "000000";
constant DMA_ADV_REG: std_logic_vector(5 downto 0)         := "000100";
constant DMA_ABORT_REG: std_logic_vector(5 downto 0)       := "001000";
constant DMA_LL_START_REG_L: std_logic_vector(5 downto 0)  := "001100"; 
constant DMA_LL_START_REG_M: std_logic_vector(5 downto 0)  := "010000";
constant FIFO_FLUSH_REG: std_logic_vector(5 downto 0)      := "010100"; 
constant OUT_SIZE_CTL_REG: std_logic_vector(5 downto 0)    := "011000";
constant DMA_STATUS_REG:std_logic_vector(5 downto 0)       := "011100";
constant CURRENT_LINK_ADDRESS_REG_L:std_logic_vector(5 downto 0) := "100000";
constant CURRENT_LINK_ADDRESS_REG_M:std_logic_vector(5 downto 0) := "100100";
constant LAST_LINK_ADDRESS_REG_L:std_logic_vector(5 downto 0) := "101000";
constant LAST_LINK_ADDRESS_REG_M:std_logic_vector(5 downto 0) := "101100";
constant BYTES_LAST_TRANSFERRED_REG:std_logic_vector(5 downto 0) := "110000";
constant INTRPT_ENABLE_REG: std_logic_vector(5 downto 0)   := "110100";
constant INTRPT_STATUS_REG: std_logic_vector(5 downto 0)   := "111000";
constant INTRPT_FLAG_REG: std_logic_vector(5 downto 0)   := "111100";

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

begin

-- Descriptor Control Word
-- [0:0]   = AUTO
-- [1:1]   = Reserved
-- [2:2]   = Reserved
-- [3:3]   = INCR AXI MODE
-- [4:4]   = Reserved
-- [5:5]   = Reserved
-- [6:6]   = Reserved
-- [7:7]   = EOP END
-- [8:8]   = LINK END INT EN
-- [9:9]   = CHAIN END INT EN
-- [10:10] = CHAIN END
-- [11:11] = Output Meta Data
-- [13:12] = Reserved
-- [15:14] = Reserved
 
BufferAControlWord(0) <= px_boolean_to_std_logic(param_record.A_AUTO);          
BufferAControlWord(1) <= '0';           
BufferAControlWord(2) <= '0';      
BufferAControlWord(3) <= px_boolean_to_std_logic(param_record.A_INCR_MODE);         
BufferAControlWord(4) <= '0';     
BufferAControlWord(5) <= '0'; 
BufferAControlWord(6) <= '0';
BufferAControlWord(7) <= px_boolean_to_std_logic(param_record.A_EOP_END);         
BufferAControlWord(8) <= px_boolean_to_std_logic(param_record.A_LINK_END_INT_EN);   
BufferAControlWord(9) <= px_boolean_to_std_logic(param_record.A_CHAIN_END_INT_EN);  
BufferAControlWord(10)<= px_boolean_to_std_logic(param_record.A_CHAIN_END);         
BufferAControlWord(11)<= px_boolean_to_std_logic(param_record.A_WRITE_META);          
BufferAControlWord(13 downto 12) <= "00";
BufferAControlWord(15 downto 14) <= "00";      
BufferAControlWord(31 downto 16) <= x"0000";       

BufferBControlWord(0) <= px_boolean_to_std_logic(param_record.B_AUTO);          
BufferBControlWord(1) <= '0';           
BufferBControlWord(2) <= '0';      
BufferBControlWord(3) <= px_boolean_to_std_logic(param_record.B_INCR_MODE);         
BufferBControlWord(4) <= '0';     
BufferBControlWord(5) <= '0'; 
BufferBControlWord(6) <= '0';
BufferBControlWord(7) <= px_boolean_to_std_logic(param_record.B_EOP_END);         
BufferBControlWord(8) <= px_boolean_to_std_logic(param_record.B_LINK_END_INT_EN);   
BufferBControlWord(9) <= px_boolean_to_std_logic(param_record.B_CHAIN_END_INT_EN);  
BufferBControlWord(10)<= px_boolean_to_std_logic(param_record.B_CHAIN_END);         
BufferBControlWord(11)<= px_boolean_to_std_logic(param_record.B_WRITE_META);          
BufferBControlWord(13 downto 12) <= "00";
BufferBControlWord(15 downto 14) <= "00";      
BufferBControlWord(31 downto 16) <= x"0000";  

uut: px_dma_ppld2axi
generic map(
channel_id                  => channel_id,
desc_axi_addr_width         => 64,
data_axi_addr_width         => 64        
)
port map(
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI-LITE)
   ----------------------------------------------------------------------------
   -- associated with aclk
   aclk                     => aclk,  
   aresetn                  => aresetn, 
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
   
   irq                      => irq,  -- Interrupt out
  ----------------------------------------------------------------------------
    -- Descriptor RAM interface
    ----------------------------------------------------------------------------
    -- associated with clk
    m_axi_descr_arid              => open,
    m_axi_descr_araddr            => m_axi_descr_araddr  ,  
    m_axi_descr_arprot            => m_axi_descr_arprot  ,
    m_axi_descr_arsize            => m_axi_descr_arsize  ,
    m_axi_descr_arburst           => m_axi_descr_arburst ,
    m_axi_descr_arlen             => m_axi_descr_arlen   ,
    m_axi_descr_arvalid           => m_axi_descr_arvalid ,
    m_axi_descr_arready           => m_axi_descr_arready ,
    m_axi_descr_rdata             => m_axi_descr_rdata   ,
    m_axi_descr_rresp             => m_axi_descr_rresp   ,
    m_axi_descr_rvalid            => m_axi_descr_rvalid  ,
    m_axi_descr_rlast             => m_axi_descr_rlast   ,
    m_axi_descr_rready            => m_axi_descr_rready  ,
    m_axi_descr_rid               => "00000",
   ----------------------------------------------------------------------------
   -- Input Data Stream (AIX-Stream Stream Slave)
   ----------------------------------------------------------------------------
   s_axis_ppld_tvalid     => s_axis_ppld_tvalid, 
   s_axis_ppld_tready     => s_axis_ppld_tready, 
   -- Earliest byte in lower byte 
   s_axis_ppld_tdata      => s_axis_ppld_tdata,

   s_axis_ppld_tuser      => s_axis_ppld_tuser,
   s_axis_ppld_tkeep      => s_axis_ppld_tkeep,
   s_axis_ppld_tlast      => s_axis_ppld_tlast,
   ----------------------------------------------------------------------------
   -- Output Data Bus (AXI-4 Master)
   ----------------------------------------------------------------------------  
   m_axi_s2mm_awid          => open,
   m_axi_s2mm_awid          => m_axi_s2mm_awid,   
   m_axi_s2mm_awaddr        => m_axi_s2mm_awaddr, 
   m_axi_s2mm_awlen         => m_axi_s2mm_awlen,  
   m_axi_s2mm_awsize        => m_axi_s2mm_awsize, 
   m_axi_s2mm_awburst       => m_axi_s2mm_awburst,
   m_axi_s2mm_awprot        => m_axi_s2mm_awprot, 
   m_axi_s2mm_awcache       => m_axi_s2mm_awcache,
   m_axi_s2mm_awuser        => m_axi_s2mm_awuser, 
   m_axi_s2mm_awvalid       => m_axi_s2mm_awvalid,
   m_axi_s2mm_awready       => m_axi_s2mm_awready,
   m_axi_s2mm_wdata         => m_axi_s2mm_wdata,  
   m_axi_s2mm_wstrb         => m_axi_s2mm_wstrb,  
   m_axi_s2mm_wlast         => m_axi_s2mm_wlast,  
   m_axi_s2mm_wvalid        => m_axi_s2mm_wvalid, 
   m_axi_s2mm_wready        => m_axi_s2mm_wready, 
   m_axi_s2mm_bresp         => m_axi_s2mm_bresp,  
   m_axi_s2mm_bvalid        => m_axi_s2mm_bvalid, 
   m_axi_s2mm_bready        => m_axi_s2mm_bready, 
   m_axi_s2mm_bid           => "00000",
   ----------------------------------------------------------------------------
   -- Misc. Control
   ------------------------------------------------------------------------------ 
   -- 64,128,256,512,1024,2048,4096,8192 bytes
   payload_size_ctl         => payload_size_ctl(13 downto 0),   
   payload_size_ctl_en      => payload_size_ctl_en,
   external_fifo_rstn       => fifo_rst_in_n
   );
    
payload_size_ctl(16 downto 14) <= "000";

--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------

-- CSR Clock = 250MHz
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
-- DWORD 0 -- descriptor_ram_readdata[31:0]	   Control Word
-- DWORD 1 -- descriptor_ram_readdata[63:32]    Bytes to Transfer[31:0]
-- DWORD 2 -- descriptor_ram_readdata[95:64]    Destination Address[31:0] 
-- DWORD 3 -- descriptor_ram_readdata[127:96]   Destination Address[63:32] 
-- DWORD 4 -- descriptor_ram_readdata[159:128]  Destination  Meta Data Address[31:0] 
-- DWORD 5 -- descriptor_ram_readdata[191:160]  Destination  Meta Data Address[63:32] 
-- DWORD 6 -- descriptor_ram_readdata[223:192]  Next Link Address[31:0]
-- DWORD 7 -- descriptor_ram_readdata[255:224]  Next Link Address[63:32]

setup_process: process
variable c_time : time := 0 ns;
variable d_time : time := 0 ns;

begin
    wait until reset_done = '1';

    -- Write Linked List Start Address 
    assert false
    report "Writing the Linked List Start Address." 
    severity NOTE;  
    px_axi_lite_writer( DMA_LL_START_REG_L, (param_record.LINK_START_ADDRESS(31 downto 0)), aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    px_axi_lite_writer( DMA_LL_START_REG_M, (param_record.LINK_START_ADDRESS(63 downto 32)), aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    assert false
    report "Verifing the Linked List Start Address." 
    severity NOTE;     
    px_axi_lite_reader(DMA_LL_START_REG_L, (param_record.LINK_START_ADDRESS(31 downto 0)) , '1', '1',  aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
    px_axi_lite_reader(DMA_LL_START_REG_M, (param_record.LINK_START_ADDRESS(63 downto 32)) , '1', '1',  aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
    assert false
    report "Setting Maximum Payload Size." 
    severity NOTE;     
    px_axi_lite_writer( OUT_SIZE_CTL_REG, (x"0000" & '1' & '0' & conv_std_logic_vector(param_record.MAX_PAYLOAD_SIZE,14)) , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   
    -- Enable DMA Interrupts
    assert false
    report "Enabling DMA Link End and Chain End Interrupts." 
    severity NOTE;    
    px_axi_lite_writer( INTRPT_ENABLE_REG, x"00000003", aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);

    -- Reset the DMA
    assert false
    report "Resetting the DMA." 
    severity NOTE;    
    px_axi_lite_writer( DMA_RESET_REG, x"00000001" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    px_axi_lite_writer( DMA_RESET_REG, x"00000000" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);

    -- Start the DMA
    assert false
    report "Starting the DMA" 
    severity NOTE;    
    px_axi_lite_writer( DMA_ADV_REG, x"00000001" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    px_axi_lite_writer( DMA_ADV_REG, x"00000000" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    
    config_done <= '1';
        
    wait for 500 ns;
    
    -- ABORT the DMA
--    assert false
--    report "Aborting the DMA." 
--    severity NOTE;    
--    px_axi_lite_writer( DMA_ABORT_REG, x"00000001" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
--    wait for 600 ns;
--    px_axi_lite_writer( DMA_ABORT_REG, x"00000000" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);

    wait for 600 ns;

--    -- ABORT the DMA
--    assert false
--    report "Aborting the DMA." 
--    severity NOTE;    
--    px_axi_lite_writer( DMA_ABORT_REG, x"00000001" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
--    wait for 100 ns;
--    px_axi_lite_writer( DMA_ABORT_REG, x"00000000" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);

--    wait for 200 ns;
    
--    -- Start the DMA
--    assert false
--    report "Starting the DMA" 
--    severity NOTE;    
--    px_axi_lite_writer( DMA_ADV_REG, x"00000001" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
--    px_axi_lite_writer( DMA_ADV_REG, x"00000000" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    
    
    wait for 100 ns;
    

    
    wait; 
end process;

--------------------------------------------------------------------------------
-- AXI-4 Write Interface
--------------------------------------------------------------------------------

axi_write_process: process

file MyFile: text;	
VARIABLE l : LINE; -- declare a line variable
variable header : std_logic_vector(127 downto 0) :=(others => '0');
variable addr: std_logic_vector(63 downto 0) :=(others => '0');
variable offset : std_logic_vector(2 downto 0) :=(others => '0');
variable first_loop : std_logic:= '1';
variable first_d: integer := 1;
begin
file_open(MyFile, out_file_name, WRITE_MODE);
								
wait until reset_done = '1';
wait for 100 ns;
wait until rising_edge(aclk);
wait for 0.5 ns; 

m_axi_s2mm_wready    <= '1';
m_axi_s2mm_bvalid    <= '1';
m_axi_s2mm_bresp     <= "00";
wait until rising_edge(aclk);
loop
    m_axi_s2mm_awready   <= '1';
    if (m_axi_s2mm_awvalid = '0') then
        wait until (m_axi_s2mm_awvalid = '1');
    end if;    
        wait until rising_edge(aclk);
        m_axi_s2mm_awready   <= '0';
        WRITE(l,STRING'("Address : "));
        WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_awaddr(63 downto 0)) );
        WRITELINE(MyFile,l);
        WRITE(l,STRING'("Burst Length in Bytes : "));
        WRITE(l,integer'image((conv_integer('0' & m_axi_s2mm_awlen) + 1) * 64) );
        WRITELINE(MyFile,l);
        if m_axi_s2mm_awburst = "00" then
         WRITE(l,STRING'("Burst Type : Fixed Address"));
        else
         WRITE(l,STRING'("Burst Type : Incrementing Address"));
        end if; 
        WRITELINE(MyFile,l);
        WRITE(l,STRING'("-----------------------------------"));
        WRITELINE(MyFile,l);
        if (m_axi_s2mm_wvalid = '1') then
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(31 downto 0)) );
            WRITE(l,STRING'("  "));
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(63 downto 32)) );
            WRITE(l,STRING'("  "));
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(95 downto 64)) );
            WRITE(l,STRING'("  "));            
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(127 downto 96)) );
            WRITE(l,STRING'("  "));            
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(159 downto 128)) );
            WRITE(l,STRING'("  "));            
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(191 downto 160)) );
            WRITE(l,STRING'("  "));            
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(223 downto 192)) );
            WRITE(l,STRING'("  "));            
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(255 downto 224)) );
            WRITELINE(MyFile,l);
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(287 downto 256)) );
            WRITE(l,STRING'("  "));
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(319 downto 288)) );
            WRITE(l,STRING'("  "));
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(351 downto 320)) );
            WRITE(l,STRING'("  "));            
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(383 downto 352)) );
            WRITE(l,STRING'("  "));            
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(415 downto 384)) );
            WRITE(l,STRING'("  "));            
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(447 downto 416)) );
            WRITE(l,STRING'("  "));            
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(479 downto 448)) );
            WRITE(l,STRING'("  "));            
            WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(511 downto 480)) );
            WRITELINE(MyFile,l);
            if (m_axi_s2mm_wlast = '1') then
               first_d := 0;
            end if;
        else
         wait until (m_axi_s2mm_wvalid = '1');
         first_d := 1;
        end if;
    while(m_axi_s2mm_wlast = '0') or (first_d = 1)  loop  
      first_d := 0;
      wait until rising_edge(aclk); -- next word
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(31 downto 0)) );
      WRITE(l,STRING'("  "));
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(63 downto 32)) );
      WRITE(l,STRING'("  "));
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(95 downto 64)) );
      WRITE(l,STRING'("  "));            
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(127 downto 96)) );
      WRITE(l,STRING'("  "));            
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(159 downto 128)) );
      WRITE(l,STRING'("  "));            
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(191 downto 160)) );
      WRITE(l,STRING'("  "));            
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(223 downto 192)) );
      WRITE(l,STRING'("  "));            
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(255 downto 224)) );
      WRITELINE(MyFile,l);
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(287 downto 256)) );
      WRITE(l,STRING'("  "));
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(319 downto 288)) );
      WRITE(l,STRING'("  "));
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(351 downto 320)) );
      WRITE(l,STRING'("  "));            
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(383 downto 352)) );
      WRITE(l,STRING'("  "));            
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(415 downto 384)) );
      WRITE(l,STRING'("  "));            
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(447 downto 416)) );
      WRITE(l,STRING'("  "));            
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(479 downto 448)) );
      WRITE(l,STRING'("  "));            
      WRITE(l,px_std_logic_vector_to_hstring(m_axi_s2mm_wdata(511 downto 480)) );
      WRITELINE(MyFile,l);
    end loop;
    wait until rising_edge(aclk);
end loop;    

end process;

--------------------------------------------------------------------------------
-- Input Data stream
--------------------------------------------------------------------------------
process
variable  data_value : integer := 0;
variable i: integer := 0;
variable timestamp : std_logic_vector(63 downto 0) := (others => '0');

begin
    wait until config_done = '1'; -- We are all set up so, let us stream in some data
    wait until rising_edge(aclk);
    for n in 0 to (param_record.INDATA_GATE_REPEAT - 1) loop
        data_value := 0;
        i := param_record.INDATA_GATE_LENGTH;
        while (i /= 0) loop
           s_axis_ppkt_tvalid <= '1';
           for h in 0 to input_data_stream_width-1 loop
             s_axis_ppkt_tdata(((h*16)+15) downto h*16) <= conv_std_logic_vector(data_value, 16);
             data_value := data_value + 1;
           end loop;
           -- tuser[63:0]    = timestamp[63:0]  
           -- tuser[64]      = Start of Payload Packet   
           -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
           -- tuser[67]      = Data Type 0 = Real 1 = I/Q
           -- tuser[75:68]   = channel[7:0]
           -- tuser[77:76]   = Reserved
           -- tuser[78]      = Acq. Start 
           -- tuser[79]      = Acq. End (Input PPKT had tlast)
           -- tuser[96:80]   = Payload Size (bytes)
           -- tuser[103:97]  = Number Valid Bytes in cycle
         if i = param_record.INDATA_GATE_LENGTH then
            s_axis_ppkt_tuser(64)  <= '1'; -- Start of Acq.
         else
            s_axis_ppkt_tuser(64)  <= '0';
         end if;   
         s_axis_ppkt_tuser(67 downto 65)  <= "001"; 
         s_axis_ppkt_tuser(75 downto 68)  <= "000" & conv_std_logic_vector(channel_id,5);   
         s_axis_ppkt_tuser(63 downto 0)   <= timestamp; 
         s_axis_ppkt_tuser(77 downto 76)  <= "00"; 
         if (i < input_data_stream_width) then   
           for j in 0 to (i-1) loop
                s_axis_ppkt_tkeep(j)     <= '1';
           end loop; 
           for k in i to (input_data_stream_width-1) loop
                s_axis_ppkt_tkeep(k) <= '0';
           end loop; 
         else
            s_axis_ppkt_tkeep <= (others => '1');
         end if;
         if (i <= input_data_stream_width) then   
            s_axis_ppkt_tlast  <= '1'; -- EOP
           i := 0;
         else
            s_axis_ppkt_tlast  <= '0'; -- EOP
           i := i - input_data_stream_width;
         end if;    
         timestamp := timestamp +  input_data_stream_width;
         if s_axis_ppkt_tready = '0' then
            while(s_axis_ppkt_tready = '0') loop
                wait until rising_edge(aclk);
            end loop;
         else
            wait until rising_edge(aclk);
         end if;   
         wait until rising_edge(aclk); --////
         s_axis_ppkt_tvalid <= '0';--////
         wait until rising_edge(aclk); --////
         wait until rising_edge(aclk); --////
         wait until rising_edge(aclk); --////
         wait until rising_edge(aclk); --////
         s_axis_ppkt_tvalid <= '1';--////
         wait for 0.5 ns; 
      end loop;
      -- wait for desired time befor asserting the gate again
      for m in 0 to ((param_record.INDATA_GATE_INACTIVETIME/input_data_stream_width) - 1) loop
         timestamp := timestamp +  input_data_stream_width;
         s_axis_ppkt_tkeep <= (others => '0');
         s_axis_ppkt_tlast  <= '0';
         s_axis_ppkt_tvalid <= '0';
         wait until rising_edge(aclk);
         wait for 0.5 ns; 
      end loop;
  end loop;
end process;

tb_ppld_inst : tb_px_axis_ppkt2ppld
  PORT MAP (
    s_axi_csr_aclk => aclk,
    s_axi_csr_aresetn => s_axi_csr_aresetn,
    s_axi_csr_awaddr => s_axi_ppld_csr_awaddr,
    s_axi_csr_awprot => s_axi_ppld_csr_awprot,
    s_axi_csr_awvalid => s_axi_ppld_csr_awvalid,
    s_axi_csr_awready => s_axi_ppld_csr_awready,
    s_axi_csr_wdata => s_axi_ppld_csr_wdata,
    s_axi_csr_wstrb => s_axi_ppld_csr_wstrb,
    s_axi_csr_wvalid => s_axi_ppld_csr_wvalid,
    s_axi_csr_wready => s_axi_ppld_csr_wready,
    s_axi_csr_bresp => s_axi_ppld_csr_bresp,
    s_axi_csr_bvalid => s_axi_ppld_csr_bvalid,
    s_axi_csr_bready => s_axi_ppld_csr_bready,
    s_axi_csr_araddr => s_axi_ppld_csr_araddr,
    s_axi_csr_arprot => s_axi_ppld_csr_arprot,
    s_axi_csr_arvalid => s_axi_ppld_csr_arvalid,
    s_axi_csr_arready => s_axi_ppld_csr_arready,
    s_axi_csr_rdata => s_axi_ppld_csr_rdata,
    s_axi_csr_rresp => s_axi_ppld_csr_rresp,
    s_axi_csr_rvalid => s_axi_ppld_csr_rvalid,
    s_axi_csr_rready => s_axi_ppld_csr_rready,
    axis_aclk => aclk,
    axis_aresetn => aresetn,
    fifo_rst_in_n => fifo_rst_in_n,
    override_pkt_size_en => payload_size_ctl_en,     
    override_pkt_size    => payload_size_ctl,   
    s_axis_ppkt_tvalid => s_axis_ppkt_tvalid,
    s_axis_ppkt_tready => s_axis_ppkt_tready,
    s_axis_ppkt_tdata => s_axis_ppkt_tdata,
    s_axis_ppkt_tuser => s_axis_ppkt_tuser,
    s_axis_ppkt_tkeep => s_axis_ppkt_tkeep,
    s_axis_ppkt_tlast => s_axis_ppkt_tlast,
    m_axis_pktfifo_aresetn => m_axis_pktfifo_aresetn,
    m_axis_pktfifo_tvalid => m_axis_pktfifo_tvalid,
    m_axis_pktfifo_tready => m_axis_pktfifo_tready,
    m_axis_pktfifo_tdata => m_axis_pktfifo_tdata,
    m_axis_pktfifo_tuser => m_axis_pktfifo_tuser,
    m_axis_pktfifo_tkeep => m_axis_pktfifo_tkeep,
    m_axis_pktfifo_tlast => m_axis_pktfifo_tlast,
    s_axis_pktfifo_tvalid => s_axis_pktfifo_tvalid,
    s_axis_pktfifo_tready => s_axis_pktfifo_tready,
    s_axis_pktfifo_tdata => s_axis_pktfifo_tdata,
    s_axis_pktfifo_tuser => s_axis_pktfifo_tuser,
    s_axis_pktfifo_tkeep => s_axis_pktfifo_tkeep,
    s_axis_pktfifo_tlast => s_axis_pktfifo_tlast,
    m_axis_ppld_tvalid => s_axis_ppld_tvalid,
    m_axis_ppld_tready => s_axis_ppld_tready,
    m_axis_ppld_tdata => s_axis_ppld_tdata,
    m_axis_ppld_tuser => s_axis_ppld_tuser,
    m_axis_ppld_tkeep => s_axis_ppld_tkeep,
    m_axis_ppld_tlast => s_axis_ppld_tlast,
    m_axis_ppld_tdest => open
  );
  
pktfifo_inst : tb_pktfifo
    PORT MAP (
      s_aclk => aclk,
      s_aresetn => m_axis_pktfifo_aresetn,
      s_axis_tvalid => m_axis_pktfifo_tvalid,
      s_axis_tready => m_axis_pktfifo_tready,
      s_axis_tdata => m_axis_pktfifo_tdata,
      s_axis_tkeep => m_axis_pktfifo_tkeep,
      s_axis_tlast => m_axis_pktfifo_tlast,
      s_axis_tuser => m_axis_pktfifo_tuser,
      m_axis_tvalid => s_axis_pktfifo_tvalid,
      m_axis_tready => s_axis_pktfifo_tready,
      m_axis_tdata => s_axis_pktfifo_tdata,
      m_axis_tkeep => s_axis_pktfifo_tkeep,
      m_axis_tlast => s_axis_pktfifo_tlast,
      m_axis_tuser => s_axis_pktfifo_tuser
    );


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
         READ(l,param_record.INDATA_GATE_LENGTH);
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
         READ(l,param_record.INDATA_GATE_INACTIVETIME);
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
         READ(l,param_record.INDATA_GATE_REPEAT);
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
         READ(l,param_record.MAX_PAYLOAD_SIZE, ok);
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
         px_hread(l, param_record.LINK_START_ADDRESS, ok);
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
         px_hread(l,param_record.dest_A_Address, ok);
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
         px_hread(l,param_record.dest_A_MetaAddress, ok);
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
         READ(l,param_record.BufferA_ByteSize, ok);
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
         px_hread(l,param_record.dest_B_Address, ok);
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
         px_hread(l,param_record.dest_B_MetaAddress, ok);
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
         READ(l,param_record.BufferB_ByteSize, ok);
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
         READ(l,param_record.A_WRITE_META);
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
         READ(l,param_record.A_EOP_END);
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
         READ(l,param_record.B_WRITE_META);
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
         READ(l,param_record.B_EOP_END);
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
    assert false
    report "Reading Parameters is complete." 
    severity NOTE;          
    file_close(paramfile);
    wait;
end process;

-------------------------------------------------------------------------------
-- Simulate AXI4 transaction with an external descriptor RAM
-------------------------------------------------------------------------------
m_axi_descr_arready <= m_axi_descr_arvalid;

process
variable addr : std_logic_vector(63 downto 0) := x"0000000000000000";
begin
    loop
        while (m_axi_descr_arvalid = '0') or (m_axi_descr_arvalid = 'X') or (m_axi_descr_arvalid = 'U') loop
            wait until rising_edge(aclk);
        end loop;
        addr := m_axi_descr_araddr; 
        wait until rising_edge(aclk);
        m_axi_descr_rvalid <= '1';
        if addr = x"0000000000000000" then
            m_axi_descr_rdata <= x"0000000000000020" & param_record.dest_A_MetaAddress(63 downto 32) & param_record.dest_A_MetaAddress(31 downto 0) & param_record.dest_A_Address(63 downto 32) & param_record.dest_A_Address(31 downto 0) & (conv_std_logic_vector(param_record.BufferA_ByteSize, 32)) & BufferAControlWord;
        else
            m_axi_descr_rdata <=  x"0000000000000000" & param_record.dest_B_MetaAddress(63 downto 32) & param_record.dest_B_MetaAddress(31 downto 0) & param_record.dest_B_Address(63 downto 32) & param_record.dest_B_Address(31 downto 0) & (conv_std_logic_vector(param_record.BufferB_ByteSize, 32)) & BufferBControlWord;
        end if; 
        m_axi_descr_rlast  <= '1'; 
        m_axi_descr_rresp  <= "00";   
        wait until rising_edge(aclk);  
        m_axi_descr_rvalid <= '0';
        wait until rising_edge(aclk);
        m_axi_descr_rlast  <= '0'; 
    end loop;    
end process;
  

end Behavioral;
