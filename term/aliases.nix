{ config, pkgs, ... }:

let
  scripts = "/synced/Sync/Linux/BashScripts";
in {

  environment.shellAliases = {
    nrs = "sudo nixos-rebuild switch";
    nrsu = "sudo nixos-rebuild switch --upgrade";
    nrb = "sudo nixos-rebuild boot";
    nrbu = "sudo nixos-rebuild boot --upgrade";

    nbrc = "micro /nix/cfg/bash/aliases.nix";
    conf = "cd /nix/cfg";
    lisp = "cd /synced/Projects/Programming/Lisp";

    yd = "/synced/Sync/Linux/BashScripts/yd";
    r128all = "find . -exec r128gain {} \\;";

    ga = "git add";
    gc = "git commit";
    gs = "git status";
    gp = "git push";
    gsl = "git shortlog";
    gl = "git log";

    jcr = "/synced/Sync/Linux/BashScripts/jcr";
    gcr = "/synced/Sync/Linux/BashScripts/gcr";
    j = "java";
    ecw = "source /synced/Sync/Linux/BashScripts/ecw";
    bashscr = "cd /synced/Sync/Linux/BashScripts";
    nwk = "source /synced/Sync/Linux/BashScripts/nwk";
    dnxhdify = "source /synced/Sync/Linux/BashScripts/dnxhdify";


    brup = "brightnessctl set 5+%";
    brdown = "brightnessctl set 5-%";

    netstat = "vnstat -i enp30s0";
    bat = "cat /sys/class/power_supply/BAT1/capacity";
    batlvl = "cat /sys/class/power_supply/BAT1/capacity";
    ramCheck = "sudo lshw -short -C memory";

    hey = "echo hello there";
    claer = "tree / | lolcat";

    findSyncConflict = ''find . -name "*sync-conflict*"'';
    fileCount = "find . -type f | cut -d/ -f 2 | uniq -c";
    doom = "~/.emacs.d/bin/doom";
    findjdk = "cd /nix/store && ls -d */ | grep jdk";
    makeModule = "make -C $(nix-build -E '(import <nixpkgs> {}).linux.dev' --no-out-link)/lib/modules/*/build M=$(pwd) modules";


    rm = "rm -i";

    eleventy = "npx @11ty/eleventy";
    qtShell = "nix-shell -p libsForQt5.full -p qtcreator --run qtcreator";

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
