----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/19/2019 06:51:06 PM
-- Design Name: 
-- Module Name: tb_px_pcie2axil_512 - Behavioral
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

entity tb_px_pcie2axil_512 is
generic (
   num_addr_bits         : integer := 32;
   bar0_size_bits        : integer := 16;
   bar0_addr_translation : std_logic_vector(31 downto 0) := x"00000000";
   bar1_size_bits        : integer := 16;
   bar1_addr_translation : std_logic_vector(31 downto 0) := x"00000000";
   bar2_size_bits        : integer := 16;
   bar2_addr_translation : std_logic_vector(31 downto 0) := x"20000000";
   bar3_size_bits        : integer := 16;
   bar3_addr_translation : std_logic_vector(31 downto 0) := x"20000000";
   bar4_size_bits        : integer := 16;
   bar4_addr_translation : std_logic_vector(31 downto 0) := x"40000000";
   bar5_size_bits        : integer := 16;
   bar5_addr_translation : std_logic_vector(31 downto 0) := x"50000000"    
   );
--  Port ( );
end tb_px_pcie2axil_512;

architecture Behavioral of tb_px_pcie2axil_512 is

component  px_pcie2axil_512 
generic (
   num_addr_bits         : integer := 32;
   bar0_size_bits        : integer := 16;
   bar0_addr_translation : std_logic_vector(31 downto 0) := x"00000000";
   bar1_size_bits        : integer := 16;
   bar1_addr_translation : std_logic_vector(31 downto 0) := x"00000000";
   bar2_size_bits        : integer := 16;
   bar2_addr_translation : std_logic_vector(31 downto 0) := x"20000000";
   bar3_size_bits        : integer := 16;
   bar3_addr_translation : std_logic_vector(31 downto 0) := x"20000000";
   bar4_size_bits        : integer := 16;
   bar4_addr_translation : std_logic_vector(31 downto 0) := x"40000000";
   bar5_size_bits        : integer := 16;
   bar5_addr_translation : std_logic_vector(31 downto 0) := x"50000000"    
   );
 port (
   user_clk                       : in  std_logic;
   user_reset                     : in  std_logic;
   user_lnk_up                    : in  std_logic; 
   aresetn                        : out std_logic; 
   -----------------------------------------------------------------------------
   -- PIO TX Engine
   -----------------------------------------------------------------------------
   -- AXI-S Completer Competion Interface
   m_axis_cc_tdata                : out std_logic_vector(511 downto 0);
   m_axis_cc_tkeep                : out std_logic_vector(15 downto 0);
   m_axis_cc_tlast                : out std_logic;
   m_axis_cc_tvalid               : out std_logic;
   m_axis_cc_tuser                : out std_logic_vector(80 downto 0);
   m_axis_cc_tready               : in  std_logic_vector(3 downto 0);
   -----------------------------------------------------------------------------
   -- PIO RX Engine
   -----------------------------------------------------------------------------
   -- Completer Request Interface
   s_axis_cq_tdata                : in  std_logic_vector(511 downto 0);
   s_axis_cq_tlast                : in  std_logic;
   s_axis_cq_tvalid               : in  std_logic;
   s_axis_cq_tuser                : in  std_logic_vector(182 downto 0);
   s_axis_cq_tkeep                : in  std_logic_vector(15 downto 0);
   s_axis_cq_tready               : out std_logic;
   --------------------------------------------------------------------------------
   -- AXI LITE Master Interface  
   -- DWORD Addressing
   ------------------------------------------------------------------------------
   m_axi_awaddr                   : out std_logic_vector(num_addr_bits-1 downto 0);
   m_axi_awprot                   : out std_logic_vector(2 downto 0); -- not used
   m_axi_awvalid                  : out std_logic;
   m_axi_awready                  : in  std_logic;
   m_axi_wdata                    : out std_logic_vector(31 downto 0);
   m_axi_wstrb                    : out std_logic_vector(3 downto 0); -- not used
   m_axi_wvalid                   : out std_logic;
   m_axi_wready                   : in  std_logic;
   m_axi_bresp                    : in  std_logic_vector(1 downto 0);
   m_axi_bvalid                   : in  std_logic;
   m_axi_bready                   : out std_logic;
   m_axi_araddr                   : out std_logic_vector(num_addr_bits-1 downto 0);
   m_axi_arprot                   : out std_logic_vector(2 downto 0); -- not used
   m_axi_arvalid                  : out std_logic;
   m_axi_arready                  : in  std_logic;
   m_axi_rdata                    : in  std_logic_vector(31 downto 0);
   m_axi_rvalid                   : in  std_logic;
   m_axi_rready                   : out std_logic;
   m_axi_rresp                    : in  std_logic_vector(1 downto 0);
   ----------------------------------------------------------------------------
   cc_shutdown_ok                 : out std_logic;
   cc_shutdown_rqst               : in  std_logic
   
  );
