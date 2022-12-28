{ config, pkgs, lib, ... }:

let
    cfg = config.mas;
in {
    options.mas = {
        apps = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = ''
                List of Mac App Store apps to install.
            '';
        };
    };

    config = {
        system.activationScripts.postUserActivation.text =  ''
            echo "Installing Mac App Store apps..."
            ${lib.concatStringsSep "\n" (map (app: ''
                if ! ${pkgs.mas}/bin/mas list | grep -q ${app}; then
                    echo "Installing ${app}..."
                    ${pkgs.mas}/bin/mas install ${app}
                fi
            '') cfg.apps)}
        '';
    };
}