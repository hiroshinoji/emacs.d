
(dolist (dir (list
               "/sbin"
               "/usr/sbin"
               "/bin"
               "/usr/bin"
               "/usr/local/bin"
               "/Library/TeX/texbin"
               ;; (expand-file-name "~/bin")
               ;; (expand-file-name "~/local/bin")
               ;; (expand-file-name "~/.emacs.d/bin")
               ))

  (when (and (file-exists-p dir) (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))

(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8-auto)
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; (set-default-coding-systems 'utf-8)

;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-buffer-file-coding-system 'utf-8)
