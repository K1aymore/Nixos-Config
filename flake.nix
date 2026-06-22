{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; #"github:NixOS/nixpkgs?rev=2631b0b7abcea6e640ce31cd78ea58910d31e650";
    # nixpkgs-pc.url = "github:K900/nixpkgs/plasma-6.6";
    nixpkgs-superstable.url = "github:NixOS/nixpkgs/nixos-24.11";
    # nixpkgs-kavita.url = "github:nevivurn/nixpkgs/update/kavita";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";
    catppuccin.url = "github:catppuccin/nix";

    # nvf = {
    #   url = "github:NotAShelf/nvf/v0.8";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    # jovian-nixos.url = "github:Jovian-Experiments/Jovian-NixOS";

    # sitelen-pona-UCSUR = {
    #   url = "github:K1aymore/nix-utils?dir=sitelen-pona-UCSUR";
    # };
  };

  outputs = { self, nixpkgs, nixpkgs-superstable, home-manager, impermanence, catppuccin, nix-minecraft, ... }@attrs:
  let
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
      kavita = 6999;

      wgBen = 6970;

      wgEllMCJava = 25565;
      wgEllMCBedrock = 19132;
      
      openttd1 = 3978;
      openttd2 = 3979;

      ssh = 6900;
      syncthingTransfer = 22000;
      syncthingRelay = 22067;
      ipfsAPI = 5001;
      ipfsGateway = 8081;
      ipfs = 59271;
    };

    makeSystem = hostname: settings: 
      (if settings ? "nixpkgs"
      then attrs.${settings.nixpkgs}.lib.nixosSystem
      else nixpkgs.lib.nixosSystem)
    {
      system = settings.architecture;
      specialArgs = { inherit ports; };

      modules = builtins.filter (f: nixpkgs.lib.hasSuffix ".nix" f) (
        (nixpkgs.lib.filesystem.listFilesRecursive ./base) ++
        (nixpkgs.lib.filesystem.listFilesRecursive ./modules)) ++ 
      [
        ./hardware/${hostname}.nix
        ./${hostname}.nix

        # https://www.reddit.com/r/NixOS/comments/1u47cnb/nixos_2605_can_be_used_with_gccarch_x8664v3/
        ( if settings ? "gccArch"
          then { nixpkgs.localSystem = {
            gcc.arch = settings.gccArch; # g++ -march=native -Q --help=target | grep march= | head -n1 | cut -f3-
            gcc.tune = settings.gccArch;
            system = settings.architecture;
            # x64_v3 Fixes
            nixpkgs.overlays = [
              (final: prev: {
                # https://github.com/assimp/assimp/issues/6342
                assimp = prev.assimp.overrideAttrs (old: {
                  NIX_CFLAGS_COMPILE =
                    (old.NIX_CFLAGS_COMPILE or "") + " -ffp-contract=on";
                });

                # https://github.com/godotengine/godot/issues/91217
                # https://github.com/godotengine/godot/pull/95158
                embree = prev.embree.overrideAttrs (old: {
                  cmakeFlags = (old.cmakeFlags or []) ++ [
                    "-DEMBREE_ISA_SSE2=OFF"
                    "-DEMBREE_ISA_SSE42=OFF"
                  ];
                });

                # https://lists.xenproject.org/archives/html/xen-devel/2025-01/msg00439.html
                xen = prev.xen.overrideAttrs (old: {
                  patches = (old.patches or []) ++ [
                    (prev.writeText "xen-text-alignment.patch" ''
                      --- a/xen/arch/x86/boot/Makefile
                      +++ b/xen/arch/x86/boot/Makefile
                      @@ -44,2 +44,2 @@
                      -text_gap := 0x010200
                      -text_diff := 0x408020
                      +text_gap := 0x010240
                      +text_diff := 0x608040
                    '')
                  ];
                });
              })
            ];
          }; }
          else { nixpkgs.hostPlatform = settings.architecture; } )
        { nix.settings.max-jobs = 3; # https://nix.dev/manual/nix/2.28/command-ref/conf-file#conf-max-substitution-jobs
          nix.settings.cores = 0; } # set to host core count automaticallty
        { networking.hostName = hostname; }

        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
        { home-manager.users.klaymore.imports = [
          catppuccin.homeModules.catppuccin
        ]; }
        catppuccin.nixosModules.catppuccin
        # nvf.nixosModules.default
        nix-minecraft.nixosModules.minecraft-servers
        # jovian-nixos.nixosModules.default

        { nixpkgs.overlays = [
          nix-minecraft.overlay
          # jovian-nixos.overlays.default

          (final: prev: {
            superstable = import nixpkgs-superstable {
              system = settings.architecture;
              config.allowUnfree = true;
            };
          })
        ];}

      ];
    };

  in
  {
    nixosConfigurations = {
      pc = makeSystem "pc" {
        architecture = "x86_64-linux";
        # nixpkgs = "nixpkgs-pc";
        # gccArch = "znver2";
      };

      server = makeSystem "server" {
        architecture = "x86_64-linux";
      };

      laptop = makeSystem "laptop" {
        architecture = "x86_64-linux";
      };
    };
  };
}
