----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/13/2018 10:35:15 AM
-- Design Name: 
-- Module Name: px_gate_stat_core - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.1 - Removed gate_re and replaced with tuser_reg3(64) and tvalid_reg3.
--                Fixed byte_counter logic to correctly clear to zero
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_gate_stat_core is
generic (
  
    Data_width          : integer := 16
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

    s_axi_csr_aclk    : in STD_LOGIC;
    s_axi_csr_aresetn : in STD_LOGIC;
    s_axi_csr_awaddr  : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_awprot  : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_awvalid : in STD_LOGIC;
    s_axi_csr_awready : out STD_LOGIC;
    s_axi_csr_wdata   : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_wstrb   : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_csr_wvalid  : in STD_LOGIC;
    s_axi_csr_wready  : out STD_LOGIC;
    s_axi_csr_bresp   : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_bvalid  : out STD_LOGIC;
    s_axi_csr_bready  : in STD_LOGIC;
    s_axi_csr_araddr  : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_arprot  : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_arvalid : in STD_LOGIC;
    s_axi_csr_arready : out STD_LOGIC;
    s_axi_csr_rdata   : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_rresp   : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_rvalid  : out STD_LOGIC;
    s_axi_csr_rready  : in STD_LOGIC

);
end px_gate_stat_core;

architecture Behavioral of px_gate_stat_core is

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_ppkt_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_ppkt_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_ppkt_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ppkt:m_axis_ppkt:m_axis_gate_stat";

constant bytes_per_clock : integer := Data_width/8;

signal s_axi_csr_aresetn_reg : std_logic := '0';

signal tvalid_reg1 : std_logic := '0';
signal tvalid_reg2 : std_logic := '0';
signal tvalid_reg3 : std_logic := '0';
signal tuser_reg1  : std_logic_vector(79 downto 0) := (others => '0');
signal tuser_reg2  : std_logic_vector(79 downto 0) := (others => '0');
signal tuser_reg3  : std_logic_vector(79 downto 0) := (others => '0');
signal gate_reg    : std_logic := '0';              
signal gate_reg2   : std_logic := '0'; 
signal gate_reg3   : std_logic := '0';
signal gate_re     : std_logic := '0';

signal tkeep_reg   : std_logic_vector((Data_width / 16) - 1 downto 0);
signal tlast_reg1  : std_logic := '0';
signal tlast_reg2  : std_logic := '0';
signal tlast_regx  : std_logic_vector(7 downto 0) := (others => '0');

signal time_stamp        : std_logic_vector(63 downto 0) := (others => '0');
signal data_format       : std_logic_vector(1 downto 0) := (others => '0');
signal data_type         : std_logic;
signal channel           : std_logic_vector(7 downto 0) := (others => '0'); 
signal gate_count        : std_logic_vector(31 downto 0) := (others => '0');

signal byte_count_rst     : std_logic := '0';
signal byte_counter       : std_logic_vector(31 downto 0) := (others => '0');
signal byte_counter_tlast : std_logic_vector(31 downto 0) := (others => '0');
signal byte_counter_final : std_logic_vector(31 downto 0) := (others => '0');

signal tlast_word_advance       : std_logic := '0';
signal tlast_word_advance_reg1  : std_logic := '0';
signal tlast_word_advance_reg2  : std_logic := '0';
signal tlast_word_advance_pulse : std_logic := '0';

signal m_axis_ppkt_tdata_out   : std_logic_vector(Data_width - 1 downto 0);
signal m_axis_ppkt_tkeep_out   : std_logic_vector((Data_width / 16) - 1 downto 0);
signal m_axis_ppkt_tlast_out   : std_logic;
signal m_axis_ppkt_tuser_out   : std_logic_vector(79 downto 0);
signal m_axis_ppkt_tvalid_out  : std_logic;

signal m_axis_gate_stat_tdata_out   : std_logic_vector(Data_width - 1 downto 0);
signal m_axis_gate_stat_tkeep_out   : std_logic_vector((Data_width / 16) - 1 downto 0);
signal m_axis_gate_stat_tlast_out   : std_logic;
signal m_axis_gate_stat_tuser_out   : std_logic_vector(79 downto 0);
signal m_axis_gate_stat_tvalid_out  : std_logic;

