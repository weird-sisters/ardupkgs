{ inputs, ... }:
{
  imports = [ inputs.devenv.flakeModule ];

  perSystem =
    { pkgs, ... }:
    {
      devenv.shells.default = {
        devenv.root =
          let
            devenvRootFileContent = builtins.readFile inputs.devenv-root.outPath;
          in
          pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;

        name = "default";

        imports = [ ./devenv-mavproxy.nix ];

        packages = [ ];
      };
    };
}
