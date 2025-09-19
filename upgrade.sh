#! /bin/sh

nix flake update --flake ~/.dotfiles/
sudo nixos-rebuild switch --flake ~/.dotfiles/#default
home-manager switch --flake ~/.dotfiles/#default
