#!/usr/bin/env bash
#    bash -c "$(wget -qLO - https://raw.githubusercontent.com/pvscvl/lnx/main/prep.sh)"

# FORMATTING
	DEFAULT=$(tput sgr0)
	GREEN=$(tput setaf 2)
	RED=$(tput setaf 1)
 	BLUE=$(tput setaf 4)
	YELLOW=$(tput setaf 3)
	ORANGE=$(tput setaf 202)
	GREY=$(tput setaf 7)
	DARK_GREY=$(tput setaf 8)
	PURPLE=$(tput setaf 5)
	CYAN=$(tput setaf 6)
	DIMMED=$(tput dim)
	ITALICS=$(tput sitm)
	BOLD=$(tput bold)
	UNDERLINED=$(tput smul)

	TICK="${DEFAULT}${BOLD}[${GREEN}✓${DEFAULT}]  "
	CROSS="${DEFAULT}[${BOLD}${RED}✗${DEFAULT}]  "
	INFO="${DEFAULT}${BOLD}[i]${DEFAULT}  "   
	WARN="${DEFAULT}[${BOLD}${YELLOW}!${DEFAULT}]  "


# Systeminfos
	Detected_OSTYPE=$(uname)
	Detected_Architecture=$(uname -m)   
	Detected_OS=$(grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
	Detected_Version=$(grep VERSION_ID /etc/os-release | cut -d '=' -f2 | tr -d '"')
	Detected_Env=$(systemd-detect-virt)
	Detected_Timezone=$(cat /etc/timezone)    
	Detected_Hostname=$(hostname -f)


# MSG Functions

	function msg_info() {
		local msg="$1"
		printf "%b ${msg}\\n" "${INFO}"
	}


	function msg_ok() {
		local msg="$1"
		printf "%b ${msg}\\n" "${TICK}"
	}


	function msg_no() {
		local msg="$1"
		printf "%b ${msg}\\n" "${CROSS}"
	}


	function msg_warn() {
		local msg="$1"
		printf "%b ${msg}\\n" "${WARN}"
	}


# Functions

	function get_mac() {
		local interface
		interface=$(ip route | awk '/default/ {print $5}')

		local mac_address
		mac_address=$(ip link show "$interface" | awk '/ether/ {print $2}')

		local ip_address
		ip_address=$(ip addr show dev "$interface" | awk '/inet / {print $2}')
		echo "$mac_address"
	}


	function get_ip() {
		local interface
		interface=$(ip route | awk '/default/ {print $5}')

		local mac_address
		mac_address=$(ip link show "$interface" | awk '/ether/ {print $2}')

		local ip_address
		ip_address=$(ip addr show dev "$interface" | awk '/inet / {print $2}')
		echo "$ip_address"
	}


	function get_interface() {
		local interface
		interface=$(ip route | awk '/default/ {print $5}')

		local mac_address
		mac_address=$(ip link show "$interface" | awk '/ether/ {print $2}')

		local ip_address
		ip_address=$(ip addr show dev "$interface" | awk '/inet / {print $2}')
		echo "$interface"
	}



	local_ip=$(get_ip)
	local_mac=$(get_mac)
	local_if=$(get_interface)

msg_info "${BOLD}Hostname: ${DEFAULT}${ITALICS}${Detected_Hostname}${DEFAULT}"
msg_info "${BOLD}Virtual environment: ${DEFAULT}${ITALICS}${Detected_Env}${DEFAULT}"
msg_info "${BOLD}Detected OS: ${DEFAULT}${ITALICS}${Detected_OS} ${Detected_Version}${DEFAULT}"
msg_info "${BOLD}Detected architecture: ${DEFAULT}${ITALICS}${Detected_Architecture}${DEFAULT}"
msg_info "${BOLD}IP Address: ${DEFAULT}${ITALICS}${local_ip}${DEFAULT}"
msg_info "${BOLD}MAC Address: ${DEFAULT}${ITALICS}${local_mac}${DEFAULT}"
msg_info "${BOLD}Interface: ${DEFAULT}${ITALICS}${local_if}${DEFAULT}"
echo ""
#msg_info "${BOLD}Timezone: ${DEFAULT}${ITALICS}$chktz${DEFAULT}"
if grep -q "Europe/Berlin" /etc/timezone ; then
	msg_ok "${BOLD}Timezone: ${DEFAULT}${ITALICS}${Detected_Timezone}{DEFAULT}"
else
	msg_warn "${BOLD}Timezone: ${DEFAULT}${ITALICS}${Detected_Timezone}{DEFAULT}"
 	msg_info "${DEFAULT}${ITALICS}Changing Timezone to Europe/Berlin... ${DEFAULT"
	timedatectl set-timezone Europe/Berlin
	Detected_Timezone=$(cat /etc/timezone)
	msg_ok "${BOLD}Timezone set to: ${DEFAULT}${ITALICS}${Detected_Timezone}{DEFAULT}"        
fi


wget -q -O /root/.bashrc2 https://raw.githubusercontent.com/pvscvl/lnx/main/.bashrc2


apt update &>/dev/null
apt install ncdu

