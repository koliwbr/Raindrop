#!/bin/bash

version="1.3"

check_command(){
	if ! command -v $1 &> /dev/null
	then
	    echo $1 could not be found! Install it and try again.
	    exit 1
	fi
}

echo RaindropInstaller for v$version

echo Checking preinstall requirements...
check_command python3
check_command pip3

echo Installing pip dependencies...
pip3 install requests pyfiglet termcolor plotext

cd ~/.local/share

echo Making raindrop app folder
mkdir RaindropWeather

echo Entering raindrop app folder
cd RaindropWeather

echo Getting logo
curl -o icon.png "https://raw.githubusercontent.com/metalfoxdev/Raindrop/main/assets/logo.png"

echo Getting main.py
curl -o main.py "https://raw.githubusercontent.com/metalfoxdev/Raindrop/v$version/main.py"
chmod +x main.py

echo Linking to local bin
ln -s ~/.local/share/RaindropWeather/main.py ~/.local/bin/raindrop

echo writing desktop file
echo "
[Desktop Entry]
Version=$version
Name=Raindrop
Comment=A slick and intuitive weather app for the Linux terminal
Exec=python3 main.py
Icon=$(echo ~)/.local/share/RaindropWeather/icon.png
Path=$(echo ~)/.local/share/RaindropWeather
Terminal=true
Type=Application
Categories=Utility;Application;" >> ~/.local/share/applications/raindrop.desktop

echo Installation complete! Type \"raindrop\" to run it!
