{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.theme = "agnoster";
    oh-my-zsh.plugins = [ "git" "fzf" ];
  };

  programs.tmux.enable = true;
  programs.neovim.enable = true;
  programs.git.enable = true;

  home.packages = with pkgs; [
    bat fd fzf eza lazygit go
  ];

  home.file.".tmux.conf".source = ./tmux/.tmux.conf;

  # home.file.".config/nvim" = {
  #   source = ./nvim/config;
  #   recursive = true;
  # };
}
