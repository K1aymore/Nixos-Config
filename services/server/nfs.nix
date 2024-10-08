{ ... }:

{

  networking.firewall.allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
  networking.firewall.allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];

  services.nfs.server = {
    enable = true;
    hostName = "172.16.0.109";
    statdPort = 4000;
    lockdPort = 4001;
    mountdPort = 4002;
    extraNfsdConfig = '''';

    exports = ''
      /zfs1/hugeArchive         172.16.0.109(rw,nohide,no_subtree_check,no_root_squash)
    '';
  };

  /*
      /synced/Archive             172.16.0.1(rw,nohide,insecure,no_subtree_check)
      /synced/EllidaProjects      172.16.0.1(rw,nohide,insecure,no_subtree_check)
      /synced/EllidaSync          172.16.0.1(rw,nohide,insecure,no_subtree_check)
      /synced/Projects            172.16.0.1(rw,nohide,insecure,no_subtree_check)
      /synced/Sync                172.16.0.1(rw,nohide,insecure,no_subtree_check)
      /synced/Websites            172.16.0.1(rw,nohide,insecure,no_subtree_check)
  */

}
