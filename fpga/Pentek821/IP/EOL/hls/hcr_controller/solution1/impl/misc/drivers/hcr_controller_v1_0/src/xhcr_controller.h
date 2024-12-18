// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XHCR_CONTROLLER_H
#define XHCR_CONTROLLER_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xhcr_controller_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
#else
typedef struct {
    u16 DeviceId;
    u32 Cfg_bus_BaseAddress;
} XHcr_controller_Config;
#endif

typedef struct {
    u32 Cfg_bus_BaseAddress;
    u32 IsReady;
} XHcr_controller;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XHcr_controller_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XHcr_controller_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XHcr_controller_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XHcr_controller_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XHcr_controller_Initialize(XHcr_controller *InstancePtr, u16 DeviceId);
XHcr_controller_Config* XHcr_controller_LookupConfig(u16 DeviceId);
int XHcr_controller_CfgInitialize(XHcr_controller *InstancePtr, XHcr_controller_Config *ConfigPtr);
#else
int XHcr_controller_Initialize(XHcr_controller *InstancePtr, const char* InstanceName);
int XHcr_controller_Release(XHcr_controller *InstancePtr);
#endif

void XHcr_controller_Start(XHcr_controller *InstancePtr);
u32 XHcr_controller_IsDone(XHcr_controller *InstancePtr);
u32 XHcr_controller_IsIdle(XHcr_controller *InstancePtr);
u32 XHcr_controller_IsReady(XHcr_controller *InstancePtr);
void XHcr_controller_EnableAutoRestart(XHcr_controller *InstancePtr);
void XHcr_controller_DisableAutoRestart(XHcr_controller *InstancePtr);

