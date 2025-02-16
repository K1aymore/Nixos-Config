{ ports, ... }:

{

  networking.firewall = {
    allowedTCPPorts = [ ports.wgEllMCJava ports.wgEllMCBedrock ];
  };

  # https://wiki.nixos.org/wiki/Networking
  networking.nftables = {
    enable = true;
    flushRuleset = true;
    ruleset = ''
        table ip nat {
          chain postrouting {
            type nat hook postrouting priority 100; policy accept;
            masquerade
          }

        chain prerouting {
            type nat hook prerouting priority -100; policy accept;
            #(use journalctl --grep=CONNECTION")
            iifname "enp4s0" tcp dport ${toString ports.wgEllMCJava} log prefix "MC${toString ports.wgEllMCJava}: " dnat to 10.100.0.2:${toString ports.wgEllMCJava}
            #iifname "enp4s0" udp dport 6970 log prefix "Wg6970: "
            #iifname "enp4s0" tcp dport 6969 log prefix "MC6969: "
            iifname "enp4s0" udp dport ${toString ports.wgEllMCBedrock} log prefix "MC${toString ports.wgEllMCBedrock}: " dnat to 10.100.0.2:${toString ports.wgEllMCBedrock}
          }
        }
    '';
  };
  networking.nat = {
    enable = true;
    enableIPv6 = true;
    internalInterfaces = [ "enp4s0" ];
    externalInterface = "wgEllMC";
    forwardPorts = [
      {
        sourcePort = ports.wgEllMCJava;
        proto = "tcp";
        destination = "10.100.0.2:${toString ports.wgEllMCJava}";
      }
      {
        sourcePort = ports.wgEllMCBedrock;
        proto = "udp";
        destination = "10.100.0.2:${toString ports.wgEllMCBedrock}";
      }
    ];
  };

  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wgEllMC = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.100.0.1/24" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = ports.wgEllMCJava;

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
      privateKeyFile = "/nix/persist/stuff/wg-private";

      peers = [
        # List of allowed peers.
        { # Feel free to give a meaning full name
          # Public key of the peer (not a file path).
          publicKey = "mmC2KtYIqeydbfbunLwJSCtCHwUebBLH9LKIj32wSho=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.2/32" ];
          persistentKeepalive = 25;
        }
        # { # John Doe
        #   publicKey = "{john doe's public key}";
        #   allowedIPs = [ "10.100.0.3/32" ];
        # }
      ];
    };
  };

}
