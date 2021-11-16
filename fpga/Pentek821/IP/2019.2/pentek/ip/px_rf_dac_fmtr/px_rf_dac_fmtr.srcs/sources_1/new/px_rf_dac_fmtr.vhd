----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2018 12:45:21 PM
-- Design Name: 
-- Module Name: px_rf_dac_fmtr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Formatter for rfsoc DAC data
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Assumes data is in similar format to ADC output
   -- Real only on i_tdata only  (8/cycle)
   -- IQ i_tdata and q_tdata 4/cycle 2/cycle or 1/cycle
   -- The bus is alway 8 per cycle wide. In I/Q modes valid samples are right justified.  
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library xpm;
use xpm.vcomponents.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_rf_dac_fmtr is
Port (
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
s_axi_csr_aclk           : in  std_logic;
s_axi_csr_aresetn        : in  std_logic;
s_axi_csr_awaddr         : in  std_logic_vector(11 downto 0);
s_axi_csr_awprot         : in  std_logic_vector(2 downto 0);
s_axi_csr_awvalid        : in  std_logic;
s_axi_csr_awready        : out std_logic;
s_axi_csr_wdata          : in  std_logic_vector(31 downto 0);
s_axi_csr_wstrb          : in  std_logic_vector(3 downto 0);
s_axi_csr_wvalid         : in  std_logic;
s_axi_csr_wready         : out std_logic;
s_axi_csr_bresp          : out std_logic_vector(1 downto 0);
s_axi_csr_bvalid         : out std_logic;
s_axi_csr_bready         : in  std_logic;
s_axi_csr_araddr         : in  std_logic_vector(11 downto 0);
s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
s_axi_csr_arvalid        : in  std_logic;
s_axi_csr_arready        : out std_logic;
s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
s_axi_csr_rvalid         : out std_logic;
s_axi_csr_rready         : in  std_logic;
--------------------------------------------------------------------------------
-- Input AXI-Stream   (axis_aclk)
--------------------------------------------------------------------------------
axis_aclk                : in  std_logic;
axis_aresetn             : in std_logic; -- reset   
--I or Real
s_axis_i_tdata           : in  std_logic_vector(127 downto 0);
s_axis_i_tvalid          : in  std_logic;
s_axis_i_tready          : out std_logic; -- always high
--Q 
s_axis_q_tdata           : in  std_logic_vector(127 downto 0);
s_axis_q_tvalid          : in  std_logic;
s_axis_q_tready          : out std_logic; -- always high
--------------------------------------------------------------------------------
-- Output AXI-Stream  (axis_aclk)
--------------------------------------------------------------------------------
m_axis_tdata             : out std_logic_vector(127 downto 0);
m_axis_tvalid            : out std_logic
);
end px_rf_dac_fmtr;

architecture Behavioral of px_rf_dac_fmtr is

type axi_state_type is
(
    RESET_STATE,
    WR_ADDR_DATA_STATE,
    WR_DATA_STATE,
    WR_ADDR2_STATE,
    WR_ADDR_STATE,
    WR_DATA2_STATE,
    WR_ADDR_DEC_STATE,
    WR_B_RSP_STATE,
    RD_ADDR_STATE,
    WAIT_RD_BS_STATE,
    WAIT_RDDATA_RDY_STATE
);


--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal rd_data          : std_logic_vector(7 downto 0)  := (others => '0');
signal w_data           : std_logic_vector(7 downto 0)  := (others => '0');
signal w_strb           : std_logic_vector(3 downto 0)   := (others => '0');
signal axi_state        : axi_state_type := RESET_STATE;
signal ctl_reg          : std_logic_vector(7 downto 0)  := (others => '0');
signal t1_s_axi_csr_aresetn: std_logic := '0'; 
signal ctl_reg_rs       : std_logic := '0';

signal mode: std_logic;

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_i:s_axis_q:m_axis, ASSOCIATED_RESET axis_aresetn";


begin

s_axis_i_tready <= '1';
s_axis_q_tready <= '1';

