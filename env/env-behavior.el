;;; Various packages -*- lexical-binding: t; -*-

;; Electric indent
(use-package electric
  :straight nil
  :defer t
  :hook (after-init . electric-indent-mode)
  :config
  (setq-default electric-indent-inhibit t))

;; Undotree
(use-package undo-tree
  :straight nil
  :disabled t)
  ;; :config
  ;; ;; Persistent undo-tree history across Emacs sessions
  ;; (setq undo-tree-auto-save-history t
  ;;       undo-tree-history-directory-alist '(("." . "~/.cache/emacs/undo"))
  ;;       undo-tree-enable-undo-in-region nil)
  ;; ;; TODO:
  ;; ;; (add-hook 'after-save-hook #'undo-tree-save-history)
  ;; ;; (add-hook 'find-file-hook #'undo-tree-load-history)
  ;; ;; (add-hook 'find-file-hook #'global-undo-tree-mode-check-buffers)
  ;; ;; (add-hook 'undo-tree-visualizer-mode-hook #'undo-tree-visualizer-toggle-diff)

  ;; (setq-default undo-tree-visualizer-timestamps t)
  ;; (setq-default undo-tree-visualizer-diff nil)
  ;; (global-undo-tree-mode 1))

(use-package undo-propose
  :straight (:host github :repo "jackkamm/undo-propose-el" :files ("*.el"))
  :commands (undo-propose undo-propose-diff)
  :config
  (undo-propose-wrap redo)
  (setq undo-propose-pop-to-buffer t))

;; Simple, stable linear undo with redo for Emacs.
(use-package undo-fu
  :defer t
  :commands (undo-fu-only-undo undo-fu-only-redo))

;; Save & recover undo steps between Emacs sessions.
(use-package undo-fu-session
  :hook (after-init . global-undo-fu-session-mode)
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'")))

;; If you want Emacs kill ring and system clipboard to be independent.
;; (use-package simpleclip
;;   :config
;;   (simpleclip-mode t))

(defvar snug-recentf-cleanup-symlinks t
  "When t, delete symbolic links from the list with recent opened files.")

;; Recent files
(use-package recentf
  :straight nil
  :defer 1
  :preface
  (defun snug/recentf-save-list-silence ()
    (interactive)
    (let ((message-log-max nil))
      (if (fboundp 'shut-up)
          (shut-up (recentf-save-list))
        (recentf-save-list)))
    (message ""))

  (defun snug/recentf-cleanup-silence ()
    (interactive)
    (let ((message-log-max nil))
      (if (fboundp 'shut-up)
          (shut-up (recentf-cleanup))
        (recentf-cleanup)))
    (message ""))
  :config
  (run-at-time nil (* 5 60) 'snug/recentf-save-list-silence)

  (setq recentf-max-menu-items 150
        recentf-max-saved-items 150
        recentf-auto-cleanup 'never
        ;; Recentf blacklist
        recentf-exclude '("^/var/folders\\.*"
                          "COMMIT_EDITMSG\\'"
                          ".*-autoloads\\.el\\'"
                          "[/\\]\\.emacs.d/recentf"
                          "[/\\]\\.emacs.d/.cache"
                          "[/\\]\\.emacs.d/bookmarks"
                          "[/\\]\\.emacs.d/url"
                          "[/\\]\\.emacs.d/straight"
                          ".*.jpg$"
                          ".*.png$"
                          ".*.gif$"
                          ".cache"
                          "cache"
                          "^/usr/share/emacs"
                          "^/usr/lib64/go/src"
                          "[/\\]\\.emacs.d/elpa"))

  ;; Don't show files inside no-littering directory
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory)

  ;; Delete symbolic links from recentf
  (when snug-recentf-cleanup-symlinks
    (add-to-list 'recentf-exclude (lambda (f) (not (string= (file-truename f) f)))))
  (recentf-mode t)
  )

(use-package subword
  :defer t
  ;; :commands (subword-mode global-subword-mode)
  :hook (after-init . global-subword-mode))

(use-package uniquify
  :straight nil
  :defer 2
  :config
  (setq uniquify-buffer-name-style 'forward))


(provide 'env-behavior)
