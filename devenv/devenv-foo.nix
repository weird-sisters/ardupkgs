{pkgs, ...}: {
  packages = with pkgs; [
    mavproxy
  ];

  languages = {
  };

  scripts = {
    show.exec = ''
      pushd $DEVENV_ROOT
      nix flake show .# --impure "$@"
    '';

    check.exec = ''
      pushd $DEVENV_ROOT
      export NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1
      nix flake check .# --impure "$@"
    '';

    build.exec = ''
      pushd $DEVENV_ROOT
      nix build .# "$@"
    '';
  };

  git-hooks = {
    hooks = {
      shellcheck.enable = true;
      alejandra.enable = true;
      shfmt.enable = false;
      deadnix = {
        enable = true;
        settings = {
          edit = true;
          noLambdaArg = true;
        };
      };
    };
  };
}
