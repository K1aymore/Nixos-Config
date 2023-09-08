{ pkgs, rustdesk-nightly, ... }:


{


  /*nixpkgs.overlays = [
    (self: super: {
      rustdesk = super.rustdesk.overrideAttrs (o: {
        version = "nightly";
        src = rustdesk-nightly;
      });
    })
  ];*/


  environment.systemPackages = with pkgs; [
    rustdesk
  ];


}
