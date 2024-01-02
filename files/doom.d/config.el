;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

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

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Always use spaces
(setq-default indent-tabs-mode t)

;; Iterate throught CamelCase words
(global-subword-mode 1)

;; Prefer relative numbers
(setq display-line-numbers-type 'relative)

;; Remap keys for Evil
(evil-define-key 'normal 'global "\C-u" (kbd "C-r"))
(evil-define-key 'normal 'global "\C-o" (kbd "o <escape>"))
(evil-define-key nil 'global "\C-h" (kbd "<backspace>"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Auto next-line after 100 columns
(add-hook! 'org-mode-hook '(lambda () (setq fill-column 100)))
(add-hook! 'org-mode-hook 'turn-on-auto-fill)
(add-hook! 'org-mode-hook #'format-all-mode)

;; Setup notifier for timer
(defvar terminal-notifier-command (executable-find "terminal-notifier") "The path to terminal-notifier.")

(defun terminal-notifier-notify (title message)
  "Show a message with terminal-notifier-command."
  (start-process "terminal-notifier"
		 "terminal-notifier"
		 terminal-notifier-command
		 "-title" title
		 "-message" message
		 "-activate" "org.gnu.Emacs"))

(defun timed-notification (time msg)
  (interactive "sNotification when (e.g: 2 minutes, 60 seconds, 3 days): \nsMessage: ")
  (run-at-time time nil (lambda (msg) (terminal-notifier-notify "Emacs" msg)) msg))

(setq org-show-notification-handler
      (lambda (msg) (timed-notification nil msg)))

(setq org-clock-sound "/System/Library/Sounds/Blow.aiff")

;; Automatically clean whitespaces
(use-package! ws-butler
  :hook ((text-mode . ws-butler-mode)
	 (prog-mode . ws-butler-mode)))

;; Configure lsp-ui documentation
(after! lsp-ui
  (setq lsp-ui-doc-enable nil)
  (setq lsp-modeline-code-actions-enable t))

;; Python
(setq lsp-enable-file-watchers nil)

(use-package! lsp-pyright
  :config
  (setq-default flycheck-disabled-checkers '(python-pylint))
  :hook
  (python-mode . (lambda ()
		   (require 'lsp-pyright)
		   (lsp-deferred)
		   (flycheck-select-checker 'python-flake8))))

;; Go
(use-package! flycheck-golangci-lint
  :hook
   (go-mode . flycheck-golangci-lint-setup))

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

;; IBuffer filter groups
(setq! ibuffer-saved-filter-groups
       '(("Default"
	  ("Python" (predicate string-match "Python" mode-name))
	  ("Internal" (name . "^\\*.*?\\*$")))))

;; Useful shortucts
(map! :leader
      ;; For Terminal
      :desc "Open EShell" "e s" #'eshell
      ;; For spelling
      :desc "Lookup spelling corrections" "c z" #'ispell-word
      ;; For treemacs
      :desc "Toggle current project in treemacs" "t e" #'treemacs-display-current-project-exclusively
      ;; For centaur tabs
      :desc "Toggle tabs globally" "t c" #'centaur-tabs-mode
      :desc "Toggle tabs local display" "t C" #'centaur-tabs-local-mode
      ;; For lsp-ui
      :desc "Show documentation in doc-frame" "d s" #'lsp-ui-doc-show
      ;; For Helm Buffers
      :desc "Show buffers list with Counsel" "b h" #'counsel-ibuffer
      ;; For Gitlab-CI
      :desc "Run Gitlab-CI lint" "c g" #'gitlab-ci-lint)

;; Load secrets
(load! "secrets.el")

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
