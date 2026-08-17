#!/bin/sh


# detects which directory
DIRECTORY=$(dirname "$0")

printf "%b" "\033[94m"

cat << 'EOF'
▄▄   ▄▄       ▄▄                           ▄▄ 
██   ██       ██                           ██ 
▓▓   ▓▓       ▓▓                           ▓▓ 
▓▓   ▓▓       ▓▓                           ▓▓ 
▒▒ ▒ ▒▒  ▄▄▄▄ ▒▒   ▄▄▄  ▄▄▄  ▄▄▄▄▄▄   ▄▄▄▄ ▒▒ 
▒▒ ▒ ▒▒ ▒▒ ▒▒ ▒▒  ▒▒ ▒ ▒▒ ▒▒ ▒▒ ▒ ▒▒ ▒▒ ▒▒ ▒▒ 
░░ ░ ░░ ░░▄░░ ░░  ░░   ░░ ░░ ░░ ░ ░░ ░░▄░░ ░░ 
░░ ░ ░░ ░░ ▄▄ ░░  ░░   ░░ ░░ ░░ ░ ░░ ░░ ▄▄    
██▄█▄██ ██ ██ ██  ██ █ ██ ██ ██   ██ ██ ██ ██ 
 ▀▀▀▀▀   ▀▀▀▀  ▀▀  ▀▀▀  ▀▀▀  ▀▀   ▀▀  ▀▀▀▀ ▀▀ 
                                                                                       
EOF

# finds what authenticator you use, sudo and doas are supported
if command -v doas >/dev/null 2>&1; then
    AUTH="doas"
elif command -v sudo >/dev/null 2>&1; then
    AUTH="sudo"
else
    echo "[E]: Authentication tool not found."
    exit 1
fi

echo ""
echo "All flatpak, snap, brew, and nix packages are automatically detected and updated."

echo "Please enter the number corresponding to your native package manager: (it will be used in updating)"
echo ""
printf "%b" "\033[0m"

YELLOW="\033[93m"
RESET="\033[0m"

echo -e "$YELLOW[ 1]$RESET apk (Alpine, Chimera)"
echo -e "$YELLOW[ 2]$RESET apt (Debian, Ubuntu)"
echo -e "$YELLOW[ 3]$RESET Brew (MacOS, Other)"
echo -e "$YELLOW[ 4]$RESET dnf (Fedora, Mageia)"
echo -e "$YELLOW[ 5]$RESET eopkg (Solus)"
echo -e "$YELLOW[ 6]$RESET nix (NixOS, Other)"
echo -e "$YELLOW[ 7]$RESET ostree/immutable (Fedora atomic, Other)"
echo -e "$YELLOW[ 8]$RESET pacman (Arch, EndeavourOS)"
echo -e "$YELLOW[ 9]$RESET pkg (FreeBSD, Termux)"
echo -e "$YELLOW[10]$RESET slapt-get (Slackware, Other)"
echo -e "$YELLOW[11]$RESET SteamOS (SteamOS)"
echo -e "$YELLOW[12]$RESET vso (VanillaOS)"
echo -e "$YELLOW[13]$RESET xbps (Void)"
echo -e "$YELLOW[14]$RESET Zypper (openSUSE)"
echo -e "$YELLOW[15]$RESET Not in the list"

printf "Type the number of the chosen package manager:  " && read input_num

case "$input_num" in
    1) pkg_manager="apk" ;;
    2) pkg_manager="apt" ;;
    3) pkg_manager="brew" ;;
    4) pkg_manager="dnf" ;;
    5) pkg_manager="eopkg" ;;
    6) pkg_manager="nix" ;;
    7) pkg_manager="ostree" ;;
    8) pkg_manager="pacman" ;;
    9) pkg_manager="pkg" ;;
    10) pkg_manager="slapt-get" ;;
    11) pkg_manager="steamos" ;;
    12) pkg_manager="vso" ;;
    13) pkg_manager="xbps" ;;
    14) pkg_manager="zypper" ;;
    *) pkg_manager="other" ;;
esac

echo "Selected package manager:  $pkg_manager"

# updating is easy as cloning or git pulling then running install.sh again

$AUTH rm -rf /usr/share/system-updater
$AUTH cp -r "${DIRECTORY}/system-updater" "/usr/share/"

echo "$pkg_manager" | $AUTH tee "/usr/share/system-updater/choice.txt" > /dev/null

$AUTH ln -sf /usr/share/system-updater/sysupdate.sh /usr/local/bin/system-updater
$AUTH chmod +x /usr/share/system-updater/sysupdate.sh
