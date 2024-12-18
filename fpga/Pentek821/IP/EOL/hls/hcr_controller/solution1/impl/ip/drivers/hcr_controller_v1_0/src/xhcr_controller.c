// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xhcr_controller.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XHcr_controller_CfgInitialize(XHcr_controller *InstancePtr, XHcr_controller_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Cfg_bus_BaseAddress = ConfigPtr->Cfg_bus_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XHcr_controller_Start(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_AP_CTRL) & 0x80;
    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_AP_CTRL, Data | 0x01);
}

u32 XHcr_controller_IsDone(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XHcr_controller_IsIdle(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XHcr_controller_IsReady(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XHcr_controller_EnableAutoRestart(XHcr_controller *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_AP_CTRL, 0x80);
}

void XHcr_controller_DisableAutoRestart(XHcr_controller *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_AP_CTRL, 0);
}

void XHcr_controller_Set_cfg_pulse_sequence_start_stop_indexes(XHcr_controller *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_START_STOP_INDEXES_DATA, Data);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_start_stop_indexes(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_START_STOP_INDEXES_DATA);
    return Data;
}

void XHcr_controller_Set_cfg_num_pulses_to_execute(XHcr_controller *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_NUM_PULSES_TO_EXECUTE_DATA, Data);
}

u32 XHcr_controller_Get_cfg_num_pulses_to_execute(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_NUM_PULSES_TO_EXECUTE_DATA);
    return Data;
}

void XHcr_controller_Set_cfg_total_decimation(XHcr_controller *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_TOTAL_DECIMATION_DATA, Data);
}

u32 XHcr_controller_Get_cfg_total_decimation(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_TOTAL_DECIMATION_DATA);
    return Data;
}

void XHcr_controller_Set_cfg_post_decimation(XHcr_controller *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_POST_DECIMATION_DATA, Data);
}

u32 XHcr_controller_Get_cfg_post_decimation(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_POST_DECIMATION_DATA);
    return Data;
}

void XHcr_controller_Set_cfg_num_pulses_per_xfer(XHcr_controller *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_NUM_PULSES_PER_XFER_DATA, Data);
}

u32 XHcr_controller_Get_cfg_num_pulses_per_xfer(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_NUM_PULSES_PER_XFER_DATA);
    return Data;
}

void XHcr_controller_Set_cfg_enabled_channel_vector(XHcr_controller *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_ENABLED_CHANNEL_VECTOR_DATA, Data);
}

u32 XHcr_controller_Get_cfg_enabled_channel_vector(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_ENABLED_CHANNEL_VECTOR_DATA);
    return Data;
}

void XHcr_controller_Set_cfg_watchdog(XHcr_controller *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_WATCHDOG_DATA, Data);
}

u32 XHcr_controller_Get_cfg_watchdog(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_WATCHDOG_DATA);
    return Data;
}

void XHcr_controller_Set_cfg_use_mag_phase(XHcr_controller *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_USE_MAG_PHASE_DATA, Data);
}

u32 XHcr_controller_Get_cfg_use_mag_phase(XHcr_controller *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_USE_MAG_PHASE_DATA);
    return Data;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_prt_0_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_prt_0_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_prt_0_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_prt_0_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_PRT_0;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_prt_0_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_PRT_0;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_prt_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_prt_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_prt_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_prt_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_prt_1_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_prt_1_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_prt_1_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_prt_1_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_PRT_1;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_prt_1_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_PRT_1;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_prt_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_prt_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_prt_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_prt_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_num_pulses_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_num_pulses_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_num_pulses_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_num_pulses_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_NUM_PULSES;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_num_pulses_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_NUM_PULSES;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_num_pulses_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_num_pulses_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_num_pulses_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_num_pulses_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_block_post_time_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_block_post_time_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_block_post_time_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_block_post_time_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_block_post_time_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_block_post_time_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_block_post_time_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_block_post_time_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_block_post_time_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_control_flags_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_control_flags_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_control_flags_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_control_flags_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_CONTROL_FLAGS;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_control_flags_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_CONTROL_FLAGS;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_control_flags_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_control_flags_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_control_flags_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_control_flags_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_polarization_mode_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_polarization_mode_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_polarization_mode_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_polarization_mode_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_POLARIZATION_MODE;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_polarization_mode_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_POLARIZATION_MODE;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_polarization_mode_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_polarization_mode_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_polarization_mode_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_polarization_mode_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch0_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch0_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch0_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch0_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch0_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch1_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch1_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch1_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch1_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch1_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch2_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch2_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch2_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch2_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch2_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_begin_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_begin_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_begin_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_begin_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_begin_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_phase_table_begin_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_phase_table_begin_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_phase_table_begin_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_phase_table_begin_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_end_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_end_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_end_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_end_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_PHASE_TABLE_END;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_end_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_PHASE_TABLE_END;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_phase_table_end_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_phase_table_end_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_phase_table_end_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_phase_table_end_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_0_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_0_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_0_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_0_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_0_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_1_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_1_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_1_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_1_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_1_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_2_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_2_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_2_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_2_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_2_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_3_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_3_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_3_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_3_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_3_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_3_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_3_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_3_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_3_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_4_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_4_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_4_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_4_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_4_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_4_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_4_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_4_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_4_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_5_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_5_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_5_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_5_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_5_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_5_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_5_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_5_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_5_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_6_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_6_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_6_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_6_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_6_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_6_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_6_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_6_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_6_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_7_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_7_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_7_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_7_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_7_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_7_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_7_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_7_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_7_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_0_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_0_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_0_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_0_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_0_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_1_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_1_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_1_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_1_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_1_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_2_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_2_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_2_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_2_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_2_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_3_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_3_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_3_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_3_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_3_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_3_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_3_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_3_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_3_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_4_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_4_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_4_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_4_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_4_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_4_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_4_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_4_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_4_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_5_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_5_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_5_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_5_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_5_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_5_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_5_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_5_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_5_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_6_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_6_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_6_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_6_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_6_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_6_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_6_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_6_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_6_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_7_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_7_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_7_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE + 1);
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_7_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7;
}

