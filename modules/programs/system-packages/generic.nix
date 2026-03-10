let
  genericPkg = {pkgs, ...}: {
    environment.systemPackages = with pkgs.unstable; [
      # Core Tools
      zsh
      neovim
      fastfetch
      gnumake
      just
      git
      git-lfs
      ansible
      tree
      openssl

      # System Monitoring
      procs
      btop

      # GNU Tools
      coreutils
      findutils
      binutils
      diffutils
      gnutls
      gnugrep
      gawk
      gnutar
      gnused
      time
      getopt
      which
      units
      bc

      # Text Processing
      sad
      jq
      yq-go
      jc

      # Disk Tools
      duf
      dust
      gdu
      ncdu

      # Networking Tools
      wget
      curl
      httpie
      mtr
      gping
      dnsutils
      doggo
      aria2
      nmap
      ipcalc
      iperf3
      hyperfine
      tcpdump
    ];
  };
in {
  flake.modules.nixos.systemPackages = genericPkg;
  flake.modules.darwin.systemPackages = genericPkg;
}
