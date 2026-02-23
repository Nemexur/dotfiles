{
  body = {pkgs, ...}:
    pkgs.writers.writeBashBin "body" {
      makeWrapperArgs = with pkgs; [
        "--prefix PATH : ${lib.makeBinPath [coreutils]}"
      ];
    } (builtins.readFile ./body);
  # cols = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "cols" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [coreutils]}"
  #     ];
  #   } (builtins.readFile ./cols);
  # extract = {pkgs, ...}: pkgs.writers.writeBashBin "extract" {} (builtins.readFile ./extract); # TODO: Add many packages
  # git-nuke = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "git-nuke" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [git]}"
  #     ];
  #   } (builtins.readFile ./git-nuke);
  # git-rank-contributors = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "git-rank-contributors" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [git]}"
  #     ];
  #   } (builtins.readFile ./git-rank-contributors);
  # git-undo = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "git-undo" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [git]}"
  #     ];
  #   } (builtins.readFile ./git-undo); # Add git
  # git-wtf = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "git-wtf" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [git]}"
  #     ];
  #   } (builtins.readFile ./git-wtf); # Add git
  # headers = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "headers" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [coreutils]}"
  #     ];
  #   } (builtins.readFile ./headers); # Add grep curl coreutils
  # prepend-jira = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "prepend-jira" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [coreutils]}"
  #     ];
  #   } (builtins.readFile ./prepend-jira); # Add coreutils
  # tgmsg = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "tgmsg" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [coreutils httpie]}"
  #     ];
  #   } (builtins.readFile ./tgmsg); # TODO check packages
  # tmux-history = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "tmux-history" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [coreutils tmux]}"
  #     ];
  #   } (builtins.readFile ./tmux-history); # Add tmux
  # tmux-kill-session = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "tmux-kill-session" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [coreutils tmux]}"
  #     ];
  #   } (builtins.readFile ./tmux-kill-session); # Add tmux
  # tmux-sessionizer = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "tmux-sessionizer" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [coreutils tmux]}"
  #     ];
  #   } (builtins.readFile ./tmux-sessionizer); # Add tmux
  # tmux-ssh = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "tmux-ssh" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [coreutils tmux]}"
  #     ];
  #   } (builtins.readFile ./tmux-ssh); # Add tmux
  # tmux-switch = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "tmux-switch" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [coreutils tmux]}"
  #     ];
  #   } (builtins.readFile ./tmux-switch); # Add tmux
  # trim = {pkgs, ...}:
  #   pkgs.writers.writeBashBin "trim" {
  #     makeWrapperArgs = with pkgs; [
  #       "--prefix PATH : ${lib.makeBinPath [coreutils gawk]}"
  #     ];
  #   } (builtins.readFile ./trim); # TODO check awk
}
