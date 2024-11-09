{ lib, stdenv, fetchFromGitHub, meson, pkg-config, vulkan-loader, ninja, writeText, vulkan-headers, vulkan-utility-libraries, jq, libX11, libXrandr, libxcb, wayland, wayland-scanner }:

stdenv.mkDerivation rec {
  pname = "vulkan-hdr-layer";
  version = "e173f26";

  src = (fetchFromGitHub {
    owner = "Zamundaaa";
    repo = "VK_hdr_layer";
    rev = "e173f2617262664901039e3c821929afce05d2c1";
    fetchSubmodules = true;
    hash = "sha256-hBxRwbn29zFeHcRpfMF6I4piSASpN2AvZY0ci5Utj4U=";
  }).overrideAttrs (_: {
    GIT_CONFIG_COUNT = 1;
    GIT_CONFIG_KEY_0 = "url.https://github.com/.insteadOf";
    GIT_CONFIG_VALUE_0 = "git@github.com:";
  });

  nativeBuildInputs = [ vulkan-headers meson ninja pkg-config jq ];

  buildInputs = [ vulkan-headers vulkan-loader vulkan-utility-libraries libX11 libXrandr libxcb wayland wayland-scanner ];

  # Help vulkan-loader find the validation layers
  setupHook = writeText "setup-hook" ''
    addToSearchPath XDG_DATA_DIRS @out@/share
  '';

  meta = with lib; {
    description = "Layers providing Vulkan HDR";
    homepage = "https://github.com/Zamundaaa/VK_hdr_layer";
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
