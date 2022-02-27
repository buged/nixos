#!/usr/bin/env bash
updateSystem () {
cd /home/us3r/nixos
git pull https://github.com/buged/nixos
sudo cp /home/us3r/nixos/configuration.nix /etc/nixos/
nixos-rebuild switch
}

cloneRepo () {
# Cloning the repository
git clone https://github.com/buged/nixos
# Giving execute permission to the update.sh file
sudo chmod a+x /home/us3r/nixos/update.sh
}

FILE=/home/us3r/nixos/configuration.nix
if [ -f "$FILE" ]; then
    updateSystem
else 
    cloneRepo
		updateSystem
fi
