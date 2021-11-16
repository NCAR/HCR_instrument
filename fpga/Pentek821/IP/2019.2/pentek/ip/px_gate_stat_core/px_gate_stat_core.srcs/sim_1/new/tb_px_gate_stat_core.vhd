----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/13/2018 02:52:12 PM
-- Design Name: 
-- Module Name: tb_px_gate_stat_core - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.1 - Added simulation support for additional modes
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.px_utility_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_gate_stat_core is
--  Port ( );
end tb_px_gate_stat_core;

architecture Behavioral of tb_px_gate_stat_core is

-- 0 for 16 bit
-- 1 for 8 bit
signal bit_mode                : std_logic := '1';

constant Data_width            : integer := 128;
constant data_format           : std_logic_vector(1 downto 0) := "01";
constant data_type             : std_logic                    := '1';
constant channel               : std_logic_vector(7 downto 0) := "00000001";
signal   tkeep_last_test       : std_logic_vector((Data_width / 16) - 1 downto 0) := (others => '1'); 
              
constant axis_ppkt_aclk_half_p : time := 1.11 ns;
constant s_axi_csr_aclk_half_p : time := 2 ns;

signal axis_ppkt_aclk      : std_logic := '0';
signal axis_ppkt_aresetn   : std_logic := '0';
signal s_axis_ppkt_tdata   : std_logic_vector(Data_width - 1 downto 0) := (others => '0');
signal s_axis_ppkt_tkeep   : std_logic_vector((Data_width / 16) - 1 downto 0) := (others => '0');
signal s_axis_ppkt_tlast   : std_logic := '0';
signal s_axis_ppkt_tuser   : std_logic_vector(79 downto 0) := (others => '0');
signal s_axis_ppkt_tvalid  : std_logic;
signal s_axis_ppkt_tdata_reg   : std_logic_vector(Data_width - 1 downto 0) := (others => '0');
signal s_axis_ppkt_tkeep_reg   : std_logic_vector((Data_width / 16) - 1 downto 0) := (others => '0');
signal s_axis_ppkt_tlast_reg   : std_logic := '0';
signal s_axis_ppkt_tuser_reg   : std_logic_vector(79 downto 0) := (others => '0');
signal s_axis_ppkt_tvalid_reg  : std_logic;

signal m_axis_gate_stat_tdata   : std_logic_vector(Data_width - 1 downto 0);
signal m_axis_gate_stat_tkeep   : std_logic_vector((Data_width / 16) - 1 downto 0);
signal m_axis_gate_stat_tlast   : std_logic;
signal m_axis_gate_stat_tuser   : std_logic_vector(79 downto 0);
signal m_axis_gate_stat_tvalid  : std_logic;

signal s_axi_csr_aclk    : STD_LOGIC := '0';
signal s_axi_csr_aresetn : STD_LOGIC := '0';
signal s_axi_csr_awaddr  : STD_LOGIC_VECTOR ( 6 downto 0 ) := (others => '0');
signal s_axi_csr_awprot  : STD_LOGIC_VECTOR ( 2 downto 0 ) := (others => '0');
signal s_axi_csr_awvalid : STD_LOGIC:= '0';
signal s_axi_csr_awready :  STD_LOGIC:= '0';
signal s_axi_csr_wdata   : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
signal s_axi_csr_wstrb   : STD_LOGIC_VECTOR ( 3 downto 0 ) := (others => '0');
signal s_axi_csr_wvalid  : STD_LOGIC:= '0';
signal s_axi_csr_wready  :  STD_LOGIC:= '0';
signal s_axi_csr_bresp   :  STD_LOGIC_VECTOR ( 1 downto 0 ) := (others => '0');
signal s_axi_csr_bvalid  :  STD_LOGIC:= '0';
signal s_axi_csr_bready  : STD_LOGIC:= '0';
signal s_axi_csr_araddr  : STD_LOGIC_VECTOR ( 6 downto 0 ) := (others => '0');
signal s_axi_csr_arprot  : STD_LOGIC_VECTOR ( 2 downto 0 ) := (others => '0');
signal s_axi_csr_arvalid : STD_LOGIC:= '0';
signal s_axi_csr_arready :  STD_LOGIC:= '0';
signal s_axi_csr_rdata   :  STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
signal s_axi_csr_rresp   :  STD_LOGIC_VECTOR ( 1 downto 0 ) := (others => '0');
signal s_axi_csr_rvalid  :  STD_LOGIC:= '0';
signal s_axi_csr_rready  : STD_LOGIC:= '0';

