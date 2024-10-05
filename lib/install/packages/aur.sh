# ------------------------------------------------------
# Select AUR Helper
# ------------------------------------------------------

aur_helper=""

_installYay() {
    _installPackagesPacman "base-devel"
    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")
    git clone https://aur.archlinux.org/yay.git ~/yay
    cd ~/yay || exit
    makepkg -si
    cd "$temp_path" || exit
    echo ":: yay has been installed successfully."
}

_installParu() {
    _installPackagesPacman "base-devel"
    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")
    git clone https://aur.archlinux.org/paru.git ~/paru
    cd ~/paru || exit
    makepkg -si
    cd "$temp_path" || exit
    echo ":: paru has been installed successfully."
}

_selectAURHelper() {
    echo ":: Please select your preferred AUR Helper"
    echo
    aur_helper=$(gum choose "yay" "paru")
    if [ -z "$aur_helper" ]; then
        _selectAURHelper
    fi
}

_checkAURHelper() {
    if [[ $(_checkCommandExists "yay") == "0" ]]; then
        echo ":: yay is installed"
        yay_installed="true"
    fi
    if [[ $(_checkCommandExists "paru") == "0" ]]; then
        echo ":: paru is installed"
        paru_installed="true"
    fi
    if [[ $yay_installed == "true" ]] && [[ $paru_installed == "false" ]]; then
        echo ":: Using AUR Helper yay"
        aur_helper="yay"
    elif [[ $yay_installed == "false" ]] && [[ $paru_installed == "true" ]]; then
        echo ":: Using AUR Helper paru"
        aur_helper="paru"
    elif [[ $yay_installed == "false" ]] && [[ $paru_installed == "false" ]]; then
        if [[ $(_check_update) == "false" ]]; then
            _selectAURHelper
            if [[ $aur_helper == "yay" ]]; then
                _installYay
            else
                _installParu
            fi
        fi
    else
        echo ":: Installing $aur_helper..."
        cd "$HOME" || exit
        if [ -d "$HOME/$aur_helper" ]; then
            rm -rf "$HOME/$aur_helper"
        fi
        git clone "https://aur.archlinux.org/$aur_helper.git" ~/"$aur_helper" || {
            echo ":: Failed to clone $aur_helper."
            return 1
        }
        cd "$HOME"/"$aur_helper" || {
            echo ":: Failed to change directory to $aur_helper."
            return 1
        }
        makepkg -si --noconfirm || {
            echo ":: Installation of $aur_helper failed."
            return 1
        }
        cd "$HOME" || exit
        rm -rf "$aur_helper"
        echo ":: $aur_helper installed successfully."
    fi
}

if [[ $(_check_update) == "false" ]]; then
    echo -e "${GREEN}"
    figlet -f smslant "AUR Helper"
    echo -e "${NONE}"
    _selectAURHelper
fi
_checkAURHelper
