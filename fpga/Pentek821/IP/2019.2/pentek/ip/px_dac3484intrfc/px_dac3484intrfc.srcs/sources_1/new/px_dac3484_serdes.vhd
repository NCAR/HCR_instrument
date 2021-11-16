----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2019 01:59:44 PM
-- Design Name: 
-- Module Name: px_dac3484_serdes - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revisoin 1.00 - 10/9/20 - Added TAP delay capability on DAC SYNC and OSTR
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

Library xpm;
use xpm.vcomponents.all;

entity px_dac3484_serdes is
generic (

    initial_sync_tap_delay    : integer := 0;
    initial_ostrb_tap_delay   : integer := 0;
    
    idelaycntrl_refclk_freq   : integer := 200; -- in MHz
    iodelay_grp               : string := "IODELAY_GRP"

);
Port ( 

    s_dac_axis_aresetn : in std_logic;

    DAC_CLK_IN     : in  std_logic;
    s_dac_axis_aclk : in std_logic;
    DAC_DATA_A_IN  : in  std_logic_vector (63 downto 0);
    dac_reseta_n_in : in  std_logic;
    dac_sync_in    : in  std_logic;
    dac_serdes_int_rst : in std_logic;
    DAC_CLK        : out std_logic;
    
    sync_tap_delay           : in std_logic_vector(8 downto 0);    
    sync_tap_delay_ld        : in std_logic;
    ostrb_tap_delay          : in std_logic_vector(8 downto 0);
    ostrb_tap_delay_ld       : in std_logic;
    
    dac_ostr       : out std_logic;
    -- Data to the 3484
    DAC_DATA_P      : out std_logic_vector(15 downto 0); -- DAC Data +
    DAC_DATA_N      : out std_logic_vector(15 downto 0); -- DAC Data -
    DAC_DCLK_P      : out std_logic;
    DAC_DCLK_N      : out std_logic;
     
    DAC_FRAME_P   : out std_logic;
    DAC_FRAME_N   : out std_logic;
    DAC_PARITY_P  : out std_logic;
    DAC_PARITY_N  : out std_logic;
    DAC_OSTR_P       : out std_logic;
    DAC_OSTR_N       : out std_logic;
        
    -- DAC Control/Status Signals
    DAC_SYNC_P    : out std_logic; -- DAC Sync +
    DAC_SYNC_N    : out std_logic; -- DAC Sync -
    DAC_RESET_N   : out std_logic  -- Reset to the DAC



);
end px_dac3484_serdes;

architecture Behavioral of px_dac3484_serdes is

constant refclk_freq : real := real(idelaycntrl_refclk_freq);

attribute IODELAY_GROUP: string;
--attribute IODELAY_GROUP of ODELAYE_sync_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE_dacclk_inst: label is iodelay_grp;


type t_data_in_a is array (0 to 15) of std_logic_vector(7 downto 0);

signal data_in_a               : t_data_in_a;
signal data_out_a              : std_logic_vector(15 downto 0);
signal clk_in_a                : std_logic_vector(7 downto 0);
signal clk_out_a               : std_logic;
signal sync_in                 : std_logic_vector(7 downto 0);
signal dac_sync_in_reg         : std_logic;
signal dac_sync_out            : std_logic;
signal dac_ostr_in             : std_logic;
signal dac_ostr_out            : std_logic;
signal ostr_in                 : std_logic_vector(7 downto 0);
signal dac_reset_in            : std_logic_vector(7 downto 0);
signal dac_frame               : std_logic;
signal dac_parity              : std_logic;
signal dac_serdes_int_rst_reg1 : std_logic;
signal dac_serdes_int_rst_reg2 : std_logic;

signal dac_clk_in_inv          : std_logic := '0';

signal dly_ld_ctl_re      : std_logic := '0';
signal t1_dly_ld_ctl      : std_logic := '0';
signal dly_ld_ctl         : std_logic := '0';
signal ctl_dly_ld         : std_logic := '0';
signal ctl_en_vtc         : std_logic := '0';
signal ctl_tap_delay      : std_logic_vector(8 downto 0) := (others => '0');
signal ld_cntr            : std_logic_vector(5 downto 0) := "000000";

attribute mark_debug : string;
attribute keep : string;
attribute mark_debug of sync_in     : signal is "true";
attribute mark_debug of dac_sync_in_reg  : signal is "true";
attribute mark_debug of dac_ostr_in  : signal is "true";
attribute mark_debug of ostr_in  : signal is "true";
attribute mark_debug of data_in_a  : signal is "true";


begin

