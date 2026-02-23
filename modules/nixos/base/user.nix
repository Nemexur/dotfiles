{
  myVars,
  username ? myVars.username,
  userFullName ? myVars.userFullName,
  ...
}: {
  users.groups = {
    "${username}" = {};
    docker = {};
    podman = {};
  };

  users.users."${username}" = {
    home = "/home/${username}";
    description = userFullName;
    isNormalUser = true;
    extraGroups = [
      username
      "users"
      "wheel"
      "networkmanager"
      "podman"
      "docker"
      "libvirtd"
    ];
  };
}
