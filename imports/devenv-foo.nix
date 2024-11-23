{pkgs, ...}: {
  packages = with pkgs; [
    example1
    example2
    mavproxy
  ];

  languages = {
    python = {
      enable = true;
    };
  };

  pre-commit = {
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
