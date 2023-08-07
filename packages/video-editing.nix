{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    davinci-resolve
    #cinelerra
    #olive-editor
    #shotcut
    #flowblade
  ];


}
