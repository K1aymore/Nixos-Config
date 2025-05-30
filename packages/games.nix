{ pkgs, ...}:

{

  environment.systemPackages = with pkgs; [
    wineWowPackages.full
    lutris
    #playonlinux
    bottles
    #grapejuice
    protonup-qt
    #protontricks
    #openal
    heroic
    #legendary-gl
    winetricks
    protontricks

    mangohud
    
    parsec-bin
    r2modman

    #piper

    #minecraft
    #itch
    prismlauncher
    jdk17
    jdk11
    jdk8

    #wesnoth
    #openttd
    #simutrans
    #openrct2
    #zeroad
    #opendungeons
    #crawl
    #opendune
    #galaxis
    #xlife
    #eternity
    #freedroidrpg
    #osu-lazer
    #arx-libertatis
    #warzone2100
    #widelands
    

  ];

  # sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # flatpak install flathub com.valvesoftware.Steam
  # flatpak run com.valvesoftware.Steam
  # flatpak override --user --env=MANGOHUD=1 com.valvesoftware.Steam
  # flatpak override --user --env=ENABLE_VKBASALT=1 com.valvesoftware.Steam
  # flatpak override --user --env=MANGOHUD_CONFIG=fps_limit=135+114+0,arch,ram,vram,resolution,vkbasalt,gamemode,vulkan_driver,io_read,io_write,gpu_core_clock,gpu_mem_clock,gpu_fan,gpu_voltage,cpu_temp,gpu_temp com.valvesoftware.Steam
  
  # MANGOHUD=1
  # ENABLE_VKBASALT=1 
  # 
  # FLATPAK_GL_DRIVERS=mesa-git flatpak run com.valvesoftware.Steam

  
  hardware.steam-hardware.enable = true;
  #services.ratbagd.enable = true;
  

  #flatpak install flathub net.brinkervii.grapejuice
  #flatpak run net.brinkervii.grapejuice

  programs.gamemode = {
    enable = true;
  };

  programs.gamescope = {
    enable = true;
  };

  home-manager.users.klaymore.programs.mangohud = {
    enable = true;
    enableSessionWide = false;
    settings = {
      fps_limit = [ 0 150 60 ]; # doesn't work with mangoapp
      show_fps_limit = true;
      
      arch = true;
      vulkan_driver = true;
      wine = true;
      gamemode = true;
      vkbasalt = true;
      resolution = true;
      
      gpu_temp = true;
      #gpu_fan = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      #gpu_voltage = true;
      
      cpu_temp = true;
      
      ram = true;
      vram = true;
      io_read = true;
      io_write = true;
      
    };
  };

  # environment.sessionVariables = {
  #   MANGOHUD = "1";
  # };



}
