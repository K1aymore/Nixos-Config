{ ... }:

let
  scripts = "/synced/Sync/Linux/BashScripts";
  configPath = "/synced/Nix/cfg";
in {

  environment.shellAliases = {
    nrb = "sudo nixos-rebuild boot --flake ${configPath}";
    nrs = "sudo nixos-rebuild switch --flake ${configPath}";
    rebuildBoot = "cd ${configPath} && git add .; cd - && nrb";
    rebuildSwitch = "cd ${configPath} && git add .; cd - && nrs";
    update = "cd ${configPath} && git add . && git commit -m \"before update\" && nix flake update && rebuildBoot; cd -";
    restart = "reboot";
    
    conf = "cd ${configPath}";
    
    #cd = "z"; # Breaks z lol
    ls = "eza";
    #cat = "bat";
    fd = "fd --hidden";

    nbrc = "micro /nix/cfg/bash/aliases.nix";

    yd = "bash /synced/Sync/Linux/BashScripts/yd";
    r128all = "r128gain -r ./";

    ga = "git add";
    gc = "git commit";
    gs = "git status";
    gp = "git push";
    gsl = "git shortlog";
    gl = "git log";

    vi = "nvim";
    steamflat = "flatpak run com.valvesoftware.Steam";
    blades = "~/.cargo/bin/blades";
    ncfg = "codium ${configPath}";
    notes = "codium /synced/Sync/Notes";

    jcr = "/synced/Sync/Linux/BashScripts/jcr";
    gcr = "/synced/Sync/Linux/BashScripts/gcr";
    j = "java";
    ecw = "bash /synced/Sync/Linux/BashScripts/ecw";
    bashscr = "cd /synced/Sync/Linux/BashScripts";
    nwk = "bash /synced/Sync/Linux/BashScripts/nwk";
    dnxhdify = "bash /synced/Sync/Linux/BashScripts/dnxhdify";
    capEachWord = "bash /synced/Sync/Linux/BashScripts/capEachWord";

    brup = "brightnessctl set 5+%";
    brdown = "brightnessctl set 5-%";

    netstat = "vnstat -i enp30s0";
    battery = "cat /sys/class/power_supply/BAT1/capacity";
    batlvl = "cat /sys/class/power_supply/BAT1/capacity";
    ramCheck = "sudo lshw -short -C memory";

    hey = "echo hello there";
    claer = "tree / | lolcat";

    findSyncConflict = ''find . -name "*sync-conflict*"'';
    fileCount = "find . -type f | cut -d/ -f 2 | uniq -c";
    doom = "~/.emacs.d/bin/doom";
    findjdk = "cd /nix/store && ls -d */ | grep jdk";
    makeModule = "make -C $(nix-build -E '(import <nixpkgs> {}).linux.dev' --no-out-link)/lib/modules/*/build M=$(pwd) modules";


    #rm = "rm -i";

    eleventy = "npx @11ty/eleventy";
    qtShell = "nix-shell -p kdePackages.full -p qtcreator --run qtcreator";
    davinciResolve = "NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nix-shell -p davinci-resolve --impure --run davinci-resolve";

    webFullMirror = "wget --mirror --convert-links --adjust-extension --page-requisites";
    webMirror = "wget --mirror --convert-links --adjust-extension --page-requisites --no-parent";
    rcloneS3 = "rclone sync --fast-list --checksum --progress";



    sshServerLan = "ssh 172.16.0.115 -p 56789";


    ipfsbafysimple = "ipfs add --cid-version 1";
    ipfslist = "ipfs pin ls | grep recursive";

    elementSounds = "sudo rm -r /usr/share/webapps/element/media && sudo cp -r /synced/Sync/Linux/ElementSounds /usr/share/webapps/element/media";
  };




  # programs.bash.shellInit = [

    # for i in /synced/Sync/Linux/BashScripts/*; do alias "${i##*/}"="$i"; done

  # ];


}
