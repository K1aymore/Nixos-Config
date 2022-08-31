{ config, pkgs, ... }:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in {

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: with pkgs; {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };


  environment.systemPackages = with pkgs; [
    git
    gh

    jdk
    #jdk8
    clang
    gcc
    ghc
    sbcl  # Lisp compiler
    nasm  # assembly
    gnumake

    /* geany
    bluefish */

    # eclipses.eclipse-java
    jetbrains.idea-community
    vscodium-fhs
    arduino

    qtcreator
    libsForQt5.full
    cmake
    gdb
  ];


  programs = {
    java = {
      enable = true;
      package = pkgs.jdk;
    };
  };

}
