{ config, lib, ... }:

{

  config = lib.mkIf config.klaymore.system.catppuccin.enable {
    catppuccin = {
      flavor = "mocha";
      accent = "maroon";
      
      grub.enable = true;
    };

    #services.displayManager.sddm.catppuccin.enable = true;

    # need program to be enabled in home manager as well
    home-manager.users.klaymore.catppuccin = {
      flavor = "mocha";
      accent = "maroon";

      fish.enable = true;
      starship.enable = true;
      zellij.enable = true;
      kitty.enable = true;
      alacritty.enable = true;
      foot.enable = true;


      bottom.enable = true;
      bat.enable = true;
      eza.enable = true;
      micro.enable = true;
      delta.enable = true;
      yazi.enable = true;

      hyprland.enable = true;
      hyprlock.enable = true;
      #waybar.enable = true;

      element-desktop.enable = true;
      obs.enable = true;  # adds option to menu
      chromium.enable = true;
      librewolf.enable = true;
      anki.enable = true;

      fcitx5.enable = true;
      kvantum.enable = true;

      vscode.profiles.default = {
        enable = true;
        #accent = "maroon";
        settings = {
          boldKeywords = true;
          italicComments = true;
          italicKeywords = true;
          colorOverrides = {};
          customUIColors = {};
          workbenchMode = "default";
          bracketMode = "rainbow";
          extraBordersEnabled = false;
        };
      };

    };

  };
}
