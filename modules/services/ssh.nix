{ config, lib, ports, ... }:

{

  config = lib.mkIf config.klaymore.services.ssh.listen.enable {

    networking.firewall.allowedTCPPorts = [ ports.ssh ];

    services.fail2ban.enable = true;

    services.openssh = {
      enable = true;
      ports = [ ports.ssh ];
      openFirewall = false;
      settings.PasswordAuthentication = false;
      settings.X11Forwarding = true;
      #hostKeys = [
      #  { type = "ed25519"; path = "/nix/persist/home/SSH/.ssh/id_ed25519"; }
        # { type = "rsa"; bits = 4096; path = "/mnt/persist/etc/ssh/ssh_host_rsa_key"; }
      #];
    };

    users.users.klaymore.openssh.authorizedKeys.keys = [
      # Phone connectbot
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDE3BuIuioGUdZ/13witApvVN7TXgG8/fL18sC/BiQYpyh24k6AkZwsRM+0fE2GjdYAptXOFKmAAzuQSekZ8UmWhL93UWUHnb+OvyqGqr+W6Aap6fr/OmSldCtDqIrMkgKF7vUgTx9YVMV+Xcer1PUKKspd/Lv9YSDEEz+g3XhSnWEPNE7Kb2+u5XKAVrYb59SBvnpFofsTaepCewrUrmh27F0MAIfGsU4E7FCBNnvCWZCukWV8tlckl8Zeni+gVSAkB065ktlzhJkQGW1rxAuMEed2Fahop/c/qWlKe07F0Jk+ycSUPf6pRblbN8L37uPlHfJQK4GTD9ACeE/gVagv server"
      
      # Laptop
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDtXaikBKQO+y9Fc0bloDJ2V3OP8FBzkLCUlci9xGz8whQqANDG+T4UTIixTReOb8zyO3sEyhqqC8Gp8EpflRQ1C/faFg0KEKNhdNh8fWEwlXVGx6o9FlSkfAuUqGEYfJDwawWuE52tbBKMAsc1vIUY7xR8i0P5NC7cWhnGjbyZOYmM18tMpqngF62fdDR7t2yZa8VvfaOy7BP1tFrsKdRm/fZ1MZn5h/MJnZayvw6y/gl5F/1+Xq+0oVt7xwYpdVrGEL6qfKZZBiHBfTA3pBNZn1QVgYsyrGQDqLh6vCgIKNF8pTZRXcCx7TlpQA40USH0yD+f5WRUtzhoujQj+WlnmduwRd2htYD2GoIhp0kCd0sNAeCK3glCypV6Uqzl5SOAvGaoVwP/NIbak87dVPQ6diWnQIcvpD+dD3m8Bt1juHL++M9pu+/VTPZcpKqD8zf0b0BkwIVKUauiXAgPwL4P17OeySsib7+JQprACS+SzJsahA8pbtC7QND9T8W+SsFEVRYf+qpax/km9ogx34rXRo3uVux3TYJdm4G6IJa3McP/rACUpxD47Sz0Vr1ztfN7X+irdGsT9KAoe7nsC2+fPSFfk3nrrszLfnAA2PO19KwjNZeJ+2hAdNOKfoiApiby7gYcA5i+YMEKJwSEuEDQ0+PG+WDaWX9VvLcoDJqxIQ== Klaymore-Laptop"

      # PC
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3USE2bNw6pA3mVBezBVVrwXG63U630iL8NgswGI8khJDuQzn/Yjan9QhAAAavVXJhga88DEYrr32G0wotqtL+rMaqpn0cgUhX1KTaUObdSm1dOelmioFUT9sm6Ct97SrImXkm50DeK1/3tyAz7td7tk7wUZxEmwVWtBzz3uV6NhzVT1AJbb+NoVGMVspuyaVhf4qUefuSLxbmm3Y9qjHW/GTGOpxYWp7ZOwGtO6ct8C/D0O2KhKNZWzz3DW0ylo1Bvp8NZxdkCEp5GYY9VOU4pUVXO0c+faVsLoWA6G+AbWqTC2qmKHTWs/taYnby57e3i4IX9ghiN+PrH8bPcgBOk3dRh9mmzj8p2YoiUDjczH/dmkoIl7tepqttLAW3K0nVhCpZouQdGprIO+8NUjDQWDEpqUx+2EAXuVvPm89ZDOBnr7H9nZl5T3j3rQsjTftqiOS8+bR7OlYdfqwb19xXmKpSlkdcQoHdgvz5dwvl9DGzAcBJ28+iz2dFz5u8+X0= klaymore@pc"

    ];

  };
}