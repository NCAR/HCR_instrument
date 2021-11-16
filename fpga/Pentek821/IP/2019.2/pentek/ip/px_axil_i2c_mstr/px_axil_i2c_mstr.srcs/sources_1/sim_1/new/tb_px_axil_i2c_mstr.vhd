----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2015 12:00:37 PM
-- Design Name: 
-- Module Name: tb_px_axil_i2c_mstr - Behavioral
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

use work.px_utility_pkg.ALL; -- Pentek Utility Package

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity tb_px_axil_i2c_mstr is
generic (
   port_init_rate_khz  : integer := 100;  -- Initial output I2C clock rate setting at reset
   i2c_address         : std_logic_vector(6 downto 0) := "1010000"
);
end tb_px_axil_i2c_mstr;

architecture Behavioral of tb_px_axil_i2c_mstr is

--------------------------------------------------------------------------------
-- Component
--------------------------------------------------------------------------------

component px_axil_i2c_mstr
generic (
   port_has_mga        : boolean := true; -- Has Geographical Address Input (IP Packager uses this generic)
   in_clk_rate_mhz     : integer := 250; -- Input Clock Rate in Megahertz
   port_init_rate_khz  : integer := 100  -- Initial output I2C clock rate setting at reset
   );
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(5 downto 0);
   s_axi_csr_awprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid   : in  std_logic;
   s_axi_csr_awready   : out std_logic;
   s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0); 
   s_axi_csr_wvalid    : in  std_logic;
   s_axi_csr_wready    : out std_logic;
   s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid    : out std_logic;
   s_axi_csr_bready    : in  std_logic;
   s_axi_csr_araddr    : in  std_logic_vector(5 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;
  
   irq                 : out std_logic;
   ----------------------------------------------------------------------------
   -- I2C Port
   ----------------------------------------------------------------------------
   -- Conforms to Interface frmat of IP Integrator IIC bus interface.
   -- Connect externally to Tri-State Buffers.
   port_scl_i         : in  std_logic;
   port_scl_o         : out std_logic;
   port_scl_t         : out std_logic;
   port_sda_i         : in  std_logic;
   port_sda_o         : out std_logic;
   port_sda_t         : out std_logic;
   port_mga           : in  std_logic_vector(2 downto 0) -- Geographical Address Input
   );
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
signal s_axi_csr_aclk      : std_logic := '0';
signal s_axi_csr_aresetn   : std_logic := '0';
signal s_axi_csr_awaddr    : std_logic_vector(5 downto 0) := (others => '0');
signal s_axi_csr_awprot    : std_logic_vector(2 downto 0) := (others => '0'); -- not used
signal s_axi_csr_awvalid   : std_logic := '0';
signal s_axi_csr_awready   : std_logic := '0';
signal s_axi_csr_wdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_wstrb     : std_logic_vector(3 downto 0) := (others => '0'); 
signal s_axi_csr_wvalid    : std_logic := '0';
signal s_axi_csr_wready    : std_logic := '0';
signal s_axi_csr_bresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_bvalid    : std_logic := '0';
signal s_axi_csr_bready    : std_logic := '0';
signal s_axi_csr_araddr    : std_logic_vector(5 downto 0) := (others => '0');
signal s_axi_csr_arprot    : std_logic_vector(2 downto 0) := (others => '0'); -- not used
signal s_axi_csr_arvalid   : std_logic := '0';
signal s_axi_csr_arready   : std_logic := '0';
signal s_axi_csr_rdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid    : std_logic := '0';
signal s_axi_csr_rready    : std_logic := '0';
  
signal irq                 : std_logic := '0';

----------------------------------------------------------------------------
-- I2C Port
----------------------------------------------------------------------------
   -- Conforms to Interface frmat of IP Integrator IIC bus interface.
   -- Connect externally to Tri-State Buffers.
signal port_scl_i         : std_logic := '0';
signal port_scl_o         : std_logic := '0';
signal port_scl_t         : std_logic := '1';
signal port_sda_i         : std_logic := '0';
signal port_sda_o         : std_logic := '0';
signal port_sda_t         : std_logic := '1';
signal port_mga           : std_logic_vector(2 downto 0) := "000"; -- Geographical Address Input
signal SCL                : std_logic := 'Z';
signal SDA                : std_logic := 'Z';
signal sda_buf_in         : std_logic := '0';
signal scl_buf_in         : std_logic := '0';

