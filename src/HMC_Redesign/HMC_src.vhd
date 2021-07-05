----------------------------------------------------------------------------------
-- Company:        NCAR/EOL
-- Engineer:       Loew
--
-- Create Date:    15:01:07 07/17/2012
-- Module Name:    HMC_src - Behavioral
-- Project Name:   HCR
--
-- Revision:
-- HMC V5 updates: 7/2/21 - Karboski
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity HMC_src is
    generic (
        TESTBENCH_MODE      : boolean := false
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
        SYNC_PULSE_CLK      : in  std_logic; -- 217.01389 MHz clock; 125 MHz/8/72
        HVn_FLAG            : out std_logic; -- HVn confirmation to Pentek.

        --            GPS input
        ONE_PPS             : in  std_logic;

        --            Power Monitoring
        EMS_PWR_ERROR       : in  std_logic;

        --            PMC730 Commands
        HV_ON_730           : in  std_logic; -- High voltage cmd from PMC730
        FIL_ON_730          : in  std_logic; -- Filament on cmd from PMC730
        OPS_MODE_730        : in  std_logic_vector(2 downto 0); -- Operationsl mode cmd from PMC730
        STATUS_ACK          : in  std_logic; -- Status receipt acknowledgement

        --            EMS latching circulator Built in Test (BIT) complementary inputs
        BIT_EMS             : in  std_logic_vector(7 downto 1); -- EMS latching circulator BIT

        --            EMS latching circulator complementary control signals
        EMS_OUT             : out std_logic_vector(7 downto 1); -- EMS latching circulator outputs

        --            Modulator timing and control signals
        MOD_PULSE_HMC       : out std_logic;
        SYNC_PULSE_HMC      : out std_logic;
        HV_ON_HMC           : out std_logic;
        FIL_ON_HMC          : out std_logic;

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
        U6_OE               : out std_logic;

        --            Route spare connector (P3)
        SPARE2              : out std_logic;
        SPARE3              : out std_logic
    );
end HMC_src;