signal m_axis_output_mux       : std_logic_vector(3 downto 0);

signal reg0_init_val     : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
signal ctl0_out          : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');
signal ctl0_out_cdc      : STD_LOGIC_VECTOR ( 31 downto 0 ) := (others => '0');

signal time_stamp_cdc    : std_logic_vector(63 downto 0);
signal byte_count_cdc    : std_logic_vector(31 downto 0);
signal gate_count_cdc    : std_logic_vector(31 downto 0);

component px_axil_csr_0 
  Port ( 
    s_axi_csr_aclk : in STD_LOGIC;
    s_axi_csr_aresetn : in STD_LOGIC;
    s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_awvalid : in STD_LOGIC;
    s_axi_csr_awready : out STD_LOGIC;
    s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_csr_wvalid : in STD_LOGIC;
    s_axi_csr_wready : out STD_LOGIC;
    s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_bvalid : out STD_LOGIC;
    s_axi_csr_bready : in STD_LOGIC;
    s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_arvalid : in STD_LOGIC;
    s_axi_csr_arready : out STD_LOGIC;
    s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_rvalid : out STD_LOGIC;
    s_axi_csr_rready : in STD_LOGIC;
    reg0_init_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ctl0_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat2_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat3_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );

end component;

begin

process(s_axi_csr_aclk) begin

    if(rising_edge(s_axi_csr_aclk)) then
        s_axi_csr_aresetn_reg <= s_axi_csr_aresetn;
    end if;

end process;


process(axis_ppkt_aclk) begin
    
    if(rising_edge(axis_ppkt_aclk)) then
         
          -- pass through data
          m_axis_ppkt_tdata_out  <= s_axis_ppkt_tdata;
          m_axis_ppkt_tkeep_out  <= s_axis_ppkt_tkeep;
          m_axis_ppkt_tlast_out  <= s_axis_ppkt_tlast;
          m_axis_ppkt_tuser_out  <= s_axis_ppkt_tuser;
          m_axis_ppkt_tvalid_out <= s_axis_ppkt_tvalid;
    
          m_axis_ppkt_tdata  <=  m_axis_ppkt_tdata_out;
          m_axis_ppkt_tkeep  <=  m_axis_ppkt_tkeep_out;
          m_axis_ppkt_tlast  <=  m_axis_ppkt_tlast_out;
          m_axis_ppkt_tuser  <=  m_axis_ppkt_tuser_out;
          m_axis_ppkt_tvalid <=  m_axis_ppkt_tvalid_out;
          
          -- Gate stat data
          -- Send out last dummy data
          if(tlast_word_advance_pulse = '1') then
              m_axis_gate_stat_tdata  <= (others => '0'); 
              m_axis_gate_stat_tkeep  <= (others => '1'); 
              m_axis_gate_stat_tlast  <= '1'; 
              m_axis_gate_stat_tuser  <= (others => '0'); 
              m_axis_gate_stat_tvalid <= '1';
          else
              -- Gate stat data
              m_axis_gate_stat_tdata  <= m_axis_gate_stat_tdata_out; 
              m_axis_gate_stat_tkeep  <= m_axis_gate_stat_tkeep_out; 
              m_axis_gate_stat_tlast  <= m_axis_gate_stat_tlast_out; 
              m_axis_gate_stat_tuser  <= m_axis_gate_stat_tuser_out; 
              m_axis_gate_stat_tvalid <= m_axis_gate_stat_tvalid_out;
          end if;
    
        if(axis_ppkt_aresetn = '0' or byte_count_rst = '1') then
            tvalid_reg1  <= '0';
            tvalid_reg2  <= '0';
            tvalid_reg3  <= '0';
            tuser_reg1   <= (others => '0');
            tkeep_reg    <= (others => '0'); 
            byte_counter <= (others => '0');
            byte_counter_final <= (others => '0');
            
            data_format  <= (others => '0');
            data_type    <= '0';
            channel      <= (others => '0');
        else
            tvalid_reg1 <= s_axis_ppkt_tvalid;
            tvalid_reg2 <= tvalid_reg1;
            tvalid_reg3 <= tvalid_reg2;
            
            tuser_reg1  <= s_axis_ppkt_tuser;
            tuser_reg2  <= tuser_reg1; 
            tuser_reg3  <= tuser_reg2;
            
            -- Detect start of gate
            gate_re     <= tvalid_reg2 and not tvalid_reg3;
            
            tkeep_reg   <= s_axis_ppkt_tkeep;
            tlast_reg1  <= s_axis_ppkt_tlast;
            tlast_reg2  <= tlast_reg1;
            
            -- Create a tlast pulse indicating the end of gate
            tlast_regx(0)          <= tlast_reg2 and tvalid_reg2;
            tlast_regx(7 downto 1) <= tlast_regx(6 downto 0);
            
            -- Latch time stamp, data format, data type and channel present
            -- at the start of gate
            if(tuser_reg3(64) = '1' and tvalid_reg3 = '1') then
                time_stamp  <= tuser_reg3(63 downto 0);
                data_format <= tuser_reg3(66 downto 65);
                data_type   <= tuser_reg3(67);
                channel     <= tuser_reg3(75 downto 68);
            end if;
          
            -- Count the number of bytes when gate active.  Varies based on the number of
            -- samples per cycle this core is set to use
            if(s_axis_ppkt_tvalid = '1' and s_axis_ppkt_tuser(64) = '1') then
                byte_counter <= (others => '0');
            elsif(tvalid_reg1 = '1' and tlast_reg1 = '0') then
                byte_counter <= byte_counter + bytes_per_clock;
            end if;
              
            -- Final byte count based on the number of samples when tlast
            -- received
            if(tvalid_reg2 = '1' and tlast_reg2 = '1') then
                byte_counter_final <= byte_counter + byte_counter_tlast;
            end if;
            
        end if;
    end if;

