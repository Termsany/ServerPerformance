#!/bin/bash

echo "========================================"
echo "       SERVER PERFORMANCE STATS         "
echo "========================================"
echo

# Date & Hostname
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo

# ----------------------------------------
# CPU Usage
# ----------------------------------------
echo "---- CPU Usage ----"
top -bn1 | grep "Cpu(s)" | \
awk '{print "CPU Usage: " 100 - $8 "%"}'
echo

# ----------------------------------------
# Memory Usage
# ----------------------------------------
echo "---- Memory Usage ----"
free -m | awk 'NR==2{
    printf "Total: %sMB\nUsed: %sMB\nFree: %sMB\nUsage: %.2f%%\n",
    $2,$3,$4,$3*100/$2 }'
echo

# ----------------------------------------
# Disk Usage
# ----------------------------------------
echo "---- Disk Usage ----"
df -h --total | grep 'total' | awk '{
    printf "Total: %s\nUsed: %s\nAvailable: %s\nUsage: %s\n",
    $2,$3,$4,$5 }'
echo

# ----------------------------------------
# Load Average
# ----------------------------------------
echo "---- Load Average ----"
uptime | awk -F'load average:' '{ print $2 }'
echo

# ----------------------------------------
# Uptime
# ----------------------------------------
echo "---- System Uptime ----"
uptime -p
echo

# ----------------------------------------
# Logged in Users
# ----------------------------------------
echo "---- Logged in Users ----"
who | wc -l
echo

# ----------------------------------------
# Top 5 Processes by CPU
# ----------------------------------------
echo "---- Top 5 Processes by CPU ----"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
echo

# ----------------------------------------
# Top 5 Processes by Memory
# ----------------------------------------
echo "---- Top 5 Processes by Memory ----"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
echo

echo "========================================"
echo "         END OF REPORT                  "
echo "========================================"