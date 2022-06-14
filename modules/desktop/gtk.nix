{ pkgs, lib, config, machine, ... }:
let host = machine.host;
in {
  home.packages = with pkgs; [ bibata-cursors ];

  # TODO symlink .nix-profile/share/icons:themes folder to .local/share/icons:themes
  #home.file.".local/share/icons".source =
  #    config.lib.file.mkOutOfStoreSymlink "${config.home.profileDirectory}/share/icons";
  home.file.".local/share/themes".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.profileDirectory}/share/themes";
  home.file.".icons/icons".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.profileDirectory}/share/icons";
  home.file.".themes".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.profileDirectory}/share/themes";

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      #package = pkgs.nordic;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    # Font in org gnome desktop interface
    font = {
      name = "Roboto";
      size = 11;
      package = pkgs.roboto;
    };
    gtk3 = {
      bookmarks =
        [ "ssh://autumnal@clz.autumnal.de/media/torrent_storage Index (SSH)" ]
        ++ lib.optionals (host == "neesama")
        [ "file:///net/index Index (NFS)" ];
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 1;
        gtk-enable-input-feedback-sounds = 1;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
      };
    };
  };

  qt = {
    enable = true;
    # Use same theme as GTK applications
    platformTheme = "gtk";
    style.package = pkgs.adwaita-qt;
    style.name = "adwaita-dark";
  };

  home.pointerCursor = {
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 12;
  };
}