end process;

-- When core is set for 16 bit width, 2 bytes per clock cycle
tlastbyte_2: if Data_width = 16 generate

    process(axis_ppkt_aclk) begin
        if(rising_edge(axis_ppkt_aclk)) then
            
            -- determines the last number of bytes when (end of gate/tlast received
            if(tvalid_reg1 = '1' and tlast_reg1 = '1') then
                case tkeep_reg is
                    when "1" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(2,32));
                    when "0" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(0,32));
                    when others =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(0,32));
                end case;
            end if;
            
            -- Pack gate statistics
            case tlast_regx is
             
                when "00000001" =>
                    m_axis_gate_stat_tdata_out  <= time_stamp(15 downto 0);  
                    m_axis_gate_stat_tkeep_out  <= "1";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                    
                when "00000010" =>
                    m_axis_gate_stat_tdata_out  <= time_stamp(31 downto 16);
                    m_axis_gate_stat_tkeep_out  <= "1";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                
                when "00000100" =>
                    m_axis_gate_stat_tdata_out  <= time_stamp(47 downto 32);  
                    m_axis_gate_stat_tkeep_out  <= "1";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                
                when "00001000" =>
                    m_axis_gate_stat_tdata_out  <= time_stamp(63 downto 48);   
                    m_axis_gate_stat_tkeep_out  <= "1";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                    
                ------------------------------------------------------    
                when "00010000" =>
                    m_axis_gate_stat_tdata_out  <= byte_counter_final(15 downto 0);   
                    m_axis_gate_stat_tkeep_out  <= "1";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                    
                when "00100000" =>
                    m_axis_gate_stat_tdata_out  <= byte_counter_final(31 downto 16);   
                    m_axis_gate_stat_tkeep_out  <= "1";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                    
                when "01000000" =>
                    m_axis_gate_stat_tdata_out  <= gate_count(15 downto 0);   
                    m_axis_gate_stat_tkeep_out  <= "1";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                    
                when "10000000" =>
                    m_axis_gate_stat_tdata_out  <= gate_count(31 downto 16);   
                    m_axis_gate_stat_tkeep_out  <= "1";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                    
                when "00000000" =>
                    m_axis_gate_stat_tdata_out  <= (others => '0');
                    m_axis_gate_stat_tkeep_out  <= (others => '0');
                    m_axis_gate_stat_tlast_out  <= '0';
                    m_axis_gate_stat_tuser_out  <= (others => '0');
                    m_axis_gate_stat_tvalid_out <= '0';
                    
                when others =>     
                    m_axis_gate_stat_tdata_out  <= (others => '0');
                    m_axis_gate_stat_tkeep_out  <= (others => '0');
                    m_axis_gate_stat_tlast_out  <= '0';
                    m_axis_gate_stat_tuser_out  <= (others => '0');
                    m_axis_gate_stat_tvalid_out <= '0';
                
            end case;
            
            -- Gate count number
            if(axis_ppkt_aresetn = '0' or byte_count_rst = '1') then
                gate_count <= (others => '0');
            elsif(tlast_regx(7) = '1') then
                gate_count <= gate_count + '1';
            end if;
            
        end if;    
    end process;

