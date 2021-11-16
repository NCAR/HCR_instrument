----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/25/2017 10:50:10 AM
-- Design Name: 
-- Module Name: tb_px_dac38rf89intrfc_pack - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_dac38rf89intrfc_pack is
Generic
( 

    DAC_JESD_FORMAT_MODE     : std_logic_vector(2 downto 0) := "001";
    
    -- For Dual channel mode. Select which channels to run
    -- bit 0 - run channel A
    -- bit 1 - run channel B
    CHAN                     : std_logic_vector(1 downto 0) := "11";
    
    -- 0 for normal start mode.  Data starts forever
    -- 1 for toggle start mode.  Start and stop mode where toggle with turn on and off
    START_MODE               : std_logic := '0'; 
    
    -- Test Wide DUC Mode - Applies only to JESD Format Mode "100" and "101"
    WIDE_DUC_MODE            : std_logic := '0'

);
end tb_px_dac38rf89intrfc_pack;

architecture Behavioral of tb_px_dac38rf89intrfc_pack is

constant tx_core_clk_half_p     : time := 1.6 ns;
constant dac_sample_clk_half_p  : time := 1.20 ns;


signal dac_pack_rst             : std_logic := '1';
                         
signal tx_core_clk              : std_logic := '0';
signal dac_sample_clk           : std_logic := '0'; -- Sample Clock input

signal sync_latch_clr           : std_logic := '1';
signal sync_latch_en            : std_logic := '0';

signal start_data               : std_logic := '0';
signal start_data_toggle        : std_logic := '0';
signal start_data_dly1          : std_logic := '0';
signal start_data_dly2          : std_logic := '0';
signal start_data_dly3          : std_logic := '0';
 
signal s_axis_pdti_a_tdata      : std_logic_vector(255 downto 0) := (others => '0');
signal s_axis_pdti_a_tuser      : std_logic_vector(127 downto 0) := (others => '0');
signal s_axis_pdti_a_tvalid     : std_logic := '0';
              
signal s_axis_pdti_b_tdata      : std_logic_vector(255 downto 0) := (others => '0');
signal s_axis_pdti_b_tuser      : std_logic_vector(127 downto 0) := (others => '0');
signal s_axis_pdti_b_tvalid     : std_logic := '0';
          
signal tx_start_of_frame        : std_logic_vector(3 downto 0)   := "0000";
signal tx_start_of_frame_dly    : std_logic_vector(3 downto 0)   := "0000";
signal m_axis_jesd_tx_tdata     : std_logic_vector(255 downto 0) := (others => '0');
signal m_axis_jesd_tx_tvalid    : std_logic := '0';

component px_dac38rf89intrfc_pack 
Port 
( 
   dac_pack_rst             : in std_logic;
   
   dac_jesd_format_mode     : in std_logic_vector(2 downto 0);
   wide_duc_mode            : in std_logic;
                            
   tx_core_clk              : in  std_logic;
   dac_sample_clk           : in  std_logic; -- Sample Clock input
   
   sync_latch_clr           : in  std_logic;
   sync_latch_en            : in  std_logic;
      
   s_axis_pdti_a_tdata      : in  std_logic_vector(255 downto 0);
   s_axis_pdti_a_tuser      : in  std_logic_vector(127 downto 0);
   s_axis_pdti_a_tvalid     : in  std_logic;
   
   s_axis_pdti_b_tdata      : in  std_logic_vector(255 downto 0);
   s_axis_pdti_b_tuser      : in  std_logic_vector(127 downto 0);
   s_axis_pdti_b_tvalid     : in  std_logic;
            
   tx_start_of_frame        : in  std_logic_vector(3 downto 0);
   m_axis_jesd_tx_tdata     : out std_logic_vector(255 downto 0);
   m_axis_jesd_tx_tready    : in  std_logic;
   m_axis_jesd_tx_tvalid    : out std_logic

);
end component;

begin

