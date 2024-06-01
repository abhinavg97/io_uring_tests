#!/bin/bash

# Enable core 0
echo 1 | sudo tee /sys/devices/system/cpu/cpu0/online


# Disable all other cores
for core in /sys/devices/system/cpu/cpu[0-9]*; do
    echo 0 | sudo tee "$core/online"
done

echo "Only core 0 is active."
