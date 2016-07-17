
(add-to-list 'load-path "~/.emacs.d/lisp")   

;; flyspell check
;;
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(dolist (hook '(text-mode-hook))
     (add-hook hook (lambda () (flyspell-mode 1))))
    (dolist (hook '(change-log-mode-hook log-edit-mode-hook))
     (add-hook hook (lambda () (flyspell-mode -1))))

;;;;;;line number ;;;;;;;;
;; line number on the left
;(require 'linum+)
;(require 'nlinum)
;(require 'linum)
;(global-linum-mode t)
;(setq linum-format "%4d")
;;;;;;;;;;;;;;;;;;;;


;;;; auto complete mode
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict") 
(global-auto-complete-mode t)
(defun auto-complete-mode-maybe ()
;  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))
;; have auto check and flyspell work at the same time
(ac-flyspell-workaround)


;;;;;;;;;;; or company mode, haven't set tab ;;;;;;;;;;;;;;
;(eval-after-load 'company
;  '(progn
;     (define-key company-active-map (kbd "TAB") 'company-select-next)
;     (define-key company-active-map [tab] 'company-select-next)
;	 (define-key company-active-map (kbd "TAB") 'company-selection-wrap-around)
;     (define-key company-active-map [tab] 'company-selection-wrap-around)
;	 (define-key company-active-map (kbd "TAB") 'company-complete-selection)
;	 (define-key company-active-map [tab] 'company-complete-selection)
;	 ))
;(global-set-key "\t" 'indent-or-complete)
;(defun indent-or-complete ()
;    (interactive)
;    (if (looking-at "\\_>")
;        (company-complete-common)
;      (indent-according-to-mode)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; line wrap word
(global-visual-line-mode t)

;; auto indent
(add-hook 'c-mode-common-hook '(lambda ()
      (local-set-key (kbd "RET") 'newline-and-indent)))

;; do not auto indent paraenthesis
(setq c-default-style "linux"
          c-basic-offset 4)

;; set indent width to two
 (setq-default c-basic-offset 4
                  tab-width 4
                  indent-tabs-mode t)

;; disable fontify script
(eval-after-load "tex-mode" '(fset 'tex-font-lock-suscript 'ignore))

;;;;;;;;;;;;;;;;; mass comment ;;;;;;;;;;;;;;;;
;(define-prefix-command 'comment-map)

;(defun uncomment-region (beg end)
;  "Uncomment a region of text"
;  (interactive "r")
;  (comment-region beg end -1))


;; (global-set-key (kbd "C-p") 'comment-map)
;; (define-key comment-map (kbd "C-r") 'comment-region)
;; (define-key comment-map (kbd "C-t") 'uncomment-region)
;; (use-local-map (make-sparse-keymap))


;; mouse scroll slower
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1) ((control) . nil))) 
(setq mouse-wheel-progressive-speed nil)

;; do not auto copy selected region?
(setq select-active-regions nil)
(setq mouse-drag-copy-region nil)

;;;;;;;;;;;;; AucTex related ;;;;;;;;;;;;;;;;;
;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)

;compile tex as PDF
(setq TeX-PDF-mode t)

;view the pdf using evince
(setq TeX-view-program-selection '((output-pdf "Evince")))
 
; enable source specials or SyncTeX to be enable to compile it to a forward / backword searching.
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
 
; always start emacs server when viewing in evance for backward search
(setq TeX-source-correlate-start-server t)
(setq font-latex-fontify-script nil)

; Add Texify and TexifyPDF functionality to C-c C-c
(add-hook 'LaTeX-mode-hook 
      (lambda ()
        (add-to-list 'TeX-command-list
             '("Texify" "texify -b %t" TeX-run-command t (latex-mode) :help "Texify document to dvi (resolves all cross-references, etc.)") t)
        (add-to-list 'TeX-command-list
             '("TexifyPDF" "texify -b -p %t" TeX-run-command t (latex-mode) :help "Texify document to pdf (resolves all cross-references, etc.)") t)
        ))

; add a short cut for pdflatex
(defun my-run-latex ()
   (interactive)
   (TeX-save-document (TeX-master-file))
   (TeX-command "LaTeX" 'TeX-master-file -1)
)
(defun my-LaTeX-hook ()
  (local-set-key (kbd "C-c C-f") 'my-run-latex))
(add-hook 'LaTeX-mode-hook 'my-LaTeX-hook)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

;; disable fontify script
(eval-after-load "tex-mode" '(fset 'tex-font-lock-suscript 'ignore))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; line number mode
(global-linum-mode t)
(setq linum-format "%4d ")

;; turn off auto indent
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(cua-mode t nil (cua-base))
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 143 :width normal))))
 '(font-latex-bold-face ((t nil)))
 '(font-latex-doctex-documentation-face ((t nil)))
 '(font-latex-doctex-preprocessor-face ((t nil)))
 '(font-latex-italic-face ((t nil)))
 '(font-latex-sectioning-0-face ((t nil)))
 '(font-latex-sectioning-1-face ((t nil)))
 '(font-latex-sectioning-2-face ((t nil)))
 '(font-latex-sectioning-3-face ((t nil)))
 '(font-latex-sectioning-4-face ((t nil)))
 '(font-latex-sectioning-5-face ((t nil)))
 '(font-latex-sedate-face ((t nil)))
 '(font-latex-slide-title-face ((t nil)))
 '(font-latex-string-face ((t nil)))
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil)))
 '(font-latex-verbatim-face ((t nil)))
 '(font-latex-warning-face ((t nil)))
 )
