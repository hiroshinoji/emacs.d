;; http://tarao.hatenablog.com/entry/20150221/1424518030#fn-5aab7793
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(eval-when-compile (require 'cl))

;; package.el setting
(require 'package)
(add-to-list 'package-archives '("melpa"     . "http://melpa.milkbox.net/packages/")  t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
;; install if not installed
(defvar my-package-list
  '(ag
    ace-isearch
    atom-one-dark-theme
    auto-async-byte-compile
    backup-each-save
    ;;auto-complete
    company
    cperl-mode
    direx
    helm
    helm-ag
    helm-descbinds
    helm-ls-git
    helm-migemo
    helm-swoop
    init-loader
    js2-mode
    magit
    markdown-mode
    migemo
    open-junk-file
    tangotango-theme
    recentf-ext
    real-auto-save
    ruby-mode
    wgrep
    wgrep-ag
    sbt-mode
    scala-mode2
    seti-theme
    win-switch
    yasnippet
    yatex))

(let ((not-installed
       (loop for package in my-package-list
             when (not (package-installed-p package))
             collect package)))
  (when not-installed
    (package-refresh-contents)
    (dolist (package not-installed)
      (package-install package))))

(require 'init-loader)
(setq-default init-loader-show-log-after-init nil
              init-loader-byte-compile t)
(init-loader-load (locate-user-emacs-file "init-loader"))

;; after init
(add-hook 'after-init-hook
          (lambda ()
            (load-theme 'tangotango t)
            (windmove-default-keybindings) ;; This does not work unless placed here for some reasons.
            ;; split window
            ;; (split-window-horizontally)
            ;; show init time
            (message "init time: %.3f sec"
                     (float-time (time-subtract after-init-time before-init-time)))))
