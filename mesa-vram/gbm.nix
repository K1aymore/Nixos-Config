{ lib
, stdenv
, fetchFromGitLab
, libglvnd
, bison
, flex
, meson
, pkg-config
, ninja
, python3Packages
, libdrm
,
}:

let
  common = import ./common.nix { inherit lib fetchFromGitLab; };
in
stdenv.mkDerivation rec {
  pname = "mesa-libgbm";

  # We don't use the versions from common.nix, because libgbm is a world rebuild,
  # so the updates need to happen separately on staging.
  version = "26.3.0";

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "pixelcluster";
    repo = "mesa";
    rev = "777966a7cd402248a06603691ec89eb3bf3bade8";
    hash = "sha256-fyYGgCgnreBRgUc9ZEkEaT0NogeGGOWVzzfEK+rCRok=";
  };

  mesonAutoFeatures = "disabled";

  mesonFlags = [
    "--sysconfdir=/etc"

    (lib.mesonEnable "gbm" true)
    (lib.mesonOption "gbm-backends-path" "${libglvnd.driverLink}/lib/gbm")

    (lib.mesonEnable "egl" false)
    (lib.mesonEnable "glx" false)
    (lib.mesonEnable "zlib" false)

    (lib.mesonOption "platforms" "")
    (lib.mesonOption "gallium-drivers" "")
    (lib.mesonOption "vulkan-drivers" "")
    (lib.mesonOption "vulkan-layers" "")
  ];

  strictDeps = true;

  propagatedBuildInputs = [ libdrm ];

  nativeBuildInputs = [
    bison
    flex
    meson
    pkg-config
    ninja
    python3Packages.packaging
    python3Packages.python
    python3Packages.mako
    python3Packages.pyyaml
  ];

  inherit (common) meta;
}
