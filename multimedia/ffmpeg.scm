;;;
;;;  ffmpeg.scm
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

(define-module multimedia.ffmpeg
  (extend multimedia.avcodec multimedia.avformat)
  (export open-input-acodec
		  open-input-vcodec
		  open-input-avcodec
		  get-frame-rate
		  call-with-input-avcodec
		  ))
(select-module multimedia.ffmpeg)

(dynamic-load "mm_ffmpeg")

(define-method open-input-acodec ((c <avformat-context>))
  (ffmpeg-open-input-acodec c))
(define-method open-input-vcodec ((c <avformat-context>))
  (ffmpeg-open-input-vcodec c))
(define-method open-input-avcodec ((c <avformat-context>))
  (ffmpeg-open-input-avcodec c))

(define-method get-frame-rate ((fc <avformat-context>) (cc <avcodec-context>))
  (ffmpeg-get-frame-rate fc cc))

(define (call-with-input-avcodec fc proc)
  (receive (ac vc) (open-input-avcodec fc)
    (unwind-protect
     (proc ac vc)
     (begin
       (when ac (close-input-avcodec ac))
       (when vc (close-input-avcodec vc))))))

(provide "multimedia/ffmpeg")