end generate tlastbyte_2;

-- When core is set for 16 bit width, 4 bytes per clock cycle
tlastbyte_4: if Data_width = 32 generate

    process(axis_ppkt_aclk) begin
        if(rising_edge(axis_ppkt_aclk)) then
            
            -- determines the last number of bytes when (end of gate/tlast received
            if(tvalid_reg1 = '1' and tlast_reg1 = '1') then
                case tkeep_reg is
                    when "11" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(4,32));
                    when "01" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(2,32));
                    when others =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(0,32));
                end case;
            end if;
            
            -- Pack gate statistics
            case tlast_regx(3 downto 0) is
                when "0001" => 
                    m_axis_gate_stat_tdata_out  <= time_stamp(31 downto 0);  
                    m_axis_gate_stat_tkeep_out  <= "11";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                    
                when "0010" =>
                    m_axis_gate_stat_tdata_out  <= time_stamp(63 downto 32);
                    m_axis_gate_stat_tkeep_out  <= "11";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                
                when "0100" =>
                    m_axis_gate_stat_tdata_out  <= byte_counter_final;  
                    m_axis_gate_stat_tkeep_out  <= "11";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                
                when "1000" =>
                    m_axis_gate_stat_tdata_out  <= gate_count;   
                    m_axis_gate_stat_tkeep_out  <= "11";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                    
                when "0000" =>
                    m_axis_gate_stat_tdata_out  <= (others => '0');
                    m_axis_gate_stat_tkeep_out  <= (others => '0');
                    m_axis_gate_stat_tlast_out  <= '0';
                    m_axis_gate_stat_tuser_out  <= (others => '0');
                    m_axis_gate_stat_tvalid_out <= '0';
                    
                when others => 
                    m_axis_gate_stat_tdata_out  <= (others => '0');
                    m_axis_gate_stat_tkeep_out  <= (others => '0');
                    m_axis_gate_stat_tlast_out  <= '0';
                    m_axis_gate_stat_tuser_out  <= (others => '0');
                    m_axis_gate_stat_tvalid_out <= '0';
            end case;
            
            if(axis_ppkt_aresetn = '0' or byte_count_rst = '1') then
                gate_count <= (others => '0');
            elsif(tlast_regx(3) = '1') then
                gate_count <= gate_count + '1';
            end if; 
        end if;    
    end process;

end generate tlastbyte_4;

-- When core is set for 64 bit width, 8 bytes per clock cycle
tlastbyte_8: if Data_width = 64 generate

    process(axis_ppkt_aclk) begin
        if(rising_edge(axis_ppkt_aclk)) then
       
            -- determines the last number of bytes when (end of gate/tlast received
            if(tvalid_reg1 = '1' and tlast_reg1 = '1') then
                case tkeep_reg is
                    when X"F" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(8,32));
                    when X"7" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(6,32));
                    when X"3" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(4,32));
                    when X"1" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(2,32));
                    when others =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(0,32));
                end case;
            end if;
            
            -- Pack gate statistics
            case tlast_regx(1 downto 0) is
                when "01" =>
                    m_axis_gate_stat_tdata_out  <= time_stamp;  
                    m_axis_gate_stat_tkeep_out  <= X"F";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                   
                when "10" =>
                    m_axis_gate_stat_tdata_out  <= gate_count & byte_counter_final;  
                    m_axis_gate_stat_tkeep_out  <= X"F";   
                    m_axis_gate_stat_tlast_out  <= '0';   
                    m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                    m_axis_gate_stat_tvalid_out <= '1';
                when "00" =>
                    m_axis_gate_stat_tdata_out  <= (others => '0');
                    m_axis_gate_stat_tkeep_out  <= (others => '0');
                    m_axis_gate_stat_tlast_out  <= '0';
                    m_axis_gate_stat_tuser_out  <= (others => '0');
                    m_axis_gate_stat_tvalid_out <= '0';
                when others => 
                    m_axis_gate_stat_tdata_out  <= (others => '0');
                    m_axis_gate_stat_tkeep_out  <= (others => '0');
                    m_axis_gate_stat_tlast_out  <= '0';
                    m_axis_gate_stat_tuser_out  <= (others => '0');
                    m_axis_gate_stat_tvalid_out <= '0';
            end case;
            
            if(axis_ppkt_aresetn = '0' or byte_count_rst = '1') then
                gate_count <= (others => '0');
            elsif(tlast_regx(1) = '1') then
                gate_count <= gate_count + '1';
            end if;
        end if;    
    end process;

