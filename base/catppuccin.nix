{ ... }:

{

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


    bottom.enable = true;

    hyprland.enable = true;
    hyprlock.enable = true;
    #waybar.enable = true;


    fcitx5.enable = true;
    gtk.enable = true;
    kvantum = {
      enable = true;
      accent = "maroon"; 
    };

  };

}
