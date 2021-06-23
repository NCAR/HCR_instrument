----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    15:01:07 07/17/2012
-- Design Name:
-- Module Name:    main_src - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity HMC_src is
    generic (
        TESTBENCH_MODE : boolean := false
    );
    port (

        --            Unused FPGA inputs
        --RDS_GND           : in  std_logic;
        --PW_GND            : in  std_logic;

        --            Unused Pentek Timing Signals
        TIMER_6           : in  std_logic;
        TIMER_7           : in  std_logic;
        TX_GATE           : in  std_logic;

        --            cPCI Signals
        RESET             : in  std_logic; -- cPCI reset line

        --            Pentek Timing Signals (Connector PN 4)
        EXT_CLK           : in  std_logic; -- 15.625 MHz clock; 125 MHz/8
        T0                : in  std_logic;
        MOD_PULSE         : in  std_logic;
        SYNC_PULSE        : in  std_logic;
        EMS_TRIG          : in  std_logic;
        RX_GATE           : in  std_logic;

        --            GPS input
        ONE_PPS           : in  std_logic;

        --            Power Monitoring
        EMS_PWR_ERROR     : in  std_logic;

        --            PMC730 Commands
        HV_ON_730         : in  std_logic; -- High voltage cmd from PMC730
        FIL_ON_730        : in  std_logic; -- Filament on cmd from PMC730
        OPS_MODE_730      : in  std_logic_vector(2 downto 0); -- Operationsl mode cmd from PMC730
        STATUS_ACK        : in  std_logic; -- Status receipt acknowledgement

        --            EMS latching circulator Built in Test (BIT) complementary inputs
        BIT_EMS           : in  std_logic_vector(7 downto 1); -- EMS latching circulator BIT

        --            EMS latching circulator complementary control signals
        EMS_OUT           : out std_logic_vector(7 downto 1); -- EMS latching circulator outputs

        --            Modulator timing and control signals
        MOD_PULSE_HMC     : out std_logic;
        SYNC_PULSE_HMC    : out std_logic;
        HV_ON_HMC         : out std_logic;
        FIL_ON_HMC        : out std_logic;

        --            Noise source calibration control

        WG_SW_TERM        : in  std_logic; -- BIT indication when waveguide switch is into load
        WG_SW_NOISE       : in  std_logic; -- BIT indication when waveguide switch is into noise source
        WG_SW_CTRL_TERM   : out std_logic; -- Terminate waveguide switch into load
        WG_SW_CTRL_NOISE  : out std_logic; -- Terminate waveguide switch into noise source
        NOISE_SOURCE_EN   : out std_logic; -- Turn on noise source
        WG_SW_ERROR       : out std_logic; -- Waveguide switch BIT doesn't match command

        --            Status information
        MOD_PULSE_DISABLE : out std_logic; -- Fault sum status
        EMS_ERROR_1       : out std_logic; -- EMS switch 1 BIT error
        EMS_ERROR_2       : out std_logic; -- EMS switch 2 BIT error
        EMS_ERROR_3       : out std_logic; -- EMS switch 3 BIT error
        EMS_ERROR_45      : out std_logic; -- EMS switch 4,5 BIT error
        EMS_ERROR_67      : out std_logic; -- EMS switch 6,7 BIT error
        EMS_ERROR_EVENT   : out std_logic; -- EMS switch BIT error count

        --            General spares
        TEST_BIT_0        : in  std_logic;
        TEST_BIT_1        : in  std_logic;
        SPARE_STATUS0     : out std_logic;
        SPARE_STATUS1     : out std_logic;

        --            U6 Output Enable control, allows Pentek to be discovered on PCI bus
        U6_OE             : out std_logic;

        --            Route spare connector (P3)
        SPARE1            : out std_logic;
        SPARE2            : out std_logic;
        SPARE3            : out std_logic
        --SPARE4            : out STD_LOGIC;
        --SPARE5            : out STD_LOGIC;
        --SPARE6            : out STD_LOGIC;
        --SPARE7            : out STD_LOGIC;

        --            Unused signals available on FPGA only
        --SPARE10           : inout STD_LOGIC;
        --SPARE11           : inout STD_LOGIC;
        --SPARE12           : inout STD_LOGIC;
        --SPARE13           : inout STD_LOGIC;
        --SPARE14           : inout STD_LOGIC;
        --SPARE15           : inout STD_LOGIC;
        --SPARE16           : inout STD_LOGIC;
        --SPARE17           : inout STD_LOGIC;
        --SPARE18           : inout STD_LOGIC;
        --SPARE19           : inout STD_LOGIC;
        --SPARE21           : inout STD_LOGIC;
        --SPARE22           : inout STD_LOGIC;
        --SPARE23           : inout STD_LOGIC;
    );
end HMC_src;

