#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Colors
pink="\e[35m"
white="\e[97m"
reset="\e[0m"

# ASCII Art
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

# OS Detection
if [ -f /etc/os-release ]; then
    . "/etc/os-release"
    os="${NAME}"
else
    os="$(uname -o)"
fi

# Enhanced Package Managers
if command -v pacman &>/dev/null; then
    package_count="$(pacman -Q | wc -l)"
    package_source="pacman (AUR included)"
elif command -v xbps-query &>/dev/null; then
    package_count="$(xbps-query -l | wc -l)"
    package_source="XBPS"
elif command -v emerge &>/dev/null; then
    package_count="$(qlist -I | wc -l)"
    package_source="Portage"
elif command -v apk &>/dev/null; then
    package_count="$(apk info | wc -l)"
    package_source="apk (Alpine Linux)"
elif command -v zypper &>/dev/null; then
    package_count="$(zypper se --installed-only | wc -)"
    package_source="zypper"
elif command -v apt &>/dev/null; then
    package_count="$(dpkg-query -f '.\n' -W | wc -l)"
    package_source="APT"
elif command -v rpm &>/dev/null && command -v dnf &>/dev/null; then
    package_count="$(dnf list installed | wc -l)"
    package_source="dnf (Fedora/RHEL)"
else
    package_count=""
    package_source=""
fi

if command -v flatpak &>/dev/null; then
    flatpaks_count="$(flatpak list --system | wc -l)\" (system)\""
    flatpaku_count="$(flatpak list -u | wc -l)\" (user)\""
else
    flatpaks_count=""
    flatpaku_count=""
fi

# System Info
kernel="$(uname -r)"
user="$USER"
host="$(hostname 2>/dev/null || echo "Hostname not found")"
memory="$(LANG="C.UTF-8" free -h --si | awk '/^Mem:/ {print $3 "/" $2}')"
disk_usage="$(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
uptime="Up for $(awk '{printf "%02d:%02d:%02d", int(int($1 / 60) / 60), int($1 / 60) % 60, int($1 % 60)}') < /proc/uptime"

wm="$XDG_SESSION_DESKTOP"
case "$wm" in
    "gnome")
	de="GNOME"
	wm="Mutter"
	;;
    "KDE")
	de="KDE"
	wm="Kwin"
	;;
    *)
	de=""
	;;
esac

# Quotes
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

# Info Output
echo -e "${ascii_art}"
echo -e "Welcome, ${pink}${user}${reset}, to the many funiii ${pink}danifetch${reset} awawa!! :3"
echo -e ""
[ -z "$os" ] || echo -e "${pink}OS:${reset} ${white}${os}${reset}"
[ -z "$kernel" ] || echo -e "${pink}Kernel:${reset} ${white}${kernel}${reset}"
[ -z "$uptime" ] || echo -e "${pink}Uptime:${reset} ${white}${uptime}${reset}"
[ -z "$host" ] || echo -e "${pink}Host:${reset} ${white}${host}${reset}"
[ -z "$de" ] || echo -e "${pink}DE:${reset} ${white}${de}${reset}"
[ -z "$wm" ] || echo -e "${pink}WM:${reset} ${white}${wm}${reset}"
[ -z "$memory" ] || echo -e "${pink}Memory:${reset} ${white}${memory}${reset}"
[ -z "$package_source" ] || echo -e "${pink}Packages:${reset} ${white}${package_count} (${package_source})${reset}"
[ -z "$flatpaks_count" ] || echo -e "${pink}Flatpak packages:${reset} ${white}${flatpaks_count} ${flatpaku_count} ${reset}"
[ -z "$disk_usage" ] || echo -e "${pink}Live disk reaction:${reset} ${white}${disk_usage}${reset}"
echo -e "${pink}Funi random quote:${reset} ${white}${random_quote}${reset}"
