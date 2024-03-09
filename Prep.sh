
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




msg_info "${ITALICS}${GREEN}Main PPS Version: ${DEFAULT}${BOLD}${YELLOW}$VERSION ${DEFAULT}"
msg_info "${ITALICS}${GREEN}PPS-vars Version: ${DEFAULT}${BOLD}${YELLOW}$VARVERSION ${DEFAULT}"
msg_info "${ITALICS}${GREEN}PPS-func Version: ${DEFAULT}${BOLD}${YELLOW}$FUNCVERSION ${DEFAULT}"
echo ""
msg_info "${BOLD}Hostname: ${DEFAULT}${ITALICS}$hostsys ${DEFAULT}"
msg_info "${BOLD}Virtual environment: ${DEFAULT}${ITALICS}$detected_env${DEFAULT}"
msg_info "${BOLD}Detected OS: ${DEFAULT}${ITALICS}$detected_os $detected_version${DEFAULT}"
msg_info "${BOLD}Detected architecture: ${DEFAULT}${ITALICS}${detected_architecture}${DEFAULT}"
msg_info "${BOLD}IP Address: ${DEFAULT}${ITALICS}${local_ip}${DEFAULT}"
msg_info "${BOLD}MAC Address: ${DEFAULT}${ITALICS}${local_mac}${DEFAULT}"
msg_info "${BOLD}Interface: ${DEFAULT}${ITALICS}${local_if}${DEFAULT}"
echo ""
msg_info "${BOLD}Timezone: ${DEFAULT}${ITALICS}$chktz${DEFAULT}"

if grep -q "Europe/Berlin" /etc/timezone ; then
	echo -n ""
else
	timedatectl set-timezone Europe/Berlin
	chktz=$(cat /etc/timezone)
	msg_ok "${BOLD}Timezone set to: ${DEFAULT}${ITALICS}$chktz${DEFAULT}"        
fi

