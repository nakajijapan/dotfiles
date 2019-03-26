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

;; マウスホイールでスクロール
(defun scroll-down-with-lines ()
  ""
  (interactive)
  (scroll-down 1)
  )
(defun scroll-up-with-lines ()
   ""
   (interactive)
   (scroll-up 1)
)
;;　キーバインドは適宜変更
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)

;; スクロールステップを 1 に設定
(setq scroll-step 1)

;;-------------------------------------
;; 補完関連
;;-------------------------------------
;; 補完機能をしよう
(require 'auto-complete)

;; 補完機能自動起動
(global-auto-complete-mode t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; PHP
(add-hook  'php-mode-hook
           (lambda ()
             (require 'php-completion)
             (php-completion-mode t)
             (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
             (when (require 'auto-complete nil t)
               (make-variable-buffer-local 'ac-sources)
               (add-to-list 'ac-sources 'ac-source-php-completion)
               (auto-complete-mode t))))

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

;; inent
(setq-default tab-width 2)
(setq-default tab-width 2 indent-tabs-mode nil)

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
;; rubyモード
;;----------------------------------------
(setq ruby-insert-encoding-magic-comment nil)

(autoload 'ruby-mode "ruby-mode"
            "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$latex " . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(setq ruby-indent-level 2)

(add-hook 'makefile-mode-hook
          (function (lambda ()
                     (setq indent-tabs-mode t))))

;;; 種類ごとの色
(add-hook 'font-lock-mode-hook
  '(lambda ()
     (set-face-foreground 'font-lock-comment-face "Green")
     (set-face-foreground 'font-lock-string-face "#DB2C38")
     (set-face-foreground 'font-lock-keyword-face "#B21889")
     (set-face-foreground 'font-lock-variable-name-face "LightGoldenrod")
     (set-face-foreground 'font-lock-type-face "#00A0BE")
     (set-face-foreground 'font-lock-constant-face "#00A0BE")
     (set-face-foreground 'font-lock-warning-face "Pink")
     )
  )