--------------------------------------------------------------------------------   
-- Constants
--------------------------------------------------------------------------------
-- Control/Status Register Addresses
constant START_REG_ADDR          : std_logic_vector(5 downto 0) := "000000";
constant RATE_REG_ADDR           : std_logic_vector(5 downto 0) := "000100";
constant I2CADDR_REG_ADDR        : std_logic_vector(5 downto 0) := "001000"; 
constant CONTROL_REG_ADDR        : std_logic_vector(5 downto 0) := "001100";
constant STATUS_REG_ADDR         : std_logic_vector(5 downto 0) := "010000";  
constant INTRPT_ENABLE_REG_ADDR  : std_logic_vector(5 downto 0) := "010100";
constant INTRPT_STATUS_REG_ADDR  : std_logic_vector(5 downto 0) := "011000";  
constant INTRPT_FLAG_REG_ADDR    : std_logic_vector(5 downto 0) := "011100";
constant DATA_FIFO_ADDR          : std_logic_vector(5 downto 0) := "100000";
constant DATA_FIFO_FLAG_ADDR     : std_logic_vector(5 downto 0) := "100100";
-- Interrupt Enable bit positions
constant TRNS_DONE_ENABLE        : std_logic_vector(31 downto 0) := x"00000001";
constant NOT_BUSY_ENABLE         : std_logic_vector(31 downto 0) := x"00000002";
constant NO_ACK_ENABLE           : std_logic_vector(31 downto 0) := x"00000004";
constant RX_FIFO_EMPTY_ENABLE    : std_logic_vector(31 downto 0) := x"00000008";
constant RX_FIFO_FULL_ENABLE     : std_logic_vector(31 downto 0) := x"00000010";
constant TX_FIFO_EMPTY_ENABLE    : std_logic_vector(31 downto 0) := x"00000020";
constant TX_FIFO_FULL_ENABLE     : std_logic_vector(31 downto 0) := x"00000040";

--------------------------------------------------------------------------------

begin

uut: px_axil_i2c_mstr
generic map (
   port_has_mga        => true, -- Has Geographical Address Input (IP Packager uses this generic)
   in_clk_rate_mhz     => 250, -- Input Clock Rate in Megahertz
   port_init_rate_khz  => port_init_rate_khz  -- Initial output I2C clock rate setting at reset
   )
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk      => s_axi_csr_aclk,    
   s_axi_csr_aresetn   => s_axi_csr_aresetn, 
   s_axi_csr_awaddr    => s_axi_csr_awaddr,  
   s_axi_csr_awprot    => s_axi_csr_awprot,  
   s_axi_csr_awvalid   => s_axi_csr_awvalid, 
   s_axi_csr_awready   => s_axi_csr_awready, 
   s_axi_csr_wdata     => s_axi_csr_wdata,   
   s_axi_csr_wstrb     => s_axi_csr_wstrb,   
   s_axi_csr_wvalid    => s_axi_csr_wvalid,  
   s_axi_csr_wready    => s_axi_csr_wready,  
   s_axi_csr_bresp     => s_axi_csr_bresp,   
   s_axi_csr_bvalid    => s_axi_csr_bvalid,  
   s_axi_csr_bready    => s_axi_csr_bready,  
   s_axi_csr_araddr    => s_axi_csr_araddr,  
   s_axi_csr_arprot    => s_axi_csr_arprot,  
   s_axi_csr_arvalid   => s_axi_csr_arvalid, 
   s_axi_csr_arready   => s_axi_csr_arready, 
   s_axi_csr_rdata     => s_axi_csr_rdata,   
   s_axi_csr_rresp     => s_axi_csr_rresp,   
   s_axi_csr_rvalid    => s_axi_csr_rvalid,  
   s_axi_csr_rready    => s_axi_csr_rready,  
  
   irq                 => irq,
   ----------------------------------------------------------------------------
   -- I2C Port
   ----------------------------------------------------------------------------
   -- Conforms to Interface frmat of IP Integrator IIC bus interface.
   -- Connect externally to Tri-State Buffers.
   port_scl_i          => port_scl_i,
   port_scl_o          => port_scl_o,
   port_scl_t          => port_scl_t,
   port_sda_i          => port_sda_i,
   port_sda_o          => port_sda_o,
   port_sda_t          => port_sda_t,
   port_mga            => port_mga   -- Geographical Address Input
   );
   
