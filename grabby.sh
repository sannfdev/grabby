#!/bin/bash

OS="$(grep '^NAME' /etc/os-release | cut -c 6-) "

echo -e "\033[37m╭────────────╮"
echo -e "\033[37m│  \033[1;31mUser/Host\033[0;37m │ \033[31m-> $USER\033[37m@\033[31m$HOSTNAME"
echo -e "\033[37m│         \033[1;32mOS\033[0;37m │ \033[32m-> $OS\033[37m(\033[32m$(uname -r)\033[37m)"
echo -e "\033[37m│      \033[1;34mShell\033[0;37m │ \033[34m-> $(cat /proc/$PPID/comm) \033[37m(\033[34m$SHELL\033[37m)"
echo -e "\033[37m│      \033[1;35mWM/DE\033[0;37m │ \033[35m-> $(wmctrl -m | head -n 1 | cut -c 7-)\033[37m/\033[35m$XDG_CURRENT_DESKTOP"
echo -e "\033[37m│     \033[1;36mUptime\033[0;37m │ \033[36m-> $(uptime | awk -F'( |,|:)+' '{print $6,$7"\033[37m,\033[36m",$8,"hours\033[37m,\033[36m",$9,"minutes"}')"
echo -e "\033[37m│     \033[1;33mMemory\033[0;37m │ \033[33m-> $(free -m | awk 'NR==2{printf "%s/%sMB \033[37m(\033[33m%.2f%%\033[37m)", $3,$2,$3*100/$2 }')"
echo -e "\033[37m╰────────────╯"