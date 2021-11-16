----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 08/29/2019 02:00:32 PM
-- Design Name: 
-- Module Name: px_axis_pkt2contigstream_512 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Repacks 512-bit AXIS data that has a tkeep to contiguous full 64 byte words.
-- Limitations: No tready Back-Pressure. It has a slave bus tready but it is always high.
--              Assumes 32-bit values (Only every fourth tkeep is considered to limit barrel shift complexity)
-- Reg Map
-- 0x00 Bit [0] - State Machine Reset
--      Bit [1] - Flush out left over partial data as valid data
                -- Note: No attempt is made to tkeep partial data. Entire 64 byte value is output as valid (including any padding)

-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_pkt2contigstream_512 is
port (
   fifo_rst_in_n       : in  std_logic; -- if this is ahead of a FIFO, the FIFO's Reset should be connect here also.
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   --------------------------------------------------------------------------------
   s_axi_csr_aclk        : in  std_logic;
   s_axi_csr_aresetn     : in  std_logic;
   s_axi_csr_awaddr      : in  std_logic_vector(6 downto 0);
   s_axi_csr_awprot      : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid     : in  std_logic;
   s_axi_csr_awready     : out std_logic;
   s_axi_csr_wdata       : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb       : in  std_logic_vector(3 downto 0); 
   s_axi_csr_wvalid      : in  std_logic;
   s_axi_csr_wready      : out std_logic;
   s_axi_csr_bresp       : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid      : out std_logic;
   s_axi_csr_bready      : in  std_logic;
   s_axi_csr_araddr      : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot      : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid     : in  std_logic;
   s_axi_csr_arready     : out std_logic;
   s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid      : out std_logic;
   s_axi_csr_rready      : in  std_logic;
   ----------------------------------------------------------------------------------
   -- AXI-Stream Slave
   ----------------------------------------------------------------------------------
   s_axis_aclk         : in  std_logic;
   s_axis_aresetn      : in  std_logic;
   s_axis_tvalid       : in  std_logic;
   s_axis_tready       : out std_logic;
   s_axis_tdata        : in  std_logic_vector(511 downto 0);
   s_axis_tkeep        : in  std_logic_vector(63 downto 0);
   s_axis_tlast        : in  std_logic; -- end of packet
   ----------------------------------------------------------------------------------
   m_axis_tvalid       : out std_logic;
   m_axis_tdata        : out std_logic_vector(511 downto 0)
    );
end px_axis_pkt2contigstream_512;

architecture Behavioral of px_axis_pkt2contigstream_512 is



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

---------------------------------------------------------------------------------
-- Attributes
---------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO: STRING;
ATTRIBUTE X_INTERFACE_PARAMETER: STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis:m_axis, ASSOCIATED_RESET s_axis_aresetn:fifo_rst_in_n";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aresetn: SIGNAL is "xilinx.com:signal:reset:1.0 s_axis_aresetn RST";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aresetn: SIGNAL is "POLARITY ACTIVE_LOW";

ATTRIBUTE X_INTERFACE_INFO of fifo_rst_in_n: SIGNAL is "xilinx.com:signal:reset:1.0 fifo_rst_in_n RST";
ATTRIBUTE X_INTERFACE_PARAMETER of fifo_rst_in_n: SIGNAL is "POLARITY ACTIVE_LOW";

