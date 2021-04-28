----------------------------------------------------------------------------------
-- Pentek PCIe to AXI-S DMA Read Request State Machine
----------------------------------------------------------------------------------
-- px_dma_pcie2pd_rd_rqst_sm.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2015
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 

-------------------------------------------------------------------------------

-- (c) Copyright 2016 Pentek, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Pentek, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Pentek, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND PENTEK HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Pentek shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Pentek had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Pentek products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Pentek products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------

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

entity px_dma_pcie2pd_rdrqst_sm is
generic(
    pcie_channel : std_logic_vector(2 downto 0) := "000"
);
port ( 
   clk                     : in  std_logic;
   rst_n                   : in  std_logic;
   ----------------------------------------------------------------------------
   -- Accept the Buffer Write Request from the DMA
   ----------------------------------------------------------------------------
   buffer_rd_rqst_valid    : in  std_logic; 
   buffer_rd_rqst_ready    : out std_logic; 
   buffer_rd_rqst_data     : in  std_logic_vector(167 downto 0);
   -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
   -- buffer_rd_rqst_data[127:64]  = Source Meta Address -- Meta Address must be on 16 byte address boundry
   -- buffer_rd_rqst_data[128]     = 0 = Use Descriptor Length 1 = Use Meta Data Length
   -- buffer_rd_rqst_data[130:129] = PCIe AT 
   -- buffer_rd_rqst_data[135:131] = Reserved 
   -- buffer_rd_rqst_data[167:136] = Size in bytes    
   buffer_rd_complete      : out std_logic;
   buffer_rqst_complete    : out std_logic;   
   ----------------------------------------------------------------------------
   -- Flow Control
   ----------------------------------------------------------------------------
   -- Found Meta Data
   s_axis_rd_rsp_tvalid    : in  std_logic;
   s_axis_rd_rsp_tdata     : in  std_logic_vector(31 downto 0); -- meta data length value when a meta data packet
   -- Response Tag to be monitored for completion
   meta_tvalid             : out std_logic;
   meta_tdata              : out std_logic_vector(2 downto 0); -- Return tag to look for for meta data
   
   incr_tag                : out std_logic;
   next_free_tag           : in  std_logic_vector(2 downto 0);
   num_free_tags           : in  std_logic_vector(3 downto 0);  
   rsp_pipe_afl            : in  std_logic;

   max_pcie_rqst_size      : in std_logic_vector(2 downto 0); 
   ----------------------------------------------------------------------------
   -- Control
   ----------------------------------------------------------------------------
   abort                   : in  std_logic; 
   abort_busy              : out std_logic;
   fifo_flush              : in  std_logic;
   ----------------------------------------------------------------------------
   -- Actual Bytes Output
   ----------------------------------------------------------------------------
   actual_bytes            : out std_logic_vector(31 downto 0); -- Actual number of Bytes Transferred
   actual_bytes_valid      : out std_logic; -- Actual number of Bytes Transferred valid
    ----------------------------------------------------------------------------
   -- Output PCIe Requester Request Data Stream (AXI-Stream Master)
   ----------------------------------------------------------------------------
   -- address aligned mode
   
   m_axis_pcie_rq_tvalid   : out std_logic;
   m_axis_pcie_rq_tready   : in  std_logic;
   m_axis_pcie_rq_tdata    : out std_logic_vector(255 downto 0); 
   m_axis_pcie_rq_tkeep    : out std_logic_vector(7 downto 0);    
   m_axis_pcie_rq_tuser    : out std_logic_vector(59 downto 0);
   m_axis_pcie_rq_tlast    : out std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- Status
   -----------------------------------------------------------------------------
   fifo_empty              : out std_logic;
   fifo_afl                : out std_logic
);
end px_dma_pcie2pd_rdrqst_sm;

architecture Behavioral of px_dma_pcie2pd_rdrqst_sm is

--------------------------------------------------------------------------------
--Components
--------------------------------------------------------------------------------

-- 32 deep and 128 wide
-- Common Clock
-- AXI-S FIFO
-- AFL at 26
component px_dma_pcie2pd_rqst_fifo
  port (
    s_aclk          : in  std_logic;
    s_aresetn       : in  std_logic;
    s_axis_tvalid   : in  std_logic;
    s_axis_tready   : out std_logic;
    s_axis_tdata    : in  std_logic_vector(127 downto 0);
    s_axis_tuser    : in  std_logic_vector(59 downto 0);
    m_axis_tvalid   : out std_logic;
    m_axis_tready   : in  std_logic;
    m_axis_tdata    : out std_logic_vector(127 downto 0);
    m_axis_tuser    : out std_logic_vector(59 downto 0);
    axis_prog_full  : out std_logic
  );
