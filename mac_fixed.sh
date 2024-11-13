#!/bin/bash

# Check if the user has provided administrator privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo."
  exit 1
fi

# get the Wi-Fi network interface name (usually en0, but confirm with the networksetup command) also sets the variable for en0
wifi_interface=$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')

# verify that the Wi-Fi interface was found
if [ -z "$wifi_interface" ]; then
  echo "Wi-Fi interface not found. Make sure your Wi-Fi is enabled."
  exit 1
fi

# store the MAC address of en0 in a variable
originalMac=$(ifconfig en0 | grep ether | awk '{print $2}')



# turn off MAC address randomization
echo "Disabling private MAC addressing for $wifi_interface..."
ifconfig "$wifi_interface" down
ifconfig "$wifi_interface" ether "$originalMac"
ifconfig "$wifi_interface" up

# confirm the change
networksetup -getmacaddress en0


echo "Private MAC addressing is now forced off."

