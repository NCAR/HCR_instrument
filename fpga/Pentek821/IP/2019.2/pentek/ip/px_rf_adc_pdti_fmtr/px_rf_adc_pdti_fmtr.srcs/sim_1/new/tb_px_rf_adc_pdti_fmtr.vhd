----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/20/2018 12:00:24 PM
-- Design Name: 
-- Module Name: tb_px_rf_adc_pdti_fmtr - Behavioral
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
use ieee.numeric_std.ALL;
use work.px_utility_pkg.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_rf_adc_pdti_fmtr is
end tb_px_rf_adc_pdti_fmtr;

architecture Behavioral of tb_px_rf_adc_pdti_fmtr is

component px_rf_adc_pdti_fmtr
generic (
   channel: integer := 0; -- 0 to 255
   has_in_tready : boolean := true
);
port (
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI4-LITE)
   ----------------------------------------------------------------------------
   -- associated with s_axi_csr_aclk
   s_axi_csr_aclk           : in  std_logic;
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
--------------------------------------------------------------------------------
-- Input AXI-Stream   (s_axis_aclk)
--------------------------------------------------------------------------------
   s_axis_aclk              : in  std_logic;
   s_axis_aresetn           : in std_logic; -- reset   
   --I or Real
   s_axis_i_tdata           : in  std_logic_vector(127 downto 0);
   s_axis_i_tvalid          : in  std_logic;
   s_axis_i_tready          : out std_logic; -- always high
   --Q 
   s_axis_q_tdata           : in  std_logic_vector(127 downto 0);
   s_axis_q_tvalid          : in  std_logic;
   s_axis_q_tready          : out std_logic; -- always high
   
   -----------------------------------------------------------------------------
   -- Time Stamp Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   -- tuser[7:0]       = Gate Positions  
   -- tuser[15:8]      = Sync Positions      
   -- tuser[23:16]     = PPS Positions
   -- pts_tdata[63:0]  = timestamp[63:0] 
   -- (s_axis_aclk)
   s_axis_pts_tdata         : in std_logic_vector(63 downto 0);
   s_axis_pts_tuser         : in std_logic_vector(23 downto 0);
   s_axis_pts_tvalid        : in std_logic;
