{ pkgs, lib, config, ... }:

{

  networking.firewall = {
    allowedTCPPorts = [ 6968 6969 6970 ];
  };

  networking.nftables = {
    enable = true;
    flushRuleset = true;
    tables.EllMC = {
      content = ''
        # Check out https://wiki.nftables.org/ for better documentation.
        chain postrouting {
          type nat hook postrouting priority 100; policy accept;
          masquerade
        }

        chain prerouting {
          type nat hook prerouting priority -100; policy accept;
          ip daddr 10.0.0.125 tcp dport { 6969 } dnat to 10.100.0.2:25565
          ip daddr 10.0.0.125 udp dport { 6968 } dnat to 10.100.0.2:19132
        }
      '';
      family = "inet";
    };
  };

  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wgEllMC = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.100.0.1/24" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = 6970;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      # postSetup = ''
      #   ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      # '';

      # This undoes the above command
      # postShutdown = ''
      #   ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      # '';

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/nix/persist/wireguard.key";

      peers = [
        # List of allowed peers.
        { # Feel free to give a meaning full name
          # Public key of the peer (not a file path).
          publicKey = "BGtFEKI1cqIc+tVml4OmAdL7lW/Gt748yO1JGio7mgs=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.2/32" ];
        }
        # { # John Doe
        #   publicKey = "{john doe's public key}";
        #   allowedIPs = [ "10.100.0.3/32" ];
        # }
      ];
    };
  };

}
