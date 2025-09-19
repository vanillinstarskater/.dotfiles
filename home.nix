{ config, pkgs, ... }:
{
  # Etc.
  home.stateVersion = "25.05";
  home.username = "vanillin";
  home.homeDirectory = "/home/vanillin";
  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = false;

  # Configures xcursor.
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  # Configures bash.
  programs.bash = {
    enable = true;
    initExtra = ''
      PS1='[\u@\H \W]$ '
      set -o vi
      alias vi='nvim'
      alias :q='exit'
      alias ls='ls --color=auto'
      alias la='ls -A'
      alias cl='clear'
    '';
  };

  # Configures neovim.
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.vim-sleuth
      pkgs.vimPlugins.gitsigns-nvim
      pkgs.vimPlugins.which-key-nvim
      pkgs.vimPlugins.neo-tree-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.conform-nvim
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.nvim-ufo
    ];
    extraLuaConfig = ''
      -- Sets up leader key.
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -- Improves navigation.
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.cursorline = true
      vim.opt.cursorcolumn = true
      vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
      vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
      vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
      vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

      -- Improves aesthetics.
      vim.opt.signcolumn = "yes"
      vim.cmd([[highlight Normal guibg=none]])
      vim.opt.tabstop = 4
      vim.opt.list = true
      vim.opt.listchars = { tab = "> ", trail = "-" }

      -- Switches to system clipboad.
      vim.opt.clipboard = "unnamedplus"

      -- Sets up some shortcuts.
      vim.keymap.set("n", "<Esc>", ":noh<LF><Esc>")
      vim.keymap.set("n", "<Leader>d", ":lua vim.diagnostic.open_float()<LF>")
      vim.keymap.set("n", "<Leader>e", ":Neotree toggle right<LF>")
      vim.keymap.set("n", "<Leader>t", ":terminal<LF>")
      vim.keymap.set("n", "<Leader>c", ":bd<LF>")

      -- Makes neo-tree show hidden files by default.
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true
          }
        }
      })

      -- Sets up LSP.
      vim.lsp.enable('black')
      vim.lsp.enable('nixfmt')
      vim.lsp.enable('nil')

      -- Sets up formatting.
      require("conform").setup({
      format_on_save = {},
        formatters_by_ft = {
          python = { "black" },
          nix = { "nixfmt" },
        },
      })

      -- Sets up UFO folding.
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
      local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
          capabilities = capabilities
        })
      end
      require('ufo').setup()
    '';
  };

  # Configures alacritty.
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.5;
      mouse.hide_when_typing = true;
      colors = {
        primary = {
          foreground = "#ffffff";
          background = "#000000";
        };
        normal = {
          black = "#000000";
          red = "#ff0000";
          green = "#00ff00";
          yellow = "#ffff00";
          blue = "#0000ff";
          magenta = "#ff00ff";
          cyan = "#00ffff";
          white = "#ffffff";
        };
      };
    };
  };

  # Configures waybar.
  programs.waybar = {
    enable = true;
    settings.main = {
      position = "bottom";
      "height" = 20;
      "spacing" = 4;

      modules-left = [
        "network"
        "tray"
      ];

      modules-center = [
        "pulseaudio"
      ];

      modules-right = [
        "cpu"
        "memory"
        "clock"
      ];

      network = {
        format = "{ipaddr}";
        format-disconnected = "DISCONNECTED";
        tooltip = false;
      };

      tray = {
        spacing = 10;
        tooltip = false;
      };

      pulseaudio = {
        format = "{volume}% | {format_source}%";
        format-muted = "[muted] | {format_source}%";
        format-source = "{volume}";
        tooltip = false;
      };

      cpu = {
        format = "CPU {usage}%";
        tooltip = false;
      };

      memory = {
        format = "MEM {}%";
        tooltip = false;
      };

      clock = {
        tooltip = false;
      };
    };

    style = ''
      	* {
      	    font-family: Hack Nerd Font;
      	    font-size: 13px;
      	}

      	window#waybar {
      	    background-color: rgba(0, 0, 0, 0.0);
      	}

      	#network,
      	#tray,
      	#pulseaudio,
      	#cpu,
      	#memory,
      	#clock {
      	    padding: 0 5px;
      	    background-color: rgba(0, 0, 0, 0.5);
      	    color: #ffffff;
      	}
    '';
  };

  # Configures hyprland.
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    plugins = [
      # Hyprland multi-monitor is borderline unusable.
      # I kinda get what they were going for, with the workspace-monitor binding and stuff, but they were _not_ cooking.
      # Luckily, there are a few plugins that fix that and this one's in nixpkgs.
      pkgs.hyprlandPlugins.hyprsplit
    ];

    settings = {
      plugin = {
        hyprsplit = [
          "num_workspaces = 10"
        ];
      };

      monitor = ", preferred, auto, auto";

      exec-once = [
        "swaybg --image ~/.dotfiles/wallhaven-0wym26.jpg"
      ];

      input = {
        kb_options = "caps:escape";
        repeat_rate = 70;
        repeat_delay = 200;
      };

      general = {
        gaps_in = 2;
        gaps_out = 2;
        border_size = 1;
        "col.active_border" = "rgba(00ffffff)";
        "col.inactive_border" = "rgba(00000000)";
      };

      decoration = {
        shadow.enabled = false;
        blur.enabled = false;
      };

      animations = {
        enabled = true;
        animation = [ "global, 1, 2, default" ];
      };

      bind = [
        # Commands.
        "SUPER, C, killactive,"
        "SUPER, F, fullscreen,"
        "SUPER, P, togglefloating,"

        # Run-commands.
        "SUPER, T, exec, alacritty"
        "SUPER, B, exec, librewolf"
        "SUPER, return, exec, tofi-run --hide-cursor=false --history=false --font=\"Hack Nerd Font\" --font-size=15 --background-color=00000080 --outline-width=0 --border-width=1 --border-color=00FFFF --prompt-text=\"> \" --selection-color=00FFFF --height=50% --width=50% | sh"

        # Intra-workspace movement.
        "SUPER, h, movefocus, l"
        "SUPER SHIFT, h, movewindow, l"
        "SUPER, j, movefocus, d"
        "SUPER SHIFT, j, movewindow, d"
        "SUPER, k, movefocus, u"
        "SUPER SHIFT, k, movewindow, u"
        "SUPER, l, movefocus, r"
        "SUPER SHIFT, l, movewindow, r"

        # Inter-workspace movement.
        "SUPER, 1, split:workspace, 1"
        "SUPER SHIFT, 1, split:movetoworkspace, 1"
        "SUPER, 2, split:workspace, 2"
        "SUPER SHIFT, 2, split:movetoworkspace, 2"
        "SUPER, 3, split:workspace, 3"
        "SUPER SHIFT, 3, split:movetoworkspace, 3"
        "SUPER, 4, split:workspace, 4"
        "SUPER SHIFT, 4, split:movetoworkspace, 4"
        "SUPER, 5, split:workspace, 5"
        "SUPER SHIFT, 5, split:movetoworkspace, 5"
        "SUPER, 6, split:workspace, 6"
        "SUPER SHIFT, 6, split:movetoworkspace, 6"
        "SUPER, 7, split:workspace, 7"
        "SUPER SHIFT, 7, split:movetoworkspace, 7"
        "SUPER, 8, split:workspace, 8"
        "SUPER SHIFT, 8, split:movetoworkspace, 8"
        "SUPER, 9, split:workspace, 9"
        "SUPER SHIFT, 9, split:movetoworkspace, 9"
        "SUPER, 0, split:workspace, 10"
        "SUPER SHIFT, 0, split:movetoworkspace, 10"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
    };
  };
}