--------------------------------------------------------------------------------
-- Output AXI-Stream (Pentek PDTI Format)   (m_axis_aclk)
--------------------------------------------------------------------------------
   -- tuser[63:0]    = timestamp[63:0]
   -- tuser[71:64]   = Gate Positions  
   -- tuser[79:72]   = Sync Positions      
   -- tuser[87:80]   = PPS  Positions  
   -- tuser[91:88]   = Samples/Cycle
   -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   -- tuser[127:104] = Reserved 
   m_axis_pdti_aclk         : in  std_logic;
   m_axis_aresetn           : in std_logic; -- reset  
   m_axis_pdti_tdata        : out std_logic_vector(255 downto 0);
   m_axis_pdti_tuser        : out std_logic_vector(127 downto 0);
   m_axis_pdti_tvalid       : out std_logic;
   
   sync_rst                 : in std_logic -- synchronous to s_axis_aclk
);
end component;

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal s_axi_csr_aclk           :  std_logic := '0';
signal s_axi_csr_aresetn        :  std_logic := '0';
signal s_axi_csr_awaddr         :  std_logic_vector(11 downto 0) := (others => '0');
signal s_axi_csr_awprot         :  std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_awvalid        :  std_logic := '0';
signal s_axi_csr_awready        :  std_logic := '0';
signal s_axi_csr_wdata          :  std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_wstrb          :  std_logic_vector(3 downto 0) := (others => '0');
signal s_axi_csr_wvalid         :  std_logic := '0';
signal s_axi_csr_wready         :  std_logic := '0';
signal s_axi_csr_bresp          :  std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_bvalid         :  std_logic := '0';
signal s_axi_csr_bready         :  std_logic := '0';
signal s_axi_csr_araddr         :  std_logic_vector(11 downto 0) := (others => '0');
signal s_axi_csr_arprot         :  std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_arvalid        :  std_logic := '0';
signal s_axi_csr_arready        :  std_logic := '0';
signal s_axi_csr_rdata          :  std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp          :  std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid         :  std_logic := '0';
signal s_axi_csr_rready         :  std_logic := '0';
signal s_axis_aclk              :  std_logic := '0';
signal s_axis_aresetn           : std_logic := '0'; -- reset   
signal s_axis_i_tdata           :  std_logic_vector(127 downto 0) := x"00070006000500040003000200010000";
signal s_axis_i_tvalid          :  std_logic := '1';
signal s_axis_i_tready          :  std_logic := '0'; -- always high
signal s_axis_q_tdata           :  std_logic_vector(127 downto 0) := (others => '0');
signal s_axis_q_tvalid          :  std_logic := '1';
signal s_axis_q_tready          :  std_logic := '0'; -- always high
signal s_axis_pts_tdata         : std_logic_vector(63 downto 0) := (others => '0');
signal s_axis_pts_tuser         : std_logic_vector(23 downto 0) := (others => '0');
signal s_axis_pts_tvalid        : std_logic := '1';
signal m_axis_pdti_aclk         :  std_logic := '0';
signal m_axis_aresetn           : std_logic := '0'; -- reset  
signal m_axis_pdti_tdata        :  std_logic_vector(255 downto 0) := (others => '0');
signal m_axis_pdti_tuser        :  std_logic_vector(127 downto 0) := (others => '0');
signal m_axis_pdti_tvalid       :  std_logic := '0';
signal sync_rst                 : std_logic := '0'; -- synchronous to s_axis_aclk

begin

process
begin
   loop
      wait for 2 ns;
      s_axis_aclk <= not s_axis_aclk;
   end loop;
end process;  

process
begin
   loop
      wait for 4 ns;
      m_axis_pdti_aclk <= not m_axis_pdti_aclk;
   end loop;
end process;   

process
begin
   loop
      wait for 5 ns;
      s_axi_csr_aclk <= not s_axi_csr_aclk;
   end loop;
end process;  

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      s_axis_i_tdata(15 downto 0)    <= s_axis_i_tdata(15 downto 0)    + 8;
      s_axis_i_tdata(31 downto 16)   <= s_axis_i_tdata(31 downto 16)   + 8;
      s_axis_i_tdata(47 downto 32)   <= s_axis_i_tdata(47 downto 32)   + 8;
      s_axis_i_tdata(63 downto 48)   <= s_axis_i_tdata(63 downto 48)   + 8;
      s_axis_i_tdata(79 downto 64)   <= s_axis_i_tdata(79 downto 64)   + 8;
      s_axis_i_tdata(95 downto 80)   <= s_axis_i_tdata(95 downto 80)   + 8;
      s_axis_i_tdata(111 downto 96)  <= s_axis_i_tdata(111 downto 96)  + 8;
      s_axis_i_tdata(127 downto 112) <= s_axis_i_tdata(127 downto 112) + 8;
   end if;
end process;

