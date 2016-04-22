;; 縦と横の3分割
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))

(global-set-key "\C-x4" '(lambda ()
			  (interactive)
			  (split-window-vertically-n 3)))
(global-set-key "\C-x5" '(lambda ()
			  (interactive)
			  (split-window-horizontally-n 3)))

(setq inhibit-startup-message t)

;; scratch のメッセージを空にする
;; (setq initial-scratch-message nil)

(menu-bar-mode -1)

(require 'whitespace)
;; visualize whitespace
(setq whitespace-global-modes '(not)
      whitespace-style '(face tabs tab-mark fw-space-mark lines-tail))
;; tab
(setcar (nthcdr 2 (assq 'tab-mark whitespace-display-mappings)) [?> ?\t])
(let ((face  'whitespace-tab))
  (set-face-background face nil)
  (set-face-attribute face nil :foreground "gray30" :strike-through t))
;; full-width space
(defface full-width-space
  '((((class color) (background light)) (:foreground "azure3"))
    (((class color) (background dark)) (:foreground "pink4")))
  "Face for full-width space"
  :group 'whitespace)
(let ((fw-space-mark (make-glyph-code #x25a1 'full-width-space)))
  (add-to-list 'whitespace-display-mappings
               `(fw-space-mark ?　 ,(vector fw-space-mark))))
;; patch
(defsubst whitespace-char-or-glyph-code-valid-p (char)
  (let ((char (if (consp char) (car char) char)))
    (or (< char 256) (characterp char))))
(defadvice whitespace-display-vector-p (around improved-version activate)
  (let ((i (length vec)))
    (when (> i 0)
      (while (and (>= (setq i (1- i)) 0)
                  (whitespace-char-or-glyph-code-valid-p (aref vec i))))
      (setq ad-return-value (< i 0)))))
;; activate
(global-whitespace-mode)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)
(add-hook 'comint-mode-hook #'(lambda() (setq show-trailing-whitespace nil)))
