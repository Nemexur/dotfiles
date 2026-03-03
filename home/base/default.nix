{
  lib,
  config,
  pkgs,
  ...
}: let
  scriptsDir = ./scripts;
  binScripts =
    builtins.listToAttrs
    (map
      (name: {
        name = ".local/bin/${name}";
        value = {
          source = lib.path.append scriptsDir "${name}";
          executable = true;
        };
      })
      (builtins.attrNames (builtins.readDir scriptsDir)));
in {
  imports = [
    ./browser
    ./terminal.nix
    ./starship.nix
    ./zsh.nix
    ./tmux.nix
    ./neovim
    ./nh.nix
    ./zoxide.nix
    ./zsh.nix
    ./fzf.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    # Tools
    eza
    bat
    gopass
    manix
    tealdeer
    trash-cli
    fd
    (ripgrep.override {withPCRE2 = true;})

    # K8s
    kubectl
    kubectx

    # Compression
    zip
    xz
    zstd
    unzipNLS
    p7zip

    # File Transfers
    rsync
    croc

    # GUI Apps
    obsidian
    dbeaver-bin
    telegram-desktop
    sioyek
    winbox4
  ];

  home.sessionPath = ["$HOME/.local/bin"];
  home.file = binScripts;
}
