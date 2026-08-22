{ lib
, stdenv
, fetchFromGitLab
,
}:

let
  common = import ./common.nix { inherit lib fetchFromGitLab; };
  headers = [
    "include/GL/internal/dri_interface.h"
    "include/EGL/eglext_angle.h"
    "include/EGL/eglmesaext.h"
  ];
in
stdenv.mkDerivation rec {
  pname = "mesa-gl-headers";

  # These are a bigger rebuild and don't change often, so keep them separate.
  version = "26.3.0";

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "pixelcluster";
    repo = "mesa";
    rev = "777966a7cd402248a06603691ec89eb3bf3bade8";
    hash = "sha256-fyYGgCgnreBRgUc9ZEkEaT0NogeGGOWVzzfEK+rCRok=";
  };

  dontBuild = true;

  installPhase = ''
    for header in ${toString headers}; do
      install -Dm444 $header $out/$header
    done
  '';

  passthru = { inherit headers; };

  inherit (common) meta;
}
