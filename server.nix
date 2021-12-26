{ config, pkgs, ... }:


{

  imports =
    [
      ./base.nix
      ./locale/qwerty.nix
      ./locale/losAngeles.nix
      # ./system/pipewire.nix
      ./de/plasma.nix

      ./packages/gui.nix
      
      ./server/syncthing.nix
      ./server/ssh.nix

      ./server/nginx.nix
      #./server/httpd.nix
      ./server/synapse.nix
      # ./server/radicale.nix
      # ./server/vaultwarden.nix


      # ./system/xp-pen.nix

      # ./impermanence/system.nix
      # ./impermanence/home.nix
    ];



  networking = {
    hostName = "server";
    domain = "klaymore.me";

    firewall.enable = true;
  };


  security.acme.email = "klaymorer@protonmail.com";
  security.acme.acceptTerms = true;


  services.cron = {
    enable = true;
    systemCronJobs = [
      "@daily sudo rclone sync /nix/persist /synced/Archive/NixPersist && sudo chown -R klaymore:users /synced/Archive/NixPersist"
    ];
  };



}




