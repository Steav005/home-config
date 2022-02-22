{ pkgs, config, ... }:
let theme = config.theme-non_hex;
in {
  services.sxhkd.keybindings = { "super + l" = "betterlockscreen -l"; };

  systemd.user.services.wallpaper = {
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Type = "oneshot";
      ExecStart = toString (pkgs.writeShellScript "set-wallpaper.sh" ''
        export PATH=$PATH:${pkgs.feh}/bin 
        ${config.programs.fish.shellAliases.load-background}
      '');
      IOSchedulingClass = "idle";
    };
  };

  xdg.configFile."betterlockscreenrc".text = ''
    font="${config.gtk.font.name}"
    loginbox=${theme.nord0}66
    loginshadow=00000000
    ringcolor=${theme.nord6}ff
    insidecolor=00000000
    separatorcolor=00000000
    ringvercolor=${theme.nord6}ff
    insidevercolor=00000000
    ringwrongcolor=${theme.nord6}ff
    insidewrongcolor=${theme.nord11}ff
    timecolor=${theme.nord6}ff
    time_format="%H:%M:%S"
    greetercolor=${theme.nord6}ff
    layoutcolor=${theme.nord6}ff
    keyhlcolor=${theme.nord11}ff
    bshlcolor=${theme.nord11}ff
    verifcolor=${theme.nord6}ff
    wrongcolor=${theme.nord11}ff
    modifcolor=${theme.nord11}ff
    bgcolor=${theme.nord6}ff
  '';

}
