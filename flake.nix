{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-parsec.url = "github:NixOS/nixpkgs?rev=ce5e4a6ef2e59d89a971bc434ca8ca222b9c7f5e";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";


    pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";

    rustdesk-nightly = {
      url = "github:rustdesk/rustdesk/1.2.2";
      flake = false;
    };

  };


  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-stable, nixpkgs-parsec, home-manager, impermanence, pipewire-screenaudio, rustdesk-nightly }@attrs:
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

      overlay-parsec = final: prev: {
        pkgs-parsec = import nixpkgs-parsec {
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
          ({ config, lib, pkgs, system, ... }: { nixpkgs.overlays = [ overlay-unstable overlay-stable overlay-parsec ]; })
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
