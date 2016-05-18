
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

