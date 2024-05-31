#!/bin/bash

# Ensure the script runs with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# List of iodepth values
iodepths=(1 2 4 8 16 32 64 128)

# Loop through each iodepth value
for depth in "${iodepths[@]}"; do
    # Modify iou.fio
    sed -i "s/iodepth=.*/iodepth=$depth/" iou.fio
    sudo fio iou.fio --output=output_iou_${depth}_2core.txt
    
    # Modify iou_p.fio
    sed -i "s/iodepth=.*/iodepth=$depth/" iou_p.fio
    sudo fio iou_p.fio --output=output_iou_p_${depth}_2core.txt
    
    # Modify iou_k.fio
    sed -i "s/iodepth=.*/iodepth=$depth/" iou_k.fio
    sudo fio iou_k.fio --output=output_iou_k_${depth}_2core.txt

    # Modify aio.fio
    sed -i "s/iodepth=.*/iodepth=$depth/" aio.fio
    sudo fio aio.fio --output=output_aio_${depth}_2core.txt

    # Modify spdk.fio
    sed -i "s/iodepth=.*/iodepth=$depth/" spdk.fio
    sudo fio spdk.fio --output=output_spdk_${depth}_2core.txt
done

echo "Tests completed."

