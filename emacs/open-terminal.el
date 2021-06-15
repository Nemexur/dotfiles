;;; $DOOMDIR/open-terminal.el -*- lexical-binding: t; -*-

(require 'cl-lib)

(defvar project-root-functions
  '(projectile-project-root ffip-project-root)
  "Functions to attempt evaluating to determine the project root.")

(defvar project-root-files
  '(".git")
  "Dominating files to look for to determine the project root.")

(defun get-project-root ()
  "Return the project root.
   Tries calling `shell-here-project-root-functions', returning the
   result of evaluating the first one which is bound. If none are
   bound, looks for a parent directory containing a file in
   `shell-here-project-root-files'."
  (or (cl-loop with found = nil
               for func in project-root-functions
               if (setq found (and (fboundp func) (apply func nil)))
               return found)
      (cl-loop with found = nil
               for file in project-root-files
               if (setq found (locate-dominating-file default-directory file))
               return found)
      default-directory))

;;;###autoload
(defun toggle-vterm (arg)
  "Toggles a terminal popup window at project root.
If prefix ARG is non-nil, recreate vterm buffer in the current project's root.
Returns the vterm buffer."
  (interactive "P")
  (+vterm--configure-project-root-and-display
   arg
   (lambda()
     (let ((buffer-name
            (format "*doom:vterm-popup:%s*"
		    (f-filename (get-project-root))))
           confirm-kill-processes
           current-prefix-arg)
       (when arg
         (let ((buffer (get-buffer buffer-name))
               (window (get-buffer-window buffer-name)))
           (when (buffer-live-p buffer)
             (kill-buffer buffer))
           (when (window-live-p window)
             (delete-window window))))
       (if-let (win (get-buffer-window buffer-name))
           (if (eq (selected-window) win)
               (delete-window win)
             (select-window win)
             (when (bound-and-true-p evil-local-mode)
               (evil-change-to-initial-state))
             (goto-char (point-max)))
         (let ((buffer (get-buffer-create buffer-name)))
           (with-current-buffer buffer
             (unless (eq major-mode 'vterm-mode)
               (vterm-mode))
             (+vterm--change-directory-if-remote))
           (pop-to-buffer buffer)))
       (get-buffer buffer-name)))))
