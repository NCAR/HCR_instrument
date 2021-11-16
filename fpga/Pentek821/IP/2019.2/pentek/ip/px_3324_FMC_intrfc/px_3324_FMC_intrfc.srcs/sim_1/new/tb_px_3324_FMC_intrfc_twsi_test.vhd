----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/10/2018 10:21 AM
-- Design Name: 
-- Module Name: tb_px_3324_FMC_intrfc_twsi_test - Behavioral
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

library UNISIM;
use UNISIM.VComponents.all;

entity tb_px_3324_FMC_intrfc_twsi_test is
generic (
   twsi_address         : std_logic_vector(6 downto 0) := "1010000"
);
end tb_px_3324_FMC_intrfc_twsi_test;

architecture Behavioral of tb_px_3324_FMC_intrfc_twsi_test is

--------------------------------------------------------------------------------
-- Component
--------------------------------------------------------------------------------

component px_3324_FMC_intrfc_top
port (
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   --------------------------------------------------------------------------------
   s_axi_csr_aclk          : in  std_logic;                         
   s_axi_csr_araddr        : in  std_logic_vector ( 6 downto 0 );
   s_axi_csr_aresetn       : in  std_logic;
   s_axi_csr_arprot        : in  std_logic_vector ( 2 downto 0 );
   s_axi_csr_arready       : out std_logic;
   s_axi_csr_arvalid       : in  std_logic;
   s_axi_csr_awaddr        : in  std_logic_vector ( 6 downto 0 );
   s_axi_csr_awprot        : in  std_logic_vector ( 2 downto 0 );
   s_axi_csr_awready       : out std_logic;
   s_axi_csr_awvalid       : in  std_logic;
   s_axi_csr_bready        : in  std_logic;
   s_axi_csr_bresp         : out std_logic_vector ( 1 downto 0 );
   s_axi_csr_bvalid        : out std_logic;
   s_axi_csr_rdata         : out std_logic_vector ( 31 downto 0 );
   s_axi_csr_rready        : in  std_logic;
   s_axi_csr_rresp         : out std_logic_vector ( 1 downto 0 );
   s_axi_csr_rvalid        : out std_logic;
   s_axi_csr_wdata         : in  std_logic_vector ( 31 downto 0 );
   s_axi_csr_wready        : out std_logic;
   s_axi_csr_wstrb         : in  std_logic_vector ( 3 downto 0 );
   s_axi_csr_wvalid        : in  std_logic;
 
   --------------------------------------------------------------------------------
   -- System Level Clock and Reset  
   --------------------------------------------------------------------------------
   PCIE_CLK                : in  std_logic;
   LRST_N                  : in  std_logic;

   ----------------------------------------------------------------------------
   -- TWSI Serial Bus
   ----------------------------------------------------------------------------
   TWSI_SDA                : inout std_logic;
   TWSI_SCL                : inout std_logic;
   
   TRNS_DONE_INT           : out std_logic;  -- Transfer Done Interrupt
   NO_ACK_INT              : out std_logic;  -- No Acknowledge Interrupt

   
   -----------------------------------------------------------------------------
   -- SPI  Serial Bus
   -----------------------------------------------------------------------------
   SDIO                    : inout std_logic;
   SDENB                   : out std_logic_vector(4 downto 0);
   SCLK                    : out std_logic;
   SDO                     : in  std_logic_vector(4 downto 0);
   
   ----------------------------------------------------------------------------
   -- LMK04828B Control and Status
   ----------------------------------------------------------------------------
   INT_REF_SEL             : out std_logic;
   JESD_RESET_GPO          : out std_logic;
   PLL1_CLKIN_SEL0         : out std_logic;
   PLL1_CLKIN_SEL1         : out std_logic;
   PLL1_REF_ENAB           : out std_logic;
   PLL2_REF_ENAB           : out std_logic;
   GATE_B_SEL              : out std_logic;
   SYSREF_SYNC             : out std_logic;
   STATUS_LD1              : in std_logic;
   STATUS_LD2              : in std_logic
 );
end component;


