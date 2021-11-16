----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/19/2017 12:03:47 PM
-- Design Name: 
-- Module Name: px_chirp_gen_chrpgen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Chirp Generation
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- latency = 19 ce
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_chirp_gen_chrpgen is
generic (
    samples_per_cycle : integer := 4 -- 1,2,4 or 8
);
port ( 
    clk     : in STD_LOGIC;
    rstn    : in std_logic;
    ce      : in std_logic;
    gate    : in std_logic;
    up      : in std_logic;
    load    : in std_logic;
    start   : in std_logic_vector(31 downto 0);
    offset: in std_logic_vector(31 downto 0); -- offset initial phase
    rate    : in std_logic_vector(31 downto 0);
    calc_strt : in std_logic;
    i0      : out std_logic_vector(15 downto 0);
    q0      : out std_logic_vector(15 downto 0);
    i1      : out std_logic_vector(15 downto 0);
    q1      : out std_logic_vector(15 downto 0);
    i2      : out std_logic_vector(15 downto 0);
    q2      : out std_logic_vector(15 downto 0);
    i3      : out std_logic_vector(15 downto 0);
    q3      : out std_logic_vector(15 downto 0);
    i4      : out std_logic_vector(15 downto 0);
    q4      : out std_logic_vector(15 downto 0);
    i5      : out std_logic_vector(15 downto 0);
    q5      : out std_logic_vector(15 downto 0);
    i6      : out std_logic_vector(15 downto 0);
    q6      : out std_logic_vector(15 downto 0);
    i7      : out std_logic_vector(15 downto 0);
    q7      : out std_logic_vector(15 downto 0);
    ce_out  : out std_logic;
    gate_out: out std_logic
    );
end px_chirp_gen_chrpgen;

architecture Behavioral of px_chirp_gen_chrpgen is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_chrpgen_phase_acc
generic (
    samples_per_cycle : integer := 4 -- 1,2 or 4
);
port ( 
    clk : in STD_LOGIC;
    ce : in std_logic;
    gate: in std_logic;
    up : in std_logic;
    load : in std_logic;
    start : in std_logic_vector(31 downto 0);
    offset: in std_logic_vector(31 downto 0); -- offset initial phase
    rate: in std_logic_vector(31 downto 0);
    calc_strt : in std_logic;
    phase0: out std_logic_vector(31 downto 0);
    phase1: out std_logic_vector(31 downto 0); -- not used for 1
    phase2: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    phase3: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    phase4: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    phase5: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    phase6: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    phase7: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    gate_out: out std_logic
    );
end component px_chrpgen_phase_acc;

