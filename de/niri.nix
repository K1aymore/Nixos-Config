{ pkgs, ... }:

{

	imports = [
		./x11.nix
		./wayland.nix
		./pipewire.nix
	];

	environment.systemPackages = with pkgs; [
		niri
		fuzzel
		alacritty
	];


}
