----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2017 02:59:08 PM
-- Design Name: 
-- Module Name: tb_px_adc12dj3200intrfc_unpack - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
--
-- Revision 1.2 - 11/16/2018 - Changed fifo implementation option of jesd_buffer_fifo 
-- from built-in to block ram. Block Ram results in better routing and timing for
-- fifo's at high frequencies. Modified this test bench to support simulation of
-- all JESD modes
--
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

entity tb_px_adc12dj3200intrfc_unpack is
--  Port ( );
end tb_px_adc12dj3200intrfc_unpack;

architecture Behavioral of tb_px_adc12dj3200intrfc_unpack is


-- 00000 - 12 Bit single
-- 00010 - 12 Bit dual
-- 00101 - 5 Bit Single
-- 00111 - 5 Bit Dual
-- 01001 - 15 Bit Decim-2 Dual
-- 01011 - 15 Bit Decim-4 Dual
-- 01110 - 15 Bit Decim-8 Dual
-- 10000 - 15 Bit Decim-16 Dual
constant jmode                      : std_logic_vector(4 downto 0) := "10000";

constant rx_core_clk_half_p                 : time := 2 ns;
constant adc_sample_clk_half_p              : time := 1.6 ns;
constant adc_sample_clk_half_p_decim16      : time := 8 ns;
constant adc_sample_clk_half_p_decim8       : time := 4 ns;

signal rx_core_clk                  : std_logic := '0';
signal s_axis_jesd_rx_pd_tdata      : std_logic_vector(255 downto 0);
signal s_axis_jesd_rx_pd_tvalid     : std_logic := '0';
signal s_axis_jesd_rx_pd_tvalid_reg : std_logic := '0';
signal adc_sample_clk               : std_logic := '0';
signal m_axis_adc1_pd_tdata         : std_logic_vector(255 downto 0) := (others => '0');
signal m_axis_adc1_pd_tvalid        : std_logic := '0';
signal m_axis_adc2_pd_tdata         : std_logic_vector(255 downto 0) := (others => '0');
signal m_axis_adc2_pd_tvalid        : std_logic := '0';

signal m_axis_adc1_pd_tdata_dly     : std_logic_vector(255 downto 0) := (others => '0');
signal m_axis_adc1_pd_tvalid_dly    : std_logic := '0';

signal m_axis_adc2_pd_tdata_dly     : std_logic_vector(255 downto 0) := (others => '0');
signal m_axis_adc2_pd_tvalid_dly    : std_logic := '0';

signal m_axis_adc1_pd_tdata_compare  : std_logic_vector(255 downto 0) := (others => '0');
signal m_axis_adc1_pd_tdata_error    : std_logic := '0';

signal m_axis_adc2_pd_tdata_compare  : std_logic_vector(255 downto 0) := (others => '0');
signal m_axis_adc2_pd_tdata_error    : std_logic := '0';

                                    
signal toogle                       :  std_logic := '0';
                         

signal jesd_buffer_fifo_rst         : std_logic := '1';
signal tb_rst                       : std_logic := '1';



type data_int_array is array(0 to 39) of std_logic_vector(15 downto 0);
type lanes_array is array(0 to 7) of std_logic_vector(31 downto 0);

signal data_int_a : data_int_array; -- := {X"000",X"001",X"002",X"003",X"004",X"005",X"006",X"007",X"008",X"009",
signal data_int_b : data_int_array; --    X"00A",X"00B",X"00C",X"00D",X"00F",X"010",X"011",X"012",X"013",X"014",
                                    --    X"015",X"016",X"017",X"018",X"019",X"01A",X"01B",X"01C",X"01D",X"01E",
                                    --    X"01F",X"020",X"021",X"022",X"023",X"024",X"025",X"026",X"027",X"028"};
signal data_int_a_i : data_int_array; 
signal data_int_a_q : data_int_array; 
signal data_int_b_i : data_int_array;
signal data_int_b_q : data_int_array;

signal lanes    : lanes_array;

component px_adc12dj3200intrfc_unpack 
Port 
( 
     jmode                    : in std_logic_vector(4 downto 0);
    
     jesd_buffer_fifo_rst     : in std_logic;
     
     rx_core_clk              : in std_logic;
     s_axis_jesd_rx_pd_tdata  : in std_logic_vector(255 downto 0);
     s_axis_jesd_rx_pd_tvalid : in std_logic;
    
     adc_sample_clk           : in std_logic;
     
     m_axis_adc1_pd_tdata      : out std_logic_vector(255 downto 0);
     m_axis_adc1_pd_tvalid     : out std_logic;
     
     m_axis_adc2_pd_tdata     : out std_logic_vector(255 downto 0);
     m_axis_adc2_pd_tvalid    : out std_logic

);
end component;
                

