# ------------------------------------------------------
# Install wallpapers
# ------------------------------------------------------

if [ ! -d ~/wallpaper ]; then
    echo -e "${GREEN}"
    figlet -f smslant "Wallpapers"
    echo -e "${NONE}"
    echo "Do you want to download the wallpapers from repository https://github.com/mylinuxforwork/wallpaper/ ?"
    echo "If not, the script will install some default wallpapers in ~/.local/share/backgrounds"
    echo ""
    if gum confirm "Do you want to download the repository?"; then
        if [ -d ~/Downloads/wallpaper ]; then
            rm -rf ~/Downloads/wallpaper
        fi
        git clone --depth 1 https://github.com/mylinuxforwork/wallpaper.git ~/Downloads/wallpaper
        if [ ! -d ~/.local/share/backgrounds/ ]; then
            mkdir ~/.local/share/backgrounds
        fi
        rsync -a -I --exclude-from=$install_directory/includes/excludes.txt ~/Downloads/wallpaper/. ~/.local/share/backgrounds/
        echo "Wallpapers from the repository installed successfully."
    elif [ $? -eq 130 ]; then
        exit 130
    else
        if [ -d ~/.local/share/backgrounds/ ]; then
            echo "~/.local/share/backgrounds/ folder already exists."
        else
            mkdir ~/.local/share/backgrounds
        fi
        cp $wallpaper_directory/* ~/.local/share/backgrounds
        echo "Default wallpapers installed successfully."
    fi
else
    echo ":: ~/.local/share/backgrounds folder already exists."
fi
echo ""

# ------------------------------------------------------
# Copy default wallpaper files to .cache
# ------------------------------------------------------

# Cache file for holding the current wallpaper
cache_file="$HOME/.config/ml4w/cache/current_wallpaper"
rasi_file="$HOME/.config/ml4w/cache/current_wallpaper.rasi"

# Create cache file if not exists
if [ ! -f $cache_file ]; then
    touch $cache_file
    echo "$HOME/.local/share/backgrounds/default.jpg" >"$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ]; then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/.local/share/backgrounds/default.jpg\", height); }" >"$rasi_file"
fi
