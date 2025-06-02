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

    ./server/nginx.nix
    #./server/conduit.nix
    ./server/forgejo.nix
    #./server/syncplay.nix
    #./server/miniflux.nix
    #./server/freshrss.nix
    ./server/minecraft.nix


    ./system/syncthing.nix
    ./system/zram.nix
    ./system/zfs.nix

    ./impermanence/system.nix
    ./impermanence/home.nix
  ];

  networking = {
    hostId = "03828261";
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedTCPPortRanges = [ { from = 6900; to = 6999; } ];

  programs.java.enable = true;


}
