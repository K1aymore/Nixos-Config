{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.klaymore.servers.samba.enable {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        "stuff" = {
          "path" = "/zfs3/stuff";
          "browseable" = "yes";
          "read only" = "yes";
          "guest ok" = "yes";
          # "create mask" = "0644";
          # "directory mask" = "0755";
          # "force user" = "username";
          # "force group" = "groupname";
        };
        # "private" = {
        #   "path" = "/mnt/Shares/Private";
        #   "browseable" = "yes";
        #   "read only" = "no";
        #   "guest ok" = "no";
        #   "create mask" = "0644";
        #   "directory mask" = "0755";
        #   "force user" = "username";
        #   "force group" = "groupname";
        # };
      };
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    services.avahi = {
      enable = true;
      openFirewall = true;
      publish.enable = true;
      publish.userServices = true;
      # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
      nssmdns4 = true;
      # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
    };
  };
}