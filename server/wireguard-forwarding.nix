{ pkgs, lib, config, ... }:

{

  networking.firewall = {
    allowedTCPPorts = [ 6968 6969 6970 ];
  };

  # https://wiki.nixos.org/wiki/Networking
  networking.nftables = {
    enable = true;
    ruleset = ''
        table ip nat {
          chain PREROUTING {
            type nat hook prerouting priority dstnat; policy accept;
            iifname "enp4s0" tcp dport 6969 dnat to 10.100.0.2:25565
            iifname "enp4s0" udp dport 6968 dnat to 10.100.0.2:19132
          }
        }
    '';
  };
  networking.nat = {
    enable = true;
    internalInterfaces = [ "enp4s0" ];
    externalInterface = "wgEllMC";
    forwardPorts = [
      {
        sourcePort = 6969;
        proto = "tcp";
        destination = "10.100.0.1:25565";
      }
      {
        sourcePort = 6968;
        proto = "udp";
        destination = "10.100.0.1:19132";
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
      privateKeyFile = "/nix/persist/stuff/wg-private";

      peers = [
        # List of allowed peers.
        { # Feel free to give a meaning full name
          # Public key of the peer (not a file path).
          publicKey = "mmC2KtYIqeydbfbunLwJSCtCHwUebBLH9LKIj32wSho=";
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
