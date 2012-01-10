;;-------------------------------------
;; 基本機能
;;-------------------------------------
; encoding
(prefer-coding-system 'utf-8)

;; ファイル読み込み
(setq load-path (cons "~/.emacs.d/elisp" load-path))

;; まず、install-elisp のコマンドを使える様にします。
(require 'install-elisp)

;; 次に、Elisp ファイルをインストールする場所を指定します。
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; 選択範囲に色を付ける
;;(install-elisp "http://taiyaki.org/elisp/sense-region/src/sense-region.el")
(require 'sense-region)
(sense-region-on)

;; 日付を表示する
(define-key global-map [f5]
  '(lambda ()
     (interactive)
     (insert (format-time-string "%Y/%m/%d %H:%M:%S"))))




;;-------------------------------------
;; 操作機能
;;-------------------------------------

;; 自動バックアップ機能しない
(setq make-backup-files nil)

;; key set
(global-set-key "\C-h" 'delete-backward-char)
(put 'upcase-region 'disabled nil)

;; undo
(global-set-key "\C-z" 'undo)

;; 次に、Elisp ファイルをインストールする場所を指定します。
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; nobackup
(setq make-backup-files nil)

(setq-default tab-width 4)
(setq-default tab-width 4 indent-tabs-mode nil)

;; タブ, 全角スペース、改行直前の半角スペースを表示する
(when (require 'jaspace nil t)
  (when (boundp 'jaspace-modes)
    (setq jaspace-modes (append jaspace-modes
                                (list 'php-mode
                                      'yaml-mode
                                      'javascript-mode
                                      'ruby-mode
                                      'text-mode
                                      'fundamental-mode))))
  (when (boundp 'jaspace-alternate-jaspace-string)
    (setq jaspace-alternate-jaspace-string "□"))
  (when (boundp 'jaspace-highlight-tabs)
    (setq jaspace-highlight-tabs ?^))
  (add-hook 'jaspace-mode-off-hook
            (lambda()
              (when (boundp 'show-trailing-whitespace)
                (setq show-trailing-whitespace nil))))
  (add-hook 'jaspace-mode-hook
            (lambda()
              (progn
                (when (boundp 'show-trailing-whitespace)
                  (setq show-trailing-whitespace t))
                (face-spec-set 'jaspace-highlight-jaspace-face
                               '((((class color) (background light))
                                  (:foreground "blue"))
                                 (t (:foreground "green"))))
                (face-spec-set 'jaspace-highlight-tab-face
                               '((((class color) (background light))
                                  (:foreground "red"
                                   :background "unspecified"
                                   :strike-through nil
                                   :underline t))
                                 (t (:foreground "purple"
                                     :background "unspecified"
                                     :strike-through nil
                                     :underline t))))
                (face-spec-set 'trailing-whitespace
                               '((((class color) (background light))
                                  (:foreground "red"
                                   :background "unspecified"
                                   :strike-through nil
                                   :underline t))
                                 (t (:foreground "purple"
                                     :background "unspecified"
                                     :strike-through nil
                                     :underline t))))))))

;;----------------------------------------
;;PHPモード
;;----------------------------------------
(autoload 'php-mode "php-mode" "PHP mode" t)
(defcustom php-file-patterns (list "\\.php[s34]?\\'" "\\.phtml\\'" "\\.inc\\'")
"*List of file patterns for which to automatically invoke php-mode."
:type '(repeat (regexp :tag "Pattern"))
:group 'php)
(let ((php-file-patterns-temp php-file-patterns))
(while php-file-patterns-temp(add-to-list 'auto-mode-alist
(cons (car php-file-patterns-temp) 'php-mode))
(setq php-file-patterns-temp (cdr php-file-patterns-temp))))

;;(add-hook 'php-mode-user-hook
;;'(lambda ()
;;(setq tab-width 4)
;;(setq indent-tabs-mode nil))
;;)

(add-hook 'php-mode-hook '(lambda ()
    (setq c-basic-offset 4)
    (setq c-tab-width 4)
;;    (setq c-argdecl-indent 0)
;;    (setq c-auto-newline nil)
;;    (setq c-continued-statement-offset 0)
;;    (setq c-indent-level 4)
;;    (setq c-label-offset -4)
;;    (setq c-tab-always-indent t)
    (setq indent-tabs-mode nil)
    (setq tab-width 4)
    (setq-default tab-width 4)
) t)


;;----------------------------------------
;; rubyモード
;;----------------------------------------
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))

;; ruby-electric.el --- electric editing commands for ruby files(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

(setq ruby-indent-level 4)
(setq ruby-indent-tabs-mode nil)
