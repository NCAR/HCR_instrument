--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.40xd
--  \   \         Application: netgen
--  /   /         Filename: HMC_src_timesim.vhd
-- /___/   /\     Timestamp: Mon Jul 08 09:45:58 2013
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -s 5 -pcf HMC_src.pcf -rpw 100 -tpw 0 -ar Structure -tm HMC_src -insert_pp_buffers true -w -dir netgen/par -ofmt vhdl -sim HMC_src.ncd HMC_src_timesim.vhd 
-- Device	: 3s50avq100-5 (PRODUCTION 1.42 2012-10-12)
-- Input file	: HMC_src.ncd
-- Output file	: C:\TEMP\HMC_Redesign\netgen\par\HMC_src_timesim.vhd
-- # of Entities	: 1
-- Design Name	: HMC_src
-- Xilinx	: C:\Xilinx\14.3\ISE_DS\ISE\
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library SIMPRIM;
use SIMPRIM.VCOMPONENTS.ALL;
use SIMPRIM.VPACKAGE.ALL;

entity HMC_src is
  port (
    SPARE_STATUS0 : out STD_LOGIC; 
    SPARE_STATUS1 : out STD_LOGIC; 
    EMS_PWR_ERROR : in STD_LOGIC := 'X'; 
    RX_GATE : in STD_LOGIC := 'X'; 
    WG_SW_CTRL_NOISE : out STD_LOGIC; 
    STATUS_ACK : in STD_LOGIC := 'X'; 
    EMS_ERROR_EVENT : out STD_LOGIC; 
    SYNC_PULSE_HMC : out STD_LOGIC; 
    EMS_ERROR_45 : out STD_LOGIC; 
    RESET : in STD_LOGIC := 'X'; 
    MOD_PULSE_DISABLE : out STD_LOGIC; 
    EMS_ERROR_67 : out STD_LOGIC; 
    EMS_TRIG : in STD_LOGIC := 'X'; 
    TEST_BIT_0 : in STD_LOGIC := 'X'; 
    TEST_BIT_1 : in STD_LOGIC := 'X'; 
    T0 : in STD_LOGIC := 'X'; 
    SYNC_PULSE : in STD_LOGIC := 'X'; 
    NOISE_SOURCE_EN : out STD_LOGIC; 
    ONE_PPS : in STD_LOGIC := 'X'; 
    HV_ON_HMC : out STD_LOGIC; 
    MOD_PULSE_HMC : out STD_LOGIC; 
    HV_ON_730 : in STD_LOGIC := 'X'; 
    EXT_CLK : in STD_LOGIC := 'X'; 
    EMS_ERROR_1 : out STD_LOGIC; 
    EMS_ERROR_2 : out STD_LOGIC; 
    EMS_ERROR_3 : out STD_LOGIC; 
    MOD_PULSE : in STD_LOGIC := 'X'; 
    WG_SW_TERM : in STD_LOGIC := 'X'; 
    SPARE1 : out STD_LOGIC; 
    SPARE2 : out STD_LOGIC; 
    SPARE3 : out STD_LOGIC; 
    WG_SW_ERROR : out STD_LOGIC; 
    FIL_ON_HMC : out STD_LOGIC; 
    TIMER_6 : in STD_LOGIC := 'X'; 
    WG_SW_NOISE : in STD_LOGIC := 'X'; 
    TIMER_7 : in STD_LOGIC := 'X'; 
    FIL_ON_730 : in STD_LOGIC := 'X'; 
    WG_SW_CTRL_TERM : out STD_LOGIC; 
    TX_GATE : in STD_LOGIC := 'X'; 
    EMS_OUT : out STD_LOGIC_VECTOR ( 7 downto 1 ); 
    BIT_EMS : in STD_LOGIC_VECTOR ( 7 downto 1 ); 
    OPS_MODE_730 : in STD_LOGIC_VECTOR ( 2 downto 0 ) 
  );
end HMC_src;

architecture Structure of HMC_src is
  signal Madd_hv_count_addsub0000_cy_1_Q : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_3_Q : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_5_Q : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_7_Q : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_9_Q : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_11_Q : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_13_Q : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_15_Q : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_17_Q : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_19_Q : STD_LOGIC; 
  signal count_enable_cmp_eq0000 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000 : STD_LOGIC; 
  signal WG_SW_NOISE_IBUF_0 : STD_LOGIC; 
  signal ems_45_error_1509 : STD_LOGIC; 
  signal ems_67_error_1510 : STD_LOGIC; 
  signal SPARE2_OBUF_0 : STD_LOGIC; 
  signal WG_SW_CTRL_TERM_OBUF_1512 : STD_LOGIC; 
  signal SPARE1_OBUF1_0 : STD_LOGIC; 
  signal MOD_PULSE_IBUF_0 : STD_LOGIC; 
  signal ems_1_error_1519 : STD_LOGIC; 
  signal ems_2_error_1520 : STD_LOGIC; 
  signal HV_ON_HMC_OBUF_0 : STD_LOGIC; 
  signal ems_3_error_1522 : STD_LOGIC; 
  signal WG_SW_TERM_IBUF_0 : STD_LOGIC; 
  signal RX_GATE_IBUF_0 : STD_LOGIC; 
  signal mod_pulse_error_1529 : STD_LOGIC; 
  signal EMS_OUT_4_OBUF_0 : STD_LOGIC; 
  signal STATUS_ACK_IBUF_0 : STD_LOGIC; 
  signal EMS_OUT_7_OBUF_0 : STD_LOGIC; 
  signal WG_SW_CTRL_NOISE_OBUF_0 : STD_LOGIC; 
  signal EMS_TRIG_IBUF_0 : STD_LOGIC; 
  signal ops_mode_not0001_0 : STD_LOGIC; 
  signal ONE_PPS_IBUF_0 : STD_LOGIC; 
  signal EMS_PWR_ERROR_IBUF_0 : STD_LOGIC; 
  signal BIT_EMS_1_IBUF_0 : STD_LOGIC; 
  signal BIT_EMS_2_IBUF_0 : STD_LOGIC; 
  signal ems_error_prt_1543 : STD_LOGIC; 
  signal BIT_EMS_3_IBUF_0 : STD_LOGIC; 
  signal BIT_EMS_4_IBUF_0 : STD_LOGIC; 
  signal BIT_EMS_5_IBUF_0 : STD_LOGIC; 
  signal RESET_IBUF_0 : STD_LOGIC; 
  signal BIT_EMS_6_IBUF_0 : STD_LOGIC; 
  signal BIT_EMS_7_IBUF_0 : STD_LOGIC; 
  signal SPARE1_OBUF_1550 : STD_LOGIC; 
  signal tx_dly_1552 : STD_LOGIC; 
  signal rx_dly_1553 : STD_LOGIC; 
  signal state_FSM_FFd2_1554 : STD_LOGIC; 
  signal state_FSM_FFd1_In34 : STD_LOGIC; 
  signal N18 : STD_LOGIC; 
  signal ems_tx_stat34 : STD_LOGIC; 
  signal N14 : STD_LOGIC; 
  signal ems_tx_stat : STD_LOGIC; 
  signal ems_tx_error_1560 : STD_LOGIC; 
  signal l_tx_dly_1561 : STD_LOGIC; 
  signal N21 : STD_LOGIC; 
  signal ems_tx_count_enable_1564 : STD_LOGIC; 
  signal N10_0 : STD_LOGIC; 
  signal N9_0 : STD_LOGIC; 
  signal N38 : STD_LOGIC; 
  signal wg_dly_1573 : STD_LOGIC; 
  signal wg_count_enable_1574 : STD_LOGIC; 
  signal N4 : STD_LOGIC; 
  signal ems_rx_count_enable_1577 : STD_LOGIC; 
  signal ems_1_rx_stat_or0000 : STD_LOGIC; 
  signal N35 : STD_LOGIC; 
  signal l_rx_dly_1584 : STD_LOGIC; 
  signal N26_0 : STD_LOGIC; 
  signal state_FSM_N8 : STD_LOGIC; 
  signal ems_tx_ok_1587 : STD_LOGIC; 
  signal state_cmp_eq0000 : STD_LOGIC; 
  signal hv_dly_1589 : STD_LOGIC; 
  signal state_FSM_FFd1_In60_0 : STD_LOGIC; 
  signal ems_tx_stat21_0 : STD_LOGIC; 
  signal ems_error_prt_or00005_0 : STD_LOGIC; 
  signal ems_2_error_or000015_0 : STD_LOGIC; 
  signal ems_2_error_or000046_SW0_O : STD_LOGIC; 
  signal state_FSM_FFd1_1595 : STD_LOGIC; 
  signal state_FSM_FFd2_In92_O : STD_LOGIC; 
  signal N28_0 : STD_LOGIC; 
  signal state_FSM_FFd2_In2_0 : STD_LOGIC; 
  signal state_FSM_FFd2_In36_O : STD_LOGIC; 
  signal state_FSM_FFd2_In24_0 : STD_LOGIC; 
  signal N141_0 : STD_LOGIC; 
  signal state_FSM_FFd2_In106_O : STD_LOGIC; 
  signal ems_45_error_or0000115_O : STD_LOGIC; 
  signal ems_45_error_or000087_0 : STD_LOGIC; 
  signal ems_45_error_or00005_0 : STD_LOGIC; 
  signal ems_error_prt_or0000121_O : STD_LOGIC; 
  signal end_cycle_1607 : STD_LOGIC; 
  signal ems_error_prt_or0000118_0 : STD_LOGIC; 
  signal ems_error_prt_or000040_0 : STD_LOGIC; 
  signal ems_error_prt_or000063_0 : STD_LOGIC; 
  signal ems_error_prt_or000086_0 : STD_LOGIC; 
  signal ems_67_error_or0000115_O : STD_LOGIC; 
  signal ems_67_error_or000087_0 : STD_LOGIC; 
  signal ems_67_error_or00005_0 : STD_LOGIC; 
  signal ems_3_error_or000026_O : STD_LOGIC; 
  signal ems_3_error_or000017_0 : STD_LOGIC; 
  signal N261_0 : STD_LOGIC; 
  signal wg_change_state : STD_LOGIC; 
  signal wg_dly_not0001_0 : STD_LOGIC; 
  signal ems_1_error_or00002_0 : STD_LOGIC; 
  signal ems_1_error_or000016_O : STD_LOGIC; 
  signal ems_1_error_or000029_0 : STD_LOGIC; 
  signal l_ems_trig_1623 : STD_LOGIC; 
  signal rx_dly_not0001_1624 : STD_LOGIC; 
  signal hv_count_not0002_0 : STD_LOGIC; 
  signal tx_dly_not0001_1626 : STD_LOGIC; 
  signal l_rx_gate_1627 : STD_LOGIC; 
  signal N5_0 : STD_LOGIC; 
  signal N01 : STD_LOGIC; 
  signal ems_45_error_or000046_1631 : STD_LOGIC; 
  signal N24_0 : STD_LOGIC; 
  signal EMS_OUT_2_mux0004 : STD_LOGIC; 
  signal ems_45_error_or000031_0 : STD_LOGIC; 
  signal count_enable_not0001_0 : STD_LOGIC; 
  signal count_enable_1636 : STD_LOGIC; 
  signal N36 : STD_LOGIC; 
  signal N22_0 : STD_LOGIC; 
  signal N12 : STD_LOGIC; 
  signal N20 : STD_LOGIC; 
  signal ems_67_error_or000046_1642 : STD_LOGIC; 
  signal hv_count_addsub0000_0_XORF_1677 : STD_LOGIC; 
  signal hv_count_addsub0000_0_LOGIC_ONE_1676 : STD_LOGIC; 
  signal hv_count_addsub0000_0_CYINIT_1675 : STD_LOGIC; 
  signal hv_count_addsub0000_0_CYSELF_1666 : STD_LOGIC; 
  signal hv_count_addsub0000_0_BXINV_1664 : STD_LOGIC; 
  signal hv_count_addsub0000_0_XORG_1662 : STD_LOGIC; 
  signal hv_count_addsub0000_0_CYMUXG_1661 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_0_Q : STD_LOGIC; 
  signal hv_count_addsub0000_0_LOGIC_ZERO_1659 : STD_LOGIC; 
  signal hv_count_addsub0000_0_CYSELG_1650 : STD_LOGIC; 
  signal hv_count_addsub0000_0_G : STD_LOGIC; 
  signal hv_count_addsub0000_2_XORF_1715 : STD_LOGIC; 
  signal hv_count_addsub0000_2_CYINIT_1714 : STD_LOGIC; 
  signal hv_count_addsub0000_2_F : STD_LOGIC; 
  signal hv_count_addsub0000_2_XORG_1703 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_2_Q : STD_LOGIC; 
  signal hv_count_addsub0000_2_CYSELF_1701 : STD_LOGIC; 
  signal hv_count_addsub0000_2_CYMUXFAST_1700 : STD_LOGIC; 
  signal hv_count_addsub0000_2_CYAND_1699 : STD_LOGIC; 
  signal hv_count_addsub0000_2_FASTCARRY_1698 : STD_LOGIC; 
  signal hv_count_addsub0000_2_CYMUXG2_1697 : STD_LOGIC; 
  signal hv_count_addsub0000_2_CYMUXF2_1696 : STD_LOGIC; 
  signal hv_count_addsub0000_2_LOGIC_ZERO_1695 : STD_LOGIC; 
  signal hv_count_addsub0000_2_CYSELG_1686 : STD_LOGIC; 
  signal hv_count_addsub0000_2_G : STD_LOGIC; 
  signal hv_count_addsub0000_4_XORF_1753 : STD_LOGIC; 
  signal hv_count_addsub0000_4_CYINIT_1752 : STD_LOGIC; 
  signal hv_count_addsub0000_4_F : STD_LOGIC; 
  signal hv_count_addsub0000_4_XORG_1741 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_4_Q : STD_LOGIC; 
  signal hv_count_addsub0000_4_CYSELF_1739 : STD_LOGIC; 
  signal hv_count_addsub0000_4_CYMUXFAST_1738 : STD_LOGIC; 
  signal hv_count_addsub0000_4_CYAND_1737 : STD_LOGIC; 
  signal hv_count_addsub0000_4_FASTCARRY_1736 : STD_LOGIC; 
  signal hv_count_addsub0000_4_CYMUXG2_1735 : STD_LOGIC; 
  signal hv_count_addsub0000_4_CYMUXF2_1734 : STD_LOGIC; 
  signal hv_count_addsub0000_4_LOGIC_ZERO_1733 : STD_LOGIC; 
  signal hv_count_addsub0000_4_CYSELG_1724 : STD_LOGIC; 
  signal hv_count_addsub0000_4_G : STD_LOGIC; 
  signal hv_count_addsub0000_6_XORF_1791 : STD_LOGIC; 
  signal hv_count_addsub0000_6_CYINIT_1790 : STD_LOGIC; 
  signal hv_count_addsub0000_6_F : STD_LOGIC; 
  signal hv_count_addsub0000_6_XORG_1779 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_6_Q : STD_LOGIC; 
  signal hv_count_addsub0000_6_CYSELF_1777 : STD_LOGIC; 
  signal hv_count_addsub0000_6_CYMUXFAST_1776 : STD_LOGIC; 
  signal hv_count_addsub0000_6_CYAND_1775 : STD_LOGIC; 
  signal hv_count_addsub0000_6_FASTCARRY_1774 : STD_LOGIC; 
  signal hv_count_addsub0000_6_CYMUXG2_1773 : STD_LOGIC; 
  signal hv_count_addsub0000_6_CYMUXF2_1772 : STD_LOGIC; 
  signal hv_count_addsub0000_6_LOGIC_ZERO_1771 : STD_LOGIC; 
  signal hv_count_addsub0000_6_CYSELG_1762 : STD_LOGIC; 
  signal hv_count_addsub0000_6_G : STD_LOGIC; 
  signal hv_count_addsub0000_8_XORF_1829 : STD_LOGIC; 
  signal hv_count_addsub0000_8_CYINIT_1828 : STD_LOGIC; 
  signal hv_count_addsub0000_8_F : STD_LOGIC; 
  signal hv_count_addsub0000_8_XORG_1817 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_8_Q : STD_LOGIC; 
  signal hv_count_addsub0000_8_CYSELF_1815 : STD_LOGIC; 
  signal hv_count_addsub0000_8_CYMUXFAST_1814 : STD_LOGIC; 
  signal hv_count_addsub0000_8_CYAND_1813 : STD_LOGIC; 
  signal hv_count_addsub0000_8_FASTCARRY_1812 : STD_LOGIC; 
  signal hv_count_addsub0000_8_CYMUXG2_1811 : STD_LOGIC; 
  signal hv_count_addsub0000_8_CYMUXF2_1810 : STD_LOGIC; 
  signal hv_count_addsub0000_8_LOGIC_ZERO_1809 : STD_LOGIC; 
  signal hv_count_addsub0000_8_CYSELG_1800 : STD_LOGIC; 
  signal hv_count_addsub0000_8_G : STD_LOGIC; 
  signal hv_count_addsub0000_10_XORF_1867 : STD_LOGIC; 
  signal hv_count_addsub0000_10_CYINIT_1866 : STD_LOGIC; 
  signal hv_count_addsub0000_10_F : STD_LOGIC; 
  signal hv_count_addsub0000_10_XORG_1855 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_10_Q : STD_LOGIC; 
  signal hv_count_addsub0000_10_CYSELF_1853 : STD_LOGIC; 
  signal hv_count_addsub0000_10_CYMUXFAST_1852 : STD_LOGIC; 
  signal hv_count_addsub0000_10_CYAND_1851 : STD_LOGIC; 
  signal hv_count_addsub0000_10_FASTCARRY_1850 : STD_LOGIC; 
  signal hv_count_addsub0000_10_CYMUXG2_1849 : STD_LOGIC; 
  signal hv_count_addsub0000_10_CYMUXF2_1848 : STD_LOGIC; 
  signal hv_count_addsub0000_10_LOGIC_ZERO_1847 : STD_LOGIC; 
  signal hv_count_addsub0000_10_CYSELG_1838 : STD_LOGIC; 
  signal hv_count_addsub0000_10_G : STD_LOGIC; 
  signal hv_count_addsub0000_12_XORF_1905 : STD_LOGIC; 
  signal hv_count_addsub0000_12_CYINIT_1904 : STD_LOGIC; 
  signal hv_count_addsub0000_12_F : STD_LOGIC; 
  signal hv_count_addsub0000_12_XORG_1893 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_12_Q : STD_LOGIC; 
  signal hv_count_addsub0000_12_CYSELF_1891 : STD_LOGIC; 
  signal hv_count_addsub0000_12_CYMUXFAST_1890 : STD_LOGIC; 
  signal hv_count_addsub0000_12_CYAND_1889 : STD_LOGIC; 
  signal hv_count_addsub0000_12_FASTCARRY_1888 : STD_LOGIC; 
  signal hv_count_addsub0000_12_CYMUXG2_1887 : STD_LOGIC; 
  signal hv_count_addsub0000_12_CYMUXF2_1886 : STD_LOGIC; 
  signal hv_count_addsub0000_12_LOGIC_ZERO_1885 : STD_LOGIC; 
  signal hv_count_addsub0000_12_CYSELG_1876 : STD_LOGIC; 
  signal hv_count_addsub0000_12_G : STD_LOGIC; 
  signal hv_count_addsub0000_14_XORF_1943 : STD_LOGIC; 
  signal hv_count_addsub0000_14_CYINIT_1942 : STD_LOGIC; 
  signal hv_count_addsub0000_14_F : STD_LOGIC; 
  signal hv_count_addsub0000_14_XORG_1931 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_14_Q : STD_LOGIC; 
  signal hv_count_addsub0000_14_CYSELF_1929 : STD_LOGIC; 
  signal hv_count_addsub0000_14_CYMUXFAST_1928 : STD_LOGIC; 
  signal hv_count_addsub0000_14_CYAND_1927 : STD_LOGIC; 
  signal hv_count_addsub0000_14_FASTCARRY_1926 : STD_LOGIC; 
  signal hv_count_addsub0000_14_CYMUXG2_1925 : STD_LOGIC; 
  signal hv_count_addsub0000_14_CYMUXF2_1924 : STD_LOGIC; 
  signal hv_count_addsub0000_14_LOGIC_ZERO_1923 : STD_LOGIC; 
  signal hv_count_addsub0000_14_CYSELG_1914 : STD_LOGIC; 
  signal hv_count_addsub0000_14_G : STD_LOGIC; 
  signal hv_count_addsub0000_16_XORF_1981 : STD_LOGIC; 
  signal hv_count_addsub0000_16_CYINIT_1980 : STD_LOGIC; 
  signal hv_count_addsub0000_16_F : STD_LOGIC; 
  signal hv_count_addsub0000_16_XORG_1969 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_16_Q : STD_LOGIC; 
  signal hv_count_addsub0000_16_CYSELF_1967 : STD_LOGIC; 
  signal hv_count_addsub0000_16_CYMUXFAST_1966 : STD_LOGIC; 
  signal hv_count_addsub0000_16_CYAND_1965 : STD_LOGIC; 
  signal hv_count_addsub0000_16_FASTCARRY_1964 : STD_LOGIC; 
  signal hv_count_addsub0000_16_CYMUXG2_1963 : STD_LOGIC; 
  signal hv_count_addsub0000_16_CYMUXF2_1962 : STD_LOGIC; 
  signal hv_count_addsub0000_16_LOGIC_ZERO_1961 : STD_LOGIC; 
  signal hv_count_addsub0000_16_CYSELG_1952 : STD_LOGIC; 
  signal hv_count_addsub0000_16_G : STD_LOGIC; 
  signal hv_count_addsub0000_18_XORF_2019 : STD_LOGIC; 
  signal hv_count_addsub0000_18_CYINIT_2018 : STD_LOGIC; 
  signal hv_count_addsub0000_18_F : STD_LOGIC; 
  signal hv_count_addsub0000_18_XORG_2007 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_18_Q : STD_LOGIC; 
  signal hv_count_addsub0000_18_CYSELF_2005 : STD_LOGIC; 
  signal hv_count_addsub0000_18_CYMUXFAST_2004 : STD_LOGIC; 
  signal hv_count_addsub0000_18_CYAND_2003 : STD_LOGIC; 
  signal hv_count_addsub0000_18_FASTCARRY_2002 : STD_LOGIC; 
  signal hv_count_addsub0000_18_CYMUXG2_2001 : STD_LOGIC; 
  signal hv_count_addsub0000_18_CYMUXF2_2000 : STD_LOGIC; 
  signal hv_count_addsub0000_18_LOGIC_ZERO_1999 : STD_LOGIC; 
  signal hv_count_addsub0000_18_CYSELG_1990 : STD_LOGIC; 
  signal hv_count_addsub0000_18_G : STD_LOGIC; 
  signal hv_count_addsub0000_20_XORF_2057 : STD_LOGIC; 
  signal hv_count_addsub0000_20_CYINIT_2056 : STD_LOGIC; 
  signal hv_count_addsub0000_20_F : STD_LOGIC; 
  signal hv_count_addsub0000_20_XORG_2045 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_20_Q : STD_LOGIC; 
  signal hv_count_addsub0000_20_CYSELF_2043 : STD_LOGIC; 
  signal hv_count_addsub0000_20_CYMUXFAST_2042 : STD_LOGIC; 
  signal hv_count_addsub0000_20_CYAND_2041 : STD_LOGIC; 
  signal hv_count_addsub0000_20_FASTCARRY_2040 : STD_LOGIC; 
  signal hv_count_addsub0000_20_CYMUXG2_2039 : STD_LOGIC; 
  signal hv_count_addsub0000_20_CYMUXF2_2038 : STD_LOGIC; 
  signal hv_count_addsub0000_20_LOGIC_ZERO_2037 : STD_LOGIC; 
  signal hv_count_addsub0000_20_CYSELG_2028 : STD_LOGIC; 
  signal hv_count_addsub0000_20_G : STD_LOGIC; 
  signal hv_count_addsub0000_22_XORF_2088 : STD_LOGIC; 
  signal hv_count_addsub0000_22_LOGIC_ZERO_2087 : STD_LOGIC; 
  signal hv_count_addsub0000_22_CYINIT_2086 : STD_LOGIC; 
  signal hv_count_addsub0000_22_CYSELF_2077 : STD_LOGIC; 
  signal hv_count_addsub0000_22_F : STD_LOGIC; 
  signal hv_count_addsub0000_22_XORG_2074 : STD_LOGIC; 
  signal Madd_hv_count_addsub0000_cy_22_Q : STD_LOGIC; 
  signal hv_count_23_rt_2071 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_1_CYINIT_2118 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_1_CYSELF_2112 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_1_BXINV_2110 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_1_CYMUXG_2109 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_1_LOGIC_ZERO_2107 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_1_CYSELG_2101 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_3_CYSELF_2142 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_3_CYMUXFAST_2141 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_3_CYAND_2140 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_3_FASTCARRY_2139 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_3_CYMUXG2_2138 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_3_CYMUXF2_2137 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_3_LOGIC_ZERO_2136 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_wg_cy_3_CYSELG_2130 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_CYSELF_2172 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_CYMUXFAST_2171 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_CYAND_2170 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_FASTCARRY_2169 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_CYMUXG2_2168 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_CYMUXF2_2167 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_LOGIC_ZERO_2166 : STD_LOGIC; 
  signal count_enable_cmp_eq0000_CYSELG_2160 : STD_LOGIC; 
  signal wg_count_addsub0000_0_XORF_2213 : STD_LOGIC; 
  signal wg_count_addsub0000_0_LOGIC_ONE_2212 : STD_LOGIC; 
  signal wg_count_addsub0000_0_CYINIT_2211 : STD_LOGIC; 
  signal wg_count_addsub0000_0_CYSELF_2202 : STD_LOGIC; 
  signal wg_count_addsub0000_0_BXINV_2200 : STD_LOGIC; 
  signal wg_count_addsub0000_0_XORG_2198 : STD_LOGIC; 
  signal wg_count_addsub0000_0_CYMUXG_2197 : STD_LOGIC; 
  signal wg_count_addsub0000_0_LOGIC_ZERO_2195 : STD_LOGIC; 
  signal wg_count_addsub0000_0_CYSELG_2186 : STD_LOGIC; 
  signal wg_count_addsub0000_0_G : STD_LOGIC; 
  signal wg_count_addsub0000_2_XORF_2251 : STD_LOGIC; 
  signal wg_count_addsub0000_2_CYINIT_2250 : STD_LOGIC; 
  signal wg_count_addsub0000_2_F : STD_LOGIC; 
  signal wg_count_addsub0000_2_XORG_2239 : STD_LOGIC; 
  signal wg_count_addsub0000_2_CYSELF_2237 : STD_LOGIC; 
  signal wg_count_addsub0000_2_CYMUXFAST_2236 : STD_LOGIC; 
  signal wg_count_addsub0000_2_CYAND_2235 : STD_LOGIC; 
  signal wg_count_addsub0000_2_FASTCARRY_2234 : STD_LOGIC; 
  signal wg_count_addsub0000_2_CYMUXG2_2233 : STD_LOGIC; 
  signal wg_count_addsub0000_2_CYMUXF2_2232 : STD_LOGIC; 
  signal wg_count_addsub0000_2_LOGIC_ZERO_2231 : STD_LOGIC; 
  signal wg_count_addsub0000_2_CYSELG_2222 : STD_LOGIC; 
  signal wg_count_addsub0000_2_G : STD_LOGIC; 
  signal wg_count_addsub0000_4_XORF_2289 : STD_LOGIC; 
  signal wg_count_addsub0000_4_CYINIT_2288 : STD_LOGIC; 
  signal wg_count_addsub0000_4_F : STD_LOGIC; 
  signal wg_count_addsub0000_4_XORG_2277 : STD_LOGIC; 
  signal wg_count_addsub0000_4_CYSELF_2275 : STD_LOGIC; 
  signal wg_count_addsub0000_4_CYMUXFAST_2274 : STD_LOGIC; 
  signal wg_count_addsub0000_4_CYAND_2273 : STD_LOGIC; 
  signal wg_count_addsub0000_4_FASTCARRY_2272 : STD_LOGIC; 
  signal wg_count_addsub0000_4_CYMUXG2_2271 : STD_LOGIC; 
  signal wg_count_addsub0000_4_CYMUXF2_2270 : STD_LOGIC; 
  signal wg_count_addsub0000_4_LOGIC_ZERO_2269 : STD_LOGIC; 
  signal wg_count_addsub0000_4_CYSELG_2260 : STD_LOGIC; 
  signal wg_count_addsub0000_4_G : STD_LOGIC; 
  signal wg_count_addsub0000_6_XORF_2327 : STD_LOGIC; 
  signal wg_count_addsub0000_6_CYINIT_2326 : STD_LOGIC; 
  signal wg_count_addsub0000_6_F : STD_LOGIC; 
  signal wg_count_addsub0000_6_XORG_2315 : STD_LOGIC; 
  signal wg_count_addsub0000_6_CYSELF_2313 : STD_LOGIC; 
  signal wg_count_addsub0000_6_CYMUXFAST_2312 : STD_LOGIC; 
  signal wg_count_addsub0000_6_CYAND_2311 : STD_LOGIC; 
  signal wg_count_addsub0000_6_FASTCARRY_2310 : STD_LOGIC; 
  signal wg_count_addsub0000_6_CYMUXG2_2309 : STD_LOGIC; 
  signal wg_count_addsub0000_6_CYMUXF2_2308 : STD_LOGIC; 
  signal wg_count_addsub0000_6_LOGIC_ZERO_2307 : STD_LOGIC; 
  signal wg_count_addsub0000_6_CYSELG_2298 : STD_LOGIC; 
  signal wg_count_addsub0000_6_G : STD_LOGIC; 
  signal wg_count_addsub0000_8_XORF_2365 : STD_LOGIC; 
  signal wg_count_addsub0000_8_CYINIT_2364 : STD_LOGIC; 
  signal wg_count_addsub0000_8_F : STD_LOGIC; 
  signal wg_count_addsub0000_8_XORG_2353 : STD_LOGIC; 
  signal wg_count_addsub0000_8_CYSELF_2351 : STD_LOGIC; 
  signal wg_count_addsub0000_8_CYMUXFAST_2350 : STD_LOGIC; 
  signal wg_count_addsub0000_8_CYAND_2349 : STD_LOGIC; 
  signal wg_count_addsub0000_8_FASTCARRY_2348 : STD_LOGIC; 
  signal wg_count_addsub0000_8_CYMUXG2_2347 : STD_LOGIC; 
  signal wg_count_addsub0000_8_CYMUXF2_2346 : STD_LOGIC; 
  signal wg_count_addsub0000_8_LOGIC_ZERO_2345 : STD_LOGIC; 
  signal wg_count_addsub0000_8_CYSELG_2336 : STD_LOGIC; 
  signal wg_count_addsub0000_8_G : STD_LOGIC; 
  signal wg_count_addsub0000_10_XORF_2403 : STD_LOGIC; 
  signal wg_count_addsub0000_10_CYINIT_2402 : STD_LOGIC; 
  signal wg_count_addsub0000_10_F : STD_LOGIC; 
  signal wg_count_addsub0000_10_XORG_2391 : STD_LOGIC; 
  signal wg_count_addsub0000_10_CYSELF_2389 : STD_LOGIC; 
  signal wg_count_addsub0000_10_CYMUXFAST_2388 : STD_LOGIC; 
  signal wg_count_addsub0000_10_CYAND_2387 : STD_LOGIC; 
  signal wg_count_addsub0000_10_FASTCARRY_2386 : STD_LOGIC; 
  signal wg_count_addsub0000_10_CYMUXG2_2385 : STD_LOGIC; 
  signal wg_count_addsub0000_10_CYMUXF2_2384 : STD_LOGIC; 
  signal wg_count_addsub0000_10_LOGIC_ZERO_2383 : STD_LOGIC; 
  signal wg_count_addsub0000_10_CYSELG_2374 : STD_LOGIC; 
  signal wg_count_addsub0000_10_G : STD_LOGIC; 
  signal wg_count_addsub0000_12_XORF_2441 : STD_LOGIC; 
  signal wg_count_addsub0000_12_CYINIT_2440 : STD_LOGIC; 
  signal wg_count_addsub0000_12_F : STD_LOGIC; 
  signal wg_count_addsub0000_12_XORG_2429 : STD_LOGIC; 
  signal wg_count_addsub0000_12_CYSELF_2427 : STD_LOGIC; 
  signal wg_count_addsub0000_12_CYMUXFAST_2426 : STD_LOGIC; 
  signal wg_count_addsub0000_12_CYAND_2425 : STD_LOGIC; 
  signal wg_count_addsub0000_12_FASTCARRY_2424 : STD_LOGIC; 
  signal wg_count_addsub0000_12_CYMUXG2_2423 : STD_LOGIC; 
  signal wg_count_addsub0000_12_CYMUXF2_2422 : STD_LOGIC; 
  signal wg_count_addsub0000_12_LOGIC_ZERO_2421 : STD_LOGIC; 
  signal wg_count_addsub0000_12_CYSELG_2412 : STD_LOGIC; 
  signal wg_count_addsub0000_12_G : STD_LOGIC; 
  signal wg_count_addsub0000_14_XORF_2479 : STD_LOGIC; 
  signal wg_count_addsub0000_14_CYINIT_2478 : STD_LOGIC; 
  signal wg_count_addsub0000_14_F : STD_LOGIC; 
  signal wg_count_addsub0000_14_XORG_2467 : STD_LOGIC; 
  signal wg_count_addsub0000_14_CYSELF_2465 : STD_LOGIC; 
  signal wg_count_addsub0000_14_CYMUXFAST_2464 : STD_LOGIC; 
  signal wg_count_addsub0000_14_CYAND_2463 : STD_LOGIC; 
  signal wg_count_addsub0000_14_FASTCARRY_2462 : STD_LOGIC; 
  signal wg_count_addsub0000_14_CYMUXG2_2461 : STD_LOGIC; 
  signal wg_count_addsub0000_14_CYMUXF2_2460 : STD_LOGIC; 
  signal wg_count_addsub0000_14_LOGIC_ZERO_2459 : STD_LOGIC; 
  signal wg_count_addsub0000_14_CYSELG_2450 : STD_LOGIC; 
  signal wg_count_addsub0000_14_G : STD_LOGIC; 
  signal wg_count_addsub0000_16_XORF_2517 : STD_LOGIC; 
  signal wg_count_addsub0000_16_CYINIT_2516 : STD_LOGIC; 
  signal wg_count_addsub0000_16_F : STD_LOGIC; 
  signal wg_count_addsub0000_16_XORG_2505 : STD_LOGIC; 
  signal wg_count_addsub0000_16_CYSELF_2503 : STD_LOGIC; 
  signal wg_count_addsub0000_16_CYMUXFAST_2502 : STD_LOGIC; 
  signal wg_count_addsub0000_16_CYAND_2501 : STD_LOGIC; 
  signal wg_count_addsub0000_16_FASTCARRY_2500 : STD_LOGIC; 
  signal wg_count_addsub0000_16_CYMUXG2_2499 : STD_LOGIC; 
  signal wg_count_addsub0000_16_CYMUXF2_2498 : STD_LOGIC; 
  signal wg_count_addsub0000_16_LOGIC_ZERO_2497 : STD_LOGIC; 
  signal wg_count_addsub0000_16_CYSELG_2488 : STD_LOGIC; 
  signal wg_count_addsub0000_16_G : STD_LOGIC; 
  signal wg_count_addsub0000_18_XORF_2555 : STD_LOGIC; 
  signal wg_count_addsub0000_18_CYINIT_2554 : STD_LOGIC; 
  signal wg_count_addsub0000_18_F : STD_LOGIC; 
  signal wg_count_addsub0000_18_XORG_2543 : STD_LOGIC; 
  signal wg_count_addsub0000_18_CYSELF_2541 : STD_LOGIC; 
  signal wg_count_addsub0000_18_CYMUXFAST_2540 : STD_LOGIC; 
  signal wg_count_addsub0000_18_CYAND_2539 : STD_LOGIC; 
  signal wg_count_addsub0000_18_FASTCARRY_2538 : STD_LOGIC; 
  signal wg_count_addsub0000_18_CYMUXG2_2537 : STD_LOGIC; 
  signal wg_count_addsub0000_18_CYMUXF2_2536 : STD_LOGIC; 
  signal wg_count_addsub0000_18_LOGIC_ZERO_2535 : STD_LOGIC; 
  signal wg_count_addsub0000_18_CYSELG_2526 : STD_LOGIC; 
  signal wg_count_addsub0000_18_G : STD_LOGIC; 
  signal wg_count_addsub0000_20_XORF_2570 : STD_LOGIC; 
  signal wg_count_addsub0000_20_CYINIT_2569 : STD_LOGIC; 
  signal wg_count_20_rt_2567 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_1_CYINIT_2600 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_1_CYSELF_2591 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_1_BXINV_2589 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_1_CYMUXG_2588 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_1_LOGIC_ZERO_2586 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_1_CYSELG_2580 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_3_CYSELF_2624 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_3_CYMUXFAST_2623 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_3_CYAND_2622 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_3_FASTCARRY_2621 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_3_CYMUXG2_2620 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_3_CYMUXF2_2619 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_3_LOGIC_ZERO_2618 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_wg_cy_3_CYSELG_2612 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_CYSELF_2654 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_CYMUXFAST_2653 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_CYAND_2652 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_FASTCARRY_2651 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_CYMUXG2_2650 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_CYMUXF2_2649 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_LOGIC_ZERO_2648 : STD_LOGIC; 
  signal wg_dly_cmp_eq0000_CYSELG_2642 : STD_LOGIC; 
  signal WG_SW_NOISE_IBUF_2667 : STD_LOGIC; 
  signal MOD_PULSE_HMC_O : STD_LOGIC; 
  signal EMS_ERROR_45_O : STD_LOGIC; 
  signal EMS_ERROR_67_O : STD_LOGIC; 
  signal SPARE2_OBUF_2698 : STD_LOGIC; 
  signal WG_SW_CTRL_TERM_O : STD_LOGIC; 
  signal SPARE_STATUS0_OBUF_2713 : STD_LOGIC; 
  signal SPARE_STATUS1_OBUF_2720 : STD_LOGIC; 
  signal SPARE1_O : STD_LOGIC; 
  signal MOD_PULSE_IBUF_2735 : STD_LOGIC; 
  signal SPARE2_O : STD_LOGIC; 
  signal WG_SW_ERROR_O : STD_LOGIC; 
  signal SPARE3_O : STD_LOGIC; 
  signal EMS_ERROR_1_O : STD_LOGIC; 
  signal EMS_ERROR_2_O : STD_LOGIC; 
  signal HV_ON_HMC_OBUF_2782 : STD_LOGIC; 
  signal EMS_ERROR_3_O : STD_LOGIC; 
  signal SYNC_PULSE_HMC_O : STD_LOGIC; 
  signal SPARE1_OBUF1 : STD_LOGIC; 
  signal FIL_ON_HMC_O : STD_LOGIC; 
  signal WG_SW_TERM_IBUF_2820 : STD_LOGIC; 
  signal RX_GATE_IBUF_2827 : STD_LOGIC; 
  signal EMS_OUT_1_O : STD_LOGIC; 
  signal EMS_OUT_2_O : STD_LOGIC; 
  signal MOD_PULSE_DISABLE_O : STD_LOGIC; 
  signal SYNC_PULSE_HMC_OBUF_2858 : STD_LOGIC; 
  signal EMS_OUT_3_O : STD_LOGIC; 
  signal EMS_OUT_4_O : STD_LOGIC; 
  signal STATUS_ACK_IBUF_2881 : STD_LOGIC; 
  signal EMS_OUT_5_O : STD_LOGIC; 
  signal NOISE_SOURCE_EN_O : STD_LOGIC; 
  signal EMS_OUT_6_O : STD_LOGIC; 
  signal WG_SW_CTRL_NOISE_O : STD_LOGIC; 
  signal HV_ON_HMC_O : STD_LOGIC; 
  signal EMS_TRIG_IBUF_2928 : STD_LOGIC; 
  signal OPS_MODE_730_0_IBUF_2943 : STD_LOGIC; 
  signal OPS_MODE_730_1_IBUF_2958 : STD_LOGIC; 
  signal SPARE3_OBUF_2965 : STD_LOGIC; 
  signal OPS_MODE_730_2_IBUF_2980 : STD_LOGIC; 
  signal ONE_PPS_IBUF_2987 : STD_LOGIC; 
  signal EMS_OUT_7_O : STD_LOGIC; 
  signal SPARE_STATUS0_O : STD_LOGIC; 
  signal SPARE_STATUS1_O : STD_LOGIC; 
  signal EMS_PWR_ERROR_IBUF_3018 : STD_LOGIC; 
  signal BIT_EMS_1_IBUF_3025 : STD_LOGIC; 
  signal BIT_EMS_2_IBUF_3032 : STD_LOGIC; 
  signal EMS_ERROR_EVENT_O : STD_LOGIC; 
  signal BIT_EMS_3_IBUF_3047 : STD_LOGIC; 
  signal BIT_EMS_4_IBUF_3054 : STD_LOGIC; 
  signal BIT_EMS_5_IBUF_3061 : STD_LOGIC; 
  signal RESET_IBUF_3068 : STD_LOGIC; 
  signal BIT_EMS_6_IBUF_3075 : STD_LOGIC; 
  signal FIL_ON_HMC_OBUF_3082 : STD_LOGIC; 
  signal BIT_EMS_7_IBUF_3089 : STD_LOGIC; 
  signal SPARE1_OBUF_BUFG_S_INVNOT : STD_LOGIC; 
  signal SPARE1_OBUF_BUFG_I0_INV : STD_LOGIC; 
  signal state_FSM_FFd1_In34_F5MUX_3118 : STD_LOGIC; 
  signal state_FSM_FFd1_In34_F_3116 : STD_LOGIC; 
  signal state_FSM_FFd1_In34_BXINV_3107 : STD_LOGIC; 
  signal N30 : STD_LOGIC; 
  signal N18_F5MUX_3143 : STD_LOGIC; 
  signal N33 : STD_LOGIC; 
  signal N18_BXINV_3136 : STD_LOGIC; 
  signal N32 : STD_LOGIC; 
  signal ems_tx_stat34_F5MUX_3168 : STD_LOGIC; 
  signal ems_tx_stat34_F : STD_LOGIC; 
  signal ems_tx_stat34_BXINV_3157 : STD_LOGIC; 
  signal ems_tx_stat341_3155 : STD_LOGIC; 
  signal ems_tx_error_DXMUX_3198 : STD_LOGIC; 
  signal ems_tx_error_and0000 : STD_LOGIC; 
  signal N14_pack_2 : STD_LOGIC; 
  signal ems_tx_error_CLKINV_3180 : STD_LOGIC; 
  signal ems_tx_count_0_DXMUX_3233 : STD_LOGIC; 
  signal N21_pack_2 : STD_LOGIC; 
  signal ems_tx_count_0_CLKINV_3216 : STD_LOGIC; 
  signal wg_count_enable_DXMUX_3270 : STD_LOGIC; 
  signal wg_count_enable_mux0000 : STD_LOGIC; 
  signal N38_pack_2 : STD_LOGIC; 
  signal wg_count_enable_CLKINV_3252 : STD_LOGIC; 
  signal wg_count_enable_CEINV_3251 : STD_LOGIC; 
  signal ems_rx_count_0_DXMUX_3305 : STD_LOGIC; 
  signal N4_pack_2 : STD_LOGIC; 
  signal ems_rx_count_0_CLKINV_3288 : STD_LOGIC; 
  signal N26 : STD_LOGIC; 
  signal N35_pack_1 : STD_LOGIC; 
  signal state_FSM_FFd1_In60_3357 : STD_LOGIC; 
  signal state_FSM_N8_pack_1 : STD_LOGIC; 
  signal ems_error_prt_or00005_3381 : STD_LOGIC; 
  signal ems_tx_stat_pack_1 : STD_LOGIC; 
  signal ems_2_error_DXMUX_3412 : STD_LOGIC; 
  signal ems_2_error_or0000 : STD_LOGIC; 
  signal ems_2_error_or000046_SW0_O_pack_2 : STD_LOGIC; 
  signal ems_2_error_CLKINV_3396 : STD_LOGIC; 
  signal N28 : STD_LOGIC; 
  signal state_FSM_FFd2_In92_O_pack_1 : STD_LOGIC; 
  signal N141 : STD_LOGIC; 
  signal state_FSM_FFd2_In36_O_pack_1 : STD_LOGIC; 
  signal state_FSM_FFd2_DXMUX_3495 : STD_LOGIC; 
  signal state_FSM_FFd2_In : STD_LOGIC; 
  signal state_FSM_FFd2_In106_O_pack_3 : STD_LOGIC; 
  signal state_FSM_FFd2_CLKINV_3479 : STD_LOGIC; 
  signal ems_45_error_DXMUX_3530 : STD_LOGIC; 
  signal ems_45_error_or0000 : STD_LOGIC; 
  signal ems_45_error_or0000115_O_pack_2 : STD_LOGIC; 
  signal ems_45_error_CLKINV_3513 : STD_LOGIC; 
  signal ems_error_prt_DXMUX_3565 : STD_LOGIC; 
  signal ems_error_prt_or0000 : STD_LOGIC; 
  signal ems_error_prt_or0000121_O_pack_1 : STD_LOGIC; 
  signal ems_error_prt_CLKINV_3548 : STD_LOGIC; 
  signal ems_67_error_DXMUX_3600 : STD_LOGIC; 
  signal ems_67_error_or0000 : STD_LOGIC; 
  signal ems_67_error_or0000115_O_pack_2 : STD_LOGIC; 
  signal ems_67_error_CLKINV_3583 : STD_LOGIC; 
  signal ems_3_error_DXMUX_3635 : STD_LOGIC; 
  signal ems_3_error_or0000 : STD_LOGIC; 
  signal ems_3_error_or000026_O_pack_2 : STD_LOGIC; 
  signal ems_3_error_CLKINV_3619 : STD_LOGIC; 
  signal wg_dly_not0001 : STD_LOGIC; 
  signal wg_change_state_pack_1 : STD_LOGIC; 
  signal ems_1_error_or000029_3687 : STD_LOGIC; 
  signal ems_1_error_or000016_O_pack_1 : STD_LOGIC; 
  signal ems_rx_count_enable_DXMUX_3724 : STD_LOGIC; 
  signal ems_rx_count_enable_and0000 : STD_LOGIC; 
  signal ems_rx_count_enable_DYMUX_3711 : STD_LOGIC; 
  signal ems_tx_ok_and0000 : STD_LOGIC; 
  signal ems_rx_count_enable_SRINVNOT : STD_LOGIC; 
  signal ems_rx_count_enable_CLKINV_3702 : STD_LOGIC; 
  signal ems_rx_count_2_FFY_RST : STD_LOGIC; 
  signal ems_rx_count_2_FFX_RST : STD_LOGIC; 
  signal ems_rx_count_2_DXMUX_3766 : STD_LOGIC; 
  signal ems_rx_count_2_DYMUX_3752 : STD_LOGIC; 
  signal ems_rx_count_2_SRINVNOT : STD_LOGIC; 
  signal ems_rx_count_2_CLKINV_3742 : STD_LOGIC; 
  signal hv_count_11_FFY_RST : STD_LOGIC; 
  signal hv_count_11_FFX_RST : STD_LOGIC; 
  signal hv_count_11_DXMUX_3811 : STD_LOGIC; 
  signal hv_count_11_DYMUX_3795 : STD_LOGIC; 
  signal hv_count_11_SRINVNOT : STD_LOGIC; 
  signal hv_count_11_CLKINV_3785 : STD_LOGIC; 
  signal hv_count_11_CEINV_3784 : STD_LOGIC; 
  signal hv_count_21_FFY_RST : STD_LOGIC; 
  signal hv_count_21_FFX_RST : STD_LOGIC; 
  signal hv_count_21_DXMUX_3857 : STD_LOGIC; 
  signal hv_count_21_DYMUX_3841 : STD_LOGIC; 
  signal hv_count_21_SRINVNOT : STD_LOGIC; 
  signal hv_count_21_CLKINV_3831 : STD_LOGIC; 
  signal hv_count_21_CEINV_3830 : STD_LOGIC; 
  signal hv_count_13_FFY_RST : STD_LOGIC; 
  signal hv_count_13_FFX_RST : STD_LOGIC; 
  signal hv_count_13_DXMUX_3903 : STD_LOGIC; 
  signal hv_count_13_DYMUX_3887 : STD_LOGIC; 
  signal hv_count_13_SRINVNOT : STD_LOGIC; 
  signal hv_count_13_CLKINV_3877 : STD_LOGIC; 
  signal hv_count_13_CEINV_3876 : STD_LOGIC; 
  signal hv_count_23_FFY_RST : STD_LOGIC; 
  signal hv_count_23_FFX_RST : STD_LOGIC; 
  signal hv_count_23_DXMUX_3949 : STD_LOGIC; 
  signal hv_count_23_DYMUX_3933 : STD_LOGIC; 
  signal hv_count_23_SRINVNOT : STD_LOGIC; 
  signal hv_count_23_CLKINV_3923 : STD_LOGIC; 
  signal hv_count_23_CEINV_3922 : STD_LOGIC; 
  signal hv_count_15_FFX_RST : STD_LOGIC; 
  signal hv_count_15_DXMUX_3995 : STD_LOGIC; 
  signal hv_count_15_DYMUX_3979 : STD_LOGIC; 
  signal hv_count_15_SRINVNOT : STD_LOGIC; 
  signal hv_count_15_CLKINV_3969 : STD_LOGIC; 
  signal hv_count_15_CEINV_3968 : STD_LOGIC; 
  signal wg_count_11_DXMUX_4041 : STD_LOGIC; 
  signal wg_count_11_DYMUX_4025 : STD_LOGIC; 
  signal wg_count_11_SRINVNOT : STD_LOGIC; 
  signal wg_count_11_CLKINV_4015 : STD_LOGIC; 
  signal wg_count_11_CEINV_4014 : STD_LOGIC; 
  signal ops_mode_not0001 : STD_LOGIC; 
  signal state_FSM_FFd1_DYMUX_4068 : STD_LOGIC; 
  signal state_FSM_FFd1_In : STD_LOGIC; 
  signal state_FSM_FFd1_CLKINV_4058 : STD_LOGIC; 
  signal hv_count_17_DXMUX_4122 : STD_LOGIC; 
  signal hv_count_17_DYMUX_4106 : STD_LOGIC; 
  signal hv_count_17_SRINVNOT : STD_LOGIC; 
  signal hv_count_17_CLKINV_4096 : STD_LOGIC; 
  signal hv_count_17_CEINV_4095 : STD_LOGIC; 
  signal wg_dly_DXMUX_4169 : STD_LOGIC; 
  signal wg_dly_FXMUX_4168 : STD_LOGIC; 
  signal wg_count_enable_not0001 : STD_LOGIC; 
  signal wg_dly_DYMUX_4152 : STD_LOGIC; 
  signal wg_dly_SRINVNOT : STD_LOGIC; 
  signal wg_dly_CLKINV_4142 : STD_LOGIC; 
  signal wg_dly_CEINV_4141 : STD_LOGIC; 
  signal wg_count_13_DXMUX_4215 : STD_LOGIC; 
  signal wg_count_13_DYMUX_4199 : STD_LOGIC; 
  signal wg_count_13_SRINVNOT : STD_LOGIC; 
  signal wg_count_13_CLKINV_4189 : STD_LOGIC; 
  signal wg_count_13_CEINV_4188 : STD_LOGIC; 
  signal hv_count_19_DXMUX_4261 : STD_LOGIC; 
  signal hv_count_19_DYMUX_4245 : STD_LOGIC; 
  signal hv_count_19_SRINVNOT : STD_LOGIC; 
  signal hv_count_19_CLKINV_4235 : STD_LOGIC; 
  signal hv_count_19_CEINV_4234 : STD_LOGIC; 
  signal wg_count_15_DXMUX_4307 : STD_LOGIC; 
  signal wg_count_15_DYMUX_4291 : STD_LOGIC; 
  signal wg_count_15_SRINVNOT : STD_LOGIC; 
  signal wg_count_15_CLKINV_4281 : STD_LOGIC; 
  signal wg_count_15_CEINV_4280 : STD_LOGIC; 
  signal wg_count_17_DXMUX_4353 : STD_LOGIC; 
  signal wg_count_17_DYMUX_4337 : STD_LOGIC; 
  signal wg_count_17_SRINVNOT : STD_LOGIC; 
  signal wg_count_17_CLKINV_4327 : STD_LOGIC; 
  signal wg_count_17_CEINV_4326 : STD_LOGIC; 
  signal ems_tx_count_2_DXMUX_4396 : STD_LOGIC; 
  signal ems_tx_count_2_DYMUX_4382 : STD_LOGIC; 
  signal ems_tx_count_2_SRINVNOT : STD_LOGIC; 
  signal ems_tx_count_2_CLKINV_4372 : STD_LOGIC; 
  signal end_cycle_DYMUX_4419 : STD_LOGIC; 
  signal end_cycle_and0000 : STD_LOGIC; 
  signal end_cycle_CLKINV_4408 : STD_LOGIC; 
  signal wg_count_19_DXMUX_4464 : STD_LOGIC; 
  signal wg_count_19_DYMUX_4448 : STD_LOGIC; 
  signal wg_count_19_SRINVNOT : STD_LOGIC; 
  signal wg_count_19_CLKINV_4438 : STD_LOGIC; 
  signal wg_count_19_CEINV_4437 : STD_LOGIC; 
  signal mod_pulse_error_DXMUX_4507 : STD_LOGIC; 
  signal mod_pulse_error_and0000 : STD_LOGIC; 
  signal mod_pulse_error_DYMUX_4493 : STD_LOGIC; 
  signal ems_1_error_or0000 : STD_LOGIC; 
  signal mod_pulse_error_SRINVNOT : STD_LOGIC; 
  signal mod_pulse_error_CLKINV_4483 : STD_LOGIC; 
  signal EMS_OUT_4_OBUF_4546 : STD_LOGIC; 
  signal ems_tx_count_enable_DYMUX_4535 : STD_LOGIC; 
  signal ems_tx_count_enable_and0000 : STD_LOGIC; 
  signal ems_tx_count_enable_CLKINV_4526 : STD_LOGIC; 
  signal hv_count_1_DXMUX_4587 : STD_LOGIC; 
  signal hv_count_1_DYMUX_4571 : STD_LOGIC; 
  signal hv_count_1_SRINVNOT : STD_LOGIC; 
  signal hv_count_1_CLKINV_4561 : STD_LOGIC; 
  signal hv_count_1_CEINV_4560 : STD_LOGIC; 
  signal hv_count_3_DXMUX_4633 : STD_LOGIC; 
  signal hv_count_3_DYMUX_4617 : STD_LOGIC; 
  signal hv_count_3_SRINVNOT : STD_LOGIC; 
  signal hv_count_3_CLKINV_4607 : STD_LOGIC; 
  signal hv_count_3_CEINV_4606 : STD_LOGIC; 
  signal wg_count_1_DXMUX_4679 : STD_LOGIC; 
  signal wg_count_1_DYMUX_4663 : STD_LOGIC; 
  signal wg_count_1_SRINVNOT : STD_LOGIC; 
  signal wg_count_1_CLKINV_4653 : STD_LOGIC; 
  signal wg_count_1_CEINV_4652 : STD_LOGIC; 
  signal hv_count_5_DXMUX_4725 : STD_LOGIC; 
  signal hv_count_5_DYMUX_4709 : STD_LOGIC; 
  signal hv_count_5_SRINVNOT : STD_LOGIC; 
  signal hv_count_5_CLKINV_4699 : STD_LOGIC; 
  signal hv_count_5_CEINV_4698 : STD_LOGIC; 
  signal wg_count_3_DXMUX_4771 : STD_LOGIC; 
  signal wg_count_3_DYMUX_4755 : STD_LOGIC; 
  signal wg_count_3_SRINVNOT : STD_LOGIC; 
  signal wg_count_3_CLKINV_4745 : STD_LOGIC; 
  signal wg_count_3_CEINV_4744 : STD_LOGIC; 
  signal hv_count_7_DXMUX_4817 : STD_LOGIC; 
  signal hv_count_7_DYMUX_4801 : STD_LOGIC; 
  signal hv_count_7_SRINVNOT : STD_LOGIC; 
  signal hv_count_7_CLKINV_4791 : STD_LOGIC; 
  signal hv_count_7_CEINV_4790 : STD_LOGIC; 
  signal wg_count_5_DXMUX_4863 : STD_LOGIC; 
  signal wg_count_5_DYMUX_4847 : STD_LOGIC; 
  signal wg_count_5_SRINVNOT : STD_LOGIC; 
  signal wg_count_5_CLKINV_4837 : STD_LOGIC; 
  signal wg_count_5_CEINV_4836 : STD_LOGIC; 
  signal hv_count_9_DXMUX_4909 : STD_LOGIC; 
  signal hv_count_9_DYMUX_4893 : STD_LOGIC; 
  signal hv_count_9_SRINVNOT : STD_LOGIC; 
  signal hv_count_9_CLKINV_4883 : STD_LOGIC; 
  signal hv_count_9_CEINV_4882 : STD_LOGIC; 
  signal wg_count_7_FFX_RST : STD_LOGIC; 
  signal wg_count_7_DXMUX_4955 : STD_LOGIC; 
  signal wg_count_7_DYMUX_4939 : STD_LOGIC; 
  signal wg_count_7_SRINVNOT : STD_LOGIC; 
  signal wg_count_7_CLKINV_4929 : STD_LOGIC; 
  signal wg_count_7_CEINV_4928 : STD_LOGIC; 
  signal wg_count_9_FFY_RST : STD_LOGIC; 
  signal wg_count_9_FFX_RST : STD_LOGIC; 
  signal wg_count_9_DXMUX_5001 : STD_LOGIC; 
  signal wg_count_9_DYMUX_4985 : STD_LOGIC; 
  signal wg_count_9_SRINVNOT : STD_LOGIC; 
  signal wg_count_9_CLKINV_4975 : STD_LOGIC; 
  signal wg_count_9_CEINV_4974 : STD_LOGIC; 
  signal ems_tx_count_4_FFX_RST : STD_LOGIC; 
  signal ems_tx_count_4_DXMUX_5037 : STD_LOGIC; 
  signal Madd_ems_tx_count_addsub0000_cy_2_pack_2 : STD_LOGIC; 
  signal ems_tx_count_4_CLKINV_5020 : STD_LOGIC; 
  signal l_rx_dly_FFY_RST : STD_LOGIC; 
  signal l_rx_dly_DYMUX_5051 : STD_LOGIC; 
  signal l_rx_dly_CLKINV_5048 : STD_LOGIC; 
  signal EMS_OUT_7_OBUF_5079 : STD_LOGIC; 
  signal N01_pack_1 : STD_LOGIC; 
  signal N261 : STD_LOGIC; 
  signal ems_1_rx_stat_or0000_pack_1 : STD_LOGIC; 
  signal ems_67_error_or00005_5127 : STD_LOGIC; 
  signal ems_error_prt_or000040_5120 : STD_LOGIC; 
  signal ems_45_error_or000087_5151 : STD_LOGIC; 
  signal ems_45_error_or000046_pack_1 : STD_LOGIC; 
  signal count_enable_DYMUX_5163 : STD_LOGIC; 
  signal count_enable_CLKINV_5160 : STD_LOGIC; 
  signal count_enable_CEINV_5159 : STD_LOGIC; 
  signal ems_rx_count_3_DXMUX_5198 : STD_LOGIC; 
  signal rx_dly_not0001_pack_2 : STD_LOGIC; 
  signal ems_rx_count_3_CLKINV_5181 : STD_LOGIC; 
  signal ems_45_error_or00005_5226 : STD_LOGIC; 
  signal ems_1_error_or00002_5219 : STD_LOGIC; 
  signal ems_tx_count_3_DXMUX_5257 : STD_LOGIC; 
  signal tx_dly_not0001_pack_2 : STD_LOGIC; 
  signal ems_tx_count_3_CLKINV_5240 : STD_LOGIC; 
  signal WG_SW_CTRL_NOISE_OBUF_5285 : STD_LOGIC; 
  signal ems_2_error_or000015_5277 : STD_LOGIC; 
  signal N10 : STD_LOGIC; 
  signal N9 : STD_LOGIC; 
  signal hv_dly_DYMUX_5321 : STD_LOGIC; 
  signal hv_dly_CLKINV_5318 : STD_LOGIC; 
  signal hv_dly_CEINV_5317 : STD_LOGIC; 
  signal N22 : STD_LOGIC; 
  signal N36_pack_1 : STD_LOGIC; 
  signal ems_45_error_or000031 : STD_LOGIC; 
  signal state_FSM_FFd2_In2_5366 : STD_LOGIC; 
  signal ems_3_error_or000017_5398 : STD_LOGIC; 
  signal state_FSM_FFd2_In24_5391 : STD_LOGIC; 
  signal MOD_PULSE_HMC_OBUF_5422 : STD_LOGIC; 
  signal N24 : STD_LOGIC; 
  signal ems_error_prt_or000063_5446 : STD_LOGIC; 
  signal N12_pack_1 : STD_LOGIC; 
  signal tx_dly_DYMUX_5458 : STD_LOGIC; 
  signal tx_dly_CLKINV_5455 : STD_LOGIC; 
  signal tx_dly_CEINV_5454 : STD_LOGIC; 
  signal ems_error_prt_or0000118_5475 : STD_LOGIC; 
  signal ems_rx_count_4_DXMUX_5506 : STD_LOGIC; 
  signal Madd_ems_rx_count_addsub0000_cy_2_pack_2 : STD_LOGIC; 
  signal ems_rx_count_4_CLKINV_5489 : STD_LOGIC; 
  signal EMS_OUT_2_OBUF_5534 : STD_LOGIC; 
  signal N5 : STD_LOGIC; 
  signal l_ems_trig_DYMUX_5544 : STD_LOGIC; 
  signal l_ems_trig_CLKINV_5541 : STD_LOGIC; 
  signal l_tx_dly_DYMUX_5558 : STD_LOGIC; 
  signal l_tx_dly_CLKINV_5555 : STD_LOGIC; 
  signal ems_error_prt_or000086_5586 : STD_LOGIC; 
  signal N20_pack_1 : STD_LOGIC; 
  signal hv_count_not0002 : STD_LOGIC; 
  signal count_enable_not0001 : STD_LOGIC; 
  signal ems_67_error_or000087_5634 : STD_LOGIC; 
  signal ems_67_error_or000046_pack_1 : STD_LOGIC; 
  signal ems_tx_stat21_5658 : STD_LOGIC; 
  signal EMS_OUT_2_mux0004_pack_1 : STD_LOGIC; 
  signal l_rx_gate_DYMUX_5668 : STD_LOGIC; 
  signal l_rx_gate_CLKINV_5665 : STD_LOGIC; 
  signal EMS_OUT_1_OBUF_5696 : STD_LOGIC; 
  signal WG_SW_CTRL_TERM_OBUF_pack_1 : STD_LOGIC; 
  signal state_FSM_FFd1_In14_5720 : STD_LOGIC; 
  signal state_cmp_eq0000_pack_1 : STD_LOGIC; 
  signal rx_dly_DYMUX_5732 : STD_LOGIC; 
  signal rx_dly_CLKINV_5729 : STD_LOGIC; 
  signal rx_dly_CEINV_5728 : STD_LOGIC; 
  signal WG_SW_ERROR_OBUF_5749 : STD_LOGIC; 
  signal OPS_MODE_730_0_IFF_ICLK1INVNOT : STD_LOGIC; 
  signal OPS_MODE_730_0_IFF_IDDRIN_MUX_2936 : STD_LOGIC; 
  signal OPS_MODE_730_1_IFF_ICLK1INVNOT : STD_LOGIC; 
  signal OPS_MODE_730_1_IFF_IDDRIN_MUX_2951 : STD_LOGIC; 
  signal OPS_MODE_730_2_IFF_ICLK1INVNOT : STD_LOGIC; 
  signal OPS_MODE_730_2_IFF_IDDRIN_MUX_2973 : STD_LOGIC; 
  signal ems_tx_error_FFX_RSTAND_3203 : STD_LOGIC; 
  signal ems_tx_count_0_FFX_RSTAND_3238 : STD_LOGIC; 
  signal wg_count_enable_FFX_SET : STD_LOGIC; 
  signal ems_rx_count_0_FFX_RSTAND_3310 : STD_LOGIC; 
  signal ems_2_error_FFX_RSTAND_3417 : STD_LOGIC; 
  signal state_FSM_FFd2_FFX_RSTAND_3500 : STD_LOGIC; 
  signal ems_45_error_FFX_RSTAND_3535 : STD_LOGIC; 
  signal ems_error_prt_FFX_RSTAND_3570 : STD_LOGIC; 
  signal ems_67_error_FFX_RSTAND_3605 : STD_LOGIC; 
  signal ems_3_error_FFX_RSTAND_3640 : STD_LOGIC; 
  signal state_FSM_FFd1_FFY_RSTAND_4073 : STD_LOGIC; 
  signal end_cycle_FFY_RSTAND_4424 : STD_LOGIC; 
  signal ems_tx_count_enable_FFY_RSTAND_4540 : STD_LOGIC; 
  signal count_enable_FFY_SET : STD_LOGIC; 
  signal ems_rx_count_3_FFX_RSTAND_5203 : STD_LOGIC; 
  signal ems_tx_count_3_FFX_RSTAND_5262 : STD_LOGIC; 
  signal hv_dly_FFY_RSTAND_5327 : STD_LOGIC; 
  signal tx_dly_FFY_RSTAND_5464 : STD_LOGIC; 
  signal ems_rx_count_4_FFX_RSTAND_5511 : STD_LOGIC; 
  signal l_ems_trig_FFY_RSTAND_5549 : STD_LOGIC; 
  signal l_tx_dly_FFY_RSTAND_5563 : STD_LOGIC; 
  signal l_rx_gate_FFY_RSTAND_5673 : STD_LOGIC; 
  signal rx_dly_FFY_RSTAND_5738 : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal NlwInverterSignal_ops_mode_0_CLK : STD_LOGIC; 
  signal NlwInverterSignal_ops_mode_1_CLK : STD_LOGIC; 
  signal NlwInverterSignal_ops_mode_2_CLK : STD_LOGIC; 
  signal hv_count : STD_LOGIC_VECTOR ( 23 downto 0 ); 
  signal hv_count_addsub0000 : STD_LOGIC_VECTOR ( 23 downto 0 ); 
  signal wg_count : STD_LOGIC_VECTOR ( 20 downto 0 ); 
  signal wg_count_addsub0000 : STD_LOGIC_VECTOR ( 20 downto 0 ); 
  signal Madd_wg_count_addsub0000_cy : STD_LOGIC_VECTOR ( 18 downto 0 ); 
  signal ops_mode : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal ems_tx_count : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal ems_rx_count : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal Madd_ems_tx_count_addsub0000_cy : STD_LOGIC_VECTOR ( 2 downto 2 ); 
  signal Madd_ems_rx_count_addsub0000_cy : STD_LOGIC_VECTOR ( 2 downto 2 ); 
  signal Madd_hv_count_addsub0000_lut : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal count_enable_cmp_eq0000_wg_lut : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal count_enable_cmp_eq0000_wg_cy : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal Madd_wg_count_addsub0000_lut : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal wg_dly_cmp_eq0000_wg_lut : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal wg_dly_cmp_eq0000_wg_cy : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal ems_tx_count_mux0002 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal ems_rx_count_mux0002 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal hv_count_mux0000 : STD_LOGIC_VECTOR ( 23 downto 0 ); 
  signal wg_count_mux0000 : STD_LOGIC_VECTOR ( 20 downto 0 ); 