dac_pack_rst       <= '0' after 200 ns;
sync_latch_clr     <= '0' after 200 ns;

sync_latch_en           <= '1' after 1000 ns;
s_axis_pdti_a_tuser(72) <= '1' after 2000 ns when CHAN(0) = '1';
s_axis_pdti_b_tuser(72) <= '1' after 2000 ns when CHAN(1) = '1';

start_data_toggle       <= not start_data_toggle after 3000 ns when START_MODE = '1' else
                           '0';
start_data              <= '1' after 3000 ns when START_MODE = '0' else
                           start_data_toggle;

generate_82121: if dac_jesd_format_mode = "000" generate
    
    tx_core_clk        <= not tx_core_clk after tx_core_clk_half_p;
    dac_sample_clk     <= not dac_sample_clk after tx_core_clk_half_p;
    
    tx_start_of_frame  <= "1111";
   
    data_loop: for i in 0 to 7 generate
        process(dac_sample_clk) begin
            if(rising_edge(dac_sample_clk)) then
                if(dac_pack_rst = '1') then
                    s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= std_logic_vector(to_unsigned(i, 16)); 
                    s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= std_logic_vector(to_unsigned(i+32768, 16));
                else
                
                    s_axis_pdti_a_tuser(64) <= start_data;
                    s_axis_pdti_a_tvalid    <= '1';
                    
                    if(s_axis_pdti_a_tuser(64) = '1') then
                        s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) ) + 8; 
                        s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) + 8;
                        
                    end if;
                end if;
            end if;
        end process;
    end generate;

end generate;

generate_84111: if dac_jesd_format_mode = "001" generate
    
    tx_core_clk        <= not tx_core_clk after tx_core_clk_half_p;
    dac_sample_clk     <= not dac_sample_clk after tx_core_clk_half_p;
    
    tx_start_of_frame  <= "1111";
   
    data_loop: for i in 0 to 7 generate
        process(dac_sample_clk) begin
            if(rising_edge(dac_sample_clk)) then
                if(dac_pack_rst = '1') then
                    s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= std_logic_vector(to_unsigned(i, 16)); 
                    s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= std_logic_vector(to_unsigned(i+32768, 16));
                    
                    s_axis_pdti_b_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= std_logic_vector(to_unsigned(i, 16)); 
                    s_axis_pdti_b_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= std_logic_vector(to_unsigned(i+32768, 16));
                else
                    
                    if(chan(0) = '1') then
                        s_axis_pdti_a_tuser(64) <= start_data;
                        
                        if(start_data = '1') then
                            s_axis_pdti_a_tvalid    <= not s_axis_pdti_a_tvalid;
                        end if;
                        
                        if(s_axis_pdti_a_tvalid = '1') then
                            s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) ) + 8; 
                            s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) + 8;
                            
                        end if;
                    end if;
                    
                    if(chan(1) = '1') then
                        s_axis_pdti_b_tuser(64) <= start_data;
                        if(start_data = '1') then
                            s_axis_pdti_b_tvalid    <= not s_axis_pdti_b_tvalid;
                        end if;
                        
                        if(s_axis_pdti_b_tvalid = '1') then
                            s_axis_pdti_b_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= s_axis_pdti_b_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) ) + 8; 
                            s_axis_pdti_b_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= s_axis_pdti_b_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) + 8;
                            
                        end if;
                    end if;
                end if;
            end if;
        end process;
    end generate;

end generate;

