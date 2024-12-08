{
  lib,
  config,
  ...
}:
with lib;
{
  options = {
    name = mkOption {
      internal = true;
      type = types.nullOr types.str;
      default = null;
    };
  };

  config.ardutoolchain =
    {
    }
    // (lib.optionalAttrs (config.name != null) { name = config.name; });
}