architecture Behavioral of HMC_src is
    -- Uncomment for "Safe" mode
    --BEGIN
    ----    EMS latching circulator complementary control signals
    --    EMS_OUT <= "ZZZZZZZ";
    --
    ----            Modulator timing and control signals
    --    MOD_PULSE_HMC <= 'Z';
    --    SYNC_PULSE_HMC <= 'Z';
    --    HV_ON_HMC <= 'Z';
    --    FIL_ON_HMC <= 'Z';
    --
    ----            Noise source calibration control
    --    WG_SW_CTRL_TERM <= 'Z';
    --    WG_SW_CTRL_NOISE <= 'Z';
    --    NOISE_SOURCE_EN <= 'Z';
    --    WG_SW_ERROR <= 'Z';
    --
    ----          Status information
    --    MOD_PULSE_DISABLE <= 'Z';
    --    EMS_ERROR_1 <= 'Z';
    --    EMS_ERROR_2 <= 'Z';
    --    EMS_ERROR_3 <= 'Z';
    --    EMS_ERROR_45 <= 'Z';
    --    EMS_ERROR_67 <= 'Z';
    --    EMS_ERROR_EVENT <= 'Z';
    --
    ----         General spares
    --    SPARE_STATUS0 <= 'Z';
    --    SPARE_STATUS1 <= 'Z';
    --
    ----            Route spare connector (P3)
    --   SPARE1 <= 'Z';
    --   SPARE2 <= 'Z';
    --   SPARE3 <= 'Z';
    --
    --END;

    --   Constant declarations

    constant EMS_HORZTX_TX      : std_logic_vector(7 downto 1) := "0101001";
    constant EMS_HORZTX_RX      : std_logic_vector(7 downto 1) := "1010010";
    constant EMS_VERTTX_TX      : std_logic_vector(7 downto 1) := "0101110";
    constant EMS_VERTTX_RX      : std_logic_vector(7 downto 1) := "1010011";
    constant EMS_CREF_RX        : std_logic_vector(7 downto 1) := "0000010";
    constant EMS_CREF_NOISE_RX  : std_logic_vector(7 downto 1) := "0000011";
    constant EMS_NOISE_CAL      : std_logic_vector(7 downto 1) := "0101101";

    constant OPS_0_H_TX         : std_logic_vector(2 downto 0) := o"0"; -- horizontal transmit, receive both
    constant OPS_1_V_TX         : std_logic_vector(2 downto 0) := o"1"; -- vertical transmit, receive both
    constant OPS_2_HHVV_TX      : std_logic_vector(2 downto 0) := o"2"; -- HHVV transmit, receive both
    constant OPS_3_CREF_H       : std_logic_vector(2 downto 0) := o"3"; -- Corner reflector horizontal transmit, receive both
    constant OPS_4_NOISE        : std_logic_vector(2 downto 0) := o"4"; -- Noise source cal, no tx
    constant OPS_5_CREF_V       : std_logic_vector(2 downto 0) := o"5"; -- Corner reflector cal, vertical tx w/increased NF
    constant OPS_6_TEST         : std_logic_vector(2 downto 0) := o"6"; -- Test Mode, no tx
    constant OPS_7_ISOL_NOISE   : std_logic_vector(2 downto 0) := o"7"; -- vertical transmit, receive both, but enable noise source for testing

    --   Signal declarations

    signal ems_pwr_ok           : std_logic;
    signal hv_dly               : std_logic;
    signal hv_count             : std_logic_vector(23 downto 0);
    signal count_enable         : std_logic;
    signal U6_count             : std_logic_vector(23 downto 0);
    signal U6_dly               : std_logic;
    signal U6_count_enable      : std_logic;
    signal wg_dly               : std_logic;
    signal wg_count             : std_logic_vector(20 downto 0);
    signal wg_count_enable      : std_logic;
    signal wg_change_state      : std_logic;
    signal wg_stat              : std_logic;
    signal tx_dly               : std_logic; -- Delay before reading EMS BIT on transmit
    signal ems_tx_count         : std_logic_vector(4 downto 0);
    signal rx_dly               : std_logic; -- Delay before reading EMS BIT on receive
    signal ems_rx_count         : std_logic_vector(4 downto 0);
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
    signal l_tx_dly             : std_logic;
    signal l_rx_dly             : std_logic;
    signal l_rx_gate            : std_logic;
    signal ops_mode             : std_logic_vector(2 downto 0); -- ops_mode at state S0
    signal ops_mode_en          : std_logic; -- enables ops mode to be latched
    signal pol_state            : std_logic_vector(1 downto 0); -- polarization state of Tx pulse
    signal wg_sw_pos            : std_logic; -- current waveguide switch position
    signal cmd_wg_sw_pos        : std_logic; -- commanded waveguide switch position
    signal hv_flag             : std_logic; -- H/V Flag to be sent to Pentek for housekeeping; Tx-H=1, Tx-V=0

    -- State machine declarations
    type state_type is (s0, s1, s2, s3);
    signal state      : state_type;

    -- for debugging state machine
    signal state_code : std_logic_vector(1 downto 0);

