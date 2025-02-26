{ pkgs, ... }:

{

  nixpkgs.config = {
    joypixels.acceptLicense = true;
  };

  fonts.packages = with pkgs; [
    #nerdfonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
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

    linja-pi-pu-lukin
    nasin-nanpa # The only one that properly handles words inside each other. kinda hard to read
    sitelen-seli-kiwen
    linja-sike
  ] ++ map (f: pkgs.callPackage f {}) [
    ./craftyPE.nix
    ./fairfax.nix
    #./linja-pona.nix
  ];

  # https://stackoverflow.com/questions/53658303/fetchfromgithub-filter-down-and-use-as-environment-etc-file-source
  home-manager.users.klaymore.home.file.".local/share/fonts/nasin-nanpa-4.0.2-Helvetica.otf".source = pkgs.fetchFromGitHub {
    owner = "ETBCOR";
    repo = "nasin-nanpa";
    rev = "3e533578fd591395f424e09626e7eaa2577914f3";
    hash = "sha256-BgWt3+vIMvKx4Jrk+Z6GUZPUxYhAdkK9aWCl1/0rneo=";
  } + "/versions/nasin-nanpa-4.0.2-Helvetica.otf";

}