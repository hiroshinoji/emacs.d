(require 'markdown-mode)

;; gfm = Github flavoured Mark Down
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

;; by "C-c C-c p", 
(setq markdown-command "multimarkdown")
