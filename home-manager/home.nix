{ config, pkgs, ... }:

{
  home.username = "cnnd";
  home.homeDirectory = "/home/cnnd";

  imports = [
    ./imports.nix
  ];

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
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

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "cnnd";
    userEmail = "hi@cnnd.dev";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}