dac_ostr <= dac_ostr_in;

process(s_dac_axis_aclk) begin

    if(rising_edge(s_dac_axis_aclk)) then
        dac_serdes_int_rst_reg1 <= DAC_SERDES_INT_RST;
        dac_serdes_int_rst_reg2 <= dac_serdes_int_rst_reg1;
        
        dac_sync_in_reg                <= dac_sync_in;
        dac_ostr_in                    <= dac_sync_in_reg;          
    end if;
end process;


data_serdes_gen_a: for i in 0 to 15 generate

    --data_in_a(i) <= "0000" & DAC_DATA_A_IN(32+i) & DAC_DATA_A_IN(48+i) & DAC_DATA_A_IN(i) & DAC_DATA_A_IN(16+i);
    data_in_a(i) <= "0000" & DAC_DATA_A_IN(48+i) & DAC_DATA_A_IN(32+i) & DAC_DATA_A_IN(16+i) & DAC_DATA_A_IN(i);
    
    data_OSERDESE3_inst : OSERDESE3
       generic map (
          DATA_WIDTH => 4,            -- Parallel Data Width (4-8)
          INIT => '0',                -- Initialization value of the OSERDES flip-flops
          IS_CLKDIV_INVERTED => '0',  -- Optional inversion for CLKDIV
          IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
          IS_RST_INVERTED => '0',     -- Optional inversion for RST
          SIM_DEVICE => "ULTRASCALE"  -- Set the device version (ULTRASCALE)
       )
       port map (
          OQ => data_out_a(i),      -- 1-bit output: Serial Output Data
          T_OUT => open,           -- 1-bit output: 3-state control output to IOB
          CLK => DAC_CLK_IN,       -- 1-bit input: High-speed clock
          CLKDIV => s_dac_axis_aclk, -- 1-bit input: Divided Clock
          D => data_in_a(i),           -- 8-bit input: Parallel Data Input
          RST => dac_serdes_int_rst_reg2,       -- 1-bit input: Asynchronous Reset
          T => '0'                                -- 1-bit input: Tristate input from fabric
       );
    
    --data_OSERDESE1_inst : OSERDESE1
    --   generic map (
    --      DATA_RATE_OQ => "DDR",       -- "SDR" or "DDR" 
    --      DATA_RATE_TQ => "DDR",       -- "BUF", "SDR" or "DDR" 
    --      DATA_WIDTH => 4,             -- Parallel data width (1-8,10)
    --      DDR3_DATA => 1,              -- Must leave at 1 (MIG-only parameter)
    --      INIT_OQ => '0',              -- Initial value of OQ output (0/1)
    --      INIT_TQ => '0',              -- Initial value of TQ output (0/1)
    --      INTERFACE_TYPE => "DEFAULT", -- Must leave at "DEFAULT" (MIG-only parameter)
    --      ODELAY_USED => 0,            -- Must leave at 0 (MIG-only parameter)
    --      SERDES_MODE => "MASTER",     -- "MASTER" or "SLAVE" 
    --      SRVAL_OQ => '0',             -- OQ output value when SR is used (0/1)
    --      SRVAL_TQ => '0',             -- TQ output value when SR is used (0/1)
    --      TRISTATE_WIDTH => 4          -- Parallel to serial 3-state converter width (1 or 4)
    --   )
    --   port map (
    --      -- MIG-only Signals: 1-bit (each) output Do not use unless generated by MIG
    --      OCBEXTEND => open,       -- 1-bit output Leave unconnected (MIG-only connected signal)
    --      -- Outputs: 1-bit (each) output Serial output ports
    --      OFB => open,                  -- 1-bit output Data feedback output to ISERDESE1
    --      OQ => data_out_a(i),            -- 1-bit output Data output (connect to I/O port)
    --      TFB => open,                   -- 1-bit output 3-state control output
    --      TQ => open,                     -- 1-bit output 3-state path output
    --      -- SHIFTOUT1-SHIFTOUT2: 1-bit (each) output Data width expansion output ports
    --      SHIFTOUT1 => open,       -- 1-bit output Connect to SHIFTIN1 of slave or unconnected
    --      SHIFTOUT2 => open,       -- 1-bit output Connect to SHIFTIN2 of slave or unconnected
    --      -- Clocks: 1-bit (each) input OSERDESE1 clock input ports
    --      CLK => DAC_CLK_IN,                   -- 1-bit input High-speed clock input
    --      CLKDIV => s_dac_axis_aclk,       -- 1-bit input Divided clock input
    --      -- Control Signals: 1-bit (each) input Clock enable and reset input ports
    --      OCE => '1',                   -- 1-bit input Active high clock data path enable input
    --      RST => dac_serdes_int_rst_reg2,     -- 1-bit input Active high reset input
    --      TCE => '1',                   -- 1-bit input Active high clock enable input for 3-state
    --      -- D1 - D6: 1-bit (each) input Parallel data inputs
    --      D1 => DAC_DATA_A_IN(16+i),
    --      D2 => DAC_DATA_A_IN(i),   
    --      D3 => DAC_DATA_A_IN(48+i),
    --      D4 => DAC_DATA_A_IN(32+i),
    --      D5 => '0',
    --      D6 => '0',
    --      -- MIG-only Signals: 1-bit (each) input Do not use unless generated by MIG
    --      CLKPERF => '0',           -- 1-bit input Ground input (MIG-only connected signal)
    --      CLKPERFDELAY => '0', -- 1-bit input Ground input (MIG-only connected signal)
    --      ODV => '0',                   -- 1-bit input Ground input (MIG-only connected signal)
    --      WC => '0',                     -- 1-bit input Ground input (MIG-only connected signal)
    --      -- SHIFTIN1-SHIFTIN2: 1-bit (each) input Data width expansion input ports
    --      SHIFTIN1 => '0',         -- 1-bit input Connect to SHIFTOUT1 of master or GND
    --      SHIFTIN2 => '0',         -- 1-bit input Connect to SHIFTOUT2 of master or GND
    --      -- T1 - T4: 1-bit (each) input Parallel 3-state inputs
    --      T1 => '0',
    --      T2 => '0',
    --      T3 => '0',
    --      T4 => '0' 
    --   );

   data_OBUFDS_inst : OBUFDS
   generic map (
      IOSTANDARD => "LVDS_25"
      )
   port map (
      O  => DAC_DATA_P(i), -- Diff_p output (connect directly to top-level port)
      OB => DAC_DATA_N(i), -- Diff_n output (connect directly to top-level port)
      I  => data_out_a(i)      -- Buffer input 
   );
   

