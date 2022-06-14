{ pkgs, config, lib, machine, ... }:
let
  host = machine.host;
  theme = config.theme;
in {
  services.sxhkd.keybindings = { "super + Return" = "alacritty"; };

  programs.alacritty = {
    enable = true;
    package = with pkgs; if machine.nixos then unstable.alacritty else hello;
    settings = {
      window = {
        padding = {
          x = 5;
          y = 5;
        };
        opacity = 0.9;
      };
      font.size = if host == "neesama" then 11 else 8;
      shell.program = "${pkgs.fish}/bin/fish";
      colors = {
        transparent_background_colors = true;
        # TODO https://gist.github.com/AlphaTechnolog/d1d5f6557f77f71519cb5713268da7dd
        # Monokai

        #primary = {
        #  background = theme.nord0;
        #  foreground = theme.nord4;
        #  dim_foreground = "#a5abb6";
        #};
        #cursor = {
        #  text = theme.nord0;
        #  cursor = theme.nord4;
        #};
        #vi_mode_cursor = {
        #  text = theme.nord0;
        #  cursor = theme.nord4;
        #};
        #selection = {
        #  text = "CellForeground";
        #  background = theme.nord3;
        #};
        #search = {
        #  matches = {
        #    foreground = "CellBackground";
        #    background = theme.nord8;
        #  };
        #  bar = {
        #    background = theme.nord2;
        #    foreground = theme.nord4;
        #  };
        #};
        #normal = {
        #  black = theme.nord1;
        #  red = theme.nord11;
        #  green = theme.nord14;
        #  yellow = theme.nord13;
        #  blue = theme.nord9;
        #  magenta = theme.nord15;
        #  cyan = theme.nord8;
        #  white = "#e5e9f0";
        #};
        #bright = {
        black = theme.nord3;
        red = theme.nord11;
        green = theme.nord14;
        yellow = theme.nord13;
        blue = theme.nord9;
        magenta = theme.nord15;
        cyan = theme.nord7;
        white = theme.nord6;
        #};
        #dim = {
        #  black = "#373e4d";
        #  red = "#94545d";
        #  green = "#809575";
        #  yellow = "#b29e75";
        #  blue = "#68809a";
        #  magenta = "#8c738c";
        #  cyan = "#6d96a5";
        #  white = "#aeb3bb";
        #};
      };
    };
  };
}
