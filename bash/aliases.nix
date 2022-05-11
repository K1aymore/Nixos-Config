{ config, pkgs, ... }:

let
  scripts = "/synced/Sync/Linux/BashScripts";
in {

  programs.bash.shellAliases = {
    nrs = "sudo nixos-rebuild switch";
    nrsu = "sudo nixos-rebuild switch --upgrade";
    nrb = "sudo nixos-rebuild boot";
    nrbu = "sudo nixos-rebuild boot --upgrade";

    nbrc = "micro /nix/cfg/bash/aliases.nix";
    conf = "cd /nix/cfg";

    yd = "/synced/Sync/Linux/BashScripts/yd";
    r128all = "find . -exec r128gain {} \\;";

    jcr = "/synced/Sync/Linux/BashScripts/jcr";
    gcr = "/synced/Sync/Linux/BashScripts/gcr";
    j = "java";
    ecw = "source /synced/Sync/Linux/BashScripts/ecw";
    bashscr = "cd /synced/Sync/Linux/BashScripts";
    nwk = "source /synced/Sync/Linux/BashScripts/nwk";


    brup = "brightnessctl set 5+%";
    brdown = "brightnessctl set 5-%";

    netstat = "vnstat -i enp30s0";
    bat = "cat /sys/class/power_supply/BAT1/capacity";
    batlvl = "cat /sys/class/power_supply/BAT1/capacity";

    hey = "echo hello there";
    claer = "tree / | lolcat";

    findSyncConflict = ''find . -name "*sync-conflict*"'';
    fileCount = "find . -type f | cut -d/ -f 2 | uniq -c";
    doom = "~/.emacs.d/bin/doom";


    rm = "rm -i";

    eleventy = "npx @11ty/eleventy";
    qtShell = "nix-shell -p qt5Full -p qtcreator --run qtcreator";

    webFullMirror = "wget --mirror --convert-links --adjust-extension --page-requisites";
    webMirror = "wget --mirror --convert-links --adjust-extension --page-requisites --no-parent";
    rcloneS3 = "rclone sync --fast-list --checksum --progress";



#   nbrc = "$EDITOR ~/.bashrc && source ~/.bashrc"



    sshServerLan = "ssh 172.16.0.115 -p 56789";

    syncplayFraggie = "syncplay-server --port 59876 --salt 42069 --password Fraggie";



    ipfsbafysimple = "ipfs add --cid-version 1";
    ipfslist = "ipfs pin ls | grep recursive";




    elementSounds = "sudo rm -r /usr/share/webapps/element/media && sudo cp -r /synced/Sync/Linux/ElementSounds /usr/share/webapps/element/media";
  };




  # programs.bash.shellInit = [

    # for i in /synced/Sync/Linux/BashScripts/*; do alias "${i##*/}"="$i"; done

  # ];


}
