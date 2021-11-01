library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity p14_gpio is
port (
    ADC_CLK                 : in  STD_LOGIC;
    P14GPIO_P               : inout STD_LOGIC_VECTOR( 23 downto 0 ) := (others=>'Z');
    P14GPIO_N               : inout STD_LOGIC_VECTOR( 23 downto 0 ) := (others=>'Z');
    CONTROLLER_RUNNING      : in  STD_LOGIC;
    CONTROL_FLAGS           : in  STD_LOGIC_VECTOR ( 31 downto 0 );
    CONTROL_HVn             : in  STD_LOGIC;
    PPS_TO_CONTROLLER_IN    : in  STD_LOGIC;
    PPS_TO_CONTROLLER_OUT   : out STD_LOGIC;
    MT_PULSE                : in  STD_LOGIC_VECTOR ( 7 downto 0 );
    GPR_CTL3_OUT            : in  STD_LOGIC_VECTOR ( 31 downto 0 );
    PPS_FROM_GPIO           : out STD_LOGIC := '0';
    STATUS_FLAGS            : out STD_LOGIC_VECTOR ( 15 downto 0 ) := (others=>'0');
    ROT_A                   : out STD_LOGIC := '0';
    ROT_B                   : out STD_LOGIC := '0';
    TILT_A                  : out STD_LOGIC := '0';
    TILT_B                  : out STD_LOGIC := '0';
    TILT_Z                  : out STD_LOGIC := '0';
    SPARE_PENTEK2           : out STD_LOGIC := '0';
    AZ_MOSI                 : out STD_LOGIC := '0';
    AZ_SCK                  : out STD_LOGIC := '0';
    AZ_SSEL                 : out STD_LOGIC := '0';
    EL_MOSI                 : out STD_LOGIC := '0';
    EL_SCK                  : out STD_LOGIC := '0';
    EL_SSEL                 : out STD_LOGIC := '0'
);
end p14_gpio;


architecture p14_gpio of p14_gpio is

    --PMC card Pn4 pinout map    
    --In HCR, the odd Pn4 pins are used as outputs

    signal Pn4_1                : std_logic := '0';
    signal Pn4_3                : std_logic := '0';
    signal Pn4_5                : std_logic := '0';
    signal Pn4_7                : std_logic := '0';
    signal Pn4_9                : std_logic := '0';
    signal Pn4_11               : std_logic := '0';
    signal Pn4_13               : std_logic := '0';
    signal Pn4_15               : std_logic := '0';
    signal Pn4_17               : std_logic := '0';
    signal Pn4_19               : std_logic := '0';
    signal Pn4_21               : std_logic := '0';
    signal Pn4_23               : std_logic := '0';
    signal Pn4_25               : std_logic := '0';
    signal Pn4_27               : std_logic := '0';
    signal Pn4_29               : std_logic := '0';
    signal Pn4_31               : std_logic := '0';

    signal Pn4_2                : std_logic := '0';
    signal Pn4_4                : std_logic := '0';
    signal Pn4_6                : std_logic := '0';
    signal Pn4_8                : std_logic := '0';
    signal Pn4_10               : std_logic := '0';
    signal Pn4_12               : std_logic := '0';
    signal Pn4_14               : std_logic := '0';
    signal Pn4_16               : std_logic := '0';
    signal Pn4_18               : std_logic := '0';
    signal Pn4_20               : std_logic := '0';
    signal Pn4_22               : std_logic := '0';
    signal Pn4_24               : std_logic := '0';
    signal Pn4_26               : std_logic := '0';
    signal Pn4_28               : std_logic := '0';
    signal Pn4_30               : std_logic := '0';
    signal Pn4_32               : std_logic := '0';
    signal Pn4_34               : std_logic := '0';
    signal Pn4_36               : std_logic := '0';
    signal Pn4_38               : std_logic := '0';
    signal Pn4_40               : std_logic := '0';
    signal Pn4_42               : std_logic := '0';
    signal Pn4_44               : std_logic := '0';
    signal Pn4_46               : std_logic := '0';
    signal Pn4_48               : std_logic := '0';
    signal Pn4_50               : std_logic := '0';
    signal Pn4_52               : std_logic := '0';
    signal Pn4_54               : std_logic := '0';
    signal Pn4_56               : std_logic := '0';
    signal Pn4_58               : std_logic := '0';
    signal Pn4_60               : std_logic := '0';
    signal Pn4_62               : std_logic := '0';
    signal Pn4_64               : std_logic := '0';

    alias hcr_mt0_sync          : std_logic is MT_PULSE(0);
    alias hcr_mt1_adc_ch0       : std_logic is MT_PULSE(1);
    alias hcr_mt2_adc_ch1       : std_logic is MT_PULSE(2);
    alias hcr_mt3_adc_ch2       : std_logic is MT_PULSE(3);    
    alias hcr_mt4_dac           : std_logic is MT_PULSE(4);
    alias hcr_mt5_mod_pulse     : std_logic is MT_PULSE(5);
    alias hcr_mt6_ems_trig      : std_logic is MT_PULSE(6);
    alias hcr_mt7_spare         : std_logic is MT_PULSE(7);
    
    signal ext_clk              : std_logic := '0';
    signal ext_clk_counter      : unsigned(3 downto 0) := (others=>'0');
    
    signal sync_pulse_clk       : std_logic := '0';
    signal sync_pulse_counter   : unsigned(7 downto 0) := (others=>'0');

    signal controller_run_reg   : std_logic := '0';
    signal pps_to_controller_in_reg : std_logic := '0';
    signal pps_edge             : std_logic := '0';

    --If you wanted to do multiple radars with one bitstream, this could be set by software
    constant RADAR_TYPE_HCR     : std_logic_vector(3 downto 0) := x"0";
    signal radar_type           : std_logic_vector(3 downto 0) := RADAR_TYPE_HCR;