signal mux_tdata : std_logic_vector(511 downto 0) := (others => '0'); 
signal old_tdata : std_logic_vector(511 downto 0) := (others => '0'); 
signal t1_tdata  : std_logic_vector(511 downto 0) := (others => '0');
signal t1_tvalid : std_logic := '0';
signal mux_tvalid : std_logic := '0';
signal shift : std_logic_vector(3 downto 0) := "0000";
signal t1_num_tkeep : std_logic_vector(4 downto 0) := "00000";
signal t1_s_axis_aresetn : std_logic := '0';
signal t2_s_axis_aresetn : std_logic := '0';
signal partial : std_logic := '0';
signal axi_state        : axi_state_type := RESET_STATE;
signal rd_data : std_logic_vector(31 downto 0) := (others => '0');
signal w_data : std_logic_vector(31 downto 0) := (others => '0');
signal reg0 : std_logic_vector(31 downto 0) := (others => '0');
signal reg0_cdc : std_logic_vector(1 downto 0) := (others => '0');
signal t1_s_axi_csr_aresetn: std_logic:= '0';
signal w_strb: std_logic:= '0';
signal t1_reg0_cdc: std_logic:= '0';
signal t2_reg0_cdc: std_logic:= '0';
signal flush: std_logic:= '0';
signal dw_tkeep: std_logic_vector(15 downto 0) := (others => '0');
signal t1_fifo_rst_in_n: std_logic:= '0';


begin

-- A limitation of this core is that input must be 32-bit values or garbage data bytes will be packed into the stream at the end of each packet.
dw_tkeep <= s_axis_tkeep(60) & s_axis_tkeep(56) & s_axis_tkeep(52) & s_axis_tkeep(48) &s_axis_tkeep(44) & s_axis_tkeep(40) & s_axis_tkeep(36) & s_axis_tkeep(32) & 
                     s_axis_tkeep(28) & s_axis_tkeep(24) & s_axis_tkeep(20) & s_axis_tkeep(16) & s_axis_tkeep(12) & s_axis_tkeep(8) & s_axis_tkeep(4) & s_axis_tkeep(0);

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
           reg0                <= x"00010000";
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
                    reg0                <= x"00010000";
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
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata;
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata;
                axi_state         <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_csr_wready     <= '0';
                if (s_axi_csr_awvalid = '1') then      
                   axi_state         <= WR_ADDR_DEC_STATE;
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
                   w_strb           <= s_axi_csr_wstrb(0);
                   w_data           <= s_axi_csr_wdata;
                else
                   axi_state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';   
                if w_strb = '1' then
                    reg0      <= w_data;
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
               rd_data     <= reg0; 
               axi_state   <= WAIT_RD_BS_STATE;
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rdata   <= rd_data;
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

xpm_cdc_reg0_inst : xpm_cdc_array_single
   generic map (
      DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 0,   -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      SIM_ASSERT_CHK => 0, -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      SRC_INPUT_REG => 1,  -- DECIMAL; 0=do not register input, 1=register input
      WIDTH => 2           -- DECIMAL; range: 1-1024
   )
   port map (
      dest_out => reg0_cdc, 
      dest_clk => s_axis_aclk, 
      src_clk => s_axi_csr_aclk,   
      src_in => reg0(1 downto 0)    
   );

process(s_axis_aclk)
begin
 if rising_edge(s_axis_aclk) then
    t1_reg0_cdc <= reg0_cdc(1);
    t2_reg0_cdc <= t1_reg0_cdc;
    flush <= t1_reg0_cdc and not t2_reg0_cdc;
 end if;
end process;