--------------------------------------------------------------------------------
-- I/O Tri-State Buffers
--------------------------------------------------------------------------------
scl_IOBUF_inst : IOBUF
port map (
   O  => scl_buf_in,   -- 1-bit output: Buffer output
   I  => port_scl_o,   -- 1-bit input: Buffer input
   IO => SCL, -- 1-bit inout: Buffer inout (connect directly to top-level port)
   T  => port_scl_t    -- 1-bit input: 3-state enable input
);

sda_IOBUF_inst : IOBUF
port map (
   O  => sda_buf_in,   -- 1-bit output: Buffer output
   I  => port_sda_o,   -- 1-bit input: Buffer input
   IO => SDA, -- 1-bit inout: Buffer inout (connect directly to top-level port)
   T  => port_sda_t    -- 1-bit input: 3-state enable input
);  

scl_PULLUP_inst : PULLUP
port map (
   O => SCL  -- 1-bit output: Pullup output (connect directly to top-level port)
);

sda_PULLUP_inst : PULLUP
port map (
   O => SDA  -- 1-bit output: Pullup output (connect directly to top-level port)
);

port_scl_i <= '1' when ((scl_buf_in = 'H') or (scl_buf_in = '1')) else '0';  
port_sda_i <= '1' when ((sda_buf_in = 'H') or (sda_buf_in = '1')) else '0'; 

--------------------------------------------------------------------------------
-- Generate Clock
--------------------------------------------------------------------------------

clk_gen: process
begin
   loop
      wait for 2 ns;
      s_axi_csr_aclk <= not s_axi_csr_aclk;
   end loop;
end process;   

