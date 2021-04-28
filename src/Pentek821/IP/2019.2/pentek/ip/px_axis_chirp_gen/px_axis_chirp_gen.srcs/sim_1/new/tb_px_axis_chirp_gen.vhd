----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2017 07:49:19 AM
-- Design Name: 
-- Module Name: tb_px_axis_chirp_gen - Behavioral
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
use work.px_utility_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_axis_chirp_gen is
generic(
-- Samples per clock cycle 1,2,4,8
samples_per_cycle : integer range 1 to 8 := 1;
sample_freq: real := 100000000.0;  
pulsewidth : integer := 512; -- number of samples in length
start_freq : real := 0.0; 
end_freq: real := 1000000.0; -- must be higher than start_freq for this test bench
out_file_name           : string := "..\..\..\test_results.txt" -- Testbebch Output file
);
end tb_px_axis_chirp_gen;

architecture Behavioral of tb_px_axis_chirp_gen is

component px_axis_chirp_gen
generic (
    -- Samples per clock cycle 1,2,4,8
    samples_per_cycle : integer range 1 to 8 := 4   
);
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
   s_axis_aclk              : in  std_logic; -- Timestamp clock (usually data sample clock
   s_axis_aresetn           : in  std_logic; -- reset   
   s_axis_ptctl_tdata    : in  std_logic_vector(((((samples_per_cycle*3)+8)/8)*8)-1  downto 0);
   s_axis_ptctl_tvalid   : in  std_logic;
   -----------------------------------------------------------------------------
   -- Chirp Signal Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   m_axis_pd_tdata       : out std_logic_vector((samples_per_cycle*32)-1 downto 0);
   m_axis_pd_tvalid      : out std_logic
);
end component px_axis_chirp_gen;

--samples_per_cycle : integer range 1 to 4 := 4;
--sample_freq: real := 100000000.0;  
--pulsewidth : integer := 16; -- number of samples in length
--gatemode : std_logic := '0';
--start_freq : real := 5000000.0; 
--end_freq: real := 10000000.0
constant clkperiod : time := (((1.0/sample_freq)/2.0)/(real(samples_per_cycle))) * 1 us;
constant start_ph : real := (start_freq/sample_freq) * 4294967296.0;
constant start_ph_incr : std_logic_vector(31 downto 0) := conv_std_logic_vector(integer(start_ph), 32);
constant rate_ph : real :=  ((((end_freq-start_freq)/(real(pulsewidth))))/sample_freq) * 4294967296.0;
constant rate_ph_incr : std_logic_vector(31 downto 0) := conv_std_logic_vector(integer(rate_ph), 32);
constant pw: std_logic_vector(31 downto 0) := conv_std_logic_vector((pulsewidth), 32);

-- Register Addresses
constant CTRL_REGISTER  : std_logic_vector(15 downto 0) := x"0000";
constant START_REGISTER : std_logic_vector(15 downto 0) := x"0004";
constant RATE_REGISTER  : std_logic_vector(15 downto 0) := x"000C";
constant PW_REGISTER    : std_logic_vector(15 downto 0) := x"0010";

signal s_axi_csr_aclk           : std_logic := '0';
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
signal s_axi_csr_rready         : std_logic := '0';
signal irq                      : std_logic := '0'; -- Interrupt out

