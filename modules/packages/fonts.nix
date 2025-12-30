{ config, pkgs, ... }:

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
  
  sevenish-sp = ({ lib, stdenvNoCC, fetchFromGitHub, }:
    stdenvNoCC.mkDerivation (finalAttrs: {
      pname = "sevenish-sp";
      version = "2025-02";
      src = fetchFromGitHub {
        owner = "SauceDLX";
        repo = "Sevenish";
        rev = "ccc4bfdb5ad6af467485c02d505067994f0041a4";
        hash = "sha256-jKnjoWP++HqBU0bGUVT6xLRIYDEYNSR8OeqCIwt6Zro=";
      };
      installPhase = ''
        install -Dm644 -t $out/share/fonts/truetype SevenishSP.ttf
      '';
      meta = with lib; {
        homepage = "https://github.com/SauceDLX/Sevenish";
        description = "Pixel font, max height of ~7, ASCII SP ligatures";
        longDescription = '' '';
        license = licenses.mit;
        maintainers = [ ];
        platforms = platforms.all;
      };
    }));

  linja-waso = ({ lib, stdenvNoCC, fetchFromGitHub, }:
    stdenvNoCC.mkDerivation (finalAttrs: {
      pname = "linja-waso";
      version = "v0.5.2";
      src = fetchFromGitHub {
        owner = "ItMarki";
        repo = "linja-waso";
        rev = "91771e119db5a87a030ec14721a8bed077b8ce37";
        hash = "sha256-1Z9A098OYGcNujhs00tOKWBDreZBpfZHrMh0rZtwPM8=";
      };
      installPhase = ''
        install -Dm644 -t $out/share/fonts/truetype fonts/linja-waso-lili.ttf
      '';
      meta = with lib; {
        homepage = "https://github.com/ItMarki/linja-waso";
        description = "Based on the LxgwWenKai Chinese font";
        longDescription = '' '';
        license = licenses.ofl;
        maintainers = [ ];
        platforms = platforms.all;
      };
    }));

  linja-insa = ({ lib, stdenvNoCC, fetchFromGitHub, }:
    stdenvNoCC.mkDerivation (finalAttrs: {
      pname = "linja-insa";
      version = "2024-08";
      src = fetchFromGitHub {
        owner = "tomo-pi-linja-yupekosi";
        repo = "linja-insa";
        rev = "c1838f3d5c6eb79cf6513f1bd22e654e62de6b54";
        hash = "sha256-SKHuzU3p7yWSybDCdyOQBBiVT72qMNYDWMU9UBe09cE=";
      };
      installPhase = ''
        install -Dm644 -t $out/share/fonts/truetype TTF/linjainsa-linjameso.ttf
      '';
      meta = with lib; {
        homepage = "https://github.com/tomo-pi-linja-yupekosi/linja-insa/";
        description = "sans-serif monospace with ucsur ascii and cartouches";
        longDescription = '' '';
        license = licenses.mit;
        maintainers = [ ];
        platforms = platforms.all;
      };
    }));

    linja-lipamanka = ({ lib, stdenvNoCC, fetchFromGitHub, }:
    stdenvNoCC.mkDerivation (finalAttrs: {
      pname = "linja-lipamanka";
      version = "";
      src = builtins.fetchurl { 
        url = "https://lipamanka.gay/linjalipamanka-normal.otf";
        sha256 = "sha256-ZuKxVZKfxePZAjlInTZX9cZ8AXV8O7X6RGDSq+o3s1s=";
      };
      installPhase = ''
        install -Dm644 -t $out/share/fonts/opentype linjalipamanka-normal.otf
      '';
      meta = with lib; {
        homepage = "https://lipamanka.gay/linjamanka";
        description = "";
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

    #fonts.enableDefaultPackages = true;
    fonts.packages = map (f: pkgs.callPackage f {}) [
      #craftyPE
      fairfax
      #linja-insa
      #sevenish-sp
      #linja-waso
      #linja-pona
      #linja-lipamanka
    ] ++
    (with pkgs; [
      #nerdfonts
      #nerd-fonts.symbols-only  # collides with 󱥠󱥔
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      #noto-fonts-monochrome-emoji
      #noto-fonts-emoji-blob-bin
      #unicode-emoji
      #twitter-color-emoji
      #emojione
      #openmoji-color
      #joypixels
      #whatsapp-emoji-font
      #twemoji-color-font
      #liberation_ttf
      unifont

      #fira
      #fira-mono
      fira-code
      fira-code-symbols
      hack-font
      #iosevka
      #scientifica

      #font-awesome
      #font-awesome_4
      #terminus_font

      #comic-mono
      #monocraft

      # The only one that properly handles words inside each other.
      # Too bold for vscode
      nasin-nanpa-ucsur
      nasin-nanpa-helvetica

      sitelen-seli-kiwen
      #linja-pi-pu-lukin
      #linja-sike
    ]);

    fonts.fontconfig = {
      subpixel.rgba = "rgb";
      useEmbeddedBitmaps = true; # fix Firefox emoji
      defaultFonts = {
        serif     = [ config.klaymore.font.serif "Noto Serif" "nasin-nanpa" ];
        sansSerif = [ config.klaymore.font.sans  "Noto Sans" "nasin-nanpa" ];
        monospace = [ config.klaymore.font.monospace "Fira Code" "nasin-nanpa" ];
      };
    };

    # https://stackoverflow.com/questions/53658303/fetchfromgithub-filter-down-and-use-as-environment-etc-file-source
    # home-manager.users.klaymore.home.file.".local/share/fonts/nasin-nanpa-5.0.0-beta.3.otf".source = pkgs.fetchFromGitHub {
    #   owner = "ETBCOR";
    #   repo = "nasin-nanpa";
    #   rev = "803e6b32f30aa99c6e779267921e3f0fd57c9f63";
    #   hash = "sha256-5fPzJyx1PryqZLeU0EOKxtLOFP0jJ1GYS+7ffDEZoCQ=";
    # } + "/versions/nasin-nanpa-5.0.0-beta.3.otf";


    nixpkgs.overlays = [
      (final: prev: {
        nasin-nanpa-ucsur = prev.nasin-nanpa-ucsur.overrideAttrs (old: rec {
          version = "5.0.0-beta.3";
          src = pkgs.fetchurl {
            url = "https://github.com/ETBCOR/nasin-nanpa/releases/download/n${version}/nasin-nanpa-${version}-UCSUR.otf";
            hash = "sha256-vmPOTWkRelPLQtATjlSGbMEhfnkrJvuT0Ip/hi5BiGg=";
          };
        });
        nasin-nanpa-helvetica = prev.nasin-nanpa-helvetica.overrideAttrs (old: rec {
          version = "5.0.0-beta.3";
          src = pkgs.fetchurl {
            url = "https://github.com/ETBCOR/nasin-nanpa/releases/download/n${version}/nasin-nanpa-${version}-Helvetica.otf";
            hash = "sha256-NlfLBzfHoHRmF4/OsadcSAS/lXu/SMDZJNm8F0yFDyM=";
          };
        });
      })
    ];


  };
}
