#lang racket/base

;;==========================================================================
;;===                Code generated with MrEd Designer 3.17              ===
;;===              https://github.com/Metaxal/MrEd-Designer              ===
;;==========================================================================

;;; Call (tax-helper-ui-init) with optional arguments to this module

(require
 racket/gui/base
 racket/class
 racket/list
 )

(provide tax-helper-ui-init
         MainWindow
         lbSummary
         lbDetails1
         lbDetails2
         lbDetails3
         lbDetails4
         lbDetails5
         lbDetails6
         lbDetails7
         lbDetails8
         lbDetails9)

(define (label-bitmap-proc l)
  (let ((label (first l)) (image? (second l)) (file (third l)))
    (or (and image?
             (or (and file
                      (let ((bmp (make-object bitmap% file 'unknown/mask)))
                        (and (send bmp ok?) bmp)))
                 "<Bad Image>"))
        label)))

(define (list->font l)
  (with-handlers
   ((exn:fail?
     (λ (e)
       (send/apply
        the-font-list
        find-or-create-font
        (cons (first l) (rest (rest l)))))))
   (send/apply the-font-list find-or-create-font l)))

(define tax-helper-ui #f)
(define MainWindow #f)
(define tpTabs #f)
(define tSummaryTab #f)
(define lbSummary #f)
(define tDetailsTab1 #f)
(define lbDetails1 #f)
(define tDetailsTab2 #f)
(define lbDetails2 #f)
(define tDetailsTab3 #f)
(define lbDetails3 #f)
(define tDetailsTab4 #f)
(define lbDetails4 #f)
(define tDetailsTab5 #f)
(define lbDetails5 #f)
(define tDetailsTab6 #f)
(define lbDetails6 #f)
(define tDetailsTab7 #f)
(define lbDetails7 #f)
(define tDetailsTab8 #f)
(define lbDetails8 #f)
(define tDetailsTab9 #f)
(define lbDetails9 #f)
(define MainMenuBar #f)
(define menu-file #f)
(define menu-item-open #f)
(define separator-menu-item-99622 #f)
(define menu-item-exit #f)
(define menu-edit #f)
(define menu-item-cut #f)
(define menu-item-copy #f)
(define menu-item-paste #f)
(define separator-menu-item-99686 #f)
(define menu-item-pref #f)
(define menu-help #f)
(define menu-item-about #f)
(define (tax-helper-ui-init
         #:lbSummary-callback
         (lbSummary-callback (lambda (list-box control-event) (void)))
         #:lbSummary-columns
         (lbSummary-columns (list "Description" "Value"))
         #:lbDetails1-callback
         (lbDetails1-callback (lambda (list-box control-event) (void)))
         #:lbDetails1-columns
         (lbDetails1-columns (list "Date" "Description" "Value"))
         #:lbDetails2-callback
         (lbDetails2-callback (lambda (list-box control-event) (void)))
         #:lbDetails2-columns
         (lbDetails2-columns (list "Date" "Description" "Value"))
         #:lbDetails3-callback
         (lbDetails3-callback (lambda (list-box control-event) (void)))
         #:lbDetails3-columns
         (lbDetails3-columns (list "Date" "Description" "Value"))
         #:lbDetails4-callback
         (lbDetails4-callback (lambda (list-box control-event) (void)))
         #:lbDetails4-columns
         (lbDetails4-columns (list "Date" "Description" "Value"))
         #:lbDetails5-callback
         (lbDetails5-callback (lambda (list-box control-event) (void)))
         #:lbDetails5-columns
         (lbDetails5-columns (list "Date" "Description" "Value"))
         #:lbDetails6-callback
         (lbDetails6-callback (lambda (list-box control-event) (void)))
         #:lbDetails6-columns
         (lbDetails6-columns (list "Date" "Description" "Value"))
         #:lbDetails7-callback
         (lbDetails7-callback (lambda (list-box control-event) (void)))
         #:lbDetails7-columns
         (lbDetails7-columns (list "Date" "Description" "Value"))
         #:lbDetails8-callback
         (lbDetails8-callback (lambda (list-box control-event) (void)))
         #:lbDetails8-columns
         (lbDetails8-columns (list "Date" "Description" "Value"))
         #:lbDetails9-callback
         (lbDetails9-callback (lambda (list-box control-event) (void)))
         #:lbDetails9-columns
         (lbDetails9-columns (list "Date" "Description" "Value"))
         #:MainMenuBar-demand-callback
         (MainMenuBar-demand-callback (lambda (m) (void)))
         #:menu-file-demand-callback
         (menu-file-demand-callback (lambda (m) (void)))
         #:menu-item-open-callback
         (menu-item-open-callback (lambda (item event) (void)))
         #:menu-item-open-demand-callback
         (menu-item-open-demand-callback (lambda (item) (void)))
         #:menu-item-exit-callback
         (menu-item-exit-callback (lambda (item event) (void)))
         #:menu-item-exit-demand-callback
         (menu-item-exit-demand-callback (lambda (item) (void)))
         #:menu-edit-demand-callback
         (menu-edit-demand-callback (lambda (m) (void)))
         #:menu-item-cut-callback
         (menu-item-cut-callback (lambda (item event) (void)))
         #:menu-item-cut-demand-callback
         (menu-item-cut-demand-callback (lambda (item) (void)))
         #:menu-item-copy-callback
         (menu-item-copy-callback (lambda (item event) (void)))
         #:menu-item-copy-demand-callback
         (menu-item-copy-demand-callback (lambda (item) (void)))
         #:menu-item-paste-callback
         (menu-item-paste-callback (lambda (item event) (void)))
         #:menu-item-paste-demand-callback
         (menu-item-paste-demand-callback (lambda (item) (void)))
         #:menu-item-pref-callback
         (menu-item-pref-callback (lambda (item event) (void)))
         #:menu-item-pref-demand-callback
         (menu-item-pref-demand-callback (lambda (item) (void)))
         #:menu-help-demand-callback
         (menu-help-demand-callback (lambda (m) (void)))
         #:menu-item-about-callback
         (menu-item-about-callback (lambda (item event) (void)))
         #:menu-item-about-demand-callback
         (menu-item-about-demand-callback (lambda (item) (void))))
  (set! MainWindow
    (new
     frame%
     (parent tax-helper-ui)
     (label "Tax Helper")
     (width #f)
     (height #f)
     (x #f)
     (y #f)
     (style '())
     (enabled #t)
     (border 0)
     (spacing 0)
     (alignment (list 'center 'top))
     (min-width 840)
     (min-height 480)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! tpTabs
    (new
     (class tab-panel%
       (super-new)
       (define child-panels '())
       (define/public
        (add-child-panel p label)
        (set! child-panels (append child-panels (list p)))
        (send this append label)
        (when (> (length child-panels) 1) (send this delete-child p)))
       (define/public
        (active-child n)
        (send this change-children
          (lambda (children) (list (list-ref child-panels n))))))
     (parent MainWindow)
     (choices (list))
     (callback (λ (tp e) (send tp active-child (send tp get-selection))))
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment (list 'center 'center))
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! tSummaryTab
    (new
     (class vertical-panel%
       (init parent)
       (init-field label)
       (super-new (parent parent))
       (send parent add-child-panel this label))
     (parent tpTabs)
     (label "Summary")
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment (list 'left 'center))
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! lbSummary
    (new
     list-box%
     (parent tSummaryTab)
     (label #f)
     (choices (list "Please open a transaction file..."))
     (callback lbSummary-callback)
     (style
      ((λ (l) (list* (first l) (second l) (third l)))
       (list 'single 'horizontal-label '(variable-columns column-headers))))
     (font (list->font (list 8 #f 'default 'normal 'normal #f 'default #f)))
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)
     (columns lbSummary-columns)
     (column-order #f)))
  (set! tDetailsTab1
    (new
     (class vertical-panel%
       (init parent)
       (init-field label)
       (super-new (parent parent))
       (send parent add-child-panel this label))
     (parent tpTabs)
     (label "Business")
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment (list 'left 'center))
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! lbDetails1
    (new
     list-box%
     (parent tDetailsTab1)
     (label #f)
     (choices (list "Please open a transaction file..."))
     (callback lbDetails1-callback)
     (style
      ((λ (l) (list* (first l) (second l) (third l)))
       (list 'single 'horizontal-label '(variable-columns column-headers))))
     (font (list->font (list 8 #f 'default 'normal 'normal #f 'default #f)))
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)
     (columns lbDetails1-columns)
     (column-order #f)))
  (set! tDetailsTab2
    (new
     (class vertical-panel%
       (init parent)
       (init-field label)
       (super-new (parent parent))
       (send parent add-child-panel this label))
     (parent tpTabs)
     (label "Babysitter")
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment (list 'left 'center))
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! lbDetails2
    (new
     list-box%
     (parent tDetailsTab2)
     (label #f)
     (choices (list "Please open a transaction file..."))
     (callback lbDetails2-callback)
     (style
      ((λ (l) (list* (first l) (second l) (third l)))
       (list 'single 'horizontal-label '(variable-columns column-headers))))
     (font (list->font (list 8 #f 'default 'normal 'normal #f 'default #f)))
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)
     (columns lbDetails2-columns)
     (column-order #f)))
  (set! tDetailsTab3
    (new
     (class vertical-panel%
       (init parent)
       (init-field label)
       (super-new (parent parent))
       (send parent add-child-panel this label))
     (parent tpTabs)
     (label "Heat")
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment (list 'left 'center))
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! lbDetails3
    (new
     list-box%
     (parent tDetailsTab3)
     (label #f)
     (choices (list "Please open a transaction file..."))
     (callback lbDetails3-callback)
     (style
      ((λ (l) (list* (first l) (second l) (third l)))
       (list 'single 'horizontal-label '(variable-columns column-headers))))
     (font (list->font (list 8 #f 'default 'normal 'normal #f 'default #f)))
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)
     (columns lbDetails3-columns)
     (column-order #f)))
  (set! tDetailsTab4
    (new
     (class vertical-panel%
       (init parent)
       (init-field label)
       (super-new (parent parent))
       (send parent add-child-panel this label))
     (parent tpTabs)
     (label "Hydro")
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment (list 'left 'center))
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! lbDetails4
    (new
     list-box%
     (parent tDetailsTab4)
     (label #f)
     (choices (list "Please open a transaction file..."))
     (callback lbDetails4-callback)
     (style
      ((λ (l) (list* (first l) (second l) (third l)))
       (list 'single 'horizontal-label '(variable-columns column-headers))))
     (font (list->font (list 8 #f 'default 'normal 'normal #f 'default #f)))
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)
     (columns lbDetails4-columns)
     (column-order #f)))
  (set! tDetailsTab5
    (new
     (class vertical-panel%
       (init parent)
       (init-field label)
       (super-new (parent parent))
       (send parent add-child-panel this label))
     (parent tpTabs)
     (label "Insurance 1")
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment (list 'left 'center))
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! lbDetails5
    (new
     list-box%
     (parent tDetailsTab5)
     (label #f)
     (choices (list "Please open a transaction file..."))
     (callback lbDetails5-callback)
     (style
      ((λ (l) (list* (first l) (second l) (third l)))
       (list 'single 'horizontal-label '(variable-columns column-headers))))
     (font (list->font (list 8 #f 'default 'normal 'normal #f 'default #f)))
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)
     (columns lbDetails5-columns)
     (column-order #f)))
  (set! tDetailsTab6
    (new
     (class vertical-panel%
       (init parent)
       (init-field label)
       (super-new (parent parent))
       (send parent add-child-panel this label))
     (parent tpTabs)
     (label "Insurance 2")
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment (list 'left 'center))
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! lbDetails6
    (new
     list-box%
     (parent tDetailsTab6)
     (label #f)
     (choices (list "Please open a transaction file..."))
     (callback lbDetails6-callback)
     (style
      ((λ (l) (list* (first l) (second l) (third l)))
       (list 'single 'horizontal-label '(variable-columns column-headers))))
     (font (list->font (list 8 #f 'default 'normal 'normal #f 'default #f)))
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)
     (columns lbDetails6-columns)
     (column-order #f)))
  (set! tDetailsTab7
    (new
     (class vertical-panel%
       (init parent)
       (init-field label)
       (super-new (parent parent))
       (send parent add-child-panel this label))
     (parent tpTabs)
     (label "Internet")
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment (list 'left 'center))
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! lbDetails7
    (new
     list-box%
     (parent tDetailsTab7)
     (label #f)
     (choices (list "Please open a transaction file..."))
     (callback lbDetails7-callback)
     (style
      ((λ (l) (list* (first l) (second l) (third l)))
       (list 'single 'horizontal-label '(variable-columns column-headers))))
     (font (list->font (list 8 #f 'default 'normal 'normal #f 'default #f)))
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)
     (columns lbDetails7-columns)
     (column-order #f)))
  (set! tDetailsTab8
    (new
     (class vertical-panel%
       (init parent)
       (init-field label)
       (super-new (parent parent))
       (send parent add-child-panel this label))
     (parent tpTabs)
     (label "Cellphone")
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment (list 'left 'center))
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! lbDetails8
    (new
     list-box%
     (parent tDetailsTab8)
     (label #f)
     (choices (list "Please open a transaction file..."))
     (callback lbDetails8-callback)
     (style
      ((λ (l) (list* (first l) (second l) (third l)))
       (list 'single 'horizontal-label '(variable-columns column-headers))))
     (font (list->font (list 8 #f 'default 'normal 'normal #f 'default #f)))
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)
     (columns lbDetails8-columns)
     (column-order #f)))
  (set! tDetailsTab9
    (new
     (class vertical-panel%
       (init parent)
       (init-field label)
       (super-new (parent parent))
       (send parent add-child-panel this label))
     (parent tpTabs)
     (label "Water")
     (style '())
     (enabled #t)
     (vert-margin 0)
     (horiz-margin 0)
     (border 0)
     (spacing 0)
     (alignment (list 'left 'center))
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! lbDetails9
    (new
     list-box%
     (parent tDetailsTab9)
     (label #f)
     (choices (list "Please open a transaction file..."))
     (callback lbDetails9-callback)
     (style
      ((λ (l) (list* (first l) (second l) (third l)))
       (list 'single 'horizontal-label '(variable-columns column-headers))))
     (font (list->font (list 8 #f 'default 'normal 'normal #f 'default #f)))
     (selection 0)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width 0)
     (min-height 0)
     (stretchable-width #t)
     (stretchable-height #t)
     (columns lbDetails9-columns)
     (column-order #f)))
  (set! MainMenuBar
    (new
     menu-bar%
     (parent MainWindow)
     (demand-callback MainMenuBar-demand-callback)))
  (set! menu-file
    (new
     menu%
     (parent MainMenuBar)
     (label "&File")
     (help-string "File")
     (demand-callback menu-file-demand-callback)))
  (set! menu-item-open
    (new
     menu-item%
     (parent menu-file)
     (label "&Open...")
     (callback menu-item-open-callback)
     (shortcut #\O)
     (help-string "Open")
     (demand-callback menu-item-open-demand-callback)
     (shortcut-prefix '(ctl))))
  (set! separator-menu-item-99622
    (new separator-menu-item% (parent menu-file)))
  (set! menu-item-exit
    (new
     menu-item%
     (parent menu-file)
     (label "E&xit")
     (callback menu-item-exit-callback)
     (shortcut #\Q)
     (help-string "Exit Application")
     (demand-callback menu-item-exit-demand-callback)
     (shortcut-prefix '(ctl))))
  (set! menu-edit
    (new
     menu%
     (parent MainMenuBar)
     (label "&Edit")
     (help-string "Edit")
     (demand-callback menu-edit-demand-callback)))
  (set! menu-item-cut
    (new
     menu-item%
     (parent menu-edit)
     (label "&Cut")
     (callback menu-item-cut-callback)
     (shortcut #\X)
     (help-string "Cut")
     (demand-callback menu-item-cut-demand-callback)
     (shortcut-prefix '(ctl))))
  (set! menu-item-copy
    (new
     menu-item%
     (parent menu-edit)
     (label "&Copy")
     (callback menu-item-copy-callback)
     (shortcut #\C)
     (help-string "Copy")
     (demand-callback menu-item-copy-demand-callback)
     (shortcut-prefix '(ctl))))
  (set! menu-item-paste
    (new
     menu-item%
     (parent menu-edit)
     (label "&Paste")
     (callback menu-item-paste-callback)
     (shortcut #\V)
     (help-string "Paste")
     (demand-callback menu-item-paste-demand-callback)
     (shortcut-prefix '(ctl))))
  (set! separator-menu-item-99686
    (new separator-menu-item% (parent menu-edit)))
  (set! menu-item-pref
    (new
     menu-item%
     (parent menu-edit)
     (label "&Preferences...")
     (callback menu-item-pref-callback)
     (shortcut 'f1)
     (help-string "Preferences")
     (demand-callback menu-item-pref-demand-callback)
     (shortcut-prefix '(ctl))))
  (set! menu-help
    (new
     menu%
     (parent MainMenuBar)
     (label "&Help")
     (help-string "Help")
     (demand-callback menu-help-demand-callback)))
  (set! menu-item-about
    (new
     menu-item%
     (parent menu-help)
     (label "&About...")
     (callback menu-item-about-callback)
     (shortcut 'f1)
     (help-string "About")
     (demand-callback menu-item-about-demand-callback)
     (shortcut-prefix '())))
  (send MainWindow show #t))

(module+ main (tax-helper-ui-init))