begin

    state_code <= "00" when state = s0 else
                  "01" when state = s1 else
                  "10" when state = s2 else
                  "11";
    -- Tx Control
    HV_ON_HMC      <= HV_ON_730;
    FIL_ON_HMC     <= FIL_ON_730;
    SYNC_PULSE_HMC <= SYNC_PULSE;

    -- Check key power supply voltages
    ems_pwr_ok <= not EMS_PWR_ERROR;

    -- Check wavequide switch position    NEED to account for switch delay (~100 msec) before reporting status
    CHECK_WG : process (EXT_CLK, RESET)
    begin
        if rising_edge(EXT_CLK) then
            if (wg_dly = '1') then
                if (ops_mode = OPS_4_NOISE or ops_mode = OPS_7_ISOL_NOISE) then -- Noise source cal or isolation test mode
                    if (WG_SW_TERM = '1' and WG_SW_NOISE = '0') then
                        WG_SW_ERROR <= '0';
                        wg_stat     <= '1'; -- good status
                        wg_sw_pos   <= '1';
                    else
                        WG_SW_ERROR <= '1';
                        wg_stat     <= '0'; -- bad status
                        wg_sw_pos   <= '0';
                    end if;
                else
                    if (WG_SW_TERM = '0' and WG_SW_NOISE = '1') then
                        WG_SW_ERROR <= '0';
                        wg_sw_pos   <= '0';
                        wg_stat     <= '1'; -- good status
                    else
                        WG_SW_ERROR <= '1';
                        wg_stat     <= '0'; -- bad status
                        wg_sw_pos   <= '1';
                    end if;
                end if;
                wg_change_state <= wg_sw_pos xor cmd_wg_sw_pos;
            else -- waveguide switch is in transition
                wg_sw_pos           <= '0';
                wg_stat             <= '0'; -- bad status; don't want to transmit in transition
                WG_SW_ERROR         <= '0'; -- assume there is no error in transition
                wg_change_state     <= '0';
            end if;
            
        end if; --RE CLK
        if (RESET = '0') then
            wg_sw_pos               <= '0'; -- assume waveguide switch is pointed into termination (normal ops)
            wg_stat                 <= '0'; -- bad status
            WG_SW_ERROR             <= '0'; -- assume switch is not in error until we confirm where it is pointed
            wg_change_state         <= '0';
        end if;        
    end process;

    -- Force good waveguide switch status for now to aide in debug
    --wg_stat <= '1';
    --WG_SW_ERROR <= '0';
    --wg_sw_pos <= cmd_wg_sw_pos;
    --wg_dly <= '1';

    -- Check EMS BIT against the value it's supposed to be for the mode we're in
    CHECK_BITE : process (EXT_CLK, RESET)
    begin
        if rising_edge(EXT_CLK) then
            if wg_dly = '1' then -- Waveguide switch is not in transition
                case ops_mode is
                    when OPS_0_H_TX => -- horizontal transmit, receive both
                        ems_tx_error_vector     <= BIT_EMS xor EMS_HORZTX_TX;     --"0101001";
                        ems_rx_error_vector     <= BIT_EMS xor EMS_HORZTX_RX;     --"1010010";
                    when OPS_1_V_TX => -- vertical transmit, receive both
                        ems_tx_error_vector     <= BIT_EMS xor EMS_VERTTX_TX;     --"0101110";
                        ems_rx_error_vector     <= BIT_EMS xor EMS_VERTTX_RX;     --"1010011";
                    when OPS_2_HHVV_TX => -- HHVV transmit, receive both
                        if pol_state(1) = '0' then -- H transmit
                            ems_tx_error_vector <= BIT_EMS xor EMS_HORZTX_TX;     --"0101001";
                            ems_rx_error_vector <= BIT_EMS xor EMS_HORZTX_RX;     --"1010010";
                        else -- V transmit
                            ems_tx_error_vector <= BIT_EMS xor EMS_VERTTX_TX;     --"0101110";
                            ems_rx_error_vector <= BIT_EMS xor EMS_VERTTX_RX;     --"1010011";
                        end if;
                    when OPS_3_CREF_H => -- Corner reflector horizontal transmit, receive both
                        ems_tx_error_vector     <= BIT_EMS xor EMS_HORZTX_TX;     --"0101001";
                        ems_rx_error_vector     <= BIT_EMS xor EMS_CREF_RX;       --"0000010";
                    when OPS_4_NOISE => -- Noise source cal, no tx
                        ems_tx_error_vector     <= BIT_EMS xor EMS_NOISE_CAL;     --"0101101";
                        ems_rx_error_vector     <= BIT_EMS xor EMS_NOISE_CAL;     --"0101101";
                    when OPS_5_CREF_V => -- Corner reflector cal, vertical tx w/increased NF
                        ems_tx_error_vector     <= BIT_EMS xor EMS_VERTTX_TX;     --"0101110";
                        ems_rx_error_vector     <= BIT_EMS xor EMS_CREF_NOISE_RX; --"0000011";
                    when OPS_6_TEST => -- Test Mode, no tx
                        ems_tx_error_vector     <= BIT_EMS xor EMS_VERTTX_TX;     --"0101110";
                        ems_rx_error_vector     <= BIT_EMS xor EMS_VERTTX_RX;     --"1010011";
                    when OPS_7_ISOL_NOISE => -- vertical transmit, receive both, but enable noise source for testing
                        ems_tx_error_vector     <= BIT_EMS xor EMS_VERTTX_TX;     --"0101110";
                        ems_rx_error_vector     <= BIT_EMS xor EMS_VERTTX_RX;     --"1010011";
                    when others => -- default bad status for all
                    ems_tx_error_vector         <= (others=>'1');
                    ems_rx_error_vector         <= (others=>'1');
                end case;
            else
                -- report good status for all ems switches during waveguide switch transition
                ems_tx_error_vector             <= (others=>'0');
                ems_rx_error_vector             <= (others=>'0');
            end if;

        end if; --RE CLK
        if (RESET = '0') then
            ems_tx_error_vector                 <= (others=>'1');
            ems_rx_error_vector                 <= (others=>'1');
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

    -- Assign test signals to SPARE outputs for debug
    SPARE1        <= hv_flag;
    SPARE2        <= state_code(0);
    SPARE3        <= state_code(1);

    SPARE_STATUS0 <= TEST_BIT_0;
    SPARE_STATUS1 <= TEST_BIT_1;

    -- Update EMS switch status
    EMS_ERROR_1   <= ems_1_error;
    EMS_ERROR_2   <= ems_2_error;
    EMS_ERROR_3   <= ems_3_error;
    EMS_ERROR_45  <= ems_45_error;
    EMS_ERROR_67  <= ems_67_error;
    -- Latch OPS_MODE
    SET_OPS_MODE : process (EXT_CLK, RESET)
    begin
        if (RESET = '0') then
            ops_mode <= OPS_6_TEST; -- default to bench test
        elsif (rising_edge (EXT_CLK)) then
            if ops_mode_en = '1' then
                ops_mode <= OPS_MODE_730;
            else
                ops_mode <= ops_mode;
            end if;
        end if; --RE CLK
    end process;

    -- Latch EMS delays
    LATCH_DLY : process (EXT_CLK, RESET)
    begin
        if (RESET = '0') then
            l_tx_dly <= '0';
            l_rx_dly <= '0';
        elsif (rising_edge (EXT_CLK)) then
            l_tx_dly <= tx_dly;
            l_rx_dly <= rx_dly;
        end if; --RE CLK
    end process;

    -- Update EMS status when BIT is valid
    EMS_STAT : process (EXT_CLK, RESET)
    begin
        if (RESET = '0') then
            ems_tx_ok       <= '1';
            ems_rx_ok       <= '1';
            ems_1_error     <= '0';
            ems_2_error     <= '0';
            ems_3_error     <= '0';
            ems_45_error    <= '0';
            ems_67_error    <= '0';
            ems_tx_error    <= '0';
            mod_pulse_error <= '0';

        elsif (rising_edge (EXT_CLK)) then
            ems_tx_ok   <= ((not l_tx_dly and tx_dly and ems_tx_stat) or ems_tx_ok) and not end_cycle;

            ems_1_error <= (((not l_tx_dly and tx_dly and ems_1_tx_stat) or ems_1_error) and not STATUS_ACK) or
                           (((not l_rx_dly and rx_dly and ems_1_rx_stat) or ems_1_error) and not STATUS_ACK);
            ems_2_error <= (((not l_tx_dly and tx_dly and ems_2_tx_stat) or ems_2_error) and not STATUS_ACK) or
                           (((not l_rx_dly and rx_dly and ems_2_rx_stat) or ems_2_error) and not STATUS_ACK);
            ems_3_error <= (((not l_tx_dly and tx_dly and ems_3_tx_stat) or ems_3_error) and not STATUS_ACK) or
                           (((not l_rx_dly and rx_dly and ems_3_rx_stat) or ems_3_error) and not STATUS_ACK);
            ems_45_error <= (((not l_tx_dly and tx_dly and ems_45_tx_stat) or ems_45_error) and not STATUS_ACK) or
                            (((not l_rx_dly and rx_dly and ems_45_rx_stat) or ems_45_error) and not STATUS_ACK);
            ems_67_error <= (((not l_tx_dly and tx_dly and ems_67_tx_stat) or ems_67_error) and not STATUS_ACK) or
                            (((not l_rx_dly and rx_dly and ems_67_rx_stat) or ems_67_error) and not STATUS_ACK);
            ems_tx_error    <= (((not l_tx_dly and tx_dly and not ems_tx_stat) or ems_tx_error) and not STATUS_ACK);

            ems_rx_ok       <= ((not l_rx_dly and rx_dly and ems_rx_stat) or ems_rx_ok) and not end_cycle;

            mod_pulse_error <= (not (ems_pwr_ok and not ems_tx_error) or mod_pulse_error) and not STATUS_ACK;
        end if; --RE CLK
    end process;

    MOD_PULSE_DISABLE <=
        '1' when ops_mode = OPS_6_TEST
              or ops_mode = OPS_4_NOISE
              or ops_mode = OPS_7_ISOL_NOISE
              or mod_pulse_error = '1'
        else '0';

    EMS_PRT : process (EXT_CLK, RESET)
    begin
        if (rising_edge (EXT_CLK)) then

            ems_error_prt <= (((not l_tx_dly and tx_dly and not ems_tx_stat) or ems_error_prt) and not end_cycle) or
                             (((not l_rx_dly and rx_dly and not ems_rx_stat) or ems_error_prt) and not end_cycle);

        end if; --RE CLK
        if (RESET = '0') then
            ems_error_prt <= '0';
        end if;
    end process;
    EMS_ERROR_EVENT <= ems_error_prt; -- reports a maximum of one event per PRT

    -- Sets 1 second safety delay from HV_ON to enabling transmit triggers
    DELAY_1SEC : process (EXT_CLK, RESET)
    begin
        if (rising_edge (EXT_CLK)) then
            if (HV_ON_730 = '0') then
                if (hv_count = "111100000000000000000000") or TESTBENCH_MODE then -- ~1sec delay
                    hv_count     <= (others=>'0');
                    count_enable <= '0';
                    hv_dly       <= '1';
                elsif (count_enable = '1') then
                    hv_count <= hv_count + 1;
                end if;
            else
                hv_count     <= (others=>'0');
                hv_dly       <= '0';
                count_enable <= '1';
            end if;
        end if; --RE CLK
        if (RESET = '0') then
            hv_count     <= (others=>'0');
            hv_dly       <= '0';
            count_enable <= '1';
        end if;
    end process;

    -- Delay for 1 second while Pentek initializes, then enable U6; ohterwise, Pentek isn't discovered on PCI bus!
    -- This is a mystery, but haven't sufficient documentation on Pentek to sort it out.
    DELAY_U6_ENABLE : process (EXT_CLK, RESET)
    begin
        if (rising_edge (EXT_CLK)) then
            if (U6_count = "111100000000000000000000") then -- ~1sec delay
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
        if (RESET = '0') then
            U6_count        <= (others=>'0');
            U6_dly          <= '0';
            U6_count_enable <= '1';
        end if;
    end process;

    U6_OE <= not U6_dly;

    -- Sets 100 millisecond safety delay from waveguide switch command to switch in position
    DELAY_100MSEC : process (EXT_CLK, RESET)
    begin
        if (rising_edge (EXT_CLK)) then
            if (wg_change_state = '1') then -- waveguide switch is commanded to move
                if (wg_count = "101111101011110000011") then -- ~100 millisec delay
                    wg_count        <= (others=>'0');
                    wg_count_enable <= '0';
                    wg_dly          <= '1';
                elsif (wg_count_enable = '1') then
                    wg_count    <= wg_count + 1;
                    wg_dly      <= '0';
                end if;
            else
                wg_count        <= (others=>'0');
                wg_dly          <= '1';
                wg_count_enable <= '1';
            end if;
        end if; --RE CLK
        if (RESET = '0') then
            wg_count            <= (others=>'0');
            wg_dly              <= '0';
            wg_count_enable     <= '1';
        end if;
    end process;
    
    -- Generate registered EMS_TRIG
    LATCH_EMS_TRIG : process (EXT_CLK, RESET)
    begin
        if (rising_edge (EXT_CLK)) then
            l_ems_trig <= EMS_TRIG;
        end if; --RE CLK
        if (RESET = '0') then
            l_ems_trig <= '0';
        end if;
    end process;

    -- Generate EMS Transmit and Receive BIT count enables
    EMS_CNT_EN : process (EXT_CLK, RESET)
    begin
        if (rising_edge (EXT_CLK)) then
            ems_tx_count_enable <= ((EMS_TRIG and not l_ems_trig) or ems_tx_count_enable) and not end_cycle; -- rising edge of EMS_TRIG
            ems_rx_count_enable <= ((not EMS_TRIG and l_ems_trig) or ems_rx_count_enable) and not end_cycle; -- falling edge of EMS_TRIG
        end if; --RE CLK
        if (RESET = '0') then
            ems_tx_count_enable <= '0';
            ems_rx_count_enable <= '0';
        end if;
    end process;

    -- Sets delay from EMS switch trigger to EMS switch BIT valid on transmit
    EMS_TX_DELAY : process (EXT_CLK, RESET)
    begin
        if (rising_edge (EXT_CLK)) then
            if (ems_tx_count_enable = '1') then
                if (ems_tx_count = "100") then
                    ems_tx_count <= "00000";
                    tx_dly       <= '1';
                else
                    ems_tx_count <= ems_tx_count + 1;
                end if;
            else
                ems_tx_count <= "00000";
                tx_dly       <= '0';
            end if;
        end if; --RE CLK
        if (RESET = '0') then
            ems_tx_count <= "00000";
            tx_dly       <= '0';
        end if;
    end process;

    -- Sets delay from EMS switch trigger to EMS switch BIT valid on receive
    EMS_RX_DELAY : process (EXT_CLK, RESET)
    begin
        if (rising_edge (EXT_CLK)) then
            if (ems_rx_count_enable = '1') then
                if (ems_rx_count = "100") then
                    ems_rx_count <= "00000";
                    rx_dly       <= '1';
                else
                    ems_rx_count <= ems_rx_count + 1;
                end if;
            else
                ems_rx_count <= "00000";
                rx_dly       <= '0';
            end if;
        end if; --RE CLK
        if (RESET = '0') then
            ems_rx_count <= "00000";
            rx_dly       <= '0';
        end if;
    end process;

    -- Defines cycle over which State Machine operates
    CYCLE : process (EXT_CLK, RESET)
    begin
        if (rising_edge (EXT_CLK)) then
            l_rx_gate <= RX_GATE;
            end_cycle <= l_rx_gate and not RX_GATE; -- end cycle on falling edge of rx_gate!
        end if; --RE CLK
        if (RESET = '0') then
            end_cycle <= '0';
            l_rx_gate <= '0';
        end if;
    end process;

    HHVV : process (EXT_CLK, RESET)
    begin
        if (rising_edge (EXT_CLK)) then
            if (ops_mode = OPS_2_HHVV_TX and end_cycle = '1') then
                pol_state <= pol_state + 1; -- cycle through polarization states
            end if;
        end if; --RE CLK
        if (RESET = '0') then
            pol_state <= "11"; -- initial polarization state := V tx
        end if;
    end process;
    ------------------------ End Sychronous Processes ----------------------------------------------------

    ------------------------ State Machine ----------------------------------------------------------------

    STATE_MACHINE : process (EXT_CLK, RESET)
    begin
        if (rising_edge (EXT_CLK)) then
            case state is
                when s0 =>
                    if (ops_mode = OPS_6_TEST and EMS_TRIG = '1' and T0 = '1' and tx_dly = '0' and rx_dly = '0' and ems_pwr_ok = '1' and wg_stat = '1') then -- Test Mode
                        state <= s1;
                    elsif (ops_mode = OPS_4_NOISE and EMS_TRIG = '1' and T0 = '1' and tx_dly = '0' and rx_dly = '0' and ems_pwr_ok = '1' and wg_stat = '1') then -- Noise source cal
                        state <= s1;
                    elsif (ops_mode = OPS_7_ISOL_NOISE and EMS_TRIG = '1' and T0 = '1' and tx_dly = '0' and rx_dly = '0' and ems_pwr_ok = '1' and wg_stat = '1') then -- Noise source isolation test
                        state <= s1;
                    elsif (EMS_TRIG = '1' and T0 = '1' and tx_dly = '0' and rx_dly = '0' and hv_dly = '1' and ems_pwr_ok = '1' and wg_stat = '1') then
                        state <= s1;
                    end if;
                when s1 =>
                    if (ops_mode = OPS_6_TEST and ems_tx_ok = '1' and rx_dly = '0' and ems_pwr_ok = '1') then -- Test Mode
                        state <= s2;
                    elsif (ops_mode = OPS_4_NOISE and ems_tx_ok = '1' and rx_dly = '0' and ems_pwr_ok = '1') then -- Noise source cal
                        state <= s2;
                    elsif (ops_mode = OPS_7_ISOL_NOISE and ems_tx_ok = '1' and rx_dly = '0' and ems_pwr_ok = '1') then -- Noise source isolation test
                        state <= s2;
                    elsif (ems_tx_ok = '1' and rx_dly = '0' and hv_dly = '1' and ems_pwr_ok = '1') then
                        state <= s2;
                        -----------------------------------------------------------------------------------------------------
                        --                WHY AREN'T ALL STATES COVERED HERE???

                    elsif (ops_mode = OPS_0_H_TX and hv_dly = '0' and rx_dly = '0' and tx_dly = '1') then
                        state <= s0;
                    elsif (ops_mode = OPS_1_V_TX and hv_dly = '0' and rx_dly = '0' and tx_dly = '1') then
                        state <= s0;
                    elsif (ops_mode = OPS_2_HHVV_TX and hv_dly = '0' and rx_dly = '0' and tx_dly = '1') then
                        state <= s0;
                    elsif (ops_mode = OPS_3_CREF_H and hv_dly = '0' and rx_dly = '0' and tx_dly = '1') then
                        state <= s0;
                    elsif (ops_mode = OPS_5_CREF_V and hv_dly = '0' and rx_dly = '0' and tx_dly = '1') then
                        state <= s0;
                    end if;

                    -------------------------------------------------------------------------------------------------------------
                when s2 =>
                    if (ops_mode = OPS_6_TEST and tx_dly = '1' and ems_pwr_ok = '1') then -- Test Mode
                        state <= s3;
                    elsif (ops_mode = OPS_4_NOISE and tx_dly = '1' and ems_pwr_ok = '1') then -- Noise source cal
                        state <= s3;
                    elsif (ops_mode = OPS_7_ISOL_NOISE and tx_dly = '1' and ems_pwr_ok = '1') then -- Noise source isolation test
                        state <= s3;
                    elsif (rx_dly = '1' and tx_dly = '1' and hv_dly = '1' and ems_pwr_ok = '1') then
                        state <= s3;
                    elsif (rx_dly = '1' and tx_dly = '1' and hv_dly = '0' and ems_pwr_ok = '1') then
                        state <= s0;
                    elsif (rx_dly = '1' and tx_dly = '1' and hv_dly = '1' and ems_pwr_ok = '0') then
                        state <= s0;
                    elsif (rx_dly = '1' and tx_dly = '1' and hv_dly = '0' and ems_pwr_ok = '0') then
                        state <= s0;
                    end if;
                when s3 =>
                    --                if(RX_GATE = '0' AND ems_tx_ok = '1' AND rx_dly = '0' AND tx_dly = '0') then
                    if (RX_GATE = '0' and rx_dly = '0' and tx_dly = '0') then
                        state <= s0;
                    end if;
                when others =>
                    state <= s0;
            end case;
        
        end if; --RE CLK        
        if (RESET = '0') then
            state <= s0;
        end if;        
    end process;

    -- State Machine Ouputs

    STATE_OUT : process (EXT_CLK, RESET)
    begin
        if rising_edge(EXT_CLK) then
        
            ops_mode_en      <= '0';
            cmd_wg_sw_pos    <= '0';
            MOD_PULSE_HMC    <= '0';
            EMS_OUT          <= "0000000";
            WG_SW_CTRL_TERM  <= '0';
            WG_SW_CTRL_NOISE <= '1';
            NOISE_SOURCE_EN  <= '0';
            cmd_wg_sw_pos    <= '0';
            hv_flag          <= '0';
            
            case state is
                when S0 => -- Reset State, ensure EMS switches transition each PRT
                    --            ops_mode <= OPS_MODE_730;
                    ops_mode_en   <= '1';
                    MOD_PULSE_HMC <= '0';
                    if (ops_mode = OPS_4_NOISE) then -- Noise source cal, no tx
                        EMS_OUT          <= "1010010";
                        WG_SW_CTRL_TERM  <= '1';
                        WG_SW_CTRL_NOISE <= '0';
                        NOISE_SOURCE_EN  <= '1';
                        cmd_wg_sw_pos    <= '1';

                    elsif (ops_mode = OPS_7_ISOL_NOISE) then -- Noise source isolation test
                        WG_SW_CTRL_TERM  <= '1';
                        WG_SW_CTRL_NOISE <= '0';
                        NOISE_SOURCE_EN  <= '1';
                        cmd_wg_sw_pos    <= '1';

                    elsif (ops_mode = OPS_0_H_TX) then -- Horizontal tx, receive both
                        EMS_OUT(3)       <= '1';
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';

                    elsif (ops_mode = OPS_3_CREF_H) then -- Corner reflector cal, horizontal tx w/increased NF
                        EMS_OUT(3)       <= '1';
                        EMS_OUT(5)       <= '1';
                        EMS_OUT(7)       <= '1';
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';

                    elsif (ops_mode = OPS_5_CREF_V) then -- Corner reflector cal, vertical tx w/increased NF
                        EMS_OUT(2)       <= '0';
                        EMS_OUT(5)       <= '1';
                        EMS_OUT(7)       <= '1';
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';

                    elsif (ops_mode = OPS_2_HHVV_TX) then -- Alternating HHVV
                        if (pol_state = "11") then -- V tx, receive both (initial HHVV state)
                            EMS_OUT(2) <= '0';
                        elsif (pol_state = "00") then -- H tx, receive both
                            EMS_OUT(1) <= '0';
                            EMS_OUT(3) <= '1';
                        elsif (pol_state = "01") then -- H tx, receive both
                            EMS_OUT(3) <= '1';
                        elsif (pol_state = "10") then -- V tx, receive both
                            EMS_OUT(1) <= '1';
                            EMS_OUT(2) <= '0';
                        end if;
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    else
                        EMS_OUT          <= "0000000";
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    end if;
                when S1 =>
                    ops_mode_en <= '0';
                    if (ops_mode = OPS_0_H_TX) then -- Horizontal tx, receive both
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT(1)       <= EMS_TRIG;
                        EMS_OUT(2)       <= not EMS_TRIG;
                        EMS_OUT(3)       <= '0';
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        hv_flag          <= '1'; -- Tx-H
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_1_V_TX) then -- Vertical tx, receive both
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        hv_flag          <= '0'; -- Tx-V
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_2_HHVV_TX) then -- HHVV tx, receive both
                        if (pol_state = "00") then -- transmit H
                            MOD_PULSE_HMC    <= '0';
                            EMS_OUT(1)       <= EMS_TRIG;
                            EMS_OUT(2)       <= not EMS_TRIG;
                            EMS_OUT(3)       <= '0';
                            EMS_OUT(4)       <= EMS_TRIG;
                            EMS_OUT(5)       <= not EMS_TRIG;
                            EMS_OUT(6)       <= EMS_TRIG;
                            EMS_OUT(7)       <= not EMS_TRIG;
                            hv_flag          <= '1'; -- H
                            WG_SW_CTRL_TERM  <= '0';
                            WG_SW_CTRL_NOISE <= '1';
                            NOISE_SOURCE_EN  <= '0';
                            cmd_wg_sw_pos    <= '0';
                        elsif (pol_state = "01") then -- transmit H
                            MOD_PULSE_HMC    <= '0';
                            EMS_OUT(1)       <= EMS_TRIG;
                            EMS_OUT(2)       <= not EMS_TRIG;
                            EMS_OUT(3)       <= '0';
                            EMS_OUT(4)       <= EMS_TRIG;
                            EMS_OUT(5)       <= not EMS_TRIG;
                            EMS_OUT(6)       <= EMS_TRIG;
                            EMS_OUT(7)       <= not EMS_TRIG;
                            hv_flag          <= '1'; -- H
                            WG_SW_CTRL_TERM  <= '0';
                            WG_SW_CTRL_NOISE <= '1';
                            NOISE_SOURCE_EN  <= '0';
                            cmd_wg_sw_pos    <= '0';
                        elsif (pol_state = "10") then -- transmit V
                            MOD_PULSE_HMC    <= '0';
                            EMS_OUT(1)       <= not EMS_TRIG;
                            EMS_OUT(2)       <= '1';
                            EMS_OUT(3)       <= EMS_TRIG;
                            EMS_OUT(4)       <= EMS_TRIG;
                            EMS_OUT(5)       <= not EMS_TRIG;
                            EMS_OUT(6)       <= EMS_TRIG;
                            EMS_OUT(7)       <= not EMS_TRIG;
                            hv_flag          <= '0'; -- V
                            WG_SW_CTRL_TERM  <= '0';
                            WG_SW_CTRL_NOISE <= '1';
                            NOISE_SOURCE_EN  <= '0';
                            cmd_wg_sw_pos    <= '0';
                        else -- transmit V
                            MOD_PULSE_HMC    <= '0';
                            EMS_OUT(1)       <= not EMS_TRIG;
                            EMS_OUT(2)       <= '1';
                            EMS_OUT(3)       <= EMS_TRIG;
                            EMS_OUT(4)       <= EMS_TRIG;
                            EMS_OUT(5)       <= not EMS_TRIG;
                            EMS_OUT(6)       <= EMS_TRIG;
                            EMS_OUT(7)       <= not EMS_TRIG;
                            hv_flag          <= '0'; -- V
                            WG_SW_CTRL_TERM  <= '0';
                            WG_SW_CTRL_NOISE <= '1';
                            NOISE_SOURCE_EN  <= '0';
                            cmd_wg_sw_pos    <= '0';
                        end if;
                    elsif (ops_mode = OPS_3_CREF_H) then -- Corner reflector horizontal tx w/increased NF
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT(1)       <= EMS_TRIG;
                        EMS_OUT(2)       <= not EMS_TRIG;
                        EMS_OUT(3)       <= '0';
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= '0';
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= '0';
                        hv_flag          <= '1'; -- H
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_4_NOISE) then -- Noise source cal, no tx
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT          <= "0101101";
                        WG_SW_CTRL_TERM  <= '1';
                        WG_SW_CTRL_NOISE <= '0';
                        NOISE_SOURCE_EN  <= '1';
                        cmd_wg_sw_pos    <= '1';
                        hv_flag          <= '0'; -- V
                    elsif (ops_mode = OPS_5_CREF_V) then -- Corner reflector cal, vertical tx w/increased NF
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= '0';
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= '0';
                        hv_flag          <= '0'; -- V
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_6_TEST) then -- Test Mode, no tx
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        hv_flag          <= '0'; -- V
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_7_ISOL_NOISE) then -- Vertical tx, receive both, enable noise source for testing
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        hv_flag          <= '0'; -- V
                        WG_SW_CTRL_TERM  <= '1';
                        WG_SW_CTRL_NOISE <= '0';
                        NOISE_SOURCE_EN  <= '1';
                        cmd_wg_sw_pos    <= '1';
                    else
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT          <= "0000000";
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                        hv_flag          <= '1'; -- H
                    end if;
                when S2 =>
                    ops_mode_en <= '0';
                    if (ops_mode = OPS_0_H_TX) then -- Horizontal tx, receive both
                        MOD_PULSE_HMC    <= MOD_PULSE;
                        EMS_OUT(1)       <= EMS_TRIG;
                        EMS_OUT(2)       <= not EMS_TRIG;
                        EMS_OUT(3)       <= '0';
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_1_V_TX) then -- Vertical tx, receive both
                        MOD_PULSE_HMC    <= MOD_PULSE;
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_2_HHVV_TX) then -- HHVV tx, receive both
                        if (pol_state = "00") then -- transmit H
                            MOD_PULSE_HMC    <= MOD_PULSE;
                            EMS_OUT(1)       <= EMS_TRIG;
                            EMS_OUT(2)       <= not EMS_TRIG;
                            EMS_OUT(3)       <= '0';
                            EMS_OUT(4)       <= EMS_TRIG;
                            EMS_OUT(5)       <= not EMS_TRIG;
                            EMS_OUT(6)       <= EMS_TRIG;
                            EMS_OUT(7)       <= not EMS_TRIG;
                            WG_SW_CTRL_TERM  <= '0';
                            WG_SW_CTRL_NOISE <= '1';
                            NOISE_SOURCE_EN  <= '0';
                            cmd_wg_sw_pos    <= '0';
                        elsif (pol_state = "01") then -- transmit H
                            MOD_PULSE_HMC    <= MOD_PULSE;
                            EMS_OUT(1)       <= EMS_TRIG;
                            EMS_OUT(2)       <= not EMS_TRIG;
                            EMS_OUT(3)       <= '0';
                            EMS_OUT(4)       <= EMS_TRIG;
                            EMS_OUT(5)       <= not EMS_TRIG;
                            EMS_OUT(6)       <= EMS_TRIG;
                            EMS_OUT(7)       <= not EMS_TRIG;
                            WG_SW_CTRL_TERM  <= '0';
                            WG_SW_CTRL_NOISE <= '1';
                            NOISE_SOURCE_EN  <= '0';
                            cmd_wg_sw_pos    <= '0';
                        elsif (pol_state = "10") then -- transmit V
                            MOD_PULSE_HMC    <= MOD_PULSE;
                            EMS_OUT(1)       <= not EMS_TRIG;
                            EMS_OUT(2)       <= '1';
                            EMS_OUT(3)       <= EMS_TRIG;
                            EMS_OUT(4)       <= EMS_TRIG;
                            EMS_OUT(5)       <= not EMS_TRIG;
                            EMS_OUT(6)       <= EMS_TRIG;
                            EMS_OUT(7)       <= not EMS_TRIG;
                            WG_SW_CTRL_TERM  <= '0';
                            WG_SW_CTRL_NOISE <= '1';
                            NOISE_SOURCE_EN  <= '0';
                            cmd_wg_sw_pos    <= '0';
                        else -- transmit V
                            MOD_PULSE_HMC    <= MOD_PULSE;
                            EMS_OUT(1)       <= not EMS_TRIG;
                            EMS_OUT(2)       <= '1';
                            EMS_OUT(3)       <= EMS_TRIG;
                            EMS_OUT(4)       <= EMS_TRIG;
                            EMS_OUT(5)       <= not EMS_TRIG;
                            EMS_OUT(6)       <= EMS_TRIG;
                            EMS_OUT(7)       <= not EMS_TRIG;
                            WG_SW_CTRL_TERM  <= '0';
                            WG_SW_CTRL_NOISE <= '1';
                            NOISE_SOURCE_EN  <= '0';
                            cmd_wg_sw_pos    <= '0';
                        end if;
                    elsif (ops_mode = OPS_3_CREF_H) then -- Corner reflector cal Horizontal tx w/increased NF
                        MOD_PULSE_HMC    <= MOD_PULSE;
                        EMS_OUT(1)       <= EMS_TRIG;
                        EMS_OUT(2)       <= not EMS_TRIG;
                        EMS_OUT(3)       <= '0';
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= '0';
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= '0';
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_4_NOISE) then -- Noise source cal, no tx
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT          <= "0101101";
                        WG_SW_CTRL_TERM  <= '1';
                        WG_SW_CTRL_NOISE <= '0';
                        NOISE_SOURCE_EN  <= '1';
                        cmd_wg_sw_pos    <= '1';
                    elsif (ops_mode = OPS_5_CREF_V) then -- Corner reflector cal, vertical tx w/increased NF
                        MOD_PULSE_HMC    <= MOD_PULSE;
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= '0';
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= '0';
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_6_TEST) then -- Test Mode, no tx
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_7_ISOL_NOISE) then -- Vertical tx, receive both, enable noise source for test
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        WG_SW_CTRL_TERM  <= '1';
                        WG_SW_CTRL_NOISE <= '0';
                        NOISE_SOURCE_EN  <= '1';
                        cmd_wg_sw_pos    <= '1';
                    else
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT          <= "0000000";
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    end if;
                when S3 =>
                    ops_mode_en <= '0';
                    if (ops_mode = OPS_0_H_TX) then -- Horizontal tx, receive both
                        MOD_PULSE_HMC    <= MOD_PULSE;
                        EMS_OUT(1)       <= EMS_TRIG;
                        EMS_OUT(2)       <= not EMS_TRIG;
                        EMS_OUT(3)       <= '0';
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_1_V_TX) then -- Vertical tx, receive both
                        MOD_PULSE_HMC    <= MOD_PULSE;
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_2_HHVV_TX) then -- HHVV tx, receive both
                        case pol_state is
                            when "00" => -- transmit H
                                MOD_PULSE_HMC    <= MOD_PULSE;
                                EMS_OUT(1)       <= EMS_TRIG;
                                EMS_OUT(2)       <= not EMS_TRIG;
                                EMS_OUT(3)       <= '0';
                                EMS_OUT(4)       <= EMS_TRIG;
                                EMS_OUT(5)       <= not EMS_TRIG;
                                EMS_OUT(6)       <= EMS_TRIG;
                                EMS_OUT(7)       <= not EMS_TRIG;
                                WG_SW_CTRL_TERM  <= '0';
                                WG_SW_CTRL_NOISE <= '1';
                                NOISE_SOURCE_EN  <= '0';
                                cmd_wg_sw_pos    <= '0';
                            when "01" => -- transmit H
                                MOD_PULSE_HMC    <= MOD_PULSE;
                                EMS_OUT(1)       <= EMS_TRIG;
                                EMS_OUT(2)       <= not EMS_TRIG;
                                EMS_OUT(3)       <= '0';
                                EMS_OUT(4)       <= EMS_TRIG;
                                EMS_OUT(5)       <= not EMS_TRIG;
                                EMS_OUT(6)       <= EMS_TRIG;
                                EMS_OUT(7)       <= not EMS_TRIG;
                                WG_SW_CTRL_TERM  <= '0';
                                WG_SW_CTRL_NOISE <= '1';
                                NOISE_SOURCE_EN  <= '0';
                                cmd_wg_sw_pos    <= '0';
                            when "10" => -- transmit V
                                MOD_PULSE_HMC    <= MOD_PULSE;
                                EMS_OUT(1)       <= not EMS_TRIG;
                                EMS_OUT(2)       <= '1';
                                EMS_OUT(3)       <= EMS_TRIG;
                                EMS_OUT(4)       <= EMS_TRIG;
                                EMS_OUT(5)       <= not EMS_TRIG;
                                EMS_OUT(6)       <= EMS_TRIG;
                                EMS_OUT(7)       <= not EMS_TRIG;
                                WG_SW_CTRL_TERM  <= '0';
                                WG_SW_CTRL_NOISE <= '1';
                                NOISE_SOURCE_EN  <= '0';
                                cmd_wg_sw_pos    <= '0';
                            when "11" => -- transmit V
                                MOD_PULSE_HMC    <= MOD_PULSE;
                                EMS_OUT(1)       <= not EMS_TRIG;
                                EMS_OUT(2)       <= '1';
                                EMS_OUT(3)       <= EMS_TRIG;
                                EMS_OUT(4)       <= EMS_TRIG;
                                EMS_OUT(5)       <= not EMS_TRIG;
                                EMS_OUT(6)       <= EMS_TRIG;
                                EMS_OUT(7)       <= not EMS_TRIG;
                                WG_SW_CTRL_TERM  <= '0';
                                WG_SW_CTRL_NOISE <= '1';
                                NOISE_SOURCE_EN  <= '0';
                                cmd_wg_sw_pos    <= '0';
                            when others =>
                        end case;
                    elsif (ops_mode = OPS_3_CREF_H) then -- Corner reflector cal, horizontal tx w/increased NF
                        MOD_PULSE_HMC    <= MOD_PULSE;
                        EMS_OUT(1)       <= EMS_TRIG;
                        EMS_OUT(2)       <= not EMS_TRIG;
                        EMS_OUT(3)       <= '0';
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= '0';
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= '0';
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_4_NOISE) then -- Noise source cal, no tx
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT          <= "0101101";
                        WG_SW_CTRL_TERM  <= '1';
                        WG_SW_CTRL_NOISE <= '0';
                        NOISE_SOURCE_EN  <= '1';
                        cmd_wg_sw_pos    <= '1';
                    elsif (ops_mode = OPS_5_CREF_V) then -- Corner reflector cal, vertical tx w/increased NF
                        MOD_PULSE_HMC    <= MOD_PULSE;
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= '0';
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= '0';
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_6_TEST) then -- Test Mode, no tx
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    elsif (ops_mode = OPS_7_ISOL_NOISE) then -- Vertical tx, receive both
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT(1)       <= not EMS_TRIG;
                        EMS_OUT(2)       <= '1';
                        EMS_OUT(3)       <= EMS_TRIG;
                        EMS_OUT(4)       <= EMS_TRIG;
                        EMS_OUT(5)       <= not EMS_TRIG;
                        EMS_OUT(6)       <= EMS_TRIG;
                        EMS_OUT(7)       <= not EMS_TRIG;
                        WG_SW_CTRL_TERM  <= '1';
                        WG_SW_CTRL_NOISE <= '0';
                        NOISE_SOURCE_EN  <= '1';
                        cmd_wg_sw_pos    <= '1';
                    else
                        MOD_PULSE_HMC    <= '0';
                        EMS_OUT          <= "0000000";
                        WG_SW_CTRL_TERM  <= '0';
                        WG_SW_CTRL_NOISE <= '1';
                        NOISE_SOURCE_EN  <= '0';
                        cmd_wg_sw_pos    <= '0';
                    end if;
                when others =>
                    ops_mode_en      <= '0';
                    cmd_wg_sw_pos    <= '0';
                    MOD_PULSE_HMC    <= '0';
                    EMS_OUT          <= "0000000";
                    WG_SW_CTRL_TERM  <= '0';
                    WG_SW_CTRL_NOISE <= '1';
                    NOISE_SOURCE_EN  <= '0';
                    cmd_wg_sw_pos    <= '0';
            end case;
            
        end if; --RE CLK
        if (RESET = '0') then
            ops_mode_en      <= '0';
            cmd_wg_sw_pos    <= '0';
            MOD_PULSE_HMC    <= '0';
            EMS_OUT          <= "0000000";
            WG_SW_CTRL_TERM  <= '0';
            WG_SW_CTRL_NOISE <= '1';
            NOISE_SOURCE_EN  <= '0';
            cmd_wg_sw_pos    <= '0';
            hv_flag          <= '0';
        end if;            
    end process;

    -------------------------------------------------------------------------------------------------------
end Behavioral;
