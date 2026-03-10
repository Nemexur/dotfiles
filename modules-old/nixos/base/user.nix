{
  myVars,
  username ? myVars.username,
  userfullname ? myVars.userfullname,
  ...
}: {
  users.groups = {
    "${username}" = {};
    docker = {};
    podman = {};
  };

  users.users."${username}" = {
    home = "/home/${username}";
    description = userfullname;
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
