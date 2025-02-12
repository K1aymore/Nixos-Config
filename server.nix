{ ... }:

{

  imports = [
    ./locale/colemak.nix
    ./locale/losAngeles.nix
    
    #./de/plasma.nix
    
    #./packages/gui.nix


    ./server/ssh.nix
    ./server/wireguard-forwarding.nix
    ./server/nfs.nix

    #./server/nginx.nix
    #./server/synapse.nix
    ./server/gitea.nix
    #./server/syncplay.nix
    ./server/miniflux.nix
    #./server/minecraft.nix


    ./system/syncthing.nix
    ./system/zram.nix
    ./system/zfs.nix

    ./impermanence/system.nix
    ./impermanence/home.nix
  ];

  networking = {
    hostId = "03828261";
    domain = "klaymore.me";
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];

  programs.java.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
