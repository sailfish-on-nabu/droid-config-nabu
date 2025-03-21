#!/bin/bash

/usr/sbin/ip a | grep "wlan\|wlp" > /dev/null

while [ $? -eq 1 ]; do sleep 1; ip a | grep "wlan\|wlp" > /dev/null; done

exit 0