void XHcr_controller_Set_cfg_pulse_sequence_start_stop_indexes(XHcr_controller *InstancePtr, u32 Data);
u32 XHcr_controller_Get_cfg_pulse_sequence_start_stop_indexes(XHcr_controller *InstancePtr);
void XHcr_controller_Set_cfg_num_pulses_to_execute(XHcr_controller *InstancePtr, u32 Data);
u32 XHcr_controller_Get_cfg_num_pulses_to_execute(XHcr_controller *InstancePtr);
void XHcr_controller_Set_cfg_total_decimation(XHcr_controller *InstancePtr, u32 Data);
u32 XHcr_controller_Get_cfg_total_decimation(XHcr_controller *InstancePtr);
void XHcr_controller_Set_cfg_post_decimation(XHcr_controller *InstancePtr, u32 Data);
u32 XHcr_controller_Get_cfg_post_decimation(XHcr_controller *InstancePtr);
void XHcr_controller_Set_cfg_num_pulses_per_xfer(XHcr_controller *InstancePtr, u32 Data);
u32 XHcr_controller_Get_cfg_num_pulses_per_xfer(XHcr_controller *InstancePtr);
void XHcr_controller_Set_cfg_enabled_channel_vector(XHcr_controller *InstancePtr, u32 Data);
u32 XHcr_controller_Get_cfg_enabled_channel_vector(XHcr_controller *InstancePtr);
void XHcr_controller_Set_cfg_watchdog(XHcr_controller *InstancePtr, u32 Data);
u32 XHcr_controller_Get_cfg_watchdog(XHcr_controller *InstancePtr);
void XHcr_controller_Set_cfg_use_mag_phase(XHcr_controller *InstancePtr, u32 Data);
u32 XHcr_controller_Get_cfg_use_mag_phase(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_prt_0_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_prt_0_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_prt_0_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_prt_0_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_prt_0_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_prt_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_prt_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_prt_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_prt_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_prt_1_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_prt_1_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_prt_1_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_prt_1_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_prt_1_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_prt_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_prt_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_prt_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_prt_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_num_pulses_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_num_pulses_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_num_pulses_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_num_pulses_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_num_pulses_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_num_pulses_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_num_pulses_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_num_pulses_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_num_pulses_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_block_post_time_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_block_post_time_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_block_post_time_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_block_post_time_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_block_post_time_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_block_post_time_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_block_post_time_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_block_post_time_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_block_post_time_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_control_flags_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_control_flags_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_control_flags_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_control_flags_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_control_flags_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_control_flags_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_control_flags_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_control_flags_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_control_flags_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_polarization_mode_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_polarization_mode_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_polarization_mode_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_polarization_mode_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_polarization_mode_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_polarization_mode_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_polarization_mode_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_polarization_mode_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_polarization_mode_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch0_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch0_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch0_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch0_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch0_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch1_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch1_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch1_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch1_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch1_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch2_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch2_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch2_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch2_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_filter_select_ch2_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_filter_select_ch2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_filter_select_ch2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_begin_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_begin_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_begin_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_begin_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_begin_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_phase_table_begin_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_phase_table_begin_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_phase_table_begin_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_phase_table_begin_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_end_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_end_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_end_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_end_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_phase_table_end_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_phase_table_end_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_phase_table_end_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_phase_table_end_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_phase_table_end_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_0_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_0_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_0_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_0_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_0_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_1_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_1_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_1_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_1_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_1_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_2_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_2_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_2_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_2_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_2_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_3_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_3_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_3_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_3_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_3_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_3_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_3_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_3_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_3_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_4_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_4_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_4_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_4_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_4_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_4_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_4_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_4_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_4_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_5_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_5_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_5_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_5_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_5_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_5_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_5_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_5_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_5_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_6_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_6_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_6_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_6_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_6_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_6_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_6_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_6_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_6_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_7_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_7_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_7_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_7_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_offset_7_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_7_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_7_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_offset_7_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_offset_7_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_0_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_0_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_0_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_0_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_0_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_1_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_1_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_1_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_1_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_1_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_2_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_2_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_2_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_2_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_2_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_3_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_3_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_3_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_3_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_3_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_3_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_3_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_3_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_3_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_4_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_4_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_4_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_4_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_4_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_4_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_4_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_4_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_4_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_5_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_5_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_5_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_5_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_5_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_5_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_5_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_5_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_5_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_6_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_6_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_6_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_6_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_6_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_6_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_6_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_6_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_6_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_7_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_7_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_7_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_7_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_pulse_sequence_timer_width_7_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_7_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_7_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_pulse_sequence_timer_width_7_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_pulse_sequence_timer_width_7_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_filter_coefs_ch0_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch0_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch0_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch0_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch0_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_filter_coefs_ch0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_filter_coefs_ch0_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_filter_coefs_ch0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_filter_coefs_ch0_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_filter_coefs_ch1_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch1_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch1_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch1_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch1_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_filter_coefs_ch1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_filter_coefs_ch1_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_filter_coefs_ch1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_filter_coefs_ch1_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_filter_coefs_ch2_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch2_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch2_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch2_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_filter_coefs_ch2_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_filter_coefs_ch2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_filter_coefs_ch2_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_filter_coefs_ch2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_filter_coefs_ch2_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Get_cfg_phase_samples_BaseAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_phase_samples_HighAddress(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_phase_samples_TotalBytes(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_phase_samples_BitWidth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Get_cfg_phase_samples_Depth(XHcr_controller *InstancePtr);
u32 XHcr_controller_Write_cfg_phase_samples_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Read_cfg_phase_samples_Words(XHcr_controller *InstancePtr, int offset, int *data, int length);
u32 XHcr_controller_Write_cfg_phase_samples_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);
u32 XHcr_controller_Read_cfg_phase_samples_Bytes(XHcr_controller *InstancePtr, int offset, char *data, int length);

void XHcr_controller_InterruptGlobalEnable(XHcr_controller *InstancePtr);
void XHcr_controller_InterruptGlobalDisable(XHcr_controller *InstancePtr);
void XHcr_controller_InterruptEnable(XHcr_controller *InstancePtr, u32 Mask);
void XHcr_controller_InterruptDisable(XHcr_controller *InstancePtr, u32 Mask);
void XHcr_controller_InterruptClear(XHcr_controller *InstancePtr, u32 Mask);
u32 XHcr_controller_InterruptGetEnabled(XHcr_controller *InstancePtr);
u32 XHcr_controller_InterruptGetStatus(XHcr_controller *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
