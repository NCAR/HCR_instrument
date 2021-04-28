----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2018 03:35:12 PM
-- Design Name: 
-- Module Name: tb_px_pdti_dec16fir_8 - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.numeric_std.ALL;
use std.textio.all;	
use work.px_utility_pkg.ALL;			
Library xpm;
use xpm.vcomponents.all;				

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_pdti_dec16fir_8 is
end tb_px_pdti_dec16fir_8;

architecture Behavioral of tb_px_pdti_dec16fir_8 is

component px_pdti_dec16fir_8
port (
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

axis_aclk          : in std_logic;
axis_aresetn       : in std_logic;
-------------------------------------------------------------------------------
-- Input AXI-S PDTI
-------------------------------------------------------------------------------
-- [ Q7 I7 Q6 I6 Q5 I5 Q4 I4 Q3 I3 Q2 I2 I1 Q0 I0 ]  I0 is oldest sample
s_axis_pdti_tvalid : in std_logic;
s_axis_pdti_tdata  : in std_logic_vector(255 downto 0);
s_axis_pdti_tuser  : in std_logic_vector(127 downto 0);
-------------------------------------------------------------------------------
-- Output AXI-S PDTI
-------------------------------------------------------------------------------
m_axis_pdti_tvalid : out std_logic;
m_axis_pdti_tdata  : out std_logic_vector(31 downto 0);
m_axis_pdti_tuser  : out std_logic_vector(127 downto 0)
);
end component;

COMPONENT test_chirp_1
  PORT (
    s_axi_csr_aclk : IN STD_LOGIC;
    s_axi_csr_aresetn : IN STD_LOGIC;
    s_axi_csr_awaddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
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
    s_axi_csr_araddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    s_axi_csr_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_arvalid : IN STD_LOGIC;
    s_axi_csr_arready : OUT STD_LOGIC;
    s_axi_csr_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_rvalid : OUT STD_LOGIC;
    s_axi_csr_rready : IN STD_LOGIC;
    irq : OUT STD_LOGIC;
    s_axis_aclk : IN STD_LOGIC;
    s_axis_aresetn : IN STD_LOGIC;
    s_axis_ptctl_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_ptctl_tvalid : IN STD_LOGIC;
    m_axis_pd_tdata : OUT STD_LOGIC_VECTOR(255 DOWNTO 0);
    m_axis_pd_tvalid : OUT STD_LOGIC
  );
END COMPONENT;

signal axis_aclk          : std_logic := '0';
signal axis_aresetn       : std_logic := '0';

signal s_axis_pdti_tvalid : std_logic := '0';
signal s_axis_pdti_tdata  : std_logic_vector(255 downto 0):= (others => '0');
signal s_axis_pdti_tuser  : std_logic_vector(127 downto 0):= (others => '0');

signal m_axis_pdti_tvalid :  std_logic := '0';
signal m_axis_pdti_tdata  :  std_logic_vector(31 downto 0) := (others => '0');
signal m_axis_pdti_tuser  :  std_logic_vector(127 downto 0):= (others => '0');

signal s_axi_csr_aclk : STD_LOGIC := '0';
signal s_axi_csr_aresetn : STD_LOGIC := '0';
signal s_axi_csr_awaddr : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
signal s_axi_csr_awprot : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
signal s_axi_csr_awvalid : STD_LOGIC := '0';
signal s_axi_csr_awready :  STD_LOGIC := '0';
signal s_axi_csr_wdata :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
signal s_axi_csr_wstrb :  STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
signal s_axi_csr_wvalid :  STD_LOGIC := '0';
signal s_axi_csr_wready :  STD_LOGIC := '0';
signal s_axi_csr_bresp :  STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
signal s_axi_csr_bvalid :  STD_LOGIC := '0';
signal s_axi_csr_bready :  STD_LOGIC := '0';
signal s_axi_csr_araddr :  STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
signal s_axi_csr_arprot :  STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
signal s_axi_csr_arvalid :  STD_LOGIC := '0';
signal s_axi_csr_arready :  STD_LOGIC := '0';
signal s_axi_csr_rdata :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
signal s_axi_csr_rresp :  STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
signal s_axi_csr_rvalid :  STD_LOGIC := '0';
signal s_axi_csr_rready :  STD_LOGIC := '0';
signal irq :  STD_LOGIC := '0';


signal uut_axi_csr_awaddr : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
signal uut_axi_csr_awprot : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
signal uut_axi_csr_awvalid : STD_LOGIC := '0';
signal uut_axi_csr_awready :  STD_LOGIC := '0';
signal uut_axi_csr_wdata :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
signal uut_axi_csr_wstrb :  STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
signal uut_axi_csr_wvalid :  STD_LOGIC := '0';
signal uut_axi_csr_wready :  STD_LOGIC := '0';
signal uut_axi_csr_bresp :  STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
signal uut_axi_csr_bvalid :  STD_LOGIC := '0';
signal uut_axi_csr_bready :  STD_LOGIC := '0';
signal uut_axi_csr_araddr :  STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
signal uut_axi_csr_arprot :  STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
signal uut_axi_csr_arvalid :  STD_LOGIC := '0';
signal uut_axi_csr_arready :  STD_LOGIC := '0';
signal uut_axi_csr_rdata :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
signal uut_axi_csr_rresp :  STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
signal uut_axi_csr_rvalid :  STD_LOGIC := '0';
signal uut_axi_csr_rready :  STD_LOGIC := '0';

