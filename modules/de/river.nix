{ config, lib, pkgs, ... }:

{
  config = let 
    ashrwm = (
      { stdenv
      , lib
      , fetchFromGitHub
      , callPackage
      , cmake
      , pkg-config
      , libGL
      , vulkan-loader
      , libXrandr
      , libXinerama
      , libXcursor
      , libX11
      , libXi
      , libXext
      , darwin
      , fixDarwinDylibNames
      , wayland
      , wayland-scanner
      , wayland-protocols
      , libxkbcommon
      , libdecor
      , zig
      }:
      stdenv.mkDerivation (finalAttrs: {
        pname = "ashrwm";
        version = "0.3.0";

        src = fetchFromGitHub {
          owner = "shadowash8";
          repo = "ashrwm";
          rev = "${finalAttrs.version}";
          hash = "sha256-Ec9hp1SxtvXZkTn+DkM4FYYk9u7r0RS6LOBmBNrLKgU=";
        };

        propagatedBuildInputs = [ wayland-scanner ];

        nativeBuildInputs = [ zig wayland-scanner ];

        buildInputs = [
          wayland
          wayland-protocols
          wayland-scanner
          libxkbcommon
          libX11
          libXrandr
          libXinerama
          libXcursor
          libXi
          libXext
        ];

        # dontSetZigDefaultFlags = true;
        # zigBuildFlags = [
        #   "--system"
        #   "${finalAttrs.deps}"
        #   "-Dcpu=baseline"
        #   "-Doptimize=ReleaseFast"
        # ];

        env.VERSION = finalAttrs.version;


        meta = with lib; {
          description = "Window manager for River";
          homepage = "https://github.com/shadowash8/ashrwm";
          license = licenses.mit;
          platforms = platforms.unix;
        };
      }
    ));

  in lib.mkIf config.klaymore.gui.enable {

    environment.systemPackages = [
      # (pkgs.callPackage ashrwm {})
    ];

  };
}