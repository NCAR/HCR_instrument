----------------------------------------------------------------------------
-- Company:        NCAR/EOL
-- Engineer:       Karboski
--
-- Create Date:    07/06/2021
-- Module Name:    x_HMC_src
-- Project Name:   HCR
--
-- Revision:
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity x_HMC_src is
    generic (
        C_EMS_DELAY         : integer := 20;
        C_U6_DELAY          : integer := 62500000;
        C_HV_DELAY          : integer := 62500000;
        C_WG_DELAY          : integer := 6250000
    );
    port (

        --            cPCI Signals
        RESETn_CPCI         : in  std_logic; -- cPCI reset line

        --            Pentek Timing Signals (Connector PN 4)
        T0                  : in  std_logic;
        MOD_PULSE           : in  std_logic;
        EMS_TRIG            : in  std_logic;
        RX_GATE             : in  std_logic;
        HVn_CMD_PENTEK      : in  std_logic; -- HVn command from the Pentek. Was TX_GATE
        EXT_CLK             : in  std_logic; -- 15.625 MHz clock;    125 MHz/8
        SYNC_PULSE_CLK      : in  std_logic; -- 217.01389 kHz clock; 125 MHz/8/72
        HVn_FLAG            : out std_logic; -- HVn confirmation to Pentek.

        --            GPS input
        --ONE_PPS             : in  std_logic;

        --            Power Monitoring
        EMS_PWR_ERROR       : in  std_logic;

        --            PMC730 Commands
        HV_ON_730n          : in  std_logic; -- High voltage cmd from PMC730
        FIL_ON_730n         : in  std_logic; -- Filament on cmd from PMC730
        OPS_MODE_730        : in  std_logic_vector(2 downto 0); -- Operationsl mode cmd from PMC730
        STATUS_ACK          : in  std_logic; -- Status receipt acknowledgement

        --            EMS latching circulator Built in Test (BIT) complementary inputs
        BIT_EMS             : in  std_logic_vector(7 downto 1); -- EMS latching circulator BIT

        --            EMS latching circulator complementary control signals
        EMS_OUT             : out std_logic_vector(7 downto 1); -- EMS latching circulator outputs

        --            Modulator timing and control signals
        MOD_PULSE_HMC       : out std_logic;
        SYNC_PULSE_HMC      : out std_logic;
        HV_ON_HMCn          : out std_logic;
        FIL_ON_HMCn         : out std_logic;

        --            Noise source calibration control

        WG_SW_TERMn         : in  std_logic; -- BIT indication when waveguide switch is into load
        WG_SW_NOISEn        : in  std_logic; -- BIT indication when waveguide switch is into noise source
        WG_SW_CTRL_TERMn    : out std_logic; -- Terminate waveguide switch into load
        WG_SW_CTRL_NOISEn   : out std_logic; -- Terminate waveguide switch into noise source
        NOISE_SOURCE_EN     : out std_logic; -- Turn on noise source
        WG_SW_ERROR         : out std_logic; -- Waveguide switch BIT doesn't match command

        --            Status information
        MOD_PULSE_DISABLE   : out std_logic; -- Fault sum status
        EMS_ERROR_1         : out std_logic; -- EMS switch 1 BIT error
        EMS_ERROR_2         : out std_logic; -- EMS switch 2 BIT error
        EMS_ERROR_3         : out std_logic; -- EMS switch 3 BIT error
        EMS_ERROR_45        : out std_logic; -- EMS switch 4,5 BIT error
        EMS_ERROR_67        : out std_logic; -- EMS switch 6,7 BIT error
        EMS_ERROR_EVENT     : out std_logic; -- EMS switch BIT error count

        --            General spares
        TEST_BIT_0          : in  std_logic;
        TEST_BIT_1          : in  std_logic;
        SPARE_STATUS0       : out std_logic;
        SPARE_STATUS1       : out std_logic;

        --            U6 Output Enable control, allows Pentek to be discovered on PCI bus
        U6_OEn              : out std_logic;

        --            Route spare connector (P3)
        SPARE2              : out std_logic;
        SPARE3              : out std_logic
    );
end x_HMC_src;

