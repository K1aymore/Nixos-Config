{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-staging.url = "github:NixOS/nixpkgs/nixos-unstable-small";  # ?rev=493dfd5c25fefa57fe87d50aaa0341a47c673546
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    catppuccin.url = "github:catppuccin/nix";

    nix-std.url = "github:chessai/nix-std";
    
    flake-programs-sqlite.url = "github:wamserma/flake-programs-sqlite";
    flake-programs-sqlite.inputs.nixpkgs.follows = "nixpkgs";
    
    
    stylix.url = "github:danth/stylix";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, nixpkgs-staging, nixpkgs-unstable, nixpkgs-stable, home-manager, impermanence,
              catppuccin, nix-std, flake-programs-sqlite, stylix, chaotic, nixos-cosmic, lib, ... }@attrs:
  let
    sharedConfig = hostname: inSettings@{ ... }:
    let
      # sets the default settings, which will be overwritten by any custom parameters
      systemSettings = {
        architecture = "x86_64-linux";
        hdr = false;
        scaling = "1";
        nixpkgs = "unstable";
        yggdrasilPeers = [];
      } // inSettings;

      modules = rec {
        system = systemSettings.architecture;
        specialArgs = attrs // { inherit systemSettings; };

        modules = [
          ./base
          ./${hostname}.nix
          ./hardware/${hostname}.nix
          
          { networking.hostName = hostname;
            nixpkgs.hostPlatform = systemSettings.architecture; }
          
          { nixpkgs.config.pkgs = if systemSettings.nixpkgs == "staging"
            then import nixpkgs-staging { inherit system; }
            else import nixpkgs { inherit system; }; }
          
          home-manager.nixosModules.home-manager
          impermanence.nixosModule

          { home-manager.users.klaymore.imports = [
            impermanence.nixosModules.home-manager.impermanence
            catppuccin.homeManagerModules.catppuccin
          ]; }
          
          catppuccin.nixosModules.catppuccin

          {
            imports = lib.mkIf (systemSettings.yggdrasilPeers != []) [
              "./services/system/yggdrasil.nix"
            ];
          }

          flake-programs-sqlite.nixosModules.programs-sqlite
          #stylix.nixosModules.stylix
          chaotic.nixosModules.default
          nixos-cosmic.nixosModules.default

          { nixpkgs.overlays = [
            (final: prev: {
              unstable = import nixpkgs-unstable {
                system = systemSettings.architecture;
                config.allowUnfree = true;
              };
            })
            (final: prev: {
              stable = import nixpkgs-stable {
                system = systemSettings.architecture;
                config.allowUnfree = true;
              };
            })
          ];}
          
          
        ];
      };
      
    in
    if systemSettings.nixpkgs == "staging"
    then nixpkgs-staging.lib.nixosSystem modules
    else nixpkgs.lib.nixosSystem modules;

  in
  {
    nixosConfigurations = {

      oldlaptop = sharedConfig "oldlaptop" {};

      laptop = sharedConfig "laptop" {
        yggdrasilPeers = [ "tcp://klaymore.me:13121" ];
      };

      pc = sharedConfig "pc" {
        hdr = true;
        scaling = "1.75";
        #nixpkgs = "staging";
        yggdrasilPeers = [ "tcp://10.0.0.105:13121" ];
      };

      server = sharedConfig "server" {
        yggdrasilPeers = [
          "tls://44.234.134.124:443"
          "tcp://longseason.1200bps.xyz:13121"
        ];
      };
      
      pimusic = sharedConfig "pimusic" {
        architecture = "aarch64-linux";
      };

    };
  };

}