begin

   jesd_buffer_fifo_rst <= '0' after 200 ns;
   tb_rst               <= '0' after 2000 ns;
   rx_core_clk    <= not rx_core_clk after rx_core_clk_half_p;
   
   single_channel_12_bit : if jmode = "00000" generate
   
       adc_sample_clk <= not adc_sample_clk after adc_sample_clk_half_p;
   
       data_loop: for i in 0 to 39 generate 
           process(tb_rst, rx_core_clk) begin
                
               if(tb_rst = '1') then
                     data_int_a(i)(11 downto 0)  <= std_logic_vector(to_unsigned(i, 12));
                     data_int_a(i)(15 downto 12) <= (others => '0');
                     data_int_b(i)(15 downto 0)  <= (others => '0');
                     s_axis_jesd_rx_pd_tvalid     <= '0';
                     s_axis_jesd_rx_pd_tvalid_reg <= '0';
               elsif(rising_edge(rx_core_clk)) then
                    
                    s_axis_jesd_rx_pd_tvalid     <= not tb_rst;
                    s_axis_jesd_rx_pd_tvalid_reg <= s_axis_jesd_rx_pd_tvalid;
                
                    if(toogle = '1') then
                        data_int_a(i)(11 downto 0) <= data_int_a(i)(11 downto 0) + 40;     
                    end if;
            
               end if;
           end process;
       end generate;
       
       process(tb_rst, rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if( s_axis_jesd_rx_pd_tvalid = '1') then
                   if(toogle = '0') then  
                       lanes(0) <=  data_int_a(16)(11 downto 4) & data_int_a(8)(7 downto 0)  & data_int_a(0)(3 downto 0)  & data_int_a(8)(11 downto 8)  & data_int_a(0)(11 downto 4);
                       lanes(1) <=  data_int_a(18)(11 downto 4) & data_int_a(10)(7 downto 0) & data_int_a(2)(3 downto 0)  & data_int_a(10)(11 downto 8) & data_int_a(2)(11 downto 4);
                       lanes(2) <=  data_int_a(20)(11 downto 4) & data_int_a(12)(7 downto 0) & data_int_a(4)(3 downto 0)  & data_int_a(12)(11 downto 8) & data_int_a(4)(11 downto 4);
                       lanes(3) <=  data_int_a(22)(11 downto 4) & data_int_a(14)(7 downto 0) & data_int_a(6)(3 downto 0)  & data_int_a(14)(11 downto 8) & data_int_a(6)(11 downto 4);
                       lanes(4) <=  data_int_a(17)(11 downto 4) & data_int_a(9)(7 downto 0)  & data_int_a(1)(3 downto 0)  & data_int_a(9)(11 downto 8)  & data_int_a(1)(11 downto 4);
                       lanes(5) <=  data_int_a(19)(11 downto 4) & data_int_a(11)(7 downto 0) & data_int_a(3)(3 downto 0)  & data_int_a(11)(11 downto 8) & data_int_a(3)(11 downto 4);
                       lanes(6) <=  data_int_a(21)(11 downto 4) & data_int_a(13)(7 downto 0) & data_int_a(5)(3 downto 0)  & data_int_a(13)(11 downto 8) & data_int_a(5)(11 downto 4);
                       lanes(7) <=  data_int_a(23)(11 downto 4) & data_int_a(15)(7 downto 0) & data_int_a(7)(3 downto 0)  & data_int_a(15)(11 downto 8) & data_int_a(7)(11 downto 4);
                       toogle <= '1'; 
                   else
                       lanes(0) <= data_int_a(32)(3 downto 0) & x"0" & data_int_a(32)(11 downto 4) & data_int_a(24)(7 downto 0) & data_int_a(16)(3 downto 0) & data_int_a(24)(11 downto 8) ;
                       lanes(1) <= data_int_a(34)(3 downto 0) & x"0" & data_int_a(34)(11 downto 4) & data_int_a(26)(7 downto 0) & data_int_a(18)(3 downto 0) & data_int_a(26)(11 downto 8) ;
                       lanes(2) <= data_int_a(36)(3 downto 0) & x"0" & data_int_a(36)(11 downto 4) & data_int_a(28)(7 downto 0) & data_int_a(20)(3 downto 0) & data_int_a(28)(11 downto 8) ;
                       lanes(3) <= data_int_a(38)(3 downto 0) & x"0" & data_int_a(38)(11 downto 4) & data_int_a(30)(7 downto 0) & data_int_a(22)(3 downto 0) & data_int_a(30)(11 downto 8) ;
                       lanes(4) <= data_int_a(33)(3 downto 0) & x"0" & data_int_a(33)(11 downto 4) & data_int_a(25)(7 downto 0) & data_int_a(17)(3 downto 0) & data_int_a(25)(11 downto 8) ;
                       lanes(5) <= data_int_a(35)(3 downto 0) & x"0" & data_int_a(35)(11 downto 4) & data_int_a(27)(7 downto 0) & data_int_a(19)(3 downto 0) & data_int_a(27)(11 downto 8) ;
                       lanes(6) <= data_int_a(37)(3 downto 0) & x"0" & data_int_a(37)(11 downto 4) & data_int_a(29)(7 downto 0) & data_int_a(21)(3 downto 0) & data_int_a(29)(11 downto 8) ;
                       lanes(7) <= data_int_a(39)(3 downto 0) & x"0" & data_int_a(39)(11 downto 4) & data_int_a(31)(7 downto 0) & data_int_a(23)(3 downto 0) & data_int_a(31)(11 downto 8) ;
                       toogle <= '0';
                   end if;
               end if;
          end if;
       end process;
   end generate;
   
   dual_channel_12_bit : if jmode = "00010" generate
   
       adc_sample_clk <= not adc_sample_clk after adc_sample_clk_half_p;
   
       data_loop_chan_a_b: for i in 0 to 19 generate 
           process(tb_rst, rx_core_clk) begin
                
               if(tb_rst = '1') then
                     data_int_a(i)(11 downto 0)   <= std_logic_vector(to_unsigned(i, 12));
                     data_int_b(i)(11 downto 0)   <= std_logic_vector(to_unsigned(i+2048, 12));
                     data_int_a(i)(15 downto 12)  <= (others => '0');
                     data_int_b(i)(15 downto 12)  <= (others => '0');
                     s_axis_jesd_rx_pd_tvalid     <= '0';
                     s_axis_jesd_rx_pd_tvalid_reg <= '0';
               elsif(rising_edge(rx_core_clk)) then
                    
                    s_axis_jesd_rx_pd_tvalid     <= not tb_rst;
                    s_axis_jesd_rx_pd_tvalid_reg <= s_axis_jesd_rx_pd_tvalid;
                
                    if(toogle = '1') then
                        data_int_a(i)(11 downto 0)    <= data_int_a(i)(11 downto 0) + 20;
                        data_int_b(i)(11 downto 0)    <= data_int_b(i)(11 downto 0) + 20;
                    end if;
            
               end if;
           end process;
       end generate;
       
       process(tb_rst, rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if( s_axis_jesd_rx_pd_tvalid = '1') then
                   if(toogle = '0') then  
                       lanes(0) <=  data_int_a(8)(11 downto 4)  & data_int_a(4)(7 downto 0)  & data_int_a(0)(3 downto 0) & data_int_a(4)(11 downto 8)  & data_int_a(0)(11 downto 4);
                       lanes(1) <=  data_int_a(9)(11 downto 4)  & data_int_a(5)(7 downto 0)  & data_int_a(1)(3 downto 0) & data_int_a(5)(11 downto 8)  & data_int_a(1)(11 downto 4);
                       lanes(2) <=  data_int_a(10)(11 downto 4) & data_int_a(6)(7 downto 0)  & data_int_a(2)(3 downto 0) & data_int_a(6)(11 downto 8)  & data_int_a(2)(11 downto 4);
                       lanes(3) <=  data_int_a(11)(11 downto 4) & data_int_a(7)(7 downto 0)  & data_int_a(3)(3 downto 0) & data_int_a(7)(11 downto 8)  & data_int_a(3)(11 downto 4);
                       
                       lanes(4) <=  data_int_b(8)(11 downto 4)  & data_int_b(4)(7 downto 0)  & data_int_b(0)(3 downto 0) & data_int_b(4)(11 downto 8)  & data_int_b(0)(11 downto 4);
                       lanes(5) <=  data_int_b(9)(11 downto 4)  & data_int_b(5)(7 downto 0)  & data_int_b(1)(3 downto 0) & data_int_b(5)(11 downto 8)  & data_int_b(1)(11 downto 4);
                       lanes(6) <=  data_int_b(10)(11 downto 4) & data_int_b(6)(7 downto 0)  & data_int_b(2)(3 downto 0) & data_int_b(6)(11 downto 8)  & data_int_b(2)(11 downto 4);
                       lanes(7) <=  data_int_b(11)(11 downto 4) & data_int_b(7)(7 downto 0)  & data_int_b(3)(3 downto 0) & data_int_b(7)(11 downto 8)  & data_int_b(3)(11 downto 4);
                       toogle <= '1'; 
                   else
                       lanes(0) <= data_int_a(16)(3 downto 0) & x"0" & data_int_a(16)(11 downto 4) & data_int_a(12)(7 downto 0) & data_int_a(8)(3 downto 0)  & data_int_a(12)(11 downto 8);
                       lanes(1) <= data_int_a(17)(3 downto 0) & x"0" & data_int_a(17)(11 downto 4) & data_int_a(13)(7 downto 0) & data_int_a(9)(3 downto 0)  & data_int_a(13)(11 downto 8);
                       lanes(2) <= data_int_a(18)(3 downto 0) & x"0" & data_int_a(18)(11 downto 4) & data_int_a(14)(7 downto 0) & data_int_a(10)(3 downto 0) & data_int_a(14)(11 downto 8);
                       lanes(3) <= data_int_a(19)(3 downto 0) & x"0" & data_int_a(19)(11 downto 4) & data_int_a(15)(7 downto 0) & data_int_a(11)(3 downto 0) & data_int_a(15)(11 downto 8);
                       
                       lanes(4) <= data_int_b(16)(3 downto 0) & x"0" & data_int_b(16)(11 downto 4) & data_int_b(12)(7 downto 0) & data_int_b(8)(3 downto 0)  & data_int_b(12)(11 downto 8);
                       lanes(5) <= data_int_b(17)(3 downto 0) & x"0" & data_int_b(17)(11 downto 4) & data_int_b(13)(7 downto 0) & data_int_b(9)(3 downto 0)  & data_int_b(13)(11 downto 8);
                       lanes(6) <= data_int_b(18)(3 downto 0) & x"0" & data_int_b(18)(11 downto 4) & data_int_b(14)(7 downto 0) & data_int_b(10)(3 downto 0) & data_int_b(14)(11 downto 8);
                       lanes(7) <= data_int_b(19)(3 downto 0) & x"0" & data_int_b(19)(11 downto 4) & data_int_b(15)(7 downto 0) & data_int_b(11)(3 downto 0) & data_int_b(15)(11 downto 8);
                       toogle <= '0';
                   end if;
               end if;
          end if;
       end process;
   end generate;
   
   jmode_5_8bit : if jmode = "00101" generate
   
       adc_sample_clk <= not adc_sample_clk after rx_core_clk_half_p;
   
       data_loop_chan: for i in 0 to 31 generate 
           process(tb_rst, rx_core_clk) begin
                
               if(tb_rst = '1') then
                     data_int_a(i)                  <= X"00" & std_logic_vector(to_unsigned(i, 8));
                     data_int_b(i)                  <= (others => '0');
                     s_axis_jesd_rx_pd_tvalid     <= '0';
                     s_axis_jesd_rx_pd_tvalid_reg <= '0';
               elsif(rising_edge(rx_core_clk)) then
                    
                    s_axis_jesd_rx_pd_tvalid     <= not tb_rst;
                    s_axis_jesd_rx_pd_tvalid_reg <= s_axis_jesd_rx_pd_tvalid;
                
                    if(s_axis_jesd_rx_pd_tvalid = '1') then
                        data_int_a(i)    <= data_int_a(i) + 32;
                    end if;
               end if;
           end process;
       end generate;
       
       process(tb_rst, rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if( s_axis_jesd_rx_pd_tvalid = '1') then
                   lanes(0) <= data_int_a(24)(7 downto 0) & data_int_a(16)(7 downto 0) & data_int_a(8)(7 downto 0) & data_int_a(0)(7 downto 0);
                   lanes(1) <= data_int_a(26)(7 downto 0) & data_int_a(18)(7 downto 0) & data_int_a(10)(7 downto 0) & data_int_a(2)(7 downto 0);
                   lanes(2) <= data_int_a(28)(7 downto 0) & data_int_a(20)(7 downto 0) & data_int_a(12)(7 downto 0) & data_int_a(4)(7 downto 0);
                   lanes(3) <= data_int_a(30)(7 downto 0) & data_int_a(22)(7 downto 0) & data_int_a(14)(7 downto 0) & data_int_a(6)(7 downto 0);
                   
                   lanes(4) <= data_int_a(25)(7 downto 0) & data_int_a(17)(7 downto 0) & data_int_a(9)(7 downto 0)  & data_int_a(1)(7 downto 0); 
                   lanes(5) <= data_int_a(27)(7 downto 0) & data_int_a(19)(7 downto 0) & data_int_a(11)(7 downto 0) & data_int_a(3)(7 downto 0); 
                   lanes(6) <= data_int_a(29)(7 downto 0) & data_int_a(21)(7 downto 0) & data_int_a(13)(7 downto 0) & data_int_a(5)(7 downto 0); 
                   lanes(7) <= data_int_a(31)(7 downto 0) & data_int_a(23)(7 downto 0) & data_int_a(15)(7 downto 0) & data_int_a(7)(7 downto 0); 
               end if;
          end if;
       end process;
   end generate;  
   
   jmode_7_8bit : if jmode = "00111" generate
   
       adc_sample_clk <= not adc_sample_clk after rx_core_clk_half_p;
   
       data_loop_chan: for i in 0 to 15 generate 
           process(tb_rst, rx_core_clk) begin
                
               if(tb_rst = '1') then
                     data_int_a(i)                  <= X"00" & std_logic_vector(to_unsigned(i, 8));
                     data_int_b(i)                  <= X"00" & std_logic_vector(to_unsigned(i+128, 8));
                     s_axis_jesd_rx_pd_tvalid     <= '0';
                     s_axis_jesd_rx_pd_tvalid_reg <= '0';
               elsif(rising_edge(rx_core_clk)) then
                    
                    s_axis_jesd_rx_pd_tvalid     <= not tb_rst;
                    s_axis_jesd_rx_pd_tvalid_reg <= s_axis_jesd_rx_pd_tvalid;
                
                    if(s_axis_jesd_rx_pd_tvalid = '1') then
                        data_int_a(i)    <= data_int_a(i) + 16;
                        data_int_b(i)    <= data_int_b(i) + 16;
                    end if;
               end if;
           end process;
       end generate;
       
       process(tb_rst, rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if( s_axis_jesd_rx_pd_tvalid = '1') then
                   lanes(0) <= data_int_a(12)(7 downto 0) & data_int_a(8)(7 downto 0) & data_int_a(4)(7 downto 0) & data_int_a(0)(7 downto 0);
                   lanes(1) <= data_int_a(13)(7 downto 0) & data_int_a(9)(7 downto 0) & data_int_a(5)(7 downto 0) & data_int_a(1)(7 downto 0);
                   lanes(2) <= data_int_a(14)(7 downto 0) & data_int_a(10)(7 downto 0) & data_int_a(6)(7 downto 0) & data_int_a(2)(7 downto 0);
                   lanes(3) <= data_int_a(15)(7 downto 0) & data_int_a(11)(7 downto 0) & data_int_a(7)(7 downto 0) & data_int_a(3)(7 downto 0);
                   
                   lanes(4) <= data_int_b(12)(7 downto 0) & data_int_b(8)(7 downto 0) & data_int_b(4)(7 downto 0) & data_int_b(0)(7 downto 0); 
                   lanes(5) <= data_int_b(13)(7 downto 0) & data_int_b(9)(7 downto 0) & data_int_b(5)(7 downto 0) & data_int_b(1)(7 downto 0); 
                   lanes(6) <= data_int_b(14)(7 downto 0) & data_int_b(10)(7 downto 0) & data_int_b(6)(7 downto 0) & data_int_b(2)(7 downto 0); 
                   lanes(7) <= data_int_b(15)(7 downto 0) & data_int_b(11)(7 downto 0) & data_int_b(7)(7 downto 0) & data_int_b(3)(7 downto 0); 
               end if;
          end if;
       end process;
   end generate;  
   
   


   jmode_9_15bit : if jmode = "01001" generate
   
       adc_sample_clk <= not adc_sample_clk after rx_core_clk_half_p;
   
       data_loop_chan: for i in 0 to 7 generate 
           process(tb_rst, rx_core_clk) begin
                
               if(tb_rst = '1') then
                     data_int_a(i)                  <= std_logic_vector(to_unsigned(i, 16));
                     data_int_b(i)                  <= std_logic_vector(to_unsigned(i+32768, 16));
                     s_axis_jesd_rx_pd_tvalid     <= '0';
                     s_axis_jesd_rx_pd_tvalid_reg <= '0';
               elsif(rising_edge(rx_core_clk)) then
                    
                    s_axis_jesd_rx_pd_tvalid     <= not tb_rst;
                    s_axis_jesd_rx_pd_tvalid_reg <= s_axis_jesd_rx_pd_tvalid;
                
                    if(s_axis_jesd_rx_pd_tvalid = '1') then
                        data_int_a(i)    <= data_int_a(i) + 8;
                        data_int_b(i)    <= data_int_b(i) + 8;
                    end if;
               end if;
           end process;
       end generate;
       
       process(tb_rst, rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if( s_axis_jesd_rx_pd_tvalid = '1') then
                   lanes(0) <= data_int_a(4)(7 downto 0) & data_int_a(4)(15 downto 8) & data_int_a(0)(7 downto 0) & data_int_a(0)(15 downto 8);
                   lanes(1) <= data_int_a(5)(7 downto 0) & data_int_a(5)(15 downto 8) & data_int_a(1)(7 downto 0) & data_int_a(1)(15 downto 8);
                   lanes(2) <= data_int_a(6)(7 downto 0) & data_int_a(6)(15 downto 8) & data_int_a(2)(7 downto 0) & data_int_a(2)(15 downto 8);
                   lanes(3) <= data_int_a(7)(7 downto 0) & data_int_a(7)(15 downto 8) & data_int_a(3)(7 downto 0) & data_int_a(3)(15 downto 8);
                   
                   lanes(4) <= data_int_b(4)(7 downto 0) & data_int_b(4)(15 downto 8) & data_int_b(0)(7 downto 0) & data_int_b(0)(15 downto 8); 
                   lanes(5) <= data_int_b(5)(7 downto 0) & data_int_b(5)(15 downto 8) & data_int_b(1)(7 downto 0) & data_int_b(1)(15 downto 8); 
                   lanes(6) <= data_int_b(6)(7 downto 0) & data_int_b(6)(15 downto 8) & data_int_b(2)(7 downto 0) & data_int_b(2)(15 downto 8); 
                   lanes(7) <= data_int_b(7)(7 downto 0) & data_int_b(7)(15 downto 8) & data_int_b(3)(7 downto 0) & data_int_b(3)(15 downto 8); 
               end if;
          end if;
       end process;
   end generate;
   

   jmode_11_15bit : if jmode = "01011" generate
   
       adc_sample_clk <= not adc_sample_clk after rx_core_clk_half_p;
   
       data_loop_chan: for i in 0 to 3 generate 
           process(tb_rst, rx_core_clk) begin
                
               if(tb_rst = '1') then
                     data_int_a_i(i)                  <= std_logic_vector(to_unsigned(i, 16));
                     data_int_a_q(i)                  <= std_logic_vector(to_unsigned(i+32768, 16));
                     data_int_b_i(i)                  <= std_logic_vector(to_unsigned(i, 16));
                     data_int_b_q(i)                  <= std_logic_vector(to_unsigned(i+61440, 16));
                     
                     s_axis_jesd_rx_pd_tvalid     <= '0';
                     s_axis_jesd_rx_pd_tvalid_reg <= '0';
               elsif(rising_edge(rx_core_clk)) then
                    
                    s_axis_jesd_rx_pd_tvalid     <= not tb_rst;
                    s_axis_jesd_rx_pd_tvalid_reg <= s_axis_jesd_rx_pd_tvalid;
                
                    if(s_axis_jesd_rx_pd_tvalid = '1') then
                        data_int_a_i(i)    <= data_int_a_i(i) + 4;
                        data_int_a_q(i)    <= data_int_a_q(i) + 4;
                        data_int_b_i(i)    <= data_int_b_i(i) + 4;
                        data_int_b_q(i)    <= data_int_b_q(i) + 4;
                    end if;
               end if;
           end process;
       end generate;
       
       process(tb_rst, rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if( s_axis_jesd_rx_pd_tvalid = '1') then
                   lanes(0) <= data_int_a_i(2)(7 downto 0) & data_int_a_i(2)(15 downto 8) & data_int_a_i(0)(7 downto 0) & data_int_a_i(0)(15 downto 8);
                   lanes(1) <= data_int_a_i(3)(7 downto 0) & data_int_a_i(3)(15 downto 8) & data_int_a_i(1)(7 downto 0) & data_int_a_i(1)(15 downto 8);
                   lanes(2) <= data_int_a_q(2)(7 downto 0) & data_int_a_q(2)(15 downto 8) & data_int_a_q(0)(7 downto 0) & data_int_a_q(0)(15 downto 8);
                   lanes(3) <= data_int_a_q(3)(7 downto 0) & data_int_a_q(3)(15 downto 8) & data_int_a_q(1)(7 downto 0) & data_int_a_q(1)(15 downto 8);
                   
                   lanes(4) <= data_int_b_i(2)(7 downto 0) & data_int_b_i(2)(15 downto 8) & data_int_b_i(0)(7 downto 0) & data_int_b_i(0)(15 downto 8); 
                   lanes(5) <= data_int_b_i(3)(7 downto 0) & data_int_b_i(3)(15 downto 8) & data_int_b_i(1)(7 downto 0) & data_int_b_i(1)(15 downto 8); 
                   lanes(6) <= data_int_b_q(2)(7 downto 0) & data_int_b_q(2)(15 downto 8) & data_int_b_q(0)(7 downto 0) & data_int_b_q(0)(15 downto 8); 
                   lanes(7) <= data_int_b_q(3)(7 downto 0) & data_int_b_q(3)(15 downto 8) & data_int_b_q(1)(7 downto 0) & data_int_b_q(1)(15 downto 8); 
               end if;
          end if;
       end process;
   end generate;
                                              
   jmode_14_16bit_decimation_8 : if jmode = "01110" generate
   
       adc_sample_clk <= not adc_sample_clk after rx_core_clk_half_p;
   
       data_loop_chan: for i in 0 to 1 generate 
           process(tb_rst, rx_core_clk) begin
                
               if(tb_rst = '1') then
                    data_int_a_i(i)                  <= std_logic_vector(to_unsigned(i, 16));
                    data_int_a_q(i)                  <= std_logic_vector(to_unsigned(i+32768, 16));
                    data_int_b_i(i)                  <= std_logic_vector(to_unsigned(i, 16));
                    data_int_b_q(i)                  <= std_logic_vector(to_unsigned(i+61440, 16));
                    
                    s_axis_jesd_rx_pd_tvalid       <= '0';
                    s_axis_jesd_rx_pd_tvalid_reg   <= '0';
               elsif(rising_edge(rx_core_clk)) then
                    
                    s_axis_jesd_rx_pd_tvalid     <= not tb_rst;
                    s_axis_jesd_rx_pd_tvalid_reg <= s_axis_jesd_rx_pd_tvalid;
                
                    if(s_axis_jesd_rx_pd_tvalid = '1') then
                        data_int_a_i(i)    <= data_int_a_i(i) + 2;
                        data_int_a_q(i)    <= data_int_a_q(i) + 2;
                        data_int_b_i(i)    <= data_int_b_i(i) + 2;
                        data_int_b_q(i)    <= data_int_b_q(i) + 2;
                    end if;
               end if;
           end process;
       end generate;
       
       process(tb_rst, rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if( s_axis_jesd_rx_pd_tvalid = '1') then
                   lanes(0) <= data_int_a_i(1)(7 downto 0) & data_int_a_i(1)(15 downto 8) & data_int_a_i(0)(7 downto 0) & data_int_a_i(0)(15 downto 8);
                   lanes(1) <= data_int_a_q(1)(7 downto 0) & data_int_a_q(1)(15 downto 8) & data_int_a_q(0)(7 downto 0) & data_int_a_q(0)(15 downto 8);
                   
                   lanes(2) <= (others => '0'); 
                   lanes(3) <= (others => '0'); 
                   
                   lanes(4) <= data_int_b_i(1)(7 downto 0) & data_int_b_i(1)(15 downto 8) & data_int_b_i(0)(7 downto 0) & data_int_b_i(0)(15 downto 8);
                   lanes(5) <= data_int_b_q(1)(7 downto 0) & data_int_b_q(1)(15 downto 8) & data_int_b_q(0)(7 downto 0) & data_int_b_q(0)(15 downto 8);
                   lanes(6) <= (others => '0'); 
                   lanes(7) <= (others => '0'); 
               end if;
          end if;
       end process;
   end generate;
   
   jmode_16_16bit_decimation_16 : if jmode = "10000" generate
   
       adc_sample_clk <= not adc_sample_clk after rx_core_clk_half_p;
   
       data_loop_chan: for i in 0 to 0 generate 
           process(tb_rst, rx_core_clk) begin
                
               if(tb_rst = '1') then
                    data_int_a_i(i)                  <= std_logic_vector(to_unsigned(i, 16));
                    data_int_a_q(i)                  <= std_logic_vector(to_unsigned(i+32768, 16));
                    data_int_b_i(i)                  <= std_logic_vector(to_unsigned(i, 16));
                    data_int_b_q(i)                  <= std_logic_vector(to_unsigned(i+61440, 16));
                    
                    s_axis_jesd_rx_pd_tvalid       <= '0';
                    s_axis_jesd_rx_pd_tvalid_reg   <= '0';
               elsif(rising_edge(rx_core_clk)) then
                    
                    s_axis_jesd_rx_pd_tvalid     <= not tb_rst;
                    s_axis_jesd_rx_pd_tvalid_reg <= s_axis_jesd_rx_pd_tvalid;
                
                    if(s_axis_jesd_rx_pd_tvalid = '1') then
                        data_int_a_i(i)    <= data_int_a_i(i) + 1;
                        data_int_a_q(i)    <= data_int_a_q(i) + 1;
                        data_int_b_i(i)    <= data_int_b_i(i) + 1;
                        data_int_b_q(i)    <= data_int_b_q(i) + 1;
                    end if;
               end if;
           end process;
       end generate;
       
       process(tb_rst, rx_core_clk) begin
           if(rising_edge(rx_core_clk)) then
               if( s_axis_jesd_rx_pd_tvalid = '1') then
                   lanes(0) <= data_int_a_q(0)(7 downto 0) & data_int_a_q(0)(15 downto 8) & data_int_a_i(0)(7 downto 0) & data_int_a_i(0)(15 downto 8);
                   lanes(1) <= (others => '0'); 
                   
                   lanes(2) <= (others => '0'); 
                   lanes(3) <= (others => '0'); 
                   
                   lanes(4) <= data_int_b_q(0)(7 downto 0) & data_int_b_q(0)(15 downto 8) & data_int_b_i(0)(7 downto 0) & data_int_b_i(0)(15 downto 8); 
                   lanes(5) <= (others => '0'); 
                   lanes(6) <= (others => '0'); 
                   lanes(7) <= (others => '0'); 
               end if;
          end if;
       end process;
   end generate;

    
   
   process(lanes(7), lanes(6), lanes(5), lanes(4), lanes(3), lanes(2), lanes(1), lanes(0))
   begin
       if(jmode = "00000" or jmode = "00101") then
           s_axis_jesd_rx_pd_tdata <= lanes(7) & lanes(6) & lanes(5) & lanes(4) & lanes(3) & lanes(2) & lanes(1) & lanes(0);
       else
           s_axis_jesd_rx_pd_tdata <= (not lanes(7)) & (not lanes(6)) & (not lanes(5)) & (not lanes(4)) & lanes(3) & lanes(2) & lanes(1) & lanes(0);
       end if;
   end process;

dut: px_adc12dj3200intrfc_unpack 
Port map
( 
     jmode                    => jmode(4 downto 0),
    
     jesd_buffer_fifo_rst     => jesd_buffer_fifo_rst,
     
     rx_core_clk              => rx_core_clk,
     s_axis_jesd_rx_pd_tdata  => s_axis_jesd_rx_pd_tdata,
     s_axis_jesd_rx_pd_tvalid => s_axis_jesd_rx_pd_tvalid_reg,
    
     adc_sample_clk           => adc_sample_clk,
                 
     m_axis_adc1_pd_tdata      => m_axis_adc1_pd_tdata, 
     m_axis_adc1_pd_tvalid     => m_axis_adc1_pd_tvalid,
     
     m_axis_adc2_pd_tdata      => m_axis_adc2_pd_tdata,
     m_axis_adc2_pd_tvalid     => m_axis_adc2_pd_tvalid  
    
    
    

);
 
m_axis_adc1_pd_tdata_dly  <= m_axis_adc1_pd_tdata after 1 ns;
m_axis_adc1_pd_tvalid_dly <= m_axis_adc1_pd_tvalid after 1 ns;

m_axis_adc2_pd_tdata_dly  <= m_axis_adc2_pd_tdata after 1 ns;
m_axis_adc2_pd_tvalid_dly <= m_axis_adc2_pd_tvalid after 1 ns;

--data verification for single channel modes
tb_jmodes_0_5: if jmode = "00000" or jmode = "00101" generate
   data_verification_loop: for i in 0 to 15 generate
        process(tb_rst, adc_sample_clk) begin
            if(tb_rst = '1') then
                if(jmode = "00000") then
                    m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) <= std_logic_vector(to_unsigned(i, 12)) & x"0";
                elsif(jmode = "00101") then
                    m_axis_adc1_pd_tdata_compare((i*2+1)*8 - 1 downto i*16)           <= std_logic_vector(to_unsigned(i*2,   8));
                    m_axis_adc1_pd_tdata_compare(((i*2+1)*8 - 1) + 8 downto i*16 + 8) <= std_logic_vector(to_unsigned(i*2+1, 8));
                end if;
            elsif(rising_edge(adc_sample_clk)) then
                
                if(m_axis_adc1_pd_tvalid_dly = '1') then
                    if(m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) /= m_axis_adc1_pd_tdata_dly((i+1)*16 - 1 downto i*16)) then
                        m_axis_adc1_pd_tdata_error <= '1';    
                    end if;
                    
                    if(jmode = "00000") then
                        m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) <= m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) + 256;
                    elsif(jmode = "00101") then
                        m_axis_adc1_pd_tdata_compare((i*2+1)*8 - 1 downto i*16)           <= m_axis_adc1_pd_tdata_compare((i*2+1)*8 - 1 downto i*16) + 32;
                        m_axis_adc1_pd_tdata_compare(((i*2+1)*8 - 1) + 8 downto i*16 + 8) <= m_axis_adc1_pd_tdata_compare(((i*2+1)*8 - 1) + 8 downto i*16 + 8) + 32;
                    end if;
                    
                end if;
            end if;
        end process;        
    end generate;  
end generate tb_jmodes_0_5;

--data verification for dual channel mode
tb_jmodes_2_7_9: if jmode = "00010" or jmode = "00111" or jmode = "01001" generate
   data_verification_loop: for i in 0 to 15 generate
        process(tb_rst, adc_sample_clk) begin
            if(tb_rst = '1') then
                if(jmode = "00010") then
                    m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) <= std_logic_vector(to_unsigned(i, 12)) & x"0";
                elsif(jmode = "00111") then
                    m_axis_adc1_pd_tdata_compare((i*2+1)*8 - 1 downto i*16)           <= std_logic_vector(to_unsigned(i*2,   8));
                    m_axis_adc1_pd_tdata_compare(((i*2+1)*8 - 1) + 8 downto i*16 + 8) <= std_logic_vector(to_unsigned(i*2+1, 8));
                elsif(jmode = "01001") then
                    m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) <= std_logic_vector(to_unsigned(i, 16));
                end if;
            elsif(rising_edge(adc_sample_clk)) then
                
                if(m_axis_adc1_pd_tvalid_dly = '1') then
                    if(m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) /= m_axis_adc1_pd_tdata_dly((i+1)*16 - 1 downto i*16)) then
                        m_axis_adc1_pd_tdata_error <= '1';    
                    end if;
                    
                    if(jmode = "00010") then
                        m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) <= m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) + 256;
                    elsif(jmode = "00111") then
                        m_axis_adc1_pd_tdata_compare((i*2+1)*8 - 1 downto i*16)           <= m_axis_adc1_pd_tdata_compare((i*2+1)*8 - 1 downto i*16) + 32;
                        m_axis_adc1_pd_tdata_compare(((i*2+1)*8 - 1) + 8 downto i*16 + 8) <= m_axis_adc1_pd_tdata_compare(((i*2+1)*8 - 1) + 8 downto i*16 + 8) + 32;
                    elsif(jmode = "01001") then
                        m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) <= m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) + 16;
                    end if;
                    
                end if;
            end if;
        end process;
        
        process(tb_rst, adc_sample_clk) begin
            if(tb_rst = '1') then
                if(jmode = "00010") then
                    m_axis_adc2_pd_tdata_compare((i+1)*16 - 1 downto i*16) <= std_logic_vector(to_unsigned(i+2048, 12)) & x"0";
                elsif(jmode = "00111") then
                    m_axis_adc2_pd_tdata_compare((i*2+1)*8 - 1 downto i*16)           <= std_logic_vector(to_unsigned(i*2+128,   8));
                    m_axis_adc2_pd_tdata_compare(((i*2+1)*8 - 1) + 8 downto i*16 + 8) <= std_logic_vector(to_unsigned(i*2+1+128, 8));
                elsif(jmode = "01001") then
                    m_axis_adc2_pd_tdata_compare((i+1)*16 - 1 downto i*16) <= std_logic_vector(to_unsigned(i+32768, 16));
                end if;
            elsif(rising_edge(adc_sample_clk)) then
                
                if(m_axis_adc2_pd_tvalid_dly = '1') then
                    if(m_axis_adc2_pd_tdata_compare((i+1)*16 - 1 downto i*16) /= m_axis_adc2_pd_tdata_dly((i+1)*16 - 1 downto i*16)) then
                        m_axis_adc2_pd_tdata_error <= '1';    
                    end if;
                    
                    if(jmode = "00010") then
                        m_axis_adc2_pd_tdata_compare((i+1)*16 - 1 downto i*16) <= m_axis_adc2_pd_tdata_compare((i+1)*16 - 1 downto i*16) + 256;
                     elsif(jmode = "00111") then
                        m_axis_adc2_pd_tdata_compare((i*2+1)*8 - 1 downto i*16)           <= m_axis_adc2_pd_tdata_compare((i*2+1)*8 - 1 downto i*16) + 32;
                        m_axis_adc2_pd_tdata_compare(((i*2+1)*8 - 1) + 8 downto i*16 + 8) <= m_axis_adc2_pd_tdata_compare(((i*2+1)*8 - 1) + 8 downto i*16 + 8) + 32;
                    elsif(jmode = "01001") then
                        m_axis_adc2_pd_tdata_compare((i+1)*16 - 1 downto i*16) <= m_axis_adc2_pd_tdata_compare((i+1)*16 - 1 downto i*16) + 16;
                    end if;
                    
                end if;
            end if;
        end process;
    end generate;  
