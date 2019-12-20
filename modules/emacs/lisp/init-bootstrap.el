;;; -*- lexical-binding: t -*-

;; Copyright (C) 2018-2019 Robin Mattheussen

;; Author: Robin Mattheussen <robin.mattheussen@gmail.com>
;; URL: https://github.com/romatthe/dotfiles

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;

;;; Commentary:
;;
;; Bootstrapping code.
;;

;;; Code:

;; Now that we have `use-package`, we can use the Garbage Collection Magic Trick
(use-package gcmh
  :demand t
  :config
  (gcmh-mode 1))

;; Package `bind-key' provides a macro by the same name (along with
;; `bind-key*', `bind-keys', `bind-keys*', and `unbind-key') which
;; provides a much prettier API for manipulating keymaps than
;; `define-key' and `global-set-key' do. It's also the same API that
;; `:bind' and similar keywords in `use-package' use.
(use-package bind-key
  :demand t)

(provide 'init-bootstrap)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-bootstrap.el ends here
