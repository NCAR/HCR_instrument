/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/TEMP/HMC_Redesign/HMC_tb.vhd";



static void work_a_4123021360_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 9152U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(193, ng0);
    t2 = (t0 + 10776);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(194, ng0);
    t2 = (t0 + 8048U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 8960);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(195, ng0);
    t2 = (t0 + 10776);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(196, ng0);
    t2 = (t0 + 8048U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 8960);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_4123021360_2372691052_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;

LAB0:    t1 = (t0 + 9400U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(201, ng0);
    t2 = (t0 + 10840);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(202, ng0);
    t7 = (101376 * 1000LL);
    t2 = (t0 + 9208);
    xsi_process_wait(t2, t7);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(204, ng0);
    t2 = (t0 + 10840);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(205, ng0);
    t7 = (101376 * 1000LL);
    t2 = (t0 + 9208);
    xsi_process_wait(t2, t7);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_4123021360_2372691052_p_2(char *t0)
{
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t1 = (t0 + 9648U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(211, ng0);
    t3 = (100 * 1000LL);
    t2 = (t0 + 9456);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(212, ng0);
    t2 = (t0 + 10904);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(213, ng0);
    t3 = (500 * 1000LL);
    t2 = (t0 + 9456);
    xsi_process_wait(t2, t3);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(214, ng0);
    t2 = (t0 + 10968);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(215, ng0);
    t2 = (t0 + 11032);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(216, ng0);
    t2 = (t0 + 10904);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(217, ng0);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    goto LAB2;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

}

static void work_a_4123021360_2372691052_p_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;

LAB0:    t1 = (t0 + 9896U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(222, ng0);
    t2 = (t0 + 11096);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(223, ng0);
    t2 = (t0 + 11160);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(224, ng0);
    t7 = (128 * 1000LL);
    t2 = (t0 + 9704);
    xsi_process_wait(t2, t7);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(225, ng0);
    t2 = (t0 + 11096);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(226, ng0);
    t7 = (272 * 1000LL);
    t2 = (t0 + 9704);
    xsi_process_wait(t2, t7);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(227, ng0);
    t2 = (t0 + 11224);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(228, ng0);
    t7 = (512 * 1000LL);
    t2 = (t0 + 9704);
    xsi_process_wait(t2, t7);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(229, ng0);
    t2 = (t0 + 11224);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(230, ng0);
    t7 = (256 * 1000LL);
    t2 = (t0 + 9704);
    xsi_process_wait(t2, t7);

LAB18:    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB16:    xsi_set_current_line(231, ng0);
    t2 = (t0 + 11160);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(232, ng0);
    t2 = (t0 + 11288);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(233, ng0);
    t7 = (97280 * 1000LL);
    t2 = (t0 + 9704);
    xsi_process_wait(t2, t7);

LAB22:    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB17:    goto LAB16;

LAB19:    goto LAB17;

LAB20:    xsi_set_current_line(234, ng0);
    t2 = (t0 + 11288);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(235, ng0);
    t7 = (2928 * 1000LL);
    t2 = (t0 + 9704);
    xsi_process_wait(t2, t7);

LAB26:    *((char **)t1) = &&LAB27;
    goto LAB1;

LAB21:    goto LAB20;

LAB23:    goto LAB21;

LAB24:    goto LAB2;

LAB25:    goto LAB24;

LAB27:    goto LAB25;

}

static void work_a_4123021360_2372691052_p_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;

LAB0:    t1 = (t0 + 10144U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(240, ng0);
    t2 = (t0 + 11352);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(241, ng0);
    t7 = (2304 * 1000LL);
    t2 = (t0 + 9952);
    xsi_process_wait(t2, t7);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(242, ng0);
    t2 = (t0 + 11352);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(243, ng0);
    t7 = (2304 * 1000LL);
    t2 = (t0 + 9952);
    xsi_process_wait(t2, t7);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_4123021360_2372691052_p_5(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    char *t8;
    char *t9;
    int t10;
    unsigned char t11;
    char *t12;
    int t13;

LAB0:    t1 = (t0 + 10392U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(249, ng0);
    t2 = (t0 + 8168U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(250, ng0);
    t2 = (t0 + 11416);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(251, ng0);
    t2 = (t0 + 11480);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(252, ng0);
    t7 = (320 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(254, ng0);
    t2 = (t0 + 16496);
    t4 = (t0 + 11544);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(255, ng0);
    t2 = (t0 + 16499);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(256, ng0);
    t7 = (1168 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(257, ng0);
    t2 = (t0 + 16506);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(258, ng0);
    t7 = (99788 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(259, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(260, ng0);
    t7 = (100 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB18:    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB16:    xsi_set_current_line(261, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(296, ng0);
    t2 = (t0 + 8168U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(297, ng0);

LAB20:    t2 = (t0 + 8168U);
    t3 = *((char **)t2);
    t10 = *((int *)t3);
    t11 = (t10 <= 1000);
    if (t11 != 0)
        goto LAB21;

LAB23:    xsi_set_current_line(320, ng0);
    t7 = (320 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB47:    *((char **)t1) = &&LAB48;
    goto LAB1;

LAB17:    goto LAB16;

LAB19:    goto LAB17;

LAB21:    xsi_set_current_line(298, ng0);
    t7 = (320 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB26:    *((char **)t1) = &&LAB27;
    goto LAB1;

LAB22:;
LAB24:    xsi_set_current_line(300, ng0);
    t2 = (t0 + 8168U);
    t3 = *((char **)t2);
    t10 = *((int *)t3);
    t11 = (t10 == 988);
    if (t11 != 0)
        goto LAB28;

LAB30:    t2 = (t0 + 8168U);
    t3 = *((char **)t2);
    t10 = *((int *)t3);
    t11 = (t10 == 1000);
    if (t11 != 0)
        goto LAB31;

LAB32:    xsi_set_current_line(308, ng0);
    t2 = (t0 + 16516);
    t4 = (t0 + 11544);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 3U);
    xsi_driver_first_trans_fast(t4);

LAB29:    xsi_set_current_line(310, ng0);
    t2 = (t0 + 16519);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(311, ng0);
    t7 = (1168 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB35:    *((char **)t1) = &&LAB36;
    goto LAB1;

LAB25:    goto LAB24;

LAB27:    goto LAB25;

LAB28:    xsi_set_current_line(301, ng0);
    t2 = (t0 + 11416);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t8 = *((char **)t6);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(302, ng0);
    t2 = (t0 + 11480);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB29;

LAB31:    xsi_set_current_line(304, ng0);
    t2 = (t0 + 16513);
    t5 = (t0 + 11544);
    t6 = (t5 + 56U);
    t8 = *((char **)t6);
    t9 = (t8 + 56U);
    t12 = *((char **)t9);
    memcpy(t12, t2, 3U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(305, ng0);
    t2 = (t0 + 11416);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(306, ng0);
    t2 = (t0 + 11480);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB29;

LAB33:    xsi_set_current_line(312, ng0);
    t2 = (t0 + 16526);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(313, ng0);
    t7 = (99788 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB39:    *((char **)t1) = &&LAB40;
    goto LAB1;

LAB34:    goto LAB33;

LAB36:    goto LAB34;

LAB37:    xsi_set_current_line(314, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(315, ng0);
    t7 = (100 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB43:    *((char **)t1) = &&LAB44;
    goto LAB1;

LAB38:    goto LAB37;

LAB40:    goto LAB38;

LAB41:    xsi_set_current_line(316, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(317, ng0);
    t2 = (t0 + 8168U);
    t3 = *((char **)t2);
    t10 = *((int *)t3);
    t13 = (t10 + 1);
    t2 = (t0 + 8168U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = t13;
    goto LAB20;

LAB42:    goto LAB41;

LAB44:    goto LAB42;

LAB45:    xsi_set_current_line(322, ng0);
    t2 = (t0 + 16533);
    t4 = (t0 + 11544);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(323, ng0);
    t2 = (t0 + 16536);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(324, ng0);
    t7 = (1168 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB51:    *((char **)t1) = &&LAB52;
    goto LAB1;

LAB46:    goto LAB45;

LAB48:    goto LAB46;

LAB49:    xsi_set_current_line(325, ng0);
    t2 = (t0 + 16543);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(326, ng0);
    t7 = (99788 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB55:    *((char **)t1) = &&LAB56;
    goto LAB1;

LAB50:    goto LAB49;

LAB52:    goto LAB50;

LAB53:    xsi_set_current_line(327, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(328, ng0);
    t7 = (100 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB59:    *((char **)t1) = &&LAB60;
    goto LAB1;

LAB54:    goto LAB53;

LAB56:    goto LAB54;

LAB57:    xsi_set_current_line(329, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(332, ng0);
    t7 = (320 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB63:    *((char **)t1) = &&LAB64;
    goto LAB1;

LAB58:    goto LAB57;

LAB60:    goto LAB58;

LAB61:    xsi_set_current_line(333, ng0);
    t2 = (t0 + 16550);
    t4 = (t0 + 11544);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(334, ng0);
    t2 = (t0 + 16553);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(335, ng0);
    t7 = (1168 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB67:    *((char **)t1) = &&LAB68;
    goto LAB1;

LAB62:    goto LAB61;

LAB64:    goto LAB62;

LAB65:    xsi_set_current_line(336, ng0);
    t2 = (t0 + 16560);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(337, ng0);
    t7 = (99788 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB71:    *((char **)t1) = &&LAB72;
    goto LAB1;

LAB66:    goto LAB65;

LAB68:    goto LAB66;

LAB69:    xsi_set_current_line(338, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(339, ng0);
    t7 = (100 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB75:    *((char **)t1) = &&LAB76;
    goto LAB1;

LAB70:    goto LAB69;

LAB72:    goto LAB70;

LAB73:    xsi_set_current_line(340, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(342, ng0);
    t7 = (320 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB79:    *((char **)t1) = &&LAB80;
    goto LAB1;

LAB74:    goto LAB73;

LAB76:    goto LAB74;

LAB77:    xsi_set_current_line(343, ng0);
    t2 = (t0 + 16567);
    t4 = (t0 + 11544);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(344, ng0);
    t2 = (t0 + 16570);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(345, ng0);
    t7 = (1168 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB83:    *((char **)t1) = &&LAB84;
    goto LAB1;

LAB78:    goto LAB77;

LAB80:    goto LAB78;

LAB81:    xsi_set_current_line(346, ng0);
    t2 = (t0 + 16577);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(347, ng0);
    t7 = (99788 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB87:    *((char **)t1) = &&LAB88;
    goto LAB1;

LAB82:    goto LAB81;

LAB84:    goto LAB82;

LAB85:    xsi_set_current_line(348, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(349, ng0);
    t7 = (100 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB91:    *((char **)t1) = &&LAB92;
    goto LAB1;

LAB86:    goto LAB85;

LAB88:    goto LAB86;

LAB89:    xsi_set_current_line(350, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(352, ng0);
    t7 = (320 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB95:    *((char **)t1) = &&LAB96;
    goto LAB1;

LAB90:    goto LAB89;

LAB92:    goto LAB90;

LAB93:    xsi_set_current_line(353, ng0);
    t2 = (t0 + 16584);
    t4 = (t0 + 11544);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(354, ng0);
    t2 = (t0 + 16587);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(355, ng0);
    t7 = (1168 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB99:    *((char **)t1) = &&LAB100;
    goto LAB1;

LAB94:    goto LAB93;

LAB96:    goto LAB94;

LAB97:    xsi_set_current_line(356, ng0);
    t2 = (t0 + 16594);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(357, ng0);
    t7 = (99788 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB103:    *((char **)t1) = &&LAB104;
    goto LAB1;

LAB98:    goto LAB97;

LAB100:    goto LAB98;

LAB101:    xsi_set_current_line(358, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(359, ng0);
    t7 = (100 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB107:    *((char **)t1) = &&LAB108;
    goto LAB1;

LAB102:    goto LAB101;

LAB104:    goto LAB102;

LAB105:    xsi_set_current_line(360, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(362, ng0);
    t7 = (320 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB111:    *((char **)t1) = &&LAB112;
    goto LAB1;

LAB106:    goto LAB105;

LAB108:    goto LAB106;

LAB109:    xsi_set_current_line(363, ng0);
    t2 = (t0 + 16601);
    t4 = (t0 + 11544);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(364, ng0);
    t2 = (t0 + 16604);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(365, ng0);
    t7 = (1168 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB115:    *((char **)t1) = &&LAB116;
    goto LAB1;

LAB110:    goto LAB109;

LAB112:    goto LAB110;

LAB113:    xsi_set_current_line(366, ng0);
    t2 = (t0 + 16611);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(367, ng0);
    t7 = (99788 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB119:    *((char **)t1) = &&LAB120;
    goto LAB1;

LAB114:    goto LAB113;

LAB116:    goto LAB114;

LAB117:    xsi_set_current_line(368, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(369, ng0);
    t7 = (100 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB123:    *((char **)t1) = &&LAB124;
    goto LAB1;

LAB118:    goto LAB117;

LAB120:    goto LAB118;

LAB121:    xsi_set_current_line(370, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(372, ng0);
    t7 = (320 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB127:    *((char **)t1) = &&LAB128;
    goto LAB1;

LAB122:    goto LAB121;

LAB124:    goto LAB122;

LAB125:    xsi_set_current_line(373, ng0);
    t2 = (t0 + 16618);
    t4 = (t0 + 11544);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(374, ng0);
    t2 = (t0 + 16621);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(375, ng0);
    t7 = (1168 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB131:    *((char **)t1) = &&LAB132;
    goto LAB1;

LAB126:    goto LAB125;

LAB128:    goto LAB126;

LAB129:    xsi_set_current_line(376, ng0);
    t2 = (t0 + 16628);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(377, ng0);
    t7 = (99788 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB135:    *((char **)t1) = &&LAB136;
    goto LAB1;

LAB130:    goto LAB129;

LAB132:    goto LAB130;

LAB133:    xsi_set_current_line(378, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(379, ng0);
    t7 = (100 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB139:    *((char **)t1) = &&LAB140;
    goto LAB1;

LAB134:    goto LAB133;

LAB136:    goto LAB134;

LAB137:    xsi_set_current_line(380, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(382, ng0);
    t7 = (320 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB143:    *((char **)t1) = &&LAB144;
    goto LAB1;

LAB138:    goto LAB137;

LAB140:    goto LAB138;

LAB141:    xsi_set_current_line(383, ng0);
    t2 = (t0 + 16635);
    t4 = (t0 + 11544);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 3U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(384, ng0);
    t2 = (t0 + 16638);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(385, ng0);
    t7 = (1168 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB147:    *((char **)t1) = &&LAB148;
    goto LAB1;

LAB142:    goto LAB141;

LAB144:    goto LAB142;

LAB145:    xsi_set_current_line(386, ng0);
    t2 = (t0 + 16645);
    t4 = (t0 + 11608);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 7U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(387, ng0);
    t7 = (99788 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB151:    *((char **)t1) = &&LAB152;
    goto LAB1;

LAB146:    goto LAB145;

LAB148:    goto LAB146;

LAB149:    xsi_set_current_line(388, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(389, ng0);
    t7 = (100 * 1000LL);
    t2 = (t0 + 10200);
    xsi_process_wait(t2, t7);

LAB155:    *((char **)t1) = &&LAB156;
    goto LAB1;

LAB150:    goto LAB149;

LAB152:    goto LAB150;

LAB153:    xsi_set_current_line(390, ng0);
    t2 = (t0 + 11672);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB2;

LAB154:    goto LAB153;

LAB156:    goto LAB154;

}


extern void work_a_4123021360_2372691052_init()
{
	static char *pe[] = {(void *)work_a_4123021360_2372691052_p_0,(void *)work_a_4123021360_2372691052_p_1,(void *)work_a_4123021360_2372691052_p_2,(void *)work_a_4123021360_2372691052_p_3,(void *)work_a_4123021360_2372691052_p_4,(void *)work_a_4123021360_2372691052_p_5};
	xsi_register_didat("work_a_4123021360_2372691052", "isim/HMC_tb_isim_beh.exe.sim/work/a_4123021360_2372691052.didat");
	xsi_register_executes(pe);
}
