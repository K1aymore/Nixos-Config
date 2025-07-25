{ ... }:

{

  config = {
    home-manager.users.klaymore.programs = {

      # kitty: bugs with zellij + neovim after expanding window
      # konsole: slow with nvim in zellij
      # work fine: alacritty, foot, st

      # ctrl move and backspace by word: Alacritty, Kitty
      # ctrl backspace only one letter: konsole, st, foot

      # Alacritty re-renders during resizing, kinda jerky
      # Foot only rerenders during pause while resizing
      # st re-renders while resizing
      # st is only for X11
      # Alacritty feels slightly higher frame rate than foot

      # glitch when resizing cmatrix: konsole, alacritty, kitty, foot. st?
      # konsole fonts kinda blurry
      # kitty fonts crisp
      # fonts crunchy on 90% scale: alacritty, foot

      # ligature support: kitty
      # no ligs: alacritty, konsole, foot

      # MPV tct squished on alacritty, foot, slightly kitty.
      # mpv tct good on Konsole
      # line height issue? squished (horizontally) terminals have bigger line height
      # Konsole: screen tearing and stuttering
      # Kitty: bad stuttering
      # Alacritty: slight stuttering but better
      # foot: stuttering

      # bidirectional support: konsole, kitty
      # no bidir: alacritty, foot, st


      kitty = {
        enable = true;
        settings = {
          font_family = "Fira Code";
          symbol_map = "U+F1900-U+F19FF Fairfax Hax HD";
          narrow_symbols = "U+F1900-U+F19FF 1";
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

          tab_bar_min_tabs = 1;
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
        settings = {
          main = {
            font = "Fira Code:size=10";
          };
          mouse = {
            #hide-when-typing = "yes";
          };
        };
      };
    };
  };
}