end generate;


dac_clk_in_inv <= not DAC_CLK_IN;
ODELAYE_dacclk_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => clk_out_a,         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_dac_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => sync_tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => ctl_en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => ctl_dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => dac_clk_in,         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

--clk_in_a <= "00001010";
--
--clk_OSERDESE3_inst : OSERDESE3
--   generic map (
--      DATA_WIDTH => 4,            -- Parallel Data Width (4-8)
--      INIT => '0',                -- Initialization value of the OSERDES flip-flops
--      IS_CLKDIV_INVERTED => '0',  -- Optional inversion for CLKDIV
--      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
--      IS_RST_INVERTED => '0',     -- Optional inversion for RST
--      SIM_DEVICE => "ULTRASCALE"  -- Set the device version (ULTRASCALE)
--   )
--   port map (
--      OQ => clk_out_a,         -- 1-bit output: Serial Output Data
--      T_OUT => open,   -- 1-bit output: 3-state control output to IOB
--      CLK => DAC_CLK_IN,       -- 1-bit input: High-speed clock
--      CLKDIV => s_dac_axis_aclk, -- 1-bit input: Divided Clock
--      D => clk_in_a,           -- 8-bit input: Parallel Data Input
--      RST => dac_serdes_int_rst_reg2,       -- 1-bit input: Asynchronous Reset
--      T => '0'            -- 1-bit input: Tristate input from fabric
--   );

