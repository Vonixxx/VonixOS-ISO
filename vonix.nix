# Minimal NixOS 
{ config, pkgs, ... }:


{
 imports = [
   <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
 ];

 environment.systemPackages = with pkgs; [
   git
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
        /bin/sh -c "cd /home/nixos && /run/current-system/sw/bin/wget https://github.com/Vonixxx/VonixOS/raw/main/install-script/automated-install.py -O automated-install.py && chmod +x automated-install.py"
     '';
   };
 };
}
