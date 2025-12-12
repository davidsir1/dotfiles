(require 'use-package)
(add-to-list 'load-path "~/.emacs.local/")
;; ------------------------------------------------------------------------
;; Customização

;;; Exibe a linha atual e o número de colunas no mode line
(setq line-number-mode t)
(setq column-number-mode t)
(setq mode-line-position-column-line-format '("%l:%C"))

;;; Exibe o número linhas no buffer atual
(setq-default display-line-numbers-type 'relative)
(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'display-line-numbers-mode))


;;; ido-mode
(ido-mode t)
(ido-everywhere t)

;;; c-mode
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-to-list 'auto-mode-alist '("\\.[b]\\'" . simpc-mode))

;;; Duplicar linha
(defun duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'duplicate-line)

(global-set-key (kbd "M-#") 'compile)

;; ------------------------------------------------------------------------
;; Fonte
(set-face-attribute 'default nil
                    :height 110 :weight 'normal :family "Hack Nerd Font")

;; ------------------------------------------------------------------------
;; Configuração do Corfu
;; Corfu enhances in-buffer completion by displaying a compact popup with
;; current candidates, positioned either below or above the point. Candidates
;; can be selected by navigating up or down.
(use-package corfu
  :ensure t
  :commands (corfu-mode global-corfu-mode)

  :hook ((prog-mode . corfu-mode)
         (shell-mode . corfu-mode)
         (eshell-mode . corfu-mode))

  :custom
  ;; Hide commands in M-x which do not apply to the current mode.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Disable Ispell completion function. As an alternative try `cape-dict'.
  (text-mode-ispell-word-completion nil)
  (tab-always-indent 'complete)

  ;; Enable Corfu
  :config
  (global-corfu-mode))

;; Cape, or Completion At Point Extensions, extends the capabilities of
;; in-buffer completion. It integrates with Corfu or the default completion UI,
;; by providing additional backends through completion-at-point-functions.
(use-package cape
  :ensure t
  :commands (cape-dabbrev cape-file cape-elisp-block)
  :bind ("C-c p" . cape-prefix-map)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

;; ------------------------------------------------------------------------
;; Configuração do tema utilizando doom-themes
(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  :config
  (load-theme 'doom-gruvbox t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  ;;(doom-themes-neotree-config)
  ;; or for treemacs users
  ;;(doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; ------------------------------------------------------------------------
;; Configuração do Org-mode
(use-package org
  :ensure t
  :commands (org-mode org-version)
  :mode
  ("\\.org\\'" . org-mode)
  :custom
  (org-hide-leading-stars t)
  (org-startup-indented t)
  (org-adapt-indentation nil)
  (org-edit-src-content-indentation 0)
  ;; (org-fontify-done-headline t)
  ;; (org-fontify-todo-headline t)
  ;; (org-fontify-whole-heading-line t)
  ;; (org-fontify-quote-and-verse-blocks t)
  (org-startup-truncated t))

;; ------------------------------------------------------------------------
;; Configuração do markdown-mode
(use-package markdown-mode
  :commands (gfm-mode
             gfm-view-mode
             markdown-mode
             markdown-view-mode)
  :mode (("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :init
  (setq markdown-command "multimarkdown")

  :bind
  (:map markdown-mode-map
        ("C-c C-e" . markdown-do)))

;; ------------------------------------------------------------------------
;; Configuração do Eglot
(use-package eglot
  :ensure nil
  :commands (eglot-ensure
             eglot-rename
             eglot-format-buffer)
  :custom
  (eglot-autoshutdown t)
  :config
  (fset #'jsonrpc--log-event #'ignore)
  (setq jsonrpc-event-hook nil)

  ;; configuração dos servidores
  (add-to-list 'eglot-server-programs
               '(simpc-mode . ("clangd-14")))
  )

(add-hook 'simpc-mode-hook #'eglot-ensure)

;; ------------------------------------------------------------------------
;; Configuração do yasnippets
(use-package yasnippet
  :demand t
  :commands yas-minor-mode-on
  :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
  :hook ((prog-mode org-mode) . yas-minor-mode-on)
  )

;; ------------------------------------------------------------------------
;; Configuração do multiple-cursors
(use-package multiple-cursors
  :hook ((multiple-cursors-mode-enabled-hook . (lambda() (corfu-mode -1)))
         (multiple-cursors-mode-disabled-hook . (lambda () (corfu-mode 1))))
  :bind
  (:map prog-mode-map
        ("C-S-c C-S-c" . mc/edit-lines)
        ("C->" . mc/mark-next-like-this)
        ("C-<" . mc/mark-previous-like-this)
        ("C-\"" . mc/skip-to-next-like-this)
        ("C-:" . mc/skip-to-previous-like-this))
  )

;; ------------------------------------------------------------------------
;; web-mode

(use-package web-mode
  :defer t
  :mode (("\\.phtml\\'"      . web-mode)
         ("\\.tpl\\.php\\'"  . web-mode)
         ("\\.twig\\'"       . web-mode)
         ("\\.xml\\'"        . web-mode)
         ("\\.html\\'"       . web-mode)
         ("\\.htm\\'"        . web-mode)
         ("\\.[gj]sp\\'"     . web-mode)
         ("\\.as[cp]x?\\'"   . web-mode)
         ("\\.eex\\'"        . web-mode)
         ("\\.erb\\'"        . web-mode)
         ("\\.mustache\\'"   . web-mode)
         ("\\.handlebars\\'" . web-mode)
         ("\\.hbs\\'"        . web-mode)
         ("\\.eco\\'"        . web-mode)
         ("\\.ejs\\'"        . web-mode)
         ("\\.svelte\\'"     . web-mode)
         ("\\.ctp\\'"        . web-mode)
         ("\\.djhtml\\'"     . web-mode)
         ("\\.vue\\'"        . web-mode))
  :bind (:map web-mode-map
              ;; Quick actions with direct M-g prefix
              ("M-g /" . web-mode-element-close)
              ("M-g k" . web-mode-element-kill)
              ("M-g s" . web-mode-element-select)

              ;; Tag operations (M-g t prefix)
              ("M-g t n" . web-mode-tag-next)
              ("M-g t p" . web-mode-tag-previous)
              ("M-g t m" . web-mode-tag-match)
              ("M-g t s" . web-mode-tag-select)
              ("M-g t b" . web-mode-tag-beginning)
              ("M-g t e" . web-mode-tag-end)

              ;; Element operations (M-g e prefix)
              ("M-g e n" . web-mode-element-next)
              ("M-g e p" . web-mode-element-previous)
              ("M-g e u" . web-mode-element-parent)
              ("M-g e d" . web-mode-element-child)
              ("M-g e k" . web-mode-element-kill)
              ("M-g e w" . web-mode-element-wrap)
              ("M-g e s" . web-mode-element-select)
              ("M-g e c" . web-mode-element-clone)
              ("M-g e r" . web-mode-element-rename)

              ;; Attribute operations (M-g a prefix)
              ("M-g a n" . web-mode-attribute-next)
              ("M-g a p" . web-mode-attribute-previous)
              ("M-g a k" . web-mode-attribute-kill)
              ("M-g a i" . web-mode-attribute-insert)
              ("M-g a s" . web-mode-attribute-select))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-enable-auto-pairing t
        web-mode-enable-css-colorization t))

;; ------------------------------------------------------------------------
;; indent-bars
;;(use-package indent-bars
;;  :hook (
;;         ((prog-mode) . indent-bars-mode)
;;  ))

;; ------------------------------------------------------------------------
;; mood-line
(use-package mood-line
  :config
  (mood-line-mode)

  :custom
  (mood-line-format mood-line-format-default-extended)
  (mood-line-glyph-alist mood-line-glyphs-ascii)
  )

;; ------------------------------------------------------------------------
;; whitespace

(use-package whitespace
  :ensure nil
  :config
  (global-whitespace-mode t)
  (setq whitespace-style '(face tabs tab-mark trailing lines-tail spaces
                                space-mark)
        whitespace-display-mappings
        '((space-mark ?\ [?\u00B7] [?.])
          (space-mark ?\xA0 [?\u00A4] [?_])
          (newline-mark ?\n [?¬ ?\n])
          (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
  )
