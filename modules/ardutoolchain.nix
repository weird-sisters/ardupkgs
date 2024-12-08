{
  pkgs,
  lib,
  config,
  withSystem,
  system,
  options,
  ...
}:
with lib;
let
  cfg = config.ardutoolchain;
in
{
  options.ardutoolchain = {

    name = mkOption {
      type = types.str;
      default = "sitl";
      description = ''
        Name of the toolchain.
      '';
    };

  };

  config = {

    ardutoolchain = {

      env = [
        {
          name = "CONAN_HOME";
          value = "$PRJ_ROOT/.conan2";
        }
        {
          name = "NIXPKGS_ALLOW_UNFREE";
          value = 1;
        }
      ];
    };
  };
}