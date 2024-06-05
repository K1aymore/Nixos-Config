{ ... }:


{


  catppuccin = {
    accent = "maroon";
    flavor = "mocha";
  };


  #services.displayManager.sddm.catppuccin.enable = true;

  home-manager.users.klaymore = {
    catppuccin = {
      accent = "maroon";
      flavor = "mocha";
    };

    gtk.catppuccin.enable = true;

    programs = {
      bottom.catppuccin.enable = true;

      fish.catppuccin.enable = true;
      starship.catppuccin.enable = true;
    };

    qt.style.catppuccin = {
      enable = true;
      accent = "maroon"; 
    };
  };

}