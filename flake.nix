{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small"; #"github:NixOS/nixpkgs?rev=2631b0b7abcea6e640ce31cd78ea58910d31e650";
  
    nixpkgs-staging.url = "github:NixOS/nixpkgs/nixos-unstable-small";  # ?rev=493dfd5c25fefa57fe87d50aaa0341a47c673546
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-superstable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    impermanence.url = "github:nix-community/impermanence";
    catppuccin.url = "github:catppuccin/nix";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    sitelen-pona-UCSUR = {
      url = "github:K1aymore/nix-utils?dir=sitelen-pona-UCSUR";
    };

  };


  outputs = { self, nixpkgs, nixpkgs-staging, nixpkgs-stable, nixpkgs-superstable, home-manager, impermanence, catppuccin, nix-minecraft, ... }@attrs:
  let
    ports = {
      # forwarded on server: 80 443 6900-6999 25565 19132
      # nfs = 111 2049 4000 4001 4002 20048;
      # KDE Connect 1714-1764

      nginx = 80;
      nginxs = 443;

      forgejo = 3000;
      # forgejo database port 3306
      miniflux = 3001;
      synapse = 8008;
      # coturn 49000-50000
      conduit = 6920;

      yggdrasil = 6901;
      minecraft-wildcat = 6968;
      minecraft-frenched = 6967;

      wgBen = 6970;

      wgEllMCJava = 25565;
      wgEllMCBedrock = 19132;
      
      openttd1 = 3978;
      openttd2 = 3979;

      ssh = 56789;
      syncthingTransfer = 22000;
      syncthingRelay = 22067;
      ipfsAPI = 5001;
      ipfsGateway = 8081;
      ipfs = 59271;

    };

    makeSystem = hostname: settings: 
      (if settings ? "nixpkgs"
      then attrs.${settings.nixpkgs}.lib.nixosSystem
      else nixpkgs.lib.nixosSystem)
    {
      system = settings.architecture;
      specialArgs = attrs // { inherit ports; };

      modules = builtins.filter (f: nixpkgs.lib.hasSuffix ".nix" f) (
        (nixpkgs.lib.filesystem.listFilesRecursive ./base) ++
        (nixpkgs.lib.filesystem.listFilesRecursive ./modules)) ++ 
      [
        ./hardware/${hostname}.nix
        ./${hostname}.nix
        ./_secrets.nix

        { networking.hostName = hostname; }
        { nixpkgs.hostPlatform = settings.architecture; }

        home-manager.nixosModules.home-manager
        impermanence.nixosModule
        { home-manager.users.klaymore.imports = [
          impermanence.nixosModules.home-manager.impermanence
          catppuccin.homeModules.catppuccin
        ]; }
        catppuccin.nixosModules.catppuccin
        nix-minecraft.nixosModules.minecraft-servers


        { nixpkgs.overlays = [
          nix-minecraft.overlay

          (final: prev: {
            staging = import nixpkgs-staging {
              system = settings.architecture;
              config.allowUnfree = true;
            };
            stable = import nixpkgs-stable {
              system = settings.architecture;
              config.allowUnfree = true;
            };
            superstable = import nixpkgs-superstable {
              system = settings.architecture;
              config.allowUnfree = true;
            };
          })
        ];}

      ];
    };

  in
  {
    nixosConfigurations = {

      pc = makeSystem "pc" {
        architecture = "x86_64-linux";
      };

      server = makeSystem "server" {
        architecture = "x86_64-linux";
      };

      laptop = makeSystem "laptop" {
        architecture = "x86_64-linux";
      };

    };
  };
}
