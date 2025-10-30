{ ... }:

{

  config = {
    home-manager.users.klaymore.programs = {

      # kitty: bugs with zellij + neovim after expanding window
      # konsole: slow with nvim in zellij
      # work fine: alacritty, foot, st
      # nvim: rmpc album art pixelated

      # ctrl move and backspace by word: Alacritty, Kitty
      # ctrl backspace only one letter: konsole, st, foot

      # Alacritty re-renders during resizing, kinda jerky
      # Foot only rerenders during pause while resizing
      # st re-renders while resizing
      # st is only for X11

      # konsole fonts kinda blurry
      # kitty fonts crisp
      # fonts crunchy on 90% scale: alacritty, foot (unless dpi-aware)
      # wezterm fonts crisp, but blurry on 90%

      # ligature support: kitty, wezterm
      # no ligs: alacritty, konsole, foot

      # MPV tct squished on alacritty, foot, slightly kitty.
      # mpv tct good on Konsole
      # line height issue? squished (horizontally) terminals have bigger line height
      # Konsole: screen tearing and stuttering
      # Kitty: bad stuttering
      # Alacritty: slight stuttering but better
      # foot: stuttering

      # for hebrew / hindi they all suck ngl
      # bidirectional support: kitty, wezsterm kinda
      # no bidir: alacritty, foot, st, konsole, nvim
      # Wezterm: butchers Hindi, gnarled but displayed Hebrew
      # Foot: Hindi backwards, 
      # Alacritty great font display but not RTL

      # with fish_ambiguous_width 2: foot perfect, kitty small
      # fullwidth sitelen pona: wezterm, xterm (with tty_pona), nvim
      # doesn't work with fullwidth sitelen pona: kitty, alacritty, foot, konsole
      # alacritty & foot: renders full-width anyway, crushing them together
      # kitty: renders small unless followed by space, okay

      # supports ctrl+shift+u: foot, kitty (not with kanata?)
      # no +u unicode: alacritty, wezterm, xfce, konsole, st


      kitty = {
        enable = true;
        settings = {
          font_family = "Fira Code";
          #symbol_map = "U+F1900-U+F19FF Fairfax Hax HD";

          font_size = 10.0; # breaks bottoms of "g"s if less than 10?
          "modify_font cell_height" = "100%";

          show_hyperlink_targets = "yes";
          underline_hyperlinks = "always";

          enable_audio_bell = false;

          enabled_layouts = "tall,horizontal";

          #hide_window_decorations = "yes";
          window_border_width = 1;
          active_border_color = "#585b70";
          inactive_border_color = "#585b70";
          bell_border_color = "#585b70";
          #window_margin_width = "3";
          window_padding_width = 4;
          inactive_text_alpha = 0.8;

          #cursor_trail = 3; # strange in rmpc
          #cursor_trail_decay = "0.07 0.3";

          tab_bar_min_tabs = 2;
          #tab_bar_margin_height = "0.0 10.0";
          tab_bar_edge = "top";
          tab_bar_style = "powerline";
          tab_powerline_style = "slanted";
          #tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
        };
      };

      alacritty = {
        enable = true;
        settings = {
          font = {
            normal = { family = "Fira Code"; style = "Regular"; };
            size = 10;
            offset.y = 0;
          };
        };
      };

      foot = {
        enable = true;
        server.enable = true;
        settings = {
          main = {
            font = "Fira Code:size=10";
            #dpi-aware = "yes"; # too big on laptop
          };
          mouse = {
            #hide-when-typing = "yes";
          };
        };
      };

      wezterm = {
        enable = true;
        extraConfig = ''
          local wezterm = require 'wezterm'
          return {
            font = wezterm.font_with_fallback { "Fira Code", "Fairfax Hax HD", },
            font_size = 10.0,
            cell_widths = {
              { first = 0xF1900, last = 0xF19FF, width = 2 },
            },
            enable_wayland = false,

            color_scheme = "Catppuccin Mocha",
            hide_tab_bar_if_only_one_tab = true,
          }
        '';
      };


      neovide = {
        enable = true;
        settings = {
          font = {
            normal = [ "Fira Code" "Fairfax Hax HD" ];
            size = 10;
          };
          tabs = false;
        };
      };

    };

  };
}
