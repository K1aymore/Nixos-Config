{ pkgs, lib, config, ... }:


{

  services.distcc = {
    enable = true;
    openFirewall = true;
    port = 3632;

    allowedClients = [
      "127.0.0.1"
      "172.16.0.1"
    ];
  };

}
