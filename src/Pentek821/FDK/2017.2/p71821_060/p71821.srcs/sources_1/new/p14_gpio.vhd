library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity p14_gpio is
generic (
    INSTANTIATE_TEST_PATTERN : boolean := false
);
port ( 

    CLK             : in  std_logic;
    CLK_DAC         : in  std_logic;

    LVDS_P          : inout std_logic_vector(23 downto 0);
    LVDS_N          : inout std_logic_vector(23 downto 0);

    out_test        : in  std_logic_vector(6 downto 1) := (others=>'0'); 
    out_spare       : in  std_logic := '0';   
    out_rxgate      : in  std_logic := '0';
    out_txgate      : in  std_logic := '0';
    out_sync        : in  std_logic := '0'; 

    in_tqs          : out std_logic := '0';
    in_pps          : out std_logic := '0';
    in_spare1       : out std_logic := '0';    
    in_spare2       : out std_logic := '0'

);
end p14_gpio;


architecture p14_gpio of p14_gpio is

    signal sig_out_test        : std_logic_vector(8 downto 1) := (others=>'0');
    signal sig_out_spare       : std_logic;   
    signal sig_out_rxgate      : std_logic;
    signal sig_out_txgate      : std_logic;
    signal sig_out_sync        : std_logic; 
    signal sig_in_tqs          : std_logic;
    signal sig_in_pps          : std_logic;
    signal sig_in_spare1       : std_logic;    
    signal sig_in_spare2       : std_logic;
    signal test_word           : std_logic_vector(11 downto 0) := (others=>'0'); 
    signal test_counter        : unsigned(15 downto 0) := (others=>'0'); 
    
