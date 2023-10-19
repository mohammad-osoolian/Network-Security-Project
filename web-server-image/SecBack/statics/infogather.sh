#!/bin/sh

# Get system information
hostname=$(hostname)
kernel_version=$(uname -r)
operating_system=$(grep -w "PRETTY_NAME" /etc/os-release | cut -d'"' -f2)

# Get CPU information
cpu_model=$(grep -m1 "model name" /proc/cpuinfo | cut -d':' -f2 | sed 's/^ *//')

# Get memory information
total_memory=$(free -h | awk '/^Mem:/ {print $2}')
available_memory=$(free -h | awk '/^Mem:/ {print $7}')

# Get disk information
disk_usage=$(df -h / | awk 'NR==2{print $5}')
disk_space=$(df -h / | awk 'NR==2{print $2}')
free_space=$(df -h / | awk 'NR==2{print $4}')

# Get network information
ip_addresses=$(hostname -i)
mac_addresses=$(ip -o link show | awk -F 'link/ether ' '{print $2}' | awk '{print $1}')

# Get user accounts
user_accounts=$(awk -F':' '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd)

# Get open network ports
open_ports=$(netstat -tuln | awk 'NR>2 {print $4}' | awk -F':' '{print $NF}' | sort -u) 

# Get date and time
datetime=$(date +"%Y-%m-%d %H:%M:%S")

# Prepare JSON string
json_data="{"
json_data="$json_data\"Hostname\":\"$hostname\","
json_data="$json_data\"KernelVersion\":\"$kernel_version\","
json_data="$json_data\"OperatingSystem\":\"$operating_system\","
json_data="$json_data\"CPUModel\":\"$cpu_model\","
json_data="$json_data\"TotalMemory\":\"$total_memory\","
json_data="$json_data\"AvailableMemory\":\"$available_memory\","
json_data="$json_data\"DiskUsage\":\"$disk_usage\","
json_data="$json_data\"DiskSpace\":\"$disk_space\","
json_data="$json_data\"FreeSpace\":\"$free_space\","
json_data="$json_data\"IPAddresses\":\"$ip_addresses\","
json_data="$json_data\"MACAddresses\":\"$mac_addresses\","
json_data="$json_data\"UserAccounts\":\"$user_accounts\","
json_data="$json_data\"OpenPorts\":\"$open_ports\","
json_data="$json_data\"DateTime\":\"$datetime\""
json_data="$json_data}"

# Write JSON to a file
clean_json_data=$(echo "$json_data" | sed ':a;N;$!ba;s/\n/ /g')
echo $clean_json_data > security_information.txt
curl -sX POST "$1" -H 'Content-Type: application/json' -d "$clean_json_data"
