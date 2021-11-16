----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/30/2019 07:45:41 AM
-- Design Name: 
-- Module Name: tb_axis_ppkt_repack - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_axis_pkt2contigstream_512 is
--  Port ( );
end tb_px_axis_pkt2contigstream_512;

architecture Behavioral of tb_px_axis_pkt2contigstream_512 is

component px_axis_pkt2contigstream_512
port (
   fifo_rst_in_n       : in  std_logic;
   
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
end component px_axis_pkt2contigstream_512;

type pkt_state_type is
(
RESET_STATE,
PKT_1_STATE,
PKT_2_STATE,
PKT_3_STATE,
PKT_4_STATE,
PKT_5_STATE
);

signal   fifo_rst_in_n       : std_logic := '1';
  ----------------------------------------------------------------------------------
  -- AXI-Stream Slave
  ----------------------------------------------------------------------------------
signal   s_axis_aclk         : std_logic := '0';
signal   s_axis_aresetn      : std_logic := '0';
signal   s_axis_tvalid       : std_logic := '0';
signal   s_axis_tready       : std_logic := '0';
signal   s_axis_tdata        : std_logic_vector(511 downto 0) := (others => '0');
signal   s_axis_tkeep        : std_logic_vector(63 downto 0) := (others => '0'); 
signal   s_axis_tlast        : std_logic := '0'; -- end of packet
   ----------------------------------------------------------------------------------
signal   m_axis_tvalid  : std_logic := '0';
signal   m_axis_tdata   : std_logic_vector(511 downto 0) := (others => '0');

signal cntr : std_logic_vector(31 downto 0) := (others => '0');
signal t1_cntr : std_logic_vector(31 downto 0) := (others => '0');
signal adder : std_logic_vector(4 downto 0) := (others => '0');
signal last_cnt : integer := 0; 
signal pkt_state: pkt_state_type := RESET_STATE;
signal valid : std_logic := '0';

  --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
signal  s_axi_csr_aclk        : std_logic := '0';
signal  s_axi_csr_aresetn     : std_logic := '0';
signal  s_axi_csr_awaddr      : std_logic_vector(6 downto 0);
signal  s_axi_csr_awprot      : std_logic_vector(2 downto 0); -- not used
signal  s_axi_csr_awvalid     : std_logic := '0';
signal  s_axi_csr_awready     : std_logic := '0';
signal  s_axi_csr_wdata       : std_logic_vector(31 downto 0);
signal  s_axi_csr_wstrb       : std_logic_vector(3 downto 0); 
signal  s_axi_csr_wvalid      : std_logic := '0';
signal  s_axi_csr_wready      : std_logic := '0';
signal  s_axi_csr_bresp       : std_logic_vector(1 downto 0);
signal  s_axi_csr_bvalid      : std_logic := '0';
signal  s_axi_csr_bready      : std_logic := '1';
signal  s_axi_csr_araddr      : std_logic_vector(6 downto 0);
signal  s_axi_csr_arprot      : std_logic_vector(2 downto 0); -- not used
signal  s_axi_csr_arvalid     : std_logic := '0';
signal  s_axi_csr_arready     : std_logic := '0';
signal  s_axi_csr_rdata       : std_logic_vector(31 downto 0);
signal  s_axi_csr_rresp       : std_logic_vector(1 downto 0);
signal  s_axi_csr_rvalid      : std_logic := '0';
signal  s_axi_csr_rready      : std_logic := '0';
signal stop_output : std_logic := '0';
signal tkeep : std_logic_vector(15 downto 0) := (others => '0');

begin

uut: px_axis_pkt2contigstream_512
port map (
   fifo_rst_in_n      => fifo_rst_in_n, 
     --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   --------------------------------------------------------------------------------
   s_axi_csr_aclk        => s_axi_csr_aclk    ,
   s_axi_csr_aresetn     => s_axi_csr_aresetn ,
   s_axi_csr_awaddr      => s_axi_csr_awaddr  ,
   s_axi_csr_awprot      => s_axi_csr_awprot  ,
   s_axi_csr_awvalid     => s_axi_csr_awvalid ,
   s_axi_csr_awready     => s_axi_csr_awready ,
   s_axi_csr_wdata       => s_axi_csr_wdata   ,
   s_axi_csr_wstrb       => s_axi_csr_wstrb   ,
   s_axi_csr_wvalid      => s_axi_csr_wvalid  ,
   s_axi_csr_wready      => s_axi_csr_wready  ,
   s_axi_csr_bresp       => s_axi_csr_bresp   ,
   s_axi_csr_bvalid      => s_axi_csr_bvalid  ,
   s_axi_csr_bready      => s_axi_csr_bready  ,
   s_axi_csr_araddr      => s_axi_csr_araddr  ,
   s_axi_csr_arprot      => s_axi_csr_arprot  ,
   s_axi_csr_arvalid     => s_axi_csr_arvalid ,
   s_axi_csr_arready     => s_axi_csr_arready ,
   s_axi_csr_rdata       => s_axi_csr_rdata   ,
   s_axi_csr_rresp       => s_axi_csr_rresp   ,
   s_axi_csr_rvalid      => s_axi_csr_rvalid  ,
   s_axi_csr_rready      => s_axi_csr_rready  ,
   ----------------------------------------------------------------------------------
   -- AXI-Stream Slave
   ----------------------------------------------------------------------------------
   s_axis_aclk        => s_axis_aclk,     
   s_axis_aresetn     => s_axis_aresetn,  
   s_axis_tvalid      => s_axis_tvalid,   
   s_axis_tready      => s_axis_tready,   
   s_axis_tdata       => s_axis_tdata,    
   s_axis_tkeep       => s_axis_tkeep,    
   s_axis_tlast       => s_axis_tlast,    
   ----------------------------------------------------------------------------------
   m_axis_tvalid      => m_axis_tvalid,
   -- Earliest byte in lower byte 
   m_axis_tdata       => m_axis_tdata
    );
    
    
process
begin
    loop
        wait for 1.6 ns;
        s_axis_aclk <= not s_axis_aclk;
    end loop;
end process;
process
begin
    loop
        wait for 2 ns;
        s_axi_csr_aclk <= not s_axi_csr_aclk;
    end loop;
end process;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        if stop_output = '1' then
            valid <= '0';
        else
            valid <= not valid;
        end if;
    end if;
end process;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        if s_axis_aresetn = '0' then
           pkt_state <= RESET_STATE;
           s_axis_tvalid <= '0';
        else
            if valid = '0' then
                s_axis_tvalid <= '0';
            else
            case pkt_state is
                when RESET_STATE =>
                    s_axis_tvalid <= '0';
                    if s_axis_aresetn = '0' then
                        cntr <= (others => '0');
                    end if;
                    pkt_state <= PKT_1_STATE;
                    s_axis_tlast <= '0';
                when PKT_1_STATE =>
                    s_axis_tvalid <= '1';
                    cntr <= cntr + 16;
                    pkt_state <= PKT_2_STATE;
                    s_axis_tlast <= '0';
                when PKT_2_STATE =>
                    s_axis_tvalid <= '1';
                    cntr <= cntr + 16;
                    pkt_state <= PKT_3_STATE;
                    s_axis_tlast <= '0';
                when PKT_3_STATE =>
                    s_axis_tvalid <= '1';
                    cntr <= cntr + 16;
                    pkt_state <= PKT_4_STATE;
                    s_axis_tlast <= '0';
                when PKT_4_STATE =>
                    s_axis_tvalid <= '1';
                    cntr <= cntr + 16;
                    pkt_state <= PKT_5_STATE;
                    s_axis_tlast <= '0';
                when PKT_5_STATE =>
                    s_axis_tvalid <= '1';
                    if (conv_integer(adder) = 0) then
                        cntr <= cntr + 1;
                        last_cnt <= 1;
                    elsif (conv_integer(adder) > 16) then
                        cntr <= cntr + 1;
                        last_cnt <= 1;
                    else
                        cntr <= cntr + conv_integer(adder);
                        last_cnt <= conv_integer(adder);
                    end if;    
                    pkt_state <= RESET_STATE;
                    s_axis_tlast <= '1';
                when others =>
                pkt_state <= RESET_STATE;
            end case;
            end if;
         end if;
         t1_cntr <= cntr;
    end if;
end process;

adder <= ((cntr(1) and not cntr(0))  & cntr(3) & cntr(0) & (cntr(2) or cntr(0)) & cntr(4));


process(last_cnt, s_axis_tlast, pkt_state,cntr, s_axis_aclk)
begin
    if s_axis_tlast = '0' then 
       for i in 0 to 15 loop
          s_axis_tdata((32*i)+32-1 downto (32*i)) <= conv_std_logic_vector(conv_integer(t1_cntr+i), 32);
       end loop;
    else
        if (last_cnt /= 16) then
            s_axis_tdata(511 downto (32*last_cnt)) <= (others => '0');
            for i in 0 to last_cnt-1 loop
               s_axis_tdata((32*i)+32-1 downto (32*i)) <= conv_std_logic_vector(conv_integer(t1_cntr+i), 32);
            end loop;
        else
            for i in 0 to 15 loop
               s_axis_tdata((32*i)+32-1 downto (32*i)) <= conv_std_logic_vector(conv_integer(t1_cntr+i), 32);
            end loop;
        end if;
    end if; 
end process; 

tkeep <= "1111111111111111" when (s_axis_tlast = '0') else
                     "0000000000000001" when (last_cnt = 1) else
                     "0000000000000011" when (last_cnt = 2) else
                     "0000000000000111" when (last_cnt = 3) else
                     "0000000000001111" when (last_cnt = 4) else
                     "0000000000011111" when (last_cnt = 5) else
                     "0000000000111111" when (last_cnt = 6) else
                     "0000000001111111" when (last_cnt = 7) else
                     "0000000011111111" when (last_cnt = 8) else
                     "0000000111111111" when (last_cnt = 9) else
                     "0000001111111111" when (last_cnt = 10) else
                     "0000011111111111" when (last_cnt = 11) else
                     "0000111111111111" when (last_cnt = 12) else
                     "0001111111111111" when (last_cnt = 13) else
                     "0011111111111111" when (last_cnt = 14) else
                     "0111111111111111" when (last_cnt = 15) else
                     "1111111111111111" when (last_cnt = 16) else "1111111111111111";
                     
gen_tkeep :for i in 0 to 15 generate 

s_axis_tkeep((i*4)+3 downto (i*4)) <= tkeep(i) & tkeep(i) & tkeep(i) & tkeep(i);

end generate;

process
begin
    wait for 100 ns;
    s_axis_aresetn <= '1';
    s_axi_csr_aresetn <= '1';
    wait for 1000 ns;
    s_axi_csr_awvalid <= '1';
    s_axi_csr_wvalid <= '1';
    s_axi_csr_wdata <= x"00000001";  -- test out state machine reset
    s_axi_csr_wstrb <=  "0001";
    wait until  s_axi_csr_awready = '1';
    wait until rising_edge( s_axi_csr_aclk);
    s_axi_csr_awvalid <= '0';
    s_axi_csr_wvalid <= '0';
    wait for 100 ns;
    wait until rising_edge( s_axi_csr_aclk);
    s_axi_csr_awvalid <= '1';
    s_axi_csr_wvalid <= '1';
    s_axi_csr_wdata <= x"00000000";
    wait until  s_axi_csr_awready = '1';
    wait until rising_edge( s_axi_csr_aclk);
    s_axi_csr_awvalid <= '0';
    s_axi_csr_wvalid <= '0';
 
    wait for 990 ns;    -- test out last data fragment flush
    stop_output <= '1';
    wait for 1000 ns;
    s_axi_csr_awvalid <= '1';
    s_axi_csr_wvalid <= '1';
    s_axi_csr_wdata <= x"00000002";
    s_axi_csr_wstrb <=  "0001";
    wait until  s_axi_csr_awready = '1';
    wait until rising_edge( s_axi_csr_aclk);
    s_axi_csr_awvalid <= '0';
    s_axi_csr_wvalid <= '0';
    wait for 100 ns;
    wait until rising_edge( s_axi_csr_aclk);
    s_axi_csr_awvalid <= '1';
    s_axi_csr_wvalid <= '1';
    s_axi_csr_wdata <= x"00000000";
    wait until  s_axi_csr_awready = '1';
    wait until rising_edge( s_axi_csr_aclk);
    s_axi_csr_awvalid <= '0';
    s_axi_csr_wvalid <= '0';
    wait;
end process;

end Behavioral;
