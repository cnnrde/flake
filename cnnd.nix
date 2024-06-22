{ config, pkgs, ... }:

let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  spicetify-nix = (import flake-compat {
    src = builtins.fetchTarball "https://github.com/the-argus/spicetify-nix/archive/master.tar.gz";
  }).defaultNix;
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in {
  users.users.cnnd = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];

    packages = with pkgs; [
      nitch
      google-chrome 
      vesktop
      vscode
      alacritty
      prismlauncher
      wget
      unzip
      nerdfonts
      zip
      lunar-client

      # Theoretically required for VSCode
      desktop-file-utils
      libsecret
      gnome.gnome-keyring
    ];

  };

  home-manager.useGlobalPkgs = true;

  home-manager.users.cnnd = {
  imports = [ spicetify-nix.homeManagerModule ];
    programs.zsh = {
      enable = true;
    };

    programs.starship = {
      enable = true;
    };

    programs.git = {
      enable = true;
      userName = "cnnd";
      userEmail = "hi@cnnd.dev";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.text;
      colorScheme = "CatppuccinMocha";
    };

    home.stateVersion = "24.05";
  };
}