generate_81180: if dac_jesd_format_mode = "011" generate
    
    tx_core_clk        <= not tx_core_clk after tx_core_clk_half_p;
    dac_sample_clk     <= not dac_sample_clk after tx_core_clk_half_p;
    
    tx_start_of_frame  <= "1111"; 
   
    data_loop: for i in 0 to 31 generate
        process(dac_sample_clk) begin
            if(rising_edge(dac_sample_clk)) then
                if(dac_pack_rst = '1') then
                    s_axis_pdti_a_tdata( ((i+1)*8 -1) downto i*8 ) <= std_logic_vector(to_unsigned(i, 8)); 
                else
                
                    s_axis_pdti_a_tuser(64) <= start_data;
                    s_axis_pdti_a_tvalid    <= '1';    
                    
                    if(s_axis_pdti_a_tuser(64) = '1') then
                        s_axis_pdti_a_tdata( ((i+1)*8 -1) downto i*8 ) <= s_axis_pdti_a_tdata(  ((i+1)*8 -1) downto i*8 ) + 32; 
                    end if;
                end if;
            end if;
        end process;
    end generate;

end generate;


generate_82380: if dac_jesd_format_mode = "100" generate

    tx_core_clk        <= not tx_core_clk after tx_core_clk_half_p;
    dac_sample_clk     <= not dac_sample_clk after dac_sample_clk_half_p;

    data_loop: for i in 0 to 7 generate
        process(dac_sample_clk) begin
            if(rising_edge(dac_sample_clk)) then
                if(wide_duc_mode = '0') then
                    if(dac_pack_rst = '1') then
                        s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= std_logic_vector(to_unsigned(i*16, 16)); 
                        s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= std_logic_vector(to_unsigned(i*16+32768, 16));
                        s_axis_pdti_b_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= std_logic_vector(to_unsigned(i*16, 16)); 
                        s_axis_pdti_b_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= std_logic_vector(to_unsigned(i*16+32768, 16));
                    else
                    
                        start_data_dly1 <= start_data;
                        start_data_dly2 <= start_data_dly1;
                        start_data_dly3 <= start_data_dly2;
                    
                        if(chan(0) = '1') then
                        
                            s_axis_pdti_a_tuser(64) <= start_data;
                            
                            
                            if(start_data = '1') then
                                s_axis_pdti_a_tvalid    <= not s_axis_pdti_a_tvalid;
                            end if;
                            
                            if(s_axis_pdti_a_tvalid = '1') then
                                s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) ) + 128; 
                                s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) + 128;
                                
                            end if;
                        end if;
                        
                        if(chan(1) = '1') then
                        
                            s_axis_pdti_b_tuser(64) <= start_data;
                            
                            if(start_data = '1') then
                                s_axis_pdti_b_tvalid    <= not s_axis_pdti_b_tvalid;
                            end if;
                            
                            if(s_axis_pdti_b_tvalid = '1') then
                                s_axis_pdti_b_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= s_axis_pdti_b_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) ) - 128; 
                                s_axis_pdti_b_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= s_axis_pdti_b_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) - 128;
                                
                            end if;
                        end if;
                    end if;
                
                else
                    if(dac_pack_rst = '1') then
                        s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= std_logic_vector(to_unsigned(i*16, 16)); 
                        s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= std_logic_vector(to_unsigned(i*16+32768, 16));
                        s_axis_pdti_b_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= (others => '0');
                        s_axis_pdti_b_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= (others => '0');
                    else
                    
                        start_data_dly1 <= start_data;
                        start_data_dly2 <= start_data_dly1;
                        start_data_dly3 <= start_data_dly2;
                    
                        s_axis_pdti_a_tuser(64) <= start_data;
                        s_axis_pdti_b_tuser(64) <= '0';
                        s_axis_pdti_b_tvalid    <= '0';
                        
                        if(start_data = '1') then
                            s_axis_pdti_a_tvalid    <= '1';
                        end if;
                        
                        if(s_axis_pdti_a_tvalid = '1') then
                            s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) ) + 128; 
                            s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) + 128;
                            
                        end if;
                        
                    end if;
                
                end if;
            end if;
        end process;
        
        process(tx_core_clk) begin
            if(rising_edge(tx_core_clk)) then
            
                if(dac_pack_rst = '1') then
                    tx_start_of_frame <= "1001";
                else
                    if(tx_start_of_frame = "1001") then
                        tx_start_of_frame <= "0100";
                    end if;
                    
                    if(tx_start_of_frame = "0100") then
                        tx_start_of_frame <= "0010";
                    end if;
                    
                    if(tx_start_of_frame = "0010") then
                        tx_start_of_frame <= "1001";
                    end if;
                end if;
            end if;
        
        end process;
        
    end generate;