end component;

-- test registers
component px_axil_csr
generic (
   num_addr_bits     : integer := 7; -- Number of address bits 3-7 (Must agree with number of registers
   num_ctl_regs      : integer := 8; -- Number of Control Registers - 0 through 8
   num_stat_regs     : integer := 8; -- Number of Status Registers - 0 through 8
   num_interrupt_regs: integer := 1; -- Number of Interrupt Registers - 0 or 1
   num_interrupt_src : integer := 16 -- Number of Interrupt Source bits - 0 to 32 
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(num_addr_bits-1 downto 0);
   s_axi_csr_awprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid   : in  std_logic;
   s_axi_csr_awready   : out std_logic;
   s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0); -- not used
   s_axi_csr_wvalid    : in  std_logic;
   s_axi_csr_wready    : out std_logic;
   s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid    : out std_logic;
   s_axi_csr_bready    : in  std_logic;
   s_axi_csr_araddr    : in  std_logic_vector(num_addr_bits-1 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;
--------------------------------------------------------------------------------
-- Control Register Init Values
-------------------------------------------------------------------------------- 
   reg0_init_val   : in  std_logic_vector(31 downto 0);
   reg1_init_val   : in  std_logic_vector(31 downto 0);
   reg2_init_val   : in  std_logic_vector(31 downto 0);
   reg3_init_val   : in  std_logic_vector(31 downto 0);
   reg4_init_val   : in  std_logic_vector(31 downto 0);
   reg5_init_val   : in  std_logic_vector(31 downto 0);
   reg6_init_val   : in  std_logic_vector(31 downto 0);
   reg7_init_val   : in  std_logic_vector(31 downto 0);   
--------------------------------------------------------------------------------
-- Control Register Outputs
--------------------------------------------------------------------------------
   ctl0_out        : out std_logic_vector(31 downto 0);
   ctl1_out        : out std_logic_vector(31 downto 0);
   ctl2_out        : out std_logic_vector(31 downto 0);
   ctl3_out        : out std_logic_vector(31 downto 0);
   ctl4_out        : out std_logic_vector(31 downto 0);
   ctl5_out        : out std_logic_vector(31 downto 0);
   ctl6_out        : out std_logic_vector(31 downto 0);
   ctl7_out        : out std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------
-- Status Register Inputs
--------------------------------------------------------------------------------
   stat0_in        : in  std_logic_vector(31 downto 0);
   stat1_in        : in  std_logic_vector(31 downto 0);
   stat2_in        : in  std_logic_vector(31 downto 0);
   stat3_in        : in  std_logic_vector(31 downto 0);
   stat4_in        : in  std_logic_vector(31 downto 0);
   stat5_in        : in  std_logic_vector(31 downto 0);
   stat6_in        : in  std_logic_vector(31 downto 0);
   stat7_in        : in  std_logic_vector(31 downto 0);  
--------------------------------------------------------------------------------
-- Interrupt
--------------------------------------------------------------------------------
   intrpt_src_in   : in  std_logic_vector(num_interrupt_src-1 downto 0);        
   irq             : out std_logic
);
end component;
 
constant  AXIS_TDATA_WIDTH   : integer := 256;   
constant  S_AXI_TDATA_WIDTH  : integer := 32;   
constant  S_AXI_ADDR_WIDTH   : integer := 5;  
constant  M_AXI_TDATA_WIDTH  : integer := 32;
constant  M_AXI_ADDR_WIDTH   : integer := 32; 


signal    user_clk         : std_logic:= '0';
signal    user_reset       : std_logic:= '1';
signal    user_lnk_up      : std_logic; 
signal    aresetn          : std_logic; 
    
signal    s_axis_cq_tdata  : std_logic_vector(511 downto 0):= (others => '0');
signal    s_axis_cq_tuser  : std_logic_vector(182 downto 0):= (others => '0');
signal    s_axis_cq_tlast  : std_logic:= '0';
signal    s_axis_cq_tkeep  : std_logic_vector(15 downto 0):= (others => '0');
signal    s_axis_cq_tvalid : std_logic:= '0';
signal    s_axis_cq_tready : std_logic:= '0';
    
signal    m_axis_cc_tdata  : std_logic_vector(511 downto 0):= (others => '0');
signal    m_axis_cc_tuser  : std_logic_vector(80 downto 0);
signal    m_axis_cc_tlast  : std_logic:= '0';
signal    m_axis_cc_tkeep  : std_logic_vector(15 downto 0):= (others => '0');
signal    m_axis_cc_tvalid : std_logic:= '0';
signal    m_axis_cc_tready : std_logic_vector(3 downto 0):= (others => '1');
    
signal    m_axi_awaddr     : std_logic_vector(num_addr_bits-1 downto 0):= (others => '0');
signal    m_axi_awprot     : std_logic_vector(2 downto 0);
signal    m_axi_awvalid    : std_logic:= '0';
signal    m_axi_awready    : std_logic:= '0';
   
signal    m_axi_wdata      : std_logic_vector(31 downto 0):= (others => '0');
signal    m_axi_wstrb      : std_logic_vector(3 downto 0):= (others => '0');
signal    m_axi_wvalid     : std_logic:= '0';
signal    m_axi_wready     : std_logic:= '0';
    
signal    m_axi_bresp      : std_logic_vector(1 downto 0):= (others => '0');
signal    m_axi_bvalid     : std_logic:= '0';
signal    m_axi_bready     : std_logic:= '0';
  
signal    m_axi_araddr     : std_logic_vector(num_addr_bits-1 downto 0):= (others => '0');
signal    m_axi_arprot     : std_logic_vector(2 downto 0);
signal    m_axi_arvalid    : std_logic:= '0';
signal    m_axi_arready    : std_logic:= '0';
     
signal    m_axi_rdata      : std_logic_vector(31 downto 0):= (others => '0');
signal    m_axi_rresp      : std_logic_vector(1 downto 0);
signal    m_axi_rvalid     : std_logic:= '0';
signal    m_axi_rready     : std_logic:= '0';


--------------------------------------------------------------------------------
-- Control Register Outputs
--------------------------------------------------------------------------------

signal     cntl_reg0       : std_logic_vector(31 downto 0);
signal     cntl_reg1       : std_logic_vector(31 downto 0);
signal     cntl_reg2       : std_logic_vector(31 downto 0);
signal     cntl_reg3       : std_logic_vector(31 downto 0);
signal     cntl_reg4       : std_logic_vector(31 downto 0);
signal     cntl_reg5       : std_logic_vector(31 downto 0);
signal     cntl_reg6       : std_logic_vector(31 downto 0);
signal     cntl_reg7       : std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------
-- Status Register Inputs
--------------------------------------------------------------------------------    
signal     stat_reg0       : std_logic_vector(31 downto 0):= x"11111111";
signal     stat_reg1       : std_logic_vector(31 downto 0):= x"22222222";
signal     stat_reg2       : std_logic_vector(31 downto 0):= x"33333333";
signal     stat_reg3       : std_logic_vector(31 downto 0):= x"44444444";
signal     stat_reg4       : std_logic_vector(31 downto 0):= x"55555555";
signal     stat_reg5       : std_logic_vector(31 downto 0):= x"66666666";
signal     stat_reg6       : std_logic_vector(31 downto 0):= x"77777777";
signal     stat_reg7       : std_logic_vector(31 downto 0):= x"88888888"; -- Interrupt sources

signal     cc_shutdown_ok  :  std_logic;

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

procedure cq_request(
    constant addr         : in  std_logic_vector;
    constant val          : in  std_logic_vector(31 downto 0);
    constant wr           : in  std_logic;  
    signal user_clk       : in  std_logic;
    signal axis_cq_tdata  : out std_logic_vector(511 downto 0);
    signal axis_cq_tuser  : out std_logic_vector(182 downto 0) ; 
    signal axis_cq_tlast  : out std_logic;
    signal axis_cq_tkeep  : out std_logic_vector(15 downto 0);
    signal axis_cq_tvalid : out std_logic;
    signal axis_cq_tready : in  std_logic
    ) is
    begin
    axis_cq_tuser <= (others => '0');
    if wr = '1' then
        assert false
        report "Writing x" & (to_hstring(To_StdULogicVector(val))) & " to Address: x" &  (to_hstring(To_StdULogicVector(addr)))
        severity NOTE;
    else
        assert false
        report "Reading from Address: x" &  (to_hstring(To_StdULogicVector(addr)))
        severity NOTE;    
    end if;
        wait until rising_edge(user_clk);
        wait for 1 ns;
        axis_cq_tdata(511 downto 256) <= (others => '0');
        axis_cq_tdata(255 downto 0)  <= x"000000000000000000000000" & val & x"0000000000000" & wr & "000" & x"01" &  addr;
        axis_cq_tuser(80) <= '1';
        axis_cq_tuser(3 downto 0) <=  x"F";
        axis_cq_tlast        <= not wr;
        axis_cq_tkeep        <= x"01FF";
        axis_cq_tvalid       <= '1'; 
        if  (axis_cq_tready /= '1') then
            while (axis_cq_tready /= '1') loop
                wait until rising_edge(user_clk);
                wait for 1 ns;
            end loop;
            wait until rising_edge(user_clk);
            wait for 1 ns;
        else
            wait until rising_edge(user_clk);
            wait for 1 ns;
        end if;
        axis_cq_tvalid       <= '0';
        axis_cq_tlast        <= '0';
        axis_cq_tkeep        <= x"0000";
end;



begin

uut:px_pcie2axil_512 
generic map (
   num_addr_bits         => num_addr_bits,        
   bar0_size_bits        => bar0_size_bits,       
   bar0_addr_translation => bar0_addr_translation,
   bar1_size_bits        => bar1_size_bits,       
   bar1_addr_translation => bar1_addr_translation,
   bar2_size_bits        => bar2_size_bits,       
   bar2_addr_translation => bar2_addr_translation,
   bar3_size_bits        => bar3_size_bits,       
   bar3_addr_translation => bar3_addr_translation,
   bar4_size_bits        => bar4_size_bits,      
   bar4_addr_translation => bar4_addr_translation,
   bar5_size_bits        => bar5_size_bits,       
   bar5_addr_translation => bar5_addr_translation
   )
port map(
    user_clk         => user_clk,            
    user_reset       => user_reset,
    user_lnk_up      => '1',   
    aresetn          => aresetn,      
    s_axis_cq_tdata  => s_axis_cq_tdata,    
    s_axis_cq_tuser  => s_axis_cq_tuser,    
    s_axis_cq_tlast  => s_axis_cq_tlast,    
    s_axis_cq_tkeep  => s_axis_cq_tkeep,    
    s_axis_cq_tvalid => s_axis_cq_tvalid,   
    s_axis_cq_tready => s_axis_cq_tready,   
                    
    m_axis_cc_tdata  => m_axis_cc_tdata,    
    m_axis_cc_tuser  => m_axis_cc_tuser,    
    m_axis_cc_tlast  => m_axis_cc_tlast,    
    m_axis_cc_tkeep  => m_axis_cc_tkeep,    
    m_axis_cc_tvalid => m_axis_cc_tvalid,   
    m_axis_cc_tready => m_axis_cc_tready,   
                
    m_axi_awaddr     => m_axi_awaddr,       
    m_axi_awprot     => m_axi_awprot,       
    m_axi_awvalid    => m_axi_awvalid,      
    m_axi_awready    => m_axi_awready,     
                 
    m_axi_wdata      => m_axi_wdata,        
    m_axi_wstrb      => m_axi_wstrb,        
    m_axi_wvalid     => m_axi_wvalid,       
    m_axi_wready     => m_axi_wready,       
               
    m_axi_bresp      => m_axi_bresp,        
    m_axi_bvalid     => m_axi_bvalid,       
    m_axi_bready     => m_axi_bready,       
         
    m_axi_araddr     => m_axi_araddr,       
    m_axi_arprot     => m_axi_arprot,       
    m_axi_arvalid    => m_axi_arvalid,      
    m_axi_arready    => m_axi_arready,      
     
    m_axi_rdata      => m_axi_rdata,        
    m_axi_rresp      => m_axi_rresp,        
    m_axi_rvalid     => m_axi_rvalid,       
    m_axi_rready     => m_axi_rready,       

    cc_shutdown_ok  => cc_shutdown_ok,
    cc_shutdown_rqst=> '0'
  );

process
begin
    loop
        wait for 2 ns;
        user_clk <= not user_clk;
    end loop;    
end process;

process
begin
    wait for 100 ns;
    user_reset <= '0';
    wait until rising_edge(user_clk);
    wait until rising_edge(user_clk);
    wait until rising_edge(user_clk);
    wait until rising_edge(user_clk);
      -- Write
    cq_request(
        x"0000000000000000",            
        x"12345678",
        '1',
        user_clk,       
        s_axis_cq_tdata,   
        s_axis_cq_tuser,   
        s_axis_cq_tlast,   
        s_axis_cq_tkeep,   
        s_axis_cq_tvalid,  
        s_axis_cq_tready  
        );
     -- Read  
     cq_request(
        x"0000000000000000",            
        x"12345678",
        '0',
        user_clk,       
        s_axis_cq_tdata,   
        s_axis_cq_tuser,   
        s_axis_cq_tlast,   
        s_axis_cq_tkeep,   
        s_axis_cq_tvalid,  
        s_axis_cq_tready  
        );   
      -- Write
     cq_request(
        x"0000000000000004",            
        x"87654321",
        '1',
        user_clk,       
        s_axis_cq_tdata,   
        s_axis_cq_tuser,   
        s_axis_cq_tlast,   
        s_axis_cq_tkeep,   
        s_axis_cq_tvalid,  
        s_axis_cq_tready  
        );
      -- Write
      cq_request(
        x"0000000000000008",            
        x"a5a5a5a5",
        '1',
        user_clk,       
        s_axis_cq_tdata,   
        s_axis_cq_tuser,   
        s_axis_cq_tlast,   
        s_axis_cq_tkeep,   
        s_axis_cq_tvalid,  
        s_axis_cq_tready  
        );
      -- Read  
      cq_request(
        x"0000000000000020",            
        x"a5a5a5a5",
        '0',
        user_clk,       
        s_axis_cq_tdata,   
        s_axis_cq_tuser,   
        s_axis_cq_tlast,   
        s_axis_cq_tkeep,   
        s_axis_cq_tvalid,  
        s_axis_cq_tready  
        );
      -- Read  
      cq_request(
        x"0000000000000024",            
        x"a5a5a5a5",
        '0',
        user_clk,       
        s_axis_cq_tdata,   
        s_axis_cq_tuser,   
        s_axis_cq_tlast,   
        s_axis_cq_tkeep,   
        s_axis_cq_tvalid,  
        s_axis_cq_tready  
        );
    wait;
end process; 

-- Test Register Block
px_axil_csr_inst: px_axil_csr
generic map(
   num_addr_bits      => 6, -- Number of address bits 3-7 (Must agree with number of registers
   num_ctl_regs       => 8, -- Number of Control Registers - 0 through 8
   num_stat_regs      => 8, -- Number of Status Registers - 0 through 8
   num_interrupt_regs => 0, -- Number of Interrupt Registers - 0 or 1
   num_interrupt_src  => 16 -- Number of Interrupt Source bits - 0 to 32 
)
port map(
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk      => user_clk,                     
   s_axi_csr_aresetn   => aresetn,                 
   s_axi_csr_awaddr    => m_axi_awaddr(5 downto 0),    
   s_axi_csr_awprot    => m_axi_awprot,                
   s_axi_csr_awvalid   => m_axi_awvalid,               
   s_axi_csr_awready   => m_axi_awready,               
   s_axi_csr_wdata     => m_axi_wdata,                 
   s_axi_csr_wstrb     => m_axi_wstrb,                 
   s_axi_csr_wvalid    => m_axi_wvalid,                
   s_axi_csr_wready    => m_axi_wready,                
   s_axi_csr_bresp     => m_axi_bresp,                 
   s_axi_csr_bvalid    => m_axi_bvalid,                
   s_axi_csr_bready    => m_axi_bready,                
   s_axi_csr_araddr    => m_axi_araddr(5 downto 0),    
   s_axi_csr_arprot    => m_axi_arprot,                
   s_axi_csr_arvalid   => m_axi_arvalid,               
   s_axi_csr_arready   => m_axi_arready,               
   s_axi_csr_rdata     => m_axi_rdata,                 
   s_axi_csr_rresp     => m_axi_rresp,                 
   s_axi_csr_rvalid    => m_axi_rvalid,                
   s_axi_csr_rready    => m_axi_rready,                
--------------------------------------------------------------------------------
-- Control Register Init Values
-------------------------------------------------------------------------------- 
   reg0_init_val       => x"00000000",
   reg1_init_val       => x"00000000",       
   reg2_init_val       => x"00000000",       
   reg3_init_val       => x"00000000",       
   reg4_init_val       => x"00000000",       
   reg5_init_val       => x"00000000",       
   reg6_init_val       => x"00000000",       
   reg7_init_val       => x"00000000",       
--------------------------------------------------------------------------------
-- Control Register Outputs
--------------------------------------------------------------------------------
   ctl0_out            => cntl_reg0, 
   ctl1_out            => cntl_reg1, 
   ctl2_out            => cntl_reg2, 
   ctl3_out            => cntl_reg3, 
   ctl4_out            => cntl_reg4, 
   ctl5_out            => cntl_reg5, 
   ctl6_out            => cntl_reg6, 
   ctl7_out            => cntl_reg7,
--------------------------------------------------------------------------------
-- Status Register Inputs
--------------------------------------------------------------------------------
   stat0_in            => stat_reg0,
   stat1_in            => stat_reg1,
   stat2_in            => stat_reg2,
   stat3_in            => stat_reg3,
   stat4_in            => stat_reg4,
   stat5_in            => stat_reg5,
   stat6_in            => stat_reg6,
   stat7_in            => stat_reg7,
--------------------------------------------------------------------------------
-- Interrupt
--------------------------------------------------------------------------------
   intrpt_src_in       => x"0000",        
   irq                 => open
);



end Behavioral;
