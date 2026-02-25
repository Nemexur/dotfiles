{pkgs, ...}: {
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # virtualisation
  programs.virt-manager.enable = true;
  virtualisation = {
    podman.enable = true;
    docker.enable = true;
    libvirtd.enable = true;
  };

  # dconf
  programs.dconf.enable = true;

  # bluetooth
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true; # bluetooth percentage
  };

  # audio
  security.rtkit.enable = true;
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # # services
  # services = {
  #   xserver.enable = false; # disable xorg server
  #   greetd = {
  #     enable = true;
  #     settings = {
  #       default_session = {
  #         user = myVars.username;
  #         command = "$HOME/.wayland-session";
  #       };
  #     };
  #   };
  #   sysprof.enable = true;
  #   printing.enable = false;
  #   flatpak.enable = true;
  # };
}
