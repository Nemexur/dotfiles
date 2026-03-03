{
  # security with polkit
  security.polkit.enable = true;
  # security with gnome-kering
  services.gnome = {
    gnome-keyring.enable = true;
    # Use gnome keyring's SSH Agent
    # https://wiki.gnome.org/Projects/GnomeKeyring/Ssh
    gcr-ssh-agent.enable = false;
  };
  # seahorse is a GUI App for GNOME Keyring.
  programs.seahorse.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # fix for `sudo xxx` in kitty/wezterm/foot and other modern terminal emulators
  security.sudo.keepTerminfo = true;
}
