{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-vscodium.url = "github:NixOS/nixpkgs?rev=963006aab35e3e8ebbf6052b6bf4ea712fdd3c28";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nixvim.url = "github:pta2002/nixvim";
  };


  outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-vscodium, home-manager, impermanence, nixvim }@attrs:
    let
      overlay-stable = final: prev: {
        stable = import nixpkgs-stable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };

      overlay-vscodium = final: prev: {
        unstableVSCodium = import nixpkgs-vscodium {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };

      sharedConfig = hostname: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./${hostname}.nix
          ./hardware/${hostname}/configuration.nix
          ({ config, lib, pkgs, system, ... }: { nixpkgs.overlays = [ overlay-stable overlay-vscodium ]; })
        ];
      };

    in
    {
      nixosConfigurations = {

        acer = sharedConfig "acer";

        laptop = sharedConfig "laptop";

        pc = sharedConfig "pc";

        server = sharedConfig "server";

      };
    };

}
