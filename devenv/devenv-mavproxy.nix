{ pkgs, ... }:
{
  packages = with pkgs; [
    conan
    mavproxy
    pyEnv
  ];

  languages = {
    python = {
      enable = true;
      package = pkgs.pyEnv;
    };
  };

  enterShell = ''
    eval "$(mise activate bash)"
    eval "$(mise hook-env -s bash)"
    local-home
    eval "$(mise hook-env -s bash)"
    detect-profile
    eval "$(mise hook-env -s bash)"
    profile
    eval "$(mise hook-env -s bash)"
    export "$(./conanbuild.sh)"
  '';

  scripts = {
    local-home.exec = ''
      pushd $DEVENV_ROOT
      cat << EOF > .mise.local.toml
      [env]
        CONAN_HOME = '$DEVENV_ROOT/.conan2'
      EOF
    '';

    detect-profile.exec = ''
      pushd $DEVENV_ROOT
      conan profile detect -e
      conan remote add localindex ./local_index --allowed-packages="waf/2.0.27" --force
    '';

    subup.exec = ''
      pushd $DEVENV_ROOT
      git submodule update --init --recursive
    '';

    profile.exec = ''
      pushd $DEVENV_ROOT
      conan install . -pr:b=./profiles/macos-x86_64 --build missing
      chmod +x ./conanbuild*.sh
      chmod +x ./conanrun*.sh
      chmod +x ./deactivate_conanbuild*.sh
      chmod +x ./deactivate_conanrun*.sh
    '';

    patch-classic.exec = ''
      pushd $DEVENV_ROOT
      patch --directory submodules/ardupilot/Tools/ardupilotwaf < 0001-Remove-ld_classic.patch
    '';
  };

  git-hooks = {
    hooks = {
      shellcheck.enable = true;
      shfmt.enable = false;
      alejandra.enable = true;
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
