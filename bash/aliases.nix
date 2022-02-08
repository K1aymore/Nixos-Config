{ config, pkgs, ... }:


{

  programs.bash.shellAliases = {
    nrs="sudo nixos-rebuild switch";
    nrsu="sudo nixos-rebuild switch --upgrade";
    nrb="sudo nixos-rebuild boot";
    nrbu="sudo nixos-rebuild boot --upgrade";

    nbrc="micro /nix/cfg/bash/aliases.nix";


    yd="/synced/Sync/Linux/BashScripts/yd";


    brup="brightnessctl set 5+%";
    brdown="brightnessctl set 5-%";

    netstat="vnstat -i enp30s0";
    bat="cat /sys/class/power_supply/BAT1/capacity";
    batlvl="cat /sys/class/power_supply/BAT1/capacity";

    hey="echo hello there";


    doom = "~/.emacs.d/bin/doom";


    rm="rm -i";

    eleventy="npx @11ty/eleventy";

    jcr="javac *.java && java";


#   nbrc="$EDITOR ~/.bashrc && source ~/.bashrc"



    sshServerLan="ssh 172.16.0.115 -p 56789";

    syncplayFraggie="syncplay-server --port 59876 --salt 42069 --password Fraggie";



    ipfsbafysimple="ipfs add --cid-version 1";
    ipfslist="ipfs pin ls | grep recursive";




    elementSounds="sudo rm -r /usr/share/webapps/element/media && sudo cp -r /synced/Sync/Linux/ElementSounds /usr/share/webapps/element/media";
  };




  # programs.bash.shellInit = [

    # for i in /synced/Sync/Linux/BashScripts/*; do alias "${i##*/}"="$i"; done

  # ];


}