--clka_OSERDESE1_inst : OSERDESE1
--   generic map (
--      DATA_RATE_OQ => "DDR",       -- "SDR" or "DDR" 
--      DATA_RATE_TQ => "DDR",       -- "BUF", "SDR" or "DDR" 
--      DATA_WIDTH => 4,             -- Parallel data width (1-8,10)
--      DDR3_DATA => 1,              -- Must leave at 1 (MIG-only parameter)
--      INIT_OQ => '0',              -- Initial value of OQ output (0/1)
--      INIT_TQ => '0',              -- Initial value of TQ output (0/1)
--      INTERFACE_TYPE => "DEFAULT", -- Must leave at "DEFAULT" (MIG-only parameter)
--      ODELAY_USED => 0,            -- Must leave at 0 (MIG-only parameter)
--      SERDES_MODE => "MASTER",     -- "MASTER" or "SLAVE" 
--      SRVAL_OQ => '0',             -- OQ output value when SR is used (0/1)
--      SRVAL_TQ => '0',             -- TQ output value when SR is used (0/1)
--      TRISTATE_WIDTH => 4          -- Parallel to serial 3-state converter width (1 or 4)
--   )
--   port map (
--      -- MIG-only Signals: 1-bit (each) output Do not use unless generated by MIG
--      OCBEXTEND => open,       -- 1-bit output Leave unconnected (MIG-only connected signal)
--      -- Outputs: 1-bit (each) output Serial output ports
--      OFB => open,                  -- 1-bit output Data feedback output to ISERDESE1
--      OQ => clk_out_a,            -- 1-bit output Data output (connect to I/O port)
--      TFB => open,                   -- 1-bit output 3-state control output
--      TQ => open,                     -- 1-bit output 3-state path output
--      -- SHIFTOUT1-SHIFTOUT2: 1-bit (each) output Data width expansion output ports
--      SHIFTOUT1 => open,       -- 1-bit output Connect to SHIFTIN1 of slave or unconnected
--      SHIFTOUT2 => open,       -- 1-bit output Connect to SHIFTIN2 of slave or unconnected
--      -- Clocks: 1-bit (each) input OSERDESE1 clock input ports
--      CLK => DAC_CLK_IN,                   -- 1-bit input High-speed clock input
--      CLKDIV => s_dac_axis_aclk,       -- 1-bit input Divided clock input
--      -- Control Signals: 1-bit (each) input Clock enable and reset input ports
--      OCE => '1',                   -- 1-bit input Active high clock data path enable input
--      RST => dac_serdes_int_rst_reg2,  -- 1-bit input Active high reset input
--      TCE => '1',                   -- 1-bit input Active high clock enable input for 3-state
--      -- D1 - D6: 1-bit (each) input Parallel data inputs
--      D1 => '1',
--      D2 => '0',
--      D3 => '1',
--      D4 => '0',
--      D5 => '0',
--      D6 => '0',
--      -- MIG-only Signals: 1-bit (each) input Do not use unless generated by MIG
--      CLKPERF => '0',           -- 1-bit input Ground input (MIG-only connected signal)
--      CLKPERFDELAY => '0', -- 1-bit input Ground input (MIG-only connected signal)
--      ODV => '0',                   -- 1-bit input Ground input (MIG-only connected signal)
--      WC => '0',                     -- 1-bit input Ground input (MIG-only connected signal)
--      -- SHIFTIN1-SHIFTIN2: 1-bit (each) input Data width expansion input ports
--      SHIFTIN1 => '0',         -- 1-bit input Connect to SHIFTOUT1 of master or GND
--      SHIFTIN2 => '0',         -- 1-bit input Connect to SHIFTOUT2 of master or GND
--      -- T1 - T4: 1-bit (each) input Parallel 3-state inputs
--      T1 => '0',
--      T2 => '0',
--      T3 => '0',
--      T4 => '0' 
--   );
   
clka_OBUFDS_inst : OBUFDS
   generic map (
      IOSTANDARD => "LVDS_25"
      )
   port map (
      O  => DAC_DCLK_P, -- Diff_p output (connect directly to top-level port)
      OB => DAC_DCLK_N, -- Diff_n output (connect directly to top-level port)
      I  => clk_out_a     -- Buffer input 
   );
     

   
dly_ld_ctl <= sync_tap_delay_ld;

process(s_dac_axis_aclk)
begin
   if rising_edge(s_dac_axis_aclk) then
      if (s_dac_axis_aresetn = '0') then 
         dly_ld_ctl_re <= '0';
         t1_dly_ld_ctl <= '0';
      else
         dly_ld_ctl_re <= (not t1_dly_ld_ctl) and dly_ld_ctl;
         t1_dly_ld_ctl <= dly_ld_ctl;
      end if;   
      if (s_dac_axis_aresetn = '0') or (dly_ld_ctl_re = '1') then
         ld_cntr <= "000000";
      elsif (ld_cntr /= "111111") then       
         ld_cntr <= ld_cntr + 1;
      end if;   
      if ld_cntr = "100000" then
        ctl_dly_ld <= '1';
      else
        ctl_dly_ld <= '0';
      end if;
      if ld_cntr = "111111" then
        ctl_en_vtc <= '1';
      else
        ctl_en_vtc <= '0';
      end if;
   end if;
end process;   


