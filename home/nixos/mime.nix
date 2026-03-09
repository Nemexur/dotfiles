{
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
    defaultApplications = let
      browser = [
        "zen-beta.desktop"
        "firefox.desktop"
        "google-chrome.desktop"
      ];
      editor = [
        "nvim.desktop"
      ];
      imageViewer = [
        "gwenview.desktop"
      ];
    in {
      "application/json" = browser;
      "application/pdf" = ["sioyek.desktop"];

      "text/html" = browser;
      "text/xml" = browser;
      "text/plain" = editor;
      "application/xml" = browser;
      "application/xhtml+xml" = browser;
      "application/xhtml_xml" = browser;
      "application/rdf+xml" = browser;
      "application/rss+xml" = browser;
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xht" = browser;
      "application/x-extension-xhtml" = browser;
      "application/x-wine-extension-ini" = editor;

      # define default applications for some url schemes.
      "x-scheme-handler/about" = browser; # open `about:` url with `browser`
      "x-scheme-handler/ftp" = browser; # open `ftp:` url with `browser`
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/zoommtg" = ["Zoom.desktop"];

      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];

      "audio/*" = ["mpv.desktop"];
      "video/*" = ["mpv.desktop"];
      "image/*" = imageViewer;
      "image/gif" = imageViewer;
      "image/jpg" = imageViewer;
      "image/jpeg" = imageViewer;
      "image/png" = imageViewer;
      "image/webp" = imageViewer;

      "inode/directory" = ["yazi.desktop"];
    };

    associations.removed = {};
  };
}
