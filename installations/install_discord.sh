#!/bin/bash

output_file="/home/jinoyoko/Downloads/discord.deb"

function downlaod_discord() {
  download_link="https://discord.com/api/download?platform=linux&format=deb"
  wget -O $output_file $download_link
}

function install_discord() {
  gdebi $output_file
  rm $output_file
}

downlaod_discord
install_discord
