let
  luffy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1sDaqbpFRDEKPa3CtsAacX3mS1KetWNcFcbVWx22RY";
  work-macbook = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAni+NMuxXDRq0NVEQ/1NGN13SvXY6lhSudCsjf1Z9buD7ca3vT676UwgehVJzlqWN+j2cfizGXE9BVyl/xFnv7x7XFtz91PzPLTizUBRzJYAeuYBT9ff11PfOIEh/2FwZJYXrO74SmgM7OZv8YJTHl6sR3Rj1H/hrfcHvR7oyiBvwIAvsT+M4fhW4E8twPtXd1c6RjjMf3hg7gD2p3WiW4V22nw8S/JEsC4ZIj0HxMdO7+B8LGIUpunxrNjqUJkJMafrpUe3q1gUXHyiB7YLFKc5F4JEszCIv0LXQpVt2XDmzJTh96ZHIlvPxOsXbSI5NewVnz05PGHOKgHKAbRQR3nb7ENE39PaahJqYHw9E5MBVPAkPX41OHYCHtIo3YavAC/tj1HZheY2wGN+kJ5unQwLschaiA1VU3l1dYFyrfw5qbqj2ieGNXJVnuh3SNWL5U15NuPdI1v3ttsiN4XdGUnbzAazSEfEDObbbKCHBhQm+XKj6qYZun1f+ZRpc0Es=";

  nemexur-luffy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyoUEBWkbcHc16+TCeeQvBzR6V6QZ3ETZ5Z/L48XSxK";
in {
  "home-envs.age".publicKeys = [nemexur-luffy luffy work-macbook];
  "work-envs.age".publicKeys = [work-macbook];
}
