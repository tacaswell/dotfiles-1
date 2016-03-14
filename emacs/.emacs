(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
	       '("elpy" . "https://jorgenschaefer.github.io/packages/"))
  (setq package-enable-at-startup nil)
  )



(add-to-list 'load-path "~/.emacs.d/site-lisp/magit/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/mdboom_gh")
(require 'magit)

(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/site-lisp/magit/Documentation/"))

(setq magit-last-seen-setup-instructions "1.4.0")
;(add-to-list 'load-path "~/.emacs.d")
;(add-to-list 'load-path "~/.emacs.d/emacs-jabber")
;(add-to-list 'load-path "~/.emacs.d/git-emacs")
;(require 'jabber-autoloads)

(add-hook 'jabber-chat-mode-hook (lambda () (flyspell-mode t)))
(add-hook 'rst-mode-hook (lambda () (flyspell-mode t)))

(setq yas-triggers-in-field t)

;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (let (el-get-master-branch)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp))))

;; (el-get 'sync)
;; (set-frame-font "6x10")

;; ;;to set foreground color to white
;; (set-foreground-color "white")

;; ;;to set background color to black
;; (set-background-color "black")

;; (set-cursor-color "white")

;; (set-mouse-color "white")

(add-to-list 'default-frame-alist '(mouse-color . "white"))
(add-to-list 'default-frame-alist '(cursor-color . "white"))
(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(foreground-color . "white"))

;(server-start)

;; Python
;;switching to fancy new python mode
;(setq load-path (append load-path (list "~/.emacs.d/python-mode")))
;(require 'python-mode)
;(require 'ipython)

;;load-path

;; loads fly spell and turns off the blasted word completion
(autoload 'flyspell-mode "flyspell" "On-the-fly ispell." t)
(setq flyspell-use-meta-tab nil)


;(iswitchb-mode t)

;;junk from steve yegge
;(global-set-key "\C-x\C-m" 'execute-extended-command)
;;;nukes scroll bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))


(global-set-key "\C-h" 'backward-delete-char-untabify)
(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
(global-set-key [(super h)] 'help-command)
(global-set-key "\M-h" 'backward-kill-word)
(global-unset-key "\C-z")

;; makes name spaces not indent, set up indent on blocks
(setq c-offsets-alist
      '((innamespace . 0) (substatement-open . 0)))


;; clock
(setq display-time-24hr-format t)
(display-time-mode 1)


(defun insert-comment-block ()
  "inserts javadoc style comment block"
  (interactive "*")
    (save-excursion
    (let ((start (point)))
      (insert "/**\n\n*/")
      (indent-region start (point))
      )
    )
  (next-line)
  (end-of-line)
  (c-indent-command)
  )

(defun insert-python-code-block ()
  "inserts javadoc style comment block"
  (interactive "*")
    (save-excursion
    (let ((start (point)))
      (insert "#+BEGIN_SRC python\n\n#+END_SRC")
      (indent-region start (point))
      )
    )
  (next-line)
  (end-of-line)
  )



(defun my-change-comment ()
  "inserts name and date for changing code"
  (interactive "*")
  (save-excursion
    (let ((start (point)))
      (insert "tac ")
      (insert-date-string)
      (comment-region start (point))
      (comment-indent-new-line)
      )
    )
  (next-line)
  (end-of-line)
  )


(defun insert-date-string ()
  "Insert a nicely formated date string."
  (interactive "*")
  (insert (format-time-string "%Y-%m-%d") )
  )




(defun my-compile-hook ()
  (local-set-key "\C-cp" 'compile)
  (local-set-key "\C-cc" 'insert-comment-block)
  (local-set-key "\C-c\C-c" 'comment-or-uncomment-region)
  (local-set-key "\C-cu" 'comment-or-uncomment-region)
  (local-set-key "\C-ct" 'my-change-comment)
  (local-set-key "\C-h" 'c-electric-backspace)
)

(add-hook 'c-mode-common-hook 'my-compile-hook)
(add-hook 'c-mode-common-hook (lambda () (flyspell-mode t)))
(add-hook 'c-mode-common-hook (lambda () (flyspell-prog-mode)))
(add-hook 'c-mode-common-hook (lambda () (c-toggle-auto-state)))
(add-hook 'c-mode-common-hook (lambda () (c-toggle-hungry-state)))

(add-hook 'python-mode-hook (lambda () (flyspell-mode t)))
(add-hook 'python-mode-hook (lambda () (flyspell-prog-mode)))
(add-hook 'python-mode-hook (lambda () (flymake-mode t)))
;(add-hook 'python-mode-hook (lambda () (flymake-cursor-mode t)))

(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-hook 'org-mode-hook (lambda () (flyspell-mode t)))


(setq mail-default-headers "BCC:tcaswell@gmail.com\n")
(setq mail-from-style 'angles)




;;;set up shift arrows to move
(windmove-default-keybindings)

;;; Other settings:


;; Syntax highlighting:
(global-font-lock-mode t)
(setq transient-mark-mode nil)



(mouse-wheel-mode t)

(put 'narrow-to-region 'disabled nil)

;(load-file "~/.emacs.d/psvn.el")


;(load "/usr/share/emacs22/site-lisp/cedet-common/cedet.elc")
;; Load CEDET
;;(load-file "~/.emacs.d/cedet-1.0pre4/common/cedet.el")

;;(require 'cedet)
;; Enabling various SEMANTIC minor modes.  See semantic/INSTALL for more ideas.
;; Select one of the following:

;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as the nascent intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-guady-code-helpers)

;; * This turns on which-func support (Plus all other code helpers)
;; (semantic-load-enable-excessive-code-helpers)

;; This turns on modes that aid in grammar writing and semantic tool
;; development.  It does not enable any other features such as code
;; helpers above.
;; (semantic-load-enable-semantic-debugging-helpers)


;(require 'cmake-mode)
;(setq auto-mode-alist
;      (append '(("CMakeLists\\.txt\\'" . cmake-mode);
;		("\\.cmake\\'" . cmake-mode));
;	      auto-mode-alist))


(defun insert-muse-date-header ()
  "Insert a nicely formated date string."
  (interactive "*")
  (insert "* ")
  (insert (format-time-string "%Y-%m-%d") )
  )

(add-hook 'muse-mode-hook (lambda () (flyspell-mode t)))
(add-hook 'muse-mode-hook (lambda ()
			    (local-set-key "\C-cd" 'insert-muse-date-header)
			    (local-set-key (kbd "<tab>") 'indent-relative)
			    (local-set-key "\C-c\C-g" 'muse-colors-toggle-inline-images)
			    )
	  )

(add-hook 'org-mode-hook (lambda ()
			   (local-set-key "\C-cd" 'insert-muse-date-header))
	  )

(put 'upcase-region 'disabled nil)

;;(require 'muse-mode)
;;(require 'muse-project)
;;(require 'muse-publish)
;;(require 'muse-html)
;;(require 'muse-latex)
;;(require 'muse-texinfo)
;;(require 'muse-docbook)
;;(require 'muse-latex2png)

;;(setq muse-project-alist
;;      `(("notebook" (,@(muse-project-alist-dirs "~/notebook/notes"))
;;	 ,@(muse-project-alist-styles "~/notebook/notes"
;;				      "~/public_html"
;;				      "html"
;;	 ))))
;;
;;

(add-to-list 'load-path "~/.emacs.d/pov-mode-3.2")
(autoload 'pov-mode "pov-mode" "PoVray scene file mode" t)
(add-to-list 'auto-mode-alist '("\\.pov\\'" . pov-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . pov-mode))




(put 'scroll-left 'disabled nil)

(defadvice completion--file-name-table (after
                                        ignoring-backups-f-n-completion
                                        activate)
  "filter out results when the have completion-ignored-extensions"
  (let ((res ad-return-value))
    (if (and (listp res)
	     (stringp (car res))
	     (cdr res))                 ; length > 1, don't ignore sole match
	(setq ad-return-value
              (completion-pcm--filename-try-filter res)))))

;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(autoload 'org-gis-update-todo "org-github-issue-sync" "Org Github Issue Sync" t)

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "<f12>") 'org-gis-update-todo)))

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

;(setq org-mobile-directory "/scpc:tcaswell@kaylee.homelinux.net:/var/www/mobileorg/webdav/")

(setq TeX-electric-sub-and-superscript t)

(add-hook 'LaTeX-mode-hook (lambda () (flyspell-mode t)))
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'latex-mode-hook (lambda () (flyspell-mode t)))
(add-hook 'latex-mode-hook 'turn-on-reftex)


(eval-after-load 'quail
  '(progn
     (add-to-list 'quail-keyboard-layout-alist
		  '("dvp" . "\
                              \
  %&7[5{3}1(9=0*2)4+6]8!`#    \
  ;:,<.>pPyYfFgGcCrRlL/?@^    \
  aAoOeEuUiIdDhHtTnNsS-_\\|    \
  '\"qQjJkKxXbBmMwWvVzZ        \
                              "))
     (add-to-list 'quail-keyboard-layout-alist
		  '("dvorak" . "\
                              \
  1!2@3#4$5%6^7&8*9(0)[{]}`~  \
  '\",<.>pPyYfFgGcCrRlL/?=+    \
  aAoOeEuUiIdDhHtTnNsS-_\\|    \
  ;:qQjJkKxXbBmMwWvVzZ         \
                             "))
     (add-to-list 'quail-keyboard-layout-alist
		  '("us-pgr-dvk" . "\
                              \
$~&%[7{5}3(1=9*0)2+4]6!8#`    \
  ;:,<.>pPyYfFgGcCrRlL/?@^\\|  \
  aAoOeEuUiIdDhHtTnNsS-_      \
  '\"qQjJkKxXbBmMwWvVzZ        \
                              "))
     (quail-set-keyboard-layout "us-pgr-dvk")))



;;;; pymacs stuff, prep to get rope working
;;(autoload 'pymacs-apply "pymacs")
;;(autoload 'pymacs-call "pymacs")
;;(autoload 'pymacs-eval "pymacs" nil t)
;;(autoload 'pymacs-exec "pymacs" nil t)
;;(autoload 'pymacs-load "pymacs" nil t)
;;
;;(require 'pymacs)
;;(pymacs-load "ropemacs" "rope-")
;;
(setq-default bidi-display-reordering t)
;(require 'git-emacs)
(add-hook 'log-edit-mode-hook (lambda () (flyspell-mode t)))



;; http://emacs-fu.blogspot.com/2009/02/switching-buffers.html
;; ido makes competing buffers and finding files easier
;; http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
(require 'ido)
(ido-mode 'both) ;; for buffers and files

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-text-emacs))
 '(c-macro-cppflags "-I/home/tcaswell/local_installs/include")
 '(dired-bind-jump nil)
 '(dired-omit-extensions
   (quote
    (".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".dfsl" ".pfsl" ".d64fsl" ".p64fsl" ".lx64fsl" ".lx32fsl" ".dx64fsl" ".dx32fsl" ".fx64fsl" ".fx32fsl" ".sx64fsl" ".sx32fsl" ".wx64fsl" ".wx32fsl" ".fasl" ".ufsl" ".fsl" ".dxl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo" ".idx" ".lof" ".lot" ".glo" ".blg" ".bbl" ".cp" ".cps" ".fn" ".fns" ".ky" ".kys" ".pg" ".pgs" ".tp" ".tps" ".vr" ".vrs" "__pycache__/" ".egg" ".egg-info")))
 '(dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^__.*__$")
 '(display-time-mode t)
 '(flymake-cursor-error-display-delay 0.5)
 '(flymake-cursor-number-of-errors-to-display 5)
 '(flymake-fringe-indicator-position (quote left-fringe))
 '(font-latex-fontify-script nil)
 '(font-latex-fontify-sectioning (quote color))
 '(git-commit-known-pseudo-headers
   (quote
    ("Signed-off-by" "Acked-by" "Cc" "Suggested-by" "Reported-by" "Tested-by" "Reviewed-by" "closes" "fixes")))
 '(git-commit-setup-hook
   (quote
    (magit-revert-buffers git-commit-save-message git-commit-setup-changelog-support git-commit-turn-on-auto-fill git-commit-turn-on-flyspell git-commit-propertize-diff with-editor-usage-message)))
 '(git-state-modeline-decoration (quote git-state-decoration-letter))
 '(git-working-dir-change-behaviour (quote git-refresh-all-saved))
 '(global-auto-complete-mode nil)
 '(ido-default-file-method (quote selected-window))
 '(ido-enable-flex-matching t)
 '(ido-ignore-directories
   (quote
    ("\\`CVS/" "\\`\\.\\./" "\\`\\./" "\\`__pycache__/" "__pycache__")))
 '(ido-show-dot-for-dired nil)
 '(inhibit-startup-screen t)
 '(jabber-account-list
   (quote
    (("tcaswell@im.uchicago.edu")
     ("tcaswell@gmail.com"
      (:network-server . "talk.google.com")
      (:connection-type . ssl)
      (:password . "jkacybjtvqkzgmrf")))))
 '(jabber-chat-buffer-show-avatar nil)
 '(jabber-history-enable-rotation t)
 '(jabber-history-enabled t)
 '(jabber-use-global-history nil)
 '(magit-diff-options (quote ("--minimal" "--patience" "--histogram")))
 '(magit-diff-refine-hunk t)
 '(magit-fetch-arguments (quote ("--prune")))
 '(magit-merge-arguments (quote ("--ff-only")))
 '(magit-show-child-count t)
 '(magit-tag-arguments (quote ("--annotate" "--sign")))
 '(muse-mode-hook
   (quote
    (flyspell-mode
     (lambda nil
       (local-set-key "d"
		      (quote insert-muse-date-header))
       (local-set-key
	(kbd "<tab>")
	(quote indent-relative))
       (local-set-key ""
		      (quote muse-colors-toggle-inline-images))))) t)
 '(org-agenda-files nil)
 '(org-capture-templates
   (quote
    (("m" "Watch a mpl issue" entry
      (file+headline "~/source/p/notebook/mpl/todo.org" "review")
      "** WAIT [[mpl:%?]]
"))))
 '(org-completion-use-ido t)
 '(org-export-with-drawers nil)
 '(org-log-done (quote time))
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-crypt org-docview org-gnus org-id org-info org-jsinfo org-habit org-irc org-protocol org-special-blocks org-vm org-wl org-w3m org-bookmark org-checklist org-choose org-collector org-exp-bibtex org-git-link org-man org-track)))
 '(org-pretty-entities-include-sub-superscripts nil)
 '(org-replace-disputed-keys t)
 '(org-src-window-setup (quote current-window))
 '(org-startup-with-inline-images t)
 '(org-use-sub-superscripts nil)
 '(package-selected-packages
   (quote
    (json-mode yaml-mode virtualenvwrapper markdown-mode lua-mode jekyll-modes jabber elpy ack)))
 '(py-docstring-style nil)
 '(py-fontify-shell-buffer-p t)
 '(py-ipython-command-args (quote ("--matplotlib")))
 '(py-ipython-execute-delay 1.0)
 '(py-keep-windows-configuration t)
 '(py-python-command "ipython")
 '(py-python3-command "ipython")
 '(py-shell-input-prompt-1-regexp "^In \\[[0-9]+\\]: *")
 '(py-shell-input-prompt-2-regexp "^   [.][.][.]+: *")
 '(py-shell-name "ipython")
 '(py-shell-switch-buffers-on-execute nil)
 '(py-split-windows-on-execute-function (quote split-window-horizontally))
 '(py-split-windows-on-execute-p nil)
 '(py-tab-indent t)
 '(python-skeleton-autoinsert t)
 '(rst-level-face-base-light 20)
 '(send-mail-function (quote sendmail-send-it))
 '(tool-bar-mode nil)
 '(transient-mark-mode nil)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(user-mail-address "tcaswell@uchicago.edu")
 '(visual-line-fringe-indicators (quote (left-curly-arrow right-curly-arrow))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 99 :width normal :foundry "unknown" :family "Hack"))))
 '(flymake-errline ((t (:background "firebrick"))))
 '(flymake-warnline ((t (:background "RoyalBlue4"))))
 '(magit-blame-heading ((t (:background "grey25" :foreground "gray"))))
 '(py-object-reference-face ((t (:inherit py-pseudo-keyword-face)))))

;(setenv "PYTHONPATH" "/home/tcaswell/work/leidenfrost:/home/tcaswell/work/python:/home/tcaswell/local_installs/lib/python2.7/site-packages/:")

;(setenv "PATH" "/home/tcaswell/local_installs/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/grass/bin:/opt/grass/scripts:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/qt/bin:/home/tcaswell/bin")

;(getenv "PATH")
;
;(when (load "flymake" t)
;  (defun flymake-pyflakes-init ()
;    (let* ((temp-file (flymake-init-create-temp-buffer-copy
;               'flymake-create-temp-inplace))
;       (local-file (file-relative-name
;            temp-file
;            (file-name-directory buffer-file-name))))
;      (list "pycheckers"  (list local-file))))
;   (add-to-list 'flymake-allowed-file-name-masks
;             '("\\.py\\'" flymake-pyflakes-init)))
;
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)



(defvar visual-wrap-column nil)
(defun set-visual-wrap-column (new-wrap-column &optional buffer)
  "Force visual line wrap at NEW-WRAP-COLUMN in BUFFER (defaults
    to current buffer) by setting the right-hand margin on every
    window that displays BUFFER.  A value of NIL or 0 for
    NEW-WRAP-COLUMN disables this behavior."
  (interactive (list (read-number "New visual wrap column, 0 to disable: " (or visual-wrap-column fill-column 0)))\
)
  (if (and (numberp new-wrap-column)
           (zerop new-wrap-column))
      (setq new-wrap-column nil))
  (with-current-buffer (or buffer (current-buffer))
    (visual-line-mode t)
    (set (make-local-variable 'visual-wrap-column) new-wrap-column)
    (add-hook 'window-configuration-change-hook 'update-visual-wrap-column nil t)
    (let ((windows (get-buffer-window-list)))
      (while windows
        (when (window-live-p (car windows))
          (with-selected-window (car windows)
            (update-visual-wrap-column)))
        (setq windows (cdr windows))))))
(defun update-visual-wrap-column ()
  (if (not visual-wrap-column)
      (set-window-margins nil nil)
    (let* ((current-margins (window-margins))
           (right-margin (or (cdr current-margins) 0))
           (current-width (window-width))
           (current-available (+ current-width right-margin)))
      (if (<= current-available visual-wrap-column)
          (set-window-margins nil (car current-margins))
        (set-window-margins nil (car current-margins)
                            (- current-available visual-wrap-column))))))

(global-set-key "\C-x\C-g" 'magit-status)
(require 'dired-x)

(require 'uniquify)
(setq ring-bell-function 'ignore)

(defun tac-python-header ()
  (interactive "*")
  (occur "^\\s-*\\(\\(class \\)\\|\\(def \\)\\)\\|\\(@\\)")
  )

(require 'dired-x)
(setq-default dired-omit-files-p t) ; Buffer-local variable
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))

(venv-workon "dd_35")
(elpy-enable)
(elpy-use-ipython)


(setenv "EPICS_CA_AUTO_ADDR_LIST" "no")
(setenv "EPICS_CA_ADDR_LIST" "172.17.255.255")
(setenv "EPICS_CA_MAX_ARRAY_BYTES" "10000000")
(setenv "DOCKER0_IP" "172.17.0.1")

;; always split into side-by-side windows
(setq split-height-threshold 9999)


(defun reb-query-replace (to-string)
  "Replace current RE from point with `query-replace-regexp'."
  (interactive
   (progn (barf-if-buffer-read-only)
	  (list (query-replace-read-to (reb-target-binding reb-regexp)
				       "Query replace"  t))))
  (with-current-buffer reb-target-buffer
    (query-replace-regexp (reb-target-binding reb-regexp) to-string)))

(setq org-link-abbrev-alist
      '(("mpl" . "http://github.com/matplotlib/matplotlib/issues/")
        ("ast" . "http://github.com/astropy/astropy/issues/")
        ("gwcs" . "http://github.com/spacetelescope/gwcs/issues/")
        ("pyasdf" . "http://github.com/spacetelescope/pyasdf/issues/")
        ("asv" . "http://github.com/spacetelescope/asv/issues/")
        ("st" . "http://trac.assembla.com/jwst/ticket/")
        ("ph" . "chrome-extension://kcnhkahnjcbndmmehfkdnkjomaanaooo/widget.html#")
        ("cr" . "http://github.com/conda/conda-recipes/issues/")
        ("bk" . "http://github.com/bokeh/bokeh")
	))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium")
