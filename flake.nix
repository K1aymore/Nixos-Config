{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?rev=2631b0b7abcea6e640ce31cd78ea58910d31e650";
  
    nixpkgs-staging.url = "github:NixOS/nixpkgs/nixos-unstable-small";  # ?rev=493dfd5c25fefa57fe87d50aaa0341a47c673546
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    catppuccin.url = "github:catppuccin/nix";
    
    flake-programs-sqlite.url = "github:wamserma/flake-programs-sqlite";
    flake-programs-sqlite.inputs.nixpkgs.follows = "nixpkgs";
    

    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    sitelen-pona-UCSUR = {
      url = "github:K1aymore/nix-utils?dir=sitelen-pona-UCSUR";
    };

    macroboard = {
      url = "github:newAM/macroboard";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = { self, nixpkgs, nixpkgs-staging, nixpkgs-stable, home-manager, lix, lix-module, impermanence, catppuccin, flake-programs-sqlite, macroboard, nix-minecraft, ... }@attrs:
  let
    publicIP = "71.231.122.199";
    serverLan = "172.16.0.115";
    sharedConfig = hostname: inSettings@{ ... }:
    let
      # sets the default settings, which will be overwritten by any custom parameters
      systemSettings = {
        architecture = "x86_64-linux";
        hdr = false;
        scaling = "1";
        nixpkgs = "unstable";
        yggdrasilPeers = [];
        publicIP = publicIP;
        serverLan = serverLan;
      } // inSettings;

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

      modules = rec {
        system = systemSettings.architecture;
        specialArgs = attrs // { inherit systemSettings ports; };

        modules = [
          ./base
          ./${hostname}.nix
          ./hardware/${hostname}.nix
          
          { networking.hostName = hostname; }
          
          { nixpkgs.hostPlatform = systemSettings.architecture;
            nixpkgs.config.pkgs = if systemSettings.nixpkgs == "staging"
              then import nixpkgs-staging { inherit system; }
              else import nixpkgs { inherit system; }; }
          
          home-manager.nixosModules.home-manager
          impermanence.nixosModule

          { home-manager.users.klaymore.imports = [
            impermanence.nixosModules.home-manager.impermanence
            catppuccin.homeModules.catppuccin
          ]; }

          #lix-module.nixosModules.default # better but needs to compile each time
          catppuccin.nixosModules.catppuccin
          flake-programs-sqlite.nixosModules.programs-sqlite

          macroboard.nixosModules.default
          nix-minecraft.nixosModules.minecraft-servers

          { nixpkgs.overlays = [
            macroboard.overlays.default
            nix-minecraft.overlay
            
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

      pc = sharedConfig "pc" {
        hdr = true;
        scaling = "1.75";
        #nixpkgs = "staging";
        # yggdrasilPeers = [
        #   "tcp://${serverLan}:${toString yggdrasilPort}"
        # ];
      };

      server = sharedConfig "server" {
        # yggdrasilPeers = [
        #   "tls://44.234.134.124:443"
        #   "tcp://nerdvm.mywire.org:65535"
        # ];
      };

      laptop = sharedConfig "laptop" {
        #yggdrasilPeers = [ "tcp://${publicIP}:${toString yggdrasilPort}" ];
      };

    };
  };

}
