{ pkgs, config, lib, ... }:
{
  home-manager.users.romatthe = {
    programs.emacs = {
      enable = true;
      extraPackages = epkgs:
        with epkgs; [
          use-package
          gcmh
          bind-key
          cheatsheet
          exec-path-from-shell
          #saveplace
          #recentf
          #savehist
          helpful
          restart-emacs
          #uniquify
          #delsel
          #autorevert
          avy
          avy-zap
          ace-link
          #comment-dwim2
          drag-stuff
          #elec-pair
          multiple-cursors
          expand-region
          mwim
          undo-tree
          #subword
          imenu-list
          ivy
	  counsel
          counsel-projectile
          counsel-projectile
          ivy-hydra
          ivy-yasnippet
          ivy-rich
          #dired
          dired-rsync
          diredfl
          all-the-icons-dired
          #ibuffer
          ibuffer-projectile
          org
          org-bullets
          treemacs
          treemacs-projectile
          treemacs-magit 
          switch-window
          company
          company-prescient
          company-box
          company-quickhelp
          magit
          magit-todos
          flycheck
          flycheck-posframe
          projectile
          lsp-mode
          lsp-treemacs
          lsp-ui
 	  company-lsp
          dap-mode
          ccls
          lsp-java
          dashboard
          doom-modeline
          hide-mode-line
          minions
          moody
          doom-themes
          #display-line-numbers
          which-key
          modern-cpp-font-lock
          cmake-mode
          cmake-font-lock
          cmake-ide
          rainbow-delimiters
          clj-refactor
          clojure-mode
          cider
          #lisp-mode
          sly
          #sly-company
          sly-macrostep
          sly-repl-ansi-color
          go-projectile
          go-mode
          haskell-mode
          #pdf-mode
          auctex
          auctex-latexmk
          company-auctex
          #tex
          markdown-mode
          nix-mode
          toml-mode
          rust-mode
          cargo
          flycheck-rust
        ];
    };


    home.file.".emacs.d/init.el".source = ./init.el;
    home.file.".emacs.d/lisp/".source = ./lisp;
    home.file.".emacs.d/img/".source = ./img;

    services.emacs.enable = true;

    home.activation.emacs = {
      before = [ ];
      after = [ ];
      data = "";
    };
   
  };

  fonts.fonts = with pkgs; [
    emacs-all-the-icons-fonts
    fira-code
  ];
  
}