stim_process: process
begin
   wait for 100 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   wait until rising_edge(s_axi_csr_aclk);
   wait until rising_edge(s_axi_csr_aclk);
   -- Clear Interrupt Flag Register
   assert false
   report "Clearing Interrupt Flag Register." 
   severity NOTE;
   px_axi_lite_writer(
      INTRPT_FLAG_REG_ADDR,
      (x"000000FF"),
      s_axi_csr_aclk,
      s_axi_csr_awaddr,  
      s_axi_csr_awprot,  
      s_axi_csr_awvalid, 
      s_axi_csr_awready, 
      s_axi_csr_wdata,   
      s_axi_csr_wstrb,   
      s_axi_csr_wvalid,  
      s_axi_csr_wready,  
      s_axi_csr_bresp,   
      s_axi_csr_bvalid,  
      s_axi_csr_bready  
      );
   assert false
   report "Enabling Interrupt Enable for 'Transaction Done'." 
   severity NOTE;
   -- Enable Interrupt for Transaction done
   px_axi_lite_writer(
      INTRPT_ENABLE_REG_ADDR,
      TRNS_DONE_ENABLE,
      s_axi_csr_aclk,
      s_axi_csr_awaddr,  
      s_axi_csr_awprot,  
      s_axi_csr_awvalid, 
      s_axi_csr_awready, 
      s_axi_csr_wdata,   
      s_axi_csr_wstrb,   
      s_axi_csr_wvalid,  
      s_axi_csr_wready,  
      s_axi_csr_bresp,   
      s_axi_csr_bvalid,  
      s_axi_csr_bready  
      );   
   assert false   
   report "Setting the I2C Address."   
   severity NOTE;
   -- Set the desired I2C Address
   px_axi_lite_writer(
         I2CADDR_REG_ADDR,
         (x"000000" & '0' & i2c_address),
         s_axi_csr_aclk,
         s_axi_csr_awaddr,  
         s_axi_csr_awprot,  
         s_axi_csr_awvalid, 
         s_axi_csr_awready, 
         s_axi_csr_wdata,   
         s_axi_csr_wstrb,   
         s_axi_csr_wvalid,  
         s_axi_csr_wready,  
         s_axi_csr_bresp,   
         s_axi_csr_bvalid,  
         s_axi_csr_bready  
         );
    assert false   
    report "Setting Control Register for Write of One Byte."   
    severity NOTE;
    -- Set up the Control Register for Write of 1 byte
    -- Set Enable bit to '1', R/W bit to '0', Number Bytes to x"0" (1-1))
    px_axi_lite_writer(
        CONTROL_REG_ADDR,
        (x"000000" & "0000" & "00" & '0' & '1'), 
        s_axi_csr_aclk,
        s_axi_csr_awaddr,  
        s_axi_csr_awprot,  
        s_axi_csr_awvalid, 
        s_axi_csr_awready, 
        s_axi_csr_wdata,   
        s_axi_csr_wstrb,   
        s_axi_csr_wvalid,  
        s_axi_csr_wready,  
        s_axi_csr_bresp,   
        s_axi_csr_bvalid,  
        s_axi_csr_bready  
        );
     assert false   
     report "Writing the value 0xA5 to the Data Transmit FIFO (Data to transmit over I2C)."   
     severity NOTE;
     -- Write a data value of 0xA5 to the Data Transmit FIFO (Data to transmit over I2C)   
     px_axi_lite_writer(
       DATA_FIFO_ADDR,
       (x"000000A5"), 
       s_axi_csr_aclk,
       s_axi_csr_awaddr,  
       s_axi_csr_awprot,  
       s_axi_csr_awvalid, 
       s_axi_csr_awready, 
       s_axi_csr_wdata,   
       s_axi_csr_wstrb,   
       s_axi_csr_wvalid,  
       s_axi_csr_wready,  
       s_axi_csr_bresp,   
       s_axi_csr_bvalid,  
       s_axi_csr_bready  
       );  
     assert false   
     report "Toggling the Start Transaction Control Bit."   
     severity NOTE;       
     -- Toggle Start bit
     px_axi_lite_writer(
        START_REG_ADDR,
        (x"00000001"), 
        s_axi_csr_aclk,
        s_axi_csr_awaddr,  
        s_axi_csr_awprot,  
        s_axi_csr_awvalid, 
        s_axi_csr_awready, 
        s_axi_csr_wdata,   
        s_axi_csr_wstrb,   
        s_axi_csr_wvalid,  
        s_axi_csr_wready,  
        s_axi_csr_bresp,   
        s_axi_csr_bvalid,  
        s_axi_csr_bready  
        );
      px_axi_lite_writer(
        START_REG_ADDR,
        (x"00000000"), 
        s_axi_csr_aclk,
        s_axi_csr_awaddr,  
        s_axi_csr_awprot,  
        s_axi_csr_awvalid, 
        s_axi_csr_awready, 
        s_axi_csr_wdata,   
        s_axi_csr_wstrb,   
        s_axi_csr_wvalid,  
        s_axi_csr_wready,  
        s_axi_csr_bresp,   
        s_axi_csr_bvalid,  
        s_axi_csr_bready  
        );  
   assert false   
   report "Waiting for Transaction Done Interrupt..."   
   severity NOTE;     
   -- Wait for Transaction Done Interrupt     
   wait until (irq = '1');
   wait until (irq = '0');
   assert false   
   report "Transaction Done Interrupt was Received."   
   severity NOTE;  
   assert false   
   report "Reading Interrupt Flag Register."   
   severity NOTE;  
   -- Read Interrupt Flag Register
   px_axi_lite_reader(
       INTRPT_FLAG_REG_ADDR,
       x"00000001",
       '0',
       '0', 
       s_axi_csr_aclk,
       s_axi_csr_araddr,     
       s_axi_csr_arprot,     
       s_axi_csr_arvalid,    
       s_axi_csr_arready,    
       s_axi_csr_rdata,      
       s_axi_csr_rresp,      
       s_axi_csr_rvalid,     
       s_axi_csr_rready     
       );
   assert false   
   report "Interrupt Flag Register = 0x" &  px_std_logic_vector_to_hstring(s_axi_csr_rdata) 
   severity NOTE; 
   assert false   
   report "Clearing Interrupt."
   severity NOTE;
   -- Clear Interrupt Flag Register
   px_axi_lite_writer(
      INTRPT_FLAG_REG_ADDR,
      (x"000000FF"),
      s_axi_csr_aclk,
      s_axi_csr_awaddr,  
      s_axi_csr_awprot,  
      s_axi_csr_awvalid, 
      s_axi_csr_awready, 
      s_axi_csr_wdata,   
      s_axi_csr_wstrb,   
      s_axi_csr_wvalid,  
      s_axi_csr_wready,  
      s_axi_csr_bresp,   
      s_axi_csr_bvalid,  
      s_axi_csr_bready  
      );
   assert false   
   report "Verifying that the Flags are Cleared."
   severity NOTE;
   -- Verify the Flags all cleared
   px_axi_lite_reader(
      INTRPT_FLAG_REG_ADDR,
      x"00000000",
      '1',
      '1', 
      s_axi_csr_aclk,
      s_axi_csr_araddr,     
      s_axi_csr_arprot,     
      s_axi_csr_arvalid,    
      s_axi_csr_arready,    
      s_axi_csr_rdata,      
      s_axi_csr_rresp,      
      s_axi_csr_rvalid,     
      s_axi_csr_rready     
      );      
   
   assert false   
   report "Setting Control Register for Read of One Byte."   
   severity NOTE;
   -- Set up the Control Register for Write of 1 byte
   -- Set Enable bit to '1', R/W bit to '0', Number Bytes to x"0" (1-1))
   px_axi_lite_writer(
       CONTROL_REG_ADDR,
       (x"000000" & "0000" & "00" & '1' & '1'), 
       s_axi_csr_aclk,
       s_axi_csr_awaddr,  
       s_axi_csr_awprot,  
       s_axi_csr_awvalid, 
       s_axi_csr_awready, 
       s_axi_csr_wdata,   
       s_axi_csr_wstrb,   
       s_axi_csr_wvalid,  
       s_axi_csr_wready,  
       s_axi_csr_bresp,   
       s_axi_csr_bvalid,  
       s_axi_csr_bready  
       );
    assert false                                      
    report "Toggling the Start Transaction Control Bit."
    severity NOTE;                                    
    -- Toggle Start bit                               
    px_axi_lite_writer(                               
      START_REG_ADDR,                                
      (x"00000001"),                                 
      s_axi_csr_aclk,                                
      s_axi_csr_awaddr,                              
      s_axi_csr_awprot,                              
      s_axi_csr_awvalid,                             
      s_axi_csr_awready,                             
      s_axi_csr_wdata,                               
      s_axi_csr_wstrb,                               
      s_axi_csr_wvalid,                              
      s_axi_csr_wready,                              
      s_axi_csr_bresp,                               
      s_axi_csr_bvalid,                              
      s_axi_csr_bready                               
      );                                             
    px_axi_lite_writer(                              
      START_REG_ADDR,                                
      (x"00000000"),                                 
      s_axi_csr_aclk,                                
      s_axi_csr_awaddr,                              
      s_axi_csr_awprot,                              
      s_axi_csr_awvalid,                             
      s_axi_csr_awready,                             
      s_axi_csr_wdata,                               
      s_axi_csr_wstrb,                               
      s_axi_csr_wvalid,                              
      s_axi_csr_wready,                              
      s_axi_csr_bresp,                               
      s_axi_csr_bvalid,                              
      s_axi_csr_bready                               
      );                                             
    assert false                                        
    report "Waiting for Transaction Done Interrupt..."  
    severity NOTE;                                      
    -- Wait for Transaction Done Interrupt              
    wait until (irq = '1');                             
    wait until (irq = '0');                             
    assert false                                        
    report "Transaction Done Interrupt was Received. Read Complete."   
    severity NOTE;                                      
    
    assert false   
    report "Reading the Data Receive FIFO."   
    severity NOTE;
   -- Read data value from the Data Receive FIFO (Data received over I2C)   
   px_axi_lite_reader(
      DATA_FIFO_ADDR,
      x"000000A5", 
      '1',
      '1', 
      s_axi_csr_aclk,
      s_axi_csr_araddr,     
      s_axi_csr_arprot,     
      s_axi_csr_arvalid,    
      s_axi_csr_arready,    
      s_axi_csr_rdata,      
      s_axi_csr_rresp,      
      s_axi_csr_rvalid,     
      s_axi_csr_rready     
      );                                            
   assert false   
   report "**** Data Received by Core from I2C = 0x" &  px_std_logic_vector_to_hstring(s_axi_csr_rdata) 
   severity NOTE;        
   assert false
   report "******* Test Completed. Not an error. Time = " & time'image(now)
   severity FAILURE;
   
