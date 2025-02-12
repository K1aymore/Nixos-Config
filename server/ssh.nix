{ ports, ... }:

{

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
    #"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCulFjLwB+PGnhY1l4a6S2wAzK/bf7b6lWkT1SKFvifxAKbU1/7OWVnYnpzjpXB3/9m6yevKvVUecCVBCZKMWjFlIB/WK8zwAaSopXb3+BhIrBhcfPvrNt4EeufLbtIDFnB0V46WNDVIPxqwWCe+dU39gP8SDEpkDza3dGx4Wf2hs7Vr9Oof2cRguv2BDqUJoRqgDkq6rrUWxRLxDDLwcWJfLtTsRLD9bIZy/1KtlcqfFZqV4HhjBz0LOv3iwHr9Bc1CCsvU/OVxzkUesXX7qvNDNiync3BQUwMzbSm6cAMhkcDULfBcdoPJZpmP9GPC2MiVDJgmr4DHV3PL96du1gIdhot+pew9uH/Do7k2mA/hTiV4G22wdWCNVFsQDzJHwHqI1fCOxutpgeqG6IvdbCx3BZH0ZVJnGgzcEUyCOevhAjdkoxKLoPxWDx/AK9fS6y+i7N9R4reptcySxPTVEenAf/DM2a1nxenU0tgtR/Ctp1h7JvvRsv1zs7u3pO8XxLi6DhfUYR3j4CfKNqnBYrrm+Vki9wO3p4rS6nHhKDhBF2AsLe/tnxPerfD++X7jMe4qJjeJ4RNw2jEDogFVE6Y/OBibKSanzGykU2H+C7tILs9w2dx9hq1nswgfs+/N7+JWE7qThSXJTSBMgA5edCWyM/QPWNaJpoIxoRUKo2zJQ== PC"

    # Laptop
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDtXaikBKQO+y9Fc0bloDJ2V3OP8FBzkLCUlci9xGz8whQqANDG+T4UTIixTReOb8zyO3sEyhqqC8Gp8EpflRQ1C/faFg0KEKNhdNh8fWEwlXVGx6o9FlSkfAuUqGEYfJDwawWuE52tbBKMAsc1vIUY7xR8i0P5NC7cWhnGjbyZOYmM18tMpqngF62fdDR7t2yZa8VvfaOy7BP1tFrsKdRm/fZ1MZn5h/MJnZayvw6y/gl5F/1+Xq+0oVt7xwYpdVrGEL6qfKZZBiHBfTA3pBNZn1QVgYsyrGQDqLh6vCgIKNF8pTZRXcCx7TlpQA40USH0yD+f5WRUtzhoujQj+WlnmduwRd2htYD2GoIhp0kCd0sNAeCK3glCypV6Uqzl5SOAvGaoVwP/NIbak87dVPQ6diWnQIcvpD+dD3m8Bt1juHL++M9pu+/VTPZcpKqD8zf0b0BkwIVKUauiXAgPwL4P17OeySsib7+JQprACS+SzJsahA8pbtC7QND9T8W+SsFEVRYf+qpax/km9ogx34rXRo3uVux3TYJdm4G6IJa3McP/rACUpxD47Sz0Vr1ztfN7X+irdGsT9KAoe7nsC2+fPSFfk3nrrszLfnAA2PO19KwjNZeJ+2hAdNOKfoiApiby7gYcA5i+YMEKJwSEuEDQ0+PG+WDaWX9VvLcoDJqxIQ== Klaymore-Laptop"

    # PC
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3USE2bNw6pA3mVBezBVVrwXG63U630iL8NgswGI8khJDuQzn/Yjan9QhAAAavVXJhga88DEYrr32G0wotqtL+rMaqpn0cgUhX1KTaUObdSm1dOelmioFUT9sm6Ct97SrImXkm50DeK1/3tyAz7td7tk7wUZxEmwVWtBzz3uV6NhzVT1AJbb+NoVGMVspuyaVhf4qUefuSLxbmm3Y9qjHW/GTGOpxYWp7ZOwGtO6ct8C/D0O2KhKNZWzz3DW0ylo1Bvp8NZxdkCEp5GYY9VOU4pUVXO0c+faVsLoWA6G+AbWqTC2qmKHTWs/taYnby57e3i4IX9ghiN+PrH8bPcgBOk3dRh9mmzj8p2YoiUDjczH/dmkoIl7tepqttLAW3K0nVhCpZouQdGprIO+8NUjDQWDEpqUx+2EAXuVvPm89ZDOBnr7H9nZl5T3j3rQsjTftqiOS8+bR7OlYdfqwb19xXmKpSlkdcQoHdgvz5dwvl9DGzAcBJ28+iz2dFz5u8+X0= klaymore@pc"

  ];




}
