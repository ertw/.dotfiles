{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "zorrito";
    connman.enable = true;
  };

  services = {
    printing.enable = true;
  };

  i18n.consoleUseXkbConfig = true;

  virtualisation.docker.enable = true;

  time.timeZone = "America/Santiago";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget vim sway swaylock xwayland dmenu alacritty brightnessctl
  ];

  programs = {
    fish.enable = true;
    sway.enable = true;
    vim.defaultEditor = true;
  };

  sound.enable = true;

  hardware.pulseaudio.enable = true;

  security = {
    sudo.enable = true;
    sudo.extraRules = [{
      runAs = "root";
      groups = [ "wheel" ];
      commands = [{
        command = "/run/current-system/sw/bin/brightnessctl";
        options = [ "NOPASSWD" ];
      }];
    }];
  };

  users.users.ertw = {
    isNormalUser = true;
    description = "Erik Williamson";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    helvetica-neue-lt-std
  ];

  system.stateVersion = "19.03";
}