--ODELAYE_sync_inst : ODELAYE3
--   generic map (
--      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
--      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
--      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
--      DELAY_VALUE => 0,           -- Output delay tap setting
--      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
--      IS_RST_INVERTED => '0',     -- Optional inversion for RST
--      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
--      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
--      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
--                                  -- SYNC)
--   )
--   port map (
--      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
--      CNTVALUEOUT => open, -- 9-bit output: Counter value output
--      DATAOUT => dac_sync_out,         -- 1-bit output: Delayed data from ODATAIN input port
--      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
--      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
--      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
--      CLK => s_dac_axis_aclk,               -- 1-bit input: Clock input
--      CNTVALUEIN => ostrb_tap_delay,   -- 9-bit input: Counter value input
--      EN_VTC => ctl_en_vtc,           -- 1-bit input: Keep delay constant over VT
--      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
--      LOAD => ctl_dly_ld,             -- 1-bit input: Load DELAY_VALUE input
--      ODATAIN => dac_sync_in,         -- 1-bit input: Data input
--      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
--   );
   
sync_in <= "0000" & dac_sync_in & dac_sync_in & dac_sync_in & dac_sync_in;
   
sync_a_OSERDESE3_inst : OSERDESE3
   generic map (
      DATA_WIDTH => 4,            -- Parallel Data Width (4-8)
      INIT => '0',                -- Initialization value of the OSERDES flip-flops
      IS_CLKDIV_INVERTED => '0',  -- Optional inversion for CLKDIV
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      SIM_DEVICE => "ULTRASCALE"  -- Set the device version (ULTRASCALE)
   )
   port map (
      OQ => dac_sync_out,             -- 1-bit output: Serial Output Data
      T_OUT => open,                  -- 1-bit output: 3-state control output to IOB
      CLK => DAC_CLK_IN,             -- 1-bit input: High-speed clock
      CLKDIV => s_dac_axis_aclk,      -- 1-bit input: Divided Clock
      D => sync_in,                   -- 8-bit input: Parallel Data Input
      RST => dac_serdes_int_rst_reg2, -- 1-bit input: Asynchronous Reset
      T => '0'                        -- 1-bit input: Tristate input from fabric
   );

   
--sync_a_OSERDESE1_inst : OSERDESE1
--   generic map (
--      DATA_RATE_OQ => "DDR",       -- "SDR" or "DDR" 
--      DATA_RATE_TQ => "DDR",       -- "BUF", "SDR" or "DDR" 
--      DATA_WIDTH => 4,             -- Parallel data width (1-8,10)
--      DDR3_DATA => 1,              -- Must leave at 1 (MIG-only parameter)
--      INIT_OQ => '0',              -- Initial value of OQ output (0/1)
--      INIT_TQ => '0',              -- Initial value of TQ output (0/1)
--      INTERFACE_TYPE => "DEFAULT", -- Must leave at "DEFAULT" (MIG-only parameter)
--      ODELAY_USED => 0,            -- Must leave at 0 (MIG-only parameter)
--      SERDES_MODE => "MASTER",     -- "MASTER" or "SLAVE" 
--      SRVAL_OQ => '0',             -- OQ output value when SR is used (0/1)
--      SRVAL_TQ => '0',             -- TQ output value when SR is used (0/1)
--      TRISTATE_WIDTH => 4          -- Parallel to serial 3-state converter width (1 or 4)
--   )
--   port map (
--      -- MIG-only Signals: 1-bit (each) output Do not use unless generated by MIG
--      OCBEXTEND => open,       -- 1-bit output Leave unconnected (MIG-only connected signal)
--      -- Outputs: 1-bit (each) output Serial output ports
--      OFB => open,                  -- 1-bit output Data feedback output to ISERDESE1
--      OQ => dac_sync_out,            -- 1-bit output Data output (connect to I/O port)
--      TFB => open,                   -- 1-bit output 3-state control output
--      TQ => open,                     -- 1-bit output 3-state path output
--      -- SHIFTOUT1-SHIFTOUT2: 1-bit (each) output Data width expansion output ports
--      SHIFTOUT1 => open,       -- 1-bit output Connect to SHIFTIN1 of slave or unconnected
--      SHIFTOUT2 => open,       -- 1-bit output Connect to SHIFTIN2 of slave or unconnected
--      -- Clocks: 1-bit (each) input OSERDESE1 clock input ports
--      CLK => DAC_CLK_IN,                   -- 1-bit input High-speed clock input
--      CLKDIV => s_dac_axis_aclk,       -- 1-bit input Divided clock input
--      -- Control Signals: 1-bit (each) input Clock enable and reset input ports
--      OCE => '1',                   -- 1-bit input Active high clock data path enable input
--      RST => dac_serdes_int_rst_reg2,  -- 1-bit input Active high reset input
--      TCE => '1',                   -- 1-bit input Active high clock enable input for 3-state
--      -- D1 - D6: 1-bit (each) input Parallel data inputs
--      D1 => DAC_SYNC_IN,
--      D2 => DAC_SYNC_IN,
--      D3 => DAC_SYNC_IN,
--      D4 => DAC_SYNC_IN,
--      D5 => '0',
--      D6 => '0',
--      -- MIG-only Signals: 1-bit (each) input Do not use unless generated by MIG
--      CLKPERF => '0',           -- 1-bit input Ground input (MIG-only connected signal)
--      CLKPERFDELAY => '0', -- 1-bit input Ground input (MIG-only connected signal)
--      ODV => '0',                   -- 1-bit input Ground input (MIG-only connected signal)
--      WC => '0',                     -- 1-bit input Ground input (MIG-only connected signal)
--      -- SHIFTIN1-SHIFTIN2: 1-bit (each) input Data width expansion input ports
--      SHIFTIN1 => '0',         -- 1-bit input Connect to SHIFTOUT1 of master or GND
--      SHIFTIN2 => '0',         -- 1-bit input Connect to SHIFTOUT2 of master or GND
--      -- T1 - T4: 1-bit (each) input Parallel 3-state inputs
--      T1 => '0',
--      T2 => '0',
--      T3 => '0',
--      T4 => '0' 
--   );

