{ config, pkgs, ... }:

{
  home.username = "cnnd";
  home.homeDirectory = "/home/cnnd";

  imports = [
    ./imports.nix
  ];

  home.packages = with pkgs; [
    nitch
    google-chrome 
    vesktop
    prismlauncher
    nerdfonts
    lunar-client
    aseprite
    virt-manager
    zulu
    hypnotix
    freerdp3
    dotnet-sdk_8
    gh

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

  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      ghcs = "gh copilot suggest";
      ghce = "gh copilot explain";
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-dotnettools.csdevkit
    ];
  };

  # might as well
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
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