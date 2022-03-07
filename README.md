
In your configuration.nix you basically just import pc.nix, or laptop.nix, or server.nix
whichever setup you want.

First get rid of all the Syncthing stuff though, I don't want you trying to
sync stuff with my computers lol.

You should probably comment out the impermanence imports as well,
unless you have it set up for impermanence.
