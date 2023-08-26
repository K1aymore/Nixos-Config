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


    pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";

  };


  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-stable, home-manager, impermanence, pipewire-screenaudio }@attrs:
    let
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-stable {
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
          ./${hostname}.nix
          ./hardware/${hostname}/configuration.nix
          ({ config, lib, pkgs, system, ... }: { nixpkgs.overlays = [ overlay-unstable overlay-stable ]; })
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