signal s_axis_ptctl_tdata:  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');

type f_type is array (0 to 8) of std_logic_vector(31 downto 0);

constant freq_array: f_type := (
x"00000000",
x"04000000",
x"06660000",
x"08000000",
x"099C0000",
x"10000000",
x"20000000",
x"40000000",
x"80000000"
);

-- Chirp Gen Register Addresses
constant CTRL_REGISTER  : std_logic_vector(15 downto 0) := x"0000";
constant START_REGISTER : std_logic_vector(15 downto 0) := x"0004";
constant RATE_REGISTER  : std_logic_vector(15 downto 0) := x"000C";
constant PW_REGISTER    : std_logic_vector(15 downto 0) := x"0010";


begin


uut: px_pdti_dec16fir_8
port map (
s_axi_csr_aclk     => s_axi_csr_aclk,   
s_axi_csr_aresetn  => s_axi_csr_aresetn,
s_axi_csr_awaddr   => uut_axi_csr_awaddr(4 downto 0), 
s_axi_csr_awprot   => uut_axi_csr_awprot, 
s_axi_csr_awvalid  => uut_axi_csr_awvalid,
s_axi_csr_awready  => uut_axi_csr_awready,
s_axi_csr_wdata    => uut_axi_csr_wdata,  
s_axi_csr_wstrb    => uut_axi_csr_wstrb,  
s_axi_csr_wvalid   => uut_axi_csr_wvalid, 
s_axi_csr_wready   => uut_axi_csr_wready, 
s_axi_csr_bresp    => uut_axi_csr_bresp,  
s_axi_csr_bvalid   => uut_axi_csr_bvalid,
s_axi_csr_bready   => uut_axi_csr_bready, 
s_axi_csr_araddr   => uut_axi_csr_araddr(4 downto 0), 
s_axi_csr_arprot   => uut_axi_csr_arprot, 
s_axi_csr_arvalid  => uut_axi_csr_arvalid,
s_axi_csr_arready  => uut_axi_csr_arready,
s_axi_csr_rdata    => uut_axi_csr_rdata,  
s_axi_csr_rresp    => uut_axi_csr_rresp,  
s_axi_csr_rvalid   => uut_axi_csr_rvalid,
s_axi_csr_rready   => uut_axi_csr_rready,
 
axis_aclk          => axis_aclk,   
axis_aresetn       => axis_aresetn,
-------------------------------------------------------------------------------
-- Input AXI-S PDTI
-------------------------------------------------------------------------------
-- [ Q7 I7 Q6 I6 Q5 I5 Q4 I4 Q3 I3 Q2 I2 I1 Q0 I0 ]  I0 is oldest sample
s_axis_pdti_tvalid => s_axis_pdti_tvalid,
s_axis_pdti_tdata  => s_axis_pdti_tdata, 
s_axis_pdti_tuser  => s_axis_pdti_tuser, 
-------------------------------------------------------------------------------
-- Output AXI-S PDTI
-------------------------------------------------------------------------------
m_axis_pdti_tvalid => m_axis_pdti_tvalid,
m_axis_pdti_tdata  => m_axis_pdti_tdata, 
m_axis_pdti_tuser  => m_axis_pdti_tuser 
);

  
process
begin
    loop
        wait for 5 ns;
        axis_aclk <= not axis_aclk;
    end loop;
end process;

process
begin
    loop
        wait for 2 ns;
        s_axi_csr_aclk <= not s_axi_csr_aclk;
    end loop;
end process;

