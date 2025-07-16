{ config, lib, ... }:

{

  config = lib.mkIf config.klaymore.system.zram.enable {

    zramSwap = {
      enable = true;
      priority = 5;  # default 5
    };
    
    boot.kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
      "zswap.enabled" = 0;
    };

  };
}