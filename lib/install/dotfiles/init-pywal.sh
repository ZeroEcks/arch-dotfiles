# ------------------------------------------------------
# init pywal with default wallpaper
# ------------------------------------------------------

if [ ! -f ~/.cache/wal/colors-hyprland.conf ]; then
    echo -e "${GREEN}"
    figlet -f smslant "Pywal"
    echo -e "${NONE}"
    wal -i ~/.local/user/share/backgrounds/default.jpg
    echo ":: Pywal and templates activated."
    echo ""
else
    echo ":: Pywal already activated."
    echo ""
fi
