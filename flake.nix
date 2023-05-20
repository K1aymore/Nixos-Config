{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nixvim.url = "github:pta2002/nixvim";
  };


  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, impermanence, nixvim }@attrs:
    let
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
          ./${hostname}.nix
          ./hardware/${hostname}/configuration.nix
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-stable ]; })
        ];
      };

    in
    {
      nixosConfigurations = {

        acer = sharedConfig "acer";

        pc = sharedConfig "pc";

        server = sharedConfig "server";

      };
    };

}