architecture Behavioral of HMC_src is

    --   Constant declarations

    -- Enumeration of OPS_MODE_730
    constant OPS_730_RESET          : std_logic_vector(2 downto 0) := o"0"; -- Reset mode
    constant OPS_730_SPARE          : std_logic_vector(2 downto 0) := o"1"; -- Spare mode
    constant OPS_730_TRANSMIT       : std_logic_vector(2 downto 0) := o"2"; -- Transmit X, receive both. X is determined by Pentek scheduler
    constant OPS_730_CREF_H         : std_logic_vector(2 downto 0) := o"3"; -- Corner reflector horizontal transmit, receive both
    constant OPS_730_NOISE          : std_logic_vector(2 downto 0) := o"4"; -- Noise source cal, no tx
    constant OPS_730_CREF_V         : std_logic_vector(2 downto 0) := o"5"; -- Corner reflector cal, vertical tx w/increased NF
    constant OPS_730_TEST           : std_logic_vector(2 downto 0) := o"6"; -- Test Mode, no tx
    constant OPS_730_ISOL_NOISE     : std_logic_vector(2 downto 0) := o"7"; -- vertical transmit, receive both, but enable noise source for testing

    -- Enumeration of pulse_mode. These are used internally and don't correspond to the 730 modes.
    constant NUM_PULSE_MODES        : integer := 7;
    constant PULSE_MODE_H_TX        : integer := 0;  -- horizontal transmit, receive both
    constant PULSE_MODE_V_TX        : integer := 1;  -- vertical transmit, receive both
    constant PULSE_MODE_CREF_H      : integer := 2;  -- Corner reflector horizontal transmit, receive both
    constant PULSE_MODE_CREF_V      : integer := 3;  -- Corner reflector cal, vertical tx w/increased NF
    constant PULSE_MODE_NOISE       : integer := 4;  -- Noise source cal, no tx
    constant PULSE_MODE_ISOL_NOISE  : integer := 5;  -- vertical transmit, receive both, but enable noise source for testing
    constant PULSE_MODE_TEST        : integer := 6;  -- Test Mode, no tx

    type ems_type   is array(0 to NUM_PULSE_MODES-1) of std_logic_vector(7 downto 1);

    --Switch values for when EMS_TRIG = 1
    constant C_TX_EMS_SWITCH_VAL : ems_type := (
        PULSE_MODE_H_TX         => "0101001",
        PULSE_MODE_V_TX         => "0101110",
        PULSE_MODE_CREF_H       => "0101001",
        PULSE_MODE_CREF_V       => "0101110",
        PULSE_MODE_NOISE        => "0101101",
        PULSE_MODE_ISOL_NOISE   => "0101110",
        PULSE_MODE_TEST         => "0101110",
        others                  => "0000000"
    );

    --Switch values for when EMS_TRIG = 0
    constant C_RX_EMS_SWITCH_VAL : ems_type := (
        PULSE_MODE_H_TX         => "1010010",
        PULSE_MODE_V_TX         => "1010011",
        PULSE_MODE_CREF_H       => "0000010",
        PULSE_MODE_CREF_V       => "0000011",
        PULSE_MODE_NOISE        => "0101101",
        PULSE_MODE_ISOL_NOISE   => "1010011",
        PULSE_MODE_TEST         => "1010011",
        others                  => "0000000"
    );

    --Whether mod_pulse can be high in this ops mode
    constant C_ALLOW_MOD_PULSE : std_logic_vector(NUM_PULSE_MODES-1 downto 0) := (
        PULSE_MODE_H_TX         => '1',
        PULSE_MODE_V_TX         => '1',
        PULSE_MODE_CREF_H       => '1',
        PULSE_MODE_CREF_V       => '1',
        others                  => '0'
    );

    --Value to set for HVn in this ops mode
    constant C_HVn_FLAG : std_logic_vector(NUM_PULSE_MODES-1 downto 0) := (
        PULSE_MODE_H_TX         => '1',
        PULSE_MODE_CREF_H       => '1',
        others                  => '0'
    );

    --Whether this mode uses the noise source
    constant C_NOISE_EN : std_logic_vector(NUM_PULSE_MODES-1 downto 0) := (
        PULSE_MODE_NOISE        => '1',
        PULSE_MODE_ISOL_NOISE   => '1',
        others                  => '0'
    );

    constant C_1S_DELAY         : integer := 15728640;
    constant C_100MS_DELAY      : integer := 1562499;
    constant C_TESTBENCH_DELAY  : integer := 1562;
    constant C_EMS_DELAY        : integer := 4;
    signal   C_U6_DELAY         : integer; --set later
    signal   C_HV_DELAY         : integer;
    signal   C_WG_DELAY         : integer;

    --   Signal declarations

    signal ems_pwr_ok           : std_logic;
    signal hv_powerup_dly       : std_logic;
    signal hv_count             : unsigned(23 downto 0);
    signal count_enable         : std_logic;
    signal U6_count             : unsigned(23 downto 0);
    signal U6_dly               : std_logic;
    signal U6_count_enable      : std_logic;
    signal wg_dly               : std_logic;
    signal wg_count             : unsigned(20 downto 0);
    signal wg_stat_ok           : std_logic;
    signal tx_ems_switch_dly    : std_logic; -- Delay before reading EMS BIT on transmit
    signal ems_tx_count         : unsigned(4 downto 0);
    signal rx_ems_switch_dly    : std_logic; -- Delay before reading EMS BIT on receive
    signal ems_rx_count         : unsigned(4 downto 0);
    signal l_ems_trig           : std_logic; -- Latched EMS_TRIG signal
    signal ems_tx_count_enable  : std_logic;
    signal ems_rx_count_enable  : std_logic;
    signal end_cycle            : std_logic; --    End of cycle flag
    signal ems_tx_error_vector  : std_logic_vector(7 downto 1);
    signal ems_rx_error_vector  : std_logic_vector(7 downto 1);
    signal ems_tx_ok            : std_logic;
    signal ems_rx_ok            : std_logic;
    signal ems_tx_stat          : std_logic;
    signal ems_rx_stat          : std_logic;
    signal ems_tx_error         : std_logic;
    signal ems_1_tx_stat        : std_logic;
    signal ems_2_tx_stat        : std_logic;
    signal ems_3_tx_stat        : std_logic;
    signal ems_45_tx_stat       : std_logic;
    signal ems_67_tx_stat       : std_logic;
    signal ems_1_rx_stat        : std_logic;
    signal ems_2_rx_stat        : std_logic;
    signal ems_3_rx_stat        : std_logic;
    signal ems_45_rx_stat       : std_logic;
    signal ems_67_rx_stat       : std_logic;
    signal ems_1_error          : std_logic;
    signal ems_2_error          : std_logic;
    signal ems_3_error          : std_logic;
    signal ems_45_error         : std_logic;
    signal ems_67_error         : std_logic;
    signal mod_pulse_error      : std_logic;
    signal ems_error_prt        : std_logic;
    signal ems_out_i            : std_logic_vector(7 downto 1); -- signal EMS_OUT
    signal l_tx_ems_switch_dly  : std_logic;
    signal l_rx_ems_switch_dly  : std_logic;
    signal l_rx_gate            : std_logic;
    signal ops_mode_730_reg     : std_logic_vector(2 downto 0) := "000";
    signal ops_mode_730_reg2    : std_logic_vector(2 downto 0) := "000";
    signal HVn_cmd_px_reg       : std_logic;
    signal resetn_730           : std_logic := '0';
    signal next_pulse_mode      : integer range 0 to NUM_PULSE_MODES-1 := PULSE_MODE_TEST;
    signal pulse_mode           : integer range 0 to NUM_PULSE_MODES-1 := PULSE_MODE_TEST;
    signal cmd_wg_sw_pos        : std_logic; -- commanded waveguide switch position
    signal state_code           : std_logic_vector(1 downto 0); -- for debugging state machine
    signal resetn               : std_logic; -- Reset, active low

    -- State machine declarations
    type state_type is (s0, s1, s2, s3);
    signal state                : state_type;
    signal prev_state           : state_type;

