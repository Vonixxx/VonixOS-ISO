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
 
 environment.etc = {
   "fetchVonixOS.sh".mode   = "0755";
   "fetchVonixOS.sh".source = ./fetchVonixOS.sh;
 };

 systemd.services.fetchScript = {
   wantedBy    = [ "multi-user.target" ];
   wants       = [ "network-online.target" ];
   after       = [ "network-online.target" ];
   description = "Fetch and Run Python Script from GitHub";
   serviceConfig = {
     Type      = "oneshot";
     ExecStart = "/etc/fetchVonixOS.sh";
   };
 };

 nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
