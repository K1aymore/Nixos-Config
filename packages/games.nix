{ pkgs, ...}:

{


  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    lutris
    playonlinux
    bottles
    #grapejuice
    #protonup
    #protontricks
    #openal
    heroic
    legendary-gl

    mangohud

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

  ];

  # sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # flatpak install flathub com.valvesoftware.Steam
  # flatpak run com.valvesoftware.Steam
  # flatpak override --user --env=MANGOHUD=1 com.valvesoftware.Steam
  # flatpak override --user --env=ENABLE_VKBASALT=1 com.valvesoftware.Steam
  # flatpak override --user --env=MANGOHUD_CONFIG=fps_limit=114,arch,ram,vram,vkbasalt,vulkan_driver,io_read,io_write,gpu_core_clock,gpu_mem_clock,gpu_fan,gpu_voltage,cpu_temp,gpu_temp com.valvesoftware.Steam
  
  # MANGOHUD=1
  # ENABLE_VKBASALT=1
  # 
  # FLATPAK_GL_DRIVERS=mesa-git flatpak run com.valvesoftware.Steam

  
  hardware.steam-hardware.enable = true;

  #flatpak install flathub net.brinkervii.grapejuice
  #flatpak run net.brinkervii.grapejuice

  programs.gamemode = {
    enable = true;
  };

  programs.gamescope.enable = true;

  home-manager.users.klaymore.programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      fps_limit = [ 117 0 ];
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

  /*programs = {
    steam.enable = true;
  };*/


}
