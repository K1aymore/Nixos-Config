{ config, lib, ...}:

{

#   config = {

#     programs.nvf = {
#       enable = true;
#       settings.vim = {
#         viAlias = true;
#         vimAlias = true;
#         theme = {
#           enable = true;
#           name = "catppuccin";
#           style = "mocha";
#         };
#         git.enable = true;
#         lsp = {
#           enable = true;
#           inlayHints.enable = true;
#         };
#         languages = {
#           enableTreesitter = false; # default false
#           nix.enable = true;
#           rust.enable = true;
#           clang.enable = true;
#           #csharp.enable = true;
#           bash.enable = true;
#           markdown.enable = true;
#           html.enable = true;
#           css.enable = true;
#           ts.enable = true;
#           yaml.enable = true;
#         };
#         clipboard = {
#           enable = true;
#           providers.wl-copy.enable = true;
#         };

#         telescope.enable = true;
#         mini.pick.enable = true;
#         fzf-lua.enable = true;
#         autocomplete.nvim-cmp.enable = true;
      
#         filetree.neo-tree.enable = true;
#         filetree.neo-tree.setupOpts.auto_clean_after_session_restore = true;
#         # filetree.nvimTree.enable = true; # opens automatically

#         tabline.nvimBufferline.enable = true;

#         visuals = {
#           indent-blankline.enable = true;
#           rainbow-delimiters.enable = true;
#         };

#         keymaps = [
#           {
#             key = "<C-BS>";
#             mode = [ "n" "v" ];
#             action = "ldb";
#             desc = "Delete previous word";
#             silent = false;
#           }
#           {
#             key = "<C-BS>";
#             mode = [ "i" ];
#             action = "<ESC>ldbi";
#             desc = "Delete previous word";
#             silent = false;
#           }

#           { # ctrl+s for save
#             key = "<C-s>";
#             mode = [ "n" "v" ];
#             action = ":w<Enter>";
#             desc = "Save file";
#             silent = false;
#           }
#           {
#             key = "<C-s>";
#             mode = [ "i" ];
#             action = "<ESC>:w<Enter>a";
#             desc = "Save file";
#             silent = false;
#           }

#           {
#             key = "<C-c>";
#             mode = [ "n" "v" ];
#             action = ''"+y'';
#             desc = "Copy to clipboard";
#             silent = false;
#           }
#           {
#             key = "<C-v>";
#             mode = [ "i" ];
#             action = ''<ESC>"+pa'';
#             desc = "Paste from clipboard";
#             silent = false;
#           }
#           {
#             key = "<C-v>";
#             mode = [ "n" "v" ];
#             action = ''"+p'';
#             desc = "Paste from clipboard";
#             silent = false;
#           }

#           #{
#           #  key = "<C-S-U>";
#           #  mode = [ "i" ];
#           #  action = "<C-S-v>U";
#           #  desc = "Insert Unicode character";
#           #  silent = false;
#           #}
#         ];

#         options = {
#           number = true;
#           relativenumber = true;
#           tabstop = 2;
#           shiftwidth = 2;
#           softtabstop = 2;

#           guifont = "${config.klaymore.font.monospace},Fira Code,nasin-nanpa:h${toString config.klaymore.font.size}";
#         };
        
        
#         luaConfigPost = ''
#           vim.cmd [[
#             autocmd VimEnter * if getcwd() == '/home/klaymore' | cd ${config.klaymore.configPath} | endif
#           ]]
#           vim.api.nvim_create_autocmd("VimEnter", {
#             pattern = "*",
#             group = vim.api.nvim_create_augroup("NeotreeOnOpen", { clear = true }),
#             once = true,
#             callback = function(_)
#               if vim.fn.argc() == 0 then
#                 vim.cmd("Neotree")
#               end
#             end,
#           })
#           vim.api.nvim_create_autocmd("TabNew", {
#             group = vim.api.nvim_create_augroup("NeotreeOnNewTab", { clear = true }),
#             command = "Neotree",
#           })

#           --vim.opt.clipboard=unnamedplus



#           -- sitelen pona correct width
#           vim.fn.setcellwidths({ {0xF1900, 0xF19FF, 2}, })

#           -- Neovide settings
#           --vim.g.neovide_fullscreen = true
#           vim.g.neovide_cursor_trail_size = 0.4
#           vim.g.neovide_cursor_animation_length = 0.08
#           vim.g.neovide_cursor_short_animation_length = 0
#           vim.g.neovide_scroll_animation_length = 0.13
#           vim.g.neovide_input_ime = true
#           vim.g.neovide_cursor_hack = false
#         '';
#       };
#     };

  # };
}