signal rate                : std_logic := '0'; 

signal gate                : std_logic := '0';
signal gate_t1             : std_logic := '0';
signal gate_t2             : std_logic := '0';
signal gate_t3             : std_logic := '0';
signal sof                 : std_logic := '0';
signal eof                 : std_logic := '0';

signal time_stamp          : std_logic_vector(63 downto 0)  := X"000000000000000A"; --X"1000100010001000";
signal data_counter        : std_logic_vector(Data_width - 1 downto 0) := (others => '0');

signal gate_count          : integer := 0;

signal end_tb              : std_logic := '0';
signal end_tb_reg          : std_logic := '0';

component px_gate_stat_core 
generic (
  
    Data_width          : integer := 128
);
Port 
( 
    axis_ppkt_aclk      : in std_logic;
    axis_ppkt_aresetn   : in std_logic;
    s_axis_ppkt_tdata   : in std_logic_vector(Data_width - 1 downto 0);
    s_axis_ppkt_tkeep   : in std_logic_vector((Data_width / 16) - 1 downto 0);
    s_axis_ppkt_tlast   : in std_logic;
    s_axis_ppkt_tuser   : in std_logic_vector(79 downto 0);
    s_axis_ppkt_tvalid  : in std_logic;
    
    m_axis_ppkt_tdata   : out std_logic_vector(Data_width - 1 downto 0);
    m_axis_ppkt_tkeep   : out std_logic_vector((Data_width / 16) - 1 downto 0);
    m_axis_ppkt_tlast   : out std_logic;
    m_axis_ppkt_tuser   : out std_logic_vector(79 downto 0);
    m_axis_ppkt_tvalid  : out std_logic;
    
    m_axis_gate_stat_tdata   : out std_logic_vector(Data_width - 1 downto 0);
    m_axis_gate_stat_tkeep   : out std_logic_vector((Data_width / 16) - 1 downto 0);
    m_axis_gate_stat_tlast   : out std_logic;
    m_axis_gate_stat_tuser   : out std_logic_vector(79 downto 0);
    m_axis_gate_stat_tvalid  : out std_logic;
    
    s_axi_csr_aclk           : in STD_LOGIC;
    s_axi_csr_aresetn        : in STD_LOGIC;
    s_axi_csr_awaddr         : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_awprot         : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_awvalid        : in STD_LOGIC;
    s_axi_csr_awready        : out STD_LOGIC;
    s_axi_csr_wdata          : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_wstrb          : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_csr_wvalid         : in STD_LOGIC;
    s_axi_csr_wready         : out STD_LOGIC;
    s_axi_csr_bresp          : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_bvalid         : out STD_LOGIC;
    s_axi_csr_bready         : in STD_LOGIC;
    s_axi_csr_araddr         : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_arprot         : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_arvalid        : in STD_LOGIC;
    s_axi_csr_arready        : out STD_LOGIC;
    s_axi_csr_rdata          : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_rresp          : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_rvalid         : out STD_LOGIC;
    s_axi_csr_rready         : in STD_LOGIC 
);
end component;
  
begin

axis_ppkt_aresetn <= '1' after 1000 ns;
axis_ppkt_aclk    <= not axis_ppkt_aclk after axis_ppkt_aclk_half_p;
gate              <= not gate after 8192 ns;
          
s_axi_csr_aclk    <= not s_axi_csr_aclk after s_axi_csr_aclk_half_p; 
s_axi_csr_aresetn <= '1' after 1000 ns;

end_tb            <= '1' when gate_count = 10;


                      


