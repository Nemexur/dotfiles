{
  lib,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./browser
    ./fzf.nix
    ./git.nix
    ./neovim
    ./nh.nix
    ./starship.nix
    ./tealdeer.nix
    ./terminal.nix
    ./tmux.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  xdg.enable = true;

  home = {
    packages = with pkgs-unstable; [
      # Tools
      eza
      bat
      gopass
      manix
      trash-cli
      fd
      yazi
      (lib.hiPrio parallel)
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

      # Misc
      ani-cli

      # GUI Apps
      obsidian
      dbeaver-bin
      telegram-desktop
      sioyek
      winbox4
    ];
    sessionPath = ["$HOME/.local/bin"];
    file = let
      binScripts = scriptsDir:
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
    in
      binScripts ./scripts;
  };
}