-- Mode Control
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
variable ctl_init : std_logic_vector(31 downto 0) := x"80000082";
begin
   wait for 400 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   axis_aresetn <= '1';
   wait for 40 ns;

   -----------------------------------------------------------------------------
   -- Set up Control Registers
   -----------------------------------------------------------------------------
   c_time := now;
   report "Toggling Syncing Decimation Manually. Start Time = " & time'image(now) 
   severity NOTE;
   px_axi_lite_writer(x"0000", x"00000001", s_axi_csr_aclk, uut_axi_csr_awaddr, uut_axi_csr_awprot, uut_axi_csr_awvalid, uut_axi_csr_awready, uut_axi_csr_wdata, uut_axi_csr_wstrb, uut_axi_csr_wvalid, uut_axi_csr_wready, uut_axi_csr_bresp, uut_axi_csr_bvalid, uut_axi_csr_bready);
   d_time := now - c_time; 
   assert false
   report "Finished Writing to Sect1 Control Register. End Time = " & time'image(now) 
   severity NOTE;
   assert false
   report "Total Time = " & time'image(d_time) 
   severity NOTE;
   c_time := now;   
   report "Sync off. Start Time = " & time'image(now) 
   severity NOTE;
   px_axi_lite_writer(x"0000", x"00000000", s_axi_csr_aclk, uut_axi_csr_awaddr, uut_axi_csr_awprot, uut_axi_csr_awvalid, uut_axi_csr_awready, uut_axi_csr_wdata, uut_axi_csr_wstrb, uut_axi_csr_wvalid, uut_axi_csr_wready, uut_axi_csr_bresp, uut_axi_csr_bvalid, uut_axi_csr_bready);
   d_time := now - c_time; 
   assert false
   report "Finished Writing to Sect1 Control Register. End Time = " & time'image(now) 
   severity NOTE;
   assert false
   report "Total Time = " & time'image(d_time) 
   severity NOTE;
   c_time := now;    
   for i in 0 to 8 loop
    assert false
    report "Writing to Control Register Reset. Start Time = " & time'image(now) 
    severity NOTE;
    px_axi_lite_writer(CTRL_REGISTER, x"80000081", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    d_time := now - c_time; 
    assert false
    report "Finished Writing to Sect1 Control Register. End Time = " & time'image(now) 
    severity NOTE;
    assert false
    report "Total Time = " & time'image(d_time) 
    severity NOTE;
     wait for 100 ns;
     assert false
     report "Writing to Control Register End Reset. Start Time = " & time'image(now) 
     severity NOTE;
     px_axi_lite_writer(CTRL_REGISTER, x"80000080", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
     d_time := now - c_time; 
     assert false
     report "Finished Writing to Sect1 Control Register. End Time = " & time'image(now) 
     severity NOTE;
     assert false
     report "Total Time = " & time'image(d_time) 
     severity NOTE;
     
     wait for 100 ns;
   
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
      px_axi_lite_writer(START_REGISTER, freq_array(i), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
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
     -- px_axi_lite_writer(RATE_REGISTER, rate_ph_incr, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      px_axi_lite_writer(RATE_REGISTER, x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
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
      px_axi_lite_writer(PW_REGISTER, x"FFFFFFFF", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
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
      px_axi_lite_writer(CTRL_REGISTER, x"80000280", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Sect1 Control Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
         
   wait for 1 us;
       
   wait for 100 ns;  
   wait until rising_edge(axis_aclk);
   wait until rising_edge(axis_aclk);
   wait for 100 ns;
   wait until rising_edge(axis_aclk);

        wait until rising_edge(axis_aclk);
        s_axis_ptctl_tdata <= (others => '1'); -- trigger
        s_axis_pdti_tuser(87 downto 64) <= (others => '1'); 
        --s_axis_pdti_tdata(15 downto 0)  <= x"7FFE"; 
        wait until rising_edge(axis_aclk);
        s_axis_ptctl_tdata <= (others => '0');
        --s_axis_pdti_tdata(15 downto 0)  <= x"0000"; 
        s_axis_pdti_tuser(87 downto 64) <= (others => '0'); 
        wait for 5 us;
   end loop;
   wait for 5 us;
   assert false
   report "Test Complete, Not A Failure." 
   severity FAILURE;
end process;    

chirp_inst : test_chirp_1
  PORT MAP (
    s_axi_csr_aclk => s_axi_csr_aclk,
    s_axi_csr_aresetn => s_axi_csr_aresetn,
    s_axi_csr_awaddr => s_axi_csr_awaddr(4 downto 0),
    s_axi_csr_awprot => s_axi_csr_awprot,
    s_axi_csr_awvalid => s_axi_csr_awvalid,
    s_axi_csr_awready => s_axi_csr_awready,
    s_axi_csr_wdata => s_axi_csr_wdata,
    s_axi_csr_wstrb => s_axi_csr_wstrb,
    s_axi_csr_wvalid => s_axi_csr_wvalid,
    s_axi_csr_wready => s_axi_csr_wready,
    s_axi_csr_bresp => s_axi_csr_bresp,
    s_axi_csr_bvalid => s_axi_csr_bvalid,
    s_axi_csr_bready => s_axi_csr_bready,
    s_axi_csr_araddr => s_axi_csr_araddr(4 downto 0),
    s_axi_csr_arprot => s_axi_csr_arprot,
    s_axi_csr_arvalid => s_axi_csr_arvalid,
    s_axi_csr_arready => s_axi_csr_arready,
    s_axi_csr_rdata => s_axi_csr_rdata,
    s_axi_csr_rresp => s_axi_csr_rresp,
    s_axi_csr_rvalid => s_axi_csr_rvalid,
    s_axi_csr_rready => s_axi_csr_rready,
    irq => irq,
    s_axis_aclk => axis_aclk,
    s_axis_aresetn => axis_aresetn,
    s_axis_ptctl_tdata => s_axis_ptctl_tdata,
    s_axis_ptctl_tvalid => '1',
    m_axis_pd_tdata => s_axis_pdti_tdata,
    m_axis_pd_tvalid => s_axis_pdti_tvalid
  );

end Behavioral;