signal   s_axi_csr_aclk     :  std_logic := '0';                         
signal   s_axi_csr_araddr   :  std_logic_vector ( 6 downto 0 ) := (others => '0');
signal   s_axi_csr_aresetn  :  std_logic := '0';
signal   s_axi_csr_arprot   :  std_logic_vector ( 2 downto 0 ) := (others => '0');
signal   s_axi_csr_arready  :  std_logic;
signal   s_axi_csr_arvalid  :  std_logic := '0';
signal   s_axi_csr_awaddr   :  std_logic_vector ( 6 downto 0 ) := (others => '0');
signal   s_axi_csr_awprot   :  std_logic_vector ( 2 downto 0 ) := (others => '0');
signal   s_axi_csr_awready  :  std_logic;
signal   s_axi_csr_awvalid  :  std_logic := '0';
signal   s_axi_csr_bready   :  std_logic := '0';
signal   s_axi_csr_bresp    :  std_logic_vector ( 1 downto 0 );
signal   s_axi_csr_bvalid   :  std_logic;
signal   s_axi_csr_rdata    :  std_logic_vector ( 31 downto 0 );
signal   s_axi_csr_rready   :  std_logic := '0';
signal   s_axi_csr_rresp    :  std_logic_vector ( 1 downto 0 );
signal   s_axi_csr_rvalid   :  std_logic;
signal   s_axi_csr_wdata    :  std_logic_vector ( 31 downto 0 ) := (others => '0');
signal   s_axi_csr_wready   :  std_logic;
signal   s_axi_csr_wstrb    :  std_logic_vector ( 3 downto 0 ) := (others => '0');
signal   s_axi_csr_wvalid   :  std_logic := '0';
signal   PCIE_CLK           :  std_logic := '0';
signal   LRST_N             :  std_logic := '0';
signal   TWSI_SDA           :  std_logic := 'Z';
signal   TWSI_SCL           :  std_logic := 'Z';   
signal   TRNS_DONE_INT      :  std_logic;  -- Transfer Done Interrupt
signal   NO_ACK_INT         :  std_logic;  -- No Acknowledge Interrupt
signal   SDIO               :  std_logic;
signal   SDENB              :  std_logic_vector(4 downto 0);
signal   SCLK               :  std_logic;
signal   SDO                :  std_logic_vector(4 downto 0) := (others => '0');
signal   INT_REF_SEL        :  std_logic;
signal   JESD_RESET_GPO     :  std_logic;
signal   PLL1_CLKIN_SEL0    :  std_logic;
signal   PLL1_CLKIN_SEL1    :  std_logic;
signal   PLL1_REF_ENAB      :  std_logic;
signal   PLL2_REF_ENAB      :  std_logic;
signal   GATE_B_SEL         :  std_logic;
signal   SYSREF_SYNC        :  std_logic;
signal   STATUS_LD1         :  std_logic := '0';
signal   STATUS_LD2         :  std_logic := '0';
signal   tx_data            :  std_logic_vector(31 downto 0) := (others => '0');
signal   rx_data            :  std_logic_vector(31 downto 0) := (others => '0');

--------------------------------------------------------------------------------   
-- Constants
--------------------------------------------------------------------------------
-- Control/Status Register Addresses
constant START_REG_ADDR          : std_logic_vector(6 downto 0) := "0010100";  -- 0x14
constant CONTROL_REG_ADDR        : std_logic_vector(6 downto 0) := "0001100";  -- 0x0C
constant STATUS_REG_ADDR         : std_logic_vector(6 downto 0) := "0100100";  -- 0x24 
constant WRITE_DATA_ADDR         : std_logic_vector(6 downto 0) := "0010000";  -- 0x10
constant READ_DATA_ADDR          : std_logic_vector(6 downto 0) := "0101000";  -- 0x28

-- Define 1/2 Clock Period
constant clk_in_half_p      : time := 2.0 ns;

--------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--          ******************* Normal Testbench Runtime: 620656 ns *******************                           --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                        Testbench Set-up                                                        --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Pull TWSI I/O Ports UP to mimic system
--------------------------------------------------------------------------------

twsi_scl_PULLUP_inst : PULLUP
port map (
   O => TWSI_SCL  -- 1-bit output: Pullup output (connect directly to top-level port)
);

