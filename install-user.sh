#!/bin/sh

RED="\033[91m"
YELLOW="\033[93m"
GREEN="\033[92m"
BLUE="\033[94m"
RESET="\033[0m"

DIRECTORY=$(dirname "$0")

printf "%b" "$BLUE"

cat << 'EOF'
                                                   ,---,  
        ,--,                                    ,`--.' |  
      ,--.'|            ,--,    ,--,            |   :  :  
   ,--,  | :          ,--.'|  ,--.'|            '   '  ;  
,---.'|  : '          |  | :  |  | :     ,---.  |   |  |  
|   | : _' |          :  : '  :  : '    '   ,'\ '   :  ;  
:   : |.'  |   ,---.  |  ' |  |  ' |   /   /   ||   |  '  
|   ' '  ; :  /     \ '  | |  '  | |  .   ; ,. :'   :  |  
'   |  .'. | /    /  ||  | :  |  | :  '   | |: :;   |  ;  
|   | :  | '.    ' / |'  : |__'  : |__'   | .; :`---'. |  
'   : |  : ;'   ;   /||  | '.'|  | '.'|   :    | `--..`;  
|   | '  ,/ '   |  / |;  :    ;  :    ;\   \  / .--,_     
;   : ;--'  |   :    ||  ,   /|  ,   /  `----'  |    |`.  
|   ,/       \   \  /  ---`-'  ---`-'           `-- -`, ; 
'---'         `----'                              '---`"  
                                                        
EOF

echo ""
echo "All flatpak, snap, brew, and nix packages are automatically detected and updated."

echo "Please enter the number corresponding to your native package manager: (it will be used in updating)"
echo ""
printf "%b" "$RESET"

printf "%b\n" "$YELLOW[ 1]$RESET apk (Alpine, Chimera)"
printf "%b\n" "$YELLOW[ 2]$RESET apt (Debian, Ubuntu)"
printf "%b\n" "$YELLOW[ 3]$RESET Brew (MacOS, Other)"
printf "%b\n" "$YELLOW[ 4]$RESET dnf (Fedora, Mageia)"
printf "%b\n" "$YELLOW[ 5]$RESET eopkg (Solus)"
printf "%b\n" "$YELLOW[ 6]$RESET nix (NixOS, Other)"
printf "%b\n" "$YELLOW[ 7]$RESET ostree/immutable (Fedora atomic, Other)"
printf "%b\n" "$YELLOW[ 8]$RESET pacman (Arch, EndeavourOS)"
printf "%b\n" "$YELLOW[ 9]$RESET pkg (FreeBSD, Termux)"
printf "%b\n" "$YELLOW[10]$RESET slapt-get (Slackware, Other)"
printf "%b\n" "$YELLOW[11]$RESET vso (VanillaOS)"
printf "%b\n" "$YELLOW[12]$RESET xbps (Void)"
printf "%b\n" "$YELLOW[13]$RESET Zypper (openSUSE)"
printf "%b\n" "$YELLOW[14]$RESET zeta (openSUSE)"
printf "%b\n" "$YELLOW[15]$RESET Not in the list"

printf "Type the number of the chosen package manager:  " && read -r input_num

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
    11) pkg_manager="vso" ;;
    12) pkg_manager="xbps" ;;
    13) pkg_manager="zypper" ;;
    14) pkg_manager="zeta" ;;
    *) pkg_manager="other" ;;
esac

printf "Type the name for the command you wish (Default: system-updater):  " && read -r input_cmd

if [ -z "$input_cmd" ]; then
    command="system-updater"
else
    command=$input_cmd
fi

echo "Selected package manager:  $pkg_manager"
echo "Selected name:  $command"

# updating is easy, just clone or git pull then running install-user.sh again duhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh

rm -rf "$HOME/.local/share/system-updater"
cp -r "${DIRECTORY}/system-updater" "$HOME/.local/share/"

echo "$pkg_manager" > "$HOME/.local/share/system-updater/choice.txt"

mkdir -p "$HOME/.local/bin"
chmod +x "$HOME/.local/share/system-updater/sysupdate-user.sh"
ln -sf "$HOME/.local/share/system-updater/sysupdate-user.sh" "$HOME/.local/bin/$command"

