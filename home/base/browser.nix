{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    languagePacks = ["en-US"];

    suppressXdgMigrationWarning = true;

    profiles.default.settings = {
      "zen.workspaces.continue-where-left-off" = true;
      "zen.workspaces.natural-scroll" = true;
      "zen.view.compact.hide-tabbar" = true;
      "zen.view.compact.hide-toolbar" = true;
      "zen.view.compact.animate-sidebar" = false;
      "zen.welcome-screen.seen" = true;
      "zen.urlbar.behavior" = "float";
    };
  };

  programs.google-chrome = {
    enable = true;
    package =
      if pkgs.stdenv.isAarch64
      then pkgs.chromium
      else pkgs.google-chrome;
    extensions = [
      # Dark Reader
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";}
    ];
  };
}