signal s_axis_aclk              : std_logic := '0'; -- Timestamp clock (usually data sample clock
signal s_axis_aresetn           : std_logic := '0'; -- reset   
signal s_axis_ptctl_tdata       : std_logic_vector(((((samples_per_cycle*3)+8)/8)*8)-1  downto 0) := (others => '0');
signal s_axis_ptctl_tvalid      : std_logic := '1';

signal m_axis_pd_tdata          : std_logic_vector((samples_per_cycle*32)-1 downto 0) := (others => '0');
signal m_axis_pd_tvalid         : std_logic := '0';

--------------------------------------------------------------------------------

begin

uut: px_axis_chirp_gen
generic map (
    -- Samples per clock cycle 1,2,4
    samples_per_cycle => samples_per_cycle 
)
port map(
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI4-LITE)
   ----------------------------------------------------------------------------
   -- associated with s_axi_csr_aclk
   s_axi_csr_aclk          => s_axi_csr_aclk,      
   s_axi_csr_aresetn       => s_axi_csr_aresetn,   
   s_axi_csr_awaddr        => s_axi_csr_awaddr(4 downto 0),    
   s_axi_csr_awprot        => s_axi_csr_awprot,    
   s_axi_csr_awvalid       => s_axi_csr_awvalid,   
   s_axi_csr_awready       => s_axi_csr_awready,   
   s_axi_csr_wdata         => s_axi_csr_wdata,     
   s_axi_csr_wstrb         => s_axi_csr_wstrb,     
   s_axi_csr_wvalid        => s_axi_csr_wvalid,    
   s_axi_csr_wready        => s_axi_csr_wready,    
   s_axi_csr_bresp         => s_axi_csr_bresp,     
   s_axi_csr_bvalid        => s_axi_csr_bvalid,    
   s_axi_csr_bready        => s_axi_csr_bready,    
   s_axi_csr_araddr        => s_axi_csr_araddr(4 downto 0),    
   s_axi_csr_arprot        => s_axi_csr_arprot,    
   s_axi_csr_arvalid       => s_axi_csr_arvalid,   
   s_axi_csr_arready       => s_axi_csr_arready,   
   s_axi_csr_rdata         => s_axi_csr_rdata,     
   s_axi_csr_rresp         => s_axi_csr_rresp,     
   s_axi_csr_rvalid        => s_axi_csr_rvalid,    
   s_axi_csr_rready        => s_axi_csr_rready,    

   irq                     => irq,                 
   -----------------------------------------------------------------------------
   -- Timing Events (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- tdata[n-1:0]       = Gate Positions
   -- tdata[2n-1:n]      = Sync Positions   
   -- tdata[3n-1:2n]     = PPS Positions  
   s_axis_aclk             => s_axis_aclk,        
   s_axis_aresetn          => s_axis_aresetn,     
   s_axis_ptctl_tdata      => s_axis_ptctl_tdata, 
   s_axis_ptctl_tvalid     => s_axis_ptctl_tvalid,
   -----------------------------------------------------------------------------
   -- Chirp Signal Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   m_axis_pd_tdata         => m_axis_pd_tdata,   
   m_axis_pd_tvalid        => m_axis_pd_tvalid  
);


process
begin
   loop 
      wait for 1 ns;
      s_axis_aclk <= not s_axis_aclk;
   end loop;     
end process;

process
begin
   loop 
      wait for 2 ns;
       s_axi_csr_aclk <= not s_axi_csr_aclk;
   end loop;      
end process;

-- 0x00 Mode Control
-- 0x04 Frequency Value
-- 0x08 Phase Offset
-- 0x0C Frequency ramp rate
-- 0x10 Pulse Width
-- 0x14 Interrupt Enables
-- 0x18 Interrupt Status Register
-- 0x1C Interrupt Flag Register 

-- Control
--Bit [0]   - Reset
--Bit [1]   - Arm Load 
--Bit [2]   - Arm Clear 
--Bit [3]   - Stay Armed
--Bit [5:4] - trig_sig_sel
--Bit [6]   - gate_mode
--Bit [7]   - up_mode
--Bit [31:16] - Gain 

test_process: process
variable c_time : time    := 0 ns;
variable d_time : time    := 0 ns;
variable x      : integer := 5;
variable ctl_init : std_logic_vector(31 downto 0) := x"04000082";
begin
   wait for 400 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   s_axis_aresetn <= '1';
   wait for 40 ns;
   c_time := now;
   -----------------------------------------------------------------------------
   -- Set up Control Registers
   -----------------------------------------------------------------------------
      assert false
      report "Writing to Control Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(CTRL_REGISTER, ctl_init, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Sect1 Control Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;
       
      assert false
      report "Writing to Start Frequency Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(START_REGISTER, start_ph_incr, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Start Frequency Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 
      
      assert false
      report "Writing to Frequency Rate Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(RATE_REGISTER, rate_ph_incr, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      --px_axi_lite_writer(RATE_REGISTER, x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Frequency Rate Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;   

      assert false
      report "Writing to Pulse Width Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(PW_REGISTER, pw, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      --px_axi_lite_writer(PW_REGISTER, x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Pulse Width Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;   
      
      assert false
      report "Writing to Control Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(CTRL_REGISTER, x"04000280", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Sect1 Control Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
         
   wait for 7 us;
       
   wait for 100 ns;  
   wait until rising_edge(s_axis_aclk);
   --s_axis_ptctl_tvalid <= '1';
   wait until rising_edge(s_axis_aclk);
   wait for 100 ns;
   wait until rising_edge(s_axis_aclk);
   --gate <= '1';  
   --s_axis_pdti_tdata(15 downto 0) <= x"4000";
   s_axis_ptctl_tdata <= (others => '1');
   wait until rising_edge(s_axis_aclk);
   s_axis_ptctl_tdata <= (others => '0');
   
   wait for 100 us;
   wait;
   
   assert false
   report "Test Complete, Not A Failure." 
   severity FAILURE;
end process;  

pcie_rqst_process: process

file MyFile: text;	
VARIABLE l : LINE; -- declare a line variable
variable i: integer := 0;
variable x: integer := 0;
begin
file_open(MyFile, out_file_name, WRITE_MODE);
								
wait until s_axis_aresetn = '1';
wait for 100 ns;
wait until rising_edge(s_axis_aclk);
for i in 0 to 4096 loop
    if (m_axis_pd_tvalid = '0') then
        wait until (m_axis_pd_tvalid = '1');
        wait until rising_edge(s_axis_aclk);  
    end if;
    -- Case Samples per cycle = 1 
    if (samples_per_cycle = 1) then
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(15 downto 0)& x"0000"))/65536));
        WRITELINE(MyFile,l); 
        --WRITE(l,STRING'(" , "));
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(31 downto 16)& x"0000"))/65536));
        WRITELINE(MyFile,l);  
    end if;  
    -- Case Samples per cycle = 2 
    if (samples_per_cycle = 2) then
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(15 downto 0)& x"0000"))/65536));
        WRITELINE(MyFile,l);  
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(31 downto 16)& x"0000"))/65536));
        WRITELINE(MyFile,l);  
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(47 downto 32)& x"0000"))/65536));
        WRITELINE(MyFile,l);  
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(63 downto 48)& x"0000"))/65536));
        WRITELINE(MyFile,l);   
    end if;    
--    -- Case Samples per cycle = 4 
    if (samples_per_cycle = 4) then
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(15 downto 0)& x"0000"))/65536));
        WRITELINE(MyFile,l);  
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(31 downto 16)& x"0000"))/65536));
        WRITELINE(MyFile,l);  
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(47 downto 32)& x"0000"))/65536));
        WRITELINE(MyFile,l);  
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(63 downto 48)& x"0000"))/65536));
        WRITELINE(MyFile,l);   
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(79 downto 64)& x"0000"))/65536));
        WRITELINE(MyFile,l); 
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(95 downto 80)& x"0000"))/65536));
        WRITELINE(MyFile,l); 
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(111 downto 96)& x"0000"))/65536)); 
        WRITELINE(MyFile,l); 
        WRITE(l,integer'image((conv_integer(m_axis_pd_tdata(127 downto 112)& x"0000"))/65536));
        WRITELINE(MyFile,l); 
    end if;    
    wait until rising_edge(s_axis_aclk);    
 end loop;
file_close(MyFile);
wait;
end process;


end Behavioral;
