{
  programs.alacritty = {
    enable = true;
    settings = {

      font = {
        normal = {
          family = "JetbrainsMono Nerd Font";
          style = "Regular";
        };
        italic = {
          family = "JetbrainsMono Nerd Font";
          style = "Italic";
        };
        bold = {
          family = "JetbrainsMono Nerd Font";
          style = "Bold";
        };
      };

      keyboard = {
        bindings = [
          {
            key = "+";
            mods = "Super | Alt";
            action = "IncreaseFontSize";
          }
          {
            key = "´";
            mods = "Super | Alt";
            action = "DecreaseFontSize";
          }
          {
            key = "º";
            mods = "Super | Alt";
            action = "ResetFontSize";
          }
        ];
      };

      window = {
        decorations = "None";
        padding = {
          x = 0;
          y = 0;
        };
        opacity = 0.9;
      };


      colors = {
        selection = {
          background = "0x403A36";
          text = "0xECE1D7";
        };
        footer_bar = {
          foreground = "0x292522";
          background = "0xECE1D7";
        };

        primary = {
          background = "0x292522";
          foreground = "0xECE1D7";
        };

        normal = {
          black = "0x34302C";
          red = "0xBD8183";
          green = "0x78997A";
          yellow = "0xE49B5D";
          blue = "0x7F91B2";
          magenta = "0xB380B0";
          cyan = "0x7B9695";
          white = "0xC1A78E";
        };

        bright = {
          black = "0x867462";
          red = "0xD47766";
          green = "0x85B695";
          yellow = "0xEBC06D";
          blue = "0xA3A9CE";
          magenta = "0xCF9BC2";
          cyan = "0x89B3B6";
          white = "0xECE1D7";
        };
      };

    };
  };
}
