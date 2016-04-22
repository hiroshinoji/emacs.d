;; It is a bit complicated to manage depencdencies in helm with el-get. So all settings are placed here.
(require 'helm)
(require 'helm-config)
(require 'helm-ag)
(require 'helm-ls-git)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") #'helm-mini)

(helm-mode 1)
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;; helm-ag
(setq helm-ag-insert-at-point 'symbol)
(global-set-key (kbd "M-a") 'helm-ag)
(global-set-key (kbd "M-k") 'backward-kill-sexp)

(custom-set-variables
 '(helm-truncate-lines t)
 '(helm-delete-minibuffer-contents-from-point t)
 '(helm-ff-skip-boring-files t)
 '(helm-boring-file-regexp-list '("~$" "\\.elc$"))
 '(helm-ls-git-show-abs-or-relative 'relative)
 '(helm-mini-default-sources '(helm-source-buffers-list
                               helm-source-files-in-current-dir
                               helm-source-ls-git
                               helm-source-recentf)))


(define-key isearch-mode-map (kbd "M-o") 'helm-multi-swoop-all-from-isearch)

(require 'helm-migemo)
;;; この修正が必要
(eval-after-load "helm-migemo"
  '(defun helm-compile-source--candidates-in-buffer (source)
     (helm-aif (assoc 'candidates-in-buffer source)
         (append source
                 `((candidates
                    . ,(or (cdr it)
                           (lambda ()
                             ;; Do not use `source' because other plugins
                             ;; (such as helm-migemo) may change it
                             (helm-candidates-in-buffer (helm-get-current-source)))))
                   (volatile) (match identity)))
       source)))

(require 'helm-swoop)

(global-set-key (kbd "M-o") 'helm-swoop)

