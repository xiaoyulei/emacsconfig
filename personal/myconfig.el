;;===================================================
;; .emacs of Yulei Xiao
;;===================================================
;;insert cmd to .bashrc to set color display
;;alias ls="ls --color=always"

;;-------------------------
;; set env
;;-------------------------
(setenv "LESS" "-erX")
(setenv "alias ls" "ls --color=alwasy")

;;-------------------------
;; global key setting
;;-------------------------
;;(global-set-key (kbd "M-SPC") 'set-mark-command)
;;(global-set-key (kbd "C-x f") 'helm-find-files)
;;(global-set-key (kbd "C-x C-k") 'kill-buffer)
;;(global-set-key (kbd "C-t") 'toggle-truncate-lines)
;;(global-set-key (kbd "M-x") 'helm-M-x)

;;; history mode
;;(require 'history)
;;(add-to-list 'history-advised-before-functions 'push-mark t)
;;(history-mode)
;;(global-set-key (kbd "M-,") 'history-prev-history)

;;; highlite mode
(add-hook 'find-file-hook 'idle-highlight-mode)
;;(require 'highlight-symbol)
;;(global-set-key [(control f3)] 'highlight-symbol)
;;(global-set-key [f3] 'highlight-symbol-next)
;;(global-set-key [(shift f3)] 'highlight-symbol-prev)
;;(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;;-------------------------
;; line num on left
;;-------------------------
(global-linum-mode t)


;;-------------------------
;; op buffer
;;-------------------------
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)
(global-set-key (kbd "M-0") 'delete-window)

;;-------------------------
;; trans buffer
;;-------------------------
(defun transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))
(global-set-key (kbd "M-9") 'transpose-buffers)

;;-------------------------
;; some blablabla
;;-------------------------
;; disable whitespace of prelude
(setq prelude-whitespace nil)
;;(setq prelude-clean-whitespace-on-save nil);;disable auto clean whitespace

;; display cursor to little bar
(setq-default cursor-type 'bar)
;; set mark hotkey
(global-set-key (kbd "M-m") 'set-mark-command)
;; set goto line hotkey
(global-set-key (kbd "M-g") 'goto-line)
;;block emacs hide key
(global-set-key (kbd "C-z") 'nil)
(global-set-key (kbd "C-x C-z") 'nil)

;;-------------------------
;;scroll display
;;-------------------------
(defun hode-line-scroll-up()
"Scroll the page with the cursor in the same line"
(interactive)
(let ((next-screen-context-lines
(count-lines
(window-start)(window-end))))
(scroll-up)))
(global-set-key (kbd "M-n") 'hode-line-scroll-up)

(defun hode-line-scroll-down()
"Scroll the page with the cursor in the same line"
(interactive)
(let ((next-screen-context-lines
(count-lines
(window-start)(window-end))))
(scroll-down)))
(global-set-key (kbd "M-p") 'hode-line-scroll-down)

;;-----------------------------------
;; themes
;;-----------------------------------
;;(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-20080305.34")
;;(require 'color-theme)
;;(color-theme-initialize)

;;;;-----------------------------------
;;;; helm
;;;;-----------------------------------
(require 'grep)
;;(require 'prelude-helm-everywhere)
;; add in modules
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
;;

;;-----------------------------------
;; display time
;;-----------------------------------
(display-time)
(display-time-mode t)
(setq display-time-24hr-format t)                              ;打开24小时显示模式
(setq display-time-day-and-date t)                             ;打开日期显示
(setq display-time-format "%Y/%m/%d %A %H:%M")                 ;设定时间显示格式
(setq display-time-interval 10)
;;(setq time-stamp-format "%02H:%02M:%02S %:y (%z) %3a %3b %2d") ;设置时间戳的显示格式
;;time stamp
(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)
(setq time-stamp-format "%:u %02m/%02d/%04y %02H02M02S")
(add-hook 'write-file-hooks 'time-stamp)

;;-----------------------------------
;; golang
;;-----------------------------------
;;(setq gofmt-command "goimports")
;;(add-to-list 'load-path "~/.emacs.d/elpa/go-mode-20141025.219")
(prelude-require-package 'go-mode)
(require 'go-mode)
(require 'go-mode-autoloads)
(add-hook 'before-save-hook 'gofmt-before-save nil t)
(add-hook 'before-save-hook 'gofmt-before-save)

;;(require 'go-autocomplete)
;;(require 'auto-complete-config)

;; define my own go mode key binds ::super
(setq go-mode-map
      (let ((m (make-sparse-keymap)))
        (define-key m "}" #'go-mode-insert-and-indent)
        (define-key m ")" #'go-mode-insert-and-indent)
        (define-key m "," #'go-mode-insert-and-indent)
        (define-key m ":" #'go-mode-insert-and-indent)
        (define-key m "=" #'go-mode-insert-and-indent)
        (define-key m (kbd "C-c C-a") #'go-import-add)
        (define-key m (kbd "C-c C-j") #'godef-jump)
        ;; go back to point after called godef-jump.  ::super
        (define-key m (kbd "C-c C-p") #'pop-tag-mark)
        (define-key m (kbd "C-x 4 C-c C-j") #'godef-jump-other-window)
        (define-key m (kbd "C-c C-d") #'godef-describe)
        m))
;; use goimports instead of gofmt ::super
;;(setq gofmt-command "goimports")

;;-----------------------------------
;; org mode
;;-----------------------------------
;;init org new version
;;(add-to-list 'load-path "~/.emacs.d/elpa/org-20141103/lisp")
(prelude-require-package 'org)
(require 'org-install)
;;some hotkey config
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-ck" 'org-store-link)
(global-set-key "\C-cb" 'org-iswitchb)
;;some config
(setq org-todo-keywords
      '((sequence "TODO(t!)" "HANG(h!)" "|" "DONE(d!)" "CANCEL(c!)")))

;;export to pdf file with  org-mode 8.0
(setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f" "xelatex -interaction nonstopmode %f"))
;;use M-x to quick open
(defun todo ()
  (interactive)
  (find-file "~/.emacs.d/personal/todo.org")
  )
;;add my orgfile to agenda
(setq org-agenda-files (list "~/.emacs.d/personal/todo.org"))
(global-set-key "\C-ca" 'org-agenda)
;;display image in org file
;;image width
(setq org-image-actual-width 100)
;;iimage mode
;;;;(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
;;;;(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)

;;timed reminder
                                        ; Erase all reminders and rebuilt reminders for today from the agenda
(defun bh/org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

                                        ; Rebuild the reminders everytime the agenda is displayed
(add-hook 'org-finalize-agenda-hook 'bh/org-agenda-to-appt 'append)

                                        ; This is at the end of my .emacs - so appointments are set up when Emacs starts
(bh/org-agenda-to-appt)

                                        ; Activate appointments so we get notifications
(appt-activate t)

                                        ; If we leave Emacs running overnight - reset the appointments one minute after midnight
(run-at-time "24:01" nil 'bh/org-agenda-to-appt)

(setq appt-message-warning-time 10);; advance 10 minutes to display warning
(setq appt-display-interval 2);; every 2 minutes to display warning

;;-----------------------------------
;; backup set
;;-----------------------------------
(setq backup-by-copying t ;
      backup-directory-alist
      '(("." . "~/.emacs.d/.saves")) ;
      delete-old-versions t ;
      kept-new-versions 6 ;
      kept-old-versions 2 ;
      version-control t) ;

;;----------------------------------
;; switch window
;;----------------------------------
;;(add-to-list 'load-path "~/.emacs.d/elpa/switch-window-20140919.734")
(prelude-require-package 'switch-window)
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;;;;-----------------------------------
;;;; helm gtags
;;;;-----------------------------------

;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))


;;-----------------------------------
;; c style from google
;;-----------------------------------
;;(add-to-list 'load-path "~/.emacs.d/elpa/google-c-style-20140929.1118")
(prelude-require-package 'google-c-style)
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(defun my-c-mode-hook ()
  (setq c-basic-offset 4          ;; 基本缩进宽度
        indent-tabs-mode t        ;; 禁止空格替换Tab
        default-tab-width 4))     ;; 默认Tab宽度
(add-hook 'c-mode-hook 'my-c-mode-hook)

;;-----------------------------------
;; ace jump hot key
;;-----------------------------------
;; ace jump mode major function
;;(add-to-list 'load-path "~/.emacs.d/elpa/ace-jump-mode-20140616.115")
(prelude-require-package 'ace-jump-mode)
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
;;(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "M-j") 'ace-jump-mode)

;;-----------------------------------
;; magit
;;-----------------------------------
(require 'magit)
(setq magit-last-seen-setup-instructions "1.4.0")

;;-----------------------------------
;; helm-swoop
;;-----------------------------------
(prelude-require-package 'helm-swoop)
(global-set-key (kbd "C-c w") 'helm-swoop)

;;-----------------------------------
;; helm-ag
;;-----------------------------------
(custom-set-variables
 '(helm-ag-base-command "ag --nogroup --ignore-case")
 '(helm-ag-command-option "--all-text")
 '(helm-ag-insert-at-point 'symbol))


