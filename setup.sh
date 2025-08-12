#! /bin/sh

paru -S neovim-git gtk4 hyprland kitty stow pipewire wireplumber pipewire-jack pipewire-alsa pipewire-pulse ttf-hack-nerd archlinux-wallpaper swaybg dunst libnotify qt5-wayland qt6-wayland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk hyprpolkitagent waybar wayclip tofi cpio pyright python-black

mkdir -p ~/.config
stow --dotfiles --restow dotfiles

# Hyprland's default multi-monitor behavior is borderline unusable without this plugin.
hyprpm update
hyprpm add https://github.com/Duckonaut/split-monitor-workspaces
hyprpm enable split-monitor-workspaces