ostr_in <= "0000" & dac_ostr_in & dac_ostr_in & dac_ostr_in & dac_ostr_in;

ostr_OSERDESE3_inst : OSERDESE3
   generic map (
      DATA_WIDTH => 4,            -- Parallel Data Width (4-8)
      INIT => '0',                -- Initialization value of the OSERDES flip-flops
      IS_CLKDIV_INVERTED => '0',  -- Optional inversion for CLKDIV
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      SIM_DEVICE => "ULTRASCALE"  -- Set the device version (ULTRASCALE)
   )
   port map (
      OQ => dac_ostr_out,              -- 1-bit output: Serial Output Data
      T_OUT => open,                   -- 1-bit output: 3-state control output to IOB
      CLK => DAC_CLK_IN,              -- 1-bit input: High-speed clock
      CLKDIV => s_dac_axis_aclk,       -- 1-bit input: Divided Clock
      D => ostr_in,                    -- 8-bit input: Parallel Data Input
      RST => dac_serdes_int_rst_reg2,  -- 1-bit input: Asynchronous Reset
      T => '0'                         -- 1-bit input: Tristate input from fabric
   );

   --ostr_a_OSERDESE1_inst : OSERDESE1
   --generic map (
   --   DATA_RATE_OQ => "DDR",       -- "SDR" or "DDR" 
   --   DATA_RATE_TQ => "DDR",       -- "BUF", "SDR" or "DDR" 
   --   DATA_WIDTH => 4,             -- Parallel data width (1-8,10)
   --   DDR3_DATA => 1,              -- Must leave at 1 (MIG-only parameter)
   --   INIT_OQ => '0',              -- Initial value of OQ output (0/1)
   --   INIT_TQ => '0',              -- Initial value of TQ output (0/1)
   --   INTERFACE_TYPE => "DEFAULT", -- Must leave at "DEFAULT" (MIG-only parameter)
   --   ODELAY_USED => 0,            -- Must leave at 0 (MIG-only parameter)
   --   SERDES_MODE => "MASTER",     -- "MASTER" or "SLAVE" 
   --   SRVAL_OQ => '0',             -- OQ output value when SR is used (0/1)
   --   SRVAL_TQ => '0',             -- TQ output value when SR is used (0/1)
   --   TRISTATE_WIDTH => 4          -- Parallel to serial 3-state converter width (1 or 4)
   --)
   --port map (
   --   -- MIG-only Signals: 1-bit (each) output Do not use unless generated by MIG
   --   OCBEXTEND => open,       -- 1-bit output Leave unconnected (MIG-only connected signal)
   --   -- Outputs: 1-bit (each) output Serial output ports
   --   OFB => open,                  -- 1-bit output Data feedback output to ISERDESE1
   --   OQ => dac_ostr_out,            -- 1-bit output Data output (connect to I/O port)
   --   TFB => open,                   -- 1-bit output 3-state control output
   --   TQ => open,                     -- 1-bit output 3-state path output
   --   -- SHIFTOUT1-SHIFTOUT2: 1-bit (each) output Data width expansion output ports
   --   SHIFTOUT1 => open,       -- 1-bit output Connect to SHIFTIN1 of slave or unconnected
   --   SHIFTOUT2 => open,       -- 1-bit output Connect to SHIFTIN2 of slave or unconnected
   --   -- Clocks: 1-bit (each) input OSERDESE1 clock input ports
   --   CLK => DAC_CLK_IN,                   -- 1-bit input High-speed clock input
   --   CLKDIV => s_dac_axis_aclk,       -- 1-bit input Divided clock input
   --   -- Control Signals: 1-bit (each) input Clock enable and reset input ports
   --   OCE => '1',                   -- 1-bit input Active high clock data path enable input
   --   RST => dac_serdes_int_rst_reg2,  -- 1-bit input Active high reset input
   --   TCE => '1',                   -- 1-bit input Active high clock enable input for 3-state
   --   -- D1 - D6: 1-bit (each) input Parallel data inputs
   --   D1 => dac_ostr_in,
   --   D2 => dac_ostr_in,
   --   D3 => dac_ostr_in,
   --   D4 => dac_ostr_in,
   --   D5 => '0',
   --   D6 => '0',
   --   -- MIG-only Signals: 1-bit (each) input Do not use unless generated by MIG
   --   CLKPERF => '0',           -- 1-bit input Ground input (MIG-only connected signal)
   --   CLKPERFDELAY => '0', -- 1-bit input Ground input (MIG-only connected signal)
   --   ODV => '0',                   -- 1-bit input Ground input (MIG-only connected signal)
   --   WC => '0',                     -- 1-bit input Ground input (MIG-only connected signal)
   --   -- SHIFTIN1-SHIFTIN2: 1-bit (each) input Data width expansion input ports
   --   SHIFTIN1 => '0',         -- 1-bit input Connect to SHIFTOUT1 of master or GND
   --   SHIFTIN2 => '0',         -- 1-bit input Connect to SHIFTOUT2 of master or GND
   --   -- T1 - T4: 1-bit (each) input Parallel 3-state inputs
   --   T1 => '0',
   --   T2 => '0',
   --   T3 => '0',
   --   T4 => '0' 
   --); 
   
   
