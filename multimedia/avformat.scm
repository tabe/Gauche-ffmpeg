;;;
;;;  avformat.scm
;;;
;;;   Copyright (C) 2006 Takeshi Abe. All rights reserved.
;;;
;;;   This library is free software; you can redistribute it and/or
;;;   modify it under the terms of the GNU Lesser General Public
;;;   License as published by the Free Software Foundation; either
;;;   version 2.1 of the License, or (at your option) any later version.
;;;
;;;   This library is distributed in the hope that it will be useful,
;;;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;;   Lesser General Public License for more details.
;;;
;;;   You should have received a copy of the GNU Lesser General Public
;;;   License along with this library; if not, write to the Free Software
;;;   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
;;;
;;;  $Id$

(define-module multimedia.avformat
  (export <avformat-context>
		  avformat-version
		  open-input-avformat
		  close-input-avformat
		  get-duration
		  get-file-name
		  call-with-input-avformat
		  ))
(select-module multimedia.avformat)

(dynamic-load "mm_avformat")

(define-method open-input-avformat ((path <string>))
  (avformat-open-input-avformat path))
(define-method close-input-avformat ((c <avformat-context>))
  (avformat-close-input-avformat c))

(define-method get-duration ((c <avformat-context>))
  (avformat-context-duration c))
(define-method get-file-name ((c <avformat-context>))
  (avformat-context-filename c))

(define (call-with-input-avformat path proc)
  (let ((fc (open-input-avformat path)))
	(dynamic-wind
		(lambda () #f)
		(lambda () (proc fc))
		(lambda () (when fc (close-input-avformat fc))))))

(provide "multimedia/avformat")