architecture x_HMC_src of x_HMC_src is

    component HMC_src is
    generic (
        C_EMS_DELAY             : integer;
        C_U6_DELAY              : integer;
        C_HV_DELAY              : integer;
        C_WG_DELAY              : integer
    );
    port (
        RESETn                  : in  std_logic;
        CLK                     : in  std_logic;
        T0                      : in  std_logic;
        MOD_PULSE               : in  std_logic;
        EMS_TRIG                : in  std_logic;
        RX_GATE                 : in  std_logic;
        HVn_CMD_PENTEK          : in  std_logic;
        SYNC_PULSE_CLK          : in  std_logic;
        HVn_FLAG                : out std_logic;
        --ONE_PPS                 : in  std_logic;
        EMS_PWR_ERROR           : in  std_logic;
        HV_ON_730n              : in  std_logic;
        FIL_ON_730n             : in  std_logic;
        OPS_MODE_730            : in  std_logic_vector(2 downto 0);
        STATUS_ACK              : in  std_logic;
        BIT_EMS                 : in  std_logic_vector(7 downto 1);
        EMS_OUT                 : out std_logic_vector(7 downto 1);
        MOD_PULSE_HMC           : out std_logic;
        SYNC_PULSE_HMC          : out std_logic;
        HV_ON_HMCn              : out std_logic;
        FIL_ON_HMCn             : out std_logic;
        WG_SW_TERMn             : in  std_logic;
        WG_SW_NOISEn            : in  std_logic;
        WG_SW_CTRL_TERMn        : out std_logic;
        WG_SW_CTRL_NOISEn       : out std_logic;
        NOISE_SOURCE_EN         : out std_logic;
        WG_SW_ERROR             : out std_logic;
        MOD_PULSE_DISABLE       : out std_logic;
        EMS_ERROR_1             : out std_logic;
        EMS_ERROR_2             : out std_logic;
        EMS_ERROR_3             : out std_logic;
        EMS_ERROR_45            : out std_logic;
        EMS_ERROR_67            : out std_logic;
        EMS_ERROR_EVENT         : out std_logic;
        TEST_BIT_0              : in  std_logic;
        TEST_BIT_1              : in  std_logic;
        SPARE_STATUS0           : out std_logic;
        SPARE_STATUS1           : out std_logic;
        U6_OEn                  : out std_logic;
        SPARE2                  : out std_logic;
        SPARE3                  : out std_logic
    );
    end component HMC_src;

    signal T0_i                 : std_logic := '0';
    signal MOD_PULSE_i          : std_logic := '0';
    signal EMS_TRIG_i           : std_logic := '0';
    signal RX_GATE_i            : std_logic := '0';
    signal HVn_CMD_PENTEK_i     : std_logic := '0';
    signal SYNC_PULSE_CLK_i     : std_logic := '0';
    signal EMS_PWR_ERROR_i      : std_logic := '0';
    signal HV_ON_730n_i         : std_logic := '0';
    signal FIL_ON_730n_i        : std_logic := '0';
    signal OPS_MODE_730_i       : std_logic_vector(2 downto 0) := (others=>'0');
    signal OPS_MODE_730_reg     : std_logic_vector(2 downto 0) := (others=>'0');
    signal OPS_MODE_730_reg2    : std_logic_vector(2 downto 0) := (others=>'0');
    signal OPS_MODE_730_reg3    : std_logic_vector(2 downto 0) := (others=>'0');
    signal STATUS_ACK_i         : std_logic := '0';
    signal BIT_EMS_i            : std_logic_vector(7 downto 1) := (others=>'0');
    signal WG_SW_TERMn_i        : std_logic := '0';
    signal WG_SW_NOISEn_i       : std_logic := '0';
    signal TEST_BIT_0_i         : std_logic := '0';
    signal TEST_BIT_1_i         : std_logic := '0';
    
    signal HVn_FLAG_o           : std_logic := '0';
    signal EMS_OUT_o            : std_logic_vector(7 downto 1) := (others=>'0');
    signal MOD_PULSE_HMC_o      : std_logic := '0';
    signal SYNC_PULSE_HMC_o     : std_logic := '0';
    signal HV_ON_HMCn_o         : std_logic := '0';
    signal FIL_ON_HMCn_o        : std_logic := '0';
    signal WG_SW_CTRL_TERMn_o   : std_logic := '0';
    signal WG_SW_CTRL_NOISEn_o  : std_logic := '0';
    signal NOISE_SOURCE_EN_o    : std_logic := '0';
    signal WG_SW_ERROR_o        : std_logic := '0';
    signal MOD_PULSE_DISABLE_o  : std_logic := '0';
    signal EMS_ERROR_1_o        : std_logic := '0';
    signal EMS_ERROR_2_o        : std_logic := '0';
    signal EMS_ERROR_3_o        : std_logic := '0';
    signal EMS_ERROR_45_o       : std_logic := '0';
    signal EMS_ERROR_67_o       : std_logic := '0';
    signal EMS_ERROR_EVENT_o    : std_logic := '0';
    signal SPARE_STATUS0_o      : std_logic := '0';
    signal SPARE_STATUS1_o      : std_logic := '0';
    signal U6_OEn_o             : std_logic := '0';
    signal SPARE2_o             : std_logic := '0';
    signal SPARE3_o             : std_logic := '0';    
    
    signal dcm_reset            : std_logic := '0';
    signal clk                  : std_logic := '0';
    signal dcm_locked           : std_logic := '0';
    signal resetn               : std_logic := '0';
    signal ext_clk_buf          : std_logic := '0';
    signal watchdog             : unsigned(7 downto 0) := (others=>'0');
    signal watchdog_reg         : unsigned(7 downto 0) := (others=>'0');