DAC_RESET_N <= dac_reseta_n_in;

----dac_reset_in <= "0000" & dac_reseta_n_in & dac_reseta_n_in & dac_reseta_n_in & dac_reseta_n_in;   
----   
----rst_OSERDESE3_inst : OSERDESE3
----   generic map (
----      DATA_WIDTH => 4,            -- Parallel Data Width (4-8)
----      INIT => '0',                -- Initialization value of the OSERDES flip-flops
----      IS_CLKDIV_INVERTED => '0',  -- Optional inversion for CLKDIV
----      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
----      IS_RST_INVERTED => '0',     -- Optional inversion for RST
----      SIM_DEVICE => "ULTRASCALE"  -- Set the device version (ULTRASCALE)
----   )
----   port map (
----      OQ => DAC_RESET_N,             -- 1-bit output: Serial Output Data
----      T_OUT => open,                  -- 1-bit output: 3-state control output to IOB
----      CLK => DAC_CLK_IN,             -- 1-bit input: High-speed clock
----      CLKDIV => s_dac_axis_aclk,      -- 1-bit input: Divided Clock
----      D => dac_reset_in,              -- 8-bit input: Parallel Data Input
----      RST => dac_serdes_int_rst_reg2, -- 1-bit input: Asynchronous Reset
----      T => '0'                        -- 1-bit input: Tristate input from fabric
----   );
----  
--rst_OSERDESE1_inst_a : OSERDESE1
--   generic map (
--      DATA_RATE_OQ => "DDR",       -- "SDR" or "DDR" 
--      DATA_RATE_TQ => "DDR",       -- "BUF", "SDR" or "DDR" 
--      DATA_WIDTH => 4,             -- Parallel data width (1-8,10)
--      DDR3_DATA => 1,              -- Must leave at 1 (MIG-only parameter)
--      INIT_OQ => '0',              -- Initial value of OQ output (0/1)
--      INIT_TQ => '0',              -- Initial value of TQ output (0/1)
--      INTERFACE_TYPE => "DEFAULT", -- Must leave at "DEFAULT" (MIG-only parameter)
--      ODELAY_USED => 0,            -- Must leave at 0 (MIG-only parameter)
--      SERDES_MODE => "MASTER",     -- "MASTER" or "SLAVE" 
--      SRVAL_OQ => '0',             -- OQ output value when SR is used (0/1)
--      SRVAL_TQ => '0',             -- TQ output value when SR is used (0/1)
--      TRISTATE_WIDTH => 4          -- Parallel to serial 3-state converter width (1 or 4)
--   )
--   port map (
--      -- MIG-only Signals: 1-bit (each) output Do not use unless generated by MIG
--      OCBEXTEND => open,       -- 1-bit output Leave unconnected (MIG-only connected signal)
--      -- Outputs: 1-bit (each) output Serial output ports
--      OFB => open,                  -- 1-bit output Data feedback output to ISERDESE1
--      OQ => DAC_RESETA_N,            -- 1-bit output Data output (connect to I/O port)
--      TFB => open,                   -- 1-bit output 3-state control output
--      TQ => open,                     -- 1-bit output 3-state path output
--      -- SHIFTOUT1-SHIFTOUT2: 1-bit (each) output Data width expansion output ports
--      SHIFTOUT1 => open,       -- 1-bit output Connect to SHIFTIN1 of slave or unconnected
--      SHIFTOUT2 => open,       -- 1-bit output Connect to SHIFTIN2 of slave or unconnected
--      -- Clocks: 1-bit (each) input OSERDESE1 clock input ports
--      CLK => DAC_CLK_IN,                   -- 1-bit input High-speed clock input
--      CLKDIV => s_dac_axis_aclk,       -- 1-bit input Divided clock input
--      -- Control Signals: 1-bit (each) input Clock enable and reset input ports
--      OCE => '1',                   -- 1-bit input Active high clock data path enable input
--      RST => '0',  -- 1-bit input Active high reset input
--      TCE => '1',                   -- 1-bit input Active high clock enable input for 3-state
--      -- D1 - D6: 1-bit (each) input Parallel data inputs
--      D1 => DAC_RESETA_N_IN,
--      D2 => DAC_RESETA_N_IN,
--      D3 => DAC_RESETA_N_IN,
--      D4 => DAC_RESETA_N_IN,
--      D5 => '0',
--      D6 => '0',
--      -- MIG-only Signals: 1-bit (each) input Do not use unless generated by MIG
--      CLKPERF => '0',           -- 1-bit input Ground input (MIG-only connected signal)
--      CLKPERFDELAY => '0', -- 1-bit input Ground input (MIG-only connected signal)
--      ODV => '0',                   -- 1-bit input Ground input (MIG-only connected signal)
--      WC => '0',                     -- 1-bit input Ground input (MIG-only connected signal)
--      -- SHIFTIN1-SHIFTIN2: 1-bit (each) input Data width expansion input ports
--      SHIFTIN1 => '0',         -- 1-bit input Connect to SHIFTOUT1 of master or GND
--      SHIFTIN2 => '0',         -- 1-bit input Connect to SHIFTOUT2 of master or GND
--      -- T1 - T4: 1-bit (each) input Parallel 3-state inputs
--      T1 => '0',
--      T2 => '0',
--      T3 => '0',
--      T4 => '0' 
--   );

