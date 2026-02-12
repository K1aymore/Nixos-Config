{ config, lib, pkgs, ...}:

{

 config = lib.mkIf config.klaymore.servers.kavita.enable {
  nixpkgs.overlays = with pkgs; [
    (final: prev: {
      kavita = stdenvNoCC.mkDerivation (finalAttrs: {
        pname = "kavita";
        version = "0.8.8.3-offset";

        src = fetchFromGitHub {
          owner = "K1aymore"; #"linkion";
          repo = "Kavita";
          rev = "7d8e5b8b728bd5e87781c82207cf5d8ab8a861c7"; # me odd lock 4c58023f1aad48843da162d2a04c97fee659fd5c # me no covers "339f9833da7669927f436835d8d6aaa7450b0eee"; # works jan 11 "a610a057c798b5bd5332aa29ed44f76015b4f20c"; # no jan 12 "53a7e690a1bc3b12d59020c857fc29dd8a0f4d15"; # no jan 13 "7c2be140c72fe49f17b4c25a729771ec791b16aa"; # jan 10 "dcd9bd50bfc249e2e07cb41fe2a8e7bca599be6c"; # Last of the year "6d1c7a4ff502b87329fb1f2fb11a5eb46c146547";
          hash = "sha256-QASE7Hg+WQgdWnmuxXJ1kKkLMhu88zCYaTVdrkeu0eM="; # me odd lock "sha256-7tdxL0Bt+pImaKwhsf6znMXifSWecklZ1U3oY9JWi6I="; # me no covers "sha256-rPq8GcjsMHorEmMp8XEZErN32RKLoS2DlqPw4pjvxow="; # linkion "sha256-ctnSq5d8FB6DCORTi7IPIMQu0xyamUiAAcYJZdjHQlM="; # jan 11 "sha256-cOICeUX9bmcgC2ZpcEroMPNmP5BJcD0Mbgl7P16FQg4="; # jan 10 "sha256-BcreJ4RFZHpd97O6eQAzFJEq2Iyv6XZvTdbILb8hx80="; # Last of the Year "sha256-lVe3bApwYzlLBhC36AHc4g1WO7Fc3aXAXkafqST07NQ="; # 8.9.1 "sha256-pQuHnhHlctWhh3ZV5Qvi8vBVegwO57GYpwLI3ZReWws=";
        };

        backend = buildDotnetModule {
          pname = "kavita-backend";
          inherit (finalAttrs) version src;

          patches = [
            # The webroot is hardcoded as ./wwwroot
            ./change-webroot.diff
            # NOTE: Upstream frequently removes old database migrations between versions.
            # Currently no migration patches are needed for upgrades from NixOS 24.11 (v0.8.3.2).
            # Future updates should check if migration restoration is needed for supported upgrade paths.
          ];
          postPatch = ''
            substituteInPlace API/Services/DirectoryService.cs --subst-var out

            substituteInPlace API/Startup.cs API/Services/LocalizationService.cs API/Controllers/FallbackController.cs \
              --subst-var-by webroot "${finalAttrs.frontend}/lib/node_modules/kavita-webui/dist/browser"
          '';

          executables = [ "API" ];

          projectFile = "API/API.csproj";
          nugetDeps = ./nuget-deps.json;
          dotnet-sdk = dotnetCorePackages.sdk_9_0;
          dotnet-runtime = dotnetCorePackages.aspnetcore_9_0;
        };

        frontend = buildNpmPackage rec {
          pname = "kavita-frontend";
          inherit (finalAttrs) version src;

          sourceRoot = "${src.name}/UI/Web";

          npmBuildScript = "prod";
          npmFlags = [ "--legacy-peer-deps" ];
          npmRebuildFlags = [ "--ignore-scripts" ]; # Prevent playwright from trying to install browsers
          npmDepsHash = "sha256-SqW9qeg0CKfVKYsDXmVsnVNmcH7YkaXtXpPjIqGL0i0="; # linkion "sha256-ofHlTfjC1S+12EkxlLw7baepUwfzzypfN+VTjv2LnRc="; # jan 11 "sha256-uVd2fq/1Ske/c1nvG32hvWVtaEgdQqWyc/K6bz6hFUg="; # jan 10 "sha256-uVd2fq/1Ske/c1nvG32hvWVtaEgdQqWyc/K6bz6hFUg="; # Last of the year "sha256-ofHlTfjC1S+12EkxlLw7baepUwfzzypfN+VTjv2LnRc="; # 8.9.1 "sha256-YCCls05i16EmNEEWVs58BIwjbmUnahlhuR23hkfyWks=";
        };

        dontBuild = true;

        installPhase = ''
          runHook preInstall

          mkdir -p $out/bin $out/lib/kavita
          ln -s $backend/lib/kavita-backend $out/lib/kavita/backend
          ln -s $frontend/lib/node_modules/kavita-webui/dist $out/lib/kavita/frontend
          ln -s $backend/bin/API $out/bin/kavita

          runHook postInstall
        '';

        passthru = {
          tests = {
            inherit (nixosTests) kavita;
          };
          # updateScript = ./update.sh;
        };

        meta = {
          description = "Fast, feature rich, cross platform reading server";
          homepage = "https://kavitareader.com";
          changelog = "https://github.com/kareadita/kavita/releases/tag/${finalAttrs.src.rev}";
          license = lib.licenses.gpl3Only;
          platforms = lib.platforms.linux;
          maintainers = with lib.maintainers; [
            misterio77
            nevivurn
          ];
          mainProgram = "kavita";
        };
      });
    })
  ];

 };
}