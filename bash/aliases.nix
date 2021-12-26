{ config, pkgs, ... }:


{

  programs.bash.shellAliases = {
    nrs="sudo nixos-rebuild switch";
    nrsu="sudo nixos-rebuild switch --upgrade";

    nbrc="micro /nix/cfg/bash/aliases.nix";

    brup="brightnessctl set 5+%";
    brdown="brightnessctl set 5-%";

    netstat="vnstat -i enp30s0";
    bat="cat /sys/class/power_supply/BAT1/capacity";
    batlvl="cat /sys/class/power_supply/BAT1/capacity";

    hey="echo hello there";

  };


  # programs.bash.shellInit = [
 
    # for i in /synced/Sync/Linux/BashScripts/*; do alias "${i##*/}"="$i"; done
    
  # ];


}
