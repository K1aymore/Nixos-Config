{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "fairfax";
  version = "2024";

  src = fetchFromGitHub {
    owner = "kreativekorp";
    repo = "open-relay";
    rev = "401a64595b4c36794ed05e1cbc04b92b7e1afc9f";
    hash = "sha256-gXQVvXHDqNU0RCs9dmIvgDSODLTn1vtcByqixMWvXRA=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/truetype FairfaxHD/*.ttf
    install -Dm644 -t $out/share/fonts/truetype Fairfax/*.ttf

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://www.kreativekorp.com/software/fonts/fairfaxhd/";
    description = "Monospace font with UCSUR support and programming ligatures";
    longDescription = '' '';
    license = licenses.ofl;
    maintainers = [ ];
    platforms = platforms.all;
  };
})