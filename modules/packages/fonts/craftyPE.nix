{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "crafty-pe";
  version = "beta-18";

  src = fetchFromGitHub {
    owner = "The-Haunted-Coop";
    repo = "CraftyPE";
    rev = "9cf1883878aab10f1d4f25839a6e779f6100fd3a";
    hash = "sha256-VzqjD3V/cxfX2SxG0qYc4qFfqGiTMoBZnc13fw50F3Q=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/truetype fonts/ttf/CraftyPE-VF.ttf
    install -Dm644 -t $out/share/fonts/truetype fonts/ttf/static/*.ttf

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/The-Haunted-Coop/CraftyPE";
    description = "Font based on Minecraft font, with sitelen pona UCSUR support";
    longDescription = '' '';
    license = licenses.ofl;
    maintainers = [ ];
    platforms = platforms.all;
  };
})