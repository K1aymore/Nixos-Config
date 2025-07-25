{ config, lib, pkgs, ... }:

let
  package = (
{ stdenv
, lib
, fetchFromGitHub
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
, withMinecraftPatch ? true
}:
let
  version = "3.4";
in
stdenv.mkDerivation {
  pname = "glfw${lib.optionalString withMinecraftPatch "-minecraft"}-hdr";
  inherit version;

  src = fetchFromGitHub rec {
    name = "source-${rev}";
    owner = "K1aymore";
    repo = "glfw";
    rev = "a012f455341687bba14bbf6f6477ba9c3e86d762";
    hash = "sha256-61ZtibAME41O+0ScJl7qfAZ31nTjrQYbIAgB0W0CTTU=";
  };

  # Fix linkage issues on X11 (https://github.com/NixOS/nixpkgs/issues/142583)
  patches = [
    ./x11.patch
  ] ++ lib.optionals withMinecraftPatch [
    ./0009-Defer-setting-cursor-position-until-the-cursor-is-lo.patch
  ];

  propagatedBuildInputs = lib.optionals (!stdenv.hostPlatform.isWindows) [ libGL ];

  nativeBuildInputs = [ cmake pkg-config ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [ fixDarwinDylibNames ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [ wayland-scanner ];

  buildInputs =
    lib.optionals stdenv.hostPlatform.isDarwin (with darwin.apple_sdk.frameworks; [ Carbon Cocoa Kernel ])
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      wayland
      wayland-protocols
      libxkbcommon
      libX11
      libXrandr
      libXinerama
      libXcursor
      libXi
      libXext
    ];

  cmakeFlags = [
    "-DBUILD_SHARED_LIBS=ON"
  ] ++ lib.optionals (!stdenv.hostPlatform.isDarwin && !stdenv.hostPlatform.isWindows) [
    "-DCMAKE_C_FLAGS=-D_GLFW_GLX_LIBRARY='\"${lib.getLib libGL}/lib/libGL.so.1\"'"
    "-DCMAKE_C_FLAGS=-D_GLFW_EGL_LIBRARY='\"${lib.getLib libGL}/lib/libEGL.so.1\"'"
    "-DCMAKE_C_FLAGS=-D_GLFW_VULKAN_LIBRARY='\"${lib.getLib vulkan-loader}/lib/libvulkan.so.1\"'"
  ];

  postPatch = lib.optionalString stdenv.hostPlatform.isLinux ''
    substituteInPlace src/wl_init.c \
      --replace-fail "libxkbcommon.so.0" "${lib.getLib libxkbcommon}/lib/libxkbcommon.so.0" \
      --replace-fail "libdecor-0.so.0" "${lib.getLib libdecor}/lib/libdecor-0.so.0" \
      --replace-fail "libwayland-client.so.0" "${lib.getLib wayland}/lib/libwayland-client.so.0" \
      --replace-fail "libwayland-cursor.so.0" "${lib.getLib wayland}/lib/libwayland-cursor.so.0" \
      --replace-fail "libwayland-egl.so.1" "${lib.getLib wayland}/lib/libwayland-egl.so.1"
  '';

  # glfw may dlopen libwayland-client.so:
  postFixup = lib.optionalString stdenv.hostPlatform.isLinux ''
    patchelf ''${!outputLib}/lib/libglfw.so --add-rpath ${lib.getLib wayland}/lib
  '';

  meta = with lib; {
    description = "Multi-platform library for creating OpenGL contexts and managing input, including keyboard, mouse, joystick and time";
    homepage = "https://www.glfw.org/";
    license = licenses.zlib;
    maintainers = with maintainers; [ marcweber Scrumplex twey ];
    platforms = platforms.unix ++ platforms.windows;
  };
});

in
{

  config = lib.mkIf config.klaymore.gui.hdr {
    environment.systemPackages = [ 
      (pkgs.callPackage package {})
    ];
  };
}