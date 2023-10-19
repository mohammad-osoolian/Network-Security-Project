#!/bin/bash

tempvar=$(nmap $1 -F -oN result.txt)

input_file="result.txt"  # Replace with your Nmap output file
output_file="open_ports.csv"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file not found."
    exit 1
fi

# Extract host, port, and state information from the Nmap output
awk '/Nmap scan report for/{ip=$NF} /^[0-9]+\/tcp/{print ip "," $1 "," $2}' "$input_file" > "$output_file"
echo "Conversion completed. Results saved to $output_file."

