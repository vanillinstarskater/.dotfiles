#! /bin/sh

sudo nixos-rebuild switch --flake ~/.dotfiles/#default
home-manager switch --flake ~/.dotfiles/#default
