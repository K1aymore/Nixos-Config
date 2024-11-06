# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, systemSettings, ... }:

{

  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    openMulticastPort = true;
    settings = {
      # Yggdrasil will automatically connect and "peer" with other nodes it
      # discovers via link-local multicast announcements. Unless this is the
      # case (it probably isn't) a node needs peers within the existing
      # network that it can tunnel to.
      #"tcp://1.2.3.4:1024"
      Peers = systemSettings.yggdrasilPeers;
      
      NodeInfo = {
        # This information is visible to the network.
        name = "Klaymore-" + config.networking.hostName;
        #location = "The North Pole";
      };
    };

  };



}
