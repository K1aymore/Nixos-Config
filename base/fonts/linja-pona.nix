{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "linja-pona";
  version = "4.9";

  src = fetchFromGitHub {
    owner = "janSame";
    repo = "linja-pona";
    rev = "8436d31ba84bb9c7198f7df2ec07d5b8b56ffdf7";
    hash = "sha256-jKAZVzsBeICnZcsIZUC3JKahefH9kWr9Paio4P/nRxM=";
  };

  installPhase = ''
    install -Dm644 -t $out/share/fonts/opentype linja-pona-4.9.otf
  '';

  meta = with lib; {
    homepage = "https://github.com/janSame/linja-pona";
    description = "sitelen Lasina -> sitelen pona OpenType font";
    longDescription = '' '';
    license = licenses.ofl;
    maintainers = [ ];
    platforms = platforms.all;
  };
})