end generate tlastbyte_8;

-- When core is set for 128 bit width, 16 bytes per clock cycle
tlastbyte_16: if Data_width = 128 generate

    process(axis_ppkt_aclk) begin
        if(rising_edge(axis_ppkt_aclk)) then
        
            -- determines the last number of bytes when (end of gate/tlast received
            if(tvalid_reg1 = '1' and tlast_reg1 = '1') then
                case tkeep_reg is
                    when X"FF" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(16,32));    
                    when X"7F" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(14,32));
                    when X"3F" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(12,32));
                    when X"1F" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(10,32));
                    when X"0F" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(8,32));
                    when X"07" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(6,32));
                    when X"03" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(4,32));
                    when X"01" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(2,32));
                    when others =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(0,32));
                end case;
            end if;
            
            -- Pack gate statistics
            if(tlast_regx(0) = '1') then
                m_axis_gate_stat_tdata_out  <= gate_count & byte_counter_final & time_stamp;  
                m_axis_gate_stat_tkeep_out  <= X"FF";   
                m_axis_gate_stat_tlast_out  <= '0';   
                m_axis_gate_stat_tuser_out  <= "0000" & channel & data_type & data_format & '1' & time_stamp;
                m_axis_gate_stat_tvalid_out <= '1';
               
            else
                m_axis_gate_stat_tdata_out  <= (others => '0');
                m_axis_gate_stat_tkeep_out  <= (others => '0');
                m_axis_gate_stat_tlast_out  <= '0';
                m_axis_gate_stat_tuser_out  <= (others => '0');
                m_axis_gate_stat_tvalid_out <= '0';
            end if;
            
            if(axis_ppkt_aresetn = '0' or byte_count_rst = '1') then
                gate_count <= (others => '0');
            elsif(tlast_regx(0) = '1') then
                gate_count <= gate_count + '1';
            end if;
            
        end if;    
    end process;

end generate tlastbyte_16;

-- When core is set for 256 bit width, 32 bytes per clock cycle
tlastbyte_32: if Data_width = 256 generate

    process(axis_ppkt_aclk) begin
        if(rising_edge(axis_ppkt_aclk)) then
        
            -- determines the last number of bytes when (end of gate/tlast received
            if(tvalid_reg1 = '1' and tlast_reg1 = '1') then
                case tkeep_reg is
                    when X"FFFF" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(32,32));
                    when X"7FFF" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(30,32));
                    when X"3FFF" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(28,32));
                    when X"1FFF" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(26,32));
                    when X"0FFF" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(24,32));
                    when X"07FF" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(22,32));
                    when X"03FF" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(20,32));
                    when X"01FF" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(18,32));
                    when X"00FF" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(16,32));    
                    when X"007F" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(14,32));
                    when X"003F" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(12,32));
                    when X"001F" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(10,32));
                    when X"000F" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(8,32));
                    when X"0007" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(6,32));
                    when X"0003" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(4,32));
                    when X"0001" =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(2,32));
                    when others =>
                        byte_counter_tlast <= std_logic_vector(to_unsigned(0,32));
                end case;
            end if;
            
            -- Pack gate statistics
            if(tlast_regx(0) = '1') then
                m_axis_gate_stat_tdata_out(255 downto 128) <= (others => '0'); 
                m_axis_gate_stat_tdata_out(127 downto 0)   <= gate_count & byte_counter_final & time_stamp;  
                m_axis_gate_stat_tkeep_out                 <= X"FFFF"; 
                m_axis_gate_stat_tlast_out                 <= '0';   
                m_axis_gate_stat_tuser_out                 <= "0000" & channel & data_type & data_format & '1' & time_stamp;   
                m_axis_gate_stat_tvalid_out                <= '1';
               
            else
                m_axis_gate_stat_tdata_out  <= (others => '0');
                m_axis_gate_stat_tkeep_out  <= (others => '0');
                m_axis_gate_stat_tlast_out  <= '0';
                m_axis_gate_stat_tuser_out  <= (others => '0');
                m_axis_gate_stat_tvalid_out <= '0';
            end if;
            
            if(axis_ppkt_aresetn = '0' or byte_count_rst = '1') then
                gate_count <= (others => '0');
            elsif(tlast_regx(0) = '1') then
                gate_count <= gate_count + '1';
            end if;
            
        end if;    
    end process;

