-- (c) Copyright 2009 - 2014 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and 
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;


--***************************** Entity Declaration ****************************

entity bd_b160_xpcs_0_gtwizard_gth_10gbaser_multi_GT is
generic
(
    -- Simulation attributes
    EXAMPLE_SIMULATION             : integer  := 0;      -- Set to 1 for simulation
    WRAPPER_SIM_GTRESET_SPEEDUP    : string   := "FALSE" -- Set to "TRUE" to speed up sim reset

);
port
(
    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT0  (X0Y0)
    --____________________________CHANNEL PORTS________________________________
    ---------------------------- Channel - DRP Ports  --------------------------
    gt0_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt0_drpclk_in                           : in   std_logic;
    gt0_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt0_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt0_drpen_in                            : in   std_logic;
    gt0_drprdy_out                          : out  std_logic;
    gt0_drpwe_in                            : in   std_logic;
    ------------------------------- Loopback Ports -----------------------------
    gt0_loopback_in                         : in   std_logic_vector(2 downto 0);
    ----------------------------- PCI Express Ports ----------------------------
    gt0_rxrate_in                           : in   std_logic_vector(2 downto 0);
    --------------------- RX Initialization and Reset Ports --------------------
    gt0_eyescanreset_in                     : in   std_logic;
    gt0_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt0_eyescandataerror_out                : out  std_logic;
    gt0_eyescantrigger_in                   : in   std_logic;
    ------------------------- Receive Ports - CDR Ports ------------------------
    gt0_rxcdrhold_in                        : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt0_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX Interface Ports -----------------
    gt0_rxusrclk_in                         : in   std_logic;
    gt0_rxusrclk2_in                        : in   std_logic;
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt0_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------- Receive Ports - Pattern Checker Ports ------------------
    gt0_rxprbserr_out                       : out  std_logic;
    gt0_rxprbssel_in                        : in   std_logic_vector(2 downto 0);
    ------------------- Receive Ports - Pattern Checker ports ------------------
    gt0_rxprbscntreset_in                   : in   std_logic;
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt0_gthrxn_in                           : in   std_logic;
    ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
    gt0_rxbufreset_in                       : in   std_logic;
    gt0_rxbufstatus_out                     : out  std_logic_vector(2 downto 0);
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt0_rxdfeagchold_in                     : in   std_logic;
    gt0_rxdfelpmreset_in                    : in   std_logic;
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    gt0_rxoutclk_out                        : out  std_logic;
    ---------------------- Receive Ports - RX Gearbox Ports --------------------
    gt0_rxdatavalid_out                     : out  std_logic;
    gt0_rxheader_out                        : out  std_logic_vector(1 downto 0);
    gt0_rxheadervalid_out                   : out  std_logic;
    --------------------- Receive Ports - RX Gearbox Ports  --------------------
    gt0_rxgearboxslip_in                    : in   std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt0_gtrxreset_in                        : in   std_logic;
    gt0_rxpcsreset_in                       : in   std_logic;
    gt0_rxpmareset_in                       : in   std_logic;
    ------------------ Receive Ports - RX Margin Analysis ports ----------------
    gt0_rxlpmen_in                          : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt0_rxpolarity_in                       : in   std_logic;
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt0_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt0_rxresetdone_out                     : out  std_logic;
    gt0_rxpmaresetdone_out                  : out  std_logic;
    ------------------------ TX Configurable Driver Ports ----------------------
    gt0_txpostcursor_in                     : in   std_logic_vector(4 downto 0);
    gt0_txprecursor_in                      : in   std_logic_vector(4 downto 0);
    --------------------- TX Initialization and Reset Ports --------------------
    gt0_gttxreset_in                        : in   std_logic;
    gt0_txuserrdy_in                        : in   std_logic;
    -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
    gt0_txheader_in                         : in   std_logic_vector(1 downto 0);
    ------------------ Transmit Ports - FPGA TX Interface Ports ----------------
    gt0_txusrclk_in                         : in   std_logic;
    gt0_txusrclk2_in                        : in   std_logic;
    ------------------ Transmit Ports - Pattern Generator Ports ----------------
    gt0_txprbsforceerr_in                   : in   std_logic;
    ---------------------- Transmit Ports - TX Buffer Ports --------------------
    gt0_txbufstatus_out                     : out  std_logic_vector(1 downto 0);
    --------------- Transmit Ports - TX Configurable Driver Ports --------------
    gt0_txdiffctrl_in                       : in   std_logic_vector(3 downto 0);
    gt0_txinhibit_in                        : in   std_logic;
    gt0_txmaincursor_in                     : in   std_logic_vector(6 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt0_txdata_in                           : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt0_gthtxn_out                          : out  std_logic;
    gt0_gthtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt0_txoutclk_out                        : out  std_logic;
    gt0_txoutclkfabric_out                  : out  std_logic;
    gt0_txoutclkpcs_out                     : out  std_logic;
    --------------------- Transmit Ports - TX Gearbox Ports --------------------
    gt0_txsequence_in                       : in   std_logic_vector(6 downto 0);
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt0_txpcsreset_in                       : in   std_logic;
    gt0_txpmareset_in                       : in   std_logic;
    gt0_txresetdone_out                     : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt0_txpolarity_in                       : in   std_logic;
    ------------------ Transmit Ports - pattern Generator Ports ----------------
    gt0_txprbssel_in                        : in   std_logic_vector(2 downto 0);


    --____________________________COMMON PORTS________________________________
     GT0_QPLLOUTCLK_IN : in std_logic;
     GT0_QPLLOUTREFCLK_IN : in std_logic

);


end bd_b160_xpcs_0_gtwizard_gth_10gbaser_multi_GT;
    
architecture RTL of bd_b160_xpcs_0_gtwizard_gth_10gbaser_multi_GT is
    attribute DowngradeIPIdentifiedWarnings: string;
    attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";


--***********************************Parameter Declarations********************

    constant DLY : time := 1 ns;

--***************************** Signal Declarations *****************************

    -- ground and tied_to_vcc_i signals
    signal  tied_to_ground_i          :   std_logic;
    signal  tied_to_ground_vec_i      :   std_logic_vector(63 downto 0);
    signal  tied_to_vcc_i             :   std_logic;

    signal  gt0_qplloutclk_i          :   std_logic;
    signal  gt0_qplloutrefclk_i       :   std_logic;
    signal  gt0_qpllclk_i             :   std_logic;
    signal  gt0_qpllrefclk_i          :   std_logic;


--*************************** Component Declarations **************************
component bd_b160_xpcs_0_gtwizard_gth_10gbaser_GT
generic
(
    -- Simulation attributes
    GT_SIM_GTRESET_SPEEDUP    : string := "FALSE";
    EXAMPLE_SIMULATION        : integer  := 0;   
    TXSYNC_OVRD_IN            : bit    := '0';
    TXSYNC_MULTILANE_IN       : bit    := '0'     
);
port 
(   
    ---------------------------- Channel - DRP Ports  --------------------------
    drpaddr_in                              : in   std_logic_vector(8 downto 0);
    drpclk_in                               : in   std_logic;
    drpdi_in                                : in   std_logic_vector(15 downto 0);
    drpdo_out                               : out  std_logic_vector(15 downto 0);
    drpen_in                                : in   std_logic;
    drprdy_out                              : out  std_logic;
    drpwe_in                                : in   std_logic;
    ------------------------------- Clocking Ports -----------------------------
    qpllclk_in                              : in   std_logic;
    qpllrefclk_in                           : in   std_logic;
    ------------------------------- Loopback Ports -----------------------------
    loopback_in                             : in   std_logic_vector(2 downto 0);
    ----------------------------- PCI Express Ports ----------------------------
    rxrate_in                               : in   std_logic_vector(2 downto 0);
    --------------------- RX Initialization and Reset Ports --------------------
    eyescanreset_in                         : in   std_logic;
    rxuserrdy_in                            : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    eyescandataerror_out                    : out  std_logic;
    eyescantrigger_in                       : in   std_logic;
    ------------------------- Receive Ports - CDR Ports ------------------------
    rxcdrhold_in                            : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    dmonitorout_out                         : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX Interface Ports -----------------
    rxusrclk_in                             : in   std_logic;
    rxusrclk2_in                            : in   std_logic;
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    rxdata_out                              : out  std_logic_vector(31 downto 0);
    ------------------- Receive Ports - Pattern Checker Ports ------------------
    rxprbserr_out                           : out  std_logic;
    rxprbssel_in                            : in   std_logic_vector(2 downto 0);
    ------------------- Receive Ports - Pattern Checker ports ------------------
    rxprbscntreset_in                       : in   std_logic;
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gthrxn_in                               : in   std_logic;
    ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
    rxbufreset_in                           : in   std_logic;
    rxbufstatus_out                         : out  std_logic_vector(2 downto 0);
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    rxdfeagchold_in                         : in   std_logic;
    rxdfelpmreset_in                        : in   std_logic;
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    rxoutclk_out                            : out  std_logic;
    ---------------------- Receive Ports - RX Gearbox Ports --------------------
    rxdatavalid_out                         : out  std_logic;
    rxheader_out                            : out  std_logic_vector(1 downto 0);
    rxheadervalid_out                       : out  std_logic;
    --------------------- Receive Ports - RX Gearbox Ports  --------------------
    rxgearboxslip_in                        : in   std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gtrxreset_in                            : in   std_logic;
    rxpcsreset_in                           : in   std_logic;
    rxpmareset_in                           : in   std_logic;
    ------------------ Receive Ports - RX Margin Analysis ports ----------------
    rxlpmen_in                              : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    rxpolarity_in                           : in   std_logic;
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gthrxp_in                               : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    rxresetdone_out                         : out  std_logic;
    rxpmaresetdone_out                      : out  std_logic;
    ------------------------ TX Configurable Driver Ports ----------------------
    txpostcursor_in                         : in   std_logic_vector(4 downto 0);
    txprecursor_in                          : in   std_logic_vector(4 downto 0);
    --------------------- TX Initialization and Reset Ports --------------------
    gttxreset_in                            : in   std_logic;
    txuserrdy_in                            : in   std_logic;
    -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
    txheader_in                             : in   std_logic_vector(1 downto 0);
    ------------------ Transmit Ports - FPGA TX Interface Ports ----------------
    txusrclk_in                             : in   std_logic;
    txusrclk2_in                            : in   std_logic;
    ------------------ Transmit Ports - Pattern Generator Ports ----------------
    txprbsforceerr_in                       : in   std_logic;
    ---------------------- Transmit Ports - TX Buffer Ports --------------------
    txbufstatus_out                         : out  std_logic_vector(1 downto 0);
    --------------- Transmit Ports - TX Configurable Driver Ports --------------
    txdiffctrl_in                           : in   std_logic_vector(3 downto 0);
    txinhibit_in                            : in   std_logic;
    txmaincursor_in                         : in   std_logic_vector(6 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    txdata_in                               : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gthtxn_out                              : out  std_logic;
    gthtxp_out                              : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    txoutclk_out                            : out  std_logic;
    txoutclkfabric_out                      : out  std_logic;
    txoutclkpcs_out                         : out  std_logic;
    --------------------- Transmit Ports - TX Gearbox Ports --------------------
    txsequence_in                           : in   std_logic_vector(6 downto 0);
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    txpcsreset_in                           : in   std_logic;
    txpmareset_in                           : in   std_logic;
    txresetdone_out                         : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    txpolarity_in                           : in   std_logic;
    ------------------ Transmit Ports - pattern Generator Ports ----------------
    txprbssel_in                            : in   std_logic_vector(2 downto 0)


);
end component;



--********************************* Main Body of Code**************************

begin                       

    tied_to_ground_i                    <= '0';
    tied_to_ground_vec_i(63 downto 0)   <= (others => '0');
    tied_to_vcc_i                       <= '1';
    gt0_qpllclk_i    <= GT0_QPLLOUTCLK_IN;  
    gt0_qpllrefclk_i <= GT0_QPLLOUTREFCLK_IN; 


 
    --------------------------- GT Instances  -------------------------------   

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT0  (X0Y0)

gt0_gtwizard_gth_10gbaser_i : bd_b160_xpcs_0_gtwizard_gth_10gbaser_GT 
    generic map
    (
        -- Simulation attributes
        GT_SIM_GTRESET_SPEEDUP => WRAPPER_SIM_GTRESET_SPEEDUP,
        EXAMPLE_SIMULATION     => EXAMPLE_SIMULATION,
        TXSYNC_OVRD_IN         => ('0'),
        TXSYNC_MULTILANE_IN    => ('0')
    )
    port map
    (
        ---------------------------- Channel - DRP Ports  --------------------------
        drpaddr_in                      =>      gt0_drpaddr_in,
        drpclk_in                       =>      gt0_drpclk_in,
        drpdi_in                        =>      gt0_drpdi_in,
        drpdo_out                       =>      gt0_drpdo_out,
        drpen_in                        =>      gt0_drpen_in,
        drprdy_out                      =>      gt0_drprdy_out,
        drpwe_in                        =>      gt0_drpwe_in,
        ------------------------------- Clocking Ports -----------------------------
        qpllclk_in                      =>      gt0_qpllclk_i,
        qpllrefclk_in                   =>      gt0_qpllrefclk_i,
        ------------------------------- Loopback Ports -----------------------------
        loopback_in                     =>      gt0_loopback_in,
        ----------------------------- PCI Express Ports ----------------------------
        rxrate_in                       =>      gt0_rxrate_in,
        --------------------- RX Initialization and Reset Ports --------------------
        eyescanreset_in                 =>      gt0_eyescanreset_in,
        rxuserrdy_in                    =>      gt0_rxuserrdy_in,
        -------------------------- RX Margin Analysis Ports ------------------------
        eyescandataerror_out            =>      gt0_eyescandataerror_out,
        eyescantrigger_in               =>      gt0_eyescantrigger_in,
        ------------------------- Receive Ports - CDR Ports ------------------------
        rxcdrhold_in                    =>      gt0_rxcdrhold_in,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        dmonitorout_out                 =>      gt0_dmonitorout_out,
        ------------------ Receive Ports - FPGA RX Interface Ports -----------------
        rxusrclk_in                     =>      gt0_rxusrclk_in,
        rxusrclk2_in                    =>      gt0_rxusrclk2_in,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        rxdata_out                      =>      gt0_rxdata_out,
        ------------------- Receive Ports - Pattern Checker Ports ------------------
        rxprbserr_out                   =>      gt0_rxprbserr_out,
        rxprbssel_in                    =>      gt0_rxprbssel_in,
        ------------------- Receive Ports - Pattern Checker ports ------------------
        rxprbscntreset_in               =>      gt0_rxprbscntreset_in,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gthrxn_in                       =>      gt0_gthrxn_in,
        ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
        rxbufreset_in                   =>      gt0_rxbufreset_in,
        rxbufstatus_out                 =>      gt0_rxbufstatus_out,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        rxdfeagchold_in                 =>      gt0_rxdfeagchold_in,
        rxdfelpmreset_in                =>      gt0_rxdfelpmreset_in,
        --------------- Receive Ports - RX Fabric Output Control Ports -------------
        rxoutclk_out                    =>      gt0_rxoutclk_out,
        ---------------------- Receive Ports - RX Gearbox Ports --------------------
        rxdatavalid_out                 =>      gt0_rxdatavalid_out,
        rxheader_out                    =>      gt0_rxheader_out,
        rxheadervalid_out               =>      gt0_rxheadervalid_out,
        --------------------- Receive Ports - RX Gearbox Ports  --------------------
        rxgearboxslip_in                =>      gt0_rxgearboxslip_in,
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gtrxreset_in                    =>      gt0_gtrxreset_in,
        rxpcsreset_in                   =>      gt0_rxpcsreset_in,
        rxpmareset_in                   =>      gt0_rxpmareset_in,
        ------------------ Receive Ports - RX Margin Analysis ports ----------------
        rxlpmen_in                      =>      gt0_rxlpmen_in,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        rxpolarity_in                   =>      gt0_rxpolarity_in,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gthrxp_in                       =>      gt0_gthrxp_in,
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        rxresetdone_out                 =>      gt0_rxresetdone_out,
        rxpmaresetdone_out              =>      gt0_rxpmaresetdone_out,
        ------------------------ TX Configurable Driver Ports ----------------------
        txpostcursor_in                 =>      gt0_txpostcursor_in,
        txprecursor_in                  =>      gt0_txprecursor_in,
        --------------------- TX Initialization and Reset Ports --------------------
        gttxreset_in                    =>      gt0_gttxreset_in,
        txuserrdy_in                    =>      gt0_txuserrdy_in,
        -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
        txheader_in                     =>      gt0_txheader_in,
        ------------------ Transmit Ports - FPGA TX Interface Ports ----------------
        txusrclk_in                     =>      gt0_txusrclk_in,
        txusrclk2_in                    =>      gt0_txusrclk2_in,
        ------------------ Transmit Ports - Pattern Generator Ports ----------------
        txprbsforceerr_in               =>      gt0_txprbsforceerr_in,
        ---------------------- Transmit Ports - TX Buffer Ports --------------------
        txbufstatus_out                 =>      gt0_txbufstatus_out,
        --------------- Transmit Ports - TX Configurable Driver Ports --------------
        txdiffctrl_in                   =>      gt0_txdiffctrl_in,
        txinhibit_in                    =>      gt0_txinhibit_in,
        txmaincursor_in                 =>      gt0_txmaincursor_in,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        txdata_in                       =>      gt0_txdata_in,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gthtxn_out                      =>      gt0_gthtxn_out,
        gthtxp_out                      =>      gt0_gthtxp_out,
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        txoutclk_out                    =>      gt0_txoutclk_out,
        txoutclkfabric_out              =>      gt0_txoutclkfabric_out,
        txoutclkpcs_out                 =>      gt0_txoutclkpcs_out,
        --------------------- Transmit Ports - TX Gearbox Ports --------------------
        txsequence_in                   =>      gt0_txsequence_in,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        txpcsreset_in                   =>      gt0_txpcsreset_in,
        txpmareset_in                   =>      gt0_txpmareset_in,
        txresetdone_out                 =>      gt0_txresetdone_out,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        txpolarity_in                   =>      gt0_txpolarity_in,
        ------------------ Transmit Ports - pattern Generator Ports ----------------
        txprbssel_in                    =>      gt0_txprbssel_in

    );

end RTL;     
