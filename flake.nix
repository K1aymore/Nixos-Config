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

    
    flake-programs-sqlite.url = "github:wamserma/flake-programs-sqlite";
    flake-programs-sqlite.inputs.nixpkgs.follows = "nixpkgs";
    
    stylix.url = "github:danth/stylix";
    
    nix-std.url = "github:chessai/nix-std";
  };


  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-stable, home-manager, impermanence,
              flake-programs-sqlite, stylix, nix-std }@attrs:
    let
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };

      overlay-stable = final: prev: {
        stable = import nixpkgs-stable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };


      sharedConfig = hostname: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./base
          ./${hostname}.nix
          ./hardware/${hostname}.nix
          { nixpkgs.overlays = [ overlay-unstable overlay-stable ]; }
          
          home-manager.nixosModules.home-manager
          impermanence.nixosModule
          { home-manager.users.klaymore.imports = [ impermanence.nixosModules.home-manager.impermanence ]; }
          
          flake-programs-sqlite.nixosModules.programs-sqlite
          #stylix.nixosModules.stylix
        ];
      };

    in
    {
      nixosConfigurations = {

        oldlaptop = sharedConfig "oldlaptop";

        laptop = sharedConfig "laptop";

        pc = sharedConfig "pc";

        server = sharedConfig "server";

      };
    };

}
