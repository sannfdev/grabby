#!/bin/bash

# Grabby v2 by sannf
# u/sannf_
# sannf#0001
# github.com/sannfdev

# https://github.com/sannfdev/grabby

# Config
if [ -f "$HOME/grabby.conf" ]; then printf ""; else
    printf "\033[1;37m[\033[33mWARN\033[37m]\033[0m Config not found, creating one in '%s'\n" $HOME
    echo -e "# Welcome to the configuration file for Grabby!\n# The default values are true, 033, 37, 35, 34\n\n# Grabby uses ANSI escape codes for text color. You can find a basic list below:\n# - BLACK=30\n# - RED=31\n# - GREEN=32\n# - YELLOW=33\n# - BLUE=34\n# - MAGENTA=35\n# - CYAN=36\n# - WHITE=37\n# - DEFAULT=39\n\nuse_color=true     # Determines if Grabby outputs colored text\nescape_code=033    # Determines the escape code used for ANSI codes\noutline_color=37   # Determines the color of the 'outline' characters\nmain_color=35      # Determines the color of the 'main' characters\nhighlight_color=34 # Determines the color of the 'highlight' characters"  >> "$HOME/grabby.conf"
fi



# Colors
source $HOME/grabby.conf
if [ "$use_color" == "true" ]; then
    c1="\\$escape_code[${outline_color}m"
    c2="\\$escape_code[${main_color}m"
    c3="\\$escape_code[${highlight_color}m"
fi

# Ease of use
res=$(xrandr --current | grep '*' | uniq | awk '{print $1}')

printf "$c1╭─────────────╮\n"
printf "│$c2   User/Host$c1 │$c3 ->$c2 %s$c1@$c2%s\n" $USER $HOSTNAME
printf "$c1│$c2          OS$c1 │$c3 ->$c2 %s $c1($c3%s$c1)\n" "$(grep '^NAME' /etc/os-release | cut -c 6-)" "$(uname -r)"
printf "│$c2      Uptime$c1 │$c3 ->$c2 %s\n" "$(uptime -p | cut -c 4-)"
printf "$c1│$c2       Shell$c1 │$c3 ->$c2 %s $c1($c3%s$c1)\n" $(cat /proc/$PPID/comm) $SHELL
printf "$c1│$c2       WM/DE$c1 │$c3 ->$c2 %s $c1+ $c2%s\n" $(wmctrl -m | head -n 1 | cut -c 7-) $XDG_CURRENT_DESKTOP
printf "$c1│$c2  Resolution$c1 │$c3 ->$c2 %s${c1}x$c2%s\n" $(echo "$res" | cut -d 'x' -f1) $(echo "$res" | cut -d 'x' -f2)
free -h | awk -v c1="$c1" -v c2="$c2" -v c3="$c3" '/^Mem/ {printf("%s│%s      Memory%s │%s -> %s%s%s/%s%s %s(%s%s%%%s)\n", c1, c2, c1, c3, c2, $3, c1, c2, $2, c1, c3, int($3*100/$2), c1)}'
printf "│$c2  Disk Quota$c1 │\n"
df | awk -v c1="$c1" -v c2="$c2" -v c3="$c3" '/^\/dev\// {barc=int($5 * 30 / 100); printf("│%s %10s%s  │ ", c3, "- "substr($1, 6), c1); for(i=0;i<=barc;i++) printf("%s━",c2);for(i=barc;i<=30;i++) printf("%s-", c1); printf(" %s%s%s%%\n", c2, $5-0, c1)}'
printf '╰─────────────╯\033[0m\n'
