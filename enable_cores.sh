#!/bin/bash

# Enable all cores
for core in /sys/devices/system/cpu/cpu[0-9]*; do
    echo 1 | sudo tee "$core/online"
done

echo "All cores are active."

