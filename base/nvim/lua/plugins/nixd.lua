local flake = '(builtins.getFlake "/synced/Nix/cfg").'
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "nix" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {
          settings = {
            nixd = {
              options = {
                nixos = { expr = flake .. "nixosConfigurations.jump1n.options" },
                home_manager = { expr = flake .. 'homeConfigurations."cinnamon@jump1n".options' },
              },
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
      },
    },
  },
}
