{ config, lib, ... }:

{

  config = lib.mkIf config.klaymore.system.keyd.enable {
    services.keyd.enable = true;
    # keyboards = {
    #   default = {
    #     ids = [ "*" ];
    #     settings = {
    #       main = {
    #         capslock = "overload(control, esc)";
    #       };
    #     };
    #   };
    # };

  };

}