-- DDS
-- latency = 11
-- phase offset streaming
-- fixed 0 Hz phase increment
COMPONENT px_axis_chrpgen_dds
  PORT (
  aclk : IN STD_LOGIC;
  aresetn : IN STD_LOGIC;
  s_axis_phase_tvalid : IN STD_LOGIC;
  s_axis_phase_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  s_axis_phase_tuser : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
  m_axis_data_tvalid : OUT STD_LOGIC;
  m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  m_axis_data_tuser : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal phase0: std_logic_vector(31 downto 0);
signal phase1: std_logic_vector(31 downto 0); -- not used for 1
signal phase2: std_logic_vector(31 downto 0); -- not used for 1 or 2
signal phase3: std_logic_vector(31 downto 0); -- not used for 1 or 2
signal phase4: std_logic_vector(31 downto 0);
signal phase5: std_logic_vector(31 downto 0); -- not used for 1
signal phase6: std_logic_vector(31 downto 0); -- not used for 1 or 2
signal phase7: std_logic_vector(31 downto 0); -- not used for 1 or 2
signal acc_gate_out : std_logic;
signal s_tuser: std_logic_vector(0 downto 0);
signal m_tuser: std_logic_vector(0 downto 0);
signal dds0_ce_out: std_logic;
signal dds0_out: std_logic_vector(31 downto 0);
signal dds1_out: std_logic_vector(31 downto 0);
signal dds2_out: std_logic_vector(31 downto 0);
signal dds3_out: std_logic_vector(31 downto 0);
signal dds4_out: std_logic_vector(31 downto 0);
signal dds5_out: std_logic_vector(31 downto 0);
signal dds6_out: std_logic_vector(31 downto 0);
signal dds7_out: std_logic_vector(31 downto 0);

begin


ph_acc_inst: px_chrpgen_phase_acc
generic map (
    samples_per_cycle => samples_per_cycle-- 1,2 or 4
)
port map( 
    clk         => clk,
    ce          => ce,     
    gate        => gate,    
    up          => up,      
    load        => load,    
    start       => start, 
    offset      => offset,  
    rate        => rate, 
    calc_strt   => calc_strt,   
    phase0      => phase0,  
    phase1      => phase1,  
    phase2      => phase2,  
    phase3      => phase3, 
    phase4      => phase4,
    phase5      => phase5,
    phase6      => phase6,
    phase7      => phase7,
    gate_out    => acc_gate_out
    );

s_tuser(0) <= acc_gate_out;

dds0_inst : px_axis_chrpgen_dds
  PORT MAP (
    aclk => clk,
    aresetn => rstn,
    s_axis_phase_tvalid => ce,
    s_axis_phase_tdata => phase0,
    s_axis_phase_tuser => s_tuser,
    m_axis_data_tvalid => dds0_ce_out,
    m_axis_data_tdata => dds0_out,
    m_axis_data_tuser => m_tuser
  );

process(clk)
begin
    if rising_edge(clk) then
       if m_tuser(0) = '1' then
          i0 <= dds0_out(15 downto 0);
          q0 <= dds0_out(31 downto 16);
       else
          i0 <= x"0000";
          q0 <= x"0000";
       end if;   
       ce_out   <= dds0_ce_out;         
       gate_out <= m_tuser(0); 
    end if;
end process;  
  
gen_dds1: if  (samples_per_cycle /= 1) generate

dds1_inst : px_axis_chrpgen_dds
  PORT MAP (
    aclk => clk,
    aresetn => rstn,
    s_axis_phase_tvalid => ce,
    s_axis_phase_tdata => phase1,
    s_axis_phase_tuser => s_tuser,
    m_axis_data_tvalid => open,
    m_axis_data_tdata => dds1_out,
    m_axis_data_tuser => open
  );

process(clk)
begin
    if rising_edge(clk) then
       if m_tuser(0) = '1' then
          i1 <= dds1_out(15 downto 0);
          q1 <= dds1_out(31 downto 16); 
       else
          i1 <= x"0000";
          q1 <= x"0000";
       end if;  
    end if;
end process;  

end generate;

gen_dds2: if  ((samples_per_cycle = 4) or (samples_per_cycle = 8))  generate

dds2_inst : px_axis_chrpgen_dds
  PORT MAP (
    aclk => clk,
    aresetn => rstn,
    s_axis_phase_tvalid => ce,
    s_axis_phase_tdata => phase2,
    s_axis_phase_tuser => s_tuser,
    m_axis_data_tvalid => open,
    m_axis_data_tdata => dds2_out,
    m_axis_data_tuser => open
  );
  
dds3_inst : px_axis_chrpgen_dds
    PORT MAP (
      aclk => clk,
      aresetn => rstn,
      s_axis_phase_tvalid => ce,
      s_axis_phase_tdata => phase3,
      s_axis_phase_tuser => s_tuser,
      m_axis_data_tvalid => open,
      m_axis_data_tdata => dds3_out,
      m_axis_data_tuser => open
    );  

process(clk)
begin
    if rising_edge(clk) then
       if m_tuser(0) = '1' then
          i2 <= dds2_out(15 downto 0);
          q2 <= dds2_out(31 downto 16); 
          i3 <= dds3_out(15 downto 0);
          q3 <= dds3_out(31 downto 16); 
       else
          i2 <= x"0000";
          q2 <= x"0000";
          i3 <= x"0000";
          q3 <= x"0000";          
       end if; 
    end if;
end process; 

end generate;

gen_dds3: if  (samples_per_cycle = 8) generate

dds4_inst : px_axis_chrpgen_dds
  PORT MAP (
    aclk => clk,
    aresetn => rstn,
    s_axis_phase_tvalid => ce,
    s_axis_phase_tdata => phase4,
    s_axis_phase_tuser => s_tuser,
    m_axis_data_tvalid => open,
    m_axis_data_tdata => dds4_out,
    m_axis_data_tuser => open
  );
  
dds5_inst : px_axis_chrpgen_dds
    PORT MAP (
      aclk => clk,
      aresetn => rstn,
      s_axis_phase_tvalid => ce,
      s_axis_phase_tdata => phase5,
      s_axis_phase_tuser => s_tuser,
      m_axis_data_tvalid => open,
      m_axis_data_tdata => dds5_out,
      m_axis_data_tuser => open
    );  
    
dds6_inst : px_axis_chrpgen_dds
        PORT MAP (
          aclk => clk,
          aresetn => rstn,
          s_axis_phase_tvalid => ce,
          s_axis_phase_tdata => phase6,
          s_axis_phase_tuser => s_tuser,
          m_axis_data_tvalid => open,
          m_axis_data_tdata => dds6_out,
          m_axis_data_tuser => open
        );  
        
dds7_inst : px_axis_chrpgen_dds
            PORT MAP (
              aclk => clk,
              aresetn => rstn,
              s_axis_phase_tvalid => ce,
              s_axis_phase_tdata => phase7,
              s_axis_phase_tuser => s_tuser,
              m_axis_data_tvalid => open,
              m_axis_data_tdata => dds7_out,
              m_axis_data_tuser => open
            );  

process(clk)
begin
    if rising_edge(clk) then
       if m_tuser(0) = '1' then
          i4 <= dds4_out(15 downto 0);
          q4 <= dds4_out(31 downto 16); 
          i5 <= dds5_out(15 downto 0);
          q5 <= dds5_out(31 downto 16);
          i6 <= dds6_out(15 downto 0);
          q6 <= dds6_out(31 downto 16); 
          i7 <= dds7_out(15 downto 0);
          q7 <= dds7_out(31 downto 16);  
       else
          i4 <= x"0000";
          q4 <= x"0000";
          i5 <= x"0000";
          q5 <= x"0000";  
          i6 <= x"0000";
          q6 <= x"0000";
          i7 <= x"0000";
          q7 <= x"0000";             
       end if; 
    end if;
end process; 

end generate;


   

end Behavioral;