--dac_ostr   <= '0';


--process(s_dac_axis_aclk) begin
--
--    if(rising_edge(s_dac_axis_aclk)) then
--        dac_sync_out <= DAC_SYNC_IN(0);
--        dac_ostr       <= DAC_OSTR_IN(0);
--    end if;
--
--end process;
--

   
sync_OBUFDS_inst : OBUFDS
   generic map (
      IOSTANDARD => "LVDS_25"
      )
   port map (    
      O  => DAC_SYNC_P, -- Diff_p output (connect directly to top-level port)
      OB => DAC_SYNC_N, -- Diff_n output (connect directly to top-level port)
      I  => dac_sync_out     -- Buffer input 
   );
   
dac_frame <= '0';
dac_parity <= '0';

daca_frame_OBUFDS_inst : OBUFDS
generic map (
   IOSTANDARD => "LVDS_25"
   )
port map (
   O  => DAC_FRAME_P, -- Diff_p output (connect directly to top-level port)
   OB => DAC_FRAME_N, -- Diff_n output (connect directly to top-level port)
   I  => dac_frame    -- Buffer input 
);

dac_parity_OBUFDS_inst : OBUFDS
generic map (
   IOSTANDARD => "LVDS_25"
   )
port map (
   O  => DAC_PARITY_P, -- Diff_p output (connect directly to top-level port)
   OB => DAC_PARITY_N, -- Diff_n output (connect directly to top-level port)
   I  => dac_parity    -- Buffer input 
);

dac_ostr_OBUFDS_inst : OBUFDS
generic map (
   IOSTANDARD => "LVDS_25"
   )
port map (
   O  => DAC_OSTR_P, -- Diff_p output (connect directly to top-level port)
   OB => DAC_OSTR_N, -- Diff_n output (connect directly to top-level port)
   I  => dac_ostr_out    -- Buffer input 
);




end Behavioral;
