{
  flake.modules.homeManager.k8s = {pkgs, ...}: {
    home.packages = with pkgs.unstable; [
      k9s
      kubectl
      kubectx
      kustomize
      helm
    ];
  };
}
