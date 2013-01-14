;;-------------------------------------------------------------------------------
;; global keys definition

;; to make a cursor navigation a little bit easy
(global-set-key (kbd "M-n") #'next-line)
(global-set-key (kbd "M-p") #'previous-line)

;; reserved by the StumpWM
(global-set-key (kbd "C-t") 'nil)

(global-set-key (kbd "M-#") #'dictem-run-define)
(global-set-key (kbd "M-*") #'ispell-region)
(global-set-key (kbd "M-t") #'complete-symbol)
(global-set-key (kbd "M-z") #'undo)

(defun swap-buffers (&optional last)
  "Swaps the current and a last buffers"
  (interactive)
  (let ((buf (current-buffer))
	(frame (selected-frame)))
    (switch-to-buffer
     (if last
	 (progn
	   (other-buffer buf t frame)
	   (bury-buffer buf))
       (last-buffer buf t frame)))))

;; buffer related shortcuts start from C-x 
(global-set-key (kbd "C-x p") #'previous-buffer)
(global-set-key (kbd "C-x n") #'next-buffer)
(global-set-key (kbd "C-x l")
		(lexical-let ((swap-last t))
		  #'(lambda ()
		      "that's a wrapper around the `swap-buffers'
function to keep a state variable"
		      (interactive)
		      (swap-buffers swap-last)
		      (setq swap-last (not swap-last)))))
(global-set-key (kbd "C-x d") #'dired-jump)
(global-set-key (kbd "C-x c") #'shell-jump)
(global-set-key (kbd "C-x C-d") #'dired)
(global-set-key (kbd "C-x M-d") #'dired-other-window)
(global-set-key (kbd "C-x M-f") #'find-file-other-window)
(global-set-key (kbd "C-x M-b") #'switch-to-buffer-other-window)
(global-set-key (kbd "C-x C-n")
		#'(lambda (newname)
		    (interactive
		     (list (read-string "Rename current buffer to: "
					(buffer-name (current-buffer)))))
		    (rename-buffer newname)))

;; general commands start from C-c
(global-set-key (kbd "C-c C-g") #'rgrep)
(global-set-key (kbd "C-c C-f") #'find-dired)
(global-set-key (kbd "C-c w") #'browse-url)
;; window management in StumpWM style :)
(global-set-key (kbd "C-c s") #'split-window-horizontally)
(global-set-key (kbd "C-c M-s") #'split-window-vertically)
(global-set-key (kbd "C-c q") #'delete-other-windows)
(global-set-key (kbd "C-c k") #'delete-window)
(global-set-key (kbd "C-c r") #'iresize-mode)
(global-set-key (kbd "C-c o") #'other-window)

;;-------------------------------------------------------------------------------

(global-set-key (kbd "<XF86Open>") #'find-file)
(global-set-key (kbd "<XF86Save>") #'save-buffer)
(global-set-key (kbd "<XF86Close>") #'kill-buffer)
(global-set-key (kbd "<XF86New>") #'new-frame)
(global-set-key (kbd "<XF86Forward>") #'next-buffer)
(global-set-key (kbd "<XF86Back>") #'previous-buffer)

;; these keys are partly implemented in MS Natural Ergonomic Keyboard
;; in F Lock mode
(global-set-key (kbd "<SunOpen>") #'find-file)
(global-set-key (kbd "<SunClose>") #'kill-buffer)

;;-------------------------------------------------------------------------------
;; related to global key redefinition so placed here

(add-hook 'diff-mode-hook
          '(lambda ()
             ;; diff-goto-source
             (define-key diff-mode-map (kbd "C-m") 'diff-goto-source)))

;;-------------------------------------------------------------------------------

(add-hook 'eshell-mode-hook
          '(lambda ()
             (define-key eshell-mode-map (kbd "C-c M-s") nil)))

;;-------------------------------------------------------------------------------

(add-hook 'shell-mode-hook
          '(lambda ()
             (define-key shell-mode-map (kbd "C-c M-s") nil)))

;;-------------------------------------------------------------------------------
;; platform specific

(when (string= system-type "windows-nt")
  (global-set-key (kbd "<apps>") 'execute-extended-command))
