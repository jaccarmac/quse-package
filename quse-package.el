;;; quse-package.el --- Install and configure packages in one convenient macro.

;; Copyright (C) 2015, 2016, 2017 Jacob MacDonald.

;; Author: Jacob MacDonald <jaccarmac@gmail.com>.
;; Created: 18 December 2014.
;; Version: 2.2.2
;; Keywords: extensions lisp
;; Homepage: github.com/jaccarmac/quse-package
;; Package-Requires: ((quelpa "0") (use-package "0"))

;;; Commentary:
;; Use this package exactly like you would use-package, with the exception that
;; the package name should be a quelpa recipe.  If the first argument after the
;; recipe is :upgrade, it will be treated as an :upgrade argument to quelpa.

;;; Code:

;;;###autoload
(defmacro quse-package (quelpa-form &rest use-package-forms)
  "Download a package with quelpa and initialize it with ‘use-package’.
QUELPA-FORM should be an *unquoted* name or list compatible with
quelpa.  USE-PACKAGE-FORMS should be whatever comes after the
package name in a ‘use-package’ call.  If the first element of
USE-PACKAGE-FORMS is :upgrade, the next element is used as
the :upgrade parameter to the quelpa call."
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
    `(progn (add-to-list 'package-selected-packages ',use-package-name)
            (quelpa ',quelpa-form ,@upgrade-form)
            (use-package ,use-package-name
              ,@use-package-forms))))

(provide 'quse-package)
;;; quse-package.el ends here