begin
  hv_count_addsub0000_0_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y14"
    )
    port map (
      O => hv_count_addsub0000_0_LOGIC_ZERO_1659
    );
  hv_count_addsub0000_0_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X3Y14"
    )
    port map (
      O => hv_count_addsub0000_0_LOGIC_ONE_1676
    );
  hv_count_addsub0000_0_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_0_XORF_1677,
      O => hv_count_addsub0000(0)
    );
  hv_count_addsub0000_0_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y14"
    )
    port map (
      I0 => hv_count_addsub0000_0_CYINIT_1675,
      I1 => Madd_hv_count_addsub0000_lut(0),
      O => hv_count_addsub0000_0_XORF_1677
    );
  hv_count_addsub0000_0_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y14"
    )
    port map (
      IA => hv_count_addsub0000_0_LOGIC_ONE_1676,
      IB => hv_count_addsub0000_0_CYINIT_1675,
      SEL => hv_count_addsub0000_0_CYSELF_1666,
      O => Madd_hv_count_addsub0000_cy_0_Q
    );
  hv_count_addsub0000_0_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_0_BXINV_1664,
      O => hv_count_addsub0000_0_CYINIT_1675
    );
  hv_count_addsub0000_0_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_lut(0),
      O => hv_count_addsub0000_0_CYSELF_1666
    );
  hv_count_addsub0000_0_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X3Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => '0',
      O => hv_count_addsub0000_0_BXINV_1664
    );
  hv_count_addsub0000_0_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_0_XORG_1662,
      O => hv_count_addsub0000(1)
    );
  hv_count_addsub0000_0_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y14"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_0_Q,
      I1 => hv_count_addsub0000_0_G,
      O => hv_count_addsub0000_0_XORG_1662
    );
  hv_count_addsub0000_0_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_0_CYMUXG_1661,
      O => Madd_hv_count_addsub0000_cy_1_Q
    );
  hv_count_addsub0000_0_CYMUXG : X_MUX2
    generic map(
      LOC => "SLICE_X3Y14"
    )
    port map (
      IA => hv_count_addsub0000_0_LOGIC_ZERO_1659,
      IB => Madd_hv_count_addsub0000_cy_0_Q,
      SEL => hv_count_addsub0000_0_CYSELG_1650,
      O => hv_count_addsub0000_0_CYMUXG_1661
    );
  hv_count_addsub0000_0_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X3Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_0_G,
      O => hv_count_addsub0000_0_CYSELG_1650
    );
  hv_count_addsub0000_2_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y15"
    )
    port map (
      O => hv_count_addsub0000_2_LOGIC_ZERO_1695
    );
  hv_count_addsub0000_2_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_2_XORF_1715,
      O => hv_count_addsub0000(2)
    );
  hv_count_addsub0000_2_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y15"
    )
    port map (
      I0 => hv_count_addsub0000_2_CYINIT_1714,
      I1 => hv_count_addsub0000_2_F,
      O => hv_count_addsub0000_2_XORF_1715
    );
  hv_count_addsub0000_2_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y15"
    )
    port map (
      IA => hv_count_addsub0000_2_LOGIC_ZERO_1695,
      IB => hv_count_addsub0000_2_CYINIT_1714,
      SEL => hv_count_addsub0000_2_CYSELF_1701,
      O => Madd_hv_count_addsub0000_cy_2_Q
    );
  hv_count_addsub0000_2_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y15"
    )
    port map (
      IA => hv_count_addsub0000_2_LOGIC_ZERO_1695,
      IB => hv_count_addsub0000_2_LOGIC_ZERO_1695,
      SEL => hv_count_addsub0000_2_CYSELF_1701,
      O => hv_count_addsub0000_2_CYMUXF2_1696
    );
  hv_count_addsub0000_2_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_1_Q,
      O => hv_count_addsub0000_2_CYINIT_1714
    );
  hv_count_addsub0000_2_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_2_F,
      O => hv_count_addsub0000_2_CYSELF_1701
    );
  hv_count_addsub0000_2_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_2_XORG_1703,
      O => hv_count_addsub0000(3)
    );
  hv_count_addsub0000_2_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y15"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_2_Q,
      I1 => hv_count_addsub0000_2_G,
      O => hv_count_addsub0000_2_XORG_1703
    );
  hv_count_addsub0000_2_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_2_CYMUXFAST_1700,
      O => Madd_hv_count_addsub0000_cy_3_Q
    );
  hv_count_addsub0000_2_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X3Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_1_Q,
      O => hv_count_addsub0000_2_FASTCARRY_1698
    );
  hv_count_addsub0000_2_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X3Y15"
    )
    port map (
      I0 => hv_count_addsub0000_2_CYSELG_1686,
      I1 => hv_count_addsub0000_2_CYSELF_1701,
      O => hv_count_addsub0000_2_CYAND_1699
    );
  hv_count_addsub0000_2_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X3Y15"
    )
    port map (
      IA => hv_count_addsub0000_2_CYMUXG2_1697,
      IB => hv_count_addsub0000_2_FASTCARRY_1698,
      SEL => hv_count_addsub0000_2_CYAND_1699,
      O => hv_count_addsub0000_2_CYMUXFAST_1700
    );
  hv_count_addsub0000_2_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y15"
    )
    port map (
      IA => hv_count_addsub0000_2_LOGIC_ZERO_1695,
      IB => hv_count_addsub0000_2_CYMUXF2_1696,
      SEL => hv_count_addsub0000_2_CYSELG_1686,
      O => hv_count_addsub0000_2_CYMUXG2_1697
    );
  hv_count_addsub0000_2_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X3Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_2_G,
      O => hv_count_addsub0000_2_CYSELG_1686
    );
  hv_count_addsub0000_4_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y16"
    )
    port map (
      O => hv_count_addsub0000_4_LOGIC_ZERO_1733
    );
  hv_count_addsub0000_4_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_4_XORF_1753,
      O => hv_count_addsub0000(4)
    );
  hv_count_addsub0000_4_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y16"
    )
    port map (
      I0 => hv_count_addsub0000_4_CYINIT_1752,
      I1 => hv_count_addsub0000_4_F,
      O => hv_count_addsub0000_4_XORF_1753
    );
  hv_count_addsub0000_4_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y16"
    )
    port map (
      IA => hv_count_addsub0000_4_LOGIC_ZERO_1733,
      IB => hv_count_addsub0000_4_CYINIT_1752,
      SEL => hv_count_addsub0000_4_CYSELF_1739,
      O => Madd_hv_count_addsub0000_cy_4_Q
    );
  hv_count_addsub0000_4_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y16"
    )
    port map (
      IA => hv_count_addsub0000_4_LOGIC_ZERO_1733,
      IB => hv_count_addsub0000_4_LOGIC_ZERO_1733,
      SEL => hv_count_addsub0000_4_CYSELF_1739,
      O => hv_count_addsub0000_4_CYMUXF2_1734
    );
  hv_count_addsub0000_4_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_3_Q,
      O => hv_count_addsub0000_4_CYINIT_1752
    );
  hv_count_addsub0000_4_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_4_F,
      O => hv_count_addsub0000_4_CYSELF_1739
    );
  hv_count_addsub0000_4_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_4_XORG_1741,
      O => hv_count_addsub0000(5)
    );
  hv_count_addsub0000_4_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y16"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_4_Q,
      I1 => hv_count_addsub0000_4_G,
      O => hv_count_addsub0000_4_XORG_1741
    );
  hv_count_addsub0000_4_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_4_CYMUXFAST_1738,
      O => Madd_hv_count_addsub0000_cy_5_Q
    );
  hv_count_addsub0000_4_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X3Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_3_Q,
      O => hv_count_addsub0000_4_FASTCARRY_1736
    );
  hv_count_addsub0000_4_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X3Y16"
    )
    port map (
      I0 => hv_count_addsub0000_4_CYSELG_1724,
      I1 => hv_count_addsub0000_4_CYSELF_1739,
      O => hv_count_addsub0000_4_CYAND_1737
    );
  hv_count_addsub0000_4_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X3Y16"
    )
    port map (
      IA => hv_count_addsub0000_4_CYMUXG2_1735,
      IB => hv_count_addsub0000_4_FASTCARRY_1736,
      SEL => hv_count_addsub0000_4_CYAND_1737,
      O => hv_count_addsub0000_4_CYMUXFAST_1738
    );
  hv_count_addsub0000_4_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y16"
    )
    port map (
      IA => hv_count_addsub0000_4_LOGIC_ZERO_1733,
      IB => hv_count_addsub0000_4_CYMUXF2_1734,
      SEL => hv_count_addsub0000_4_CYSELG_1724,
      O => hv_count_addsub0000_4_CYMUXG2_1735
    );
  hv_count_addsub0000_4_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X3Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_4_G,
      O => hv_count_addsub0000_4_CYSELG_1724
    );
  hv_count_addsub0000_6_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y17"
    )
    port map (
      O => hv_count_addsub0000_6_LOGIC_ZERO_1771
    );
  hv_count_addsub0000_6_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_6_XORF_1791,
      O => hv_count_addsub0000(6)
    );
  hv_count_addsub0000_6_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y17"
    )
    port map (
      I0 => hv_count_addsub0000_6_CYINIT_1790,
      I1 => hv_count_addsub0000_6_F,
      O => hv_count_addsub0000_6_XORF_1791
    );
  hv_count_addsub0000_6_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y17"
    )
    port map (
      IA => hv_count_addsub0000_6_LOGIC_ZERO_1771,
      IB => hv_count_addsub0000_6_CYINIT_1790,
      SEL => hv_count_addsub0000_6_CYSELF_1777,
      O => Madd_hv_count_addsub0000_cy_6_Q
    );
  hv_count_addsub0000_6_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y17"
    )
    port map (
      IA => hv_count_addsub0000_6_LOGIC_ZERO_1771,
      IB => hv_count_addsub0000_6_LOGIC_ZERO_1771,
      SEL => hv_count_addsub0000_6_CYSELF_1777,
      O => hv_count_addsub0000_6_CYMUXF2_1772
    );
  hv_count_addsub0000_6_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_5_Q,
      O => hv_count_addsub0000_6_CYINIT_1790
    );
  hv_count_addsub0000_6_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_6_F,
      O => hv_count_addsub0000_6_CYSELF_1777
    );
  hv_count_addsub0000_6_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_6_XORG_1779,
      O => hv_count_addsub0000(7)
    );
  hv_count_addsub0000_6_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y17"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_6_Q,
      I1 => hv_count_addsub0000_6_G,
      O => hv_count_addsub0000_6_XORG_1779
    );
  hv_count_addsub0000_6_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_6_CYMUXFAST_1776,
      O => Madd_hv_count_addsub0000_cy_7_Q
    );
  hv_count_addsub0000_6_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X3Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_5_Q,
      O => hv_count_addsub0000_6_FASTCARRY_1774
    );
  hv_count_addsub0000_6_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X3Y17"
    )
    port map (
      I0 => hv_count_addsub0000_6_CYSELG_1762,
      I1 => hv_count_addsub0000_6_CYSELF_1777,
      O => hv_count_addsub0000_6_CYAND_1775
    );
  hv_count_addsub0000_6_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X3Y17"
    )
    port map (
      IA => hv_count_addsub0000_6_CYMUXG2_1773,
      IB => hv_count_addsub0000_6_FASTCARRY_1774,
      SEL => hv_count_addsub0000_6_CYAND_1775,
      O => hv_count_addsub0000_6_CYMUXFAST_1776
    );
  hv_count_addsub0000_6_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y17"
    )
    port map (
      IA => hv_count_addsub0000_6_LOGIC_ZERO_1771,
      IB => hv_count_addsub0000_6_CYMUXF2_1772,
      SEL => hv_count_addsub0000_6_CYSELG_1762,
      O => hv_count_addsub0000_6_CYMUXG2_1773
    );
  hv_count_addsub0000_6_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X3Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_6_G,
      O => hv_count_addsub0000_6_CYSELG_1762
    );
  hv_count_addsub0000_8_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y18"
    )
    port map (
      O => hv_count_addsub0000_8_LOGIC_ZERO_1809
    );
  hv_count_addsub0000_8_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_8_XORF_1829,
      O => hv_count_addsub0000(8)
    );
  hv_count_addsub0000_8_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y18"
    )
    port map (
      I0 => hv_count_addsub0000_8_CYINIT_1828,
      I1 => hv_count_addsub0000_8_F,
      O => hv_count_addsub0000_8_XORF_1829
    );
  hv_count_addsub0000_8_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y18"
    )
    port map (
      IA => hv_count_addsub0000_8_LOGIC_ZERO_1809,
      IB => hv_count_addsub0000_8_CYINIT_1828,
      SEL => hv_count_addsub0000_8_CYSELF_1815,
      O => Madd_hv_count_addsub0000_cy_8_Q
    );
  hv_count_addsub0000_8_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y18"
    )
    port map (
      IA => hv_count_addsub0000_8_LOGIC_ZERO_1809,
      IB => hv_count_addsub0000_8_LOGIC_ZERO_1809,
      SEL => hv_count_addsub0000_8_CYSELF_1815,
      O => hv_count_addsub0000_8_CYMUXF2_1810
    );
  hv_count_addsub0000_8_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_7_Q,
      O => hv_count_addsub0000_8_CYINIT_1828
    );
  hv_count_addsub0000_8_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_8_F,
      O => hv_count_addsub0000_8_CYSELF_1815
    );
  hv_count_addsub0000_8_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_8_XORG_1817,
      O => hv_count_addsub0000(9)
    );
  hv_count_addsub0000_8_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y18"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_8_Q,
      I1 => hv_count_addsub0000_8_G,
      O => hv_count_addsub0000_8_XORG_1817
    );
  hv_count_addsub0000_8_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_8_CYMUXFAST_1814,
      O => Madd_hv_count_addsub0000_cy_9_Q
    );
  hv_count_addsub0000_8_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X3Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_7_Q,
      O => hv_count_addsub0000_8_FASTCARRY_1812
    );
  hv_count_addsub0000_8_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X3Y18"
    )
    port map (
      I0 => hv_count_addsub0000_8_CYSELG_1800,
      I1 => hv_count_addsub0000_8_CYSELF_1815,
      O => hv_count_addsub0000_8_CYAND_1813
    );
  hv_count_addsub0000_8_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X3Y18"
    )
    port map (
      IA => hv_count_addsub0000_8_CYMUXG2_1811,
      IB => hv_count_addsub0000_8_FASTCARRY_1812,
      SEL => hv_count_addsub0000_8_CYAND_1813,
      O => hv_count_addsub0000_8_CYMUXFAST_1814
    );
  hv_count_addsub0000_8_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y18"
    )
    port map (
      IA => hv_count_addsub0000_8_LOGIC_ZERO_1809,
      IB => hv_count_addsub0000_8_CYMUXF2_1810,
      SEL => hv_count_addsub0000_8_CYSELG_1800,
      O => hv_count_addsub0000_8_CYMUXG2_1811
    );
  hv_count_addsub0000_8_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X3Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_8_G,
      O => hv_count_addsub0000_8_CYSELG_1800
    );
  hv_count_addsub0000_10_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y19"
    )
    port map (
      O => hv_count_addsub0000_10_LOGIC_ZERO_1847
    );
  hv_count_addsub0000_10_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_10_XORF_1867,
      O => hv_count_addsub0000(10)
    );
  hv_count_addsub0000_10_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y19"
    )
    port map (
      I0 => hv_count_addsub0000_10_CYINIT_1866,
      I1 => hv_count_addsub0000_10_F,
      O => hv_count_addsub0000_10_XORF_1867
    );
  hv_count_addsub0000_10_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y19"
    )
    port map (
      IA => hv_count_addsub0000_10_LOGIC_ZERO_1847,
      IB => hv_count_addsub0000_10_CYINIT_1866,
      SEL => hv_count_addsub0000_10_CYSELF_1853,
      O => Madd_hv_count_addsub0000_cy_10_Q
    );
  hv_count_addsub0000_10_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y19"
    )
    port map (
      IA => hv_count_addsub0000_10_LOGIC_ZERO_1847,
      IB => hv_count_addsub0000_10_LOGIC_ZERO_1847,
      SEL => hv_count_addsub0000_10_CYSELF_1853,
      O => hv_count_addsub0000_10_CYMUXF2_1848
    );
  hv_count_addsub0000_10_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_9_Q,
      O => hv_count_addsub0000_10_CYINIT_1866
    );
  hv_count_addsub0000_10_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_10_F,
      O => hv_count_addsub0000_10_CYSELF_1853
    );
  hv_count_addsub0000_10_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_10_XORG_1855,
      O => hv_count_addsub0000(11)
    );
  hv_count_addsub0000_10_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y19"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_10_Q,
      I1 => hv_count_addsub0000_10_G,
      O => hv_count_addsub0000_10_XORG_1855
    );
  hv_count_addsub0000_10_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_10_CYMUXFAST_1852,
      O => Madd_hv_count_addsub0000_cy_11_Q
    );
  hv_count_addsub0000_10_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X3Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_9_Q,
      O => hv_count_addsub0000_10_FASTCARRY_1850
    );
  hv_count_addsub0000_10_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X3Y19"
    )
    port map (
      I0 => hv_count_addsub0000_10_CYSELG_1838,
      I1 => hv_count_addsub0000_10_CYSELF_1853,
      O => hv_count_addsub0000_10_CYAND_1851
    );
  hv_count_addsub0000_10_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X3Y19"
    )
    port map (
      IA => hv_count_addsub0000_10_CYMUXG2_1849,
      IB => hv_count_addsub0000_10_FASTCARRY_1850,
      SEL => hv_count_addsub0000_10_CYAND_1851,
      O => hv_count_addsub0000_10_CYMUXFAST_1852
    );
  hv_count_addsub0000_10_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y19"
    )
    port map (
      IA => hv_count_addsub0000_10_LOGIC_ZERO_1847,
      IB => hv_count_addsub0000_10_CYMUXF2_1848,
      SEL => hv_count_addsub0000_10_CYSELG_1838,
      O => hv_count_addsub0000_10_CYMUXG2_1849
    );
  hv_count_addsub0000_10_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X3Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_10_G,
      O => hv_count_addsub0000_10_CYSELG_1838
    );
  hv_count_addsub0000_12_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y20"
    )
    port map (
      O => hv_count_addsub0000_12_LOGIC_ZERO_1885
    );
  hv_count_addsub0000_12_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_12_XORF_1905,
      O => hv_count_addsub0000(12)
    );
  hv_count_addsub0000_12_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y20"
    )
    port map (
      I0 => hv_count_addsub0000_12_CYINIT_1904,
      I1 => hv_count_addsub0000_12_F,
      O => hv_count_addsub0000_12_XORF_1905
    );
  hv_count_addsub0000_12_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y20"
    )
    port map (
      IA => hv_count_addsub0000_12_LOGIC_ZERO_1885,
      IB => hv_count_addsub0000_12_CYINIT_1904,
      SEL => hv_count_addsub0000_12_CYSELF_1891,
      O => Madd_hv_count_addsub0000_cy_12_Q
    );
  hv_count_addsub0000_12_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y20"
    )
    port map (
      IA => hv_count_addsub0000_12_LOGIC_ZERO_1885,
      IB => hv_count_addsub0000_12_LOGIC_ZERO_1885,
      SEL => hv_count_addsub0000_12_CYSELF_1891,
      O => hv_count_addsub0000_12_CYMUXF2_1886
    );
  hv_count_addsub0000_12_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_11_Q,
      O => hv_count_addsub0000_12_CYINIT_1904
    );
  hv_count_addsub0000_12_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_12_F,
      O => hv_count_addsub0000_12_CYSELF_1891
    );
  hv_count_addsub0000_12_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_12_XORG_1893,
      O => hv_count_addsub0000(13)
    );
  hv_count_addsub0000_12_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y20"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_12_Q,
      I1 => hv_count_addsub0000_12_G,
      O => hv_count_addsub0000_12_XORG_1893
    );
  hv_count_addsub0000_12_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_12_CYMUXFAST_1890,
      O => Madd_hv_count_addsub0000_cy_13_Q
    );
  hv_count_addsub0000_12_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X3Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_11_Q,
      O => hv_count_addsub0000_12_FASTCARRY_1888
    );
  hv_count_addsub0000_12_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X3Y20"
    )
    port map (
      I0 => hv_count_addsub0000_12_CYSELG_1876,
      I1 => hv_count_addsub0000_12_CYSELF_1891,
      O => hv_count_addsub0000_12_CYAND_1889
    );
  hv_count_addsub0000_12_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X3Y20"
    )
    port map (
      IA => hv_count_addsub0000_12_CYMUXG2_1887,
      IB => hv_count_addsub0000_12_FASTCARRY_1888,
      SEL => hv_count_addsub0000_12_CYAND_1889,
      O => hv_count_addsub0000_12_CYMUXFAST_1890
    );
  hv_count_addsub0000_12_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y20"
    )
    port map (
      IA => hv_count_addsub0000_12_LOGIC_ZERO_1885,
      IB => hv_count_addsub0000_12_CYMUXF2_1886,
      SEL => hv_count_addsub0000_12_CYSELG_1876,
      O => hv_count_addsub0000_12_CYMUXG2_1887
    );
  hv_count_addsub0000_12_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X3Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_12_G,
      O => hv_count_addsub0000_12_CYSELG_1876
    );
  hv_count_addsub0000_14_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y21"
    )
    port map (
      O => hv_count_addsub0000_14_LOGIC_ZERO_1923
    );
  hv_count_addsub0000_14_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_14_XORF_1943,
      O => hv_count_addsub0000(14)
    );
  hv_count_addsub0000_14_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y21"
    )
    port map (
      I0 => hv_count_addsub0000_14_CYINIT_1942,
      I1 => hv_count_addsub0000_14_F,
      O => hv_count_addsub0000_14_XORF_1943
    );
  hv_count_addsub0000_14_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y21"
    )
    port map (
      IA => hv_count_addsub0000_14_LOGIC_ZERO_1923,
      IB => hv_count_addsub0000_14_CYINIT_1942,
      SEL => hv_count_addsub0000_14_CYSELF_1929,
      O => Madd_hv_count_addsub0000_cy_14_Q
    );
  hv_count_addsub0000_14_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y21"
    )
    port map (
      IA => hv_count_addsub0000_14_LOGIC_ZERO_1923,
      IB => hv_count_addsub0000_14_LOGIC_ZERO_1923,
      SEL => hv_count_addsub0000_14_CYSELF_1929,
      O => hv_count_addsub0000_14_CYMUXF2_1924
    );
  hv_count_addsub0000_14_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_13_Q,
      O => hv_count_addsub0000_14_CYINIT_1942
    );
  hv_count_addsub0000_14_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_14_F,
      O => hv_count_addsub0000_14_CYSELF_1929
    );
  hv_count_addsub0000_14_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_14_XORG_1931,
      O => hv_count_addsub0000(15)
    );
  hv_count_addsub0000_14_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y21"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_14_Q,
      I1 => hv_count_addsub0000_14_G,
      O => hv_count_addsub0000_14_XORG_1931
    );
  hv_count_addsub0000_14_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_14_CYMUXFAST_1928,
      O => Madd_hv_count_addsub0000_cy_15_Q
    );
  hv_count_addsub0000_14_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X3Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_13_Q,
      O => hv_count_addsub0000_14_FASTCARRY_1926
    );
  hv_count_addsub0000_14_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X3Y21"
    )
    port map (
      I0 => hv_count_addsub0000_14_CYSELG_1914,
      I1 => hv_count_addsub0000_14_CYSELF_1929,
      O => hv_count_addsub0000_14_CYAND_1927
    );
  hv_count_addsub0000_14_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X3Y21"
    )
    port map (
      IA => hv_count_addsub0000_14_CYMUXG2_1925,
      IB => hv_count_addsub0000_14_FASTCARRY_1926,
      SEL => hv_count_addsub0000_14_CYAND_1927,
      O => hv_count_addsub0000_14_CYMUXFAST_1928
    );
  hv_count_addsub0000_14_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y21"
    )
    port map (
      IA => hv_count_addsub0000_14_LOGIC_ZERO_1923,
      IB => hv_count_addsub0000_14_CYMUXF2_1924,
      SEL => hv_count_addsub0000_14_CYSELG_1914,
      O => hv_count_addsub0000_14_CYMUXG2_1925
    );
  hv_count_addsub0000_14_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X3Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_14_G,
      O => hv_count_addsub0000_14_CYSELG_1914
    );
  hv_count_addsub0000_16_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y22"
    )
    port map (
      O => hv_count_addsub0000_16_LOGIC_ZERO_1961
    );
  hv_count_addsub0000_16_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_16_XORF_1981,
      O => hv_count_addsub0000(16)
    );
  hv_count_addsub0000_16_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y22"
    )
    port map (
      I0 => hv_count_addsub0000_16_CYINIT_1980,
      I1 => hv_count_addsub0000_16_F,
      O => hv_count_addsub0000_16_XORF_1981
    );
  hv_count_addsub0000_16_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y22"
    )
    port map (
      IA => hv_count_addsub0000_16_LOGIC_ZERO_1961,
      IB => hv_count_addsub0000_16_CYINIT_1980,
      SEL => hv_count_addsub0000_16_CYSELF_1967,
      O => Madd_hv_count_addsub0000_cy_16_Q
    );
  hv_count_addsub0000_16_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y22"
    )
    port map (
      IA => hv_count_addsub0000_16_LOGIC_ZERO_1961,
      IB => hv_count_addsub0000_16_LOGIC_ZERO_1961,
      SEL => hv_count_addsub0000_16_CYSELF_1967,
      O => hv_count_addsub0000_16_CYMUXF2_1962
    );
  hv_count_addsub0000_16_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_15_Q,
      O => hv_count_addsub0000_16_CYINIT_1980
    );
  hv_count_addsub0000_16_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_16_F,
      O => hv_count_addsub0000_16_CYSELF_1967
    );
  hv_count_addsub0000_16_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_16_XORG_1969,
      O => hv_count_addsub0000(17)
    );
  hv_count_addsub0000_16_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y22"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_16_Q,
      I1 => hv_count_addsub0000_16_G,
      O => hv_count_addsub0000_16_XORG_1969
    );
  hv_count_addsub0000_16_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_16_CYMUXFAST_1966,
      O => Madd_hv_count_addsub0000_cy_17_Q
    );
  hv_count_addsub0000_16_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X3Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_15_Q,
      O => hv_count_addsub0000_16_FASTCARRY_1964
    );
  hv_count_addsub0000_16_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X3Y22"
    )
    port map (
      I0 => hv_count_addsub0000_16_CYSELG_1952,
      I1 => hv_count_addsub0000_16_CYSELF_1967,
      O => hv_count_addsub0000_16_CYAND_1965
    );
  hv_count_addsub0000_16_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X3Y22"
    )
    port map (
      IA => hv_count_addsub0000_16_CYMUXG2_1963,
      IB => hv_count_addsub0000_16_FASTCARRY_1964,
      SEL => hv_count_addsub0000_16_CYAND_1965,
      O => hv_count_addsub0000_16_CYMUXFAST_1966
    );
  hv_count_addsub0000_16_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y22"
    )
    port map (
      IA => hv_count_addsub0000_16_LOGIC_ZERO_1961,
      IB => hv_count_addsub0000_16_CYMUXF2_1962,
      SEL => hv_count_addsub0000_16_CYSELG_1952,
      O => hv_count_addsub0000_16_CYMUXG2_1963
    );
  hv_count_addsub0000_16_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X3Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_16_G,
      O => hv_count_addsub0000_16_CYSELG_1952
    );
  hv_count_addsub0000_18_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y23"
    )
    port map (
      O => hv_count_addsub0000_18_LOGIC_ZERO_1999
    );
  hv_count_addsub0000_18_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_18_XORF_2019,
      O => hv_count_addsub0000(18)
    );
  hv_count_addsub0000_18_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y23"
    )
    port map (
      I0 => hv_count_addsub0000_18_CYINIT_2018,
      I1 => hv_count_addsub0000_18_F,
      O => hv_count_addsub0000_18_XORF_2019
    );
  hv_count_addsub0000_18_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y23"
    )
    port map (
      IA => hv_count_addsub0000_18_LOGIC_ZERO_1999,
      IB => hv_count_addsub0000_18_CYINIT_2018,
      SEL => hv_count_addsub0000_18_CYSELF_2005,
      O => Madd_hv_count_addsub0000_cy_18_Q
    );
  hv_count_addsub0000_18_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y23"
    )
    port map (
      IA => hv_count_addsub0000_18_LOGIC_ZERO_1999,
      IB => hv_count_addsub0000_18_LOGIC_ZERO_1999,
      SEL => hv_count_addsub0000_18_CYSELF_2005,
      O => hv_count_addsub0000_18_CYMUXF2_2000
    );
  hv_count_addsub0000_18_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_17_Q,
      O => hv_count_addsub0000_18_CYINIT_2018
    );
  hv_count_addsub0000_18_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_18_F,
      O => hv_count_addsub0000_18_CYSELF_2005
    );
  hv_count_addsub0000_18_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_18_XORG_2007,
      O => hv_count_addsub0000(19)
    );
  hv_count_addsub0000_18_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y23"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_18_Q,
      I1 => hv_count_addsub0000_18_G,
      O => hv_count_addsub0000_18_XORG_2007
    );
  hv_count_addsub0000_18_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_18_CYMUXFAST_2004,
      O => Madd_hv_count_addsub0000_cy_19_Q
    );
  hv_count_addsub0000_18_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X3Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_17_Q,
      O => hv_count_addsub0000_18_FASTCARRY_2002
    );
  hv_count_addsub0000_18_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X3Y23"
    )
    port map (
      I0 => hv_count_addsub0000_18_CYSELG_1990,
      I1 => hv_count_addsub0000_18_CYSELF_2005,
      O => hv_count_addsub0000_18_CYAND_2003
    );
  hv_count_addsub0000_18_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X3Y23"
    )
    port map (
      IA => hv_count_addsub0000_18_CYMUXG2_2001,
      IB => hv_count_addsub0000_18_FASTCARRY_2002,
      SEL => hv_count_addsub0000_18_CYAND_2003,
      O => hv_count_addsub0000_18_CYMUXFAST_2004
    );
  hv_count_addsub0000_18_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y23"
    )
    port map (
      IA => hv_count_addsub0000_18_LOGIC_ZERO_1999,
      IB => hv_count_addsub0000_18_CYMUXF2_2000,
      SEL => hv_count_addsub0000_18_CYSELG_1990,
      O => hv_count_addsub0000_18_CYMUXG2_2001
    );
  hv_count_addsub0000_18_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X3Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_18_G,
      O => hv_count_addsub0000_18_CYSELG_1990
    );
  hv_count_addsub0000_20_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y24"
    )
    port map (
      O => hv_count_addsub0000_20_LOGIC_ZERO_2037
    );
  hv_count_addsub0000_20_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_20_XORF_2057,
      O => hv_count_addsub0000(20)
    );
  hv_count_addsub0000_20_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y24"
    )
    port map (
      I0 => hv_count_addsub0000_20_CYINIT_2056,
      I1 => hv_count_addsub0000_20_F,
      O => hv_count_addsub0000_20_XORF_2057
    );
  hv_count_addsub0000_20_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y24"
    )
    port map (
      IA => hv_count_addsub0000_20_LOGIC_ZERO_2037,
      IB => hv_count_addsub0000_20_CYINIT_2056,
      SEL => hv_count_addsub0000_20_CYSELF_2043,
      O => Madd_hv_count_addsub0000_cy_20_Q
    );
  hv_count_addsub0000_20_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y24"
    )
    port map (
      IA => hv_count_addsub0000_20_LOGIC_ZERO_2037,
      IB => hv_count_addsub0000_20_LOGIC_ZERO_2037,
      SEL => hv_count_addsub0000_20_CYSELF_2043,
      O => hv_count_addsub0000_20_CYMUXF2_2038
    );
  hv_count_addsub0000_20_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_19_Q,
      O => hv_count_addsub0000_20_CYINIT_2056
    );
  hv_count_addsub0000_20_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_20_F,
      O => hv_count_addsub0000_20_CYSELF_2043
    );
  hv_count_addsub0000_20_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_20_XORG_2045,
      O => hv_count_addsub0000(21)
    );
  hv_count_addsub0000_20_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y24"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_20_Q,
      I1 => hv_count_addsub0000_20_G,
      O => hv_count_addsub0000_20_XORG_2045
    );
  hv_count_addsub0000_20_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X3Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_hv_count_addsub0000_cy_19_Q,
      O => hv_count_addsub0000_20_FASTCARRY_2040
    );
  hv_count_addsub0000_20_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X3Y24"
    )
    port map (
      I0 => hv_count_addsub0000_20_CYSELG_2028,
      I1 => hv_count_addsub0000_20_CYSELF_2043,
      O => hv_count_addsub0000_20_CYAND_2041
    );
  hv_count_addsub0000_20_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X3Y24"
    )
    port map (
      IA => hv_count_addsub0000_20_CYMUXG2_2039,
      IB => hv_count_addsub0000_20_FASTCARRY_2040,
      SEL => hv_count_addsub0000_20_CYAND_2041,
      O => hv_count_addsub0000_20_CYMUXFAST_2042
    );
  hv_count_addsub0000_20_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X3Y24"
    )
    port map (
      IA => hv_count_addsub0000_20_LOGIC_ZERO_2037,
      IB => hv_count_addsub0000_20_CYMUXF2_2038,
      SEL => hv_count_addsub0000_20_CYSELG_2028,
      O => hv_count_addsub0000_20_CYMUXG2_2039
    );
  hv_count_addsub0000_20_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X3Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_20_G,
      O => hv_count_addsub0000_20_CYSELG_2028
    );
  hv_count_addsub0000_22_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X3Y25"
    )
    port map (
      O => hv_count_addsub0000_22_LOGIC_ZERO_2087
    );
  hv_count_addsub0000_22_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_22_XORF_2088,
      O => hv_count_addsub0000(22)
    );
  hv_count_addsub0000_22_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X3Y25"
    )
    port map (
      I0 => hv_count_addsub0000_22_CYINIT_2086,
      I1 => hv_count_addsub0000_22_F,
      O => hv_count_addsub0000_22_XORF_2088
    );
  hv_count_addsub0000_22_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X3Y25"
    )
    port map (
      IA => hv_count_addsub0000_22_LOGIC_ZERO_2087,
      IB => hv_count_addsub0000_22_CYINIT_2086,
      SEL => hv_count_addsub0000_22_CYSELF_2077,
      O => Madd_hv_count_addsub0000_cy_22_Q
    );
  hv_count_addsub0000_22_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X3Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_20_CYMUXFAST_2042,
      O => hv_count_addsub0000_22_CYINIT_2086
    );
  hv_count_addsub0000_22_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X3Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_22_F,
      O => hv_count_addsub0000_22_CYSELF_2077
    );
  hv_count_addsub0000_22_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X3Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_addsub0000_22_XORG_2074,
      O => hv_count_addsub0000(23)
    );
  hv_count_addsub0000_22_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X3Y25"
    )
    port map (
      I0 => Madd_hv_count_addsub0000_cy_22_Q,
      I1 => hv_count_23_rt_2071,
      O => hv_count_addsub0000_22_XORG_2074
    );
  count_enable_cmp_eq0000_wg_cy_1_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X1Y19"
    )
    port map (
      O => count_enable_cmp_eq0000_wg_cy_1_LOGIC_ZERO_2107
    );
  count_enable_cmp_eq0000_wg_cy_1_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X1Y19"
    )
    port map (
      IA => count_enable_cmp_eq0000_wg_cy_1_LOGIC_ZERO_2107,
      IB => count_enable_cmp_eq0000_wg_cy_1_CYINIT_2118,
      SEL => count_enable_cmp_eq0000_wg_cy_1_CYSELF_2112,
      O => count_enable_cmp_eq0000_wg_cy(0)
    );
  count_enable_cmp_eq0000_wg_cy_1_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X1Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_cmp_eq0000_wg_cy_1_BXINV_2110,
      O => count_enable_cmp_eq0000_wg_cy_1_CYINIT_2118
    );
  count_enable_cmp_eq0000_wg_cy_1_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X1Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_cmp_eq0000_wg_lut(0),
      O => count_enable_cmp_eq0000_wg_cy_1_CYSELF_2112
    );
  count_enable_cmp_eq0000_wg_cy_1_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X1Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => '1',
      O => count_enable_cmp_eq0000_wg_cy_1_BXINV_2110
    );
  count_enable_cmp_eq0000_wg_cy_1_CYMUXG : X_MUX2
    generic map(
      LOC => "SLICE_X1Y19"
    )
    port map (
      IA => count_enable_cmp_eq0000_wg_cy_1_LOGIC_ZERO_2107,
      IB => count_enable_cmp_eq0000_wg_cy(0),
      SEL => count_enable_cmp_eq0000_wg_cy_1_CYSELG_2101,
      O => count_enable_cmp_eq0000_wg_cy_1_CYMUXG_2109
    );
  count_enable_cmp_eq0000_wg_cy_1_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X1Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_cmp_eq0000_wg_lut(1),
      O => count_enable_cmp_eq0000_wg_cy_1_CYSELG_2101
    );
  count_enable_cmp_eq0000_wg_cy_3_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X1Y20"
    )
    port map (
      O => count_enable_cmp_eq0000_wg_cy_3_LOGIC_ZERO_2136
    );
  count_enable_cmp_eq0000_wg_cy_3_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X1Y20"
    )
    port map (
      IA => count_enable_cmp_eq0000_wg_cy_3_LOGIC_ZERO_2136,
      IB => count_enable_cmp_eq0000_wg_cy_3_LOGIC_ZERO_2136,
      SEL => count_enable_cmp_eq0000_wg_cy_3_CYSELF_2142,
      O => count_enable_cmp_eq0000_wg_cy_3_CYMUXF2_2137
    );
  count_enable_cmp_eq0000_wg_cy_3_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X1Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_cmp_eq0000_wg_lut(2),
      O => count_enable_cmp_eq0000_wg_cy_3_CYSELF_2142
    );
  count_enable_cmp_eq0000_wg_cy_3_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X1Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_cmp_eq0000_wg_cy_1_CYMUXG_2109,
      O => count_enable_cmp_eq0000_wg_cy_3_FASTCARRY_2139
    );
  count_enable_cmp_eq0000_wg_cy_3_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X1Y20"
    )
    port map (
      I0 => count_enable_cmp_eq0000_wg_cy_3_CYSELG_2130,
      I1 => count_enable_cmp_eq0000_wg_cy_3_CYSELF_2142,
      O => count_enable_cmp_eq0000_wg_cy_3_CYAND_2140
    );
  count_enable_cmp_eq0000_wg_cy_3_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X1Y20"
    )
    port map (
      IA => count_enable_cmp_eq0000_wg_cy_3_CYMUXG2_2138,
      IB => count_enable_cmp_eq0000_wg_cy_3_FASTCARRY_2139,
      SEL => count_enable_cmp_eq0000_wg_cy_3_CYAND_2140,
      O => count_enable_cmp_eq0000_wg_cy_3_CYMUXFAST_2141
    );
  count_enable_cmp_eq0000_wg_cy_3_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X1Y20"
    )
    port map (
      IA => count_enable_cmp_eq0000_wg_cy_3_LOGIC_ZERO_2136,
      IB => count_enable_cmp_eq0000_wg_cy_3_CYMUXF2_2137,
      SEL => count_enable_cmp_eq0000_wg_cy_3_CYSELG_2130,
      O => count_enable_cmp_eq0000_wg_cy_3_CYMUXG2_2138
    );
  count_enable_cmp_eq0000_wg_cy_3_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X1Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_cmp_eq0000_wg_lut(3),
      O => count_enable_cmp_eq0000_wg_cy_3_CYSELG_2130
    );
  count_enable_cmp_eq0000_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X1Y21"
    )
    port map (
      O => count_enable_cmp_eq0000_LOGIC_ZERO_2166
    );
  count_enable_cmp_eq0000_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X1Y21"
    )
    port map (
      IA => count_enable_cmp_eq0000_LOGIC_ZERO_2166,
      IB => count_enable_cmp_eq0000_LOGIC_ZERO_2166,
      SEL => count_enable_cmp_eq0000_CYSELF_2172,
      O => count_enable_cmp_eq0000_CYMUXF2_2167
    );
  count_enable_cmp_eq0000_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X1Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_cmp_eq0000_wg_lut(4),
      O => count_enable_cmp_eq0000_CYSELF_2172
    );
  count_enable_cmp_eq0000_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X1Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_cmp_eq0000_CYMUXFAST_2171,
      O => count_enable_cmp_eq0000
    );
  count_enable_cmp_eq0000_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X1Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_cmp_eq0000_wg_cy_3_CYMUXFAST_2141,
      O => count_enable_cmp_eq0000_FASTCARRY_2169
    );
  count_enable_cmp_eq0000_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X1Y21"
    )
    port map (
      I0 => count_enable_cmp_eq0000_CYSELG_2160,
      I1 => count_enable_cmp_eq0000_CYSELF_2172,
      O => count_enable_cmp_eq0000_CYAND_2170
    );
  count_enable_cmp_eq0000_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X1Y21"
    )
    port map (
      IA => count_enable_cmp_eq0000_CYMUXG2_2168,
      IB => count_enable_cmp_eq0000_FASTCARRY_2169,
      SEL => count_enable_cmp_eq0000_CYAND_2170,
      O => count_enable_cmp_eq0000_CYMUXFAST_2171
    );
  count_enable_cmp_eq0000_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X1Y21"
    )
    port map (
      IA => count_enable_cmp_eq0000_LOGIC_ZERO_2166,
      IB => count_enable_cmp_eq0000_CYMUXF2_2167,
      SEL => count_enable_cmp_eq0000_CYSELG_2160,
      O => count_enable_cmp_eq0000_CYMUXG2_2168
    );
  count_enable_cmp_eq0000_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X1Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_cmp_eq0000_wg_lut(5),
      O => count_enable_cmp_eq0000_CYSELG_2160
    );
  wg_count_addsub0000_0_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X11Y0"
    )
    port map (
      O => wg_count_addsub0000_0_LOGIC_ZERO_2195
    );
  wg_count_addsub0000_0_LOGIC_ONE : X_ONE
    generic map(
      LOC => "SLICE_X11Y0"
    )
    port map (
      O => wg_count_addsub0000_0_LOGIC_ONE_2212
    );
  wg_count_addsub0000_0_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_0_XORF_2213,
      O => wg_count_addsub0000(0)
    );
  wg_count_addsub0000_0_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X11Y0"
    )
    port map (
      I0 => wg_count_addsub0000_0_CYINIT_2211,
      I1 => Madd_wg_count_addsub0000_lut(0),
      O => wg_count_addsub0000_0_XORF_2213
    );
  wg_count_addsub0000_0_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X11Y0"
    )
    port map (
      IA => wg_count_addsub0000_0_LOGIC_ONE_2212,
      IB => wg_count_addsub0000_0_CYINIT_2211,
      SEL => wg_count_addsub0000_0_CYSELF_2202,
      O => Madd_wg_count_addsub0000_cy(0)
    );
  wg_count_addsub0000_0_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X11Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_0_BXINV_2200,
      O => wg_count_addsub0000_0_CYINIT_2211
    );
  wg_count_addsub0000_0_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X11Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_lut(0),
      O => wg_count_addsub0000_0_CYSELF_2202
    );
  wg_count_addsub0000_0_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X11Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => '0',
      O => wg_count_addsub0000_0_BXINV_2200
    );
  wg_count_addsub0000_0_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_0_XORG_2198,
      O => wg_count_addsub0000(1)
    );
  wg_count_addsub0000_0_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X11Y0"
    )
    port map (
      I0 => Madd_wg_count_addsub0000_cy(0),
      I1 => wg_count_addsub0000_0_G,
      O => wg_count_addsub0000_0_XORG_2198
    );
  wg_count_addsub0000_0_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_0_CYMUXG_2197,
      O => Madd_wg_count_addsub0000_cy(1)
    );
  wg_count_addsub0000_0_CYMUXG : X_MUX2
    generic map(
      LOC => "SLICE_X11Y0"
    )
    port map (
      IA => wg_count_addsub0000_0_LOGIC_ZERO_2195,
      IB => Madd_wg_count_addsub0000_cy(0),
      SEL => wg_count_addsub0000_0_CYSELG_2186,
      O => wg_count_addsub0000_0_CYMUXG_2197
    );
  wg_count_addsub0000_0_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X11Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_0_G,
      O => wg_count_addsub0000_0_CYSELG_2186
    );
  wg_count_addsub0000_2_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X11Y1"
    )
    port map (
      O => wg_count_addsub0000_2_LOGIC_ZERO_2231
    );
  wg_count_addsub0000_2_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_2_XORF_2251,
      O => wg_count_addsub0000(2)
    );
  wg_count_addsub0000_2_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X11Y1"
    )
    port map (
      I0 => wg_count_addsub0000_2_CYINIT_2250,
      I1 => wg_count_addsub0000_2_F,
      O => wg_count_addsub0000_2_XORF_2251
    );
  wg_count_addsub0000_2_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X11Y1"
    )
    port map (
      IA => wg_count_addsub0000_2_LOGIC_ZERO_2231,
      IB => wg_count_addsub0000_2_CYINIT_2250,
      SEL => wg_count_addsub0000_2_CYSELF_2237,
      O => Madd_wg_count_addsub0000_cy(2)
    );
  wg_count_addsub0000_2_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y1"
    )
    port map (
      IA => wg_count_addsub0000_2_LOGIC_ZERO_2231,
      IB => wg_count_addsub0000_2_LOGIC_ZERO_2231,
      SEL => wg_count_addsub0000_2_CYSELF_2237,
      O => wg_count_addsub0000_2_CYMUXF2_2232
    );
  wg_count_addsub0000_2_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X11Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(1),
      O => wg_count_addsub0000_2_CYINIT_2250
    );
  wg_count_addsub0000_2_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X11Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_2_F,
      O => wg_count_addsub0000_2_CYSELF_2237
    );
  wg_count_addsub0000_2_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_2_XORG_2239,
      O => wg_count_addsub0000(3)
    );
  wg_count_addsub0000_2_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X11Y1"
    )
    port map (
      I0 => Madd_wg_count_addsub0000_cy(2),
      I1 => wg_count_addsub0000_2_G,
      O => wg_count_addsub0000_2_XORG_2239
    );
  wg_count_addsub0000_2_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_2_CYMUXFAST_2236,
      O => Madd_wg_count_addsub0000_cy(3)
    );
  wg_count_addsub0000_2_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X11Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(1),
      O => wg_count_addsub0000_2_FASTCARRY_2234
    );
  wg_count_addsub0000_2_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X11Y1"
    )
    port map (
      I0 => wg_count_addsub0000_2_CYSELG_2222,
      I1 => wg_count_addsub0000_2_CYSELF_2237,
      O => wg_count_addsub0000_2_CYAND_2235
    );
  wg_count_addsub0000_2_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X11Y1"
    )
    port map (
      IA => wg_count_addsub0000_2_CYMUXG2_2233,
      IB => wg_count_addsub0000_2_FASTCARRY_2234,
      SEL => wg_count_addsub0000_2_CYAND_2235,
      O => wg_count_addsub0000_2_CYMUXFAST_2236
    );
  wg_count_addsub0000_2_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y1"
    )
    port map (
      IA => wg_count_addsub0000_2_LOGIC_ZERO_2231,
      IB => wg_count_addsub0000_2_CYMUXF2_2232,
      SEL => wg_count_addsub0000_2_CYSELG_2222,
      O => wg_count_addsub0000_2_CYMUXG2_2233
    );
  wg_count_addsub0000_2_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X11Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_2_G,
      O => wg_count_addsub0000_2_CYSELG_2222
    );
  wg_count_addsub0000_4_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X11Y2"
    )
    port map (
      O => wg_count_addsub0000_4_LOGIC_ZERO_2269
    );
  wg_count_addsub0000_4_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_4_XORF_2289,
      O => wg_count_addsub0000(4)
    );
  wg_count_addsub0000_4_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X11Y2"
    )
    port map (
      I0 => wg_count_addsub0000_4_CYINIT_2288,
      I1 => wg_count_addsub0000_4_F,
      O => wg_count_addsub0000_4_XORF_2289
    );
  wg_count_addsub0000_4_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X11Y2"
    )
    port map (
      IA => wg_count_addsub0000_4_LOGIC_ZERO_2269,
      IB => wg_count_addsub0000_4_CYINIT_2288,
      SEL => wg_count_addsub0000_4_CYSELF_2275,
      O => Madd_wg_count_addsub0000_cy(4)
    );
  wg_count_addsub0000_4_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y2"
    )
    port map (
      IA => wg_count_addsub0000_4_LOGIC_ZERO_2269,
      IB => wg_count_addsub0000_4_LOGIC_ZERO_2269,
      SEL => wg_count_addsub0000_4_CYSELF_2275,
      O => wg_count_addsub0000_4_CYMUXF2_2270
    );
  wg_count_addsub0000_4_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X11Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(3),
      O => wg_count_addsub0000_4_CYINIT_2288
    );
  wg_count_addsub0000_4_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X11Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_4_F,
      O => wg_count_addsub0000_4_CYSELF_2275
    );
  wg_count_addsub0000_4_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_4_XORG_2277,
      O => wg_count_addsub0000(5)
    );
  wg_count_addsub0000_4_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X11Y2"
    )
    port map (
      I0 => Madd_wg_count_addsub0000_cy(4),
      I1 => wg_count_addsub0000_4_G,
      O => wg_count_addsub0000_4_XORG_2277
    );
  wg_count_addsub0000_4_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_4_CYMUXFAST_2274,
      O => Madd_wg_count_addsub0000_cy(5)
    );
  wg_count_addsub0000_4_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X11Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(3),
      O => wg_count_addsub0000_4_FASTCARRY_2272
    );
  wg_count_addsub0000_4_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X11Y2"
    )
    port map (
      I0 => wg_count_addsub0000_4_CYSELG_2260,
      I1 => wg_count_addsub0000_4_CYSELF_2275,
      O => wg_count_addsub0000_4_CYAND_2273
    );
  wg_count_addsub0000_4_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X11Y2"
    )
    port map (
      IA => wg_count_addsub0000_4_CYMUXG2_2271,
      IB => wg_count_addsub0000_4_FASTCARRY_2272,
      SEL => wg_count_addsub0000_4_CYAND_2273,
      O => wg_count_addsub0000_4_CYMUXFAST_2274
    );
  wg_count_addsub0000_4_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y2"
    )
    port map (
      IA => wg_count_addsub0000_4_LOGIC_ZERO_2269,
      IB => wg_count_addsub0000_4_CYMUXF2_2270,
      SEL => wg_count_addsub0000_4_CYSELG_2260,
      O => wg_count_addsub0000_4_CYMUXG2_2271
    );
  wg_count_addsub0000_4_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X11Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_4_G,
      O => wg_count_addsub0000_4_CYSELG_2260
    );
  wg_count_addsub0000_6_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X11Y3"
    )
    port map (
      O => wg_count_addsub0000_6_LOGIC_ZERO_2307
    );
  wg_count_addsub0000_6_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_6_XORF_2327,
      O => wg_count_addsub0000(6)
    );
  wg_count_addsub0000_6_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X11Y3"
    )
    port map (
      I0 => wg_count_addsub0000_6_CYINIT_2326,
      I1 => wg_count_addsub0000_6_F,
      O => wg_count_addsub0000_6_XORF_2327
    );
  wg_count_addsub0000_6_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X11Y3"
    )
    port map (
      IA => wg_count_addsub0000_6_LOGIC_ZERO_2307,
      IB => wg_count_addsub0000_6_CYINIT_2326,
      SEL => wg_count_addsub0000_6_CYSELF_2313,
      O => Madd_wg_count_addsub0000_cy(6)
    );
  wg_count_addsub0000_6_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y3"
    )
    port map (
      IA => wg_count_addsub0000_6_LOGIC_ZERO_2307,
      IB => wg_count_addsub0000_6_LOGIC_ZERO_2307,
      SEL => wg_count_addsub0000_6_CYSELF_2313,
      O => wg_count_addsub0000_6_CYMUXF2_2308
    );
  wg_count_addsub0000_6_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X11Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(5),
      O => wg_count_addsub0000_6_CYINIT_2326
    );
  wg_count_addsub0000_6_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X11Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_6_F,
      O => wg_count_addsub0000_6_CYSELF_2313
    );
  wg_count_addsub0000_6_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_6_XORG_2315,
      O => wg_count_addsub0000(7)
    );
  wg_count_addsub0000_6_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X11Y3"
    )
    port map (
      I0 => Madd_wg_count_addsub0000_cy(6),
      I1 => wg_count_addsub0000_6_G,
      O => wg_count_addsub0000_6_XORG_2315
    );
  wg_count_addsub0000_6_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_6_CYMUXFAST_2312,
      O => Madd_wg_count_addsub0000_cy(7)
    );
  wg_count_addsub0000_6_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X11Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(5),
      O => wg_count_addsub0000_6_FASTCARRY_2310
    );
  wg_count_addsub0000_6_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X11Y3"
    )
    port map (
      I0 => wg_count_addsub0000_6_CYSELG_2298,
      I1 => wg_count_addsub0000_6_CYSELF_2313,
      O => wg_count_addsub0000_6_CYAND_2311
    );
  wg_count_addsub0000_6_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X11Y3"
    )
    port map (
      IA => wg_count_addsub0000_6_CYMUXG2_2309,
      IB => wg_count_addsub0000_6_FASTCARRY_2310,
      SEL => wg_count_addsub0000_6_CYAND_2311,
      O => wg_count_addsub0000_6_CYMUXFAST_2312
    );
  wg_count_addsub0000_6_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y3"
    )
    port map (
      IA => wg_count_addsub0000_6_LOGIC_ZERO_2307,
      IB => wg_count_addsub0000_6_CYMUXF2_2308,
      SEL => wg_count_addsub0000_6_CYSELG_2298,
      O => wg_count_addsub0000_6_CYMUXG2_2309
    );
  wg_count_addsub0000_6_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X11Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_6_G,
      O => wg_count_addsub0000_6_CYSELG_2298
    );
  wg_count_addsub0000_8_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X11Y4"
    )
    port map (
      O => wg_count_addsub0000_8_LOGIC_ZERO_2345
    );
  wg_count_addsub0000_8_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_8_XORF_2365,
      O => wg_count_addsub0000(8)
    );
  wg_count_addsub0000_8_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X11Y4"
    )
    port map (
      I0 => wg_count_addsub0000_8_CYINIT_2364,
      I1 => wg_count_addsub0000_8_F,
      O => wg_count_addsub0000_8_XORF_2365
    );
  wg_count_addsub0000_8_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X11Y4"
    )
    port map (
      IA => wg_count_addsub0000_8_LOGIC_ZERO_2345,
      IB => wg_count_addsub0000_8_CYINIT_2364,
      SEL => wg_count_addsub0000_8_CYSELF_2351,
      O => Madd_wg_count_addsub0000_cy(8)
    );
  wg_count_addsub0000_8_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y4"
    )
    port map (
      IA => wg_count_addsub0000_8_LOGIC_ZERO_2345,
      IB => wg_count_addsub0000_8_LOGIC_ZERO_2345,
      SEL => wg_count_addsub0000_8_CYSELF_2351,
      O => wg_count_addsub0000_8_CYMUXF2_2346
    );
  wg_count_addsub0000_8_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X11Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(7),
      O => wg_count_addsub0000_8_CYINIT_2364
    );
  wg_count_addsub0000_8_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X11Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_8_F,
      O => wg_count_addsub0000_8_CYSELF_2351
    );
  wg_count_addsub0000_8_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_8_XORG_2353,
      O => wg_count_addsub0000(9)
    );
  wg_count_addsub0000_8_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X11Y4"
    )
    port map (
      I0 => Madd_wg_count_addsub0000_cy(8),
      I1 => wg_count_addsub0000_8_G,
      O => wg_count_addsub0000_8_XORG_2353
    );
  wg_count_addsub0000_8_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_8_CYMUXFAST_2350,
      O => Madd_wg_count_addsub0000_cy(9)
    );
  wg_count_addsub0000_8_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X11Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(7),
      O => wg_count_addsub0000_8_FASTCARRY_2348
    );
  wg_count_addsub0000_8_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X11Y4"
    )
    port map (
      I0 => wg_count_addsub0000_8_CYSELG_2336,
      I1 => wg_count_addsub0000_8_CYSELF_2351,
      O => wg_count_addsub0000_8_CYAND_2349
    );
  wg_count_addsub0000_8_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X11Y4"
    )
    port map (
      IA => wg_count_addsub0000_8_CYMUXG2_2347,
      IB => wg_count_addsub0000_8_FASTCARRY_2348,
      SEL => wg_count_addsub0000_8_CYAND_2349,
      O => wg_count_addsub0000_8_CYMUXFAST_2350
    );
  wg_count_addsub0000_8_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y4"
    )
    port map (
      IA => wg_count_addsub0000_8_LOGIC_ZERO_2345,
      IB => wg_count_addsub0000_8_CYMUXF2_2346,
      SEL => wg_count_addsub0000_8_CYSELG_2336,
      O => wg_count_addsub0000_8_CYMUXG2_2347
    );
  wg_count_addsub0000_8_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X11Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_8_G,
      O => wg_count_addsub0000_8_CYSELG_2336
    );
  wg_count_addsub0000_10_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X11Y5"
    )
    port map (
      O => wg_count_addsub0000_10_LOGIC_ZERO_2383
    );
  wg_count_addsub0000_10_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_10_XORF_2403,
      O => wg_count_addsub0000(10)
    );
  wg_count_addsub0000_10_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X11Y5"
    )
    port map (
      I0 => wg_count_addsub0000_10_CYINIT_2402,
      I1 => wg_count_addsub0000_10_F,
      O => wg_count_addsub0000_10_XORF_2403
    );
  wg_count_addsub0000_10_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X11Y5"
    )
    port map (
      IA => wg_count_addsub0000_10_LOGIC_ZERO_2383,
      IB => wg_count_addsub0000_10_CYINIT_2402,
      SEL => wg_count_addsub0000_10_CYSELF_2389,
      O => Madd_wg_count_addsub0000_cy(10)
    );
  wg_count_addsub0000_10_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y5"
    )
    port map (
      IA => wg_count_addsub0000_10_LOGIC_ZERO_2383,
      IB => wg_count_addsub0000_10_LOGIC_ZERO_2383,
      SEL => wg_count_addsub0000_10_CYSELF_2389,
      O => wg_count_addsub0000_10_CYMUXF2_2384
    );
  wg_count_addsub0000_10_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X11Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(9),
      O => wg_count_addsub0000_10_CYINIT_2402
    );
  wg_count_addsub0000_10_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X11Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_10_F,
      O => wg_count_addsub0000_10_CYSELF_2389
    );
  wg_count_addsub0000_10_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_10_XORG_2391,
      O => wg_count_addsub0000(11)
    );
  wg_count_addsub0000_10_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X11Y5"
    )
    port map (
      I0 => Madd_wg_count_addsub0000_cy(10),
      I1 => wg_count_addsub0000_10_G,
      O => wg_count_addsub0000_10_XORG_2391
    );
  wg_count_addsub0000_10_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_10_CYMUXFAST_2388,
      O => Madd_wg_count_addsub0000_cy(11)
    );
  wg_count_addsub0000_10_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X11Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(9),
      O => wg_count_addsub0000_10_FASTCARRY_2386
    );
  wg_count_addsub0000_10_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X11Y5"
    )
    port map (
      I0 => wg_count_addsub0000_10_CYSELG_2374,
      I1 => wg_count_addsub0000_10_CYSELF_2389,
      O => wg_count_addsub0000_10_CYAND_2387
    );
  wg_count_addsub0000_10_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X11Y5"
    )
    port map (
      IA => wg_count_addsub0000_10_CYMUXG2_2385,
      IB => wg_count_addsub0000_10_FASTCARRY_2386,
      SEL => wg_count_addsub0000_10_CYAND_2387,
      O => wg_count_addsub0000_10_CYMUXFAST_2388
    );
  wg_count_addsub0000_10_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y5"
    )
    port map (
      IA => wg_count_addsub0000_10_LOGIC_ZERO_2383,
      IB => wg_count_addsub0000_10_CYMUXF2_2384,
      SEL => wg_count_addsub0000_10_CYSELG_2374,
      O => wg_count_addsub0000_10_CYMUXG2_2385
    );
  wg_count_addsub0000_10_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X11Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_10_G,
      O => wg_count_addsub0000_10_CYSELG_2374
    );
  wg_count_addsub0000_12_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X11Y6"
    )
    port map (
      O => wg_count_addsub0000_12_LOGIC_ZERO_2421
    );
  wg_count_addsub0000_12_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_12_XORF_2441,
      O => wg_count_addsub0000(12)
    );
  wg_count_addsub0000_12_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X11Y6"
    )
    port map (
      I0 => wg_count_addsub0000_12_CYINIT_2440,
      I1 => wg_count_addsub0000_12_F,
      O => wg_count_addsub0000_12_XORF_2441
    );
  wg_count_addsub0000_12_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X11Y6"
    )
    port map (
      IA => wg_count_addsub0000_12_LOGIC_ZERO_2421,
      IB => wg_count_addsub0000_12_CYINIT_2440,
      SEL => wg_count_addsub0000_12_CYSELF_2427,
      O => Madd_wg_count_addsub0000_cy(12)
    );
  wg_count_addsub0000_12_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y6"
    )
    port map (
      IA => wg_count_addsub0000_12_LOGIC_ZERO_2421,
      IB => wg_count_addsub0000_12_LOGIC_ZERO_2421,
      SEL => wg_count_addsub0000_12_CYSELF_2427,
      O => wg_count_addsub0000_12_CYMUXF2_2422
    );
  wg_count_addsub0000_12_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X11Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(11),
      O => wg_count_addsub0000_12_CYINIT_2440
    );
  wg_count_addsub0000_12_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X11Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_12_F,
      O => wg_count_addsub0000_12_CYSELF_2427
    );
  wg_count_addsub0000_12_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_12_XORG_2429,
      O => wg_count_addsub0000(13)
    );
  wg_count_addsub0000_12_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X11Y6"
    )
    port map (
      I0 => Madd_wg_count_addsub0000_cy(12),
      I1 => wg_count_addsub0000_12_G,
      O => wg_count_addsub0000_12_XORG_2429
    );
  wg_count_addsub0000_12_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_12_CYMUXFAST_2426,
      O => Madd_wg_count_addsub0000_cy(13)
    );
  wg_count_addsub0000_12_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X11Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(11),
      O => wg_count_addsub0000_12_FASTCARRY_2424
    );
  wg_count_addsub0000_12_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X11Y6"
    )
    port map (
      I0 => wg_count_addsub0000_12_CYSELG_2412,
      I1 => wg_count_addsub0000_12_CYSELF_2427,
      O => wg_count_addsub0000_12_CYAND_2425
    );
  wg_count_addsub0000_12_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X11Y6"
    )
    port map (
      IA => wg_count_addsub0000_12_CYMUXG2_2423,
      IB => wg_count_addsub0000_12_FASTCARRY_2424,
      SEL => wg_count_addsub0000_12_CYAND_2425,
      O => wg_count_addsub0000_12_CYMUXFAST_2426
    );
  wg_count_addsub0000_12_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y6"
    )
    port map (
      IA => wg_count_addsub0000_12_LOGIC_ZERO_2421,
      IB => wg_count_addsub0000_12_CYMUXF2_2422,
      SEL => wg_count_addsub0000_12_CYSELG_2412,
      O => wg_count_addsub0000_12_CYMUXG2_2423
    );
  wg_count_addsub0000_12_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X11Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_12_G,
      O => wg_count_addsub0000_12_CYSELG_2412
    );
  wg_count_addsub0000_14_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X11Y7"
    )
    port map (
      O => wg_count_addsub0000_14_LOGIC_ZERO_2459
    );
  wg_count_addsub0000_14_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_14_XORF_2479,
      O => wg_count_addsub0000(14)
    );
  wg_count_addsub0000_14_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X11Y7"
    )
    port map (
      I0 => wg_count_addsub0000_14_CYINIT_2478,
      I1 => wg_count_addsub0000_14_F,
      O => wg_count_addsub0000_14_XORF_2479
    );
  wg_count_addsub0000_14_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X11Y7"
    )
    port map (
      IA => wg_count_addsub0000_14_LOGIC_ZERO_2459,
      IB => wg_count_addsub0000_14_CYINIT_2478,
      SEL => wg_count_addsub0000_14_CYSELF_2465,
      O => Madd_wg_count_addsub0000_cy(14)
    );
  wg_count_addsub0000_14_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y7"
    )
    port map (
      IA => wg_count_addsub0000_14_LOGIC_ZERO_2459,
      IB => wg_count_addsub0000_14_LOGIC_ZERO_2459,
      SEL => wg_count_addsub0000_14_CYSELF_2465,
      O => wg_count_addsub0000_14_CYMUXF2_2460
    );
  wg_count_addsub0000_14_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X11Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(13),
      O => wg_count_addsub0000_14_CYINIT_2478
    );
  wg_count_addsub0000_14_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X11Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_14_F,
      O => wg_count_addsub0000_14_CYSELF_2465
    );
  wg_count_addsub0000_14_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_14_XORG_2467,
      O => wg_count_addsub0000(15)
    );
  wg_count_addsub0000_14_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X11Y7"
    )
    port map (
      I0 => Madd_wg_count_addsub0000_cy(14),
      I1 => wg_count_addsub0000_14_G,
      O => wg_count_addsub0000_14_XORG_2467
    );
  wg_count_addsub0000_14_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_14_CYMUXFAST_2464,
      O => Madd_wg_count_addsub0000_cy(15)
    );
  wg_count_addsub0000_14_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X11Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(13),
      O => wg_count_addsub0000_14_FASTCARRY_2462
    );
  wg_count_addsub0000_14_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X11Y7"
    )
    port map (
      I0 => wg_count_addsub0000_14_CYSELG_2450,
      I1 => wg_count_addsub0000_14_CYSELF_2465,
      O => wg_count_addsub0000_14_CYAND_2463
    );
  wg_count_addsub0000_14_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X11Y7"
    )
    port map (
      IA => wg_count_addsub0000_14_CYMUXG2_2461,
      IB => wg_count_addsub0000_14_FASTCARRY_2462,
      SEL => wg_count_addsub0000_14_CYAND_2463,
      O => wg_count_addsub0000_14_CYMUXFAST_2464
    );
  wg_count_addsub0000_14_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y7"
    )
    port map (
      IA => wg_count_addsub0000_14_LOGIC_ZERO_2459,
      IB => wg_count_addsub0000_14_CYMUXF2_2460,
      SEL => wg_count_addsub0000_14_CYSELG_2450,
      O => wg_count_addsub0000_14_CYMUXG2_2461
    );
  wg_count_addsub0000_14_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X11Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_14_G,
      O => wg_count_addsub0000_14_CYSELG_2450
    );
  wg_count_addsub0000_16_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X11Y8"
    )
    port map (
      O => wg_count_addsub0000_16_LOGIC_ZERO_2497
    );
  wg_count_addsub0000_16_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_16_XORF_2517,
      O => wg_count_addsub0000(16)
    );
  wg_count_addsub0000_16_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X11Y8"
    )
    port map (
      I0 => wg_count_addsub0000_16_CYINIT_2516,
      I1 => wg_count_addsub0000_16_F,
      O => wg_count_addsub0000_16_XORF_2517
    );
  wg_count_addsub0000_16_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X11Y8"
    )
    port map (
      IA => wg_count_addsub0000_16_LOGIC_ZERO_2497,
      IB => wg_count_addsub0000_16_CYINIT_2516,
      SEL => wg_count_addsub0000_16_CYSELF_2503,
      O => Madd_wg_count_addsub0000_cy(16)
    );
  wg_count_addsub0000_16_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y8"
    )
    port map (
      IA => wg_count_addsub0000_16_LOGIC_ZERO_2497,
      IB => wg_count_addsub0000_16_LOGIC_ZERO_2497,
      SEL => wg_count_addsub0000_16_CYSELF_2503,
      O => wg_count_addsub0000_16_CYMUXF2_2498
    );
  wg_count_addsub0000_16_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X11Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(15),
      O => wg_count_addsub0000_16_CYINIT_2516
    );
  wg_count_addsub0000_16_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X11Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_16_F,
      O => wg_count_addsub0000_16_CYSELF_2503
    );
  wg_count_addsub0000_16_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_16_XORG_2505,
      O => wg_count_addsub0000(17)
    );
  wg_count_addsub0000_16_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X11Y8"
    )
    port map (
      I0 => Madd_wg_count_addsub0000_cy(16),
      I1 => wg_count_addsub0000_16_G,
      O => wg_count_addsub0000_16_XORG_2505
    );
  wg_count_addsub0000_16_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_16_CYMUXFAST_2502,
      O => Madd_wg_count_addsub0000_cy(17)
    );
  wg_count_addsub0000_16_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X11Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(15),
      O => wg_count_addsub0000_16_FASTCARRY_2500
    );
  wg_count_addsub0000_16_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X11Y8"
    )
    port map (
      I0 => wg_count_addsub0000_16_CYSELG_2488,
      I1 => wg_count_addsub0000_16_CYSELF_2503,
      O => wg_count_addsub0000_16_CYAND_2501
    );
  wg_count_addsub0000_16_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X11Y8"
    )
    port map (
      IA => wg_count_addsub0000_16_CYMUXG2_2499,
      IB => wg_count_addsub0000_16_FASTCARRY_2500,
      SEL => wg_count_addsub0000_16_CYAND_2501,
      O => wg_count_addsub0000_16_CYMUXFAST_2502
    );
  wg_count_addsub0000_16_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y8"
    )
    port map (
      IA => wg_count_addsub0000_16_LOGIC_ZERO_2497,
      IB => wg_count_addsub0000_16_CYMUXF2_2498,
      SEL => wg_count_addsub0000_16_CYSELG_2488,
      O => wg_count_addsub0000_16_CYMUXG2_2499
    );
  wg_count_addsub0000_16_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X11Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_16_G,
      O => wg_count_addsub0000_16_CYSELG_2488
    );
  wg_count_addsub0000_18_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X11Y9"
    )
    port map (
      O => wg_count_addsub0000_18_LOGIC_ZERO_2535
    );
  wg_count_addsub0000_18_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_18_XORF_2555,
      O => wg_count_addsub0000(18)
    );
  wg_count_addsub0000_18_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X11Y9"
    )
    port map (
      I0 => wg_count_addsub0000_18_CYINIT_2554,
      I1 => wg_count_addsub0000_18_F,
      O => wg_count_addsub0000_18_XORF_2555
    );
  wg_count_addsub0000_18_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X11Y9"
    )
    port map (
      IA => wg_count_addsub0000_18_LOGIC_ZERO_2535,
      IB => wg_count_addsub0000_18_CYINIT_2554,
      SEL => wg_count_addsub0000_18_CYSELF_2541,
      O => Madd_wg_count_addsub0000_cy(18)
    );
  wg_count_addsub0000_18_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y9"
    )
    port map (
      IA => wg_count_addsub0000_18_LOGIC_ZERO_2535,
      IB => wg_count_addsub0000_18_LOGIC_ZERO_2535,
      SEL => wg_count_addsub0000_18_CYSELF_2541,
      O => wg_count_addsub0000_18_CYMUXF2_2536
    );
  wg_count_addsub0000_18_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X11Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(17),
      O => wg_count_addsub0000_18_CYINIT_2554
    );
  wg_count_addsub0000_18_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X11Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_18_F,
      O => wg_count_addsub0000_18_CYSELF_2541
    );
  wg_count_addsub0000_18_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_18_XORG_2543,
      O => wg_count_addsub0000(19)
    );
  wg_count_addsub0000_18_XORG : X_XOR2
    generic map(
      LOC => "SLICE_X11Y9"
    )
    port map (
      I0 => Madd_wg_count_addsub0000_cy(18),
      I1 => wg_count_addsub0000_18_G,
      O => wg_count_addsub0000_18_XORG_2543
    );
  wg_count_addsub0000_18_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X11Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_wg_count_addsub0000_cy(17),
      O => wg_count_addsub0000_18_FASTCARRY_2538
    );
  wg_count_addsub0000_18_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X11Y9"
    )
    port map (
      I0 => wg_count_addsub0000_18_CYSELG_2526,
      I1 => wg_count_addsub0000_18_CYSELF_2541,
      O => wg_count_addsub0000_18_CYAND_2539
    );
  wg_count_addsub0000_18_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X11Y9"
    )
    port map (
      IA => wg_count_addsub0000_18_CYMUXG2_2537,
      IB => wg_count_addsub0000_18_FASTCARRY_2538,
      SEL => wg_count_addsub0000_18_CYAND_2539,
      O => wg_count_addsub0000_18_CYMUXFAST_2540
    );
  wg_count_addsub0000_18_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X11Y9"
    )
    port map (
      IA => wg_count_addsub0000_18_LOGIC_ZERO_2535,
      IB => wg_count_addsub0000_18_CYMUXF2_2536,
      SEL => wg_count_addsub0000_18_CYSELG_2526,
      O => wg_count_addsub0000_18_CYMUXG2_2537
    );
  wg_count_addsub0000_18_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X11Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_18_G,
      O => wg_count_addsub0000_18_CYSELG_2526
    );
  wg_count_addsub0000_20_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y10",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_20_XORF_2570,
      O => wg_count_addsub0000(20)
    );
  wg_count_addsub0000_20_XORF : X_XOR2
    generic map(
      LOC => "SLICE_X11Y10"
    )
    port map (
      I0 => wg_count_addsub0000_20_CYINIT_2569,
      I1 => wg_count_20_rt_2567,
      O => wg_count_addsub0000_20_XORF_2570
    );
  wg_count_addsub0000_20_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X11Y10",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_addsub0000_18_CYMUXFAST_2540,
      O => wg_count_addsub0000_20_CYINIT_2569
    );
  wg_dly_cmp_eq0000_wg_lut_0_INV_0 : X_LUT4
    generic map(
      INIT => X"0F0F",
      LOC => "SLICE_X13Y3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => wg_count(4),
      ADR3 => VCC,
      O => wg_dly_cmp_eq0000_wg_lut(0)
    );
  wg_dly_cmp_eq0000_wg_cy_1_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X13Y3"
    )
    port map (
      O => wg_dly_cmp_eq0000_wg_cy_1_LOGIC_ZERO_2586
    );
  wg_dly_cmp_eq0000_wg_cy_1_CYMUXF : X_MUX2
    generic map(
      LOC => "SLICE_X13Y3"
    )
    port map (
      IA => wg_dly_cmp_eq0000_wg_cy_1_LOGIC_ZERO_2586,
      IB => wg_dly_cmp_eq0000_wg_cy_1_CYINIT_2600,
      SEL => wg_dly_cmp_eq0000_wg_cy_1_CYSELF_2591,
      O => wg_dly_cmp_eq0000_wg_cy(0)
    );
  wg_dly_cmp_eq0000_wg_cy_1_CYINIT : X_BUF
    generic map(
      LOC => "SLICE_X13Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_cmp_eq0000_wg_cy_1_BXINV_2589,
      O => wg_dly_cmp_eq0000_wg_cy_1_CYINIT_2600
    );
  wg_dly_cmp_eq0000_wg_cy_1_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X13Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_cmp_eq0000_wg_lut(0),
      O => wg_dly_cmp_eq0000_wg_cy_1_CYSELF_2591
    );
  wg_dly_cmp_eq0000_wg_cy_1_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X13Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => '1',
      O => wg_dly_cmp_eq0000_wg_cy_1_BXINV_2589
    );
  wg_dly_cmp_eq0000_wg_cy_1_CYMUXG : X_MUX2
    generic map(
      LOC => "SLICE_X13Y3"
    )
    port map (
      IA => wg_dly_cmp_eq0000_wg_cy_1_LOGIC_ZERO_2586,
      IB => wg_dly_cmp_eq0000_wg_cy(0),
      SEL => wg_dly_cmp_eq0000_wg_cy_1_CYSELG_2580,
      O => wg_dly_cmp_eq0000_wg_cy_1_CYMUXG_2588
    );
  wg_dly_cmp_eq0000_wg_cy_1_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X13Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_cmp_eq0000_wg_lut(1),
      O => wg_dly_cmp_eq0000_wg_cy_1_CYSELG_2580
    );
  wg_dly_cmp_eq0000_wg_lut_1_Q : X_LUT4
    generic map(
      INIT => X"0200",
      LOC => "SLICE_X13Y3"
    )
    port map (
      ADR0 => wg_count(8),
      ADR1 => wg_count(6),
      ADR2 => wg_count(3),
      ADR3 => wg_count(7),
      O => wg_dly_cmp_eq0000_wg_lut(1)
    );
  wg_dly_cmp_eq0000_wg_lut_2_Q : X_LUT4
    generic map(
      INIT => X"0020",
      LOC => "SLICE_X13Y4"
    )
    port map (
      ADR0 => wg_count(10),
      ADR1 => wg_count(5),
      ADR2 => wg_count(9),
      ADR3 => wg_count(13),
      O => wg_dly_cmp_eq0000_wg_lut(2)
    );
  wg_dly_cmp_eq0000_wg_cy_3_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X13Y4"
    )
    port map (
      O => wg_dly_cmp_eq0000_wg_cy_3_LOGIC_ZERO_2618
    );
  wg_dly_cmp_eq0000_wg_cy_3_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X13Y4"
    )
    port map (
      IA => wg_dly_cmp_eq0000_wg_cy_3_LOGIC_ZERO_2618,
      IB => wg_dly_cmp_eq0000_wg_cy_3_LOGIC_ZERO_2618,
      SEL => wg_dly_cmp_eq0000_wg_cy_3_CYSELF_2624,
      O => wg_dly_cmp_eq0000_wg_cy_3_CYMUXF2_2619
    );
  wg_dly_cmp_eq0000_wg_cy_3_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X13Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_cmp_eq0000_wg_lut(2),
      O => wg_dly_cmp_eq0000_wg_cy_3_CYSELF_2624
    );
  wg_dly_cmp_eq0000_wg_cy_3_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X13Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_cmp_eq0000_wg_cy_1_CYMUXG_2588,
      O => wg_dly_cmp_eq0000_wg_cy_3_FASTCARRY_2621
    );
  wg_dly_cmp_eq0000_wg_cy_3_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X13Y4"
    )
    port map (
      I0 => wg_dly_cmp_eq0000_wg_cy_3_CYSELG_2612,
      I1 => wg_dly_cmp_eq0000_wg_cy_3_CYSELF_2624,
      O => wg_dly_cmp_eq0000_wg_cy_3_CYAND_2622
    );
  wg_dly_cmp_eq0000_wg_cy_3_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X13Y4"
    )
    port map (
      IA => wg_dly_cmp_eq0000_wg_cy_3_CYMUXG2_2620,
      IB => wg_dly_cmp_eq0000_wg_cy_3_FASTCARRY_2621,
      SEL => wg_dly_cmp_eq0000_wg_cy_3_CYAND_2622,
      O => wg_dly_cmp_eq0000_wg_cy_3_CYMUXFAST_2623
    );
  wg_dly_cmp_eq0000_wg_cy_3_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X13Y4"
    )
    port map (
      IA => wg_dly_cmp_eq0000_wg_cy_3_LOGIC_ZERO_2618,
      IB => wg_dly_cmp_eq0000_wg_cy_3_CYMUXF2_2619,
      SEL => wg_dly_cmp_eq0000_wg_cy_3_CYSELG_2612,
      O => wg_dly_cmp_eq0000_wg_cy_3_CYMUXG2_2620
    );
  wg_dly_cmp_eq0000_wg_cy_3_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X13Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_cmp_eq0000_wg_lut(3),
      O => wg_dly_cmp_eq0000_wg_cy_3_CYSELG_2612
    );
  wg_dly_cmp_eq0000_wg_lut_3_Q : X_LUT4
    generic map(
      INIT => X"0080",
      LOC => "SLICE_X13Y4"
    )
    port map (
      ADR0 => wg_count(14),
      ADR1 => wg_count(12),
      ADR2 => wg_count(1),
      ADR3 => wg_count(11),
      O => wg_dly_cmp_eq0000_wg_lut(3)
    );
  wg_dly_cmp_eq0000_wg_lut_4_Q : X_LUT4
    generic map(
      INIT => X"8000",
      LOC => "SLICE_X13Y5"
    )
    port map (
      ADR0 => wg_count(16),
      ADR1 => wg_count(18),
      ADR2 => wg_count(0),
      ADR3 => wg_count(15),
      O => wg_dly_cmp_eq0000_wg_lut(4)
    );
  wg_dly_cmp_eq0000_LOGIC_ZERO : X_ZERO
    generic map(
      LOC => "SLICE_X13Y5"
    )
    port map (
      O => wg_dly_cmp_eq0000_LOGIC_ZERO_2648
    );
  wg_dly_cmp_eq0000_CYMUXF2 : X_MUX2
    generic map(
      LOC => "SLICE_X13Y5"
    )
    port map (
      IA => wg_dly_cmp_eq0000_LOGIC_ZERO_2648,
      IB => wg_dly_cmp_eq0000_LOGIC_ZERO_2648,
      SEL => wg_dly_cmp_eq0000_CYSELF_2654,
      O => wg_dly_cmp_eq0000_CYMUXF2_2649
    );
  wg_dly_cmp_eq0000_CYSELF : X_BUF
    generic map(
      LOC => "SLICE_X13Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_cmp_eq0000_wg_lut(4),
      O => wg_dly_cmp_eq0000_CYSELF_2654
    );
  wg_dly_cmp_eq0000_COUTUSED : X_BUF
    generic map(
      LOC => "SLICE_X13Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_cmp_eq0000_CYMUXFAST_2653,
      O => wg_dly_cmp_eq0000
    );
  wg_dly_cmp_eq0000_FASTCARRY : X_BUF
    generic map(
      LOC => "SLICE_X13Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_cmp_eq0000_wg_cy_3_CYMUXFAST_2623,
      O => wg_dly_cmp_eq0000_FASTCARRY_2651
    );
  wg_dly_cmp_eq0000_CYAND : X_AND2
    generic map(
      LOC => "SLICE_X13Y5"
    )
    port map (
      I0 => wg_dly_cmp_eq0000_CYSELG_2642,
      I1 => wg_dly_cmp_eq0000_CYSELF_2654,
      O => wg_dly_cmp_eq0000_CYAND_2652
    );
  wg_dly_cmp_eq0000_CYMUXFAST : X_MUX2
    generic map(
      LOC => "SLICE_X13Y5"
    )
    port map (
      IA => wg_dly_cmp_eq0000_CYMUXG2_2650,
      IB => wg_dly_cmp_eq0000_FASTCARRY_2651,
      SEL => wg_dly_cmp_eq0000_CYAND_2652,
      O => wg_dly_cmp_eq0000_CYMUXFAST_2653
    );
  wg_dly_cmp_eq0000_CYMUXG2 : X_MUX2
    generic map(
      LOC => "SLICE_X13Y5"
    )
    port map (
      IA => wg_dly_cmp_eq0000_LOGIC_ZERO_2648,
      IB => wg_dly_cmp_eq0000_CYMUXF2_2649,
      SEL => wg_dly_cmp_eq0000_CYSELG_2642,
      O => wg_dly_cmp_eq0000_CYMUXG2_2650
    );
  wg_dly_cmp_eq0000_CYSELG : X_BUF
    generic map(
      LOC => "SLICE_X13Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_cmp_eq0000_wg_lut(5),
      O => wg_dly_cmp_eq0000_CYSELG_2642
    );
  wg_dly_cmp_eq0000_wg_lut_5_Q : X_LUT4
    generic map(
      INIT => X"1000",
      LOC => "SLICE_X13Y5"
    )
    port map (
      ADR0 => wg_count(19),
      ADR1 => wg_count(2),
      ADR2 => wg_count(20),
      ADR3 => wg_count(17),
      O => wg_dly_cmp_eq0000_wg_lut(5)
    );
  WG_SW_NOISE_IBUF : X_BUF
    generic map(
      LOC => "PAD95",
      PATHPULSE => 499 ps
    )
    port map (
      I => WG_SW_NOISE,
      O => WG_SW_NOISE_IBUF_2667
    );
  MOD_PULSE_HMC_OBUF : X_OBUF
    generic map(
      LOC => "PAD133"
    )
    port map (
      I => MOD_PULSE_HMC_O,
      O => MOD_PULSE_HMC
    );
  EMS_ERROR_45_OBUF : X_OBUF
    generic map(
      LOC => "PAD103"
    )
    port map (
      I => EMS_ERROR_45_O,
      O => EMS_ERROR_45
    );
  EMS_ERROR_67_OBUF : X_OBUF
    generic map(
      LOC => "PAD102"
    )
    port map (
      I => EMS_ERROR_67_O,
      O => EMS_ERROR_67
    );
  T0_IBUF : X_BUF
    generic map(
      LOC => "PAD20",
      PATHPULSE => 499 ps
    )
    port map (
      I => T0,
      O => SPARE2_OBUF_2698
    );
  WG_SW_CTRL_TERM_OBUF : X_OBUF
    generic map(
      LOC => "PAD19"
    )
    port map (
      I => WG_SW_CTRL_TERM_O,
      O => WG_SW_CTRL_TERM
    );
  TEST_BIT_0_IBUF : X_BUF
    generic map(
      LOC => "PAD25",
      PATHPULSE => 499 ps
    )
    port map (
      I => TEST_BIT_0,
      O => SPARE_STATUS0_OBUF_2713
    );
  TEST_BIT_1_IBUF : X_BUF
    generic map(
      LOC => "PAD21",
      PATHPULSE => 499 ps
    )
    port map (
      I => TEST_BIT_1,
      O => SPARE_STATUS1_OBUF_2720
    );
  SPARE1_OBUF : X_OBUF
    generic map(
      LOC => "PAD11"
    )
    port map (
      I => SPARE1_O,
      O => SPARE1
    );
  MOD_PULSE_IBUF : X_BUF
    generic map(
      LOC => "PAD99",
      PATHPULSE => 499 ps
    )
    port map (
      I => MOD_PULSE,
      O => MOD_PULSE_IBUF_2735
    );
  SPARE2_OBUF : X_OBUF
    generic map(
      LOC => "PAD139"
    )
    port map (
      I => SPARE2_O,
      O => SPARE2
    );
  WG_SW_ERROR_OBUF : X_OBUF
    generic map(
      LOC => "PAD131"
    )
    port map (
      I => WG_SW_ERROR_O,
      O => WG_SW_ERROR
    );
  SPARE3_OBUF : X_OBUF
    generic map(
      LOC => "PAD2"
    )
    port map (
      I => SPARE3_O,
      O => SPARE3
    );
  EMS_ERROR_1_OBUF : X_OBUF
    generic map(
      LOC => "PAD98"
    )
    port map (
      I => EMS_ERROR_1_O,
      O => EMS_ERROR_1
    );
  EMS_ERROR_2_OBUF : X_OBUF
    generic map(
      LOC => "PAD101"
    )
    port map (
      I => EMS_ERROR_2_O,
      O => EMS_ERROR_2
    );
  HV_ON_730_IBUF : X_BUF
    generic map(
      LOC => "PAD1",
      PATHPULSE => 499 ps
    )
    port map (
      I => HV_ON_730,
      O => HV_ON_HMC_OBUF_2782
    );
  EMS_ERROR_3_OBUF : X_OBUF
    generic map(
      LOC => "PAD92"
    )
    port map (
      I => EMS_ERROR_3_O,
      O => EMS_ERROR_3
    );
  SYNC_PULSE_HMC_OBUF : X_OBUF
    generic map(
      LOC => "PAD116"
    )
    port map (
      I => SYNC_PULSE_HMC_O,
      O => SYNC_PULSE_HMC
    );
  EXT_CLK_IBUF : X_BUF
    generic map(
      LOC => "PAD96",
      PATHPULSE => 499 ps
    )
    port map (
      I => EXT_CLK,
      O => SPARE1_OBUF1
    );
  FIL_ON_HMC_OBUF : X_OBUF
    generic map(
      LOC => "PAD144"
    )
    port map (
      I => FIL_ON_HMC_O,
      O => FIL_ON_HMC
    );
  WG_SW_TERM_IBUF : X_BUF
    generic map(
      LOC => "PAD132",
      PATHPULSE => 499 ps
    )
    port map (
      I => WG_SW_TERM,
      O => WG_SW_TERM_IBUF_2820
    );
  RX_GATE_IBUF : X_BUF
    generic map(
      LOC => "PAD125",
      PATHPULSE => 499 ps
    )
    port map (
      I => RX_GATE,
      O => RX_GATE_IBUF_2827
    );
  EMS_OUT_1_OBUF : X_OBUF
    generic map(
      LOC => "PAD82"
    )
    port map (
      I => EMS_OUT_1_O,
      O => EMS_OUT(1)
    );
  EMS_OUT_2_OBUF : X_OBUF
    generic map(
      LOC => "PAD54"
    )
    port map (
      I => EMS_OUT_2_O,
      O => EMS_OUT(2)
    );
  MOD_PULSE_DISABLE_OBUF : X_OBUF
    generic map(
      LOC => "PAD126"
    )
    port map (
      I => MOD_PULSE_DISABLE_O,
      O => MOD_PULSE_DISABLE
    );
  SYNC_PULSE_IBUF : X_BUF
    generic map(
      LOC => "IPAD114",
      PATHPULSE => 499 ps
    )
    port map (
      I => SYNC_PULSE,
      O => SYNC_PULSE_HMC_OBUF_2858
    );
  EMS_OUT_3_OBUF : X_OBUF
    generic map(
      LOC => "PAD62"
    )
    port map (
      I => EMS_OUT_3_O,
      O => EMS_OUT(3)
    );
  EMS_OUT_4_OBUF : X_OBUF
    generic map(
      LOC => "PAD61"
    )
    port map (
      I => EMS_OUT_4_O,
      O => EMS_OUT(4)
    );
  STATUS_ACK_IBUF : X_BUF
    generic map(
      LOC => "PAD104",
      PATHPULSE => 499 ps
    )
    port map (
      I => STATUS_ACK,
      O => STATUS_ACK_IBUF_2881
    );
  EMS_OUT_5_OBUF : X_OBUF
    generic map(
      LOC => "PAD60"
    )
    port map (
      I => EMS_OUT_5_O,
      O => EMS_OUT(5)
    );
  NOISE_SOURCE_EN_OBUF : X_OBUF
    generic map(
      LOC => "PAD109"
    )
    port map (
      I => NOISE_SOURCE_EN_O,
      O => NOISE_SOURCE_EN
    );
  EMS_OUT_6_OBUF : X_OBUF
    generic map(
      LOC => "PAD67"
    )
    port map (
      I => EMS_OUT_6_O,
      O => EMS_OUT(6)
    );
  WG_SW_CTRL_NOISE_OBUF : X_OBUF
    generic map(
      LOC => "PAD107"
    )
    port map (
      I => WG_SW_CTRL_NOISE_O,
      O => WG_SW_CTRL_NOISE
    );
  HV_ON_HMC_OBUF : X_OBUF
    generic map(
      LOC => "PAD112"
    )
    port map (
      I => HV_ON_HMC_O,
      O => HV_ON_HMC
    );
  EMS_TRIG_IBUF : X_BUF
    generic map(
      LOC => "PAD106",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_TRIG,
      O => EMS_TRIG_IBUF_2928
    );
  OPS_MODE_730_0_IBUF : X_BUF
    generic map(
      LOC => "PAD36",
      PATHPULSE => 499 ps
    )
    port map (
      I => OPS_MODE_730(0),
      O => OPS_MODE_730_0_IBUF_2943
    );
  OPS_MODE_730_1_IBUF : X_BUF
    generic map(
      LOC => "IPAD23",
      PATHPULSE => 499 ps
    )
    port map (
      I => OPS_MODE_730(1),
      O => OPS_MODE_730_1_IBUF_2958
    );
  TX_GATE_IBUF : X_BUF
    generic map(
      LOC => "PAD111",
      PATHPULSE => 499 ps
    )
    port map (
      I => TX_GATE,
      O => SPARE3_OBUF_2965
    );
  OPS_MODE_730_2_IBUF : X_BUF
    generic map(
      LOC => "PAD16",
      PATHPULSE => 499 ps
    )
    port map (
      I => OPS_MODE_730(2),
      O => OPS_MODE_730_2_IBUF_2980
    );
  ONE_PPS_IBUF : X_BUF
    generic map(
      LOC => "PAD93",
      PATHPULSE => 499 ps
    )
    port map (
      I => ONE_PPS,
      O => ONE_PPS_IBUF_2987
    );
  EMS_OUT_7_OBUF : X_OBUF
    generic map(
      LOC => "PAD59"
    )
    port map (
      I => EMS_OUT_7_O,
      O => EMS_OUT(7)
    );
  SPARE_STATUS0_OBUF : X_OBUF
    generic map(
      LOC => "PAD24"
    )
    port map (
      I => SPARE_STATUS0_O,
      O => SPARE_STATUS0
    );
  SPARE_STATUS1_OBUF : X_OBUF
    generic map(
      LOC => "PAD91"
    )
    port map (
      I => SPARE_STATUS1_O,
      O => SPARE_STATUS1
    );
  EMS_PWR_ERROR_IBUF : X_BUF
    generic map(
      LOC => "PAD108",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_PWR_ERROR,
      O => EMS_PWR_ERROR_IBUF_3018
    );
  BIT_EMS_1_IBUF : X_BUF
    generic map(
      LOC => "PAD53",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS(1),
      O => BIT_EMS_1_IBUF_3025
    );
  BIT_EMS_2_IBUF : X_BUF
    generic map(
      LOC => "IPAD50",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS(2),
      O => BIT_EMS_2_IBUF_3032
    );
  EMS_ERROR_EVENT_OBUF : X_OBUF
    generic map(
      LOC => "PAD140"
    )
    port map (
      I => EMS_ERROR_EVENT_O,
      O => EMS_ERROR_EVENT
    );
  BIT_EMS_3_IBUF : X_BUF
    generic map(
      LOC => "PAD48",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS(3),
      O => BIT_EMS_3_IBUF_3047
    );
  BIT_EMS_4_IBUF : X_BUF
    generic map(
      LOC => "PAD47",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS(4),
      O => BIT_EMS_4_IBUF_3054
    );
  BIT_EMS_5_IBUF : X_BUF
    generic map(
      LOC => "PAD44",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS(5),
      O => BIT_EMS_5_IBUF_3061
    );
  RESET_IBUF : X_BUF
    generic map(
      LOC => "PAD22",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET,
      O => RESET_IBUF_3068
    );
  BIT_EMS_6_IBUF : X_BUF
    generic map(
      LOC => "PAD43",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS(6),
      O => BIT_EMS_6_IBUF_3075
    );
  FIL_ON_730_IBUF : X_BUF
    generic map(
      LOC => "PAD143",
      PATHPULSE => 499 ps
    )
    port map (
      I => FIL_ON_730,
      O => FIL_ON_HMC_OBUF_3082
    );
  BIT_EMS_7_IBUF : X_BUF
    generic map(
      LOC => "PAD37",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS(7),
      O => BIT_EMS_7_IBUF_3089
    );
  SPARE1_OBUF_BUFG : X_BUFGMUX
    generic map(
      LOC => "BUFGMUX_X1Y1"
    )
    port map (
      I0 => SPARE1_OBUF_BUFG_I0_INV,
      I1 => GND,
      S => SPARE1_OBUF_BUFG_S_INVNOT,
      O => SPARE1_OBUF_1550
    );
  SPARE1_OBUF_BUFG_SINV : X_INV
    generic map(
      LOC => "BUFGMUX_X1Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => '1',
      O => SPARE1_OBUF_BUFG_S_INVNOT
    );
  SPARE1_OBUF_BUFG_I0_USED : X_BUF
    generic map(
      LOC => "BUFGMUX_X1Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF1_0,
      O => SPARE1_OBUF_BUFG_I0_INV
    );
  state_FSM_FFd1_In34_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X15Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_FSM_FFd1_In34_F5MUX_3118,
      O => state_FSM_FFd1_In34
    );
  state_FSM_FFd1_In34_F5MUX : X_MUX2
    generic map(
      LOC => "SLICE_X15Y19"
    )
    port map (
      IA => N30,
      IB => state_FSM_FFd1_In34_F_3116,
      SEL => state_FSM_FFd1_In34_BXINV_3107,
      O => state_FSM_FFd1_In34_F5MUX_3118
    );
  state_FSM_FFd1_In34_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_FSM_FFd1_In14_5720,
      O => state_FSM_FFd1_In34_BXINV_3107
    );
  N18_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X20Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => N18_F5MUX_3143,
      O => N18
    );
  N18_F5MUX : X_MUX2
    generic map(
      LOC => "SLICE_X20Y25"
    )
    port map (
      IA => N32,
      IB => N33,
      SEL => N18_BXINV_3136,
      O => N18_F5MUX_3143
    );
  N18_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X20Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => ops_mode(2),
      O => N18_BXINV_3136
    );
  ems_tx_stat34_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X20Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_stat34_F5MUX_3168,
      O => ems_tx_stat34
    );
  ems_tx_stat34_F5MUX : X_MUX2
    generic map(
      LOC => "SLICE_X20Y24"
    )
    port map (
      IA => ems_tx_stat341_3155,
      IB => ems_tx_stat34_F,
      SEL => ems_tx_stat34_BXINV_3157,
      O => ems_tx_stat34_F5MUX_3168
    );
  ems_tx_stat34_BXINV : X_BUF
    generic map(
      LOC => "SLICE_X20Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS_7_IBUF_0,
      O => ems_tx_stat34_BXINV_3157
    );
  ems_tx_error_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_error_and0000,
      O => ems_tx_error_DXMUX_3198
    );
  ems_tx_error_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => N14_pack_2,
      O => N14
    );
  ems_tx_error_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_tx_error_CLKINV_3180
    );
  ems_tx_count_0_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X23Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_count_mux0002(4),
      O => ems_tx_count_0_DXMUX_3233
    );
  ems_tx_count_0_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X23Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => N21_pack_2,
      O => N21
    );
  ems_tx_count_0_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X23Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_tx_count_0_CLKINV_3216
    );
  wg_count_enable_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_enable_mux0000,
      O => wg_count_enable_DXMUX_3270
    );
  wg_count_enable_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X12Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => N38_pack_2,
      O => N38
    );
  wg_count_enable_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_count_enable_CLKINV_3252
    );
  wg_count_enable_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_FXMUX_4168,
      O => wg_count_enable_CEINV_3251
    );
  ems_rx_count_0_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X11Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_rx_count_mux0002(4),
      O => ems_rx_count_0_DXMUX_3305
    );
  ems_rx_count_0_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => N4_pack_2,
      O => N4
    );
  ems_rx_count_0_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X11Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_rx_count_0_CLKINV_3288
    );
  N26_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => N26,
      O => N26_0
    );
  N26_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => N35_pack_1,
      O => N35
    );
  state_FSM_FFd1_In60_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X14Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_FSM_FFd1_In60_3357,
      O => state_FSM_FFd1_In60_0
    );
  state_FSM_FFd1_In60_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X14Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_FSM_N8_pack_1,
      O => state_FSM_N8
    );
  ems_error_prt_or00005_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X20Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_error_prt_or00005_3381,
      O => ems_error_prt_or00005_0
    );
  ems_error_prt_or00005_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X20Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_stat_pack_1,
      O => ems_tx_stat
    );
  ems_2_error_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y13",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_2_error_or0000,
      O => ems_2_error_DXMUX_3412
    );
  ems_2_error_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X15Y13",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_2_error_or000046_SW0_O_pack_2,
      O => ems_2_error_or000046_SW0_O
    );
  ems_2_error_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y13",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_2_error_CLKINV_3396
    );
  N28_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X12Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => N28,
      O => N28_0
    );
  N28_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X12Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_FSM_FFd2_In92_O_pack_1,
      O => state_FSM_FFd2_In92_O
    );
  N141_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X17Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => N141,
      O => N141_0
    );
  N141_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X17Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_FSM_FFd2_In36_O_pack_1,
      O => state_FSM_FFd2_In36_O
    );
  state_FSM_FFd2_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_FSM_FFd2_In,
      O => state_FSM_FFd2_DXMUX_3495
    );
  state_FSM_FFd2_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X14Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_FSM_FFd2_In106_O_pack_3,
      O => state_FSM_FFd2_In106_O
    );
  state_FSM_FFd2_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => state_FSM_FFd2_CLKINV_3479
    );
  ems_45_error_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X18Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_45_error_or0000,
      O => ems_45_error_DXMUX_3530
    );
  ems_45_error_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_45_error_or0000115_O_pack_2,
      O => ems_45_error_or0000115_O
    );
  ems_45_error_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X18Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_45_error_CLKINV_3513
    );
  ems_error_prt_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X21Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_error_prt_or0000,
      O => ems_error_prt_DXMUX_3565
    );
  ems_error_prt_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X21Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_error_prt_or0000121_O_pack_1,
      O => ems_error_prt_or0000121_O
    );
  ems_error_prt_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X21Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_error_prt_CLKINV_3548
    );
  ems_67_error_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X19Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_67_error_or0000,
      O => ems_67_error_DXMUX_3600
    );
  ems_67_error_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_67_error_or0000115_O_pack_2,
      O => ems_67_error_or0000115_O
    );
  ems_67_error_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X19Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_67_error_CLKINV_3583
    );
  ems_3_error_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X18Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_3_error_or0000,
      O => ems_3_error_DXMUX_3635
    );
  ems_3_error_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_3_error_or000026_O_pack_2,
      O => ems_3_error_or000026_O
    );
  ems_3_error_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X18Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_3_error_CLKINV_3619
    );
  wg_dly_not0001_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X13Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001,
      O => wg_dly_not0001_0
    );
  wg_dly_not0001_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X13Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_change_state_pack_1,
      O => wg_change_state
    );
  ems_1_error_or000029_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_1_error_or000029_3687,
      O => ems_1_error_or000029_0
    );
  ems_1_error_or000029_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_1_error_or000016_O_pack_1,
      O => ems_1_error_or000016_O
    );
  ems_rx_count_enable_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_rx_count_enable_and0000,
      O => ems_rx_count_enable_DXMUX_3724
    );
  ems_rx_count_enable_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_ok_and0000,
      O => ems_rx_count_enable_DYMUX_3711
    );
  ems_rx_count_enable_SRINV : X_INV
    generic map(
      LOC => "SLICE_X15Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_rx_count_enable_SRINVNOT
    );
  ems_rx_count_enable_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_rx_count_enable_CLKINV_3702
    );
  ems_rx_count_mux0002_3_1 : X_LUT4
    generic map(
      INIT => X"2828",
      LOC => "SLICE_X10Y18"
    )
    port map (
      ADR0 => ems_rx_count_enable_1577,
      ADR1 => ems_rx_count(1),
      ADR2 => ems_rx_count(0),
      ADR3 => VCC,
      O => ems_rx_count_mux0002(3)
    );
  ems_rx_count_2_FFY_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X10Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_rx_count_2_SRINVNOT,
      O => ems_rx_count_2_FFY_RST
    );
  ems_rx_count_1 : X_FF
    generic map(
      LOC => "SLICE_X10Y18",
      INIT => '0'
    )
    port map (
      I => ems_rx_count_2_DYMUX_3752,
      CE => VCC,
      CLK => ems_rx_count_2_CLKINV_3742,
      SET => GND,
      RST => ems_rx_count_2_FFY_RST,
      O => ems_rx_count(1)
    );
  ems_rx_count_mux0002_2_1 : X_LUT4
    generic map(
      INIT => X"1320",
      LOC => "SLICE_X10Y18"
    )
    port map (
      ADR0 => ems_rx_count(1),
      ADR1 => rx_dly_not0001_1624,
      ADR2 => ems_rx_count(0),
      ADR3 => ems_rx_count(2),
      O => ems_rx_count_mux0002(2)
    );
  ems_rx_count_2_FFX_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X10Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_rx_count_2_SRINVNOT,
      O => ems_rx_count_2_FFX_RST
    );
  ems_rx_count_2 : X_FF
    generic map(
      LOC => "SLICE_X10Y18",
      INIT => '0'
    )
    port map (
      I => ems_rx_count_2_DXMUX_3766,
      CE => VCC,
      CLK => ems_rx_count_2_CLKINV_3742,
      SET => GND,
      RST => ems_rx_count_2_FFX_RST,
      O => ems_rx_count(2)
    );
  ems_rx_count_2_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_rx_count_mux0002(2),
      O => ems_rx_count_2_DXMUX_3766
    );
  ems_rx_count_2_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_rx_count_mux0002(3),
      O => ems_rx_count_2_DYMUX_3752
    );
  ems_rx_count_2_SRINV : X_INV
    generic map(
      LOC => "SLICE_X10Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_rx_count_2_SRINVNOT
    );
  ems_rx_count_2_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_rx_count_2_CLKINV_3742
    );
  hv_count_11_FFY_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X2Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_11_SRINVNOT,
      O => hv_count_11_FFY_RST
    );
  hv_count_10 : X_FF
    generic map(
      LOC => "SLICE_X2Y19",
      INIT => '0'
    )
    port map (
      I => hv_count_11_DYMUX_3795,
      CE => hv_count_11_CEINV_3784,
      CLK => hv_count_11_CLKINV_3785,
      SET => GND,
      RST => hv_count_11_FFY_RST,
      O => hv_count(10)
    );
  hv_count_mux0000_13_1 : X_LUT4
    generic map(
      INIT => X"0300",
      LOC => "SLICE_X2Y19"
    )
    port map (
      ADR0 => VCC,
      ADR1 => HV_ON_HMC_OBUF_0,
      ADR2 => count_enable_cmp_eq0000,
      ADR3 => hv_count_addsub0000(10),
      O => hv_count_mux0000(13)
    );
  hv_count_mux0000_12_1 : X_LUT4
    generic map(
      INIT => X"000A",
      LOC => "SLICE_X2Y19"
    )
    port map (
      ADR0 => hv_count_addsub0000(11),
      ADR1 => VCC,
      ADR2 => count_enable_cmp_eq0000,
      ADR3 => HV_ON_HMC_OBUF_0,
      O => hv_count_mux0000(12)
    );
  hv_count_11_FFX_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X2Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_11_SRINVNOT,
      O => hv_count_11_FFX_RST
    );
  hv_count_11 : X_FF
    generic map(
      LOC => "SLICE_X2Y19",
      INIT => '0'
    )
    port map (
      I => hv_count_11_DXMUX_3811,
      CE => hv_count_11_CEINV_3784,
      CLK => hv_count_11_CLKINV_3785,
      SET => GND,
      RST => hv_count_11_FFX_RST,
      O => hv_count(11)
    );
  hv_count_11_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(12),
      O => hv_count_11_DXMUX_3811
    );
  hv_count_11_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(13),
      O => hv_count_11_DYMUX_3795
    );
  hv_count_11_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_11_SRINVNOT
    );
  hv_count_11_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_11_CLKINV_3785
    );
  hv_count_11_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_11_CEINV_3784
    );
  hv_count_21_FFY_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X2Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_21_SRINVNOT,
      O => hv_count_21_FFY_RST
    );
  hv_count_20 : X_FF
    generic map(
      LOC => "SLICE_X2Y25",
      INIT => '0'
    )
    port map (
      I => hv_count_21_DYMUX_3841,
      CE => hv_count_21_CEINV_3830,
      CLK => hv_count_21_CLKINV_3831,
      SET => GND,
      RST => hv_count_21_FFY_RST,
      O => hv_count(20)
    );
  hv_count_mux0000_3_1 : X_LUT4
    generic map(
      INIT => X"0050",
      LOC => "SLICE_X2Y25"
    )
    port map (
      ADR0 => count_enable_cmp_eq0000,
      ADR1 => VCC,
      ADR2 => hv_count_addsub0000(20),
      ADR3 => HV_ON_HMC_OBUF_0,
      O => hv_count_mux0000(3)
    );
  hv_count_mux0000_2_1 : X_LUT4
    generic map(
      INIT => X"000C",
      LOC => "SLICE_X2Y25"
    )
    port map (
      ADR0 => VCC,
      ADR1 => hv_count_addsub0000(21),
      ADR2 => count_enable_cmp_eq0000,
      ADR3 => HV_ON_HMC_OBUF_0,
      O => hv_count_mux0000(2)
    );
  hv_count_21_FFX_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X2Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_21_SRINVNOT,
      O => hv_count_21_FFX_RST
    );
  hv_count_21 : X_FF
    generic map(
      LOC => "SLICE_X2Y25",
      INIT => '0'
    )
    port map (
      I => hv_count_21_DXMUX_3857,
      CE => hv_count_21_CEINV_3830,
      CLK => hv_count_21_CLKINV_3831,
      SET => GND,
      RST => hv_count_21_FFX_RST,
      O => hv_count(21)
    );
  hv_count_21_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(2),
      O => hv_count_21_DXMUX_3857
    );
  hv_count_21_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(3),
      O => hv_count_21_DYMUX_3841
    );
  hv_count_21_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_21_SRINVNOT
    );
  hv_count_21_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_21_CLKINV_3831
    );
  hv_count_21_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_21_CEINV_3830
    );
  hv_count_mux0000_11_1 : X_LUT4
    generic map(
      INIT => X"0050",
      LOC => "SLICE_X2Y21"
    )
    port map (
      ADR0 => HV_ON_HMC_OBUF_0,
      ADR1 => VCC,
      ADR2 => hv_count_addsub0000(12),
      ADR3 => count_enable_cmp_eq0000,
      O => hv_count_mux0000(11)
    );
  hv_count_13_FFY_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X2Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_13_SRINVNOT,
      O => hv_count_13_FFY_RST
    );
  hv_count_12 : X_FF
    generic map(
      LOC => "SLICE_X2Y21",
      INIT => '0'
    )
    port map (
      I => hv_count_13_DYMUX_3887,
      CE => hv_count_13_CEINV_3876,
      CLK => hv_count_13_CLKINV_3877,
      SET => GND,
      RST => hv_count_13_FFY_RST,
      O => hv_count(12)
    );
  hv_count_mux0000_10_1 : X_LUT4
    generic map(
      INIT => X"000C",
      LOC => "SLICE_X2Y21"
    )
    port map (
      ADR0 => VCC,
      ADR1 => hv_count_addsub0000(13),
      ADR2 => HV_ON_HMC_OBUF_0,
      ADR3 => count_enable_cmp_eq0000,
      O => hv_count_mux0000(10)
    );
  hv_count_13_FFX_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X2Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_13_SRINVNOT,
      O => hv_count_13_FFX_RST
    );
  hv_count_13 : X_FF
    generic map(
      LOC => "SLICE_X2Y21",
      INIT => '0'
    )
    port map (
      I => hv_count_13_DXMUX_3903,
      CE => hv_count_13_CEINV_3876,
      CLK => hv_count_13_CLKINV_3877,
      SET => GND,
      RST => hv_count_13_FFX_RST,
      O => hv_count(13)
    );
  hv_count_13_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(10),
      O => hv_count_13_DXMUX_3903
    );
  hv_count_13_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(11),
      O => hv_count_13_DYMUX_3887
    );
  hv_count_13_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_13_SRINVNOT
    );
  hv_count_13_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_13_CLKINV_3877
    );
  hv_count_13_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_13_CEINV_3876
    );
  hv_count_mux0000_1_1 : X_LUT4
    generic map(
      INIT => X"0300",
      LOC => "SLICE_X2Y24"
    )
    port map (
      ADR0 => VCC,
      ADR1 => HV_ON_HMC_OBUF_0,
      ADR2 => count_enable_cmp_eq0000,
      ADR3 => hv_count_addsub0000(22),
      O => hv_count_mux0000(1)
    );
  hv_count_23_FFY_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X2Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_23_SRINVNOT,
      O => hv_count_23_FFY_RST
    );
  hv_count_22 : X_FF
    generic map(
      LOC => "SLICE_X2Y24",
      INIT => '0'
    )
    port map (
      I => hv_count_23_DYMUX_3933,
      CE => hv_count_23_CEINV_3922,
      CLK => hv_count_23_CLKINV_3923,
      SET => GND,
      RST => hv_count_23_FFY_RST,
      O => hv_count(22)
    );
  hv_count_mux0000_0_1 : X_LUT4
    generic map(
      INIT => X"000A",
      LOC => "SLICE_X2Y24"
    )
    port map (
      ADR0 => hv_count_addsub0000(23),
      ADR1 => VCC,
      ADR2 => count_enable_cmp_eq0000,
      ADR3 => HV_ON_HMC_OBUF_0,
      O => hv_count_mux0000(0)
    );
  hv_count_23_FFX_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X2Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_23_SRINVNOT,
      O => hv_count_23_FFX_RST
    );
  hv_count_23 : X_FF
    generic map(
      LOC => "SLICE_X2Y24",
      INIT => '0'
    )
    port map (
      I => hv_count_23_DXMUX_3949,
      CE => hv_count_23_CEINV_3922,
      CLK => hv_count_23_CLKINV_3923,
      SET => GND,
      RST => hv_count_23_FFX_RST,
      O => hv_count(23)
    );
  hv_count_23_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(0),
      O => hv_count_23_DXMUX_3949
    );
  hv_count_23_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(1),
      O => hv_count_23_DYMUX_3933
    );
  hv_count_23_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_23_SRINVNOT
    );
  hv_count_23_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_23_CLKINV_3923
    );
  hv_count_23_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_23_CEINV_3922
    );
  hv_count_15_FFX_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X2Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_15_SRINVNOT,
      O => hv_count_15_FFX_RST
    );
  hv_count_15 : X_FF
    generic map(
      LOC => "SLICE_X2Y20",
      INIT => '0'
    )
    port map (
      I => hv_count_15_DXMUX_3995,
      CE => hv_count_15_CEINV_3968,
      CLK => hv_count_15_CLKINV_3969,
      SET => GND,
      RST => hv_count_15_FFX_RST,
      O => hv_count(15)
    );
  hv_count_15_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(8),
      O => hv_count_15_DXMUX_3995
    );
  hv_count_15_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(9),
      O => hv_count_15_DYMUX_3979
    );
  hv_count_15_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_15_SRINVNOT
    );
  hv_count_15_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_15_CLKINV_3969
    );
  hv_count_15_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_15_CEINV_3968
    );
  wg_count_11_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(9),
      O => wg_count_11_DXMUX_4041
    );
  wg_count_11_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(10),
      O => wg_count_11_DYMUX_4025
    );
  wg_count_11_SRINV : X_INV
    generic map(
      LOC => "SLICE_X10Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_count_11_SRINVNOT
    );
  wg_count_11_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_count_11_CLKINV_4015
    );
  wg_count_11_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y5",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001_0,
      O => wg_count_11_CEINV_4014
    );
  state_FSM_FFd1_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X15Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => ops_mode_not0001,
      O => ops_mode_not0001_0
    );
  state_FSM_FFd1_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X15Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_FSM_FFd1_In,
      O => state_FSM_FFd1_DYMUX_4068
    );
  state_FSM_FFd1_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X15Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => state_FSM_FFd1_CLKINV_4058
    );
  hv_count_17_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(6),
      O => hv_count_17_DXMUX_4122
    );
  hv_count_17_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(7),
      O => hv_count_17_DYMUX_4106
    );
  hv_count_17_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_17_SRINVNOT
    );
  hv_count_17_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_17_CLKINV_4096
    );
  hv_count_17_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_17_CEINV_4095
    );
  wg_dly_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_FXMUX_4168,
      O => wg_dly_DXMUX_4169
    );
  wg_dly_FXMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_enable_not0001,
      O => wg_dly_FXMUX_4168
    );
  wg_dly_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(0),
      O => wg_dly_DYMUX_4152
    );
  wg_dly_SRINV : X_INV
    generic map(
      LOC => "SLICE_X12Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_dly_SRINVNOT
    );
  wg_dly_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_dly_CLKINV_4142
    );
  wg_dly_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001_0,
      O => wg_dly_CEINV_4141
    );
  wg_count_13_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(7),
      O => wg_count_13_DXMUX_4215
    );
  wg_count_13_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(8),
      O => wg_count_13_DYMUX_4199
    );
  wg_count_13_SRINV : X_INV
    generic map(
      LOC => "SLICE_X10Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_count_13_SRINVNOT
    );
  wg_count_13_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_count_13_CLKINV_4189
    );
  wg_count_13_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001_0,
      O => wg_count_13_CEINV_4188
    );
  hv_count_19_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(4),
      O => hv_count_19_DXMUX_4261
    );
  hv_count_19_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(5),
      O => hv_count_19_DYMUX_4245
    );
  hv_count_19_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_19_SRINVNOT
    );
  hv_count_19_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_19_CLKINV_4235
    );
  hv_count_19_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_19_CEINV_4234
    );
  wg_count_15_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(5),
      O => wg_count_15_DXMUX_4307
    );
  wg_count_15_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(6),
      O => wg_count_15_DYMUX_4291
    );
  wg_count_15_SRINV : X_INV
    generic map(
      LOC => "SLICE_X10Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_count_15_SRINVNOT
    );
  wg_count_15_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_count_15_CLKINV_4281
    );
  wg_count_15_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001_0,
      O => wg_count_15_CEINV_4280
    );
  wg_count_17_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(3),
      O => wg_count_17_DXMUX_4353
    );
  wg_count_17_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(4),
      O => wg_count_17_DYMUX_4337
    );
  wg_count_17_SRINV : X_INV
    generic map(
      LOC => "SLICE_X10Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_count_17_SRINVNOT
    );
  wg_count_17_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_count_17_CLKINV_4327
    );
  wg_count_17_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001_0,
      O => wg_count_17_CEINV_4326
    );
  ems_tx_count_2_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X23Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_count_mux0002(2),
      O => ems_tx_count_2_DXMUX_4396
    );
  ems_tx_count_2_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X23Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_count_mux0002(3),
      O => ems_tx_count_2_DYMUX_4382
    );
  ems_tx_count_2_SRINV : X_INV
    generic map(
      LOC => "SLICE_X23Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_tx_count_2_SRINVNOT
    );
  ems_tx_count_2_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X23Y7",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_tx_count_2_CLKINV_4372
    );
  end_cycle_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => end_cycle_and0000,
      O => end_cycle_DYMUX_4419
    );
  end_cycle_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => end_cycle_CLKINV_4408
    );
  wg_count_19_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(1),
      O => wg_count_19_DXMUX_4464
    );
  wg_count_19_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(2),
      O => wg_count_19_DYMUX_4448
    );
  wg_count_19_SRINV : X_INV
    generic map(
      LOC => "SLICE_X10Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_count_19_SRINVNOT
    );
  wg_count_19_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_count_19_CLKINV_4438
    );
  wg_count_19_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001_0,
      O => wg_count_19_CEINV_4437
    );
  mod_pulse_error_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y12",
      PATHPULSE => 499 ps
    )
    port map (
      I => mod_pulse_error_and0000,
      O => mod_pulse_error_DXMUX_4507
    );
  mod_pulse_error_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y12",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_1_error_or0000,
      O => mod_pulse_error_DYMUX_4493
    );
  mod_pulse_error_SRINV : X_INV
    generic map(
      LOC => "SLICE_X14Y12",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => mod_pulse_error_SRINVNOT
    );
  mod_pulse_error_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y12",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => mod_pulse_error_CLKINV_4483
    );
  ems_tx_count_enable_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_OUT_4_OBUF_4546,
      O => EMS_OUT_4_OBUF_0
    );
  ems_tx_count_enable_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X18Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_count_enable_and0000,
      O => ems_tx_count_enable_DYMUX_4535
    );
  ems_tx_count_enable_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X18Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_tx_count_enable_CLKINV_4526
    );
  hv_count_1_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(22),
      O => hv_count_1_DXMUX_4587
    );
  hv_count_1_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(23),
      O => hv_count_1_DYMUX_4571
    );
  hv_count_1_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_1_SRINVNOT
    );
  hv_count_1_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_1_CLKINV_4561
    );
  hv_count_1_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_1_CEINV_4560
    );
  hv_count_3_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(20),
      O => hv_count_3_DXMUX_4633
    );
  hv_count_3_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(21),
      O => hv_count_3_DYMUX_4617
    );
  hv_count_3_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_3_SRINVNOT
    );
  hv_count_3_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_3_CLKINV_4607
    );
  hv_count_3_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_3_CEINV_4606
    );
  wg_count_1_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(19),
      O => wg_count_1_DXMUX_4679
    );
  wg_count_1_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(20),
      O => wg_count_1_DYMUX_4663
    );
  wg_count_1_SRINV : X_INV
    generic map(
      LOC => "SLICE_X10Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_count_1_SRINVNOT
    );
  wg_count_1_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_count_1_CLKINV_4653
    );
  wg_count_1_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y0",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001_0,
      O => wg_count_1_CEINV_4652
    );
  hv_count_5_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(18),
      O => hv_count_5_DXMUX_4725
    );
  hv_count_5_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(19),
      O => hv_count_5_DYMUX_4709
    );
  hv_count_5_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_5_SRINVNOT
    );
  hv_count_5_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_5_CLKINV_4699
    );
  hv_count_5_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_5_CEINV_4698
    );
  wg_count_3_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(17),
      O => wg_count_3_DXMUX_4771
    );
  wg_count_3_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(18),
      O => wg_count_3_DYMUX_4755
    );
  wg_count_3_SRINV : X_INV
    generic map(
      LOC => "SLICE_X10Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_count_3_SRINVNOT
    );
  wg_count_3_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_count_3_CLKINV_4745
    );
  wg_count_3_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y1",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001_0,
      O => wg_count_3_CEINV_4744
    );
  hv_count_7_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(16),
      O => hv_count_7_DXMUX_4817
    );
  hv_count_7_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(17),
      O => hv_count_7_DYMUX_4801
    );
  hv_count_7_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_7_SRINVNOT
    );
  hv_count_7_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_7_CLKINV_4791
    );
  hv_count_7_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_7_CEINV_4790
    );
  wg_count_5_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(15),
      O => wg_count_5_DXMUX_4863
    );
  wg_count_5_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X12Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(16),
      O => wg_count_5_DYMUX_4847
    );
  wg_count_5_SRINV : X_INV
    generic map(
      LOC => "SLICE_X12Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_count_5_SRINVNOT
    );
  wg_count_5_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_count_5_CLKINV_4837
    );
  wg_count_5_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X12Y2",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001_0,
      O => wg_count_5_CEINV_4836
    );
  hv_count_9_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(14),
      O => hv_count_9_DXMUX_4909
    );
  hv_count_9_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X2Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_mux0000(15),
      O => hv_count_9_DYMUX_4893
    );
  hv_count_9_SRINV : X_INV
    generic map(
      LOC => "SLICE_X2Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_count_9_SRINVNOT
    );
  hv_count_9_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_count_9_CLKINV_4883
    );
  hv_count_9_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X2Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002_0,
      O => hv_count_9_CEINV_4882
    );
  wg_count_mux0000_13_1 : X_LUT4
    generic map(
      INIT => X"0808",
      LOC => "SLICE_X10Y3"
    )
    port map (
      ADR0 => wg_count_addsub0000(7),
      ADR1 => wg_change_state,
      ADR2 => wg_dly_cmp_eq0000,
      ADR3 => VCC,
      O => wg_count_mux0000(13)
    );
  wg_count_7_FFX_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X10Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_7_SRINVNOT,
      O => wg_count_7_FFX_RST
    );
  wg_count_7 : X_FF
    generic map(
      LOC => "SLICE_X10Y3",
      INIT => '0'
    )
    port map (
      I => wg_count_7_DXMUX_4955,
      CE => wg_count_7_CEINV_4928,
      CLK => wg_count_7_CLKINV_4929,
      SET => GND,
      RST => wg_count_7_FFX_RST,
      O => wg_count(7)
    );
  wg_count_7_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(13),
      O => wg_count_7_DXMUX_4955
    );
  wg_count_7_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(14),
      O => wg_count_7_DYMUX_4939
    );
  wg_count_7_SRINV : X_INV
    generic map(
      LOC => "SLICE_X10Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_count_7_SRINVNOT
    );
  wg_count_7_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_count_7_CLKINV_4929
    );
  wg_count_7_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y3",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001_0,
      O => wg_count_7_CEINV_4928
    );
  wg_count_6 : X_FF
    generic map(
      LOC => "SLICE_X10Y3",
      INIT => '0'
    )
    port map (
      I => wg_count_7_DYMUX_4939,
      CE => wg_count_7_CEINV_4928,
      CLK => wg_count_7_CLKINV_4929,
      SET => GND,
      RST => wg_count_7_SRINVNOT,
      O => wg_count(6)
    );
  wg_count_9_FFY_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X10Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_9_SRINVNOT,
      O => wg_count_9_FFY_RST
    );
  wg_count_8 : X_FF
    generic map(
      LOC => "SLICE_X10Y4",
      INIT => '0'
    )
    port map (
      I => wg_count_9_DYMUX_4985,
      CE => wg_count_9_CEINV_4974,
      CLK => wg_count_9_CLKINV_4975,
      SET => GND,
      RST => wg_count_9_FFY_RST,
      O => wg_count(8)
    );
  wg_count_mux0000_12_1 : X_LUT4
    generic map(
      INIT => X"00C0",
      LOC => "SLICE_X10Y4"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_change_state,
      ADR2 => wg_count_addsub0000(8),
      ADR3 => wg_dly_cmp_eq0000,
      O => wg_count_mux0000(12)
    );
  wg_count_mux0000_11_1 : X_LUT4
    generic map(
      INIT => X"0088",
      LOC => "SLICE_X10Y4"
    )
    port map (
      ADR0 => wg_change_state,
      ADR1 => wg_count_addsub0000(9),
      ADR2 => VCC,
      ADR3 => wg_dly_cmp_eq0000,
      O => wg_count_mux0000(11)
    );
  wg_count_9_FFX_RSTOR : X_BUF
    generic map(
      LOC => "SLICE_X10Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_9_SRINVNOT,
      O => wg_count_9_FFX_RST
    );
  wg_count_9 : X_FF
    generic map(
      LOC => "SLICE_X10Y4",
      INIT => '0'
    )
    port map (
      I => wg_count_9_DXMUX_5001,
      CE => wg_count_9_CEINV_4974,
      CLK => wg_count_9_CLKINV_4975,
      SET => GND,
      RST => wg_count_9_FFX_RST,
      O => wg_count(9)
    );
  wg_count_9_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(11),
      O => wg_count_9_DXMUX_5001
    );
  wg_count_9_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_count_mux0000(12),
      O => wg_count_9_DYMUX_4985
    );
  wg_count_9_SRINV : X_INV
    generic map(
      LOC => "SLICE_X10Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_count_9_SRINVNOT
    );
  wg_count_9_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => wg_count_9_CLKINV_4975
    );
  wg_count_9_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y4",
      PATHPULSE => 499 ps
    )
    port map (
      I => wg_dly_not0001_0,
      O => wg_count_9_CEINV_4974
    );
  Madd_ems_tx_count_addsub0000_cy_2_11 : X_LUT4
    generic map(
      INIT => X"8080",
      LOC => "SLICE_X22Y8"
    )
    port map (
      ADR0 => ems_tx_count(0),
      ADR1 => ems_tx_count(1),
      ADR2 => ems_tx_count(2),
      ADR3 => VCC,
      O => Madd_ems_tx_count_addsub0000_cy_2_pack_2
    );
  ems_tx_count_mux0002_0_1 : X_LUT4
    generic map(
      INIT => X"1444",
      LOC => "SLICE_X22Y8"
    )
    port map (
      ADR0 => tx_dly_not0001_1626,
      ADR1 => ems_tx_count(4),
      ADR2 => ems_tx_count(3),
      ADR3 => Madd_ems_tx_count_addsub0000_cy(2),
      O => ems_tx_count_mux0002(0)
    );
  ems_tx_count_4_FFX_RSTOR : X_INV
    generic map(
      LOC => "SLICE_X22Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_tx_count_4_FFX_RST
    );
  ems_tx_count_4 : X_FF
    generic map(
      LOC => "SLICE_X22Y8",
      INIT => '0'
    )
    port map (
      I => ems_tx_count_4_DXMUX_5037,
      CE => VCC,
      CLK => ems_tx_count_4_CLKINV_5020,
      SET => GND,
      RST => ems_tx_count_4_FFX_RST,
      O => ems_tx_count(4)
    );
  ems_tx_count_4_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X22Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_count_mux0002(0),
      O => ems_tx_count_4_DXMUX_5037
    );
  ems_tx_count_4_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X22Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_ems_tx_count_addsub0000_cy_2_pack_2,
      O => Madd_ems_tx_count_addsub0000_cy(2)
    );
  ems_tx_count_4_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X22Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_tx_count_4_CLKINV_5020
    );
  l_rx_dly_FFY_RSTOR : X_INV
    generic map(
      LOC => "SLICE_X18Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => l_rx_dly_FFY_RST
    );
  l_rx_dly : X_FF
    generic map(
      LOC => "SLICE_X18Y14",
      INIT => '0'
    )
    port map (
      I => l_rx_dly_DYMUX_5051,
      CE => VCC,
      CLK => l_rx_dly_CLKINV_5048,
      SET => GND,
      RST => l_rx_dly_FFY_RST,
      O => l_rx_dly_1584
    );
  l_rx_dly_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X18Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => rx_dly_1553,
      O => l_rx_dly_DYMUX_5051
    );
  l_rx_dly_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X18Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => l_rx_dly_CLKINV_5048
    );
  EMS_OUT_7_OBUF_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y12",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_OUT_7_OBUF_5079,
      O => EMS_OUT_7_OBUF_0
    );
  EMS_OUT_7_OBUF_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y12",
      PATHPULSE => 499 ps
    )
    port map (
      I => N01_pack_1,
      O => N01
    );
  N261_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X21Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => N261,
      O => N261_0
    );
  N261_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X21Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_1_rx_stat_or0000_pack_1,
      O => ems_1_rx_stat_or0000
    );
  ems_67_error_or00005_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X21Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_67_error_or00005_5127,
      O => ems_67_error_or00005_0
    );
  ems_67_error_or00005_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X21Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_error_prt_or000040_5120,
      O => ems_error_prt_or000040_0
    );
  ems_45_error_or000087 : X_LUT4
    generic map(
      INIT => X"3020",
      LOC => "SLICE_X19Y21"
    )
    port map (
      ADR0 => N24_0,
      ADR1 => l_rx_dly_1584,
      ADR2 => rx_dly_1553,
      ADR3 => ems_45_error_or000046_1631,
      O => ems_45_error_or000087_5151
    );
  ems_45_error_or000087_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_45_error_or000087_5151,
      O => ems_45_error_or000087_0
    );
  ems_45_error_or000087_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_45_error_or000046_pack_1,
      O => ems_45_error_or000046_1631
    );
  ems_45_error_or000046 : X_LUT4
    generic map(
      INIT => X"88F8",
      LOC => "SLICE_X19Y21"
    )
    port map (
      ADR0 => BIT_EMS_4_IBUF_0,
      ADR1 => EMS_OUT_2_mux0004,
      ADR2 => ems_45_error_or000031_0,
      ADR3 => BIT_EMS_5_IBUF_0,
      O => ems_45_error_or000046_pack_1
    );
  count_enable_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X5Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => HV_ON_HMC_OBUF_0,
      O => count_enable_DYMUX_5163
    );
  count_enable_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X5Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => count_enable_CLKINV_5160
    );
  count_enable_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X5Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_not0001_0,
      O => count_enable_CEINV_5159
    );
  ems_rx_count_3_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_rx_count_mux0002(1),
      O => ems_rx_count_3_DXMUX_5198
    );
  ems_rx_count_3_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X13Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => rx_dly_not0001_pack_2,
      O => rx_dly_not0001_1624
    );
  ems_rx_count_3_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X13Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_rx_count_3_CLKINV_5181
    );
  ems_45_error_or00005_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_45_error_or00005_5226,
      O => ems_45_error_or00005_0
    );
  ems_45_error_or00005_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_1_error_or00002_5219,
      O => ems_1_error_or00002_0
    );
  ems_tx_count_3_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X23Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_count_mux0002(1),
      O => ems_tx_count_3_DXMUX_5257
    );
  ems_tx_count_3_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X23Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => tx_dly_not0001_pack_2,
      O => tx_dly_not0001_1626
    );
  ems_tx_count_3_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X23Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_tx_count_3_CLKINV_5240
    );
  WG_SW_CTRL_NOISE_OBUF_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X15Y12",
      PATHPULSE => 499 ps
    )
    port map (
      I => WG_SW_CTRL_NOISE_OBUF_5285,
      O => WG_SW_CTRL_NOISE_OBUF_0
    );
  WG_SW_CTRL_NOISE_OBUF_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X15Y12",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_2_error_or000015_5277,
      O => ems_2_error_or000015_0
    );
  N10_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X13Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => N10,
      O => N10_0
    );
  N10_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X13Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => N9,
      O => N9_0
    );
  hv_dly_DYMUX : X_INV
    generic map(
      LOC => "SLICE_X4Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => HV_ON_HMC_OBUF_0,
      O => hv_dly_DYMUX_5321
    );
  hv_dly_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X4Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => hv_dly_CLKINV_5318
    );
  hv_dly_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X4Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_not0001_0,
      O => hv_dly_CEINV_5317
    );
  N22_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => N22,
      O => N22_0
    );
  N22_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => N36_pack_1,
      O => N36
    );
  ems_45_error_or000031_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X17Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_45_error_or000031,
      O => ems_45_error_or000031_0
    );
  ems_45_error_or000031_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X17Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_FSM_FFd2_In2_5366,
      O => state_FSM_FFd2_In2_0
    );
  ems_3_error_or000017_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_3_error_or000017_5398,
      O => ems_3_error_or000017_0
    );
  ems_3_error_or000017_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y25",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_FSM_FFd2_In24_5391,
      O => state_FSM_FFd2_In24_0
    );
  MOD_PULSE_HMC_OBUF_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y20",
      PATHPULSE => 499 ps
    )
    port map (
      I => N24,
      O => N24_0
    );
  ems_error_prt_or000063_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X20Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_error_prt_or000063_5446,
      O => ems_error_prt_or000063_0
    );
  ems_error_prt_or000063_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X20Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => N12_pack_1,
      O => N12
    );
  tx_dly_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X22Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_count_enable_1564,
      O => tx_dly_DYMUX_5458
    );
  tx_dly_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X22Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => tx_dly_CLKINV_5455
    );
  tx_dly_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X22Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => tx_dly_not0001_1626,
      O => tx_dly_CEINV_5454
    );
  ems_error_prt_or0000118_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X21Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_error_prt_or0000118_5475,
      O => ems_error_prt_or0000118_0
    );
  ems_rx_count_4_DXMUX : X_BUF
    generic map(
      LOC => "SLICE_X11Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_rx_count_mux0002(0),
      O => ems_rx_count_4_DXMUX_5506
    );
  ems_rx_count_4_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X11Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => Madd_ems_rx_count_addsub0000_cy_2_pack_2,
      O => Madd_ems_rx_count_addsub0000_cy(2)
    );
  ems_rx_count_4_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X11Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => ems_rx_count_4_CLKINV_5489
    );
  EMS_OUT_2_OBUF_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => N5,
      O => N5_0
    );
  l_ems_trig_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X16Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_TRIG_IBUF_0,
      O => l_ems_trig_DYMUX_5544
    );
  l_ems_trig_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X16Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => l_ems_trig_CLKINV_5541
    );
  l_tx_dly_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X14Y13",
      PATHPULSE => 499 ps
    )
    port map (
      I => tx_dly_1552,
      O => l_tx_dly_DYMUX_5558
    );
  l_tx_dly_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X14Y13",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => l_tx_dly_CLKINV_5555
    );
  ems_error_prt_or000086_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X21Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_error_prt_or000086_5586,
      O => ems_error_prt_or000086_0
    );
  ems_error_prt_or000086_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X21Y24",
      PATHPULSE => 499 ps
    )
    port map (
      I => N20_pack_1,
      O => N20
    );
  hv_count_not0002_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X4Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => hv_count_not0002,
      O => hv_count_not0002_0
    );
  hv_count_not0002_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X4Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => count_enable_not0001,
      O => count_enable_not0001_0
    );
  ems_67_error_or000087_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_67_error_or000087_5634,
      O => ems_67_error_or000087_0
    );
  ems_67_error_or000087_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_67_error_or000046_pack_1,
      O => ems_67_error_or000046_1642
    );
  ems_tx_stat21_XUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_tx_stat21_5658,
      O => ems_tx_stat21_0
    );
  ems_tx_stat21_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X19Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_OUT_2_mux0004_pack_1,
      O => EMS_OUT_2_mux0004
    );
  l_rx_gate_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X10Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => RX_GATE_IBUF_0,
      O => l_rx_gate_DYMUX_5668
    );
  l_rx_gate_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X10Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => l_rx_gate_CLKINV_5665
    );
  EMS_OUT_1_OBUF_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X18Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => WG_SW_CTRL_TERM_OBUF_pack_1,
      O => WG_SW_CTRL_TERM_OBUF_1512
    );
  state_FSM_FFd1_In14_YUSED : X_BUF
    generic map(
      LOC => "SLICE_X14Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => state_cmp_eq0000_pack_1,
      O => state_cmp_eq0000
    );
  rx_dly_DYMUX : X_BUF
    generic map(
      LOC => "SLICE_X13Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_rx_count_enable_1577,
      O => rx_dly_DYMUX_5732
    );
  rx_dly_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X13Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF_1550,
      O => rx_dly_CLKINV_5729
    );
  rx_dly_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X13Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => rx_dly_not0001_1624,
      O => rx_dly_CEINV_5728
    );
  wg_count_20_rt : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X11Y10"
    )
    port map (
      ADR0 => wg_count(20),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => wg_count_20_rt_2567
    );
  hv_count_14 : X_FF
    generic map(
      LOC => "SLICE_X2Y20",
      INIT => '0'
    )
    port map (
      I => hv_count_15_DYMUX_3979,
      CE => hv_count_15_CEINV_3968,
      CLK => hv_count_15_CLKINV_3969,
      SET => GND,
      RST => hv_count_15_SRINVNOT,
      O => hv_count(14)
    );
  hv_count_mux0000_8_1 : X_LUT4
    generic map(
      INIT => X"000A",
      LOC => "SLICE_X2Y20"
    )
    port map (
      ADR0 => hv_count_addsub0000(15),
      ADR1 => VCC,
      ADR2 => HV_ON_HMC_OBUF_0,
      ADR3 => count_enable_cmp_eq0000,
      O => hv_count_mux0000(8)
    );
  ems_rx_count_enable : X_FF
    generic map(
      LOC => "SLICE_X15Y14",
      INIT => '0'
    )
    port map (
      I => ems_rx_count_enable_DXMUX_3724,
      CE => VCC,
      CLK => ems_rx_count_enable_CLKINV_3702,
      SET => GND,
      RST => ems_rx_count_enable_SRINVNOT,
      O => ems_rx_count_enable_1577
    );
  ems_rx_count_enable_and00001 : X_LUT4
    generic map(
      INIT => X"5054",
      LOC => "SLICE_X15Y14"
    )
    port map (
      ADR0 => end_cycle_1607,
      ADR1 => l_ems_trig_1623,
      ADR2 => ems_rx_count_enable_1577,
      ADR3 => EMS_TRIG_IBUF_0,
      O => ems_rx_count_enable_and0000
    );
  ems_tx_ok : X_FF
    generic map(
      LOC => "SLICE_X15Y14",
      INIT => '1'
    )
    port map (
      I => ems_rx_count_enable_DYMUX_3711,
      CE => VCC,
      CLK => ems_rx_count_enable_CLKINV_3702,
      SET => ems_rx_count_enable_SRINVNOT,
      RST => GND,
      O => ems_tx_ok_1587
    );
  ems_tx_ok_and00001 : X_LUT4
    generic map(
      INIT => X"5540",
      LOC => "SLICE_X15Y14"
    )
    port map (
      ADR0 => end_cycle_1607,
      ADR1 => N14,
      ADR2 => ems_tx_stat,
      ADR3 => ems_tx_ok_1587,
      O => ems_tx_ok_and0000
    );
  hv_count_mux0000_9_1 : X_LUT4
    generic map(
      INIT => X"0300",
      LOC => "SLICE_X2Y20"
    )
    port map (
      ADR0 => VCC,
      ADR1 => count_enable_cmp_eq0000,
      ADR2 => HV_ON_HMC_OBUF_0,
      ADR3 => hv_count_addsub0000(14),
      O => hv_count_mux0000(9)
    );
  wg_count_mux0000_10_1 : X_LUT4
    generic map(
      INIT => X"0C00",
      LOC => "SLICE_X10Y5"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_change_state,
      ADR2 => wg_dly_cmp_eq0000,
      ADR3 => wg_count_addsub0000(10),
      O => wg_count_mux0000(10)
    );
  ems_67_error_or00005 : X_LUT4
    generic map(
      INIT => X"2202",
      LOC => "SLICE_X21Y22"
    )
    port map (
      ADR0 => tx_dly_1552,
      ADR1 => l_tx_dly_1561,
      ADR2 => BIT_EMS_6_IBUF_0,
      ADR3 => BIT_EMS_7_IBUF_0,
      O => ems_67_error_or00005_5127
    );
  ems_error_prt_or000040 : X_LUT4
    generic map(
      INIT => X"FF37",
      LOC => "SLICE_X21Y22"
    )
    port map (
      ADR0 => BIT_EMS_2_IBUF_0,
      ADR1 => BIT_EMS_1_IBUF_0,
      ADR2 => BIT_EMS_6_IBUF_0,
      ADR3 => N18,
      O => ems_error_prt_or000040_5120
    );
  ems_3_error_or000026_SW0 : X_LUT4
    generic map(
      INIT => X"BBFB",
      LOC => "SLICE_X21Y17"
    )
    port map (
      ADR0 => l_tx_dly_1561,
      ADR1 => tx_dly_1552,
      ADR2 => BIT_EMS_3_IBUF_0,
      ADR3 => ems_1_rx_stat_or0000,
      O => N261
    );
  ems_1_rx_stat_or00001 : X_LUT4
    generic map(
      INIT => X"C0F3",
      LOC => "SLICE_X21Y17"
    )
    port map (
      ADR0 => VCC,
      ADR1 => ops_mode(0),
      ADR2 => ops_mode(1),
      ADR3 => ops_mode(2),
      O => ems_1_rx_stat_or0000_pack_1
    );
  EMS_OUT_7_Q : X_LUT4
    generic map(
      INIT => X"0042",
      LOC => "SLICE_X18Y12"
    )
    port map (
      ADR0 => ops_mode(0),
      ADR1 => ops_mode(1),
      ADR2 => ops_mode(2),
      ADR3 => N01,
      O => EMS_OUT_7_OBUF_5079
    );
  EMS_OUT_7_SW0 : X_LUT4
    generic map(
      INIT => X"F0F5",
      LOC => "SLICE_X18Y12"
    )
    port map (
      ADR0 => state_FSM_FFd2_1554,
      ADR1 => VCC,
      ADR2 => EMS_TRIG_IBUF_0,
      ADR3 => state_FSM_FFd1_1595,
      O => N01_pack_1
    );
  Madd_hv_count_addsub0000_lut_0_INV_0 : X_LUT4
    generic map(
      INIT => X"00FF",
      LOC => "SLICE_X3Y14"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => hv_count(0),
      O => Madd_hv_count_addsub0000_lut(0)
    );
  hv_count_23_rt : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X3Y25"
    )
    port map (
      ADR0 => VCC,
      ADR1 => hv_count(23),
      ADR2 => VCC,
      ADR3 => VCC,
      O => hv_count_23_rt_2071
    );
  count_enable_cmp_eq0000_wg_lut_1_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X1Y19"
    )
    port map (
      ADR0 => hv_count(9),
      ADR1 => hv_count(10),
      ADR2 => hv_count(11),
      ADR3 => hv_count(3),
      O => count_enable_cmp_eq0000_wg_lut(1)
    );
  count_enable_cmp_eq0000_wg_lut_0_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X1Y19"
    )
    port map (
      ADR0 => hv_count(4),
      ADR1 => hv_count(6),
      ADR2 => hv_count(7),
      ADR3 => hv_count(8),
      O => count_enable_cmp_eq0000_wg_lut(0)
    );
  count_enable_cmp_eq0000_wg_lut_3_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X1Y20"
    )
    port map (
      ADR0 => hv_count(15),
      ADR1 => hv_count(1),
      ADR2 => hv_count(16),
      ADR3 => hv_count(17),
      O => count_enable_cmp_eq0000_wg_lut(3)
    );
  count_enable_cmp_eq0000_wg_lut_2_Q : X_LUT4
    generic map(
      INIT => X"0001",
      LOC => "SLICE_X1Y20"
    )
    port map (
      ADR0 => hv_count(5),
      ADR1 => hv_count(12),
      ADR2 => hv_count(13),
      ADR3 => hv_count(14),
      O => count_enable_cmp_eq0000_wg_lut(2)
    );
  count_enable_cmp_eq0000_wg_lut_5_Q : X_LUT4
    generic map(
      INIT => X"4000",
      LOC => "SLICE_X1Y21"
    )
    port map (
      ADR0 => hv_count(2),
      ADR1 => hv_count(23),
      ADR2 => hv_count(22),
      ADR3 => hv_count(21),
      O => count_enable_cmp_eq0000_wg_lut(5)
    );
  count_enable_cmp_eq0000_wg_lut_4_Q : X_LUT4
    generic map(
      INIT => X"0002",
      LOC => "SLICE_X1Y21"
    )
    port map (
      ADR0 => hv_count(20),
      ADR1 => hv_count(18),
      ADR2 => hv_count(19),
      ADR3 => hv_count(0),
      O => count_enable_cmp_eq0000_wg_lut(4)
    );
  Madd_wg_count_addsub0000_lut_0_INV_0 : X_LUT4
    generic map(
      INIT => X"0F0F",
      LOC => "SLICE_X11Y0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => wg_count(0),
      ADR3 => VCC,
      O => Madd_wg_count_addsub0000_lut(0)
    );
  ops_mode_0 : X_LATCHE
    generic map(
      LOC => "PAD36",
      INIT => '0'
    )
    port map (
      I => OPS_MODE_730_0_IFF_IDDRIN_MUX_2936,
      GE => VCC,
      CLK => NlwInverterSignal_ops_mode_0_CLK,
      SET => GND,
      RST => GND,
      O => ops_mode(0)
    );
  OPS_MODE_730_0_IFF_IDDRIN_MUX : X_BUF
    generic map(
      LOC => "PAD36",
      PATHPULSE => 499 ps
    )
    port map (
      I => OPS_MODE_730_0_IBUF_2943,
      O => OPS_MODE_730_0_IFF_IDDRIN_MUX_2936
    );
  OPS_MODE_730_0_IFF_ICLK1INV : X_INV
    generic map(
      LOC => "PAD36",
      PATHPULSE => 499 ps
    )
    port map (
      I => ops_mode_not0001_0,
      O => OPS_MODE_730_0_IFF_ICLK1INVNOT
    );
  ops_mode_1 : X_LATCHE
    generic map(
      LOC => "IPAD23",
      INIT => '0'
    )
    port map (
      I => OPS_MODE_730_1_IFF_IDDRIN_MUX_2951,
      GE => VCC,
      CLK => NlwInverterSignal_ops_mode_1_CLK,
      SET => GND,
      RST => GND,
      O => ops_mode(1)
    );
  OPS_MODE_730_1_IFF_IDDRIN_MUX : X_BUF
    generic map(
      LOC => "IPAD23",
      PATHPULSE => 499 ps
    )
    port map (
      I => OPS_MODE_730_1_IBUF_2958,
      O => OPS_MODE_730_1_IFF_IDDRIN_MUX_2951
    );
  OPS_MODE_730_1_IFF_ICLK1INV : X_INV
    generic map(
      LOC => "IPAD23",
      PATHPULSE => 499 ps
    )
    port map (
      I => ops_mode_not0001_0,
      O => OPS_MODE_730_1_IFF_ICLK1INVNOT
    );
  ops_mode_2 : X_LATCHE
    generic map(
      LOC => "PAD16",
      INIT => '0'
    )
    port map (
      I => OPS_MODE_730_2_IFF_IDDRIN_MUX_2973,
      GE => VCC,
      CLK => NlwInverterSignal_ops_mode_2_CLK,
      SET => GND,
      RST => GND,
      O => ops_mode(2)
    );
  OPS_MODE_730_2_IFF_IDDRIN_MUX : X_BUF
    generic map(
      LOC => "PAD16",
      PATHPULSE => 499 ps
    )
    port map (
      I => OPS_MODE_730_2_IBUF_2980,
      O => OPS_MODE_730_2_IFF_IDDRIN_MUX_2973
    );
  OPS_MODE_730_2_IFF_ICLK1INV : X_INV
    generic map(
      LOC => "PAD16",
      PATHPULSE => 499 ps
    )
    port map (
      I => ops_mode_not0001_0,
      O => OPS_MODE_730_2_IFF_ICLK1INVNOT
    );
  state_FSM_FFd1_In34_F : X_LUT4
    generic map(
      INIT => X"3FFE",
      LOC => "SLICE_X15Y19"
    )
    port map (
      ADR0 => RX_GATE_IBUF_0,
      ADR1 => rx_dly_1553,
      ADR2 => state_FSM_FFd2_1554,
      ADR3 => tx_dly_1552,
      O => N30
    );
  ems_error_prt_or000040_SW0_F : X_LUT4
    generic map(
      INIT => X"FBF3",
      LOC => "SLICE_X20Y25"
    )
    port map (
      ADR0 => BIT_EMS_5_IBUF_0,
      ADR1 => ops_mode(0),
      ADR2 => ops_mode(1),
      ADR3 => BIT_EMS_6_IBUF_0,
      O => N32
    );
  ems_error_prt_or000040_SW0_G : X_LUT4
    generic map(
      INIT => X"EACA",
      LOC => "SLICE_X20Y25"
    )
    port map (
      ADR0 => BIT_EMS_5_IBUF_0,
      ADR1 => ops_mode(0),
      ADR2 => ops_mode(1),
      ADR3 => BIT_EMS_6_IBUF_0,
      O => N33
    );
  ems_tx_stat341 : X_LUT4
    generic map(
      INIT => X"0800",
      LOC => "SLICE_X20Y24"
    )
    port map (
      ADR0 => BIT_EMS_4_IBUF_0,
      ADR1 => BIT_EMS_3_IBUF_0,
      ADR2 => BIT_EMS_5_IBUF_0,
      ADR3 => BIT_EMS_6_IBUF_0,
      O => ems_tx_stat341_3155
    );
  ems_1_error_or0000111 : X_LUT4
    generic map(
      INIT => X"4444",
      LOC => "SLICE_X14Y15"
    )
    port map (
      ADR0 => l_tx_dly_1561,
      ADR1 => tx_dly_1552,
      ADR2 => VCC,
      ADR3 => VCC,
      O => N14_pack_2
    );
  ems_tx_error_and00001 : X_LUT4
    generic map(
      INIT => X"5510",
      LOC => "SLICE_X14Y15"
    )
    port map (
      ADR0 => STATUS_ACK_IBUF_0,
      ADR1 => ems_tx_stat,
      ADR2 => N14,
      ADR3 => ems_tx_error_1560,
      O => ems_tx_error_and0000
    );
  ems_tx_error : X_FF
    generic map(
      LOC => "SLICE_X14Y15",
      INIT => '0'
    )
    port map (
      I => ems_tx_error_DXMUX_3198,
      CE => VCC,
      CLK => ems_tx_error_CLKINV_3180,
      SET => GND,
      RST => ems_tx_error_FFX_RSTAND_3203,
      O => ems_tx_error_1560
    );
  ems_tx_error_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X14Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_tx_error_FFX_RSTAND_3203
    );
  tx_dly_not0001_SW0 : X_LUT4
    generic map(
      INIT => X"FFBB",
      LOC => "SLICE_X23Y8"
    )
    port map (
      ADR0 => ems_tx_count(4),
      ADR1 => ems_tx_count(2),
      ADR2 => VCC,
      ADR3 => ems_tx_count(3),
      O => N21_pack_2
    );
  ems_tx_count_mux0002_4_1 : X_LUT4
    generic map(
      INIT => X"2220",
      LOC => "SLICE_X23Y8"
    )
    port map (
      ADR0 => ems_tx_count_enable_1564,
      ADR1 => ems_tx_count(0),
      ADR2 => N21,
      ADR3 => ems_tx_count(1),
      O => ems_tx_count_mux0002(4)
    );
  ems_tx_count_0 : X_FF
    generic map(
      LOC => "SLICE_X23Y8",
      INIT => '0'
    )
    port map (
      I => ems_tx_count_0_DXMUX_3233,
      CE => VCC,
      CLK => ems_tx_count_0_CLKINV_3216,
      SET => GND,
      RST => ems_tx_count_0_FFX_RSTAND_3238,
      O => ems_tx_count(0)
    );
  ems_tx_count_0_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X23Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_tx_count_0_FFX_RSTAND_3238
    );
  Mxor_wg_change_state_Result31 : X_LUT4
    generic map(
      INIT => X"8888",
      LOC => "SLICE_X12Y9"
    )
    port map (
      ADR0 => wg_dly_1573,
      ADR1 => RESET_IBUF_0,
      ADR2 => VCC,
      ADR3 => VCC,
      O => N38_pack_2
    );
  wg_count_enable_mux00001 : X_LUT4
    generic map(
      INIT => X"2EEE",
      LOC => "SLICE_X12Y9"
    )
    port map (
      ADR0 => N9_0,
      ADR1 => WG_SW_CTRL_TERM_OBUF_1512,
      ADR2 => N38,
      ADR3 => N10_0,
      O => wg_count_enable_mux0000
    );
  wg_count_enable : X_FF
    generic map(
      LOC => "SLICE_X12Y9",
      INIT => '1'
    )
    port map (
      I => wg_count_enable_DXMUX_3270,
      CE => wg_count_enable_CEINV_3251,
      CLK => wg_count_enable_CLKINV_3252,
      SET => wg_count_enable_FFX_SET,
      RST => GND,
      O => wg_count_enable_1574
    );
  wg_count_enable_FFX_SETOR : X_INV
    generic map(
      LOC => "SLICE_X12Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => wg_count_enable_FFX_SET
    );
  rx_dly_not0001_SW0 : X_LUT4
    generic map(
      INIT => X"FFDD",
      LOC => "SLICE_X11Y19"
    )
    port map (
      ADR0 => ems_rx_count(2),
      ADR1 => ems_rx_count(3),
      ADR2 => VCC,
      ADR3 => ems_rx_count(4),
      O => N4_pack_2
    );
  ems_rx_count_mux0002_4_1 : X_LUT4
    generic map(
      INIT => X"2220",
      LOC => "SLICE_X11Y19"
    )
    port map (
      ADR0 => ems_rx_count_enable_1577,
      ADR1 => ems_rx_count(0),
      ADR2 => ems_rx_count(1),
      ADR3 => N4,
      O => ems_rx_count_mux0002(4)
    );
  ems_rx_count_0 : X_FF
    generic map(
      LOC => "SLICE_X11Y19",
      INIT => '0'
    )
    port map (
      I => ems_rx_count_0_DXMUX_3305,
      CE => VCC,
      CLK => ems_rx_count_0_CLKINV_3288,
      SET => GND,
      RST => ems_rx_count_0_FFX_RSTAND_3310,
      O => ems_rx_count(0)
    );
  ems_rx_count_0_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X11Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_rx_count_0_FFX_RSTAND_3310
    );
  ems_45_error_or0000321 : X_LUT4
    generic map(
      INIT => X"00F0",
      LOC => "SLICE_X19Y14"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => rx_dly_1553,
      ADR3 => l_rx_dly_1584,
      O => N35_pack_1
    );
  ems_1_error_or0000131 : X_LUT4
    generic map(
      INIT => X"F400",
      LOC => "SLICE_X19Y14"
    )
    port map (
      ADR0 => l_tx_dly_1561,
      ADR1 => tx_dly_1552,
      ADR2 => N35,
      ADR3 => ems_1_rx_stat_or0000,
      O => N26
    );
  state_FSM_FFd2_In41 : X_LUT4
    generic map(
      INIT => X"1110",
      LOC => "SLICE_X14Y19"
    )
    port map (
      ADR0 => rx_dly_1553,
      ADR1 => EMS_PWR_ERROR_IBUF_0,
      ADR2 => hv_dly_1589,
      ADR3 => state_cmp_eq0000,
      O => state_FSM_N8_pack_1
    );
  state_FSM_FFd1_In60 : X_LUT4
    generic map(
      INIT => X"C000",
      LOC => "SLICE_X14Y19"
    )
    port map (
      ADR0 => VCC,
      ADR1 => state_FSM_FFd2_1554,
      ADR2 => state_FSM_N8,
      ADR3 => ems_tx_ok_1587,
      O => state_FSM_FFd1_In60_3357
    );
  ems_tx_stat54 : X_LUT4
    generic map(
      INIT => X"CF0F",
      LOC => "SLICE_X20Y23"
    )
    port map (
      ADR0 => VCC,
      ADR1 => ems_tx_stat21_0,
      ADR2 => wg_dly_1573,
      ADR3 => ems_tx_stat34,
      O => ems_tx_stat_pack_1
    );
  ems_error_prt_or00005 : X_LUT4
    generic map(
      INIT => X"FF10",
      LOC => "SLICE_X20Y23"
    )
    port map (
      ADR0 => l_tx_dly_1561,
      ADR1 => ems_tx_stat,
      ADR2 => tx_dly_1552,
      ADR3 => ems_error_prt_1543,
      O => ems_error_prt_or00005_3381
    );
  ems_2_error_or000046_SW0 : X_LUT4
    generic map(
      INIT => X"C0E0",
      LOC => "SLICE_X15Y13"
    )
    port map (
      ADR0 => tx_dly_1552,
      ADR1 => N35,
      ADR2 => wg_dly_1573,
      ADR3 => l_tx_dly_1561,
      O => ems_2_error_or000046_SW0_O_pack_2
    );
  ems_2_error_or000046 : X_LUT4
    generic map(
      INIT => X"3222",
      LOC => "SLICE_X15Y13"
    )
    port map (
      ADR0 => ems_2_error_1520,
      ADR1 => STATUS_ACK_IBUF_0,
      ADR2 => ems_2_error_or000015_0,
      ADR3 => ems_2_error_or000046_SW0_O,
      O => ems_2_error_or0000
    );
  ems_2_error : X_FF
    generic map(
      LOC => "SLICE_X15Y13",
      INIT => '0'
    )
    port map (
      I => ems_2_error_DXMUX_3412,
      CE => VCC,
      CLK => ems_2_error_CLKINV_3396,
      SET => GND,
      RST => ems_2_error_FFX_RSTAND_3417,
      O => ems_2_error_1520
    );
  ems_2_error_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X15Y13",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_2_error_FFX_RSTAND_3417
    );
  state_FSM_FFd2_In92 : X_LUT4
    generic map(
      INIT => X"0210",
      LOC => "SLICE_X12Y18"
    )
    port map (
      ADR0 => WG_SW_TERM_IBUF_0,
      ADR1 => tx_dly_1552,
      ADR2 => WG_SW_NOISE_IBUF_0,
      ADR3 => WG_SW_CTRL_TERM_OBUF_1512,
      O => state_FSM_FFd2_In92_O_pack_1
    );
  state_FSM_FFd2_In106_SW0 : X_LUT4
    generic map(
      INIT => X"BFFF",
      LOC => "SLICE_X12Y18"
    )
    port map (
      ADR0 => state_FSM_FFd1_1595,
      ADR1 => state_FSM_N8,
      ADR2 => wg_dly_1573,
      ADR3 => state_FSM_FFd2_In92_O,
      O => N28
    );
  state_FSM_FFd2_In36 : X_LUT4
    generic map(
      INIT => X"5554",
      LOC => "SLICE_X17Y23"
    )
    port map (
      ADR0 => EMS_PWR_ERROR_IBUF_0,
      ADR1 => ops_mode(1),
      ADR2 => hv_dly_1589,
      ADR3 => state_FSM_FFd2_In24_0,
      O => state_FSM_FFd2_In36_O_pack_1
    );
  state_FSM_FFd2_In114_SW0 : X_LUT4
    generic map(
      INIT => X"C4C7",
      LOC => "SLICE_X17Y23"
    )
    port map (
      ADR0 => state_FSM_FFd2_In2_0,
      ADR1 => state_FSM_FFd1_1595,
      ADR2 => rx_dly_1553,
      ADR3 => state_FSM_FFd2_In36_O,
      O => N141
    );
  state_FSM_FFd2_In106 : X_LUT4
    generic map(
      INIT => X"4000",
      LOC => "SLICE_X14Y22"
    )
    port map (
      ADR0 => N28_0,
      ADR1 => EMS_TRIG_IBUF_0,
      ADR2 => SPARE2_OBUF_0,
      ADR3 => RESET_IBUF_0,
      O => state_FSM_FFd2_In106_O_pack_3
    );
  state_FSM_FFd2_In114 : X_LUT4
    generic map(
      INIT => X"FF2A",
      LOC => "SLICE_X14Y22"
    )
    port map (
      ADR0 => state_FSM_FFd2_1554,
      ADR1 => N141_0,
      ADR2 => tx_dly_1552,
      ADR3 => state_FSM_FFd2_In106_O,
      O => state_FSM_FFd2_In
    );
  state_FSM_FFd2 : X_FF
    generic map(
      LOC => "SLICE_X14Y22",
      INIT => '0'
    )
    port map (
      I => state_FSM_FFd2_DXMUX_3495,
      CE => VCC,
      CLK => state_FSM_FFd2_CLKINV_3479,
      SET => GND,
      RST => state_FSM_FFd2_FFX_RSTAND_3500,
      O => state_FSM_FFd2_1554
    );
  state_FSM_FFd2_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X14Y22",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => state_FSM_FFd2_FFX_RSTAND_3500
    );
  ems_45_error_or0000115 : X_LUT4
    generic map(
      INIT => X"F0E0",
      LOC => "SLICE_X18Y16"
    )
    port map (
      ADR0 => N26_0,
      ADR1 => ems_45_error_or000087_0,
      ADR2 => wg_dly_1573,
      ADR3 => ems_45_error_or00005_0,
      O => ems_45_error_or0000115_O_pack_2
    );
  ems_45_error_or0000142 : X_LUT4
    generic map(
      INIT => X"0F0C",
      LOC => "SLICE_X18Y16"
    )
    port map (
      ADR0 => VCC,
      ADR1 => ems_45_error_1509,
      ADR2 => STATUS_ACK_IBUF_0,
      ADR3 => ems_45_error_or0000115_O,
      O => ems_45_error_or0000
    );
  ems_45_error : X_FF
    generic map(
      LOC => "SLICE_X18Y16",
      INIT => '0'
    )
    port map (
      I => ems_45_error_DXMUX_3530,
      CE => VCC,
      CLK => ems_45_error_CLKINV_3513,
      SET => GND,
      RST => ems_45_error_FFX_RSTAND_3535,
      O => ems_45_error_1509
    );
  ems_45_error_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X18Y16",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_45_error_FFX_RSTAND_3535
    );
  ems_error_prt_or0000121 : X_LUT4
    generic map(
      INIT => X"AAA8",
      LOC => "SLICE_X21Y23"
    )
    port map (
      ADR0 => ems_error_prt_or0000118_0,
      ADR1 => ems_error_prt_or000086_0,
      ADR2 => ems_error_prt_or000040_0,
      ADR3 => ems_error_prt_or000063_0,
      O => ems_error_prt_or0000121_O_pack_1
    );
  ems_error_prt_or0000147 : X_LUT4
    generic map(
      INIT => X"3330",
      LOC => "SLICE_X21Y23"
    )
    port map (
      ADR0 => VCC,
      ADR1 => end_cycle_1607,
      ADR2 => ems_error_prt_or00005_0,
      ADR3 => ems_error_prt_or0000121_O,
      O => ems_error_prt_or0000
    );
  ems_error_prt : X_FF
    generic map(
      LOC => "SLICE_X21Y23",
      INIT => '0'
    )
    port map (
      I => ems_error_prt_DXMUX_3565,
      CE => VCC,
      CLK => ems_error_prt_CLKINV_3548,
      SET => GND,
      RST => ems_error_prt_FFX_RSTAND_3570,
      O => ems_error_prt_1543
    );
  ems_error_prt_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X21Y23",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_error_prt_FFX_RSTAND_3570
    );
  ems_67_error_or0000115 : X_LUT4
    generic map(
      INIT => X"FE00",
      LOC => "SLICE_X19Y15"
    )
    port map (
      ADR0 => ems_67_error_or000087_0,
      ADR1 => N26_0,
      ADR2 => ems_67_error_or00005_0,
      ADR3 => wg_dly_1573,
      O => ems_67_error_or0000115_O_pack_2
    );
  ems_67_error_or0000142 : X_LUT4
    generic map(
      INIT => X"3322",
      LOC => "SLICE_X19Y15"
    )
    port map (
      ADR0 => ems_67_error_1510,
      ADR1 => STATUS_ACK_IBUF_0,
      ADR2 => VCC,
      ADR3 => ems_67_error_or0000115_O,
      O => ems_67_error_or0000
    );
  ems_67_error : X_FF
    generic map(
      LOC => "SLICE_X19Y15",
      INIT => '0'
    )
    port map (
      I => ems_67_error_DXMUX_3600,
      CE => VCC,
      CLK => ems_67_error_CLKINV_3583,
      SET => GND,
      RST => ems_67_error_FFX_RSTAND_3605,
      O => ems_67_error_1510
    );
  ems_67_error_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X19Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_67_error_FFX_RSTAND_3605
    );
  ems_3_error_or000026 : X_LUT4
    generic map(
      INIT => X"3B33",
      LOC => "SLICE_X18Y17"
    )
    port map (
      ADR0 => ems_3_error_or000017_0,
      ADR1 => N261_0,
      ADR2 => l_rx_dly_1584,
      ADR3 => rx_dly_1553,
      O => ems_3_error_or000026_O_pack_2
    );
  ems_3_error_or000061 : X_LUT4
    generic map(
      INIT => X"5540",
      LOC => "SLICE_X18Y17"
    )
    port map (
      ADR0 => STATUS_ACK_IBUF_0,
      ADR1 => wg_dly_1573,
      ADR2 => ems_3_error_or000026_O,
      ADR3 => ems_3_error_1522,
      O => ems_3_error_or0000
    );
  ems_3_error : X_FF
    generic map(
      LOC => "SLICE_X18Y17",
      INIT => '0'
    )
    port map (
      I => ems_3_error_DXMUX_3635,
      CE => VCC,
      CLK => ems_3_error_CLKINV_3619,
      SET => GND,
      RST => ems_3_error_FFX_RSTAND_3640,
      O => ems_3_error_1522
    );
  ems_3_error_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X18Y17",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_3_error_FFX_RSTAND_3640
    );
  Mxor_wg_change_state_Result : X_LUT4
    generic map(
      INIT => X"808F",
      LOC => "SLICE_X13Y8"
    )
    port map (
      ADR0 => N10_0,
      ADR1 => N38,
      ADR2 => WG_SW_CTRL_TERM_OBUF_1512,
      ADR3 => N9_0,
      O => wg_change_state_pack_1
    );
  wg_dly_not00011 : X_LUT4
    generic map(
      INIT => X"EFEF",
      LOC => "SLICE_X13Y8"
    )
    port map (
      ADR0 => wg_count_enable_1574,
      ADR1 => wg_dly_cmp_eq0000,
      ADR2 => wg_change_state,
      ADR3 => VCC,
      O => wg_dly_not0001
    );
  ems_1_error_or000016 : X_LUT4
    generic map(
      INIT => X"00DC",
      LOC => "SLICE_X18Y15"
    )
    port map (
      ADR0 => WG_SW_CTRL_TERM_OBUF_1512,
      ADR1 => N35,
      ADR2 => N14,
      ADR3 => BIT_EMS_1_IBUF_0,
      O => ems_1_error_or000016_O_pack_1
    );
  ems_1_error_or000029 : X_LUT4
    generic map(
      INIT => X"AAA8",
      LOC => "SLICE_X18Y15"
    )
    port map (
      ADR0 => wg_dly_1573,
      ADR1 => N26_0,
      ADR2 => ems_1_error_or000016_O,
      ADR3 => ems_1_error_or00002_0,
      O => ems_1_error_or000029_3687
    );
  wg_count_10 : X_FF
    generic map(
      LOC => "SLICE_X10Y5",
      INIT => '0'
    )
    port map (
      I => wg_count_11_DYMUX_4025,
      CE => wg_count_11_CEINV_4014,
      CLK => wg_count_11_CLKINV_4015,
      SET => GND,
      RST => wg_count_11_SRINVNOT,
      O => wg_count(10)
    );
  wg_count_mux0000_9_1 : X_LUT4
    generic map(
      INIT => X"0088",
      LOC => "SLICE_X10Y5"
    )
    port map (
      ADR0 => wg_count_addsub0000(11),
      ADR1 => wg_change_state,
      ADR2 => VCC,
      ADR3 => wg_dly_cmp_eq0000,
      O => wg_count_mux0000(9)
    );
  wg_count_11 : X_FF
    generic map(
      LOC => "SLICE_X10Y5",
      INIT => '0'
    )
    port map (
      I => wg_count_11_DXMUX_4041,
      CE => wg_count_11_CEINV_4014,
      CLK => wg_count_11_CLKINV_4015,
      SET => GND,
      RST => wg_count_11_SRINVNOT,
      O => wg_count(11)
    );
  state_FSM_FFd1_In62 : X_LUT4
    generic map(
      INIT => X"F8F8",
      LOC => "SLICE_X15Y18"
    )
    port map (
      ADR0 => state_FSM_FFd1_In34,
      ADR1 => state_FSM_FFd1_1595,
      ADR2 => state_FSM_FFd1_In60_0,
      ADR3 => VCC,
      O => state_FSM_FFd1_In
    );
  state_FSM_FFd1 : X_FF
    generic map(
      LOC => "SLICE_X15Y18",
      INIT => '0'
    )
    port map (
      I => state_FSM_FFd1_DYMUX_4068,
      CE => VCC,
      CLK => state_FSM_FFd1_CLKINV_4058,
      SET => GND,
      RST => state_FSM_FFd1_FFY_RSTAND_4073,
      O => state_FSM_FFd1_1595
    );
  state_FSM_FFd1_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X15Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => state_FSM_FFd1_FFY_RSTAND_4073
    );
  ops_mode_not00011 : X_LUT4
    generic map(
      INIT => X"0505",
      LOC => "SLICE_X15Y18"
    )
    port map (
      ADR0 => state_FSM_FFd1_1595,
      ADR1 => VCC,
      ADR2 => state_FSM_FFd2_1554,
      ADR3 => VCC,
      O => ops_mode_not0001
    );
  hv_count_mux0000_7_1 : X_LUT4
    generic map(
      INIT => X"0030",
      LOC => "SLICE_X2Y22"
    )
    port map (
      ADR0 => VCC,
      ADR1 => count_enable_cmp_eq0000,
      ADR2 => hv_count_addsub0000(16),
      ADR3 => HV_ON_HMC_OBUF_0,
      O => hv_count_mux0000(7)
    );
  hv_count_16 : X_FF
    generic map(
      LOC => "SLICE_X2Y22",
      INIT => '0'
    )
    port map (
      I => hv_count_17_DYMUX_4106,
      CE => hv_count_17_CEINV_4095,
      CLK => hv_count_17_CLKINV_4096,
      SET => GND,
      RST => hv_count_17_SRINVNOT,
      O => hv_count(16)
    );
  hv_count_mux0000_6_1 : X_LUT4
    generic map(
      INIT => X"0044",
      LOC => "SLICE_X2Y22"
    )
    port map (
      ADR0 => count_enable_cmp_eq0000,
      ADR1 => hv_count_addsub0000(17),
      ADR2 => VCC,
      ADR3 => HV_ON_HMC_OBUF_0,
      O => hv_count_mux0000(6)
    );
  hv_count_17 : X_FF
    generic map(
      LOC => "SLICE_X2Y22",
      INIT => '0'
    )
    port map (
      I => hv_count_17_DXMUX_4122,
      CE => hv_count_17_CEINV_4095,
      CLK => hv_count_17_CLKINV_4096,
      SET => GND,
      RST => hv_count_17_SRINVNOT,
      O => hv_count(17)
    );
  wg_count_mux0000_0_1 : X_LUT4
    generic map(
      INIT => X"4040",
      LOC => "SLICE_X12Y8"
    )
    port map (
      ADR0 => wg_dly_cmp_eq0000,
      ADR1 => wg_change_state,
      ADR2 => wg_count_addsub0000(20),
      ADR3 => VCC,
      O => wg_count_mux0000(0)
    );
  wg_count_20 : X_FF
    generic map(
      LOC => "SLICE_X12Y8",
      INIT => '0'
    )
    port map (
      I => wg_dly_DYMUX_4152,
      CE => wg_dly_CEINV_4141,
      CLK => wg_dly_CLKINV_4142,
      SET => GND,
      RST => wg_dly_SRINVNOT,
      O => wg_count(20)
    );
  wg_count_enable_not00011 : X_LUT4
    generic map(
      INIT => X"F3F3",
      LOC => "SLICE_X12Y8"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_change_state,
      ADR2 => wg_dly_cmp_eq0000,
      ADR3 => VCC,
      O => wg_count_enable_not0001
    );
  wg_dly : X_FF
    generic map(
      LOC => "SLICE_X12Y8",
      INIT => '0'
    )
    port map (
      I => wg_dly_DXMUX_4169,
      CE => wg_dly_CEINV_4141,
      CLK => wg_dly_CLKINV_4142,
      SET => GND,
      RST => wg_dly_SRINVNOT,
      O => wg_dly_1573
    );
  wg_count_mux0000_8_1 : X_LUT4
    generic map(
      INIT => X"00A0",
      LOC => "SLICE_X10Y7"
    )
    port map (
      ADR0 => wg_change_state,
      ADR1 => VCC,
      ADR2 => wg_count_addsub0000(12),
      ADR3 => wg_dly_cmp_eq0000,
      O => wg_count_mux0000(8)
    );
  wg_count_12 : X_FF
    generic map(
      LOC => "SLICE_X10Y7",
      INIT => '0'
    )
    port map (
      I => wg_count_13_DYMUX_4199,
      CE => wg_count_13_CEINV_4188,
      CLK => wg_count_13_CLKINV_4189,
      SET => GND,
      RST => wg_count_13_SRINVNOT,
      O => wg_count(12)
    );
  wg_count_mux0000_7_1 : X_LUT4
    generic map(
      INIT => X"00C0",
      LOC => "SLICE_X10Y7"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_count_addsub0000(13),
      ADR2 => wg_change_state,
      ADR3 => wg_dly_cmp_eq0000,
      O => wg_count_mux0000(7)
    );
  wg_count_13 : X_FF
    generic map(
      LOC => "SLICE_X10Y7",
      INIT => '0'
    )
    port map (
      I => wg_count_13_DXMUX_4215,
      CE => wg_count_13_CEINV_4188,
      CLK => wg_count_13_CLKINV_4189,
      SET => GND,
      RST => wg_count_13_SRINVNOT,
      O => wg_count(13)
    );
  hv_count_mux0000_5_1 : X_LUT4
    generic map(
      INIT => X"1100",
      LOC => "SLICE_X2Y23"
    )
    port map (
      ADR0 => count_enable_cmp_eq0000,
      ADR1 => HV_ON_HMC_OBUF_0,
      ADR2 => VCC,
      ADR3 => hv_count_addsub0000(18),
      O => hv_count_mux0000(5)
    );
  hv_count_18 : X_FF
    generic map(
      LOC => "SLICE_X2Y23",
      INIT => '0'
    )
    port map (
      I => hv_count_19_DYMUX_4245,
      CE => hv_count_19_CEINV_4234,
      CLK => hv_count_19_CLKINV_4235,
      SET => GND,
      RST => hv_count_19_SRINVNOT,
      O => hv_count(18)
    );
  hv_count_mux0000_4_1 : X_LUT4
    generic map(
      INIT => X"0022",
      LOC => "SLICE_X2Y23"
    )
    port map (
      ADR0 => hv_count_addsub0000(19),
      ADR1 => count_enable_cmp_eq0000,
      ADR2 => VCC,
      ADR3 => HV_ON_HMC_OBUF_0,
      O => hv_count_mux0000(4)
    );
  hv_count_19 : X_FF
    generic map(
      LOC => "SLICE_X2Y23",
      INIT => '0'
    )
    port map (
      I => hv_count_19_DXMUX_4261,
      CE => hv_count_19_CEINV_4234,
      CLK => hv_count_19_CLKINV_4235,
      SET => GND,
      RST => hv_count_19_SRINVNOT,
      O => hv_count(19)
    );
  wg_count_mux0000_6_1 : X_LUT4
    generic map(
      INIT => X"3000",
      LOC => "SLICE_X10Y6"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_dly_cmp_eq0000,
      ADR2 => wg_change_state,
      ADR3 => wg_count_addsub0000(14),
      O => wg_count_mux0000(6)
    );
  wg_count_14 : X_FF
    generic map(
      LOC => "SLICE_X10Y6",
      INIT => '0'
    )
    port map (
      I => wg_count_15_DYMUX_4291,
      CE => wg_count_15_CEINV_4280,
      CLK => wg_count_15_CLKINV_4281,
      SET => GND,
      RST => wg_count_15_SRINVNOT,
      O => wg_count(14)
    );
  wg_count_mux0000_5_1 : X_LUT4
    generic map(
      INIT => X"00A0",
      LOC => "SLICE_X10Y6"
    )
    port map (
      ADR0 => wg_count_addsub0000(15),
      ADR1 => VCC,
      ADR2 => wg_change_state,
      ADR3 => wg_dly_cmp_eq0000,
      O => wg_count_mux0000(5)
    );
  wg_count_15 : X_FF
    generic map(
      LOC => "SLICE_X10Y6",
      INIT => '0'
    )
    port map (
      I => wg_count_15_DXMUX_4307,
      CE => wg_count_15_CEINV_4280,
      CLK => wg_count_15_CLKINV_4281,
      SET => GND,
      RST => wg_count_15_SRINVNOT,
      O => wg_count(15)
    );
  wg_count_mux0000_4_1 : X_LUT4
    generic map(
      INIT => X"00A0",
      LOC => "SLICE_X10Y9"
    )
    port map (
      ADR0 => wg_change_state,
      ADR1 => VCC,
      ADR2 => wg_count_addsub0000(16),
      ADR3 => wg_dly_cmp_eq0000,
      O => wg_count_mux0000(4)
    );
  wg_count_16 : X_FF
    generic map(
      LOC => "SLICE_X10Y9",
      INIT => '0'
    )
    port map (
      I => wg_count_17_DYMUX_4337,
      CE => wg_count_17_CEINV_4326,
      CLK => wg_count_17_CLKINV_4327,
      SET => GND,
      RST => wg_count_17_SRINVNOT,
      O => wg_count(16)
    );
  wg_count_mux0000_3_1 : X_LUT4
    generic map(
      INIT => X"0808",
      LOC => "SLICE_X10Y9"
    )
    port map (
      ADR0 => wg_change_state,
      ADR1 => wg_count_addsub0000(17),
      ADR2 => wg_dly_cmp_eq0000,
      ADR3 => VCC,
      O => wg_count_mux0000(3)
    );
  wg_count_17 : X_FF
    generic map(
      LOC => "SLICE_X10Y9",
      INIT => '0'
    )
    port map (
      I => wg_count_17_DXMUX_4353,
      CE => wg_count_17_CEINV_4326,
      CLK => wg_count_17_CLKINV_4327,
      SET => GND,
      RST => wg_count_17_SRINVNOT,
      O => wg_count(17)
    );
  ems_tx_count_mux0002_3_1 : X_LUT4
    generic map(
      INIT => X"4488",
      LOC => "SLICE_X23Y7"
    )
    port map (
      ADR0 => ems_tx_count(0),
      ADR1 => ems_tx_count_enable_1564,
      ADR2 => VCC,
      ADR3 => ems_tx_count(1),
      O => ems_tx_count_mux0002(3)
    );
  ems_tx_count_1 : X_FF
    generic map(
      LOC => "SLICE_X23Y7",
      INIT => '0'
    )
    port map (
      I => ems_tx_count_2_DYMUX_4382,
      CE => VCC,
      CLK => ems_tx_count_2_CLKINV_4372,
      SET => GND,
      RST => ems_tx_count_2_SRINVNOT,
      O => ems_tx_count(1)
    );
  ems_tx_count_mux0002_2_1 : X_LUT4
    generic map(
      INIT => X"0708",
      LOC => "SLICE_X23Y7"
    )
    port map (
      ADR0 => ems_tx_count(0),
      ADR1 => ems_tx_count(1),
      ADR2 => tx_dly_not0001_1626,
      ADR3 => ems_tx_count(2),
      O => ems_tx_count_mux0002(2)
    );
  ems_tx_count_2 : X_FF
    generic map(
      LOC => "SLICE_X23Y7",
      INIT => '0'
    )
    port map (
      I => ems_tx_count_2_DXMUX_4396,
      CE => VCC,
      CLK => ems_tx_count_2_CLKINV_4372,
      SET => GND,
      RST => ems_tx_count_2_SRINVNOT,
      O => ems_tx_count(2)
    );
  end_cycle_and00001 : X_LUT4
    generic map(
      INIT => X"00F0",
      LOC => "SLICE_X14Y14"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => l_rx_gate_1627,
      ADR3 => RX_GATE_IBUF_0,
      O => end_cycle_and0000
    );
  end_cycle : X_FF
    generic map(
      LOC => "SLICE_X14Y14",
      INIT => '0'
    )
    port map (
      I => end_cycle_DYMUX_4419,
      CE => VCC,
      CLK => end_cycle_CLKINV_4408,
      SET => GND,
      RST => end_cycle_FFY_RSTAND_4424,
      O => end_cycle_1607
    );
  end_cycle_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X14Y14",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => end_cycle_FFY_RSTAND_4424
    );
  wg_count_mux0000_2_1 : X_LUT4
    generic map(
      INIT => X"0A00",
      LOC => "SLICE_X10Y8"
    )
    port map (
      ADR0 => wg_change_state,
      ADR1 => VCC,
      ADR2 => wg_dly_cmp_eq0000,
      ADR3 => wg_count_addsub0000(18),
      O => wg_count_mux0000(2)
    );
  wg_count_18 : X_FF
    generic map(
      LOC => "SLICE_X10Y8",
      INIT => '0'
    )
    port map (
      I => wg_count_19_DYMUX_4448,
      CE => wg_count_19_CEINV_4437,
      CLK => wg_count_19_CLKINV_4438,
      SET => GND,
      RST => wg_count_19_SRINVNOT,
      O => wg_count(18)
    );
  wg_count_mux0000_1_1 : X_LUT4
    generic map(
      INIT => X"0808",
      LOC => "SLICE_X10Y8"
    )
    port map (
      ADR0 => wg_count_addsub0000(19),
      ADR1 => wg_change_state,
      ADR2 => wg_dly_cmp_eq0000,
      ADR3 => VCC,
      O => wg_count_mux0000(1)
    );
  wg_count_19 : X_FF
    generic map(
      LOC => "SLICE_X10Y8",
      INIT => '0'
    )
    port map (
      I => wg_count_19_DXMUX_4464,
      CE => wg_count_19_CEINV_4437,
      CLK => wg_count_19_CLKINV_4438,
      SET => GND,
      RST => wg_count_19_SRINVNOT,
      O => wg_count(19)
    );
  ems_1_error_or000051 : X_LUT4
    generic map(
      INIT => X"0F0C",
      LOC => "SLICE_X14Y12"
    )
    port map (
      ADR0 => VCC,
      ADR1 => ems_1_error_or000029_0,
      ADR2 => STATUS_ACK_IBUF_0,
      ADR3 => ems_1_error_1519,
      O => ems_1_error_or0000
    );
  ems_1_error : X_FF
    generic map(
      LOC => "SLICE_X14Y12",
      INIT => '0'
    )
    port map (
      I => mod_pulse_error_DYMUX_4493,
      CE => VCC,
      CLK => mod_pulse_error_CLKINV_4483,
      SET => GND,
      RST => mod_pulse_error_SRINVNOT,
      O => ems_1_error_1519
    );
  mod_pulse_error_and00001 : X_LUT4
    generic map(
      INIT => X"0F0E",
      LOC => "SLICE_X14Y12"
    )
    port map (
      ADR0 => ems_tx_error_1560,
      ADR1 => mod_pulse_error_1529,
      ADR2 => STATUS_ACK_IBUF_0,
      ADR3 => EMS_PWR_ERROR_IBUF_0,
      O => mod_pulse_error_and0000
    );
  mod_pulse_error : X_FF
    generic map(
      LOC => "SLICE_X14Y12",
      INIT => '0'
    )
    port map (
      I => mod_pulse_error_DXMUX_4507,
      CE => VCC,
      CLK => mod_pulse_error_CLKINV_4483,
      SET => GND,
      RST => mod_pulse_error_SRINVNOT,
      O => mod_pulse_error_1529
    );
  ems_tx_count_enable_and00001 : X_LUT4
    generic map(
      INIT => X"00F2",
      LOC => "SLICE_X18Y9"
    )
    port map (
      ADR0 => EMS_TRIG_IBUF_0,
      ADR1 => l_ems_trig_1623,
      ADR2 => ems_tx_count_enable_1564,
      ADR3 => end_cycle_1607,
      O => ems_tx_count_enable_and0000
    );
  ems_tx_count_enable : X_FF
    generic map(
      LOC => "SLICE_X18Y9",
      INIT => '0'
    )
    port map (
      I => ems_tx_count_enable_DYMUX_4535,
      CE => VCC,
      CLK => ems_tx_count_enable_CLKINV_4526,
      SET => GND,
      RST => ems_tx_count_enable_FFY_RSTAND_4540,
      O => ems_tx_count_enable_1564
    );
  ems_tx_count_enable_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X18Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_tx_count_enable_FFY_RSTAND_4540
    );
  EMS_OUT_4_1 : X_LUT4
    generic map(
      INIT => X"20FF",
      LOC => "SLICE_X18Y9"
    )
    port map (
      ADR0 => N5_0,
      ADR1 => ems_1_rx_stat_or0000,
      ADR2 => EMS_TRIG_IBUF_0,
      ADR3 => WG_SW_CTRL_TERM_OBUF_1512,
      O => EMS_OUT_4_OBUF_4546
    );
  hv_count_mux0000_23_1 : X_LUT4
    generic map(
      INIT => X"0050",
      LOC => "SLICE_X2Y14"
    )
    port map (
      ADR0 => count_enable_cmp_eq0000,
      ADR1 => VCC,
      ADR2 => hv_count_addsub0000(0),
      ADR3 => HV_ON_HMC_OBUF_0,
      O => hv_count_mux0000(23)
    );
  hv_count_0 : X_FF
    generic map(
      LOC => "SLICE_X2Y14",
      INIT => '0'
    )
    port map (
      I => hv_count_1_DYMUX_4571,
      CE => hv_count_1_CEINV_4560,
      CLK => hv_count_1_CLKINV_4561,
      SET => GND,
      RST => hv_count_1_SRINVNOT,
      O => hv_count(0)
    );
  hv_count_mux0000_22_1 : X_LUT4
    generic map(
      INIT => X"0404",
      LOC => "SLICE_X2Y14"
    )
    port map (
      ADR0 => HV_ON_HMC_OBUF_0,
      ADR1 => hv_count_addsub0000(1),
      ADR2 => count_enable_cmp_eq0000,
      ADR3 => VCC,
      O => hv_count_mux0000(22)
    );
  hv_count_1 : X_FF
    generic map(
      LOC => "SLICE_X2Y14",
      INIT => '0'
    )
    port map (
      I => hv_count_1_DXMUX_4587,
      CE => hv_count_1_CEINV_4560,
      CLK => hv_count_1_CLKINV_4561,
      SET => GND,
      RST => hv_count_1_SRINVNOT,
      O => hv_count(1)
    );
  hv_count_mux0000_21_1 : X_LUT4
    generic map(
      INIT => X"1100",
      LOC => "SLICE_X2Y15"
    )
    port map (
      ADR0 => count_enable_cmp_eq0000,
      ADR1 => HV_ON_HMC_OBUF_0,
      ADR2 => VCC,
      ADR3 => hv_count_addsub0000(2),
      O => hv_count_mux0000(21)
    );
  hv_count_2 : X_FF
    generic map(
      LOC => "SLICE_X2Y15",
      INIT => '0'
    )
    port map (
      I => hv_count_3_DYMUX_4617,
      CE => hv_count_3_CEINV_4606,
      CLK => hv_count_3_CLKINV_4607,
      SET => GND,
      RST => hv_count_3_SRINVNOT,
      O => hv_count(2)
    );
  hv_count_mux0000_20_1 : X_LUT4
    generic map(
      INIT => X"1010",
      LOC => "SLICE_X2Y15"
    )
    port map (
      ADR0 => HV_ON_HMC_OBUF_0,
      ADR1 => count_enable_cmp_eq0000,
      ADR2 => hv_count_addsub0000(3),
      ADR3 => VCC,
      O => hv_count_mux0000(20)
    );
  hv_count_3 : X_FF
    generic map(
      LOC => "SLICE_X2Y15",
      INIT => '0'
    )
    port map (
      I => hv_count_3_DXMUX_4633,
      CE => hv_count_3_CEINV_4606,
      CLK => hv_count_3_CLKINV_4607,
      SET => GND,
      RST => hv_count_3_SRINVNOT,
      O => hv_count(3)
    );
  wg_count_mux0000_20_1 : X_LUT4
    generic map(
      INIT => X"00A0",
      LOC => "SLICE_X10Y0"
    )
    port map (
      ADR0 => wg_change_state,
      ADR1 => VCC,
      ADR2 => wg_count_addsub0000(0),
      ADR3 => wg_dly_cmp_eq0000,
      O => wg_count_mux0000(20)
    );
  wg_count_0 : X_FF
    generic map(
      LOC => "SLICE_X10Y0",
      INIT => '0'
    )
    port map (
      I => wg_count_1_DYMUX_4663,
      CE => wg_count_1_CEINV_4652,
      CLK => wg_count_1_CLKINV_4653,
      SET => GND,
      RST => wg_count_1_SRINVNOT,
      O => wg_count(0)
    );
  wg_count_mux0000_19_1 : X_LUT4
    generic map(
      INIT => X"0808",
      LOC => "SLICE_X10Y0"
    )
    port map (
      ADR0 => wg_change_state,
      ADR1 => wg_count_addsub0000(1),
      ADR2 => wg_dly_cmp_eq0000,
      ADR3 => VCC,
      O => wg_count_mux0000(19)
    );
  wg_count_1 : X_FF
    generic map(
      LOC => "SLICE_X10Y0",
      INIT => '0'
    )
    port map (
      I => wg_count_1_DXMUX_4679,
      CE => wg_count_1_CEINV_4652,
      CLK => wg_count_1_CLKINV_4653,
      SET => GND,
      RST => wg_count_1_SRINVNOT,
      O => wg_count(1)
    );
  hv_count_mux0000_19_1 : X_LUT4
    generic map(
      INIT => X"1010",
      LOC => "SLICE_X2Y16"
    )
    port map (
      ADR0 => count_enable_cmp_eq0000,
      ADR1 => HV_ON_HMC_OBUF_0,
      ADR2 => hv_count_addsub0000(4),
      ADR3 => VCC,
      O => hv_count_mux0000(19)
    );
  hv_count_4 : X_FF
    generic map(
      LOC => "SLICE_X2Y16",
      INIT => '0'
    )
    port map (
      I => hv_count_5_DYMUX_4709,
      CE => hv_count_5_CEINV_4698,
      CLK => hv_count_5_CLKINV_4699,
      SET => GND,
      RST => hv_count_5_SRINVNOT,
      O => hv_count(4)
    );
  hv_count_mux0000_18_1 : X_LUT4
    generic map(
      INIT => X"0404",
      LOC => "SLICE_X2Y16"
    )
    port map (
      ADR0 => HV_ON_HMC_OBUF_0,
      ADR1 => hv_count_addsub0000(5),
      ADR2 => count_enable_cmp_eq0000,
      ADR3 => VCC,
      O => hv_count_mux0000(18)
    );
  hv_count_5 : X_FF
    generic map(
      LOC => "SLICE_X2Y16",
      INIT => '0'
    )
    port map (
      I => hv_count_5_DXMUX_4725,
      CE => hv_count_5_CEINV_4698,
      CLK => hv_count_5_CLKINV_4699,
      SET => GND,
      RST => hv_count_5_SRINVNOT,
      O => hv_count(5)
    );
  wg_count_mux0000_18_1 : X_LUT4
    generic map(
      INIT => X"0A00",
      LOC => "SLICE_X10Y1"
    )
    port map (
      ADR0 => wg_change_state,
      ADR1 => VCC,
      ADR2 => wg_dly_cmp_eq0000,
      ADR3 => wg_count_addsub0000(2),
      O => wg_count_mux0000(18)
    );
  wg_count_2 : X_FF
    generic map(
      LOC => "SLICE_X10Y1",
      INIT => '0'
    )
    port map (
      I => wg_count_3_DYMUX_4755,
      CE => wg_count_3_CEINV_4744,
      CLK => wg_count_3_CLKINV_4745,
      SET => GND,
      RST => wg_count_3_SRINVNOT,
      O => wg_count(2)
    );
  wg_count_mux0000_17_1 : X_LUT4
    generic map(
      INIT => X"0808",
      LOC => "SLICE_X10Y1"
    )
    port map (
      ADR0 => wg_count_addsub0000(3),
      ADR1 => wg_change_state,
      ADR2 => wg_dly_cmp_eq0000,
      ADR3 => VCC,
      O => wg_count_mux0000(17)
    );
  wg_count_3 : X_FF
    generic map(
      LOC => "SLICE_X10Y1",
      INIT => '0'
    )
    port map (
      I => wg_count_3_DXMUX_4771,
      CE => wg_count_3_CEINV_4744,
      CLK => wg_count_3_CLKINV_4745,
      SET => GND,
      RST => wg_count_3_SRINVNOT,
      O => wg_count(3)
    );
  hv_count_mux0000_17_1 : X_LUT4
    generic map(
      INIT => X"0500",
      LOC => "SLICE_X2Y17"
    )
    port map (
      ADR0 => HV_ON_HMC_OBUF_0,
      ADR1 => VCC,
      ADR2 => count_enable_cmp_eq0000,
      ADR3 => hv_count_addsub0000(6),
      O => hv_count_mux0000(17)
    );
  hv_count_6 : X_FF
    generic map(
      LOC => "SLICE_X2Y17",
      INIT => '0'
    )
    port map (
      I => hv_count_7_DYMUX_4801,
      CE => hv_count_7_CEINV_4790,
      CLK => hv_count_7_CLKINV_4791,
      SET => GND,
      RST => hv_count_7_SRINVNOT,
      O => hv_count(6)
    );
  hv_count_mux0000_16_1 : X_LUT4
    generic map(
      INIT => X"0202",
      LOC => "SLICE_X2Y17"
    )
    port map (
      ADR0 => hv_count_addsub0000(7),
      ADR1 => HV_ON_HMC_OBUF_0,
      ADR2 => count_enable_cmp_eq0000,
      ADR3 => VCC,
      O => hv_count_mux0000(16)
    );
  hv_count_7 : X_FF
    generic map(
      LOC => "SLICE_X2Y17",
      INIT => '0'
    )
    port map (
      I => hv_count_7_DXMUX_4817,
      CE => hv_count_7_CEINV_4790,
      CLK => hv_count_7_CLKINV_4791,
      SET => GND,
      RST => hv_count_7_SRINVNOT,
      O => hv_count(7)
    );
  wg_count_mux0000_16_1 : X_LUT4
    generic map(
      INIT => X"4040",
      LOC => "SLICE_X12Y2"
    )
    port map (
      ADR0 => wg_dly_cmp_eq0000,
      ADR1 => wg_count_addsub0000(4),
      ADR2 => wg_change_state,
      ADR3 => VCC,
      O => wg_count_mux0000(16)
    );
  wg_count_4 : X_FF
    generic map(
      LOC => "SLICE_X12Y2",
      INIT => '0'
    )
    port map (
      I => wg_count_5_DYMUX_4847,
      CE => wg_count_5_CEINV_4836,
      CLK => wg_count_5_CLKINV_4837,
      SET => GND,
      RST => wg_count_5_SRINVNOT,
      O => wg_count(4)
    );
  wg_count_mux0000_15_1 : X_LUT4
    generic map(
      INIT => X"3000",
      LOC => "SLICE_X12Y2"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_dly_cmp_eq0000,
      ADR2 => wg_change_state,
      ADR3 => wg_count_addsub0000(5),
      O => wg_count_mux0000(15)
    );
  wg_count_5 : X_FF
    generic map(
      LOC => "SLICE_X12Y2",
      INIT => '0'
    )
    port map (
      I => wg_count_5_DXMUX_4863,
      CE => wg_count_5_CEINV_4836,
      CLK => wg_count_5_CLKINV_4837,
      SET => GND,
      RST => wg_count_5_SRINVNOT,
      O => wg_count(5)
    );
  hv_count_mux0000_15_1 : X_LUT4
    generic map(
      INIT => X"0050",
      LOC => "SLICE_X2Y18"
    )
    port map (
      ADR0 => count_enable_cmp_eq0000,
      ADR1 => VCC,
      ADR2 => hv_count_addsub0000(8),
      ADR3 => HV_ON_HMC_OBUF_0,
      O => hv_count_mux0000(15)
    );
  hv_count_8 : X_FF
    generic map(
      LOC => "SLICE_X2Y18",
      INIT => '0'
    )
    port map (
      I => hv_count_9_DYMUX_4893,
      CE => hv_count_9_CEINV_4882,
      CLK => hv_count_9_CLKINV_4883,
      SET => GND,
      RST => hv_count_9_SRINVNOT,
      O => hv_count(8)
    );
  hv_count_mux0000_14_1 : X_LUT4
    generic map(
      INIT => X"000C",
      LOC => "SLICE_X2Y18"
    )
    port map (
      ADR0 => VCC,
      ADR1 => hv_count_addsub0000(9),
      ADR2 => count_enable_cmp_eq0000,
      ADR3 => HV_ON_HMC_OBUF_0,
      O => hv_count_mux0000(14)
    );
  hv_count_9 : X_FF
    generic map(
      LOC => "SLICE_X2Y18",
      INIT => '0'
    )
    port map (
      I => hv_count_9_DXMUX_4909,
      CE => hv_count_9_CEINV_4882,
      CLK => hv_count_9_CLKINV_4883,
      SET => GND,
      RST => hv_count_9_SRINVNOT,
      O => hv_count(9)
    );
  wg_count_mux0000_14_1 : X_LUT4
    generic map(
      INIT => X"0C00",
      LOC => "SLICE_X10Y3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_change_state,
      ADR2 => wg_dly_cmp_eq0000,
      ADR3 => wg_count_addsub0000(6),
      O => wg_count_mux0000(14)
    );
  count_enable : X_FF
    generic map(
      LOC => "SLICE_X5Y21",
      INIT => '1'
    )
    port map (
      I => count_enable_DYMUX_5163,
      CE => count_enable_CEINV_5159,
      CLK => count_enable_CLKINV_5160,
      SET => count_enable_FFY_SET,
      RST => GND,
      O => count_enable_1636
    );
  count_enable_FFY_SETOR : X_INV
    generic map(
      LOC => "SLICE_X5Y21",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => count_enable_FFY_SET
    );
  rx_dly_not0001 : X_LUT4
    generic map(
      INIT => X"0F1F",
      LOC => "SLICE_X13Y19"
    )
    port map (
      ADR0 => ems_rx_count(1),
      ADR1 => N4,
      ADR2 => ems_rx_count_enable_1577,
      ADR3 => ems_rx_count(0),
      O => rx_dly_not0001_pack_2
    );
  ems_rx_count_mux0002_1_1 : X_LUT4
    generic map(
      INIT => X"003C",
      LOC => "SLICE_X13Y19"
    )
    port map (
      ADR0 => VCC,
      ADR1 => ems_rx_count(3),
      ADR2 => Madd_ems_rx_count_addsub0000_cy(2),
      ADR3 => rx_dly_not0001_1624,
      O => ems_rx_count_mux0002(1)
    );
  ems_rx_count_3 : X_FF
    generic map(
      LOC => "SLICE_X13Y19",
      INIT => '0'
    )
    port map (
      I => ems_rx_count_3_DXMUX_5198,
      CE => VCC,
      CLK => ems_rx_count_3_CLKINV_5181,
      SET => GND,
      RST => ems_rx_count_3_FFX_RSTAND_5203,
      O => ems_rx_count(3)
    );
  ems_rx_count_3_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X13Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_rx_count_3_FFX_RSTAND_5203
    );
  ems_1_error_or00002 : X_LUT4
    generic map(
      INIT => X"4000",
      LOC => "SLICE_X18Y19"
    )
    port map (
      ADR0 => l_tx_dly_1561,
      ADR1 => BIT_EMS_1_IBUF_0,
      ADR2 => EMS_OUT_2_mux0004,
      ADR3 => tx_dly_1552,
      O => ems_1_error_or00002_5219
    );
  ems_45_error_or00005 : X_LUT4
    generic map(
      INIT => X"2030",
      LOC => "SLICE_X18Y19"
    )
    port map (
      ADR0 => BIT_EMS_5_IBUF_0,
      ADR1 => l_tx_dly_1561,
      ADR2 => tx_dly_1552,
      ADR3 => BIT_EMS_4_IBUF_0,
      O => ems_45_error_or00005_5226
    );
  tx_dly_not0001 : X_LUT4
    generic map(
      INIT => X"5557",
      LOC => "SLICE_X23Y9"
    )
    port map (
      ADR0 => ems_tx_count_enable_1564,
      ADR1 => ems_tx_count(0),
      ADR2 => N21,
      ADR3 => ems_tx_count(1),
      O => tx_dly_not0001_pack_2
    );
  ems_tx_count_mux0002_1_1 : X_LUT4
    generic map(
      INIT => X"0066",
      LOC => "SLICE_X23Y9"
    )
    port map (
      ADR0 => Madd_ems_tx_count_addsub0000_cy(2),
      ADR1 => ems_tx_count(3),
      ADR2 => VCC,
      ADR3 => tx_dly_not0001_1626,
      O => ems_tx_count_mux0002(1)
    );
  ems_tx_count_3 : X_FF
    generic map(
      LOC => "SLICE_X23Y9",
      INIT => '0'
    )
    port map (
      I => ems_tx_count_3_DXMUX_5257,
      CE => VCC,
      CLK => ems_tx_count_3_CLKINV_5240,
      SET => GND,
      RST => ems_tx_count_3_FFX_RSTAND_5262,
      O => ems_tx_count(3)
    );
  ems_tx_count_3_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X23Y9",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_tx_count_3_FFX_RSTAND_5262
    );
  ems_2_error_or000015 : X_LUT4
    generic map(
      INIT => X"BF5B",
      LOC => "SLICE_X15Y12"
    )
    port map (
      ADR0 => ops_mode(0),
      ADR1 => ops_mode(2),
      ADR2 => BIT_EMS_2_IBUF_0,
      ADR3 => ops_mode(1),
      O => ems_2_error_or000015_5277
    );
  WG_SW_CTRL_NOISE1 : X_LUT4
    generic map(
      INIT => X"000C",
      LOC => "SLICE_X15Y12"
    )
    port map (
      ADR0 => VCC,
      ADR1 => ops_mode(2),
      ADR2 => ops_mode(1),
      ADR3 => ops_mode(0),
      O => WG_SW_CTRL_NOISE_OBUF_5285
    );
  Mxor_wg_change_state_Result_SW2 : X_LUT4
    generic map(
      INIT => X"0080",
      LOC => "SLICE_X13Y9"
    )
    port map (
      ADR0 => RESET_IBUF_0,
      ADR1 => wg_dly_1573,
      ADR2 => WG_SW_NOISE_IBUF_0,
      ADR3 => WG_SW_TERM_IBUF_0,
      O => N9
    );
  Mxor_wg_change_state_Result_SW3 : X_LUT4
    generic map(
      INIT => X"F3F3",
      LOC => "SLICE_X13Y9"
    )
    port map (
      ADR0 => VCC,
      ADR1 => WG_SW_TERM_IBUF_0,
      ADR2 => WG_SW_NOISE_IBUF_0,
      ADR3 => VCC,
      O => N10
    );
  hv_dly : X_FF
    generic map(
      LOC => "SLICE_X4Y19",
      INIT => '0'
    )
    port map (
      I => hv_dly_DYMUX_5321,
      CE => hv_dly_CEINV_5317,
      CLK => hv_dly_CLKINV_5318,
      SET => GND,
      RST => hv_dly_FFY_RSTAND_5327,
      O => hv_dly_1589
    );
  hv_dly_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X4Y19",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => hv_dly_FFY_RSTAND_5327
    );
  ems_45_error_or0000231 : X_LUT4
    generic map(
      INIT => X"F0FF",
      LOC => "SLICE_X18Y23"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => ops_mode(1),
      ADR3 => ops_mode(2),
      O => N36_pack_1
    );
  ems_67_error_or000087_SW0 : X_LUT4
    generic map(
      INIT => X"0C0D",
      LOC => "SLICE_X18Y23"
    )
    port map (
      ADR0 => ops_mode(0),
      ADR1 => BIT_EMS_7_IBUF_0,
      ADR2 => N36,
      ADR3 => BIT_EMS_6_IBUF_0,
      O => N22
    );
  state_FSM_FFd2_In2 : X_LUT4
    generic map(
      INIT => X"FDFF",
      LOC => "SLICE_X17Y19"
    )
    port map (
      ADR0 => ops_mode(1),
      ADR1 => ops_mode(0),
      ADR2 => EMS_PWR_ERROR_IBUF_0,
      ADR3 => ops_mode(2),
      O => state_FSM_FFd2_In2_5366
    );
  ems_67_error_or000031 : X_LUT4
    generic map(
      INIT => X"300C",
      LOC => "SLICE_X17Y19"
    )
    port map (
      ADR0 => VCC,
      ADR1 => ops_mode(0),
      ADR2 => ops_mode(1),
      ADR3 => ops_mode(2),
      O => ems_45_error_or000031
    );
  state_FSM_FFd2_In24 : X_LUT4
    generic map(
      INIT => X"0055",
      LOC => "SLICE_X18Y25"
    )
    port map (
      ADR0 => ops_mode(0),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => ops_mode(2),
      O => state_FSM_FFd2_In24_5391
    );
  ems_3_error_or000017 : X_LUT4
    generic map(
      INIT => X"E9FD",
      LOC => "SLICE_X18Y25"
    )
    port map (
      ADR0 => ops_mode(0),
      ADR1 => BIT_EMS_3_IBUF_0,
      ADR2 => ops_mode(1),
      ADR3 => ops_mode(2),
      O => ems_3_error_or000017_5398
    );
  ems_45_error_or000087_SW0 : X_LUT4
    generic map(
      INIT => X"2223",
      LOC => "SLICE_X18Y20"
    )
    port map (
      ADR0 => BIT_EMS_5_IBUF_0,
      ADR1 => N36,
      ADR2 => ops_mode(0),
      ADR3 => BIT_EMS_4_IBUF_0,
      O => N24
    );
  MOD_PULSE_HMC1 : X_LUT4
    generic map(
      INIT => X"4000",
      LOC => "SLICE_X18Y20"
    )
    port map (
      ADR0 => ops_mode(1),
      ADR1 => ops_mode(0),
      ADR2 => state_FSM_FFd1_1595,
      ADR3 => MOD_PULSE_IBUF_0,
      O => MOD_PULSE_HMC_OBUF_5422
    );
  ems_error_prt_or000063_SW0 : X_LUT4
    generic map(
      INIT => X"CE0A",
      LOC => "SLICE_X20Y22"
    )
    port map (
      ADR0 => BIT_EMS_7_IBUF_0,
      ADR1 => BIT_EMS_6_IBUF_0,
      ADR2 => BIT_EMS_5_IBUF_0,
      ADR3 => ops_mode(0),
      O => N12_pack_1
    );
  ems_error_prt_or000063 : X_LUT4
    generic map(
      INIT => X"FFC8",
      LOC => "SLICE_X20Y22"
    )
    port map (
      ADR0 => BIT_EMS_4_IBUF_0,
      ADR1 => BIT_EMS_2_IBUF_0,
      ADR2 => BIT_EMS_3_IBUF_0,
      ADR3 => N12,
      O => ems_error_prt_or000063_5446
    );
  tx_dly : X_FF
    generic map(
      LOC => "SLICE_X22Y6",
      INIT => '0'
    )
    port map (
      I => tx_dly_DYMUX_5458,
      CE => tx_dly_CEINV_5454,
      CLK => tx_dly_CLKINV_5455,
      SET => GND,
      RST => tx_dly_FFY_RSTAND_5464,
      O => tx_dly_1552
    );
  tx_dly_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X22Y6",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => tx_dly_FFY_RSTAND_5464
    );
  ems_error_prt_or0000118 : X_LUT4
    generic map(
      INIT => X"0088",
      LOC => "SLICE_X21Y21"
    )
    port map (
      ADR0 => wg_dly_1573,
      ADR1 => rx_dly_1553,
      ADR2 => VCC,
      ADR3 => l_rx_dly_1584,
      O => ems_error_prt_or0000118_5475
    );
  Madd_ems_rx_count_addsub0000_cy_2_11 : X_LUT4
    generic map(
      INIT => X"8080",
      LOC => "SLICE_X11Y18"
    )
    port map (
      ADR0 => ems_rx_count(2),
      ADR1 => ems_rx_count(0),
      ADR2 => ems_rx_count(1),
      ADR3 => VCC,
      O => Madd_ems_rx_count_addsub0000_cy_2_pack_2
    );
  ems_rx_count_mux0002_0_1 : X_LUT4
    generic map(
      INIT => X"1540",
      LOC => "SLICE_X11Y18"
    )
    port map (
      ADR0 => rx_dly_not0001_1624,
      ADR1 => ems_rx_count(3),
      ADR2 => Madd_ems_rx_count_addsub0000_cy(2),
      ADR3 => ems_rx_count(4),
      O => ems_rx_count_mux0002(0)
    );
  ems_rx_count_4 : X_FF
    generic map(
      LOC => "SLICE_X11Y18",
      INIT => '0'
    )
    port map (
      I => ems_rx_count_4_DXMUX_5506,
      CE => VCC,
      CLK => ems_rx_count_4_CLKINV_5489,
      SET => GND,
      RST => ems_rx_count_4_FFX_RSTAND_5511,
      O => ems_rx_count(4)
    );
  ems_rx_count_4_FFX_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X11Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => ems_rx_count_4_FFX_RSTAND_5511
    );
  N51 : X_LUT4
    generic map(
      INIT => X"FCFC",
      LOC => "SLICE_X19Y19"
    )
    port map (
      ADR0 => VCC,
      ADR1 => state_FSM_FFd1_1595,
      ADR2 => state_FSM_FFd2_1554,
      ADR3 => VCC,
      O => N5
    );
  EMS_OUT_2_mux00051 : X_LUT4
    generic map(
      INIT => X"FC00",
      LOC => "SLICE_X19Y19"
    )
    port map (
      ADR0 => VCC,
      ADR1 => state_FSM_FFd1_1595,
      ADR2 => state_FSM_FFd2_1554,
      ADR3 => EMS_OUT_2_mux0004,
      O => EMS_OUT_2_OBUF_5534
    );
  l_ems_trig : X_FF
    generic map(
      LOC => "SLICE_X16Y8",
      INIT => '0'
    )
    port map (
      I => l_ems_trig_DYMUX_5544,
      CE => VCC,
      CLK => l_ems_trig_CLKINV_5541,
      SET => GND,
      RST => l_ems_trig_FFY_RSTAND_5549,
      O => l_ems_trig_1623
    );
  l_ems_trig_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X16Y8",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => l_ems_trig_FFY_RSTAND_5549
    );
  l_tx_dly : X_FF
    generic map(
      LOC => "SLICE_X14Y13",
      INIT => '0'
    )
    port map (
      I => l_tx_dly_DYMUX_5558,
      CE => VCC,
      CLK => l_tx_dly_CLKINV_5555,
      SET => GND,
      RST => l_tx_dly_FFY_RSTAND_5563,
      O => l_tx_dly_1561
    );
  l_tx_dly_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X14Y13",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => l_tx_dly_FFY_RSTAND_5563
    );
  ems_error_prt_or000086_SW0 : X_LUT4
    generic map(
      INIT => X"FFA0",
      LOC => "SLICE_X21Y24"
    )
    port map (
      ADR0 => BIT_EMS_4_IBUF_0,
      ADR1 => VCC,
      ADR2 => BIT_EMS_3_IBUF_0,
      ADR3 => ops_mode(0),
      O => N20_pack_1
    );
  ems_error_prt_or000086 : X_LUT4
    generic map(
      INIT => X"00DF",
      LOC => "SLICE_X21Y24"
    )
    port map (
      ADR0 => ops_mode(2),
      ADR1 => ops_mode(1),
      ADR2 => N20,
      ADR3 => BIT_EMS_7_IBUF_0,
      O => ems_error_prt_or000086_5586
    );
  count_enable_not00011 : X_LUT4
    generic map(
      INIT => X"FFF0",
      LOC => "SLICE_X4Y21"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => HV_ON_HMC_OBUF_0,
      ADR3 => count_enable_cmp_eq0000,
      O => count_enable_not0001
    );
  hv_count_not00021 : X_LUT4
    generic map(
      INIT => X"FFFC",
      LOC => "SLICE_X4Y21"
    )
    port map (
      ADR0 => VCC,
      ADR1 => count_enable_cmp_eq0000,
      ADR2 => HV_ON_HMC_OBUF_0,
      ADR3 => count_enable_1636,
      O => hv_count_not0002
    );
  ems_67_error_or000046 : X_LUT4
    generic map(
      INIT => X"AE0C",
      LOC => "SLICE_X19Y22"
    )
    port map (
      ADR0 => BIT_EMS_6_IBUF_0,
      ADR1 => ems_45_error_or000031_0,
      ADR2 => BIT_EMS_7_IBUF_0,
      ADR3 => EMS_OUT_2_mux0004,
      O => ems_67_error_or000046_pack_1
    );
  ems_67_error_or000087 : X_LUT4
    generic map(
      INIT => X"5400",
      LOC => "SLICE_X19Y22"
    )
    port map (
      ADR0 => l_rx_dly_1584,
      ADR1 => N22_0,
      ADR2 => ems_67_error_or000046_1642,
      ADR3 => rx_dly_1553,
      O => ems_67_error_or000087_5634
    );
  EMS_OUT_2_mux00041 : X_LUT4
    generic map(
      INIT => X"3388",
      LOC => "SLICE_X19Y23"
    )
    port map (
      ADR0 => ops_mode(2),
      ADR1 => ops_mode(1),
      ADR2 => VCC,
      ADR3 => ops_mode(0),
      O => EMS_OUT_2_mux0004_pack_1
    );
  ems_tx_stat21 : X_LUT4
    generic map(
      INIT => X"3404",
      LOC => "SLICE_X19Y23"
    )
    port map (
      ADR0 => WG_SW_CTRL_TERM_OBUF_1512,
      ADR1 => BIT_EMS_1_IBUF_0,
      ADR2 => BIT_EMS_2_IBUF_0,
      ADR3 => EMS_OUT_2_mux0004,
      O => ems_tx_stat21_5658
    );
  l_rx_gate : X_FF
    generic map(
      LOC => "SLICE_X10Y15",
      INIT => '0'
    )
    port map (
      I => l_rx_gate_DYMUX_5668,
      CE => VCC,
      CLK => l_rx_gate_CLKINV_5665,
      SET => GND,
      RST => l_rx_gate_FFY_RSTAND_5673,
      O => l_rx_gate_1627
    );
  l_rx_gate_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X10Y15",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => l_rx_gate_FFY_RSTAND_5673
    );
  WG_SW_CTRL_TERM1 : X_LUT4
    generic map(
      INIT => X"FFCF",
      LOC => "SLICE_X18Y8"
    )
    port map (
      ADR0 => VCC,
      ADR1 => ops_mode(0),
      ADR2 => ops_mode(2),
      ADR3 => ops_mode(1),
      O => WG_SW_CTRL_TERM_OBUF_pack_1
    );
  EMS_OUT_1_mux00041 : X_LUT4
    generic map(
      INIT => X"02FF",
      LOC => "SLICE_X18Y8"
    )
    port map (
      ADR0 => N5_0,
      ADR1 => ems_1_rx_stat_or0000,
      ADR2 => EMS_TRIG_IBUF_0,
      ADR3 => WG_SW_CTRL_TERM_OBUF_1512,
      O => EMS_OUT_1_OBUF_5696
    );
  state_cmp_eq00001 : X_LUT4
    generic map(
      INIT => X"00A0",
      LOC => "SLICE_X14Y18"
    )
    port map (
      ADR0 => ops_mode(1),
      ADR1 => VCC,
      ADR2 => ops_mode(2),
      ADR3 => ops_mode(0),
      O => state_cmp_eq0000_pack_1
    );
  state_FSM_FFd1_In14 : X_LUT4
    generic map(
      INIT => X"2220",
      LOC => "SLICE_X14Y18"
    )
    port map (
      ADR0 => tx_dly_1552,
      ADR1 => EMS_PWR_ERROR_IBUF_0,
      ADR2 => hv_dly_1589,
      ADR3 => state_cmp_eq0000,
      O => state_FSM_FFd1_In14_5720
    );
  rx_dly : X_FF
    generic map(
      LOC => "SLICE_X13Y18",
      INIT => '0'
    )
    port map (
      I => rx_dly_DYMUX_5732,
      CE => rx_dly_CEINV_5728,
      CLK => rx_dly_CLKINV_5729,
      SET => GND,
      RST => rx_dly_FFY_RSTAND_5738,
      O => rx_dly_1553
    );
  rx_dly_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X13Y18",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_0,
      O => rx_dly_FFY_RSTAND_5738
    );
  WG_SW_ERROR2 : X_LUT4
    generic map(
      INIT => X"A28A",
      LOC => "SLICE_X12Y14"
    )
    port map (
      ADR0 => N38,
      ADR1 => WG_SW_CTRL_TERM_OBUF_1512,
      ADR2 => WG_SW_NOISE_IBUF_0,
      ADR3 => WG_SW_TERM_IBUF_0,
      O => WG_SW_ERROR_OBUF_5749
    );
  hv_count_addsub0000_0_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X3Y14"
    )
    port map (
      ADR0 => hv_count(1),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => hv_count_addsub0000_0_G
    );
  hv_count_addsub0000_2_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X3Y15"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => hv_count(2),
      ADR3 => VCC,
      O => hv_count_addsub0000_2_F
    );
  hv_count_addsub0000_2_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X3Y15"
    )
    port map (
      ADR0 => VCC,
      ADR1 => hv_count(3),
      ADR2 => VCC,
      ADR3 => VCC,
      O => hv_count_addsub0000_2_G
    );
  hv_count_addsub0000_4_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X3Y16"
    )
    port map (
      ADR0 => hv_count(4),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => hv_count_addsub0000_4_F
    );
  hv_count_addsub0000_4_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X3Y16"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => hv_count(5),
      O => hv_count_addsub0000_4_G
    );
  hv_count_addsub0000_6_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X3Y17"
    )
    port map (
      ADR0 => VCC,
      ADR1 => hv_count(6),
      ADR2 => VCC,
      ADR3 => VCC,
      O => hv_count_addsub0000_6_F
    );
  hv_count_addsub0000_6_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X3Y17"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => hv_count(7),
      ADR3 => VCC,
      O => hv_count_addsub0000_6_G
    );
  hv_count_addsub0000_8_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X3Y18"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => hv_count(8),
      ADR3 => VCC,
      O => hv_count_addsub0000_8_F
    );
  hv_count_addsub0000_8_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X3Y18"
    )
    port map (
      ADR0 => hv_count(9),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => hv_count_addsub0000_8_G
    );
  hv_count_addsub0000_10_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X3Y19"
    )
    port map (
      ADR0 => VCC,
      ADR1 => hv_count(10),
      ADR2 => VCC,
      ADR3 => VCC,
      O => hv_count_addsub0000_10_F
    );
  hv_count_addsub0000_10_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X3Y19"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => hv_count(11),
      O => hv_count_addsub0000_10_G
    );
  hv_count_addsub0000_12_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X3Y20"
    )
    port map (
      ADR0 => hv_count(12),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => hv_count_addsub0000_12_F
    );
  hv_count_addsub0000_12_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X3Y20"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => hv_count(13),
      ADR3 => VCC,
      O => hv_count_addsub0000_12_G
    );
  hv_count_addsub0000_14_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X3Y21"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => hv_count(14),
      ADR3 => VCC,
      O => hv_count_addsub0000_14_F
    );
  hv_count_addsub0000_14_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X3Y21"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => hv_count(15),
      O => hv_count_addsub0000_14_G
    );
  hv_count_addsub0000_16_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X3Y22"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => hv_count(16),
      ADR3 => VCC,
      O => hv_count_addsub0000_16_F
    );
  hv_count_addsub0000_16_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X3Y22"
    )
    port map (
      ADR0 => hv_count(17),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => hv_count_addsub0000_16_G
    );
  hv_count_addsub0000_18_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X3Y23"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => hv_count(18),
      O => hv_count_addsub0000_18_F
    );
  hv_count_addsub0000_18_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X3Y23"
    )
    port map (
      ADR0 => VCC,
      ADR1 => hv_count(19),
      ADR2 => VCC,
      ADR3 => VCC,
      O => hv_count_addsub0000_18_G
    );
  hv_count_addsub0000_20_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X3Y24"
    )
    port map (
      ADR0 => hv_count(20),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => hv_count_addsub0000_20_F
    );
  hv_count_addsub0000_20_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X3Y24"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => hv_count(21),
      O => hv_count_addsub0000_20_G
    );
  hv_count_addsub0000_22_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X3Y25"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => hv_count(22),
      ADR3 => VCC,
      O => hv_count_addsub0000_22_F
    );
  wg_count_addsub0000_0_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X11Y0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_count(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => wg_count_addsub0000_0_G
    );
  wg_count_addsub0000_2_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X11Y1"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => wg_count(2),
      O => wg_count_addsub0000_2_F
    );
  wg_count_addsub0000_2_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X11Y1"
    )
    port map (
      ADR0 => wg_count(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => wg_count_addsub0000_2_G
    );
  wg_count_addsub0000_4_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X11Y2"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => wg_count(4),
      ADR3 => VCC,
      O => wg_count_addsub0000_4_F
    );
  wg_count_addsub0000_4_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X11Y2"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_count(5),
      ADR2 => VCC,
      ADR3 => VCC,
      O => wg_count_addsub0000_4_G
    );
  wg_count_addsub0000_6_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X11Y3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_count(6),
      ADR2 => VCC,
      ADR3 => VCC,
      O => wg_count_addsub0000_6_F
    );
  wg_count_addsub0000_6_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X11Y3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => wg_count(7),
      O => wg_count_addsub0000_6_G
    );
  wg_count_addsub0000_8_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X11Y4"
    )
    port map (
      ADR0 => wg_count(8),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => wg_count_addsub0000_8_F
    );
  wg_count_addsub0000_8_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X11Y4"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => wg_count(9),
      O => wg_count_addsub0000_8_G
    );
  wg_count_addsub0000_10_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X11Y5"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_count(10),
      ADR2 => VCC,
      ADR3 => VCC,
      O => wg_count_addsub0000_10_F
    );
  wg_count_addsub0000_10_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X11Y5"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => wg_count(11),
      ADR3 => VCC,
      O => wg_count_addsub0000_10_G
    );
  wg_count_addsub0000_12_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X11Y6"
    )
    port map (
      ADR0 => wg_count(12),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => wg_count_addsub0000_12_F
    );
  wg_count_addsub0000_12_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X11Y6"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => wg_count(13),
      O => wg_count_addsub0000_12_G
    );
  wg_count_addsub0000_14_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X11Y7"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_count(14),
      ADR2 => VCC,
      ADR3 => VCC,
      O => wg_count_addsub0000_14_F
    );
  wg_count_addsub0000_14_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X11Y7"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => wg_count(15),
      ADR3 => VCC,
      O => wg_count_addsub0000_14_G
    );
  wg_count_addsub0000_16_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA",
      LOC => "SLICE_X11Y8"
    )
    port map (
      ADR0 => wg_count(16),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => wg_count_addsub0000_16_F
    );
  wg_count_addsub0000_16_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00",
      LOC => "SLICE_X11Y8"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => wg_count(17),
      O => wg_count_addsub0000_16_G
    );
  wg_count_addsub0000_18_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC",
      LOC => "SLICE_X11Y9"
    )
    port map (
      ADR0 => VCC,
      ADR1 => wg_count(18),
      ADR2 => VCC,
      ADR3 => VCC,
      O => wg_count_addsub0000_18_F
    );
  wg_count_addsub0000_18_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0",
      LOC => "SLICE_X11Y9"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => wg_count(19),
      ADR3 => VCC,
      O => wg_count_addsub0000_18_G
    );
  WG_SW_NOISE_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD95",
      PATHPULSE => 499 ps
    )
    port map (
      I => WG_SW_NOISE_IBUF_2667,
      O => WG_SW_NOISE_IBUF_0
    );
  MOD_PULSE_HMC_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD133",
      PATHPULSE => 499 ps
    )
    port map (
      I => MOD_PULSE_HMC_OBUF_5422,
      O => MOD_PULSE_HMC_O
    );
  EMS_ERROR_45_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD103",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_45_error_1509,
      O => EMS_ERROR_45_O
    );
  EMS_ERROR_67_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD102",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_67_error_1510,
      O => EMS_ERROR_67_O
    );
  T0_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD20",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE2_OBUF_2698,
      O => SPARE2_OBUF_0
    );
  WG_SW_CTRL_TERM_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD19",
      PATHPULSE => 499 ps
    )
    port map (
      I => WG_SW_CTRL_TERM_OBUF_1512,
      O => WG_SW_CTRL_TERM_O
    );
  SPARE1_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD11",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF1_0,
      O => SPARE1_O
    );
  MOD_PULSE_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD99",
      PATHPULSE => 499 ps
    )
    port map (
      I => MOD_PULSE_IBUF_2735,
      O => MOD_PULSE_IBUF_0
    );
  SPARE2_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD139",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE2_OBUF_0,
      O => SPARE2_O
    );
  WG_SW_ERROR_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD131",
      PATHPULSE => 499 ps
    )
    port map (
      I => WG_SW_ERROR_OBUF_5749,
      O => WG_SW_ERROR_O
    );
  SPARE3_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD2",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE3_OBUF_2965,
      O => SPARE3_O
    );
  EMS_ERROR_1_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD98",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_1_error_1519,
      O => EMS_ERROR_1_O
    );
  EMS_ERROR_2_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD101",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_2_error_1520,
      O => EMS_ERROR_2_O
    );
  HV_ON_730_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD1",
      PATHPULSE => 499 ps
    )
    port map (
      I => HV_ON_HMC_OBUF_2782,
      O => HV_ON_HMC_OBUF_0
    );
  EMS_ERROR_3_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD92",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_3_error_1522,
      O => EMS_ERROR_3_O
    );
  SYNC_PULSE_HMC_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD116",
      PATHPULSE => 499 ps
    )
    port map (
      I => SYNC_PULSE_HMC_OBUF_2858,
      O => SYNC_PULSE_HMC_O
    );
  EXT_CLK_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD96",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE1_OBUF1,
      O => SPARE1_OBUF1_0
    );
  FIL_ON_HMC_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD144",
      PATHPULSE => 499 ps
    )
    port map (
      I => FIL_ON_HMC_OBUF_3082,
      O => FIL_ON_HMC_O
    );
  WG_SW_TERM_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD132",
      PATHPULSE => 499 ps
    )
    port map (
      I => WG_SW_TERM_IBUF_2820,
      O => WG_SW_TERM_IBUF_0
    );
  RX_GATE_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD125",
      PATHPULSE => 499 ps
    )
    port map (
      I => RX_GATE_IBUF_2827,
      O => RX_GATE_IBUF_0
    );
  EMS_OUT_1_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD82",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_OUT_1_OBUF_5696,
      O => EMS_OUT_1_O
    );
  EMS_OUT_2_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD54",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_OUT_2_OBUF_5534,
      O => EMS_OUT_2_O
    );
  MOD_PULSE_DISABLE_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD126",
      PATHPULSE => 499 ps
    )
    port map (
      I => mod_pulse_error_1529,
      O => MOD_PULSE_DISABLE_O
    );
  EMS_OUT_3_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD62",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_OUT_4_OBUF_0,
      O => EMS_OUT_3_O
    );
  EMS_OUT_4_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD61",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_OUT_4_OBUF_0,
      O => EMS_OUT_4_O
    );
  STATUS_ACK_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD104",
      PATHPULSE => 499 ps
    )
    port map (
      I => STATUS_ACK_IBUF_2881,
      O => STATUS_ACK_IBUF_0
    );
  EMS_OUT_5_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD60",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_OUT_7_OBUF_0,
      O => EMS_OUT_5_O
    );
  NOISE_SOURCE_EN_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD109",
      PATHPULSE => 499 ps
    )
    port map (
      I => WG_SW_CTRL_NOISE_OBUF_0,
      O => NOISE_SOURCE_EN_O
    );
  EMS_OUT_6_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD67",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_OUT_4_OBUF_0,
      O => EMS_OUT_6_O
    );
  WG_SW_CTRL_NOISE_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD107",
      PATHPULSE => 499 ps
    )
    port map (
      I => WG_SW_CTRL_NOISE_OBUF_0,
      O => WG_SW_CTRL_NOISE_O
    );
  HV_ON_HMC_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD112",
      PATHPULSE => 499 ps
    )
    port map (
      I => HV_ON_HMC_OBUF_0,
      O => HV_ON_HMC_O
    );
  EMS_TRIG_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD106",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_TRIG_IBUF_2928,
      O => EMS_TRIG_IBUF_0
    );
  ONE_PPS_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD93",
      PATHPULSE => 499 ps
    )
    port map (
      I => ONE_PPS_IBUF_2987,
      O => ONE_PPS_IBUF_0
    );
  EMS_OUT_7_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD59",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_OUT_7_OBUF_0,
      O => EMS_OUT_7_O
    );
  SPARE_STATUS0_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD24",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE_STATUS0_OBUF_2713,
      O => SPARE_STATUS0_O
    );
  SPARE_STATUS1_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD91",
      PATHPULSE => 499 ps
    )
    port map (
      I => SPARE_STATUS1_OBUF_2720,
      O => SPARE_STATUS1_O
    );
  EMS_PWR_ERROR_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD108",
      PATHPULSE => 499 ps
    )
    port map (
      I => EMS_PWR_ERROR_IBUF_3018,
      O => EMS_PWR_ERROR_IBUF_0
    );
  BIT_EMS_1_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD53",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS_1_IBUF_3025,
      O => BIT_EMS_1_IBUF_0
    );
  BIT_EMS_2_IFF_IMUX : X_BUF
    generic map(
      LOC => "IPAD50",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS_2_IBUF_3032,
      O => BIT_EMS_2_IBUF_0
    );
  EMS_ERROR_EVENT_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD140",
      PATHPULSE => 499 ps
    )
    port map (
      I => ems_error_prt_1543,
      O => EMS_ERROR_EVENT_O
    );
  BIT_EMS_3_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD48",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS_3_IBUF_3047,
      O => BIT_EMS_3_IBUF_0
    );
  BIT_EMS_4_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD47",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS_4_IBUF_3054,
      O => BIT_EMS_4_IBUF_0
    );
  BIT_EMS_5_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD44",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS_5_IBUF_3061,
      O => BIT_EMS_5_IBUF_0
    );
  RESET_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD22",
      PATHPULSE => 499 ps
    )
    port map (
      I => RESET_IBUF_3068,
      O => RESET_IBUF_0
    );
  BIT_EMS_6_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD43",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS_6_IBUF_3075,
      O => BIT_EMS_6_IBUF_0
    );
  BIT_EMS_7_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD37",
      PATHPULSE => 499 ps
    )
    port map (
      I => BIT_EMS_7_IBUF_3089,
      O => BIT_EMS_7_IBUF_0
    );
  state_FSM_FFd1_In34_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FFFF",
      LOC => "SLICE_X15Y19"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => state_FSM_FFd1_In34_F_3116
    );
  ems_tx_stat34_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"0000",
      LOC => "SLICE_X20Y24"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => ems_tx_stat34_F
    );
  NlwBlock_HMC_src_VCC : X_ONE
    port map (
      O => VCC
    );
  NlwBlock_HMC_src_GND : X_ZERO
    port map (
      O => GND
    );
  NlwInverterBlock_ops_mode_0_CLK : X_INV
    port map (
      I => OPS_MODE_730_0_IFF_ICLK1INVNOT,
      O => NlwInverterSignal_ops_mode_0_CLK
    );
  NlwInverterBlock_ops_mode_1_CLK : X_INV
    port map (
      I => OPS_MODE_730_1_IFF_ICLK1INVNOT,
      O => NlwInverterSignal_ops_mode_1_CLK
    );
  NlwInverterBlock_ops_mode_2_CLK : X_INV
    port map (
      I => OPS_MODE_730_2_IFF_ICLK1INVNOT,
      O => NlwInverterSignal_ops_mode_2_CLK
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

