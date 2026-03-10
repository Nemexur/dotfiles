{
  flake.modules.nixos.xdg = {
    lib,
    config,
    pkgs,
    ...
  }: {
    options.xdgSettings = {
      terminalDesktop = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Terminal Exec Applications";
      };
    };

    config = let
      cfg = config.xdgSettings;
    in {
      xdg.terminal-exec = {
        enable = true;
        package = pkgs.xdg-terminal-exec;
        settings = {
          default = cfg.terminalDesktop;
          niri = cfg.terminalDesktop;
        };
      };

      xdg = {
        autostart.enable = lib.mkDefault true;
        menus.enable = lib.mkDefault true;
        mime.enable = lib.mkDefault true;
        icons.enable = lib.mkDefault true;
      };

      xdg.portal = {
        enable = true;
        config.common.default = ["gtk" "kde"];
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          kdePackages.xdg-desktop-portal-kde
        ];
      };
    };
  };

  flake.modules.homeManager.xdg = {
    lib,
    config,
    ...
  }: {
    options.homeXDGSettings = {
      browser = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Browser Apps for Mime";
      };
      editor = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Editor Apps for Mime";
      };
      imageViewer = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Image Viewer Apps for Mime";
      };
      pdfViewer = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "PDF Viewer Apps for Mime";
      };
      video = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Video Apps for Mime";
      };
      inode = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "INode Apps for Mime";
      };
    };

    config = let
      cfg = config.homeXDGSettings;
    in {
      xdg.enable = true;

      xdg.configFile."mimeapps.list".force = true;

      # manage $XDG_CONFIG_HOME/mimeapps.list
      # xdg search all desktop entries from $XDG_DATA_DIRS, check it by command:
      #    echo $XDG_DATA_DIRS
      # the system-level desktop entries can be list by command:
      #    ls -l /run/current-system/sw/share/applications/
      # the user-level desktop entries can be list by command(user ryan):
      #    ls /etc/profiles/per-user/nemexur/share/applications/
      xdg.mimeApps = {
        enable = true;
        # let `xdg-open` to open the url with the correct application.
        defaultApplications = {
          "application/json" = cfg.browser;
          "application/pdf" = cfg.pdfViewer;

          "text/html" = cfg.browser;
          "text/xml" = cfg.browser;
          "text/plain" = cfg.editor;
          "application/xml" = cfg.browser;
          "application/xhtml+xml" = cfg.browser;
          "application/xhtml_xml" = cfg.browser;
          "application/rdf+xml" = cfg.browser;
          "application/rss+xml" = cfg.browser;
          "application/x-extension-htm" = cfg.browser;
          "application/x-extension-html" = cfg.browser;
          "application/x-extension-shtml" = cfg.browser;
          "application/x-extension-xht" = cfg.browser;
          "application/x-extension-xhtml" = cfg.browser;
          "application/x-wine-extension-ini" = cfg.editor;

          # define default applications for some url schemes.
          "x-scheme-handler/about" = cfg.browser; # open `about:` url with `browser`
          "x-scheme-handler/ftp" = cfg.browser; # open `ftp:` url with `browser`
          "x-scheme-handler/http" = cfg.browser;
          "x-scheme-handler/https" = cfg.browser;
          "x-scheme-handler/zoommtg" = ["Zoom.desktop"];

          "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];

          "audio/*" = cfg.video;
          "video/*" = cfg.video;
          "image/*" = cfg.imageViewer;
          "image/gif" = cfg.imageViewer;
          "image/jpg" = cfg.imageViewer;
          "image/jpeg" = cfg.imageViewer;
          "image/png" = cfg.imageViewer;
          "image/webp" = cfg.imageViewer;

          "inode/directory" = cfg.inode;
        };

        associations.removed = {};
      };
    };
  };
}
