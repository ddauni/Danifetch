#!/bin/bash

# Cores
pink="\e[35m"
white="\e[97m"
reset="\e[0m"

# ASCII
ascii_art="""
${pink}
            ..:=*%%%#+-..
           ..=@@*==+%@@#..
     .....  .........*@@-..
    .:%@*...	 ...+@@-..
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

# OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    os=${NAME}
else
    os=$(uname -o)
fi

# Enhanced Package Managers
if command -v pacman &>/dev/null; then
    package_count=$(pacman -Q | wc -l)
    package_source="pacman (AUR included)"
    elif command -v xbps-query &>/dev/null; then
    package_count=$(xbps-query -l | wc -l)
    package_source="XBPS"
elif command -v emerge &>/dev/null; then
    package_count=$(qlist -I | wc -l)
    package_source="Portage"
elif command -v apk &>/dev/null; then
    package_count=$(apk info | wc -l)
    package_source="apk (Alpine Linux)"
elif command -v zypper &>/dev/null; then
    package_count=$(zypper se --installed-only | wc -l)
    package_source="zypper"
elif command -v apt &>/dev/null; then
    package_count=$(dpkg-query -f '.\n' -W | wc -l)
    package_source="APT"
elif command -v rpm &>/dev/null && command -v dnf &>/dev/null; then
    package_count=$(dnf list installed | wc -l)
    package_source="dnf (Fedora/RHEL)"
else
    package_count="N/A"
    package_source="Unknown"
fi

# System Info
kernel=$(uname -r)
uptime="Up for $(uptime -p | sed 's/^up //')"
user=$USER
host=$(hostname 2>/dev/null || echo "Hostname not found")
fi

# System Info
kernel=$(uname -r)
uptime="Up for $(uptime -p | sed 's/^up //')"
user=$USER
host=$(hostname 2>/dev/null || echo "Hostname not found")
memory=$(free -h --si | awk '/^Mem:/ {print $3 "/" $2}')
disk_usage=$(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')

# WM Detection
if command -v sway &>/dev/null; then
    wm="Sway"
elif command -v i3 &>/dev/null; then
    wm="i3"
elif command -v bspwm &>/dev/null; then
    wm="bspwm"
elif command -v river &>/dev/null; then
    wm="River"
elif command -v awesome &>/dev/null; then
    wm="Awesome"
elif command -v herbstluftwm &>/dev/null; then
    wm="herbstluftwm"
elif command -v hyprland &>/dev/null; then
    wm="Hyprland"
elif command -v xmonad &>/dev/null; then
    wm="xmonad"
elif command -v dwm &>/dev/null; then
    wm="dwm"
else
    wm="N/A"
fi

# Quotes Aleatorias
quotes=("Did you know? Each time you use \"danifetch\" a little dani smiles!! :D"
        "I forgor :<"
        "Haiii my name dani,,,, me,,, im dani,, that's me haii :3"
        "This is a quote!"
        "Each copy of danifetch is personalized,,,, spooky,,,,"
        ":3"
        "The fog is coming the fog is coming the fog is coming the fo-"
        "they are coming to take me away PLEASE HELP PLE-"
        "this script came to me in a dream,,, waw,aw,,,aw,,"
        "Have a nice day!! :D"
        "danifetch is so cool -dani")
random_quote=${quotes[$((RANDOM % ${#quotes[@]}))]}

# Info wowie!!
echo -e "${ascii_art}"
echo -e "Welcome, ${pink}${user}${reset}, to the many funiii ${pink}danifetch${reset} awawa!! :3"
echo -e ""
echo -e "${pink}OS:${reset} ${white}${os}${reset}"
echo -e "${pink}Kernel:${reset} ${white}${kernel}${reset}"
echo -e "${pink}Uptime:${reset} ${white}${uptime}${reset}"
echo -e "${pink}Host:${reset} ${white}${host}${reset}"
echo -e "${pink}DE/WM:${reset} ${white}${de}${wm}${reset}"
echo -e "${pink}Memory:${reset} ${white}${memory}${reset}"
echo -e "${pink}Packages:${reset} ${white}${package_count} (${package_source})${reset}"
echo -e "${pink}Live disk reaction:${reset} ${white}${disk_usage}${reset}"
echo -e "${pink}Funi random quote:${reset} ${white}${random_quote}${reset}"
echo -e ""
