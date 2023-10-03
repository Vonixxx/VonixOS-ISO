###########
# VonixOS #
#################
# Minimal NixOS # 
#################
{ config, pkgs, ... }:

{
 imports = [
   <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
 ];

 environment.systemPackages = with pkgs; [
   git
   mkpasswd
   wget
   python3Full
 ];
 
 nix.settings.experimental-features = [ "nix-command" "flakes" ];

 systemd.services.fetchScript = {
   wantedBy    = [ "multi-user.target" ];
   wants       = [ "network-online.target" ];
   after       = [ "network-online.target" ];
   description = "Fetch and Run Python Script from GitHub";
   serviceConfig = {
     Type = "oneshot";
     ExecStart = ''
        /bin/sh -c '\
         cd /home/nixos && \
         /run/current-system/sw/bin/wget https://github.com/Vonixxx/VonixOS/raw/main/install-script/main.py -O main.py && \
         /run/current-system/sw/bin/wget https://github.com/Vonixxx/VonixOS/raw/main/install-script/functions.py -O functions.py && \
         chmod +x main.py
        '
     '';
   };
 };
}
