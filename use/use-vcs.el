;; Mercurial  -*- lexical-binding: t -*-
;; (use-package monky
;;   :config
;;   (setq monky-process-type 'cmdserver))

(setq vc-annotate-background nil
      vc-annotate-very-old-color nil)

;; Magit complains loudly when it can't determine its own version, which is
;; the case when magit is built through straight. The warning is harmless,
;; however, so we just need it to shut up.
;;;###autoload (advice-add #'magit-version :override #'ignore)

;; Git
(use-package magit
  :defer t
  :init
  ;; Disable GUI dialog for git
  (setenv "GIT_ASKPASS" "")
  (setenv "SSH_ASKPASS" "")
  :preface
  (defun magit-status-only ()
    "Invoke magit-status and delete other windows."
    (interactive)
    (magit-status)
    (delete-other-windows))
  :commands (magit-status magit-diff magit-blame magit-commit)
  :config
  ;; Disable arrows in section heading
  (setq magit-section-visibility-indicator nil
        magit-diff-buffer-file-locked nil
        magit-clone-set-remote.pushDefault t
        magit-remote-add-set-remote.pushDefault t
        magit-log-auto-more t
        ;; MAYBE:
        ;; magit-save-repository-buffers 'dontask))
        ))
  ;; (setq magit-diff-refine-hunk 'all))

;; TODO: support github in my workflow
;; (use-package forge
;;   :after magit)

(use-package gist
  :defer t
  :commands (gist-list))

;; Highlight changes in git
(use-package git-gutter
  :defer t
  :hook (after-init . global-git-gutter-mode))

(use-package git-gutter-fringe
  :after git-gutter)
;; :config
;; (setq git-gutter-fr:side 'right-fringe))

(provide 'use-vcs)
