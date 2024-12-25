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

      gtk.enable = true;

      bottom.enable = true;

      fish.enable = true;
      starship.enable = true;

      alacritty.enable = true;
      kitty.enable = true;

      kvantum = {
        enable = true;
        accent = "maroon"; 
      };
    };


  };

}