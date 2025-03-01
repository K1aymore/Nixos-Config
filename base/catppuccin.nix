{ ... }:

{

  catppuccin = {
    flavor = "mocha";
    accent = "maroon";
  };

  #services.displayManager.sddm.catppuccin.enable = true;

  home-manager.users.klaymore.catppuccin = {
    flavor = "mocha";
    accent = "maroon";

    fish.enable = true;
    starship.enable = true;
    # zellij.enable = true;
    kitty.enable = true;


    bottom.enable = true;


    fcitx5.enable = true;
    gtk.enable = true;
    kvantum = {
      enable = true;
      accent = "maroon"; 
    };

    # don't work
    alacritty.enable = true;

  };

}