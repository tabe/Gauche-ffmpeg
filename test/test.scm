;;;
;;; test multimedia.ffmpeg
;;;

(use gauche.test)
(use gauche.sequence)

(test-start "multimedia.ffmpeg")
(use multimedia.ffmpeg)
(test-module 'multimedia.ffmpeg)

(define-macro (test*-version proc)
  `(begin
	 (let ((v (,proc)))
	   (test* ,(symbol->string proc)
			  #t
			  (and (string? v)
				   (is-a? (rxmatch #/^[0-9]+\.[0-9]+\.[0-9]+$/ v) <regmatch>)))
	   (print v))))

; ------------------------------------------------------------------------
(test-section "libavcodec")
(test*-version avcodec-version)

; ------------------------------------------------------------------------
(test-section "libavformat")
(test*-version avformat-version)

; ------------------------------------------------------------------------
(test-section "format context")

(define fc-empty (open-input-avformat "empty.wmv"))
(test* "open-input-avformat" #f fc-empty)

(define fc (open-input-avformat "welcome3.wmv"))
(test* "open-input-avformat" #t (is-a? fc <avformat-context>))
(test* "get-duration" 17.0 (get-duration fc))
(test* "get-file-name" "welcome3.wmv" (get-file-name fc))

(define vcc (open-input-vcodec fc))
(define acc (open-input-acodec fc))
(test* "open-input-vcodec" #t (is-a? vcc <avcodec-context>))
(test* "open-input-acodec" #t (is-a? acc <avcodec-context>))

; ------------------------------------------------------------------------
(test-section "audio codec")

(test* "get-codec-name" "wmav2" (get-codec-name acc))

(close-input-avcodec acc)

(test-section "video codec")
(test* "get-width" 320 (get-width vcc))
(test* "get-height" 240 (get-height vcc))
(test* "get-codec-name" "mpeg4" (get-codec-name vcc))

(close-input-avcodec vcc)

; ------------------------------------------------------------------------
(test-section "audio/video codec")

(define-values (acc1 vcc1) (open-input-avcodec fc))
(test* "open-input-avcodec(audio)" #t (is-a? acc1 <avcodec-context>))
(test* "get-bit-rate(audio)" 16000 (get-bit-rate acc1))
(test* "get-sample-rate(audio)" 16000 (get-sample-rate acc1))
(test* "open-input-avcodec(video)" #t (is-a? vcc1 <avcodec-context>))

(close-input-avcodec acc1)

(receive (num den)
	(get-frame-rate fc vcc1)
  (test* "get-frame-rate(num)" 15 num)
  (test* "get-frame-rate(den)"  1 den))

(close-input-avcodec vcc1)
(close-input-avformat fc)

; ------------------------------------------------------------------------
(test-section "some sample files")

(use srfi-1)

(define-syntax cond-test*
  (syntax-rules ()
	((_ str expected expr)
	 (let ((e expected))
	   (if e
		   (test* str e expr)
		   (test* str 'N/A 'N/A))))))

(define (check-file spec)
  (let ((name (car spec))
		(spec-duration (second spec))
		(spec-audio (third spec))
		(spec-video (fourth spec)))
	(let ((spec-acodec (first spec-audio))
		  (spec-bit-rate (second spec-audio))
		  (spec-sample-rate (third spec-audio))
		  (spec-vcodec (first spec-video))
		  (spec-width (second spec-video))
		  (spec-height (third spec-video))
		  (spec-num (fourth spec-video))
		  (spec-den (fifth spec-video)))
	  (when (file-is-regular? name)
		(call-with-input-avformat
		 name
		 (lambda (fc)
		   (when fc
			 (cond-test* "get-duration" spec-duration (get-duration fc))
			 (call-with-input-avcodec
			  fc
			  (lambda (ac vc)
				(when ac
				  (cond-test* "get-codec-name(audio)" spec-acodec (get-codec-name ac))
				  (cond-test* "get-bit-rate(audio)"    spec-bit-rate (and ac (get-bit-rate ac)))
				  (cond-test* "get-sample-rate(audio)" spec-sample-rate (and ac (get-sample-rate ac))))
				(when vc
				  (cond-test* "get-codec-name(video)" spec-vcodec (get-codec-name vc))
				  (cond-test* "get-width" spec-width (get-width vc))
				  (cond-test* "get-height" spec-height (get-height vc))
				  (receive (num den)
					  (get-frame-rate fc vc)
					(cond-test* "get-frame-rate(num)" spec-num num)
					(cond-test* "get-frame-rate(den)" spec-den den)))
				)))))))))

(for-each
 check-file
 '(("welcome3.wmv" 17.0 ("wmav2" 16000 16000) ("mpeg4" 320 240 15 1))
   ("mode1_ogg.avi" 8.0 (#f #f #f) ("mpeg4" 352 288 25 1))
   ("zelda.flv" 29.0 ("adpcm_swf" 0 22050) ("flv" 160 120 12 1))
   ("11082005.3gp" 12.0 (#f #f #f) ("h263" 176 144 30000 2000))
   ("aacaudio.mov" 826.0 (#f #f #f) (#f #f #f #f #f))
   ))

(test-end)

;; Local variables:
;; mode: scheme
;; end:
