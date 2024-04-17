{ pkgs, ... }:

{

  imports = [
    ./x11.nix
    ./wayland.nix
    ./pipewire.nix
  ];

  environment.systemPackages = with pkgs; [
    cosmic-applets
    cosmic-applibrary
    cosmic-bg
    cosmic-comp
    cosmic-icons
    cosmic-launcher
    cosmic-notifications
    cosmic-osd
    cosmic-panel
    cosmic-session
    cosmic-settings
    cosmic-settings-daemon
    cosmic-workspaces-epoch
    xdg-desktop-portal-cosmic
    cosmic-greeter
    cosmic-protocols
    cosmic-edit
    cosmic-screenshot
    cosmic-design-demo
    cosmic-term
    cosmic-randr
    cosmic-files
  ];

  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

	services.desktopManager.cosmic.enable = true;
	services.displayManager.cosmic-greeter.enable = true;

}