twsi_sda_PULLUP_inst : PULLUP
port map (
   O => TWSI_SDA  -- 1-bit output: Pullup output (connect directly to top-level port)
);

--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------

-- PCIE_clk - 250MHz
process
begin
    loop
        PCIE_clk <= not PCIE_clk;
        wait for clk_in_half_p;
    end loop;
end process;

-- s_axi_csr_aclk 250MHz
process
begin
   loop
      s_axi_csr_aclk <= not s_axi_csr_aclk;
      wait for clk_in_half_p;
   end loop;
end process;

TWSI_TEST : process
begin
   wait for 100 ns;
   LRST_N <= '1';
   wait for 200 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   wait for 200 ns;
   wait until rising_edge(s_axi_csr_aclk);
   wait until rising_edge(s_axi_csr_aclk);
   
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                           TWSI Write Data Test                                                 --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

    assert false   
    report ">>>>>>>>>>>>>> Setting Control Register for Write of One Byte to address 0x"  & px_std_logic_vector_to_hstring(twsi_address) & "."   
    severity NOTE;
    -- Set up the Control Register (0x0C) for Write of 1 byte
    -- Set R/W bit to '0', Enable bit to '1', Number Bytes to x"0" (1-1))
    px_axi_lite_writer(
        CONTROL_REG_ADDR,
        (x"0000" & '0' & twsi_address & "00" & '0' & '1' & "0000" ), 
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
          
    -- Set the desired value for the TWSI Data Transmit:    
    tx_data <= x"000000C5";
    wait for 100 ns;

    assert false   
    report ">>>>>>>>>>>>>> Writing the value 0x" & px_std_logic_vector_to_hstring(tx_data) & " to the Data Transmit FIFO (Data to transmit over TWSI)."   
    severity NOTE;
    -- Write a data value of 0x81 to the Data Transmit FIFO (0x10) (Data to transmit over TWSI)   
    px_axi_lite_writer(
        WRITE_DATA_ADDR,
        (tx_data), 
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
    report ">>>>>>>>>>>>>> Toggling the Start Transaction Control Bit."   
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
    report ">>>>>>>>>>>>>> Checking the TWSI Status Register (TWSI Write Check)..."   
    severity NOTE;     
        
    px_axi_lite_reader(
        STATUS_REG_ADDR,
        x"00000023", 
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
             
    if (s_axi_csr_rdata /= x"00000023") then
       assert false
       report "!!!!!!!!!!!!!!!!! TWSI WRITE STATUS REGISTER CHECK FAILED!!  Expected Data = 0x00000023; Actual Data Receiveded = 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."
       severity FAILURE;
    else
       assert false
       report ">>>>>>>>>>>>>>**** TWSI Write Status Register Check Succeeded." 
       severity NOTE;
    end if;
       
    assert false   
    report ">>>>>>>>>>>>>> Waiting for Transaction Done Interrupt..."   
    severity NOTE;     
    -- Wait for Transaction Done Interrupt     
    wait until (TRNS_DONE_INT = '1');
    wait until (TRNS_DONE_INT = '0');
    assert false   
    report ">>>>>>>>>>>>>> Transaction Done Interrupt was Received."   
    severity NOTE;  

    assert false   
    report ">>>>>>>>>>>>>> Setting Control Register to Disable TWSI."   
    severity NOTE;
    -- Set up the Control Register (0x0C) for Write of 1 byte
    -- Set R/W bit to '0', Enable bit to '1', Number Bytes to x"0" (1-1))
    px_axi_lite_writer(
        CONTROL_REG_ADDR,
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
        
    wait for 100 us;
   
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                       End of TWSI Write Data Test                                              --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                         TWSI Read Data Test                                                    --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
  
    assert false   
    report ">>>>>>>>>>>>>> Setting Control Register for Read of One Byte."   
    severity NOTE;
    -- Set up the Control Register (0x0C) for Write of 1 byte
    -- Set R/W bit to '0', Enable bit to '1', Number Bytes to x"0" (1-1))
    px_axi_lite_writer(
        CONTROL_REG_ADDR,
        (x"0000" & '0' & twsi_address & "00" & '1' & '1' & "0000" ), 
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
    -- Set the desired value for the TWSI Data Read:    
    rx_data <= x"000000B4";
    wait for 100 ns;

        assert false                                      
    report ">>>>>>>>>>>>>> Toggling the Start Transaction Control Bit."
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
    report ">>>>>>>>>>>>>> Waiting for Transaction Done Interrupt..."  
    severity NOTE;
    
    -- Wait for Transaction Done Interrupt              
    wait until (TRNS_DONE_INT = '1');                             
    wait until (TRNS_DONE_INT = '0');                             
    assert false                                        
    report ">>>>>>>>>>>>>> Transaction Done Interrupt was Received. Read Complete."   
    severity NOTE;                                      
    
    assert false   
    report ">>>>>>>>>>>>>> Reading the Data Receive FIFO."   
    severity NOTE;
    -- Read data value from the Data Receive FIFO (0x28) (Data received over TWSI)   
    px_axi_lite_reader(
        READ_DATA_ADDR,
        rx_data, 
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
             
    if (s_axi_csr_rdata /= rx_data) then
       assert false
       report "!!!!!!!!!!!!!!!!! TWSI READ FAILED!!  Expected Data = 0x" & px_std_logic_vector_to_hstring(rx_data) & "; Actual Data Receiveded = 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."
       severity FAILURE;
    else
       assert false
       report ">>>>>>>>>>>>>>**** TWSI Data Received at Address = 0x" & px_std_logic_vector_to_hstring(READ_DATA_ADDR) & "  Data Received = 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & " ****" 
       severity NOTE;
       assert false
       report ">>>>>>>>>>>>>>**** TWSI Read Succeeded:" 
       severity NOTE;
    end if;
    
    wait for 1us;
    assert false   
    report ">>>>>>>>>>>>>> Checking the TWSI Status Register (TWSI Read Check)..."   
    severity NOTE;     
        
    px_axi_lite_reader(
        STATUS_REG_ADDR,
        x"00000102", 
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
             
    if (s_axi_csr_rdata /= x"00000022") then
       assert false
       report "!!!!!!!!!!!!!!!!! TWSI READ STATUS REGISTER CHECK FAILED!!  Expected Data = 0x00000022; Actual Data Receiveded = 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."
       severity FAILURE;
    else
       assert false
       report ">>>>>>>>>>>>>>**** TWSI Read Status Register Check Succeeded." 
       severity NOTE;
    end if;

    wait for 1us;
        
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                       End of TWSI Read Data Test                                               --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
   
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                      End of Tests - Report Status                                              --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
    
    assert false
    report ">>>>>>>>>>>>>>******* NOT A FAILURE: All TWSI Tests Completed with No Errors. Time = " & time'image(now)
    severity FAILURE;
--    severity NOTE;
   
end process;

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                            Parallel Processes                                                  --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                     Verify TWSI Write Data Test Data                                           --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

receive_twsi: process
variable addr : std_logic_vector(6 downto 0) := "0000000";
variable wr   : std_logic := '0';
variable data : std_logic_vector(7 downto 0) := x"00";
variable t    : time;
variable period : time;
begin
   loop
      wait until ((TWSI_SDA = 'H') and (TWSI_SCL = 'H')); 
      wait until (TWSI_SDA = '0');       -- Start
      assert false
      report ">>>>>>>>>>>>>>**** Start Bit sensed on TWSI bus ****" 
      severity NOTE;
      wait until rising_edge(TWSI_SCL); 
      t := time(now);
      if TWSI_SDA = '0' then addr(6) := '0'; else addr(6) := '1'; end if;  -- Address MSB
      wait until rising_edge(TWSI_SCL); 
      period := (time(now) - t);
      assert false
      report ">>>>>>>>>>>>>>**** TWSI Clock Period = " &  time'image(period) & " ****" 
      severity NOTE;
      if TWSI_SDA = '0' then addr(5) := '0'; else addr(5) := '1'; end if;
      wait until rising_edge(TWSI_SCL); 
      if TWSI_SDA = '0' then addr(4) := '0'; else addr(4) := '1'; end if;
      wait until rising_edge(TWSI_SCL); 
      if TWSI_SDA = '0' then addr(3) := '0'; else addr(3) := '1'; end if;
      wait until rising_edge(TWSI_SCL); 
      if TWSI_SDA = '0' then addr(2) := '0'; else addr(2) := '1'; end if;
      wait until rising_edge(TWSI_SCL); 
      if TWSI_SDA = '0' then addr(1) := '0'; else addr(1) := '1'; end if;
      wait until rising_edge(TWSI_SCL); 
      if TWSI_SDA = '0' then addr(0) := '0'; else addr(0) := '1'; end if;   -- Address LSB
      wait until rising_edge(TWSI_SCL);  
      if TWSI_SDA = '0' then wr := '1'; else wr := '0'; end if; -- Read/Write Command
      if wr = '1' then    
         assert false
         report ">>>>>>>>>>>>>>**** Sensed Write Transaction on TWSI Bus ****" 
         severity NOTE;
      else
         assert false
         report ">>>>>>>>>>>>>> Sensed Read" 
         severity NOTE;
      end if;   
      wait until falling_edge(TWSI_SCL);
      assert false
      report ">>>>>>>>>>>>>>**** Acknowledging Address on TWSI bus ****" 
      severity NOTE;  
      TWSI_SDA <= '0';
      wait until falling_edge(TWSI_SCL);
      TWSI_SDA <= 'Z'; 
      if wr = '1' then -- write
         wait until rising_edge(TWSI_SCL);
         if TWSI_SDA = '0' then data(7) := '0'; else data(7) := '1'; end if;
         wait until rising_edge(TWSI_SCL);
         if TWSI_SDA = '0' then data(6) := '0'; else data(6) := '1'; end if;
         wait until rising_edge(TWSI_SCL);
         if TWSI_SDA = '0' then data(5) := '0'; else data(5) := '1'; end if;
         wait until rising_edge(TWSI_SCL);
         if TWSI_SDA = '0' then data(4) := '0'; else data(4) := '1'; end if;
         wait until rising_edge(TWSI_SCL);
         if TWSI_SDA = '0' then data(3) := '0'; else data(3) := '1'; end if;
         wait until rising_edge(TWSI_SCL);
         if TWSI_SDA = '0' then data(2) := '0'; else data(2) := '1'; end if;
         wait until rising_edge(TWSI_SCL);
         if TWSI_SDA = '0' then data(1) := '0'; else data(1) := '1'; end if;
         wait until rising_edge(TWSI_SCL);
         if TWSI_SDA = '0' then data(0) := '0'; else data(0) := '1'; end if;
       wait until falling_edge(TWSI_SCL);
       assert false
       report ">>>>>>>>>>>>>>**** Acknowledging Data on TWSI bus ****" 
       severity NOTE;   
       TWSI_SDA <= '0';
       wait until falling_edge(TWSI_SCL);
       TWSI_SDA <= 'Z';
       
       if (data /= tx_data(7 downto 0)) then
          assert false
          report "!!!!!!!!!!!!!!!!! TWSI WRITE FAILED!!  Data To Be Transmitted = 0x" & px_std_logic_vector_to_hstring(tx_data) & "; Actual Data Transmitted = 0x" & px_std_logic_vector_to_hstring(data) & "."
          severity FAILURE;
       else
          assert false
          report ">>>>>>>>>>>>>>**** TWSI Simulated Slave Received Write to Address = 0x" & px_std_logic_vector_to_hstring(addr) & "  Data Received = 0x" & px_std_logic_vector_to_hstring(data) & " ****" 
          severity NOTE;
          assert false
          report ">>>>>>>>>>>>>>**** TWSI Write Succeeded:" 
          severity NOTE;
       end if;

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                     Generate TWSI Read Test Data                                               --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

     else -- Read
--       data := x"A5";
       data := rx_data(7 downto 0);
       if data(7) = '0' then TWSI_SDA <= '0'; else TWSI_SDA <= 'Z'; end if;
       wait until falling_edge(TWSI_SCL); 
       if data(6) = '0' then TWSI_SDA <= '0'; else TWSI_SDA <= 'Z'; end if;
       wait until falling_edge(TWSI_SCL); 
       if data(5) = '0' then TWSI_SDA <= '0'; else TWSI_SDA <= 'Z'; end if;
       wait until falling_edge(TWSI_SCL); 
       if data(4) = '0' then TWSI_SDA <= '0'; else TWSI_SDA <= 'Z'; end if;
       wait until falling_edge(TWSI_SCL); 
       if data(3) = '0' then TWSI_SDA <= '0'; else TWSI_SDA <= 'Z'; end if;
       wait until falling_edge(TWSI_SCL); 
       if data(2) = '0' then TWSI_SDA <= '0'; else TWSI_SDA <= 'Z'; end if;
       wait until falling_edge(TWSI_SCL); 
       if data(1) = '0' then TWSI_SDA <= '0'; else TWSI_SDA <= 'Z'; end if;
       wait until falling_edge(TWSI_SCL); 
       if data(0) = '0' then TWSI_SDA <= '0'; else TWSI_SDA <= 'Z'; end if; 
       wait until falling_edge(TWSI_SCL);      
     end if;
  end loop;   
     wait;            
end process;
   
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                         --  End of tests --                                                    --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                 --  Core Under Test Instantiation --                                           --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


uut : px_3324_FMC_intrfc_top
   port map(
   s_axi_csr_aclk     =>   s_axi_csr_aclk,
   s_axi_csr_araddr   =>   s_axi_csr_araddr ,
   s_axi_csr_aresetn  =>   s_axi_csr_aresetn,
   s_axi_csr_arprot   =>   s_axi_csr_arprot,
   s_axi_csr_arready  =>   s_axi_csr_arready,
   s_axi_csr_arvalid  =>   s_axi_csr_arvalid,
   s_axi_csr_awaddr   =>   s_axi_csr_awaddr,
   s_axi_csr_awprot   =>   s_axi_csr_awprot,
   s_axi_csr_awready  =>   s_axi_csr_awready,
   s_axi_csr_awvalid  =>   s_axi_csr_awvalid,
   s_axi_csr_bready   =>   s_axi_csr_bready,
   s_axi_csr_bresp    =>   s_axi_csr_bresp,
   s_axi_csr_bvalid   =>   s_axi_csr_bvalid ,
   s_axi_csr_rdata    =>   s_axi_csr_rdata,
   s_axi_csr_rready   =>   s_axi_csr_rready,
   s_axi_csr_rresp    =>   s_axi_csr_rresp,
   s_axi_csr_rvalid   =>   s_axi_csr_rvalid,
   s_axi_csr_wdata    =>   s_axi_csr_wdata,
   s_axi_csr_wready   =>   s_axi_csr_wready,
   s_axi_csr_wstrb    =>   s_axi_csr_wstrb,
   s_axi_csr_wvalid   =>   s_axi_csr_wvalid,
   PCIE_CLK           =>   PCIE_CLK,
   LRST_N             =>   LRST_N,
   TWSI_SDA           =>   TWSI_SDA,
   TWSI_SCL           =>   TWSI_SCL,
   TRNS_DONE_INT      =>   TRNS_DONE_INT,
   NO_ACK_INT         =>   NO_ACK_INT,
   SDIO               =>   SDIO,
   SDENB              =>   SDENB,
   SCLK               =>   SCLK,
   SDO                =>   SDO,
   INT_REF_SEL        =>   INT_REF_SEL,
   JESD_RESET_GPO     =>   JESD_RESET_GPO,
   PLL1_CLKIN_SEL0    =>   PLL1_CLKIN_SEL0,
   PLL1_CLKIN_SEL1    =>   PLL1_CLKIN_SEL1,
   PLL1_REF_ENAB      =>   PLL1_REF_ENAB,
   PLL2_REF_ENAB      =>   PLL2_REF_ENAB,
   GATE_B_SEL         =>   GATE_B_SEL,
   SYSREF_SYNC        =>   SYSREF_SYNC,
   STATUS_LD1         =>   STATUS_LD1,
   STATUS_LD2         =>   STATUS_LD2
   );


end Behavioral;