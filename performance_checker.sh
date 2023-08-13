#!/bin/bash

cwd=$(dirname $0)

# Get the first line with aggregate of all CPUs
cpu_now=($(head -n1 /proc/stat))
# Get all columns but skip the first (which is the "cpu" string)
cpu_sum="${cpu_now[@]:1}"
# Replace the column seperator (space) with +
cpu_sum=$((${cpu_sum// /+}))
# Get the idle time
cpu_idle=${cpu_now[4]}
# Calc time spent working
cpu_used=$((cpu_sum - cpu_idle))
# Calc percentage
cpu_usage=$((100 * cpu_used / cpu_sum))

meminfo=($(head -n2 /proc/meminfo))
mem_total=${meminfo[1]}
mem_free=${meminfo[4]}
mem_used=$((mem_total - mem_free))
mem_usage=$((100 * mem_used / mem_total))

disk=$(df -h)
disk=${disk//$'\n'/$'\n  '}

date=$(date +%F\ %T)

echo "===================================================
Date&Time: $date

- CPU usage: $cpu_usage%

- Memory usage: $mem_usage%
  Total Memory: $mem_total
  Free Memory: $mem_free
  Used Memory: $mem_used

- Disk usage:
  $disk
==================================================


" >> "$cwd/log.txt"
