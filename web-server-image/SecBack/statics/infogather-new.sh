#!/bin/bash

# Create an associative array to hold the security information
declare -A security_info

# Get system information
security_info["Hostname"]=$(hostname)
security_info["KernelVersion"]=$(uname -r)
security_info["OperatingSystem"]=$(cat /etc/os-release | grep -w "PRETTY_NAME" | cut -d'"' -f2)

# Get CPU information
security_info["CPUModel"]=$(cat /proc/cpuinfo | grep -m1 "model name" | cut -d':' -f2 | sed 's/^ *//')

# Get memory information
security_info["TotalMemory"]=$(free -h | awk '/^Mem:/ {print $2}')
security_info["AvailableMemory"]=$(free -h | awk '/^Mem:/ {print $7}')

# Get disk information
security_info["DiskUsage"]=$(df -h / | awk 'NR==2{print $5}')
security_info["DiskSpace"]=$(df -h / | awk 'NR==2{print $2}')
security_info["FreeSpace"]=$(df -h / | awk 'NR==2{print $4}')

# Get network information
security_info["IPAddresses"]=$(hostname -I)
security_info["MACAddresses"]=$(ip -o link show | awk -F 'link/ether ' '{print $2}' | awk '{print $1}')

# Get user accounts
user_accounts=$(awk -F':' '{ if ($3 >= 1000 && $1 != "nobody") print $1 }' /etc/passwd)
security_info["UserAccounts"]=$user_accounts

# Get open network ports
open_ports=$(ss -tuln | awk 'NR>1 {print $5}' | cut -d':' -f2 | sort -u)
security_info["OpenPorts"]=$open_ports

# Get date and time
security_info["DateTime"]=$(date +"%Y-%m-%d %H:%M:%S")

# Prepare JSON string
json_data="{"
for key in "${!security_info[@]}"; do
  json_data+="\"$key\":\"${security_info[$key]}\","
done
json_data=${json_data%,} # Remove the trailing comma
json_data+="}"

# Write JSON to a file
clean_json_data="$(echo "$json_data" | sed ':a;N;$!ba;s/\n/ /g')"
curl -sX POST $1 -H 'Content-Type: application/json' -d "$clean_json_data"