end generate tlastbyte_32;


csr: px_axil_csr_0 
  Port map
  ( 
    s_axi_csr_aclk    => s_axi_csr_aclk   ,
    s_axi_csr_aresetn => s_axi_csr_aresetn_reg,
    s_axi_csr_awaddr  => s_axi_csr_awaddr ,
    s_axi_csr_awprot  => s_axi_csr_awprot ,
    s_axi_csr_awvalid => s_axi_csr_awvalid,
    s_axi_csr_awready => s_axi_csr_awready,
    s_axi_csr_wdata   => s_axi_csr_wdata  ,
    s_axi_csr_wstrb   => s_axi_csr_wstrb  ,
    s_axi_csr_wvalid  => s_axi_csr_wvalid ,
    s_axi_csr_wready  => s_axi_csr_wready ,
    s_axi_csr_bresp   => s_axi_csr_bresp  ,
    s_axi_csr_bvalid  => s_axi_csr_bvalid ,
    s_axi_csr_bready  => s_axi_csr_bready ,
    s_axi_csr_araddr  => s_axi_csr_araddr ,
    s_axi_csr_arprot  => s_axi_csr_arprot ,
    s_axi_csr_arvalid => s_axi_csr_arvalid,
    s_axi_csr_arready => s_axi_csr_arready,
    s_axi_csr_rdata   => s_axi_csr_rdata  ,
    s_axi_csr_rresp   => s_axi_csr_rresp  ,
    s_axi_csr_rvalid  => s_axi_csr_rvalid ,
    s_axi_csr_rready  => s_axi_csr_rready ,
    reg0_init_val     => reg0_init_val    ,
    ctl0_out          => ctl0_out,
    stat0_in          => time_stamp_cdc(31 downto 0),
    stat1_in          => time_stamp_cdc(63 downto 32),
    stat2_in          => byte_count_cdc,
    stat3_in          => gate_count_cdc
  );
  
  xpm_cdc_inst: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 32  -- integer; range: 1-1024

  )
  port map (

    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => ctl0_out,
    dest_clk => axis_ppkt_aclk,
    dest_out => ctl0_out_cdc
  );
  
  process( axis_ppkt_aclk) begin
      if(rising_edge(axis_ppkt_aclk)) then
          byte_count_rst     <= ctl0_out_cdc(0);
          tlast_word_advance <= ctl0_out_cdc(1);
          
          tlast_word_advance_reg1 <= tlast_word_advance;
          tlast_word_advance_reg2 <= tlast_word_advance_reg1;
          
          tlast_word_advance_pulse <= tlast_word_advance_reg1 and not tlast_word_advance_reg2;
          
      end if;
  end process;
  
  time_stamp_xpm_cdc: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 64  -- integer; range: 1-1024

  )
  port map (

    src_clk  => axis_ppkt_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => time_stamp,
    dest_clk => s_axi_csr_aclk,
    dest_out => time_stamp_cdc
  );
  
  byte_count_xpm_cdc: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 32  -- integer; range: 1-1024

  )
  port map (

    src_clk  => axis_ppkt_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => byte_counter_final,
    dest_clk => s_axi_csr_aclk,
    dest_out => byte_count_cdc
  );
  
  gate_count_xpm_cdc: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 32  -- integer; range: 1-1024

  )
  port map (

    src_clk  => axis_ppkt_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => gate_count,
    dest_clk => s_axi_csr_aclk,
    dest_out => gate_count_cdc
  );
  


  





end Behavioral;