uut: px_rf_adc_pdti_fmtr
generic map (
   channel => 1, -- 0 to 255
   has_in_tready => true
)
port map (
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI4-LITE)
   ----------------------------------------------------------------------------
   -- associated with s_axi_csr_aclk
   s_axi_csr_aclk         => s_axi_csr_aclk,      
   s_axi_csr_aresetn      => s_axi_csr_aresetn,   
   s_axi_csr_awaddr       => s_axi_csr_awaddr,    
   s_axi_csr_awprot       => s_axi_csr_awprot,    
   s_axi_csr_awvalid      => s_axi_csr_awvalid,   
   s_axi_csr_awready      => s_axi_csr_awready,   
   s_axi_csr_wdata        => s_axi_csr_wdata,     
   s_axi_csr_wstrb        => s_axi_csr_wstrb,     
   s_axi_csr_wvalid       => s_axi_csr_wvalid,    
   s_axi_csr_wready       => s_axi_csr_wready,    
   s_axi_csr_bresp        => s_axi_csr_bresp,     
   s_axi_csr_bvalid       => s_axi_csr_bvalid,    
   s_axi_csr_bready       => s_axi_csr_bready,    
   s_axi_csr_araddr       => s_axi_csr_araddr,    
   s_axi_csr_arprot       => s_axi_csr_arprot,    
   s_axi_csr_arvalid      => s_axi_csr_arvalid,   
   s_axi_csr_arready      => s_axi_csr_arready,   
   s_axi_csr_rdata        => s_axi_csr_rdata,     
   s_axi_csr_rresp        => s_axi_csr_rresp,     
   s_axi_csr_rvalid       => s_axi_csr_rvalid,    
   s_axi_csr_rready       => s_axi_csr_rready,    
--------------------------------------------------------------------------------
-- Input AXI-Stream   (s_axis_aclk)
--------------------------------------------------------------------------------
   s_axis_aclk            => s_axis_aclk,            
   s_axis_aresetn         => s_axis_aresetn,         
   --I or Real                   
   s_axis_i_tdata         => s_axis_i_tdata,         
   s_axis_i_tvalid        => s_axis_i_tvalid,        
   s_axis_i_tready        => s_axis_i_tready,        
   --Q                               
   s_axis_q_tdata         => s_axis_q_tdata,         
   s_axis_q_tvalid        => s_axis_q_tvalid,        
   s_axis_q_tready        => s_axis_q_tready,        
   
   -----------------------------------------------------------------------------
   -- Time Stamp Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   -- tuser[7:0]       = Gate Positions  
   -- tuser[15:8]      = Sync Positions      
   -- tuser[23:16]     = PPS Positions
   -- pts_tdata[63:0]  = timestamp[63:0] 
   -- (s_axis_aclk)
   s_axis_pts_tdata       => s_axis_pts_tdata,
   s_axis_pts_tuser       => s_axis_pts_tuser, 
   s_axis_pts_tvalid      => s_axis_pts_tvalid,
--------------------------------------------------------------------------------
-- Output AXI-Stream (Pentek PDTI Format)   (m_axis_aclk)
--------------------------------------------------------------------------------
   -- tuser[63:0]    = timestamp[63:0]
   -- tuser[71:64]   = Gate Positions  
   -- tuser[79:72]   = Sync Positions      
   -- tuser[87:80]   = PPS  Positions  
   -- tuser[91:88]   = Samples/Cycle
   -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   -- tuser[127:104] = Reserved 
   m_axis_pdti_aclk       => m_axis_pdti_aclk,    
   m_axis_aresetn         => m_axis_aresetn,      
   m_axis_pdti_tdata      => m_axis_pdti_tdata,   
   m_axis_pdti_tuser      => m_axis_pdti_tuser,   
   m_axis_pdti_tvalid     => m_axis_pdti_tvalid,  
   
   sync_rst               => sync_rst -- synchronous to s_axis_aclk
);

process
begin
   wait for 100 ns;
   s_axi_csr_aresetn <= '1';
   m_axis_aresetn <= '1';
   s_axis_aresetn <= '1';
   wait for 2000 ns;
       assert false
   report "Writing the Linked List Start Address." 
   severity NOTE;  
   px_axi_lite_writer( x"000", x"00000018", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   px_axi_lite_writer( x"000", x"00000080", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   wait until rising_edge(s_axis_aclk);
   s_axis_pts_tuser(15 downto 8) <= x"FF";
   wait until rising_edge(s_axis_aclk);
   s_axis_pts_tuser(15 downto 8) <= x"00";
   wait;
end process;

end Behavioral;