u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_7_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_7_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_7_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_7_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_7_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch0_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE);
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch0_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_HIGH);
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch0_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE + 1);
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch0_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_FILTER_COEFS_CH0;
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch0_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_FILTER_COEFS_CH0;
}

u32 XHcr_controller_Write_cfg_filter_coefs_ch0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_filter_coefs_ch0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_filter_coefs_ch0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_filter_coefs_ch0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch1_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE);
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch1_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_HIGH);
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch1_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE + 1);
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch1_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_FILTER_COEFS_CH1;
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch1_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_FILTER_COEFS_CH1;
}

u32 XHcr_controller_Write_cfg_filter_coefs_ch1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_filter_coefs_ch1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_filter_coefs_ch1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_filter_coefs_ch1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch2_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE);
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch2_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_HIGH);
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch2_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE + 1);
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch2_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_FILTER_COEFS_CH2;
}

u32 XHcr_controller_Get_cfg_filter_coefs_ch2_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_FILTER_COEFS_CH2;
}

u32 XHcr_controller_Write_cfg_filter_coefs_ch2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_filter_coefs_ch2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_filter_coefs_ch2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_filter_coefs_ch2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE + offset + i);
    }
    return length;
}

u32 XHcr_controller_Get_cfg_phase_samples_BaseAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_BASE);
}

u32 XHcr_controller_Get_cfg_phase_samples_HighAddress(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_HIGH);
}

u32 XHcr_controller_Get_cfg_phase_samples_TotalBytes(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_BASE + 1);
}

u32 XHcr_controller_Get_cfg_phase_samples_BitWidth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PHASE_SAMPLES;
}

u32 XHcr_controller_Get_cfg_phase_samples_Depth(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PHASE_SAMPLES;
}

u32 XHcr_controller_Write_cfg_phase_samples_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_phase_samples_Words(XHcr_controller *InstancePtr, int offset, int *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_BASE + (offset + i)*4);
    }
    return length;
}

u32 XHcr_controller_Write_cfg_phase_samples_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XHcr_controller_Read_cfg_phase_samples_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_HIGH - XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Cfg_bus_BaseAddress + XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_BASE + offset + i);
    }
    return length;
}

void XHcr_controller_InterruptGlobalEnable(XHcr_controller *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_GIE, 1);
}

void XHcr_controller_InterruptGlobalDisable(XHcr_controller *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_GIE, 0);
}

void XHcr_controller_InterruptEnable(XHcr_controller *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_IER);
    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_IER, Register | Mask);
}

void XHcr_controller_InterruptDisable(XHcr_controller *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_IER);
    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_IER, Register & (~Mask));
}

void XHcr_controller_InterruptClear(XHcr_controller *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHcr_controller_WriteReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_ISR, Mask);
}

u32 XHcr_controller_InterruptGetEnabled(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_IER);
}

u32 XHcr_controller_InterruptGetStatus(XHcr_controller *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHcr_controller_ReadReg(InstancePtr->Cfg_bus_BaseAddress, XHCR_CONTROLLER_CFG_BUS_ADDR_ISR);
}

