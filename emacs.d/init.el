;;; This came from Greg V's dotfiles:
;;;      https://github.com/myfreeweb/dotfiles
;;; Feel free to steal it, but attribution is nice
;;;
;;; Thanks:
;;;   https://github.com/edtsech/clojure-emacs-setup
;;;   http://whattheemacsd.com
;;;   https://github.com/bodil/emacs.d


;; Fix the PATH variable
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

;; Submodules
(setq emacs-dir "~/.emacs.d")
(add-to-list 'load-path emacs-dir)
(defun addpath (dir)
  (add-to-list 'load-path (concat emacs-dir "/" dir)))
(addpath "vendor")

;; Packages
(defvar my-packages '(; General
                      color-theme-railscasts
                      starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      autopair
                      popwin
                      smart-tab
                      diminish
                      powerline
                      ; Vim
                      evil
                      evil-paredit
                      surround
                      ; Lisp
                      clojure-mode
                      clojure-test-mode
                      kibit-mode
                      nrepl
                      ac-nrepl
                      nrepl-ritz
                      align-cljlet
                      paredit
                      rainbow-delimiters
                      highlight-parentheses
                     ))
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;; General settings
(set-face-attribute 'default nil :font "Source Code Pro-14")
(setq ido-everywhere t
      ido-ignore-buffers (append '(".*Completion" "*magit-process*" "*Pymacs*" "*Messages*") ido-ignore-buffers)
      ido-ignore-extensions t
      ido-confirm-unique-completion t
      ido-max-directory-size 100500)
(add-hook 'ido-setup-hook
    (lambda () ;; Go straight home
      (define-key ido-file-completion-map
        (kbd "~")
        (lambda ()
          (interactive)
          (if (looking-back "/")
              (insert "~/")
            (call-interactively 'self-insert-command))))))
(show-paren-mode t)
(global-hl-line-mode t)
(savehist-mode t)
(recentf-mode t)
(delete-selection-mode t)
(toggle-truncate-lines -1)
(auto-fill-mode -1)
(when (functionp 'tooltip-mode)
  (tooltip-mode -1))
(when (functionp 'tool-bar-mode)
  (tool-bar-mode -1))
(if (featurep window-system)
    (modify-frame-parameters nil '((wait-for-wm . nil)))
  (menu-bar-mode -1))
(if (featurep 'aquamacs) (one-buffer-one-frame-mode -1))

(setq backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      edit-server-new-frame nil
      word-wrap nil
      x-select-enable-clipboard t
      confirm-nonexistent-file-or-buffer nil
      delete-by-moving-to-trash t
      next-line-add-newlines t
      tooltip-use-echo-area t
      vc-handled-backends '()
      kill-buffer-query-functions (remq 'process-kill-buffer-query-function
                                        kill-buffer-query-functions)
      redisplay-dont-pause t)
(setq-default indent-tabs-mode nil
              tab-width 2)

;;; Functions
(defun comment-or-uncomment-line ()
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))

(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (move-to-column col)))

(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))
(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map
              (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))

;;; Plugins
;; Vim stuff
(require 'cl)
(require 'evil)
(evil-mode t)
(define-key evil-normal-state-map (kbd "k") 'evil-next-line)
(define-key evil-visual-state-map (kbd "k") 'evil-next-line)
(define-key evil-normal-state-map (kbd "j") 'evil-previous-line)
(define-key evil-visual-state-map (kbd "j") 'evil-previous-line)
(define-key evil-normal-state-map (kbd "C-h") 'windmove-left)
(define-key evil-normal-state-map (kbd "C-k") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-j") 'windmove-up)
(define-key evil-normal-state-map (kbd "C-l") 'windmove-right)
(define-key evil-normal-state-map (kbd "C-p") 'ffip)
(define-key evil-normal-state-map (kbd "C-o") 'ido-find-file)
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-normal-state-map (kbd "]e") 'move-line-down)
(define-key evil-normal-state-map (kbd "[e") 'move-line-up)
(define-key evil-normal-state-map "\\" 'comment-or-uncomment-line)
(define-key evil-visual-state-map "\\" 'comment-or-uncomment-region)
(define-key evil-normal-state-map (kbd "<left>") 'previous-buffer)
(define-key evil-normal-state-map (kbd "<right>") 'next-buffer)
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(addpath "vimvars")
(require 'vimvars)
(add-hook 'find-file-hook 'vimvars-obey-vim-modeline)

(require 'surround)
(global-surround-mode t)

(global-linum-mode t)

;; Lisp stuff
(require 'clojure-mode)
(require 'align-cljlet)
(require 'ac-nrepl)
(require 'nrepl)
(require 'nrepl-ritz)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(add-hook 'nrepl-mode-hook 'subword-mode)
(setq nrepl-popup-stacktraces nil)
(setq nrepl-hide-special-buffers t)
(add-to-list 'same-window-buffer-names "*nrepl*")
(define-key nrepl-interaction-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
(define-key nrepl-mode-map (kbd "C-c C-j") 'nrepl-javadoc)
(define-key nrepl-interaction-mode-map (kbd "C-c C-a") 'nrepl-apropos)
(define-key nrepl-mode-map (kbd "C-c C-a") 'nrepl-apropos)

(require 'midje-test-mode)
(setenv "MIDJE_COLORIZE" "false") 

(require 'auto-complete-config)
(ac-config-default)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'clojure-mode))
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'clojure-mode-hook 'ac-nrepl-setup)

(require 'paredit)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)

(require 'autopair)
(autopair-global-mode)

(eval-after-load 'find-file-in-project '(add-to-list 'ffip-patterns "*.clj"))

(require 'powerline)
(powerline-default-theme)

;; Color stuff
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode (lambda () (highlight-parentheses-mode t)))

(custom-set-variables '(hl-paren-colors (quote ("orange" "yellow" "greenyellow" "green" "springgreen" "cyan" "slateblue" "magenta" "purple"))))
(add-hook 'clojure-mode-hook 'highlight-parentheses-mode)
(add-hook 'nrepl-mode-hook 'highlight-parentheses-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)

(require 'color-theme)
(require 'color-theme-railscasts)
(color-theme-initialize)
(color-theme-railscasts)

(defface esk-paren-face ; Set parentheses color
   '((((class color) (background dark))
      (:foreground "grey40"))
     (((class color) (background light))
      (:foreground "grey55")))
   "Face used to dim parentheses."
   :group 'starter-kit-faces)

(font-lock-add-keywords 'clojure-mode '(("(\\|)" . 'esk-paren-face)))
(font-lock-add-keywords 'nrepl-mode '(("(\\|)" . 'esk-paren-face)))
(font-lock-add-keywords 'emacs-lisp-mode '(("(\\|)" . 'esk-paren-face)))

;; Stuff
(require 'smart-tab)
(global-smart-tab-mode t)

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;; Diminish modeline clutter
(require 'diminish)
(diminish 'undo-tree-mode)
(diminish 'smart-tab-mode)
(require 'elisp-slime-nav)
(diminish 'elisp-slime-nav-mode)
(diminish 'highlight-parentheses-mode)
