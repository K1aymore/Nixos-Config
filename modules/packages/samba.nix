{ config, lib, pkgs, ... }:

/* Enables Samba sharing from Dolphin.
*/

{
  config = {
    services.samba = let 
      localNet = (lib.concatStringsSep "." (lib.take 3 (lib.splitString "." config.klaymore.localIP))) + ".";
    in  {
      enable = true;
      openFirewall = true;
      # The full package is needed to register mDNS records (for discoverability), see discussion in
      # https://gist.github.com/vy-let/a030c1079f09ecae4135aebf1e121ea6
      package = pkgs.samba4Full;
      usershares.enable = true;
      settings.global = {
        "workgroup" = "WORKGROUP";
        "server string" = "klaymore %h";
        "netbios name" = "klaymore %h";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = localNet + " 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        # "guest account" = "nobody";
        # "map to guest" = "bad user";
      };
    };

    # To be discoverable with windows
    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    # Make sure your user is in the samba group
    users.users.klaymore = {
      isNormalUser = true;
      extraGroups = [ "samba" ];
    };
  };
}