end generate;

generate_82121_2tx: if dac_jesd_format_mode = "101" generate
    
    tx_core_clk        <= not tx_core_clk after tx_core_clk_half_p;
    dac_sample_clk     <= not dac_sample_clk after tx_core_clk_half_p;
    
    tx_start_of_frame  <= "1111";
   
    data_loop: for i in 0 to 7 generate
        process(dac_sample_clk) begin
            if(rising_edge(dac_sample_clk)) then
                if(dac_pack_rst = '1') then
                    s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= std_logic_vector(to_unsigned(i, 16)); 
                    s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= std_logic_vector(to_unsigned(i+32768, 16));
                    
                    s_axis_pdti_b_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= std_logic_vector(to_unsigned(i, 16)); 
                    s_axis_pdti_b_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= std_logic_vector(to_unsigned(i+32768, 16));
                else
                
                    s_axis_pdti_a_tuser(64) <= start_data;
                    
                    if(start_data = '1') then
                        s_axis_pdti_a_tvalid    <= not s_axis_pdti_a_tvalid;
                    end if;
                    
                    if(s_axis_pdti_a_tvalid = '1') then
                        s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= s_axis_pdti_a_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) ) + 8; 
                        s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= s_axis_pdti_a_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) + 8;
                        
                    end if;
                    
                    s_axis_pdti_b_tuser(64) <= start_data;
                    if(start_data = '1') then
                        s_axis_pdti_b_tvalid    <= not s_axis_pdti_b_tvalid;
                    end if;
                    
                    if(s_axis_pdti_b_tvalid = '1') then
                        s_axis_pdti_b_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) )       <= s_axis_pdti_b_tdata( ((i*2+1)*16 - 1) downto ((i*2*16)) ) + 8; 
                        s_axis_pdti_b_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) <= s_axis_pdti_b_tdata( (((i+1)*16)*2 - 1) downto (((i*2+1)*16)) ) + 8;
                        
                    end if;
                end if;
            end if;
        end process;
    end generate;

end generate;



   
--s_axis_pdti_a_tuser   
--s_axis_pdti_a_tvalid  
tx_start_of_frame_dly <= tx_start_of_frame after 1 ps;

dut: px_dac38rf89intrfc_pack 
Port map
( 
   dac_pack_rst             => dac_pack_rst,           
                                                      
   dac_jesd_format_mode     => dac_jesd_format_mode,
   wide_duc_mode            => wide_duc_mode,    
                                                      
   tx_core_clk              => tx_core_clk,            
   dac_sample_clk           => dac_sample_clk,
   
   sync_latch_clr           => sync_latch_clr,
   sync_latch_en            => sync_latch_en,
                                  
                                                      
   s_axis_pdti_a_tdata      => s_axis_pdti_a_tdata,    
   s_axis_pdti_a_tuser      => s_axis_pdti_a_tuser,    
   s_axis_pdti_a_tvalid     => s_axis_pdti_a_tvalid,   
                                                      
   s_axis_pdti_b_tdata      => s_axis_pdti_b_tdata,    
   s_axis_pdti_b_tuser      => s_axis_pdti_b_tuser,    
   s_axis_pdti_b_tvalid     => s_axis_pdti_b_tvalid,   
                                                      
   tx_start_of_frame        => tx_start_of_frame_dly,
   m_axis_jesd_tx_tdata     => m_axis_jesd_tx_tdata,
   m_axis_jesd_tx_tready    => '1',   
   m_axis_jesd_tx_tvalid    => m_axis_jesd_tx_tvalid  

);




end Behavioral;
