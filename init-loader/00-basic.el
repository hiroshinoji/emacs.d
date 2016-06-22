(setq visible-bell t)

;; 自動改行関連
(setq-default auto-fill-mode nil)
(setq-default fill-column 300)
(setq text-mode-hook 'turn-off-auto-fill)

;; delete file if empty
;; ref. http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=delete%20nocontents
(add-hook 'after-save-hook 'delete-file-if-no-contents t)
(defun delete-file-if-no-contents ()
  (when (and buffer-file-name (= (point-min) (point-max)))
    (if (y-or-n-p "Delete file and kill buffer? ")
      (let ((filename buffer-file-name))
        (delete-file filename)
        (kill-buffer (current-buffer))
        (message (concat "Deleted " (file-name-nondirectory filename)))
        ))))

;; モードラインにライン数、カラム数表示
(line-number-mode t)
(column-number-mode t)

;; リージョンを kill-ring に入れないで削除できるようにする
(delete-selection-mode t)

;; TAB はスペース 2 個ぶんを基本
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; 対応するカッコを色表示する
;; 特に色をつけなくてもC-M-p、C-M-n を利用すれば対応するカッコ等に移動できる
(show-paren-mode t)

;; カーソル位置を変更しない
(setq scroll-preserve-screen-position t)
;; shell-mode において最後の行ができるだけウィンドウの一番下にくるようにする
(setq comint-scroll-show-maximum-output t)

;; 終了時に聞く
(setq confirm-kill-emacs 'y-or-n-p)

;;auto chmod+x
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; Sync between OSX clipboard and Emacs yank.
;; from http://hakurei-shain.blogspot.com/2010/05/mac.html
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

;; See https://yono05.wordpress.com/2011/11/20/emacs-と-mac-のクリップボードを共有する/
(when (eq system-type 'darwin)
  (progn (setq interprogram-cut-function 'paste-to-osx)
         (setq interprogram-paste-function 'copy-from-osx)))

(custom-set-variables
 ;; '(truncate-lines           t)              ; truncate line
 '(indent-tabs-mode         nil)            ; don't use tab
 '(make-backup-files        nil)            ; don't make *~ files
 '(find-file-visit-truename t)              ; visit truename
 '(read-file-name-completion-ignore-case t) ; for case insensitive find-file
 '(dired-use-ls-dired nil))                 ; dired ls
