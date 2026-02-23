{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Core Tools
    zsh
    fastfetch
    neovim
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

    # TODO: Move
    # archives
    # zip
    # xz
    # zstd
    # unzipNLS
    # p7zip

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

    # Text Processing
    sad
    jq
    yq-go
    jc

    # TODO: Move
    # Interactively filter its input using fuzzy searching, not limit to filenames.
    # fzf
    # # search for files by name, faster than find
    # fd
    # findutils
    # # search for files by its content, replacement of grep
    # (ripgrep.override { withPCRE2 = true; })

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

    # TODO: Move to home manager
    # file transfer
    # rsync
    # croc # File transfer between computers securely and easily
    #
    # # misc
    # file
    # tealdeer # a very fast version of tldr
  ];
}
