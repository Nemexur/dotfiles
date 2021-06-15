;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Loading external files
(load! "open-terminal.el")

;; More information on errors
(setq debug-on-error t)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Alex Milogradsky"
      user-mail-address "alex.milogradsky@gmail.com")

;; Set default coding system just in case.
(set-default-coding-systems 'utf-8)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "JetBrains Mono" :size 12)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Always use spaces
(setq-default indent-tabs-mode t)

;; Automatically clean whitespaces
(use-package! ws-butler
  :hook ((text-mode . ws-butler-mode)
	 (prog-mode . ws-butler-mode)))

;; Setup lsp-ui
(use-package! lsp-mode
  :config
  (setq lsp-prefer-flymake nil))

(use-package! lsp-ui
  :requires lsp-mode flycheck
  :config

  (setq lsp-ui-doc-mode t
	lsp-ui-doc-use-webkit t
	lsp-ui-doc-use-childframe nil
	lsp-ui-doc-position 'top
	lsp-ui-doc-max-height 30
	lsp-ui-doc-max-width 40
	lsp-ui-doc-include-signature t
	lsp-ui-sideline-enable nil
	lsp-ui-flycheck-enable t
	lsp-ui-flycheck-list-position 'right
	lsp-ui-flycheck-live-reporting t
	lsp-ui-peek-enable t
	lsp-ui-peek-list-width 60
	lsp-ui-peek-peek-height 25)

  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; Setup Hydra
; (use-package! helm-lsp
;   :config
;   (defun netrom/helm-lsp-workspace-symbol-at-point ()
;     (interactive)
;     (let ((current-prefix-arg t))
;       (call-interactively #'helm-lsp-workspace-symbol)))

;   (defun netrom/helm-lsp-global-workspace-symbol-at-point ()
;     (interactive)
;     (let ((current-prefix-arg t))
;       (call-interactively #'helm-lsp-global-workspace-symbol))))

; (use-package! lsp-mode
;   :requires hydra helm helm-lsp

;   (setq netrom--general-lsp-hydra-heads
;         '(;; Xref
;           ("d" xref-find-definitions "Definitions" :column "Xref")
;           ("D" xref-find-definitions-other-window "-> other win")
;           ("r" xref-find-references "References")
;           ("s" netrom/helm-lsp-workspace-symbol-at-point "Helm search")
;           ("S" netrom/helm-lsp-global-workspace-symbol-at-point "Helm global search")

;           ;; Peek
;           ("C-d" lsp-ui-peek-find-definitions "Definitions" :column "Peek")
;           ("C-r" lsp-ui-peek-find-references "References")
;           ("C-i" lsp-ui-peek-find-implementation "Implementation")

;           ;; LSP
;           ("p" lsp-describe-thing-at-point "Describe at point" :column "LSP")
;           ("C-a" lsp-execute-code-action "Execute code action")
;           ("R" lsp-rename "Rename")
;           ("t" lsp-goto-type-definition "Type definition")
;           ("i" lsp-goto-implementation "Implementation")
;           ("f" helm-imenu "Filter funcs/classes (Helm)")
;           ("C-c" lsp-describe-session "Describe session")

;           ;; Flycheck
;           ("l" lsp-ui-flycheck-list "List errs/warns/notes" :column "Flycheck"))

;         netrom--misc-lsp-hydra-heads
;         '(;; Misc
;           ("q" nil "Cancel" :column "Misc")
;           ("b" pop-tag-mark "Back")))

;   ;; Create general hydra.
;   (eval `(defhydra netrom/lsp-hydra (:color blue :hint nil)
;            ,@(append
;               netrom--general-lsp-hydra-heads
;               netrom--misc-lsp-hydra-heads)))

;   (add-hook 'lsp-mode-hook
;             (lambda () (local-set-key (kbd "C-c C-l") 'netrom/lsp-hydra/body))))

;; Setup tabs navigation with centaur tabs
(setq centaur-tabs-set-bar 'over
      centaur-tabs-set-icons t
      centaur-tabs-gray-out-icons 'buffer
      centaur-tabs-height 24
      centaur-tabs-set-modified-marker t
      centaur-tabs-style "bar"
      centaur-tabs-modified-marker "•")
(define-key evil-normal-state-map (kbd "g t") 'centaur-tabs-forward)
(define-key evil-normal-state-map (kbd "g T") 'centaur-tabs-backward)
(define-key evil-normal-state-map (kbd "g q") 'centaur-tabs--kill-this-buffer-dont-ask)

;; Remap keys for Evil
(evil-define-key 'normal 'global "\C-u" (kbd "C-r"))
(evil-define-key 'normal 'global "\C-o" (kbd "o <escape>"))
(evil-define-key 'insert 'global "\C-h" (kbd "<backspace>"))

;; Useful shortucts
(map! :leader
      ;; For Terminal
      :desc "Open EShell." "e s" #'eshell
      :desc "Open shell in current directory." "o v" #'toggle-vterm
      ;; For centaur tabs
      :desc "Toggle tabs globally." "t c" #'centaur-tabs-mode
      :desc "Toggle tabs local display." "t C" #'centaur-tabs-local-mode
      ;; For lsp-ui
      :desc "Peek definition of an object in code." "l d" #'lsp-ui-peek-find-definitions
      ;; For Helm Buffers
      :desc "Show buffers list with Counsel." "b h" #'counsel-ibuffer)

;; Setup dashboard for Doom Emacs

;; (use-package dashboard
;;   :init      ;; tweak dashboard config before loading it
;;   (setq dashboard-set-heading-icons t)
;;   (setq dashboard-set-file-icons t)
;;   (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
;;   ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
;;   (setq dashboard-startup-banner "~/.config/doom/doom-emacs-dash.png")  ;; use custom image as banner
;;   (setq dashboard-center-content nil) ;; set to 't' for centered content
;;   (setq dashboard-items '((recents . 5)
;; 			  (agenda . 5 )
;; 			  (bookmarks . 5)
;; 			  (projects . 5)
;; 			  (registers . 5)))
;;   :config
;;   (dashboard-setup-startup-hook)
;;   (dashboard-modify-heading-icons '((recents . "file-text")
;; 				    (bookmarks . "book"))))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