begin

    -- Shorten delay counters for simulation
    C_U6_DELAY <= C_TESTBENCH_DELAY when TESTBENCH_MODE else C_1S_DELAY;
    C_HV_DELAY <= C_TESTBENCH_DELAY when TESTBENCH_MODE else C_1S_DELAY;
    C_WG_DELAY <= C_TESTBENCH_DELAY when TESTBENCH_MODE else C_100MS_DELAY;

    -- Latch OPS_MODE and generate resetn_730
    LATCH_OPS_730 : process (EXT_CLK)
    begin
        if (rising_edge (EXT_CLK)) then
            ops_mode_730_reg    <= OPS_MODE_730;
            ops_mode_730_reg2   <= ops_mode_730_reg;

            if ops_mode_730_reg = OPS_730_RESET and ops_mode_730_reg2 = OPS_730_RESET then
                resetn_730      <= '0';
            else
                resetn_730      <= '1';
            end if;
        end if;
    end process;

    -- Reset from either source
    resetn <= RESETn_CPCI and resetn_730;

    state_code <= "00" when state = s0 else
                  "01" when state = s1 else
                  "10" when state = s2 else
                  "11";

    -- Tx Control
    HV_ON_HMC       <= HV_ON_730;
    FIL_ON_HMC      <= FIL_ON_730;
    SYNC_PULSE_HMC  <= SYNC_PULSE_CLK;

    -- Check key power supply voltages
    ems_pwr_ok      <= not EMS_PWR_ERROR;

    -- Assign test signals to SPARE outputs for debug
    SPARE2          <= state_code(0);
    SPARE3          <= state_code(1);

    SPARE_STATUS0   <= TEST_BIT_0;
    SPARE_STATUS1   <= TEST_BIT_1;

    -- Check wavequide switch position. Account for switch delay (~100 msec) before reporting status
    CHECK_WG : process (EXT_CLK, resetn)
        variable v_wg_sw_pos : std_logic;
    begin
        if rising_edge(EXT_CLK) then
            if (wg_dly = '1') then
                if C_NOISE_EN(pulse_mode) = '1' then -- Noise source cal or isolation test mode
                    if (WG_SW_TERMn = '1' and WG_SW_NOISEn = '0') then
                        WG_SW_ERROR <= '0';
                        wg_stat_ok  <= '1'; -- good status
                        v_wg_sw_pos := '1';
                    else
                        WG_SW_ERROR <= '1';
                        wg_stat_ok  <= '0'; -- bad status
                        v_wg_sw_pos := '0';
                    end if;
                else
                    if (WG_SW_TERMn = '0' and WG_SW_NOISEn = '1') then
                        WG_SW_ERROR <= '0';
                        v_wg_sw_pos := '0';
                        wg_stat_ok  <= '1'; -- good status
                    else
                        WG_SW_ERROR <= '1';
                        wg_stat_ok  <= '0'; -- bad status
                        v_wg_sw_pos := '1';
                    end if;
                end if;

                if v_wg_sw_pos /= cmd_wg_sw_pos then
                    wg_dly          <= '0'; -- Change commanded, enter transition state
                end if;
                wg_count            <= (others=>'0');

            else -- waveguide switch is in transition
                wg_stat_ok          <= '0'; -- bad status; don't want to transmit in transition
                WG_SW_ERROR         <= '0'; -- assume there is no error in transition

                if (wg_count = C_WG_DELAY) then -- 100 ms
                    wg_count        <= (others=>'0');
                    wg_dly          <= '1';
                else
                    wg_count        <= wg_count + 1;
                end if;
            end if;

        end if; --RE CLK
        if (resetn = '0') then
            wg_stat_ok              <= '0'; -- bad status
            WG_SW_ERROR             <= '0'; -- assume switch is not in error until we confirm where it is pointed
            wg_count                <= (others=>'0');
            wg_dly                  <= '0';
        end if;
    end process;

    -- Check EMS BIT against the value it's supposed to be for the mode we're in
    CHECK_BITE : process (EXT_CLK, resetn)
    begin
        if rising_edge(EXT_CLK) then
            if wg_dly = '1' then -- Waveguide switch is not in transition
                ems_tx_error_vector     <= BIT_EMS xor C_TX_EMS_SWITCH_VAL(pulse_mode);
                ems_rx_error_vector     <= BIT_EMS xor C_RX_EMS_SWITCH_VAL(pulse_mode);
            else
                -- report good status for all ems switches during waveguide switch transition
                ems_tx_error_vector     <= (others=>'0');
                ems_rx_error_vector     <= (others=>'0');
            end if;
        end if; --RE CLK
        if (resetn = '0') then
            ems_tx_error_vector         <= (others=>'1');
            ems_rx_error_vector         <= (others=>'1');
        end if;
    end process;

    -- If there are no bits set in the error vector, then set a 1 to say we are ok
    ems_tx_stat <= '1' when ems_tx_error_vector = "0000000" else '0';
    ems_rx_stat <= '1' when ems_rx_error_vector = "0000000" else '0';

    -- Break out the error vector into individual error flags
    ems_1_tx_stat  <= ems_tx_error_vector(1);
    ems_2_tx_stat  <= ems_tx_error_vector(2);
    ems_3_tx_stat  <= ems_tx_error_vector(3);
    ems_45_tx_stat <= ems_tx_error_vector(4) or ems_tx_error_vector(5);
    ems_67_tx_stat <= ems_tx_error_vector(6) or ems_tx_error_vector(7);
    ems_1_rx_stat  <= ems_rx_error_vector(1);
    ems_2_rx_stat  <= ems_rx_error_vector(2);
    ems_3_rx_stat  <= ems_rx_error_vector(3);
    ems_45_rx_stat <= ems_rx_error_vector(4) or ems_rx_error_vector(5);
    ems_67_rx_stat <= ems_rx_error_vector(6) or ems_rx_error_vector(7);

    -- Update EMS switch status
    EMS_ERROR_1   <= ems_1_error;
    EMS_ERROR_2   <= ems_2_error;
    EMS_ERROR_3   <= ems_3_error;
    EMS_ERROR_45  <= ems_45_error;
    EMS_ERROR_67  <= ems_67_error;

    --Set next pulse_mode
    SET_OPS_MODE : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then

            HVn_cmd_px_reg              <= HVn_CMD_PENTEK;

            case ops_mode_730_reg is
                --when OPS_730_SPARE        =>
                when OPS_730_TRANSMIT =>
                    if HVn_cmd_px_reg = '1' then
                        next_pulse_mode   <= PULSE_MODE_H_TX;
                    else
                        next_pulse_mode   <= PULSE_MODE_V_TX;
                    end if;
                when OPS_730_CREF_H       =>  next_pulse_mode <= PULSE_MODE_CREF_H;
                when OPS_730_NOISE        =>  next_pulse_mode <= PULSE_MODE_NOISE;
                when OPS_730_CREF_V       =>  next_pulse_mode <= PULSE_MODE_CREF_V;
                when OPS_730_TEST         =>  next_pulse_mode <= PULSE_MODE_TEST;
                when OPS_730_ISOL_NOISE   =>  next_pulse_mode <= PULSE_MODE_ISOL_NOISE;
                when others                 =>  next_pulse_mode <= PULSE_MODE_TEST; -- default to bench test
            end case;

        end if; --RE CLK
        if (resetn = '0') then
            next_pulse_mode       <= PULSE_MODE_TEST; -- default to bench test
            HVn_cmd_px_reg      <= '0';
        end if;
    end process;

    -- Latch EMS delays
    LATCH_DLY : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then
            l_tx_ems_switch_dly <= tx_ems_switch_dly;
            l_rx_ems_switch_dly <= rx_ems_switch_dly;

        end if; --RE CLK
        if (resetn = '0') then
            l_tx_ems_switch_dly <= '0';
            l_rx_ems_switch_dly <= '0';
        end if;
    end process;

    -- Update EMS status when BIT is valid
    EMS_STAT : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then
            ems_tx_ok       <= ((not l_tx_ems_switch_dly and tx_ems_switch_dly and ems_tx_stat) or ems_tx_ok) and not end_cycle;

            ems_1_error     <= (((not l_tx_ems_switch_dly and tx_ems_switch_dly and ems_1_tx_stat) or ems_1_error) and not STATUS_ACK) or
                               (((not l_rx_ems_switch_dly and rx_ems_switch_dly and ems_1_rx_stat) or ems_1_error) and not STATUS_ACK);
            ems_2_error     <= (((not l_tx_ems_switch_dly and tx_ems_switch_dly and ems_2_tx_stat) or ems_2_error) and not STATUS_ACK) or
                               (((not l_rx_ems_switch_dly and rx_ems_switch_dly and ems_2_rx_stat) or ems_2_error) and not STATUS_ACK);
            ems_3_error     <= (((not l_tx_ems_switch_dly and tx_ems_switch_dly and ems_3_tx_stat) or ems_3_error) and not STATUS_ACK) or
                               (((not l_rx_ems_switch_dly and rx_ems_switch_dly and ems_3_rx_stat) or ems_3_error) and not STATUS_ACK);
            ems_45_error    <= (((not l_tx_ems_switch_dly and tx_ems_switch_dly and ems_45_tx_stat) or ems_45_error) and not STATUS_ACK) or
                               (((not l_rx_ems_switch_dly and rx_ems_switch_dly and ems_45_rx_stat) or ems_45_error) and not STATUS_ACK);
            ems_67_error    <= (((not l_tx_ems_switch_dly and tx_ems_switch_dly and ems_67_tx_stat) or ems_67_error) and not STATUS_ACK) or
                               (((not l_rx_ems_switch_dly and rx_ems_switch_dly and ems_67_rx_stat) or ems_67_error) and not STATUS_ACK);
            ems_tx_error    <= (((not l_tx_ems_switch_dly and tx_ems_switch_dly and not ems_tx_stat) or ems_tx_error) and not STATUS_ACK);

            ems_rx_ok       <= ((not l_rx_ems_switch_dly and rx_ems_switch_dly and ems_rx_stat) or ems_rx_ok) and not end_cycle;

            mod_pulse_error <= (not (ems_pwr_ok and not ems_tx_error) or mod_pulse_error) and not STATUS_ACK;

        end if; --RE CLK
        if (resetn = '0') then
            ems_tx_ok       <= '1';
            ems_rx_ok       <= '1';
            ems_1_error     <= '0';
            ems_2_error     <= '0';
            ems_3_error     <= '0';
            ems_45_error    <= '0';
            ems_67_error    <= '0';
            ems_tx_error    <= '0';
            mod_pulse_error <= '0';
        end if;
    end process;

    MOD_PULSE_DISABLE <=
        '1' when pulse_mode = PULSE_MODE_TEST
              or pulse_mode = PULSE_MODE_NOISE
              or pulse_mode = PULSE_MODE_ISOL_NOISE
              or mod_pulse_error = '1'
        else '0';

    EMS_PRT : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then

            ems_error_prt <= (((not l_tx_ems_switch_dly and tx_ems_switch_dly and not ems_tx_stat) or ems_error_prt) and not end_cycle) or
                             (((not l_rx_ems_switch_dly and rx_ems_switch_dly and not ems_rx_stat) or ems_error_prt) and not end_cycle);

        end if; --RE CLK
        if (resetn = '0') then
            ems_error_prt <= '0';
        end if;
    end process;
    EMS_ERROR_EVENT <= ems_error_prt; -- reports a maximum of one event per PRT

    -- Sets 1 second safety delay from HV_ON to enabling transmit triggers
    DELAY_1SEC : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then
            if (HV_ON_730 = '0') then
                if (hv_count = C_HV_DELAY) then -- 1 second
                    hv_count        <= (others=>'0');
                    count_enable    <= '0';
                    hv_powerup_dly  <= '1';
                elsif (count_enable = '1') then
                    hv_count <= hv_count + 1;
                end if;
            else
                hv_count            <= (others=>'0');
                hv_powerup_dly      <= '0';
                count_enable        <= '1';
            end if;
        end if; --RE CLK
        if (resetn = '0') then
            hv_count                <= (others=>'0');
            hv_powerup_dly          <= '0';
            count_enable            <= '1';
        end if;
    end process;

    -- Delay for 1 second while Pentek initializes, then enable U6; ohterwise, Pentek isn't discovered on PCI bus!
    -- This is a mystery, but haven't sufficient documentation on Pentek to sort it out.
    DELAY_U6_ENABLE : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then
            if (U6_count = C_U6_DELAY) then -- 1 second
                U6_count        <= (others=>'0');
                U6_count_enable <= '0';
                U6_dly          <= '1';
            elsif (U6_count_enable = '1') then
                U6_count <= U6_count + 1;
            else
                U6_count        <= (others=>'0');
                U6_dly          <= '1';
                U6_count_enable <= '0';
            end if;
        end if; --RE CLK
        if (resetn = '0') then
            U6_count        <= (others=>'0');
            U6_dly          <= '0';
            U6_count_enable <= '1';
        end if;
    end process;

    U6_OE <= not U6_dly;

    -- Generate registered EMS_TRIG
    LATCH_EMS_TRIG : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then
            l_ems_trig <= EMS_TRIG;
        end if; --RE CLK
        if (resetn = '0') then
            l_ems_trig <= '0';
        end if;
    end process;

    -- Generate EMS Transmit and Receive BIT count enables
    EMS_CNT_EN : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then
            ems_tx_count_enable <= ((EMS_TRIG and not l_ems_trig) or ems_tx_count_enable) and not end_cycle; -- rising edge of EMS_TRIG
            ems_rx_count_enable <= ((not EMS_TRIG and l_ems_trig) or ems_rx_count_enable) and not end_cycle; -- falling edge of EMS_TRIG
        end if; --RE CLK
        if (resetn = '0') then
            ems_tx_count_enable <= '0';
            ems_rx_count_enable <= '0';
        end if;
    end process;

    -- Sets delay from EMS switch trigger to EMS switch BIT valid on transmit
    EMS_TX_DELAY : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then
            if (ems_tx_count_enable = '1') then
                if (ems_tx_count = C_EMS_DELAY) then
                    ems_tx_count        <= (others=>'0');
                    tx_ems_switch_dly   <= '1';
                else
                    ems_tx_count        <= ems_tx_count + 1;
                end if;
            else
                ems_tx_count            <= (others=>'0');
                tx_ems_switch_dly       <= '0';
            end if;
        end if; --RE CLK
        if (resetn = '0') then
            ems_tx_count                <= (others=>'0');
            tx_ems_switch_dly           <= '0';
        end if;
    end process;

    -- Sets delay from EMS switch trigger to EMS switch BIT valid on receive
    EMS_RX_DELAY : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then
            if (ems_rx_count_enable = '1') then
                if (ems_rx_count = C_EMS_DELAY) then
                    ems_rx_count        <= (others=>'0');
                    rx_ems_switch_dly   <= '1';
                else
                    ems_rx_count        <= ems_rx_count + 1;
                end if;
            else
                ems_rx_count            <= (others=>'0');
                rx_ems_switch_dly       <= '0';
            end if;
        end if; --RE CLK
        if (resetn = '0') then
            ems_rx_count                <= (others=>'0');
            rx_ems_switch_dly           <= '0';
        end if;
    end process;

    -- Defines cycle over which State Machine operates
    CYCLE : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then
            l_rx_gate <= RX_GATE;
            end_cycle <= l_rx_gate and not RX_GATE; -- end cycle on falling edge of rx_gate!
        end if; --RE CLK
        if (resetn = '0') then
            end_cycle <= '0';
            l_rx_gate <= '0';
        end if;
    end process;

    ------------------------ End Sychronous Processes ----------------------------------------------------

    ------------------------ State Machine ----------------------------------------------------------------

    STATE_MACHINE : process (EXT_CLK, resetn)
    begin
        if (rising_edge (EXT_CLK)) then
            case state is
                when s0 => -- Idle state

                    if EMS_TRIG = '1' and T0 = '1' -- Triggered by scheduler
                        and tx_ems_switch_dly = '0' -- Haven't timed out yet
                        and rx_ems_switch_dly = '0' -- Haven't timed out yet
                        and ems_pwr_ok = '1'        -- Power is ok
                        and wg_stat_ok = '1'        -- Waveguide is ok
                                                    -- Either high voltage is on OR we are in a opsmode that doesn't need hv
                        and (hv_powerup_dly = '1' or C_ALLOW_MOD_PULSE(pulse_mode) = '0') then
                            state <= s1;
                    end if;

                    pulse_mode <= next_pulse_mode; -- Only latch the mode in s0

                when s1 => -- Configure for transmit

                    if ems_tx_ok = '1'              -- EMS is good
                        and ems_pwr_ok = '1'        -- Power is still good
                                                    -- Either high voltage is on OR we are in a opsmode that doesn't need hv
                        and ( hv_powerup_dly = '1'  or C_ALLOW_MOD_PULSE(pulse_mode) = '0') then

                            state <= s2;
                    end if;

                    -- Cancel if the state doesn't become good by the timeout
                    if rx_ems_switch_dly = '1' then
                        state <= s0;
                    end if;

                when s2 => -- Transmit (if in a transmitting mode) or continue (if not)

                    if (C_ALLOW_MOD_PULSE(pulse_mode) = '0') then
                        -- The non-transmitting opmodes can skip right to RX after the switch delay
                        if tx_ems_switch_dly = '1' then
                            state <= s3;
                        end if;
                        -- Cancel if power is lost
                        if ems_pwr_ok = '0' then
                            state <= s0;
                        end if;
                    else -- TX modes
                        -- When TX is done, proceed to RX
                        if rx_ems_switch_dly = '1' and tx_ems_switch_dly = '1' then
                            state <= s3;
                        end if;
                        --Cancel if high voltage or ems power is lost
                        if hv_powerup_dly = '0' or ems_pwr_ok = '0' then
                            state <= s0;
                        end if;
                    end if;

                when s3 => -- Receive
                    if RX_GATE = '0' and rx_ems_switch_dly = '0' and tx_ems_switch_dly = '0' then
                        state <= s0;
                    end if;
                when others =>
                    state <= s0;
            end case;

        end if; --RE CLK
        if (resetn = '0') then
            state <= s0;
        end if;
    end process;

    -- State Machine Ouputs
    STATE_OUT : process (EXT_CLK, resetn)
    begin
        if rising_edge(EXT_CLK) then

            -- Set the waveguide switch and enable noise according to the mode
            WG_SW_CTRL_TERMn            <= C_NOISE_EN(pulse_mode);
            WG_SW_CTRL_NOISEn           <= not C_NOISE_EN(pulse_mode);
            NOISE_SOURCE_EN             <= C_NOISE_EN(pulse_mode);
            cmd_wg_sw_pos               <= C_NOISE_EN(pulse_mode);

            if state = S0 then
                -- On the first cycle of S0, invert all the EMS pins to
                -- ensure at least one transition per PRT.
                if prev_state /= state then
                    EMS_OUT_i           <= not EMS_OUT_i;
                end if;
            else

                -- Set HVn according to the mode
                HVn_FLAG                <= C_HVn_FLAG(pulse_mode);

                -- Set EMS according to the mode
                if EMS_TRIG = '1' then
                    EMS_OUT_i           <= C_TX_EMS_SWITCH_VAL(pulse_mode);
                else
                    EMS_OUT_i           <= C_RX_EMS_SWITCH_VAL(pulse_mode);
                end if;

            end if;

            -- Mod pulse is only allowed in S2/S3, and in certain modes.
            if (state = S2 or state = S3) then
                MOD_PULSE_HMC           <= MOD_PULSE and C_ALLOW_MOD_PULSE(pulse_mode);
            else
                MOD_PULSE_HMC           <= '0';
            end if;

            prev_state                  <= state;

        end if; --RE CLK
        if (resetn = '0') then
            cmd_wg_sw_pos               <= '0';
            MOD_PULSE_HMC               <= '0';
            EMS_OUT_i                   <= "0000000";
            WG_SW_CTRL_TERMn            <= '0';
            WG_SW_CTRL_NOISEn           <= '1';
            NOISE_SOURCE_EN             <= '0';
            cmd_wg_sw_pos               <= '0';
            HVn_flag                    <= '0';
            prev_state                  <= s0;
        end if;
    end process;

    EMS_OUT <= EMS_OUT_i;

    -------------------------------------------------------------------------------------------------------
end Behavioral;
