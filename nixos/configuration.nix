# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix # include results from hw scan
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "komodo"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
  #   font = "Lat2-Terminus16";
    keyMap = "uk";
  #   useXkbConfig = true; # use xkb.options in tty.
  };

  # set the default shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  # system packages
  environment.systemPackages = with pkgs; [
    # bits and bobs
    vim
    wget
    unzip
    zip
    htop
    bc
    lsof
    cmake
  ];

  # user
  users.users = {
    # change if you are not me
    cnnd = {
      isNormalUser = true;
      extraGroups = [ "wheel" "libvirtd" "kvm" "docker" ]; # wheel for sudo, libvirt and kvm for vms, docker for... well... you'll figure it out
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # desktop
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  nixpkgs.config.allowUnfree = true; # this will allow chrome & other proprietary software

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # enable flakes & the nix command

  # i want vms
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  programs.steam = {
    enable = true;
  };

  system.stateVersion = "24.05"; # do not change :D
}
