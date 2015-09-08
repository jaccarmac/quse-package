;;; quse-package.el --- Install and configure packages in one convenient macro.

;; Copyright (C) 2015 Jacob MacDonald.

;; Author: Jacob MacDonald <jaccarmac@gmail.com>.
;; Created: 18 December 2014.
;; Version: 2.1.3
;; Keywords: extensions lisp
;; Homepage: github.com/jaccarmac/quse-package
;; Package-Requires: ((quelpa "0") (use-package "0"))

;;; Code:

;;;###autoload
(defmacro quse-package (quelpa-form &rest use-package-forms)
  "Download a package with quelpa and initialize it with use-package.
quelpa-form should be an *unquoted* name or list compatible with quelpa.
use-package-form should be whatever comes after the package name in a
use-package call. If the first element of use-package-form is :upgrade, the
next element is used as the :upgrade parameter to the quelpa call."
  (let* ((upgrade-form (if (and use-package-forms
                                (eq :upgrade (car use-package-forms)))
                           (list (car use-package-forms)
                                 (cadr use-package-forms))))
         (use-package-name (if (listp quelpa-form)
                               (car quelpa-form)
                             quelpa-form))
         (use-package-forms (if upgrade-form
                                (cddr use-package-forms)
                              use-package-forms)))
    `(progn (quelpa (quote ,quelpa-form) ,@upgrade-form)
            (use-package ,use-package-name
              ,@use-package-forms))))

(provide 'quse-package)
;;; quse-package.el ends here
