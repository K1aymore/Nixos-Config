{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; #"github:NixOS/nixpkgs?rev=2631b0b7abcea6e640ce31cd78ea58910d31e650";
    # nixpkgs-pc.url = "github:K900/nixpkgs/plasma-6.6";
  
    nixpkgs-superstable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    impermanence.url = "github:nix-community/impermanence";
    catppuccin.url = "github:catppuccin/nix";

    nvf = {
      url = "github:NotAShelf/nvf/v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-doom-emacs-unstraightened = {
    #   url = "github:marienz/nix-doom-emacs-unstraightened";
    #   # Optional, to download less. Neither the module nor the overlay uses this input.
    #   inputs.nixpkgs.follows = "";
    # };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    # sitelen-pona-UCSUR = {
    #   url = "github:K1aymore/nix-utils?dir=sitelen-pona-UCSUR";
    # };

  };


  outputs = { self, nixpkgs, nixpkgs-superstable, home-manager, impermanence, catppuccin, nvf, nix-minecraft,  ... }@attrs:
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
      kavita = 6999;

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
      specialArgs = { inherit ports; };

      modules = builtins.filter (f: nixpkgs.lib.hasSuffix ".nix" f) (
        (nixpkgs.lib.filesystem.listFilesRecursive ./base) ++
        (nixpkgs.lib.filesystem.listFilesRecursive ./modules)) ++ 
      [
        ./hardware/${hostname}.nix
        ./${hostname}.nix

        { networking.hostName = hostname; }
        { nixpkgs.hostPlatform = settings.architecture; }

        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
        { home-manager.users.klaymore.imports = [
          catppuccin.homeModules.catppuccin
          # nix-doom-emacs-unstraightened.homeModule
        ]; }
        catppuccin.nixosModules.catppuccin
        nvf.nixosModules.default
        nix-minecraft.nixosModules.minecraft-servers


        { nixpkgs.overlays = [
          nix-minecraft.overlay

          (final: prev: {
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
        # nixpkgs = "nixpkgs-pc";
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
