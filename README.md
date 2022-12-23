**Usage**

In /etc/nixos/configuration.nix just import pc.nix, laptop.nix, or server.nix, whichever setup you want.

First you should get rid of all the Syncthing devices though, so you don't try to connect to my computers.

You should probably remove the impermanence imports as well, unless you have it set up for impermanence.
With impermanence on, persist/{hostname}/etc/nixos will be linked to /etc/nixos, so that way it can be tracked by Git as well.