begin

    --Registered in Pentek logic
    PPS_FROM_GPIO   <= Pn4_2;

    --IOB registers
    --Don't do anything funny here, or it won't use the IOB flop
    IOB_REGS : process(ADC_CLK)
    begin
        if rising_edge(ADC_CLK) then

            P14GPIO_N(16)   <= Pn4_1 ;
            P14GPIO_P(16)   <= Pn4_3 ;
            P14GPIO_N(17)   <= Pn4_5 ;
            P14GPIO_P(17)   <= Pn4_7 ;
            P14GPIO_N(18)   <= Pn4_9 ;
            P14GPIO_P(18)   <= Pn4_11;
            P14GPIO_N(19)   <= Pn4_13;
            P14GPIO_P(19)   <= Pn4_15;
            P14GPIO_N(20)   <= Pn4_17;
            P14GPIO_P(20)   <= Pn4_19;
            P14GPIO_N(21)   <= Pn4_21;
            P14GPIO_P(21)   <= Pn4_23;
            P14GPIO_N(22)   <= Pn4_25;
            P14GPIO_P(22)   <= Pn4_27;
            P14GPIO_N(23)   <= Pn4_29;
            P14GPIO_P(23)   <= Pn4_31;

            --Pn4_2;          <= P14GPIO_N(0 );
            Pn4_4           <= P14GPIO_P(0 );
            Pn4_6           <= P14GPIO_N(1 );
            Pn4_8           <= P14GPIO_P(1 );
            Pn4_10          <= P14GPIO_N(2 );
            Pn4_12          <= P14GPIO_P(2 );
            Pn4_14          <= P14GPIO_N(3 );
            Pn4_16          <= P14GPIO_P(3 );
            Pn4_18          <= P14GPIO_N(4 );
            Pn4_20          <= P14GPIO_P(4 );
            Pn4_22          <= P14GPIO_N(5 );
            Pn4_24          <= P14GPIO_P(5 );
            Pn4_26          <= P14GPIO_N(6 );
            Pn4_28          <= P14GPIO_P(6 );
            Pn4_30          <= P14GPIO_N(7 );
            Pn4_32          <= P14GPIO_P(7 );
            Pn4_34          <= P14GPIO_N(8 );
            Pn4_36          <= P14GPIO_P(8 );
            Pn4_38          <= P14GPIO_N(9 );
            Pn4_40          <= P14GPIO_P(9 );
            Pn4_42          <= P14GPIO_N(10);
            Pn4_44          <= P14GPIO_P(10);
            Pn4_46          <= P14GPIO_N(11);
            Pn4_48          <= P14GPIO_P(11);
            Pn4_50          <= P14GPIO_N(12);
            Pn4_52          <= P14GPIO_P(12);
            Pn4_54          <= P14GPIO_N(13);
            Pn4_56          <= P14GPIO_P(13);
            Pn4_58          <= P14GPIO_N(14);
            Pn4_60          <= P14GPIO_P(14);
            Pn4_62          <= P14GPIO_N(15);
            Pn4_64          <= P14GPIO_P(15);

        end if;
    end process;

    RADAR_SPECIFIC_REGS : process(ADC_CLK)
    begin
        if rising_edge(ADC_CLK) then

            case radar_type is
                when RADAR_TYPE_HCR =>

                    --Register inputs                       -- Schematic name --
                    ROT_A           <= Pn4_6;
                    ROT_B           <= Pn4_10;
                    STATUS_FLAGS(0) <= Pn4_14;              -- HV_FLAG (old ROTZ)
                    TILT_A          <= Pn4_18;
                    TILT_B          <= Pn4_22;
                    TILT_Z          <= Pn4_26;
                    SPARE_PENTEK2   <= Pn4_30;

                    --Register outputs
                    Pn4_1           <= hcr_mt0_sync;        -- T0
                    Pn4_3           <= hcr_mt1_adc_ch0;     -- RX_GATE
                    Pn4_5           <= CONTROL_HVn;         -- TX_GATE
                    Pn4_7           <= hcr_mt5_mod_pulse;   -- MOD_PULSE
                    Pn4_9           <= hcr_mt6_ems_trig;    -- EMS_TRIG
                    Pn4_11          <= Pn4_6;  --rot b      -- TIMER6
                    Pn4_13          <= Pn4_10; --rot a      -- TIMER7
                    Pn4_15          <= '0';                 -- SPARE_PENTEK0
                    Pn4_17          <= '0';                 -- SPARE_PENTEK1
                    Pn4_19          <= '0';                 -- ground
                    Pn4_21          <= sync_pulse_clk;      -- SYNC_PULSE
                    Pn4_23          <= '0';                 -- ground
                    Pn4_25          <= ext_clk;             -- EXT_CLK
                    Pn4_27          <= '0';                 -- ground

                when others =>
            end case;                

        end if;
    end process RADAR_SPECIFIC_REGS;
    
    --Generate ext_clk and sync_pulse_clk
    CLK_GENS : process(ADC_CLK)    
        variable wrap : unsigned(3 downto 0);
    begin
        if rising_edge(ADC_CLK) then

            --Generate ext_clk by dividing adc_clk by a programmable amount
            wrap                        := unsigned(GPR_CTL3_OUT(3 downto 0)) - 1;

            if ext_clk_counter = (wrap srl 1) then
                ext_clk                 <= '0';
            end if;
            
            if ext_clk_counter = wrap then
                ext_clk_counter         <= (others=>'0');
                ext_clk                 <= '1';

                --Create PPS aligned to ext_clk
                PPS_TO_CONTROLLER_OUT   <= PPS_edge;
                PPS_edge                <= '0';
            else
                ext_clk_counter         <= ext_clk_counter + 1;
            end if;
            
            -- Set PPS_edge on rising edge of PPS
            pps_to_controller_in_reg    <= PPS_TO_CONTROLLER_IN;
            if PPS_TO_CONTROLLER_IN = '1' and pps_to_controller_in_reg = '0' then
                PPS_edge                <= '1';
            end if;             

            --Generate sync_pulse_clk by dividing ext_clk by 72
            if ext_clk_counter = 0 then

                if sync_pulse_counter = 35 then
                    sync_pulse_clk      <= '0';
                end if;
                
                if sync_pulse_counter = 71 then
                    sync_pulse_counter  <= (others=>'0');
                    sync_pulse_clk      <= '1';
                else
                    sync_pulse_counter  <= sync_pulse_counter + 1;
                end if;

            end if;

            --Resync when the controller scheduler starts up
            controller_run_reg <= CONTROLLER_RUNNING;
            if CONTROLLER_RUNNING = '1' and controller_run_reg = '0' then
   --             sync_pulse_counter      <= (others=>'0');
            end if;

        end if;
    end process CLK_GENS;        
  

end architecture p14_gpio;
