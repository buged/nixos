#!/bin/sh
cd /home/us3r/nixos
git pull https://github.com/buged/nixos
sudo cp /home/us3r/nixos/configuration.nix /etc/nixos/
nixos-rebuild switch