begin

    ---------------------------------------------------
    -- Actual 7807 pinout - the Pentek doc is wrong! --
    ---------------------------------------------------
    
    -- J5    Signal       Outputs   Inputs
    ----------------------------------------
    -- A1    GND
    -- A2    LVDS_P(16)   SYNC  
    -- A3    LVDS_P(0)              PPS
    -- A4    LVDS_P(17)   RXGATE  
    -- A5    LVDS_P(1)              TQS
    -- A6    LVDS_P(18)             SPAREIN1
    -- A7    LVDS_P(2)    TXGATE  
    -- A8    LVDS_P(19)             SPAREIN2
    -- A9    LVDS_P(3)    SPAREOUT  
    -- A10   LVDS_P(20)   TEST1  
    -- A11   LVDS_P(4)    TEST2  
    -- A12   LVDS_P(21)   TEST3  
    -- A13   LVDS_P(5)    TEST4  
    -- A14   LVDS_P(22)   TEST5  
    -- A15   LVDS_P(6)    TEST6  
    -- A16   LVDS_P(23)   TEST7  
    -- A17   LVDS_P(7)    TEST8  
    -- A18   NC
    -- A19   LVDS_P(8)    
    -- A20   NC
    -- A21   LVDS_P(9)    
    -- A22   NC
    -- A23   LVDS_P(10)    
    -- A24   NC
    -- A25   LVDS_P(11)    
    -- A26   NC
    -- A27   LVDS_P(12)    
    -- A28   NC
    -- A29   LVDS_P(13)    
    -- A30   NC
    -- A31   LVDS_P(14)    
    -- A32   NC
    -- A33   LVDS_P(15)    
    -- A34   GND   



    --Instantiate IOB registers
    GEN_REGS : if not INSTANTIATE_TEST_PATTERN generate
        
        REGS_PROC : process (CLK)
        begin
        
            if rising_edge(CLK) then
            
                sig_out_test(6 downto 1) <= out_test(6 downto 1);   
                sig_out_test(7)     <= not sig_out_test(7); --adc clock /2
                sig_out_spare       <= not out_spare; --unsure where this is reversed
                sig_out_rxgate      <= out_rxgate; 
                sig_out_sync        <= out_sync;
                
                in_tqs              <= sig_in_tqs;  
                in_pps              <= sig_in_pps;
                in_spare1           <= sig_in_spare1;  
                in_spare2           <= sig_in_spare2;
                
            end if;
            
        end process;
        
        REGS2_PROC : process (CLK_DAC)
        begin        
            if rising_edge(CLK_DAC) then            
                sig_out_test(8)     <= not sig_out_test(8); -- dac clock /2
                sig_out_txgate      <= out_txgate;
            end if;            
        end process;        
    
    end generate;

    -- Instantiate a test pattern
    -- Echo the 4 inputs to test(4 downto 1)
    -- Counting pattern for the remaining outputs
    GEN_TEST : if INSTANTIATE_TEST_PATTERN generate
        
        TEST_PROC : process (CLK)
        begin
        
            if rising_edge(CLK) then
            
                test_counter        <= test_counter + 1;
            
                sig_out_test        <= test_word(7 downto 0);   
                sig_out_spare       <= test_word(8);
                sig_out_rxgate      <= test_word(9);
                sig_out_txgate      <= test_word(10);
                sig_out_sync        <= test_word(11);

                test_word(0)        <= sig_in_tqs;  
                test_word(1)        <= sig_in_pps;
                test_word(2)        <= sig_in_spare1;  
                test_word(3)        <= sig_in_spare2;

                test_word(11 downto 4) <= std_logic_vector(test_counter(15 downto 8));
                
            end if;
            
        end process;
        
    end generate;


    -- OUTPUTS
    
    -- Testpoint vector

    out_test1_obuf : OBUFDS
    port map (
        O     => LVDS_P(20),
        OB    => LVDS_N(20),
        I     => sig_out_test(1)
    );

    out_test2_obuf : OBUFDS
    port map (
        O     => LVDS_P(4),
        OB    => LVDS_N(4),
        I     => sig_out_test(2)
    );

    out_test3_obuf : OBUFDS
    port map (
        O     => LVDS_P(21),
        OB    => LVDS_N(21),
        I     => sig_out_test(3)
    );

    out_test4_obuf : OBUFDS
    port map (
        O     => LVDS_P(5),
        OB    => LVDS_N(5),
        I     => sig_out_test(4)
    );

    out_test5_obuf : OBUFDS
    port map (
        O     => LVDS_P(22),
        OB    => LVDS_N(22),
        I     => sig_out_test(5)
    );

    out_test6_obuf : OBUFDS
    port map (
        O     => LVDS_P(6),
        OB    => LVDS_N(6),
        I     => sig_out_test(6)
    );

    out_test7_obuf : OBUFDS
    port map (
        O     => LVDS_P(23),
        OB    => LVDS_N(23),
        I     => sig_out_test(7)
    );

    out_test8_obuf : OBUFDS
    port map (
        O     => LVDS_P(7),
        OB    => LVDS_N(7),
        I     => sig_out_test(8)
    );
    
    -- Misc outputs
    
    out_spare_obuf : OBUFDS
    port map (
        O     => LVDS_P(3),
        OB    => LVDS_N(3),
        I     => sig_out_spare
    ); 

    out_rxgate_obuf : OBUFDS
    port map (
        O     => LVDS_P(17),
        OB    => LVDS_N(17),
        I     => sig_out_rxgate
    );

    out_txgate_obuf : OBUFDS
    port map (
        O     => LVDS_P(2),
        OB    => LVDS_N(2),
        I     => sig_out_txgate
    );

    out_sync_obuf : OBUFDS
    port map (
        O     => LVDS_P(16),
        OB    => LVDS_N(16),
        I     => sig_out_sync
    );

    --Unconnected in adjunct board
    
    spare_buf0 : OBUFDS
    port map (
        O     => LVDS_P(8),
        OB    => LVDS_N(8),
        I     => '0'
    );
    
    spare_buf1 : OBUFDS
    port map (
        O     => LVDS_P(9),
        OB    => LVDS_N(9),
        I     => '0'
    );

    spare_buf2 : OBUFDS
    port map (
        O     => LVDS_P(10),
        OB    => LVDS_N(10),
        I     => '0'
    );

    spare_buf3 : OBUFDS
    port map (
        O     => LVDS_P(11),
        OB    => LVDS_N(11),
        I     => '0'
    );

    spare_buf4 : OBUFDS
    port map (
        O     => LVDS_P(12),
        OB    => LVDS_N(12),
        I     => '0'
    );

    spare_buf5 : OBUFDS
    port map (
        O     => LVDS_P(13),
        OB    => LVDS_N(13),
        I     => '0'
    );

    spare_buf6 : OBUFDS
    port map (
        O     => LVDS_P(14),
        OB    => LVDS_N(14),
        I     => '0'
    );

    spare_buf7 : OBUFDS
    port map (
        O     => LVDS_P(15),
        OB    => LVDS_N(15),
        I     => '0'
    );    

    -- INPUTS

    in_tqs_ibuf : IBUFDS
    port map (
        I     => LVDS_P(1),
        IB    => LVDS_N(1),
        O     => sig_in_tqs
    );
    
    in_pps_ibuf : IBUFDS
    port map (
        I     => LVDS_P(0),
        IB    => LVDS_N(0),
        O     => sig_in_pps
    );

    in_spare1_ibuf : IBUFDS
    port map (
        I     => LVDS_P(18),
        IB    => LVDS_N(18),
        O     => sig_in_spare1
    );

    in_spare2_ibbuf : IBUFDS
    port map (
        I     => LVDS_P(19),
        IB    => LVDS_N(19),
        O     => sig_in_spare2
    );    


end architecture p14_gpio;