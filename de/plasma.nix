{ config, pkgs, ... }:

{

    imports = [ ./x11.nix ];

    services.xserver = {
        # Enable the KDE Plasma Desktop Environment.
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;
    };

  environment.systemPackages = with pkgs; [
    sweet

  ];
}