process(axis_ppkt_aclk) begin

    if(rising_edge(axis_ppkt_aclk)) then
    
        end_tb_reg <= end_tb;
        
        
        if(rate = '1') then
            gate_t1 <= gate;
            gate_t2 <= gate_t1;
            gate_t3 <= gate_t2;
        
            sof     <= gate_t2 and not gate_t3;
            eof     <= not gate_t1 and gate_t2;
        end if;

        if(end_tb_reg = '0') then
            if(axis_ppkt_aresetn = '0') then
                time_stamp <= X"000000000000000A";
            else
                time_stamp <= time_stamp + '1';
            end if;
            
            if(bit_mode = '0') then
                rate <= '1';   
            else
                rate <= not rate;
            end if;
            
            s_axis_ppkt_tdata <= data_counter;
            s_axis_ppkt_tlast <= '0';
            
            s_axis_ppkt_tuser <= "0000" & channel & data_type & data_format & sof & time_stamp;
            
            if(bit_mode = '0') then
                s_axis_ppkt_tvalid <= gate;
                data_counter <= data_counter + '1';
                
            else
                if(gate_t3 = '1') then
                    if(s_axis_ppkt_tvalid = '0') then
                        s_axis_ppkt_tvalid <= '1';
                        data_counter <= data_counter + '1';
                        
                    else
                        s_axis_ppkt_tvalid <= '0';
                    end if;
                else
                    s_axis_ppkt_tvalid <= '0';
                end if;
            end if;
            
            s_axis_ppkt_tlast <= eof;
            
            
            s_axis_ppkt_tdata_reg   <= s_axis_ppkt_tdata;
            s_axis_ppkt_tkeep_reg   <= s_axis_ppkt_tkeep;
            s_axis_ppkt_tlast_reg   <= s_axis_ppkt_tlast;
            s_axis_ppkt_tuser_reg   <= s_axis_ppkt_tuser;
            s_axis_ppkt_tvalid_reg  <= s_axis_ppkt_tvalid;
        else
            s_axis_ppkt_tdata_reg   <= (others => '0');
            s_axis_ppkt_tkeep_reg   <= (others => '0');
            s_axis_ppkt_tlast_reg   <= '0';
            s_axis_ppkt_tuser_reg   <= (others => '0');
            s_axis_ppkt_tvalid_reg  <= '0';
            s_axis_ppkt_tvalid      <= '0';
        end if;
        
    end if;

end process;

process(gate) begin
    if(falling_edge(gate)) then
        gate_count <= gate_count + 1;
    end if;
end process;    
    
process begin
    wait until rising_edge(end_tb_reg);
    wait for 30 us;
        px_axi_lite_writer("0000000", X"00000002", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
        px_axi_lite_writer("0000000", X"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
end process;

--test all tkeep scenarios
process(axis_ppkt_aclk) begin

    if(rising_edge(axis_ppkt_aclk)) then
        if(s_axis_ppkt_tlast_reg = '1') then
            if(tkeep_last_test = 1) then
               tkeep_last_test <= (others => '1'); 
            else
               tkeep_last_test((Data_width / 16) - 1)          <= '0';
               tkeep_last_test((Data_width / 16) - 2 downto 0) <= tkeep_last_test((Data_width / 16) - 1 downto 1);  
            end if;
        end if;
    end if;

end process;

tkeep: for I in 0 to (Data_width / 16) - 1 generate 
    process(axis_ppkt_aclk) begin
        if(rising_edge(axis_ppkt_aclk)) then
            s_axis_ppkt_tkeep(i) <= tkeep_last_test(i) and gate;                                 
        end if;
    end process;
end generate;


dut: px_gate_stat_core 
generic map
(
  
    Data_width          => Data_width
)
Port map 
( 
    axis_ppkt_aclk      => axis_ppkt_aclk,
    axis_ppkt_aresetn   => axis_ppkt_aresetn,
    s_axis_ppkt_tdata   => s_axis_ppkt_tdata_reg,
    s_axis_ppkt_tkeep   => s_axis_ppkt_tkeep_reg,
    s_axis_ppkt_tlast   => s_axis_ppkt_tlast_reg,
    s_axis_ppkt_tuser   => s_axis_ppkt_tuser_reg,
    s_axis_ppkt_tvalid  => s_axis_ppkt_tvalid_reg,
    
    
    m_axis_ppkt_tdata   => open,
    m_axis_ppkt_tkeep   => open,
    m_axis_ppkt_tlast   => open,
    m_axis_ppkt_tuser   => open,
    m_axis_ppkt_tvalid  => open,
    
    m_axis_gate_stat_tdata  => m_axis_gate_stat_tdata,   
    m_axis_gate_stat_tkeep  => m_axis_gate_stat_tkeep,   
    m_axis_gate_stat_tlast  => m_axis_gate_stat_tlast,   
    m_axis_gate_stat_tuser  => m_axis_gate_stat_tuser,   
    m_axis_gate_stat_tvalid => m_axis_gate_stat_tvalid,
    
    s_axi_csr_aclk           => s_axi_csr_aclk,   
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
    s_axi_csr_rready         => s_axi_csr_rready 
);


end Behavioral;
