(require 'ag)
(require 'wgrep)

(setq default-process-coding-system 'utf-8-unix)
(setq ag-highlight-search t)

(add-hook 'ag-mode-hook '(lambda ()
			   (require 'wgrep-ag)
			   (setq wgrep-enable-key "e")
			   (setq wgrep-auto-save-buffer t)
			   (wgrep-ag-setup)))
