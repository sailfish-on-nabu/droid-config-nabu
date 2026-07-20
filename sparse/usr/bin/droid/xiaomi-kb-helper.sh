#!/bin/sh
# Xiaomi Pad 5 Keyboard Helper for SailfishOS
# 监听霍尔传感器事件，自动启用/禁用键盘MCU
#
# 硬件链路:
#   磁吸键盘 → 霍尔传感器(GPIO9/GPIO83) → gpio-keys → EV_SW事件
#   → 本脚本 → sysfs enable_keyboard → MCU上电(GPIO82)
#   → USB1(a800000.dwc3 host) → USB HID枚举 → event8(键盘) + event9(触控板)

SYSFS_KB="/sys/bus/platform/drivers/xiaomi-keyboard/soc:xiaomi_keyboard/xiaomi_keyboard_conn_status"
HALL_EVENT="/dev/input/event2"
USB_VID_PID="3206:3ffc"
LOG_TAG="xiaomi-kb"
POLL_INTERVAL=2

log_msg() {
    logger -t "$LOG_TAG" "$1" 2>/dev/null
    echo "[$LOG_TAG] $1" >&2
}

enable_mcu() {
    local current
    current=$(cat "$SYSFS_KB" 2>/dev/null)
    if [ "$current" = "0" ]; then
        echo "enable_keyboard" > "$SYSFS_KB" 2>/dev/null
        log_msg "MCU enabled"
        return 0
    fi
    log_msg "MCU already enabled (status=$current)"
    return 0
}

disable_mcu() {
    echo "disable_keyboard" > "$SYSFS_KB" 2>/dev/null
    log_msg "MCU disabled"
}

is_usb_keyboard_present() {
    lsusb 2>/dev/null | grep -q "$USB_VID_PID"
    return $?
}

wait_for_usb() {
    local i=0
    while [ $i -lt 10 ]; do
        is_usb_keyboard_present && return 0
        sleep 1
        i=$((i + 1))
    done
    log_msg "USB keyboard not found after 10s"
    return 1
}

# 从od输出中解析小端16位整数
# 输入: od -A n -t x1 输出的两个字节 (如 "1e 05")
parse_le16() {
    local lo="$1" hi="$2"
    printf '%d' "$(( (0x${hi} << 8) | 0x${lo} ))"
}

# 从od输出中解析小端32位整数
# 输入: od -A n -t x1 输出的四个字节 (如 "01 00 00 00")
parse_le32() {
    local b0="$1" b1="$2" b2="$3" b3="$4"
    printf '%d' "$(( 0x${b0} | (0x${b1} << 8) | (0x${b2} << 16) | (0x${b3} << 24) ))"
}

# 监听霍尔传感器input事件
# input_event 结构体 = 24 bytes:
#   bytes 0-15:  timestamp (忽略)
#   bytes 16-17: type   (LE 16-bit)  EV_SW=5
#   bytes 18-19: code   (LE 16-bit)  SW_LID=0
#   bytes 20-23: value  (LE 32-bit)  1=吸附 0=分离
monitor_hall_sensor() {
    log_msg "Monitoring hall sensor on $HALL_EVENT"

    local fd
    exec 3<>"$HALL_EVENT"
    fd=3

    while true; do
        # 读取24字节, 用od转为十六进制 (空格分隔, 无地址)
        raw=$(dd bs=24 count=1 <&$fd 2>/dev/null | od -A n -t x1 | tr -s ' ')
        [ -z "$raw" ] && continue

        # 解析: byte0..byte15=timestamp, byte16-17=type, byte18-19=code, byte20-23=value
        set -- $raw
        # $1-$16 = timestamp, $17=type_lo, $18=type_hi, $19=code_lo, $20=code_hi
        # $21=val0, $22=val1, $23=val2, $24=val3
        eval "type_lo=\$17 type_hi=\$18 code_lo=\$19 code_hi=\$20"
        eval "val0=\$21 val1=\$22 val2=\$23 val3=\$24"

        ev_type=$(parse_le16 "$type_lo" "$type_hi")
        ev_code=$(parse_le16 "$code_lo" "$code_hi")
        ev_value=$(parse_le32 "$val0" "$val1" "$val2" "$val3")

        # EV_SW = 5
        if [ "$ev_type" -eq 5 ]; then
            if [ "$ev_code" -eq 0 ] && [ "$ev_value" -eq 1 ]; then
                log_msg "Hall: keyboard attached"
                enable_mcu
                wait_for_usb
            elif [ "$ev_code" -eq 0 ] && [ "$ev_value" -eq 0 ]; then
                log_msg "Hall: keyboard detached"
                disable_mcu
            fi
        fi
    done

    exec 3>&-
}

# 降级轮询模式
poll_fallback() {
    log_msg "Falling back to USB polling (interval=${POLL_INTERVAL}s)"
    local was_present=0
    is_usb_keyboard_present && was_present=1 && enable_mcu

    while true; do
        sleep "$POLL_INTERVAL"
        local now_present=0
        is_usb_keyboard_present && now_present=1

        if [ "$now_present" -eq 1 ] && [ "$was_present" -eq 0 ]; then
            log_msg "Keyboard connected (polling)"
            enable_mcu
        elif [ "$now_present" -eq 0 ] && [ "$was_present" -eq 1 ]; then
            log_msg "Keyboard disconnected (polling)"
            disable_mcu
        fi
        was_present=$now_present
    done
}

# --- Main ---
log_msg "Xiaomi keyboard helper started (PID $$)"

if [ ! -f "$SYSFS_KB" ]; then
    log_msg "ERROR: $SYSFS_KB not found"
    exit 1
fi

# 已有USB设备则先启用
is_usb_keyboard_present && enable_mcu

# 监听霍尔传感器
if [ -c "$HALL_EVENT" ]; then
    # 测试能否打开
    exec 3<>"$HALL_EVENT" 2>/dev/null
    if [ $? -eq 0 ]; then
        exec 3>&-
        monitor_hall_sensor
    else
        log_msg "Cannot open $HALL_EVENT, falling back to polling"
        poll_fallback
    fi
else
    log_msg "Hall sensor $HALL_EVENT not found, falling back to polling"
    poll_fallback
fi

