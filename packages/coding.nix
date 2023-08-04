{ pkgs, home-manager, ... }:

{
  imports = [
    home-manager.nixosModule
  ];



  environment.systemPackages = with pkgs; [
    clang
    gcc
    ghc # Haskell compiler
    sbcl # Lisp compiler
    nasm # assembly compiler
    gnumake
    avalonia-ilspy # .NET exe decompiler
    lldb


    cargo
    rustc
    rustfmt
    wasm-pack # Rust WebAssembly
    rust-analyzer

    #android-studio
    #apksigner
    jdk11
    jdk17
    jdk8
    jdt-language-server

    #jetbrains.idea-community
    vscode-fhs
    #arduino

    /* qtcreator */
    /* libsForQt5.full */
    cmake
    gdb

    glibc_multi

    #neovide
    #neovim-qt
    #gnvim

    #lapce


  ];



  programs = {
    java = {
      enable = true;
      package = pkgs.jdk;
    };
  };

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };
  users.users.klaymore.extraGroups = [ "docker" ];

}
