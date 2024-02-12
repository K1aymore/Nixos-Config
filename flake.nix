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

    nix-std.url = "github:chessai/nix-std";
    
    flake-programs-sqlite.url = "github:wamserma/flake-programs-sqlite";
    flake-programs-sqlite.inputs.nixpkgs.follows = "nixpkgs";
    
    
    stylix.url = "github:danth/stylix";

    kde2nix.url = "github:nix-community/kde2nix";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    
    VK_hdr_layer.url = "/synced/other/VK_hdr_layer";
  };


  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-stable, home-manager, impermanence,
              nix-std, flake-programs-sqlite, stylix, kde2nix, chaotic, VK_hdr_layer }@attrs:
    let
      
      sharedConfig = hostname: nsystem: nixpkgs.lib.nixosSystem {
        system = nsystem;
        specialArgs = attrs;
        modules = [
          ./base
          ./${hostname}.nix
          ./hardware/${hostname}.nix
          
          { networking.hostName = hostname; }
          
          
          home-manager.nixosModules.home-manager
          impermanence.nixosModule
          { home-manager.users.klaymore.imports = [ impermanence.nixosModules.home-manager.impermanence ]; }
          
          flake-programs-sqlite.nixosModules.programs-sqlite
          #stylix.nixosModules.stylix
          kde2nix.nixosModules.plasma6
          chaotic.nixosModules.default
          
          
          { nixpkgs.overlays = [
            (final: prev: {
              unstable = import nixpkgs-unstable {
                system = nsystem;
                config.allowUnfree = true;
              };
            })
            
            (final: prev: {
              stable = import nixpkgs-stable {
                system = nsystem;
                config.allowUnfree = true;
              };
            })
          ];}
          
          
        ];
      };

    in
    {
      nixosConfigurations = {

        oldlaptop = sharedConfig "oldlaptop" "x86_64-linux";

        laptop = sharedConfig "laptop" "x86_64-linux";

        pc = sharedConfig "pc" "x86_64-linux";

        server = sharedConfig "server" "x86_64-linux";
        
        pimusic = sharedConfig "pimusic" "aarch64-linux";

      };
    };

}
