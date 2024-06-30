{
  programs.alacritty = {
    enable = true;
    settings = {
      
      font = {
        normal = { family = "JetbrainsMono Nerd Font"; style = "Regular"; };
        italic = { family = "JetbrainsMono Nerd Font"; style = "Italic"; };
        bold = { family = "JetbrainsMono Nerd Font"; style = "Bold"; };
      };

      keyboard = { 
        bindings = [
          { key = "+";          mods = "Super | Alt"; action = "IncreaseFontSize"; }
          { key = "´";          mods = "Super | Alt"; action = "DecreaseFontSize"; }
          { key = "º";          mods = "Super | Alt"; action = "ResetFontSize"; }
          { key = "ArrowUp";    mods = "Super | Alt"; action = "SearchBackward"; }
          { key = "ArrowDown";  mods = "Super | Alt"; action = "SearchForward"; }
          { key = "ArrowRight";  action = "SearchFocusPrevious"; mode = "Search"; }
          { key = "ArrowLeft"; action = "SearchFocusNext"; mode = "Search"; }
          { key = "Return"; action = "SearchConfirm"; mode = "Search"; }
        ];
      };

      window = {
        decorations = "None";
        padding = { x = 0; y = 0; };
        opacity = 0.9;
      };

      colors = {
        
        selection = { background = "0x777777"; text = "CellForeground"; };
        footer_bar = { foreground = "0x151515"; background = "0xE1E1E1"; };
        
        primary = {
          background =  "0x151515";
          foreground =  "0xE1E1E1";
        };

        normal = {
          black =    "0x777777";
          red =      "0xB46958";
          green =    "0x90A959";
          yellow =   "0xF4BF75";
          blue =     "0x88AFA2";
          magenta =  "0xAA759F";
          cyan =     "0x88AFA2";
          white =    "0xE1E1E1";
        };
      };
    };
  };
}
