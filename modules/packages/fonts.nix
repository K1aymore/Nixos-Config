{ pkgs, ... }:

let 
  craftyPE = ({ lib, stdenvNoCC, fetchFromGitHub, }:
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
    }));

  fairfax = ({ lib, stdenvNoCC, fetchFromGitHub, }:
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
    }));
  
  linja-pona = ({ lib, stdenvNoCC, fetchFromGitHub, }:
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
    }));

in
{

  config = {
    nixpkgs.config = {
      joypixels.acceptLicense = true;
    };

    fonts.packages = map (f: pkgs.callPackage f {}) [
      #craftyPE
      fairfax
      #linja-pona
    ] ++
    (with pkgs; [
      #nerdfonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
      noto-fonts-emoji-blob-bin
      unicode-emoji
      twitter-color-emoji
      #emojione
      openmoji-color
      joypixels
      #whatsapp-emoji-font
      twemoji-color-font
      liberation_ttf
      
      fira
      fira-mono
      fira-code
      fira-code-symbols
      hack-font
      iosevka
      scientifica

      #font-awesome
      font-awesome_4
      terminus_font

      comic-mono
      monocraft

      # remove so it defaults to Fairfax
      # linja-pi-pu-lukin
      # nasin-nanpa # The only one that properly handles words inside each other. kinda hard to read
      # sitelen-seli-kiwen
      # linja-sike
    ]);

    # for Discord
    # https://stackoverflow.com/questions/53658303/fetchfromgithub-filter-down-and-use-as-environment-etc-file-source
    home-manager.users.klaymore.home.file.".local/share/fonts/nasin-nanpa-4.0.2-Helvetica.otf".source = pkgs.fetchFromGitHub {
      owner = "ETBCOR";
      repo = "nasin-nanpa";
      rev = "3e533578fd591395f424e09626e7eaa2577914f3";
      hash = "sha256-BgWt3+vIMvKx4Jrk+Z6GUZPUxYhAdkK9aWCl1/0rneo=";
    } + "/versions/nasin-nanpa-4.0.2-Helvetica.otf";

  };
}