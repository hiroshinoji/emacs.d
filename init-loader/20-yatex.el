;; (require 'yatex)

(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(with-eval-after-load 'yatex
  (setq tex-command "~/Library/TeXShop/bin/platex2pdf-utf8"   ; eucの場合はplatex2pdf-euc
        dvi2-command "open -a Preview")

  (setq YaTeX-dvi2-command-ext-alist
        '(("Preview\\|TeXShop\\|TeXworks\\|Skim\\|mupdf\\|xpdf\\|Firefox\\|Adobe" . ".pdf")))

  (setq YaTeX-kanji-code 4)
  (setq YaTeX-use-AMS-LaTeX t))