end component;


--------------------------------------------------------------------------------
--Types
--------------------------------------------------------------------------------

type sm_state_type is (
    RESET_STATE,
    LOAD_BUF_SIZE_COUNTER_STATE,
    ACCEPT_READ_REQUEST_STATE,
    LOAD_CNTR_STATE,
    CHOOSE_MODE_STATE,
    FETCH_META_STATE,
    FETCH_META_END_STATE,
    READ_STATE,
    READ_WAIT1_STATE,
    READ_WAIT2_STATE,
    AFL_STATE,
    EOP_STATE,
    END_STATE
);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal state                    : sm_state_type:= RESET_STATE;
signal t1_rst                   : std_logic := '0';
signal src_start_address        : std_logic_vector(63 downto 0) := (others => '0'); 
signal src_meta_address         : std_logic_vector(63 downto 0) := (others => '0');        
signal meta_len                 : std_logic := '0';          
signal buf_size                 : std_logic_vector(31 downto 0) := (others => '0');
signal buffer_rd_rqst_ready_int : std_logic := '0';       
signal src_addr_cntr            : std_logic_vector(61 downto 0) := (others => '0'); 
signal actual_cntr              : std_logic_vector(29 downto 0) := (others => '0'); 
signal t1_fifo_flush            : std_logic := '0'; 
signal abort_fifo_rst           : std_logic := '0';
signal fifo_sclr_n              : std_logic := '0';        
signal rd_rqst_tvalid           : std_logic := '0';                                           
signal last_tag                 : std_logic_vector(2 downto 0) := (others => '0'); 
signal abort_dly                : std_logic_vector(7 downto 0) := (others => '0');
signal at                       : std_logic_vector(1 downto 0) := "00";
signal fetch_meta_enable        : std_logic := '0'; 
signal rqst_out_fifo_afl        : std_logic := '0'; -- The Request Output FIFO is almost full flag
signal packet_tvalid            : std_logic := '0';     
signal packet_tready            : std_logic := '0';   
signal packet_tdata             : std_logic_vector(127 downto 0) := (others => '0');  
signal packet_tkeep             : std_logic_vector(7 downto 0) := (others => '0');      
signal packet_tuser             : std_logic_vector(59 downto 0) := (others => '0');  
signal rqst_out_fifo_tdata      : std_logic_vector(127 downto 0) := (others => '0');   
signal rqst_out_fifo_tuser      : std_logic_vector(59 downto 0) := (others => '0');  
signal end_nonposted            : std_logic := '0';
signal req_type                 : std_logic_vector(3 downto 0) := "0000";
signal poisoned_req             : std_logic := '0';                          
signal tag                      : std_logic_vector(7 downto 0) := x"00";
signal req_id_en                : std_logic := '0';                          
signal force_erc                : std_logic := '0';                              
signal attr                     : std_logic_vector(2 downto 0)  := "000";                            
signal comp_id                  : std_logic_vector(15 downto 0) := x"0000";                          
signal req_id                   : std_logic_vector(15 downto 0) := x"0000";                        
signal tc                       : std_logic_vector(2 downto 0)  := "000"; 
signal dw_to_pcie4k_boundary    : std_logic_vector(10 downto 0) := (others => '0');
signal data_buf_cntr_integer    : integer := 0;
signal data_buf_cntr            : std_logic_vector(29 downto 0) := (others => '0');
signal dw_to_pcie4k_boundary_integer: integer:= 0;
signal max_access_size          : integer := 0;
signal dw_offset                : std_logic_vector(2 downto 0) := (others => '0');
signal access_size              : std_logic_vector(12 downto 0) := (others => '0');
signal last_access              : std_logic := '0';
signal pcie_pkt_tuser           : std_logic_vector(59 downto 0) := (others => '0');
signal metatag                  : std_logic_vector(7 downto 0) := x"00";
-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

function select_least_of_3_values(val0 : integer;  
                                  val1 : integer;
                                  val2 : integer ) return integer is
