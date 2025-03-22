#!/bin/bash

mkdir /odm/etc
mount --bind /odm_root/etc /odm/etc

# wlan
mount --bind /lib/modules/`uname -r`/wlan.ko /vendor/lib/modules/qca_cld3_wlan.ko

# audio
# 1. 先加载 Q6 DSP 相关核心模块（低级驱动）
mount --bind /lib/modules/`uname -r`/q6_pdr_dlkm.ko /vendor/lib/modules/audio_q6_pdr.ko
mount --bind /lib/modules/`uname -r`/q6_notifier_dlkm.ko /vendor/lib/modules/audio_q6_notifier.ko
mount --bind /lib/modules/`uname -r`/apr_dlkm.ko /vendor/lib/modules/audio_apr.ko
mount --bind /lib/modules/`uname -r`/q6_dlkm.ko /vendor/lib/modules/audio_q6.ko

# 2. 加载 WCD 相关核心模块
mount --bind /lib/modules/`uname -r`/wcd_core_dlkm.ko /vendor/lib/modules/audio_wcd_core.ko
mount --bind /lib/modules/`uname -r`/wcd9xxx_dlkm.ko /vendor/lib/modules/audio_wcd9xxx.ko
mount --bind /lib/modules/`uname -r`/wcd934x_dlkm.ko /vendor/lib/modules/audio_wcd934x.ko
mount --bind /lib/modules/`uname -r`/wcd9360_dlkm.ko /vendor/lib/modules/audio_wcd9360.ko
mount --bind /lib/modules/`uname -r`/wcd_spi_dlkm.ko /vendor/lib/modules/audio_wcd_spi.ko

# 3. 其他音频相关模块
mount --bind /lib/modules/`uname -r`/pinctrl_wcd_dlkm.ko /vendor/lib/modules/audio_pinctrl_wcd.ko
mount --bind /lib/modules/`uname -r`/machine_msmnile_dlkm.ko /vendor/lib/modules/audio_machine_msmnile.ko
mount --bind /lib/modules/`uname -r`/swr_dlkm.ko /vendor/lib/modules/audio_swr.ko
mount --bind /lib/modules/`uname -r`/swr_ctrl_dlkm.ko /vendor/lib/modules/audio_swr_ctrl.ko
mount --bind /lib/modules/`uname -r`/mbhc_dlkm.ko /vendor/lib/modules/audio_mbhc.ko

# 4. 其他外设或增强功能相关模块
mount --bind /lib/modules/`uname -r`/platform_dlkm.ko /vendor/lib/modules/audio_platform.ko
mount --bind /lib/modules/`uname -r`/usf_dlkm.ko /vendor/lib/modules/audio_usf.ko
mount --bind /lib/modules/`uname -r`/wsa881x_dlkm.ko /vendor/lib/modules/audio_wsa881x.ko
mount --bind /lib/modules/`uname -r`/tfa98xx_dlkm.ko /vendor/lib/modules/audio_tfa98xx.ko
mount --bind /lib/modules/`uname -r`/cs35l41_dlkm.ko /vendor/lib/modules/audio_cs35l41.ko
mount --bind /lib/modules/`uname -r`/hdmi_dlkm.ko /vendor/lib/modules/audio_hdmi.ko
mount --bind /lib/modules/`uname -r`/native_dlkm.ko /vendor/lib/modules/audio_native.ko
mount --bind /lib/modules/`uname -r`/adsp_loader_dlkm.ko /vendor/lib/modules/audio_adsp_loader.ko
mount --bind /lib/modules/`uname -r`/stub_dlkm.ko /vendor/lib/modules/audio_stub.ko
mount --bind /lib/modules/`uname -r`/wglink_dlkm.ko /vendor/lib/modules/audio_wglink.ko

