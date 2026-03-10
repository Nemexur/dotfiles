{
  myVars,
  username ? myVars.username,
  ...
}: {
  users.users."${username}" = {
    home = "/Users/${username}";
  };
}
