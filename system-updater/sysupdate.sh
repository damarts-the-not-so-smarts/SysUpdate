#!/bin/sh


RED="\033[91m"
YELLOW="\033[93m"
GREEN="\033[92m"
BLUE="\033[94m"
RESET="\033[0m"

if [ "$EUID" -eq 0 ]; then
    ROOT=true
else
    ROOT=false
fi

PKG=$(cat "/usr/share/system-updater/choice.txt")

if command -v chafa >/dev/null 2>&1; then
	chafa "/usr/share/system-updater/banner/${PKG}.png"
else
	printf "%b" "$BLUE"
	echo "<###################################>"
	echo " >##      SysUpdate cool ye      ##<"
	echo "<###################################>"
	printf "%b" "$RESET"
	
fi

echo ""
echo ""

printf "%b" "$BLUE"
echo "[^^^] : Starting update.."
printf "%b" "$RESET"

if [ "$EUID" -eq 0 ]; then
    AUTH=""
elif command -v doas >/dev/null 2>&1; then
    AUTH="doas"
elif command -v sudo >/dev/null 2>&1; then
    AUTH="sudo"
else
    printf "%b" "$RED"
    echo "[E] : Authentication tool not found."
    printf "%b" "$RESET"
    exit 1
fi

printf "%b" "$GREEN"
echo "[>>>] : Updating packages.."
printf "%b" "$RESET"
case "$PKG" in
    "apk")
        $AUTH apk update && $AUTH apk upgrade --available
        ;;
    "apt")
        $AUTH apt-get update && $AUTH apt-get dist-upgrade -y
        ;;
    "brew")
        brew update && brew upgrade --formula --cask
        ;;
    "dnf")
        $AUTH dnf upgrade --refresh -y --best --allowerasing
        ;;
    "eopkg")
        $AUTH eopkg update-repo && $AUTH eopkg upgrade -y
        ;;
    "nix")
        nix-channel --update && nix-env -u '*'
        ;;
    "ostree")
        $AUTH rpm-ostree upgrade
        ;;
    "pacman")
        $AUTH pacman -Syyu --noconfirm
        ;;
    "pkg")
        $AUTH pkg update && $AUTH pkg upgrade -y
        ;;
    "slapt-get")
        $AUTH slapt-get --update && $AUTH slapt-get --upgrade -y
        ;;
    "vso")
        vso update
        ;;
    "xbps")
        $AUTH xbps-install -Syu
        ;;
    "zypper")
        $AUTH zypper refresh --force && $AUTH zypper dist-upgrade -y --allow-vendor-change
        ;;
    *)
    		printf "%b" "$YELLOW"
        echo "[W] : No valid package manager, Skipping.."
        printf "%b" "$RESET"
        ;;
esac

if command -v flatpak >/dev/null 2>&1; then
	echo ""
	printf "%b" "$GREEN"
    echo "[>>>] : Updating flatpaks.."
    printf "%b" "$RESET"
    flatpak update -y
fi

if command -v snap >/dev/null 2>&1; then
	echo ""
	printf "%b" "$GREEN"
    echo "[>>>] : Updating snaps.. snap snapity snap"
    printf "%b" "$RESET"
    $AUTH snap refresh
fi

if command -v nix-env >/dev/null 2>&1; then
	if [ "$PKG" != "nix" ]; then
		echo ""
		printf "%b" "$GREEN"
        echo "[>>>] : Updating nixes.. or nix's?"
	    printf "%b" "$RESET"
        nix-channel --update && nix-env -u '*'
    fi
fi

if command -v brew >/dev/null 2>&1; then
	if [ "$PKG" != "brew" ]; then
		echo ""
		printf "%b" "$GREEN"
        echo "[>>>]: Updating brews.." # ur banned for using brew if ur on linux btw
	    printf "%b" "$RESET"
        brew update && brew upgrade --formula --cask
    fi
fi

echo ""
printf "%b" "$BLUE"
echo "<###################################>"
echo " >##      Update Completed!      ##<"
echo "<###################################>"
printf "%b" "$RESET"
exit 0
