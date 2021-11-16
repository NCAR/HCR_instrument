----------------------------------------------------------------------------------
-- Testbench for ptk_dma_ppkt2pcie_512.vhd
----------------------------------------------------------------------------------
-- tb_ptk_dma_ppkt2pcie_512.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2019
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 
--  
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

entity tb_px_dma_ppkt2pcie_512 is
Generic (
   in_stream_clk_period    : time    := 5 ns; -- input data stream clock period
   pcie_channel            : integer range 0 to 7 := 2; -- 0-7 (must be unique)   
   parameter_file_name     : string := "..\..\..\..\test_parameters.txt"; -- input test parameter file
   out_file_name           : string := "..\..\..\..\test_results.txt"; -- Testbebch Output file
   has_fifo_full_led       : boolean := true
);
end tb_px_dma_ppkt2pcie_512;

architecture Behavioral of tb_px_dma_ppkt2pcie_512 is

-- UUT
component px_dma_ppkt2pcie_512 is
generic(
pcie_channel                : integer range 0 to 7 := 0; -- 0-7 (must be unique)  
has_fifo_full_led           : boolean := true
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
   -- Input Data Stream (AIX-Stream Stream Slave)
   ----------------------------------------------------------------------------
   s_axis_ppkt_aclk      : in  std_logic;
   s_axis_ppkt_aresetn   : in  std_logic; 
   s_axis_ppkt_tvalid    : in  std_logic;
   s_axis_ppkt_tready    : out std_logic;
   -- Earliest byte in lower byte 
   s_axis_ppkt_tdata     : in  std_logic_vector(511 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   s_axis_ppkt_tuser     : in  std_logic_vector(79 downto 0);
   s_axis_ppkt_tkeep     : in  std_logic_vector(31 downto 0); -- One per 16-bit word
   s_axis_ppkt_tlast     : in  std_logic; -- end of packet
   ----------------------------------------------------------------------------
   -- Output PCIe Packet Data Stream (AXI-Stream Stream Master)
   ----------------------------------------------------------------------------  
   m_axis_pcie_rq_tvalid    : out std_logic;
   m_axis_pcie_rq_tready    : in  std_logic;
   m_axis_pcie_rq_tdata     : out std_logic_vector(511 downto 0);
   m_axis_pcie_rq_tkeep     : out std_logic_vector(63 downto 0);    
   m_axis_pcie_rq_tuser     : out std_logic_vector(136 downto 0);
   m_axis_pcie_rq_tlast     : out std_logic; -- end of packet
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
end component;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------


type param_record_type is RECORD
    INDATA_GATE_LENGTH  : integer;                        -- Length in 16 byte samples of active gate time for input stream.
    INDATA_GATE_INACTIVETIME  : integer;                  -- Length in 16 byte samples of inactive gate time between active gates. (must be multiple of  input_data_stream_width)
    INDATA_GATE_REPEAT  : integer;                        -- number of times to repeat the active gate period. 
    PCIE_MAX_PAYLOAD_SIZE : std_logic_vector(2 downto 0);-- Controls maximum PCIe payload size allowed. Comes from PCIe Core.
    LINK_START_ADDRESS  : std_logic_vector(15 downto 0); -- First Linked List Descriptor address (must be on 64 byte boundaries) 
    PCIE_A_Address      : std_logic_vector(63 downto 0); -- PCIe Destination Start Address to program in first descriptor (DWORD address boundary) 
    PCIE_A_MetaAddress  : std_logic_vector(63 downto 0); -- PCIe Meta Data Destination Start Address to program in first descriptor (must be DWORD address boundary)   
    BufferA_ByteSize    : integer range 1 to 16383;       -- Buffer A bytes to transfer. (limited in size for test) to program first descriptor with
    PCIE_B_Address      : std_logic_vector(63 downto 0); -- PCIe Destination Start Address to program in second descriptor (DWORD address boundary)               
    PCIE_B_MetaAddress  : std_logic_vector(63 downto 0); -- PCIe Meta Data Destination Start Address to program in second descriptor (must be DWORD address boundary)   
    BufferB_ByteSize    : integer range 1 to 16383;       -- Buffer B bytes to transfer. (limited in size for test) to program second descriptor with                       
    A_AUTO              : boolean;                        -- First Descriptor Auto Mode (test does not yet support manual setting '0')
    A_WRITE_META        : boolean;                        -- First Descriptor Write Meta Data Enable  
    A_INCR_MODE         : boolean;                        -- First Descriptor Loop Increment Mode
    A_SOP_START         : boolean;                        -- First Descriptor Use Meta Data length for destination address increment in loop mode 
    A_EOP_END           : boolean;                        -- First Descriptor Use Meta Data Length Mode
    A_LINK_END_INT_EN   : boolean;                        -- First Descriptor Enable Link End Interrupt 
    A_CHAIN_END_INT_EN  : boolean;                        -- First Descriptor Enable Chain End Interrupt 
    A_CHAIN_END         : boolean;                        -- First Descriptor Is End of Chain. 
    A_LOOP_LENGTH       : integer range 0 to 16383;      -- First Descriptor number of times to loop in Loop Increment Mode (# loops -1)
    A_LOOP_ADDR_INCR    : std_logic_vector(31 downto 0); -- First Descriptor number of bytes to increment address in loop increment mode.           
    B_AUTO              : boolean;                     -- Second Descriptor Auto Mode (test does not yet support manual setting '0')
    B_WRITE_META        : boolean;                     -- Second Descriptor Fetch Meta Data Enable           
    B_INCR_MODE         : boolean;                     -- Second Descriptor Loop Increment Mode      
    B_SOP_START         : boolean;                     -- Second Descriptor Use Meta Data length for destination address increment in loop mode                                         
    B_EOP_END           : boolean;                     -- Second Descriptor Use Meta Data Length Mode                                                                                        
    B_LINK_END_INT_EN   : boolean;                     -- Second Descriptor Enable Link End Interrupt                                        
    B_CHAIN_END_INT_EN  : boolean;                     -- Second Descriptor Enable Chain End Interrupt                                       
    B_CHAIN_END         : boolean;                     -- Second Descriptor Is End of Chain.                                                                                                     
    B_LOOP_LENGTH       : integer range 0 to 16383;      -- Second Descriptor number of times to loop in Loop Increment Mode (# loops -1)      
    B_LOOP_ADDR_INCR    : std_logic_vector(31 downto 0); -- Second Descriptor number of bytes to increment address in loop increment mode.      "00";
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
----------------------------------------------------------------------------
-- Linked List RAM (AXI-LITE) 
----------------------------------------------------------------------------
-- associated with aclk
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
-- Input Data Stream (AIX-Stream Stream Slave)
----------------------------------------------------------------------------
signal s_axis_ppkt_aclk      : std_logic := '0';
signal s_axis_ppkt_aresetn   : std_logic := '0'; 
signal s_axis_ppkt_tvalid    : std_logic := '0';
signal s_axis_ppkt_tready    : std_logic := '0';
signal s_axis_ppkt_tdata     : std_logic_vector(511 downto 0):= (others => '0');
signal s_axis_ppkt_tuser     : std_logic_vector(79 downto 0):= (others => '0');
signal s_axis_ppkt_tkeep     : std_logic_vector(31 downto 0):= (others => '0'); -- One per 16-bit word
signal s_axis_ppkt_tlast     : std_logic := '0'; -- end of packet
----------------------------------------------------------------------------
-- Output PCIe Packet Data Stream (AXI-Stream Stream Master)
----------------------------------------------------------------------------
-- associated with aclk
signal m_axis_pcie_rq_tvalid : std_logic := '0';
signal m_axis_pcie_rq_tready : std_logic := '0';
signal m_axis_pcie_rq_tdata  : std_logic_vector(511 downto 0) := (others => '0');
signal m_axis_pcie_rq_tkeep  : std_logic_vector(63 downto 0)   := (others => '0');    
signal m_axis_pcie_rq_tuser  : std_logic_vector(136 downto 0)  := (others => '0');
signal m_axis_pcie_rq_tlast  : std_logic := '0'; -- end of packet
----------------------------------------------------------------------------
-- PCI Express Control
----------------------------------------------------------------------------

signal BufferAControlWord    : std_logic_vector(31 downto 0);
signal BufferBControlWord    : std_logic_vector(31 downto 0);
signal reset_done            : std_logic := '0';
signal config_done           : std_logic := '0';

signal s_axis_cntl_tdata     : std_logic_vector(7 downto 0):= x"00";   
signal s_axis_cntl_tvalid    : std_logic:= '1'; 


shared variable param_record : param_record_type;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
-- CSR Register Addresses
constant DMA_RESET_REG: std_logic_vector(5 downto 0)       := "000000";
constant DMA_ADV_REG: std_logic_vector(5 downto 0)         := "000100";
constant DMA_ABORT_REG: std_logic_vector(5 downto 0)       := "001000";
constant DMA_LL_START_REG: std_logic_vector(5 downto 0)    := "001100"; 
constant SYNC_RAM_CLR_REG: std_logic_vector(5 downto 0)    := "010100"; 
constant SYNC_RAM_SET_REG: std_logic_vector(5 downto 0)    := "011000";
constant INTRPT_ENABLE_REG: std_logic_vector(5 downto 0)   := "110100";
constant DMA_STATUS_REG: std_logic_vector(5 downto 0)      := "100000";

constant instrm_half_period: time := (in_stream_clk_period/2);
constant input_data_stream_width : integer := 32;  -- number of 16-bit words that input stream 
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

begin

-- Descriptor Control Word
-- [0:0]   = AUTO
-- [1:1]   = Reserved
-- [2:2]   = SOP START
-- [3:3]   = INCR MODE
-- [4:4]   = Reserved
-- [5:5]   = Reserved
-- [6:6]   = Reserved
-- [7:7]   = EOP END
-- [8:8]   = LINK END INT EN
-- [9:9]   = CHAIN END INT EN
-- [10:10] = CHAIN END
-- [11:11] = Output Meta Data
-- [13:12] = PCIE AT
-- [15:14] = Reserved
-- [31:16] = INCR LOOP COUNT[15:0]
 
BufferAControlWord(0) <= px_boolean_to_std_logic(param_record.A_AUTO);          
BufferAControlWord(1) <= '0';           
BufferAControlWord(2) <= px_boolean_to_std_logic(param_record.A_SOP_START);      
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
BufferAControlWord(31 downto 16) <= conv_std_logic_vector(param_record.A_LOOP_LENGTH-1, 16);       

BufferBControlWord(0) <= px_boolean_to_std_logic(param_record.B_AUTO);          
BufferBControlWord(1) <= '0';           
BufferBControlWord(2) <= px_boolean_to_std_logic(param_record.B_SOP_START);      
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
BufferBControlWord(31 downto 16) <= conv_std_logic_vector(param_record.B_LOOP_LENGTH-1, 16);  


s_axis_cntl_tdata(2 downto 0) <= param_record.PCIE_MAX_PAYLOAD_SIZE;

uut: px_dma_ppkt2pcie_512
generic map(
pcie_channel     => pcie_channel,    -- 0-7 (must be unique)            
has_fifo_full_led   => has_fifo_full_led                        
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
   -- Linked List RAM (AXI-LITE) 
   ----------------------------------------------------------------------------
   -- associated with aclk
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
   -- Input Data Stream (AIX-Stream Stream Slave)
   ----------------------------------------------------------------------------
   s_axis_ppkt_aclk       => s_axis_ppkt_aclk,   
   s_axis_ppkt_aresetn    => s_axis_ppkt_aresetn,
   s_axis_ppkt_tvalid     => s_axis_ppkt_tvalid, 
   s_axis_ppkt_tready     => s_axis_ppkt_tready, 
   -- Earliest byte in lower byte 
   s_axis_ppkt_tdata      => s_axis_ppkt_tdata,

   s_axis_ppkt_tuser      => s_axis_ppkt_tuser,
   s_axis_ppkt_tkeep      => s_axis_ppkt_tkeep,
   s_axis_ppkt_tlast      => s_axis_ppkt_tlast,
   ----------------------------------------------------------------------------
   -- Output PCIe Packet Data Stream (AXI-Stream Stream Master)
   ----------------------------------------------------------------------------
-- associated with aclk  
                            
   m_axis_pcie_rq_tvalid    => m_axis_pcie_rq_tvalid,
   m_axis_pcie_rq_tready    => m_axis_pcie_rq_tready,  
   m_axis_pcie_rq_tdata     => m_axis_pcie_rq_tdata, 
   m_axis_pcie_rq_tkeep     => m_axis_pcie_rq_tkeep,   
   m_axis_pcie_rq_tuser     => m_axis_pcie_rq_tuser, 
   m_axis_pcie_rq_tlast     => m_axis_pcie_rq_tlast, 

   ------------------------- ---------------------------------------------------
   -- PCI Express Control    
   ------------------------- ---------------------------------------------------
   s_axis_cntl_tdata        => s_axis_cntl_tdata,
   s_axis_cntl_tvalid       => '1'
   ); 
    -- '1' = 256 byte is max PCIe packet size, '0' = 128 byte is max size   
--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------

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

-- Input Stream Clock
process
begin
    loop
        s_axis_ppkt_aclk <= not s_axis_ppkt_aclk;
        wait for instrm_half_period;
    end loop;
end process;


process
begin
wait for 400 ns;
aresetn <= '1';
s_axi_csr_aresetn <= '1';
s_axis_ppkt_aresetn <= '1';
wait for 40 ns;
reset_done <= '1';
wait;
end process;

--------------------------------------------------------------------------------
-- Set Up Linked List RAM and DMA registers
--------------------------------------------------------------------------------
-- DWORD 0 -- Link Base + 0x0000	Control Word
-- DWORD 1 -- Link Base + 0x0004	Bytes to Transfer[31:0]
-- DWORD 2 -- Link Base + 0x0008	Destination Address[31:0] 
-- DWORD 3 -- Link Base + 0x000C	Destination Address[63:32]
-- DWORD 4 -- Link Base + 0x0010	Destination Meta Data Address[31:0] 
-- DWORD 5 -- Link Base + 0x0014	Destination Meta Data Address[63:32] 
-- DWORD 6 -- Link Base + 0x0018	Loop Address Increment Value[31:0]              
-- DWORD 7 -- Link Base + 0x001C	Next Link Address[15:0] 

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
    px_axi_lite_writer( x"0000", BufferAControlWord, aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Bytes to Transfer
    px_axi_lite_writer( x"0004", (conv_std_logic_vector(param_record.BufferA_ByteSize, 32)), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Destination Address [31:0] 
    px_axi_lite_writer( x"0008", param_record.PCIE_A_Address(31 downto 0), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Destination Address [63:32] 
    px_axi_lite_writer( x"000C", param_record.PCIE_A_Address(63 downto 32), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Destination Meta Address [31:0] 
    px_axi_lite_writer( x"0010", param_record.PCIE_A_MetaAddress(31 downto 0) , aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Destination Meta Address [63:32] 
    px_axi_lite_writer( x"0014", param_record.PCIE_A_MetaAddress(63 downto 32), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Descriptor Loop Address Increment
    px_axi_lite_writer( x"0018", param_record.A_LOOP_ADDR_INCR, aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferA Next Link Address
    px_axi_lite_writer( x"001C", x"00000020" , aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);

    -- Write BufferB Descriptor Control Word   
    px_axi_lite_writer( x"0020", BufferBControlWord, aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Bytes to Transfer
    px_axi_lite_writer( x"0024", (conv_std_logic_vector(param_record.BufferB_ByteSize, 32)), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Destination Address [31:0] 
    px_axi_lite_writer( x"0028", param_record.PCIE_B_Address(31 downto 0), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Destination Address [63:32] 
    px_axi_lite_writer( x"002C", param_record.PCIE_B_Address(63 downto 32), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Destination Meta Address [31:0] 
    px_axi_lite_writer( x"0030", param_record.PCIE_B_MetaAddress(31 downto 0) , aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Destination Meta Address [63:32] 
    px_axi_lite_writer( x"0034", param_record.PCIE_B_MetaAddress(63 downto 32), aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Descriptor Loop Address Increment
    px_axi_lite_writer( x"0038", param_record.B_LOOP_ADDR_INCR, aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);
    -- Write BufferB Next Link Address
    px_axi_lite_writer( x"003C", x"00000000" , aclk, s_axi_descr_awaddr, s_axi_descr_awprot, s_axi_descr_awvalid, s_axi_descr_awready, s_axi_descr_wdata, s_axi_descr_wstrb, s_axi_descr_wvalid, s_axi_descr_wready, s_axi_descr_bresp, s_axi_descr_bvalid, s_axi_descr_bready);

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
    px_axi_lite_reader( x"0000", BufferAControlWord, '1', '1', aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Bytes to Transfer
    px_axi_lite_reader( x"0004", (conv_std_logic_vector(param_record.BufferA_ByteSize, 32)), '1', '1', aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Address [31:0] 
    px_axi_lite_reader( x"0008", param_record.PCIE_A_Address(31 downto 0), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Address [63:32] 
    px_axi_lite_reader( x"000C", param_record.PCIE_A_Address(63 downto 32), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Meta Address [31:0] 
    px_axi_lite_reader( x"0010", param_record.PCIE_A_MetaAddress(31 downto 0), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Meta Address [63:32] 
    px_axi_lite_reader( x"0014", param_record.PCIE_A_MetaAddress(63 downto 32), '1', '1', aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Loop Address Increment
    px_axi_lite_reader( x"0018", param_record.A_LOOP_ADDR_INCR, '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
   -- Read BufferA Next Link Address
    px_axi_lite_reader( x"001C", x"00000020" , '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);

    -- Read BufferA Descriptor Control Word   
    px_axi_lite_reader( x"0020", BufferBControlWord, '1', '1', aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Bytes to Transfer
    px_axi_lite_reader( x"0024", (conv_std_logic_vector(param_record.BufferB_ByteSize, 32)), '1', '1', aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Address [31:0] 
    px_axi_lite_reader( x"0028", param_record.PCIE_B_Address(31 downto 0), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Address [63:32] 
    px_axi_lite_reader( x"002C", param_record.PCIE_B_Address(63 downto 32), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Meta Address [31:0] 
    px_axi_lite_reader( x"0030", param_record.PCIE_B_MetaAddress(31 downto 0), '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Source Meta Address [63:32] 
    px_axi_lite_reader( x"0034", param_record.PCIE_B_MetaAddress(63 downto 32), '1', '1', aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
    -- Read BufferA Descriptor Loop Address Increment
    px_axi_lite_reader( x"0038", param_record.B_LOOP_ADDR_INCR, '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);
   -- Read BufferA Next Link Address
    px_axi_lite_reader( x"003C", x"00000000" , '1', '1',  aclk, s_axi_descr_araddr, s_axi_descr_arprot, s_axi_descr_arvalid, s_axi_descr_arready, s_axi_descr_rdata, s_axi_descr_rresp, s_axi_descr_rvalid, s_axi_descr_rready);

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
    px_axi_lite_writer( DMA_LL_START_REG, (x"0000" & param_record.LINK_START_ADDRESS), aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    assert false
    report "Verifing the Linked List Start Address." 
    severity NOTE;     
    px_axi_lite_reader(DMA_LL_START_REG, (x"0000" & param_record.LINK_START_ADDRESS) , '1', '1',  aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
  
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
        
    wait for 200 ns;
    
--    -- ABORT the DMA
--    assert false
--    report "Aborting the DMA." 
--    severity NOTE;    
--    px_axi_lite_writer( DMA_ABORT_REG, x"00000001" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
--    wait for 600 ns;
--    px_axi_lite_writer( DMA_ABORT_REG, x"00000000" , aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);

    wait for 600 ns;

----    -- ABORT the DMA
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
-- PCIe Requester Request Interface
--------------------------------------------------------------------------------

pcie_rqst_process: process

file MyFile: text;	
VARIABLE l : LINE; -- declare a line variable
variable header : std_logic_vector(127 downto 0) :=(others => '0');
variable addr: std_logic_vector(63 downto 0) :=(others => '0');
variable offset : std_logic_vector(2 downto 0) :=(others => '0');
variable first_be : std_logic_vector(3 downto 0) :=(others => '0');
variable last_be : std_logic_vector(3 downto 0) :=(others => '0');
variable first_data: std_logic_vector(383 downto 0) :=(others => '0');
variable first_loop : std_logic:= '1';
begin
file_open(MyFile, out_file_name, WRITE_MODE);
								
wait until reset_done = '1';
wait for 100 ns;
wait until rising_edge(aclk);
wait for 0.5 ns; 
m_axis_pcie_rq_tready    <= '1';
wait until rising_edge(aclk);
loop
    if (m_axis_pcie_rq_tvalid = '0') then
        wait until (m_axis_pcie_rq_tvalid = '1');
        wait until rising_edge(aclk);  
    end if;
    -- Get PCIe Header
    header := m_axis_pcie_rq_tdata(127 downto 0);
    WRITE(l,STRING'("Request Header : "));
    WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata(127 downto 0)) );
    WRITELINE(MyFile,l);
    WRITE(l,STRING'("AT : "));
    WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata(1 downto 0)) );
    WRITELINE(MyFile,l);
    WRITE(l,STRING'("Dest. Address : "));
    WRITE(l,px_std_logic_vector_to_hstring((m_axis_pcie_rq_tdata(63 downto 2) & "00")) );
    WRITELINE(MyFile,l);
    addr := m_axis_pcie_rq_tdata(63 downto 2) & "00";
    offset := m_axis_pcie_rq_tuser(18 downto 16); -- first DW offset
    first_be := m_axis_pcie_rq_tuser(3 downto 0);
    last_be := m_axis_pcie_rq_tuser(11 downto 8);
    first_data := m_axis_pcie_rq_tdata(511 downto 128);
    WRITE(l,STRING'("DWORD Count : "));
    WRITE(l,integer'image(conv_integer(('0' & m_axis_pcie_rq_tdata(74 downto 64)))) );
    WRITELINE(MyFile,l);
    WRITE(l,STRING'("DWORD Offset : "));
    WRITE(l,integer'image(conv_integer('0' & offset)) );
    WRITELINE(MyFile,l);
    WRITE(l,STRING'("First BE : "));
    WRITE(l,px_std_logic_vector_to_hstring(first_be) );
    WRITELINE(MyFile,l);
    WRITE(l,STRING'("Last BE : "));
    WRITE(l,px_std_logic_vector_to_hstring(last_be) );
    WRITELINE(MyFile,l);
    WRITE(l,STRING'("Request Type : "));
    if (m_axis_pcie_rq_tdata(78 downto 75)= "001") then
        WRITE(l,STRING'("WRITE REQUEST"));
    else
        WRITE(l,STRING'("WRONG TYPE"));
    end if;   
    WRITELINE(MyFile,l);
    WRITE(l,STRING'("Tag : "));
    WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata(103 downto 96)) );
    WRITELINE(MyFile,l);
    if m_axis_pcie_rq_tuser(36) = '1' then
        WRITE(l,STRING'("Packet Discontinued! (aborted)"));
        WRITELINE(MyFile,l);
    end if;      
    if (addr(31 downto 10) = param_record.PCIE_A_MetaAddress(31 downto 10)) or (addr(31 downto 10) = param_record.PCIE_B_MetaAddress(31 downto 10)) then
        WRITE(l,STRING'("Meta Data"));
    end if;
    WRITELINE(MyFile,l);
    WRITE(l,STRING'(" Addr : "));
    WRITE(l,px_std_logic_vector_to_hstring(addr) );
        for i in 4 to 15 loop -- DW loop
           if m_axis_pcie_rq_tkeep(i*4) = '1' then
             WRITE(l,' ');
             WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(0*8)+7 downto (i*4*8)+(0*8)) ) );
             WRITE(l,' ');
             WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(1*8)+7 downto (i*4*8)+(1*8)) ) );
             WRITE(l,' ');
             WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(2*8)+7 downto (i*4*8)+(2*8)) ) );
             WRITE(l,' ');
             WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(3*8)+7 downto (i*4*8)+(3*8)) ) );
             addr := addr + 4;
          end if; 
        end loop;
    WRITELINE(MyFile,l);
    if (m_axis_pcie_rq_tlast = '0') then
        wait until rising_edge(aclk); -- next word
        --wait for 1 ns;
        first_loop := '1';
        while (m_axis_pcie_rq_tlast = '0') loop
            WRITE(l,STRING'(" Addr : "));
            WRITE(l,px_std_logic_vector_to_hstring(addr) );
            for i in 0 to 15 loop -- DW loop
                if (i >= (conv_integer('0' & offset))) or (first_loop = '0') then
                    if m_axis_pcie_rq_tkeep(i*4) = '1' then
                        WRITE(l,' ');
                        WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(0*8)+7 downto (i*4*8)+(0*8)) ) );
                        WRITE(l,' ');
                        WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(1*8)+7 downto (i*4*8)+(1*8)) ) );
                        WRITE(l,' ');
                        WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(2*8)+7 downto (i*4*8)+(2*8)) ) );
                        WRITE(l,' ');
                        WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(3*8)+7 downto (i*4*8)+(3*8)) ) );
                        addr := addr + 4;
                    end if; 
                else
                    WRITE(l,STRING'("            "));  
                end if;
            
            end loop;
            first_loop := '0';
            WRITELINE(MyFile,l);
        
            wait until rising_edge(aclk);
        end loop;
    
        WRITE(l,STRING'(" Addr : "));
        WRITE(l,px_std_logic_vector_to_hstring(addr) );
        for i in 0 to 15 loop -- DW loop
            if (i >= (conv_integer('0' & offset))) or (first_loop = '0')  then
                if m_axis_pcie_rq_tkeep(i*4) = '1' then
                    WRITE(l,' ');
                    WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(0*8)+7 downto (i*4*8)+(0*8)) ) );
                    WRITE(l,' ');
                    WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(1*8)+7 downto (i*4*8)+(1*8)) ) );
                    WRITE(l,' ');
                    WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(2*8)+7 downto (i*4*8)+(2*8)) ) );
                    WRITE(l,' ');
                    WRITE(l,px_std_logic_vector_to_hstring(m_axis_pcie_rq_tdata((i*4*8)+(3*8)+7 downto (i*4*8)+(3*8)) ) );
                    addr := addr + 4;
                end if; 
            else
                WRITE(l,STRING'("            "));  
            end if;
        end loop;
        WRITELINE(MyFile,l);
        wait until rising_edge(aclk);
       
        WRITE(l,' ');
        WRITE(l,' ');
        WRITELINE(MyFile,l);
     else
        WRITE(l,' ');
        WRITE(l,' ');
        WRITELINE(MyFile,l);
        wait until rising_edge(aclk); -- next word
     end if;
end loop;    

end process;

--------------------------------------------------------------------------------
-- Input Data Stream
--------------------------------------------------------------------------------
process
variable  data_value : integer := 0;
variable i: integer := 0;
variable timestamp : std_logic_vector(63 downto 0) := (others => '0');

begin
    wait until config_done = '1'; -- We are all set up so, let us stream in some data
    wait until rising_edge(s_axis_ppkt_aclk);
    for n in 0 to (param_record.INDATA_GATE_REPEAT - 1) loop
        data_value := 0;
        i := param_record.INDATA_GATE_LENGTH;
        while (i /= 0) loop
           s_axis_ppkt_tvalid <= '1';
           for h in 0 to 31 loop
             s_axis_ppkt_tdata(((h*16)+15) downto h*16) <= conv_std_logic_vector(data_value, 16);
             data_value := data_value + 1;
           end loop;
           --s_axis_data_in_tuser [0]      = start of packet 
           --s_axis_data_in_tuser [2:1]    = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
           --s_axis_data_in_tuser [3]      = Data Type 0 = Real 1 = I/Q
           --s_axis_data_in_tuser [4]      = Type of first sample 0 = I 1 = Q
           --s_axis_data_in_tuser [7:5]    = Reserved  
           --s_axis_data_in_tuser [15:8]   = channel[7:0]   
           --s_axis_data_in_tuser [31:16]  = I/Q Markers  
           --s_axis_data_in_tuser [47:32]  = Sync Position  
           --s_axis_data_in_tuser [63:48]  = 
           --s_axis_data_in_tuser [127:64] = Timestamp of first sample in data_in_tdata   
           -- tuser[63:0]    = timestamp[63:0]  
           -- tuser[64]      = SOP   
           -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
           -- tuser[67]      = Data Type 0 = Real 1 = I/Q
           -- tuser[75:68]   = channel[7:0] 
         if i = param_record.INDATA_GATE_LENGTH then
            s_axis_ppkt_tuser(64)  <= '1';
         else
            s_axis_ppkt_tuser(64)  <= '0';
         end if;   
         s_axis_ppkt_tuser(67 downto 65)  <= "001"; 
         s_axis_ppkt_tuser(75 downto 68)  <= "000" & conv_std_logic_vector(0,5);   
         s_axis_ppkt_tuser(63 downto 0)   <= timestamp;     
         if (i < input_data_stream_width) then   
           for j in 0 to (i-1) loop
                s_axis_ppkt_tkeep(j) <= '1';
           end loop; 
           for k in i to (input_data_stream_width-1) loop
                s_axis_ppkt_tkeep(k) <= '0';
           end loop; 
         else
            s_axis_ppkt_tkeep <= (others => '1');
         end if;
         if (i <= input_data_stream_width) then   
           s_axis_ppkt_tlast <= '1';
           i := 0;
         else
           s_axis_ppkt_tlast <= '0';
           i := i - input_data_stream_width;
         end if;    
         timestamp := timestamp +  input_data_stream_width;
         wait until rising_edge(s_axis_ppkt_aclk);
         wait for 0.5 ns; 
      end loop;
      -- wait for desired time befor asserting the gate again
      for m in 0 to ((param_record.INDATA_GATE_INACTIVETIME/input_data_stream_width) - 1) loop
         timestamp := timestamp +  input_data_stream_width;
         s_axis_ppkt_tkeep <= (others => '0');
         s_axis_ppkt_tlast  <= '0';
         s_axis_ppkt_tvalid <= '0';
         wait until rising_edge(s_axis_ppkt_aclk);
         wait for 0.5 ns; 
      end loop;
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
         px_hread(l,param_record.PCIE_MAX_PAYLOAD_SIZE, ok);
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
         px_hread(l,param_record.PCIE_A_Address, ok);
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
         px_hread(l,param_record.PCIE_A_MetaAddress, ok);
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
         px_hread(l,param_record.PCIE_B_Address, ok);
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
         px_hread(l,param_record.PCIE_B_MetaAddress, ok);
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
         READ(l,param_record.A_SOP_START);
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
         px_hread(l,param_record.A_LOOP_ADDR_INCR, ok);
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
         READ(l,param_record.B_SOP_START);
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
         px_hread(l,param_record.B_LOOP_ADDR_INCR, ok);
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
