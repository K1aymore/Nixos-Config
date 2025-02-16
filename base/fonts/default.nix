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
    nasin-nanpa
    sitelen-seli-kiwen
    linja-sike
  ] ++ map (f: pkgs.callPackage f {}) [
    ./craftyPE.nix
    ./fairfax.nix
    #./linja-pona.nix
  ];

}