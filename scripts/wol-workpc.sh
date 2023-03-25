#!/usr/bin/env bash
# This is needed as the /bin/bash path does not exist in nixos

#    This is a bash script that performs the following actions:

#    Creates a directory named "logs" in the home directory of the current user (using the "mkdir" command with the "-p" option, which creates the directory only if it does not already exist).
#    Appends the current date and time to a log file named "wol-workpc.log" in the "logs" directory (using the "printf" command to print a formatted string that includes the current date and time, and the ">>" operator to append the output to the end of the file).
#    Sends a Wake-on-LAN (WoL) "magic packet" to wake up a computer with the MAC address "18:66:DA:4B:AD:1B" at IP address "10.84.1.54" (using the "wol" command).
#    Redirects any error output from the "wol" command (using the "2>&1" operator) to the same log file as step 2 (using the ">>" operator to append the output to the end of the file).

# export PATH="/run/current-system/sw/bin:${PATH}"

wol_ip="10.84.1.54"
wol_mac="18:66:DA:4B:AD:1B"
log_path="${HOME}/logs"
log_name="wol-workpc.log"

mkdir -p "${log_path}"

# ls -lha /run/current-system/sw/bin/wol 2>&1 >> "${log_path}/${log_name}"

#echo "wol: $(/usr/bin/env wol)" >> "${log_path}/${log_name}"
#echo "whoami: $(whoami)" >> "${log_path}/${log_name}"

printf "\n$(date)" >> "${log_path}/${log_name}"
printf "\n** Sending WOL Magic Packet **\n" >> "${log_path}/${log_name}"
/usr/bin/env wol -vi "${wol_ip}" "${wol_mac}" 2>&1 >> "${log_path}/${log_name}"
printf "\n** Command executed. See \"${log_path}/${log_name}\" for results. **\n"