-------------------------------------------------------------------------------
-- AXI4-Lite Interface State Machine
-------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        if t1_s_axi_csr_aresetn = '0' then
           axi_state           <= RESET_STATE;
           s_axi_csr_awready   <= '0'; 
           s_axi_csr_wready    <= '0';  
           s_axi_csr_arready   <= '0'; 
           s_axi_csr_rvalid    <= '0';  
           s_axi_csr_bvalid    <= '0';
           ctl_reg             <= (others => '0');
        else 
           case axi_state is 
            when RESET_STATE =>
                if (t1_s_axi_csr_aresetn = '0') then
                    axi_state           <= RESET_STATE;
                    s_axi_csr_awready   <= '0';
                    s_axi_csr_wready    <= '0';
                    s_axi_csr_arready   <= '0'; 
                    s_axi_csr_rvalid    <= '0';  
                    s_axi_csr_bvalid    <= '0';
                    ctl_reg             <= (others => '0');
                elsif (s_axi_csr_awvalid = '1') then  
                    if (s_axi_csr_wvalid = '1') then
                        axi_state <=  WR_ADDR_DATA_STATE;
                    else
                        axi_state <=  WR_ADDR_STATE;
                    end if; 
                elsif (s_axi_csr_wvalid = '1') then
                    axi_state <=  WR_DATA_STATE;
                elsif (s_axi_csr_arvalid = '1') then
                    axi_state <=  RD_ADDR_STATE;
                else
                    axi_state <= RESET_STATE;
                end if;    
             when WR_ADDR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                s_axi_csr_awready <= '1';       
                w_strb            <= s_axi_csr_wstrb;
                w_data            <= s_axi_csr_wdata(7 downto 0);
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                w_strb            <= s_axi_csr_wstrb;
                w_data            <= s_axi_csr_wdata(7 downto 0);
                axi_state         <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_csr_wready     <= '0';
                if (s_axi_csr_awvalid = '1') then      
                   axi_state  <= WR_ADDR_DEC_STATE;
                   s_axi_csr_awready <= '1';
                else
                   axi_state         <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   s_axi_csr_awready <= '1';
                   axi_state     <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                s_axi_csr_awready <= '0';
                if (s_axi_csr_wvalid = '1') then      
                   axi_state        <= WR_ADDR_DEC_STATE;
                   s_axi_csr_wready <= '1';
                   w_strb           <= s_axi_csr_wstrb;
                   w_data           <= s_axi_csr_wdata(7 downto 0);
                else
                   axi_state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';   
                if w_strb(0) = '1' then   
                  ctl_reg(7 downto 0)  <= w_data(7 downto 0);
                end if;                     
                axi_state         <= WR_B_RSP_STATE;
                s_axi_csr_bresp   <= "00";
                s_axi_csr_bvalid  <= '1';     
            when  WR_B_RSP_STATE =>
                if s_axi_csr_bready = '1' then
                    s_axi_csr_bvalid <= '0';
                    axi_state <= RESET_STATE;
                else
                    axi_state <= WR_B_RSP_STATE;
                end if;    
            when  RD_ADDR_STATE =>
               s_axi_csr_arready <= '1';
               rd_data     <= ctl_reg; 
               axi_state   <= WAIT_RD_BS_STATE;
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rdata(7 downto 0) <= rd_data;
                s_axi_csr_rvalid  <= '1'; 
                s_axi_csr_rresp   <= "00";
                axi_state         <= WAIT_RDDATA_RDY_STATE;              
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_csr_rready = '1' then
                   s_axi_csr_rvalid <= '0';
                   axi_state        <= RESET_STATE;
                else
                   axi_state        <= WAIT_RDDATA_RDY_STATE;     
                end if;  
            when others =>
               axi_state <= RESET_STATE;
          end case;
       end if;
   end if;  
end process;

s_axi_csr_rdata(31 downto 8) <= x"000000";

xpm_cdc_single_inst : xpm_cdc_single
   generic map (
      DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 1,   -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      SIM_ASSERT_CHK => 0, -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      SRC_INPUT_REG => 1   -- DECIMAL; 0=do not register input, 1=register input
   )
   port map (
      dest_out => ctl_reg_rs, -- 1-bit output: src_in synchronized to the destination clock domain. This output
                            -- is registered.
      dest_clk => axis_aclk, -- 1-bit input: Clock signal for the destination clock domain.
      src_clk => s_axi_csr_aclk,   -- 1-bit input: optional; required when SRC_INPUT_REG = 1
      src_in => ctl_reg(0)      -- 1-bit input: Input signal to be synchronized to dest_clk domain.
   );


process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      mode <= ctl_reg_rs;
      if mode = '0' then -- real mode
         m_axis_tdata <= s_axis_i_tdata;
      else
         m_axis_tdata <= s_axis_q_tdata(63 downto 48) & s_axis_i_tdata(63 downto 48) & s_axis_q_tdata(47 downto 32) & s_axis_i_tdata(47 downto 32) & s_axis_q_tdata(31 downto 16) & s_axis_i_tdata(31 downto 16) & s_axis_q_tdata(15 downto 0) & s_axis_i_tdata(15 downto 0);
      end if;
      m_axis_tvalid <= s_axis_i_tvalid;
   end if;
end process;   


end Behavioral;