type val_array_type is array (0 to 2) of integer;                                  
variable result : integer;
variable val_array : val_array_type;
begin
    val_array(0) := val0;
    val_array(1) := val1;
    val_array(2) := val2; 
    if (val_array(1) <= val_array(0)) then
        if (val_array(2) <= val_array(1)) then
           result := val_array(2);
        else
           result := val_array(1);
        end if;
    elsif (val_array(2) <= val_array(0)) then
        result := val_array(2);
    else
        result := val_array(0);
    end if;
    return result;
end function select_least_of_3_values;

function index_of_least_of_3_values(val0 : integer;  
                                    val1 : integer;
                                    val2 : integer ) return integer is
type val_array_type is array (0 to 2) of integer;  
variable result : integer;
variable val_array : val_array_type;
begin
    val_array(0) := val0;
    val_array(1) := val1;
    val_array(2) := val2;
    if (val_array(1) <= val_array(0)) then
        if (val_array(2) <= val_array(1)) then
           result := 2;
        else
           result := 1;
        end if;
    elsif (val_array(2) <= val_array(0)) then
        result := 2;
    else
        result := 0;
    end if;
    return result;
end function index_of_least_of_3_values;


--------------------------------------------------------------------------------

begin

buffer_rd_rqst_ready <= buffer_rd_rqst_ready_int;

-- max_pcie_rqst_size
-- 000b: 128 bytes maximum Read Request size
-- 001b: 256 bytes maximum Read Request size
-- 010b: 512 bytes maximum Read Request size
-- 011b: 1024 bytes maximum Read Request size
-- 100b: 2048 bytes maximum Read Request size
-- 101b: 4096 bytes maximum Read Request size

process(clk)
begin
   if rising_edge(clk) then
     case max_pcie_rqst_size is
        when "000" =>
            max_access_size <= 32; -- number of DW
        when "001" =>
            max_access_size <= 64;
        when "010" =>
            max_access_size <= 128;
        when "011" =>
            max_access_size <= 256;
        when "100" =>
            max_access_size <= 512;
        when "101" =>
            max_access_size <= 1024;
        when others =>
            max_access_size <= 1024;
     end case;    
   end if;
end process;

dw_to_pcie4k_boundary         <= "10000000000" - ('0' & src_addr_cntr(9 downto 0));
data_buf_cntr_integer         <= conv_integer('0' & data_buf_cntr(29 downto 0));
dw_to_pcie4k_boundary_integer <= conv_integer('0' & dw_to_pcie4k_boundary);

-- Determine access size in DWords
access_size <= conv_std_logic_vector(select_least_of_3_values(max_access_size, dw_to_pcie4k_boundary_integer, data_buf_cntr_integer), 13);
last_access <= '1' when (index_of_least_of_3_values(max_access_size, dw_to_pcie4k_boundary_integer, data_buf_cntr_integer) = 2) else '0';
dw_offset <= "000"; --"00" & dest_addr_cntr(0);

req_type        <= "0000"; -- Memory Read Type
poisoned_req    <= '0';
tag             <= "00" & pcie_channel & next_free_tag;
metatag         <= "00" & pcie_channel & next_free_tag;
req_id_en       <= '0';
force_erc       <= '0';
attr            <= "000";
comp_id         <= x"0000";
req_id          <= x"0000";
tc              <= "000"; 

packet_tkeep    <= x"0F";

-------------------------------------------------------------------------------
-- Output Read Request to PCIe
-------------------------------------------------------------------------------

process(clk)
begin
   if rising_edge(clk) then
      t1_fifo_flush  <= fifo_flush;
      abort_dly(7 downto 0) <= abort_dly(6 downto 0) & abort;
      if (abort_dly /= x"00") or (abort = '1') then
        abort_fifo_rst <= '1';
      else
        abort_fifo_rst <= '0';
      end if;
      fifo_sclr_n <= not (abort_fifo_rst or t1_rst or t1_fifo_flush);
   end if;
end process;   

abort_busy <= abort_fifo_rst;


rqst_fifo_inst: px_dma_pcie2pd_rqst_fifo
port map (
  s_aclk          => clk,
  s_aresetn       => fifo_sclr_n,
  s_axis_tvalid   => packet_tvalid,
  s_axis_tready   => packet_tready,
  s_axis_tdata    => packet_tdata,
  s_axis_tuser    => packet_tuser,
  m_axis_tvalid   => rd_rqst_tvalid,
  m_axis_tready   => m_axis_pcie_rq_tready,
  m_axis_tdata    => m_axis_pcie_rq_tdata(127 downto 0),
  m_axis_tuser    => m_axis_pcie_rq_tuser,
  axis_prog_full  => rqst_out_fifo_afl
);

  
m_axis_pcie_rq_tlast <= '1';
m_axis_pcie_rq_tkeep <= x"0F";

