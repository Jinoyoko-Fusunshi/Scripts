#!/bin/bash

install_brave() {
    program_name="brave-browser"
    program_exists $program_name
    exists=$?

    echo "-- installing $program_name ..."

    if [ $exists = 0 ]
    then
        sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" |
        sudo tee /etc/apt/sources.list.d/brave-browser-release.list
        sudo apt update

        install_apt_program "brave-browser"
        echo ">> $program_name installed!"
    else
        echo ">> $program_name already installed"
    fi
}

install_discord() {
    install_external_debian_package "discord" "https://discord.com/api/download?platform=linux&format=deb"
}

install_code() {
    install_external_debian_package "code" "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
}

install_steam() {
    install_external_debian_package "steam" "https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb"
}

install_apt_program() {
    install_package_program "apt" $1
}

install_snap_program() {
    install_package_program "snap" $1
}

install_package_program() {
    program_name=$2
    package_manager=$1
    program_exists $program_name
    exists=$?

    echo "-- installing $program_name ..."

    if [ $exists = 0 ]
    then
        sudo $package_manager install $program_name
        echo ">> $program_name installed!"
    else
        echo ">> $program_name already installed"
    fi

   echo ""
}

install_external_debian_package() {
    program_name=$1
    package_address=$2
    program_exists $program_name
    exists=$?

    echo "-- installing $program_name ..."

    if [ $exists = 0 ]
    then
        debian_file="./temp/$program_name.deb"

        sudo wget --output-document="$debian_file" "$package_address"
        sudo gdebi $debian_file
        echo ">> $program_name installed!"
    else
        echo ">> $program_name already installed"
    fi

    echo ""
}

program_exists() {
    if [ "$(which "$1")" != ""  ];
    then
        return 1;
    else
        return 0;
    fi
}

install_starship() {
    echo "-- installing starship theme ..."

    curl -sS https://starship.rs/install.sh | sh

    echo ">> starship successfully installed!"
    echo ""
}

# configures oh-my-bash with the starship theme
install_bash() {
    echo "-- installing oh-my-bash addon ..."

    sudo cp "config-templates/.bashrc" "/home/$USER/"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

    echo ">> oh-my-bash successfully installed!"
    echo ""
}

# configures oh-my-fish with the starship theme
install_fish() {
    echo "-- installing oh-my-fish ..."
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    sudo mkdir "/home/$USER/.config/fish"
    sudo cp "config-templates/config.fish" "/home/$USER/.config/fish/"

    echo ">> oh-my-fish successfully installed!"
    echo ""

}

# some operations create temp date like wget as example and should be removed
clear_temp_files() {
    sudo rm -f -R ./temp
    sudo rm -f wget-log
    sudo rm -f *.deb
}

chosen_programs=()

# check if all programs are wished to be installled or specific ones
get_all_programs() {
    install_prefix=$1

    if [[ $install_prefix = "--install" ]];
    then
        first_program_arg=$1
        program_list=()    

        if [ $first_program_arg = "all" ]
        then
            program_list=${available_programs[@]}
        else
            parameter_count=($# - 1);

            for (( i=2; i<=$parameter_count; i++ )); 
            do
                program_list+=(${!i})
            done
        fi

        for program in ${program_list[@]} 
        do
            chosen_programs+=($program) 
        done
    fi
}

available_programs=("nala" "curl" "gdebi" "vim" "fish" "git" "brave" "discord" "code" "steam" "starship" "bash" "fish")

# matches the program name with the defined installation function
install_program() {
    program=$1
    echo "$program"

    case $program in 
        ("nala") 
            install_apt_program "nala"
            return 0 
        ;;

        ("curl") 
            install_apt_program "curl"
            return 0 
        ;;

        ("gdebi") 
            install_apt_program "gdebi"
            return 0 
        ;;

        ("vim") 
            install_apt_program "vim"
            return 0 
        ;;

        ("fish") 
            install_apt_program "fish"
            return 0 
        ;;

        ("git") 
            install_apt_program "git"
            return 0 
        ;;

        ("brave") 
            install_brave
            return 0 
        ;;

        ("discord") 
            install_discord 
            return 0 
        ;;

        ("code") 
            install_code
            return 0 
        ;;

        ("steam") 
            install_steam
            return 0 
        ;;

        ("starship") 
            install_starship
            return 0 
        ;;

        ("bash") 
            install_bash
            return 0 
        ;;

        ("fish") 
            install_fish
            return 0 
        ;;

        (*) return 1 ;;
    esac
}

# reports if a installation was successful or not for each program
function install_programs() {  
    for program in ${chosen_programs[@]}; 
    do 
        echo "-- trying to install $program ..."
        
        install_program "$program"
        status=$?

        if [[ $status -eq 0 ]];
        then
            echo "-- installation was success!"
        else
            echo "-- installation failed!"
        fi

        echo ""
    done
}

echo "-- initializing script ..."
echo "-- Initializing ..."
echo ">> Done."
echo ""

get_all_programs $@

echo "Following programs are gonna be tried to install:"
echo "=> ${chosen_programs[@]}"
echo ""

install_programs
clear_temp_files