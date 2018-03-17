#!/bin/bash

mkdir -p $HOME/lin
mkdir -p $HOME/mem
mkdir -p $HOME/dd
mkdir -p $HOME/fio

current_time1=$(date +%s)

while [ $(date +%s) -lt $(($current_time1 + 300)) ]
do
	currentTime1=$(date +%s)
	lin_out=$($HOME/linpack.sh)
	echo "$(date +%Y/%m/%d_%H:%M:%S)" >> $HOME/lin/lin_$currentTime1.log
	echo "$lin_out" >> $HOME/lin/lin_$currentTime1.log
done

current_time2=$(date +%s)

while [ $(date +%s) -lt $(($current_time2 + 300)) ]
do
	currentTime2=$(date +%s)
	mem_out=$($HOME/memsweep.sh)
	echo "$(date +%Y/%m/%d_%H:%M:%S)" >> $HOME/mem/mem_$currentTime2.log
	echo "$mem_out" >> $HOME/mem/mem_$currentTime2.log
done

currentTime3=$(date +%s)

while [ $(date +%s) -lt $(($currentTime3 + 300)) ]
do
	dd_out=$(dd if=/dev/zero of=/tmp/test2 bs=100M count=1 oflag=direct 2>&1)
	echo "$(date +%Y/%m/%d_%H:%M:%S)" >> $HOME/dd/dd_$currentTime3.log
	echo "$dd_out" >> $HOME/dd/dd_$currentTime3.log
done

FPATH4 = "$HOME/fio"

currentTime4=$(date +%s)

fio_out=$(sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=random_read_write.fio --bs=4k --iodepth=64 --size=100M --readwrite=randrw --rwmixread=75)
echo "$(date +%Y/%m/%d_%H:%M:%S)" >> $FPATH4/fio_$currentTime4.log
echo "$(fio_out)" >> $FPATH4/fio_$currentTime4.log