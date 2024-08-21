{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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


  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-stable, home-manager, impermanence,
              catppuccin, nix-std, flake-programs-sqlite, stylix, chaotic, nixos-cosmic, ... }@attrs:
  let
    sharedConfig = hostname: inSettings@{ ... }:
    let
      # sets the default settings, which will be overwritten by any custom parameters
      systemSettings = {
        architecture = "x86_64-linux";
        hdr = false;
        scaling = "1";
      } // inSettings;
      
    in
    nixpkgs.lib.nixosSystem {
      system = systemSettings.architecture;
      specialArgs = attrs // { inherit systemSettings; };

      modules = [
        ./base
        ./${hostname}.nix
        ./hardware/${hostname}.nix
        
        { networking.hostName = hostname;
          nixpkgs.hostPlatform = systemSettings.architecture; }
        
        
        
        home-manager.nixosModules.home-manager
        impermanence.nixosModule

        { home-manager.users.klaymore.imports = [
          impermanence.nixosModules.home-manager.impermanence
          catppuccin.homeManagerModules.catppuccin
        ]; }
        
        catppuccin.nixosModules.catppuccin


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
  {
    nixosConfigurations = {

      oldlaptop = sharedConfig "oldlaptop" {};

      laptop = sharedConfig "laptop" {};

      pc = sharedConfig "pc" {
        hdr = true;
        scaling = "1.75";
      };

      server = sharedConfig "server" {};
      
      pimusic = sharedConfig "pimusic" {
        architecture = "aarch64-linux";
      };

    };
  };

}
