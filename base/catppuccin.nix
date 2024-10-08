{ ... }:


{


  catppuccin = {
    flavor = "mocha";
    accent = "maroon";
  };


  #services.displayManager.sddm.catppuccin.enable = true;

  home-manager.users.klaymore = {
    catppuccin = {
      flavor = "mocha";
      accent = "maroon";
    };

    gtk.catppuccin.enable = true;

    programs = {
      bottom.catppuccin.enable = true;

      fish.catppuccin.enable = true;
      starship.catppuccin.enable = true;

      alacritty.catppuccin.enable = true;
      kitty.catppuccin.enable = true;
    };

    qt.style.catppuccin = {
      enable = true;
      accent = "maroon"; 
    };
  };

}