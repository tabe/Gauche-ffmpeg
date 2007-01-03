;;;
;;;  avcodec.scm
;;;
;;;   Copyright (C) 2006,2007 Takeshi Abe. All rights reserved.
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

(define-module multimedia.avcodec
  (export <avcodec-context>
		  avcodec-version
		  close-input-avcodec
		  get-bit-rate
		  get-sample-rate
		  get-width
		  get-height
		  get-codec-name
		  ))
(select-module multimedia.avcodec)

(dynamic-load "mm_avcodec")

(define-method close-input-avcodec ((c <avcodec-context>))
  (avcodec-close-input-avcodec c))
(define-method get-bit-rate ((c <avcodec-context>))
  (avcodec-context-bit-rate c))
(define-method get-sample-rate ((c <avcodec-context>))
  (avcodec-context-sample-rate c))
(define-method get-width ((c <avcodec-context>))
  (avcodec-context-width c))
(define-method get-height ((c <avcodec-context>))
  (avcodec-context-height c))
(define-method get-codec-name ((c <avcodec-context>))
  (avcodec-context-codec-name c))

(provide "multimedia/avcodec")
