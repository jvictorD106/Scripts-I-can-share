#!/bin/bash


read -p "Enter hostname: " hostname


read -p "Enter username: " username


read -s -p "Enter password: " password
echo "" # Add a newline after password input


if [[ -z "$hostname" || -z "$username" || -z "$password" ]]; then
  echo "Error: Hostname, username, and password are required."
  exit 1
fi


sshpass -p "$password" ssh "$username@$hostname"

echo "SSH session ended."

exit 0
