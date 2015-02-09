(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq package-enable-at-startup nil)
(package-initialize)

;; Org-mode: enable tab
(setq evil-want-C-i-jump nil)

;; Evil-mode settings
(require 'evil)
(evil-mode 1)

(setq auto-indent-start-org-mode t)

;; evil-org-mode supplementary bindings
; https://github.com/edwtjo/evil-org-mode
(add-to-list 'load-path "~/.emacs.d/plugins/evil-org-mode")
(require 'evil-org)

;; Color scheme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'solarized-light t)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)

;; Leave all backups in ~/.saves
(setq backup-directory-alist `(("." . "~/.saves")))

(setq-default indent-tabs-mode nil
              tab-width 4
              c-basic-offset 4
              mode-require-final-newline t
              require-final-newline t
              show-trailing-whitespace t
              )
(setq indent-line-function 'insert-tab)

; Enable mouse mode
(xterm-mouse-mode 1)
; Mouse wheel scroll step = 1
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

;; Org-mode Day Planner Settings
;; http://newartisans.com/2007/08/using-org-mode-as-a-day-planner/
(require 'org-install)

; (setq org-log-done t)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(define-key mode-specific-map [?a] 'org-agenda)

(eval-after-load "org"
  '(progn
     (define-prefix-command 'org-todo-state-map)

     (define-key org-mode-map "\C-cx" 'org-todo-state-map)

     (define-key org-todo-state-map "x"
       #'(lambda nil (interactive) (org-todo "CANCELLED")))
     (define-key org-todo-state-map "d"
       #'(lambda nil (interactive) (org-todo "DONE")))
     (define-key org-todo-state-map "f"
       #'(lambda nil (interactive) (org-todo "DEFERRED")))
     (define-key org-todo-state-map "l"
       #'(lambda nil (interactive) (org-todo "DELEGATED")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "STARTED")))
     (define-key org-todo-state-map "w"
       #'(lambda nil (interactive) (org-todo "WAITING")))

     (local-set-key (kbd "\C-t") 'org-todo)
     (local-set-key "\C-t" 'org-todo)

     ))

(require 'remember)

(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map [(control ?s)] 'remember)

(custom-set-variables
 '(org-agenda-files (quote ("~/org/")))
 '(org-default-notes-file "~/org/notes.org")
 '(org-agenda-ndays 7)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-reverse-note-order t)
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-agenda-custom-commands
   (quote (("d" todo "DELEGATED" nil)
       ("c" todo "DONE|DEFERRED|CANCELLED" nil)
       ("w" todo "WAITING" nil)
       ("W" agenda "" ((org-agenda-ndays 21)))
       ("A" agenda ""
        ((org-agenda-skip-function
          (lambda nil
        (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
         (org-agenda-ndays 1)
         (org-agenda-overriding-header "Today's Priority #A tasks: ")))
       ("u" alltodo ""
        ((org-agenda-skip-function
          (lambda nil
        (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
                      (quote regexp) "\n]+>")))
         (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
 '(org-remember-store-without-prompt t)
 '(org-remember-templates
   (quote ((116 "* TODO %?\n  %u" "~/org/todo.org" "Pending")
       (110 "* %u %?" "~/org/notes.org" "Notes"))))
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler))))

;;; KEY BINDINGS
; org-mode
(add-hook 'org-mode-hook (lambda() (local-set-key "\C-t" 'org-todo)))

; org-agenda: add j&k movement keys
(add-hook 'org-agenda-mode-hook
  (lambda ()
    (define-key org-agenda-mode-map "j" 'evil-next-line)
    (define-key org-agenda-mode-map "k" 'evil-previous-line)
    ))
