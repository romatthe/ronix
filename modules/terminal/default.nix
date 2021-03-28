{ config, lib, pkgs, ... }:
{
  home-manager.users.romatthe = { 
    programs.alacritty = {
      enable = true;
      settings = {
      
        env = {
          "TERM" = "xterm-256color";
        };

        background_opacity = 0.95;

        window = {
          padding.x = 10;
          padding.y = 10;
          decorations = "none";
        };

        font = {
          size = 11.0;
          use_thin_strokes = true;

    	    normal.family = "FuraCode Nerd Font";
    	    bold.family = "FuraCode Nerd Font";
    	    italic.family = "FuraCode Nerd Font";
        };

        cursor.style = "Block";

        shell = {
          program = "zsh";
        };

        # Colors (Gruvbox dark)
        colors = {
          # Default colors
          primary = {
            # hard contrast: background = '0x1d2021'
            background = "0x282828";
            # soft contrast: background = '0x32302f'
            foreground = "0xebdbb2";

            # Normal colors
            normal = {
              black   = "0x282828";
              red     = "0xcc241d";
              green   = "0x98971a";
              yellow  = "0xd79921";
              blue    = "0x458588";
              magenta = "0xb16286";
              cyan    = "0x689d6a";
              white   = "0xa89984";

              # Bright colors
              bright = {
                black   = "0x928374";
                red     = "0xfb4934";
                green   = "0xb8bb26";
                yellow  = "0xfabd2f";
                blue    = "0x83a598";
                magenta = "0xd3869b";
                cyan    = "0x8ec07c";
                white   = "0xebdbb2";
              };
            };
          };
        };
      };
    };

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "b2609ca787803f523a18bb9f53277d0121e30389";
            sha256 = "01w59zzdj12p4ag9yla9ycxx58pg3rah2hnnf3sw4yk95w3hlzi6";
          };
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.4.0";
            sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
          };
        }
        {
          name = "you-should-use";
          src = pkgs.fetchFromGitHub {
            owner = "MichaelAquilina";
            repo = "zsh-you-should-use";
            rev = "2be37f376c13187c445ae9534550a8a5810d4361";
            sha256 = "0yhwn6av4q6hz9s34h4m3vdk64ly6s28xfd8ijgdbzic8qawj5p1";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          file = "zsh-syntax-highlighting.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "e7d3fbc50b0209cb9f9b0812fd40298be03c7808";
            sha256 = "14sfbnl8iw1l1ixzg8al190hcxyakgb1sf8qqd64n7adrq8vfiv6";
          };
        }
      ];
      shellAliases = {
        "ls" = ''ls --color=auto'';
        "ll" = ''ls -la --color=auto'';
      };
      initExtra = ''
        eval "$(starship init zsh)"
        eval `${pkgs.coreutils}/bin/dircolors "${./dircolors}"`

        bindkey "^[[1;5C" forward-word    
        bindkey "^[[1;5D" backward-word
        bindkey "^[^[[D" forward-word
        bindkey "^[^[[C" backward-word
      '';
    };

    home.packages = with pkgs; [
      pkgs.neofetch
      pkgs.starship
    ];

  };
  
  environment.sessionVariables.TERMINAL = [ "alacritty" ];

  fonts.fonts = with pkgs; [
    nerdfonts
  ];
}