end generate tb_jmodes_2_7_9;


tb_jmodes_11_14_16: if jmode = "01011" or jmode = "01110" or jmode = "10000" generate
   data_verification_loop: for i in 0 to 7 generate
        process(tb_rst, adc_sample_clk) begin
            if(tb_rst = '1') then
                if( jmode = "01011" or jmode = "01110" or jmode = "10000") then
                    m_axis_adc1_pd_tdata_compare((i*2+1)*16 - 1 downto 2*i*16)             <= std_logic_vector(to_unsigned(i, 16));
                    m_axis_adc1_pd_tdata_compare(((i*2+1)*16 - 1) + 16 downto 2*i*16 + 16) <= std_logic_vector(to_unsigned(i+32768, 16));
                end if;
            elsif(rising_edge(adc_sample_clk)) then
                
                if(m_axis_adc1_pd_tvalid_dly = '1') then
                    if(m_axis_adc1_pd_tdata_compare((i+1)*16 - 1 downto i*16) /= m_axis_adc1_pd_tdata_dly((i+1)*16 - 1 downto i*16)) then
                        m_axis_adc1_pd_tdata_error <= '1';    
                    end if;
                    
                    if(jmode = "01011" or jmode = "01110" or jmode = "10000") then
                        m_axis_adc1_pd_tdata_compare((i*2+1)*16 - 1 downto 2*i*16)             <= m_axis_adc1_pd_tdata_compare((i*2+1)*16 - 1 downto 2*i*16) + 8;
                        m_axis_adc1_pd_tdata_compare(((i*2+1)*16 - 1) + 16 downto 2*i*16 + 16) <= m_axis_adc1_pd_tdata_compare(((i*2+1)*16 - 1) + 16 downto 2*i*16 + 16) + 8;
                    end if;
                    
                end if;
            end if;
        end process;
        
        process(tb_rst, adc_sample_clk) begin
            if(tb_rst = '1') then
                if( jmode = "01011" or jmode = "01110" or jmode = "10000") then
                    m_axis_adc2_pd_tdata_compare((i*2+1)*16 - 1 downto 2*i*16)             <= std_logic_vector(to_unsigned(i, 16));
                    m_axis_adc2_pd_tdata_compare(((i*2+1)*16 - 1) + 16 downto 2*i*16 + 16) <= std_logic_vector(to_unsigned(i+61440, 16));
                end if;
            elsif(rising_edge(adc_sample_clk)) then
                
                if(m_axis_adc2_pd_tvalid_dly = '1') then
                    if(m_axis_adc2_pd_tdata_compare((i+1)*16 - 1 downto i*16) /= m_axis_adc2_pd_tdata_dly((i+1)*16 - 1 downto i*16)) then
                        m_axis_adc2_pd_tdata_error <= '1';    
                    end if;
                    
                    if(jmode = "01011" or jmode = "01110" or jmode = "10000") then
                        m_axis_adc2_pd_tdata_compare((i*2+1)*16 - 1 downto 2*i*16)             <= m_axis_adc2_pd_tdata_compare((i*2+1)*16 - 1 downto 2*i*16) + 8;
                        m_axis_adc2_pd_tdata_compare(((i*2+1)*16 - 1) + 16 downto 2*i*16 + 16) <= m_axis_adc2_pd_tdata_compare(((i*2+1)*16 - 1) + 16 downto 2*i*16 + 16) + 8;
                    end if;
                    
                end if;
            end if;
        end process;
        
    end generate;  
end generate tb_jmodes_11_14_16;






end Behavioral;
