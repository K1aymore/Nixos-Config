# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    config = {
      # List of connection strings for outbound peer connections in URI format,
      # e.g. tls://a.b.c.d:e or socks://a.b.c.d:e/f.g.h.i:j. These connections
      # will obey the operating system routing table, therefore you should
      # use this section when you may connect via different interfaces.
      Peers = [
        /* "tcp://50.236.201.218:56088"
        "tcp://51.81.46.170:5000"
        "tls://108.175.10.127:61216" */
        "tls://167.160.89.98:7040"
        /* "tcp://198.54.131.122:61007" */
      ];

      # List of connection strings for outbound peer connections in URI format,
      # arranged by source interface, e.g. { "eth0": [ tls://a.b.c.d:e ] }.
      # Note that SOCKS peerings will NOT be affected by this option and should
      # go in the "Peers" section instead.
      InterfacePeers = {};

      # Listen addresses for incoming connections. You will need to add
      # listeners in order to accept incoming peerings from non-local nodes.
      # Multicast peer discovery will work regardless of any listeners set
      # here. Each listener should be specified in URI format as above, e.g.
      # tls://0.0.0.0:0 or tls://[::]:0 to listen on all interfaces.
      Listen = [
        "tls://0.0.0.0:61007"
        "tls://[::]:61007"
      ];

      # Listen address for admin connections. Default is to listen for local
      # connections either on TCP/9001 or a UNIX socket depending on your
      # platform. Use this value for yggdrasilctl -endpoint=X. To disable
      # the admin socket, use the value "none" instead.
      AdminListen = "unix:///var/run/yggdrasil/yggdrasil.sock";

      # Configuration for which interfaces multicast peer discovery should be
      # enabled on. Each entry in the list should be a json object which may
      # contain Regex, Beacon, Listen, and Port. Regex is a regular expression
      # which is matched against an interface name, and interfaces use the
      # first configuration that they match gainst. Beacon configures whether
      # or not the node should send link-local multicast beacons to advertise
      # their presence, while listening for incoming connections on Port.
      # Listen controls whether or not the node listens for multicast beacons
      # and opens outgoing connections.
      MulticastInterfaces = [ {
        Regex = ".*";
        Beacon = true;
        Listen = true;
        Port = 0;
      } ];

      # List of peer public keys to allow incoming peering connections
      # from. If left empty/undefined then all connections will be allowed
      # by default. This does not affect outgoing peerings, nor does it
      # affect link-local peers discovered via multicast.
      AllowedPublicKeys = [];

      # Local network interface name for TUN adapter, or "auto" to select
      # an interface automatically, or "none" to run without TUN.
      IfName = "auto";

      # Maximum Transmission Unit (MTU) size for your local TUN interface.
      # Default is the largest supported size for your platform. The lowest
      # possible value is 1280.
      IfMTU = 65535;

      # By default, nodeinfo contains some defaults including the platform,
      # architecture and Yggdrasil version. These can help when surveying
      # the network and diagnosing network routing problems. Enabling
      # nodeinfo privacy prevents this, so that only items specified in
      # "NodeInfo" are sent back if specified.
      NodeInfoPrivacy = false;

      # Optional node info. This must be a { "key": "value", ... } map
      # or set as null. This is entirely optional but, if set, is visible
      # to the whole network on request.
      NodeInfo = {};

    };



  };



}