-- Repacking State Machine
process(s_axis_aclk)
begin
 if rising_edge(s_axis_aclk) then
        t1_s_axis_aresetn <= s_axis_aresetn;
        t2_s_axis_aresetn <= t1_s_axis_aresetn;
        s_axis_tready     <= t1_s_axis_aresetn and t2_s_axis_aresetn;
        t1_fifo_rst_in_n  <= fifo_rst_in_n;
        t1_tvalid <= s_axis_tvalid;
        t1_tdata  <= s_axis_tdata;
        if (s_axis_tvalid = '1') and (s_axis_tlast = '1') then
            case dw_tkeep is
                when x"0000" =>
                    t1_num_tkeep <= "00000";
                when x"0001" =>
                    t1_num_tkeep <= "00001";
                when x"0003" =>
                    t1_num_tkeep <= "00010";
                when x"0007" =>
                    t1_num_tkeep <= "00011";
                when x"000F" =>
                    t1_num_tkeep <= "00100";
                when x"001F" =>
                    t1_num_tkeep <= "00101";
                when x"003F" =>
                    t1_num_tkeep <= "00110";
                when x"007F" =>
                    t1_num_tkeep <= "00111";
                when x"00FF" =>
                    t1_num_tkeep <= "01000";
                when x"01FF" =>
                    t1_num_tkeep <= "01001";
                when x"03FF" =>
                    t1_num_tkeep <= "01010";
                when x"07FF" =>
                    t1_num_tkeep <= "01011";
                when x"0FFF" =>
                    t1_num_tkeep <= "01100";
                when x"1FFF" =>
                    t1_num_tkeep <= "01101";
                when x"3FFF" =>
                    t1_num_tkeep <= "01110";
                when x"7FFF" =>
                    t1_num_tkeep <= "01111"; 
                when x"FFFF" =>
                    t1_num_tkeep <= "10000";
                when others =>
                    t1_num_tkeep <= "10000";
             end case;
        else
            t1_num_tkeep <= "10000";
        end if;
        if ((t2_s_axis_aresetn = '0') or (t1_fifo_rst_in_n = '0') or (reg0_cdc(0) = '1'))then
            shift                     <= "0000";
            mux_tvalid                <= '0';
            partial                   <= '0';
        elsif (flush = '1') and (partial = '1') then
            mux_tvalid                <= '1';
            shift                     <= "0000";
            partial                   <= '0';
        elsif (t1_tvalid = '1') then
            case (conv_integer(shift)) is
                when 0 =>
                    mux_tdata                 <= t1_tdata(511 downto 0);
                    old_tdata(31 downto 0)    <= (others => '0');
                    old_tdata(511 downto 32)  <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 15) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;
                when 1 =>    
                    if partial = '1' then
                        mux_tdata(511 downto 32)  <= t1_tdata(479 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(479 downto 0) & old_tdata(31 downto 0);
                    end if;
                    old_tdata(31 downto 0)    <= t1_tdata(511 downto 480);
                    old_tdata(511 downto 32)  <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 14) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;
                when 2 =>    
                    if partial = '1' then
                        mux_tdata(511 downto 64)  <= t1_tdata(447 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(447 downto 0) & old_tdata(63 downto 0);
                    end if;
                    old_tdata(63 downto 0)    <= t1_tdata(511 downto 448);
                    old_tdata(511 downto 64)  <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 13) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;
                when 3 =>    
                    if partial = '1' then
                        mux_tdata(511 downto 96)  <= t1_tdata(415 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(415 downto 0) & old_tdata(95 downto 0);
                    end if;
                    old_tdata(95 downto 0)    <= t1_tdata(511 downto 416);
                    old_tdata(511 downto 96)  <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 12) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;
                when 4 =>   
                    if partial = '1' then 
                        mux_tdata(511 downto 128) <= t1_tdata(383 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(383 downto 0) & old_tdata(127 downto 0);
                    end if;
                    old_tdata(127 downto 0)   <= t1_tdata(511 downto 384);
                    old_tdata(511 downto 128) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 11) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;
                when 5 => 
                    if partial = '1' then
                        mux_tdata(511 downto 160) <= t1_tdata(351 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(351 downto 0) & old_tdata(159 downto 0);
                    end if;    
                    old_tdata(159 downto 0)   <= t1_tdata(511 downto 352);
                    old_tdata(511 downto 160) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 10) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;     
                when 6 =>  
                    if partial = '1' then
                        mux_tdata(511 downto 192) <= t1_tdata(319 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(319 downto 0) & old_tdata(191 downto 0);
                    end if;
                    old_tdata(191 downto 0)   <= t1_tdata(511 downto 320);
                    old_tdata(511 downto 192) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 9) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;                 
                when 7 =>    
                    if partial = '1' then
                        mux_tdata(511 downto 224) <= t1_tdata(287 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(287 downto 0) & old_tdata(223 downto 0);
                    end if;
                    old_tdata(223 downto 0)   <= t1_tdata(511 downto 288);
                    old_tdata(511 downto 224) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 8) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;                 
                when 8 => 
                    if partial = '1' then
                        mux_tdata(511 downto 256) <= t1_tdata(255 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(255 downto 0) & old_tdata(255 downto 0);
                    end if;
                    old_tdata(255 downto 0)   <= t1_tdata(511 downto 256);
                    old_tdata(511 downto 256) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 7) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;           
                when 9 => 
                    if partial = '1' then
                        mux_tdata(511 downto 288) <= t1_tdata(223 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(223 downto 0) & old_tdata(287 downto 0);
                    end if;
                    old_tdata(287 downto 0)   <= t1_tdata(511 downto 224);
                    old_tdata(511 downto 288) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 6) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;
                when 10 => 
                    if partial = '1' then
                        mux_tdata(511 downto 320) <= t1_tdata(191 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(191 downto 0) & old_tdata(319 downto 0);
                    end if;
                    old_tdata(319 downto 0)   <= t1_tdata(511 downto 192);
                    old_tdata(511 downto 320) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 5) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;    
                when 11 => 
                    if partial = '1' then
                        mux_tdata(511 downto 352) <= t1_tdata(159 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(159 downto 0) & old_tdata(351 downto 0);
                    end if;
                    old_tdata(351 downto 0)   <= t1_tdata(511 downto 160);
                    old_tdata(511 downto 352) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 4) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;           
                when 12 => 
                    if partial = '1' then
                        mux_tdata(511 downto 384) <= t1_tdata(127 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(127 downto 0) & old_tdata(383 downto 0);
                    end if;
                    old_tdata(383 downto 0)   <= t1_tdata(511 downto 128);
                    old_tdata(511 downto 384) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 3) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;                                         
                when 13 => 
                    if partial = '1' then
                        mux_tdata(511 downto 416) <= t1_tdata(95 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(95 downto 0) & old_tdata(415 downto 0);
                    end if;
                    old_tdata(415 downto 0)   <= t1_tdata(511 downto 96);
                    old_tdata(511 downto 416) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 2) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;     
                when 14 => 
                    if partial = '1' then
                        mux_tdata(511 downto 448) <= t1_tdata(63 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(63 downto 0) & old_tdata(447 downto 0);
                    end if;
                    old_tdata(447 downto 0)   <= t1_tdata(511 downto 64);
                    old_tdata(511 downto 448) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 1) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;               
                when 15 => 
                    if partial = '1' then
                        mux_tdata(511 downto 480) <= t1_tdata(31 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(31 downto 0) & old_tdata(479 downto 0);
                    end if;
                    old_tdata(479 downto 0)   <= t1_tdata(511 downto 32);
                    old_tdata(511 downto 480) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 0) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;  
                when others =>
                    if partial = '1' then
                        mux_tdata(511 downto 480) <= t1_tdata(31 downto 0);
                    else
                        mux_tdata                 <= t1_tdata(31 downto 0) & old_tdata(479 downto 0);
                    end if;
                    old_tdata(479 downto 0)   <= t1_tdata(511 downto 32);
                    old_tdata(511 downto 480) <= (others => '0');
                    shift                     <= shift + t1_num_tkeep(3 downto 0);
                    if (t1_num_tkeep > 0) then
                       mux_tvalid                <= '1';
                       partial                   <= '0';
                    else
                       mux_tvalid                <= '0';
                       partial                   <= '1';
                    end if;    
            end case;
        else
           mux_tvalid       <= '0';    
        end if;
        m_axis_tvalid  <= mux_tvalid;
        m_axis_tdata   <= mux_tdata;
 end if;
end process;


end Behavioral;
