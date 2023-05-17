{
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nixvim.url = "github:pta2002/nixvim";
  };


  outputs = { self, nixpkgs, home-manager, impermanence, nixvim }@attrs: {

    nixosConfigurations.acer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./acer.nix
        ./persist/acer/etc/nixos/configuration.nix
      ];
    };

    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./pc.nix
        ./hardware/pc/configuration.nix
      ];
    };

  };
}
