#!/bin/bash

# Cores
pink="\e[35m"  # Highlight color (pink)
white="\e[97m" # Stat color (white)
reset="\e[0m"  # Reset color

# ASCII
ascii_art="""
${pink}
            ..:=*%%%#+-..
           ..=@@*==+%@@#..
     .....  .........*@@-..
    .:%@*...      ...+@@-..
    .:@@#:.. ......:+@@+...
    ....... ..:%@@@@@#-...
            ....:::-=%@@=..
                  ....#@@-.
    ..................#@@-.
    .:@@#...:%*-:...-#@@*..
    .:@@#:...+%@@@@@@@#-..
    ......  .....:::....
       ..      ... ..
${reset}
"""

# Display do ASCII
echo -e "${ascii_art}"

# System Info
os=$(uname -o)
kernel=$(uname -r)
uptime=$(uptime -p)
user=$USER
host=$(hostname 2>/dev/null || echo "Hostname not found")
de=${XDG_CURRENT_DESKTOP:-"N/A"}
memory=$(free -h --si | awk '/^Mem:/ {print $3 "/" $2}')
packages=$(command -v pacman &> /dev/null && pacman -Q | wc -l || echo "N/A")

# Display da system info
echo -e "Haiii!! Welcome, ${pink}${user}${reset}, to the many funiii ${pink}danifetch${reset} awawaa!! :3"
echo -e "${pink}OS:${reset} ${white}${os}${reset}"
echo -e "${pink}Kernel:${reset} ${white}${kernel}${reset}"
echo -e "${pink}Uptime:${reset} ${white}${uptime}${reset}"
echo -e "${pink}Host:${reset} ${white}${host}${reset}"
echo -e "${pink}DE:${reset} ${white}${de}${reset}"
echo -e "${pink}Memory:${reset} ${white}${memory}${reset}"
echo -e "${pink}Packages:${reset} ${white}${packages}${reset}"
