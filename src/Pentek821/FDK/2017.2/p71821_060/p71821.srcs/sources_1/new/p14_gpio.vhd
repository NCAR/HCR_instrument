library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity p14_gpio is
port ( 

    ADC_CLK         : in  STD_LOGIC;

    P14GPIO_P       : inout STD_LOGIC_VECTOR( 23 downto 0 );
    P14GPIO_N       : inout STD_LOGIC_VECTOR( 23 downto 0 );

    CONTROL_FLAGS   : in  STD_LOGIC_VECTOR ( 31 downto 0 );
    MT_PULSE        : in  STD_LOGIC_VECTOR ( 7 downto 0 );
    PPS             : out STD_LOGIC;
    STATUS_FLAGS    : out STD_LOGIC_VECTOR ( 15 downto 0 );
    ROT_A           : out STD_LOGIC;
    ROT_B           : out STD_LOGIC;
    TILT_A          : out STD_LOGIC;
    TILT_B          : out STD_LOGIC;
    AZ_MOSI         : out STD_LOGIC;
    AZ_SCK          : out STD_LOGIC;
    AZ_SSEL         : out STD_LOGIC;
    EL_MOSI         : out STD_LOGIC;
    EL_SCK          : out STD_LOGIC
    
);
end p14_gpio;


architecture p14_gpio of p14_gpio is

    signal mt0_sync      : std_logic;
    signal mt1_adc_ch0   : std_logic;
    signal mt2_adc_ch1   : std_logic;
    signal mt3_adc_ch2   : std_logic;
    signal mt4_dac       : std_logic;
    signal mt5_mod_pulse : std_logic;
    signal mt6_ems_trig  : std_logic;
    signal mt7_spare     : std_logic;

begin

-- J5    P14          Signal         J5      P14         Signal
-----------------------------------------------------------------
-- A1    GND                         B1    GND           
-- A2    LVDS_P(16)                  B2    LVDS_N(16)    
-- A3    LVDS_P(0)                   B3    LVDS_N(0)     
-- A4    LVDS_P(17)                  B4    LVDS_N(17)    
-- A5    LVDS_P(1)                   B5    LVDS_N(1)     
-- A6    LVDS_P(18)                  B6    LVDS_N(18)    
-- A7    LVDS_P(2)                   B7    LVDS_N(2)     
-- A8    LVDS_P(19)                  B8    LVDS_N(19)    
-- A9    LVDS_P(3)                   B9    LVDS_N(3)     
-- A10   LVDS_P(20)                  B10   LVDS_N(20)    SYNC_PULSE
-- A11   LVDS_P(4)                   B11   LVDS_N(4)     
-- A12   LVDS_P(21)                  B12   LVDS_N(21)    
-- A13   LVDS_P(5)                   B13   LVDS_N(5)     
-- A14   LVDS_P(22)   MOD_PULSE      B14   LVDS_N(22)    TIMER5
-- A15   LVDS_P(6)                   B15   LVDS_N(6)     
-- A16   LVDS_P(23)   RX_GATE        B16   LVDS_N(23)    TX_GATE
-- A17   LVDS_P(7)    PPS            B17   LVDS_N(7)     
-- A18   NC                          B18   NC            
-- A19   LVDS_P(8)                   B19   LVDS_N(8)     
-- A20   NC                          B20   NC            
-- A21   LVDS_P(9)                   B21   LVDS_N(9)     
-- A22   NC                          B22   NC            
-- A23   LVDS_P(10)                  B23   LVDS_N(10)    
-- A24   NC                          B24   NC            
-- A25   LVDS_P(11)                  B25   LVDS_N(11)    
-- A26   NC                          B26   NC            
-- A27   LVDS_P(12)                  B27   LVDS_N(12)    
-- A28   NC                          B28   NC            
-- A29   LVDS_P(13)                  B29   LVDS_N(13)    
-- A30   NC                          B30   NC            
-- A31   LVDS_P(14)                  B31   LVDS_N(14)    
-- A32   NC                          B32   NC            
-- A33   LVDS_P(15)                  B33   LVDS_N(15)    
-- A34   GND                         B34   GND           


    PPS             <= P14GPIO_P(7);
    ROT_A           <= '0';
    ROT_B           <= '0';
    TILT_A          <= '0';
    TILT_B          <= '0';
    AZ_MOSI         <= '0';
    AZ_SCK          <= '0';
    AZ_SSEL         <= '0';
    EL_MOSI         <= '0';
    EL_SCK          <= '0';

    output_regs : process(ADC_CLK)
    begin
        
        mt0_sync      <= MT_PULSE(0);
        mt1_adc_ch0   <= MT_PULSE(1);
        mt2_adc_ch1   <= MT_PULSE(2);
        mt3_adc_ch2   <= MT_PULSE(3);
        mt4_dac       <= MT_PULSE(4);
        mt5_mod_pulse <= MT_PULSE(5);
        mt6_ems_trig  <= MT_PULSE(6);
        mt7_spare     <= MT_PULSE(7);
        
        P14GPIO_N(20) <= mt0_sync;
        P14GPIO_P(23) <= mt1_adc_ch0;
        P14GPIO_N(23) <= mt4_dac;
        P14GPIO_P(22) <= mt5_mod_pulse;
        P14GPIO_N(22) <= mt6_ems_trig;

    end process output_regs;

end architecture p14_gpio;