begin

    EXT_BUF : BUFG
    port map (
        I                       => EXT_CLK,
        O                       => ext_clk_buf
    );
    

    DCM1 : DCM_SP
    generic map (
        CLKFX_DIVIDE            => 1,
        CLKFX_MULTIPLY          => 4,
        CLKIN_PERIOD            => 64.0,
        CLK_FEEDBACK            => "NONE"
    )
    port map (
        CLKFX                   => clk,
        LOCKED                  => dcm_locked,
        CLKFB                   => '0',
        CLKIN                   => ext_clk_buf,
        PSCLK                   => '0',
        PSEN                    => '0',
        PSINCDEC                => '0',
        RST                     => dcm_reset
    );

    -- Latch OPS_MODE and generate dcm_reset if zero
    GEN_DCM_RESET : process (EXT_CLK_buf, RESETN_CPCI)
    begin
        if (rising_edge (EXT_CLK_buf)) then
            OPS_MODE_730_reg    <= OPS_MODE_730;
            OPS_MODE_730_reg2   <= OPS_MODE_730_reg;
            OPS_MODE_730_reg3   <= OPS_MODE_730_reg2;

            if OPS_MODE_730_reg = "000" and OPS_MODE_730_reg2 = "000" and OPS_MODE_730_reg3 = "000" then
                dcm_reset       <= '1';
            else
                dcm_reset       <= '0';
            end if;

            -- Also reset the dcm if the counter has stalled
            if dcm_locked = '1' and watchdog_reg = watchdog then
                dcm_reset       <= '1';
            end if;

            watchdog_reg        <= watchdog;
        end if;
        if RESETN_CPCI = '0' then
            dcm_reset           <= '1';
            OPS_MODE_730_reg    <= "000";
            OPS_MODE_730_reg2   <= "000";
            OPS_MODE_730_reg3   <= "000";				
        end if;
    end process;

    -- Detect if the clock from the DCM has stopped
    DCM_WATCHDOG : process(CLK)
    begin
        if rising_edge(clk) then
            watchdog            <= watchdog + 1;
        end if;
    end process;

    LATCH_INPUTS : process(CLK, dcm_locked)
    begin
        if rising_edge(clk) then
            T0_i                <= T0;
            MOD_PULSE_i         <= MOD_PULSE;
            EMS_TRIG_i          <= EMS_TRIG;
            RX_GATE_i           <= RX_GATE;
            HVn_CMD_PENTEK_i    <= HVn_CMD_PENTEK;
            SYNC_PULSE_CLK_i    <= SYNC_PULSE_CLK;
            EMS_PWR_ERROR_i     <= EMS_PWR_ERROR;
            HV_ON_730n_i        <= HV_ON_730n;
            FIL_ON_730n_i       <= FIL_ON_730n;
            OPS_MODE_730_i      <= OPS_MODE_730_reg;
            STATUS_ACK_i        <= STATUS_ACK;
            BIT_EMS_i           <= BIT_EMS;
            WG_SW_TERMn_i       <= WG_SW_TERMn;
            WG_SW_NOISEn_i      <= WG_SW_NOISEn;
            TEST_BIT_0_i        <= TEST_BIT_0;
            TEST_BIT_1_i        <= TEST_BIT_1;
            HVn_FLAG            <= HVn_FLAG_o;            
            EMS_OUT             <= EMS_OUT_o;             
            MOD_PULSE_HMC       <= MOD_PULSE_HMC_o;     
            SYNC_PULSE_HMC      <= SYNC_PULSE_HMC_o;      
            HV_ON_HMCn          <= HV_ON_HMCn_o;           
            FIL_ON_HMCn         <= FIL_ON_HMCn_o;          
            WG_SW_CTRL_TERMn    <= WG_SW_CTRL_TERMn_o;    
            WG_SW_CTRL_NOISEn   <= WG_SW_CTRL_NOISEn_o;   
            NOISE_SOURCE_EN     <= NOISE_SOURCE_EN_o;     
            WG_SW_ERROR         <= WG_SW_ERROR_o;         
            MOD_PULSE_DISABLE   <= MOD_PULSE_DISABLE_o;  
            EMS_ERROR_1         <= EMS_ERROR_1_o;         
            EMS_ERROR_2         <= EMS_ERROR_2_o;         
            EMS_ERROR_3         <= EMS_ERROR_3_o;         
            EMS_ERROR_45        <= EMS_ERROR_45_o;        
            EMS_ERROR_67        <= EMS_ERROR_67_o;        
            EMS_ERROR_EVENT     <= EMS_ERROR_EVENT_o;     
            SPARE_STATUS0       <= SPARE_STATUS0_o;       
            SPARE_STATUS1       <= SPARE_STATUS1_o;       
            U6_OEn              <= U6_OEn_o;               
            SPARE2              <= SPARE2_o;              
            SPARE3              <= SPARE3_o;
            resetn              <= dcm_locked;
        end if;
        if dcm_locked = '0' then
            resetn <= '0'; --async clear
        end if;
    end process;

    HMC : HMC_SRC
    generic map (
        C_EMS_DELAY             => C_EMS_DELAY,
        C_U6_DELAY              => C_U6_DELAY,
        C_HV_DELAY              => C_HV_DELAY,
        C_WG_DELAY              => C_WG_DELAY
    )
    port map (
        RESETn                  => resetn,
        CLK                     => clk,
        T0                      => T0_i,
        MOD_PULSE               => MOD_PULSE_i,
        EMS_TRIG                => EMS_TRIG_i,
        RX_GATE                 => RX_GATE_i,
        HVn_CMD_PENTEK          => HVn_CMD_PENTEK_i,
        SYNC_PULSE_CLK          => SYNC_PULSE_CLK_i,
        HVn_FLAG                => HVn_FLAG_o,
        EMS_PWR_ERROR           => EMS_PWR_ERROR_i,
        HV_ON_730n              => HV_ON_730n_i,
        FIL_ON_730n             => FIL_ON_730n_i,
        OPS_MODE_730            => OPS_MODE_730_i,
        STATUS_ACK              => STATUS_ACK_i,
        BIT_EMS                 => BIT_EMS_i,
        EMS_OUT                 => EMS_OUT_o,
        MOD_PULSE_HMC           => MOD_PULSE_HMC_o,
        SYNC_PULSE_HMC          => SYNC_PULSE_HMC_o,
        HV_ON_HMCn              => HV_ON_HMCn_o,
        FIL_ON_HMCn             => FIL_ON_HMCn_o,
        WG_SW_TERMn             => WG_SW_TERMn_i,
        WG_SW_NOISEn            => WG_SW_NOISEn_i,
        WG_SW_CTRL_TERMn        => WG_SW_CTRL_TERMn_o,
        WG_SW_CTRL_NOISEn       => WG_SW_CTRL_NOISEn_o,
        NOISE_SOURCE_EN         => NOISE_SOURCE_EN_o,
        WG_SW_ERROR             => WG_SW_ERROR_o,
        MOD_PULSE_DISABLE       => MOD_PULSE_DISABLE_o,
        EMS_ERROR_1             => EMS_ERROR_1_o,
        EMS_ERROR_2             => EMS_ERROR_2_o,
        EMS_ERROR_3             => EMS_ERROR_3_o,
        EMS_ERROR_45            => EMS_ERROR_45_o,
        EMS_ERROR_67            => EMS_ERROR_67_o,
        EMS_ERROR_EVENT         => EMS_ERROR_EVENT_o,
        TEST_BIT_0              => TEST_BIT_0_i,
        TEST_BIT_1              => TEST_BIT_1_i,
        SPARE_STATUS0           => SPARE_STATUS0_o,
        SPARE_STATUS1           => SPARE_STATUS1_o,
        U6_OEn                  => U6_OEn_o,
        SPARE2                  => SPARE2_o,
        SPARE3                  => SPARE3_o
    );

end architecture;

