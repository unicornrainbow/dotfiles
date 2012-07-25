;;; This came from Greg V's dotfiles:
;;;      https://github.com/myfreeweb/dotfiles
;;; Feel free to steal it, but attribution is nice

(setq emacs-dir "~/.emacs.d")
(add-to-list 'load-path emacs-dir)
(defun addpath (dir)
  (add-to-list 'load-path (concat emacs-dir "/" dir)))

;;; Encoding, input
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")

;;; General settings
(fset 'yes-or-no-p 'y-or-n-p)
(server-start t)
(cua-mode t)
(ido-mode t)
(show-paren-mode t)
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
      ido-create-new-buffer 'always
      ido-enable-flex-matching t
      ido-everywhere t
      ido-ignore-buffers (append '(".*Completion" "*magit-process*" "*Pymacs*" "*Messages*") ido-ignore-buffers)
      ido-ignore-extensions t
      ido-confirm-unique-completion t
      ido-max-directory-size 100500
      ido-use-filename-at-point 'guess
      kill-buffer-query-functions (remq 'process-kill-buffer-query-function
                                        kill-buffer-query-functions)
      redisplay-dont-pause t)
(setq-default indent-tabs-mode nil
              tab-width 2)

;;; Aliases
(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'qrr 'query-replace-regexp)
(defalias 'ind 'indent-according-to-mode)
(defalias 'lcs 'downcase-region)

;;; Keyboard shortcuts
(global-set-key (kbd "C-c C-f") 'find-grep-dired)
(global-set-key (kbd "C-'") 'comment-or-uncomment-region)
(global-set-key (kbd "C-k") 'kill-whole-line)

;;; Plugins
(addpath "evil")
(addpath "evil/lib")
(require 'cl)
(require 'evil)
(evil-mode t)
(define-key evil-normal-state-map (kbd "k") 'evil-next-line)
(define-key evil-normal-state-map (kbd "j") 'evil-previous-line)
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(addpath "surround")
(require 'surround)
(global-surround-mode t)

(addpath "vimvars")
(require 'vimvars)
(add-hook 'find-file-hook 'vimvars-obey-vim-modeline)

(addpath "smart-tab")
(require 'smart-tab)
(global-smart-tab-mode t)

(addpath "popwin")
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

(addpath "autopair")
(require 'autopair)
(autopair-global-mode)

(addpath "color-theme")
(addpath "color-theme-solarized")
(require 'color-theme)
(require 'color-theme-solarized)
(color-theme-initialize)
(color-theme-solarized-light)

(addpath "clojure")
(require 'clojure-mode)