end process;

receive_i2c: process
variable addr : std_logic_vector(6 downto 0) := "0000000";
variable wr   : std_logic := '0';
variable data : std_logic_vector(7 downto 0) := x"00";
variable t    : time;
variable period : time;
begin
   loop
      wait until ((SDA = 'H') and (SCL = 'H')); 
      wait until (SDA = '0');       -- Start
      assert false
      report "**** Start Bit sensed on I2C bus ****" 
      severity NOTE;
      wait until rising_edge(SCL); 
      t := time(now);
      if SDA = '0' then addr(6) := '0'; else addr(6) := '1'; end if;  -- Address MSB
      wait until rising_edge(SCL); 
      period := (time(now) - t);
      assert false
      report "**** I2C Clock Period = " &  time'image(period) & " ****" 
      severity NOTE;
      if SDA = '0' then addr(5) := '0'; else addr(5) := '1'; end if;
      wait until rising_edge(SCL); 
      if SDA = '0' then addr(4) := '0'; else addr(4) := '1'; end if;
      wait until rising_edge(SCL); 
      if SDA = '0' then addr(3) := '0'; else addr(3) := '1'; end if;
      wait until rising_edge(SCL); 
      if SDA = '0' then addr(2) := '0'; else addr(2) := '1'; end if;
      wait until rising_edge(SCL); 
      if SDA = '0' then addr(1) := '0'; else addr(1) := '1'; end if;
      wait until rising_edge(SCL); 
      if SDA = '0' then addr(0) := '0'; else addr(0) := '1'; end if;   -- Address LSB
      wait until rising_edge(SCL);  
      if SDA = '0' then wr := '1'; else wr := '0'; end if; -- Read/Write Command
      if wr = '1' then    
         assert false
         report "**** Sensed Write Transaction on I2C Bus ****" 
         severity NOTE;
      else
         assert false
         report "Sensed Read" 
         severity NOTE;
      end if;   
      wait until falling_edge(SCL);
      assert false
      report "**** Acknowledging Address on I2C bus ****" 
      severity NOTE;  
      SDA <= '0';
      wait until falling_edge(SCL);
      SDA <= 'Z'; 
      if wr = '1' then -- write
         wait until rising_edge(SCL);
         if SDA = '0' then data(7) := '0'; else data(7) := '1'; end if;
         wait until rising_edge(SCL);
         if SDA = '0' then data(6) := '0'; else data(6) := '1'; end if;
         wait until rising_edge(SCL);
         if SDA = '0' then data(5) := '0'; else data(5) := '1'; end if;
         wait until rising_edge(SCL);
         if SDA = '0' then data(4) := '0'; else data(4) := '1'; end if;
         wait until rising_edge(SCL);
         if SDA = '0' then data(3) := '0'; else data(3) := '1'; end if;
         wait until rising_edge(SCL);
         if SDA = '0' then data(2) := '0'; else data(2) := '1'; end if;
         wait until rising_edge(SCL);
         if SDA = '0' then data(1) := '0'; else data(1) := '1'; end if;
         wait until rising_edge(SCL);
         if SDA = '0' then data(0) := '0'; else data(0) := '1'; end if;
       wait until falling_edge(SCL);
       assert false
       report "**** Acknowledging Data on I2C bus ****" 
       severity NOTE;   
       SDA <= '0';
       wait until falling_edge(SCL);
       SDA <= 'Z';
       assert false
       report "**** I2C Simulated Slave Received Write to Address = 0x" & px_std_logic_vector_to_hstring(addr) & "  Data Received = 0x" & px_std_logic_vector_to_hstring(data) & " ****" 
       severity NOTE;
     else -- Read
       data := x"A5";
       if data(7) = '0' then SDA <= '0'; else SDA <= 'Z'; end if;
       wait until falling_edge(SCL); 
       if data(6) = '0' then SDA <= '0'; else SDA <= 'Z'; end if;
       wait until falling_edge(SCL); 
       if data(5) = '0' then SDA <= '0'; else SDA <= 'Z'; end if;
       wait until falling_edge(SCL); 
       if data(4) = '0' then SDA <= '0'; else SDA <= 'Z'; end if;
       wait until falling_edge(SCL); 
       if data(3) = '0' then SDA <= '0'; else SDA <= 'Z'; end if;
       wait until falling_edge(SCL); 
       if data(2) = '0' then SDA <= '0'; else SDA <= 'Z'; end if;
       wait until falling_edge(SCL); 
       if data(1) = '0' then SDA <= '0'; else SDA <= 'Z'; end if;
       wait until falling_edge(SCL); 
       if data(0) = '0' then SDA <= '0'; else SDA <= 'Z'; end if; 
       wait until falling_edge(SCL);      
     end if;
  end loop;   
     wait;            
end process;


end Behavioral;