m_axis_pcie_rq_tvalid <= rd_rqst_tvalid;

m_axis_pcie_rq_tdata(255 downto 128) <= (others => '0');

process(clk)
begin
   if rising_edge(clk) then  
      fifo_empty <= not rd_rqst_tvalid;
      fifo_afl   <= rqst_out_fifo_afl;
   end if;
end process;


-------------------------------------------------------------------------------
-- Read Request State Machine
-------------------------------------------------------------------------------
process(clk)
begin
   if rising_edge(clk) then
      t1_rst <= not rst_n;
      if (t1_rst = '1') or (abort = '1') then
         state                  <= RESET_STATE;
         packet_tvalid          <= '0';
         actual_bytes           <= (others => '0');
         actual_bytes_valid     <= '0';
         buffer_rd_complete     <= '0'; 
         buffer_rqst_complete   <= '0'; 
         buffer_rd_rqst_ready_int <= '0';  
         incr_tag               <= '0';
         meta_tvalid            <= '0';
      else      
         case state is
      -- Reset State
            when RESET_STATE =>
               -- Start if there is a Buffer Read Request and no abort
               if (buffer_rd_rqst_valid = '1') then  
                  state <= ACCEPT_READ_REQUEST_STATE;
                  buffer_rd_rqst_ready_int <= '1';
               -- Otherwise, wait here.   
               else
                  state <= RESET_STATE;
                  buffer_rd_rqst_ready_int <= '0';
               end if;          
               packet_tvalid          <= '0';
               actual_bytes_valid     <= '0';  
               actual_bytes           <= (others => '0');
               buffer_rd_complete     <= '0';
               buffer_rqst_complete   <= '0'; 
               incr_tag               <= '0';
            ----------------------------------------------
            -- Read the Data Buffer Size
            ----------------------------------------------  
            when ACCEPT_READ_REQUEST_STATE =>
               state <= LOAD_CNTR_STATE;
               buffer_rd_rqst_ready_int <= '0';
               src_start_address        <= buffer_rd_rqst_data(63 downto 0);     -- Source Start Address
               src_meta_address         <= buffer_rd_rqst_data(127 downto 64);   -- Source Meta Address
               meta_len                 <= buffer_rd_rqst_data(128);             -- Use Meta Data Length
               at                       <= buffer_rd_rqst_data(130 downto 129);  -- AT
               buf_size                 <= buffer_rd_rqst_data(167 downto 138) & "00";  -- Size in bytes 
            ----------------------------------------------
            -- Load Counter State
            ----------------------------------------------  
            when LOAD_CNTR_STATE =>  
               src_addr_cntr(61 downto 0) <= src_start_address(63 downto 2); -- Load the start address (in DWords
               actual_cntr                <= (others => '0');
               data_buf_cntr              <= buf_size(31 downto 2);
               state                      <= CHOOSE_MODE_STATE;  
            ----------------------------------------------
            -- CHOOSE MODE STATE
            ----------------------------------------------  
            when CHOOSE_MODE_STATE =>  
               if (num_free_tags > "0001") and (rsp_pipe_afl = '0') then -- a free tag is available  
                  if meta_len = '1' then -- Fetch Meta Data
                    state <= FETCH_META_STATE;
                  else
                    state              <= READ_STATE; -- Don't Fetch Meta Data, go right to Start Read
                    incr_tag           <= '1'; 
                  end if;   
               else
                  state <= CHOOSE_MODE_STATE;  
               end if;          
           ----------------------------------------------
           -- Fetch Meta Data State (get length)
           ----------------------------------------------
           when FETCH_META_STATE =>      
               packet_tvalid                <= '1';
               -- Header (address Aligned)
               packet_tdata(127 downto 0)<= force_erc & attr & tc & req_id_en & comp_id & metatag & req_id & poisoned_req & req_type & "00000000100" & src_meta_address(63 downto 2) & at;
               packet_tuser(3 downto 0 ) <= "1111"; -- First BE
               packet_tuser(7 downto 4 ) <= "1111"; -- Last BE
               packet_tuser(10 downto 8) <= "000";  -- first DW offset
               packet_tuser(11)          <= '0';    -- discontinue bit off
                             
               last_tag     <= next_free_tag;
               incr_tag     <= '0'; -- '1';  
     
               state <= FETCH_META_END_STATE;  
                 
               meta_tvalid <= '1';  -- Set the return Tag to look for for meta data  
               meta_tdata  <= next_free_tag;                   
           ----------------------------------------------
           -- Meta Data Fetch End State
           ----------------------------------------------
           -- Wait until the meta data is returned before resuming.
           when FETCH_META_END_STATE =>
                 meta_tvalid           <= '0';
                 packet_tvalid         <= '0';
  
                if  meta_len = '0' then -- We are not going to use the Meta Data length, so no reason to wait for it
                    state              <= READ_STATE; -- Start Read
                    incr_tag           <= '1'; 
                -- We have found a tag match for the meta data.   
                elsif (s_axis_rd_rsp_tvalid = '1') then
                    state              <= READ_STATE; -- Modify the Buffer size with the Meta Data
                    data_buf_cntr      <= s_axis_rd_rsp_tdata(31 downto 2); -- If set to use Meta Data length then modify the buffer size
                    incr_tag           <= '1'; 
                else -- No tag match
                   state <= FETCH_META_END_STATE ; -- Start Read
                   incr_tag            <= '0'; 
                end if;         
            ----------------------------------------------
            -- Read State
            ----------------------------------------------
            when READ_STATE =>
             -- Counters
                src_addr_cntr(29 downto 0)   <= src_addr_cntr(29 downto 0) + conv_integer(access_size);
                actual_cntr                  <= actual_cntr + conv_integer(access_size);
                data_buf_cntr                <= data_buf_cntr - conv_integer(access_size);
                
                packet_tvalid                <= '1';
             -- Header (PCIe Core set for Address Aligned mode)
                packet_tdata(127 downto 0)   <= force_erc & attr & tc & req_id_en & comp_id & tag & req_id & poisoned_req & req_type & access_size(10 downto 0) & src_addr_cntr(61 downto 0) & at;
                packet_tuser(3 downto 0 )    <= "1111"; -- First BE
                packet_tuser(7 downto 4 )    <= "1111"; -- Last BE
                packet_tuser(10 downto 8)    <= dw_offset;  -- first DW offset
                packet_tuser(11)             <= '0';    -- discontinue bit off
                

                if last_access  = '1' then -- transfer is complete       
                     state                   <= EOP_STATE; -- finish                 
                elsif (rsp_pipe_afl = '1') or (rqst_out_fifo_afl = '1') or (num_free_tags < "0010") then
                     state                   <= AFL_STATE; -- Almost full, so wait   
                else
                     state                   <= READ_WAIT1_STATE; -- Start again  
                end if;
                incr_tag               <= '0';
                last_tag               <= next_free_tag;
           ----------------------------------------------
           -- Read Wait State
           ----------------------------------------------
           when READ_WAIT1_STATE =>    
                 state                 <= READ_WAIT2_STATE;
                 packet_tvalid         <= '0';  
           ----------------------------------------------
           -- Read Wait State
           ----------------------------------------------
           when READ_WAIT2_STATE =>    
                 state                 <= READ_STATE;
                 incr_tag              <= '1';  
           ----------------------------------------------
           -- End of Packet Reached
           ----------------------------------------------   
           when EOP_STATE =>  
             packet_tvalid             <= '0';  
             incr_tag                  <= '0'; 
             buffer_rqst_complete      <= '1'; 
             state                     <= END_STATE;
           ----------------------------------------------
           -- Output FIFO AFL State
           ----------------------------------------------
           when AFL_STATE =>
              -- Stay here if Almost Full
              if (rsp_pipe_afl = '1') or (rqst_out_fifo_afl = '1') or (num_free_tags < "0010") then
                 state                 <= AFL_STATE;
                 packet_tvalid         <= '0';  
                 incr_tag              <= '0';    
              else
                 state                 <= READ_STATE;
                 packet_tvalid         <= '0';  
                 incr_tag              <= '1';     
              end if;
           ----------------------------------------------
           -- End State
           ----------------------------------------------
           when END_STATE =>
              buffer_rqst_complete     <= '0'; 
              -- Last Tag of current Buffer Read Request has been responded to.   
              state <= RESET_STATE; -- Start Over
              buffer_rd_complete       <= '1';
              actual_bytes             <= actual_cntr & "00";
              actual_bytes_valid       <= '1';
           when others =>
              state <= RESET_STATE;
         end case;       
      end if;      
   end if;
end process;




end Behavioral;
