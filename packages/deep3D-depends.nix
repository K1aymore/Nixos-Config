{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    python310Full
    python310Packages.tqdm
    python310Packages.numpy
    python310Packages.opencv4
    python310Packages.torchvision
  ];


}
