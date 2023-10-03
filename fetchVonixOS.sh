#!/usr/bin/env bash

cd /home/nixos
/run/current-system/sw/bin/wget https://github.com/Vonixxx/VonixOS/raw/main/install-script/main.py -O main.py
/run/current-system/sw/bin/wget https://github.com/Vonixxx/VonixOS/raw/main/install-script/functions.py -O functions.py
chmod +x main.py
