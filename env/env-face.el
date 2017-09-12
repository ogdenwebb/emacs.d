;; Custom theme load
(defadvice load-theme (before clear-previous-themes activate)
  "Clear existing theme settings instead of layering them"
  (mapc #'disable-theme custom-enabled-themes))

;; Theme settings
;; noctilux
;; bliss
;; boron
;; base16-default-dark
;; danneskjold-theme
;; flatland-theme

;; Load my theme
(use-package kaolin-theme
  :load-path "themes/kaolin-theme"
  :init
  ;; Set default theme
  (defun load-my-theme (frame)
    (select-frame frame)
    (load-theme 'kaolin t))

  (if (daemonp)
      (add-hook 'after-make-frame-functions #'load-my-theme)
    (load-theme 'kaolin t))

  :config
  ;; Highlight t and nil in elisp-mode
  (font-lock-add-keywords 'emacs-lisp-mode
    '(("\\<\\(nil\\|t\\)\\>" . 'kaolin-boolean))))

;; Set default font
;; TODO: Error: highlight-indent-guides cannot auto set faces:
;; `default' face is not set properly
(add-to-list 'default-frame-alist '(font . "Roboto Mono-11"))

;; (let ((default-font "Iosevka-12"))
;;   (assq-delete-all 'font default-frame-alist)
;;   (add-to-list 'default-frame-alist
;;          `(font . ,default-font))
;;   (set-frame-font default-font))

  ;; (set-face-attribute 'default t
  ;;                     :family "Roboto Mono for Powerline"
  ;;                     :height 110
  ;;                     :weight 'normal
  ;;                     :width  'normal))

;; Set the fringe size
(setq-default left-fringe-width  6)
(setq-default right-fringe-width 8)

;; Disable newline markers in fringe
;; (setq overflow-newline-into-fringe nil)
(setf (cdr (assq 'truncation fringe-indicator-alist)) '(nil nil))

(define-fringe-bitmap 'right-curly-arrow
  [#b00000000
   #b00000000
   #b00000000
   #b00000000
   #b00000000
   #b00000000
   #b00000000
   #b00000000])
(define-fringe-bitmap 'left-curly-arrow
  [#b00000000
   #b00000000
   #b00000000
   #b00000000
   #b00000000
   #b00000000
   #b00000000
   #b00000000])

;; Need to show fringe in vertical split
(setq-default fringes-outside-margins t)


;; Highlight current line
(global-hl-line-mode 1)

;; Disable scroll bars
(defun my/disable-scroll-bars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))

(add-hook 'after-make-frame-functions 'my/disable-scroll-bars)

;; Hide toolbar and menu
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Disable startup/splash screen
;; (setq initial-scratch-message nil)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(defalias 'display-startup-echo-area-message #'ignore)

;; Disable cursor in non selected windows
(setq-default cursor-in-non-selected-windows nil)

;;;; Packages

;; Highlight numbers
(use-package highlight-numbers
  :config
  (add-hook 'prog-mode-hook 'highlight-numbers-mode))

;; Highlight defined Emacs Lisp symbols in source code
(use-package highlight-defined
  :config
  (add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode))

;; Highlight parenthess
(use-package paren
  :config
  (show-paren-mode 1)        ; Automatically highlight parenthesis pairs
  (setq show-paren-delay 0)) ; show the paren match immediately

;; Highlight quoted symbols
(use-package highlight-quoted
  :config
  (add-hook 'emacs-lisp-mode-hook 'highlight-quoted-mode))

;; Dim innactive windows
;; (use-package auto-dim-other-buffers
;;   :config
;; (auto-dim-other-buffers-mode))

;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode))

;; Show indent line
;; TODO: disable in swiper
;; (use-package highlight-indent-guides
;;   :init
;;   (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;;   :config
;;   (setq highlight-indent-guides-method 'character)
;;   ;; Indent character samples: | ┆ ┊
;;   (setq highlight-indent-guides-character ?\┆))


;; Line numbering
(use-package nlinum
    :init
    (setq nlinum-format "%4d ")
    (setq nlinum-highlight-current-line t)
    (add-hook 'prog-mode-hook 'nlinum-mode)
    (add-hook 'text-mode-hook 'nlinum-mode))

;; Dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  ;; Set the title
  (setq dashboard-banner-logo-title "I know no Evil")
  ;; Set the banner
  (setq dashboard-startup-banner 'logo)

  (setq dashboard-items
        '((recents   . 5)
          (bookmarks . 10)
          (projects  . 10))))

;; Icons
(use-package all-the-icons)

;; Highlight TODO and FIXME
(use-package fic-mode
  :config
  (add-hook 'prog-mode-hook 'fic-mode))

(provide 'env-face)
