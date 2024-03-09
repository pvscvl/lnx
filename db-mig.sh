#!/usr/bin/env bash
#    bash -c "$(wget -qLO - https://raw.githubusercontent.com/pvscvl/lnx/main/db-mig.sh)"
apt update &>/dev/null
apt install rg
mkdir -p /root/DB-Migration/Logs/ 
LOGFILE="/root/DB-Migration/Logs/rg.log"
LOGFILENH="/root/DB-Migration/Logs/rg-nohidden.log"
rg "^(10\.0\.0\.116|TKM-SV-DB01(\.tkm\.local)?)$" / --ignore-case --hidden --no-messages  >> $LOGFILE
rg "^(10\.0\.0\.116|TKM-SV-DB01(\.tkm\.local)?)$" / --ignore-case  --no-messages >> $LOGFILENH
