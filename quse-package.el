;;; quse-package.el --- Install and configure packages in one convenient macro.

;; Copyright (C) 2015 Jacob MacDonald.

;; Author: Jacob MacDonald <jaccarmac@gmail.com>.
;; Created: 18 December 2014.
;; Version: 2.0.1
;; Keywords: extensions lisp
;; Homepage: github.com/jaccarmac/quse-package
;; Package-Requires: ((quelpa "0") (use-package "0"))

;;; Code:

;;;###autoload
(defmacro quse-package (quelpa-form &rest use-package-forms)
  "Download a package with quelpa and initialize it with use-package.
quelpa-form should be an *unquoted* name or list compatible with quelpa.
use-package-form should be whatever comes after the package name in a use-package call."
  (let ((use-package-name (if (listp quelpa-form)
                              (car quelpa-form)
                            quelpa-form)))
    `(progn (quelpa (quote ,quelpa-form))
            (use-package ,use-package-name
              ,@use-package-forms))))

(provide 'quse-package)
;;; quse-package.el ends here
