{inputs, ...}: {
  perSystem = {
    system,
    pkgs,
    ...
  }: {
    devShells = {
      go = pkgs.mkShell {
        packages = with pkgs; [
          go
          gopls
          gotools
          gofumpt
          gotools
          golines
          golangci-lint
          golangci-lint-langserver
          delve
        ];
      };
      poetry1 = pkgs.mkShell {
        packages = [
          pkgs.uv
          (import inputs.nixpkgs-24-11 {inherit system;}).poetry
        ];
      };
      poetry2 = pkgs.mkShell {
        packages = with pkgs; [
          uv
          poetry
        ];
      };
    };
  };
}
